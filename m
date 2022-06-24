Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3E1CCA473
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 07:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84E0A848A9;
	Fri, 24 Jun 2022 07:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84E0A848A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eYrV/Z4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ILfqrsTW7Vyy; Fri, 24 Jun 2022 07:57:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DB7284894;
	Fri, 24 Jun 2022 07:57:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DB7284894
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8DF0C0032;
	Fri, 24 Jun 2022 07:57:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64CD8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 07:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FBD540125
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 07:57:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FBD540125
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eYrV/Z4I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G0q25ZP521Pd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 07:57:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3956B40126
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3956B40126
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656057423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s2LZA/fXI+mD13WTemreZqL0kxh0eBajgvaYdX/0vbQ=;
 b=eYrV/Z4IbwUUbBaI2rTcymeRcH4JuyjTy+VqFjDEkqqNG6l9InErdAI3gg9a8XZkDml4mI
 ICX6izBmviQAcgKPFyiliZznwADIFmQeaV31JsdwsjiXaXoylxuxt2QnKPBBePudfSIiml
 WIUjqHA3rxD+Gosk/bRqxooVSiNy84A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-MJpDbt41MaqxbNvBBVTs_Q-1; Fri, 24 Jun 2022 03:57:00 -0400
X-MC-Unique: MJpDbt41MaqxbNvBBVTs_Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 k16-20020a7bc310000000b0038e6cf00439so1124739wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 00:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s2LZA/fXI+mD13WTemreZqL0kxh0eBajgvaYdX/0vbQ=;
 b=vGumQ8AdxTLZllUJMrB62CXmFomP41ksnRD0LIjQwO3nwt//Wq+AMfRsGNinCu9mEs
 84KAZmHTLLRa2GE5Efd8BbNAHAuqvvevB3AnmiL3w7ol2GhxwCQZ9XuQ2Ebx/zSO2K+Q
 bJ4hS9BF5cWmHlczGdI+zKu9pGEiZItOPJLJqYyD8zJFF0Lxt0kyeFWUpklvgOLfKfmr
 QRIH1Ygn4jTZoBBL19yOPCa4Nto/lR28W5NmWmmLWuDesCT0zziQd8/ws8eSTJhbuyXO
 GRNNCObZkXWoqn3NYsStnpR3tn5R0h2Ms6ngQYXRThY5XfWAyN8ZZ4j8Q/Ru2agFWnRD
 eEDg==
X-Gm-Message-State: AJIora+9nIy+5QaRzmVVMRHakYRLyvx/3y6S0T7RIQiz5DPLt/HTdeK5
 272ZHD9PtPgYNazfA6DmQZy17oyqaBHk/IWe8GxD/e6tDRhwW5DS1QQVylHhxAnJo9s79nGmYsJ
 ynQYAnxrL902GygHP2jiWwHxb35A7/uG0rcfLSJL5sL8BIa71MTvO11/5BG6QHW/tAYR8Sj+Akn
 fIhyTPfv1dbZz3zctzhg==
X-Received: by 2002:a05:600c:4ca7:b0:3a0:3905:d441 with SMTP id
 g39-20020a05600c4ca700b003a03905d441mr2235418wmp.159.1656057419323; 
 Fri, 24 Jun 2022 00:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNfHWb9u9vWiW5DWSFpAv1CdnziWuY0VO871vq8AjALqHLbv+K+Sigjdz+Mpcfn9SgjHzANA==
X-Received: by 2002:a05:600c:4ca7:b0:3a0:3905:d441 with SMTP id
 g39-20020a05600c4ca700b003a03905d441mr2235389wmp.159.1656057419075; 
 Fri, 24 Jun 2022 00:56:59 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 c2-20020a1c3502000000b0039c5328ad92sm5975322wma.41.2022.06.24.00.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 00:56:58 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] vringh: iterate on iotlb_translate to handle large
 translations
Date: Fri, 24 Jun 2022 09:56:56 +0200
Message-Id: <20220624075656.13997-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

iotlb_translate() can return -ENOBUFS if the bio_vec is not big enough
to contain all the ranges for translation.
This can happen for example if the VMM maps a large bounce buffer,
without using hugepages, that requires more than 16 ranges to translate
the addresses.

To handle this case, let's extend iotlb_translate() to also return the
number of bytes successfully translated.
In copy_from_iotlb()/copy_to_iotlb() loops by calling iotlb_translate()
several times until we complete the translation.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 78 ++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index eab55accf381..11f59dd06a74 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1095,7 +1095,8 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
 static int iotlb_translate(const struct vringh *vrh,
-			   u64 addr, u64 len, struct bio_vec iov[],
+			   u64 addr, u64 len, u64 *translated,
+			   struct bio_vec iov[],
 			   int iov_size, u32 perm)
 {
 	struct vhost_iotlb_map *map;
@@ -1136,43 +1137,76 @@ static int iotlb_translate(const struct vringh *vrh,
 
 	spin_unlock(vrh->iotlb_lock);
 
+	if (translated)
+		*translated = min(len, s);
+
 	return ret;
 }
 
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
-	struct iov_iter iter;
-	struct bio_vec iov[16];
-	int ret;
+	u64 total_translated = 0;
 
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
-			      len, iov, 16, VHOST_MAP_RO);
-	if (ret < 0)
-		return ret;
+	while (total_translated < len) {
+		struct bio_vec iov[16];
+		struct iov_iter iter;
+		u64 translated;
+		int ret;
 
-	iov_iter_bvec(&iter, READ, iov, ret, len);
+		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
+				      len - total_translated, &translated,
+				      iov, ARRAY_SIZE(iov), VHOST_MAP_RO);
+		if (ret == -ENOBUFS)
+			ret = ARRAY_SIZE(iov);
+		else if (ret < 0)
+			return ret;
 
-	ret = copy_from_iter(dst, len, &iter);
+		iov_iter_bvec(&iter, READ, iov, ret, translated);
 
-	return ret;
+		ret = copy_from_iter(dst, translated, &iter);
+		if (ret < 0)
+			return ret;
+
+		src += translated;
+		dst += translated;
+		total_translated += translated;
+	}
+
+	return total_translated;
 }
 
 static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				void *src, size_t len)
 {
-	struct iov_iter iter;
-	struct bio_vec iov[16];
-	int ret;
+	u64 total_translated = 0;
 
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
-			      len, iov, 16, VHOST_MAP_WO);
-	if (ret < 0)
-		return ret;
+	while (total_translated < len) {
+		struct bio_vec iov[16];
+		struct iov_iter iter;
+		u64 translated;
+		int ret;
+
+		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
+				      len - total_translated, &translated,
+				      iov, ARRAY_SIZE(iov), VHOST_MAP_WO);
+		if (ret == -ENOBUFS)
+			ret = ARRAY_SIZE(iov);
+		else if (ret < 0)
+			return ret;
 
-	iov_iter_bvec(&iter, WRITE, iov, ret, len);
+		iov_iter_bvec(&iter, WRITE, iov, ret, translated);
+
+		ret = copy_to_iter(src, translated, &iter);
+		if (ret < 0)
+			return ret;
+
+		src += translated;
+		dst += translated;
+		total_translated += translated;
+	}
 
-	return copy_to_iter(src, len, &iter);
+	return total_translated;
 }
 
 static inline int getu16_iotlb(const struct vringh *vrh,
@@ -1183,7 +1217,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 	int ret;
 
 	/* Atomic read is needed for getu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
 			      &iov, 1, VHOST_MAP_RO);
 	if (ret < 0)
 		return ret;
@@ -1204,7 +1238,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	int ret;
 
 	/* Atomic write is needed for putu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
 			      &iov, 1, VHOST_MAP_WO);
 	if (ret < 0)
 		return ret;
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
