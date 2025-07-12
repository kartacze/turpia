import { http, HttpResponse } from "msw";
import { Record } from "../budget/Record";
import { Storage } from "./Storage";

export const handlers = [
  http.post<never, Record>("/api/records", async ({ request }) => {
    return Storage.ceateRecord(request.json()).match(
      (record: Record) => HttpResponse.json(record),
      () => HttpResponse.error(),
    );
  }),

  http.get<never, Record>("/api/records", async () => {
    return Storage.readRecords().match(
      (records) => HttpResponse.json(records),
      () => HttpResponse.error(),
    );
  }),

  http.get<never>("/api/setup", async () => {

    return HttpResponse.text("ok");
  }),
];
