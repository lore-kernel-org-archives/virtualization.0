Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD3FC433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 15:04:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8580D61101
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 15:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8580D61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5785C80C56;
	Mon,  8 Nov 2021 15:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P__o8AzwQMr7; Mon,  8 Nov 2021 15:04:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 134D180C8E;
	Mon,  8 Nov 2021 15:04:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1C7EC0012;
	Mon,  8 Nov 2021 15:04:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0837EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 15:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0048760800
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 15:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rd0-bchx2blv
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 15:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2628B607EC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 15:04:02 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UveXr6p_1636383838; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UveXr6p_1636383838) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 08 Nov 2021 23:03:58 +0800
MIME-Version: 1.0
message-id: <1636382860.765897-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH v4 0/3] virtio support cache indirect desc
date: Mon, 08 Nov 2021 22:47:40 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211108084732-mutt-send-email-mst@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org
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

On Mon, 8 Nov 2021 08:49:27 -0500, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Hmm a bunch of comments got ignored. See e.g.
> https://lore.kernel.org/r/20211027043851-mutt-send-email-mst%40kernel.org
> if they aren't relevant add code comments or commit log text explaining the
> design choice please.

I should have responded to related questions, I am guessing whether some emails
have been lost.

I have sorted out the following 6 questions, if there are any missing questions,
please let me know.

1. use list_head
  In the earliest version, I used pointers directly. You suggest that I use
  llist_head, but considering that llist_head has atomic operations. There is no
  competition problem here, so I used list_head.

  In fact, I did not increase the allocated space for list_head.

  use as desc array: | vring_desc | vring_desc | vring_desc | vring_desc |
  use as queue item: | list_head ........................................|

2.
> > +	if (vq->use_desc_cache && total_sg <= VIRT_QUEUE_CACHE_DESC_NUM) {
> > +		if (vq->desc_cache_chain) {
> > +			desc = vq->desc_cache_chain;
> > +			vq->desc_cache_chain = (void *)desc->addr;
> > +			goto got;
> > +		}
> > +		n = VIRT_QUEUE_CACHE_DESC_NUM;
>
> Hmm. This will allocate more entries than actually used. Why do it?


This is because the size of each cache item is fixed, and the logic has been
modified in the latest code. I think this problem no longer exists.


3.
> What bothers me here is what happens if cache gets
> filled on one numa node, then used on another?

I'm thinking about another question, how did the cross-numa appear here, and
virtio desc queue also has the problem of cross-numa. So is it necessary for us
to deal with the cross-numa scene?

Indirect desc is used as virtio desc, so as long as it is in the same numa as
virito desc. So we can allocate indirect desc cache at the same time when
allocating virtio desc queue.

4.
> So e.g. for rx, we are wasting memory since indirect isn't used.

In the current version, desc cache is set up based on pre-queue.

So if the desc cache is not used, we don't need to set the desc cache.

For example, virtio-net, as long as the tx queue and the rx queue in big packet
mode enable desc cache.

5.
> Would a better API be a cache size in bytes? This controls how much
> memory is spent after all.

My design is to set a threshold. When total_sg is greater than this threshold,
it will fall back to kmalloc/kfree. When total_sg is less than or equal to
this threshold, use the allocated cache.


6. kmem_cache_*

I have tested these, the performance is not as good as the method used in this
patch.


Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
