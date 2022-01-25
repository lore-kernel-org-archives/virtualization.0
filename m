Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47792C433F5
	for <virtualization@archiver.kernel.org>; Tue, 25 Jan 2022 08:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9362684CC1;
	Tue, 25 Jan 2022 08:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BjA-hhyix7oC; Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F01E84CC6;
	Tue, 25 Jan 2022 08:47:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904E7C0078;
	Tue, 25 Jan 2022 08:47:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD162C0031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0E3E84CAD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D9KeWzwZkyc1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A081E84CA0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:47:26 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id q127so868660ljq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=baQ+umQNqHWDum1lpPhk7WW3HA5LDWS+YAun2KSlxoM=;
 b=wDBHF7w/TMCb+hQit42vS3t/lC2517uJvPUBhXqfdal8jFWSxDixIdeHImw94pMhB9
 W/f5jjHcIoSKzFZPwx0UyQRx1HbhvsrRTy9LNxD8iZoa251NscFVFZuAEscBM6N3hDsQ
 NnH2t8ECcNwthNO5DibTwt2kykb16IQ9DGEpoSY/KR5Am9y5CTGEvxZQXL/mauiXRIBU
 Qc21Vx3CCtxwjUFB5Iou22VHPZ1ostv8ol7NyHBmJQcMOTSFKVW2gJuEknM5jSEe0H1m
 9TNftXM0SRofdK18MnBocE0I8NruSmiIE4gm+emYaz4cUNijLiUedvW8GyyzRlA8BEsg
 X8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=baQ+umQNqHWDum1lpPhk7WW3HA5LDWS+YAun2KSlxoM=;
 b=EkF6IWS9L3xalcNuG7JjfCPlS6zo9aWPKl/XZNwRWVW8W/DE37DR6VB9GFzzed2XxE
 wuexh9iYv0IyJJ0adSqAcv6lPvxPgU6wC2R25ky2+8Ts9xN/efmC2q/EbH6cUIqgZCez
 uK3t+YQRk0cfRkVb+6bIvTKbjELYGN7zKz4G0uVvC5K7vg/op1jepqxx3tdgdil5ejai
 eahHsAOI4Lppsc8nAbGZIe05wcDwKEso/K8DGfgjz2TJeiGe+P79KpYADApIFOGlJ+RN
 pLJiTjn4hmyJKH1SoJrfZOvnVNwF4EQoGM0ebWo86ri/brpIiv6BRHn0yu0O8MUygLXj
 cflA==
X-Gm-Message-State: AOAM533pykJe94AEsqHgZGjeiJtrBJMms7SyyM1il8zOZ7zxpyOibHft
 qX75FrHg5K64aYUxMsQ6n2iwEg==
X-Google-Smtp-Source: ABdhPJxwoXFjwGNabYMY+I6uihGStNKdiHmxSD+sVeV0Up4jOraro+EZiNLGhfeRiUwhmTKg6Qqrhw==
X-Received: by 2002:a2e:7f10:: with SMTP id a16mr14008651ljd.48.1643100444520; 
 Tue, 25 Jan 2022 00:47:24 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id q5sm1418944lfe.279.2022.01.25.00.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jan 2022 00:47:24 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 4/5] linux/virtio_net.h: Added Support for GSO_UDP_L4
 offload.
Date: Tue, 25 Jan 2022 10:47:01 +0200
Message-Id: <20220125084702.3636253-5-andrew@daynix.com>
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

Now, it's possible to convert vnet packets from/to skb.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/linux/virtio_net.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69..9311d41d0a81 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -17,6 +17,9 @@ static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 	case VIRTIO_NET_HDR_GSO_UDP:
 		return protocol == cpu_to_be16(ETH_P_IP) ||
 		       protocol == cpu_to_be16(ETH_P_IPV6);
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
+		return protocol == cpu_to_be16(ETH_P_IP) ||
+		       protocol == cpu_to_be16(ETH_P_IPV6);
 	default:
 		return false;
 	}
@@ -31,6 +34,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
 	case VIRTIO_NET_HDR_GSO_TCPV4:
 	case VIRTIO_NET_HDR_GSO_UDP:
+	case VIRTIO_NET_HDR_GSO_UDP_L4:
 		skb->protocol = cpu_to_be16(ETH_P_IP);
 		break;
 	case VIRTIO_NET_HDR_GSO_TCPV6:
@@ -69,6 +73,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
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
@@ -182,6 +191,8 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
 		else if (sinfo->gso_type & SKB_GSO_TCPV6)
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+		else if (sinfo->gso_type & SKB_GSO_UDP_L4)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
