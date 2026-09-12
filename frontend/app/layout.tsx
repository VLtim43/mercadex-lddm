import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Mercadex",
  description: "Painel administrativo do Mercadex",
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="pt-BR">
      <body>{children}</body>
    </html>
  );
}
