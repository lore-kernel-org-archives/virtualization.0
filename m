Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99F363C6A
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161044; cv=none; b=JjzhdXmT0x+KGGAA7wAg6x3d75G6+3wgdSxX0ETHxUvFAkCnzCjwZnsVULymYvOANRDOqPMlzoNzHwT7vBhJKIjsxfSBU6HDcBO/64/C8HveNnwR5PDB9PzoquLsBf8kKKJQwLSIGHaZjSf8qr2Ht/ssTeZGuE7HH4iVpO6SLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161044; c=relaxed/simple;
	bh=2mJ61I5TJUNkGm0PDhijKpL+/E3zhoJyaxpTIBWn790=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mcqI2ZifeOI3t3poFB8x9SEC0d7RCfOyuwKJSPpulnNb9179TWt4HJUwuko+TPvMZmnI69bDRvlvQH53wosEhbQDlRahFAsbSJiJf2L2ijRVOeDvFhc6UoLgocJsElE2dW0WA2j9loJwFX8OeJrPSMmCLbCBLd8pc5TzBqR3QRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQR2p7RU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQR2p7RU"
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-9205e6b0bcaso597879285a.1
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782161042; x=1782765842; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPeGazJ7KQoOREISM/XZdRZoBpHzQAXAz7NAUNnaOTw=;
        b=wQR2p7RUZkCSa/KnO3hpD+8Mi6J+RNHbrhEPPWD0/15yH1TxkGqvYWTB4iPBYB6FUV
         1pTjNOuc+Juaa+kOGvmrdLbvmN5xzEEBZJ7jGDaM0WEPRFmc56s0dSXAffntbI5MAOwW
         vqI/GD4hffN6d4hmSmGRIxNYUxGLtU8vOCRgeVFhAYVuxSHhb5DbBE0RaYpuCltwhtn1
         W5iEcSb+WRlpSOaq5UAiC3wsp+7NB8IyT1YLU0MWKsX6FbDgU1TSb8ZfQCQm8eeBaGdb
         50FV+BF+10mo0HH2aPmmIcW9w1ZPenGJNaVLj7Uk9DUkC5fhzleXgK5Vdo8qTy/ubybY
         ngug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161042; x=1782765842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPeGazJ7KQoOREISM/XZdRZoBpHzQAXAz7NAUNnaOTw=;
        b=LIRQ3VAwNlOIdev3dTGOXxxWcklfc9DZ/ONCtotVvSZ2xHOscor9Ey0aosTsiLy3g3
         5IYMQ/73fMJz6jAPIBvO8CKI0i1ZR1nNAV2aPIMSlBMN1tB/9BM0QweuQS0KsxNbvJe1
         xIsXFdSvYaP9pJ9TIQjznnqKpxm4iAoy9r+5wDCnDQ6V5MKoUrqn72VzDOSg1+rW4ye0
         0kTuEQdSnBg06gshSBc7PUzOAuenoUhbJzA3RpuZqTVszI97WVKdFPud4gMpbfZcqU1q
         rAS4AzT8oKjYJNB3DSoHJGQE42lGJKarCKG1t6SlbFeloShxkSZ56RJxqEsrmq9GLY7K
         DU0g==
X-Forwarded-Encrypted: i=1; AFNElJ94KuTZ3a/2O8AH2advCMBTeus5XJyd2myFNvo9HxRSpN2pDXFp8ErBlFfis+rWPv/HjbOyPCt8DfGCjBoT9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYgU7mQjsBxpmOD9KxamuTizQd9rwLLsvZTkH0/DRfn2Ys8ess
	x8qNy4HwVMYsVoa2bp0RaqMuGFbFBvnv9bzQI0qFbgaZXevMXT33mv+7aNtbWR067/c3Bv3TBmU
	wglKDKuI2pZ90ynaR2WEd3Kp/GW+x
X-Received: from qknru1.prod.google.com ([2002:a05:620a:6841:b0:915:73e8:b754])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:278a:b0:915:f27f:e70e with SMTP id af79cd13be357-9208f161e9bmr2529029185a.23.1782161042055;
 Mon, 22 Jun 2026 13:44:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:37 -0400
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622204343.1994418-3-briandaniels@google.com>
Subject: [PATCH v4 2/8] media: virtio: Add virtio-media driver structs and
 function declarations
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

Add the structs and function declarations for the new virtio-media drvier.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/virtio_media.h | 95 +++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 drivers/media/virtio/virtio_media.h

diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
new file mode 100644
index 000000000..52809d4e9
--- /dev/null
+++ b/drivers/media/virtio/virtio_media.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Virtio-media structures & functions declarations.
+ *
+ * Copyright (c) 2024-2025 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_H
+#define __VIRTIO_MEDIA_H
+
+#include <linux/virtio_config.h>
+#include <media/v4l2-device.h>
+
+#include "protocol.h"
+
+#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
+
+#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
+
+extern char *virtio_media_driver_name;
+extern bool virtio_media_allow_userptr;
+
+/**
+ * struct virtio_media - Virtio-media device.
+ * @v4l2_dev: v4l2_device for the media device.
+ * @video_dev: video_device for the media device.
+ * @virtio_dev: virtio device for the media device.
+ * @commandq: virtio command queue.
+ * @eventq: virtio event queue.
+ * @eventq_work: work to run when events are received on @eventq.
+ * @mmap_region: region into which MMAP buffers are mapped by the host.
+ * @event_buffer: buffer for event descriptors.
+ * @sessions: list of active sessions on the device.
+ * @sessions_lock: protects @sessions and ``virtio_media_session::list``.
+ * @events_lock: prevents concurrent processing of events.
+ * @cmd: union of the device commands "open" and "munmap". The other
+ *       commands are handled by @struct virtio_media_session
+ * @resp: union of responses.to device commands "open" and "munmap". The
+ *        other responses are handled by @struct virtio_media_session
+ * @vlock: serializes access to the command queue.
+ * @wq: waitqueue for host responses on the command queue.
+ */
+struct virtio_media {
+	struct v4l2_device v4l2_dev;
+	struct video_device video_dev;
+
+	struct virtio_device *virtio_dev;
+	struct virtqueue *commandq;
+	struct virtqueue *eventq;
+	struct work_struct eventq_work;
+
+	struct virtio_shm_region mmap_region;
+
+	void *event_buffer;
+
+	struct list_head sessions;
+	struct mutex sessions_lock; /* protects sessions list */
+
+	struct mutex events_lock; /* prevents concurrent event processing */
+
+	union {
+		struct virtio_media_cmd_open open;
+		struct virtio_media_cmd_munmap munmap;
+	} cmd;
+
+	union {
+		struct virtio_media_resp_open open;
+		struct virtio_media_resp_munmap munmap;
+	} resp;
+
+	struct mutex vlock; /* serializes command queue access */
+	wait_queue_head_t wq;
+};
+
+static inline struct virtio_media *
+to_virtio_media(struct video_device *video_dev)
+{
+	return container_of(video_dev, struct virtio_media, video_dev);
+}
+
+/* virtio_media_driver.c */
+
+int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
+			      const size_t out_sgs, const size_t in_sgs,
+			      size_t minimum_resp_len, size_t *resp_len);
+void virtio_media_process_events(struct virtio_media *vv);
+
+/* virtio_media_ioctls.c */
+
+long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg);
+extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
+
+#endif // __VIRTIO_MEDIA_H
-- 
2.55.0.rc0.799.gd6f94ed593-goog

