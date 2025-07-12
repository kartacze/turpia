import { useMutation } from "@tanstack/react-query";

import { Record } from "./Record";

export const useCreateRecordMutation = () => {
  return useMutation({
    mutationFn: (data: Record) =>
      fetch("api/records", { method: "POST", body: JSON.stringify(data) }),
  });
};
