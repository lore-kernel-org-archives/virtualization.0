Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A625C838
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 07:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992625; cv=none; b=mXMqd2sHOblwiWCUwh28pCdC2HvctUPGaowAAXxE7i7Y2rGRfGtLlYuqecJfsWkcf3Pa8elTqHEcJP4QDsHuffw9TxYDScJxlBbMAs4+n/ukKcO9GgxDqKpyyrH6J33ppV98re9mmmgFjEoEefS+S944lJPjs0FAdnxj9gbEN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992625; c=relaxed/simple;
	bh=CBdMLctKkPnkvIbH4iQKcFZmys4OsCRcgi5oLUqKzgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcZZzqWOJAYTJhfagNLgz+d8TDuOMiGoXJ0YSBx26afeFeFOPmTqkjoDorid1vp/5MAs2NM9RzNTWSQ5+Jf9d46aPk0zrv4X4W4TNcnfdkUlw7I9ZekuNDaijNBFa5QAMDcx/l5RtnUcRH8kwlV2V9Hsf0Rpj8OhNSXSTun2t8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uz1DT3S6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz1DT3S6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766992622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RrlOdfOMom74lA6CP2bqLRY5Ue3VS7dZVf8azBkW94=;
	b=Uz1DT3S61Nr6rxFaJteXgXP7WKbW36TdQMtAgTLplcRGJEjRpmcLoM9NnbCviAvOdLpNQg
	85jhVSRD12FnZ/M+maHhIDaCa711mQmqy7KgSJZuTRv6wIDLJss/5bD8laVxxJ+/6P1Dox
	hvW5XF+uqPtSfkwzItWALhAUvgxe33g=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-kWd-yy0iPC27RLZFfFNUOg-1; Mon, 29 Dec 2025 02:17:00 -0500
X-MC-Unique: kWd-yy0iPC27RLZFfFNUOg-1
X-Mimecast-MFC-AGG-ID: kWd-yy0iPC27RLZFfFNUOg_1766992619
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0dabc192eso209042925ad.0
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 23:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766992619; x=1767597419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RrlOdfOMom74lA6CP2bqLRY5Ue3VS7dZVf8azBkW94=;
        b=GVcfQpsoEDQ83+5EfEx64jAELyNUzmtRkj4dovx7zihOQnKhf2oVk1dA9e+yJHBocu
         fvDg+xFgwLEyykTlmrVASZX6Lgod2aNq56sSNUpgH5Yg0mHPyvv6rf+VIzIL2JwBD/sd
         0ByMmtfZTOIxyGCnYOgDTG2ARxoScn9TZ3Py8csQ3ZWX5Xu1UiK6NfaTKwCsg70YEwSp
         I1ql0mS0oT6aHCXT99dbnk6GMLhvVpDk1sqH38onTLj6HAy92U9eXKIMDDuNCSDSXDZt
         16+nFl0OsngMSpZVFWDN18MamrE7iUB4f9crekQ6QKWIvkZrzfKL/qyJ4wYapoHLe48g
         MDCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTV+WixjKQsoj+LW3jiau9dhJxNrIQAwWK/ZacPfWCmD18rgq9f6w4TKtujpCjKLIgvUdGwTP6EypbCHAm6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlHUtkPqKmD7/4Pnpfgi6TTszA2tKQJd/sjcj7HH0oQE9vs9xz
	Vr5gS1t0SNJOdgdrzLDYoj/wX6wMtBNuO83+V81Hhh7JWfaP6TWTGR8nFBUpnvqH20InwtSKH2V
	2ghe2gD7tsHuONULC3kA0v9hxjw5X0r/pqPcZaxz0u3XnxVZHqpzuKzCTUsi7tdB4E2bTpT0Owt
	l2qFp+lPlo9XNheMwZzTSLCMIxB9edOgRpobGqagYSXAE=
X-Gm-Gg: AY/fxX68U4a1p/4RiYhng/3Ghmt5NDulyX19dIRB88Da3c3zSqbOqnhtEy90lbwQ1Pw
	Rb62ZgwBGhf2165zJroV5T7MKACueUCPa7UVNBn/LHmLg8hLpXYCGafCK7jN5PfOeyafkdVaYN9
	u/8GLDEa5z+YnnumPZIOVQ5mkntN2ylE/uuSmM10sahlzucZHTvmWLclrB5qH+88044Qg=
X-Received: by 2002:a17:902:e785:b0:2a1:47e:1a34 with SMTP id d9443c01a7336-2a2f1f6a1c4mr301537145ad.0.1766992619041;
        Sun, 28 Dec 2025 23:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOrpj1dXc4ZT9HRkC4eB9b7Xt3wJfG5ziBqzEJ1Np469xmmgf0FM4dcNjmC9oNJV80jSjNZifjUP8MS8BI8A=
X-Received: by 2002:a17:902:e785:b0:2a1:47e:1a34 with SMTP id
 d9443c01a7336-2a2f1f6a1c4mr301536925ad.0.1766992618527; Sun, 28 Dec 2025
 23:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251225042608.32350-1-jasowang@redhat.com> <20251225042608.32350-15-jasowang@redhat.com>
 <20251226143309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251226143309-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Dec 2025 15:16:47 +0800
X-Gm-Features: AQt7F2pHTFRKagO6bu00M-pBUjvQP700ACXmxc5FZruiVh2EygIX8NQG2VDZqTw
Message-ID: <CACGkMEupNSQAaH6y6mcZV2BwdYh2fpCzb_JQXn+7CWOo0z8SmA@mail.gmail.com>
Subject: Re: [PATCH V11 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ll9m46ca8d2YVkeiKqyB9WzGfKgEt3LkP4zVU9dyxf4_1766992619
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 3:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Dec 25, 2025 at 12:26:03PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 4e905dc7b6cb..dbcd6f26df7d 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, avail, descs_used, err_idx, sg_count =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -635,42 +635,40 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                       dma_addr_t addr;
> >                       u32 len;
> > +                     u16 flags =3D 0;
> > +
> > +                     if (++sg_count !=3D total_sg)
> > +                             flags |=3D VRING_DESC_F_NEXT;
> >
> >                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> > -                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT,
> > -                                                  premapped);
> > +                     i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr,
> > +                                                  len, flags ,premappe=
d);
>
> coding style violation.
>

Fixed.

Thanks

