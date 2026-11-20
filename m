Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211977;
	b=25frsV/fjdCQ1jUSyAkd36q2+zul+UMXy3cCJHtHxbfCTyzJb888AxEf5a2v87kZbVoS
	 /VEt9dB9IFMYlvylqsIRP12y5/r9PFP01yT4UEwYGzOmbJgQv9hPwFw8A6pMxDHKAtZ55
	 bDPAqGbMFGDwB0z4B0PkuqcY3m1dywEPPel80ZF1gg+aByOEay9iJmQHP0IQ6SijUcxU3
	 OksuPQqFpkNJZyu60TjfjUSV4xtv4IEvTTs/iOKRyqfNdTVo/PRrZ7jZ3loWY8yJ66Ao9
	 bcQ1i07qENq/iJB27Oyg3Db6ECcJMSpYvbibKrDC/ihedSrAJgSaBi0tN9jChkVzzUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Jt9RCBa8sBvR061AaSkNCLxjeK/ds/G5ZqPF9nB3MHo=;
	b=VBWM/CRahb9C2rc8AwdoF3IhpN55slmOyCP3e9g4zdcrNCxldrG1KxgbNyNUVbxJDuFw
	 /56ehEjp0MGqrzwYSAI7H2yXTDb9cVeyQ6l4HUPprRMcOFD5oCLWfRhAnO1UEX0aY7Kt8
	 wuZlDVueu0GpHuE/dd73GZ355P2JrbdP4zakznMGSF5bzXp12nHEkc0bgPb21gv02j3AM
	 +G5PdZdrMITPJ8RRAeJkFFwAiGuJYpUeeZrsfjz6s9/PJGjjTGgukOsd8zEfk31NzvEXO
	 7fpODnvit82zSq0/Z6kTIQyiDMX9Ymu+rZP71OZI4yiHlW7rEOcznWP3QocUyCxtW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JJtbNrc8;
	arc=none smtp.remote-ip=74.125.224.70
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581C60A2617
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 21:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7581C60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JJtbNrc8
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67c58f18a42so2811345d50.3
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211972; x=1795816772; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jt9RCBa8sBvR061AaSkNCLxjeK/ds/G5ZqPF9nB3MHo=;
        b=JJtbNrc847zhaST5R/4ifmh/O4p2eXi91shhgs2gd7rIA9kM8sRdpXbzbbQXTXDCDu
         nj34gEutEmRU7zxodkddrmfCNPhVSlKhE/hrRhu8ziRwXQJsCiqWjgaHLuHHG8/w1Tc7
         vp+LZJgEuQmEZeKnUsiefyRZduOeltInGieyccaARxf22ws/Wd8x/VpediE5qVNePEyB
         IEogbNs+3gXxlFCohhyAWcyE+oUdRQjJ+vrv6w8qbHNflRWk5UD3Wl41KnABmsMDk+cg
         fVHB/B4OufRQe7oW9wN9dj7SSbfZ3jhGQSnRxKA2sjtp0y1PEtD7Vg8nj/P7m4JbRBKr
         k5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211972; x=1795816772;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt9RCBa8sBvR061AaSkNCLxjeK/ds/G5ZqPF9nB3MHo=;
        b=0FKEvAykAUJJy47cmftawwtwoIPw/C5jMBRx9S/Ipv+3gmlfwToTeY/eGjBFRtc6B/
         AS1XbRCXA98gD19Dm+bEGMcmKHDML6UZLRaIMbfs5lyaQqqDudXcbSkcimT3p9FgbzJ6
         Jzm8o37g+rY1baoluJ5bnPuHy4hMDiusB9r+PizSvvKtk65TRPU87ntZ87HcjLEuWRQg
         2YadnmxR7QroybgihUIbthnm50vgEPTTavcuIszU90BbSs7hBEU1LqTHOXwSniBtS05z
         eho7Ha/WMEhjcOo6ziD+DmFbT7f1xKwFIav/wCpU7uYP59MvSsxHiKAcytW4n7NvFO5v
         EP7Q==
X-Forwarded-Encrypted: i=1; AL+hErH09L6wTPEI2EYY7OO/rv0uIqbOdO9IiOpDdmq+mgQvRUj/nMACQT4w21oz3prsaYDGRFpu4Iq6k1iBuGt06A==@lists.linux.dev
X-Gm-Message-State: APuU4Z84kLP3zInoaXq28FZU4FiNypHgRz5p51GuwZq+vcgna3KPrJdY
	8jF2QGnS3uWjYuKSwtxWr8VibKQetJ6Ebsk+EBvIVg/gtp8alY+lh6Gvrz/2Nk6ry+MLCwj9BBx
	EXYQ74FlTqyDhHimxFLrmRc/p4B+N
X-Received: from yxws18.prod.google.com ([2002:a53:de52:0:b0:679:1d65:95e])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:480c:b0:672:e7e1:f3de with SMTP id 956f58d0204a3-67df44bf2f6mr805895d50.73.1795211972187;
 Fri, 20 Nov 2026 13:59:32 -0800 (PST)
Date: Fri, 20 Nov 2026 16:59:15 -0500
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
Message-ID: <20261120215916.3149345-6-briandaniels@google.com>
Subject: [PATCH v11 5/6] media: virtio: Add MMAP buffer mapping support
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

Support mapping V4L2_MEMORY_MMAP buffers into guest userspace through
virtio shared memory region 0.

Query the shared memory region during device probe and implement the
mmap file operation and VMA close callback using VIRTIO_MEDIA_CMD_MMAP
and VIRTIO_MEDIA_CMD_MUNMAP, remapping the host-provided shared memory
offset into userspace via io_remap_pfn_range().

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: LLM
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/session.h             |  14 +-
 drivers/media/virtio/virtio_media.h        |  13 +-
 drivers/media/virtio/virtio_media_driver.c | 159 +++++++++++++++++++++
 include/uapi/linux/virtio_media.h          |  67 +++++++++
 4 files changed, 243 insertions(+), 10 deletions(-)

diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
index 16bb86bf4..c074ffc2c 100644
--- a/drivers/media/virtio/session.h
+++ b/drivers/media/virtio/session.h
@@ -63,12 +63,12 @@ struct virtio_media_queue_state {
  * @nonblocking_dequeue: whether dequeue should block or not (nonblocking if
  *                       file opened with O_NONBLOCK).
  * @uses_mplane: whether the queues for this session use the MPLANE API or not.
- * @cmd: union of session commands ``close`` and ``ioctl``. A session can have
- *       one command currently running. The rest of the commands are handled by
- *       &struct virtio_media.
- * @resp: union of responses to session commands. A session can wait on one
- *        command only. The rest of the responses are handled by
- *        &struct virtio_media.
+ * @cmd: union of session commands ``close``, ``ioctl``, and ``mmap``. A
+ *       session can have one command currently running. The rest of the
+ *       commands are handled by &struct virtio_media.
+ * @resp: union of responses to session commands ``close``, ``ioctl``, and
+ *        ``mmap``. A session can wait on one command only. The rest of the
+ *        responses are handled by &struct virtio_media.
  * @shadow_buf: shadow buffer where data to be added to the descriptor chain can
  *              be staged before being sent to the device.
  * @command_sgs: SG table gathering descriptors for a given command and its
@@ -91,10 +91,12 @@ struct virtio_media_session {
 	union {
 		struct virtio_media_cmd_close close;
 		struct virtio_media_cmd_ioctl ioctl;
+		struct virtio_media_cmd_mmap mmap;
 	} cmd;
 
 	union {
 		struct virtio_media_resp_ioctl ioctl;
+		struct virtio_media_resp_mmap mmap;
 	} resp;
 	__dma_from_device_group_end();
 
diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
index 8b21c1941..7acb2b842 100644
--- a/drivers/media/virtio/virtio_media.h
+++ b/drivers/media/virtio/virtio_media.h
@@ -26,14 +26,15 @@
  * @commandq: virtio command queue.
  * @eventq: virtio event queue.
  * @eventq_work: work to run when events are received on @eventq.
+ * @mmap_region: region into which MMAP buffers are mapped by the host.
  * @event_buffer: buffer for event descriptors.
  * @sessions: list of active sessions on the device.
  * @sessions_lock: protects @sessions and &struct virtio_media_session.list.
  * @events_lock: prevents concurrent processing of events.
- * @cmd: union of device-level commands. Session commands are handled by
- *       &struct virtio_media_session.
- * @resp: union of responses to device-level commands. Session responses are
- *        handled by &struct virtio_media_session.
+ * @cmd: union of the device commands ``open`` and ``munmap``. The other
+ *       commands are handled by &struct virtio_media_session
+ * @resp: union of responses to device commands ``open`` and ``munmap``. The
+ *        other responses are handled by &struct virtio_media_session
  * @vlock: serializes access to the command queue.
  * @wq: waitqueue for host responses on the command queue.
  */
@@ -46,6 +47,8 @@ struct virtio_media {
 	struct virtqueue *eventq;
 	struct work_struct eventq_work;
 
+	struct virtio_shm_region mmap_region;
+
 	void *event_buffer;
 
 	struct list_head sessions;
@@ -56,10 +59,12 @@ struct virtio_media {
 	__dma_from_device_group_begin();
 	union {
 		struct virtio_media_cmd_open open;
+		struct virtio_media_cmd_munmap munmap;
 	} cmd;
 
 	union {
 		struct virtio_media_resp_open open;
+		struct virtio_media_resp_munmap munmap;
 	} resp;
 	__dma_from_device_group_end();
 
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
index 748357725..eb6b31d7e 100644
--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2024-2026 Google LLC.
  */
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
 #include <linux/mutex.h>
@@ -20,6 +21,7 @@
 #include <linux/workqueue.h>
 #include <linux/dma-mapping.h>
 #include <linux/poll.h>
+#include <linux/mm.h>
 
 #include <media/v4l2-dev.h>
 #include <media/v4l2-device.h>
@@ -32,6 +34,12 @@
 
 #define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
 
+/* ID of the SHM region into which MMAP buffer will be mapped. */
+#define VIRTIO_MEDIA_SHM_MMAP 0
+
+/* Bit mask for the VIRTIO_MEDIA_MMAP_FLAG_RW flag */
+#define VIRTIO_MEDIA_MMAP_FLAG_RW_MASK BIT(VIRTIO_MEDIA_MMAP_FLAG_RW)
+
 /**
  * virtio_media_session_alloc() - Allocate a new session.
  * @vv: virtio-media device the session belongs to.
@@ -697,12 +705,155 @@ static __poll_t virtio_media_device_poll(struct file *file, poll_table *wait)
 	return rc;
 }
 
+static void virtio_media_vma_close_locked(struct vm_area_struct *vma)
+{
+	struct virtio_media *vv = vma->vm_private_data;
+	struct virtio_media_cmd_munmap *cmd_munmap = &vv->cmd.munmap;
+	struct virtio_media_resp_munmap *resp_munmap = &vv->resp.munmap;
+	struct scatterlist cmd_sg = {}, resp_sg = {};
+	struct scatterlist *sgs[2] = { &cmd_sg, &resp_sg };
+	int ret;
+
+	sg_set_buf(&cmd_sg, cmd_munmap, sizeof(*cmd_munmap));
+	sg_mark_end(&cmd_sg);
+
+	sg_set_buf(&resp_sg, resp_munmap, sizeof(*resp_munmap));
+	sg_mark_end(&resp_sg);
+
+	cmd_munmap->hdr.cmd = VIRTIO_MEDIA_CMD_MUNMAP;
+	cmd_munmap->hdr.__reserved = 0;
+	cmd_munmap->driver_addr =
+		(vma->vm_pgoff << PAGE_SHIFT) - vv->mmap_region.addr;
+	ret = virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_munmap),
+					NULL);
+	if (ret < 0) {
+		v4l2_err(&vv->v4l2_dev, "host failed to unmap buffer: %d\n",
+			 ret);
+	}
+}
+
+/**
+ * virtio_media_vma_close() - Close a MMAP buffer mapping.
+ * @vma: VMA of the mapping to close.
+ *
+ * Inform the host that a previously created MMAP mapping is no longer needed
+ * and can be removed.
+ */
+static void virtio_media_vma_close(struct vm_area_struct *vma)
+{
+	struct virtio_media *vv = vma->vm_private_data;
+
+	mutex_lock(&vv->vlock);
+	virtio_media_vma_close_locked(vma);
+	mutex_unlock(&vv->vlock);
+}
+
+static const struct vm_operations_struct virtio_media_vm_ops = {
+	.close = virtio_media_vma_close,
+};
+
+/**
+ * virtio_media_device_mmap() - Perform a mmap request from userspace.
+ * @file: opened file of the session to map for.
+ * @vma: VM area struct describing the desired mapping.
+ *
+ * This requests the host to map a MMAP buffer for us, so we can then make that
+ * mapping visible into user-space address space.
+ */
+static int virtio_media_device_mmap(struct file *file,
+				    struct vm_area_struct *vma)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session =
+		fh_to_session(file->private_data);
+	struct virtio_media_cmd_mmap *cmd_mmap = &session->cmd.mmap;
+	struct virtio_media_resp_mmap *resp_mmap = &session->resp.mmap;
+	struct scatterlist cmd_sg = {}, resp_sg = {};
+	struct scatterlist *sgs[2] = { &cmd_sg, &resp_sg };
+	int ret;
+
+	mutex_lock(&session->error_lock);
+	bool session_error = session->error;
+
+	mutex_unlock(&session->error_lock);
+
+	if (session_error)
+		return -EIO;
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+	if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
+		return -EINVAL;
+
+	mutex_lock(&vv->vlock);
+
+	cmd_mmap->hdr.cmd = VIRTIO_MEDIA_CMD_MMAP;
+	cmd_mmap->hdr.__reserved = 0;
+	cmd_mmap->session_id = session->id;
+	cmd_mmap->flags =
+		(vma->vm_flags & VM_WRITE) ? VIRTIO_MEDIA_MMAP_FLAG_RW_MASK : 0;
+	cmd_mmap->offset = vma->vm_pgoff << PAGE_SHIFT;
+	cmd_mmap->__reserved = 0;
+
+	sg_set_buf(&cmd_sg, cmd_mmap, sizeof(*cmd_mmap));
+	sg_mark_end(&cmd_sg);
+
+	sg_set_buf(&resp_sg, resp_mmap, sizeof(*resp_mmap));
+	sg_mark_end(&resp_sg);
+
+	/*
+	 * The host performs reference counting and is smart enough to return
+	 * the same guest physical address if this is called several times on
+	 * the same
+	 * buffer.
+	 */
+	ret = virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_mmap),
+					NULL);
+	if (ret < 0)
+		goto end;
+
+	vma->vm_private_data = vv;
+	/*
+	 * Keep the guest address at which the buffer is mapped since we will
+	 * use that to unmap.
+	 */
+	vma->vm_pgoff = (resp_mmap->driver_addr + vv->mmap_region.addr) >>
+			PAGE_SHIFT;
+
+	/*
+	 * We cannot let the mapping be larger than the buffer.
+	 */
+	if (vma->vm_end - vma->vm_start > PAGE_ALIGN(resp_mmap->len)) {
+		dev_dbg(&video_dev->dev,
+			"invalid MMAP, as it would overflow buffer length\n");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				 vma->vm_end - vma->vm_start,
+				 vma->vm_page_prot);
+	if (ret) {
+		dev_dbg(&video_dev->dev, "io_remap_pfn_range() failed\n");
+		goto cleanup;
+	}
+
+	vma->vm_ops = &virtio_media_vm_ops;
+	goto end;
+cleanup:
+	virtio_media_vma_close_locked(vma);
+end:
+	mutex_unlock(&vv->vlock);
+	return ret;
+}
+
 static const struct v4l2_file_operations virtio_media_fops = {
 	.owner = THIS_MODULE,
 	.open = virtio_media_device_open,
 	.release = virtio_media_device_close,
 	.poll = virtio_media_device_poll,
 	.unlocked_ioctl = virtio_media_device_ioctl,
+	.mmap = virtio_media_device_mmap,
 };
 
 static void virtio_media_release(struct v4l2_device *v4l2_dev)
@@ -773,6 +924,14 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 	vv->eventq = vqs[1];
 	INIT_WORK(&vv->eventq_work, virtio_media_event_work);
 
+	/* Get MMAP buffer mapping SHM region */
+	if (!virtio_get_shm_region(virtio_dev, &vv->mmap_region,
+				   VIRTIO_MEDIA_SHM_MMAP)) {
+		dev_err(&virtio_dev->dev, "Failed to get shared memory region");
+		ret = -ENOMEM;
+		goto err_del_vqs;
+	}
+
 	vd = &vv->video_dev;
 	vd->v4l2_dev = &vv->v4l2_dev;
 	vd->ioctl_ops = &virtio_media_ioctl_ops;
diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virtio_media.h
index da5c5baf0..2ea28770e 100644
--- a/include/uapi/linux/virtio_media.h
+++ b/include/uapi/linux/virtio_media.h
@@ -171,6 +171,73 @@ struct virtio_media_sg_entry {
 	__le32 __reserved;
 };
 
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
+ * @__reserved: must be set to zero by the driver.
+ */
+struct virtio_media_cmd_mmap {
+	struct virtio_media_cmd_header hdr;
+	__le32 session_id;
+	__le32 flags;
+	__le32 offset;
+	__le32 __reserved;
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
+	__le64 driver_addr;
+	__le64 len;
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
+	__le64 driver_addr;
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
 /* The values for these events are set by the virtio-media specification. */
 #define VIRTIO_MEDIA_EVT_ERROR 0
 #define VIRTIO_MEDIA_EVT_DQBUF 1
-- 
2.56.1.750.gf70dc682cf-goog

