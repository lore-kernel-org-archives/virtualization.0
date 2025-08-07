Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD4277C90
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564182; cv=none; b=XeD9s4ncoE4Pgyn/lwnEWPDjdePR0Zd1SlYco0dThR5BJVoTYVDR/wP6wFN1NkBOHJ1tTG5QHowkciNqDGluL8/5Ul/9N/yHKX2T2b+oW/CMwMOkWY++0yxTC1rFI0DnQ+t+svKVwMeRX+bmXH5Kow557NjYRBqQ1M5QWxADX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564182; c=relaxed/simple;
	bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLF4TO6BUAKFmzy7l53+EsZcCCBKGYGBtxRmtS8SMEzR+EOHlF+++I6HLk6gKkmQojwSYUuQpyp8tCxuo5Kk95CKulKxqIDpLs+Pwllp7xzVr26FvsG+qAi09cvtTKbe97YYZTDw7cKwy0k6Bm+9jXG6nzcOOrL5ILMJ7yjOzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpkctXu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpkctXu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754564179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
	b=PpkctXu8F7M+6hE0NUvdAh8tTIxxjWZZLWeLMkhlXZloQvMFpH8SunSYG+DPMSzP4/7c4P
	6Q8zT0QShFFEWkTSjmhqqavsDuokmc0kWC+P+aklRTsc2btsgdzyN37WuV/LRynx+3tedK
	ECMrfXwCcRzsHsmbyaEuoYjbBYiv1KU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-3DItn30jMV2hz4bwCGlwZw-1; Thu, 07 Aug 2025 06:56:18 -0400
X-MC-Unique: 3DItn30jMV2hz4bwCGlwZw-1
X-Mimecast-MFC-AGG-ID: 3DItn30jMV2hz4bwCGlwZw_1754564178
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1010199a91.1
        for <virtualization@lists.linux.dev>; Thu, 07 Aug 2025 03:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564178; x=1755168978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
        b=XGIBL8qc/A7V9EOg6bgOGGddnddJUyEfvgw72Sb5wFZnbSgN4or1BWKD7hrJePLMCK
         LSQcpNDLbT+rzwdLXZqTWa8HKj8O5GMQFwbRUFx7KQKCAE5xm/t6nzl3pv7nM0DIWAe7
         Zp7WOwUut8VwDeVKOq7PPac8dIugQIuficfG57pzGnxAjmFbSBMVDv0Wi4JL2FJR91SY
         j1hra1VKd1scWRAGDatG5ZR4Te2K04qyR5RRQT0EYUxq9aPMG1+PLF77ObIXWoHH9ZOR
         tMKGUyZVd4cIYn6AP/mtfxCMjUsAK7vZN/2yUl1Nn7CgcKj+VDs809MC9ZXh06Q5YJoF
         CDRw==
X-Forwarded-Encrypted: i=1; AJvYcCXDwOi4RDZs3UgEEntrTcjByXA3T1sNgYkoLKEjILu1edSROMbjQa7C8jvISkk4N+CIhi3tu6Gd6qrQx/HilA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4KIXJYWFmnFeOERlYiXPsEZE62GyoE2wytkUhBCSJgyT/KA8z
	Bw0z0t417BCNCnXZbFfD085+oKdG1eEmXXbiSeyIu8+pS6zFdAz6l/BEsVh9Az99KVlsCLDQRfm
	iYmPMYLw5FjU+Feyc6Vc3CfsGPqUxY3FAX3pEGq3bHELN4CiGlbJCsOh7GpKOpKKoLvhzI3jlkm
	lCJwfFVxMZl9OyAzNm3ZlG5CQL63w5iIbXNRhTHNyWVKs=
X-Gm-Gg: ASbGncvbODuILHtFr95ZDxyCilZSOHCdoZFymlw2p4k7bNclgmSPFr1EVcVl5eLl4XW
	8h8WbHAaAAOYN+mANZaZHEz1IVY5aMlQlzK3UuFerJ/DtPspoouJ8U/tDBs13Hbkqv1JUB0t0mF
	VXYV+uNP93H+/sBgvCV6T2
X-Received: by 2002:a17:90b:1c10:b0:31f:4a91:4e94 with SMTP id 98e67ed59e1d1-32166ceff05mr7274977a91.30.1754564177531;
        Thu, 07 Aug 2025 03:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnji28TKZYRSPeOPRIzeGS5YsdiPvxMHMQ8G/IxMSHDVyC2mWQCHBvrdd0u92IisFQ9KMRBNPftWmwbHSU0qY=
X-Received: by 2002:a17:90b:1c10:b0:31f:4a91:4e94 with SMTP id
 98e67ed59e1d1-32166ceff05mr7274942a91.30.1754564177031; Thu, 07 Aug 2025
 03:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
 <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
 <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com> <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
In-Reply-To: <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Aug 2025 12:55:40 +0200
X-Gm-Features: Ac12FXyAp2Orw7ea3GlDIsGBdiXOoNFGa3EvjiOD9nnxscN9GpRPsdcRVCe1ktU
Message-ID: <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ltRl4vy9PoF9MY5YL0S6NLuhjxxqD_59j07saQ5Xz4_1754564178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > > >
> > > > > This allows to define all functions checking the API version set =
by the
> > > > > userland device.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >
> > > > It might be worth clarifying how it works.
> > > >
> > > > For example,
> > > >
> > > > 1) would VDUSE behave differently or if it's just some new ioctls
> >
> > I'd like to test more in-depth, but a device can just bump the version
> > ID and then implement the replies to the vduse messages. No need to
> > implement new ioctls. If the VDUSE device sets 0 in either number of
> > ASID or vq groups, the kernel assumes 1.
>
> Right, this is the way we use now and I think maybe we can document
> this somewhere.
>
> >
> > But you have a very good point here, I think it is wise to evaluate
> > the shortcut of these messages in the VDUSE kernel module. If a VDUSE
> > device only has one vq group and one ASID, it can always return group
> > 0 and asid 0 for everything, and fail every try to ser asid !=3D 0.
>
> Yes, and vhost-vDPA needs to guard against the misconfiguration.
>
> > This
> > way, the update is transparent for the VDUSE device, and future
> > devices do not need to implement the reply of these. What do you
> > think?
>
> This should work.
>
> >
> > > > 2) If VDUSE behave differently, do we need a ioctl to set the API
> > > > version for backward compatibility?
> > >
> > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > >
> > > I think we need to think if it complicates the migration compatibilit=
y or not.
> > >
> >
> > Do you mean migration as "increase the VDUSE version number", not "VM
> > live migration from vduse version 0 to vduse version 1", isn't it? The
> > second should not have any problem but I haven't tested it.
>
> I mean if we bump the version, we can't migrate from version 1 to
> version 0. Or we can offload this to the management (do we need to
> extend the vdpa tool for this)?
>

I just noticed I left this unreplied. But I still do not get what
migrate means here :).

If migrate means to run current VDUSE devices on kernel with this
series applied these devices don't set V1 API so they have one vq
group, and one asid. I'm actually testing this with my libfuse+VDUSE
modifications that don't use V1 at all. Adding this explanation to the
patch as it is a very good point indeed.

If it means to migrate a guest from using a V1 VDUSE device to a V0
device "it should work", as it is just a backend implementation
detail. If we migrate from or to a vdpa device backed by hardware, for
example, one of the devices does not even have the concept of VDUSE
API version.

In the case of net, it does not work at the moment because the only
way to set features like mq are through the shadow CVQ. If a VDUSE net
device implements, let's say, admin vq, something similar to PF and
VF, and dirty bitmap, I guess it should be possible. Maybe it is
easier to play with this wuth block devices.

