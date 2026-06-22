Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F2364931
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161050; cv=none; b=pjigd0SgmmxNPe6U05ZLFdq+PlqAPRrcUPojDEMzrU/I8m3zG/V/WfL37glGmCLhG6tMhpNIV7RRbxDtakpMHnt0ltEW8bfG6052L2G5DGaGKC+PuwcJDlZJbxiPmaxbYHdybOi6XI9Fta8O1B4ir5OYelCRQgbts1umZwLosYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161050; c=relaxed/simple;
	bh=/kpLieeyRS1BS4DZ/dRcxu1Pc7dUIIoREFKQ6Zh9SR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l3GIh4PHs5/0shghIQKuFgTDAbpGfOJLIiW9xH6L5SS/OZuzpAMbXzcmyn0O5mUnjJYzVHydeaw+V0VxMGGgTLzhm6r9piE2VqjYPmW0qUh4qogfd0xwXOzjg0lhdCAAwtnQSZEuQogwh+Xv512DBAxCGAdYwJlUsFuWnwpPmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n8hhJGQ+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n8hhJGQ+"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-800396d3495so79895007b3.3
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782161044; x=1782765844; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqtxCvW5AADhPRykM+XCtVf3bYVhrjchM1ftr7eV1fE=;
        b=n8hhJGQ+1pRzuOYAeGRmwVYk98D3lkwum/3jqc2StE7plejxCy7/HXfYqzUSQ8VEN9
         LpPNIqIbPCx/PP4V1iRBuRblmCrAKfhwc5jA9qKdyBdbCutD8smL7yPKAYngxml/HcE+
         wj2pcxnHq3QO/crfearFabI8ER6nyWXG0YBGwzUGs9Gz+g7ayUgrEerhvNVmuOE2N2AL
         NhyI7XpQdF0wviEIHvdgPwXE12jAgm0oQNI6Ob09XUwnPdikHW0USUhPkI6yRI2Lm4bB
         p7OpQi241DNyrqby961/EcL5TmXEqxIUwdefdJ5JOg+0D8oMzXD5dpxlHncirUhqesRF
         rVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161044; x=1782765844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqtxCvW5AADhPRykM+XCtVf3bYVhrjchM1ftr7eV1fE=;
        b=Q+8zS/SvGrHx3XJ1MblrBs/jlsKvrLPCxXM6OUO72VzuJ6ty+V8IjfyfJBMI/Kty2j
         nm69XPt28MsbpMBzb6pVp4lj/ItHTy7xXAFZQkeXr1dPnI9W1FlqDtdxABiF6SOZ6/7O
         WyQvuIcnQ5PtJKt4kChkavqokw7Kwt6xotXKKjvOuyB0RLGzC/xP4DMWi6Yd5u/pTK6O
         743xQhqKNXjoea3M6RZG6DBjEQ8vMxrZYE1hDLLH55wRicZ6xyd9wOmDjsd/y11qo+2r
         9P5JWgKsB7hAehcSp8ko90IEAc2srMe9l8v5/GlHTe3RnZBEhUceN+0EXT822rQhjpkd
         8KWA==
X-Forwarded-Encrypted: i=1; AHgh+Rpyx6a+6vaRKuQYa1RW3sdg4VyP/1UyIlZAyAvh5BwOF3tJ64rRMGpiF5mG355gi3lrhJyw7iX4c2V7U+TBZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRRitc4jgjjsKsi3XZ7nq7u9gJFxs/SZzxB94dh6GIsiOLyCNp
	ENMfobT218a6+fbG1GL53b4N1dK7f8e5W15c3zIHmFILLd/Q+bOfHxOuleerorHSSqc/ZPNYVlb
	kprnj01vg7r58HfvqXhpL9fcODDt5
X-Received: from ywbcd4.prod.google.com ([2002:a05:690c:884:b0:7fd:e2e8:a199])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6713:b0:7db:e20c:2b24 with SMTP id 00721157ae682-80133ec5ecbmr170295097b3.45.1782161044011;
 Mon, 22 Jun 2026 13:44:04 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:38 -0400
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622204343.1994418-4-briandaniels@google.com>
Subject: [PATCH v4 3/8] media: virtio: Add virtio-media session related structures
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

Add the structs and functions to manage sessions. A session is
equivalent to opening the /dev/videoX device file of the V4L2 device.

Depending on the type of device, it may be possible to open several
sessions concurrently.

While the session is opened, its ID can be used to perform actions on
it, most commonly V4L2 ioctls.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/session.h | 130 +++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 drivers/media/virtio/session.h

diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
new file mode 100644
index 000000000..4a2360625
--- /dev/null
+++ b/drivers/media/virtio/session.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Definitions of virtio-media session related structures.
+ *
+ * Copyright (c) 2024-2025 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_SESSION_H
+#define __VIRTIO_MEDIA_SESSION_H
+
+#include <linux/scatterlist.h>
+#include <media/v4l2-fh.h>
+
+#include "protocol.h"
+
+#define VIRTIO_MEDIA_LAST_QUEUE (V4L2_BUF_TYPE_META_OUTPUT)
+
+/*
+ * Size of the per-session virtio shadow and event buffers. 16K should be
+ * enough to contain everything we need.
+ */
+#define VIRTIO_SHADOW_BUF_SIZE 0x4000
+
+/**
+ * struct virtio_media_buffer - Current state of a buffer.
+ * @buffer: ``struct v4l2_buffer`` with current information about the buffer.
+ * @planes: backing planes array for @buffer.
+ * @list: link into the list of buffers pending dequeue.
+ */
+struct virtio_media_buffer {
+	struct v4l2_buffer buffer;
+	struct v4l2_plane planes[VIDEO_MAX_PLANES];
+	struct list_head list;
+};
+
+/**
+ * struct virtio_media_queue_state - Represents the state of a V4L2 queue.
+ * @streaming: Whether the queue is currently streaming.
+ * @allocated_bufs: How many buffers are currently allocated.
+ * @is_capture_last: set to true when the last buffer has been received on a
+ * capture queue, so we can return -EPIPE on subsequent DQBUF requests.
+ * @buffers: Buffer state array of size @allocated_bufs.
+ * @queued_bufs: How many buffers are currently queued on the device.
+ * @pending_dqbufs: Buffers that are available for being dequeued.
+ */
+struct virtio_media_queue_state {
+	bool streaming;
+	size_t allocated_bufs;
+	bool is_capture_last;
+
+	struct virtio_media_buffer *buffers;
+	size_t queued_bufs;
+	struct list_head pending_dqbufs;
+};
+
+/**
+ * struct virtio_media_session - A session on a virtio_media device.
+ * @fh: file handler for the session.
+ * @file: file pointer associated with the session's file handler.
+ * @id: session ID used to communicate with the device.
+ * @nonblocking_dequeue: whether dequeue should block or not (nonblocking if
+ * file opened with O_NONBLOCK).
+ * @uses_mplane: whether the queues for this session use the MPLANE API or not.
+ * @cmd: union of session commands "close", "ioctl", and "mmap". A session can
+ *       have one command currently running. The rest of the commands are
+ *       handled by @struct virtio_media.
+ * @resp: union of responses to session commands "close", "ioctl", and "mmap".
+ *        A session can wait on one command only.The rest of the responses are
+ *        handled by @struct virtio_media.
+ * @shadow_buf: shadow buffer where data to be added to the descriptor chain can
+ * be staged before being sent to the device.
+ * @command_sgs: SG table gathering descriptors for a given command and its
+ *               response.
+ * @queues: state of all the queues for this session.
+ * @queues_lock: protects all members for the queues for this session.
+ * virtio_media_queue_state`.
+ * @dqbuf_wait: waitqueue for dequeued buffers, if ``VIDIOC_DQBUF`` needs to
+ * block or when polling.
+ * @list: link into the list of sessions for the device.
+ */
+struct virtio_media_session {
+	struct v4l2_fh fh;
+	struct file *file;
+	u32 id;
+	bool nonblocking_dequeue;
+	bool uses_mplane;
+
+	union {
+		struct virtio_media_cmd_close close;
+		struct virtio_media_cmd_ioctl ioctl;
+		struct virtio_media_cmd_mmap mmap;
+	} cmd;
+
+	union {
+		struct virtio_media_resp_ioctl ioctl;
+		struct virtio_media_resp_mmap mmap;
+	} resp;
+
+	void *shadow_buf;
+
+	struct sg_table command_sgs;
+
+	struct virtio_media_queue_state queues[VIRTIO_MEDIA_LAST_QUEUE + 1];
+	struct mutex queues_lock; /* protects queues array and states */
+	wait_queue_head_t dqbuf_wait;
+
+	struct list_head list;
+};
+
+static inline struct virtio_media_session *fh_to_session(struct v4l2_fh *fh)
+{
+	return container_of(fh, struct virtio_media_session, fh);
+}
+
+static inline void
+virtio_media_session_fh_add(struct virtio_media_session *session,
+			    struct file *file)
+{
+	v4l2_fh_add(&session->fh, file);
+	session->file = file;
+}
+
+static inline void
+virtio_media_session_fh_del(struct virtio_media_session *session)
+{
+	v4l2_fh_del(&session->fh, session->file);
+}
+
+#endif // __VIRTIO_MEDIA_SESSION_H
-- 
2.55.0.rc0.799.gd6f94ed593-goog

