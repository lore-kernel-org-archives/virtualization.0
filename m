Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F54BC4708E
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC73161126;
	Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC73161126
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=TncvI/pn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jy8sFfPc7M1d; Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A72F61112;
	Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A72F61112
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55AE8C0078;
	Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC0FCC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D42F86111C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D42F86111C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ctrGyGyD32A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 089C661116
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 089C661116
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:55 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id be13so4792896lfb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wN4DUy4CI6jrcJgFDHsjquJNvQgQh0CBq/XFO2ynUaE=;
 b=TncvI/pnkeQKaTJfWTddQy6i1xGln5P4sPqmOYmoh8XOX9/iXQfw6N0SvdcfSfVASv
 r137ImoL64G167gOUOSvgrXtIHtGGfrhTP5jgM/MLOxfUMfiWlSvACwPTVobcHuYR46g
 MwX4adfi0X7LDRT5bAqj9d2gd1RESvJMB4g/OptXCn94VM8wd2dF6bzxrbT95M2Wt2jJ
 3N/1pSh5ZX9eNzRDEQ3flEz9Sh7fqVzH0ex6eXtIxDrK1cpjafeWgUQhv2CSqKbFY8Ej
 pem/ne4CpXcoRv39ko8AWaaMYYtkpUnikYKqfVJQTMfx0IZTrNT3xRK5JlYpFVQHdcLN
 p69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wN4DUy4CI6jrcJgFDHsjquJNvQgQh0CBq/XFO2ynUaE=;
 b=IoOG74DAgNKTCgnX2isctCsOjtLTaID/4w1pUxKLii1fugp3jRDWQHhfSigXLnK4xj
 aT6+7uIFlhPDUIYwGfFVjcqoQXiKdoen9+QzJHDuRdwJaOihzP62abi0lb5NLqm2ghXA
 0lmWR+BD1+lpfk8vMwvTsJqlE96gqjTUxVIBl/vScX5d4T+Q/fZEYFPd0o17Mt8lqjSU
 XJD63ZQzINSrPMKguPyyKXLuKP3cYHP587UK5eiYD5d0L4TLQZf+A0coOmCWCJ/xtZZa
 HzH2UCyTkhYshilQ8YX0P4OB+SeaFUXVcdlsBvpbr20090/Fgxs/jPDQJYdzHv1OszC8
 rEPg==
X-Gm-Message-State: ANoB5pkl8tsLq4Ah4dwzi+c8wa3PxFUMB3HeHcDNzreZH6fioNV5LKas
 f54rEh+8ZgAf2gVrlKlJgM8ifw==
X-Google-Smtp-Source: AA0mqf5DW6loVcF3hzhX8GTVWuVnFDAc4kFRcXK0FVNwJuoCTfSpwo3G+W+r5qwFnML4wed50lRdOg==
X-Received: by 2002:a05:6512:715:b0:4b4:e552:5638 with SMTP id
 b21-20020a056512071500b004b4e5525638mr14555910lfs.287.1669934933946; 
 Thu, 01 Dec 2022 14:48:53 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:53 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 4/6] uapi/linux/virtio_net.h: Added USO types.
Date: Fri,  2 Dec 2022 00:33:30 +0200
Message-Id: <20221201223332.249441-4-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201223332.249441-1-andrew@daynix.com>
References: <20221201223332.249441-1-andrew@daynix.com>
MIME-Version: 1.0
Cc: devel@daynix.com
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

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6cb842ea8979..cbc631247489 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,10 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
+
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -130,6 +134,7 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
+#define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
