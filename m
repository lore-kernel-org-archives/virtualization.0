Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2982866
	for <virtualization@lists.linux.dev>; Mon, 22 Sep 2025 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502676; cv=none; b=JsWSg6PimgVRgj1KceM7pc1Hqan0Mfv6jfxtInoUax6/olKnhB1AGEm0jAecT+tyVpPJm6P9lAtDg+Af7rq7Yow7jQzVXU5T1H6YnPZTvZNVZxL6J/FqN7Dkp+2Cbo3WmpL9Fn4yBySK/xB5Y2zQmEInEPMnhVhO8RNLEGry+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502676; c=relaxed/simple;
	bh=q1a/rF9kqp+ywaGF0ETTH/H1IBYzKKaVF5l0/SyOF1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+PoosoYgUkgrdRoE26KfGLtd4tGWeF/dNvGZPh3jzJg0tG+bUc2ufFHkjGpIPGJerZkdMUyDhSVBFSRkXN9o8gsNgP+tyLVP32rbW9GetqEMN77yuTJWJ8E9myEDi1p/N5km3sATNh95OBE6DkaJHf9Q17PTNIijzl9IKb6rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk4CjX08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk4CjX08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQSNgaae61Za8vLW581DDdncO8iG3z5YRux/p3d2ziM=;
	b=Mk4CjX084BJWV5pCp3ppjdRsm53Sf86FuL7oi2+VDpzl1S7YCPcg/5CkliCFkCSpA208HF
	2Mu9nfyiQU3UclNtAL+DYnVbu9l6ot/NrdSHy1IuP34cnL4KWyvn1uLo0iZzuTHXHdWRZ0
	txW4Ov1MtRGLWj3F+nQUrA6Y/dBLUhY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-SDvR-yphOEmmY1VJR9es9w-1; Sun, 21 Sep 2025 20:57:49 -0400
X-MC-Unique: SDvR-yphOEmmY1VJR9es9w-1
X-Mimecast-MFC-AGG-ID: SDvR-yphOEmmY1VJR9es9w_1758502668
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329b750757aso3215520a91.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502668; x=1759107468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQSNgaae61Za8vLW581DDdncO8iG3z5YRux/p3d2ziM=;
        b=Ll7jY+VrnBkXzaQm8x3PZbOnEOsW2msdQKn9nS++ZrE0BrzSCYr9LRosbXKIU74YZl
         gFduS/5sTO6LBB8leVERBlGaQW9ut1lN4Fkts4C8Wyx1xPHx4EZYsaSR0wbaZr3Lqzbg
         YamSGFphpH8foPcjiSAhDd2HpV4CGkf12lBQIarA431Ioe2Yems6dVZA0X+/Tw3dFfeE
         Xq9mFsJYa1mqVZ/O+zhukf9WL1P526RBpwif1/Om+e2amofT8oTu1g9/7N2iF5ligmGC
         p1amH/MSTLEFGjCybjVFJrEdGma08C7qQ39XlgiQ80PuOsAPlplB/w5ygH6Bhzv+3Tsg
         HybA==
X-Forwarded-Encrypted: i=1; AJvYcCWdA9BOshqXP7Wmv7MpTMfNDmTASzhUupneqOsQ+8qPp3OYHKYbznxj3qMpjr3EpP8sk7/AfTfnbpv9j4NjaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu56WC/ddpZDw/EY9mfCUioC0yqr54xx+Wm1tPQjFeX/Iskl0k
	536HArOHC81Y4kwKpJUoWPDzlTfu12OpDZ+CFqcoGGhqEzLLTPvZEBt/qd9WHl+eouQwOrBAFO2
	ensMKeu6aCs1vu7iSjbJEVYY0dqYsda3WqP1FGm79nsBuc2Kz8VaUE10RE509hWbnlayltpvBh2
	2F+iXgtM3o6fRIgZGITmnY5yWOfPMOqV0XH4qzE3H113E=
X-Gm-Gg: ASbGncuK+ZjFoy7yI+IQn0VHISJW8diUnjIZn+FFyVtG6vMRCwgdIQFYdF48ipsE/Cb
	BOWJsMZJ3m1bFPGBIkYGOz4DNHQM+EHsnDoTuY2kep7OZWivmhYfpAwB1jPBdu9sf+tXSi8v2NP
	wRGvNZcMJi3xE6sZLWYFEoqQ==
X-Received: by 2002:a17:90b:554e:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-33097fd89a5mr13591194a91.8.1758502667955;
        Sun, 21 Sep 2025 17:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFimiupeszfxDl1f/QXKUz4vhoXfLyzRJkGhpVNaQabPzz9P4AzQ5hFNSeN3FbPYQBz1FxcnvxSZyfA54MBRcM=
X-Received: by 2002:a17:90b:554e:b0:32e:52aa:3973 with SMTP id
 98e67ed59e1d1-33097fd89a5mr13591182a91.8.1758502667532; Sun, 21 Sep 2025
 17:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-15-jasowang@redhat.com>
 <20250921143758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143758-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:57:36 +0800
X-Gm-Features: AS18NWBKlztoe7dgm271u-z7KWOwPlC8MLZ24xmqb66UvMbjUrQbQXRvJtEN_Rk
Message-ID: <CACGkMEuQ5XgrAftGAmufw0U0h1foVNh8f3b71J9_4Bmh2R1gyQ@mail.gmail.com>
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 39o9mJ3yStxncgiuC5hP6l2Xcs21XBrAaU1JPmmOBOw_1758502668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:40=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:49PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 1045c553ee65..0949675a3d12 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       }
> >
> >       for (n =3D 0; n < out_sgs; n++) {
> > +             sg =3D sgs[n];
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                       dma_addr_t addr;
> >                       u32 len;
> > @@ -638,12 +639,12 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT,
> > +                                                  ++c =3D=3D total_sg =
?
> > +                                                  0 : VRING_DESC_F_NEX=
T,
>
> I would indent this line a bit more to the right - it is a continuation,
> after all.
>

Fixed.

Thanks

