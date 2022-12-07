Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18865C4708D
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 11:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5D7740B6B;
	Wed,  7 Dec 2022 11:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5D7740B6B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com header.i=@daynix-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=H9X+AFPn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNF76V0iUyFX; Wed,  7 Dec 2022 11:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4846B40B63;
	Wed,  7 Dec 2022 11:51:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4846B40B63
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E24DC0033;
	Wed,  7 Dec 2022 11:51:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB939C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85B5B40B67
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85B5B40B67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Es3Gi0GCDuDU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5188408DD
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5188408DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 11:51:32 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id r26so24491266edc.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 03:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jBijGHO2AiN4F548fLyvLB60bsMpsKu4cHIqRi1tL5k=;
 b=H9X+AFPnQ/jrcVc/TZh4p6OCCB9QnS40L1PNff3KnTL3jCQL/9YUSluFGfIWNf3gKH
 Gj5X2MslAuL+bwkvot+yLkNRpx8VbxU01EEsTtDoNqwWtxIKptrYkCBN/XI9T2+zwe74
 eAUoicIW8NJphlWRYGQw2g27aHrS9bae1rFemv1LMfPt3ufU/rnFiG5tPle8inwnkPT2
 0nf03huOy7XhdnabUxaYiNjW14wavAn5/OUDv+5szb+Pz3olGMLKwG2srJddxiKQ7/w/
 Gugi/uX4FrkP6kLI3ZyM3Nj0erZmocZCHO21aSKmBHfughvhmmd3V8DmhRyTf21tDBfA
 JKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jBijGHO2AiN4F548fLyvLB60bsMpsKu4cHIqRi1tL5k=;
 b=1Dur4FQRFVWJKuEQi4Z2SwIqvwVqFCHBcQcUC5R18/yKfPfgGpW8G2FNJcvI7EQPjF
 kOBeJWlwyeVT1Wnj465kAFjspw0kbVOV3TEfFQDqov3HTRQYQYvxVJKo6hvbYjYVELUL
 mKGDs2vMRyIrgnqC0YYpEaZx1t+r4jDr4kVIOMcPdtZwrTXvRNg+Fqa+GlyzE+ABKrA/
 8yh2h7nS4pmFaEXz/bL1AnHCFYe97vsUBsutR5pICF+p0trHN4CRKGHCCr4bgJqd6iNp
 wyX1GRJGILt8D8VN7yUihwQjRY+zkTf4gla2bsgrgCveHiSmrpIfhwbMJJ5tdkiF0j9e
 wfTA==
X-Gm-Message-State: ANoB5plhl9r94EqfpVytJovoIkmbCwA5VBYRzQHi/Pj356Tpv6p90T8x
 JTxSfYPCDNLeXm2K9bQ5qpHJ2Q==
X-Google-Smtp-Source: AA0mqf7faeznv+cpNEiJunIj8ZXLiDNsCAgep7kdqvALdydx8RSBGSjOxHBYVMfpgyqOzpQDAkk/iA==
X-Received: by 2002:a05:6402:528d:b0:468:dc9:ec08 with SMTP id
 en13-20020a056402528d00b004680dc9ec08mr5877921edb.17.1670413890749; 
 Wed, 07 Dec 2022 03:51:30 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 03:51:30 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH v5 4/6] uapi/linux/virtio_net.h: Added USO types.
Date: Wed,  7 Dec 2022 13:35:56 +0200
Message-Id: <20221207113558.19003-5-andrew@daynix.com>
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

Added new GSO type for USO: VIRTIO_NET_HDR_GSO_UDP_L4.
Feature VIRTIO_NET_F_HOST_USO allows to enable NETIF_F_GSO_UDP_L4.
Separated VIRTIO_NET_F_GUEST_USO4 & VIRTIO_NET_F_GUEST_USO6 features
required for Windows guests.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 include/uapi/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6cb842ea8979..b4062bed186a 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
+#define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
+#define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
+#define VIRTIO_NET_F_HOST_USO	56	/* Host can handle USO in. */
 #define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
@@ -130,6 +133,7 @@ struct virtio_net_hdr_v1 {
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
