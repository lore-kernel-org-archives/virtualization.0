Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D4C43461
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02B6191D
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 04:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02B6191D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48FD1844DB;
	Tue, 11 May 2021 04:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLYcoguPViX7; Tue, 11 May 2021 04:43:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B957F84493;
	Tue, 11 May 2021 04:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91E0BC000D;
	Tue, 11 May 2021 04:43:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01C5DC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D93AF60B96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1paDX10V0OZl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EC07607F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 04:43:27 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 s5-20020a7bc0c50000b0290147d0c21c51so471564wmh.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 May 2021 21:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bsCvJr4vTwPoE7/DTp7x7jVKKhNxBO/CRiZz1em8k+w=;
 b=JSBkBA/fZRmJSu3Y9xq3akl7ED6Tvpe7AvXz1yQrByhsaur23klSnr6Gyq5VVkOF/P
 ehiDxkgCwHbnHX/mXBNSZtuuk7bsIIRGAiQ4j3jut6l8HNUKQNHAopo2HuU2VL5zei60
 JWVu8C+wV0DiXbMmrKqq77WXG2qN+YjSeDXpu87UOw8Uk9c2CBK5DaS+yiamWcO4kRFR
 eWmoNtLNlfEI/s1QDxveZYkjyxgFod5GgIjU4xSpwEEoUEKLpYx2FaOMj94DXNvUUu4Y
 MuzNETQ0sy/X7KcHezWttVz3VxYGEu9aQaUaC9vgboklMJdAAEP3UHyzzWyc75VQnZ2B
 1WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bsCvJr4vTwPoE7/DTp7x7jVKKhNxBO/CRiZz1em8k+w=;
 b=fkgB9SsCV9hvbX+eG5pYauDZvMgBPP+HX6a58j/0bhrfwExSzkU+BylpujK3Wgr4Cn
 xRNoYcsajsBXvjvFLwv0oF42cF4UhsRuhODnYHHQmX6RhmHCgQXplnghbsJW75RcF0Cg
 ukvBfR73WGeXjNswasb8NF6LABtT+74t9tB5PzX0lgIvvtJwutLjpbv1UkTc1Mvv8iIW
 g2jYNX10pUeRk9oe8Im0tsSjpmhHR5V6I+hhahHpDDnL19UZuO9ClFsAx0UxYcrKsmUN
 vvC8/rDhEWH7F4t4OkhwEhYQglhDWD62e9buQEfen3jIRP0AyxsJlqA5ylXU3c+4fn0z
 SfgQ==
X-Gm-Message-State: AOAM5325JLLQkuF/Oa+NXWVEJpFkkZyc3w4ggQAfz3jUXhscMbiwOSL/
 JqJkJsDAMg9DnV/UL99/h3Kgrw==
X-Google-Smtp-Source: ABdhPJzxeGzw+4yEOHbL5HDKHJ+qupAsDGcMzwF55Eut8wUC/I5FZbSmyp0K0X27fWEs54GfArqysw==
X-Received: by 2002:a1c:545c:: with SMTP id p28mr3073820wmi.118.1620708205432; 
 Mon, 10 May 2021 21:43:25 -0700 (PDT)
Received: from f1.Home (bzq-79-180-42-161.red.bezeqint.net. [79.180.42.161])
 by smtp.gmail.com with ESMTPSA id a9sm22360520wmj.1.2021.05.10.21.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 21:43:25 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 4/4] tun: indicate support for USO feature
Date: Tue, 11 May 2021 07:42:53 +0300
Message-Id: <20210511044253.469034-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511044253.469034-1-yuri.benditovich@daynix.com>
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com
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

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 84f832806313..a35054f9d941 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2812,7 +2812,7 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 			arg &= ~(TUN_F_TSO4|TUN_F_TSO6);
 		}
 
-		arg &= ~TUN_F_UFO;
+		arg &= ~(TUN_F_UFO|TUN_F_USO);
 	}
 
 	/* This gives the user a way to test for new features in future by
-- 
2.26.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
