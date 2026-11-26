Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682533;
	b=EkPewt0W90UAOZWuVgPW4HqLWG8aC8rtUdYOnVT3mXmEPgw/9/iiFiLxEmHgnfOZBW2Q
	 WeTFZdTxRm0Y8/ulPuAY+uSwDMZkaqGQTdI4D++tvk7IVK67fQhvzP2WyJQ7z/Wdr3FnZ
	 p+xZfRBfKbcg38Yti9deD9brWHhjODeAgOHcPfWx+nuIXGH4AnurPBj2zH8feSyuDtBrq
	 9/N0j2vgqXHhgsdd29Aa1UG/RAha9lvBfd58xDB289nAsxGJtzB8e9T1nXOAqGbb1/m9s
	 FpxPqGV6dAaU6wXL6YtraOSL8ZeNEB3kBn9lhdE3jZvLZrH9paqXi3xYNDtEHRA/TGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682533;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=agS5P/JTf/k+ModOLh2I/Nqq+33l1qwMQtHX2aNGzD0=;
	b=Br+3t4KYlo101/HJ9SzjiSU/+VMFoRguICi8w/3Iv7dDCq3LhBAkLZm0JoA8bZKoUsDx
	 CPIfY8omZIwevqYrMTzLItWHtGodwB3XDDBgp6XzN5SuFNc1IDI+hlS844xxIu9jgyoWP
	 WCRxh4F6jdbbtrLuQ+pnSIO1scj//J75fI3jBCIhY1w5bVA4gpry3Vyoj1avD5Ze3kHSr
	 Um5Gw9OcNnXjmGCSJXHojFFuXux61lcHR/PX/R4wZFSNL8sWRTtMBTF3DZKaOrYRyOwyr
	 JaM+Ni01B7eevZMaHtTz+QO5GvTLtdCwhRddgRF78Y7Zynw293VCBa/IK7us7xstjUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZ2k+VFy;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5564606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5564606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CZ2k+VFy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795682531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agS5P/JTf/k+ModOLh2I/Nqq+33l1qwMQtHX2aNGzD0=;
	b=CZ2k+VFyGdRS6ERrTgaPByBzZA5VFm3XN9KvXfhjIASP+zt9Alw6n2GKcXQLbhdp+y+9pm
	a0hZ7BNgYpnBa2L6yn1plvlntNUrpGBkPuJC3FzFJ4wrN/G3da8MosyxKH6GJkw/M0az6v
	zLBGDBzQJsSxtiq6+UsClJB0pTZ0XsU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-vCeAohpOOc-IXCnX6HhYvg-1; Thu, 26 Nov 2026 08:42:09 +0000
X-MC-Unique: vCeAohpOOc-IXCnX6HhYvg-1
X-Mimecast-MFC-AGG-ID: vCeAohpOOc-IXCnX6HhYvg_1795682529
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67dc4e966b5so6459682d50.0
        for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 00:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795682529; x=1796287329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agS5P/JTf/k+ModOLh2I/Nqq+33l1qwMQtHX2aNGzD0=;
        b=GE+myj1zFQv22xUXkvHmG2M6CIQkTIlwzomSOCUDFObD2CLoX2ECoQGJlRk7w5yQDs
         AaBsW1paxAI/AJUrMBJTlpz4Dn81Xey0kODRLJ9PD6z380Zw4ObdnQqNlbSe7BXWayET
         dZUOtHTNIMPYK3tZNqn53f69XkIVcsiN7zEy8Pf3Sqv6Tql6c7y1AGumAywpvVZVD2xj
         AeMjg1wK7/3EAI1S51/7a+MbSZzvpLOdPXG0jZxSnH22JldjVXFsmyAdECDa/9R3tAK+
         TvxymBEfAXXkZfdlvDbACZbNXmSqUDCA4NUPkYNhsy/hlX5h8NVw3MCEZN2YQso42h6v
         6B7w==
X-Forwarded-Encrypted: i=1; AL+hErEyk7afalQuxFkEPS9jDjD0TiaNCaXzMXZMEJKDLU8NnX3xbFubT9KxGx5C4CxyrU/QwEHMTjjCbnQlf5sQ4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/7LjqgUU1wo1JaSjiYaFjfNDZ74w2xh/P/eIxjfGGlSWDlc2Lb
	8mXo+ZvjiQuk8aR9bOvU/DkBshjPPN3dlE7u3uvicEq2ufj3lbgSjq2Dow3iUcs6SuswYvYfZsD
	aPJ0en1HJA5vtza/RD90Tj49Lt93qW5cRRwroGTBiK7gOWdLaQzz6buL96XFxDo00g1tvckaqpp
	zErRqwj2RqBB01di0ev27LcR1vxWH9fz9nUAZANTTs1WQ=
X-Gm-Gg: AZFdTZdw/ENW6lyRlqLXsnYnorbYlNDD3mRVzJt87wdYXhWfpYBSxkF0Rcu0VTeZHUc
	B65f9j5OoaflvdyUJvmPh/U5Yw4epXnE2S1N3vhlskM2qA3fFrqoUChDjfRtoMRvuYdbUusaJuL
	2xhXXvC20vS5MIJt0ixf8a85E8QglV9/jB5Uj4+YSXNkMqCJYxhd9otZl7iew+klYyPXFEieMu6
	I+xcYhSORAsVEpKKx6I68QAj5+B6fR/2r0LU8kGKbKVVMu3jTNUNtLG6hE=
X-Received: by 2002:a05:690e:4004:b0:67d:a5bf:ac87 with SMTP id 956f58d0204a3-67df44107b5mr8692690d50.52.1795682528914;
        Thu, 26 Nov 2026 00:42:08 -0800 (PST)
X-Received: by 2002:a05:690e:4004:b0:67d:a5bf:ac87 with SMTP id
 956f58d0204a3-67df44107b5mr8692678d50.52.1795682528461; Thu, 26 Nov 2026
 00:42:08 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261126080209.2898344-1-love09010224@uos.ac.kr>
 <CAJaqyWdLXzosXuFs8iafx0x1moGsOZuWuAQCJqCQUrOt++FCBQ@mail.gmail.com> <20261126032258-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261126032258-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Nov 2026 09:41:31 +0100
X-Gm-Features: Aa3M54rBmdF2p1Wx64RTupxMxbXYZVFoPE5aS-36qL-hbFzwuw_b_yIEr4zroro
Message-ID: <CAJaqyWcJe+sSudFs8aNvzLn5YR1wvCYTDRT3AhdPgfMQTRLCzQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: reject unrepresentable split indirect tables
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Seojin An <love09010224@uos.ac.kr>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	security@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WNwYCzqpYE1qDZSJ1Urt89jIU9d8CeZX0Y-vH4HyiWg_1795682529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 9:24=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Nov 26, 2026 at 09:14:36AM +0100, Eugenio Perez Martin wrote:
> > On Thu, Nov 26, 2026 at 9:02=E2=80=AFAM Seojin An <love09010224@uos.ac.=
kr> wrote:
> > >
> > > Split descriptors store the next index as u16. alloc_indirect_split()=
 can
> > > allocate a larger table, but virtqueue_add_split() feeds the truncate=
d next
> > > value back into its construction index. With more than 65,536 SG entr=
ies,
> > > the index wraps and later entries replace descriptors at the start of=
 the
> > > table. The device then consumes a chain different from the caller's S=
G
> > > sequence.
> > >
> > > Reject split indirect tables whose entry count exceeds the representa=
ble
> > > index range. Keep the existing compatibility policy that permits
> > > representable indirect chains longer than Queue Size, and leave packe=
d
> > > indirect descriptors unchanged.
> > >
> > > A virtio-gpu render client can reach this condition with a vmalloc-ba=
cked
> > > EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
> > > substitution provided guest physical read/write and initial-namespace
> > > uid/euid 0. The virtio-gpu producer needs its own Queue-Size check be=
cause
> > > its current queue error path warns about an add failure but advances
> > > pending state and reports success.
> > >
> > > AI tools assisted the source audit, reproducer construction and patch
> > > drafting.
> > >
> > > Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_IN=
DIRECT_DESC)")
> > > Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
> > > Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Seojin An <love09010224@uos.ac.kr>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index f683a2d6a2002..ad9e52584fb52 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vri=
ng_virtqueue *vq,
> > >
> > >         head =3D vq->free_head;
> > >
> > > -       if (virtqueue_use_indirect(vq, total_sg))
> > > +       if (virtqueue_use_indirect(vq, total_sg)) {
> > > +               /*
> > > +                * The core historically permits an indirect chain to=
 exceed the
> > > +                * queue size.  Preserve that policy, but do not let =
its 16-bit
> > > +                * split descriptor links wrap within the allocated t=
able.
> > > +                */
> >
> > Seems like the same code path in the packed vqs also needs this check?
> >
> > Also, a question for everybody: is it really too late to forbid
> > indirect tables bigger than the queue size? It is not guaranteed that
> > the device will be able to handle it anyway, should we just add a if
> > (total_sg > vq.split.vring.num) return -E2BIG?
>
> It's not too late in that the spec forbids it.  But a bunch of drivers
> are broken, so for now the best place for this check is in the driver.
>

Doesn't it make sense to add in virtio_ring as hardening? Fewer places
where we can miss the check.

> > > +               if (unlikely(total_sg > (1U << 16))) {
> > > +                       END_USE(vq);
> > > +                       return -E2BIG;
> > > +               }
> > > +
> > >                 desc =3D alloc_indirect_split(vq, total_sg, gfp);
> > > -       else {
> > > +       } else {
> > >                 desc =3D NULL;
> > >                 WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->i=
ndirect);
> > >         }
> > >
> > > base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
> > > --
> > > 2.43.0
> > >
>

