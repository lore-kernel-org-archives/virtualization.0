Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49DFC4708E
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 792E8610C6;
	Wed,  7 Dec 2022 11:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 792E8610C6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=J30v1DLL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vbom9gHRXm8Q; Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E3B2610C3;
	Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E3B2610C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF046C0033;
	Wed,  7 Dec 2022 11:51:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31313C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2ACE610B1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2ACE610B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYlTMQUc1QD2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B84561096
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B84561096
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:31 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id a16so24503319edb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6KVLYAPLygGoe4sQi/p1SsV3HWl1bxrtOXgL4oTXqs=;
 b=J30v1DLLJRwACySk/YtVqRU3GkFmVzKkIrrQw06qLOBQuaoFmpU2vx3paOASsJIQra
 O8Pk7NYj1MNmzQgSw0wnoem3+mYToznn6NbAlshUNv9CleRAr8xSGdbILoBj0WedlJc3
 wPZewCgsR7X6/cz5xGOr6agtr5Y34w3W0xaYFgGRN6LD/oUR46jm7RwSz9nAMxtE3QQz
 Viz+suMJwJqQ0sKOwVVFN+W5JSnwc6/eLeLRvqFtCp/cRgJ6HWuV3PIMASbXyBi/d+5O
 60OhqraU9TU6PyEsc1p4ZrQcn4okEJbHI5Eidlhp8cJb+981mRM/4l+Vw7f/YKwRf0vE
 fJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6KVLYAPLygGoe4sQi/p1SsV3HWl1bxrtOXgL4oTXqs=;
 b=W9TTCCkAaB3nMKw4GmbDtf+CFwikqwwSOD60em5saBvH9bNBc03T6Nq+q4fLf0cA97
 tyihFoOXg6qDvng3Fwr7CBNP0m7QCyI/Ik2hhqj+BW1CQKxkVhktx3EZ7Wj+ysy5WVel
 +1q8vYHfSUGkWmwhOGW/Z+gqnCmlgnIorT44BR5/LvoJxU7lZftv6Z4jzgM1AJ06Jg/8
 3XCgfBO4cRgsl1D1dGeAAFGjmcq97q6IyKNP9Ug7c7V5uhKMJBRXPu1OsEwTcazFL/7f
 EmQntwK7UHl0YyiUxPMiTIdvkIzo86vSBPz7A2HFpUa+GcVM1WcgnRqjyVeEyaJPJCQh
 Se3Q==
X-Gm-Message-State: ANoB5pkbnE+eao2E18RTMdyvMG6MEFDaMxYJCXXC34DTIWk9rNzyMUHu
 BD4gqJ67PbUwB7VeiF8CnKsQTg==
X-Google-Smtp-Source: AA0mqf5nuG78G3ParQRGYGQx9/qgTYYpjKlI4g1n6r6f8suS7gW7VmK8EXRf7oBTGYdKcv14pR5JCA==
X-Received: by 2002:a05:6402:3886:b0:463:ab08:2bc6 with SMTP id
 fd6-20020a056402388600b00463ab082bc6mr63763991edb.143.1670413889261; 
 Wed, 07 Dec 2022 03:51:29 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:28 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 3/6] driver/net/tun: Added features for USO.
Date: Wed,  7 Dec 2022 13:35:55 +0200
Message-Id: <20221207113558.19003-4-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207113558.19003-1-andrew@daynix.com>
References: <20221207113558.19003-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

Added support for USO4 and USO6.
For now, to "enable" USO, it's required to set both USO4 and USO6 simultaneously.
USO enables NETIF_F_GSO_UDP_L4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/tap.c | 10 ++++++++--
 drivers/net/tun.c |  8 +++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9e75ed3f08ce..a2be1994b389 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -957,6 +957,10 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |= NETIF_F_TSO6;
 		}
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if ((arg & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
+			features |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -967,7 +971,8 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
+	    (feature_mask & (TUN_F_USO4 | TUN_F_USO6)) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
@@ -1091,7 +1096,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN | TUN_F_UFO))
+			    TUN_F_TSO_ECN | TUN_F_UFO |
+			    TUN_F_USO4 | TUN_F_USO6))
 			return -EINVAL;
 
 		rtnl_lock();
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 24001112c323..a7b9808368d0 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -185,7 +185,7 @@ struct tun_struct {
 	struct net_device	*dev;
 	netdev_features_t	set_features;
 #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
-			  NETIF_F_TSO6)
+			  NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4)
 
 	int			align;
 	int			vnet_hdr_sz;
@@ -2885,6 +2885,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
 		}
 
 		arg &= ~TUN_F_UFO;
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if (arg & TUN_F_USO4 && arg & TUN_F_USO6) {
+			features |= NETIF_F_GSO_UDP_L4;
+			arg &= ~(TUN_F_USO4 | TUN_F_USO6);
+		}
 	}
 
 	/* This gives the user a way to test for new features in future by
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
