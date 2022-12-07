Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4C7C352A1
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B6BD41864;
	Wed,  7 Dec 2022 11:51:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B6BD41864
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=zGFToKn8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVw_wz30sEye; Wed,  7 Dec 2022 11:51:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A65C940A00;
	Wed,  7 Dec 2022 11:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A65C940A00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 740C4C0082;
	Wed,  7 Dec 2022 11:51:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E774C007B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4515D4157B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4515D4157B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwetzRGhgwj6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48E4741834
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48E4741834
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:34 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id t17so13418735eju.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/l0FUf2LxM2s+FDut6wgd6Dg4LANJfMwzdqmeR53eYQ=;
 b=zGFToKn8FO86Xuv7xvlk8liqDBqCPtY/J6xbVIrbVoCMYk37GfocinB/w4RX6y/pzM
 4ZGegPNiPLEVFHdFPF6sRPCUqQ+MQPse11q8bDMIKo9f+StPCIaCT18AKoOOE7/j58ni
 qHJZjAwf2Diws280GHKdu2muF6bQCiQfRUkOSH6dIbG7qwf5kouiNDBzbs8+JGmuYhPs
 pjEyAaDqf1+JDh9lwjKS13SEbi4oeHEGWOvPuVVmNu52DF63clWC4lBbmZL9XZ1/8Asi
 u6/Rz+zYUUj8+1Rvk0lcnWiM1B3nmx+byccKjnjwbApusrzRV8aX9HgnfnoBEbTdzbba
 6aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/l0FUf2LxM2s+FDut6wgd6Dg4LANJfMwzdqmeR53eYQ=;
 b=XfP8DOKXAup+P4QS0z9O0GKWiwErrHI86lv6MOIMqKvQD3CkmFQ9p39VFU8Xq/jeOA
 I2wQ2z0mVnnbtOhu3QPSdX4MOa2QC1ste37169gHgrvsYzWsm0u0CNKFMnzSdp16uAy4
 6Ak4nZzdox9j+EBW1BBG2fctSLCTq8P33c3rJ9fBpZFioqaZWxwevW/OPepKY/5uzzTi
 gW0CuKRbvnlg03BC1fUjJMcPJNeSQa4USutZLvtbHULIcIlgtxBABm76VzbXm0Q+joiX
 eMGsvK3lKEigfSf3eDWHpKdW4bZC/zH6lCx5zT3Qyg1avGobzHXjfK402XIp01FpDm33
 FclA==
X-Gm-Message-State: ANoB5pmdizAtLyxzNzbiIrfXZ4SqlZY7uQbEPIX3uFoh6tEWSkeZdWt6
 rp0kT3wABMpm+8tgALYMtMZVOQ==
X-Google-Smtp-Source: AA0mqf7+5NlnP9WcERs7h4Vqci3F/FAmaQylak0BsGYiINaDgtGqamvILPTZQKlrzMLN2sxBgVUllA==
X-Received: by 2002:a17:906:fa0d:b0:7c0:e5cb:b73b with SMTP id
 lo13-20020a170906fa0d00b007c0e5cbb73bmr12860692ejb.624.1670413892372; 
 Wed, 07 Dec 2022 03:51:32 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:32 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 5/6] linux/virtio_net.h: Support USO offload in vnet header.
Date: Wed,  7 Dec 2022 13:35:57 +0200
Message-Id: <20221207113558.19003-6-andrew@daynix.com>
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
