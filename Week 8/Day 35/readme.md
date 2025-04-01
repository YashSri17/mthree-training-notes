# React Navbar Button Issue - Debugging Notes

## Issue Overview
- The `onClick` event for the button in the React navbar was not working.

## Identified Problems & Fixes

### 1. **Incomplete Class Name**
- The `className` for the `Find Trip` button was incomplete: `bg-black t`.
- **Fix:** Completed it as `bg-black text-white px-4 py-2 rounded-lg`.

### 2. **Unclosed Button Tag**
- The second button (`Ride History`) was not properly closed, causing JSX errors.
- **Fix:** Ensured all JSX elements were correctly closed.

### 3. **Ensure Function Existence**
- The `findTrip` function must be defined for the `onClick` event to work.
- **Example Fix:**
  ```jsx
  const findTrip = () => {
    console.log("Find trip clicked!");
  };
  ```

### 4. **Modified App Route for Navigation**
- Updated the `App.js` file to include routing for the new `RideHistory` component.
- **Example Fix:**
  ```jsx
  import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
  import Navbar from "./Navbar";
  import RideHistory from "./RideHistory";

  function App() {
    return (
      <Router>
        <Navbar />
        <Routes>
          <Route path="/ride-history" element={<RideHistory />} />
        </Routes>
      </Router>
    );
  }

  export default App;
  ```

### 5. **Created `RideHistory.jsx` Component**
- Added a new component for the ride history page.
- **Example `RideHistory.jsx` File:**
  ```jsx
  import React from "react";

  const RideHistory = () => {
    return (
      <div className="p-4">
        <h1 className="text-2xl font-bold">Ride History</h1>
        <p>Here is your past ride history.</p>
      </div>
    );
  };

  export default RideHistory;
  ```

### 6. **Corrected JSX Code in Navbar**
```jsx
<nav className="bg-white text-black flex justify-between items-center p-4">
  <img
    className="w-16"
    src="https://upload.wikimedia.org/wikipedia/commons/c/cc/Uber_logo_2018.png"
    alt="Uber Logo"
  />
  <div className="flex items-center gap-4">
    <button
      onClick={findTrip}
      className="bg-black text-white px-4 py-2 rounded-lg"
    >
      Find Trip
    </button>
    <a href="/ride-history">
      <button className="bg-gray-700 text-white px-4 py-2 rounded-lg">
        Ride History
      </button>
    </a>
  </div>
</nav>
```

## Summary
- Ensure all JSX elements are properly closed.
- Define `onClick` handler functions before using them.
- Check for syntax issues like incomplete class names.
- Open Developer Console (`F12 > Console`) for error debugging.
- Modified `App.js` to include `RideHistory` as a new route.
- Created a separate `RideHistory.jsx` component for handling ride history page.

## Project Screenshots
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%208/Day%2035/Screenshot%202025-04-01%20092126.png)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%208/Day%2035/Screenshot%202025-04-01%20121125.png)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%208/Day%2035/Screenshot%202025-04-01%20124918.png)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%208/Day%2035/Screenshot%202025-04-01%20150940.png)
![image](https://github.com/YashSri17/mthree-training-notes/blob/main/Week%208/Day%2035/Screenshot%202025-04-01%20164046.png)
