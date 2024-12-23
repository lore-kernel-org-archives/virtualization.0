Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39A23BB
	for <virtualization@lists.linux.dev>; Mon, 23 Dec 2024 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734926591; cv=none; b=JpWbAI12uoAqacAyIiepIgF4tEufsJ6DgmZATfFwtHPcR3YGXvGORN3/jsH8lpdzNMzUQLOJhwqa1gtEIEkrI1E2mDOd65cDqXkgiGIlppXaYTK9NcW/t4V2ZSbywVDLGq7mTFvxRYnZorn2vvUhKxiDfq9SYiBNX5dV7jMaiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734926591; c=relaxed/simple;
	bh=U97HXBLAP0HxxcNixOQ944WAjaaUQYmApiAptIIek7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXdmackaBi0zqWMcv0YgiBUfGf2mSRLyDDhj+wcbzMesQAF0OL0Wz37CN3rMw7suwdM4UWj/OUV73k1dKQMPWETA0Z4FFbY2Odpkpl0egbh4GbkM3xZx8fqTGLay3E5PntINl+P+rgJPVYjy80yuSPLXqsS8aK7dCeGJLc1PBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5JwdWA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5JwdWA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734926586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U97HXBLAP0HxxcNixOQ944WAjaaUQYmApiAptIIek7k=;
	b=f5JwdWA4spy2xfz3nG7P9Jwbj5bFK9HHdyWPD6ZQJBJv0sdhJL3Q7Mn9T0n7LV/e8j/sOt
	kB5dKIVnj3GgkunSZXoCA1K4L6azLVlifrZ+MAcIoSNXQ9pYkjWA+kaXbZ9c+uHqXKVllM
	Vf197mW1k2ZPYM98pKhI74iM7WcXKno=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-4TwKUBXBNOym0zoFMHMBoQ-1; Sun, 22 Dec 2024 23:03:05 -0500
X-MC-Unique: 4TwKUBXBNOym0zoFMHMBoQ-1
X-Mimecast-MFC-AGG-ID: 4TwKUBXBNOym0zoFMHMBoQ
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-725eb1e9139so5258111b3a.1
        for <virtualization@lists.linux.dev>; Sun, 22 Dec 2024 20:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734926584; x=1735531384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U97HXBLAP0HxxcNixOQ944WAjaaUQYmApiAptIIek7k=;
        b=SlOheXGqkWa/GX7yA8X3sjdnqGlvzvFS3WcLkcbKyDLL1zZ+K7QUOOnfy57NwllI7q
         oys2/9SJn5KEUTE/YNo95bY185sQ3zMBBtxsBXzADxhxi9VvN6alqdnOJtnv0Z9VxhVl
         KkMYREK4dNJVrUCwTV5g0Ow9/PxbsMpIUENyQKvsHUfWkVwK5BIs6SccqZmqMf7uE6VB
         DcI2W7bAwsMyKuIqkp8k0Wlk0PIhtqGNtnymIl0pEsQi1ZDBwbC9db+sjkUMVrKqiB2+
         hwWLuXc4FYy4Wv+JmJNxeUNJYtqv9mvIhED2U1iOJXwkM3g1pnlsFc2F4QNh6xaVFtsH
         Kl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBVpmqO5DPziWdetYBj0Bm8v9c2+xYhU1AZ+iPwzeGWh/28pHAlpP39OrM6YUd2zti2NNeJEK18NZTvmV5iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQusQRermU14871ZfufaUnuz1UJ9GT+quabammKcya3tEWJGdF
	1L+qd+0Fhg87EV47FlPgSX565L6R4WiiKo2xhsqGJdBawohTQGuOxmt78XdLorh09l6HmalRvBV
	nkFRXA5jcyG7fjo+Xp9NT4R7afPhSfd9Wo2ITYSYEE2dDSVwehVAJmAbNy7en+oqTNVqvT9cUZr
	zqukmZTcTUFEdZgOPnl0yfhy4EDNVgrtlkq5oEO9s=
X-Gm-Gg: ASbGncsflkd1vy0EjOx21Wft0kbdvYoiq1FNfuQjx1R2gb+YxFYJSPM9lkzjUr/IeUg
	yZQmkW1VIhuPuorsagTM3EKuBYbRZNHpQJlv96XY=
X-Received: by 2002:a05:6a00:4096:b0:72a:8461:d172 with SMTP id d2e1a72fcca58-72abdd4f34bmr17103872b3a.3.1734926584147;
        Sun, 22 Dec 2024 20:03:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9P2EdJUC5Fza0D0OdVfrMZL2jGG9YT1Z4m0pblJZNBpFPc2kunwx+7/tE8W79czW2lDd+q5Eb5FfR/hlxvkM=
X-Received: by 2002:a05:6a00:4096:b0:72a:8461:d172 with SMTP id
 d2e1a72fcca58-72abdd4f34bmr17103838b3a.3.1734926583666; Sun, 22 Dec 2024
 20:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com>
 <20241204153811.126028-2-t.ampelikiotis@virtualopensystems.com>
 <CAJSP0QW4oJGYDSLVFoeR741jVvFNS_AapFR710e5jwJ+vWHH9A@mail.gmail.com>
 <CANN35wK00GEOEeHbvx5wd+ZaNxN4vD7gSb8YT=mPs9CZ0rR7nw@mail.gmail.com> <CAJSP0QXdvWWnp-61WMeWTLnDLPWiZVqvg3Nsc3zqLuEDkxARFw@mail.gmail.com>
In-Reply-To: <CAJSP0QXdvWWnp-61WMeWTLnDLPWiZVqvg3Nsc3zqLuEDkxARFw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 Dec 2024 12:02:52 +0800
Message-ID: <CACGkMEt6hF+ZiWurKFAz3_uHLb66rXkVQ1io_C3ZdnLRkTMkNA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 1/1] VirtIO: Add platform bus driver for
 loopback virtio device
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>, virtio-dev@lists.oasis-open.org, 
	anna@virtualopensystems.com, a.rigo@virtualopensystems.com, 
	m.paolino@virtualopensystems.com, s.raho@virtualopensystems.com, 
	chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org, 
	jsmoeller@linuxfoundation.org, virtualization@lists.linux.dev, 
	stefanha@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZLskYQ20_CQ5EeZfF7SZAT5jJcSIQqiz-NpdqhWOdns_1734926584
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 9:44=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Fri, 20 Dec 2024 at 10:56, Timos Ampelikiotis
> <t.ampelikiotis@virtualopensystems.com> wrote:
> >
> >
> >
> > On Wed, Dec 4, 2024 at 7:18=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
> >>
> >> On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> w=
rote:
> >> >
> >> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> >> >
> >> > This commit, is based on virtio MMIO driver, adds support
> >> > for dynamic allocated (platform) virtio devices. This
> >> > allows applications running in native environments to use
> >> > virtio drivers as a HAL and eventually communicate with
> >> > user-space drivers (implementing the vhost-user protocol).
> >> >

[...]

> >
> >
> > I will provide a brief description of how the memory mapping
> > mechanism works and set up between the virtio-transport and
> > the vhost-user devices and then comment on the security aspect.
> >
> > The adapter application sends a set of memory regions to the
> > vhost-user device which are essentially sets of [FD_1, HPA_1, SIZE],
> > [FD_2, HPA_2, SIZE], ... [FD_N, HPA_N, SIZE]. The SIZE is 1 GB and
> > eventually HPA_N + SIZE should be bigger than the RAM size.
> >
> > When vhost-user receives those regions it calls the MMAP sys_call
> > for each one of those FDs individually and the driver assigns a page
> > handler to all of those VM regions and returns. The vhost-user device
> > at the end of this process generated the following mappings:
> > [VA_1, HPA_1, SIZE_1], [VA_2, HPA_2, SIZE_2], ..., [VA_N, HPA_N, SIZE_N=
].
> >
> > That more or less is the initialization process which will make sense
> > right after we describe how the driver give access for data buffers to =
the
> > vhost-user device below.
> >
> > When the vhost-user device tries to access a VA_X obtained by those
> > mmaps, a page-fault will occur and then the driver will need to
> > provide the corresponding page. At that point, the transport driver
> > goes through the records, recognise that VA_X is in [VA_Y, VA_Y + SIZE)
> > and constructs the required PFN by doing HPA_Y =3D VA_Y + offset where
> > offset =3D VA_X - VA_Y. Finally the driver inserts the page to the runn=
ing
> > process cause the page-fault with "vmf_insert_page".
> >
> > Security wise this approach has to fulfill the following two
> > requirements:
> >
> > a) The first one is that we need to check efficiently if
> > the calling process (vhost-user device) can have access to
> > the requested pages. For example, assuming that we run a virtio
> > blk on top of virtio-loopback transport the vhost-user blk
> > should be able to access only pages which are related with
> > virtio-blk virtqueues and vrings. That challenge is solvable
> > and we can add those checks without changing the architecture.
>
> Once pages have been faulted in, how does the kernel revoke access
> when the request is complete? I'm thinking of the scenario where a
> page is used for virtio DMA but then later reused for other purposes.
> Userspace must not retain access once the page is reused for non-DMA
> purposes.

I guess it requires madvise(MADV_DONTNEED) or something similar.

>
> >
> > b) The second one is the fact that the current memory mapping
> > approach cannot guarantee safety for the remaining data on a page
> > when the virtio buffers do not cover the whole size of it.
> > In order to address that security issue, we should implement
> > an approach such the one proposed by Jason Wang below:
> > https://github.com/jasowang/net/tree/vduse-zerocopy
> >
> > In this way we utilize the bouncing buffer idea and we can
> > guarantee to not expose the remaining data when buffer_size <
> > PAGE_SIZE and insert the page into the process otherwise.
> >
> > Overall, we are aware of those two security points, the first
> > one will require the implementation of additional checks and
> > the second the modification of data sharing model to avoid
> > exposing kernel data.
> >
> > If you think that the overall approach is interesting we
> > continue the discussion and target any future work to address
> > the above described challenges.
>
> With regards to the overall approach, please work with Jason since
> there is an overlap with VDUSE. If you guys agree on how VDUSE and
> loopback fit together, then I'm happy.
>

Right, I think it would be better if we can find a way in VDUSE first
as a lot of works/codes could be reused.

Thanks

