#https://www.reddit.com/r/learnprogramming/comments/7ii6tl/need_help_with_datatable_in_r/
    library(data.table)
    library(magrittr)

    DT <- data.table(time = 1:10,
                 P1 = c("a", "a", "b", "b", "b", "a", "a", "b", "a", "c"),
                 Res = c("d", "w", "w", "w", "w", "w", "d", "d", "w", "w"),
                 P2 = c("b", "c", "c", "a", "a", "c", "c", "a", "b", "b"))


    DT[, wins1 := shift(cumsum(Res == "w"), 1, fill=0L), by=P1]
    DT[, loss2 := shift(cumsum(Res == "w"), 1, fill=0L), by=P2]

    DT[,`:=`(Lx1= ifelse(Res=="w", P1, ""),
             Lx2= ifelse(Res=="w", P2, ""),
             Dx1= ifelse(Res=="d", P1, ""),
             Dx2= ifelse(Res=="d", P2, ""))] %>% 
      .[,loss1 := length(which(unlist(.$Lx2)[1:(.I-1)]==P1)), by=time] %>%
      .[,wins2 := length(which(unlist(.$Lx1)[1:(.I-1)]==P2)), by=time] %>%
      .[,draw1 := shift(cumsum(Res == "d"), 1, fill=0L), by=P1] %>%
      .[,draw1 := draw1 + length(which(unlist(.$Dx2)[1:(.I-1)]==P1)), by=time] %>%
      .[,draw2 := shift(cumsum(Res == "d"), 1, fill=0L), by=P2] %>%
      .[,draw2 := draw2 + length(which(unlist(.$Dx1)[1:(.I-1)]==P2)), by=time] 

    DT[,.(time, wins1, loss1, draw1, wins2, loss2, draw2)]


DT[,.(time, P1, Res, P2, wins1, loss1, draw1, wins2, loss2, draw2)]
#    time P1 Res P2 wins1 loss1 draw1 wins2 loss2 draw2
# 1:    1  a   d  b     0     0     0     0     0     0
# 2:    2  a   w  c     0     0     1     0     0     0
# 3:    3  b   w  c     0     0     1     0     1     0
# 4:    4  b   w  a     1     0     1     1     0     1
# 5:    5  b   w  a     2     0     1     1     1     1
# 6:    6  a   w  c     1     2     1     0     2     0
# 7:    7  a   d  c     2     2     1     0     3     0
# 8:    8  b   d  a     3     0     1     2     2     2
# 9:    9  a   w  b     2     2     3     3     0     2
#10:   10  c   w  b     0     3     1     3     1     2
