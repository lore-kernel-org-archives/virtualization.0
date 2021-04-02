Return-Path: <SRS0=r8Qk=I7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B1BC433ED
	for <virtualization@archiver.kernel.org>; Fri,  2 Apr 2021 13:26:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D386112E
	for <virtualization@archiver.kernel.org>; Fri,  2 Apr 2021 13:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D386112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C24A84CAD;
	Fri,  2 Apr 2021 13:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lcQHwf2sNlkS; Fri,  2 Apr 2021 13:26:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF87D84C8C;
	Fri,  2 Apr 2021 13:26:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B35B6C000C;
	Fri,  2 Apr 2021 13:26:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC72CC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 13:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B221A60699
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 13:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h9teO9X_OuAg
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 13:26:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8407B60617
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 13:26:06 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id e14so2538681plj.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Apr 2021 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nk+eDWG+Yugeh+2vUQ3xh9rieveuu83pFSxXTHCSafY=;
 b=B2uCfpeLEfh7+GbIRXc92PEReJZPG8BgODY1iTU947PttSc1udmsdBVjcPOoriAixR
 FyOfN5k0IL+LrCvxBJk/vwh0V+yWkXlw5rO4V9LPmQBEr28bgLoytT4sWrAcG9R3ZZ15
 p0PHhZljifXdclzWtfw5MPBO3EFOPL5Z3nzIjJoiMKMkMkj+TaFsKk0Q22gmnaxB8x8A
 vrCcpm9loqwbDrDWd8rznfahQtAgDj6I5xK+K+Lb1WzZq6WOKir4uHHXXs/RqRO1IBMn
 tqkP4ba57yZE9LLVjuGHsVlr9fXGu0LNLEJPmKFA5+Nxmo7FThhOyxRAzpYtuzQMAVxc
 QGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nk+eDWG+Yugeh+2vUQ3xh9rieveuu83pFSxXTHCSafY=;
 b=XijE2ghkFzxVfxlLZiVzibaQqGsyCeiFmVG0+VvWGdSrNWgE4QqFcaqeTwm7PeLizi
 JVhBQ91B2Dr3c4Quf8MJLEAzhxcROLRyfTiZGOPIg/jQjzsyJ5Zzb73ib9NsHdGzM1js
 jCHhdpc2xhMMGdNa4Vnrrbon/XYXxFHVZlBtkfCzOjIXr3zX6Zca+7cL1h6mT2LgLKPW
 IfZCgz4XjKXdHsD/i3VyIGjxn6Z83dR4Ve3YZQdNMeS18V9S3C5sxsc8XkDOz3OgFk1V
 elinfqcZou7neKhlGYbgJsTPcmR5YLec1P0pZAXd1eJ4WCMOoogSQrbDw2gLFPoa3tbC
 H00g==
X-Gm-Message-State: AOAM530FO3JzqV0hmixBz1H1nevqBXGEWqbDIzeIpA/+jdj34gfXbeqk
 2tR6xGLIQq6cBDkrgp1EzAM=
X-Google-Smtp-Source: ABdhPJz75mHHj1AwPACN1N3Khde/fIrHWHsGNKQt88nZjq2LvlV8IY6bbUOiBoDPXvcxYAE3Q9sDVw==
X-Received: by 2002:a17:902:bd8f:b029:e6:ec5a:3a6 with SMTP id
 q15-20020a170902bd8fb02900e6ec5a03a6mr13074978pls.31.1617369966016; 
 Fri, 02 Apr 2021 06:26:06 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com
 ([2620:15c:2c4:201:a57a:ec96:644b:4d80])
 by smtp.gmail.com with ESMTPSA id s22sm8143247pjs.42.2021.04.02.06.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Apr 2021 06:26:05 -0700 (PDT)
From: Eric Dumazet <eric.dumazet@gmail.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] virtio_net: Do not pull payload in skb->head
Date: Fri,  2 Apr 2021 06:26:02 -0700
Message-Id: <20210402132602.3659282-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
MIME-Version: 1.0
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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

From: Eric Dumazet <edumazet@google.com>

Xuan Zhuo reported that commit 3226b158e67c ("net: avoid 32 x truesize
under-estimation for tiny skbs") brought  a ~10% performance drop.

The reason for the performance drop was that GRO was forced
to chain sk_buff (using skb_shinfo(skb)->frag_list), which
uses more memory but also cause packet consumers to go over
a lot of overhead handling all the tiny skbs.

It turns out that virtio_net page_to_skb() has a wrong strategy :
It allocates skbs with GOOD_COPY_LEN (128) bytes in skb->head, then
copies 128 bytes from the page, before feeding the packet to GRO stack.

This was suboptimal before commit 3226b158e67c ("net: avoid 32 x truesize
under-estimation for tiny skbs") because GRO was using 2 frags per MSS,
meaning we were not packing MSS with 100% efficiency.

Fix is to pull only the ethernet header in page_to_skb()

Then, we change virtio_net_hdr_to_skb() to pull the missing
headers, instead of assuming they were already pulled by callers.

This fixes the performance regression, but could also allow virtio_net
to accept packets with more than 128bytes of headers.

Many thanks to Xuan Zhuo for his report, and his tests/help.

Fixes: 3226b158e67c ("net: avoid 32 x truesize under-estimation for tiny skbs")
Reported-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Link: https://www.spinics.net/lists/netdev/msg731397.html
Co-Developed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/net/virtio_net.c   | 10 +++++++---
 include/linux/virtio_net.h | 14 +++++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 82e520d2cb1229a0c7b9fd0def3e4a7135536478..0824e6999e49957f7aaf7c990f6259792d42f32b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -406,9 +406,13 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	offset += hdr_padded_len;
 	p += hdr_padded_len;
 
-	copy = len;
-	if (copy > skb_tailroom(skb))
-		copy = skb_tailroom(skb);
+	/* Copy all frame if it fits skb->head, otherwise
+	 * we let virtio_net_hdr_to_skb() and GRO pull headers as needed.
+	 */
+	if (len <= skb_tailroom(skb))
+		copy = len;
+	else
+		copy = ETH_HLEN + metasize;
 	skb_put_data(skb, p, copy);
 
 	if (metasize) {
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 98775d7fa69632e2c2da30b581a666f7fbb94b64..b465f8f3e554f27ced45c35f54f113cf6dce1f07 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -65,14 +65,18 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	skb_reset_mac_header(skb);
 
 	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
-		u16 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
-		u16 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
+		u32 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
+		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
+		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
+
+		if (!pskb_may_pull(skb, needed))
+			return -EINVAL;
 
 		if (!skb_partial_csum_set(skb, start, off))
 			return -EINVAL;
 
 		p_off = skb_transport_offset(skb) + thlen;
-		if (p_off > skb_headlen(skb))
+		if (!pskb_may_pull(skb, p_off))
 			return -EINVAL;
 	} else {
 		/* gso packets without NEEDS_CSUM do not set transport_offset.
@@ -102,14 +106,14 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			}
 
 			p_off = keys.control.thoff + thlen;
-			if (p_off > skb_headlen(skb) ||
+			if (!pskb_may_pull(skb, p_off) ||
 			    keys.basic.ip_proto != ip_proto)
 				return -EINVAL;
 
 			skb_set_transport_header(skb, keys.control.thoff);
 		} else if (gso_type) {
 			p_off = thlen;
-			if (p_off > skb_headlen(skb))
+			if (!pskb_may_pull(skb, p_off))
 				return -EINVAL;
 		}
 	}
-- 
2.31.0.208.g409f899ff0-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
