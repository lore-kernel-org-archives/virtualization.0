Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB53F86F8
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786644043; cv=none; b=H/b82xVBruQEoEoK2wiSIuTULMDslrKsUUlZyG54h0B+dWqLG4ay6XGx0RSqVYMiJ+gsmzPCJgwUCKmz819iw9MdMGfyzBOSTEpJL0KMSkLJ9LKfH22/Ky3V+t/afMNmx34AU0M1CdnNzSz47i4rdnVUm6ttMpb6KxOO5ta8TfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786644043; c=relaxed/simple;
	bh=7JCmGgyQKZSGYWLUqubo4jFHkFN4wW3j1DwBwsXkNag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIfJZWTA3maG+DeL3mXv1XYvnEBMRG7aFbARDHqGVYwgcg1bkBReSrTFNchkpQlVLP2NMnMVT0lcN58vSqVQ07UGswTpy2mxxPRJbeWrU7hwi0XtQUfKATTmYw/hZHTLkZ6uw3A/FPkAGIn3JpDcfnmCYZVUfrqKWTdnXP9236Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RceuHGhQ; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RceuHGhQ"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930edb4362dso15334985a.3
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786644039; x=1787248839; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xt3nUEAuloxLMHSxQ7NvzWiVS+LVsLNH3iwljD2G01w=;
        b=RceuHGhQe2xFOSOfm8nlw4wX9Wp6Hyo+jtea37twmQWKOmoVkQf9e2Zcgjg5rlBnFZ
         phEq0H2CG5LTyy4HSyhPKG5cOvZD/ETDX3uIA4K76uydekfGM/9OSt7ZKuG3gI23p3ZI
         uUATokVyGGyPgKsRimqbHLCeC/YeGuRWqUf8NQfux3oM78YC0zzSxJKgStFr+Gx7O9Pj
         hOg7F/x5hYyGZf4X0oxksqpU8xwcElmr6GkwrsqI8+iq24QCkdFUleUJQBaECjKnz6ub
         sgdlDcbcPhsyqfZf7odgujQrOV+c+dCvmlv+0pJliIxIMSZ6dy3+uyPKZQviblUgZkTJ
         xe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786644039; x=1787248839;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xt3nUEAuloxLMHSxQ7NvzWiVS+LVsLNH3iwljD2G01w=;
        b=S2rwHJwf8R4v5brs1ltv5OhhPPDrnE2mPB4HibmbqdBUpL6HkGhQsSRy9UckHabL+y
         p0Wu6plCTlQ+swh22lq51RmFWv1OERTaRsqc7rz+aA7Ok72EK8OCy4Pa6YIdmA9O0dG6
         GrGuHmiFztj4E4hjSwPr/rYVFK2DhtFvoJmtXZhX8lzNdztKHgGqZZhp8ekrjN9Uxx7g
         aOHFkhwlBB86XA3tONlZhAFwcPCJkJF51qdYqr7xCWrAx47VSjf8DuHB/EjTqonGkvCk
         eZqMmDZsquznDMYDW/un9l8jISIq5piha27wf1kK9GQmpbT39P5dtKZNOGl4UyoSS5j7
         HCAA==
X-Forwarded-Encrypted: i=1; AHgh+Roy56illlhWIiXZ7A6S7+KESiMlD+REkRKlQ25KD8P/hRYOFTjXrGF2zIFFidMqTpFSXGyyhTU9yTawJJjTuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7at5kL400gTv00g3MlXgdA+/g54N/1qGfi1V7W98Mp7rvanCv
	uXhJHecGsBaYAB/9twttGEzBJqrL2zErfMznYZWnT2uUdRr5vcwZsqoJYRsTfyRnOiNfyhPcK1s
	th2h2uCwEWakzCG+kVqcQo5n8p7fH
X-Received: from qknre11.prod.google.com ([2002:a05:620a:8e0b:b0:92e:59b9:7dc0])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:cf1:b0:914:bf8a:ba81 with SMTP id af79cd13be357-936bfa349c1mr652429285a.27.1786644038648;
 Thu, 13 Aug 2026 11:00:38 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:00:23 -0400
In-Reply-To: <20260813180026.2636879-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260813180026.2636879-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260813180026.2636879-2-briandaniels@google.com>
Subject: [PATCH v7 1/4] media: virtio: Add skeleton virtio-media driver
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mst@redhat.com, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, dbassey@redhat.com, 
	laurent.pinchart@ideasonboard.com, Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

This patch adds a minimum viable virtio-media driver that binds to the
virtio device and registers a V4L2 device and a video device, but lacks
any actual functionality.

It adds the UAPI header defining the protocol, internal driver headers,
Kconfig and Makefile entries, and MAINTAINERS entry. Many of the structs
in the protocol add reserved bits. These are present to ensure 64-bit
alignment. They are not intended to be used as reserved expansion for
the protocol in the future, so more reserved space is not required.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: Antigravity:gemini-3.5-flash
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 MAINTAINERS                                |   8 +
 drivers/media/Kconfig                      |  13 +
 drivers/media/Makefile                     |   2 +
 drivers/media/virtio/Makefile              |   7 +
 drivers/media/virtio/virtio_media.h        |  95 +++++++
 drivers/media/virtio/virtio_media_driver.c | 146 +++++++++++
 include/uapi/linux/virtio_media.h          | 287 +++++++++++++++++++++
 7 files changed, 558 insertions(+)
 create mode 100644 drivers/media/virtio/Makefile
 create mode 100644 drivers/media/virtio/virtio_media.h
 create mode 100644 drivers/media/virtio/virtio_media_driver.c
 create mode 100644 include/uapi/linux/virtio_media.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3785b8c1d..c3b5c5eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28573,6 +28573,7 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
+F:	drivers/media/virtio/
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
@@ -28685,6 +28686,13 @@ S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
 F:	include/uapi/linux/virtio_iommu.h
 
+VIRTIO MEDIA DRIVER
+M:	Brian Daniels <briandaniels@google.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/virtio/
+F:	include/uapi/linux/virtio_media.h
+
 VIRTIO MEM DRIVER
 M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 6abc9302c..ce7d088e7 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -136,6 +136,19 @@ config MEDIA_PLATFORM_SUPPORT
 
 	  Say Y when you want to be able to see such devices.
 
+config MEDIA_VIRTIO
+	tristate "Virtio-media Driver"
+	depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || CPU_LITTLE_ENDIAN)
+	select VIDEOBUF2_CORE
+	select VIDEOBUF2_MEMOPS
+	help
+	  Enables the virtio-media driver.
+
+	  This driver is used to virtualize media devices such as cameras or
+	  decoders from a host into a guest using the V4L2 protocol.
+
+	  If unsure, say N.
+
 config MEDIA_TEST_SUPPORT
 	bool
 	prompt "Test drivers" if MEDIA_SUPPORT_FILTER
diff --git a/drivers/media/Makefile b/drivers/media/Makefile
index 20fac24e4..357e786cc 100644
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -23,6 +23,8 @@ obj-$(CONFIG_DVB_CORE) += dvb-core/
 # There are both core and drivers at RC subtree - merge before drivers
 obj-y += rc/
 
+obj-$(CONFIG_MEDIA_VIRTIO) += virtio/
+
 obj-$(CONFIG_CEC_CORE) += cec/
 
 #
diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio/Makefile
new file mode 100644
index 000000000..09d9834da
--- /dev/null
+++ b/drivers/media/virtio/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the virtio-media device driver.
+
+virtio-media-objs := virtio_media_driver.o
+
+obj-$(CONFIG_MEDIA_VIRTIO) += virtio-media.o
diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
new file mode 100644
index 000000000..7acb2b842
--- /dev/null
+++ b/drivers/media/virtio/virtio_media.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Virtio-media structures & functions declarations.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_H
+#define __VIRTIO_MEDIA_H
+
+#include <linux/virtio_config.h>
+#include <media/v4l2-device.h>
+
+#include "uapi/linux/virtio_media.h"
+
+#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
+
+#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
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
+ * @sessions_lock: protects @sessions and &struct virtio_media_session.list.
+ * @events_lock: prevents concurrent processing of events.
+ * @cmd: union of the device commands ``open`` and ``munmap``. The other
+ *       commands are handled by &struct virtio_media_session
+ * @resp: union of responses to device commands ``open`` and ``munmap``. The
+ *        other responses are handled by &struct virtio_media_session
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
+	__dma_from_device_group_begin();
+	union {
+		struct virtio_media_cmd_open open;
+		struct virtio_media_cmd_munmap munmap;
+	} cmd;
+
+	union {
+		struct virtio_media_resp_open open;
+		struct virtio_media_resp_munmap munmap;
+	} resp;
+	__dma_from_device_group_end();
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
+
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
new file mode 100644
index 000000000..25f2ceaa6
--- /dev/null
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
+
+/*
+ * Virtio-media driver.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
+
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+
+#include "uapi/linux/virtio_media.h"
+#include "virtio_media.h"
+
+static void commandq_callback(struct virtqueue *vq)
+{
+}
+
+static void eventq_callback(struct virtqueue *vq)
+{
+}
+
+static const struct v4l2_file_operations virtio_media_fops = {
+	.owner = THIS_MODULE,
+	.open = v4l2_fh_open,
+	.release = v4l2_fh_release,
+};
+
+static int virtio_media_probe(struct virtio_device *virtio_dev)
+{
+	struct device *dev = &virtio_dev->dev;
+	struct virtqueue *vqs[2];
+	static struct virtqueue_info vq_info[2] = {
+		{
+			.name = "command",
+			.callback = commandq_callback,
+		},
+		{
+			.name = "event",
+			.callback = eventq_callback,
+		},
+	};
+	struct virtio_media *vv;
+	struct video_device *vd;
+	int ret;
+
+	vv = devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
+	if (!vv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vv->sessions);
+	mutex_init(&vv->sessions_lock);
+	mutex_init(&vv->events_lock);
+	mutex_init(&vv->vlock);
+
+	vv->virtio_dev = virtio_dev;
+	virtio_dev->priv = vv;
+
+	init_waitqueue_head(&vv->wq);
+
+	ret = v4l2_device_register(dev, &vv->v4l2_dev);
+	if (ret)
+		return ret;
+
+	ret = virtio_find_vqs(virtio_dev, 2, vqs, vq_info, NULL);
+	if (ret)
+		goto err_find_vqs;
+
+	vv->commandq = vqs[0];
+	vv->eventq = vqs[1];
+
+	vd = &vv->video_dev;
+	vd->v4l2_dev = &vv->v4l2_dev;
+	vd->vfl_type = VFL_TYPE_VIDEO;
+	vd->fops = &virtio_media_fops;
+	vd->release = video_device_release_empty;
+	strscpy(vd->name, "virtio-media", sizeof(vd->name));
+
+	video_set_drvdata(vd, vv);
+
+	vd->device_caps = virtio_cread32(virtio_dev, 0);
+	if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
+		vd->vfl_dir = VFL_DIR_M2M;
+	else if (vd->device_caps &
+		 (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE))
+		vd->vfl_dir = VFL_DIR_TX;
+	else
+		vd->vfl_dir = VFL_DIR_RX;
+
+	ret = video_register_device(vd, virtio_cread32(virtio_dev, 4), 0);
+	if (ret)
+		goto err_register_device;
+
+	virtio_device_ready(virtio_dev);
+
+	return 0;
+
+err_register_device:
+	virtio_dev->config->del_vqs(virtio_dev);
+err_find_vqs:
+	v4l2_device_unregister(&vv->v4l2_dev);
+	return ret;
+}
+
+static void virtio_media_remove(struct virtio_device *virtio_dev)
+{
+	struct virtio_media *vv = virtio_dev->priv;
+
+	virtio_reset_device(virtio_dev);
+	v4l2_device_unregister(&vv->v4l2_dev);
+	virtio_dev->config->del_vqs(virtio_dev);
+	video_unregister_device(&vv->video_dev);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_MEDIA, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static unsigned int features[] = {};
+
+static struct virtio_driver virtio_media_driver = {
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
+	.driver.name = VIRTIO_MEDIA_DEFAULT_DRIVER_NAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = virtio_media_probe,
+	.remove = virtio_media_remove,
+};
+
+module_virtio_driver(virtio_media_driver);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("virtio media driver");
+MODULE_AUTHOR("Alexandre Courbot <gnurou@gmail.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virtio_media.h
new file mode 100644
index 000000000..280fbbe94
--- /dev/null
+++ b/include/uapi/linux/virtio_media.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+/*
+ * Definitions of virtio-media protocol structures.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_PROTOCOL_H
+#define __VIRTIO_MEDIA_PROTOCOL_H
+
+#include <linux/videodev2.h>
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
+ *          codes as a positive integer.
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
+ * This is the equivalent of calling ``open`` on a V4L2 device node. Upon
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
+ * @session_id: if &struct virtio_media_resp_header.status == 0, contains the
+ *              id of the newly created session.
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
+ * This is the equivalent of calling ``close`` on a previously opened V4L2
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
+ * This command asks the device to run one of the ``VIDIOC_*`` ioctls on the
+ * active session.
+ *
+ * The code of the ioctl is extracted from the VIDIOC_* definitions in
+ * ``videodev2.h``, and consists of the second argument of the ``_IO*`` macro.
+ *
+ * Each ioctl has a payload, which is defined by the third argument of the
+ * ``_IO*`` macro defining it. It can be writable by the driver (``_IOW``), the
+ * device (``_IOR``), or both (``_IOWR``).
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
+/**
+ * VIRTIO_MEDIA_MMAP_FLAG_RW - Bit position of the VIRTIO_MEDIA_MMAP_FLAG_RW
+ *                             flag.
+ */
+#define VIRTIO_MEDIA_MMAP_FLAG_RW 0
+
+/**
+ * VIRTIO_MEDIA_CMD_MMAP - Command for mapping a MMAP buffer into the driver's
+ *                         address space.
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
+ *                           VIRTIO_MEDIA_CMD_MMAP.
+ */
+#define VIRTIO_MEDIA_CMD_MUNMAP 5
+
+/**
+ * struct virtio_media_cmd_munmap - Driver command for VIRTIO_MEDIA_CMD_MUNMAP.
+ * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MUNMAP.
+ * @driver_addr: offset into SHM region 0 at which the buffer has been
+ *               previously mapped.
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
+ * @__reserved: must be set to zero by the device.
+ *
+ * Upon receiving this event, the session mentioned in the header is considered
+ * corrupted and closed.
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
+ * @buffer: &struct v4l2_buffer describing the buffer that has been dequeued.
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
2.55.0.737.g08866a6d13-goog

