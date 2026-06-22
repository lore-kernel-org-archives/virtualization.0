Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96A33F584
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162537; cv=none; b=AWMwyYiBLtgBzZMTw3f80dusa7KWfOW2PxS23nFgjg09nKxRaR455WJTwRCINJOq8zfezlh9qjuvhQZlIFeucOwkuV3nnCR81RlPCHvZ3r2PjyWRv/HMq9e36EPsxi4L94TM7agIX/9YATYm67HrunqBv/WKWw7uxDU3wz5L2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162537; c=relaxed/simple;
	bh=pmBo+w73eRHOywxv/S6NXnxFU3GqCpF8V0YmuW/oaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kbvQ2uf6YSC28NvqaCCmbsiXUrB1+IF+n5erbBKXMbxJUMYjFmqx42VPhL52RtZgQshGI0dBwFqI92r5eIxmJNoKQ6zyh98DF3VCRbI9tdVxNFLF3htEC7crqwx1k18C2Uv4ELwewCMshFs8eJaWdyrh/8m3MgY1PyUUXqkh+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhhAbWLN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhhAbWLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782162535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8vqJMSqKfx+sunQXyB2WFWU85NOrm3GPszXiiWd5EI=;
	b=UhhAbWLNVLWPuHAwk8q1CKMYKkxV8nvH1SqOs+n3rjvit/JKpiRGFvz5bpIRFy5350vl4F
	Fnf/EcP0TRS00a1IGxzmHke1klKB8B+yRLHzyqyPKWJtwLDAXkVBEZtjDdViAeAUx6rsKA
	bjDzPrBrbaiuR00VuoXa8peDNl5GRZo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-c3kNw-fTP8uMq6Mb01yJ9g-1; Mon, 22 Jun 2026 17:08:54 -0400
X-MC-Unique: c3kNw-fTP8uMq6Mb01yJ9g-1
X-Mimecast-MFC-AGG-ID: c3kNw-fTP8uMq6Mb01yJ9g_1782162533
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490d3f03883so41594625e9.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162533; x=1782767333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8vqJMSqKfx+sunQXyB2WFWU85NOrm3GPszXiiWd5EI=;
        b=nZoFjXQ74vyTRdkbNjjsG9ISFAqPPaUTe4QbXrdQjEruct3WqtB/gvu4RrzB2ihTLA
         wG6nGG6daSR/Lzrj45ZflxMo5x9yOBSzJOOaUiQB+HDW5102LCawYkQ8Xp+T3M40nTbd
         JNcTvrSp4zCkxtGyjPB1WTVLyO3FNoa7V0ZiSAQuYdcIkzxuYH9m9x1rN7SzTRN4Q5r2
         C0SzquWxIsGeWKUtogVNamLOydhGYeU8K6dTX+ZZvK0Tpuued3uEXcj9qlK6nuAadoZ2
         /DXLSPHOBG2YES6X3XY+4DmtrQtBU2tm7I58kAJymQwNrFD/GqEObep254spdJ/c+PSs
         3tdw==
X-Forwarded-Encrypted: i=1; AFNElJ/nV5DmSOwj9BCP3ABSCyL08H0m+P1HXtuMfRh+sJzseJK0vqKkQzTgBEySHbdJOlXdOxF1ggFZYl3+9uJxtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9IXmeLkTBf+aetCYRgPs5vXt/XbcBtlFgRob0o8I3EdXqKZ5e
	9km54UKXtQRM4Kp435pN//lI5EtOlI1oGu+S1w5+qwkTLMxL0lbzc6ijq+y7tPoCuy1tvDYfic8
	G8Abe+ar4CtVDAfjEx0XfQT8TiVafQJxUE6WQZYMArfOH7Uu+as+YPf4IaNBtOqysULwR
X-Gm-Gg: AfdE7ckkRhnzMDHad3OuSNs8uU6QdRto/NXBe6zSk9khRoOfB9lOYPv/JRe5ZILjMpo
	xKHQ0vFTYaOZUyuxYKi+Cd+FMhbSPKtLsK6Hjs+yQNQlW3ovNE92+A7N5ez0S0roVneDXFQZAm/
	0eVkCcll64gV7KMgbrQnIoWIbuVGyorA1eF6DR4vAnnGTWGlqv7pzWVgbnerMHU55EuBfLGLZms
	ZkO78IWu/b+ECJo8srYet5hRLEpz1g8jRoA04e3nYEykVfHlM5RzRzv5G/jo5BvgxY8Tos1xFxC
	QesHMMRLcMEd4fcRvrZ2+UzST9LqZDjUcDGUWmiUxONmQ08/23KZld4hkmig6rUSKSuo3ViPu29
	xHOJuNtDEX7QPoSXZkkMMMi+lFC02UERJ
X-Received: by 2002:a05:600c:3781:b0:490:e104:7943 with SMTP id 5b1f17b1804b1-49240e85dd3mr196042535e9.18.1782162532482;
        Mon, 22 Jun 2026 14:08:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3781:b0:490:e104:7943 with SMTP id 5b1f17b1804b1-49240e85dd3mr196042355e9.18.1782162531951;
        Mon, 22 Jun 2026 14:08:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923392dsm448971425e9.2.2026.06.22.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:08:51 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:08:48 -0400
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
Message-ID: <20260622170708-mutt-send-email-mst@kernel.org>
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-3-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260622204343.1994418-3-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C24FnbOMUzD-Ad_v2UUugY6hk_e2NyqdtwbLFYJRG58_1782162533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:43:37PM -0400, Brian Daniels wrote:
> From: Alexandre Courbot <gnurou@gmail.com>
> 
> Add the structs and function declarations for the new virtio-media drvier.
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
>  drivers/media/virtio/virtio_media.h | 95 +++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 drivers/media/virtio/virtio_media.h
> 
> diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
> new file mode 100644
> index 000000000..52809d4e9
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> +
> +/*
> + * Virtio-media structures & functions declarations.
> + *
> + * Copyright (c) 2024-2025 Google LLC.
> + */
> +
> +#ifndef __VIRTIO_MEDIA_H
> +#define __VIRTIO_MEDIA_H
> +
> +#include <linux/virtio_config.h>
> +#include <media/v4l2-device.h>
> +
> +#include "protocol.h"
> +
> +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> +
> +#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
> +
> +extern char *virtio_media_driver_name;
> +extern bool virtio_media_allow_userptr;
> +
> +/**
> + * struct virtio_media - Virtio-media device.
> + * @v4l2_dev: v4l2_device for the media device.
> + * @video_dev: video_device for the media device.
> + * @virtio_dev: virtio device for the media device.
> + * @commandq: virtio command queue.
> + * @eventq: virtio event queue.
> + * @eventq_work: work to run when events are received on @eventq.
> + * @mmap_region: region into which MMAP buffers are mapped by the host.
> + * @event_buffer: buffer for event descriptors.
> + * @sessions: list of active sessions on the device.
> + * @sessions_lock: protects @sessions and ``virtio_media_session::list``.
> + * @events_lock: prevents concurrent processing of events.
> + * @cmd: union of the device commands "open" and "munmap". The other
> + *       commands are handled by @struct virtio_media_session
> + * @resp: union of responses.to device commands "open" and "munmap". The
> + *        other responses are handled by @struct virtio_media_session
> + * @vlock: serializes access to the command queue.
> + * @wq: waitqueue for host responses on the command queue.
> + */
> +struct virtio_media {
> +	struct v4l2_device v4l2_dev;
> +	struct video_device video_dev;
> +
> +	struct virtio_device *virtio_dev;
> +	struct virtqueue *commandq;
> +	struct virtqueue *eventq;
> +	struct work_struct eventq_work;
> +
> +	struct virtio_shm_region mmap_region;
> +
> +	void *event_buffer;
> +
> +	struct list_head sessions;
> +	struct mutex sessions_lock; /* protects sessions list */
> +
> +	struct mutex events_lock; /* prevents concurrent event processing */
> +
> +	union {
> +		struct virtio_media_cmd_open open;
> +		struct virtio_media_cmd_munmap munmap;
> +	} cmd;
> +
> +	union {
> +		struct virtio_media_resp_open open;
> +		struct virtio_media_resp_munmap munmap;
> +	} resp;


You need DMA alignment padding for these things.

Which one can only see when I reads the actual driver 8 patches down.
Which is why it's not a sensible way to split patches.

A sensible way is to have a driver then add functionality
in logical pieces gradually.


> +
> +	struct mutex vlock; /* serializes command queue access */
> +	wait_queue_head_t wq;
> +};
> +
> +static inline struct virtio_media *
> +to_virtio_media(struct video_device *video_dev)
> +{
> +	return container_of(video_dev, struct virtio_media, video_dev);
> +}
> +
> +/* virtio_media_driver.c */
> +
> +int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
> +			      const size_t out_sgs, const size_t in_sgs,
> +			      size_t minimum_resp_len, size_t *resp_len);
> +void virtio_media_process_events(struct virtio_media *vv);
> +
> +/* virtio_media_ioctls.c */
> +
> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +			       unsigned long arg);
> +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> +
> +#endif // __VIRTIO_MEDIA_H
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog

