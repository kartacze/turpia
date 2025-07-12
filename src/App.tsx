import React, { useState } from "react";
import "./App.css";

export function App() {
  const [count, setCount] = useState(0);

  return (
    <>
      <h1>Turpia</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>Nothing here yet</p>
      </div>
    </>
  );
}

export default App;
