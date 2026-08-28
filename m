Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAE322DB7
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926612; cv=none; b=jTOCV4zLX1KWRQD6GGRPt2BYnENwGQPjwFbEoMCH5SzzVNSFGVDq/7TQB3rNz2dlOj8vnE+gBAtPnIR9RHSEznOoReMkIMTjJaKc8bDf05sfVOPZ/n/jxMepmkXYlxZCQi7klyLaExRQTQDXulsLbrFL3q0ZIuFPJbzA0ZiJbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926612; c=relaxed/simple;
	bh=NI7fax7uLfuLXBoNEApQJ1Q+pxyH4J72y4MOyF+yhO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6CP64XBWvrV2UW+N5350H4uccjFOfLc3VNZ/PIXW/rLxOLPM5Bf59lKbiRyuzmqYBcx5GpdF2N++JB/68+OPjdbxaGlSTL8U3bgENDmi8OK7yqjXuDYST3FXLsmqJo0Id2gNP0BjN/9pLSRvv9nr1EJ8zuYdKBFBunjnYrGf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MFx6PBoA; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MFx6PBoA"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93494527488so172332285a.3
        for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787926609; x=1788531409; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yMex5KKElRvoxQSeAn1yvjXKn1oddVw02e0cC2aaeGE=;
        b=MFx6PBoAoiEo35e4c1GvWrKCLXsihqwhgVWLHYkGUP+LSfvMsfF5V8/WjAmIppYQrI
         HXoFuLDpuMk+G+Gw1apYUeD+OJ2Ml7gbsLaRgGheGn0omiBKgt+BpzMpGmCDIp0L0i/M
         TVFje7dsR6vURBOIyFIhewZOX7mdzpQLAI5V45BVuyqDefZG0saPwiDlhE3a3QvSfeRt
         04h06ZSoN5f6Uy9s8jg7SVUVFr1zuWW9CKRuqn2rPyCJADCSpTrzOE5cTlUsZrR/kk3O
         zYPDpv29VKJ9Ev0Hy3YxRxT5J3TQw38jUSzmjRobi8riZ4JTMv2DZK4OvLV76TINfjyO
         Y+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926609; x=1788531409;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yMex5KKElRvoxQSeAn1yvjXKn1oddVw02e0cC2aaeGE=;
        b=TZ/Dv2ejQt3HlmknETtvVlfWXUyT/NB9PQvDt0Cf8C8ZW3XLfrG1lTab7TIkw7hpq4
         PIaMNeDXnJnBnFkaUYvpko+p+HxQLeo2w7Du8bj2h5tCY1OWqpq60OCj0Gg+T9E31jr9
         5WzTuHsWJ4JqEZxTUqaEGMsr/+/BhSYY/QY5As1cqzNIS4k5Chnx/7ZsIt0Bh47CVlpD
         9BZRFQ4/Nn6zdVsHQaJEkTuwa4LqcQ+bHYTVVxQHXdQPGyIhFa9dgiJZSxOrtxgai++v
         f31KvDQGvQA/m62gu7KIcy/7bl53oG81LzCo+gnI8RXzWlp8Et9aZk4vMefmBUspQ247
         RnQw==
X-Forwarded-Encrypted: i=1; AHgh+RptmX+LwBXAEmWqv+pQ2FMKaF6MVe6FaSvjBA0JMx0C+o6WRL8Gag+MC2if+1QpGEhECIykjRF9ImRHmPNgcQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nB/FfcddBH3Dq9CVFb3nkAIYuYBZ48hoY5MwVA4+6Ljc0VTYYd
	05Xh3mnDzzGk1vNBqS/b7xIXu302fNJA2uIxwiU16E1dDgmSA25s18d0cyiu2kDh57ExWKDC4No
	tp9hi2IRpir2Lj2sPMFNatgWuKh/G
X-Received: from qkbbm18.prod.google.com ([2002:a05:620a:1992:b0:92e:5292:786a])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:72cf:20b0:937:25da:401b with SMTP id af79cd13be357-939137af764mr609790385a.3.1787926608423;
 Fri, 28 Aug 2026 07:16:48 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:16:35 -0400
In-Reply-To: <20260828141638.463078-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828141638.463078-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828141638.463078-3-briandaniels@google.com>
Subject: [PATCH v8 2/5] media: virtio: Add session management
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

This patch adds session management to the virtio-media driver.
A session is created when the /dev/videoX device is opened, and
destroyed when it is closed.

Opening a session sends VIRTIO_MEDIA_CMD_OPEN to the host, and closing
it sends VIRTIO_MEDIA_CMD_CLOSE.

It adds drivers/media/virtio/session.h and implements the open and
release fops.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Assisted-by: Antigravity:gemini-3.5-flash
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/session.h             | 132 +++++
 drivers/media/virtio/virtio_media_driver.c | 604 ++++++++++++++++++++-
 2 files changed, 732 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/virtio/session.h

diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
new file mode 100644
index 000000000..d523c8171
--- /dev/null
+++ b/drivers/media/virtio/session.h
@@ -0,0 +1,132 @@
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
+#include <linux/scatterlist.h>
+#include <media/v4l2-fh.h>
+
+#include "uapi/linux/virtio_media.h"
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
+ * @buffer: &struct v4l2_buffer with current information about the buffer.
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
+ *                   capture queue, so we can return %-EPIPE on subsequent
+ *                   DQBUF requests.
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
+ *                       file opened with O_NONBLOCK).
+ * @uses_mplane: whether the queues for this session use the MPLANE API or not.
+ * @cmd: union of session commands ``close``, ``ioctl``, and ``mmap``. A
+ *       session can have one command currently running. The rest of the
+ *       commands are handled by &struct virtio_media.
+ * @resp: union of responses to session commands ``close``, ``ioctl``, and
+ *        ``mmap``. A session can wait on one command only. The rest of the
+ *        responses are handled by &struct virtio_media.
+ * @shadow_buf: shadow buffer where data to be added to the descriptor chain can
+ *              be staged before being sent to the device.
+ * @command_sgs: SG table gathering descriptors for a given command and its
+ *               response.
+ * @queues: state of all the queues for this session.
+ * @queues_lock: protects all members for the queues for this session.
+ * @dqbuf_wait: waitqueue for dequeued buffers, if ``VIDIOC_DQBUF`` needs to
+ *              block or when polling.
+ * @list: link into the list of sessions for the device.
+ */
+struct virtio_media_session {
+	struct v4l2_fh fh;
+	struct file *file;
+	u32 id;
+	bool nonblocking_dequeue;
+	bool uses_mplane;
+
+	__dma_from_device_group_begin();
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
+	__dma_from_device_group_end();
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
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
index 25f2ceaa6..ef8065e34 100644
--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -14,25 +14,589 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+#include <linux/dma-mapping.h>
 
 #include <media/v4l2-dev.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-event.h>
 
 #include "uapi/linux/virtio_media.h"
+#include "session.h"
 #include "virtio_media.h"
 
-static void commandq_callback(struct virtqueue *vq)
+#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
+
+/**
+ * virtio_media_session_alloc() - Allocate a new session.
+ * @vv: virtio-media device the session belongs to.
+ * @id: ID of the session.
+ * @file: file associated with the session.
+ */
+static struct virtio_media_session *
+virtio_media_session_alloc(struct virtio_media *vv, u32 id,
+			   struct file *file)
+{
+	struct virtio_media_session *session;
+	int i;
+	int ret;
+
+	session = kzalloc_obj(*session, GFP_KERNEL);
+	if (!session)
+		goto err_session;
+
+	session->shadow_buf = kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNEL);
+	if (!session->shadow_buf)
+		goto err_shadow_buf;
+
+	ret = sg_alloc_table(&session->command_sgs, DESC_CHAIN_MAX_LEN,
+			     GFP_KERNEL);
+	if (ret)
+		goto err_payload_sgs;
+
+	session->id = id;
+	session->nonblocking_dequeue = file->f_flags & O_NONBLOCK;
+
+	INIT_LIST_HEAD(&session->list);
+	v4l2_fh_init(&session->fh, &vv->video_dev);
+	virtio_media_session_fh_add(session, file);
+
+	for (i = 0; i <= VIRTIO_MEDIA_LAST_QUEUE; i++)
+		INIT_LIST_HEAD(&session->queues[i].pending_dqbufs);
+	mutex_init(&session->queues_lock);
+
+	init_waitqueue_head(&session->dqbuf_wait);
+
+	mutex_lock(&vv->sessions_lock);
+	list_add_tail(&session->list, &vv->sessions);
+	mutex_unlock(&vv->sessions_lock);
+
+	return session;
+
+err_payload_sgs:
+	kfree(session->shadow_buf);
+err_shadow_buf:
+	kfree(session);
+err_session:
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * virtio_media_session_free() - Free all resources of a session.
+ * @vv: virtio-media device the session belongs to.
+ * @session: session to destroy.
+ *
+ * All the resources of @session, as well as the backing memory of @session
+ * itself, are freed.
+ */
+static void virtio_media_session_free(struct virtio_media *vv,
+				      struct virtio_media_session *session)
+{
+	int i;
+
+	mutex_lock(&vv->sessions_lock);
+	list_del(&session->list);
+	mutex_unlock(&vv->sessions_lock);
+
+	virtio_media_session_fh_del(session);
+	v4l2_fh_exit(&session->fh);
+
+	sg_free_table(&session->command_sgs);
+
+	for (i = 0; i <= VIRTIO_MEDIA_LAST_QUEUE; i++)
+		vfree(session->queues[i].buffers);
+
+	kfree(session->shadow_buf);
+	kfree(session);
+}
+
+/**
+ * virtio_media_session_close() - Close and free a session.
+ * @vv: virtio-media device the session belongs to.
+ * @session: session to close and destroy.
+ *
+ * This sends the ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device, and frees
+ * all resources used by @session.
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
+	cmd_close->session_id = session->id;
+
+	sg_set_buf(&cmd_sg, cmd_close, sizeof(*cmd_close));
+	sg_mark_end(&cmd_sg);
+
+	ret = virtio_media_send_command(vv, sgs, 1, 0, 0, NULL);
+	mutex_unlock(&vv->vlock);
+	if (ret < 0)
+		return ret;
+
+	virtio_media_session_free(vv, session);
+
+	return 0;
+}
+
+/**
+ * virtio_media_find_session() - Look up a session with a given ID.
+ * @vv: virtio-media device to lookup the session from.
+ * @id: ID of the session to lookup.
+ */
+static struct virtio_media_session *
+virtio_media_find_session(struct virtio_media *vv, u32 id)
+{
+	struct list_head *p;
+	struct virtio_media_session *session = NULL;
+
+	mutex_lock(&vv->sessions_lock);
+	list_for_each(p, &vv->sessions) {
+		struct virtio_media_session *s =
+			list_entry(p, struct virtio_media_session, list);
+		if (s->id == id) {
+			session = s;
+			break;
+		}
+	}
+	mutex_unlock(&vv->sessions_lock);
+
+	return session;
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
+		param->done = true;
+		param->resp_len = len;
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
+	ret = wait_event_timeout(vv->wq, cb_param.done, 5 * HZ);
+	if (ret == 0) {
+		v4l2_err(&vv->v4l2_dev,
+			 "timed out waiting for response to command\n");
+		return -ETIMEDOUT;
+	}
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
+ * virtio_media_send_event_buffer() - Sends an event buffer to the host so it
+ * can return it with an event.
+ * @vv: virtio-media device in use.
+ * @event_buffer: pointer to the event buffer to send to the device.
+ */
+static int virtio_media_send_event_buffer(struct virtio_media *vv,
+					  void *event_buffer)
+{
+	struct scatterlist *sgs[1], vresp;
+	int ret;
+
+	sg_init_one(&vresp, event_buffer, VIRTIO_MEDIA_EVENT_MAX_SIZE);
+	sgs[0] = &vresp;
+
+	ret = virtqueue_add_sgs(vv->eventq, sgs, 0, 1, event_buffer,
+				GFP_ATOMIC);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to add sgs to event virtqueue\n");
+		return ret;
+	}
+
+	if (!virtqueue_kick(vv->eventq)) {
+		v4l2_err(&vv->v4l2_dev, "failed to kick event virtqueue\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * eventq_callback() - Callback for the event queue.
+ * @queue: event virtqueue.
+ *
+ * This just schedules for event work to be run.
+ */
+static void eventq_callback(struct virtqueue *queue)
+{
+	struct virtio_media *vv = queue->vdev->priv;
+
+	schedule_work(&vv->eventq_work);
+}
+
+/**
+ * virtio_media_process_dqbuf_event() - Process a dequeued event for a session.
+ * @vv: virtio-media device in use.
+ * @session: session the event is addressed to.
+ * @dqbuf_evt: the dequeued event to process.
+ *
+ * Invalid events are ignored with an error log.
+ */
+static void
+virtio_media_process_dqbuf_event(struct virtio_media *vv,
+				 struct virtio_media_session *session,
+				 struct virtio_media_event_dqbuf *dqbuf_evt)
+{
+	struct virtio_media_buffer *dqbuf;
+	const enum v4l2_buf_type queue_type = dqbuf_evt->buffer.type;
+	struct virtio_media_queue_state *queue;
+	typeof(dqbuf->buffer.m) buffer_m;
+	typeof(dqbuf->buffer.m.planes[0].m) plane_m;
+	int i;
+
+	if (queue_type >= ARRAY_SIZE(session->queues)) {
+		v4l2_err(&vv->v4l2_dev,
+			 "unmanaged queue %d passed to dqbuf event",
+			 dqbuf_evt->buffer.type);
+		return;
+	}
+	queue = &session->queues[queue_type];
+
+	if (dqbuf_evt->buffer.index >= queue->allocated_bufs) {
+		v4l2_err(&vv->v4l2_dev,
+			 "invalid buffer ID %d for queue %d in dqbuf event",
+			 dqbuf_evt->buffer.index, dqbuf_evt->buffer.type);
+		return;
+	}
+
+	dqbuf = &queue->buffers[dqbuf_evt->buffer.index];
+
+	/*
+	 * Preserve the 'm' union that was passed to us during QBUF so userspace
+	 * gets back the information it submitted.
+	 */
+	buffer_m = dqbuf->buffer.m;
+	memcpy(&dqbuf->buffer, &dqbuf_evt->buffer, sizeof(dqbuf->buffer));
+	dqbuf->buffer.m = buffer_m;
+	if (V4L2_TYPE_IS_MULTIPLANAR(dqbuf->buffer.type)) {
+		if (dqbuf->buffer.length > VIDEO_MAX_PLANES) {
+			v4l2_err(&vv->v4l2_dev,
+				 "invalid number of planes received from host for a multiplanar buffer\n");
+			return;
+		}
+		for (i = 0; i < dqbuf->buffer.length; i++) {
+			plane_m = dqbuf->planes[i].m;
+			memcpy(&dqbuf->planes[i], &dqbuf_evt->planes[i],
+			       sizeof(struct v4l2_plane));
+			dqbuf->planes[i].m = plane_m;
+		}
+	}
+
+	/* Set the DONE flag as the buffer is waiting to be dequeued. */
+	dqbuf->buffer.flags |= V4L2_BUF_FLAG_DONE;
+
+	mutex_lock(&session->queues_lock);
+	list_add_tail(&dqbuf->list, &queue->pending_dqbufs);
+	queue->queued_bufs -= 1;
+	mutex_unlock(&session->queues_lock);
+
+	wake_up(&session->dqbuf_wait);
+}
+
+/**
+ * virtio_media_process_events() - Process all pending events on a device.
+ * @vv: device whose pending events we want to process.
+ *
+ * Retrieves all pending events on @vv's event queue and dispatches them to
+ * their corresponding session.
+ *
+ * Invalid events are ignored with an error log.
+ */
+void virtio_media_process_events(struct virtio_media *vv)
+{
+	struct virtio_media_event_error *error_evt;
+	struct virtio_media_event_dqbuf *dqbuf_evt;
+	struct virtio_media_event_event *event_evt;
+	struct virtio_media_session *session;
+	struct virtio_media_event_header *evt;
+	unsigned int len;
+
+	mutex_lock(&vv->events_lock);
+
+process_bufs:
+	while ((evt = virtqueue_get_buf(vv->eventq, &len))) {
+		/* Make sure we received enough data */
+		if (len < sizeof(*evt)) {
+			v4l2_err(&vv->v4l2_dev,
+				 "event is too short: got %u, expected at least %zu\n",
+				 len, sizeof(*evt));
+			goto end_of_event;
+		}
+
+		session = virtio_media_find_session(vv, evt->session_id);
+		if (!session) {
+			v4l2_err(&vv->v4l2_dev, "cannot find session %d\n",
+				 evt->session_id);
+			goto end_of_event;
+		}
+
+		switch (evt->event) {
+		case VIRTIO_MEDIA_EVT_ERROR:
+			if (len < sizeof(*error_evt)) {
+				v4l2_err(&vv->v4l2_dev,
+					 "error event is too short: got %u, expected %zu\n",
+					 len, sizeof(*error_evt));
+				break;
+			}
+			error_evt = (struct virtio_media_event_error *)evt;
+			v4l2_err(&vv->v4l2_dev,
+				 "received error %d for session %d",
+				 error_evt->errno, error_evt->hdr.session_id);
+			virtio_media_session_close(vv, session);
+			break;
+
+		/*
+		 * Dequeued buffer: put it into the right queue so user-space
+		 * can dequeue it.
+		 */
+		case VIRTIO_MEDIA_EVT_DQBUF:
+			if (len < sizeof(*dqbuf_evt)) {
+				v4l2_err(&vv->v4l2_dev,
+					 "dqbuf event is too short: got %u, expected %zu\n",
+					 len, sizeof(*dqbuf_evt));
+				break;
+			}
+			dqbuf_evt = (struct virtio_media_event_dqbuf *)evt;
+			virtio_media_process_dqbuf_event(vv, session,
+							 dqbuf_evt);
+			break;
+
+		case VIRTIO_MEDIA_EVT_EVENT:
+			if (len < sizeof(*event_evt)) {
+				v4l2_err(&vv->v4l2_dev,
+					 "session event is too short: got %u expected %zu\n",
+					 len, sizeof(*event_evt));
+				break;
+			}
+
+			event_evt = (struct virtio_media_event_event *)evt;
+			v4l2_event_queue_fh(&session->fh, &event_evt->event);
+			break;
+
+		default:
+			v4l2_err(&vv->v4l2_dev, "unknown event type %d\n",
+				 evt->event);
+			break;
+		}
+
+end_of_event:
+		virtio_media_send_event_buffer(vv, evt);
+	}
+
+	if (!virtqueue_enable_cb(vv->eventq)) {
+		virtqueue_disable_cb(vv->eventq);
+		goto process_bufs;
+	}
+
+	mutex_unlock(&vv->events_lock);
+}
+
+static void virtio_media_event_work(struct work_struct *work)
 {
+	struct virtio_media *vv =
+		container_of(work, struct virtio_media, eventq_work);
+
+	virtio_media_process_events(vv);
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
+	u32 session_id;
+	int ret;
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
+	ret = virtio_media_send_command(vv, sgs, 1, 1, sizeof(*resp_open),
+					NULL);
+	session_id = resp_open->session_id;
+	mutex_unlock(&vv->vlock);
+	if (ret < 0)
+		return ret;
+
+	session = virtio_media_session_alloc(vv, session_id, file);
+	if (IS_ERR(session))
+		return PTR_ERR(session);
+
+	file->private_data = &session->fh;
+
+	return 0;
 }
 
-static void eventq_callback(struct virtqueue *vq)
+/**
+ * virtio_media_device_close() - Close a previously opened session.
+ * @file: file of the session to close.
+ *
+ * This sends the ``VIRTIO_MEDIA_CMD_CLOSE`` command to the device, and closes
+ * the session on the driver side.
+ */
+static int virtio_media_device_close(struct file *file)
 {
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session =
+		fh_to_session(file->private_data);
+
+	return virtio_media_session_close(vv, session);
 }
 
 static const struct v4l2_file_operations virtio_media_fops = {
 	.owner = THIS_MODULE,
-	.open = v4l2_fh_open,
-	.release = v4l2_fh_release,
+	.open = virtio_media_device_open,
+	.release = virtio_media_device_close,
 };
 
 static int virtio_media_probe(struct virtio_device *virtio_dev)
@@ -51,12 +615,23 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 	};
 	struct virtio_media *vv;
 	struct video_device *vd;
+	int i;
 	int ret;
 
 	vv = devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
 	if (!vv)
 		return -ENOMEM;
 
+	const size_t virtio_media_event_aligned_size =
+		ALIGN(VIRTIO_MEDIA_EVENT_MAX_SIZE, dma_get_cache_alignment());
+
+	vv->event_buffer = devm_kzalloc(dev,
+					virtio_media_event_aligned_size *
+					VIRTIO_MEDIA_NUM_EVENT_BUFS,
+					GFP_KERNEL);
+	if (!vv->event_buffer)
+		return -ENOMEM;
+
 	INIT_LIST_HEAD(&vv->sessions);
 	mutex_init(&vv->sessions_lock);
 	mutex_init(&vv->events_lock);
@@ -77,6 +652,7 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 
 	vv->commandq = vqs[0];
 	vv->eventq = vqs[1];
+	INIT_WORK(&vv->eventq_work, virtio_media_event_work);
 
 	vd = &vv->video_dev;
 	vd->v4l2_dev = &vv->v4l2_dev;
@@ -100,10 +676,21 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 	if (ret)
 		goto err_register_device;
 
+	for (i = 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
+		void *ebuf = vv->event_buffer +
+			     virtio_media_event_aligned_size * i;
+
+		ret = virtio_media_send_event_buffer(vv, ebuf);
+		if (ret)
+			goto err_send_event_buffer;
+	}
+
 	virtio_device_ready(virtio_dev);
 
 	return 0;
 
+err_send_event_buffer:
+	video_unregister_device(&vv->video_dev);
 err_register_device:
 	virtio_dev->config->del_vqs(virtio_dev);
 err_find_vqs:
@@ -114,11 +701,20 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 static void virtio_media_remove(struct virtio_device *virtio_dev)
 {
 	struct virtio_media *vv = virtio_dev->priv;
+	struct list_head *p, *n;
 
+	cancel_work_sync(&vv->eventq_work);
 	virtio_reset_device(virtio_dev);
 	v4l2_device_unregister(&vv->v4l2_dev);
 	virtio_dev->config->del_vqs(virtio_dev);
 	video_unregister_device(&vv->video_dev);
+
+	list_for_each_safe(p, n, &vv->sessions) {
+		struct virtio_media_session *s =
+			list_entry(p, struct virtio_media_session, list);
+
+		virtio_media_session_free(vv, s);
+	}
 }
 
 static struct virtio_device_id id_table[] = {
-- 
2.55.0.897.gb25b4bd76c-goog

