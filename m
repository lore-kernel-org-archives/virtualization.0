Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E94192FD
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550934; cv=pass; b=vCIpW9zAVjoFHHiNvDCSADACSiMo2gTLacMgmPtE/U+mKyKqhDX//5R0YBfqtavNXGl75nHKivGJoNdDLY1xRIbB7cCfglpeCjuWD8XohVdRg7eKiWXYnKKVS2gwGWHPKiYjsD38ylSRdnXF9PNqOnvAOjfCW/7pz2uB49CT/sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550934; c=relaxed/simple;
	bh=UvbBTMKoPXsh3DPN/yaSeC34UC/Z+/EiQKZzUC4gry4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jof+QRhik/QyvU6/Er/MisygO4RoS0l+TPS0B1F/Pyl1j8WC1TJN3G6P+8NYdklxMgmA1Nuoa6qO5MxDQ9aXniIThL5IAJFbZzTTMKPZsv6fOvO4iXt9D6VSPURI/uS1voAQe//4MuATBe+lJfcxtC2eZ1b8wihCALZkzlYFKjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrlwGZ8q; arc=pass smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrlwGZ8q"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9690c99c917so2574141241.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 05:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784550931; cv=none;
        d=google.com; s=arc-20260327;
        b=A+Fl5vz/u9+mFg2mBLM26LqWOKnEphPqT7UswrDkJoL+MRasCIjMdJ8N2y3szZiRzp
         B8P7BRQcQUS2F0dK2W3Hdiw2z9qx6FrNfubjQrOeVcd0bRx4QkmWWQc4mE+IsPwJgRdh
         2CfgXODtO2AY6eEzrSw85dl1WZQj/F9AvE2r6T5JFbpPnrBjL4Fygzemkggi8kVQKwwc
         dQxV1++MTkSBbxzvgUJq8tYdRwKl53/KC1aVRYKHk90uPeooD1qkwL6xpsWwutVcQ1cb
         73eK+D6N8mB1dukwFns5c+q3Q+4ksCFdnG6XO6cH9eObUi2EF9kBhG9h4l/QIcf7Tq+N
         LCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJdZgmXdl95EzfJaX2vfpeNo7f8JMkb0O8aB4sRTCUY=;
        fh=dqGC8mEtiCbd97SNqlQDcXF8C7u+fPjpLu3U6QuEhbM=;
        b=qea/SGiWz3aneeSr08CE8dpnT2d+sW0/UBf6p0XxlvlWO/jOv1RnNpKUNCR4En2A22
         5nt6atM5mSmp8u+q9Q3I+CZ9KPtiUrrPyo6gSTaGkHIeIn1aO2X1tZo5C+u2f6kH7PbA
         74XcTP50y8JUuzaAFLFfgT0q7FIPn/AHZhcHQ5KSqDSDPvcH56fsRDm09UZmnbNVdjzA
         tTXHsflak8pO1X8MkO5uZO3shTHGjWnZvgVTAtAVARerKDgxjVfbYjPYbNaSSbsD/KLN
         JP5g23kGuY2zC1j0vOuhmkeUT41lkjh3T1gnH2gSgVJyGmLPHuD7GKF+KH3N8ZgaEf4Z
         oYTQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784550931; x=1785155731; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FJdZgmXdl95EzfJaX2vfpeNo7f8JMkb0O8aB4sRTCUY=;
        b=XrlwGZ8qGeWfgkeWUSXMpNLecswDddyOcc494uvVOjJecGTCxifX4NpneZQMXW47qr
         LIwwPFjot5ftHDXl3Hc3Fut5u4w02NEIuHlNu0S5R410kEfPSnUhjqhjSdUjBy1LCJqB
         m+q4N3hyF6PpTQAFABGSi9kqHRhJ93Ps0hYqFW6Ux2ZcY/dwlnIevoQ032ajEfxEqvD4
         hVg1P4M/T8KeQoHfo+6LLdEi7rwa2Q9zmePrGJFiC6eKjTCXlYy2ln+Fu5OzxmcUO+j5
         YGAY5mKLNK8B2tlYABEgDNSit0e4XameewexJNPt8PsUWJo8ES1QimxmQIwI44nTVrF+
         xmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784550931; x=1785155731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJdZgmXdl95EzfJaX2vfpeNo7f8JMkb0O8aB4sRTCUY=;
        b=XxFcstYvjLvh8JnSBj8lSQD3FQMUjr5w1Rxbcyed5kl4Gk9eCMeFO6PQd/StStnEZM
         NHQDkwjoSgeYQ2XukytF1zF7sWPYTc2VbhJkZuyZ0HlpaMImkT2/7GUqt4mPo/gENrjO
         g29b9HytlO2duKDeTSJT0IXSZQOulglLMCloaz1t/u+ayvHRYpP6ZGXGPabIOJ++CQ8K
         j+Q0Fgtvow9zaRfgn9Vp08CkTxtKYUdC+OLkylkejLy39uaCTceGCZjr28wBKf6OgOw+
         KJ4tQFmHf2GgrJho1uLNszdNLvS06rTQytMjT8urlnV0bkleSgaTjkRQoBr5FEG7KBqH
         cLaA==
X-Forwarded-Encrypted: i=1; AHgh+RpRrYmIXDMhD+FL+1T8mTpOv+zT/yOKpXxJOnG8GFklnchkONgM1rKA3S84yXYgKX7RGmTSF1ZYP2izqxCnqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwDm9GXBynUmKbSuDwR3Mg4wOaN58aTZK5YrAvKkiW/j4+F4S/
	cin+eBjme8goTahfcQrRKctPfXwx1GtjPfNIfhemeVPF9e+BLnHfIMZiHjo12dSfUftD9kDBBLJ
	D0VryvE+l1QcOrxCQqRIzLiNk6WZs5ALHL6v5tILw
X-Gm-Gg: AfdE7cm7z2B2yr0jwbt4k5JwQnn9nICTdVDfacO6JtdlguFv+ZIIc2205PsuGQNz0au
	aneY+RSaiV0JDitd7bSOE1LZ4r0kVGjycOx5AVvN2M2sszRiFtUztzTtaT6sxSKUcfAgrwcSAIs
	w7vUtOWtarl7BGStJBMCfN/mI2Mn6AVlc923vx0z7EoFslWIzfgk/ERMBD7KrNVr+GWoleG6hkY
	ftDuGJb8N+amLU77uRBks2o3USEg7Gw5zgU2F4VrzseeB2UUjRdm/hAFJQ/yvuEXRN7WJU=
X-Received: by 2002:a05:6102:370b:b0:745:6b55:30c8 with SMTP id
 ada2fe7eead31-7475379582cmr3097214137.27.1784550930790; Mon, 20 Jul 2026
 05:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622171017-mutt-send-email-mst@kernel.org>
 <20260625201850.2981130-1-briandaniels@google.com> <20260712085726.19198fda@foz.lan>
 <20260718132759-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260718132759-mutt-send-email-mst@kernel.org>
From: Alistair Delva <adelva@google.com>
Date: Mon, 20 Jul 2026 05:35:19 -0700
X-Gm-Features: AUfX_myV_gcQhOt-mF2dgrkfwe13YMu_2UC0wTl03jSgp2LZR5qnj01EJpc8usY
Message-ID: <CANDihLFeF_nKi5z=eH5Mwaa4s8fEU1chS4K2VQZ+0b-0OLybjg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] media: virtio: Add virtio_media_driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Brian Daniels <briandaniels@google.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sun, Jul 12, 2026 at 08:57:26AM +0200, Mauro Carvalho Chehab wrote:
> > On Thu, 25 Jun 2026 16:18:48 -0400
> > Brian Daniels <briandaniels@google.com> wrote:
> >
> > > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > > >
> > > > > virtio_media_driver.c provides the expected driver hooks, and sup=
port
> > > > > for mmapping and polling.
> > > > >
> > > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > > > ---
> > > > >  drivers/media/virtio/virtio_media_driver.c | 959 +++++++++++++++=
++++++
> > > > >  1 file changed, 959 insertions(+)
> > > > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > > > >
> > > > > diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers=
/media/virtio/virtio_media_driver.c
> > > > > new file mode 100644
> > > > > index 000000000..d6363c673
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/virtio/virtio_media_driver.c
> > > > > @@ -0,0 +1,959 @@
> > > > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> > > > > +
> > > > > +/*
> > > > > + * Virtio-media driver.
> > > > > + *
> > > > > + * Copyright (c) 2024-2025 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/dev_printk.h>
> > > > > +#include <linux/mm.h>
> > > > > +#include <linux/mutex.h>
> > > > > +#include <linux/scatterlist.h>
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/videodev2.h>
> > > > > +#include <linux/vmalloc.h>
> > > > > +#include <linux/wait.h>
> > > > > +#include <linux/workqueue.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/moduleparam.h>
> > > > > +#include <linux/virtio.h>
> > > > > +#include <linux/virtio_config.h>
> > > > > +#include <linux/virtio_ids.h>
> > > > > +
> > > > > +#include <media/frame_vector.h>
> > > > > +#include <media/v4l2-dev.h>
> > > > > +#include <media/v4l2-event.h>
> > > > > +#include <media/videobuf2-memops.h>
> > > > > +#include <media/v4l2-device.h>
> > > > > +#include <media/v4l2-ioctl.h>
> > > > > +
> > > > > +#include "protocol.h"
> > > > > +#include "session.h"
> > > > > +#include "virtio_media.h"
> > > > > +
> > > > > +#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
> > > > > +
> > > > > +/* ID of the SHM region into which MMAP buffer will be mapped. *=
/
> > > > > +#define VIRTIO_MEDIA_SHM_MMAP 0
> > > > > +
> > > > > +/*
> > > > > + * Name of the driver to expose to user-space.
> > > > > + *
> > > > > + * This is configurable because v4l2-compliance has workarounds =
specific to
> > > > > + * some drivers. When proxying these directly from the host, thi=
s allows it to
> > > > > + * apply them as needed.
> > > > > + */
> > > > > +char *virtio_media_driver_name;
> > > > > +module_param_named(driver_name, virtio_media_driver_name, charp,=
 0660);
> > > >
> > > >
> > > > Um. What? Not how it should be handled.
> > >
> > > I can remove this module param. I didn't end up using this when compl=
iance testing.
> > > Instead, I patched v4l-utils:
> > > https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels@goo=
gle.com/
> > >
> > > Let me know if you think the v4l-utils patch is a good approach, othe=
rwise let
> > > me know how you'd prefer to address the v4l2-compliance driver-specif=
ic workounds
> > > when they're being proxied with virtio-media.
> >
> > This kind of discussion should happen on a separate PR for v4l2-complia=
nce,
> > c/c to the proper developers and maintainers of it.
>
>
> I wonder how migration can work when guest is tied to host driver model l=
ike
> this.

We haven't given migration much thought yet, but I think it wouldn't
be so different to GPU, where to do snapshot/migration we have to
record all initialization / context setup state and replay it against
the GPU driver on restore (see https://github.com/google/gfxstream).
Some migrations will be possible, some will not, and the host should
be able to decide.

Also, Brian mentioned the host device pass-through use case, but we
also have device implementations on the host that work with camera
emulators or some other data source like video/webrtc, which will
support snapshot/migration more easily. This use case will probably
will see more real-world use and migration will be more relevant.

> > >
> > > > > +
> > > > > +/*
> > > > > + * Whether USERPTR buffers are allowed.
> > > > > + *
> > > > > + * This is disabled by default as USERPTR buffers are dangerous,=
 but the option
> > > > > + * is left to enable them if desired.
> > > > > + */
> > > > > +bool virtio_media_allow_userptr;
> > > > > +module_param_named(allow_userptr, virtio_media_allow_userptr, bo=
ol, 0660);
> > > >
> > > >
> > > > is this kind of thing common?
> >
> > There is one old media device that has it (saa7134).
> >
> > >
> > > To be honest, I don't really know. I'm also not that familiar with th=
e USERPTR
> > > issues. I see a few references online about their use being discourag=
ed due to
> > > possible race conditions, perhaps that was the original motivation fo=
r this
> > > parameter (I'm not the original author of this driver).
> > >
> > > I'm open to alternatives, feel free to let me know if you have a pref=
erence.
> >
> > We tend to not implement USERPTR on newer drivers. I suggest you
> > to place the logic with regards to V4L2_MEMORY_USERPTR on a separate
> > patch for further discussions.
> >
> > >
> > > > > +
> > > > > +/**
> > > > > + * virtio_media_session_alloc - Allocate a new session.
> > > > > + * @vv: virtio-media device the session belongs to.
> > > > > + * @id: ID of the session.
> > > > > + * @nonblocking_dequeue: whether dequeuing of buffers should be =
blocking or
> > > > > + * not.
> > > > > + *
> > > > > + * The ``id`` and ``list`` fields must still be set by the calle=
r.
> > > >
> > > > still in what sense?
> > >
> > > Based on the code below, I'm not so sure that the caller is responsib=
le for
> > > setting these values. They seem to be initialized in the function.
> > >
> > > Perhaps Alexandre Courbot (the original author) would know more. Unle=
ss he
> > > says otherwise though I'm inclined to remove this comment.
> > >
> > > > > + */
> > > > > +static struct virtio_media_session *
> > > > > +virtio_media_session_alloc(struct virtio_media *vv, u32 id,
> > > > > +                          struct file *file)
> > > > > +{
> > > > > +       struct virtio_media_session *session;
> > > > > +       int i;
> > > > > +       int ret;
> > > > > +
> > > > > +       session =3D kzalloc_obj(*session, GFP_KERNEL);
> > > > > +       if (!session)
> > > > > +               goto err_session;
> > > > > +
> > > > > +       session->shadow_buf =3D kzalloc(VIRTIO_SHADOW_BUF_SIZE, G=
FP_KERNEL);
> > > > > +       if (!session->shadow_buf)
> > > > > +               goto err_shadow_buf;
> > > > > +
> > > > > +       ret =3D sg_alloc_table(&session->command_sgs, DESC_CHAIN_=
MAX_LEN,
> > > > > +                            GFP_KERNEL);
> > > > > +       if (ret)
> > > > > +               goto err_payload_sgs;
> > > > > +
> > > > > +       session->id =3D id;
> > > > > +       session->nonblocking_dequeue =3D file->f_flags & O_NONBLO=
CK;
> > > > > +
> > > > > +       INIT_LIST_HEAD(&session->list);
> > > > > +       v4l2_fh_init(&session->fh, &vv->video_dev);
> > > > > +       virtio_media_session_fh_add(session, file);
> > > > > +
> > > > > +       for (i =3D 0; i <=3D VIRTIO_MEDIA_LAST_QUEUE; i++)
> > > > > +               INIT_LIST_HEAD(&session->queues[i].pending_dqbufs=
);
> > > > > +       mutex_init(&session->queues_lock);
> > > > > +
> > > > > +       init_waitqueue_head(&session->dqbuf_wait);
> > > > > +
> > > > > +       mutex_lock(&vv->sessions_lock);
> > > > > +       list_add_tail(&session->list, &vv->sessions);
> > > > > +       mutex_unlock(&vv->sessions_lock);
> > > > > +
> > > > > +       return session;
> > > > > +
> > > > > +err_payload_sgs:
> > > > > +       kfree(session->shadow_buf);
> > > > > +err_shadow_buf:
> > > > > +       kfree(session);
> > > > > +err_session:
> > > > > +       return ERR_PTR(-ENOMEM);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * virtio_media_session_free - Free all resources of a session.
> > > > > + * @vv: virtio-media device the session belongs to.
> > > > > + * @session: session to destroy.
> > > > > + *
> > > > > + * All the resources of @sesssion, as well as the backing memory=
 of @session
> > > > > + * itself, are freed.
> > > >
> > > > why @ here and `` above? And typo in the name.
> > >
> > > The `@` here was an attempt to follow the guide here for referencing =
function
> > > parameters:
> > > https://docs.kernel.org/doc-guide/kernel-doc.html#highlights-and-cros=
s-references
> >
> > Yes. This is part of Linux Kernel kernel-doc markup: when referring to
> > struct fields, you should use @field (or ``field`` if one wants to plac=
e an
> > asterisk on it, like ``*field``).
> >
> > >
> > > That being said, I don't believe this file is 100% consistent with th=
at. I will
> > > spend some time cleaning up the comments throughout this patch set to=
 get them
> > > consistent for v5. Thanks!
> >
> > Please use it on a consistent way along the driver.
> >
> >
> > Thanks,
> > Mauro
>
