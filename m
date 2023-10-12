Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBC4CDB47E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 11:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19EC040996;
	Thu, 12 Oct 2023 11:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19EC040996
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55p8f0dssnMw; Thu, 12 Oct 2023 11:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A27714098B;
	Thu, 12 Oct 2023 11:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A27714098B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEC2C0071;
	Thu, 12 Oct 2023 11:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08AB4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA3C64013F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:55:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA3C64013F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5EKEH4rk7wh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:55:39 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CFB8400E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CFB8400E7
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vu-mkwQ_1697111731; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vu-mkwQ_1697111731) by smtp.aliyun-inc.com;
 Thu, 12 Oct 2023 19:55:32 +0800
Message-ID: <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Date: Thu, 12 Oct 2023 19:54:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
 <20231012052017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231012052017-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 12 Oct 2023 05:36:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> > On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > > If send queue sent some packets, we update the tx timeout
> > > > record to prevent the tx timeout.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > index 7abd46bb0e3d..e605f860edb6 100644
> > > > --- a/drivers/net/virtio/xsk.c
> > > > +++ b/drivers/net/virtio/xsk.c
> > > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > >
> > > >  	virtnet_xsk_check_queue(sq);
> > > >
> > > > +	if (stats.packets) {
> > > > +		struct netdev_queue *txq;
> > > > +		struct virtnet_info *vi;
> > > > +
> > > > +		vi = sq->vq->vdev->priv;
> > > > +
> > > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > > +		txq_trans_cond_update(txq);
> > > > +	}
> > > > +
> > > >  	u64_stats_update_begin(&sq->stats.syncp);
> > > >  	sq->stats.packets += stats.packets;
> > > >  	sq->stats.bytes += stats.bytes;
> > >
> > > I don't get what this is doing. Is there some kind of race here you
> > > are trying to address? And what introduced the race?
> >
> >
> > Because the xsk xmit shares the send queue with the kernel xmit,
> > then when I do benchmark, the xsk will always use the send queue,
> > so the kernel may have no chance to do xmit, the tx watchdog
> > thinks that the send queue is hang and prints tx timeout log.
> >
> > So I call the txq_trans_cond_update() to tell the tx watchdog
> > that the send queue is working.
> >
> > Thanks.
>
> Don't like this hack.
> So packets are stuck in queue - that's not good is it?
> Is ours the only driver that shares queues like this?

NO.

And txq_trans_cond_update() is called by many net drivers for the similar reason.

Thanks


>
> >
> > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
