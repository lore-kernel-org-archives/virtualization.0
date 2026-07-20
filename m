Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F53B2FDF
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556491; cv=pass; b=LYOJYYC9345lbJtjEg86C031qdBE1OIi8n1/gF2V1w4ATR+2dmqHyt+LQj61uf6BAmPk9Isw5TtCZLiG/56uh+R6X6lFazf9MEqsSpa5k7kTBwHuiQSI0KKK/eDcSLbHfhgRzk/YL07s7pq/C8ILuIViSrN+dVCmRKUpWt7CIhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556491; c=relaxed/simple;
	bh=ZqVhj65K7ItZCaGaSF9ekL+yn+4VUgf3Uv00wGEU3Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbQLc/P/dyAkx3k+WU2fdpNlXUPcJlYK2yXITY4wqfxq7bFqvm50ENI5wJVb0GDFQD3Kv5d/HxrtelJ6Nmd1F+g/OgXN3y3CCTrzxW+CQ8RRDcevoqJE8sLEgNnZOhXtF/s4CBDY7ZpEC2vlOTzJLySIbi5yjPAZnROF+2WWGxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weFVvjaX; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weFVvjaX"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c27e38ee18so881024e0c.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 07:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556489; cv=none;
        d=google.com; s=arc-20260327;
        b=qa4d4pzyvnc0glo7EA9koEE7QMDcqV91uuv4NaPq1DGQOExvSmzB1pAKerTpxMFeTX
         7E0oVEx60FBmiBzQvirLdvK6sD9pw/alVKTIUZ0XAxSPHkxoBiZhsIvu4UcZ/JWZIUWX
         NbawzpsD0bsE7GTPgyl5m/H3k9th426mrnfo/sNtAeip3ItwoeEquf9wnmxGEF5/CUz4
         dhbLi1ulynb/zFuDArnLeiE1w7LXYkvqiaUOkaENcvv+ZGT++nWXkgTsUS8F421BXKCC
         gULuGSvUOkib2MN7BohVJwtwBAzO9NXgaUUf8G21gPK0sJsjWPqreGPr15BuQT/vFI1F
         +NBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLri1gunqdWpi4GFYLcz47lyk4maD5Dz29xDKmdmsIg=;
        fh=+w9pHTTz/y9InLuvb+4rQYHi3EBzoPwQGHQUxfPKFkc=;
        b=kZLGtaCZi26yiRbULjxKLwRTfD317Z2yfJi5dTbN4YqL3W80DF+KMSshGVZY0U3uaj
         mIUO06OY4Tua+TuiLs4R1gH+cVh/IHaRVLbbqvVyzBZh2LGHaE5WM6SE75WuwyPeH3Iy
         FrhA2QIS55xXhprKgl8ZnEpntUxrSW9kKymgRgRPEgjIsn91lLUUEEMgVM4uHLdw2yYg
         34wHiCjbAVbyiDm8N6A9LYsmiEh0nYQ1VDb9eKVKujWLz+HkLCwnAZRi+xfJReSRLp0C
         p2L+u2h1ghRcCKeTSd1sDv9qPpJU/ae07nsGubCOn/7qRdkgbLHleI/Y4wgRCOtmrdGp
         RVeQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784556489; x=1785161289; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLri1gunqdWpi4GFYLcz47lyk4maD5Dz29xDKmdmsIg=;
        b=weFVvjaXh36WQhroh5FU3lThYnYGxbualoZs8OVT4GCMJRNamPChv5Di0kRdg9BqbI
         jab1kbM3++YIMbqIFIqTH2k8ShnUI/sgbCQ4OTPEq0uwX7lPnrz2dhThj6l2NECdjT4v
         8n5lFTJDxOw0A5houufur3AZRuOxkFsA0PGeKMWJy+hMfbmus52MOqAXFJwzFEALb7Ct
         +yl9fPeS999QRYc2fM1MMsLDyDMSLaGseUsuROg9z7Julbffxw+eAsCG02KMtUSZbr33
         weKDDluryxtWcfG+xI48jBkpi0Ebr2iSI5jaMRRajHcRC4+8WwFFA3ZazROwnEd9qYf3
         jNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556489; x=1785161289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLri1gunqdWpi4GFYLcz47lyk4maD5Dz29xDKmdmsIg=;
        b=MYP29KAiwQFgMEqxKD++bDBOW15UFGSki4kTCJsFgWH+Fdg2BqgaC3QB0mDZt+6/h+
         53GifwaAmXPY6yEhr6ZPN7rNTTpZ4mPavBPOhj+X1bwKYsz7olespkAxGiTPRrWxSU4R
         Ec9uJjG3Y4qPyIz7WxKtQu+8Tb7lkyRs7QIt9Y4XnSN5ho4K+fc9j5mfJG3Q0Swdmssz
         fxzofY+JY2j2s417USDjgCmWOddJJ2PDy8ORlVU0vHIGOrsm9oV7dmhhpVVJeayBUwvP
         dQJyZ+I+cW9DyNXsqbtu3kOCLdxU/3fq61W3FCx7VycLmC6WUrccyuH83GrV79vYIc+3
         0Avg==
X-Forwarded-Encrypted: i=1; AHgh+RoDrDuEV1U0VDivqKicW5CXNhBZ0Zu/+TYVtEmzviBqtpSOYmVSZm/cG51Q3+005pBgOKCM2Eh1G4aNj91LLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwKvW/NUPh08beNbn23D4oZPKwf18E3kPWcs9rqDfPgbR2HWYt
	kV9QSroKfjFm7QAWaAlxTHQD0v48D7McFf9HIvOCMLtBLnp2zUB4qkegk8SdZvbMXg/IPGsSC1O
	WhyDelQtbU2j4TyqLrKih1riV3vFkWTX22j33BR4H
X-Gm-Gg: AfdE7cklOkQ1DgFrrr2xONsDhrhHDCGTvZwgm/dY1T6STzTqJHAJRj3U1QrSzswKi/0
	h6PPcgjOs8Ht527mShTZ9PEeajR0ptIV0Fy1yUaCgq+JQh5tEdZOiYcWZ2P6dDiwscwLzBKnHyg
	wEopNYsFFOcXCu+uu4zDqUOSrOqcicjLzl/fUJQ2wkhMKfCqtWbbZhTy9M9ddNO7eN1jDMQQJIw
	NOoqp9p1QWseHl5lLZPLW55Sf60Qz3Lk8Azdyps7V9kP/rjeouj6wouTX3GuRmxbKEvRePqqbXK
	y2vuc2+mYGt4yP+r9gk=
X-Received: by 2002:a05:6122:660d:b0:5bd:fb8c:5db1 with SMTP id
 71dfb90a1353d-5c1bf9ee9e7mr4054975e0c.10.1784556486276; Mon, 20 Jul 2026
 07:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622171017-mutt-send-email-mst@kernel.org>
 <20260625201850.2981130-1-briandaniels@google.com> <20260712085726.19198fda@foz.lan>
 <20260718132759-mutt-send-email-mst@kernel.org> <CANDihLFeF_nKi5z=eH5Mwaa4s8fEU1chS4K2VQZ+0b-0OLybjg@mail.gmail.com>
 <20260720090703-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260720090703-mutt-send-email-mst@kernel.org>
From: Alistair Delva <adelva@google.com>
Date: Mon, 20 Jul 2026 07:07:54 -0700
X-Gm-Features: AUfX_mzUJyvUKlsUeKSe7egK1lwlCUacVREjPIYWowi82XY2KUKf0XMOLrOKtdA
Message-ID: <CANDihLGhUoqU569e-w8cuJ3Nt7LYtVk=YJYP9Dv-2S9ZbBzbrg@mail.gmail.com>
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

On Mon, Jul 20, 2026 at 6:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 20, 2026 at 05:35:19AM -0700, Alistair Delva wrote:
> > On Sat, Jul 18, 2026 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Sun, Jul 12, 2026 at 08:57:26AM +0200, Mauro Carvalho Chehab wrote=
:
> > > > On Thu, 25 Jun 2026 16:18:48 -0400
> > > > Brian Daniels <briandaniels@google.com> wrote:
> > > >
> > > > > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > > > > >
> > > > > > > virtio_media_driver.c provides the expected driver hooks, and=
 support
> > > > > > > for mmapping and polling.
> > > > > > >
> > > > > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > > > > > ---
> > > > > > >  drivers/media/virtio/virtio_media_driver.c | 959 +++++++++++=
++++++++++
> > > > > > >  1 file changed, 959 insertions(+)
> > > > > > >  create mode 100644 drivers/media/virtio/virtio_media_driver.=
c
> > > > > > >
> > > > > > > diff --git a/drivers/media/virtio/virtio_media_driver.c b/dri=
vers/media/virtio/virtio_media_driver.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000..d6363c673
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/media/virtio/virtio_media_driver.c
> > > > > > > @@ -0,0 +1,959 @@
> > > > > > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Virtio-media driver.
> > > > > > > + *
> > > > > > > + * Copyright (c) 2024-2025 Google LLC.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/delay.h>
> > > > > > > +#include <linux/device.h>
> > > > > > > +#include <linux/dev_printk.h>
> > > > > > > +#include <linux/mm.h>
> > > > > > > +#include <linux/mutex.h>
> > > > > > > +#include <linux/scatterlist.h>
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/videodev2.h>
> > > > > > > +#include <linux/vmalloc.h>
> > > > > > > +#include <linux/wait.h>
> > > > > > > +#include <linux/workqueue.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/moduleparam.h>
> > > > > > > +#include <linux/virtio.h>
> > > > > > > +#include <linux/virtio_config.h>
> > > > > > > +#include <linux/virtio_ids.h>
> > > > > > > +
> > > > > > > +#include <media/frame_vector.h>
> > > > > > > +#include <media/v4l2-dev.h>
> > > > > > > +#include <media/v4l2-event.h>
> > > > > > > +#include <media/videobuf2-memops.h>
> > > > > > > +#include <media/v4l2-device.h>
> > > > > > > +#include <media/v4l2-ioctl.h>
> > > > > > > +
> > > > > > > +#include "protocol.h"
> > > > > > > +#include "session.h"
> > > > > > > +#include "virtio_media.h"
> > > > > > > +
> > > > > > > +#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
> > > > > > > +
> > > > > > > +/* ID of the SHM region into which MMAP buffer will be mappe=
d. */
> > > > > > > +#define VIRTIO_MEDIA_SHM_MMAP 0
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Name of the driver to expose to user-space.
> > > > > > > + *
> > > > > > > + * This is configurable because v4l2-compliance has workarou=
nds specific to
> > > > > > > + * some drivers. When proxying these directly from the host,=
 this allows it to
> > > > > > > + * apply them as needed.
> > > > > > > + */
> > > > > > > +char *virtio_media_driver_name;
> > > > > > > +module_param_named(driver_name, virtio_media_driver_name, ch=
arp, 0660);
> > > > > >
> > > > > >
> > > > > > Um. What? Not how it should be handled.
> > > > >
> > > > > I can remove this module param. I didn't end up using this when c=
ompliance testing.
> > > > > Instead, I patched v4l-utils:
> > > > > https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels=
@google.com/
> > > > >
> > > > > Let me know if you think the v4l-utils patch is a good approach, =
otherwise let
> > > > > me know how you'd prefer to address the v4l2-compliance driver-sp=
ecific workounds
> > > > > when they're being proxied with virtio-media.
> > > >
> > > > This kind of discussion should happen on a separate PR for v4l2-com=
pliance,
> > > > c/c to the proper developers and maintainers of it.
> > >
> > >
> > > I wonder how migration can work when guest is tied to host driver mod=
el like
> > > this.
> >
> > We haven't given migration much thought yet, but I think it wouldn't
> > be so different to GPU, where to do snapshot/migration we have to
> > record all initialization / context setup state and replay it against
> > the GPU driver on restore (see https://github.com/google/gfxstream).
> > Some migrations will be possible, some will not, and the host should
> > be able to decide.
> >
> > Also, Brian mentioned the host device pass-through use case, but we
> > also have device implementations on the host that work with camera
> > emulators or some other data source like video/webrtc, which will
> > support snapshot/migration more easily. This use case will probably
> > will see more real-world use and migration will be more relevant.
>
> This is par for the course.
>
>
> But I'm afraid I wasn't clear enough. This thread mentions
> supplying the host driver name to guest userspace
> in order to implement "driver specific work arounds".

Pardon my ignorance, but do a lot of v4l2 apps actually do things
differently for different drivers?

IIUC, this data is so far only used as a command line flag specified
to v4l2-compliance in the guest to pass some tests. It seems like this
information could be provided out of band for that use case.

> But given such, for migration to work userspace needs
> to be notified about driver change? And what to do about
> the things it started after migration but before the
> notification?

If this was used in a local development environment or lab, I think an
equipment change is unlikely or could be avoided by the setup. IMO,
the driver actually changing during a migration is an unlikely use
case and the host could just fail to restore the guest if a driver
change is detected.

That's why I brought up GPU - we might not support e.g. migrating from
nvidia to amd, but that's probably fine and migration is still useful
most of the time.

> > > > >
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Whether USERPTR buffers are allowed.
> > > > > > > + *
> > > > > > > + * This is disabled by default as USERPTR buffers are danger=
ous, but the option
> > > > > > > + * is left to enable them if desired.
> > > > > > > + */
> > > > > > > +bool virtio_media_allow_userptr;
> > > > > > > +module_param_named(allow_userptr, virtio_media_allow_userptr=
, bool, 0660);
> > > > > >
> > > > > >
> > > > > > is this kind of thing common?
> > > >
> > > > There is one old media device that has it (saa7134).
> > > >
> > > > >
> > > > > To be honest, I don't really know. I'm also not that familiar wit=
h the USERPTR
> > > > > issues. I see a few references online about their use being disco=
uraged due to
> > > > > possible race conditions, perhaps that was the original motivatio=
n for this
> > > > > parameter (I'm not the original author of this driver).
> > > > >
> > > > > I'm open to alternatives, feel free to let me know if you have a =
preference.
> > > >
> > > > We tend to not implement USERPTR on newer drivers. I suggest you
> > > > to place the logic with regards to V4L2_MEMORY_USERPTR on a separat=
e
> > > > patch for further discussions.
> > > >
> > > > >
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * virtio_media_session_alloc - Allocate a new session.
> > > > > > > + * @vv: virtio-media device the session belongs to.
> > > > > > > + * @id: ID of the session.
> > > > > > > + * @nonblocking_dequeue: whether dequeuing of buffers should=
 be blocking or
> > > > > > > + * not.
> > > > > > > + *
> > > > > > > + * The ``id`` and ``list`` fields must still be set by the c=
aller.
> > > > > >
> > > > > > still in what sense?
> > > > >
> > > > > Based on the code below, I'm not so sure that the caller is respo=
nsible for
> > > > > setting these values. They seem to be initialized in the function=
.
> > > > >
> > > > > Perhaps Alexandre Courbot (the original author) would know more. =
Unless he
> > > > > says otherwise though I'm inclined to remove this comment.
> > > > >
> > > > > > > + */
> > > > > > > +static struct virtio_media_session *
> > > > > > > +virtio_media_session_alloc(struct virtio_media *vv, u32 id,
> > > > > > > +                          struct file *file)
> > > > > > > +{
> > > > > > > +       struct virtio_media_session *session;
> > > > > > > +       int i;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       session =3D kzalloc_obj(*session, GFP_KERNEL);
> > > > > > > +       if (!session)
> > > > > > > +               goto err_session;
> > > > > > > +
> > > > > > > +       session->shadow_buf =3D kzalloc(VIRTIO_SHADOW_BUF_SIZ=
E, GFP_KERNEL);
> > > > > > > +       if (!session->shadow_buf)
> > > > > > > +               goto err_shadow_buf;
> > > > > > > +
> > > > > > > +       ret =3D sg_alloc_table(&session->command_sgs, DESC_CH=
AIN_MAX_LEN,
> > > > > > > +                            GFP_KERNEL);
> > > > > > > +       if (ret)
> > > > > > > +               goto err_payload_sgs;
> > > > > > > +
> > > > > > > +       session->id =3D id;
> > > > > > > +       session->nonblocking_dequeue =3D file->f_flags & O_NO=
NBLOCK;
> > > > > > > +
> > > > > > > +       INIT_LIST_HEAD(&session->list);
> > > > > > > +       v4l2_fh_init(&session->fh, &vv->video_dev);
> > > > > > > +       virtio_media_session_fh_add(session, file);
> > > > > > > +
> > > > > > > +       for (i =3D 0; i <=3D VIRTIO_MEDIA_LAST_QUEUE; i++)
> > > > > > > +               INIT_LIST_HEAD(&session->queues[i].pending_dq=
bufs);
> > > > > > > +       mutex_init(&session->queues_lock);
> > > > > > > +
> > > > > > > +       init_waitqueue_head(&session->dqbuf_wait);
> > > > > > > +
> > > > > > > +       mutex_lock(&vv->sessions_lock);
> > > > > > > +       list_add_tail(&session->list, &vv->sessions);
> > > > > > > +       mutex_unlock(&vv->sessions_lock);
> > > > > > > +
> > > > > > > +       return session;
> > > > > > > +
> > > > > > > +err_payload_sgs:
> > > > > > > +       kfree(session->shadow_buf);
> > > > > > > +err_shadow_buf:
> > > > > > > +       kfree(session);
> > > > > > > +err_session:
> > > > > > > +       return ERR_PTR(-ENOMEM);
> > > > > > > +}
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * virtio_media_session_free - Free all resources of a sessi=
on.
> > > > > > > + * @vv: virtio-media device the session belongs to.
> > > > > > > + * @session: session to destroy.
> > > > > > > + *
> > > > > > > + * All the resources of @sesssion, as well as the backing me=
mory of @session
> > > > > > > + * itself, are freed.
> > > > > >
> > > > > > why @ here and `` above? And typo in the name.
> > > > >
> > > > > The `@` here was an attempt to follow the guide here for referenc=
ing function
> > > > > parameters:
> > > > > https://docs.kernel.org/doc-guide/kernel-doc.html#highlights-and-=
cross-references
> > > >
> > > > Yes. This is part of Linux Kernel kernel-doc markup: when referring=
 to
> > > > struct fields, you should use @field (or ``field`` if one wants to =
place an
> > > > asterisk on it, like ``*field``).
> > > >
> > > > >
> > > > > That being said, I don't believe this file is 100% consistent wit=
h that. I will
> > > > > spend some time cleaning up the comments throughout this patch se=
t to get them
> > > > > consistent for v5. Thanks!
> > > >
> > > > Please use it on a consistent way along the driver.
> > > >
> > > >
> > > > Thanks,
> > > > Mauro
> > >
>
