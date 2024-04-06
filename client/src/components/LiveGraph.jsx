import React, { useState, useEffect } from "react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from "recharts";

const LiveGraph = () => {
  const [data, setData] = useState([]);

  // Simulating live data update every second
  useEffect(() => {
    const interval = setInterval(() => {
      // Generate random data point
      const newDataPoint = {
        time: new Date().toLocaleTimeString(), // x-axis value (time)
        value: Math.random() * 100, // y-axis value (random value for example)
      };

      // Update data with the new data point
      setData((prevData) => [...prevData, newDataPoint]);
    }, 1000);

    return () => clearInterval(interval); // Clean up interval on unmount
  }, []);

  return (
    <LineChart width={600} height={400} data={data} margin={{ top: 20, right: 30, left: 20, bottom: 10 }}>
      <CartesianGrid strokeDasharray="3 3" />
      <XAxis dataKey="time" />
      <YAxis />
      <Tooltip />
      <Legend />
      <Line type="monotone" dataKey="value" stroke="#8884d8" activeDot={{ r: 8 }} />
    </LineChart>
  );
};

export default LiveGraph;
