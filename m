Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D22F4F0
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843199; cv=none; b=HOWjzNWlsZqCwKU0BzIhbVwu9tk37lwAtymqlHxBJa29ETNUMa8ljfc6QCJ7CUBbIyW2boqZIlyQdsbKURkfdIaeiCFxSxlZl4DF+GECfpDICiCI+iznzHGWtuPwJXZ7ItEW+V86U4hpVOEL6YUjlOMIFmc2W0I+TmpuriW41y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843199; c=relaxed/simple;
	bh=QYZqJFdgYNLavms/nUo1ysLWMYWkecHneGmYCeW0PAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tvl5bBUL04As9/M7ENaCmkDOH93Axp5F1Uiqrlwc6ztNy8Juqi/LcHhN1J7HhAzA3TX6A7hvwLPUrCCRMhZSbF82wEprFbyMI+qT/Qt7aZ8X8GvFSIXl8mOqAC1M4cijmoVKEk5GLK7ACKQdo6Y3l5DwpPzlDWFpskiZkJEmf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKpRfWkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKpRfWkg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706843195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5MXqqYcm0nwNL3MENOJLZhnS+rtBOxM/i4dVzBZQWc=;
	b=WKpRfWkgaes3heAfZjfNQ+gVxfvS9KOX2Sw9rPGXu8vbsDiuhxFmJWDiac3upMXf4OksBd
	X0CJlqmfJTl/rSf4wlX8/I6ADNi0KLllnPqayNZnUQaxI3HIVg4SWNVNyjy8lIJ6VT14+K
	6Ggw0KILmugkMaOgS3FkluoWjZr6ot4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-S-5Rj9kTPYCmdrRKOJzZfw-1; Thu, 01 Feb 2024 22:06:34 -0500
X-MC-Unique: S-5Rj9kTPYCmdrRKOJzZfw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-598fdf35732so1743928eaf.1
        for <virtualization@lists.linux.dev>; Thu, 01 Feb 2024 19:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843193; x=1707447993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5MXqqYcm0nwNL3MENOJLZhnS+rtBOxM/i4dVzBZQWc=;
        b=i0Nsn4x+LOtllxa2hhRf6t/uzYk1JYlSXnqyv3QQiSeDCShJL6bJkOIgvAW6kRkPpM
         6XFZvKkEg6tpZZlJ5SYZeK1U/xZfrVnZtXpde4AxTOfr/9n2ggd2dE7ojEDDu3XjM5eC
         Q7VoLlfoXV0o79sXyLp01hBDKNH1dmSGsMibH6O/x5+aIcmT1OzXPIKVwitVBixZCmUB
         zsd8AC+RHLIyQaBtSer+ifLuuwDZfWNaZD0QoS+Udjh4VmB19af3yrDhzawV3npr7u1R
         +pFnYpDn/ySKKpV88iXy/Hm612ge7QZOqyJ7ow7nzE2zOb62dhZhKp8C5PVaTmbXTWXv
         MUFw==
X-Gm-Message-State: AOJu0Yw/1btsWRgAkSi73ZAQmzkQMTntjNSMpMqISV/Y3M6u20GenRKu
	cBiupUhmrB9K7LWrmpkLkEFB838DDTgnhUyJqG6FwlTq0/uR3BwasrfDqoghmuAEF9D5Ccum9+H
	BdiL/11B/b4wQoWsa1GRRl2AqexxCOvWwg/wokkTKXmtYTdVKOCSG2XYIX3efQXusBdNmz8tkJO
	Mz7B4CGPQDrC8qxKpp2CjqQabGbxhW28PMXcE55E4=
X-Received: by 2002:a05:6358:7e8b:b0:178:cb3e:b74c with SMTP id o11-20020a0563587e8b00b00178cb3eb74cmr721202rwn.28.1706843193295;
        Thu, 01 Feb 2024 19:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnnf0uYApnwJ8ot71PqIV/dtLwp0t3UGDcHzLTReGmnUTng7hr5CvYF6Rt6fg0aixEyvGJkwHqZoRSyzJB6TI=
X-Received: by 2002:a05:6358:7e8b:b0:178:cb3e:b74c with SMTP id
 o11-20020a0563587e8b00b00178cb3eb74cmr721167rwn.28.1706843192958; Thu, 01 Feb
 2024 19:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-18-xuanzhuo@linux.alibaba.com> <CACGkMEv2cyuesaTx899hwZt7uDdqwmAwXJ8fZDv00W9FbVbTpw@mail.gmail.com>
 <1706757660.3554723-2-xuanzhuo@linux.alibaba.com> <CACGkMEtwWAijrLOrdgJ9ZPx5VjSfJtwVm1k1U8fsg9+tvgRHxg@mail.gmail.com>
 <1706766995.312187-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706766995.312187-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 11:06:21 +0800
Message-ID: <CACGkMEt-sveBvAGTVsqpFSAoDpdUk66oT8wtPASu7dhAb12oJw@mail.gmail.com>
Subject: Re: [PATCH vhost 17/17] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 2:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 1 Feb 2024 13:36:46 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Thu, Feb 1, 2024 at 11:28=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 31 Jan 2024 17:12:47 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 167 +++++++++++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 163 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 226ab830870e..cf0c67380b07 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
> > > > >  #define VIRTIO_XDP_REDIR       BIT(1)
> > > > >
> > > > >  #define VIRTIO_XDP_FLAG        BIT(0)
> > > > > +#define VIRTIO_DMA_FLAG        BIT(1)
> > > > >
> > > > >  /* RX packet size EWMA. The average packet size is used to deter=
mine the packet
> > > > >   * buffer size when refilling RX rings. As the entire RX ring ma=
y be refilled
> > > > > @@ -140,6 +141,21 @@ struct virtnet_rq_dma {
> > > > >         u16 need_sync;
> > > > >  };
> > > > >
> > > > > +struct virtnet_sq_dma {
> > > > > +       union {
> > > > > +               struct virtnet_sq_dma *next;
> > > > > +               void *data;
> > > > > +       };
> > > > > +       dma_addr_t addr;
> > > > > +       u32 len;
> > > > > +       bool is_tail;
> > > > > +};
> > > > > +
> > > > > +struct virtnet_sq_dma_head {
> > > > > +       struct virtnet_sq_dma *free;
> > > > > +       struct virtnet_sq_dma *head;
> > > >
> > > > Any reason the head must be a pointer instead of a simple index?
> > >
> > >
> > > The head is used for kfree.
> > > Maybe I need to rename it.
> > >
> > > About the index(next) of the virtnet_sq_dma.
> > > If we use the index, the struct will be:
> > >
> > > struct virtnet_sq_dma {
> > >        dma_addr_t addr;
> > >        u32 len;
> > >
> > >        u32 next;
> > >        void *data
> > > };
> > >
> > > The size of virtnet_sq_dma is same.
> >
> > Ok.
> >
> > >
> > >
> > > >
> > > > > +};
> > > > > +
> > > > >  /* Internal representation of a send virtqueue */
> > > > >  struct send_queue {
> > > > >         /* Virtqueue associated with this send _queue */
> > > > > @@ -159,6 +175,8 @@ struct send_queue {
> > > > >
> > > > >         /* Record whether sq is in reset state. */
> > > > >         bool reset;
> > > > > +
> > > > > +       struct virtnet_sq_dma_head dmainfo;
> > > > >  };
> > > > >
> > >
> > > ....
> > >
> > > > > +
> > > > > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> > > > > +{
> > > > > +       struct virtnet_sq_dma *d;
> > > > > +       int size, i;
> > > > > +
> > > > > +       size =3D virtqueue_get_vring_size(sq->vq);
> > > > > +
> > > > > +       size +=3D MAX_SKB_FRAGS + 2;
> > > >
> > > > Is this enough for the case where an indirect descriptor is used?
> > >
> > >
> > > This is for the case, when the ring is full, the xmit_skb is called.
> > >
> > > I will add comment.
> >
> > Just to make sure we are at the same page.
> >
> > I meant, we could have more pending #sg than allocated here.
> >
> > For example, we can have up to (vring_size - 2 - MAX_SKB_FRAGS) *
> > MAX_SKB_FRAGS number of pending sgs?
> >
>
> Oh, my was wrong.
>
> But the max value a
> But shouldn't the maximum value be vring_size * (2 + MAX_SKB_FRAGS)?

This seems to be safer, yes.

>
> And for the reason above, we should allocate (vring_size + 1) * (2 + MAX_=
SKB_FRAGS);

Then we need to benchmark to see if it has an impact on the performance.

Thanks

>
> Thanks.
>
>
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>

