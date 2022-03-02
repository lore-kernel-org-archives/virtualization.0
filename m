Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 03:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1071A827FD;
	Wed,  2 Mar 2022 03:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N0uVhk1HnfA3; Wed,  2 Mar 2022 03:42:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A281E82849;
	Wed,  2 Mar 2022 03:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71960C0012;
	Wed,  2 Mar 2022 03:42:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB03C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CE6760B9B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EwoLdxiL-L9N
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2B3B60AAC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 03:42:38 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id o23so503554pgk.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Mar 2022 19:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RJ7SOmE24IN5voTxxb2GBU71dQmksuFM00064oAmHe4=;
 b=U7ZqznmS1op+/KaI2hpBxG57ustImo02BzrQj6bgBtLI8dvn9ffPKtDqawnldGXy9E
 Kl3PxV0jFgg/djxjJEqT/Ur7W3AUNDaPJUvE2JVUFiw4/6KAj86VT4KXCxXLITt8l2jx
 2FsYXq1az2IeMkiiVAasVL/N72wMWKLtKpFIEQCgT0EvPFw5GAHBBlzGolPcEP6AMI4Z
 WvG8vGvL+iNA1Iw9QwJLpIvYpjrE7IqTwoDV7iIm+A7/3nvJ4GRAt+bK+CSLP7FxYEjL
 9UGsJBeIR/v1W3JogivT3jMSg7/JiN7kFOoFh8Bg9W76tRspJpWOa0Of7yTzWBhLJCP+
 zfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RJ7SOmE24IN5voTxxb2GBU71dQmksuFM00064oAmHe4=;
 b=g/1wAvaHJHM4POSs7DEEABKze6N/Prj9ndFEHz+NHxAxcj+lvb8CeT3Ye0rU2OUBZK
 ls4xzRcwskzRWbIFvjhE6quJq1dUARRBNlzKBTiGjemET8MKVHNloGFqLmQhpsFUIxb3
 wg4VpAKTYiuaHUYCML1AqpPPlhktsXd8wOqvDmdbzrN5JG+gL9JDPoENqN3fVJ9mCucD
 yofgpF7fW+7R3MquafoX7s+5vS7ZH2Ug9secMFt1TREN9u50nmLyub+RlcA/SYqXC1wQ
 XIJR9HdGn/+Jv8NG2hm6LgJmu3XH2OUKHccaLOIr0XjM1Pj4FhJvTrmD5jYPz2ZyEenf
 BEqA==
X-Gm-Message-State: AOAM5322zNLvC6W5bMhtT6HM0dS7og89EWWi4d8W68d0ZJPQ1i4Yzd4W
 XfHuMPsA58UlefQuQ3ZZbbJvzA==
X-Google-Smtp-Source: ABdhPJxEiW+ipwY11l3oml3I3IyQ/Fiktw3i7sAbvQ0T7S0UNpox+jSv/i+WgAhLOq6UadZzmRl5ZA==
X-Received: by 2002:a63:2786:0:b0:365:8a2d:327b with SMTP id
 n128-20020a632786000000b003658a2d327bmr24312602pgn.16.1646192558251; 
 Tue, 01 Mar 2022 19:42:38 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
 by smtp.gmail.com with ESMTPSA id
 gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Mar 2022 19:42:37 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: arei.gonglei@huawei.com,
	mst@redhat.com
Subject: [PATCH v3 4/4] virtio-crypto: rename skcipher algs
Date: Wed,  2 Mar 2022 11:39:17 +0800
Message-Id: <20220302033917.1295334-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: helei.sig11@bytedance.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
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

Suggested by Gonglei, rename virtio_crypto_algs.c to
virtio_crypto_skcipher_algs.c. Also minor changes for function name.
Thus the function of source files get clear: skcipher services in
virtio_crypto_skcipher_algs.c and akcipher services in
virtio_crypto_akcipher_algs.c.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/Makefile                            | 2 +-
 drivers/crypto/virtio/virtio_crypto_common.h              | 4 ++--
 drivers/crypto/virtio/virtio_crypto_mgr.c                 | 8 ++++----
 ...virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/crypto/virtio/{virtio_crypto_algs.c => virtio_crypto_skcipher_algs.c} (99%)

diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
index f2b839473d61..bfa6cbae342e 100644
--- a/drivers/crypto/virtio/Makefile
+++ b/drivers/crypto/virtio/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
 virtio_crypto-objs := \
-	virtio_crypto_algs.o \
+	virtio_crypto_skcipher_algs.o \
 	virtio_crypto_akcipher_algs.o \
 	virtio_crypto_mgr.o \
 	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 214f9a6fcf84..e693d4ee83a6 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -130,8 +130,8 @@ static inline int virtio_crypto_get_current_node(void)
 	return node;
 }
 
-int virtio_crypto_algs_register(struct virtio_crypto *vcrypto);
-void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto);
+void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
 
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index 1cb92418b321..70e778aac0f2 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -237,14 +237,14 @@ struct virtio_crypto *virtcrypto_get_dev_node(int node, uint32_t service,
  */
 int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 {
-	if (virtio_crypto_algs_register(vcrypto)) {
-		pr_err("virtio_crypto: Failed to register crypto algs\n");
+	if (virtio_crypto_skcipher_algs_register(vcrypto)) {
+		pr_err("virtio_crypto: Failed to register crypto skcipher algs\n");
 		return -EFAULT;
 	}
 
 	if (virtio_crypto_akcipher_algs_register(vcrypto)) {
 		pr_err("virtio_crypto: Failed to register crypto akcipher algs\n");
-		virtio_crypto_algs_unregister(vcrypto);
+		virtio_crypto_skcipher_algs_unregister(vcrypto);
 		return -EFAULT;
 	}
 
@@ -263,7 +263,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
  */
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
 {
-	virtio_crypto_algs_unregister(vcrypto);
+	virtio_crypto_skcipher_algs_unregister(vcrypto);
 	virtio_crypto_akcipher_algs_unregister(vcrypto);
 }
 
diff --git a/drivers/crypto/virtio/virtio_crypto_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
similarity index 99%
rename from drivers/crypto/virtio/virtio_crypto_algs.c
rename to drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 583c0b535d13..a618c46a52b8 100644
--- a/drivers/crypto/virtio/virtio_crypto_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -613,7 +613,7 @@ static struct virtio_crypto_algo virtio_crypto_algs[] = { {
 	},
 } };
 
-int virtio_crypto_algs_register(struct virtio_crypto *vcrypto)
+int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto)
 {
 	int ret = 0;
 	int i = 0;
@@ -644,7 +644,7 @@ int virtio_crypto_algs_register(struct virtio_crypto *vcrypto)
 	return ret;
 }
 
-void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto)
+void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto)
 {
 	int i = 0;
 
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
