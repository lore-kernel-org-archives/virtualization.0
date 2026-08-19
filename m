Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744F4B04AF
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137334; cv=none; b=SEsyzw9M7sN1mP8BaIF6nhW8kMyD/FvW2IPPHJmN8OF4mLbq2xl+zetmNXyRonn8lqO8YQxw2u5DRswjY05hg4LX1sc2XyQcpJTUku0Qi41a+qwrSWDMggXX05ruApITQD3wO5LZnBjEetwJyWGfvC3R888djGcNeJmxYZ4zq2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137334; c=relaxed/simple;
	bh=6p1PAGcjt0K5t/8g7Le8qU/e7XFDqF0LDi4Ad7ovFYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3CySMSp3X0F2K1qwjx7NOM0qrG5WCRvB+YLHhHEJbOnyFBH+tUw93J1b7hrIW7F9ECCcCQGigQtFaaRGUhRMeeg6qrtfgpEWuIG2V+cWjkB0C1wA4Mh5jIr//znu/1k2QbtzPOXK7BSdjvWOdCKGvw1z/9kbtqx3wQ7xp6l9wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emE0RKhu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emE0RKhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787137329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqQ27purAEfJ6ecLVlF4hB38K2PnDeCOpxASArqVvRw=;
	b=emE0RKhuKgWovdzceiyqsR+J8nnqQa3DQigRKbnddjcH4KIGUPFEZXoU7YK0hYEUJoEFAJ
	CS9Jv3rcFZLZUQUrM32xMXW6g94+ZPVLly9c0ZZZ3Wfe+OES5jawkeXK7R2/mc2ig/ybz3
	K3PQVdt6i0yuIrRWQo6v1sFoy/wOsyw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-eORUsPdLMe6ru1Mb_JeUUA-1; Wed, 19 Aug 2026 07:02:08 -0400
X-MC-Unique: eORUsPdLMe6ru1Mb_JeUUA-1
X-Mimecast-MFC-AGG-ID: eORUsPdLMe6ru1Mb_JeUUA_1787137327
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28d9206f8so551101b6e.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 04:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137327; x=1787742127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqQ27purAEfJ6ecLVlF4hB38K2PnDeCOpxASArqVvRw=;
        b=D0hPNbzU+HWMbC1GMJcRvuRA4OCc8T7kwcsFS6pdL5iUADarSMh4j4J8qJk6gC/uB/
         5p6SC6dLVuHpndPwMhLsEcoUcpW8nBABliADx6P/5Xcgx3raH/d9rBHaSP573/ME6BYl
         upzYUfm6Qq7tz4VNQng7GiFUl6eFsdCxj3BrT9+lAasoMVjihCn8cHsyvgFNFLu7B4x2
         f2tysBDiGdtJo2E7vXIDWqENUuoPRg4lm5GMBVfHeP7lUn38zqXvtZhfrZbxmQFEtdfe
         9+Qp8OtRrKsJRRdZPnaWuDEPWtMNomcxjCMsCJIDzyzyQF2m2vsEiOTTIeKbCFYTgBXc
         YPSw==
X-Forwarded-Encrypted: i=1; AHgh+RoKWJInMbC6+37Eqd3hsY8nysql2tBaal9Kkn8MLZNGFMAcRH6dsyjkziIVM1WFqXbDf8zhiiciX6LP6IAuRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZmc+GrIDW+g5VrNf0Pn2qhWOCRRpznOCwBYWENrGAIbVEzvbQ
	663/14ESIf8sJd/r0AmmkR6RSW3SB4jUZWDbXdbTGA+Kme4RMPOAxxT67j3IQbogoOQmOLhjj7+
	ydiE7gcqxYhAKxFGitshPcCjA1jv8cNOwS9br8IGQ8/jZSbKJtO/ALZ8TptG9xyhpyUYxUTNYLE
	6lz4EHk2sljy0VMiPTZGn1PgRfOVNHP3IJZEBPoyiG2Qw=
X-Gm-Gg: AR+sD13+S17D6q9sRbSim6mLYI0OUHSLuttXG//oj7fmlYtwNH+Q2hAToZ4km9SQcR5
	1ZOGo1uy3uI14Ta9ZPczoalxPJDx0tl6pc5u0NnrKGFqQLqR3RXsfKw9DXoIEV76xg1JlwnIovq
	yhqwEYdVKzrirW54aoCtz4JuwK93/vM3yfo9rW2s7C5BplruVKkkT8QVn5/QvcNe36KVdmsLysf
	8vkZst8MPys6lLekYq/7Wp2ekPWvSyoFUzIMdgPUh3IQycG
X-Received: by 2002:a05:6808:309e:b0:496:3a1:e44f with SMTP id 5614622812f47-4b2bc901f84mr2775578b6e.6.1787137326517;
        Wed, 19 Aug 2026 04:02:06 -0700 (PDT)
X-Received: by 2002:a05:6808:309e:b0:496:3a1:e44f with SMTP id
 5614622812f47-4b2bc901f84mr2775371b6e.6.1787137325554; Wed, 19 Aug 2026
 04:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260813180026.2636879-1-briandaniels@google.com> <20260813180026.2636879-5-briandaniels@google.com>
In-Reply-To: <20260813180026.2636879-5-briandaniels@google.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Wed, 19 Aug 2026 13:01:54 +0200
X-Gm-Features: AcwNN1VsZfw9s8V4hxdISCh8KaeBxe-5mN_W1w9C5VWy0Lanvh3f7AcjEpRQBis
Message-ID: <CACzuRyw5Yu4ptm5jvtVg_nikb-QxVBFuDf2DzgJmd676B0Z3oQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] media: virtio: Add ioctl operations and driver logic
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	laurent.pinchart@ideasonboard.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iv8G0wHaqGV2nFiWp7Vc9D0PJ1CQnG8ThXB40uuhJGU_1787137327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> From: Alexandre Courbot <gnurou@gmail.com>
> This patch adds the ioctl operations and the remaining driver logic
> for polling and mmapping.
> It adds drivers/media/virtio/virtio_media_ioctls.c and updates
> virtio_media_driver.c to support poll, mmap, and ioctls.
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>


Tested-by: Dorinda Bassey <dbassey@redhat.com>


On Thu, Aug 13, 2026 at 8:01=E2=80=AFPM Brian Daniels <briandaniels@google.=
com> wrote:
>
> From: Alexandre Courbot <gnurou@gmail.com>
>
> This patch adds the ioctl operations and the remaining driver logic
> for polling and mmapping.
>
> It adds drivers/media/virtio/virtio_media_ioctls.c and updates
> virtio_media_driver.c to support poll, mmap, and ioctls.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
>  drivers/media/virtio/Makefile              |    2 +-
>  drivers/media/virtio/virtio_media_driver.c |  195 +++
>  drivers/media/virtio/virtio_media_ioctls.c | 1319 ++++++++++++++++++++
>  3 files changed, 1515 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/media/virtio/virtio_media_ioctls.c
>
> diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefil=
e
> index 8290d8506..f1bc8a3ce 100644
> --- a/drivers/media/virtio/Makefile
> +++ b/drivers/media/virtio/Makefile
> @@ -2,6 +2,6 @@
>  #
>  # Makefile for the virtio-media device driver.
>
> -virtio-media-objs :=3D scatterlist_builder.o virtio_media_driver.o
> +virtio-media-objs :=3D scatterlist_builder.o virtio_media_ioctls.o virti=
o_media_driver.o
>
>  obj-$(CONFIG_MEDIA_VIRTIO) +=3D virtio-media.o
> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index ef8065e34..5840bb349 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2024-2026 Google LLC.
>   */
>
> +#include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/dev_printk.h>
>  #include <linux/mutex.h>
> @@ -19,6 +20,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/workqueue.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/poll.h>
> +#include <linux/mm.h>
>
>  #include <media/v4l2-dev.h>
>  #include <media/v4l2-device.h>
> @@ -31,6 +34,12 @@
>
>  #define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
>
> +/* ID of the SHM region into which MMAP buffer will be mapped. */
> +#define VIRTIO_MEDIA_SHM_MMAP 0
> +
> +/* Bit mask for the VIRTIO_MEDIA_MMAP_FLAG_RW flag */
> +#define VIRTIO_MEDIA_MMAP_FLAG_RW_MASK BIT(VIRTIO_MEDIA_MMAP_FLAG_RW)
> +
>  /**
>   * virtio_media_session_alloc() - Allocate a new session.
>   * @vv: virtio-media device the session belongs to.
> @@ -593,10 +602,191 @@ static int virtio_media_device_close(struct file *=
file)
>         return virtio_media_session_close(vv, session);
>  }
>
> +/**
> + * virtio_media_device_poll() - Poll logic for a virtio-media device.
> + * @file: file of the session to poll.
> + * @wait: poll table to wait on.
> + */
> +static __poll_t virtio_media_device_poll(struct file *file, poll_table *=
wait)
> +{
> +       struct virtio_media_session *session =3D
> +               fh_to_session(file->private_data);
> +       enum v4l2_buf_type capture_type =3D
> +               session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE=
 :
> +                                      V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +       enum v4l2_buf_type output_type =3D
> +               session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE =
:
> +                                      V4L2_BUF_TYPE_VIDEO_OUTPUT;
> +       struct virtio_media_queue_state *capture_queue =3D
> +               &session->queues[capture_type];
> +       struct virtio_media_queue_state *output_queue =3D
> +               &session->queues[output_type];
> +       __poll_t req_events =3D poll_requested_events(wait);
> +       __poll_t rc =3D 0;
> +
> +       poll_wait(file, &session->dqbuf_wait, wait);
> +       poll_wait(file, &session->fh.wait, wait);
> +
> +       mutex_lock(&session->queues_lock);
> +       if (req_events & (EPOLLIN | EPOLLRDNORM)) {
> +               if (!capture_queue->streaming ||
> +                   (capture_queue->queued_bufs =3D=3D 0 &&
> +                    list_empty(&capture_queue->pending_dqbufs)))
> +                       rc |=3D EPOLLERR;
> +               else if (!list_empty(&capture_queue->pending_dqbufs))
> +                       rc |=3D EPOLLIN | EPOLLRDNORM;
> +       }
> +       if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
> +               if (!output_queue->streaming)
> +                       rc |=3D EPOLLERR;
> +               else if (output_queue->queued_bufs <
> +                        output_queue->allocated_bufs)
> +                       rc |=3D EPOLLOUT | EPOLLWRNORM;
> +       }
> +       mutex_unlock(&session->queues_lock);
> +
> +       if (v4l2_event_pending(&session->fh))
> +               rc |=3D EPOLLPRI;
> +
> +       return rc;
> +}
> +
> +static void virtio_media_vma_close_locked(struct vm_area_struct *vma)
> +{
> +       struct virtio_media *vv =3D vma->vm_private_data;
> +       struct virtio_media_cmd_munmap *cmd_munmap =3D &vv->cmd.munmap;
> +       struct virtio_media_resp_munmap *resp_munmap =3D &vv->resp.munmap=
;
> +       struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> +       struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> +       int ret;
> +
> +       sg_set_buf(&cmd_sg, cmd_munmap, sizeof(*cmd_munmap));
> +       sg_mark_end(&cmd_sg);
> +
> +       sg_set_buf(&resp_sg, resp_munmap, sizeof(*resp_munmap));
> +       sg_mark_end(&resp_sg);
> +
> +       cmd_munmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MUNMAP;
> +       cmd_munmap->driver_addr =3D
> +               (vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;
> +       ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mun=
map),
> +                                       NULL);
> +       if (ret < 0) {
> +               v4l2_err(&vv->v4l2_dev, "host failed to unmap buffer: %d\=
n",
> +                        ret);
> +       }
> +}
> +
> +/**
> + * virtio_media_vma_close() - Close a MMAP buffer mapping.
> + * @vma: VMA of the mapping to close.
> + *
> + * Inform the host that a previously created MMAP mapping is no longer n=
eeded
> + * and can be removed.
> + */
> +static void virtio_media_vma_close(struct vm_area_struct *vma)
> +{
> +       struct virtio_media *vv =3D vma->vm_private_data;
> +
> +       mutex_lock(&vv->vlock);
> +       virtio_media_vma_close_locked(vma);
> +       mutex_unlock(&vv->vlock);
> +}
> +
> +static const struct vm_operations_struct virtio_media_vm_ops =3D {
> +       .close =3D virtio_media_vma_close,
> +};
> +
> +/**
> + * virtio_media_device_mmap() - Perform a mmap request from userspace.
> + * @file: opened file of the session to map for.
> + * @vma: VM area struct describing the desired mapping.
> + *
> + * This requests the host to map a MMAP buffer for us, so we can then ma=
ke that
> + * mapping visible into user-space address space.
> + */
> +static int virtio_media_device_mmap(struct file *file,
> +                                   struct vm_area_struct *vma)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D
> +               fh_to_session(file->private_data);
> +       struct virtio_media_cmd_mmap *cmd_mmap =3D &session->cmd.mmap;
> +       struct virtio_media_resp_mmap *resp_mmap =3D &session->resp.mmap;
> +       struct scatterlist cmd_sg =3D {}, resp_sg =3D {};
> +       struct scatterlist *sgs[2] =3D { &cmd_sg, &resp_sg };
> +       int ret;
> +
> +       if (!(vma->vm_flags & VM_SHARED))
> +               return -EINVAL;
> +       if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
> +               return -EINVAL;
> +
> +       mutex_lock(&vv->vlock);
> +
> +       cmd_mmap->hdr.cmd =3D VIRTIO_MEDIA_CMD_MMAP;
> +       cmd_mmap->session_id =3D session->id;
> +       cmd_mmap->flags =3D
> +               (vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW_MA=
SK : 0;
> +       cmd_mmap->offset =3D vma->vm_pgoff << PAGE_SHIFT;
> +
> +       sg_set_buf(&cmd_sg, cmd_mmap, sizeof(*cmd_mmap));
> +       sg_mark_end(&cmd_sg);
> +
> +       sg_set_buf(&resp_sg, resp_mmap, sizeof(*resp_mmap));
> +       sg_mark_end(&resp_sg);
> +
> +       /*
> +        * The host performs reference counting and is smart enough to re=
turn
> +        * the same guest physical address if this is called several time=
s on
> +        * the same
> +        * buffer.
> +        */
> +       ret =3D virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mma=
p),
> +                                       NULL);
> +       if (ret < 0)
> +               goto end;
> +
> +       vma->vm_private_data =3D vv;
> +       /*
> +        * Keep the guest address at which the buffer is mapped since we =
will
> +        * use that to unmap.
> +        */
> +       vma->vm_pgoff =3D (resp_mmap->driver_addr + vv->mmap_region.addr)=
 >>
> +                       PAGE_SHIFT;
> +
> +       /*
> +        * We cannot let the mapping be larger than the buffer.
> +        */
> +       if (vma->vm_end - vma->vm_start > PAGE_ALIGN(resp_mmap->len)) {
> +               dev_dbg(&video_dev->dev,
> +                       "invalid MMAP, as it would overflow buffer length=
\n");
> +               virtio_media_vma_close_locked(vma);
> +               ret =3D -EINVAL;
> +               goto end;
> +       }
> +
> +       ret =3D io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +                                vma->vm_end - vma->vm_start,
> +                                vma->vm_page_prot);
> +       if (ret)
> +               goto end;
> +
> +       vma->vm_ops =3D &virtio_media_vm_ops;
> +
> +end:
> +       mutex_unlock(&vv->vlock);
> +       return ret;
> +}
> +
>  static const struct v4l2_file_operations virtio_media_fops =3D {
>         .owner =3D THIS_MODULE,
>         .open =3D virtio_media_device_open,
>         .release =3D virtio_media_device_close,
> +       .poll =3D virtio_media_device_poll,
> +       .unlocked_ioctl =3D virtio_media_device_ioctl,
> +       .mmap =3D virtio_media_device_mmap,
>  };
>
>  static int virtio_media_probe(struct virtio_device *virtio_dev)
> @@ -654,9 +844,14 @@ static int virtio_media_probe(struct virtio_device *=
virtio_dev)
>         vv->eventq =3D vqs[1];
>         INIT_WORK(&vv->eventq_work, virtio_media_event_work);
>
> +       /* Get MMAP buffer mapping SHM region */
> +       virtio_get_shm_region(virtio_dev, &vv->mmap_region,
> +                             VIRTIO_MEDIA_SHM_MMAP);
> +
>         vd =3D &vv->video_dev;
>         vd->v4l2_dev =3D &vv->v4l2_dev;
>         vd->vfl_type =3D VFL_TYPE_VIDEO;
> +       vd->ioctl_ops =3D &virtio_media_ioctl_ops;
>         vd->fops =3D &virtio_media_fops;
>         vd->release =3D video_device_release_empty;
>         strscpy(vd->name, "virtio-media", sizeof(vd->name));
> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 000000000..f0b82b5ec
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
> @@ -0,0 +1,1319 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> +
> +/*
> + * Ioctl implementations for the virtio-media driver.
> + *
> + * Copyright (c) 2024-2026 Google LLC.
> + */
> +
> +#include <linux/mutex.h>
> +#include <linux/videodev2.h>
> +#include <linux/virtio_config.h>
> +#include <linux/vmalloc.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +
> +#include "scatterlist_builder.h"
> +#include "virtio_media.h"
> +
> +/**
> + * virtio_media_send_r_ioctl() - Send a read-only ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + *
> + * Send an ioctl that has no driver payload, but expects a response from=
 the
> + * host (i.e. an ioctl specified with ``_IOR``).
> + */
> +static int virtio_media_send_r_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                    void *ioctl_data, size_t ioctl_data_=
len)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[3];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload */
> +       ret =3D scatterlist_builder_add_data(&builder, ioctl_data,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 1, 2,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                       ioctl_data_len, NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(&builder, 2, ioctl_data=
);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to retrieve response descriptor chain\n"=
);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_w_ioctl() - Send a write-only ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + *
> + * Send an ioctl that does not expect a reply beyond an error status (i.=
e. an
> + * ioctl specified with ``_IOW``) to the host.
> + */
> +static int virtio_media_send_w_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                    const void *ioctl_data,
> +                                    size_t ioctl_data_len)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[3];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Command payload */
> +       ret =3D scatterlist_builder_add_data(&builder, (void *)ioctl_data=
,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 2, 1,
> +                                       sizeof(struct virtio_media_resp_i=
octl),
> +                                       NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_wr_ioctl() - Send a read-write ioctl to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ioctl_data: pointer to the ioctl payload.
> + * @ioctl_data_len: length in bytes of the ioctl payload.
> + * @minimum_resp_payload: minimum expected length of the response's payl=
oad.
> + *
> + * Sends an ioctl that expects a response of exactly the same size as th=
e
> + * input (i.e. an ioctl specified with ``_IOWR``) to the host.
> + *
> + * This corresponds to what most V4L2 ioctls do. For instance
> + * ``VIDIOC_ENUM_FMT`` takes a partially-initialized &struct v4l2_fmtdes=
c
> + * and returns its filled version.
> + */
> +static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                     void *ioctl_data, size_t ioctl_data=
_len,
> +                                     size_t minimum_resp_payload)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct scatterlist *sgs[4];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* Command payload */
> +       ret =3D scatterlist_builder_add_data(&builder, ioctl_data,
> +                                          ioctl_data_len);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to prepare command descriptor chain\n");
> +               return ret;
> +       }
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload, same as command */
> +       ret =3D scatterlist_builder_add_descriptor(&builder, 1);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D virtio_media_send_command(vv, sgs, 2, 2,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                               minimum_resp_payload,
> +                                       NULL);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D scatterlist_builder_retrieve_data(&builder, 3, ioctl_data=
);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to retrieve response descriptor chain\n"=
);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_buffer_ioctl() - Send an ioctl taking a buffer as
> + * parameter to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @b: &struct v4l2_buffer to be sent as the ioctl payload.
> + *
> + * Buffers can require an additional descriptor to send their planes arr=
ay, and
> + * can have pointers to userspace memory hence this dedicated function.
> + */
> +static int virtio_media_send_buffer_ioctl(struct v4l2_fh *fh, u32 ioctl,
> +                                         struct v4l2_buffer *b)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       struct v4l2_plane *orig_planes =3D NULL;
> +       struct scatterlist *sgs[64];
> +       /*
> +        * End of the device-readable buffer SGs, to reuse in device-writ=
able
> +        * section.
> +        */
> +       size_t num_cmd_sgs;
> +       size_t end_buf_sg;
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +       size_t resp_len;
> +       int ret;
> +       int i;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
> +               orig_planes =3D b->m.planes;
> +
> +       /* Command descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, ioct=
l);
> +       if (ret)
> +               return ret;
> +
> +       /* Command payload (struct v4l2_buffer) */
> +       ret =3D scatterlist_builder_add_buffer(&builder, b);
> +       if (ret < 0)
> +               return ret;
> +
> +       end_buf_sg =3D builder.cur_sg;
> +       num_cmd_sgs =3D builder.cur_sg;
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload (same as input, but no userptr mapping) */
> +       for (i =3D 1; i < end_buf_sg; i++) {
> +               ret =3D scatterlist_builder_add_descriptor(&builder, i);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
> +                                       builder.cur_sg - num_cmd_sgs,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                       sizeof(*b), &resp_len);
> +       if (ret < 0)
> +               return ret;
> +
> +       resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +       /* Make sure that the reply length covers our v4l2_buffer */
> +       if (resp_len < sizeof(*b))
> +               return -EINVAL;
> +
> +       ret =3D scatterlist_builder_retrieve_buffer(&builder, num_cmd_sgs=
 + 1, b,
> +                                                 orig_planes);
> +       if (ret) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "failed to retrieve response descriptor chain\n"=
);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_send_ext_controls_ioctl() - Send an ioctl taking extende=
d
> + * controls as parameters to the device.
> + * @fh: file handler of the session doing the ioctl.
> + * @ioctl: ``VIDIOC_*`` ioctl code.
> + * @ctrls: &struct v4l2_ext_controls to be sent as the ioctl payload.
> + *
> + * Queues an ioctl that sends a &struct v4l2_ext_controls to the host an=
d
> + * receives an updated version.
> + *
> + * &struct v4l2_ext_controls has a pointer to an array of
> + * &struct v4l2_ext_control, and also potentially pointers to user-space=
 memory
> + * that we need to map properly, hence the dedicated function.
> + */
> +static int virtio_media_send_ext_controls_ioctl(struct v4l2_fh *fh, u32 =
ioctl,
> +                                               struct v4l2_ext_controls =
*ctrls)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D fh_to_session(fh);
> +       size_t num_cmd_sgs;
> +       size_t end_ctrls_sg;
> +       struct v4l2_ext_control *controls_backup =3D ctrls->controls;
> +       const u32 num_ctrls =3D ctrls->count;
> +       struct scatterlist *sgs[64];
> +       struct scatterlist_builder builder =3D {
> +               .descs =3D session->command_sgs.sgl,
> +               .num_descs =3D DESC_CHAIN_MAX_LEN,
> +               .cur_desc =3D 0,
> +               .shadow_buffer =3D session->shadow_buf,
> +               .shadow_buffer_size =3D VIRTIO_SHADOW_BUF_SIZE,
> +               .shadow_buffer_pos =3D 0,
> +               .sgs =3D sgs,
> +               .num_sgs =3D ARRAY_SIZE(sgs),
> +               .cur_sg =3D 0,
> +       };
> +       size_t resp_len =3D 0;
> +       int i;
> +
> +       /* Command descriptor */
> +       int ret =3D scatterlist_builder_add_ioctl_cmd(&builder, session, =
ioctl);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* v4l2_controls */
> +       ret =3D scatterlist_builder_add_ext_ctrls(&builder, ctrls);
> +       if (ret)
> +               return ret;
> +
> +       end_ctrls_sg =3D builder.cur_sg;
> +
> +       ret =3D scatterlist_builder_add_ext_ctrls_userptrs(&builder, ctrl=
s);
> +       if (ret)
> +               return ret;
> +
> +       num_cmd_sgs =3D builder.cur_sg;
> +
> +       /* Response descriptor */
> +       ret =3D scatterlist_builder_add_ioctl_resp(&builder, session);
> +       if (ret)
> +               return ret;
> +
> +       /* Response payload (same as input but without userptrs) */
> +       for (i =3D 1; i < end_ctrls_sg; i++) {
> +               ret =3D scatterlist_builder_add_descriptor(&builder, i);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
> +                                       builder.cur_sg - num_cmd_sgs,
> +                                       sizeof(struct virtio_media_resp_i=
octl) +
> +                                       sizeof(*ctrls),
> +                                       &resp_len);
> +
> +       /* Just in case the host touched these. */
> +       ctrls->controls =3D controls_backup;
> +       if (ctrls->count !=3D num_ctrls) {
> +               v4l2_err(&vv->v4l2_dev,
> +                        "device returned a number of controls different =
than the one submitted\n");
> +       }
> +       if (ctrls->count > num_ctrls)
> +               return -ENOSPC;
> +
> +       /*
> +        * Even if we have received an error, we may need to read our pay=
load
> +        * back.
> +        */
> +       if (ret < 0 && resp_len >=3D sizeof(struct virtio_media_resp_ioct=
l) +
> +                                          sizeof(*ctrls)) {
> +               /*
> +                * Deliberately ignore the error here as we want to retur=
n the
> +                * previous one.
> +                */
> +               scatterlist_builder_retrieve_ext_ctrls(&builder,
> +                                                      num_cmd_sgs + 1, c=
trls);
> +               return ret;
> +       }
> +
> +       resp_len -=3D sizeof(struct virtio_media_resp_ioctl);
> +
> +       /* Make sure that the reply's length covers our v4l2_ext_controls=
 */
> +       if (resp_len < sizeof(*ctrls))
> +               return -EINVAL;
> +
> +       ret =3D scatterlist_builder_retrieve_ext_ctrls(&builder, num_cmd_=
sgs + 1,
> +                                                    ctrls);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/**
> + * virtio_media_clear_queue() - clear all pending buffers on a streamed-=
off
> + *                              queue.
> + * @session: session which the queue to clear belongs to.
> + * @queue: state of the queue to clear.
> + *
> + * Helper function to clear the list of buffers waiting to be dequeued o=
n a
> + * queue that has just been streamed off.
> + */
> +static void virtio_media_clear_queue(struct virtio_media_session *sessio=
n,
> +                                    struct virtio_media_queue_state *que=
ue)
> +{
> +       struct list_head *p, *n;
> +       int i;
> +
> +       mutex_lock(&session->queues_lock);
> +
> +       list_for_each_safe(p, n, &queue->pending_dqbufs) {
> +               struct virtio_media_buffer *dqbuf =3D
> +                       list_entry(p, struct virtio_media_buffer, list);
> +
> +               list_del(&dqbuf->list);
> +       }
> +
> +       /* All buffers are now dequeued. */
> +       for (i =3D 0; i < queue->allocated_bufs; i++)
> +               queue->buffers[i].buffer.flags =3D 0;
> +
> +       queue->queued_bufs =3D 0;
> +       queue->streaming =3D false;
> +       queue->is_capture_last =3D false;
> +
> +       mutex_unlock(&session->queues_lock);
> +}
> +
> +/*
> + * Macros suitable for defining ioctls with a constant size payload.
> + */
> +
> +#define SIMPLE_WR_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,   \
> +                                      payload_t *payload)            \
> +       {                                                             \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);          \
> +               return virtio_media_send_wr_ioctl(vfh, ioctl, payload,\
> +                                                 sizeof(*payload),   \
> +                                                 sizeof(*payload));  \
> +       }
> +#define SIMPLE_R_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,  \
> +                                      payload_t *payload)           \
> +       {                                                            \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);         \
> +               return virtio_media_send_r_ioctl(vfh, ioctl, payload,\
> +                                                sizeof(*payload));  \
> +       }
> +#define SIMPLE_W_IOCTL(name, ioctl, payload_t)                       \
> +       static int virtio_media_##name(struct file *file, void *fh,  \
> +                                      payload_t *payload)           \
> +       {                                                            \
> +               struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);         \
> +               return virtio_media_send_w_ioctl(vfh, ioctl, payload,\
> +                                                sizeof(*payload));  \
> +       }
> +
> +/*
> + * V4L2 ioctl handlers.
> + *
> + * Most of these functions just forward the ioctl to the host, for these=
 we can
> + * use one of the SIMPLE_*_IOCTL macros. Exceptions that have their own
> + * standalone function follow.
> + */
> +
> +SIMPLE_WR_IOCTL(enum_fmt, VIDIOC_ENUM_FMT, struct v4l2_fmtdesc)
> +SIMPLE_WR_IOCTL(g_fmt, VIDIOC_G_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(s_fmt, VIDIOC_S_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(try_fmt, VIDIOC_TRY_FMT, struct v4l2_format)
> +SIMPLE_WR_IOCTL(enum_framesizes, VIDIOC_ENUM_FRAMESIZES,
> +               struct v4l2_frmsizeenum)
> +SIMPLE_WR_IOCTL(enum_frameintervals, VIDIOC_ENUM_FRAMEINTERVALS,
> +               struct v4l2_frmivalenum)
> +SIMPLE_WR_IOCTL(query_ext_ctrl, VIDIOC_QUERY_EXT_CTRL,
> +               struct v4l2_query_ext_ctrl)
> +SIMPLE_WR_IOCTL(s_dv_timings, VIDIOC_S_DV_TIMINGS, struct v4l2_dv_timing=
s)
> +SIMPLE_WR_IOCTL(g_dv_timings, VIDIOC_G_DV_TIMINGS, struct v4l2_dv_timing=
s)
> +SIMPLE_R_IOCTL(query_dv_timings, VIDIOC_QUERY_DV_TIMINGS,
> +              struct v4l2_dv_timings)
> +SIMPLE_WR_IOCTL(enum_dv_timings, VIDIOC_ENUM_DV_TIMINGS,
> +               struct v4l2_enum_dv_timings)
> +SIMPLE_WR_IOCTL(dv_timings_cap, VIDIOC_DV_TIMINGS_CAP,
> +               struct v4l2_dv_timings_cap)
> +SIMPLE_WR_IOCTL(enuminput, VIDIOC_ENUMINPUT, struct v4l2_input)
> +SIMPLE_WR_IOCTL(querymenu, VIDIOC_QUERYMENU, struct v4l2_querymenu)
> +SIMPLE_WR_IOCTL(enumoutput, VIDIOC_ENUMOUTPUT, struct v4l2_output)
> +SIMPLE_WR_IOCTL(enumaudio, VIDIOC_ENUMAUDIO, struct v4l2_audio)
> +SIMPLE_R_IOCTL(g_audio, VIDIOC_G_AUDIO, struct v4l2_audio)
> +SIMPLE_W_IOCTL(s_audio, VIDIOC_S_AUDIO, const struct v4l2_audio)
> +SIMPLE_WR_IOCTL(enumaudout, VIDIOC_ENUMAUDOUT, struct v4l2_audioout)
> +SIMPLE_R_IOCTL(g_audout, VIDIOC_G_AUDOUT, struct v4l2_audioout)
> +SIMPLE_W_IOCTL(s_audout, VIDIOC_S_AUDOUT, const struct v4l2_audioout)
> +SIMPLE_WR_IOCTL(g_modulator, VIDIOC_G_MODULATOR, struct v4l2_modulator)
> +SIMPLE_W_IOCTL(s_modulator, VIDIOC_S_MODULATOR, const struct v4l2_modula=
tor)
> +SIMPLE_WR_IOCTL(g_selection, VIDIOC_G_SELECTION, struct v4l2_selection)
> +SIMPLE_WR_IOCTL(s_selection, VIDIOC_S_SELECTION, struct v4l2_selection)
> +SIMPLE_R_IOCTL(g_enc_index, VIDIOC_G_ENC_INDEX, struct v4l2_enc_idx)
> +SIMPLE_WR_IOCTL(encoder_cmd, VIDIOC_ENCODER_CMD, struct v4l2_encoder_cmd=
)
> +SIMPLE_WR_IOCTL(try_encoder_cmd, VIDIOC_TRY_ENCODER_CMD,
> +               struct v4l2_encoder_cmd)
> +SIMPLE_WR_IOCTL(try_decoder_cmd, VIDIOC_TRY_DECODER_CMD,
> +               struct v4l2_decoder_cmd)
> +SIMPLE_WR_IOCTL(g_parm, VIDIOC_G_PARM, struct v4l2_streamparm)
> +SIMPLE_WR_IOCTL(s_parm, VIDIOC_S_PARM, struct v4l2_streamparm)
> +SIMPLE_R_IOCTL(g_std, VIDIOC_G_STD, v4l2_std_id)
> +SIMPLE_R_IOCTL(querystd, VIDIOC_QUERYSTD, v4l2_std_id)
> +SIMPLE_WR_IOCTL(enumstd, VIDIOC_ENUMSTD, struct v4l2_standard)
> +SIMPLE_WR_IOCTL(g_tuner, VIDIOC_G_TUNER, struct v4l2_tuner)
> +SIMPLE_W_IOCTL(s_tuner, VIDIOC_S_TUNER, const struct v4l2_tuner)
> +SIMPLE_WR_IOCTL(g_frequency, VIDIOC_G_FREQUENCY, struct v4l2_frequency)
> +SIMPLE_W_IOCTL(s_frequency, VIDIOC_S_FREQUENCY, const struct v4l2_freque=
ncy)
> +SIMPLE_WR_IOCTL(enum_freq_bands, VIDIOC_ENUM_FREQ_BANDS,
> +               struct v4l2_frequency_band)
> +SIMPLE_WR_IOCTL(g_sliced_vbi_cap, VIDIOC_G_SLICED_VBI_CAP,
> +               struct v4l2_sliced_vbi_cap)
> +SIMPLE_W_IOCTL(s_hw_freq_seek, VIDIOC_S_HW_FREQ_SEEK,
> +              const struct v4l2_hw_freq_seek)
> +
> +/*
> + * QUERYCAP is handled by reading the configuration area.
> + */
> +
> +static int virtio_media_querycap(struct file *file, void *fh,
> +                                struct v4l2_capability *cap)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +
> +       strscpy(cap->bus_info, "platform:virtio-media");
> +       strscpy(cap->driver, VIRTIO_MEDIA_DEFAULT_DRIVER_NAME);
> +
> +       virtio_cread_bytes(vv->virtio_dev, 8, cap->card, sizeof(cap->card=
));
> +
> +       cap->capabilities =3D video_dev->device_caps | V4L2_CAP_DEVICE_CA=
PS;
> +       cap->device_caps =3D video_dev->device_caps;
> +
> +       return 0;
> +}
> +
> +/*
> + * Extended control ioctls are handled mostly identically.
> + */
> +
> +static int virtio_media_g_ext_ctrls(struct file *file, void *fh,
> +                                   struct v4l2_ext_controls *ctrls)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +
> +       return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_G_EXT_CTR=
LS,
> +                                                   ctrls);
> +}
> +
> +static int virtio_media_s_ext_ctrls(struct file *file, void *fh,
> +                                   struct v4l2_ext_controls *ctrls)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +
> +       return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTR=
LS,
> +                                                   ctrls);
> +}
> +
> +static int virtio_media_try_ext_ctrls(struct file *file, void *fh,
> +                                     struct v4l2_ext_controls *ctrls)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +
> +       return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_TRY_EXT_C=
TRLS,
> +                                                   ctrls);
> +}
> +
> +/*
> + * Subscribe/unsubscribe from an event.
> + */
> +
> +static int
> +virtio_media_subscribe_event(struct v4l2_fh *fh,
> +                            const struct v4l2_event_subscription *sub)
> +{
> +       struct video_device *video_dev =3D fh->vdev;
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       int ret;
> +
> +       /* First subscribe to the event in the guest. */
> +       switch (sub->type) {
> +       case V4L2_EVENT_SOURCE_CHANGE:
> +               ret =3D v4l2_src_change_event_subscribe(fh, sub);
> +               break;
> +       default:
> +               ret =3D v4l2_event_subscribe(fh, sub, 1, NULL);
> +               break;
> +       }
> +       if (ret)
> +               return ret;
> +
> +       /* Then ask the host to signal us these events. */
> +       ret =3D virtio_media_send_w_ioctl(fh, VIDIOC_SUBSCRIBE_EVENT, sub=
,
> +                                       sizeof(*sub));
> +       if (ret < 0) {
> +               v4l2_event_unsubscribe(fh, sub);
> +               return ret;
> +       }
> +
> +       /*
> +        * Subscribing to an event may result in that event being signale=
d
> +        * immediately. Process all pending events to make sure we don't
> +        * miss it.
> +        */
> +       if (sub->flags & V4L2_EVENT_SUB_FL_SEND_INITIAL)
> +               virtio_media_process_events(vv);
> +
> +       return 0;
> +}
> +
> +static int
> +virtio_media_unsubscribe_event(struct v4l2_fh *fh,
> +                              const struct v4l2_event_subscription *sub)
> +{
> +       int ret =3D virtio_media_send_w_ioctl(fh, VIDIOC_UNSUBSCRIBE_EVEN=
T, sub,
> +                                       sizeof(*sub));
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D v4l2_event_unsubscribe(fh, sub);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/*
> + * Streamon/off affect the local queue state.
> + */
> +
> +static int virtio_media_streamon(struct file *file, void *fh,
> +                                enum v4l2_buf_type i)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       int ret;
> +
> +       if (i > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       ret =3D virtio_media_send_w_ioctl(vfh, VIDIOC_STREAMON, &i, sizeo=
f(i));
> +       if (ret < 0)
> +               return ret;
> +
> +       session->queues[i].streaming =3D true;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_streamoff(struct file *file, void *fh,
> +                                 enum v4l2_buf_type i)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       int ret;
> +
> +       if (i > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       ret =3D virtio_media_send_w_ioctl(vfh, VIDIOC_STREAMOFF, &i, size=
of(i));
> +       if (ret < 0)
> +               return ret;
> +
> +       virtio_media_clear_queue(session, &session->queues[i]);
> +
> +       return 0;
> +}
> +
> +/*
> + * Buffer creation/queuing functions deal with the local driver state.
> + */
> +
> +static int virtio_media_reqbufs(struct file *file, void *fh,
> +                               struct v4l2_requestbuffers *b)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       struct virtio_media_queue_state *queue;
> +       int ret;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       if (b->memory =3D=3D V4L2_MEMORY_USERPTR)
> +               return -EINVAL;
> +
> +       ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_REQBUFS, b, sizeof=
(*b),
> +                                        sizeof(*b));
> +       if (ret)
> +               return ret;
> +
> +       queue =3D &session->queues[b->type];
> +
> +       /* REQBUFS(0) is an implicit STREAMOFF. */
> +       if (b->count =3D=3D 0)
> +               virtio_media_clear_queue(session, queue);
> +
> +       vfree(queue->buffers);
> +       queue->buffers =3D NULL;
> +
> +       if (b->count > 0) {
> +               queue->buffers =3D
> +                       vzalloc(sizeof(struct virtio_media_buffer) * b->c=
ount);
> +               if (!queue->buffers)
> +                       return -ENOMEM;
> +       }
> +
> +       queue->allocated_bufs =3D b->count;
> +
> +       /*
> +        * If a multiplanar queue is successfully used here, this means
> +        * we are using the multiplanar interface.
> +        */
> +       if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
> +               session->uses_mplane =3D true;
> +
> +       b->capabilities &=3D ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
> +
> +       /* We do not support DMABUF yet. */
> +       b->capabilities &=3D ~V4L2_BUF_CAP_SUPPORTS_DMABUF;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_querybuf(struct file *file, void *fh,
> +                                struct v4l2_buffer *b)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       struct virtio_media_queue_state *queue;
> +       struct virtio_media_buffer *buffer;
> +
> +       int ret =3D virtio_media_send_buffer_ioctl(vfh, VIDIOC_QUERYBUF, =
b);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       queue =3D &session->queues[b->type];
> +       if (b->index >=3D queue->allocated_bufs)
> +               return -EINVAL;
> +
> +       buffer =3D &queue->buffers[b->index];
> +       /*
> +        * Set the DONE flag if the buffer is waiting in our own dequeue
> +        * queue.
> +        */
> +       b->flags |=3D (buffer->buffer.flags & V4L2_BUF_FLAG_DONE);
> +
> +       return 0;
> +}
> +
> +static int virtio_media_create_bufs(struct file *file, void *fh,
> +                                   struct v4l2_create_buffers *b)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       struct virtio_media_queue_state *queue;
> +       struct virtio_media_buffer *buffers;
> +       u32 type =3D b->format.type;
> +       int ret;
> +
> +       if (type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       queue =3D &session->queues[type];
> +
> +       ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_CREATE_BUFS, b, si=
zeof(*b),
> +                                        sizeof(*b));
> +       if (ret)
> +               return ret;
> +
> +       /* If count is zero, we were just checking for format. */
> +       if (b->count =3D=3D 0)
> +               return 0;
> +
> +       buffers =3D queue->buffers;
> +
> +       queue->buffers =3D
> +               vzalloc(sizeof(*queue->buffers) * (b->index + b->count));
> +       if (!queue->buffers) {
> +               queue->buffers =3D buffers;
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(queue->buffers, buffers,
> +              sizeof(*buffers) * queue->allocated_bufs);
> +       vfree(buffers);
> +
> +       queue->allocated_bufs =3D b->index + b->count;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_prepare_buf(struct file *file, void *fh,
> +                                   struct v4l2_buffer *b)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       struct virtio_media_queue_state *queue;
> +       struct virtio_media_buffer *buffer;
> +       int i, ret;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +       queue =3D &session->queues[b->type];
> +       if (b->index >=3D queue->allocated_bufs)
> +               return -EINVAL;
> +       buffer =3D &queue->buffers[b->index];
> +
> +       buffer->buffer.m =3D b->m;
> +       if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
> +               if (b->length > VIDEO_MAX_PLANES)
> +                       return -EINVAL;
> +               for (i =3D 0; i < b->length; i++)
> +                       buffer->planes[i].m =3D b->m.planes[i].m;
> +       }
> +
> +       ret =3D virtio_media_send_buffer_ioctl(vfh, VIDIOC_PREPARE_BUF, b=
);
> +       if (ret)
> +               return ret;
> +
> +       buffer->buffer.flags =3D V4L2_BUF_FLAG_PREPARED;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_qbuf(struct file *file, void *fh, struct v4l2_bu=
ffer *b)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +       struct virtio_media_queue_state *queue;
> +       struct virtio_media_buffer *buffer;
> +       bool prepared;
> +       u32 old_flags;
> +       int i, ret;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +       queue =3D &session->queues[b->type];
> +       if (b->index >=3D queue->allocated_bufs)
> +               return -EINVAL;
> +       buffer =3D &queue->buffers[b->index];
> +       prepared =3D buffer->buffer.flags & V4L2_BUF_FLAG_PREPARED;
> +
> +       /*
> +        * Store the buffer and plane `m` information so we can retrieve
> +        * it again when DQBUF occurs.
> +        */
> +       if (!prepared) {
> +               buffer->buffer.m =3D b->m;
> +               if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
> +                       if (b->length > VIDEO_MAX_PLANES)
> +                               return -EINVAL;
> +                       for (i =3D 0; i < b->length; i++)
> +                               buffer->planes[i].m =3D b->m.planes[i].m;
> +               }
> +       }
> +       old_flags =3D buffer->buffer.flags;
> +       buffer->buffer.flags =3D V4L2_BUF_FLAG_QUEUED;
> +
> +       ret =3D virtio_media_send_buffer_ioctl(vfh, VIDIOC_QBUF, b);
> +       if (ret) {
> +               /* Rollback the previous flags as the buffer is not queue=
d. */
> +               buffer->buffer.flags =3D old_flags;
> +               return ret;
> +       }
> +
> +       queue->queued_bufs +=3D 1;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_dqbuf(struct file *file, void *fh,
> +                             struct v4l2_buffer *b)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct virtio_media_session *session =3D
> +               fh_to_session(file_to_v4l2_fh(file));
> +       struct virtio_media_buffer *dqbuf;
> +       struct virtio_media_queue_state *queue;
> +       struct list_head *buffer_queue;
> +       struct v4l2_plane *planes_backup =3D NULL;
> +       const bool is_multiplanar =3D V4L2_TYPE_IS_MULTIPLANAR(b->type);
> +       int ret;
> +
> +       if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
> +               return -EINVAL;
> +
> +       queue =3D &session->queues[b->type];
> +
> +       /*
> +        * If a buffer with the LAST flag has been returned, subsequent
> +        * calls to DQBUF must return -EPIPE until the queue is cleared.
> +        */
> +       if (queue->is_capture_last)
> +               return -EPIPE;
> +
> +       buffer_queue =3D &queue->pending_dqbufs;
> +
> +       if (session->nonblocking_dequeue) {
> +               if (list_empty(buffer_queue))
> +                       return -EAGAIN;
> +       } else if (queue->allocated_bufs =3D=3D 0) {
> +               return -EINVAL;
> +       } else if (!queue->streaming) {
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * vv->lock has been acquired by virtio_media_device_ioctl. Relea=
se it
> +        * while we wait so that other ioctls for this session can be pro=
cessed
> +        * and potentially trigger dqbuf_wait.
> +        */
> +       mutex_unlock(&vv->vlock);
> +       ret =3D wait_event_interruptible(session->dqbuf_wait,
> +                                      !list_empty(buffer_queue));
> +       mutex_lock(&vv->vlock);
> +       if (ret)
> +               return -EINTR;
> +
> +       mutex_lock(&session->queues_lock);
> +       dqbuf =3D list_first_entry(buffer_queue, struct virtio_media_buff=
er,
> +                                list);
> +       list_del(&dqbuf->list);
> +       mutex_unlock(&session->queues_lock);
> +
> +       /* Clear the DONE flag as the buffer is now being dequeued. */
> +       dqbuf->buffer.flags &=3D ~V4L2_BUF_FLAG_DONE;
> +
> +       if (is_multiplanar) {
> +               size_t nb_planes =3D min_t(u32, b->length, VIDEO_MAX_PLAN=
ES);
> +
> +               memcpy(b->m.planes, dqbuf->planes,
> +                      nb_planes * sizeof(struct v4l2_plane));
> +               planes_backup =3D b->m.planes;
> +       }
> +
> +       memcpy(b, &dqbuf->buffer, sizeof(*b));
> +
> +       if (is_multiplanar)
> +               b->m.planes =3D planes_backup;
> +
> +       if (V4L2_TYPE_IS_CAPTURE(b->type) && b->flags & V4L2_BUF_FLAG_LAS=
T)
> +               queue->is_capture_last =3D true;
> +
> +       return 0;
> +}
> +
> +/*
> + * s/g_input/output work with an unsigned int - recast this to a u32 so =
the
> + * size is unambiguous.
> + */
> +
> +static int virtio_media_g_input(struct file *file, void *fh, unsigned in=
t *i)
> +{
> +       u32 input;
> +
> +       int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                        VIDIOC_G_INPUT, &input,
> +                                        sizeof(input), sizeof(input));
> +       if (ret)
> +               return ret;
> +
> +       *i =3D input;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_s_input(struct file *file, void *fh, unsigned in=
t i)
> +{
> +       u32 input =3D i;
> +
> +       return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                         VIDIOC_S_INPUT, &input,
> +                                         sizeof(input), sizeof(input));
> +}
> +
> +static int virtio_media_g_output(struct file *file, void *fh, unsigned i=
nt *o)
> +{
> +       u32 output;
> +
> +       int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                        VIDIOC_G_OUTPUT, &output,
> +                                        sizeof(output), sizeof(output));
> +       if (ret)
> +               return ret;
> +
> +       *o =3D output;
> +
> +       return 0;
> +}
> +
> +static int virtio_media_s_output(struct file *file, void *fh, unsigned i=
nt o)
> +{
> +       u32 output =3D o;
> +
> +       return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +                                         VIDIOC_S_OUTPUT, &output,
> +                                         sizeof(output), sizeof(output))=
;
> +}
> +
> +/*
> + * decoder_cmd can affect the state of the CAPTURE queue.
> + */
> +
> +static int virtio_media_decoder_cmd(struct file *file, void *fh,
> +                                   struct v4l2_decoder_cmd *cmd)
> +{
> +       struct v4l2_fh *vfh =3D file_to_v4l2_fh(file);
> +       struct virtio_media_session *session =3D fh_to_session(vfh);
> +
> +       int ret =3D virtio_media_send_wr_ioctl(vfh, VIDIOC_DECODER_CMD, c=
md,
> +                                        sizeof(*cmd), sizeof(*cmd));
> +       if (ret)
> +               return ret;
> +
> +       /* A START command makes the CAPTURE queue able to dequeue again.=
 */
> +       if (cmd->cmd =3D=3D V4L2_DEC_CMD_START) {
> +               session->queues[V4L2_BUF_TYPE_VIDEO_CAPTURE].is_capture_l=
ast =3D
> +                       false;
> +               session->queues[V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE]
> +                       .is_capture_last =3D false;
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * s_std doesn't work with a pointer, so we cannot use SIMPLE_W_IOCTL.
> + */
> +
> +static int virtio_media_s_std(struct file *file, void *fh, v4l2_std_id s=
)
> +{
> +       int ret =3D virtio_media_send_w_ioctl(file_to_v4l2_fh(file), VIDI=
OC_S_STD,
> +                                       &s, sizeof(s));
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +const struct v4l2_ioctl_ops virtio_media_ioctl_ops =3D {
> +       /* VIDIOC_QUERYCAP handler */
> +       .vidioc_querycap =3D virtio_media_querycap,
> +
> +       /* VIDIOC_ENUM_FMT handlers */
> +       .vidioc_enum_fmt_vid_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_vid_overlay =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_vid_out =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_sdr_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_sdr_out =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_meta_cap =3D virtio_media_enum_fmt,
> +       .vidioc_enum_fmt_meta_out =3D virtio_media_enum_fmt,
> +
> +       /* VIDIOC_G_FMT handlers */
> +       .vidioc_g_fmt_vid_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_overlay =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out_overlay =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vbi_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vbi_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sliced_vbi_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sliced_vbi_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_cap_mplane =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_vid_out_mplane =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sdr_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_sdr_out =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_meta_cap =3D virtio_media_g_fmt,
> +       .vidioc_g_fmt_meta_out =3D virtio_media_g_fmt,
> +
> +       /* VIDIOC_S_FMT handlers */
> +       .vidioc_s_fmt_vid_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_overlay =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out_overlay =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vbi_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vbi_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sliced_vbi_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sliced_vbi_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_cap_mplane =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_vid_out_mplane =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sdr_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_sdr_out =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_meta_cap =3D virtio_media_s_fmt,
> +       .vidioc_s_fmt_meta_out =3D virtio_media_s_fmt,
> +
> +       /* VIDIOC_TRY_FMT handlers */
> +       .vidioc_try_fmt_vid_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_overlay =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out_overlay =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vbi_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vbi_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sliced_vbi_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sliced_vbi_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_cap_mplane =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_vid_out_mplane =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sdr_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_sdr_out =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_meta_cap =3D virtio_media_try_fmt,
> +       .vidioc_try_fmt_meta_out =3D virtio_media_try_fmt,
> +
> +       /* Buffer handlers */
> +       .vidioc_reqbufs =3D virtio_media_reqbufs,
> +       .vidioc_querybuf =3D virtio_media_querybuf,
> +       .vidioc_qbuf =3D virtio_media_qbuf,
> +       .vidioc_expbuf =3D NULL,
> +       .vidioc_dqbuf =3D virtio_media_dqbuf,
> +       .vidioc_create_bufs =3D virtio_media_create_bufs,
> +       .vidioc_prepare_buf =3D virtio_media_prepare_buf,
> +       /* Overlay interface not supported yet */
> +       .vidioc_overlay =3D NULL,
> +       /* Overlay interface not supported yet */
> +       .vidioc_g_fbuf =3D NULL,
> +       /* Overlay interface not supported yet */
> +       .vidioc_s_fbuf =3D NULL,
> +
> +       /* Stream on/off */
> +       .vidioc_streamon =3D virtio_media_streamon,
> +       .vidioc_streamoff =3D virtio_media_streamoff,
> +
> +       /* Standard handling */
> +       .vidioc_g_std =3D virtio_media_g_std,
> +       .vidioc_s_std =3D virtio_media_s_std,
> +       .vidioc_querystd =3D virtio_media_querystd,
> +
> +       /* Input handling */
> +       .vidioc_enum_input =3D virtio_media_enuminput,
> +       .vidioc_g_input =3D virtio_media_g_input,
> +       .vidioc_s_input =3D virtio_media_s_input,
> +
> +       /* Output handling */
> +       .vidioc_enum_output =3D virtio_media_enumoutput,
> +       .vidioc_g_output =3D virtio_media_g_output,
> +       .vidioc_s_output =3D virtio_media_s_output,
> +
> +       /* Control handling */
> +       .vidioc_query_ext_ctrl =3D virtio_media_query_ext_ctrl,
> +       .vidioc_g_ext_ctrls =3D virtio_media_g_ext_ctrls,
> +       .vidioc_s_ext_ctrls =3D virtio_media_s_ext_ctrls,
> +       .vidioc_try_ext_ctrls =3D virtio_media_try_ext_ctrls,
> +       .vidioc_querymenu =3D virtio_media_querymenu,
> +
> +       /* Audio ioctls */
> +       .vidioc_enumaudio =3D virtio_media_enumaudio,
> +       .vidioc_g_audio =3D virtio_media_g_audio,
> +       .vidioc_s_audio =3D virtio_media_s_audio,
> +
> +       /* Audio out ioctls */
> +       .vidioc_enumaudout =3D virtio_media_enumaudout,
> +       .vidioc_g_audout =3D virtio_media_g_audout,
> +       .vidioc_s_audout =3D virtio_media_s_audout,
> +       .vidioc_g_modulator =3D virtio_media_g_modulator,
> +       .vidioc_s_modulator =3D virtio_media_s_modulator,
> +
> +       /* Crop ioctls */
> +       /*
> +        * Not directly an ioctl (part of VIDIOC_CROPCAP), so no need to
> +        * implement.
> +        */
> +       .vidioc_g_pixelaspect =3D NULL,
> +       .vidioc_g_selection =3D virtio_media_g_selection,
> +       .vidioc_s_selection =3D virtio_media_s_selection,
> +
> +       /* Compression ioctls */
> +       /* Deprecated in V4L2. */
> +       .vidioc_g_jpegcomp =3D NULL,
> +       /* Deprecated in V4L2. */
> +       .vidioc_s_jpegcomp =3D NULL,
> +       .vidioc_g_enc_index =3D virtio_media_g_enc_index,
> +       .vidioc_encoder_cmd =3D virtio_media_encoder_cmd,
> +       .vidioc_try_encoder_cmd =3D virtio_media_try_encoder_cmd,
> +       .vidioc_decoder_cmd =3D virtio_media_decoder_cmd,
> +       .vidioc_try_decoder_cmd =3D virtio_media_try_decoder_cmd,
> +
> +       /* Stream type-dependent parameter ioctls */
> +       .vidioc_g_parm =3D virtio_media_g_parm,
> +       .vidioc_s_parm =3D virtio_media_s_parm,
> +
> +       /* Tuner ioctls */
> +       .vidioc_g_tuner =3D virtio_media_g_tuner,
> +       .vidioc_s_tuner =3D virtio_media_s_tuner,
> +       .vidioc_g_frequency =3D virtio_media_g_frequency,
> +       .vidioc_s_frequency =3D virtio_media_s_frequency,
> +       .vidioc_enum_freq_bands =3D virtio_media_enum_freq_bands,
> +
> +       /* Sliced VBI cap */
> +       .vidioc_g_sliced_vbi_cap =3D virtio_media_g_sliced_vbi_cap,
> +
> +       /* Log status ioctl */
> +       /* Guest-only operation */
> +       .vidioc_log_status =3D NULL,
> +
> +       .vidioc_s_hw_freq_seek =3D virtio_media_s_hw_freq_seek,
> +
> +       .vidioc_enum_framesizes =3D virtio_media_enum_framesizes,
> +       .vidioc_enum_frameintervals =3D virtio_media_enum_frameintervals,
> +
> +       /* DV Timings IOCTLs */
> +       .vidioc_s_dv_timings =3D virtio_media_s_dv_timings,
> +       .vidioc_g_dv_timings =3D virtio_media_g_dv_timings,
> +       .vidioc_query_dv_timings =3D virtio_media_query_dv_timings,
> +       .vidioc_enum_dv_timings =3D virtio_media_enum_dv_timings,
> +       .vidioc_dv_timings_cap =3D virtio_media_dv_timings_cap,
> +       .vidioc_g_edid =3D NULL,
> +       .vidioc_s_edid =3D NULL,
> +
> +       .vidioc_subscribe_event =3D virtio_media_subscribe_event,
> +       .vidioc_unsubscribe_event =3D virtio_media_unsubscribe_event,
> +
> +       /* For other private ioctls */
> +       .vidioc_default =3D NULL,
> +};
> +
> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +                              unsigned long arg)
> +{
> +       struct video_device *video_dev =3D video_devdata(file);
> +       struct virtio_media *vv =3D to_virtio_media(video_dev);
> +       struct v4l2_fh *vfh =3D NULL;
> +       struct v4l2_standard standard;
> +       v4l2_std_id std_id =3D 0;
> +       int ret;
> +
> +       if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
> +               vfh =3D file_to_v4l2_fh(file);
> +
> +       mutex_lock(&vv->vlock);
> +
> +       /*
> +        * We need to handle a few ioctls manually because their results
> +        * rely on vfd->tvnorms, which is normally updated by the driver
> +        * as S_INPUT is called. Since we want to just pass these ioctls
> +        * through, we have to hijack them from here.
> +        */
> +       switch (cmd) {
> +       case VIDIOC_S_STD:
> +               ret =3D copy_from_user(&std_id, (void __user *)arg,
> +                                    sizeof(std_id));
> +               if (ret) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +               ret =3D virtio_media_s_std(file, vfh, std_id);
> +               break;
> +       case VIDIOC_ENUMSTD:
> +               ret =3D copy_from_user(&standard, (void __user *)arg,
> +                                    sizeof(standard));
> +               if (ret) {
> +                       ret =3D -EINVAL;
> +                       break;
> +               }
> +               ret =3D virtio_media_enumstd(file, vfh, &standard);
> +               if (ret)
> +                       break;
> +               ret =3D copy_to_user((void __user *)arg, &standard,
> +                                  sizeof(standard));
> +               if (ret)
> +                       ret =3D -EINVAL;
> +               break;
> +       case VIDIOC_QUERYSTD:
> +               ret =3D virtio_media_querystd(file, vfh, &std_id);
> +               if (ret)
> +                       break;
> +               ret =3D copy_to_user((void __user *)arg, &std_id, sizeof(=
std_id));
> +               if (ret)
> +                       ret =3D -EINVAL;
> +               break;
> +       default:
> +               ret =3D video_ioctl2(file, cmd, arg);
> +               break;
> +       }
> +
> +       mutex_unlock(&vv->vlock);
> +
> +       return ret;
> +}
> --
> 2.55.0.737.g08866a6d13-goog
>

