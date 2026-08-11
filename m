Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B384446EE
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465648; cv=pass; b=IZQv4FmdbhBClCEQ71vjEzKC3D20m1ZKq6T9b3/IOnyjVcw3nebVKl1IeYZSaoU9dP4OrQ/aMwi+ZlIs1CHeICjjFSr62jNBixBb4uj65c/fd07deSeMKD733c5On76RrXgNpZxjwfKZ4hymVWXdKAx3ofBDaXfd98lU1D8tZr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465648; c=relaxed/simple;
	bh=aLXDPoPVuUMRZiJ53myck0fJWcJFj7YndQs+jDnnC78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJE1KzVESNJPlhz0j1M4YzwnhFonVQKdP4EQh6mcKhix46IzlZTYZqFUdRKl5R281tZZdUIabqmO60NKlpsIhqRXsLq1miioPnsRgFQ1szs1kYZhiRNkA1aChbb6EM1gOBM0xfscN1KPtVK1J7McRD7aKTInUfpPy5cbTOwuleo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9cOQ2el; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9cOQ2el"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso122355ad.0
        for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 09:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786465642; cv=none;
        d=google.com; s=arc-20260327;
        b=QlI+lSHla+mc7uPxKfyfeWqUHA3WsBgiQX0NGMPQQonYo62lDW+OyFo/c05bgxRA7t
         ki/O7Y7CJRNl2Gk0TOgwTHN8vg3N5Im5+jW8pmiImo9nvL3y9CrlreUHOLYEI/HEXcGs
         zvBOXP0QVG4HaTamJPySxD9urf1/ZlyBKTTqX6zgNH8ytrK1s8HYlopl479t1Sm/Qbcz
         NpswOUZW/KI9x3C+LK/SKcr3oa7rX+wWM9ZA3hkSf+Z7IIpL09k2HwzEM6eQ09kKB0mE
         zgW4wCphvNpzwf1+sflgyp0OvFUxpccZ06DkDVu8kpGz6e2bCjxk7dCFrR/nhwqk36yN
         /Gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=06jbe9PRFYOXpCvqZFPSvd04zK3hcZg7QZCaqtRjY3k=;
        fh=g+W75h2QYox9iOVYCrrAIfLvrn4n/sa40Ese4xdx8ME=;
        b=KIUKx/P2/FS00RxtqkZz6CjYT+73Al/UrUkzs2zKX56HbMM0iP2K6Ig66pe5vvvRTn
         EJM7Cbd5FNqjwc2aKHOIrs7XTXYH1JLM5NdDXNEIh6OS787kp7KBllwFK9Sx3g4/e6TR
         6LUH7XkUi4kvUjPykmwAdjgV1p8Y+NMhZXNMFKpfcvWZQbSJEQh+blUwDOrx4qpogfbn
         klFUytis45U1dgP4gYSHnSGjs46qKf+sg0DxNxW7t5P8DK48Cayxai8c+Rg0bTxUhK61
         uRLwfyordILlt7dlJQDy2p2lXPhg8Bcj2R2B6W8ui0koTQ2LDW2OOazUYCnyf7HnUKUa
         a+ww==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786465642; x=1787070442; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=06jbe9PRFYOXpCvqZFPSvd04zK3hcZg7QZCaqtRjY3k=;
        b=O9cOQ2elDasuUU0bENUEvSJuS5oiQ2ynS6vWRkXgbR/YC+XFXReH41zMtjy6vjprAb
         U4e+wgMx7McnPgFaKQqoyMzfSE5csjbgkgp4PkXGD1dC4KYZd1jKnDizUBMvebr3wRY3
         S887PfiM8Y63XKNb9UTzbEAhdGfmGIVuo6iqdak04/uYC536IfvSo5v8v30SNox+/d3P
         w2nHNRJUSGi+MyEAoAqy2EsCBoiOyPoIReMzdsLQvXBInHQPCRBa4OddVLQexAFFINhj
         ksdeOLoGMX/OI/YqGZh/XDsHtlkW2KIYeApFQ26rfZAuvY2QBmQdxPDXwq1uqcWyRVf4
         cfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465642; x=1787070442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06jbe9PRFYOXpCvqZFPSvd04zK3hcZg7QZCaqtRjY3k=;
        b=INt81l9FYGSdE6GvIOqhx1qhz7+pxAxN9feVgzJGrx+3bzlup94jwrP5y5uy/h2Xwl
         2bgTjBBFPzVkfb8F5BQ8bGXppNZ0jvH2qSX5EY6DR3stS4ypVJfczQFDNxPgggYZzrzj
         T00rkR9HaAILQYs5ofsRaYjSlFeViKkXO7rZKooBwCl/hp55gX8/CTIyvhdawqzYVRQO
         9500GSNAF6PsOmX6nzkbJJlCVr1RPCxcgrwnYi4tF9DIvB0DzUxzvsZLU74imLlXT/Ti
         H8CQ6OuoxQdC5vKn/k+HOvEXaUMAKYjQao7iVdULgKaTiFVaNjK657wxtYcWDYGHPKIC
         kaOA==
X-Forwarded-Encrypted: i=1; AHgh+RoXpQSfa7J3ZCAuPOf77YTIu1WN3TfZ4HHuegMC3/O+kypyRPTShKFnEWNsOr5Yn1n5PUz56ssQMpT259IIlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh4z9epCG21zKlE5b/nKFCuh4l8BeEOh6DrSVdXuXqG1UphTuP
	5AMwVQZFhyejRHw6C7CuQQZ9mJqbwJ5GBn844LTavU9ulW2G+5JqwF1/wYfSWYH8YRJ9SerUtlY
	akY+mkt2EvejKwjVm00dKciCPuJjn2SRtPRU679tatlcO318GmdYttg8=
X-Gm-Gg: AR+sD13bSicBKf8+JnWXU6GzDCnlOxfMni5kqpIRF0dBAlVWDfsA+VIyOfLt4CjA7Xf
	pLyzF7uui41mnvHA9UezAPEzPy4LdjMqVPhvp4YTczCplwezzoZQlwRrYYxkhawDnhHVl0L8TLV
	qpn1bn3O1chGNfvdQoYk1G5o6rLSNt/eQXf2imX81V8P2IAdcxWdnTfpmevaDzay46jIfdgD0U1
	kBgAa49+TFgHXzoWycKdVQlO0Def8v/oZP/rcbJuOM97q0ihzaYpY7Tm7hEHPtH5gCC+FjUkblY
	kBsl6QLSbPDOoJmW+0VeZTxW1PtQB3veucEQh/iPmE20CfD5eXo4Gxar9iJELrH+Fe2RMHwqbox
	xO9s=
X-Received: by 2002:a17:902:e948:b0:2c9:d89f:fd98 with SMTP id
 d9443c01a7336-2d3171e0aecmr6311705ad.1.1786465641017; Tue, 11 Aug 2026
 09:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260723183219.737296-1-briandaniels@google.com>
 <20260723183219.737296-6-briandaniels@google.com> <20260810112143.GA2967445@killaraus.ideasonboard.com>
In-Reply-To: <20260810112143.GA2967445@killaraus.ideasonboard.com>
From: Brian Daniels <briandaniels@google.com>
Date: Tue, 11 Aug 2026 12:27:07 -0400
X-Gm-Features: AUfX_mylh3xEc22sZGEWPpcjtnrXgmrNi1Y52nWS4QRRaQ1Ah-VLGf9Q2QA4taY
Message-ID: <CAD4i_GSRAWxepyWrEDrNyPerzPr275Z=gWT+JF8Y8-HskOZ+Bw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] media: virtio: Add USERPTR memory type support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 7:21=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Jul 23, 2026 at 02:32:19PM -0400, Brian Daniels wrote:
> > From: Alexandre Courbot <gnurou@gmail.com>
> >
> > This patch adds support for the USERPTR memory type to the virtio-media
> > driver.
> >
> > It adds the allow_userptr module parameter, implements the userptr
> > mapping logic in the scatterlist builder, and enables USERPTR in
> > reqbufs if allowed.
>
> USERPTR is deprecated, it shouldn't be used in new drivers or in new
> userspace code.

Good to know. Shall I remove this patch from the next revision then?

> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > ---
> >  drivers/media/virtio/scatterlist_builder.c | 64 ++++++++++++++++++++++
> >  drivers/media/virtio/scatterlist_builder.h |  3 +
> >  drivers/media/virtio/virtio_media_driver.c | 42 +++++++++-----
> >  drivers/media/virtio/virtio_media_ioctls.c | 11 +++-
> >  4 files changed, 104 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media=
/virtio/scatterlist_builder.c
> > index 97925b277..85c6a36b4 100644
> > --- a/drivers/media/virtio/scatterlist_builder.c
> > +++ b/drivers/media/virtio/scatterlist_builder.c
> > @@ -349,14 +349,30 @@ static int scatterlist_builder_add_userptr(struct=
 scatterlist_builder *builder,
> >  int scatterlist_builder_add_buffer(struct scatterlist_builder *builder=
,
> >                                  struct v4l2_buffer *b)
> >  {
> > +     int i;
> >       int ret;
> >
> > +     /* Fixup: plane length must be zero if userptr is NULL */
> > +     if (!V4L2_TYPE_IS_MULTIPLANAR(b->type) &&
> > +         b->memory =3D=3D V4L2_MEMORY_USERPTR && b->m.userptr =3D=3D 0=
)
> > +             b->length =3D 0;
> > +
> >       /* v4l2_buffer */
> >       ret =3D scatterlist_builder_add_data(builder, b, sizeof(*b));
> >       if (ret)
> >               return ret;
> >
> >       if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
> > +             /* Fixup: plane length must be zero if userptr is NULL */
> > +             if (b->memory =3D=3D V4L2_MEMORY_USERPTR) {
> > +                     for (i =3D 0; i < b->length; i++) {
> > +                             struct v4l2_plane *plane =3D &b->m.planes=
[i];
> > +
> > +                             if (plane->m.userptr =3D=3D 0)
> > +                                     plane->length =3D 0;
> > +                     }
> > +             }
> > +
> >               /* Array of v4l2_planes */
> >               ret =3D scatterlist_builder_add_data(builder, b->m.planes=
,
> >                                                  sizeof(struct v4l2_pla=
ne) *
> > @@ -368,6 +384,54 @@ int scatterlist_builder_add_buffer(struct scatterl=
ist_builder *builder,
> >       return 0;
> >  }
> >
> > +/**
> > + * scatterlist_builder_add_buffer_userptr() - Add the payload of a ``U=
SERPTR``
> > + *                                            &struct v4l2_buffer to t=
he
> > + *                                            descriptor chain.
> > + * @builder: builder to use.
> > + * @b: &struct v4l2_buffer whose ``USERPTR`` payload we want to add.
> > + *
> > + * Add an array of &struct virtio_media_sg_entry pointing to a ``USERP=
TR``
> > + * buffer's contents. Does nothing if the buffer is not of type ``USER=
PTR``.
> > + * This is split out of scatterlist_builder_add_buffer() because we on=
ly want
> > + * to add these to the device-readable part of the descriptor chain.
> > + */
> > +int scatterlist_builder_add_buffer_userptr(struct scatterlist_builder =
*builder,
> > +                                        struct v4l2_buffer *b)
> > +{
> > +     int i;
> > +     int ret;
> > +
> > +     if (b->memory !=3D V4L2_MEMORY_USERPTR)
> > +             return 0;
> > +
> > +     if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
> > +             for (i =3D 0; i < b->length; i++) {
> > +                     struct v4l2_plane *plane =3D &b->m.planes[i];
> > +
> > +                     if (b->memory =3D=3D V4L2_MEMORY_USERPTR &&
> > +                         plane->length > 0) {
> > +                             unsigned long uptr =3D plane->m.userptr;
> > +                             unsigned long len =3D plane->length;
> > +
> > +                             ret =3D
> > +                             scatterlist_builder_add_userptr(builder,
> > +                                                             uptr,
> > +                                                             len);
> > +                             if (ret)
> > +                                     return ret;
> > +                     }
> > +             }
> > +     } else if (b->length > 0) {
> > +             ret =3D scatterlist_builder_add_userptr(builder, b->m.use=
rptr,
> > +                                                   b->length);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * scatterlist_builder_retrieve_buffer() - Retrieve a &struct v4l2_buf=
fer
> >   *                                         written by the device on th=
e shadow
> > diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media=
/virtio/scatterlist_builder.h
> > index 47bfd7ae0..53d964a48 100644
> > --- a/drivers/media/virtio/scatterlist_builder.h
> > +++ b/drivers/media/virtio/scatterlist_builder.h
> > @@ -90,6 +90,9 @@ int scatterlist_builder_add_ioctl_resp(struct scatter=
list_builder *builder,
> >  int scatterlist_builder_add_buffer(struct scatterlist_builder *builder=
,
> >                                  struct v4l2_buffer *buffer);
> >
> > +int scatterlist_builder_add_buffer_userptr(struct scatterlist_builder =
*builder,
> > +                                        struct v4l2_buffer *b);
> > +
> >  int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *bu=
ilder,
> >                                       size_t sg_index,
> >                                       struct v4l2_buffer *buffer,
> > diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media=
/virtio/virtio_media_driver.c
> > index c431c3eb2..b6f79593d 100644
> > --- a/drivers/media/virtio/virtio_media_driver.c
> > +++ b/drivers/media/virtio/virtio_media_driver.c
> > @@ -7,26 +7,29 @@
> >   */
> >
> >  #include <linux/bits.h>
> > +#include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/dev_printk.h>
> > +#include <linux/mm.h>
> >  #include <linux/mutex.h>
> > +#include <linux/scatterlist.h>
> >  #include <linux/types.h>
> > +#include <linux/videodev2.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/wait.h>
> > +#include <linux/workqueue.h>
> >  #include <linux/module.h>
> > +#include <linux/moduleparam.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_config.h>
> >  #include <linux/virtio_ids.h>
> > -#include <linux/slab.h>
> > -#include <linux/scatterlist.h>
> > -#include <linux/vmalloc.h>
> > -#include <linux/workqueue.h>
> > -#include <linux/dma-mapping.h>
> > -#include <linux/poll.h>
> > -#include <linux/mm.h>
> >
> > +#include <media/frame_vector.h>
> >  #include <media/v4l2-dev.h>
> > -#include <media/v4l2-device.h>
> > -#include <media/v4l2-fh.h>
> >  #include <media/v4l2-event.h>
> > +#include <media/videobuf2-memops.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-ioctl.h>
> >
> >  #include "uapi/linux/virtio_media.h"
> >  #include "session.h"
> > @@ -40,6 +43,15 @@
> >  /* Bit mask for the VIRTIO_MEDIA_MMAP_FLAG_RW flag */
> >  #define VIRTIO_MEDIA_MMAP_FLAG_RW_MASK BIT(VIRTIO_MEDIA_MMAP_FLAG_RW)
> >
> > +/*
> > + * Whether USERPTR buffers are allowed.
> > + *
> > + * This is disabled by default as USERPTR buffers are dangerous, but t=
he option
> > + * is left to enable them if desired.
> > + */
> > +bool virtio_media_allow_userptr;
> > +module_param_named(allow_userptr, virtio_media_allow_userptr, bool, 06=
60);
> > +
> >  /**
> >   * virtio_media_session_alloc() - Allocate a new session.
> >   * @vv: virtio-media device the session belongs to.
> > @@ -849,15 +861,11 @@ static int virtio_media_probe(struct virtio_devic=
e *virtio_dev)
> >                             VIRTIO_MEDIA_SHM_MMAP);
> >
> >       vd =3D &vv->video_dev;
> > +
> >       vd->v4l2_dev =3D &vv->v4l2_dev;
> >       vd->vfl_type =3D VFL_TYPE_VIDEO;
> >       vd->ioctl_ops =3D &virtio_media_ioctl_ops;
> >       vd->fops =3D &virtio_media_fops;
> > -     vd->release =3D video_device_release_empty;
> > -     strscpy(vd->name, "virtio-media", sizeof(vd->name));
> > -
> > -     video_set_drvdata(vd, vv);
> > -
> >       vd->device_caps =3D virtio_cread32(virtio_dev, 0);
> >       if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MP=
LANE))
> >               vd->vfl_dir =3D VFL_DIR_M2M;
> > @@ -866,6 +874,10 @@ static int virtio_media_probe(struct virtio_device=
 *virtio_dev)
> >               vd->vfl_dir =3D VFL_DIR_TX;
> >       else
> >               vd->vfl_dir =3D VFL_DIR_RX;
> > +     vd->release =3D video_device_release_empty;
> > +     strscpy(vd->name, "virtio-media", sizeof(vd->name));
> > +
> > +     video_set_drvdata(vd, vv);
> >
> >       ret =3D video_register_device(vd, virtio_cread32(virtio_dev, 4), =
0);
> >       if (ret)
> > @@ -890,6 +902,7 @@ static int virtio_media_probe(struct virtio_device =
*virtio_dev)
> >       virtio_dev->config->del_vqs(virtio_dev);
> >  err_find_vqs:
> >       v4l2_device_unregister(&vv->v4l2_dev);
> > +
> >       return ret;
> >  }
> >
> > @@ -900,6 +913,7 @@ static void virtio_media_remove(struct virtio_devic=
e *virtio_dev)
> >
> >       cancel_work_sync(&vv->eventq_work);
> >       virtio_reset_device(virtio_dev);
> > +
> >       v4l2_device_unregister(&vv->v4l2_dev);
> >       virtio_dev->config->del_vqs(virtio_dev);
> >       video_unregister_device(&vv->video_dev);
> > diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media=
/virtio/virtio_media_ioctls.c
> > index f0b82b5ec..88465f239 100644
> > --- a/drivers/media/virtio/virtio_media_ioctls.c
> > +++ b/drivers/media/virtio/virtio_media_ioctls.c
> > @@ -273,6 +273,12 @@ static int virtio_media_send_buffer_ioctl(struct v=
4l2_fh *fh, u32 ioctl,
> >               return ret;
> >
> >       end_buf_sg =3D builder.cur_sg;
> > +
> > +     /* Payload of SHARED_PAGES buffers, if relevant */
> > +     ret =3D scatterlist_builder_add_buffer_userptr(&builder, b);
> > +     if (ret < 0)
> > +             return ret;
> > +
> >       num_cmd_sgs =3D builder.cur_sg;
> >
> >       /* Response descriptor */
> > @@ -719,7 +725,7 @@ static int virtio_media_reqbufs(struct file *file, =
void *fh,
> >       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> >               return -EINVAL;
> >
> > -     if (b->memory =3D=3D V4L2_MEMORY_USERPTR)
> > +     if (b->memory =3D=3D V4L2_MEMORY_USERPTR && !virtio_media_allow_u=
serptr)
> >               return -EINVAL;
> >
> >       ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_REQBUFS, b, sizeof=
(*b),
> > @@ -752,7 +758,8 @@ static int virtio_media_reqbufs(struct file *file, =
void *fh,
> >       if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
> >               session->uses_mplane =3D true;
> >
> > -     b->capabilities &=3D ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
> > +     if (!virtio_media_allow_userptr)
> > +             b->capabilities &=3D ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
> >
> >       /* We do not support DMABUF yet. */
> >       b->capabilities &=3D ~V4L2_BUF_CAP_SUPPORTS_DMABUF;
>
> --
> Regards,
>
> Laurent Pinchart
