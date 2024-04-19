Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C563E
	for <virtualization@lists.linux.dev>; Fri, 19 Apr 2024 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487469; cv=none; b=pVcaAeGEUYzEMoHwoaw3KxHMSKsBhs+968UUMWBENMATQsNv8wUIfskpf8VIAc/gJMO5yaRL61mb1U0crJ1rdS+8sRVQwq/TgH5jH4R+WzNNaJWyU4eOgkqE+piZvpFE+Wuyuf+K8CzROjd1sdAYx8TUpKqj6bLOgPY4FjmjUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487469; c=relaxed/simple;
	bh=pBiz3LVrMCFjBKto+yUf+AajEVPLZZ2Msd8t8QjcNs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apVpzDv1EAnvZltjCxZPC99XDsIfKDuzo8ntj/LRlpt0MXXG+8VbZo4ngKBooMFMM+pnwlI5zC2MwY+TZ/Go/blGgxa7uavUl1Y1Y0r4wEPSnO/HKlrRUqDUBXHjCGYKDGv9LA4HmU1S3+DchPYqx9v3PzARbnZGLjymnvtcRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQhTdkPI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQhTdkPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/tzjilb7VmJ2J6//QDT/ySUeP2NChxSQTHnTBR1E3bs=;
	b=SQhTdkPIvxPaUvFdEMhisj8oiiOxkSHmwPdYIDav/nZ5BvDUgJvDwaefBEphquhSPYq77d
	TFgccA0p+ffLQbvBPmCtMXTd3jTGpvgN4wHFDE3uJYr+LB+lfZPJtg99pmuY/0UoBAwWlk
	KRGXFCepdqgfuTvPFJnQKUEPCdFOxGA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-5nQbLwN8MH6i2NsXC-IlHg-1; Thu, 18 Apr 2024 20:44:25 -0400
X-MC-Unique: 5nQbLwN8MH6i2NsXC-IlHg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so1763586a12.0
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 17:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487464; x=1714092264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tzjilb7VmJ2J6//QDT/ySUeP2NChxSQTHnTBR1E3bs=;
        b=YcnyJ4R9BEEIPNjAvnWw/QgQS5hsTsFRQFbAMOGITmD62KWmZ3mwCoEBCLazbgKZ5g
         myiWu4dn+8tqo8zD9M8Wtq+bXO0Q80o9yhbiY+zZDbVKv1L/IHk61dmQBAtLC6BjOzEm
         oGuwL2KhEEH6AZxNn+zNCBZzzJOapRh+Sj9CCfC/unovgEp1C/TDkJnhgRCfzYKA74i5
         igvVvVbJ/VEMAHmxYhstKZXchC1oYjt5mL9mLTm7XRVxGX0unmSPpaIKm35na09DadmK
         uXuH1cPGgpMu10Fam+OIOew06mg3BYLzzAdtwy8WTWWfXgvWmM7/VaUw8AOlfLYCNQEF
         hplQ==
X-Gm-Message-State: AOJu0YxqVkFjWPYZ3nUgStQd/Jz8jCq04FBFVYKfMspkIX5cgomVQZ6c
	4wTsD4FuCECK8PFkg7XTKDhlg8miubKE5I99tik4DnUDU8MyqKOHJwJctB4aDdp4P63oh3PVvAk
	RhAM7x2AoNnO5XDFo+iG78SWQIOkbG1jv4EEzpF3S3+e+2rZpOl+7OLY7l553Ilmu0Wgvcm3glT
	OEFekOLMNOtt5cG1F7Dh/efuUF1dqUV9W3KvyY4+g=
X-Received: by 2002:a05:6a21:78a5:b0:1a7:a86a:113a with SMTP id bf37-20020a056a2178a500b001a7a86a113amr1060828pzc.6.1713487464338;
        Thu, 18 Apr 2024 17:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuTRpNGCcKmmfOeg3USih+ZL1ti6HCLk1+MRQFl8qLGI3Kl4ALCmPKX/FDo+WZT4sblejqbzvED/WE8/LIYXQ=
X-Received: by 2002:a05:6a21:78a5:b0:1a7:a86a:113a with SMTP id
 bf37-20020a056a2178a500b001a7a86a113amr1060814pzc.6.1713487464043; Thu, 18
 Apr 2024 17:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-6-xuanzhuo@linux.alibaba.com> <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
 <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713429342.96617-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:44:12 +0800
Message-ID: <CACGkMEtZQ6FRqqzjo3Yc_uxw2uopf4+30G-33y3oi-ruHtUTUg@mail.gmail.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 18 Apr 2024 14:26:33 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Currently, big, merge, and small modes all support the premapped mode=
.
> > > We can now enable premapped mode by default. Furthermore,
> > > virtqueue_set_dma_premapped() must succeed when called immediately af=
ter
> > > find_vqs(). Consequently, we can assume that premapped mode is always
> > > enabled.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_qu=
eue *rq, u32 size, gfp_t gfp)
> > >
> > >  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > >  {
> > > -       int i;
> > > -
> > > -       /* disable for big mode */
> > > -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> > > -               return;
> > > +       int i, err;
> > >
> > >         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > > -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > > -                       continue;
> > > +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> > > +
> > > +               /* never happen */
> > > +               BUG_ON(err);
> >
> > Nit:
> >
> > Maybe just a BUG_ON(virtqueue_set_dma_premapped()).
>
> OK
>
>
> >
> > Btw, if there's no way to disable pre mapping, maybe it's better to
> > rename virtqueue_set_dma_premapped() to
> > virtqueue_enable_dma_premapped(ing).
>
> This patch will add a way to disable pre mapping.
>
>         https://lore.kernel.org/all/20240327111430.108787-11-xuanzhuo@lin=
ux.alibaba.com/
>
> Thanks.

Ok, fine.

Thanks

>
>
> >
> > Thanks
> >
> > >
> > >                 vi->rq[i].do_dma =3D true;
> > >         }
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

