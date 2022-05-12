Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CB2C433FE
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 11:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3630340BF5;
	Thu, 12 May 2022 11:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0wKUI3mE_sk; Thu, 12 May 2022 11:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E84D340BCB;
	Thu, 12 May 2022 11:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E72D4C0086;
	Thu, 12 May 2022 11:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B9C3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDC4140C03
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PlzzNq1c-PL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3548F40BCD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 11:33:25 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id t25so8493185lfg.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uEd6sKxlslOXYob+aYfGwuvE08ax3brjjZ3tUvtT5nY=;
 b=mCHGtsjtThp07FRQVWEOYHDAwe2bBM2SDMWFzwOclYH/rUTFzeOEkDMmdNLQf39AT2
 O2mNEgmOZg/cHw7jlv0Osi3mhNGYG0l8Xz49E+1YMT0zwPkbiMC1s3QXwWiOOzm0dn4X
 2Tt81II75xQVgnFqgQ4NbIPn1AZm3tiuyTeEaqNvgHmAKCVh0lGRJrDT4/tSsVjAaDDv
 qsFOHs+FzmaSvfyupxUNCNbI/vncTof4xDFmBCYbWV3Z3eudplwDwY4YBoYZgzUj00Ow
 igGvTMUVJu/KWjf1Sm5CwmrI00a5XCneA5bhaUdYVtKeqDokXwPGjxLL6ljRGAZjKuv8
 FF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uEd6sKxlslOXYob+aYfGwuvE08ax3brjjZ3tUvtT5nY=;
 b=RWuSEOs8GYdsFQoIX7MGzTzdT1ZkzCrHQkc0zqSkufOWn4aTDNtHFaglWq+Yr3Fn3V
 T2oWmackb1Gld0kitz/kW6P4DTUFOIqcRzXlrCfEBaIwqNurW5IJkksHmbp82hGxu8Gn
 qK0zksxnrA0bwuFQKUgZIWb43zw3UMaFH3LR0uw+HTJ1K2Q4tdeRc2X+85eNE6UIi9xH
 kMMEDCzEpMLj5StgjDDddYqXWwA/RZplzI65NIBGdA+s8svFTLG54FCcvuOdcrAVQQnu
 YndBEjOk29i1Xp0av9F3/yZwZlHd67a1ZBh6lNbf3zhoNt8oiqHI4yT3AJb5t42MFTi7
 wRPg==
X-Gm-Message-State: AOAM532XJcCg8Z/Q9FAXMu7CzczSAvKTbVg3n6+EcsjgJ0QcdKuOxurx
 KzVjybgZai6QTydZfCwSJzIRZA==
X-Google-Smtp-Source: ABdhPJydZzsXkKuh6xmb+KoEHAkgMMM0h42G7A/Eo3hW5TLHRzkOvvI0WdKXGyQ3m/jp7y02DTwP9Q==
X-Received: by 2002:a05:6512:4009:b0:46d:31b:e05a with SMTP id
 br9-20020a056512400900b0046d031be05amr24343108lfb.528.1652355203000; 
 Thu, 12 May 2022 04:33:23 -0700 (PDT)
Received: from localhost.localdomain (host-188-190-49-235.la.net.ua.
 [188.190.49.235]) by smtp.gmail.com with ESMTPSA id
 r29-20020ac25a5d000000b0047255d211a6sm741758lfn.213.2022.05.12.04.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 May 2022 04:33:22 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH v2 4/5] linux/virtio_net.h: Support USO offload in vnet
 header.
Date: Thu, 12 May 2022 14:23:46 +0300
Message-Id: <20220512112347.18717-5-andrew@daynix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512112347.18717-1-andrew@daynix.com>
References: <20220512112347.18717-1-andrew@daynix.com>
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
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
