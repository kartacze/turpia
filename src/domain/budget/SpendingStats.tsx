import type { Record } from "./Record";

type SpendingStatsProps = {
  records: Record[];
};

const getBalance = (records: Record[]) => {
  return records.reduce(
    (balance, rec) => balance + (rec.expense ? -1 : 1) * rec.amount,
    0,
  );
};

const format = (val: number) =>
  new Intl.NumberFormat("pl-PL", {
    style: "currency",
    currency: "EUR",
  }).format(val);

export function SpendingStats({ records }: SpendingStatsProps) {
  const incomes = records.filter((record) => !record.expense);
  const expenses = records.filter((record) => record.expense);

  const balance = getBalance(records);
  const expenses_sum = getBalance(expenses) * -1;
  const incomes_sum = getBalance(incomes);

  return (
    <section className="md:mt-12 mt-4 flex flex-col justify-center ml-auto">
      <div className="stats shadow stats-vertical md:stats-horizontal">
        <div className="stat place-items-center">
          <div className="stat-title">Expenses</div>
          <div className="stat-value text-error">{format(expenses_sum)}</div>
        </div>

        <div className="stat place-items-center">
          <div className="stat-title">Incomes</div>
          <div className="stat-value text-success">{format(incomes_sum)}</div>
        </div>

        <div className="stat place-items-center">
          <div className="stat-title">Balance</div>
          <div className="stat-value">{format(balance)}</div>
        </div>
      </div>
    </section>
  );
}
