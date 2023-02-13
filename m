Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B676C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:15:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF908813DC;
	Mon, 13 Feb 2023 12:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF908813DC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L24AKQoY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veFk0TcOIhaf; Mon, 13 Feb 2023 12:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA23381279;
	Mon, 13 Feb 2023 12:15:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA23381279
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96176C0032;
	Mon, 13 Feb 2023 12:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D38DDC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC26240606
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC26240606
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L24AKQoY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vquhxi21-snt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:15:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC506403EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC506403EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676290509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/3qa0NV6SAa+DWFZkquUnp2CMq9sj1EY4L6liDe1El0=;
 b=L24AKQoYMofWTO4wJKQnz7lxaURFEsfXPx/cMsw4SAYVf0k20vRmFPxJkFRKHRlZWV3vpT
 RWfB/yzIeDlOfmuyVV7oct8dv5tN+WrT+oHCEkr3zcVQPTYPipZiC0Mjmn+EysjGNUxVvY
 C5kIs6WRI6g4fJ3CcHwpq1ifdcdj7Ho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-p0s6vH9JMQSUfDOiblC07w-1; Mon, 13 Feb 2023 07:15:09 -0500
X-MC-Unique: p0s6vH9JMQSUfDOiblC07w-1
Received: by mail-wm1-f69.google.com with SMTP id
 o2-20020a05600c510200b003dc51c95c6aso3741274wms.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3qa0NV6SAa+DWFZkquUnp2CMq9sj1EY4L6liDe1El0=;
 b=vrNHDzsfVzZQFuPKa75zj6YhbnXZR9tC75vcixYCUJBL6LZOT5i+BHTZarirJTFqJR
 CAV80dK32GySZOQXpb5K0T8VThHfn+HobXuygS7ZD7aVfAHDhnOwWv4rteCQ0MdWCKpS
 8Ce2G0E3qI26bUbkFPLz6B3Ousf6qsCTmEJTmOilhF8K77OF7tTMEsN4yvfjrYHn6snv
 n0ZBXdVAcGYHXwHvybRXl+kID0aY5txgFMIGvvvOtfcz43N7K77r5hmg8YZ3Zij53m95
 VU8mp/grJLmNNSqvh8Vy7R6YXRjQKIPYR3ks6ZI4VsoVZKK0Ppaz3Ey3656l4WbePB8Q
 Tpeg==
X-Gm-Message-State: AO0yUKX7PObXQljxAdG8/5knV2tlB2o8S4ndqjNPa2ul8DKuK/u8+wTV
 rq6Xrk39YATfvp8lWgRZO/VNXN9+Jz3nqm1SzulfMKZ7GzhNnMZmCg2/3yuSCw51Wl8xZTrq0xn
 6hR/6Bn1BWn2AtYP5zx9QNgbFZDP531Fkf4l4hmAKKA==
X-Received: by 2002:a05:600c:755:b0:3e0:6c4:6a3a with SMTP id
 j21-20020a05600c075500b003e006c46a3amr18869000wmn.22.1676290507629; 
 Mon, 13 Feb 2023 04:15:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+P43vIsCcaEC0XvwsLyfTrlBYlBKdzBjIMl2f/TTw6XkbvBupTlvvrbK29o+k8EwLe9Lc8fw==
X-Received: by 2002:a05:600c:755:b0:3e0:6c4:6a3a with SMTP id
 j21-20020a05600c075500b003e006c46a3amr18868982wmn.22.1676290507441; 
 Mon, 13 Feb 2023 04:15:07 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 g16-20020a05600c4ed000b003dfee43863fsm19109128wmq.26.2023.02.13.04.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:15:06 -0800 (PST)
Date: Mon, 13 Feb 2023 07:15:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 06/33] virtio_ring: introduce virtqueue_reset()
Message-ID: <20230213071430-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-7-xuanzhuo@linux.alibaba.com>
 <20230203040041-mutt-send-email-mst@kernel.org>
 <1675415352.3250086-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675415352.3250086-8-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Feb 03, 2023 at 05:09:12PM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 04:05:38 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:31PM +0800, Xuan Zhuo wrote:
> > > Introduce virtqueue_reset() to release all buffer inside vq.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/virtio.h       |  2 ++
> > >  2 files changed, 52 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index e32046fd15a5..7dfce7001f9f 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2735,6 +2735,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >
> > > +/**
> > > + * virtqueue_reset - reset the vring of vq
> >
> > ..., detach and recycle all unused buffers
> >
> > 	after all this is why we are doing this reset, right?
> >
> > > + * @_vq: the struct virtqueue we're talking about.
> > > + * @recycle: callback for recycle the useless buffer
> >
> > not useless :) unused:
> >
> > 	callback to recycle unused buffers
> 
> 
> I agree. Will fix.
> 
> Thanks.

Probably too late for this merge cycle then. Oh well.


> >
> > I know we have the same confusion in virtqueue_resize, I will fix
> > that.
> >
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error.
> > > + * 0: success.
> > > + * -EBUSY: Failed to sync with device, vq may not work properly
> > > + * -ENOENT: Transport or device not supported
> > > + * -EPERM: Operation not permitted
> > > + */
> > > +int virtqueue_reset(struct virtqueue *_vq,
> > > +		    void (*recycle)(struct virtqueue *vq, void *buf))
> > > +{
> > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > +	struct virtio_device *vdev = vq->vq.vdev;
> > > +	void *buf;
> > > +	int err;
> > > +
> > > +	if (!vq->we_own_ring)
> > > +		return -EPERM;
> > > +
> > > +	if (!vdev->config->disable_vq_and_reset)
> > > +		return -ENOENT;
> > > +
> > > +	if (!vdev->config->enable_vq_after_reset)
> > > +		return -ENOENT;
> > > +
> > > +	err = vdev->config->disable_vq_and_reset(_vq);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> > > +		recycle(_vq, buf);
> > > +
> > > +	if (vq->packed_ring)
> > > +		virtqueue_reinit_packed(vq);
> > > +	else
> > > +		virtqueue_reinit_split(vq);
> > > +
> > > +	if (vdev->config->enable_vq_after_reset(_vq))
> > > +		return -EBUSY;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_reset);
> > > +
> > >  /* Only available for split ring */
> > >  struct virtqueue *vring_new_virtqueue(unsigned int index,
> > >  				      unsigned int num,
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index 3ebb346ebb7c..3ca2edb1aef3 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -105,6 +105,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
> > >
> > >  int virtqueue_resize(struct virtqueue *vq, u32 num,
> > >  		     void (*recycle)(struct virtqueue *vq, void *buf));
> > > +int virtqueue_reset(struct virtqueue *vq,
> > > +		    void (*recycle)(struct virtqueue *vq, void *buf));
> > >
> > >  /**
> > >   * struct virtio_device - representation of a device using virtio
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
