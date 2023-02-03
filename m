Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D3EC636D6
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 279B64031F;
	Fri,  3 Feb 2023 08:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 279B64031F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggJrpF5l7BBg; Fri,  3 Feb 2023 08:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF34940105;
	Fri,  3 Feb 2023 08:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF34940105
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F37C0032;
	Fri,  3 Feb 2023 08:51:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73ED7C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D694812F1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D694812F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDOSb7Uajib1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E78281299
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E78281299
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:51:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaoDQSb_1675414258; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaoDQSb_1675414258) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 16:50:59 +0800
Message-ID: <1675414156.9460502-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Date: Fri, 3 Feb 2023 16:49:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
 <20230202122445-mutt-send-email-mst@kernel.org>
 <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
 <20230203032945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203032945-mutt-send-email-mst@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Fri, 3 Feb 2023 03:33:41 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Feb 03, 2023 at 11:24:42AM +0800, Xuan Zhuo wrote:
> > On Thu, 2 Feb 2023 12:25:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> > > > Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> > > > we must stop tx napi from being disabled.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/main.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > index ed79e750bc6c..232cf151abff 100644
> > > > --- a/drivers/net/virtio/main.c
> > > > +++ b/drivers/net/virtio/main.c
> > > > @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
> > > >  		return ret;
> > > >
> > > >  	if (update_napi) {
> > > > -		for (i = 0; i < vi->max_queue_pairs; i++)
> > > > +		for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > +			/* xsk xmit depend on the tx napi. So if xsk is active,
> > >
> > > depends.
> > >
> > > > +			 * prevent modifications to tx napi.
> > > > +			 */
> > > > +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> > > > +				continue;
> > > > +
> > > >  			vi->sq[i].napi.weight = napi_weight;
> > >
> > > I don't get it.
> > > changing napi weight does not work then.
> > > why is this ok?
> >
> >
> > static void skb_xmit_done(struct virtqueue *vq)
> > {
> > 	struct virtnet_info *vi = vq->vdev->priv;
> > 	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> >
> > 	/* Suppress further interrupts. */
> > 	virtqueue_disable_cb(vq);
> >
> > 	if (napi->weight)
> > 		virtqueue_napi_schedule(napi, vq);
> > 	else
> > 		/* We were probably waiting for more output buffers. */
> > 		netif_wake_subqueue(vi->dev, vq2txq(vq));
> > }
> >
> >
> > If the weight is 0, tx napi will not be triggered again.
> >
> > Thanks.
>
> This needs more thought then. First ignoring what user is requesting is
> not nice.

Maybe we should return an error.

>Second what if napi is first disabled and then xsk enabled?


static int virtnet_xsk_pool_enable(struct net_device *dev,
				   struct xsk_buff_pool *pool,
				   u16 qid)
{
	struct virtnet_info *vi = netdev_priv(dev);
	struct receive_queue *rq;
	struct send_queue *sq;
	int err;

	if (qid >= vi->curr_queue_pairs)
		return -EINVAL;

	sq = &vi->sq[qid];
	rq = &vi->rq[qid];

	/* xsk zerocopy depend on the tx napi.
	 *
	 * All xsk packets are actually consumed and sent out from the xsk tx
	 * queue under the tx napi mechanism.
	 */
->	if (!sq->napi.weight)
		return -EPERM;

Thanks.


>
>
> > >
> > >
> > > > +		}
> > > >  	}
> > > >
> > > >  	return ret;
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
