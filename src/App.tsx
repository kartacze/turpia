import "./App.css";
import { CreateRecord } from "./domain/budget/CreateRecord";
import { RecordsList } from "./domain/budget/RecordsList";

export function App() {
  return (
    <>
      <div className="navbar bg-base-100 shadow-sm">
        <div className="flex-1">
          <a className="btn btn-ghost text-xl">🐐 Turpia</a>
        </div>
        <div className="flex-none">
          <input
            type="checkbox"
            value="synthwave"
            className="toggle theme-controller"
          />
        </div>
      </div>
      <div className="m-auto max-w-5xl flex mt-8 px-8 flex-col">
        <div>
          <CreateRecord />
        </div>
        <RecordsList />
      </div>
    </>
  );
}

export default App;
