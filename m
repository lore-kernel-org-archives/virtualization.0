Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4637AA81
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561453; cv=pass; b=cjulZwbjY9gSjoGfThtEmhK25bzhDPT47cZRx2k8EbGdec+Vqxys9tgjq7USMIdTszlxkiso54AMcgrDTu0YfFyo+a/rcHE6yQczJBZGaO8iIIcpYxXbE9+u4lMlHfzVfurAnlcw1K9co7F6d+QtNih6dW4kyIL9BkyWvruqeas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561453; c=relaxed/simple;
	bh=z6HTALdKR+S8qZiGcJUt8xHO7LZzh2vu5r30XzI1PqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9/AYOzMgJimIj+1O4o7vjCuWl91QS4ESDnqnzLIAM2FQvF+0fGp4eSxnyGDWhgPTIsG4a+VPTKICxQs21b/eWxEHh4ynVomPLQ8KcwnRQJ0ok0HFQWKI9hpBC47YRww/GFPCqDGqoy2KYnwTrPATal50Uq4uVGfaWdtAPWJO6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qa0/AuOW; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa0/AuOW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cede6375caso327565ad.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784561451; cv=none;
        d=google.com; s=arc-20260327;
        b=MxvE3F+31ADIcrjWTPqCKDTEOQqTlbfNWucV1PluB4EsCGEDuPVl6/3WJW2GUQS6d1
         kxiPkzdeKL49BG3PvYq+owvkvc2ZK1jjyYH0KAmSgw8wok20WxOLdRBrTxL5B9iJ3Ai7
         IOzdECMtlCNi7VNn+MRa0feN17ZJop3ycbqASAPXwYIFRm1hHKHJEzalEIcJEmkJ1EkP
         TrjTYGlfN9qX83mZUnCmQEckOoue1I1bup2/afVlhg7jmRWUWrP76th5LTF2ZgTbVX8/
         X3LX6SqigBQBdywvdD4GrB9m4sOU4V9MQstCi85wOX7vtuae3TCTpzrjOK2cAW1j2JKN
         aEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OaEXvFbvhMm6zafmsE8YuX95tDfvYPIMS3NPHCOYJiY=;
        fh=rvXS87ZcUBuja6cv4ZGE4bGvXafdgrPU3DLoPC5f7sI=;
        b=BlBOBDKYLFTsWrcJFV+5j8MDZ0fMTa2LHXrLEEgVQROgPjcmHeZHrL/buFb9Uq0bST
         krPyPT8GmvAEPt4hWqEKx73e3CwPK7DAiOGacOkV9m4zPX/GoWGD2MXVaWz1vlzX+hLX
         Ao0a6kgr300yUiCJiLSKA8AbIma7gXjrV1IEy7pbOD/Eik+y5WkL2UeXQjkHFl6p1Xjf
         jgCh+PI5d/Xzj7gu7dFyQ6DxxKghEBe3txneWkg44dOMGjPai9JOctmAYm/MGFxgC1zm
         PkgWjHs5ythF8RVccskO4SSurW033duumg1neOZLFSmLeHtfTUKFwYoCVWDL6EVNrq2e
         vVlQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784561451; x=1785166251; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaEXvFbvhMm6zafmsE8YuX95tDfvYPIMS3NPHCOYJiY=;
        b=qa0/AuOWXvQBPoBC1VT4i+UO6fBx1HKa+HVlyYSzx15ySV8VskHGECnuntMInBGRc9
         yeaWXa3XStwSPiTrZXNaChMNcct0gT34gie4T0O73Fu5VwAjLaAic7nPyxJr+DQhCJDS
         H21Y+pcbKhG9hR6kp/5pCsiAaF21ggwGoebpjcqBMCB/Ieq/+sQzjfIv+YWwLPO75Fn7
         QDXuQbjk+e2smr0atAfQlBZLfYjRN71uhvwdlxqsYHTNJKcxpoq8nftKkLDi03osa+B3
         hEjSTt/J+I0W5o5wkRXxX+p/a/jKxaL3ZFh82ZjeFPYl5zP2OntdgnnU19DLURObpBPR
         DnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561451; x=1785166251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaEXvFbvhMm6zafmsE8YuX95tDfvYPIMS3NPHCOYJiY=;
        b=VlrFjnB8EOOmeirQBaOqV68hfdpUqO2tuGNyqZFsbpKF7Q4KlAzBOAOIJr9x7mRL8s
         GsKqvOCkcafo7htqpFfjzBs10hU28IPi46UwCfGrTYb9OpvDwPOdMEnm95AaQhOdYPNT
         7opkkAxcloYz9Kc+Rp/qEOS9bCAWzp5hD9J9xoDF9u5zIRIhVGLlDElbLIsTSbDuRiOo
         JSTgCo13C9ovcvJ30/ku5zKokHgLi6v9/vgVJ23Y7wrLCMP3LSBIOljcs+y51RJeOUxC
         VR6FV2wW5ro5R/Eax5NbU4L69yQDOYpH9lUNVq4VU9659RxXksnJAmnFVqTM/VpYqZF2
         VxyA==
X-Forwarded-Encrypted: i=1; AHgh+Rowop2tAPDxQyTydr8mUOpsEm1AA7WKlr1aOlYgm8EBV9LLpgs2vXWa4kmvHVaiqLpUxYtQNLe2wwEPl9c6+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjjOCIfn4eFsH5ft5fGo+7lq+YmmOxrMAfiS5WJgpjsJj6ZObD
	DXLdyoTkko06ySI37FQWX50soHueuOOHc2UhIy6BEaZcYD1y8Yq/zz+ZmE6hlmBZG2DiTHOT3mx
	S+a/iQc+Qb1RhN9Hpjjo3z527Jb6DIZqoBayhzJw=
X-Gm-Gg: AR+sD12HIJVBAZpwaDQZWytHbfb7RKBWLopEiwcQ+kHtPVWasHfEDfT42XkrjVLlDqs
	qMFVwYJLMUzJsewMVMO4CGHq21m091fBsnrBmMleiDA+obKK64QGuwldGXlsZR3L9+K+nV/zUIY
	HoupR14uqMPf/s6c68h0uvGXkk/3DidffInKOWxTKKHqCkOziAnKZ6Qu458RN1MmIzNa98HLdio
	r3HqqosYBmq/rL9Qlpi7sJbjHsQBDi5+i1g6OhXHWIp6hKtM1sVPIqrnDG6
X-Received: by 2002:a17:902:e94d:b0:2c7:a13a:7fe6 with SMTP id
 d9443c01a7336-2cf7b5302afmr989835ad.10.1784561450388; Mon, 20 Jul 2026
 08:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-3-briandaniels@google.com> <20260622170708-mutt-send-email-mst@kernel.org>
 <CAD4i_GTBkZRAnBTohkzJSh2XTx+MHkTS_KokEMQ4s0-WP+DxcA@mail.gmail.com> <20260718132340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260718132340-mutt-send-email-mst@kernel.org>
From: Brian Daniels <briandaniels@google.com>
Date: Mon, 20 Jul 2026 11:30:38 -0400
X-Gm-Features: AUfX_my7bUIuVQK5CvtCwH3h8wEpjooaJfs_B6T4ePVxaDFByVxemESeA75h3sM
Message-ID: <CAD4i_GQwWkze6tcHL1mX8V8RCVKDbmHvZYMvOf2eW4NoygA4CA@mail.gmail.com>
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

On Sat, Jul 18, 2026 at 1:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 17, 2026 at 03:46:36PM -0400, Brian Daniels wrote:
> > On Mon, Jun 22, 2026 at 5:08=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Jun 22, 2026 at 04:43:37PM -0400, Brian Daniels wrote:
> > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > >
> > > > Add the structs and function declarations for the new virtio-media =
drvier.
> > > >
> > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > > ---
> > > >  drivers/media/virtio/virtio_media.h | 95 +++++++++++++++++++++++++=
++++
> > > >  1 file changed, 95 insertions(+)
> > > >  create mode 100644 drivers/media/virtio/virtio_media.h
> > > >
> > > > diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/vi=
rtio/virtio_media.h
> > > > new file mode 100644
> > > > index 000000000..52809d4e9
> > > > --- /dev/null
> > > > +++ b/drivers/media/virtio/virtio_media.h
> > > > @@ -0,0 +1,95 @@
> > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> > > > +
> > > > +/*
> > > > + * Virtio-media structures & functions declarations.
> > > > + *
> > > > + * Copyright (c) 2024-2025 Google LLC.
> > > > + */
> > > > +
> > > > +#ifndef __VIRTIO_MEDIA_H
> > > > +#define __VIRTIO_MEDIA_H
> > > > +
> > > > +#include <linux/virtio_config.h>
> > > > +#include <media/v4l2-device.h>
> > > > +
> > > > +#include "protocol.h"
> > > > +
> > > > +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> > > > +
> > > > +#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
> > > > +
> > > > +extern char *virtio_media_driver_name;
> > > > +extern bool virtio_media_allow_userptr;
> > > > +
> > > > +/**
> > > > + * struct virtio_media - Virtio-media device.
> > > > + * @v4l2_dev: v4l2_device for the media device.
> > > > + * @video_dev: video_device for the media device.
> > > > + * @virtio_dev: virtio device for the media device.
> > > > + * @commandq: virtio command queue.
> > > > + * @eventq: virtio event queue.
> > > > + * @eventq_work: work to run when events are received on @eventq.
> > > > + * @mmap_region: region into which MMAP buffers are mapped by the =
host.
> > > > + * @event_buffer: buffer for event descriptors.
> > > > + * @sessions: list of active sessions on the device.
> > > > + * @sessions_lock: protects @sessions and ``virtio_media_session::=
list``.
> > > > + * @events_lock: prevents concurrent processing of events.
> > > > + * @cmd: union of the device commands "open" and "munmap". The oth=
er
> > > > + *       commands are handled by @struct virtio_media_session
> > > > + * @resp: union of responses.to device commands "open" and "munmap=
". The
> > > > + *        other responses are handled by @struct virtio_media_sess=
ion
> > > > + * @vlock: serializes access to the command queue.
> > > > + * @wq: waitqueue for host responses on the command queue.
> > > > + */
> > > > +struct virtio_media {
> > > > +     struct v4l2_device v4l2_dev;
> > > > +     struct video_device video_dev;
> > > > +
> > > > +     struct virtio_device *virtio_dev;
> > > > +     struct virtqueue *commandq;
> > > > +     struct virtqueue *eventq;
> > > > +     struct work_struct eventq_work;
> > > > +
> > > > +     struct virtio_shm_region mmap_region;
> > > > +
> > > > +     void *event_buffer;
> > > > +
> > > > +     struct list_head sessions;
> > > > +     struct mutex sessions_lock; /* protects sessions list */
> > > > +
> > > > +     struct mutex events_lock; /* prevents concurrent event proces=
sing */
> > > > +
> > > > +     union {
> > > > +             struct virtio_media_cmd_open open;
> > > > +             struct virtio_media_cmd_munmap munmap;
> > > > +     } cmd;
> > > > +
> > > > +     union {
> > > > +             struct virtio_media_resp_open open;
> > > > +             struct virtio_media_resp_munmap munmap;
> > > > +     } resp;
> > >
> > >
> > > You need DMA alignment padding for these things.
> >
> > Each member of the above unions is already padded to 64-bit alignment,
> > is that sufficient?
> >
> > If not, could you tell me what else is necessary?
>
> Read up "What memory is DMA'able?" and following chapters in
> Documentation/core-api/dma-api-howto.rst

Great thanks!

> > > Which one can only see when I reads the actual driver 8 patches down.
> > > Which is why it's not a sensible way to split patches.
> > >
> > > A sensible way is to have a driver then add functionality
> > > in logical pieces gradually.
> > >
> >
> > Appreciate the feedback. There was a previous comment requesting to
> > split the patch into c/h file pairs, but I can try reformatting it as
> > you suggest for v5.
> >
> > > > +
> > > > +     struct mutex vlock; /* serializes command queue access */
> > > > +     wait_queue_head_t wq;
> > > > +};
> > > > +
> > > > +static inline struct virtio_media *
> > > > +to_virtio_media(struct video_device *video_dev)
> > > > +{
> > > > +     return container_of(video_dev, struct virtio_media, video_dev=
);
> > > > +}
> > > > +
> > > > +/* virtio_media_driver.c */
> > > > +
> > > > +int virtio_media_send_command(struct virtio_media *vv, struct scat=
terlist **sgs,
> > > > +                           const size_t out_sgs, const size_t in_s=
gs,
> > > > +                           size_t minimum_resp_len, size_t *resp_l=
en);
> > > > +void virtio_media_process_events(struct virtio_media *vv);
> > > > +
> > > > +/* virtio_media_ioctls.c */
> > > > +
> > > > +long virtio_media_device_ioctl(struct file *file, unsigned int cmd=
,
> > > > +                            unsigned long arg);
> > > > +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> > > > +
> > > > +#endif // __VIRTIO_MEDIA_H
> > > > --
> > > > 2.55.0.rc0.799.gd6f94ed593-goog
> > >
>
