Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B6617578
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756537; cv=none; b=I9pF+uzkTiIbUcI8jEC9fjXtOOOBAAOhKeRjrVhVOOwnUKRJ+9YyBAjxfCn72sUREAlpOu4wxOcLlEQIp/zicwijgN6d5Pq3dtJHGBFHfkW6P3KQrHgY6XLUqil2LHLO0orLeCU1jWHoDi/alMMBM3fdYB92WkVTFqcd7RxROT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756537; c=relaxed/simple;
	bh=/HRnCcZbRcb+9UnZQVgZArGPTp9yESFm13pZNntIREc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrw1vgQ/9DjAUfS59aLXVx3iEiM3xfYnMiHqTBCTUjV2ebgltFBLfJBowZbYfvkWMWy+hhUOtJszaBsjqDDarVDsa5ISxZyQtEKGcCew1XKRzC9K1824yzWaKZ9Ul7Q5iiYbUD1eKHlJsYMxmPdcWkpIGYm8lFxLOpQYdRXSO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aE6xB6Ki; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE6xB6Ki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIZbtQ2slqhS5EM/uMEEbTpOOGP49cWRXzWaMjTHz98=;
	b=aE6xB6KiE16aoWBoAdHivT7cR/pnJau6VRUii/jUBvlbx9fy5JQJnyedgES/Yf0p6xrM10
	lsk6cFXNNLIf2wVLb6MHcPUvMpi2QO33bAbBOr+Zv+ttxpYCYTZjWQUeBP6+JCyWVTRfB6
	pmGxb/2fpS//ejkr7Poy89dqBulo/sI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-JKtbkxOHMHapUF6O4Lh6XQ-1; Mon, 28 Jul 2025 22:35:33 -0400
X-MC-Unique: JKtbkxOHMHapUF6O4Lh6XQ-1
X-Mimecast-MFC-AGG-ID: JKtbkxOHMHapUF6O4Lh6XQ_1753756531
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31eec1709e7so2687462a91.0
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 19:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756531; x=1754361331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIZbtQ2slqhS5EM/uMEEbTpOOGP49cWRXzWaMjTHz98=;
        b=b4VUWCY56u0sVBbUWMW/q/yJble1SSUffoS2BKRKE9i8dJibPP8QXyuPowfaWjLGS6
         1pZbC+jlAxmHDSHrLW6Uc1wGTHKPMrHt5aLY9InbWEiuzgH1ir8Zxc7QoHfFJW07rs/U
         1ZjR1v6TkGRd4+5oGFv2LCpqlLhZA4zV03prceHwqe8NiTF6u3/kDt8+8yqOb7eFzCPq
         MZoXLS5DvCZSa674gZ0hTwHmO67un82bCm4rGpg5C9x/KdnkF6wqfVgtWy/rOQBw6EKZ
         /1Ymv1FrXaPM4ytSndP78dCgddJX91QIHerdlIbP2ejVp+IWtgX73r0wBuZegNJKU4AV
         611g==
X-Forwarded-Encrypted: i=1; AJvYcCVVETa1da+WJOtgOaxZ2kZPC5Kh3tXMLV9aiOkMMW0WQEHE2vE4Gs95Wy+FVQzuNQlItABgx6vFbSeGbYk4/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLi7FTOGFbSdK1bgBEwYlCODrXLdp9C70dXEgeDFiqHQ6Te7Up
	qEDiFer8e67jqVSecW+n8DgNeULPTH3xf1FE8n6aKIj6Q4qcs9GlgbXVa4WUOcL4TcwAAVFabCb
	3VWx9yxLOMq0cuUNALMjOdmJQHhlK/47gR7p/PjBtuXgpoHW9rJtGTxrXhkjeiSsRHD7t0W4lHW
	5MKUvH6ONQVkQLrhGoJ0EpJPZgXZHa8sLbLxvi/uYBsRgZB3v1BC0sCA==
X-Gm-Gg: ASbGnctA167MDfN1qZMIqVpXLgQBSCFaTMvgqwFllCU8HJi9uModwJTGVonfjzbYkzu
	N2XDH9f/INKrba0Kw9ioc8SYeWp2GKhmDTGB4WOD+n6e5OWROueI6zdkj/oF3Kt4QdYWyRdWKcl
	ps2717C/smdnjEcAfk9pw=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31e77afec2fmr20280650a91.28.1753756530819;
        Mon, 28 Jul 2025 19:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkVhn9W+WFyYhtsUNtXSblsyo22sgv8VehvQUpBc0h593QkX1IjQB6CHvJZiJD5dWDQF9Je+oR19Df3Sb6E8U=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31e77afec2fmr20280619a91.28.1753756530435; Mon, 28 Jul 2025
 19:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724064017.26058-1-jasowang@redhat.com> <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
In-Reply-To: <CAJaqyWddTABhmjGjvY5F91g1x5pN4MxCtPnsWt-3H=SqEKO4RQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:35:18 +0800
X-Gm-Features: Ac12FXzp_K3lxtN6U2Qhjv41YpDpTlmP8AfplG3zvRlUK09iDW2x38sfF0CaVmE
Message-ID: <CACGkMEugov98y857bGK2CmbPVK3AiB5_USxm9LOPeVj7UpfpHg@mail.gmail.com>
Subject: Re: [PATCH V4 00/19] virtio_ring in order support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q32zRD-TFfjRk_-dQdnGGvJofo-6cf1HhzShMCFj_nQ_1753756531
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:42=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jul 24, 2025 at 8:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > Hello all:
> >
> > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > virtio_ring. This is done by introducing virtqueue ops so we can
> > implement separate helpers for different virtqueue layout/features
> > then the in-order were implemented on top.
> >
> > Tests shows 2%-19% imporvment with packed virtqueue PPS with KVM guest
> > vhost-net/testpmd on the host.
> >
> > Changes since V3:
> >
> > - Re-benchmark with the recent vhost-net in order support
> > - Rename the batched used id and length
> > - Other minor tweaks
> >
> > Changes since V2:
> >
> > - Fix build warning when DEBUG is enabled
> >
> > Changes since V1:
> >
> > - use const global array of function pointers to avoid indirect
> >   branches to eliminate retpoline when mitigation is enabled
> > - fix used length calculation when processing used ids in a batch
> > - fix sparse warnings
> >
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (19):
> >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
> >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
> >     variants
> >   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> >     variants
> >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> >   virtio_ring: switch to use vring_virtqueue for disable_cb variants
> >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> >     variants
> >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> >   virtio_ring: introduce virtqueue ops
> >   virtio_ring: determine descriptor flags at one time
> >   virtio_ring: factor out core logic of buffer detaching
> >   virtio_ring: factor out core logic for updating last_used_idx
> >   virtio_ring: factor out split indirect detaching logic
> >   virtio_ring: factor out split detaching logic
> >   virtio_ring: add in order support
> >
> >  drivers/virtio/virtio_ring.c | 902 +++++++++++++++++++++++++++--------
> >  1 file changed, 690 insertions(+), 212 deletions(-)
> >
>
> I'm happy with this series and it solves the abuse of the DMA API as
> far as I know. As a suggestion, maybe we can get rid of the
> vring_use_map_api function and move it to the vdev? It's actually part
> of the TODO of the function, and this seems ideal.

Right, but I tend to make it on top.

>
> This can be done on top of course, so
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>

Thanks

