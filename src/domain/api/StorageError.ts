export type StorageWriteError = { message: string };
const toWriteError = (): StorageWriteError => ({ message: "Parse Error" });

export type StorageReadError = { message: string };

export type ParseError = { message: string };
const toParseError = (): ParseError => ({ message: "Parse Error" });

export const StorageError = {
  toParseError,
  toWriteError,
};
