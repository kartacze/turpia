import React from "react";
import { useRecordsQuery } from "./useRecordsQuery";
import { useQueryClient } from "@tanstack/react-query";

export function RecordsList() {
  const queryClient = useQueryClient();
  const recordsQuery = useRecordsQuery();

  if (recordsQuery.isPending) {
    return <span className="loading loading-dots loading-xl mt-16"></span>;
  }
  if (recordsQuery.isError) {
    return (
      <div className="flex flex-col mt-16 ">
        <div role="alert" className="alert alert-error mt-16">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            className="h-6 w-6 shrink-0 stroke-current"
            fill="none"
            viewBox="0 0 24 24"
          >
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeWidth="2"
              d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
            />
          </svg>
          <span>Error! We have problems with fetching your records.</span>
        </div>

        <button
          className="btn btn-primary ml-auto mt-4"
          onClick={() => {
            localStorage.clear();
            localStorage.setItem("records", JSON.stringify([]));
            queryClient.invalidateQueries({ queryKey: ["records"] });
          }}
        >
          Reset database
        </button>
      </div>
    );
  }

  const records = recordsQuery.data;

  return (
    <section className="mt-16 flex flex-col justify-center">
      <div className="overflow-x-auto rounded-box border border-base-content/5 bg-base-100 mt-5">
        <table className="table">
          {/* head */}
          <thead>
            <tr>
              <th></th>
              <th>Amount</th>
              <th>Date</th>
              <th>Description</th>
            </tr>
          </thead>
          <tbody>
            {records.map((record, i) => (
              <tr>
                <th>{i + 1}</th>
                <td>{(record.expense ? -1 : 1) *record.amount}</td>
                <td>{record.date}</td>
                <td>{record.description}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
