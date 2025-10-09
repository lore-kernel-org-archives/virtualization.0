Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A04238175
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989371; cv=none; b=FGp34b0PS0eU/iOx21jTLz7CeMEj1OSUhlZ1ydOj0L7PpVWKvPnf30N2f6VecHTu4lWUtb3lWd1PS5ZKoWUNWS8L/qCVBA5Q+0T5sesWJxCJU2P6qwiNODPE6rg5QvkU+xDEd+uD362bsKaTej38sQ0Wz12sbRzAFANhmByCRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989371; c=relaxed/simple;
	bh=B7rrwZA3P87YDou+AIO5jYQa3aCNJFxAB6yvUqB2E9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl4oroUwNdy63NmUnwiyxJvzZW9LQYo+kil1i9JUYBGbrng/twLJnWx3Dr8o9UdivgzsdZ2wskLSho/gtHZYok6QzI1JTTHoQYqeXQvYepS/bsesGDmlxDyn94dHYUNxDrwbkaAUuHciku+bcOH5yqC4TqxYTj49rl9RKKNZJag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTPFLXm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTPFLXm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759989367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkgKUr7nW5eH/tRqRYLI/of3JXuQQWQkB8Qwck9RD7k=;
	b=TTPFLXm8vYq24wbtfVBaXtPQLdq9b0ElNyqE2Y5Ww2ran+VO1vzmzxPrZunZJNksCnV5dO
	3XkMLRmfCI3JssYqwfQMUYOEFygM04G1UFUo61hxNpXJeOSvnccbJ4msKs2AamcCMaiu84
	PXTCokNd2VR6B46RJ0/B0LSJQjjKGxg=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-US2jLX_CM_iro8_PhDsmSw-1; Thu, 09 Oct 2025 01:56:05 -0400
X-MC-Unique: US2jLX_CM_iro8_PhDsmSw-1
X-Mimecast-MFC-AGG-ID: US2jLX_CM_iro8_PhDsmSw_1759989365
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-555c71c82ddso355436137.3
        for <virtualization@lists.linux.dev>; Wed, 08 Oct 2025 22:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989365; x=1760594165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkgKUr7nW5eH/tRqRYLI/of3JXuQQWQkB8Qwck9RD7k=;
        b=kCM6T1fETgWx/NQUodLunu2kNc5k3patvQA+TLZpJEQkVovceP3ejJk7YROARhnoyo
         A3mrwuXMtWXXaU55DfOdaWCIGh15IQF2TWNI7RmWsk1dsUdCkyLwSIXGG4nLnJe8XodA
         dwJkBLj/5rBJDMWcweZeX75BtIcjUGOjG5ItkiXbYgGKm6eVpz/EAtQKicX7mw082FSr
         d/M0irYhqTRHUSTWFkqD/uPbl9M/a3z28hvLdgHtJUlMpxC8eUdrci91NoaT8jPS6B3Z
         wN/AWoyBVI6BlK6njQ/rRVeGi+L/o3Ymh2yKie48qVu8UU62aIUqEDMU5qb1B1a4kvCE
         uJXA==
X-Forwarded-Encrypted: i=1; AJvYcCUYwA+CIbY2zktBMRkaEU8tOkjaXWv8lLFgcM03fuCXdSaokUhe80JtnbfmKRjJwXqC/DCgfBJ9VWxCjf35ng==@lists.linux.dev
X-Gm-Message-State: AOJu0YySEdZt3vGw1J2Y+YN7bsrpbGah7fc6Yb5LOXYdHd+L0SMzBgR/
	lfglUC7VLI9TlMNsoFBlsgnr1uOD6uGOi59oecamYb9cJAVkuduN1t4kbkOYRTp+qJyv5rH6qi5
	Wa7e8ro6LeJYKs3kyZcBZeytpGwe2w5akOug4EW5yRgS+CmRQKc+TYFXmLforko0GupWTDYMnJO
	3UM29P/ly7bRWIifRqhRUU9p3cV3Vh30ZUqwXFnBcmOl8=
X-Gm-Gg: ASbGncteUmBwuKr4OA9VXEPRIe3k3DfMyWEmR5oSron1u859Mh0p81XEGksunCnb6nO
	+4Cwobv2G0hKyHNXi8QBnjGop4QeGkLnQ19lZYRBiPyeHxvJbsrMx99H0sZ5gXYXy6ogdjT4f7p
	5Onx0W2mxKuSt4DZByohVeyYY=
X-Received: by 2002:a05:6102:8382:20b0:5d3:fed4:ac2b with SMTP id ada2fe7eead31-5d5e22169bfmr2099145137.1.1759989364948;
        Wed, 08 Oct 2025 22:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEwVhF+06KroYaF8WqxvvYiwVN1v9gL+gRbbNz0RnMP4XrCEdzlCCNjmi+LUJwToQCK8zW8nDJYljKZxmqAsA=
X-Received: by 2002:a05:6102:8382:20b0:5d3:fed4:ac2b with SMTP id
 ada2fe7eead31-5d5e22169bfmr2099142137.1.1759989364581; Wed, 08 Oct 2025
 22:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-13-jasowang@redhat.com>
 <20250928192719.7ea3a825@pumpkin> <20250929041808-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250929041808-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:55:51 +0800
X-Gm-Features: AS18NWDSHW-Jk2HDDnAxuppRxg2y4I86CInrH0RysfQYUeKuWAXTaaP2DlRkFrQ
Message-ID: <CACGkMEuSSGNFMiwcD5UBvpQcUxtLmA-2PiT3AD_Sf3YSzndjMQ@mail.gmail.com>
Subject: Re: [PATCH V7 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MSlvOnSjWzNGAJ--1o1rYsKr-cK38ah1E_VZjcY2vBU_1759989365
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 28, 2025 at 07:27:19PM +0100, David Laight wrote:
> > On Thu, 25 Sep 2025 18:37:01 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> >
> > > Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> > > spec.
> >
> > If you care about performance you should pretty much never use 'u16' fo=
r
> > function parameters, return values or any arithmetic.
> > Just because the domain of the variable is [0..65535] doesn't mean that
> > 'unsigned int' isn't the correct type.
> >
> > >
> > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
>
> I don't like this because it is inconsistent with virtqueue_poll.
>
>
> If you are going to change this, change virtqueue_enable_cb_prepare_split
> too.
>
>
> But really there's no point.
>
>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 58c03a8aab85..4679a027dc53 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -806,7 +806,7 @@ static void detach_buf_split(struct vring_virtque=
ue *vq, unsigned int head,
> > >  }
> > >
> > >  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> > > -                            unsigned int last_used_idx)
> > > +                            u16 last_used_idx)
> > >  {
> > >     return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,
> >
> > You can't want that (u16) cast now, I doubt it was ever needed.
> > Note that the compiler promotes the value to 'signed int',
> > so the LHS of the comparison is actually (int)(u16)last_used_idx.
> >
> >       David
>
> It is not needed because the value is from
> virtqueue_enable_cb_prepare_split:
>
> static unsigned int virtqueue_enable_cb_prepare_split(struct virtqueue *_=
vq)
> {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 last_used_idx;
>
>         START_USE(vq);
>
>         /* We optimistically turn back on interrupts, then check if there=
 was
>          * more to do. */
>         /* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
>          * either clear the flags bit or point the event index at the nex=
t
>          * entry. Always do both to keep code simple. */
>         if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
>                 vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTER=
RUPT;
>                 if (!vq->event)
>                         vq->split.vring.avail->flags =3D
>                                 cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>         vring_used_event(&vq->split.vring) =3D cpu_to_virtio16(_vq->vdev,
>                         last_used_idx =3D vq->last_used_idx);
>         END_USE(vq);
>         return last_used_idx;
> }
>
>
>
>
>
>
> > >                     vq->split.vring.used->idx);
>

I will drop this in the next version.

Thanks

