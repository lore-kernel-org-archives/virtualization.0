Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D32C433FE
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDB7E84CCB;
	Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d7R8rbDGPkt4; Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 747AA84CAF;
	Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B31BC0031;
	Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12DC5C0079
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6025607F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i-59EO5DsY9v
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B636360B4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:24 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id e9so3480170ljq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dl66e2A4mF2Qyvn7/VEBHhQt84ZUbQKV7qGHfbulC4U=;
 b=Gsrzm15/kayF28SoC7sRkEvuny/rjuR0K2X1Z7cSFVnnayBUfiP4EzS1A2SOjEc6Hh
 C7NTMRcc88pn/KoPjs2YMzKWjRjxmLg0jXOGRjhWVct3Tl0qq1V+JEFL75IbM/JUmsAM
 tdrhqfsQXJCR4egAsQInQ8ZLP4VBZf3T+/bTepIzfgGapjSy+Jo9RjHYdxGOCkEOjvFf
 7GZXD2q/iwvTy3FaLt/ZtdI8FpA7ZZInUvR4qxCp0oTiIr2xfzOySbV8bMt607oC1SfJ
 7DsCIcTW0+tQfr3RglcbTYg/Mljf71FeLFk4M675o6azUTmUSWS9oipD0pox74oQEFRr
 JN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dl66e2A4mF2Qyvn7/VEBHhQt84ZUbQKV7qGHfbulC4U=;
 b=z8fuFLKYLyGVOxRjL8BYZFlDe6/x/Fbha8947x+JGo3aSIigfcVTL1AP3Ve08nNfA7
 BicDqrvABlCyOH6wpKCdGHjB2dd5pKEOC7y5ZxE2ggHExbfo5c906VZvqJN01t+cTBWr
 3yxUGyk5WoO9ygDCiZlAfugsKmMPU0TU5n4LwE3iBTDyLew1XrSZr+K1FwQyZY7zIW1f
 ZYpozVBRmUsNz6pXBohTsnDxYGOPS6v0parX14SC0zARD6VSqYhAfgJUDEL7KCIGYYby
 5JWzZuDeXTcP4qVFX3vs8DVskZnvm0w4RUEpMK9UKlAtuWlclfMlHPxwMkh9XAFDFxMo
 6AUg==
X-Gm-Message-State: AOAM532bhFcXno8DVIoqTtJvE/8cuhEcVOi2Ugl/5Lm7uYvCq63l7ZnA
 S5YHaq0d3xRErx0zbm8gKC1KWQ==
X-Google-Smtp-Source: ABdhPJzCfueNt7EGxpjgAvt/Euq5JGSCE+aooEIdd/EgvAx3MMRVq/2nZFYCCNX0MnqsmbFtQII1ig==
X-Received: by 2002:a05:651c:210c:: with SMTP id
 a12mr14427072ljq.285.1643100442603; 
 Tue, 25 Jan 2022 00:47:22 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:22 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/5] driver/net/tun: Added features for USO.
Date: Tue, 25 Jan 2022 10:46:59 +0200
Message-Id: <20220125084702.3636253-3-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
References: <20220125084702.3636253-1-andrew@daynix.com>
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

Added support for USO4 and USO6, also added code for new ioctl TUNGETSUPPORTEDOFFLOADS.
For now, to "enable" USO, it's required to set both USO4 and USO6 simultaneously.
USO enables NETIF_F_GSO_UDP_L4.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 drivers/net/tap.c | 18 ++++++++++++++++--
 drivers/net/tun.c | 15 ++++++++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 8e3a28ba6b28..82d742ba78b1 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -940,6 +940,10 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 			if (arg & TUN_F_TSO6)
 				feature_mask |= NETIF_F_TSO6;
 		}
+
+		/* TODO: for now USO4 and USO6 should work simultaneously */
+		if (arg & (TUN_F_USO4 | TUN_F_USO6) == (TUN_F_USO4 | TUN_F_USO6))
+			features |= NETIF_F_GSO_UDP_L4;
 	}
 
 	/* tun/tap driver inverts the usage for TSO offloads, where
@@ -950,7 +954,8 @@ static int set_offload(struct tap_queue *q, unsigned long arg)
 	 * When user space turns off TSO, we turn off GSO/LRO so that
 	 * user-space will not receive TSO frames.
 	 */
-	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6))
+	if (feature_mask & (NETIF_F_TSO | NETIF_F_TSO6) ||
+	    feature_mask & (TUN_F_USO4 | TUN_F_USO6) == (TUN_F_USO4 | TUN_F_USO6))
 		features |= RX_OFFLOADS;
 	else
 		features &= ~RX_OFFLOADS;
@@ -979,6 +984,7 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	unsigned short u;
 	int __user *sp = argp;
 	struct sockaddr sa;
+	unsigned int supported_offloads;
 	int s;
 	int ret;
 
@@ -1074,7 +1080,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		/* let the user check for future flags */
 		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
-			    TUN_F_TSO_ECN | TUN_F_UFO))
+			    TUN_F_TSO_ECN | TUN_F_UFO |
+			    TUN_F_USO4 | TUN_F_USO6))
 			return -EINVAL;
 
 		rtnl_lock();
@@ -1082,6 +1089,13 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETSUPPORTEDOFFLOADS:
+		supported_offloads = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
+						TUN_F_TSO_ECN | TUN_F_UFO | TUN_F_USO4 | TUN_F_USO6;
+		if (copy_to_user(&arg, &supported_offloads, sizeof(supported_offloads)))
+			return -EFAULT;
+		return 0;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fed85447701a..4f2105d1e6f1 100644
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
@@ -2821,6 +2821,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
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
@@ -2991,6 +2997,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	int sndbuf;
 	int vnet_hdr_sz;
 	int le;
+	unsigned int supported_offloads;
 	int ret;
 	bool do_notify = false;
 
@@ -3154,6 +3161,12 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	case TUNSETOFFLOAD:
 		ret = set_offload(tun, arg);
 		break;
+	case TUNGETSUPPORTEDOFFLOADS:
+		supported_offloads = TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
+				TUN_F_TSO_ECN | TUN_F_UFO | TUN_F_USO4 | TUN_F_USO6;
+		if (copy_to_user(&arg, &supported_offloads, sizeof(supported_offloads)))
+			ret = -EFAULT;
+		break;
 
 	case TUNSETTXFILTER:
 		/* Can be set only for TAPs */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
