Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFB289367
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744319; cv=none; b=lrlLOr2lWmsxnwYYD92rohEwhX2TuFqhQDuRAx9LPxNInP4dvyPuTOrVes2bR5wGuXmcu3ncysB/lF2KSf5ffADkpGIx3/vQVMR0HAgtTCSHtYINcTD9oq7wmfjK+N2zbSp7vK8jdRDDrKcb0AlcxMmeDmKVhF5aX9Eq7zxi6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744319; c=relaxed/simple;
	bh=mUGblPwGliu3YzskON//m/UU7MFOS7s+Yue1Nej7KOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbip+iiP1opQLq25qy16TXBqQYPV8deh5LcYuJOGTLdPtX7h8Rflu/2YDR6UfMEPyi1AbHlTEaTDwDRdw9l+0D//I54D47b+lUxhHo2SU1pdMPnhXVgZgan2kfd8NdPnlmYRJpyxzTI/iX4ufovPtEi+m/5307QANChhxPiX6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=blrn+9g4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="blrn+9g4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
	b=blrn+9g4aRzdpqGsdgN68rk6uKjOZghwkrrCi0N+gGhF3bPIoPW/FyrjSVZIcwCRMdWJiD
	LYE5ZkkZd8WOZ2Zkqmbefzn2HJ/iifO2MMFM7GiTmzDGYIcBeOjcjKXGF1/oUpYGHY9M/d
	oiB4+z0dqkss+X4LMwGvYpxZG5urNaU=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-seZ1hUd0N5S2i_zdjMMD6g-1; Thu, 17 Jul 2025 05:25:12 -0400
X-MC-Unique: seZ1hUd0N5S2i_zdjMMD6g-1
X-Mimecast-MFC-AGG-ID: seZ1hUd0N5S2i_zdjMMD6g_1752744312
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e7d971b6398so1030905276.2
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744312; x=1753349112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
        b=sTI04tqoT7bzIt+CMVgirYCJlaHa5S32Gwhvxp/sSBsMaU30Z4aecdAiCs6g5Z8ucD
         J0fdn+h/gJjmiebPCKeAWdP6YHqPjRUlr278TXF4T5fVFo9iktCmEYEoxD7dX06nGG5R
         rgo+6asB0kGHFt5E+RemxCR1OtqHCjmqUYQde2dm7yCWUWc1cqh+0iNH560m/G773JM8
         Hn/CIE2wziOcLSCUBRFc6snRLoAYjD/pnSC5q8KG/pu/uE8tQ/MM4LPTii+EzgIjOeSH
         SLP5X8Z2jg9b+g/CyeJADWHxkG428mGuYJ/fXR6VJ1nNT/PqkVyQJZOEIVlSnJDzTiN/
         dGLA==
X-Forwarded-Encrypted: i=1; AJvYcCVMwHQYd07GrrKmlmMvaczSSGFtG+xe3YJhUDqIbDlnxoXAbvbEuvcG86I2y8QiVUWznhLWCJXMoMz2zQPdRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Iw9HlWH0af6AzkVjl/GHNhQ2PhaCxpfm/mOJR1vTm7PEtV6g
	0XXEu33aLM+9l0t8N/+RNr2zUzg3/4F1brZprfZ0WglTfZy1m9THZSZ9BaBSuxosj0fOI4PLu2m
	cR6ptglJblYJ19998su0DXl1rI70xAk7ZKDw48xo2U66OpIMXjduu5V3jRHHvluiBNbec7vgXjw
	8yrsTlrvW/ehB3wvF8L1yRxd8AjXvOaskVyA+ByirOUWc=
X-Gm-Gg: ASbGncvT00lXYhUMqKu4VXz+quMTlVGP2+iTBH+SPacyk8nNxfY0oHjVNnQrcvJHGjQ
	bJabstk3Dkpek7rI4/0p7WB8A7p4RX2hLArihFPbksDqYp5fskmn8muzgMuPrt6pxe8cEktmo90
	HTcmlxPUHu5suG5lyYpeAj
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id 3f1490d57ef6-e8bd0e73bdcmr5202988276.22.1752744312276;
        Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsfTvkw1PSMXKHBxuokKzY5S7apDyUaHwD6BT79131/X481c8450D90mHNBs58p1agihhTtDodQFLemqkkQdo=
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id
 3f1490d57ef6-e8bd0e73bdcmr5202940276.22.1752744311654; Thu, 17 Jul 2025
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
 <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
In-Reply-To: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 11:25:00 +0200
X-Gm-Features: Ac12FXz6ffoOmDUY3dLdGfR0fllZrD7uhyzojK2JMGGErWflZ9rAZkbEOw8MTDA
Message-ID: <CAGxU2F6jSBM-VKU6vaojvBF_4zTWndmaQ4rFvLxds6gOPjXpcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Jason Wang <jasowang@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tYrzJe2Wvn85wDhBtceRW-ZY_jHvfzWu2auuKkgRrA8_1752744312
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 11:10, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wro=
te:
> >
> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However=
,
> > this is only checked once the SKB has been allocated and, if the length
> > in the packet header is zero, the SKB may not be freed immediately.
>
> Can this be triggered from the guest? (I guess yes) Did we need to
> consider it as a security issue?

Yep, but then the packet would still be discarded later, and the
memory released, so it can only increase the pressure on allocation,
but the guest can still do so by sending packets for example on an
unopened port.

Stefano

>
> >
> > Hoist the size check before the SKB allocation so that an iovec larger
> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> > outright. The subsequent check on the length field in the header can
> > then simply check that the allocated SKB is indeed large enough to hold
> > the packet.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_bu=
ff")
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/vhost/vsock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..66a0f060770e 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >
> >         len =3D iov_length(vq->iov, out);
> >
> > +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEAD=
ROOM)
> > +               return NULL;
> > +
> >         /* len contains both payload and hdr */
> >         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
> >         if (!skb)
> > @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >                 return skb;
> >
> >         /* The pkt is too big or the length in the header is invalid */
> > -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> > -           payload_len + sizeof(*hdr) > len) {
> > +       if (payload_len + sizeof(*hdr) > len) {
> >                 kfree_skb(skb);
> >                 return NULL;
> >         }
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> Thanks
>

