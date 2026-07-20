Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9143784D
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562551; cv=pass; b=ODYGMX7MKqMIo3+MYh4jDzCtfHKMEm5DAy94SoflK0xXqI0O1T4D6xD4TwqPMjy6/ytymL2GLYf1MeLe/tMuUuf48Fw1X3sdwOd34wxzp43mbDRcrncTfji5/SCiFCGmS+o8Dk+h6SzlS3NViU6BIiqDXYikCxx97TfcxUqTV6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562551; c=relaxed/simple;
	bh=9IHkLXWFTSQVwdp6rmoJfE1bYrN4W9BCKMG9hqh6Y1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBIIvzNREL+0tkGaM+HPOAil2qsrPQe/6bFdSqRGMEQ9hTuyBrxfyKjyui+B6nTLfhMJaXZ9m0vHLBQk8M0CxiPaI/glvHvDT1CMfqt/zea8XjU033LEluXoOhM0OC2xChdSTI7NXmxneMxHkvdYI5ByfFSTQPwxjIGekLy7s5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3d6p+uD; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3d6p+uD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab97c86bdso395885ad.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784562549; cv=none;
        d=google.com; s=arc-20260327;
        b=GyZfJHxLSjhY/wgSLkpH6TRZmhOPOb8kQxnMGjIXthMaDlZnAn3MnKBtiiGAjnXCe/
         Cl+FvuksIxXuFnXi+V6c7ZyOh5+IPCWNZP+QKS2pBAYt/gGBBGUQ6qfBRIXDlp7uq6Ho
         dAeBfQD/jrK9UmEa6RZj28vReKHTNGWBrw4gJq4+Jng6OjIcTZU/uOMibfpbkRtwFrl8
         N7X3Qq08UQP+UJ8gEvjFoSmLegfyWyiCzY6XijqOIrp+l+2l56grf+MLKgBEl9xw7RYl
         J6ZNIcaoanzU71alglpenvVWA5UFMuPgiLymPsJHbJ2kDfzP8KX9hq1XvGyiuud76vFa
         3isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5oTv9im5ZGYwoCoeEyWerVwRP7Sucl0k2LnrtSJ/dM=;
        fh=KoQfxXjN5cmUARvaIiAhmFpDNwr1sJ9ASSC1xtnauAA=;
        b=flGZrqsqDDnZC9gDTpu2EqDApmILgRdxTlpw4OoYwgtsNPQhFHz3+Q5WOaqDjudWrj
         5URpgmOhhZke8oo0fqugeRhLb+KpRgOMbbcz1H505vy7eJ8xSlqRVAaIeCRuuJQPBSFc
         8VZQKJH7Uv0lhL8GLj3cGkipjCsV/RQOuwpYCDZLahyXqyEgapsTdr8kiWy0Q72lCK1E
         agzdP71Q6e5p8s8sD9MzrsAu+omptlhsif1AcBuSEKKcQYv/13VhYnSY5vgtQNIxb1YK
         9VSbNaaGDBCTX7uN72ccg0uZTrww/BxZcf8Jy7dIcVgqUa0VgB41WfUF90r5xdtaNsRl
         RyiQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784562549; x=1785167349; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s5oTv9im5ZGYwoCoeEyWerVwRP7Sucl0k2LnrtSJ/dM=;
        b=o3d6p+uDYJKDVg+7wHoUhMEUfYVY5K4LKpmsg5YgAGz/R0uRgNCaIbKBi+deIUPbdY
         MmObx0D7SMbt0p5/Uno8uc2sNjSjbNb+X5G9r2JUOBpCtqgxJCWN3XYk6yqO0TSFSqjC
         dkp+PckBd7Fx9u+nmFJieifD/X5UBTcOu/wBXQsfwZmhQXAUd1Pg+4rFht94zpWIi57N
         9WFwyx5BQT9EzoT1FDlGuum8v32nHXFN809I6qJM8MANPJMALszZcdq9chRebZ4F4gcW
         M15NZ6iA5qlMJG4tWa3iwfNmrUDhT9pjZ20mBf90s4JOz6exOpc9SHDsuww2+DO+NJEm
         /p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562549; x=1785167349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5oTv9im5ZGYwoCoeEyWerVwRP7Sucl0k2LnrtSJ/dM=;
        b=s77q1hH3HdqajXcNXSwbffIhUIA6zj+NGz56nR3H2O/pgJElLHvnRXSuop2ISIFC8u
         F7CLUgN8/EBEWRp7qdbnK8EpvhfOJIP5pCV5auJSbpIrfTgyHACXAKFp+92i5QJTgodq
         OmKTfqScPns7TSYbbxil5rHLyQy4/A9V8a0sqqhNtkZGIxv39fEzgPhVG9ZSVyQTVfdr
         53aBac/DTuejQ+jrUMZAmcl3z/9mBCykpwEcdzRB2r/JtDX1i3DCDp5XeEBmyMVSsEg2
         ZeZcEvTor/v+fTCUbRx+1ciHVgoSCxxxGCX7Bhq2C7qxSchoMrF/o0UsIqfo0znFy+G8
         2sDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1c29Mz16FyGaqmeCmClLQzLVc3DDk4kD3kyklnrSX8WWzfqrxODt0hpgtW2/ra9SrHWqYLrv6yPz+GbxiJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM/RqaKW30N9J4nSW371whcqNBr4MIcoSjTe8dBQrW4OHntLde
	6lZbkQR83CDuQ3TuIESArndlqApkL7Z38bqmVFYkA+MLv/H3Dvkdn8Rr2VmQk6C2ZmAnXoZA4cG
	UIygNCLlMvuhpfrZxtnldBzp8gFpvq1Mo0AGHWnE=
X-Gm-Gg: AR+sD10Zp3S/5SGLQNgYEfDbbFGzi+82cifZuMd0Ebn4Q4bzhVYm0GSSc7S3KDDlTUY
	eUr8diVscIBHdTbocrF+4vZrFWlY2rcDiDywLOoY+fomRKlGZobSIA7gCtZ7HuspoJ5Rgywvi1/
	IYzTD5gC+FCUTWJPuv14FT+iwyNDWc4fwcYk2oHq6iJGPiNcqAH7HvAqSJHsokZR2K/Ior5JRiB
	0tEQ5Pml8Ic4OzJY1uJXUlNkx++/rOxhlYgUrMMMFfrCFTvjwHoFPWixZXOeLRKo4y93/A=
X-Received: by 2002:a17:902:c94f:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2cf7b6989a3mr1047145ad.18.1784562548557; Mon, 20 Jul 2026
 08:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622171017-mutt-send-email-mst@kernel.org>
 <20260625201850.2981130-1-briandaniels@google.com> <20260712085726.19198fda@foz.lan>
In-Reply-To: <20260712085726.19198fda@foz.lan>
From: Brian Daniels <briandaniels@google.com>
Date: Mon, 20 Jul 2026 11:48:56 -0400
X-Gm-Features: AUfX_mw4MXvWhNuerdRMN-iqz-guHtGrBirhPauSpR73MGgBqfY_Ti9V6_c9yaQ
Message-ID: <CAD4i_GQk=GhpVfevReO_mr_KZguzo37d7zdEmuzL+f_u2ye0vg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] media: virtio: Add virtio_media_driver
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, 
	adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 2:57=E2=80=AFAM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> On Thu, 25 Jun 2026 16:18:48 -0400
> Brian Daniels <briandaniels@google.com> wrote:
>
> > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > >
> > > > virtio_media_driver.c provides the expected driver hooks, and suppo=
rt
> > > > for mmapping and polling.
> > > >
> > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > > ---
> > > >  drivers/media/virtio/virtio_media_driver.c | 959 +++++++++++++++++=
++++
> > > >  1 file changed, 959 insertions(+)
> > > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > > >
> > > > diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/m=
edia/virtio/virtio_media_driver.c
> > > > new file mode 100644
> > > > index 000000000..d6363c673
> > > > --- /dev/null
> > > > +++ b/drivers/media/virtio/virtio_media_driver.c
> > > > @@ -0,0 +1,959 @@
> > > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> > > > +
> > > > +/*
> > > > + * Virtio-media driver.
> > > > + *
> > > > + * Copyright (c) 2024-2025 Google LLC.
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/dev_printk.h>
> > > > +#include <linux/mm.h>
> > > > +#include <linux/mutex.h>
> > > > +#include <linux/scatterlist.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/videodev2.h>
> > > > +#include <linux/vmalloc.h>
> > > > +#include <linux/wait.h>
> > > > +#include <linux/workqueue.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/moduleparam.h>
> > > > +#include <linux/virtio.h>
> > > > +#include <linux/virtio_config.h>
> > > > +#include <linux/virtio_ids.h>
> > > > +
> > > > +#include <media/frame_vector.h>
> > > > +#include <media/v4l2-dev.h>
> > > > +#include <media/v4l2-event.h>
> > > > +#include <media/videobuf2-memops.h>
> > > > +#include <media/v4l2-device.h>
> > > > +#include <media/v4l2-ioctl.h>
> > > > +
> > > > +#include "protocol.h"
> > > > +#include "session.h"
> > > > +#include "virtio_media.h"
> > > > +
> > > > +#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
> > > > +
> > > > +/* ID of the SHM region into which MMAP buffer will be mapped. */
> > > > +#define VIRTIO_MEDIA_SHM_MMAP 0
> > > > +
> > > > +/*
> > > > + * Name of the driver to expose to user-space.
> > > > + *
> > > > + * This is configurable because v4l2-compliance has workarounds sp=
ecific to
> > > > + * some drivers. When proxying these directly from the host, this =
allows it to
> > > > + * apply them as needed.
> > > > + */
> > > > +char *virtio_media_driver_name;
> > > > +module_param_named(driver_name, virtio_media_driver_name, charp, 0=
660);
> > >
> > >
> > > Um. What? Not how it should be handled.
> >
> > I can remove this module param. I didn't end up using this when complia=
nce testing.
> > Instead, I patched v4l-utils:
> > https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels@googl=
e.com/
> >
> > Let me know if you think the v4l-utils patch is a good approach, otherw=
ise let
> > me know how you'd prefer to address the v4l2-compliance driver-specific=
 workounds
> > when they're being proxied with virtio-media.
>
> This kind of discussion should happen on a separate PR for v4l2-complianc=
e,
> c/c to the proper developers and maintainers of it.

I've removed the driver name module parameter in v5. Let's continue
the compliance testing discussion on the v4l-utils patch:
https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels@google.co=
m/

> >
> > > > +
> > > > +/*
> > > > + * Whether USERPTR buffers are allowed.
> > > > + *
> > > > + * This is disabled by default as USERPTR buffers are dangerous, b=
ut the option
> > > > + * is left to enable them if desired.
> > > > + */
> > > > +bool virtio_media_allow_userptr;
> > > > +module_param_named(allow_userptr, virtio_media_allow_userptr, bool=
, 0660);
> > >
> > >
> > > is this kind of thing common?
>
> There is one old media device that has it (saa7134).
>
> >
> > To be honest, I don't really know. I'm also not that familiar with the =
USERPTR
> > issues. I see a few references online about their use being discouraged=
 due to
> > possible race conditions, perhaps that was the original motivation for =
this
> > parameter (I'm not the original author of this driver).
> >
> > I'm open to alternatives, feel free to let me know if you have a prefer=
ence.
>
> We tend to not implement USERPTR on newer drivers. I suggest you
> to place the logic with regards to V4L2_MEMORY_USERPTR on a separate
> patch for further discussions.

Will do in v5.

> >
> > > > +
> > > > +/**
> > > > + * virtio_media_session_alloc - Allocate a new session.
> > > > + * @vv: virtio-media device the session belongs to.
> > > > + * @id: ID of the session.
> > > > + * @nonblocking_dequeue: whether dequeuing of buffers should be bl=
ocking or
> > > > + * not.
> > > > + *
> > > > + * The ``id`` and ``list`` fields must still be set by the caller.
> > >
> > > still in what sense?
> >
> > Based on the code below, I'm not so sure that the caller is responsible=
 for
> > setting these values. They seem to be initialized in the function.
> >
> > Perhaps Alexandre Courbot (the original author) would know more. Unless=
 he
> > says otherwise though I'm inclined to remove this comment.

Removed in v5

> > > > + */
> > > > +static struct virtio_media_session *
> > > > +virtio_media_session_alloc(struct virtio_media *vv, u32 id,
> > > > +                    struct file *file)
> > > > +{
> > > > + struct virtio_media_session *session;
> > > > + int i;
> > > > + int ret;
> > > > +
> > > > + session =3D kzalloc_obj(*session, GFP_KERNEL);
> > > > + if (!session)
> > > > +         goto err_session;
> > > > +
> > > > + session->shadow_buf =3D kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNE=
L);
> > > > + if (!session->shadow_buf)
> > > > +         goto err_shadow_buf;
> > > > +
> > > > + ret =3D sg_alloc_table(&session->command_sgs, DESC_CHAIN_MAX_LEN,
> > > > +                      GFP_KERNEL);
> > > > + if (ret)
> > > > +         goto err_payload_sgs;
> > > > +
> > > > + session->id =3D id;
> > > > + session->nonblocking_dequeue =3D file->f_flags & O_NONBLOCK;
> > > > +
> > > > + INIT_LIST_HEAD(&session->list);
> > > > + v4l2_fh_init(&session->fh, &vv->video_dev);
> > > > + virtio_media_session_fh_add(session, file);
> > > > +
> > > > + for (i =3D 0; i <=3D VIRTIO_MEDIA_LAST_QUEUE; i++)
> > > > +         INIT_LIST_HEAD(&session->queues[i].pending_dqbufs);
> > > > + mutex_init(&session->queues_lock);
> > > > +
> > > > + init_waitqueue_head(&session->dqbuf_wait);
> > > > +
> > > > + mutex_lock(&vv->sessions_lock);
> > > > + list_add_tail(&session->list, &vv->sessions);
> > > > + mutex_unlock(&vv->sessions_lock);
> > > > +
> > > > + return session;
> > > > +
> > > > +err_payload_sgs:
> > > > + kfree(session->shadow_buf);
> > > > +err_shadow_buf:
> > > > + kfree(session);
> > > > +err_session:
> > > > + return ERR_PTR(-ENOMEM);
> > > > +}
> > > > +
> > > > +/**
> > > > + * virtio_media_session_free - Free all resources of a session.
> > > > + * @vv: virtio-media device the session belongs to.
> > > > + * @session: session to destroy.
> > > > + *
> > > > + * All the resources of @sesssion, as well as the backing memory o=
f @session
> > > > + * itself, are freed.
> > >
> > > why @ here and `` above? And typo in the name.
> >
> > The `@` here was an attempt to follow the guide here for referencing fu=
nction
> > parameters:
> > https://docs.kernel.org/doc-guide/kernel-doc.html#highlights-and-cross-=
references
>
> Yes. This is part of Linux Kernel kernel-doc markup: when referring to
> struct fields, you should use @field (or ``field`` if one wants to place =
an
> asterisk on it, like ``*field``).
>
> >
> > That being said, I don't believe this file is 100% consistent with that=
. I will
> > spend some time cleaning up the comments throughout this patch set to g=
et them
> > consistent for v5. Thanks!
>
> Please use it on a consistent way along the driver.

I went through and cleaned up all of the files in v5 so they should
use kernel-doc consistently now.

> Thanks,
> Mauro
