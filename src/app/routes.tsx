import { createBrowserRouter, Outlet } from "react-router";
import { Splash } from "./screens/Splash";
import { Onboarding } from "./screens/Onboarding";
import { Welcome } from "./screens/Welcome";
import { ChooseProfile } from "./screens/ChooseProfile";
import { RegisterClient } from "./screens/RegisterClient";
import { Login } from "./screens/Login";
import { ClientHome } from "./screens/ClientHome";
import { SearchServices } from "./screens/SearchServices";
import { SearchResults } from "./screens/SearchResults";
import { ProfessionalProfile } from "./screens/ProfessionalProfile";
import { RequestService } from "./screens/RequestService";
import { RequestConfirmation } from "./screens/RequestConfirmation";
import { Chat } from "./screens/Chat";
import { ClientRequests } from "./screens/ClientRequests";
import { ClientProfile } from "./screens/ClientProfile";
import { ProfHome } from "./screens/ProfHome";
import { RegisterProfessional } from "./screens/RegisterProfessional";
import { RecoverPassword } from "./screens/RecoverPassword";

// Stubs
import {
  EvaluateProfessional,
  ProfRequests,
  ProfRequestDetail,
  ProfServices,
  ProfReviews,
  ProfProfilePublic,
  Notifications,
  Settings,
  ErrorScreen
} from "./screens/Stubs";

import { Layout } from "./components/Layout";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Layout,
    children: [
      { index: true, Component: Splash },
      { path: "onboarding", Component: Onboarding },
      { path: "welcome", Component: Welcome },
      { path: "choose-profile", Component: ChooseProfile },
      { path: "login", Component: Login },
      { path: "register/client", Component: RegisterClient },
      { path: "register/professional", Component: RegisterProfessional },
      { path: "recover-password", Component: RecoverPassword },
      { path: "client", children: [
          { path: "home", Component: ClientHome },
          { path: "search", Component: SearchServices },
          { path: "search-results", Component: SearchResults },
          { path: "professional/:id", Component: ProfessionalProfile },
          { path: "request/:id", Component: RequestService },
          { path: "confirmation", Component: RequestConfirmation },
          { path: "chat/:id", Component: Chat },
          { path: "requests", Component: ClientRequests },
          { path: "evaluate/:id", Component: EvaluateProfessional },
          { path: "profile", Component: ClientProfile }
      ]},
      { path: "professional", children: [
          { path: "home", Component: ProfHome },
          { path: "requests", Component: ProfRequests },
          { path: "request/:id", Component: ProfRequestDetail },
          { path: "chat/:id", Component: Chat },
          { path: "services", Component: ProfServices },
          { path: "reviews", Component: ProfReviews },
          { path: "profile", Component: ProfProfilePublic }
      ]},
      { path: "notifications", Component: Notifications },
      { path: "settings", Component: Settings },
      { path: "*", Component: ErrorScreen }
    ],
  },
]);
