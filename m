Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A7C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:12:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813F522B4B
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813F522B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CB3092046A;
	Tue, 12 Jan 2021 20:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eFsPguqxx7el; Tue, 12 Jan 2021 20:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id ACBE52044D;
	Tue, 12 Jan 2021 20:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95401C0893;
	Tue, 12 Jan 2021 20:12:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DC0C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 992F085722
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RrbpyOiR6oQv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:12:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AD4668522B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:11:59 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id q22so5325586eja.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vUG4KrkwS/48VCqb3gPEYEavBv7WJyPV6SrQz/KaLAM=;
 b=xXVp4dUFwGopoDHrk5N2q6tlpNzp6UcAVfATe6wqsrEI6AsT8zMquFk3s5PrenaRNS
 HsXPG8kYC0iqaJhsbWLQQVLvJzZ9fyG5MMwDHgKfhYHzVUADW8tULfPsAXPKdSzmExXs
 xGkgY8UjXhz4pr/tWYY6LIg0OPuFo4/wilerVoD5vOLJ7+xE3zVBI8l4tgeDUNGcSQS2
 w9lpFADgtL5YNaNmRW34ldPIRi8yBgvDVWpenxM8ASJiWwqp+czbRrxXsd0c45UYufcX
 ORCyuOBerYo0JFSjBUJNikFQv/KEcc3YsnoAYO8aGPrCVo2pExXlWpwTZijTWq2Ccxf6
 uguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vUG4KrkwS/48VCqb3gPEYEavBv7WJyPV6SrQz/KaLAM=;
 b=WO26Lk/satx/EJzOaHvYpkDRZZEDL+eXrsDfTu8Q0h2soAevFGYx1cV8uwMGTg7e6z
 pGAGBugYt0Hw6kE3aQvttjKsaHN9/hn/WM35otWh6RWTDVUhTiwWNqNrR5O1TtEoDUcX
 gwAxFEb70SVvCap4o6/dZoDAAmErmJTwP6NIY7qz5+N2U69ygV7ggG+sDMWCyrCydI6J
 4s/QTJ4qL9klNxyPjdFUJsAXmnx2mW/BoK2+tJyvGxm+gj1L1vYVebw5ii8UACjlcUnl
 XTfzT8uFjHkalomwNK98v9sHqUuaaFFsyAjH4G6SnCU/zdP/39271xRd7jjFT8GPHhvg
 GfOQ==
X-Gm-Message-State: AOAM531SCeXxOCoxs7p7L13HfRg6+HadpF5sxZVdMd2eJGOfHjPeXHL2
 hhGkFcyg1ff5kmR1Px6gsA5ntNLBURsvgkG8
X-Google-Smtp-Source: ABdhPJzCa62kAiSj5dwvAhD+eWjgsemDiqG4ohfKFPsazH9lExZh5CateUK1KDaOpknKxeSQxHaBJA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr454259wrw.36.1610480536897;
 Tue, 12 Jan 2021 11:42:16 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:16 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 7/7] tun: report new tun feature IFF_HASH
Date: Tue, 12 Jan 2021 21:41:43 +0200
Message-Id: <20210112194143.1494-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

IFF_HASH feature indicates that the tun supports
TUNSETHASHPOPULATION ioctl and can propagate the hash
data to the virtio-net packet.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c           | 2 +-
 include/uapi/linux/if_tun.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 214feb0b16fb..b46aa8941a9d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -88,7 +88,7 @@ static void tun_default_link_ksettings(struct net_device *dev,
 #define TUN_VNET_LE     0x80000000
 #define TUN_VNET_BE     0x40000000
 
-#define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
+#define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | IFF_HASH |\
 		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
 
 #define GOODCOPY_LEN 128
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 0fd43533da26..116b84ede3a0 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -73,6 +73,7 @@
 #define IFF_ONE_QUEUE	0x2000
 #define IFF_VNET_HDR	0x4000
 #define IFF_TUN_EXCL	0x8000
+#define IFF_HASH	0x0080
 #define IFF_MULTI_QUEUE 0x0100
 #define IFF_ATTACH_QUEUE 0x0200
 #define IFF_DETACH_QUEUE 0x0400
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
