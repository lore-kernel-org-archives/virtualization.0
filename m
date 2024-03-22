Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1908BE4C
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084435; cv=none; b=dtQ9CiJCPow/NavolUxI665DfwWnfxSxAqLEbHZH5llCTt0UZNmJKttBrMEV8Vi3pdh8puRoLWbBwQW8SVAMEP+SxJ24rbMOeGxqYJFyeiCNFF5vdZdVkqfGya2qbpdxC8b6ciIfWKfmFgI5KZhWDatCgsmvK9coktIhNtXoO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084435; c=relaxed/simple;
	bh=BUYMklqmw7+639WJzmrIAMbYivvbfYTPpa1SYTIG0dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgF1BQglecfrWgU4aEUQ+i+/7fm085XEo2P261E+qPUj0JxOXz5qDDiD/yKv4aXEVw7KJ20ByqY71c58H03J5Byx9hRaw5vWcqD8KGIicuf9CbNmy19e0cvNynEd1U2qqFM7EAX90hNIdbl0rwzbYTAxzbUVF3ZcvRZIB1SxnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajGolDAr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajGolDAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVLbbYCxnNuf6Gw/xnXzjZXwreLI7AHf88DnXBC8tyY=;
	b=ajGolDArN9lrJH+rKLyF/vb1c9CMGcmwsZLSb/JkYlcT6dWz/4y26n9T2InhvpttJe2mhD
	gAxY6jZ5Ks2l5+wY2PqKmgmO6OGkxzaQaaXmTHAu2lcg0r/B6kJfcbckyGoCYXM3qZDez4
	CtFepizgqbz7l9vR9nM409riPMFImys=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-GocHPdWjMzyjMz5Zg0Phlw-1; Fri, 22 Mar 2024 01:13:49 -0400
X-MC-Unique: GocHPdWjMzyjMz5Zg0Phlw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29ff65bbd63so1270493a91.0
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084428; x=1711689228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVLbbYCxnNuf6Gw/xnXzjZXwreLI7AHf88DnXBC8tyY=;
        b=OfBYZLgZRe6FanpdXnbAtCffsZUS/1DHVC9HYCAQhgVtPWhrOhDAojgXvScgkHEoi9
         2ptRsh7WC5S/b1W5AWi2usU6q4o3Dx9PE1xIdaF+dxUwf9MNyPqZyo+HGicl0c0HegBl
         y70zWWuyMIXyQ+a3/vlZ9QaCVQsq+hiuGRh885aB65AtKRQpi92GouXuI4+R5Ffux0Fd
         jlKarKDdU842mxBl3wXmr0M9tTeT4U7x+5zwGKVflSHgmccW7ZOAsiEXu0SlpA5buc7h
         PXFTqEaD5lUkQkUZNYUqcsoGw8vO0/6YBGtyzx6Wu6Mx3H6pKOJYwl3TEkFOXHq3v95c
         kGng==
X-Gm-Message-State: AOJu0YzXi6KE8MXy6STx3CJKYIkRulznqbn5wUuznjk4gsqfuhEzPQu/
	VLj7p+h8zRfK16ovmNJaL/AfPGrWEjGCIfviNVHFL3VE955SrLDWMdlnpY6ZxmXsvBjAUrfJ0Yh
	rAvstrg2QtcRqs2ISlaNbKal0UrRmB7UNfN1ZP1LJvO+uNYHbDhDGgH82pbzvZyoa57LFko0O+P
	5mUQh+hyATXwrhz+4TmD2DUCiPSbwn6GyAMmZedvE=
X-Received: by 2002:a17:90a:1284:b0:29b:c17c:5fa6 with SMTP id g4-20020a17090a128400b0029bc17c5fa6mr1249114pja.33.1711084428009;
        Thu, 21 Mar 2024 22:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Eayi83t0eb1MJcsMUvJ5thFo5csIJL+WG37qUBhny1rRRa9A1HtQYegMbPSe0jgONNu33xOctIxNcksYaEI=
X-Received: by 2002:a17:90a:1284:b0:29b:c17c:5fa6 with SMTP id
 g4-20020a17090a128400b0029bc17c5fa6mr1249104pja.33.1711084427767; Thu, 21 Mar
 2024 22:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
 <20240312033557.6351-11-xuanzhuo@linux.alibaba.com> <CACGkMEuM35+jDY3kQXtKNBFJi32+hVSnqDuOc2GVqX6L2hcafw@mail.gmail.com>
 <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711009281.7778504-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:13:36 +0800
Message-ID: <CACGkMEs+x8bObJ0Fr0LbkPzWqYSoU8Y8504=bqZtjux2T5-_Vg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped
 support disable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 21 Mar 2024 14:02:14 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Tue, Mar 12, 2024 at 11:36=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Now, the API virtqueue_set_dma_premapped just support to
> > > enable premapped mode.
> > >
> > > If we allow enabling the premapped dynamically, we should
> > > make this API to support disable the premapped mode.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
> > >  include/linux/virtio.h       |  2 +-
> > >  2 files changed, 27 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 34f4b2c0c31e..3bf69cae4965 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >  /**
> > >   * virtqueue_set_dma_premapped - set the vring premapped mode
> > >   * @_vq: the struct virtqueue we're talking about.
> > > + * @premapped: enable/disable the premapped mode.
> > >   *
> > >   * Enable the premapped mode of the vq.
> > >   *
> > > @@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> > >   * 0: success.
> > >   * -EINVAL: vring does not use the dma api, so we can not enable pre=
mapped mode.
> > >   */
> > > -int virtqueue_set_dma_premapped(struct virtqueue *_vq)
> > > +int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premappe=
d)
> >
> > I think we need to document the requirement for calling this.
> >
> > Looking at the code, it seems it requires to stop the datapath and
> > detach all the used buffers?
>
>
> YES. The complete document is:
>
> /**
>  * virtqueue_set_dma_premapped - set the vring premapped mode
>  * @_vq: the struct virtqueue we're talking about.
>  *
>  * Enable the premapped mode of the vq.
>  *
>  * The vring in premapped mode does not do dma internally, so the driver =
must
>  * do dma mapping in advance. The driver must pass the dma_address throug=
h
>  * dma_address of scatterlist. When the driver got a used buffer from
>  * the vring, it has to unmap the dma address.
>  *
>  * This function must be called immediately after creating the vq, or aft=
er vq
>  * reset, and before adding any buffers to it.

I'm not sure this is a good design but we need at least some guard for
this, probably WARN for num_added or others.

Thanks

>  *
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).
>  *
>  * Returns zero or a negative error.
>  * 0: success.
>  * -EINVAL: vring does not use the dma api, so we can not enable premappe=
d mode.
>  */
>
> Thanks
>
>
> >
> > Thanks
> >
>

