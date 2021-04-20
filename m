Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EEC433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 20:01:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25870613C8
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 20:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25870613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7762C402F1;
	Tue, 20 Apr 2021 20:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3fmYBFtJT93; Tue, 20 Apr 2021 20:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1165A401DD;
	Tue, 20 Apr 2021 20:01:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D750EC000E;
	Tue, 20 Apr 2021 20:01:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D376BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 20:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABACD83D09
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 20:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SqV8GP0ty1P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 20:01:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DAA4E83C80
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 20:01:48 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id w10so27457492pgh.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5Du+IgrLZVk7ZDdZOmMvPOwEkpYwzoUizXPLLUwb/Xs=;
 b=sFilqoIvdyvdUn2hWPJbGe/ooVv4/L2Dap7lINRZHOYNqZcW5XfWpNsE5bCbHWP5e7
 WPH4qSp8X2Jv3ZYO55OcPeufO4FGq+qqnFChoXx2+Mk1P5y/kS2HsVAeD9mR0Y8Fq3nC
 kIxV+sBhyAK3eW/6J27xvzd+yEOasxlLZE0UbJTKl0PgjlfQya6Cj6+gRhtczMWkx1LT
 XgvI2SGlY78L2kxfBw3giaej/lLt01GXEsLmWrSwpKuc+l68vp6bsUWfYtPqnPUz+A/o
 0cK3Q3o1jOCbYcSRjhiHBXFiYfyIbFWgS/SzLnt/rocIbszzXRSiqRZGXIS8YGIDTSFb
 UB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5Du+IgrLZVk7ZDdZOmMvPOwEkpYwzoUizXPLLUwb/Xs=;
 b=cpBq3HFvA3jmEaXxcVD7PjZnMUrPfKf1lQB4/80GvEg/jOQC9GV5FwLJpathrcTB1L
 t6nNqtpxQa6eg1bgx+DjIkQNiqEgZw7d2du96nx1VjFu/tbtNf89UM1PgHkYs/SwrXIh
 QPyXLFgTBtNQxf2lm1zv/ijx7t3he+3QF2nu2FyjWAaK/egpYzVVoPz/clWMJGllgHtP
 cSPHyQE8+hkqE0YmTr+V9A/2Jy8PJhMsE4y9UYjHl4GCm6qYX4OUwVfYYbUxQIWibNFv
 2sVEtIdX034l96QkVjEntPAfbdgV8iOmpHtaor1nQ98uz4bYc4Uu8KtMsPmq0kebZ7hh
 74Cg==
X-Gm-Message-State: AOAM531dqCSriDaQBuAtQoYwCGsUd6Ob6mscqvTWtqt6yVyWGNZ+nDiM
 SNIn8Qr5YtXHgN50TYs4KzM=
X-Google-Smtp-Source: ABdhPJwAprjfL6fB0YmGSq6icSibdyl0XAn+8HLS1XyldP7O8e6qmhRuYHSc0TD53nD3Mv/n4S/TRw==
X-Received: by 2002:a17:90a:6583:: with SMTP id
 k3mr4578048pjj.227.1618948908347; 
 Tue, 20 Apr 2021 13:01:48 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com
 ([2620:15c:2c4:201:71c5:2f2b:f562:605b])
 by smtp.gmail.com with ESMTPSA id e14sm16367605pga.14.2021.04.20.13.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 13:01:47 -0700 (PDT)
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] virtio-net: restrict build_skb() use to some arches
Date: Tue, 20 Apr 2021 13:01:44 -0700
Message-Id: <20210420200144.4189597-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Guenter Roeck <linux@roeck-us.net>
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

From: Eric Dumazet <edumazet@google.com>

build_skb() is supposed to be followed by
skb_reserve(skb, NET_IP_ALIGN), so that IP headers are word-aligned.
(Best practice is to reserve NET_IP_ALIGN+NET_SKB_PAD, but the NET_SKB_PAD
part is only a performance optimization if tunnel encaps are added.)

Unfortunately virtio_net has not provisioned this reserve.
We can only use build_skb() for arches where NET_IP_ALIGN == 0

We might refine this later, with enough testing.

Fixes: fb32856b16ad ("virtio-net: page_to_skb() use build_skb when there's sufficient tailroom")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2e28c04aa6351d2b4016f7d277ce104c4970069d..74d2d49264f3f3b7039be70331d4a44c53b8cc28 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -416,7 +416,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 	shinfo_size = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	if (len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
+	if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >= shinfo_size) {
 		skb = build_skb(p, truesize);
 		if (unlikely(!skb))
 			return NULL;
-- 
2.31.1.368.gbe11c130af-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
