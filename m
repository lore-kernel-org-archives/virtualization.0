Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E3BC25B0D
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 07:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53CC160F35;
	Mon, 15 Aug 2022 07:39:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53CC160F35
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=edPC3YGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9uWOwzxp0lhv; Mon, 15 Aug 2022 07:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A0B1060634;
	Mon, 15 Aug 2022 07:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0B1060634
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6541FC0033;
	Mon, 15 Aug 2022 07:39:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6255C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7649E81CA5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:39:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7649E81CA5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=edPC3YGh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POvDar_e98O7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:39:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77E6381CA0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77E6381CA0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660549176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OC2bkx9zJBueAPg8JEQmoRM5UxmTc8D+tbnHej4iLwk=;
 b=edPC3YGhxbabc8iT9D34VsVRbPv8lml054r2Ij2G+1chQf97+OvRm79qt7Fr33bLsj/M05
 m4f/EYeRmErqS2S718Y6Agf4cny2uZaWetP/VC4PJHh2UIk61X8GVUNGt+hE4YsviswIBw
 jUKhCNnRzjo8CmlC7dlUZBdxVUJlH2I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-gVcKPaXDPmeF1VAxWiENSQ-1; Mon, 15 Aug 2022 03:39:35 -0400
X-MC-Unique: gVcKPaXDPmeF1VAxWiENSQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 oz39-20020a1709077da700b007313bf43f0dso922704ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 00:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=OC2bkx9zJBueAPg8JEQmoRM5UxmTc8D+tbnHej4iLwk=;
 b=4VN/AF0Ha40pHNOF0+uqT3Uzpcn40BHBwRpRqD2nY06MmqssGhV1Tz6vHLxKq9Khyq
 7yIGEXtBxw7kaP7RuOcIyBWKO8wKyyjQs7lxbRIapLSl4taqiKTyD6UxrTdvKhUsw0bC
 65mXXazDGyyrl3iIa0j6otCxmf2jlYoD2xhMD0xzHHIisIPS79OczToNl37vxKT8SisT
 K5PC3H+3HlMZzZNYPdvwXpGqb3EF1zgneHqSG6pIechWgPpjYtOyFw5wu2ARKlpeWsnR
 wMMLFxAwiNMowywBvojaIiMl326XKdAvYlKNsGjFwHaxJv/i0qZ3GLt3QZvFVageZVsH
 ElFA==
X-Gm-Message-State: ACgBeo02txC0Mo0cw9dNjyFM2L7Tl+syHl4r/+DipQHPh5vfUQQq0TVM
 EsDGDX6wfMTXjQTMgCs72NNodCBjbe3eZvFMW0+U7K+L0kHmrD9OgpjxahXx/0xyRKDc9OCkZ5G
 DVEqHAA2glV6v29BcrQs7Xh4hAyGfFl+WeBx6t+BcvA==
X-Received: by 2002:a17:907:1608:b0:730:5ad0:ae1a with SMTP id
 hb8-20020a170907160800b007305ad0ae1amr9813505ejc.222.1660549174271; 
 Mon, 15 Aug 2022 00:39:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dF4uCArlexvqL8XPZdPtg7Gr2bGirXXunwpdi3Wu1c4gmQV30+uieFh6F/qWMw4uVYBdewg==
X-Received: by 2002:a17:907:1608:b0:730:5ad0:ae1a with SMTP id
 hb8-20020a170907160800b007305ad0ae1amr9813461ejc.222.1660549173946; 
 Mon, 15 Aug 2022 00:39:33 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 f25-20020a50fc99000000b004424429afd4sm6151850edq.16.2022.08.15.00.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 00:39:33 -0700 (PDT)
Date: Mon, 15 Aug 2022 03:39:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 37/42] virtio_net: set the default max ring size by
 find_vqs()
Message-ID: <20220815033849-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-38-xuanzhuo@linux.alibaba.com>
 <20220815015405-mutt-send-email-mst@kernel.org>
 <1660545303.436073-9-xuanzhuo@linux.alibaba.com>
 <20220815031022-mutt-send-email-mst@kernel.org>
 <1660548498.412278-11-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1660548498.412278-11-xuanzhuo@linux.alibaba.com>
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

On Mon, Aug 15, 2022 at 03:28:18PM +0800, Xuan Zhuo wrote:
> On Mon, 15 Aug 2022 03:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Aug 15, 2022 at 02:35:03PM +0800, Xuan Zhuo wrote:
> > > On Mon, 15 Aug 2022 02:00:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Aug 01, 2022 at 02:38:57PM +0800, Xuan Zhuo wrote:
> > > > > Use virtio_find_vqs_ctx_size() to specify the maximum ring size of tx,
> > > > > rx at the same time.
> > > > >
> > > > >                          | rx/tx ring size
> > > > > -------------------------------------------
> > > > > speed == UNKNOWN or < 10G| 1024
> > > > > speed < 40G              | 4096
> > > > > speed >= 40G             | 8192
> > > > >
> > > > > Call virtnet_update_settings() once before calling init_vqs() to update
> > > > > speed.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > I've been looking at this patchset because of the resent
> > > > reported crashes, and I'm having second thoughts about this.
> > > >
> > > > Do we really want to second-guess the device supplied
> > > > max ring size? If yes why?
> > > >
> > > > Could you please share some performance data that motivated this
> > > > specific set of numbers?
> > >
> > >
> > > The impact of this value on performance is as follows. The larger the value, the
> > > throughput can be increased, but the delay will also increase accordingly. It is
> > > a maximum limit for the ring size under the corresponding speed. The purpose of
> > > this limitation is not to improve performance, but more to reduce memory usage.
> > >
> > > These data come from many other network cards and some network optimization
> > > experience.
> > >
> > > For example, in the case of speed = 20G, the impact of ring size greater
> > > than 4096 on performance has no meaning. At this time, if the device supports
> > > 8192, we limit it to 4096 through this, the real meaning is to reduce the memory
> > > usage.
> > >
> > >
> > > >
> > > > Also why do we intepret UNKNOWN as "very low"?
> > > > I'm thinking that should definitely be "don't change anything".
> > > >
> > >
> > > Generally speaking, for a network card with a high speed, it will return a
> > > correct speed. But I think it is a good idea to do nothing.
> >
> >
> >
> >
> >
> > >
> > > > Finally if all this makes sense then shouldn't we react when
> > > > speed changes?
> > >
> > > This is the feedback of the network card when it is started, and theoretically
> > > it should not change in the future.
> >
> > Yes it should:
> > 	Both \field{speed} and \field{duplex} can change, thus the driver
> > 	is expected to re-read these values after receiving a
> > 	configuration change notification.
> >
> >
> > Moreover, during probe link can quite reasonably be down.
> > If it is, then speed and duplex might not be correct.
> >
> 
> 
> It seems that this is indeed a problem.
> 
> But I feel that this is not the reason for the abnormal network.

Yes, but it's a reason to revert this patch and rethink the approach.

> I'm still trying google cloud vm.
> 
> 
> >
> >
> >
> > > >
> > > > Could you try reverting this and showing performance results
> > > > before and after please? Thanks!
> > >
> > > I hope the above reply can help you, if there is anything else you need me to
> > > cooperate with, I am very happy.
> > >
> > > If you think it's ok, I can resubmit a commit with 'UNKNOW' set to unlimited. I
> > > can submit it with the issue of #30.
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 38 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 8a5810bcb839..40532ecbe7fc 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3208,6 +3208,29 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
> > > > >  		   (unsigned int)GOOD_PACKET_LEN);
> > > > >  }
> > > > >
> > > > > +static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
> > > > > +{
> > > > > +	u32 i, rx_size, tx_size;
> > > > > +
> > > > > +	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
> > > > > +		rx_size = 1024;
> > > > > +		tx_size = 1024;
> > > > > +
> > > > > +	} else if (vi->speed < SPEED_40000) {
> > > > > +		rx_size = 1024 * 4;
> > > > > +		tx_size = 1024 * 4;
> > > > > +
> > > > > +	} else {
> > > > > +		rx_size = 1024 * 8;
> > > > > +		tx_size = 1024 * 8;
> > > > > +	}
> > > > > +
> > > > > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > +		sizes[rxq2vq(i)] = rx_size;
> > > > > +		sizes[txq2vq(i)] = tx_size;
> > > > > +	}
> > > > > +}
> > > > > +
> > > > >  static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  {
> > > > >  	vq_callback_t **callbacks;
> > > > > @@ -3215,6 +3238,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  	int ret = -ENOMEM;
> > > > >  	int i, total_vqs;
> > > > >  	const char **names;
> > > > > +	u32 *sizes;
> > > > >  	bool *ctx;
> > > > >
> > > > >  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> > > > > @@ -3242,10 +3266,15 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  		ctx = NULL;
> > > > >  	}
> > > > >
> > > > > +	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
> > > > > +	if (!sizes)
> > > > > +		goto err_sizes;
> > > > > +
> > > > >  	/* Parameters for control virtqueue, if any */
> > > > >  	if (vi->has_cvq) {
> > > > >  		callbacks[total_vqs - 1] = NULL;
> > > > >  		names[total_vqs - 1] = "control";
> > > > > +		sizes[total_vqs - 1] = 64;
> > > > >  	}
> > > > >
> > > > >  	/* Allocate/initialize parameters for send/receive virtqueues */
> > > > > @@ -3260,8 +3289,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >  			ctx[rxq2vq(i)] = true;
> > > > >  	}
> > > > >
> > > > > -	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> > > > > -				  names, ctx, NULL);
> > > > > +	virtnet_config_sizes(vi, sizes);
> > > > > +
> > > > > +	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
> > > > > +				       names, sizes, ctx, NULL);
> > > > >  	if (ret)
> > > > >  		goto err_find;
> > > > >
> > > > > @@ -3281,6 +3312,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >
> > > > >
> > > > >  err_find:
> > > > > +	kfree(sizes);
> > > > > +err_sizes:
> > > > >  	kfree(ctx);
> > > > >  err_ctx:
> > > > >  	kfree(names);
> > > > > @@ -3630,6 +3663,9 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  		vi->curr_queue_pairs = num_online_cpus();
> > > > >  	vi->max_queue_pairs = max_queue_pairs;
> > > > >
> > > > > +	virtnet_init_settings(dev);
> > > > > +	virtnet_update_settings(vi);
> > > > > +
> > > > >  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
> > > > >  	err = init_vqs(vi);
> > > > >  	if (err)
> > > > > @@ -3642,8 +3678,6 @@ static int virtnet_probe(struct virtio_device *vdev)
> > > > >  	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
> > > > >  	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
> > > > >
> > > > > -	virtnet_init_settings(dev);
> > > > > -
> > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
> > > > >  		vi->failover = net_failover_create(vi->dev);
> > > > >  		if (IS_ERR(vi->failover)) {
> > > > > --
> > > > > 2.31.0
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
