Return-Path: <SRS0=ej4m=MW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEAC4338F
	for <virtualization@archiver.kernel.org>; Fri, 30 Jul 2021 10:45:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8112160F9B
	for <virtualization@archiver.kernel.org>; Fri, 30 Jul 2021 10:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8112160F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5222760A73;
	Fri, 30 Jul 2021 10:45:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4KDVogUwhjL; Fri, 30 Jul 2021 10:45:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5FCF605F8;
	Fri, 30 Jul 2021 10:45:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A90C3C0010;
	Fri, 30 Jul 2021 10:45:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C40E7C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 10:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0C5983252
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 10:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSWtfo5Y2Jkp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 10:45:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C27E283218
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 10:45:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB77E60F6B;
 Fri, 30 Jul 2021 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1627641940;
 bh=a7NunjToxf5g9csFohYneAsYQ/mI2EiLSZB/amu8H+4=;
 h=Subject:To:Cc:From:Date:From;
 b=GEMv2o6irRd6Cbx4ADCMu1h04v8KCQtEMtBLVzNpLxxOa4v3V70rX3bl1e9Hvn9Rr
 RmHAgtrs6A8/8jmHOpdAHbDOAq5W3D3AVVj6YKQvajOoTF+qYzRSSdEUD+wLv039FF
 kacy3GWysHDuxsCreu0ZJYEVR0kRv/7HCg9MU2FA=
Subject: Patch "virtio_net: Do not pull payload in skb->head" has been added
 to the 4.19-stable tree
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, matthieu.baerts@tessares.net, mst@redhat.com,
 virtualization@lists.linux-foundation.org, xuanzhuo@linux.alibaba.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 30 Jul 2021 12:45:29 +0200
Message-ID: <1627641929243225@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    virtio_net: Do not pull payload in skb->head

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     virtio_net-do-not-pull-payload-in-skb-head.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 0f6925b3e8da0dbbb52447ca8a8b42b371aac7db Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Apr 2021 06:26:02 -0700
Subject: virtio_net: Do not pull payload in skb->head

From: Eric Dumazet <edumazet@google.com>

commit 0f6925b3e8da0dbbb52447ca8a8b42b371aac7db upstream.

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
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c   |   10 +++++++---
 include/linux/virtio_net.h |   14 +++++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -413,9 +413,13 @@ static struct sk_buff *page_to_skb(struc
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
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -65,14 +65,18 @@ static inline int virtio_net_hdr_to_skb(
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
@@ -102,14 +106,14 @@ retry:
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


Patches currently in stable-queue which might be from edumazet@google.com are

queue-4.19/virtio_net-do-not-pull-payload-in-skb-head.patch
queue-4.19/gro-ensure-frag0-meets-ip-header-alignment.patch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
