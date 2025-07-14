import { useQuery } from "@tanstack/react-query";
import { DbRecord } from "./Record";

const fetchRecords = async (): Promise<DbRecord[]> => {
  const response = await fetch("/turpia/api/records");
  return response.json() as unknown as Promise<DbRecord[]>;
};

export const useRecordsQuery = () =>
  useQuery({
    queryKey: ["records"],
    queryFn: fetchRecords,
  });
