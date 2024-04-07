import React from "react";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

export default function FarmAnalytics(farm) {
  return (
    <div className=" flex flex-col mt-20 ml-60">
      <div className="text-3xl mx-10 text-gray-300">{farm.farm.farmName}</div>
      <div className="text-xl mx-10 text-gray-500">
        {farm.farm.energyCategory}
      </div>
      <div className="text-xl mx-10 text-gray-500">{farm.farm.location}</div>
      <div className="Graph">
        <ResponsiveContainer width="100%" height={400}>
          <LineChart
            data={farm.farm.returns?.xdata.map((value, index) => ({
              index: index + 1,
              ydata: value,
            }))}
            margin={{ top: 20, right: 30, left: 20, bottom: 20 }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="index" />
            <YAxis domain={[420, 500]} /> {/* Set the Y-axis domain */}
            <Tooltip />
            <Line type="monotone" dataKey="ydata" stroke="#8884d8" />
          </LineChart>
        </ResponsiveContainer>
      </div>

      <div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pl-80 pt-0 w-5/6">
          <div>
            <div className="mt-6 border-t border-gray-100">
              <dl className="divide-y divide-gray-100">
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Average Energy Output
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.avgEnergyOutput}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Average Returns
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.avgReturns}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Highest Output
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.highestOutput}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Highest Last Year
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.highestLastYear}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300"></dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400"></dd>
                </div>
              </dl>
            </div>
          </div>
          <div>
            <div className="mt-6 border-t border-gray-100">
              <dl className="divide-y divide-gray-100">
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Lowest Last Year
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.lowestLastYear}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Farm Degrade Percent
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.farmDegradePercent}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Farm Maintainance Percent
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.farmMaintenancePercent}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300">
                    Current Output
                  </dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400">
                    {farm.farm.returns?.analytics?.currentOutput}
                  </dd>
                </div>
                <div className="px-4 py-3">
                  <dt className="text-sm font-medium leading-6 text-gray-300"></dt>
                  <dd className="mt-1 text-sm leading-6 text-gray-400"></dd>
                </div>
              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
