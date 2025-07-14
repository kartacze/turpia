import { useRef } from "react";
import { useForm } from "react-hook-form";
import { Record } from "./Record";
import { zodResolver } from "@hookform/resolvers/zod";
import { useCreateRecordMutation } from "./useCreateRecordMutation";
import classNames from "classnames";
import { useQueryClient } from "@tanstack/react-query";

export function CreateRecord() {
  const modalRef = useRef<HTMLDialogElement>(null);
  const queryClient = useQueryClient();

  const mutate = useCreateRecordMutation();

  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
    reset,
  } = useForm<Record>({
    resolver: zodResolver(Record),
    defaultValues: {
      amount: 15,
      date: new Date().toJSON().slice(0, 10),
      category: "grocery",
      description: "",
    },
  });

  const type = watch("expense");

  const onSubmit = async (data: Record) => {
    await mutate.mutateAsync(data);
    queryClient.invalidateQueries({ queryKey: ["records"] });
    modalRef.current?.close();
    reset();
  };

  return (
    <>
      <button className="btn" onClick={() => modalRef.current?.showModal()}>
        Add record
      </button>
      <dialog ref={modalRef} className="modal">
        <div className="modal-box">
          <form method="dialog">
            <button className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">
              ✕
            </button>
          </form>
          <h3 className="font-bold text-lg">Add record</h3>
          <form
            className="py-4 flex flex-col"
            onSubmit={handleSubmit(onSubmit)}
          >
            <fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-full border p-4">
              <legend className="fieldset-legend">Details</legend>

              <label className="label">
                <input
                  type="checkbox"
                  defaultChecked
                  className="toggle border-indigo-300 bg-indigo-200 checked:border-orange-500 checked:bg-orange-400 checked:text-orange-800"
                  {...register("expense")}
                />
                <p className="ml-8">{type ? "Expense" : "Income"}</p>
              </label>

              <label className="label">Amount</label>
              <input
                type="number"
                className={classNames("input w-full", {
                  "input-error": errors.amount,
                })}
                {...register("amount", { valueAsNumber: true })}
              />
              {errors.amount && (
                <p className="label text-error">{errors.amount.message}</p>
              )}

              <label className="label">Date</label>
              <input
                type="date"
                className={classNames("input w-full", {
                  "input-error": errors.date,
                })}
                {...register("date")}
              />
              {errors.date && (
                <p className="label text-error">{errors.date.message}</p>
              )}

              <label className="label">Category</label>
              <input
                type="text"
                className={classNames("input w-full", {
                  "input-error": errors.category,
                })}
                {...register("category")}
              />
              {errors.category && (
                <p className="label text-error">{errors.category.message}</p>
              )}

              <label className="label">Description</label>
              <input
                type="text"
                className={classNames("input w-full", {
                  "input-error": errors.description,
                })}
                {...register("description")}
              />
              {errors.description && (
                <p className="label text-error">{errors.description.message}</p>
              )}
            </fieldset>
            <button
              type="submit"
              className="btn btn-outline btn-primary ml-auto mt-4"
            >
              Add
            </button>
          </form>
        </div>
      </dialog>
    </>
  );
}
