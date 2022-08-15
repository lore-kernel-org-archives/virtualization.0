Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF5C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 07:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7BEA410A0;
	Mon, 15 Aug 2022 07:15:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7BEA410A0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZLUiVF/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3-bV0U4bK3f; Mon, 15 Aug 2022 07:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 53F2D409AB;
	Mon, 15 Aug 2022 07:15:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53F2D409AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 257E1C0033;
	Mon, 15 Aug 2022 07:15:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D258C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 535E040472
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:14:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 535E040472
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZLUiVF/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b64D0YIChaCv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:14:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11E0240146
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11E0240146
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660547695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uunb/SmxieTcIyt41wPcw20H+0i6av2iZEDGKTJdPks=;
 b=ZLUiVF/kHCjb2aGhYp2giiDXHVCw71D/dpP6aPSfMyRKgWQiHVOB8tGiGhy9C1ZODohdWZ
 c9qDj8VKSE8cf/Ksfz0CDefZaFFdNdfNr7+fxt7WfHr3rWmUrR7wD3qN/OAa22k/voFhCJ
 i3sSUO69bTShyNTvXn8fEGUgGH//Ing=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-AWd5OX4XMXSdJPNaDfNOjw-1; Mon, 15 Aug 2022 03:14:54 -0400
X-MC-Unique: AWd5OX4XMXSdJPNaDfNOjw-1
Received: by mail-ed1-f69.google.com with SMTP id
 w5-20020a05640234c500b0043dda025648so4248177edc.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 00:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=uunb/SmxieTcIyt41wPcw20H+0i6av2iZEDGKTJdPks=;
 b=6fDGms3Qrl3/SSZU6v8v9+KV3JtsKkzR0f9yOQZBt9zaj98BL4GvT26Yh9lVIKuzDf
 O0hFskUi7IoPucYXxwpcM3jodB6rH4JyhP1eO45WsKa0fS1YSnt73wKEYExI7p2Ql3H6
 5QcIVLStL7Qu9SLkacYIsN4YYx5n1pKPJFrt2b9JyC9t7EyAdBEYRQdwONne9TFskPN3
 PSqUly4+W7ea+hOLL9frA5kWsBhcAYOQ2Tq9q4UkhjD+iiFQACMBOWTQ9z6bdbRT0vpu
 zrUT1806nTM9zq73xSd2fV6e9ncCj7Hw61HDjeLNS/Pjnu6IzXs7Jg1VLNYj5kr34dR4
 TRLQ==
X-Gm-Message-State: ACgBeo3QzARg3VtND9Wzuu/mLd9+W5bOhcBbUmAuc1EGnR/yLMeEL+y8
 geHbmTDwcH4HTEdkbyt7GD08PyYfP9bbHgjHkfb4i63srATY1QmIIFxROMKUqyuzQieo/YslsLt
 smhPFy6DU7/tRsEnZIuFrjx1rkeLIOdx2AH1JeC5wvA==
X-Received: by 2002:a05:6402:a47:b0:43d:17a0:fdc9 with SMTP id
 bt7-20020a0564020a4700b0043d17a0fdc9mr13334574edb.41.1660547693093; 
 Mon, 15 Aug 2022 00:14:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YoHheG5W/eaV8BZh8HsvP1ibrkGNG7x2cY+yPrQSEoDviob3P1rxs8nDl9bBsoZz0emD9gQ==
X-Received: by 2002:a05:6402:a47:b0:43d:17a0:fdc9 with SMTP id
 bt7-20020a0564020a4700b0043d17a0fdc9mr13334553edb.41.1660547692848; 
 Mon, 15 Aug 2022 00:14:52 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 f1-20020a1709067f8100b007310a9a65cbsm3880906ejr.16.2022.08.15.00.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 00:14:52 -0700 (PDT)
Date: Mon, 15 Aug 2022 03:14:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 37/42] virtio_net: set the default max ring size by
 find_vqs()
Message-ID: <20220815031022-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-38-xuanzhuo@linux.alibaba.com>
 <20220815015405-mutt-send-email-mst@kernel.org>
 <1660545303.436073-9-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1660545303.436073-9-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 02:35:03PM +0800, Xuan Zhuo wrote:
> On Mon, 15 Aug 2022 02:00:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Aug 01, 2022 at 02:38:57PM +0800, Xuan Zhuo wrote:
> > > Use virtio_find_vqs_ctx_size() to specify the maximum ring size of tx,
> > > rx at the same time.
> > >
> > >                          | rx/tx ring size
> > > -------------------------------------------
> > > speed == UNKNOWN or < 10G| 1024
> > > speed < 40G              | 4096
> > > speed >= 40G             | 8192
> > >
> > > Call virtnet_update_settings() once before calling init_vqs() to update
> > > speed.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > I've been looking at this patchset because of the resent
> > reported crashes, and I'm having second thoughts about this.
> >
> > Do we really want to second-guess the device supplied
> > max ring size? If yes why?
> >
> > Could you please share some performance data that motivated this
> > specific set of numbers?
> 
> 
> The impact of this value on performance is as follows. The larger the value, the
> throughput can be increased, but the delay will also increase accordingly. It is
> a maximum limit for the ring size under the corresponding speed. The purpose of
> this limitation is not to improve performance, but more to reduce memory usage.
> 
> These data come from many other network cards and some network optimization
> experience.
> 
> For example, in the case of speed = 20G, the impact of ring size greater
> than 4096 on performance has no meaning. At this time, if the device supports
> 8192, we limit it to 4096 through this, the real meaning is to reduce the memory
> usage.
> 
> 
> >
> > Also why do we intepret UNKNOWN as "very low"?
> > I'm thinking that should definitely be "don't change anything".
> >
> 
> Generally speaking, for a network card with a high speed, it will return a
> correct speed. But I think it is a good idea to do nothing.





> 
> > Finally if all this makes sense then shouldn't we react when
> > speed changes?
> 
> This is the feedback of the network card when it is started, and theoretically
> it should not change in the future.

Yes it should:
	Both \field{speed} and \field{duplex} can change, thus the driver
	is expected to re-read these values after receiving a
	configuration change notification.


Moreover, during probe link can quite reasonably be down.
If it is, then speed and duplex might not be correct.




> >
> > Could you try reverting this and showing performance results
> > before and after please? Thanks!
> 
> I hope the above reply can help you, if there is anything else you need me to
> cooperate with, I am very happy.
> 
> If you think it's ok, I can resubmit a commit with 'UNKNOW' set to unlimited. I
> can submit it with the issue of #30.
> 
> Thanks.
> 
> 
> >
> > > ---
> > >  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 38 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 8a5810bcb839..40532ecbe7fc 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3208,6 +3208,29 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
> > >  		   (unsigned int)GOOD_PACKET_LEN);
> > >  }
> > >
> > > +static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
> > > +{
> > > +	u32 i, rx_size, tx_size;
> > > +
> > > +	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
> > > +		rx_size = 1024;
> > > +		tx_size = 1024;
> > > +
> > > +	} else if (vi->speed < SPEED_40000) {
> > > +		rx_size = 1024 * 4;
> > > +		tx_size = 1024 * 4;
> > > +
> > > +	} else {
> > > +		rx_size = 1024 * 8;
> > > +		tx_size = 1024 * 8;
> > > +	}
> > > +
> > > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +		sizes[rxq2vq(i)] = rx_size;
> > > +		sizes[txq2vq(i)] = tx_size;
> > > +	}
> > > +}
> > > +
> > >  static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  {
> > >  	vq_callback_t **callbacks;
> > > @@ -3215,6 +3238,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  	int ret = -ENOMEM;
> > >  	int i, total_vqs;
> > >  	const char **names;
> > > +	u32 *sizes;
> > >  	bool *ctx;
> > >
> > >  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> > > @@ -3242,10 +3266,15 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  		ctx = NULL;
> > >  	}
> > >
> > > +	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
> > > +	if (!sizes)
> > > +		goto err_sizes;
> > > +
> > >  	/* Parameters for control virtqueue, if any */
> > >  	if (vi->has_cvq) {
> > >  		callbacks[total_vqs - 1] = NULL;
> > >  		names[total_vqs - 1] = "control";
> > > +		sizes[total_vqs - 1] = 64;
> > >  	}
> > >
> > >  	/* Allocate/initialize parameters for send/receive virtqueues */
> > > @@ -3260,8 +3289,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >  			ctx[rxq2vq(i)] = true;
> > >  	}
> > >
> > > -	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> > > -				  names, ctx, NULL);
> > > +	virtnet_config_sizes(vi, sizes);
> > > +
> > > +	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
> > > +				       names, sizes, ctx, NULL);
> > >  	if (ret)
> > >  		goto err_find;
> > >
> > > @@ -3281,6 +3312,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >
> > >
> > >  err_find:
> > > +	kfree(sizes);
> > > +err_sizes:
> > >  	kfree(ctx);
> > >  err_ctx:
> > >  	kfree(names);
> > > @@ -3630,6 +3663,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  		vi->curr_queue_pairs = num_online_cpus();
> > >  	vi->max_queue_pairs = max_queue_pairs;
> > >
> > > +	virtnet_init_settings(dev);
> > > +	virtnet_update_settings(vi);
> > > +
> > >  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
> > >  	err = init_vqs(vi);
> > >  	if (err)
> > > @@ -3642,8 +3678,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >  	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
> > >  	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
> > >
> > > -	virtnet_init_settings(dev);
> > > -
> > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
> > >  		vi->failover = net_failover_create(vi->dev);
> > >  		if (IS_ERR(vi->failover)) {
> > > --
> > > 2.31.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
