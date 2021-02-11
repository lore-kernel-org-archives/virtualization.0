Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B268C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 11:00:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F3764EB9
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 11:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F3764EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9131687565;
	Thu, 11 Feb 2021 11:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sz8k+YaE2Xjw; Thu, 11 Feb 2021 11:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0D7E87509;
	Thu, 11 Feb 2021 11:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3CCEC0891;
	Thu, 11 Feb 2021 11:00:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBD4FC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A9DA187565
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bovv1i6DMOPh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E58D087509
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613041225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQ1CyJDpkuauU8h1mtytMENhHHlIG0UXjEznsE8xviI=;
 b=Uqi4mSGCswJEOD1o+95r567sb7h9reyLgTZBWFPviySaTbBsMdhisAUj8a/FgNvhoavSPG
 d7Ljn3N3lVUWiWKMI4KRrL23OOENGUmoCRotfKcebJbaNd6jAEJpRlw6JoYs5RNrsF/8NN
 krETvsdzGYEORyvRvswOW4DPqz920rA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-gHnI95s5M4iCne7udxMfnA-1; Thu, 11 Feb 2021 06:00:20 -0500
X-MC-Unique: gHnI95s5M4iCne7udxMfnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6CD286A060;
 Thu, 11 Feb 2021 11:00:18 +0000 (UTC)
Received: from carbon (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75E5B62953;
 Thu, 11 Feb 2021 11:00:06 +0000 (UTC)
Date: Thu, 11 Feb 2021 12:00:05 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH netdev] virtio-net: support XDP_TX when not more queues
Message-ID: <20210211120005.04af2c0f@carbon>
In-Reply-To: <20210210163945-mutt-send-email-mst@kernel.org>
References: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
 <20210210163945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Marek Majtyka <alardam@gmail.com>,
 dust.li@linux.alibaba.com, brouer@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Wed, 10 Feb 2021 16:40:41 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jan 13, 2021 at 04:08:57PM +0800, Xuan Zhuo wrote:
> > The number of queues implemented by many virtio backends is limited,
> > especially some machines have a large number of CPUs. In this case, it
> > is often impossible to allocate a separate queue for XDP_TX.
> > 
> > This patch allows XDP_TX to run by reuse the existing SQ with
> > __netif_tx_lock() hold when there are not enough queues.

I'm a little puzzled about the choice of using the netdevice TXQ
lock __netif_tx_lock() / __netif_tx_unlock().
Can you explain more about this choice?

> > 
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>  
> 
> I'd like to get some advice on whether this is ok from some
> XDP experts - previously my understanding was that it is
> preferable to disable XDP for such devices than
> use locks on XDP fast path.

I think it is acceptable, because the ndo_xdp_xmit / virtnet_xdp_xmit
takes a bulk of packets (currently 16).

Some drivers already does this.

It would have been nice if we could set a feature flag, that allow
users to see that this driver uses locking in the XDP transmit
(ndo_xdp_xmit) function call... but it seems like a pipe dream :-P

Code related to the locking

> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index ba8e637..7a3b2a7 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
[...]
> > @@ -481,14 +484,34 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
> >  	return 0;
> >  }
> >  
> > -static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
> > +static struct send_queue *virtnet_get_xdp_sq(struct virtnet_info *vi)
> >  {
> >  	unsigned int qp;
> > +	struct netdev_queue *txq;
> > +
> > +	if (vi->curr_queue_pairs > nr_cpu_ids) {
> > +		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
> > +	} else {
> > +		qp = smp_processor_id() % vi->curr_queue_pairs;
> > +		txq = netdev_get_tx_queue(vi->dev, qp);
> > +		__netif_tx_lock(txq, raw_smp_processor_id());
> > +	}
> >  
> > -	qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
> >  	return &vi->sq[qp];
> >  }
> >  
> > +static void virtnet_put_xdp_sq(struct virtnet_info *vi)
> > +{
> > +	unsigned int qp;
> > +	struct netdev_queue *txq;
> > +
> > +	if (vi->curr_queue_pairs <= nr_cpu_ids) {
> > +		qp = smp_processor_id() % vi->curr_queue_pairs;
> > +		txq = netdev_get_tx_queue(vi->dev, qp);
> > +		__netif_tx_unlock(txq);
> > +	}
> > +}
> > +
> >  static int virtnet_xdp_xmit(struct net_device *dev,
> >  			    int n, struct xdp_frame **frames, u32 flags)
> >  {
> > @@ -512,7 +535,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >  	if (!xdp_prog)
> >  		return -ENXIO;
> >  
> > -	sq = virtnet_xdp_sq(vi);
> > +	sq = virtnet_get_xdp_sq(vi);
> >  
> >  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
> >  		ret = -EINVAL;
> > @@ -560,12 +583,13 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >  	sq->stats.kicks += kicks;
> >  	u64_stats_update_end(&sq->stats.syncp);
> >  
> > +	virtnet_put_xdp_sq(vi);
> >  	return ret;
> >  }
> >  



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
