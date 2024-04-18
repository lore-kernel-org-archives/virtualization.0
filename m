Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7E1E498
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429424; cv=none; b=h17iAIBVBA2s9vJPpoKPqKAHl3eysvRpzaNVJpLFi2+b6RS7mGDEXZNTxs7KyvQ+LRn8IY4QiEffE+aHlJtTKQKrwfx8SWJWkFEIiZIUM9wafMgmJBGXs8fhCKIRQGzK4Fe+ld9d7EE0gurh12rOFmJETUuOjCQTuxO9InG8jiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429424; c=relaxed/simple;
	bh=JaZGRhO3jSTyI0t7zJoh9Lky7UZ/epu6Dq/UoJrYki4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=U8GrnyyZK5nv+q5nc7u1rQxWFwwG6Ea8a9gqQfoGjzJ2UUsua8Ck8cB+qqy24GcR1mCqvWlIV5tjL+5qhqEYOnCt6LxVZuTOGKqpANJZwwhL2X8PDOrbrVrO/bNtXZIaol/zGISHNQ6+eTO7Py2iplbxrDb4qD5EQo2sVc6wUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wN6VpnSf; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wN6VpnSf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713429413; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=keuJ0LEJ+gUDtVA+E+zuXEvw7G9Es5NFBjrda7YVOto=;
	b=wN6VpnSf+L8q2PY8IhPBRKiVikPVEgV8X/gWQUSMCKZ4CmGMprSwIm9dL1p9GRqrPquCk02591uUz3gLhhl9rAstsaabBbLYFi2JJB5A5koJ8Ae9U8AUZLJ7xb1gYIlolrrYERR5v7koEClo9mseJcMSj6etg7UcvG+AS6S6gxM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4o21xo_1713429411;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4o21xo_1713429411)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 16:36:52 +0800
Message-ID: <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
Date: Thu, 18 Apr 2024 16:35:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
In-Reply-To: <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 18 Apr 2024 14:26:33 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Currently, big, merge, and small modes all support the premapped mode.
> > We can now enable premapped mode by default. Furthermore,
> > virtqueue_set_dma_premapped() must succeed when called immediately after
> > find_vqs(). Consequently, we can assume that premapped mode is always
> > enabled.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queu=
e *rq, u32 size, gfp_t gfp)
> >
> >  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  {
> > -       int i;
> > -
> > -       /* disable for big mode */
> > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > -               return;
> > +       int i, err;
> >
> >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > -                       continue;
> > +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> > +
> > +               /* never happen */
> > +               BUG_ON(err);
>
> Nit:
>
> Maybe just a BUG_ON(virtqueue_set_dma_premapped()).

OK


>
> Btw, if there's no way to disable pre mapping, maybe it's better to
> rename virtqueue_set_dma_premapped() to
> virtqueue_enable_dma_premapped(ing).

This patch will add a way to disable pre mapping.

	https://lore.kernel.org/all/20240327111430.108787-11-xuanzhuo@linux.alibab=
a.com/

Thanks.


>
> Thanks
>
> >
> >                 vi->rq[i].do_dma =3D true;
> >         }
> > --
> > 2.32.0.3.g01195cf9f
> >
>
