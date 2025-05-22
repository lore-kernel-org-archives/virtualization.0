Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A15D517
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897350; cv=none; b=DsVGRpQ9EwhVXj6bhqK2eTg3RMJIsukmxY6x7l6ABCaEiZ6EbEiDTBrNeFwrI51RyRqjgyV1qB32oqtvPn4x9daWztYVcnI28G5Fz9yePCQ35xFQMOqh59nGr+R0OsIdn0OZj/rDcJQgQcuSZiLIVX6bMKltejxyjFNEcPG31lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897350; c=relaxed/simple;
	bh=b0LgYCJ+zS3Y4qZy5tIhukWCpc9KZHUh/mN5i260kEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb0ayRt+DJ5H6lqvmeUgL31gjlJpLbxMYKH20qEN06yVAsHCCGSIbnzmGkG41KGHAP0ctP6WPnqiKy6fQco14Yrd8NCbRYve7qj87Js2U/MEK48P6GO2UHE4SRnswZ4ecTtR8wUy3Ls0hcBllp6KD9y0G4cCax9pRC902TaGLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNevJmSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNevJmSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747897347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag2ux448b2TruItxL58I3ryWzU9MIQdqPkcm2HcLdRo=;
	b=eNevJmSE3UZRsOmDNefRYo/3dWug23WbtknG6urtw6BYfuO63HK+FFgEqQd0UnpgwiaQGS
	FSELcQBgPGaIwJbOKfRAfelmRW2eWXdwmUSbulHqcy3bswbAsz2cIS54WYNlA+v1niHy/m
	NXViLyznQ1eQRbBGrEQKIdXMAnmed1A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Q7ECQ-RGO6aQNueWns-PWA-1; Thu, 22 May 2025 03:02:26 -0400
X-MC-Unique: Q7ECQ-RGO6aQNueWns-PWA-1
X-Mimecast-MFC-AGG-ID: Q7ECQ-RGO6aQNueWns-PWA_1747897345
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad56c5412f2so342947366b.1
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 00:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747897345; x=1748502145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag2ux448b2TruItxL58I3ryWzU9MIQdqPkcm2HcLdRo=;
        b=BgBmS/X+1ACRDwwsKnVVz+JRoPP+dqZSkH91+5OZ0WA/6CX4OC823fQ0+lrmDAoaO6
         HrtKynMMag1ewXZWg+1e4e5m3ZRWdgvagODOzMKlSM4xKmpyOHna4bMdXvu4wno3+7i7
         sOy4K2Noo6Zxie65NQZstNn6C7XkZNxb0YR/EnbskD0XTULriqMLjwYkRny6fnhh1gzr
         AE8F29eFCK1DAGfp9wYpWvnTr+6QS9T3XpgqKcPx6MBjNERSA+JxB3GQNAaJm594aX6l
         siQiHUaQPIAmzRv69+FaykdYMr0UE2fnzK6hLjk1FNBYokgUf4M6mKO2ojc/XUbUhhak
         09jA==
X-Forwarded-Encrypted: i=1; AJvYcCWZxd2OblzTbKa8B3m4cvAvDyKPqRy/GUl6BwDGJ7hzrGrSqGZXJe/gqj4y/oz2MdKRUw3ujsSPtBxicT0INQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxtK+W1wQbnkzvs+smxdULpcjA5O3CmxpDvsM3XS+XR18bD6NO
	Q4bQofFhSKbr4hCdbr2fd1txLRIFPEE7BcNUkAD4GGJ5J7ySnPnlJDcCpHaIt51+3A+YgplWhxc
	OvoLej9491AnZIO3yuB/tXhSh9zWSGdzuXFpSBa60z0jK6vvRofdGOnOgnZND2/CKRAb5L0ym85
	2o0fLOwQDoNr7D7ykjo0le3dIlVq5jG1JvYMDo1ap1GdA=
X-Gm-Gg: ASbGncsCXb8xVkDh1homb57e5uggf8srk1oKROkqWAI6sNWJg8IfEH9J/fDJKA1qRdw
	b7cdlAEXSRwEzGP0Jn2A1S06J5BYz67R7RDj8Z+Mi/yc4+a5dyXcNpoFIYA8ii5DKlrtDLA==
X-Received: by 2002:a17:907:7da2:b0:ad2:39a9:f1b2 with SMTP id a640c23a62f3a-ad536fa5966mr2109580666b.59.1747897345045;
        Thu, 22 May 2025 00:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE224W/P6ICKS/konR+EeFebTwhEbszkWz9E3Wsg8PLsnr9Hw7dE9zCQrVu1l5zjDhj9J/D3CGCH13JfIKwK50=
X-Received: by 2002:a17:907:7da2:b0:ad2:39a9:f1b2 with SMTP id
 a640c23a62f3a-ad536fa5966mr2109577066b.59.1747897344587; Thu, 22 May 2025
 00:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <CAPpAL=x4BWNh__YpzkzpErkseh04FT7WNLmg=xMXtfZ0S9BabQ@mail.gmail.com>
 <CAJaqyWdtKEYiY2tBB0F477LqxVs8fzaix96551WSMa=KdT3C5Q@mail.gmail.com> <20250518173443-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250518173443-mutt-send-email-mst@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 22 May 2025 15:01:47 +0800
X-Gm-Features: AX0GCFuYF7XdFlyXEtLr_TPKhkebV0K74gj6NfVMZNAX5P30zqgaAxprNPeRmtA
Message-ID: <CAPpAL=zhKD7q3OmcR9_nWqMXk1grz0gNJ2Wqk923k4i+kuMfgw@mail.gmail.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bkp8HuSfIWMGNJntrBiQ2cX2LmfjePmL2Yi87ffxukU_1747897345
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 5:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 26, 2025 at 07:39:47AM +0100, Eugenio Perez Martin wrote:
> > On Mon, Mar 24, 2025 at 3:44=E2=80=AFPM Lei Yang <leiyang@redhat.com> w=
rote:
> > >
> > > QE tested this series of patches with virtio-net regression tests,
> > > everything works fine.
> > >
> >
> > Hi Lei,
> >
> > Is it possible to test this series also with virtio-net-pci,...,in_orde=
r=3Don?
> >
> > Thanks!
>
>
> Lei, what do you think?


Sure,  I will test it and provide test results ASAP.

Thanks
Lei
>
>
> > > Tested-by: Lei Yang <leiyang@redhat.com>
> > >
> > > On Mon, Mar 24, 2025 at 1:45=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > Hello all:
> > > >
> > > > This sereis tries to implement the VIRTIO_F_IN_ORDER to
> > > > virtio_ring. This is done by introducing virtqueue ops so we can
> > > > implement separate helpers for different virtqueue layout/features
> > > > then the in-order were implmeented on top.
> > > >
> > > > Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> > > > host.
> > > >
> > > > Please review.
> > > >
> > > > Thanks
> > > >
> > > > Jason Wang (19):
> > > >   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
> > > >   virtio_ring: switch to use vring_virtqueue in virtqueue_poll vari=
ants
> > > >   virtio_ring: unify logic of virtqueue_poll() and more_used()
> > > >   virtio_ring: switch to use vring_virtqueue for virtqueue resize
> > > >     variants
> > > >   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_pre=
pare
> > > >     variants
> > > >   virtio_ring: switch to use vring_virtqueue for virtqueue_add vari=
ants
> > > >   virtio: switch to use vring_virtqueue for virtqueue_add variants
> > > >   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
> > > >     variants
> > > >   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
> > > >   virtio_ring: switch to use vring_virtqueue for disable_cb variant=
s
> > > >   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
> > > >     variants
> > > >   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
> > > >   virtio_ring: introduce virtqueue ops
> > > >   virtio_ring: determine descriptor flags at one time
> > > >   virtio_ring: factor out core logic of buffer detaching
> > > >   virtio_ring: factor out core logic for updating last_used_idx
> > > >   virtio_ring: move next_avail_idx to vring_virtqueue
> > > >   virtio_ring: factor out split indirect detaching logic
> > > >   virtio_ring: add in order support
> > > >
> > > >  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++-----=
----
> > > >  1 file changed, 653 insertions(+), 203 deletions(-)
> > > >
> > > > --
> > > > 2.42.0
> > > >
> > > >
> > >
>

