Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75778C74A5B
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E941E60F48;
	Wed, 22 Mar 2023 03:03:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E941E60F48
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAoVsn1qYxCC; Wed, 22 Mar 2023 03:03:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66E2360F1B;
	Wed, 22 Mar 2023 03:03:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66E2360F1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C5F0C008C;
	Wed, 22 Mar 2023 03:03:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C945C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AF7E60E79
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AF7E60E79
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33C-_SHr8OKr
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0296960F1B
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0296960F1B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:03:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VeOucAd_1679454189; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeOucAd_1679454189) by smtp.aliyun-inc.com;
 Wed, 22 Mar 2023 11:03:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
Date: Wed, 22 Mar 2023 11:03:01 +0800
Message-Id: <20230322030308.16046-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e9e1372f356
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

In the xdp implementation of virtio-net mergeable, it always checks
whether two page is used and a page is selected to release. This is
complicated for the processing of action, and be careful.

In the entire process, we have such principles:
* If xdp_page is used (PASS, TX, Redirect), then we release the old
  page.
* If it is a drop case, we will release two. The old page obtained from
  buf is release inside err_xdp, and xdp_page needs be relased by us.

But in fact, when we allocate a new page, we can release the old page
immediately. Then just one is using, we just need to release the new
page for drop case. On the drop path, err_xdp will release the variable
"page", so we only need to let "page" point to the new xdp_page in
advance.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e2560b6f7980..4d2bf1ce0730 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1245,6 +1245,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			if (!xdp_page)
 				goto err_xdp;
 			offset = VIRTIO_XDP_HEADROOM;
+
+			put_page(page);
+			page = xdp_page;
 		} else if (unlikely(headroom < virtnet_get_headroom(vi))) {
 			xdp_room = SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
 						  sizeof(struct skb_shared_info));
@@ -1259,6 +1262,9 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			       page_address(page) + offset, len);
 			frame_sz = PAGE_SIZE;
 			offset = VIRTIO_XDP_HEADROOM;
+
+			put_page(page);
+			page = xdp_page;
 		} else {
 			xdp_page = page;
 		}
@@ -1278,8 +1284,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			if (unlikely(!head_skb))
 				goto err_xdp_frags;
 
-			if (unlikely(xdp_page != page))
-				put_page(page);
 			rcu_read_unlock();
 			return head_skb;
 		case XDP_TX:
@@ -1297,8 +1301,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				goto err_xdp_frags;
 			}
 			*xdp_xmit |= VIRTIO_XDP_TX;
-			if (unlikely(xdp_page != page))
-				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		case XDP_REDIRECT:
@@ -1307,8 +1309,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			if (err)
 				goto err_xdp_frags;
 			*xdp_xmit |= VIRTIO_XDP_REDIR;
-			if (unlikely(xdp_page != page))
-				put_page(page);
 			rcu_read_unlock();
 			goto xdp_xmit;
 		default:
@@ -1321,9 +1321,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_xdp_frags;
 		}
 err_xdp_frags:
-		if (unlikely(xdp_page != page))
-			__free_pages(xdp_page, 0);
-
 		if (xdp_buff_has_frags(&xdp)) {
 			shinfo = xdp_get_shared_info_from_buff(&xdp);
 			for (i = 0; i < shinfo->nr_frags; i++) {
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
