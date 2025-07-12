import { useQuery } from "@tanstack/react-query";
import { Record } from "./Record";

const fetchRecords = async (): Promise<Record[]> => {
  const response = await fetch("/api/records");
  return response.json() as unknown as Promise<Record[]>;
};

export const useRecordsQuery = () =>
  useQuery({
    queryKey: ["records"],
    queryFn: fetchRecords,
  });
