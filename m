Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A41456E02
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831593; cv=none; b=h9gC6zkBo4TiKJw4snvkEL7ddeSLqG9iwYaF8t9Z0q4cE7jD3JEO6ZbroSJ3Na6sR6nTSh1Bx4XRWCSdMC9mXxMg2wDedNSVgFbcfu90geNQVz0AnKfrff7W7ej6fjzTqMWLh+iDIYRiFVgSbpz5pKGo8KOhW2Fa41dchjppENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831593; c=relaxed/simple;
	bh=vDZeQinpdFoDcNuImf1N/0AjNHp4brVkSFrAhi9TCPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncZpaFxQqNZEGwbl3rUtKGXVjLviZXqCFbGdjAzk7Na0ibjY5ta38gcY2CjAXT/gMwp1h15dZ03O4h/rF8eWiQ59f4EHsL5pGy4h+B8N0E5vgdhO/kt7vOPC0lTbF1+vtSSfMMfS56aBJSwfe+8Xtr/Qn/cXbXYLSOgI090RF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vxtdquey; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vxtdquey"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so19365081cf.1
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784831581; x=1785436381; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqiWQikS8RfwgMFdKdTRhH3oYvJSP9R+oKdTrkEuptE=;
        b=VxtdqueyqtkLG1h/gH6LfME99ylCvZ4TiVk2fCEunBh34WAOQdPIpvQrKGDvYo9L5u
         1aSd1HPtxpr9JQVhN17VADZuo/+y95zc4PwqFhqFkISicU9cDp2QYInJkMeSuky9+4mQ
         mrCDH3/5hR5KF/V+NwIcnUsk4wKME/vLp/NE56cvG3ZHwIZqwRzA8LT3ihBUj8weN371
         5A7fT4gImLSyslRDi9O388hQ7hmCUtV6QaMeTuJCInU5DJcNylSn0BwFcLzlYIo2Eb0X
         HOshcbnQIxP9zMKOOBVJMEghIWzBlfMypIPAkCKhuRwnztPFnX4BfN5CQ9miZShhcVic
         VaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831581; x=1785436381;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqiWQikS8RfwgMFdKdTRhH3oYvJSP9R+oKdTrkEuptE=;
        b=fQhqVw1yQcAZEk9PqmcFsUElfXEufefucNgJia4++Ji/O8JTBa53yZKlwiYRdb9AWj
         kJXv+8DVOS2RR7sgQF46sv4Kg7cU4CTBjpLtkYa7s2T8KsolnNDERB4DMQCw8gcZiMt8
         Fwab2+Wc7Lr7O2mFbpdrXKhT4LkqV65W31Sz6SGLCAc5HvcwGLwQ1yZ7gAdckqNtp8oe
         jdeNCPLxj0X/1V1ER3i52wkTVPVjImiRV9cYxLsFJIHcyv5cFDS8j1ckbu1c+vs5Lw+4
         MaHFzpR2ntsPi63Stev8PGZhxbgyRQwnefvXycbQRg5nZhkhdlLKYIg8DPWmJg51Py/t
         0yrA==
X-Forwarded-Encrypted: i=1; AHgh+RpHPxjqVmsSfottqXf3uik8nfZNg7zC9cSV1EecOXl8RQtNUMkCz3Ob9QTZYE62yZ99AfjCO4TPoWDKWs5a1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzwu24GrwphOmRKVnWy6r9hy56Nd9JYzzsEU8Sh3YuGdJeAF2n6
	vKovPxScDoJ8Rki1psRPqV17R5DwpRflG19tqeWAHiCLZJczli2Tby4VBEs0S9qAMZHIya5rlPk
	WHLzQXSqt03jaoCDjxJCgR4AA3aKv
X-Received: from qtbob13.prod.google.com ([2002:a05:622a:7d8d:b0:520:227f:57c8])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:830f:b0:526:f9e1:9e50 with SMTP id d75a77b69052e-528459f1a4dmr20080541cf.47.1784831580814;
 Thu, 23 Jul 2026 11:33:00 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:32:19 -0400
In-Reply-To: <20260723183219.737296-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260723183219.737296-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723183219.737296-6-briandaniels@google.com>
Subject: [PATCH v5 5/5] media: virtio: Add USERPTR memory type support
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mst@redhat.com, 
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

This patch adds support for the USERPTR memory type to the virtio-media
driver.

It adds the allow_userptr module parameter, implements the userptr
mapping logic in the scatterlist builder, and enables USERPTR in
reqbufs if allowed.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: Antigravity:gemini-3.5-flash
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/scatterlist_builder.c | 64 ++++++++++++++++++++++
 drivers/media/virtio/scatterlist_builder.h |  3 +
 drivers/media/virtio/virtio_media_driver.c | 42 +++++++++-----
 drivers/media/virtio/virtio_media_ioctls.c | 11 +++-
 4 files changed, 104 insertions(+), 16 deletions(-)

diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/virtio/scatterlist_builder.c
index 97925b277..85c6a36b4 100644
--- a/drivers/media/virtio/scatterlist_builder.c
+++ b/drivers/media/virtio/scatterlist_builder.c
@@ -349,14 +349,30 @@ static int scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
 int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
 				   struct v4l2_buffer *b)
 {
+	int i;
 	int ret;
 
+	/* Fixup: plane length must be zero if userptr is NULL */
+	if (!V4L2_TYPE_IS_MULTIPLANAR(b->type) &&
+	    b->memory == V4L2_MEMORY_USERPTR && b->m.userptr == 0)
+		b->length = 0;
+
 	/* v4l2_buffer */
 	ret = scatterlist_builder_add_data(builder, b, sizeof(*b));
 	if (ret)
 		return ret;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
+		/* Fixup: plane length must be zero if userptr is NULL */
+		if (b->memory == V4L2_MEMORY_USERPTR) {
+			for (i = 0; i < b->length; i++) {
+				struct v4l2_plane *plane = &b->m.planes[i];
+
+				if (plane->m.userptr == 0)
+					plane->length = 0;
+			}
+		}
+
 		/* Array of v4l2_planes */
 		ret = scatterlist_builder_add_data(builder, b->m.planes,
 						   sizeof(struct v4l2_plane) *
@@ -368,6 +384,54 @@ int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
 	return 0;
 }
 
+/**
+ * scatterlist_builder_add_buffer_userptr() - Add the payload of a ``USERPTR``
+ *                                            &struct v4l2_buffer to the
+ *                                            descriptor chain.
+ * @builder: builder to use.
+ * @b: &struct v4l2_buffer whose ``USERPTR`` payload we want to add.
+ *
+ * Add an array of &struct virtio_media_sg_entry pointing to a ``USERPTR``
+ * buffer's contents. Does nothing if the buffer is not of type ``USERPTR``.
+ * This is split out of scatterlist_builder_add_buffer() because we only want
+ * to add these to the device-readable part of the descriptor chain.
+ */
+int scatterlist_builder_add_buffer_userptr(struct scatterlist_builder *builder,
+					   struct v4l2_buffer *b)
+{
+	int i;
+	int ret;
+
+	if (b->memory != V4L2_MEMORY_USERPTR)
+		return 0;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
+		for (i = 0; i < b->length; i++) {
+			struct v4l2_plane *plane = &b->m.planes[i];
+
+			if (b->memory == V4L2_MEMORY_USERPTR &&
+			    plane->length > 0) {
+				unsigned long uptr = plane->m.userptr;
+				unsigned long len = plane->length;
+
+				ret =
+				scatterlist_builder_add_userptr(builder,
+								uptr,
+								len);
+				if (ret)
+					return ret;
+			}
+		}
+	} else if (b->length > 0) {
+		ret = scatterlist_builder_add_userptr(builder, b->m.userptr,
+						      b->length);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * scatterlist_builder_retrieve_buffer() - Retrieve a &struct v4l2_buffer
  *                                         written by the device on the shadow
diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/virtio/scatterlist_builder.h
index 47bfd7ae0..53d964a48 100644
--- a/drivers/media/virtio/scatterlist_builder.h
+++ b/drivers/media/virtio/scatterlist_builder.h
@@ -90,6 +90,9 @@ int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
 int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
 				   struct v4l2_buffer *buffer);
 
+int scatterlist_builder_add_buffer_userptr(struct scatterlist_builder *builder,
+					   struct v4l2_buffer *b);
+
 int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *builder,
 					size_t sg_index,
 					struct v4l2_buffer *buffer,
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
index c431c3eb2..b6f79593d 100644
--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -7,26 +7,29 @@
  */
 
 #include <linux/bits.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/scatterlist.h>
 #include <linux/types.h>
+#include <linux/videodev2.h>
+#include <linux/vmalloc.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
-#include <linux/slab.h>
-#include <linux/scatterlist.h>
-#include <linux/vmalloc.h>
-#include <linux/workqueue.h>
-#include <linux/dma-mapping.h>
-#include <linux/poll.h>
-#include <linux/mm.h>
 
+#include <media/frame_vector.h>
 #include <media/v4l2-dev.h>
-#include <media/v4l2-device.h>
-#include <media/v4l2-fh.h>
 #include <media/v4l2-event.h>
+#include <media/videobuf2-memops.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-ioctl.h>
 
 #include "uapi/linux/virtio_media.h"
 #include "session.h"
@@ -40,6 +43,15 @@
 /* Bit mask for the VIRTIO_MEDIA_MMAP_FLAG_RW flag */
 #define VIRTIO_MEDIA_MMAP_FLAG_RW_MASK BIT(VIRTIO_MEDIA_MMAP_FLAG_RW)
 
+/*
+ * Whether USERPTR buffers are allowed.
+ *
+ * This is disabled by default as USERPTR buffers are dangerous, but the option
+ * is left to enable them if desired.
+ */
+bool virtio_media_allow_userptr;
+module_param_named(allow_userptr, virtio_media_allow_userptr, bool, 0660);
+
 /**
  * virtio_media_session_alloc() - Allocate a new session.
  * @vv: virtio-media device the session belongs to.
@@ -849,15 +861,11 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 			      VIRTIO_MEDIA_SHM_MMAP);
 
 	vd = &vv->video_dev;
+
 	vd->v4l2_dev = &vv->v4l2_dev;
 	vd->vfl_type = VFL_TYPE_VIDEO;
 	vd->ioctl_ops = &virtio_media_ioctl_ops;
 	vd->fops = &virtio_media_fops;
-	vd->release = video_device_release_empty;
-	strscpy(vd->name, "virtio-media", sizeof(vd->name));
-
-	video_set_drvdata(vd, vv);
-
 	vd->device_caps = virtio_cread32(virtio_dev, 0);
 	if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
 		vd->vfl_dir = VFL_DIR_M2M;
@@ -866,6 +874,10 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 		vd->vfl_dir = VFL_DIR_TX;
 	else
 		vd->vfl_dir = VFL_DIR_RX;
+	vd->release = video_device_release_empty;
+	strscpy(vd->name, "virtio-media", sizeof(vd->name));
+
+	video_set_drvdata(vd, vv);
 
 	ret = video_register_device(vd, virtio_cread32(virtio_dev, 4), 0);
 	if (ret)
@@ -890,6 +902,7 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 	virtio_dev->config->del_vqs(virtio_dev);
 err_find_vqs:
 	v4l2_device_unregister(&vv->v4l2_dev);
+
 	return ret;
 }
 
@@ -900,6 +913,7 @@ static void virtio_media_remove(struct virtio_device *virtio_dev)
 
 	cancel_work_sync(&vv->eventq_work);
 	virtio_reset_device(virtio_dev);
+
 	v4l2_device_unregister(&vv->v4l2_dev);
 	virtio_dev->config->del_vqs(virtio_dev);
 	video_unregister_device(&vv->video_dev);
diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
index f0b82b5ec..88465f239 100644
--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -273,6 +273,12 @@ static int virtio_media_send_buffer_ioctl(struct v4l2_fh *fh, u32 ioctl,
 		return ret;
 
 	end_buf_sg = builder.cur_sg;
+
+	/* Payload of SHARED_PAGES buffers, if relevant */
+	ret = scatterlist_builder_add_buffer_userptr(&builder, b);
+	if (ret < 0)
+		return ret;
+
 	num_cmd_sgs = builder.cur_sg;
 
 	/* Response descriptor */
@@ -719,7 +725,7 @@ static int virtio_media_reqbufs(struct file *file, void *fh,
 	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
 		return -EINVAL;
 
-	if (b->memory == V4L2_MEMORY_USERPTR)
+	if (b->memory == V4L2_MEMORY_USERPTR && !virtio_media_allow_userptr)
 		return -EINVAL;
 
 	ret = virtio_media_send_wr_ioctl(vfh, VIDIOC_REQBUFS, b, sizeof(*b),
@@ -752,7 +758,8 @@ static int virtio_media_reqbufs(struct file *file, void *fh,
 	if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
 		session->uses_mplane = true;
 
-	b->capabilities &= ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
+	if (!virtio_media_allow_userptr)
+		b->capabilities &= ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
 
 	/* We do not support DMABUF yet. */
 	b->capabilities &= ~V4L2_BUF_CAP_SUPPORTS_DMABUF;
-- 
2.55.0.229.g6434b31f56-goog

