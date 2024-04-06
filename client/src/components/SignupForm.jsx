import React, { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function SignupForm() {
  const navigate = useNavigate();

  const [formData, setFormData] = useState({
    orgName: "",
    email: "",
    phoneNumber: "",
    permanentAddress: "",
    password: "",
    regNumber: "",
    description: "",
    marketCap: "",
  });

  const [successMessage, setSuccessMessage] = useState("");
  const apiurl = process.env.REACT_APP_API_URL;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await fetch(`${apiurl}/organisation/signup`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      const data = await response.json();

      if (response.ok) {
        setSuccessMessage("Signup successful!"); // Display success message
        setFormData({
          orgName: "",
          email: "",
          phoneNumber: "",
          permanentAddress: "",
          password: "",
          regNumber: "",
          description: "",
          marketCap: "",
          files: null,
        });

        localStorage.setItem("token", data.token);

        navigate("/");
      } else {
        // Handle error responses from the server
        const errorMessage = await response.text();
        console.error("Signup failed:", errorMessage);
        // You can set an error state here and display it to the user if needed
      }
    } catch (error) {
      console.error("Signup failed:", error);
      // You can set an error state here and display it to the user if needed
    }
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-center px-4">
      <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900">
        Sign up for an account
      </h2>
      <div className="max-w-4xl w-full grid grid-cols-2 gap-8">
        <div className="col-span-2 sm:col-span-1">
          <div className="sm:mx-auto sm:w-full sm:max-w-sm"></div>

          <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form className="space-y-6 items-center">
              <div>
                <label
                  htmlFor="orgName"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Organization Name
                </label>
                <div className="mt-2">
                  <input
                    id="orgName"
                    name="orgName"
                    type="text"
                    value={formData.orgName}
                    onChange={handleChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* Email Address */}
              <div>
                <label
                  htmlFor="email"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Email address
                </label>
                <div className="mt-2">
                  <input
                    id="email"
                    name="email"
                    type="email"
                    autoComplete="email"
                    value={formData.email}
                    onChange={handleChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* Phone Number */}
              <div>
                <label
                  htmlFor="phoneNumber"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Phone Number
                </label>
                <div className="mt-2">
                  <input
                    id="phoneNumber"
                    name="phoneNumber"
                    value={formData.phoneNumber}
                    onChange={handleChange}
                    type="tel"
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* Permanent Address */}
              <div>
                <label
                  htmlFor="permanentAddress"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Permanent Address
                </label>
                <div className="mt-2">
                  <textarea
                    id="permanentAddress"
                    name="permanentAddress"
                    rows="3"
                    value={formData.permanentAddress}
                    onChange={handleChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  ></textarea>
                </div>
              </div>
              {/* Password */}
              <div>
                <label
                  htmlFor="password"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Password
                </label>
                <div className="mt-2">
                  <input
                    id="password"
                    name="password"
                    value={formData.password}
                    onChange={handleChange}
                    type="password"
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>
            </form>
          </div>
        </div>

        {/* Right column for the remaining input fields */}
        <div className="col-span-2 sm:col-span-1">
          <div className="mt-10 sm:mx-auto sm:w-full sm:max-w-sm">
            <form className="space-y-6" onSubmit={handleSubmit}>
              <div>
                <label
                  htmlFor="regNumber"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Registration Number
                </label>
                <div className="mt-2">
                  <input
                    id="regNumber"
                    name="regNumber"
                    type="text"
                    value={formData.regNumber}
                    onChange={handleChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* Description */}
              <div>
                <label
                  htmlFor="description"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Description
                </label>
                <div className="mt-2">
                  <textarea
                    id="description"
                    name="description"
                    value={formData.description}
                    onChange={handleChange}
                    rows="3"
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  ></textarea>
                </div>
              </div>

              {/* Market Cap */}
              <div>
                <label
                  htmlFor="marketCap"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Market Cap
                </label>
                <div className="mt-2">
                  <input
                    id="marketCap"
                    name="marketCap"
                    value={formData.marketCap}
                    onChange={handleChange}
                    type="number"
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* File Upload
              <div>
                <label
                  htmlFor="files"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Upload Files
                </label>
                <div className="mt-2">
                  <input
                    id="files"
                    name="files"
                    type="file"
                    multiple
                    onChange={handleFileChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div> */}

              {/* Confirm Password */}
              <div>
                <label
                  htmlFor="confirmPassword"
                  className="block text-sm font-medium leading-6 text-gray-900"
                >
                  Confirm Password
                </label>
                <div className="mt-2">
                  <input
                    id="confirmPassword"
                    name="confirmPassword"
                    type="password"
                    onChange={handleChange}
                    required
                    className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              {/* Submit Button */}
              <div>
                <button
                  type="submit"
                  className="flex w-full justify-center rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                >
                  Sign up
                </button>
              </div>
            </form>

            {/* Login Link */}
            <p className="mt-10 text-center text-sm text-gray-500">
              Already a member?{" "}
              <a
                href="/login"
                className="font-semibold leading-6 text-indigo-600 hover:text-indigo-500"
              >
                Login
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
