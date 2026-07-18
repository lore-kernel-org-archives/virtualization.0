Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08249262FF8
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784395640; cv=none; b=tNXHRlwLdBFRoOxBzEYiF0Odrst2p2JHmaNZbwdnkEkz9FNzd9F/uCNuvx0xDBfPJR/fNKwP2kUZ81G83rmpJNQlwoSzCQMW5rdgKcLJQb9XFvEXW1wAq/sUgJpRMZo7qJaZangq2kUW71/EoqPQkexNS0miimnqaixMSrqOlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784395640; c=relaxed/simple;
	bh=6rSrZyCWXJlF3I3FaDITfDYsoSwgsFAnSZw5FPIkPTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=au5asaFLNWbBRwkb3HAQ77Ng7I67Irn8jH8zbLRijBJlxzm56WV5fmfruoa6mqfRaaV6YzIJU+nrGj8Ro4jwsYVMS/Ei+Sjj8wo0O2gfe6DHVBczZ1P++VUJyJLgfOz0YZ4mdz1HBWZisxUKI13FUKS6e+7X2H2eRVmz8saBZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs4dkLZF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs4dkLZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784395637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4SYB/B+bDlxilXL6idtvWKAFgvw269dvYm2IM94meE=;
	b=Zs4dkLZF+DMsL3zSIkXhlzZ0Sm7kiIKtL30sMbff7RcEHMX69+9WqZ2Dlm/JBn8zLgYTSy
	pObWgYQlhslSAVfFbh5qAsv/wyNiwZaBDL/wtLDg0ZtNKnwSE05ILCeMvIdARW01irVMeI
	R1K/gbJ+Z+G4OXrqcTagVzLVMios5ds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-8ZXoDnliMRSsvPls04vUKg-1; Sat, 18 Jul 2026 13:27:16 -0400
X-MC-Unique: 8ZXoDnliMRSsvPls04vUKg-1
X-Mimecast-MFC-AGG-ID: 8ZXoDnliMRSsvPls04vUKg_1784395635
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso23602925e9.1
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 10:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784395635; x=1785000435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y4SYB/B+bDlxilXL6idtvWKAFgvw269dvYm2IM94meE=;
        b=OhLQjsW4qikYhor+d4fDYbPFw1HlM3skUrFQeTnndyuSx9ri8RjV03CgQpLs0Mu960
         o/bVyHrw9Zl54ysWtQNpHvwJJUzwpiBpON+DIIrIIgvk3xptSzoHdvwcKwgc9UOlOP7C
         pSFcjcTL99QDSV20jrT2w0rJl0dRFemZMcqD8y7KF/yWPolt6WV/SDDNtCbChHEsuN5U
         Yotrk2+aAZJukrWyzFIl6YaxAPVXoQ1ZAxcsRliMRP6e6SSLYLdTG8OaZY/W42+sPCio
         YgqhOeKRxkSGsMKSSFJGvRs4SIZSv24O1ouh5vz1O/F2BKJADtjvALXOxDBzeQrbN0+9
         tFbg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2SdedhJ4WxEqnCoWaVckocitSqPM+ge7xyLEaflUvf9i3QWM5QwwHGQ0PRxpzPrydqtaqjlzABUr1/d/JRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2Rn7VXV6NGx8CCNeVJQlQZpBfP0+00V2OHcRiB4Rh0R6jQRS+
	sTAjSgfb0/auNOfX2fGKl5ZJuuXA98iyTpeci665EVUPoP8e/YXRBfZSQpktjrDvsawuWf+f6aa
	YlqtVu7xhDhHzgIto54w+Wbe/AfVh85Ls3ih1ZMqizTP6SjF9DAR3nGoSXPERKJEJNUtT
X-Gm-Gg: AfdE7cmywgBWBoIgakp4+11KU3O5rpFQtTo3DyLnNAynpRD9kxdzmxAk30piZ60wl8v
	e04T65dcX2sIZPE9lz62dxlAQMJlCTJb0lSWnchKiafaT0EW79dhYpvBp0GvmAmXldxyE6Ya7FW
	KNEsZ/kpsh5O+3K2Q1HUePO43U9TDLEQ526lA2IndNfpcOV1b5UpvX5RxAGsryTIQcqiw89ErbM
	kte0AVrggfKlIZq3omeS2rBbuLBwkZJO4dyzqNEuBrTe5SPgIv3gvEOsZGr6boLP8UdD0D1PLG7
	iUByzMpA/w2I2MgSTqcAvMKLG/5S7miUCQZRfw/mSGr2kWUpXgrT3dNrJLhQg5qNEr6+5FXZrt6
	iAFmUb7NWUxo/5BtlfyWaiaJ8N7PCNkQ=
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-4954a50ea30mr92150635e9.30.1784395634918;
        Sat, 18 Jul 2026 10:27:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id 5b1f17b1804b1-4954a50ea30mr92150045e9.30.1784395634331;
        Sat, 18 Jul 2026 10:27:14 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f6b85970esm7812651f8f.15.2026.07.18.10.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 10:27:12 -0700 (PDT)
Date: Sat, 18 Jul 2026 13:27:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com,
	adelva@google.com, aesteve@redhat.com, changyeon@google.com,
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com,
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4 2/8] media: virtio: Add virtio-media driver structs
 and function declarations
Message-ID: <20260718132340-mutt-send-email-mst@kernel.org>
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-3-briandaniels@google.com>
 <20260622170708-mutt-send-email-mst@kernel.org>
 <CAD4i_GTBkZRAnBTohkzJSh2XTx+MHkTS_KokEMQ4s0-WP+DxcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAD4i_GTBkZRAnBTohkzJSh2XTx+MHkTS_KokEMQ4s0-WP+DxcA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VHjEvMLCkL9euruUTAeC-Izz0Eok2n6MUjAwe644zXY_1784395635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 03:46:36PM -0400, Brian Daniels wrote:
> On Mon, Jun 22, 2026 at 5:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jun 22, 2026 at 04:43:37PM -0400, Brian Daniels wrote:
> > > From: Alexandre Courbot <gnurou@gmail.com>
> > >
> > > Add the structs and function declarations for the new virtio-media drvier.
> > >
> > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > ---
> > >  drivers/media/virtio/virtio_media.h | 95 +++++++++++++++++++++++++++++
> > >  1 file changed, 95 insertions(+)
> > >  create mode 100644 drivers/media/virtio/virtio_media.h
> > >
> > > diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
> > > new file mode 100644
> > > index 000000000..52809d4e9
> > > --- /dev/null
> > > +++ b/drivers/media/virtio/virtio_media.h
> > > @@ -0,0 +1,95 @@
> > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> > > +
> > > +/*
> > > + * Virtio-media structures & functions declarations.
> > > + *
> > > + * Copyright (c) 2024-2025 Google LLC.
> > > + */
> > > +
> > > +#ifndef __VIRTIO_MEDIA_H
> > > +#define __VIRTIO_MEDIA_H
> > > +
> > > +#include <linux/virtio_config.h>
> > > +#include <media/v4l2-device.h>
> > > +
> > > +#include "protocol.h"
> > > +
> > > +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> > > +
> > > +#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
> > > +
> > > +extern char *virtio_media_driver_name;
> > > +extern bool virtio_media_allow_userptr;
> > > +
> > > +/**
> > > + * struct virtio_media - Virtio-media device.
> > > + * @v4l2_dev: v4l2_device for the media device.
> > > + * @video_dev: video_device for the media device.
> > > + * @virtio_dev: virtio device for the media device.
> > > + * @commandq: virtio command queue.
> > > + * @eventq: virtio event queue.
> > > + * @eventq_work: work to run when events are received on @eventq.
> > > + * @mmap_region: region into which MMAP buffers are mapped by the host.
> > > + * @event_buffer: buffer for event descriptors.
> > > + * @sessions: list of active sessions on the device.
> > > + * @sessions_lock: protects @sessions and ``virtio_media_session::list``.
> > > + * @events_lock: prevents concurrent processing of events.
> > > + * @cmd: union of the device commands "open" and "munmap". The other
> > > + *       commands are handled by @struct virtio_media_session
> > > + * @resp: union of responses.to device commands "open" and "munmap". The
> > > + *        other responses are handled by @struct virtio_media_session
> > > + * @vlock: serializes access to the command queue.
> > > + * @wq: waitqueue for host responses on the command queue.
> > > + */
> > > +struct virtio_media {
> > > +     struct v4l2_device v4l2_dev;
> > > +     struct video_device video_dev;
> > > +
> > > +     struct virtio_device *virtio_dev;
> > > +     struct virtqueue *commandq;
> > > +     struct virtqueue *eventq;
> > > +     struct work_struct eventq_work;
> > > +
> > > +     struct virtio_shm_region mmap_region;
> > > +
> > > +     void *event_buffer;
> > > +
> > > +     struct list_head sessions;
> > > +     struct mutex sessions_lock; /* protects sessions list */
> > > +
> > > +     struct mutex events_lock; /* prevents concurrent event processing */
> > > +
> > > +     union {
> > > +             struct virtio_media_cmd_open open;
> > > +             struct virtio_media_cmd_munmap munmap;
> > > +     } cmd;
> > > +
> > > +     union {
> > > +             struct virtio_media_resp_open open;
> > > +             struct virtio_media_resp_munmap munmap;
> > > +     } resp;
> >
> >
> > You need DMA alignment padding for these things.
> 
> Each member of the above unions is already padded to 64-bit alignment,
> is that sufficient?
> 
> If not, could you tell me what else is necessary?

Read up "What memory is DMA'able?" and following chapters in
Documentation/core-api/dma-api-howto.rst


> > Which one can only see when I reads the actual driver 8 patches down.
> > Which is why it's not a sensible way to split patches.
> >
> > A sensible way is to have a driver then add functionality
> > in logical pieces gradually.
> >
> 
> Appreciate the feedback. There was a previous comment requesting to
> split the patch into c/h file pairs, but I can try reformatting it as
> you suggest for v5.
> 
> > > +
> > > +     struct mutex vlock; /* serializes command queue access */
> > > +     wait_queue_head_t wq;
> > > +};
> > > +
> > > +static inline struct virtio_media *
> > > +to_virtio_media(struct video_device *video_dev)
> > > +{
> > > +     return container_of(video_dev, struct virtio_media, video_dev);
> > > +}
> > > +
> > > +/* virtio_media_driver.c */
> > > +
> > > +int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
> > > +                           const size_t out_sgs, const size_t in_sgs,
> > > +                           size_t minimum_resp_len, size_t *resp_len);
> > > +void virtio_media_process_events(struct virtio_media *vv);
> > > +
> > > +/* virtio_media_ioctls.c */
> > > +
> > > +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> > > +                            unsigned long arg);
> > > +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> > > +
> > > +#endif // __VIRTIO_MEDIA_H
> > > --
> > > 2.55.0.rc0.799.gd6f94ed593-goog
> >

