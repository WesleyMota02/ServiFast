import { Outlet, useNavigate, useLocation } from "react-router";

export function Layout() {
  const navigate = useNavigate();
  const location = useLocation();

  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-100">
      <div className="w-full max-w-md h-[100dvh] bg-white overflow-hidden shadow-2xl relative flex flex-col sm:h-[850px] sm:rounded-[40px] sm:border-[8px] sm:border-gray-900">
        <div className="flex-1 overflow-y-auto no-scrollbar pb-16">
          <Outlet />
        </div>
      </div>
    </div>
  );
}
