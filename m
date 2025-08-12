Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446E2D97BC
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967755; cv=none; b=d3NZvJ3Fos7yn1egvHoOIrPOc6saE3IWIlRXg79wl68RIES+tCfJ2BULXvhQNlI97k5F1HYhVEH4TzBsvgc67PcjEiTVglJWzTR7JRYJ+Iak5ZdP4yLftjF97CLlxwQnk0IyMsPWNpIB8g64aXoElKxmzzZ70NIMq4cGrs7i3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967755; c=relaxed/simple;
	bh=ioZp9GwhYq3DOLcNu3g4TvlRC4KH8eaX1JYYcMUAeto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzNjNL/T4V5rImEI5OEQ1OCXMMJ3P0JuYq9YhZVk/igoNyrL9aTHAnQNQyB3jAd2BP1fn8fjik4OcX0xALo4YzJdXOPt3Bvc5WcSjJvRUIM6dfi8fnK/kXDMmKk9EDELiVRZFtrRRNuMfLpGu02KS7ZUpeTaPw8B39PGInfBVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdDbeqeX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdDbeqeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvrOcstLTid8vKk7e+6Q+Q4vFiqhAtxVL8U0N+GhLdg=;
	b=JdDbeqeXATtnEcN53MGXm+MTiFo7rXZC3WnF3akq3RsrLjrIFiNgvca99ilKaKj9wQgf7/
	u8Dc/hb+hRLX1KorSaHOLqVMjhleKTAZthjldXsiBhyWecqoTU1O90WpYbkrXurRMuzEMl
	+ytL4I/A03FxzviQI9smpVI4tF4kkZI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-aUb4E-CFMBePayOiovGmxg-1; Mon, 11 Aug 2025 23:02:30 -0400
X-MC-Unique: aUb4E-CFMBePayOiovGmxg-1
X-Mimecast-MFC-AGG-ID: aUb4E-CFMBePayOiovGmxg_1754967749
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31eb41391f3so4932415a91.0
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 20:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967749; x=1755572549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvrOcstLTid8vKk7e+6Q+Q4vFiqhAtxVL8U0N+GhLdg=;
        b=DqWkza68NYyK2+SXTRq3ZIqX97ku8/b3NLRgrpv7ioUqW8hYsuhe/IK1rtakkuAsfk
         osBqgLK1Gekv8KoLdRknDGWsKNEc9cK87gO2ITJMKPsGyYRHkBnh3TgdX/ohJw0AGp8t
         gxI3TidRHegcsTy04wjfnp9DVot0nrg9Da2OuVeA+ELx07hSOiLW/1UUm38Ve97dlkdn
         lZLBk9cXX9kw8vrB723mZ5q9znLPgm8dc7y4dtYIsr86+gc+llA/t9WNOzUyKSpSs363
         +Y36pVk3lJddTrXuQ/Ht1/O6YsgpXBM71y4u7Il8AR0Ec1EUHYPcqbbeS571M3aNKmOm
         Mziw==
X-Forwarded-Encrypted: i=1; AJvYcCUgnAGIi++edlc5uapYtAFEBqsUiYnkhRIEkioUq6SHFQLd2d5cYVuYV+fkcmC/NDYQJwmcc3MXNRbKPy36xA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxlO1yoxKDIR2sV1ys2KQ7dFmEJz0iuXddZc9uYctcyDtZWG8s
	BlrNglvqJKi8Zk3HVpP13va3QIKexYUyyAR7QCrvzAtxC2ycrZD2mjmc2gPYEz3KCFf8nZzkuor
	iUG+jV0DrdRkBbSERhsniZZojs3VJjaWi3ULVopiQCF/687xjme+wTTg8XfR+Kf3y06RexVLEMT
	sWee9KEOy2bMknjyCzsZbXVWfM2Q5GcJVm5HfkMEOXBSo=
X-Gm-Gg: ASbGncv7Ekk9OOmLyfTknmm43WpWaCayaIiMb9b/UrjnLqdyiK+gdAPs0+zg7SKNfFA
	W5j2O+q+68DrW3tm1QKR+b37DP4I1lUvRN1fQcVSo27Ft+k7CiNunEjCGwK4HCN2Qz1gOLEFblU
	uoV7cVDjPDguknUClH/lDftQU=
X-Received: by 2002:a17:90b:58cd:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-321c0a52c02mr2393314a91.13.1754967748535;
        Mon, 11 Aug 2025 20:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExmyC1v+o3+EX+7wPrTBSi1UurHHwYyuQx49y6mXs8rpoVylUDhQeJ16Iggq7jiFnxBbGtnT04jO3+mxUeT2E=
X-Received: by 2002:a17:90b:58cd:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-321c0a52c02mr2393277a91.13.1754967747878; Mon, 11 Aug 2025
 20:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
 <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com> <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
In-Reply-To: <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:02:16 +0800
X-Gm-Features: Ac12FXwZqnO6d7oHIYNzKyQAmB2XYu0MI_aY6JIP8N8FOq5205LaGyJbsvfLzJc
Message-ID: <CACGkMEv+-zbtPYsRam_8XB1hLCB-Gh5xaRLxpF_gLWZNnG2OEg@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P9nt99ZSzBvRd9I8nuolJ8RMaJYiRbfRonHoyCaW4JA_1754967749
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:04=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 5:11=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > Return the internal struct that represents the vq group as virtqueue =
map
> > > token, instead of the device.
> >
> > Note that Michael prefers to use the iova domain. This indeed seems to
> > be better.
> >
>
> Well iova domain would delete an indirection in the pointer chase, but
> it would be problematic to store the token in the caller.
>
> And we need to add some way to protect that the ASID of a vq group is
> not changed in the middle of the operation by an ioctl. IOW, the
> vq_group_internal struct pointer is constant for all the lifetime of
> the device, while iova_domain is not.

I will post a new version of DMA rework and switch to using the iova
domain there. Let's see if it works then.

>
> > > This allows the DMA functions to access
> >
> > s/DMA/map/
> >
>
> Ouch, thanks for the catch!
>
> > > the information per group.
> > >
> > > At this moment all the virtqueues share the same vq group, that only
> > > can point to ASID 0.  This change prepares the infrastructure for act=
ual
> > > per-group address space handling
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Thanks
> >
>

Thanks

