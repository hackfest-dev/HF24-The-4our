import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Layout from "./components/shared/Layout";
import LoginForm from "./components/LoginForm";
import SignupForm from "./components/SignupForm";
import AdminLoginForm from "./components/AdminLoginForm";
import Dashboard from "./components/Dashboard";
import Farms from "./components/Farms";
import CreateFarms from "./components/CreateFarms";
import Settings from "./components/Settings";
import Help from "./components/Help";
import FullPageCard from "./components/FullPageCard";
import { FARM_DATA } from "./consts/farmdata";
import ApproveFarms from "./components/ApproveFarms";
import AdminLayout from "./components/shared/AdminLayout";
import AdminDashboard from "./components/AdminDashboard";
import AdminFarms from "./components/AdminFarms";
import Profile from "./components/Profile";
import AdminSettings from "./components/AdminSettings";
import KYC from "./components/KYC";
import AdminFullPageCard from "./components/AdminFullPageCard";
import Home from "./components/Home"

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Home />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="farms" element={<Farms />} />
          <Route path="farms/:id" element={<FullPageCard />} />
          <Route path="createfarms" element={<CreateFarms />} />
          <Route path="settings" element={<Settings />} />
          <Route path="help" element={<Help />} />
          <Route path="profile" element={<Profile />} />
        </Route>
        <Route path="login" element={<LoginForm />} />
        <Route path="signup" element={<SignupForm />} />
        <Route path="adminlogin" element={<AdminLoginForm />} />

        <Route path="admin" element={<AdminLayout />}>
          <Route index element={<AdminDashboard />} />
          <Route path="adminfarms" element={<AdminFarms />} />
          <Route path="adminfarms/:id" element={<AdminFullPageCard />} />
          <Route path="approvefarms" element={<ApproveFarms />} />
          <Route path="adminsettings" element={<AdminSettings />} />
          <Route path="help" element={<Help />} />
          <Route path="kyc" element={<KYC />} />

        </Route>
      </Routes>
    </Router>
  );
}
