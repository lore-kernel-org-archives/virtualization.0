Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B37DA62
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734061948; cv=none; b=ovYHW5l3r46pyEEVN+cFBv771iQOw/R4QqHRf0w0+4zysqbXcGSZESntEFdvvvFYUcrcGOsU2f62zLimbhHatzuOvC7mhlECbNu334yppG8X9zZdx316tfU5e2reNiFFUFNBhnCUggB/r/G6m85eZgTzqgomDcATWO5mJnfSxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734061948; c=relaxed/simple;
	bh=2Xg1zg0VoQPrH7fNdLbQ3qFxJxO+tFJ2FifDLe4GcmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnSH69HwAnyi40RP+DA7hsHt+OBmbi8JnG+5s8UUjbjqdl/C3KA2NcduoR12ZdN+tPUWoO1UBH/VBxQs/brSpF4FgBDXbLdAeINY2FrEcLyjoooqEKMYM00I+3GCiR+fRoOPiWy6kQSqH3P0lNxogPSuZkq0rqt845A/SMqwJtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeDW7eXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeDW7eXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734061944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Xg1zg0VoQPrH7fNdLbQ3qFxJxO+tFJ2FifDLe4GcmE=;
	b=OeDW7eXciJYQ6TBjerlo4HYe9xmruaY/10BaZ2ghRgjUhQ5XRtruZp0/9mfrG9+Fotwf2v
	SwJ89nMs00rAVsXNA51RADNVjk+8kEP2g58W7z9MuGQwCZFRDlO+xtFdPdo6r7BH3tJi9y
	xltg84IL3zr5TLdkFUIfUoxEziSHrR0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-l3uTbKarNAKBR3LI9eQ7Hg-1; Thu, 12 Dec 2024 22:52:21 -0500
X-MC-Unique: l3uTbKarNAKBR3LI9eQ7Hg-1
X-Mimecast-MFC-AGG-ID: l3uTbKarNAKBR3LI9eQ7Hg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso1272976a91.2
        for <virtualization@lists.linux.dev>; Thu, 12 Dec 2024 19:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734061940; x=1734666740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Xg1zg0VoQPrH7fNdLbQ3qFxJxO+tFJ2FifDLe4GcmE=;
        b=KcozbG2fvDxAK0VcMHUHkWLgDU0QEyVyPzPBpeoK6eAh3WFTfwy8Hih+TyZaMcMuHn
         0C+yV9NTlsy9hWSbKgMta7gs4FpSUC2yRygwUNJQDSJHnQkZn803NYp4itikLI/fxGod
         Lw//5vxVimAxtFJCt60UT0wCfXdjUtjDl05gwZRSsKICskI6EPMLnJZEcIuorOU+ojue
         NJSMWcz96QrxZHTUNKUk6evssl1tvV/OkJeKkQ+hC7D0qGLaeRpcsCy8mKG0jlPT/6Kd
         neXfQDy28+/tnBvkhzDkEdX2AJgCUWOPS9iUbUhS0byypx2UOnjIzEbfXNvwp6CI8+Ii
         E9qg==
X-Forwarded-Encrypted: i=1; AJvYcCXnmtD78zfsgZRDXNOOwOh0XBqOruQtL/eRyN+KU8fUcz5K7F6psTU3fKbig+uSLowEMpF5v80yoSCbQrIMiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/G9cyQ0pznQ2RpOqVgJtgeOjaxcR1bV1mXUnwQMOp1Ov4ymC2
	ai8rP9Tjo6EBaFskXewsEvzU1ziMLy9jpO+wEvw0sA/AjBpi0g3AvJL8kAOFxu8fobWAfXjwpTd
	xm26RmBFPzXFQ+hBwAPKS2q2JyNxZzOUaKAZ8Kap0rzFJgBSx8EVcOFzGdjsy1BBpZ7V1h6ubJq
	/i85/0sSDvcLtqpyuGdKuizYqegOLw0iG2Ez46isM=
X-Gm-Gg: ASbGncvExrg9kRUdLHTpkSEyiCCaDSIdRZBwLj/6dDaCZki/kOEDtdfbhLVIitShOch
	GC7AJPdr/x3z9hHwXW2xhU+Lz6/+MVj8aMM8Jkp8=
X-Received: by 2002:a17:90a:d406:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2f28fb66637mr2037667a91.10.1734061940422;
        Thu, 12 Dec 2024 19:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+tqAqa5yLuoILqImlqyWlZwFRiojaB1R2mePNo7f66bmgmADVDIFHo/BlHpZaUTvDx9UcXIgqd62x9+kXS14=
X-Received: by 2002:a17:90a:d406:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2f28fb66637mr2037643a91.10.1734061939994; Thu, 12 Dec 2024
 19:52:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
 <CACGkMEtPs5O25KVxN3UJX8RD5f0EhNqrqdVqt28FZSMX_W6GTg@mail.gmail.com> <CAJaqyWe0BHkhJWKw93tTu0iMakMqhix0DOHfhQxxU49vnXQALQ@mail.gmail.com>
In-Reply-To: <CAJaqyWe0BHkhJWKw93tTu0iMakMqhix0DOHfhQxxU49vnXQALQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:52:09 +0800
Message-ID: <CACGkMEvnJ5BCir6ymg50Xweno_sgyA0YxdnqKyEj8EwqMxzadg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: t.ampelikiotis@virtualopensystems.com, virtio-dev@lists.oasis-open.org, 
	anna@virtualopensystems.com, a.rigo@virtualopensystems.com, 
	m.paolino@virtualopensystems.com, s.raho@virtualopensystems.com, 
	chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org, 
	jsmoeller@linuxfoundation.org, virtualization@lists.linux.dev, 
	stefanha@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: po3PbhgoobI-2GyblkdWNPg7duUCE-hmez5aPzszrVg_1734061940
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:51=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 5, 2024 at 9:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Adding Eugenio and YongJi.
> >
> > On Wed, Dec 4, 2024 at 11:38=E2=80=AFPM <t.ampelikiotis@virtualopensyst=
ems.com> wrote:
> > >
> > > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> > >
> > > We would like to share with you an RFC for the Virtio-loopback
> > > technology which we have been working on at Virtual Open Systems in
> > > the context of the Automotive Grade Linux community (Software defined
> > > Vehicles expert group)
> > >
> > > We previously presented this activity (see [1]) and now we come back
> > > to you with latest development and updates.
> > >
> > > We believe that the technology is more mature today and we would like
> > > to assess the community interest in the technology itself and in
> > > merging the code.
> > >
> > > Below we provide a brief description of the technology, recent
> > > updates and a short comparison with vDUSE that might be seen as a
> > > similar technology.
> > >
> > > 1. Overview:
> > > -------
> > >
> > > Virtio-loopback is a hardware abstraction layer (HAL) designed for
> > > non-virtualized environments based on virtio. The main objective is
> > > to enable applications communication with vhost-user devices in a
> > > non-virtualized environment.
> > >
> > > More in details, Virtio-loopback architecture consists of a new
> > > transport (Virtio-loopback), a user-space application (Adapter) and
> > > the vhost-user devices.
> > >
> > > The data path has been implemented using the "zero-copy" principle,
> >
> > [ ... ]
> >
> > > where vhost-user devices access virtqueues directly in the kernel
> > > space.
> >
> > Eugenio used to work on a POC to bridge vhost-user to vDPA via a
> > dedicated userspace application. He might share more thoughts about
> > this.
> >
>
> Right, it worked well with DPDK and net. It could work as long as
> vhost-user device supported iotlb messages.
>
> The current kernel vdpa framework does not send the memory map until
> the device asks for it. If we modify the kernel vdpa so it always
> sends the memory map, and only waits for the userland device iotlb if
> a given feature flag is negotiated, it can be compatible with all the
> vhost-user devices.

This seems feasible and not very hard, and we can only allow such
notification while userspace wants it by a new flag probably.

>
> I can post the code if it is useful for sure.
>

Thanks

