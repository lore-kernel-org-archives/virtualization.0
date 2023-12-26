Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853EC4CB50
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOT+L5/6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3054607B4
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 08:57:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3054607B4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aOT+L5/6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hl3Y4X0O6a-F
	for <virtualization@lists.linux-foundation.org>;
	Tue, 26 Dec 2023 08:57:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 78D2E605B0
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 08:57:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78D2E605B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703581055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=24XS44KH1TKEvl+JshWRkmqESAgi5sOeBZwfUoyM0ZI=;
	b=aOT+L5/6SmJDuLYo7dhSTSv8YkqFQxnjqfOULkuBag52y0tzVoNfdTGbKLqUo9o01+rZG4
	xZS6xu65UgiJJltqqfXe1i6xMDwvKdFpOVv/MvcN/Th7MWLEXGToCcLeZXmeSMXhIIqIOZ
	DcBEQvy6K2tpYDHHAfd2jdvr+YfCtAw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-ALV3_PViM4WJ6cgxLjaODw-1; Tue, 26 Dec 2023 03:57:33 -0500
X-MC-Unique: ALV3_PViM4WJ6cgxLjaODw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-336974655ddso1528587f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 00:57:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581052; x=1704185852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24XS44KH1TKEvl+JshWRkmqESAgi5sOeBZwfUoyM0ZI=;
        b=uKOhaZJ6OcMF5IN8Alr8G77B37tbzjn3lAOh502OWpi/eZFW+ATNxcW9v4mbgIhBiw
         H1WqGuaQEmPykRxu+BKGUD3V7M092JXcVrh8CVZsqCR2x08z8NoyJIwg7IqB8+2zchxm
         tEGmyj0oO6oB3Psiux/djMtxSmLSQ/QkcC/oCxzEDoqszTIpAPzrJQ7EFrNA0s6FIoXO
         0L40VVhTlAHA8MjnxLLTVlAQxwRF8yNdW64HR6/LdVi2EmkG2puj3BZjnW+M7jnc1eGO
         wvxwpCIbYG/krIPmq3LBCXYAf9bzVbrRT0pbG0/RgobgdyfcRWaiNS+gCjsMLq9ekhk7
         Khdw==
X-Gm-Message-State: AOJu0YyGyv5QiFiGOXEfM4fLG+pOitT5MVyncdfgH9Mth/qUcCR8L7pn
	ikBPYFrPHZChPFBglNomZLNGZ0qlYUFeIF4Uw4tHHk1pGl9dWm59bVd8QN5g/OnS21p4NgMnWOL
	PX7SG0Ii9deOYoHxlwttAiMjhqot2J+Ui7GUUqtHvogZc0N0Kow==
X-Received: by 2002:a05:600c:2eca:b0:40d:581c:f769 with SMTP id q10-20020a05600c2eca00b0040d581cf769mr689234wmn.104.1703581051932;
        Tue, 26 Dec 2023 00:57:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiWdJKwHTsUIU/XjEB4gMCnQU0wwCKTTK8HfjzQXDBr+ojrXKoR/fTYZv47nhqMaz/U2kavQ==
X-Received: by 2002:a05:600c:2eca:b0:40d:581c:f769 with SMTP id q10-20020a05600c2eca00b0040d581cf769mr689230wmn.104.1703581051587;
        Tue, 26 Dec 2023 00:57:31 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b0033629538fa2sm12014001wrx.18.2023.12.26.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 00:57:30 -0800 (PST)
Date: Tue, 26 Dec 2023 03:57:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1] virtio_net: fix missing dma unmap for resize
Message-ID: <20231226035336-mutt-send-email-mst@kernel.org>
References: <20231212081141.39757-1-xuanzhuo@linux.alibaba.com>
 <20231212032514-mutt-send-email-mst@kernel.org>
 <1703570229.7040236-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1703570229.7040236-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 26, 2023 at 01:57:09PM +0800, Xuan Zhuo wrote:
> On Tue, 12 Dec 2023 03:26:41 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Dec 12, 2023 at 04:11:41PM +0800, Xuan Zhuo wrote:
> > > For rq, we have three cases getting buffers from virtio core:
> > >
> > > 1. virtqueue_get_buf{,_ctx}
> > > 2. virtqueue_detach_unused_buf
> > > 3. callback for virtqueue_resize
> > >
> > > But in commit 295525e29a5b("virtio_net: merge dma operations when
> > > filling mergeable buffers"), I missed the dma unmap for the #3 case.
> > >
> > > That will leak some memory, because I did not release the pages referred
> > > by the unused buffers.
> > >
> > > If we do such script, we will make the system OOM.
> > >
> > >     while true
> > >     do
> > >             ethtool -G ens4 rx 128
> > >             ethtool -G ens4 rx 256
> > >             free -m
> > >     done
> > >
> > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >
> > > v1: rename to virtnet_rq_free_buf_check_dma()
> >
> > The fact that we check does not matter what matters is
> > that we unmap. I'd change the name to reflect that.
> 
> 
> Hi Michael:
> 
> I see one "[GIT PULL] virtio: bugfixes". But this is not in the list.
> 
> So I hope this is your list.
> 
> Thanks.

No - I'm still waiting for the comment to be addressed. sorry about
the back and forth. It does unmap then free. So maybe virtnet_rq_unmap_free_buf?


> 
> >
> >
> > >
> > >  drivers/net/virtio_net.c | 60 ++++++++++++++++++++--------------------
> > >  1 file changed, 30 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index d16f592c2061..58ebbffeb952 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -334,7 +334,6 @@ struct virtio_net_common_hdr {
> > >  	};
> > >  };
> > >
> > > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > >
> > >  static bool is_xdp_frame(void *ptr)
> > > @@ -408,6 +407,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > >  	return p;
> > >  }
> > >
> > > +static void virtnet_rq_free_buf(struct virtnet_info *vi,
> > > +				struct receive_queue *rq, void *buf)
> > > +{
> > > +	if (vi->mergeable_rx_bufs)
> > > +		put_page(virt_to_head_page(buf));
> > > +	else if (vi->big_packets)
> > > +		give_pages(rq, buf);
> > > +	else
> > > +		put_page(virt_to_head_page(buf));
> > > +}
> > > +
> > >  static void enable_delayed_refill(struct virtnet_info *vi)
> > >  {
> > >  	spin_lock_bh(&vi->refill_lock);
> > > @@ -634,17 +644,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> > >  	return buf;
> > >  }
> > >
> > > -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> > > -{
> > > -	void *buf;
> > > -
> > > -	buf = virtqueue_detach_unused_buf(rq->vq);
> > > -	if (buf && rq->do_dma)
> > > -		virtnet_rq_unmap(rq, buf, 0);
> > > -
> > > -	return buf;
> > > -}
> > > -
> > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> > >  {
> > >  	struct virtnet_rq_dma *dma;
> > > @@ -744,6 +743,20 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > >  	}
> > >  }
> > >
> > > +static void virtnet_rq_free_buf_check_dma(struct virtqueue *vq, void *buf)
> > > +{
> > > +	struct virtnet_info *vi = vq->vdev->priv;
> > > +	struct receive_queue *rq;
> > > +	int i = vq2rxq(vq);
> > > +
> > > +	rq = &vi->rq[i];
> > > +
> > > +	if (rq->do_dma)
> > > +		virtnet_rq_unmap(rq, buf, 0);
> > > +
> > > +	virtnet_rq_free_buf(vi, rq, buf);
> > > +}
> > > +
> > >  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> > >  {
> > >  	unsigned int len;
> > > @@ -1764,7 +1777,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > >  		DEV_STATS_INC(dev, rx_length_errors);
> > > -		virtnet_rq_free_unused_buf(rq->vq, buf);
> > > +		virtnet_rq_free_buf(vi, rq, buf);
> > >  		return;
> > >  	}
> > >
> > > @@ -2392,7 +2405,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
> > >  	if (running)
> > >  		napi_disable(&rq->napi);
> > >
> > > -	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
> > > +	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_buf_check_dma);
> > >  	if (err)
> > >  		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
> > >
> > > @@ -4031,19 +4044,6 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> > >  		xdp_return_frame(ptr_to_xdp(buf));
> > >  }
> > >
> > > -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> > > -{
> > > -	struct virtnet_info *vi = vq->vdev->priv;
> > > -	int i = vq2rxq(vq);
> > > -
> > > -	if (vi->mergeable_rx_bufs)
> > > -		put_page(virt_to_head_page(buf));
> > > -	else if (vi->big_packets)
> > > -		give_pages(&vi->rq[i], buf);
> > > -	else
> > > -		put_page(virt_to_head_page(buf));
> > > -}
> > > -
> > >  static void free_unused_bufs(struct virtnet_info *vi)
> > >  {
> > >  	void *buf;
> > > @@ -4057,10 +4057,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > >  	}
> > >
> > >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> > > -		struct receive_queue *rq = &vi->rq[i];
> > > +		struct virtqueue *vq = vi->rq[i].vq;
> > >
> > > -		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> > > -			virtnet_rq_free_unused_buf(rq->vq, buf);
> > > +		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > +			virtnet_rq_free_buf_check_dma(vq, buf);
> > >  		cond_resched();
> > >  	}
> > >  }
> > > --
> > > 2.32.0.3.g01195cf9f
> >

