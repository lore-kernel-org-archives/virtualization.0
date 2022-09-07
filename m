Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFD5C54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 12:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B760408E4;
	Wed,  7 Sep 2022 12:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B760408E4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=ueJxzkN3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CSrDUxG4ChgB; Wed,  7 Sep 2022 12:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 389ED408C8;
	Wed,  7 Sep 2022 12:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 389ED408C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10780C0033;
	Wed,  7 Sep 2022 12:51:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5738AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27A0760AFB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27A0760AFB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=ueJxzkN3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nG5jMZ16S7Mq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A24C60AF6
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A24C60AF6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 12:51:35 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id bq9so7330777wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=nGlu+O6PlfW3f4AqMN8ylp1+LKCaEOK0oFUo4L9z4xA=;
 b=ueJxzkN3eJNlAg+GMZs26h6REziEHQI3HWXre9RJs19XnQoBTzWRjuFazwWX3JOHMj
 t87i0l4mhR594c89dLs4LSfdPQsFiQzdtVKQ+nol8t7zDmcQ7wqGvA6wim/isjUzyyaD
 vM+MmvfLQA/jZ0SpdhtWFnyxTdiQ1GJ7yYqU0R7wsTm3CVqb3Fc+B2ZupB37ZUrGBRCL
 aSNWbFn72P35KeoiGctujICZrrNelp0EVbOJQa9r6PqO4YXqpiVq9KYGCSxpakiYJtL6
 OPBVcyQEOJEGvNYBrvGpPuv15mkiuTStd7LZoYTF0qYE8JQU1WGPEN9ic53zGYuQ1F4E
 mJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=nGlu+O6PlfW3f4AqMN8ylp1+LKCaEOK0oFUo4L9z4xA=;
 b=aw1AcknEBOFPMAjuSD+j2K0uZ50SgUV5c+PpmUMZwvxFlsdWyzLZUG/wq0Gsqmwv1y
 vvlfPR4FNFEo/eUFEkgF7yL/wwkdXubReXpxVCoBDsxrB8UuhPQ50g23qNcfZ2LgJOQO
 IAGrVJAJbsOkx0xEVCRCQ8uRRnB3JQYenuQ9z/K0JNFjpn43y6zw6a4XBSA5sleAQoE4
 EtTSMAL3tfV3QwpP25sxG7ml2J6/FtyfY2ZCsUDyiEi9QmWNlRDkl9/zD/s05C5NEPvP
 CMnWTh1wzM7VHx6oh5HN5+H2OIAEEZ9EvbN/A5eicZBbOMADu8K2/Jg9B/VsmFOC+bEl
 umoQ==
X-Gm-Message-State: ACgBeo2FEgQJZwrZufYOepyRQlMzns+0PTi9D84HORZTEmBHiueAOTiP
 GrDByKyRmWMgfZ6/O+R+B0Ju9Q==
X-Google-Smtp-Source: AA6agR5ZEuRdm/1QAOIGaAcNDlwntn9DuFUT138xlWy0ZrQWQV31HT8C2Kgpx41gGSCq6ES6au8o0A==
X-Received: by 2002:a5d:6245:0:b0:225:3e24:e5b1 with SMTP id
 m5-20020a5d6245000000b002253e24e5b1mr2089702wrv.698.1662555093607; 
 Wed, 07 Sep 2022 05:51:33 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 e27-20020adf9bdb000000b0021f0ff1bc6csm11480001wrc.41.2022.09.07.05.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 05:51:33 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: edumazet@google.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com, mst@redhat.com,
 pabeni@redhat.com, yoshfuji@linux-ipv6.org, dsahern@kernel.org
Subject: [PATCH v3 3/6] driver/net/tun: Added features for USO.
Date: Wed,  7 Sep 2022 15:50:45 +0300
Message-Id: <20220907125048.396126-4-andrew@daynix.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907125048.396126-1-andrew@daynix.com>
References: <20220907125048.396126-1-andrew@daynix.com>
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
index 259b2b84b2b3..f0e674e1c45e 100644
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
@@ -2871,6 +2871,12 @@ static int set_offload(struct tun_struct *tun, unsigned long arg)
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
2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
