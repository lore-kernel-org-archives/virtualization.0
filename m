Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDCC35A952
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161041; cv=none; b=oNfOFPg1SZP4vtWezZlqqYbOhynE6ixW3TbrtUIEslqo7Hy5Wai/1yAGWabnASvd4kai85Kjh+YKL3zCkYJIhSvlmyTN8hrYOxQRD5AUlGUVOz+/K6P1Ra6xGnz69HS3lYMLZF1FeExBS6GodY/QTuw+tKCUH2KzDMsDpkDiKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161041; c=relaxed/simple;
	bh=IVQLABmb+jM9dcUJYK4O/h9eVh44A6ugotGik8TQcFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1ku06ECCdC7aZgRutGfCHPsUDfGsWVkzkt05KuotT8Hb5HGzIWE7EGvE/juRpBrIqdiuVhEHKbO+q88QVPrIfKFvKmKPIAy6O4bZHAxqkOJMJkoMuHT1AazkwNbCVp+LpZmdUQvpc4PJV1X468aM0E4wF8j8vzgpaIl5blwBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L1G/0cig; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L1G/0cig"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5175aa1a54bso82600191cf.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782161038; x=1782765838; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9U1MlIjEq+OjQJi6i4/DTaCyDJRNKwrS8TtuW05m8Ow=;
        b=L1G/0cigps6Q2/h11uj+22+SkZF65HIZdlUrvCpIPccc6GWFZDQszMphDg6ADXl647
         WbilvV1w84iaYjZYh/GXoeXoauojk8u4k5A6sTjcreaoLycNszO0O6f9JEpLhvCqZPzd
         8HmHC90SWdjTjbihMO6j4jIniMbX4WpBeVxv9BxsugJAUC97dTzOj+iKfnKs8j3THf5X
         PAiKxx6Y9qkq/oAC+zvRhWavcbalHf6kelDwQ5P2nHU0FeGFPvOvzmuKf8yaO1KGTH+U
         faOHbZ6rppmg8zq5FhqceKAMqFbB4KLBkVDlV1E6wl3PUv6UXHr3jHlPCQKRjcuMUubf
         V6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161038; x=1782765838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U1MlIjEq+OjQJi6i4/DTaCyDJRNKwrS8TtuW05m8Ow=;
        b=pfkGl01asdzlnjAJtRkKlEddRKCPB2dCPcYAngh/z9uK18sxk2ROVCqiI0Suefk5DF
         lce0KG8RKr5jtWRjFN2DpoxlRpwggMPL+7uXOQ2dQxkyKPeEcvtsoyjAKJwyFaYgorA0
         CFW9+PPxw+Fn+m4oN8uhdX+YYcE15npGOh5ZH9rZhrmKmWP0KzhemfrIR6uqIwaZWu5o
         nel97JE/OYAyaVUNPRtZ/Ba9SuL/CXANjw2gD0vPdrZu9vlw1MSjqp+Y/BZJRrek3zOX
         qX9avqua168XTjmGuMMkO247QIx1dHz834hCtznJhGhopRMCvBSsLePZE7M69bNbpY/X
         qrLg==
X-Forwarded-Encrypted: i=1; AFNElJ/wQ5U4Gps1j4oLf0T4AMHHqiVYBib3SQlo8Ci7VuaoPFOomVhZB+7mNG8Xm9bFCsFeK/4aAUunl7o4k8gpkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcZ9z415TU7YDBvxSH+P6tKMWO7FRTqqtsShjirZIAYzaFSePk
	VV4G3ravdnlf2QIn+ke0tzF0QmzWhlPOnsLwY16E9KZ+mnelI6u9x55/XI9Cyp83nmnVVJjxqme
	WTJ2WBvhkjTCacovQ73B3+6Qun8bX
X-Received: from qthc6.prod.google.com ([2002:ac8:546:0:b0:510:12be:1abd])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1923:b0:517:260f:8e95 with SMTP id d75a77b69052e-519e49155f4mr254675631cf.8.1782161038278;
 Mon, 22 Jun 2026 13:43:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:36 -0400
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622204343.1994418-2-briandaniels@google.com>
Subject: [PATCH v4 1/8] media: virtio: Add protocol
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: acourbot@google.com, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add the identifiers and structs used to implement the virtio interface
as described in section 5.22 of version 1.4 of the virtio spec:

https://docs.oasis-open.org/virtio/virtio/v1.4/csprd01/virtio-v1.4-csprd01-diff-from-v1.2-cs01.html#x1-82200022

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/protocol.h | 287 ++++++++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 drivers/media/virtio/protocol.h

diff --git a/drivers/media/virtio/protocol.h b/drivers/media/virtio/protocol.h
new file mode 100644
index 000000000..5878d107c
--- /dev/null
+++ b/drivers/media/virtio/protocol.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Definitions of virtio-media protocol structures.
+ *
+ * Copyright (c) 2024-2025 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_PROTOCOL_H
+#define __VIRTIO_MEDIA_PROTOCOL_H
+
+#include <linux/videodev2.h>
+#include <linux/bits.h>
+
+/*
+ * Virtio protocol definition.
+ */
+
+/**
+ * struct virtio_media_cmd_header - Header for all virtio-media commands.
+ * @cmd: one of VIRTIO_MEDIA_CMD_*.
+ * @__reserved: must be set to zero by the driver.
+ *
+ * This header starts all commands from the driver to the device on the
+ * commandq.
+ */
+struct virtio_media_cmd_header {
+	u32 cmd;
+	u32 __reserved;
+};
+
+/**
+ * struct virtio_media_resp_header - Header for all virtio-media responses.
+ * @status: 0 if the command was successful, or one of the standard Linux error
+ * codes.
+ * @__reserved: must be set to zero by the device.
+ *
+ * This header starts all responses from the device to the driver on the
+ * commandq.
+ */
+struct virtio_media_resp_header {
+	u32 status;
+	u32 __reserved;
+};
+
+/**
+ * VIRTIO_MEDIA_CMD_OPEN - Command for creating a new session.
+ *
+ * This is the equivalent of calling `open` on a V4L2 device node. Upon
+ * success, a session id is returned which can be used to perform other
+ * commands on the session, notably ioctls.
+ */
+#define VIRTIO_MEDIA_CMD_OPEN 1
+
+/**
+ * struct virtio_media_cmd_open - Driver command for VIRTIO_MEDIA_CMD_OPEN.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_OPEN.
+ */
+struct virtio_media_cmd_open {
+	struct virtio_media_cmd_header hdr;
+};
+
+/**
+ * struct virtio_media_resp_open - Device response for VIRTIO_MEDIA_CMD_OPEN.
+ * @hdr: header containing the status of the command.
+ * @session_id: if hdr.status == 0, contains the id of the newly created
+ *              session.
+ * @__reserved: must be set to zero by the device.
+ */
+struct virtio_media_resp_open {
+	struct virtio_media_resp_header hdr;
+	u32 session_id;
+	u32 __reserved;
+};
+
+/**
+ * VIRTIO_MEDIA_CMD_CLOSE - Command for closing an active session.
+ *
+ * This is the equivalent of calling `close` on a previously opened V4L2
+ * session. All resources associated with this session will be freed and the
+ * session ID shall not be used again after queueing this command.
+ *
+ * This command does not require a response from the device.
+ */
+#define VIRTIO_MEDIA_CMD_CLOSE 2
+
+/**
+ * struct virtio_media_cmd_close - Driver command for VIRTIO_MEDIA_CMD_CLOSE.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_CLOSE.
+ * @session_id: id of the session to close.
+ * @__reserved: must be set to zero by the driver.
+ */
+struct virtio_media_cmd_close {
+	struct virtio_media_cmd_header hdr;
+	u32 session_id;
+	u32 __reserved;
+};
+
+/**
+ * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioctl.
+ *
+ * This command asks the device to run one of the `VIDIOC_*` ioctls on the
+ * active session.
+ *
+ * The code of the ioctl is extracted from the VIDIOC_* definitions in
+ * `videodev2.h`, and consists of the second argument of the `_IO*` macro.
+ *
+ * Each ioctl has a payload, which is defined by the third argument of the
+ * `_IO*` macro defining it. It can be writable by the driver (`_IOW`), the
+ * device (`_IOR`), or both (`_IOWR`).
+ *
+ * If an ioctl is writable by the driver, it must be followed by a
+ * driver-writable descriptor containing the payload.
+ *
+ * If an ioctl is writable by the device, it must be followed by a
+ * device-writable descriptor of the size of the payload that the device will
+ * write into.
+ *
+ */
+#define VIRTIO_MEDIA_CMD_IOCTL 3
+
+/**
+ * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MEDIA_CMD_IOCTL.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
+ * @session_id: id of the session to run the ioctl on.
+ * @code: code of the ioctl to run.
+ */
+struct virtio_media_cmd_ioctl {
+	struct virtio_media_cmd_header hdr;
+	u32 session_id;
+	u32 code;
+};
+
+/**
+ * struct virtio_media_resp_ioctl - Device response for VIRTIO_MEDIA_CMD_IOCTL.
+ * @hdr: header containing the status of the ioctl.
+ */
+struct virtio_media_resp_ioctl {
+	struct virtio_media_resp_header hdr;
+};
+
+/**
+ * struct virtio_media_sg_entry - Description of part of a scattered guest
+ *                                memory.
+ * @start: start guest address of the memory segment.
+ * @len: length of this memory segment.
+ * @__reserved: must be set to zero by the driver.
+ */
+struct virtio_media_sg_entry {
+	u64 start;
+	u32 len;
+	u32 __reserved;
+};
+
+#define VIRTIO_MEDIA_MMAP_FLAG_RW BIT(0)
+
+/**
+ * VIRTIO_MEDIA_CMD_MMAP - Command for mapping a MMAP buffer into the driver's
+ * address space.
+ *
+ */
+#define VIRTIO_MEDIA_CMD_MMAP 4
+
+/**
+ * struct virtio_media_cmd_mmap - Driver command for VIRTIO_MEDIA_CMD_MMAP.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MMAP.
+ * @session_id: ID of the session we are mapping for.
+ * @flags: combination of VIRTIO_MEDIA_MMAP_FLAG_*.
+ * @offset: mem_offset field of the plane to map, as returned by
+ *          VIDIOC_QUERYBUF.
+ */
+struct virtio_media_cmd_mmap {
+	struct virtio_media_cmd_header hdr;
+	u32 session_id;
+	u32 flags;
+	u32 offset;
+};
+
+/**
+ * struct virtio_media_resp_mmap - Device response for VIRTIO_MEDIA_CMD_MMAP.
+ * @hdr: header containing the status of the command.
+ * @driver_addr: offset into SHM region 0 of the start of the mapping.
+ * @len: length of the mapping.
+ */
+struct virtio_media_resp_mmap {
+	struct virtio_media_resp_header hdr;
+	u64 driver_addr;
+	u64 len;
+};
+
+/**
+ * VIRTIO_MEDIA_CMD_MUNMAP - Unmap a MMAP buffer previously mapped using
+ * VIRTIO_MEDIA_CMD_MMAP.
+ */
+#define VIRTIO_MEDIA_CMD_MUNMAP 5
+
+/**
+ * struct virtio_media_cmd_munmap - Driver command for VIRTIO_MEDIA_CMD_MUNMAP.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MUNMAP.
+ * @driver_addr: offset into SHM region 0 at which the buffer has been
+ *               previously
+ * mapped.
+ */
+struct virtio_media_cmd_munmap {
+	struct virtio_media_cmd_header hdr;
+	u64 driver_addr;
+};
+
+/**
+ * struct virtio_media_resp_munmap - Device response for
+ *                                   VIRTIO_MEDIA_CMD_MUNMAP.
+ * @hdr: header containing the status of the command.
+ */
+struct virtio_media_resp_munmap {
+	struct virtio_media_resp_header hdr;
+};
+
+/* The values for these events are set by the virtio-media specification. */
+#define VIRTIO_MEDIA_EVT_ERROR 0
+#define VIRTIO_MEDIA_EVT_DQBUF 1
+#define VIRTIO_MEDIA_EVT_EVENT 2
+
+/**
+ * struct virtio_media_event_header - Header for events on the eventq.
+ * @event: one of VIRTIO_MEDIA_EVT_*
+ * @session_id: ID of the session the event applies to.
+ */
+struct virtio_media_event_header {
+	u32 event;
+	u32 session_id;
+};
+
+/**
+ * struct virtio_media_event_error - Unrecoverable device-side error.
+ * @hdr: header for the event.
+ * @errno: error code describing the kind of error that occurred.
+ * @__reserved: must to set to zero by the device.
+ *
+ * Upon receiving this event, the session mentioned in the header is considered
+ * corrupted and closed.
+ *
+ */
+struct virtio_media_event_error {
+	struct virtio_media_event_header hdr;
+	u32 errno;
+	u32 __reserved;
+};
+
+/* This is set to VIDEO_MAX_PLANES defined in include/uapi/linux/videodev2.h.
+ * It is renamed here to match the constant that is defined in the virtio-media
+ * specification.
+ */
+#define VIRTIO_MEDIA_MAX_PLANES VIDEO_MAX_PLANES
+
+/**
+ * struct virtio_media_event_dqbuf - Dequeued buffer event.
+ * @hdr: header for the event.
+ * @buffer: struct v4l2_buffer describing the buffer that has been dequeued.
+ * @planes: plane information for the dequeued buffer.
+ *
+ * This event is used to signal that a buffer is not being used anymore by the
+ * device and is returned to the driver.
+ */
+struct virtio_media_event_dqbuf {
+	struct virtio_media_event_header hdr;
+	struct v4l2_buffer buffer;
+	struct v4l2_plane planes[VIRTIO_MEDIA_MAX_PLANES];
+};
+
+/**
+ * struct virtio_media_event_event - V4L2 event.
+ * @hdr: header for the event.
+ * @event: description of the event that occurred.
+ *
+ * This event signals that a V4L2 event has been emitted for a session.
+ */
+struct virtio_media_event_event {
+	struct virtio_media_event_header hdr;
+	struct v4l2_event event;
+};
+
+/* Maximum size of an event. We will queue descriptors of this size on the
+ * eventq.
+ */
+#define VIRTIO_MEDIA_EVENT_MAX_SIZE sizeof(struct virtio_media_event_dqbuf)
+
+#endif // __VIRTIO_MEDIA_PROTOCOL_H
-- 
2.55.0.rc0.799.gd6f94ed593-goog

