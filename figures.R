# figures.R
# Reproduces Figures 2, 3A, 3B, and 4 from the manuscript:
# "Untangling the Overexploitation Trap: Governance, Politics of Concepts, 
# and the Sustainability Claims of Chilean Southern Hake"

library(ggplot2)
library(reshape2)
library(dplyr)

# --------------------------------
# 1. Load processed data
# --------------------------------
Cuotas1 <- read.csv("data/Cuotas1.csv")
Rango_polygon <- read.csv("data/Rango_polygon.csv")
Cuotas3 <- read.csv("data/Cuotas3.csv")
pred_df <- read.csv("data/pred_df.csv")
Cuota.decision.4plot <- read.csv("data/Cuota.decision.4plot.csv")
EExplotacion.actas <- read.csv("data/EExplotacion.actas.csv")

# --------------------------------
# 2. Figure 2: Stock status (SB/SB₀)
# --------------------------------
BDo <- ggplot() +
  geom_line(data = Cuotas3 %>% filter(año > 2009),
            aes(x = año, y = value, color = variable)) +
  geom_point(data = Cuotas3 %>% filter(año > 2009),
             aes(x = año, y = value, shape = variable), size = 2, show.legend = FALSE) +
  labs(title = "",
       x = NULL,
       y = expression(SB/SB[o])) +
  theme_bw() +
  scale_y_continuous(limits = c(0, 0.5), breaks = seq(0, 0.5, by = 0.1)) +
  scale_x_continuous(limits = c(2010, 2025), breaks = seq(2010, 2025, by = 2)) +
  geom_vline(xintercept = 2013, linetype = "dashed", color = "black") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        axis.title.y = element_text(angle = 0, vjust = 0.5, hjust = 0.5)) +
  scale_color_manual(values = c("BDo" = "red",
                                "RMS" = "black"),
                     labels = c("BDo" = expression(SB[t] / SB[o]),
                                "RMS" = expression(SB[MSY] / SB[o])),
                     name = "") +
  scale_shape_manual(values = c("BDo" = 19, "RMS" = 1)) +
  geom_ribbon(data = pred_df,
              aes(x = año, ymin = lwr, ymax = upr),
              fill = "lightblue", alpha = 0.3) +
  geom_line(data = pred_df,
            aes(x = año, y = fit), color = "blue", alpha = 0.3)

ggsave("output/Figure2.png", BDo, width = 8, height = 5, dpi = 300)

# --------------------------------
# 3. Figure 3A: Quotas (recommended, approved, landed)
# --------------------------------
Fig.Cuotas1 <- ggplot(Cuotas1 %>% filter(año > 2009),
                      aes(x = año, y = value, color = variable)) +
  geom_line(show.legend = FALSE, linetype = "blank") +
  geom_point(aes(shape = variable), size = 4, show.legend = TRUE) +
  geom_polygon(data = Rango_polygon,
               aes(x = año, y = value),
               fill = "grey", alpha = 0.2, inherit.aes = FALSE) +
  labs(title = "A)",
       x = "Time (years)",
       y = "Annual quota (tons)") +
  theme_bw() +
  scale_y_continuous(limits = c(0, 28000), breaks = seq(0, 30000, by = 5000)) +
  scale_x_continuous(limits = c(2010, 2026), breaks = seq(2010, 2026, by = 2)) +
  geom_vline(xintercept = 2014, linetype = "dashed", color = "gray") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom") +
  scale_color_manual(values = c("Cuota.recomendada" = "blue",
                                "Cuota.decretada" = "red",
                                "Desembarques" = "black"),
                     labels = c("Cuota.recomendada" = "Recommended",
                                "Cuota.decretada" = "Approved",
                                "Desembarques" = "Landed"),
                     name = "Quota category") +
  scale_shape_manual(values = c("Cuota.recomendada" = 19,
                                "Cuota.decretada" = 1,
                                "Desembarques" = 4),
                     labels = c("Cuota.recomendada" = "Recommended",
                                "Cuota.decretada" = "Approved",
                                "Desembarques" = "Landed"),
                     name = "Quota category")

ggsave("output/Figure3A.png", Fig.Cuotas1, width = 8, height = 5, dpi = 300)

# --------------------------------
# 4. Figure 3B: Majority types in quota recommendations
# --------------------------------
Fig.3B <- ggplot(Cuota.decision.4plot,
                 aes(x = as.factor(ID), y = value, color = Tipo.decision)) +
  geom_line(show.legend = FALSE, linetype = "blank") +
  geom_point(aes(shape = variable), size = 4, show.legend = TRUE) +
  theme_bw() +
  scale_y_continuous(limits = c(0, 23000), breaks = seq(0, 22000, by = 5000),
                     name = "Annual quota (tons)") +
  scale_x_discrete(
    labels = c("2014","2015.rev1","2015.rev2","2016.rev1","2016.rev2",
               "2017","2018","2019.rev1","2019.rev2","2019.rev3",
               "2020","2021-2023","2024","2025","2026"),
    name = "Time of quota recommendation (year)"
  ) +
  labs(title = "B)") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom",
        legend.box = "horizontal",
        legend.spacing.y = unit(0.05, "cm"),
        legend.key.size = unit(0.8, "lines"),
        axis.text.x = element_text(angle = 35, hjust = 1)) +
  scale_color_manual(values = c("Científica" = "blue",
                                "Institucional" = "red",
                                "Unanime" = "black"),
                     name = "Majority",
                     labels = c("Científica" = "Scientific",
                                "Unanime" = "Consensus",
                                "Institucional" = "Institutional")) +
  scale_shape_manual(values = c("Rango.cuota.min" = 24,
                                "Rango.cuota.max" = 25,
                                "Cuota.recomendacion" = 8),
                     labels = c("Rango.cuota.min" = "Minimum",
                                "Rango.cuota.max" = "Maximum",
                                "Cuota.recomendacion" = "Recommended"),
                     name = "Value") +
  guides(color = guide_legend(nrow = 3),
         shape = guide_legend(nrow = 3))

ggsave("output/Figure3B.png", Fig.3B, width = 8, height = 5, dpi = 300)

# --------------------------------
# 5. Figure 4: Minutes with technical opinions on DCRs
# --------------------------------
EExplotacion.actas.plot <- ggplot(EExplotacion.actas %>% filter(Año > 2014),
                                  aes(x = as.factor(Año), y = Count,
                                      fill = as.factor(Estrategia.explotacion))) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "",
       x = "Time (year)",
       y = "Meeting minutes (number)",
       fill = "") +
  theme_bw() +
  scale_fill_manual(values = c("0" = "white", "1" = "red"),
                    labels = c("0" = "No", "1" = "Yes")) +
  scale_y_continuous(breaks = seq(0, 8, by = 2)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")

ggsave("output/Figure4.png", EExplotacion.actas.plot, width = 8, height = 5, dpi = 300)

# --------------------------------
# End of script
# --------------------------------