install.packages("yelpr")
devtools::install_github("OmaymaS/yelpr")
library(yelpr)
library(jsonlite)
key <- "wJygdPmOSu-0UR8aZnwpVx0TFvpcmgEuvL8rbl3J7F7X39Z_azCuFD3IXzoeCxSgVLPsAdcvPgm4M3mOoTbK9T7_ODZFpH9Z6zjtV8GYZ0YQb6zGVxJTPY0mHuv8W3Yx"

#chinese
business_cp <- business_search(api_key = key,
                               location = 'College Park',
                               term = "chinese",
                               limit = 50)
business_cp <- as.data.frame(business_cp)
View(business_cp)


n = NULL
for (i in business_cp_sub$businesses.alias) {
  d <- as.data.frame(business_lookup_id(key, i)$hours$open)
  df <- data.frame(d, data.frame(rep(i, nrow(d))))
  n = rbind(n,df)
}

library(dplyr)
library(tidyr)

rest_open <- n
colnames(rest_open)[5] <- "businesses.alias"
chinese_total <- merge(business_cp, rest_open, by = "businesses.alias")

business_cp_sub <- subset(business_cp, businesses.review_count >= 40)

#japanese
japan_cp <- business_search(api_key = key,
                               location = 'College Park',
                               term = "japanese",
                               limit = 50)
japan_cp <- as.data.frame(japan_cp)
View(japan_cp)

summary(japan_cp$businesses.review_count)

n = NULL
for (i in japan_cp_sub$businesses.alias) {
  d <- as.data.frame(business_lookup_id(key, i)$hours$open)
  df <- data.frame(d, data.frame(rep(i, nrow(d))))
  n = rbind(n,df)
}

japan_open <- n
colnames(japan_open)[5] <- "businesses.alias"
japan_total <- merge(japan_cp, japan_open, by = "businesses.alias")

japan_cp_sub <- subset(japan_cp, businesses.review_count >= 40)

#korean
korean_cp <- business_search(api_key = key,
                            location = 'College Park',
                            term = "korean",
                            limit = 50)
korean_cp <- as.data.frame(korean_cp)

summary(korean_cp$businesses.rating)
summary(japan_cp$businesses.rating)


n = NULL
for (i in korean_cp_sub$businesses.alias) {
  d <- as.data.frame(business_lookup_id(key, i)$hours$open)
  df <- data.frame(d, data.frame(rep(i, nrow(d))))
  n = rbind(n,df)
}


korean_open <- n
colnames(korean_open)[5] <- "businesses.alias"
korean_total <- merge(korean_cp, korean_open, by = "businesses.alias")

korean_cp_sub <- subset(korean_cp, businesses.review_count >= 40)


#save
write.csv(rest_open, file = "rest_open.csv")

b <- business_cp[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]

write.csv(b, file = "business_cp.csv")


#total open
total_open <- rbind(rest_open, japan_open, korean_open)
total_open <- total_open[!duplicated(total_open),]

write_csv(total_open, "total_open.csv")

library(rvest)

#all reviews chinese
y <- NULL
z <- NULL
for (p in business_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  y=c(y,title)
  print(p)
}
for (p in business_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p, "?start=20"))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  z=c(z,title)
  print(p)
}

rep_alias <- data.frame(rep(business_cp_sub$businesses.alias, each = 20))
y <- data.frame(y)
z <- data.frame(z)
a <- cbind(rep_alias, y)
colnames(a) <- c("name", "review")
b <- cbind(rep_alias, z)
colnames(b) <- c("name", "review")
c <- rbind(a,b)
review_ch <- c



#all reviews japan
yy <- NULL
zz <- NULL
for (p in japan_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  yy=c(yy,title)
  print(p)
}
for (p in japan_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p, "?start=20"))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  zz=c(zz,title)
  print(p)
}

rep_alias_jp <- data.frame(rep(japan_cp_sub$businesses.alias, each = 20))
yy <- data.frame(yy)
zz <- data.frame(zz)
aa <- cbind(rep_alias_jp, yy)
colnames(aa) <- c("name", "review")
bb <- cbind(rep_alias_jp, zz)
colnames(bb) <- c("name", "review")
cc <- rbind(aa,bb)
review_jp <- cc


#all reviews korean
yyy <- NULL
zzz <- NULL
for (p in korean_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  yyy=c(yyy,title)
  print(p)
}
for (p in korean_cp_sub$businesses.alias) {
  title=read_html(paste0("https://www.yelp.com/biz/", p, "?start=20"))
  title=html_nodes(title,".review-content p")
  title=html_text(title)
  title=iconv(title,"UTF-8")
  zzz=c(zzz,title)
  print(p)
}

rep_alias_ko <- data.frame(rep(korean_cp_sub$businesses.alias, each = 20))
yyy <- data.frame(yyy)
zzz <- data.frame(zzz)
aaa <- cbind(rep_alias_ko, yyy)
colnames(aaa) <- c("name", "review")
bbb <- cbind(rep_alias_ko, zzz)
colnames(bbb) <- c("name", "review")
ccc <- rbind(aaa,bbb)
review_ko <- ccc

review_total <- rbind(review_ch, review_jp, review_ko)

review_total <- review_total[!duplicated(review_total),]

write_csv(review_total, "total.csv")


#total
chinese_total <- merge(business_cp_sub, rest_open, by = "businesses.alias")
japan_total <- merge(japan_cp_sub, japan_open, by = "businesses.alias")
korean_total <- merge(korean_cp_sub, korean_open, by = "businesses.alias")


chinese_export <- chinese_total[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
japan_export <- japan_total[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
korean_export <- korean_total[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]

write.csv(chinese_export, file = "chinese_export.csv")
write.csv(japan_export, file = "japan_export.csv")
write.csv(korean_export, file = "korean_export.csv")


#without hour
sub_chinese_export <- business_cp_sub[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
sub_japan_export <- japan_cp_sub[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
sub_korean_export <- korean_cp_sub[ , -which(names(business_cp) %in% c("businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]

without_total <- rbind(sub_chinese_export, sub_japan_export, sub_korean_export)

without_total <- without_total[!duplicated(without_total$businesses.alias),]


write.csv(sub_chinese_export, file = "sub_chinese_export.csv")
write.csv(sub_japan_export, file = "sub_japan_export.csv")
write.csv(sub_korean_export, file = "sub_korean_export.csv")
write.csv(without_total, file = "total_without_hour.csv")


#review
write.csv(review_ch, file = "review_ch.csv")

#list and dataframe
list_chinese <- business_cp_sub[ , which(names(business_cp) %in% c("businesses.alias","businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
list_japan <- japan_cp_sub[ , which(names(business_cp) %in% c("businesses.alias","businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]
list_korean <- korean_cp_sub[ , which(names(business_cp) %in% c("businesses.alias","businesses.location","businesses.transactions", "businesses.categories", "businesses.coordinates"))]

library(readxl)
total_expand <- read_xlsx("total_expand.xlsx")
total_expand <- total_expand[!duplicated(total_expand$businesses.alias),]

write.csv(total_expand, file = "total_expand.csv")
