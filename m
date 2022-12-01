Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68928C4321E
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 22:49:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F3674159C;
	Thu,  1 Dec 2022 22:49:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F3674159C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=YgA9JI0r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLtvyH1xA88s; Thu,  1 Dec 2022 22:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AE5514108B;
	Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE5514108B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89A88C007E;
	Thu,  1 Dec 2022 22:48:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40C78C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DCFF61112
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0DCFF61112
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
 header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=YgA9JI0r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zRpLeBaLgoqa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FBD760E41
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3FBD760E41
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 22:48:57 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id a19so3600061ljk.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/l0FUf2LxM2s+FDut6wgd6Dg4LANJfMwzdqmeR53eYQ=;
 b=YgA9JI0r8x1idCpGrUISHXxPTdpS8bE+zsK2hvBE6Clp7Ot8Tk6aeKy8gHLzxM9ui6
 kC97V/EXcm29B+G1Wg5a7hkVWQ3+bAK5vu99zAskxHMi0yjdL+s2G6pFOFL8LJ6YMrQr
 dT1zEeyypZF4PBKfoG9RmIKCV01RpeCg7mkX/vh/FYeN4WPOQdeO7ejQKenuwrerVhn1
 JKY0SzO7f92Vpm3LiqAnYZoGS/wTqDzcpS8Kj3v8JrfT5UFennM93bMqq/oWMWpUzup1
 WIpuivGA5QSgzGvV9nM9bamVilfi++Rtc1Q44hoWfxurIEOwu2e4lFeNcgPVNGiuZcFD
 rvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/l0FUf2LxM2s+FDut6wgd6Dg4LANJfMwzdqmeR53eYQ=;
 b=62xzANPrQFZ2XnqcbymXmYkLHrDzVia/jZz5jO1OZfJhslIpds8yGH5ihz5kuf9lRI
 U4kF4xYWbKlOXr31J4MY0tMXeyJG80Y7upQ2jVbXkJEsDRLRwOw0CWSYRnjbqntoomJO
 Rj2yqBOw2dmBqgxeJ+YXHQcIkMFqkmJBfM3UsFg6nZftLEO43dVII291WxpcX2EZsW5s
 yJKLasMB4oDHR0w+MmoqmAfw+0qSUGvUDjbtO8k/4XmwcPmshU0uWqQaNaG28SrWXPei
 U0J2nEKzDv+dw1nAPIVzaXYIwRHdpwqCVYMU/FTWwDBdSjQiB93DOAhvk6xd4SvqFwGX
 uD0A==
X-Gm-Message-State: ANoB5pk/H8LIHE5YngQlkY0Ix4FU6lZFxnC1/jT0MYpIVO0nhq7+rUlh
 I+firkHIvOzCX9UZV4sHFIBHIQ==
X-Google-Smtp-Source: AA0mqf6z1/SPXT0IYlCh6uASjRLPNbQTx97NzAe14WJnS6Vvg6j4QCwKsOjDSjCtAjn6pCA/kVnYpw==
X-Received: by 2002:a05:651c:243:b0:279:9935:9170 with SMTP id
 x3-20020a05651c024300b0027999359170mr9579082ljn.457.1669934935286; 
 Thu, 01 Dec 2022 14:48:55 -0800 (PST)
Received: from localhost.localdomain ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a056512118700b00497ab34bf5asm797573lfr.20.2022.12.01.14.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 14:48:54 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v4 5/6] linux/virtio_net.h: Support USO offload in vnet header.
Date: Fri,  2 Dec 2022 00:33:31 +0200
Message-Id: <20221201223332.249441-5-andrew@daynix.com>
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

Now, it's possible to convert USO vnet packets from/to skb.
Added support for GSO_UDP_L4 offload.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/linux/virtio_net.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69..bdf8de2cdd93 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -15,6 +15,7 @@ static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 	case VIRTIO_NET_HDR_GSO_TCPV6:
 		return protocol == cpu_to_be16(ETH_P_IPV6);
 	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
 		return protocol == cpu_to_be16(ETH_P_IP) ||
 		       protocol == cpu_to_be16(ETH_P_IPV6);
 	default:
@@ -31,6 +32,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
 		skb->protocol = cpu_to_be16(ETH_P_IP);
 		break;
 	case VIRTIO_NET_HDR_GSO_TCPV6:
@@ -69,6 +71,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			ip_proto = IPPROTO_UDP;
 			thlen = sizeof(struct udphdr);
 			break;
+		case VIRTIO_NET_HDR_GSO_UDP_L4:
+			gso_type = SKB_GSO_UDP_L4;
+			ip_proto = IPPROTO_UDP;
+			thlen = sizeof(struct udphdr);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -182,6 +189,8 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
 		else if (sinfo->gso_type & SKB_GSO_TCPV6)
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
