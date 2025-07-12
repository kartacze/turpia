import { err, fromPromise, ok, Result, ResultAsync } from "neverthrow";
import { Record, RecordList } from "../budget/Record";
import {
  StorageError,
  type StorageReadError,
  type StorageWriteError,
} from "./StorageError";
import { v4 } from "uuid";

const getItem = (key: string): Result<string, StorageReadError> => {
  const item = localStorage.getItem(key);

  if (item) {
    return ok(item);
  }

  return err({ message: "read error" });
};

const safeStorageWrite = ResultAsync.fromThrowable(
  async (key, value) => localStorage.setItem(key, value),
  StorageError.toWriteError,
);

const safeJsonParse = Result.fromThrowable(
  (str) => JSON.parse(str),
  StorageError.toParseError,
);

const readRecords = (): Result<Record[], StorageReadError> => {
  return getItem("records")
    .andThen(safeJsonParse)
    .andThen((records) => {
      const result = RecordList.safeParse(records);
      if (!result.success) {
        return err({ message: "read error" });
      }
      return ok(result.data);
    });
};

const ceateRecord = (
  data: Promise<Record>,
): ResultAsync<Record, StorageReadError | StorageWriteError> => {
  return fromPromise(data, StorageError.toWriteError)
    .andThen((record) => ok({ ...record, id: v4() }))
    .andThen((record) => {
      readRecords().andTee((records) => {
        safeStorageWrite("records", JSON.stringify([...records, record]));
      });

      return ok(record);
    });
};

export const Storage = {
  readRecords,
  ceateRecord,
};
