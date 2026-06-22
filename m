Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C452366048
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162365; cv=none; b=twzYQUMPUmQu3p9vlDA+7KKSMO5UV8qOy6xVF56KGwElwvmIjgp5V57JxrtilnDehfAADtGJ/OpptIsRPunHU/ism+aj2tdS9tAXaOLwwBe3qKiZ7FCpbOb+jp/tQcy25udYriEnkePOJ21F8MaJ3ImDYgmHLoupIRtOPlxGsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162365; c=relaxed/simple;
	bh=ELtXDgzXDc4ztjBq0AL0MrkCE7z1bTC3DcJes+5F9Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BlHcdCWGpSn7rukRsTekbjcZ4SFWLIaMKYtAyPoxSkRvq/eAekCyvpGTZlUbbcqZwNhedR/LKjq1e1spgsMla4p6T/XJeF3B/8zz1onYKFQymKN2cTerzODwltWYrDyuYStCyrv846dt09dZqeDFhU+mzoojROm0Z7vBWUrgwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzLvYJFf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzLvYJFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782162362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RRcHobRBo9S79KO2uBGZWMFjZxC0rmFjmqFckJpRniw=;
	b=BzLvYJFfYryU4yre/K27MrExZyRwUdXM4qKub/L/tJZoZIgm/uxlpi+1rEoRZhgTzAg9Kx
	bibUN635MlX3vWKU99CcNWiQDIo/jghwf4iJTSreTukuUNZ1M96m6pEsequu8xbXWAPQQw
	rClycv61sO+T+6CQFm884hMa0cyZA80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-qun9tiUbM625AqTBm7aVtA-1; Mon, 22 Jun 2026 17:05:59 -0400
X-MC-Unique: qun9tiUbM625AqTBm7aVtA-1
X-Mimecast-MFC-AGG-ID: qun9tiUbM625AqTBm7aVtA_1782162358
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49246459bc4so19809665e9.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162358; x=1782767158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRcHobRBo9S79KO2uBGZWMFjZxC0rmFjmqFckJpRniw=;
        b=HyVMaE15NTFkLDVJrvKT0MXVMld+TWFZayty1a0wNgB++PmfU/LOU+V8tMwShomrKp
         xWhFb6+tdOX/mGDQaj6N1LnnZ44zGCxAuW9ITtMEP1VvYP/2ha6aq1ySsBHXpVv+1LF+
         2cQpXqAZmtLi9UbIQUEBYZbTi8AcDHGFjvMYXbJMltCfh0UOdMNfRRD6O1TrelcFPYO9
         3g5fP3jR/VN2NBAFo+IOQ1HJzYXlEfERbEP5MvNvwgF1cuLqyQGm4RgN9JIaFdNPo8U7
         usSo1XSX3HqNWwCOC16y9+B7xP79Jxrn1npOHJdJ1izD9M0lZqtcwMzCwxBNRSEEVtvI
         ht7A==
X-Forwarded-Encrypted: i=1; AFNElJ/vE4doh4NwnKw8LPwpY09Ew355GaMVxRYZm+w5x5IxxvlEkNcBfnE/fwrzPoGaCVpI8puFODtOmMGvdEkh+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1BYVQeRBfKY7aTZi3szM9Mw303m+p2eugXqYIguQpnDi7ihts
	Ht2fzsbM52ASXFneDBJbWifMWk1IPMaEEPtlEUW7bABYuQAYkxi9Z8nA/wMm8iPJQxwEaU5gDzX
	Ca+oCfwtBOKZeatTTfDxVzojFQ21A/A3Zu55XVxMSGsw/zASOhgIvPunXFnqgYDKkj0S0
X-Gm-Gg: AfdE7cldmt8UK2rqB+LpKwzkuMxxYkfkAihD/ZaVsuNgeFGNUcWPZDr6cWjdM6DCJnT
	WkNtLfWDCoiFwiNWhEWqWmQtkPJC5SSpsSN3h1fCYkS9mwlzONtk6C/T9y2Ryx/TR3s4zfvbWeX
	p/PPFnZpBTEKokL+zCZclCmhdrIYBV/8/8Tzw7cRGUStW9o1hzqK733O9Flkebn0oS8jpMyXwew
	YuSKlEQFUKFN3t2fv1LqmIeoZnefwexUK3ql3wHm5VzrS9hQFY0zssBotjxBDxJavyrDAfEmbkK
	BX6DFLjcCCi7UqhEOFdMC7DS+RhWgAZvKU45tn81h55oomAUdt2dEX787yzgjCzIe0rCfExoEJR
	vIcbhbqG3/Ay4SONttv5ImjZuIMXp/k8M
X-Received: by 2002:a05:600c:4f43:b0:491:89c2:5aca with SMTP id 5b1f17b1804b1-49242592576mr225914015e9.30.1782162357500;
        Mon, 22 Jun 2026 14:05:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4f43:b0:491:89c2:5aca with SMTP id 5b1f17b1804b1-49242592576mr225913575e9.30.1782162356953;
        Mon, 22 Jun 2026 14:05:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm350682075e9.14.2026.06.22.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:05:56 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:05:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com,
	adelva@google.com, aesteve@redhat.com, changyeon@google.com,
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com,
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4 1/8] media: virtio: Add protocol
Message-ID: <20260622170054-mutt-send-email-mst@kernel.org>
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-2-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260622204343.1994418-2-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tXUg1hbm596tbDM8ai49s-C7oH_27ko6vwXKqJVbyPI_1782162358
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:43:36PM -0400, Brian Daniels wrote:
> From: Alexandre Courbot <gnurou@gmail.com>
> 
> Add the identifiers and structs used to implement the virtio interface
> as described in section 5.22 of version 1.4 of the virtio spec:
> 
> https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01-diff-from-v1.2-cs01.html#x1-82200022
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>


Please put this under include/uapi/linux/virtio_media.h

we treat guest/host ABI similar to kernel/user ABI,
and tools know how to find it there.



> ---
>  drivers/media/virtio/protocol.h | 287 ++++++++++++++++++++++++++++++++
>  1 file changed, 287 insertions(+)
>  create mode 100644 drivers/media/virtio/protocol.h
> 
> diff --git a/drivers/media/virtio/protocol.h b/drivers/media/virtio/protocol.h
> new file mode 100644
> index 000000000..5878d107c
> --- /dev/null
> +++ b/drivers/media/virtio/protocol.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> +
> +/*
> + * Definitions of virtio-media protocol structures.
> + *
> + * Copyright (c) 2024-2025 Google LLC.
> + */
> +
> +#ifndef __VIRTIO_MEDIA_PROTOCOL_H
> +#define __VIRTIO_MEDIA_PROTOCOL_H
> +
> +#include <linux/videodev2.h>
> +#include <linux/bits.h>
> +
> +/*
> + * Virtio protocol definition.
> + */
> +
> +/**
> + * struct virtio_media_cmd_header - Header for all virtio-media commands.
> + * @cmd: one of VIRTIO_MEDIA_CMD_*.
> + * @__reserved: must be set to zero by the driver.
> + *
> + * This header starts all commands from the driver to the device on the
> + * commandq.
> + */
> +struct virtio_media_cmd_header {
> +	u32 cmd;
> +	u32 __reserved;
> +};
> +
> +/**
> + * struct virtio_media_resp_header - Header for all virtio-media responses.
> + * @status: 0 if the command was successful, or one of the standard Linux error
> + * codes.
> + * @__reserved: must be set to zero by the device.
> + *
> + * This header starts all responses from the device to the driver on the
> + * commandq.
> + */
> +struct virtio_media_resp_header {
> +	u32 status;
> +	u32 __reserved;
> +};
> +
> +/**
> + * VIRTIO_MEDIA_CMD_OPEN - Command for creating a new session.
> + *
> + * This is the equivalent of calling `open` on a V4L2 device node. Upon
> + * success, a session id is returned which can be used to perform other
> + * commands on the session, notably ioctls.
> + */
> +#define VIRTIO_MEDIA_CMD_OPEN 1
> +
> +/**
> + * struct virtio_media_cmd_open - Driver command for VIRTIO_MEDIA_CMD_OPEN.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_OPEN.
> + */
> +struct virtio_media_cmd_open {
> +	struct virtio_media_cmd_header hdr;
> +};
> +
> +/**
> + * struct virtio_media_resp_open - Device response for VIRTIO_MEDIA_CMD_OPEN.
> + * @hdr: header containing the status of the command.
> + * @session_id: if hdr.status == 0, contains the id of the newly created
> + *              session.
> + * @__reserved: must be set to zero by the device.
> + */
> +struct virtio_media_resp_open {
> +	struct virtio_media_resp_header hdr;
> +	u32 session_id;
> +	u32 __reserved;
> +};
> +
> +/**
> + * VIRTIO_MEDIA_CMD_CLOSE - Command for closing an active session.
> + *
> + * This is the equivalent of calling `close` on a previously opened V4L2
> + * session. All resources associated with this session will be freed and the
> + * session ID shall not be used again after queueing this command.
> + *
> + * This command does not require a response from the device.
> + */
> +#define VIRTIO_MEDIA_CMD_CLOSE 2
> +
> +/**
> + * struct virtio_media_cmd_close - Driver command for VIRTIO_MEDIA_CMD_CLOSE.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_CLOSE.
> + * @session_id: id of the session to close.
> + * @__reserved: must be set to zero by the driver.
> + */
> +struct virtio_media_cmd_close {
> +	struct virtio_media_cmd_header hdr;
> +	u32 session_id;
> +	u32 __reserved;
> +};
> +
> +/**
> + * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioctl.
> + *
> + * This command asks the device to run one of the `VIDIOC_*` ioctls on the
> + * active session.
> + *
> + * The code of the ioctl is extracted from the VIDIOC_* definitions in
> + * `videodev2.h`, and consists of the second argument of the `_IO*` macro.
> + *
> + * Each ioctl has a payload, which is defined by the third argument of the
> + * `_IO*` macro defining it. It can be writable by the driver (`_IOW`), the
> + * device (`_IOR`), or both (`_IOWR`).
> + *
> + * If an ioctl is writable by the driver, it must be followed by a
> + * driver-writable descriptor containing the payload.
> + *
> + * If an ioctl is writable by the device, it must be followed by a
> + * device-writable descriptor of the size of the payload that the device will
> + * write into.
> + *
> + */
> +#define VIRTIO_MEDIA_CMD_IOCTL 3
> +
> +/**
> + * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MEDIA_CMD_IOCTL.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
> + * @session_id: id of the session to run the ioctl on.
> + * @code: code of the ioctl to run.
> + */
> +struct virtio_media_cmd_ioctl {
> +	struct virtio_media_cmd_header hdr;
> +	u32 session_id;
> +	u32 code;
> +};
> +
> +/**
> + * struct virtio_media_resp_ioctl - Device response for VIRTIO_MEDIA_CMD_IOCTL.
> + * @hdr: header containing the status of the ioctl.
> + */
> +struct virtio_media_resp_ioctl {
> +	struct virtio_media_resp_header hdr;
> +};
> +
> +/**
> + * struct virtio_media_sg_entry - Description of part of a scattered guest
> + *                                memory.
> + * @start: start guest address of the memory segment.
> + * @len: length of this memory segment.
> + * @__reserved: must be set to zero by the driver.
> + */
> +struct virtio_media_sg_entry {
> +	u64 start;
> +	u32 len;
> +	u32 __reserved;
> +};
> +
> +#define VIRTIO_MEDIA_MMAP_FLAG_RW BIT(0)


Suggest just creating macros for bit numbers.
Users will either use BIT or whatever they want.

> +
> +/**
> + * VIRTIO_MEDIA_CMD_MMAP - Command for mapping a MMAP buffer into the driver's
> + * address space.
> + *
> + */
> +#define VIRTIO_MEDIA_CMD_MMAP 4
> +
> +/**
> + * struct virtio_media_cmd_mmap - Driver command for VIRTIO_MEDIA_CMD_MMAP.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MMAP.
> + * @session_id: ID of the session we are mapping for.
> + * @flags: combination of VIRTIO_MEDIA_MMAP_FLAG_*.
> + * @offset: mem_offset field of the plane to map, as returned by
> + *          VIDIOC_QUERYBUF.
> + */
> +struct virtio_media_cmd_mmap {
> +	struct virtio_media_cmd_header hdr;
> +	u32 session_id;
> +	u32 flags;
> +	u32 offset;
> +};
> +
> +/**
> + * struct virtio_media_resp_mmap - Device response for VIRTIO_MEDIA_CMD_MMAP.
> + * @hdr: header containing the status of the command.
> + * @driver_addr: offset into SHM region 0 of the start of the mapping.
> + * @len: length of the mapping.
> + */
> +struct virtio_media_resp_mmap {
> +	struct virtio_media_resp_header hdr;
> +	u64 driver_addr;
> +	u64 len;
> +};
> +
> +/**
> + * VIRTIO_MEDIA_CMD_MUNMAP - Unmap a MMAP buffer previously mapped using
> + * VIRTIO_MEDIA_CMD_MMAP.
> + */
> +#define VIRTIO_MEDIA_CMD_MUNMAP 5
> +
> +/**
> + * struct virtio_media_cmd_munmap - Driver command for VIRTIO_MEDIA_CMD_MUNMAP.
> + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MUNMAP.
> + * @driver_addr: offset into SHM region 0 at which the buffer has been
> + *               previously
> + * mapped.
> + */
> +struct virtio_media_cmd_munmap {
> +	struct virtio_media_cmd_header hdr;
> +	u64 driver_addr;
> +};
> +
> +/**
> + * struct virtio_media_resp_munmap - Device response for
> + *                                   VIRTIO_MEDIA_CMD_MUNMAP.
> + * @hdr: header containing the status of the command.
> + */
> +struct virtio_media_resp_munmap {
> +	struct virtio_media_resp_header hdr;
> +};
> +
> +/* The values for these events are set by the virtio-media specification. */
> +#define VIRTIO_MEDIA_EVT_ERROR 0
> +#define VIRTIO_MEDIA_EVT_DQBUF 1
> +#define VIRTIO_MEDIA_EVT_EVENT 2
> +
> +/**
> + * struct virtio_media_event_header - Header for events on the eventq.
> + * @event: one of VIRTIO_MEDIA_EVT_*
> + * @session_id: ID of the session the event applies to.
> + */
> +struct virtio_media_event_header {
> +	u32 event;
> +	u32 session_id;
> +};
> +
> +/**
> + * struct virtio_media_event_error - Unrecoverable device-side error.
> + * @hdr: header for the event.
> + * @errno: error code describing the kind of error that occurred.
> + * @__reserved: must to set to zero by the device.
> + *
> + * Upon receiving this event, the session mentioned in the header is considered
> + * corrupted and closed.
> + *
> + */
> +struct virtio_media_event_error {
> +	struct virtio_media_event_header hdr;
> +	u32 errno;
> +	u32 __reserved;
> +};
> +
> +/* This is set to VIDEO_MAX_PLANES defined in include/uapi/linux/videodev2.h.
> + * It is renamed here to match the constant that is defined in the virtio-media
> + * specification.
> + */
> +#define VIRTIO_MEDIA_MAX_PLANES VIDEO_MAX_PLANES
> +
> +/**
> + * struct virtio_media_event_dqbuf - Dequeued buffer event.
> + * @hdr: header for the event.
> + * @buffer: struct v4l2_buffer describing the buffer that has been dequeued.
> + * @planes: plane information for the dequeued buffer.
> + *
> + * This event is used to signal that a buffer is not being used anymore by the
> + * device and is returned to the driver.
> + */
> +struct virtio_media_event_dqbuf {
> +	struct virtio_media_event_header hdr;
> +	struct v4l2_buffer buffer;
> +	struct v4l2_plane planes[VIRTIO_MEDIA_MAX_PLANES];
> +};
> +
> +/**
> + * struct virtio_media_event_event - V4L2 event.
> + * @hdr: header for the event.
> + * @event: description of the event that occurred.
> + *
> + * This event signals that a V4L2 event has been emitted for a session.
> + */
> +struct virtio_media_event_event {
> +	struct virtio_media_event_header hdr;
> +	struct v4l2_event event;
> +};
> +
> +/* Maximum size of an event. We will queue descriptors of this size on the
> + * eventq.
> + */
> +#define VIRTIO_MEDIA_EVENT_MAX_SIZE sizeof(struct virtio_media_event_dqbuf)
> +
> +#endif // __VIRTIO_MEDIA_PROTOCOL_H
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog

