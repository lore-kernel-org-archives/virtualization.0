Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0726F469
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352119; cv=none; b=abPFJm6euELEkVohaKf+nRqMi7WP7iXs/pyQtedGvNYjKowVaI8SvJWLsHQNXWSUe/X8eCbR9Exis+eE5BMOurJ3qsyc2yIIPuweYmvZBjX63pIjopeiyaij5uhLcP/bULDQ2ERXRjsKYiii4tgaXQEUWAGXtjf7AZbOYM6srV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352119; c=relaxed/simple;
	bh=PkDtbY9NEhKa9GACDKZJ5O4QTzYKQGEbJ1wQlG1blCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnUh0PMktZnuV5tASmI4WdbQw7OIVnPMkIHP/9bckEwBfREriqHFCyGkIm2qz91ImPUICH0kOiFTWKNHVcGoYTnrVnch67DYZs7MBysB0mmUluVRr75GwQ1wxAgyud0qdWFA3Xt0YZZ+PLqcOl6IWfl7JDMOATvaOgBFIR6H7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXhZJ6B7; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXhZJ6B7"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso37646231fa.3
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748352115; x=1748956915; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8+3+XMtXOHDfLv/T+tosvnFUIfhw16R2sRDYOxTnxg=;
        b=FXhZJ6B7lVrzr8Brxdh5UZK4BQVk9G3TBemtnn2y5c/IPd6kyuovDbDFfW9vNNJUiv
         r1DFVKS8eRciKLNnZTCn5Iv6N5r3fXU1w0pjGQNwhSvb6N+Rl7DDFgeXfWh3JqXsKRGV
         pQp9wIm3efiGMRZLQf4M4jMGWYopQ2le7uZANblh4ev+xvxfEsI9KZgixbGzERBz/5Vv
         a5PsSuu4dvikW/6aT0kOnKULR9YYFbdlzqFLEJBz9HZ8Goil2jj/vY9VbXX6SsU6f5Cy
         g4KQqDbyyQwNHIFxNzmnhdnKzY64JlUfeFhrronpPJqjuo29aRmQg+3bZO6nl2xb0KRl
         noTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748352115; x=1748956915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8+3+XMtXOHDfLv/T+tosvnFUIfhw16R2sRDYOxTnxg=;
        b=IR3IRxHnQAu5lx+AQZldJ2tCG/F5Gpdrn2PIooLDzH3Nec2ivxvArkBVQFUjvdjbGR
         WihMp1yDYATBray5GOgJUbqO038j0tJlkxgXdxe7qaegWn3ZSdcgZ7iSVWSjjIkWWMFr
         kXd8xd2E42xTMvHaxZ6ztvB9Bi5lVkYMmnW7Rc5AVNECFFGhZrAz+NyRO43i6WorZwX1
         MFYMl+WCNkWe+ISZeI5EMfXm7/XS7yv+tDaByDRErAscwMvJ2vxNbof8qj9XV6tSuaPC
         o6mDataFFJU3tQJFhnbdfsfjfkm2oCXshokhu+NMT8GCLPOI6NmeEHnExm69YM0bFWA3
         Gchw==
X-Forwarded-Encrypted: i=1; AJvYcCWlKenawI67E04ujUhvCoZbhLAbGUuA9Qpvjp5zsncN1nk0/lCyZ/tb915vZTcjbWa/v2lrudbAodnjGHwWOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEoy8XizlpvIgfTRoD2VxYclch1lrp/eZwv+PKojmJJdw4Uk2M
	94ltfEDYz+BW5kxfvDOA3ovPEqoLolra0VIKCUqmraNWl/4kAgHfYCSyYRfH7J18P2+oilpRyHq
	HNMhd8qWy7eOq1tZZr00GdHtuAniyAKg=
X-Gm-Gg: ASbGncsav08JwyNO5Esy9YeQqTJmvAoomwXRVAKxS/QMlBaIBo7IYy1m0YjzJJtcmzz
	lXi+Hpcl0daaMy2+gWPRAq2p8R66PU3CN05Iy2HnGrVPvGkPau5IND5nhPoXabh5Z1DHwtpYuPg
	A1v/7Xv8ZEvFBoWB/nOiMoy/LhcHcQBu2a9uB4fqAau3Nhg27aRQgAc9y7bN43VDE=
X-Google-Smtp-Source: AGHT+IH+Ewdr9vonbIrOxmcRvgKd7RAjJeriFO+MISpkVPDe4B9w4hYy1Ur6cSAtblGN0SDU+7GGDJpmokKirdXlHAc=
X-Received: by 2002:a2e:be8c:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-3295ba7a1fdmr42809711fa.37.1748352114324; Tue, 27 May 2025
 06:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412-virtio-media-v3-1-97dc94c18398@gmail.com>
 <20250526141316.7e907032@foz.lan> <DA6Q0LZPGS2D.2QCV889PQL2A7@gmail.com> <20250527111311.105246f2@sal.lan>
In-Reply-To: <20250527111311.105246f2@sal.lan>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 27 May 2025 22:21:42 +0900
X-Gm-Features: AX0GCFs6w_wf6YTjIybZZwQbdYAW7uiqsMchgBmAWJsp_ED2VhKs0cAbQv4ghpY
Message-ID: <CAAVeFu+=RpEfu3i_Fh9_eq_g=cmDFF0gcurT0gU9AX1UX+UNVA@mail.gmail.com>
Subject: Re: [PATCH v3] media: add virtio-media driver
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Albert Esteve <aesteve@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	gurchetansingh@google.com, daniel.almeida@collabora.com, adelva@google.com, 
	changyeon@google.com, nicolas.dufresne@collabora.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 6:13=E2=80=AFPM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 27 May 2025 15:14:50 +0900
> "Alexandre Courbot" <gnurou@gmail.com> escreveu:
>
> > Hi Mauro,
> >
> > On Mon May 26, 2025 at 9:13 PM JST, Mauro Carvalho Chehab wrote:
> > > Hi Michael,
> > >
> > > Em Sat, 12 Apr 2025 13:08:01 +0900
> > > Alexandre Courbot <gnurou@gmail.com> escreveu:
> > >
> > >> Add the first version of the virtio-media driver.
> > >>
> > >> This driver acts roughly as a V4L2 relay between user-space and the
> > >> virtio virtual device on the host, so it is relatively simple, yet
> > >> unconventional. It doesn't use VB2 or other frameworks typically use=
d in
> > >> a V4L2 driver, and most of its complexity resides in correctly and
> > >> efficiently building the virtio descriptor chain to pass to the host=
,
> > >> avoiding copies whenever possible. This is done by
> > >> scatterlist_builder.[ch].
> > >>
> > >> virtio_media_ioctls.c proxies each supported ioctl to the host, usin=
g
> > >> code generated through macros for ioctls that can be forwarded direc=
tly,
> > >> which is most of them.
> > >>
> > >> virtio_media_driver.c provides the expected driver hooks, and suppor=
t
> > >> for mmapping and polling.
> > >>
> > >>  This version supports MMAP buffers, while USERPTR buffers can also =
be
> > >>  enabled through a driver option. DMABUF support is still pending.
> > >
> > > It sounds that you applied this one at the virtio tree, but it hasn't
> > > being reviewed or acked by media maintainers.
> > >
> > > Please drop it.
> > >
> > > Alexandre,
> > >
> > > Please send media patches to media maintainers, c/c other subsystem
> > > maintainers, as otherwise they might end being merged without a
> > > proper review.
> >
> > Sorry about that, I put everyone in "To:" without giving it a second
> > thought.
> >
> > >
> > > In this particular case, we need to double-check if this won't cause
> > > any issues, in special with regards to media locks and mutexes.
> >
> > Agreed, I am not 100% confident about that part myself.
> >
> > >
> > > I'll try to look on it after this merge window, as it is too late
> > > for it to be applied during this one.
> >
> > Appreciate that - given the high traffic on the list I was worried that
> > this patch would eventually be overlooked. Not making it for this merge
> > window should not be a problem, so please take the time you need.
>
> Provided that your patch was caught by patchwork, it won't be lost:
>         https://patchwork.linuxtv.org/project/linux-media/patch/20250412-=
virtio-media-v3-1-97dc94c18398@gmail.com/
>
> Please notice that our CI got a number of checkpatch issues there.
> Please check and fix the non-false-positive ones.

Will do. The macro-related ones are false-positives AFAICT. Some of
the "lines should not end with a '('" are actually the result of
applying clang-format with the kernel-provided style...

>
> Btw, I was looking at:
>
>         https://github.com/chromeos/virtio-media
>
> (I'm assuming that this is the QEMU counterpart, right?)

crosvm actually, but QEMU support is also being worked on.

>
> And I noticed something weird there:
>
>         "Unsupported ioctls
>
>          A few ioctls are replaced by other, more suitable mechanisms. If=
 being requested these ioctls, the device must return the same response as =
it would for an unknown ioctl, i.e. ENOTTY.
>
>             VIDIOC_QUERYCAP is replaced by reading the configuration area=
.
>             VIDIOC_DQBUF is replaced by a dedicated event.
>             VIDIOC_DQEVENT is replaced by a dedicated event."
>
> While this could be ok for cromeOS, this will be broken for guests with
> Linux, as all Linux applications rely on VIDIOC_QUERYCAP and VIDIOC_DQBUF
> to work. Please implement support for it, as otherwise we won't even be
> able to test the driver with the v4l2-compliance tool (*).

The phrasing was a bit confusing. The guest driver does support these
ioctls, and passes v4l2-compliance. So there is no problem here.

Where these ioctls are not supported is between the guest and the
host, i.e. as ioctls encapsulated into a virtio request. For QUERYCAP,
that's because the virtio configuration area already provides the same
information. For DQBUF and DQEVENT, that's because we want to serve
these asynchronously for performance reasons (hence the dedicated
events).

But these differences don't affect guest user applications which will
be able to perform these ioctls exactly as they expect.

>
> (*) Passing at v4l2-compliance is a requirement for any media driver
>     to be merged.
>
> With regards to testing, what's the expected testing scenario?
> My guess is that, as a virtio device, a possible test scenario would be
> to have the UVC camera from the host OS mapped using virtio-camera into
> the guest OS, allowing a V4L2 application running at the guest to map the
> camera from the host, right?

That's one of the scenarios, yes. Another one is to expose an
accelerated decoder on the host to the guest. One can also create
"fake" devices backed by software on the host for testing purposes.

That's actually the benefit of using V4L2 as a guest/host protocol:
the same guest and the same software stack on the host can be used to
virtualize multiple kinds of media devices, removing the need to have
e.g. virtio-camera and virtio-codec. This removes a ton of work (and
code).
