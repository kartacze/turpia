import * as z from "zod";

export const Record = z.object({
  amount: z
    .number({ message: "You need to provide an amount" })
    .min(0.01, { message: "Amount needs to be a positive number" }),
  // account: z.string(),
  description: z.string().nonempty({ message: "Required" }),
  category: z.string().nonempty({ message: "Required" }),
  expense: z.boolean(),
  // tags: z.array(z.string()).optional(),
  date: z.string({}).nonempty({ message: "Required" }),
});

export const DbRecord = Record.extend({
  id: z.string(),
});

export const RecordList = z.array(Record);

export type Record = z.infer<typeof Record>;
export type DbRecord = z.infer<typeof DbRecord>;
