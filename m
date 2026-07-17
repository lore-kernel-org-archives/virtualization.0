Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC89175A6C
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317611; cv=pass; b=tHRZz3Ro0dz6piYi4fYdpBZ/kyYzJx/ffR7JHDMk4GT4tMMnNAx8G3Gzk+kx2ZXofEZQYKea1pRGnn0vckdWqBlxJ16Ox8IEqg3ranbLaZsFgrHDDe25ReakUzF7WVboUTSFVaOhj9wGqfpafgdT1eL6DT8O5MIJ5js6gUYHpDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317611; c=relaxed/simple;
	bh=zoiSF3JeQIqnQcvMW43JD4qB9vpjOVAXImiebAn+BPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPg0AnTEaaSCbPdKKziyHlzpKlEuArHO7nhRQ9hlMJ8uEST7wlSF+b9igkBbnzAVuVyPXGEGRZcIIqIvowRIxI3JbfDeepbtSCacWMUzVjsRYeP75TE+Lv63mzC7jN0Lc1/Xq67aDUrxNXX96kAauRmmbrCQx4mVx7P9BCfjHQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUumI9jR; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUumI9jR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso183235ad.0
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 12:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784317609; cv=none;
        d=google.com; s=arc-20260327;
        b=jYo72Re9MdtdgTDbFMGoTNg6kGukzh9VFLQCSsBI4BgTDUwA2Yw8hsYIk26g2UFtXy
         xrI5XfmhC1NLCmnB+0a6gMZBSd+q7dJtr9NYZGhJrS/EfCeVkE7urOPPs+zcUkJlRCph
         +B+R9wQLEvXTvvBTNTgChdzoLCBx+1/1/1BHyf7uXXDZmWHNiWY098As3JJ3OanUXUOg
         J2Vp1TL27csgjvoMMdB4FZ2Ny+7nRf501U2wJeEEuwMtMhh//eA0AqOpYhHlwQBnYCRj
         a6sbMI9hIGotuzgajevKrgyO29T/mynm1RdFM3kz91TF3bEQLuVPIWSsFjxIP8/f385U
         heAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsZo6eYxZiNwWUFhdwOagBZhkMfykQcqUISKPpPxaDA=;
        fh=UIQ/7Y0XddmwvcdM4aGJMCHylXvLAxwGij5qKERvqy8=;
        b=XCDs/naN2eVrnG7ZD1ZDhVMPXTBW3NmZSzXmmlUYev5WsW9aAyHj3VwZOf9xhXnYSd
         fj97GieEcOq+s0zDxbpzWF3XUFINvbRuR4F8SZ9lVBAnZrZr3TZZAg4ODQnBW4Jjv901
         AUmyfb4LDzHqJqs9EVsfe4kuCEtgKa/Fe56ODjEdX9lWZk4zYPgQgdqvqRP3gOrIm/a7
         S/pL5XzN11QoUJKI8HmkQCpaAJuZ16Q9n9tqoDET9CSbZ6RborjQ5UWCr/j7srMzVQdU
         UzRDg4uesEkIEZhUMc9ILovTdIZHCtxKNoTPxX3h0+dsxQZ3xfmqhV3UxV/FVmuwvvNh
         IxtA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784317609; x=1784922409; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nsZo6eYxZiNwWUFhdwOagBZhkMfykQcqUISKPpPxaDA=;
        b=cUumI9jRT5W2hbhVq7XaViBfHIrjQOGSOuYbMjqTwGn7dJGv1CKawHmHh3GogTYId/
         E/8+sR8HzzcGdpYjaXAKnMjBRoPH249cjU8VvcoOxGQbZganqiFkyF+mx7RmZolqNfKz
         KAaI7kLIFMtb8bqdGZeUZEtRpM1SPQ96oN/gGwyJF3KW2rjdS9hW00upcVMb86t7YEOE
         PVE2Ha9XWOjcuMvmprlcRZaTH+hk60sA/vn/QIcuVYPRbh4tjvWbo0uvYSYr+6qnSqY2
         oogYR8Ky92km9DQzIYG24AQrUDoaBtOeUVI+qbRR9C+W/jduvAbuTRHbKIazi58kHUhy
         PUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784317609; x=1784922409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nsZo6eYxZiNwWUFhdwOagBZhkMfykQcqUISKPpPxaDA=;
        b=a9r4sNsPvhzg8OD1QghPjlruSQYf2k8Jh7MpfAFWyeV3CKXLtMq1GjP1fjfrvKuG0T
         J19gVX197eVunns36NK/m519CZA0GxbxKawGWLg1FSUvg4y7sZybec/n44xvZO8cWplk
         jV3hNmMC3n5ovSJ2/Z/xw5ZZ3k6+lOY3qgd6ynjb3Lhcu76WV9Hmwq/6rwYriTaIElZP
         iYuUkXnE1jSpVZ29w53mZYCYt6gujt9bo3z+/AaMSPU3vIij1qCw7W8r0Fs81iNUW3EA
         E9A+BYIpjDoyhBNsck6u6Sxsk+4Na/X4xB8XaDv8n3oWOubeum3OgeLQHTaY4sJGB61u
         W/nA==
X-Forwarded-Encrypted: i=1; AHgh+RpDTrP70KLWsL+vSNd5Mybziz1eXmTCG7IRvllgn+RPI9//4pm3yY/Auvm+mjbubAwx3bSAycJxEU157GNCqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIhz5uGp2TQFsqTomOLXitXgFADkeatMMiANE4M2pcdyG5FCd0
	NAhCQlRoRmdz+POqnJ6mok9AHUwnaXIYIJWE0TTTJDLDUIuNb63EJ/QTj0xVO1VwX2lQo1LLJPB
	J0BY8/s6cLQwmH7KJFQ7olf/7vwwFroU5r6zvxR8=
X-Gm-Gg: AfdE7ckxUaOaUg+aW+3xnXOM/7miCiN0bxZly9ugKCnK1UFH0ahJlzDGA1Lxbb3hDbb
	Dfg/bsT6stwk8XGtjPhGGveMg9LcKERrvAolDdKQF99v7td+RcZzJGptpLMDyQFZwBsYbsPF10C
	RHZQ3PmQE517VakXF/cCLf3Iq8npQcR8iW2bJ7zbXBameSoRto88ENaoIOB+pc48bwjARgLOouK
	NS2r06A8FtcYiuItjIDy4K6d42iohuegouCEGkk27vnGH6PPFs/5Bu/apkeUPl49nJf+HA=
X-Received: by 2002:a17:902:cec8:b0:2cf:41ba:96b8 with SMTP id
 d9443c01a7336-2cf45301963mr639285ad.6.1784317608017; Fri, 17 Jul 2026
 12:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-3-briandaniels@google.com> <20260622170708-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260622170708-mutt-send-email-mst@kernel.org>
From: Brian Daniels <briandaniels@google.com>
Date: Fri, 17 Jul 2026 15:46:36 -0400
X-Gm-Features: AUfX_mw74d-5_R4YCuTDMGPYdle20s2YGu2aL-50gbj-ggLz6JZziwCSX5CR83w
Message-ID: <CAD4i_GTBkZRAnBTohkzJSh2XTx+MHkTS_KokEMQ4s0-WP+DxcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] media: virtio: Add virtio-media driver structs and
 function declarations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, adelva@google.com, 
	aesteve@redhat.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 5:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 22, 2026 at 04:43:37PM -0400, Brian Daniels wrote:
> > From: Alexandre Courbot <gnurou@gmail.com>
> >
> > Add the structs and function declarations for the new virtio-media drvi=
er.
> >
> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > ---
> >  drivers/media/virtio/virtio_media.h | 95 +++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 drivers/media/virtio/virtio_media.h
> >
> > diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio=
/virtio_media.h
> > new file mode 100644
> > index 000000000..52809d4e9
> > --- /dev/null
> > +++ b/drivers/media/virtio/virtio_media.h
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> > +
> > +/*
> > + * Virtio-media structures & functions declarations.
> > + *
> > + * Copyright (c) 2024-2025 Google LLC.
> > + */
> > +
> > +#ifndef __VIRTIO_MEDIA_H
> > +#define __VIRTIO_MEDIA_H
> > +
> > +#include <linux/virtio_config.h>
> > +#include <media/v4l2-device.h>
> > +
> > +#include "protocol.h"
> > +
> > +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> > +
> > +#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
> > +
> > +extern char *virtio_media_driver_name;
> > +extern bool virtio_media_allow_userptr;
> > +
> > +/**
> > + * struct virtio_media - Virtio-media device.
> > + * @v4l2_dev: v4l2_device for the media device.
> > + * @video_dev: video_device for the media device.
> > + * @virtio_dev: virtio device for the media device.
> > + * @commandq: virtio command queue.
> > + * @eventq: virtio event queue.
> > + * @eventq_work: work to run when events are received on @eventq.
> > + * @mmap_region: region into which MMAP buffers are mapped by the host=
.
> > + * @event_buffer: buffer for event descriptors.
> > + * @sessions: list of active sessions on the device.
> > + * @sessions_lock: protects @sessions and ``virtio_media_session::list=
``.
> > + * @events_lock: prevents concurrent processing of events.
> > + * @cmd: union of the device commands "open" and "munmap". The other
> > + *       commands are handled by @struct virtio_media_session
> > + * @resp: union of responses.to device commands "open" and "munmap". T=
he
> > + *        other responses are handled by @struct virtio_media_session
> > + * @vlock: serializes access to the command queue.
> > + * @wq: waitqueue for host responses on the command queue.
> > + */
> > +struct virtio_media {
> > +     struct v4l2_device v4l2_dev;
> > +     struct video_device video_dev;
> > +
> > +     struct virtio_device *virtio_dev;
> > +     struct virtqueue *commandq;
> > +     struct virtqueue *eventq;
> > +     struct work_struct eventq_work;
> > +
> > +     struct virtio_shm_region mmap_region;
> > +
> > +     void *event_buffer;
> > +
> > +     struct list_head sessions;
> > +     struct mutex sessions_lock; /* protects sessions list */
> > +
> > +     struct mutex events_lock; /* prevents concurrent event processing=
 */
> > +
> > +     union {
> > +             struct virtio_media_cmd_open open;
> > +             struct virtio_media_cmd_munmap munmap;
> > +     } cmd;
> > +
> > +     union {
> > +             struct virtio_media_resp_open open;
> > +             struct virtio_media_resp_munmap munmap;
> > +     } resp;
>
>
> You need DMA alignment padding for these things.

Each member of the above unions is already padded to 64-bit alignment,
is that sufficient?

If not, could you tell me what else is necessary?

> Which one can only see when I reads the actual driver 8 patches down.
> Which is why it's not a sensible way to split patches.
>
> A sensible way is to have a driver then add functionality
> in logical pieces gradually.
>

Appreciate the feedback. There was a previous comment requesting to
split the patch into c/h file pairs, but I can try reformatting it as
you suggest for v5.

> > +
> > +     struct mutex vlock; /* serializes command queue access */
> > +     wait_queue_head_t wq;
> > +};
> > +
> > +static inline struct virtio_media *
> > +to_virtio_media(struct video_device *video_dev)
> > +{
> > +     return container_of(video_dev, struct virtio_media, video_dev);
> > +}
> > +
> > +/* virtio_media_driver.c */
> > +
> > +int virtio_media_send_command(struct virtio_media *vv, struct scatterl=
ist **sgs,
> > +                           const size_t out_sgs, const size_t in_sgs,
> > +                           size_t minimum_resp_len, size_t *resp_len);
> > +void virtio_media_process_events(struct virtio_media *vv);
> > +
> > +/* virtio_media_ioctls.c */
> > +
> > +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> > +                            unsigned long arg);
> > +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> > +
> > +#endif // __VIRTIO_MEDIA_H
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
>
