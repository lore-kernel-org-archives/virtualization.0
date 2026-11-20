Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211975;
	b=Oc3at07boyPDp3Mf7++Vy6u35FyFBcgkwpyxpQTRstqVzATjw3LiYpGkW8RCu6r0RECq
	 vBAZ1dG+Zj6iF7tIt5RNbhUqqytFcK1MhkSds8zo7Uvu2cvl1gBtjJ5ylTJlCeUXZ5YAC
	 zdAjH71w+Kp+huI9IH0jiXpcJeo4Xk05l+U8H/BohxU+7fnKdo8MhPARmR8ckxbDuaQJD
	 vDum6xZOCAatahNWUXgh64f4+pqtZg/M7aAawlwIYNrzQNzHvEQHjf+2BY3IQmSuuX8xr
	 Taer+lNZcUdtXpeIiVE3cmPYbXFa+aZHSLhVisIH+SZOunatDzEnvigAZI8jRg5p6MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4w4Q9ZG7x/vNPSW7+FRl+kNIJqFLWi67ftuc3P54atE=;
	b=CdvmSbM/BK49ASPk6DL1N5F26q6AweXsqvntOZEM/pYSNx8APkdyAUqQbty+QzpzXV0W
	 G+ChRoRWIXcz/kYulFYnvxShXUzQD/CNOiOT+EZz97a5uMoDFz1Tv54A/9BUbACqvcBTb
	 UNG76NDODSEtknWmEP9R0dDd33nP7hAyEu2v5I+6BfykJIzgojsIBK2csz/4HOq1pLuqY
	 2HgRUkL/Mxa1EYmp3FjnFazTbaxzndcdIhacB2A6DErOv1xm8rzSmOhZqT+jaQZKljkvm
	 C1aI1AcOpdFmHv9sNXFaMTGuDHX5tYhzIs7JyI12Vsf5ft3u7I252F5102LOYh1abrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k/VVBQ9K";
	arc=none smtp.remote-ip=209.85.219.71
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBAB606A33A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 21:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBAB606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k/VVBQ9K
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-921246186bfso29538336d6.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211965; x=1795816765; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4w4Q9ZG7x/vNPSW7+FRl+kNIJqFLWi67ftuc3P54atE=;
        b=k/VVBQ9KmlZh8BEexbKNn1bqgQFnjtRz5tQUgRCdbkCSvoNh608osTFDhcz+vvpu6X
         jP4jJvQdKYuvYwS1rKnS+iFHGJpXqfxgRVjdjk3IO0KkR2xj+kQoT8rR5zM/umv4ugqu
         xxaSwrfCJoYbzMnApedq1GtEOigpgJLssxKAhqBOb58Wxlcfc3lQ1ZwLKbOZXLAGCh0C
         Fx8xGoNh3DrqdRBYNjW0bhXcg63MsxrbN7W8w/1ZiHGZkgTjZcggwcPw/Ao4A3UgjtdK
         GsccOogM5rN919RKPWziVuHl4JLv0mfvs1B6qNLoXH1M1JgZDCCd+Efeh4LoJ6waJmyN
         fhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211965; x=1795816765;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4w4Q9ZG7x/vNPSW7+FRl+kNIJqFLWi67ftuc3P54atE=;
        b=DAZg9iV0E9VzVSFlB1NEwbERCuqfmB6/sC2qql8hJBhOn3MrtQ2IsSCa3eX+MNdrit
         btWRpO3IYR2IlF5SfPZYAo6lw20nItzHS+9rE4kxPRbjAUVd3u2Rf/cJHUnshq55tmur
         tlHvBA4e1xUO02+ZcEYHX3fLMMjo9Ldx5cJRfYxgimHx/Wc6NoWY2+NpzrrXZXtQlQkN
         JZQ6OVTkb18EvVpkon2JWWzSEkpEVMbVhcPNbsuLu8O+um4JZ0meRTXw5/v2qsNHZrNG
         gon2lwvdzBtg3IQLybG2kwLVRejhcfeyWjg5k6lt6xyzhR/avO8XdCEtmVxKiz8BTygt
         w7Zg==
X-Forwarded-Encrypted: i=1; AL+hErGS/fwJPh/T7opWXkH57Dxz0ILnZm72feezi+Sqbh/nX3Id7ks0FanwdXgwuVcqT266hkTnSS2Or3RiqO2HFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DvTEmtZv+KoI2L3viCQNHzyNqD1A4rmgVIOjni4DEj4rDGAUN
	qs7SG1sZEDkHseIrH/ZnyHJ8NSw925j4v8zZ1kFBK8kjgIGUKmw/4c8g5Q99tYaOMa39d3T/gys
	sw27uH9L2NTHyTHNIV97g+XbDTU7s
X-Received: from qvho13.prod.google.com ([2002:ad4:5c8d:0:b0:91e:843a:2926])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5f8d:0:b0:91c:cff6:533f with SMTP id 6a1803df08f44-92134988a6dmr70259266d6.5.1795211964100;
 Fri, 20 Nov 2026 13:59:24 -0800 (PST)
Date: Fri, 20 Nov 2026 16:59:11 -0500
In-Reply-To: <20261120215916.3149345-1-briandaniels@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261120215916.3149345-1-briandaniels@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120215916.3149345-2-briandaniels@google.com>
Subject: [PATCH v11 1/6] media: virtio: Add core driver and session management
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add the initial virtio-media driver core, build system integration,
MAINTAINERS entry, and V4L2 session lifecycle management.

The driver binds to VIRTIO_ID_MEDIA devices, reads device capabilities
and device node type from the virtio configuration space, sets up the
command virtqueue for synchronous host requests, and registers the V4L2
and video devices. Opening and closing the video device creates and
destroys a host-backed session via VIRTIO_MEDIA_CMD_OPEN and
VIRTIO_MEDIA_CMD_CLOSE.

Protocol structures in the UAPI header include explicit __reserved
fields solely to guarantee 64-bit alignment rather than for future
protocol expansion. Because the UAPI header includes linux/videodev2.h,
which is currently excluded from standalone UAPI header compilation
checks (CONFIG_UAPI_HEADER_TEST=y), add linux/virtio_media.h to the same
exception list in usr/include/Makefile.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: LLM
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 MAINTAINERS                                |   8 +
 drivers/media/Kconfig                      |  13 +
 drivers/media/Makefile                     |   2 +
 drivers/media/virtio/Makefile              |   7 +
 drivers/media/virtio/session.h             |  58 +++
 drivers/media/virtio/virtio_media.h        |  70 +++
 drivers/media/virtio/virtio_media_driver.c | 504 +++++++++++++++++++++
 include/uapi/linux/virtio_media.h          | 118 +++++
 usr/include/Makefile                       |   1 +
 9 files changed, 781 insertions(+)
 create mode 100644 drivers/media/virtio/Makefile
 create mode 100644 drivers/media/virtio/session.h
 create mode 100644 drivers/media/virtio/virtio_media.h
 create mode 100644 drivers/media/virtio/virtio_media_driver.c
 create mode 100644 include/uapi/linux/virtio_media.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 760791e36..30c565537 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28973,6 +28973,7 @@ F:	Documentation/devicetree/bindings/virtio/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
+F:	drivers/media/virtio/
 F:	drivers/vdpa/
 F:	drivers/virtio/
 F:	include/linux/vdpa.h
@@ -29085,6 +29086,13 @@ S:	Maintained
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
diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
new file mode 100644
index 000000000..4ade7fb9c
--- /dev/null
+++ b/drivers/media/virtio/session.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
+
+/*
+ * Definitions of virtio-media session related structures.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#ifndef __VIRTIO_MEDIA_SESSION_H
+#define __VIRTIO_MEDIA_SESSION_H
+
+#include <media/v4l2-fh.h>
+
+#include "uapi/linux/virtio_media.h"
+
+/**
+ * struct virtio_media_session - A session on a virtio_media device.
+ * @fh: file handler for the session.
+ * @file: file pointer associated with the session's file handler.
+ * @id: session ID used to communicate with the device.
+ * @cmd: union of session-level commands. A session can have one command
+ *       currently running.
+ * @list: link into the list of sessions for the device.
+ */
+struct virtio_media_session {
+	struct v4l2_fh fh;
+	struct file *file;
+	u32 id;
+
+	__dma_from_device_group_begin();
+	union {
+		struct virtio_media_cmd_close close;
+	} cmd;
+	__dma_from_device_group_end();
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
diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
new file mode 100644
index 000000000..68299377a
--- /dev/null
+++ b/drivers/media/virtio/virtio_media.h
@@ -0,0 +1,70 @@
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
+#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
+
+/**
+ * struct virtio_media - Virtio-media device.
+ * @v4l2_dev: v4l2_device for the media device.
+ * @video_dev: video_device for the media device.
+ * @virtio_dev: virtio device for the media device.
+ * @commandq: virtio command queue.
+ * @sessions: list of active sessions on the device.
+ * @sessions_lock: protects @sessions and &struct virtio_media_session.list.
+ * @cmd: union of device-level commands. Session commands are handled by
+ *       &struct virtio_media_session.
+ * @resp: union of responses to device-level commands. Session responses are
+ *        handled by &struct virtio_media_session.
+ * @vlock: serializes access to the command queue.
+ * @wq: waitqueue for host responses on the command queue.
+ */
+struct virtio_media {
+	struct v4l2_device v4l2_dev;
+	struct video_device video_dev;
+
+	struct virtio_device *virtio_dev;
+	struct virtqueue *commandq;
+
+	struct list_head sessions;
+	struct mutex sessions_lock; /* protects sessions list */
+
+	__dma_from_device_group_begin();
+	union {
+		struct virtio_media_cmd_open open;
+	} cmd;
+
+	union {
+		struct virtio_media_resp_open open;
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
+#endif // __VIRTIO_MEDIA_H
+
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
new file mode 100644
index 000000000..39c5a38d2
--- /dev/null
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -0,0 +1,504 @@
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
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+
+#include "uapi/linux/virtio_media.h"
+#include "session.h"
+#include "virtio_media.h"
+
+/**
+ * virtio_media_session_alloc() - Allocate a new session.
+ * @vv: virtio-media device the session belongs to.
+ * @file: file associated with the session.
+ *
+ * The caller must initialize the ``id`` field before calling
+ * virtio_media_session_add().
+ */
+static struct virtio_media_session *
+virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
+{
+	struct virtio_media_session *session;
+
+	session = kzalloc_obj(*session, GFP_KERNEL);
+	if (!session)
+		return ERR_PTR(-ENOMEM);
+
+	// The caller is expected to set the ID once the host assigns a value.
+	session->id = 0;
+
+	INIT_LIST_HEAD(&session->list);
+	v4l2_fh_init(&session->fh, &vv->video_dev);
+	virtio_media_session_fh_add(session, file);
+
+	return session;
+}
+
+/**
+ * virtio_media_session_add() - Add a session to a device.
+ * @vv: virtio-media device the session belongs to.
+ * @session: session to add to the device.
+ */
+static void virtio_media_session_add(struct virtio_media *vv,
+				     struct virtio_media_session *session)
+{
+	mutex_lock(&vv->sessions_lock);
+	list_add_tail(&session->list, &vv->sessions);
+	mutex_unlock(&vv->sessions_lock);
+}
+
+/**
+ * virtio_media_session_free() - Free all resources of a session.
+ * @session: session to destroy.
+ *
+ * All the resources of @session, as well as the backing memory of @session
+ * itself, are freed.
+ */
+static void virtio_media_session_free(struct virtio_media_session *session)
+{
+	virtio_media_session_fh_del(session);
+	v4l2_fh_exit(&session->fh);
+
+	kfree(session);
+}
+
+/**
+ * virtio_media_session_remove() - Remove a session from the device.
+ * @vv: virtio-media device the session belongs to.
+ * @session: session to remove.
+ *
+ * This only removes the session from the device. To free it, call
+ * virtio_media_session_free().
+ */
+static void virtio_media_session_remove(struct virtio_media *vv,
+					struct virtio_media_session *session)
+{
+	mutex_lock(&vv->sessions_lock);
+	list_del(&session->list);
+	mutex_unlock(&vv->sessions_lock);
+}
+
+/**
+ * virtio_media_session_close() - Close a session.
+ * @vv: virtio-media device the session belongs to.
+ * @session: session to close.
+ *
+ * This sends the ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device. If @session
+ * is no longer used, it should be first removed by calling
+ * virtio_media_session_remove(), then freed by calling
+ * virtio_media_session_free().
+ */
+static int virtio_media_session_close(struct virtio_media *vv,
+				      struct virtio_media_session *session)
+{
+	struct virtio_media_cmd_close *cmd_close = &session->cmd.close;
+	struct scatterlist cmd_sg = {};
+	struct scatterlist *sgs[1] = { &cmd_sg };
+	int ret;
+
+	mutex_lock(&vv->vlock);
+
+	cmd_close->hdr.cmd = VIRTIO_MEDIA_CMD_CLOSE;
+	cmd_close->hdr.__reserved = 0;
+	cmd_close->session_id = session->id;
+	cmd_close->__reserved = 0;
+
+	sg_set_buf(&cmd_sg, cmd_close, sizeof(*cmd_close));
+	sg_mark_end(&cmd_sg);
+
+	ret = virtio_media_send_command(vv, sgs, 1, 0, 0, NULL);
+	mutex_unlock(&vv->vlock);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * struct virtio_media_cmd_callback_param - Callback parameters to the virtio
+ *                                          command queue.
+ * @vv: virtio-media device in use.
+ * @done: flag to be switched once the command is completed.
+ * @resp_len: length of the received response from the command. Only valid
+ *            after @done flag has switched to %true.
+ */
+struct virtio_media_cmd_callback_param {
+	struct virtio_media *vv;
+	bool done;
+	size_t resp_len;
+};
+
+/**
+ * commandq_callback() - Callback for the command queue.
+ * @queue: command virtqueue.
+ *
+ * This just wakes up the thread that was waiting on the command to complete.
+ */
+static void commandq_callback(struct virtqueue *queue)
+{
+	unsigned int len;
+	struct virtio_media_cmd_callback_param *param;
+
+process_bufs:
+	while ((param = virtqueue_get_buf(queue, &len))) {
+		param->resp_len = len;
+		param->done = true;
+		wake_up(&param->vv->wq);
+	}
+
+	if (!virtqueue_enable_cb(queue)) {
+		virtqueue_disable_cb(queue);
+		goto process_bufs;
+	}
+}
+
+/**
+ * virtio_media_kick_command() - send a command to the commandq.
+ * @vv: virtio-media device in use.
+ * @sgs: descriptor chain to send.
+ * @out_sgs: number of device-readable descriptors in @sgs.
+ * @in_sgs: number of device-writable descriptors in @sgs.
+ * @resp_len: output parameter. Upon success, contains the size of the response
+ *            in bytes.
+ */
+static int virtio_media_kick_command(struct virtio_media *vv,
+				     struct scatterlist **sgs,
+				     const size_t out_sgs, const size_t in_sgs,
+				     size_t *resp_len)
+{
+	struct virtio_media_cmd_callback_param cb_param = {
+		.vv = vv,
+		.done = false,
+		.resp_len = 0,
+	};
+	struct virtio_media_resp_header *resp_header;
+	int ret = virtqueue_add_sgs(vv->commandq, sgs, out_sgs, in_sgs,
+		  &cb_param, GFP_ATOMIC);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to add sgs to command virtqueue\n");
+		return ret;
+	}
+
+	if (!virtqueue_kick(vv->commandq)) {
+		v4l2_err(&vv->v4l2_dev, "failed to kick command virtqueue\n");
+		return -EINVAL;
+	}
+
+	/* Wait for the response. */
+	wait_event(vv->wq, cb_param.done);
+
+	if (resp_len)
+		*resp_len = cb_param.resp_len;
+
+	if (in_sgs > 0) {
+		/*
+		 * If we expect a response, make sure we have at least a
+		 * response header - anything shorter is invalid.
+		 */
+		if (cb_param.resp_len < sizeof(*resp_header)) {
+			v4l2_err(&vv->v4l2_dev,
+				 "received response header is too short\n");
+			return -EINVAL;
+		}
+
+		resp_header = sg_virt(sgs[out_sgs]);
+		if (resp_header->status)
+			/* Host returns a positive error code. */
+			return -resp_header->status;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_media_send_command() - Send a command to the device and wait for its
+ * response.
+ * @vv: virtio-media device in use.
+ * @sgs: descriptor chain to send.
+ * @out_sgs: number of device-readable descriptors in @sgs.
+ * @in_sgs: number of device-writable descriptors in @sgs.
+ * @minimum_resp_len: minimum length of the response expected by the caller
+ *                    when the command is successful. Anything shorter than
+ *                    that will result in %-EINVAL being returned.
+ * @resp_len: output parameter. Upon success, contains the size of the response
+ *            in bytes.
+ */
+int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
+			      const size_t out_sgs, const size_t in_sgs,
+			      size_t minimum_resp_len, size_t *resp_len)
+{
+	size_t local_resp_len = resp_len ? *resp_len : 0;
+	int ret = virtio_media_kick_command(vv, sgs, out_sgs, in_sgs,
+					    &local_resp_len);
+	if (resp_len)
+		*resp_len = local_resp_len;
+
+	/*
+	 * If the host could not process the command, there is no valid
+	 * response.
+	 */
+	if (ret < 0)
+		return ret;
+
+	/* Make sure the host wrote a complete reply. */
+	if (local_resp_len < minimum_resp_len) {
+		v4l2_err(&vv->v4l2_dev,
+			 "received response is too short: received %zu, expected at least %zu\n",
+			 local_resp_len, minimum_resp_len);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * virtio_media_device_open() - Create a new session from an opened file.
+ * @file: opened file for the session.
+ */
+static int virtio_media_device_open(struct file *file)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_cmd_open *cmd_open = &vv->cmd.open;
+	struct virtio_media_resp_open *resp_open = &vv->resp.open;
+	struct scatterlist cmd_sg = {}, resp_sg = {};
+	struct scatterlist *sgs[2] = { &cmd_sg, &resp_sg };
+	struct virtio_media_session *session;
+	int ret;
+
+	session = virtio_media_session_alloc(vv, file);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	mutex_lock(&vv->vlock);
+
+	sg_set_buf(&cmd_sg, cmd_open, sizeof(*cmd_open));
+	sg_mark_end(&cmd_sg);
+
+	sg_set_buf(&resp_sg, resp_open, sizeof(*resp_open));
+	sg_mark_end(&resp_sg);
+
+	cmd_open->hdr.cmd = VIRTIO_MEDIA_CMD_OPEN;
+	cmd_open->hdr.__reserved = 0;
+	ret = virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_open),
+					NULL);
+	session->id = resp_open->session_id;
+
+	mutex_unlock(&vv->vlock);
+
+	if (ret < 0) {
+		virtio_media_session_free(session);
+		return ret;
+	}
+
+	virtio_media_session_add(vv, session);
+	file->private_data = &session->fh;
+
+	return 0;
+}
+
+/**
+ * virtio_media_device_close() - Close a previously opened session.
+ * @file: file of the session to close.
+ *
+ * This sends the ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device, closes the
+ * session on the driver side, and frees the session.
+ */
+static int virtio_media_device_close(struct file *file)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session =
+		fh_to_session(file->private_data);
+
+	int ret = virtio_media_session_close(vv, session);
+
+	virtio_media_session_remove(vv, session);
+	virtio_media_session_free(session);
+
+	return ret;
+}
+
+static const struct v4l2_file_operations virtio_media_fops = {
+	.owner = THIS_MODULE,
+	.open = virtio_media_device_open,
+	.release = virtio_media_device_close,
+};
+
+static void virtio_media_release(struct v4l2_device *v4l2_dev)
+{
+	struct virtio_media *vv =
+		container_of(v4l2_dev, struct virtio_media, v4l2_dev);
+
+	v4l2_device_unregister(&vv->v4l2_dev);
+	kfree(vv);
+}
+
+static int virtio_media_probe(struct virtio_device *virtio_dev)
+{
+	struct device *dev = &virtio_dev->dev;
+	struct virtqueue *vqs[1];
+	static struct virtqueue_info vq_info[1] = {
+		{
+			.name = "command",
+			.callback = commandq_callback,
+		},
+	};
+	struct virtio_media *vv;
+	struct video_device *vd;
+	int ret;
+
+	vv = kzalloc_obj(struct virtio_media);
+	if (!vv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vv->sessions);
+	mutex_init(&vv->sessions_lock);
+	mutex_init(&vv->vlock);
+
+	vv->virtio_dev = virtio_dev;
+	virtio_dev->priv = vv;
+
+	init_waitqueue_head(&vv->wq);
+
+	ret = v4l2_device_register(dev, &vv->v4l2_dev);
+	if (ret)
+		goto err_free_virtio_media;
+
+	vv->v4l2_dev.release = virtio_media_release;
+
+	ret = virtio_find_vqs(virtio_dev, 1, vqs, vq_info, NULL);
+	if (ret)
+		goto err_v4l2_device_unregister;
+
+	vv->commandq = vqs[0];
+
+	vd = &vv->video_dev;
+	vd->v4l2_dev = &vv->v4l2_dev;
+	vd->fops = &virtio_media_fops;
+	vd->release = video_device_release_empty;
+	strscpy(vd->name, "virtio-media", sizeof(vd->name));
+
+	video_set_drvdata(vd, vv);
+
+	virtio_cread_le(virtio_dev, struct virtio_media_config, device_caps,
+			&vd->device_caps);
+	if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
+		vd->vfl_dir = VFL_DIR_M2M;
+	else if (vd->device_caps &
+		 (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE))
+		vd->vfl_dir = VFL_DIR_TX;
+	else
+		vd->vfl_dir = VFL_DIR_RX;
+
+	__u32 device_type;
+
+	virtio_cread_le(virtio_dev, struct virtio_media_config, device_type,
+			&device_type);
+	if (device_type >= VFL_TYPE_MAX) {
+		dev_err(&virtio_dev->dev, "Invalid device_type: %u",
+			device_type);
+		ret = -EINVAL;
+		goto err_del_vqs;
+	}
+
+	virtio_device_ready(virtio_dev);
+
+	ret = video_register_device(vd, device_type, -1);
+	if (ret)
+		goto err_del_vqs;
+
+	return 0;
+
+err_del_vqs:
+	virtio_reset_device(virtio_dev);
+	virtio_dev->config->del_vqs(virtio_dev);
+err_v4l2_device_unregister:
+	v4l2_device_unregister(&vv->v4l2_dev);
+err_free_virtio_media:
+	kfree(vv);
+	return ret;
+}
+
+static void virtio_media_remove(struct virtio_device *virtio_dev)
+{
+	struct virtio_media *vv = virtio_dev->priv;
+	struct list_head *p, *n;
+
+	/* Remove the video device to stop accessing the commandq virtqueue */
+	video_unregister_device(&vv->video_dev);
+
+	/*
+	 * Acquire vlock to ensure no concurrent accesses to the commandq
+	 * virtqueue
+	 */
+	mutex_lock(&vv->vlock);
+
+	/* Stop all virtqueue callbacks */
+	virtio_reset_device(virtio_dev);
+
+	/*
+	 * Only detach the unused buffers to allow internal virtqueue clean up.
+	 * The actual buffers are freed in virtio_media_release()
+	 */
+	while (virtqueue_detach_unused_buf(vv->commandq))
+		;
+
+	/* Delete the virtqueues */
+	virtio_dev->config->del_vqs(virtio_dev);
+
+	mutex_unlock(&vv->vlock);
+
+	list_for_each_safe(p, n, &vv->sessions) {
+		struct virtio_media_session *s =
+			list_entry(p, struct virtio_media_session, list);
+
+		virtio_media_session_remove(vv, s);
+		virtio_media_session_free(s);
+	}
+
+	v4l2_device_put(&vv->v4l2_dev);
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
index 000000000..ad05d7421
--- /dev/null
+++ b/include/uapi/linux/virtio_media.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+/*
+ * Definitions of virtio-media protocol structures.
+ *
+ * Copyright (c) 2024-2026 Google LLC.
+ */
+
+#ifndef _UAPI__LINUX_VIRTIO_MEDIA_H
+#define _UAPI__LINUX_VIRTIO_MEDIA_H
+
+#include <linux/types.h>
+#include <linux/videodev2.h>
+
+/*
+ * Virtio protocol definition.
+ */
+
+/**
+ * struct virtio_media_config - Video device configuration space.
+ * @device_caps: flags representing the device capabilities as used in &struct
+ *               v4l2_capability. It corresponds with the device_caps field in
+ *               the &struct video_device
+ * @ device_type: informs the driver of the type of the video device. It
+ *                corresponds to with the ``vfl_devnod_type`` field of the
+ *                device.
+ * @card: name of the device, a NUL-terminated UTF-8 string. It corresponds
+ *        with the card field of the struct v4l2_capability. If all the
+ *        characters of the field are used, it does not need to be
+ *        NUL-terminated.
+ */
+struct virtio_media_config {
+	__le32 device_caps;
+	__le32 device_type;
+	__u8 card[32];
+};
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
+	__le32 cmd;
+	__le32 __reserved;
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
+	__le32 status;
+	__le32 __reserved;
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
+	__le32 session_id;
+	__le32 __reserved;
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
+	__le32 session_id;
+	__le32 __reserved;
+};
+
+#endif // _UAPI__LINUX_VIRTIO_MEDIA_H
diff --git a/usr/include/Makefile b/usr/include/Makefile
index ee69dd9d9..df106b5d9 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -37,6 +37,7 @@ no-header-test += linux/usb/audio.h
 no-header-test += linux/v4l2-mediabus.h
 no-header-test += linux/v4l2-subdev.h
 no-header-test += linux/videodev2.h
+no-header-test += linux/virtio_media.h
 no-header-test += linux/vm_sockets.h
 no-header-test += sound/asequencer.h
 no-header-test += sound/asoc.h
-- 
2.56.1.750.gf70dc682cf-goog

