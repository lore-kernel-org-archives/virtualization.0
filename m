Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA2433C8
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477008; cv=none; b=GF+POmSC2cxj0FsHsTryywkDGh5YC7l9nTNVIGj2PfEY9NoTyjpur8gkMyUuXt4dhDolY8Is70SHW4vAgYG8GYoYOCxG1mJBEIaFEl4QwMTbNudQGvqzDo7puy3Ak/gZgcAHwrQtYyEnU4+OWdmefvc/F6e3HxWevUIN+rv9IMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477008; c=relaxed/simple;
	bh=leYmNFud19dEBktjX/qSLYPAz8qlfnhMcr538hSMSIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oagjvW1CXUOtFWNRXJPSutFDraUIg82t7kjMdi7OStmvAysG8L+NtGa5IXsFjfWKgf6e966OJZa8GUxr80yYbh8f7VcRVXPjnJH8EwfZICcM69QKXZ34sM8l5RvV4clBKZFpYBcpdjqR4+IR9FRis2lhpxEfj/YV31urwzTpAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UwCrPj1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwCrPj1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754477005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqnoi8qrtxL9pTOaS/+krX+WtLa3a5uwXy2NOCwnpqU=;
	b=UwCrPj1TduJ8uzT8Ewebr2KZO78ZZkLgcRTVHI9+3JlAPlSmBGn9ZZ44y2S+qYVHK67ZnV
	3Cl6OL5We4gfDs5yExj14b8/9lEytRb/h8WosDx2EapVaWyMU+iKSOpoF1CTbnfd5ZU6wF
	4qwhe7AJApi5LUeOcARO9DfJXUFxKcI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-pgeLvhqcMWiXg81qAs4oYQ-1; Wed, 06 Aug 2025 06:43:24 -0400
X-MC-Unique: pgeLvhqcMWiXg81qAs4oYQ-1
X-Mimecast-MFC-AGG-ID: pgeLvhqcMWiXg81qAs4oYQ_1754477003
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad56a52edc5so497148366b.0
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 03:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754477003; x=1755081803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vqnoi8qrtxL9pTOaS/+krX+WtLa3a5uwXy2NOCwnpqU=;
        b=CC5ImYr1C8AoCoWcNSt0QK8xuk2LzeZFhdTEiWWvUtNYi8SvlpcmxPhbo39JjeFGeD
         BPEzT2L8h4WCXApsIwqrJ7/9jboX6LLWojnbldZl5CFGCAZlsLTHk/eeeTy53SRqFNop
         tjcpa6TrORak2LpABnr5d5F5cMHUDoZqfGFEkOcMQEf/fcme7iwA2RdQAofz9MEZTywG
         ZUluh9M8cAkdb/b82aeFoN6SMOofIwPn/X+ybef4hevYYj86xXMq1D1h3MxYwgP6n1jF
         XsE9MKS3RvaexFFGUtNk+R5y20GphjNJJhdc69IvqhPw51sKLPXe+qHyTeQp7YK2Pt2d
         4ikA==
X-Forwarded-Encrypted: i=1; AJvYcCW484l7LAGpMuUw4jb6V3uY/k0Qa3UzA4JnTIlrPSrDJz3B6chP11MwbklAymPERI79mCL4UtGTvPbaw5iiSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7brc8i/6J9CdSxlHfuzaiYUPrYali9GOqrvX8zLL76iUobYXA
	0h6Kc3XuUJLy2W1jbQXYxlbivujBWqk1k+Ieat2AkVJpWuN6LFjunr4P9HZVmiTQGErkXUKqPgo
	DJZxh/Iv1ZbLxOMzyIAOWiBLUt66JpbT1fq/SOHDbyFvQ2EmjKLwpoJsGi2Y2ZioXezbYYNKoZQ
	H8CcuGmrfHNKg2M6bwUiG3En/Szgzy+33ZTWLk10TkPg8=
X-Gm-Gg: ASbGnctw0QRS813RiN6OjIKqqsK0w+Ig3bRR2USdTtlrPHW/Ye99vDZUzrqRT7pw8F6
	OagBrKvGSEAsya+R6eT88ilM9qn+uPtYIRGCpkrgQUaLBYeLzvkxSw0Yk00OHZbDznr/MXRWmee
	kZEUYDy52luxhBVt3GubHWkQ==
X-Received: by 2002:a17:907:6d1b:b0:af9:88a2:b7a7 with SMTP id a640c23a62f3a-af99048b9a1mr211307666b.48.1754477003501;
        Wed, 06 Aug 2025 03:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAebosUpbeq9s9Bz5urn47OJQZK+u1L1dJLsX4v+AP0ko9r4MqWrNmfNhal+LWMl/oeacHmWoudyKHAX99JPc=
X-Received: by 2002:a17:907:6d1b:b0:af9:88a2:b7a7 with SMTP id
 a640c23a62f3a-af99048b9a1mr211304866b.48.1754477003042; Wed, 06 Aug 2025
 03:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250728064129.32382-1-jasowang@redhat.com> <20250728060823-mutt-send-email-mst@kernel.org>
 <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
In-Reply-To: <CACGkMEsX9=MAT=pg+MG-5_0PN7DYGNv8G9E2ZLgtZ1TmCLV-0g@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 6 Aug 2025 18:42:46 +0800
X-Gm-Features: Ac12FXwjsaUrwZ3HtqaXSQImiLG2up-ILmGcVP5QBC1pOAAAUnebPr4gUGDosKQ
Message-ID: <CAPpAL=yVvT4VYFMr6gykMuo3MYmfJMApWgW_naWWwTNKeTRGJA@mail.gmail.com>
Subject: Re: [PATCH V5] virtio_ring: add in order support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iYbqth4iwyS_Ji-isBsJcEQvlrlAHIvznSERutMVP0o_1754477003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Jul 29, 2025 at 10:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 28, 2025 at 6:17=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Mon, Jul 28, 2025 at 02:41:29PM +0800, Jason Wang wrote:
> > > This patch implements in order support for both split virtqueue and
> > > packed virtqueue. Perfomance could be gained for the device where the
> > > memory access could be expensive (e.g vhost-net or a real PCI device)=
:
> > >
> > > Benchmark with KVM guest:
> > >
> > > Vhost-net on the host: (pktgen + XDP_DROP):
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> > >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> > >
> > > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> > >
> > > For split virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> > >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> > >
> > > For packed virtqueue:
> > >
> > >          in_order=3Doff | in_order=3Don | +%
> > >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> > >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> > >
> > > Benchmark also shows no performance impact for in_order=3Doff for que=
ue
> > > size with 256 and 1024.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > > Changes since V4:
> > > - Fix build error when DEBUG is enabled
> > > - Fix function duplications
> > > - Remove unnecessary new lines
> > > ---
> > > drivers/virtio/virtio_ring.c | 421 +++++++++++++++++++++++++++++++++-=
-
> > >  1 file changed, 401 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index e675d8305dbf..c6558e271f97 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -70,11 +70,14 @@
> > >  enum vq_layout {
> > >       SPLIT =3D 0,
> > >       PACKED,
> > > +     SPLIT_IN_ORDER,
> > > +     PACKED_IN_ORDER,
> > >       VQ_TYPE_MAX,
> > >  };
> >
> >
> > how about specifying the #s here?
> >         SPLIT =3D 0,
> >         PACKED =3D 1,
> >         IN_ORDER =3D 2,
> >         SPLIT_IN_ORDER =3D 2,
> >         PACKED_IN_ORDER =3D 3,
> >         VQ_TYPE_MAX,
> >
> > and then
> >
> >   static inline bool virtqueue_is_packed(const struct vring_virtqueue *=
vq)
> >   {
> >         return vq->layout & PACKED;
> >  }
> >
> >  static inline bool virtqueue_is_in_order(const struct vring_virtqueue =
*vq)
> >  {
> >         return vq->layout & IN_ORDER;
> >   }
> >
> > which is a tiny bit less code.
> >
> > worth doing?
>
> Probably not, for example it would introduce branches. As we
> discussed, once we have sufficient optimizations, most of the branches
> could be saved.
>
> >
> > >
> > >  struct vring_desc_state_split {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will =
be
> > >        * allocated together. So we won't stress more to the memory al=
locator.
> >
> >
> > this is only used for in_order, and it increases the struct size
> > by half due to padding. why not a separate struct?
> > Or if you like, reuse vring_desc_state_packed - it is same
> > size with this addition.
> >
> >
> > > @@ -84,6 +87,7 @@ struct vring_desc_state_split {
> > >
> > >  struct vring_desc_state_packed {
> > >       void *data;                     /* Data for callback. */
> > > +     u32 total_len;                  /* Buffer Length */
> > >
> > >       /* Indirect desc table and extra table, if any. These two will =
be
> > >        * allocated together. So we won't stress more to the memory al=
locator.
> >
> > there's empty space at the end of this struct.
> > struct vring_desc_state_packed {
> >         void *data;                     /* Data for callback. */
> >         u32 total_len;                  /* Buffer Length */
> >
> >         /* Indirect desc table and extra table, if any. These two will =
be
> >          * allocated together. So we won't stress more to the memory al=
locator.
> >          */
> >         struct vring_packed_desc *indir_desc;
> >         u16 num;                        /* Descriptor list length. */
> >         u16 last;                       /* The last desc state in a lis=
t. */
> > };
> >
> > why not put it there?
> >
>
> Fine.
>
> Thanks
>
>

