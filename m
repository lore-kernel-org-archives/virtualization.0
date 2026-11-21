Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795229432;
	b=1aArXAoRTMM9wQ9v35KwPgrsZoQ+3G9K3yO4eOjw1/wd1uYSXtVtKMBJFC16h4BoYQib
	 X9PW3GlhmfE+2CYwkk8t3Q+ny5vdWInI6nwRKjwOKdlGGW00/3huPBw7YAzKXHQ0U+9/V
	 fRSWGRWOHX7sMTlsAOUOFvsl27XBkWB3dAEGIDlfWXqhAkOD3ACw7l0CjBFWtIvAwxvhw
	 /wVATkdpwZsiCXghSSXViaNkKbp8qNrkwwX0w2wipFgKXkLbGjo3EP3Ajv7BiJCO8ESQt
	 Ap8YnEGeSfSdPk/DkjKD/RuFe2VFZzaMgu3jQ4SINMtPJm/ePle/BxEVUkYRCrjsjIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795229432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MrmFpeLJ/38ckjhm/RtP/AIZC3X17uQZsfKeEHaVR4s=;
	b=2kJsxzrN/dUpjli3lCJ7Ri2rLc+1GAt7cWYZ9n6TZRkWHcEID3QsSKcZB1JYRri7ogV1
	 vopikHCgcuXIKYOwGwOWzeMufynhSOv+gmhgFha6tBh9tUigVNSBPXNX7n4U5cxXSsHtu
	 P+6hCWcfEkUed2mIWe1V8dtPZn84musuPqiy4P52gJspGLL/ETC/a2je5s2KFOn4vxWhj
	 b7Lx3DiGqO64treSssOc+SlyJaRWcC1n5Akj2PfO1Az6UkYlQz/7VIi6h07gsJXdUtBdB
	 O9eJNQL2ERYYDn824n24gXrhOwOKplZHji1T3I0QlfT+8qwlpiIuX7K7sxmwSC/mXaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g5tzImZb;
	arc=none smtp.remote-ip=209.85.160.199
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831960A261F
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 02:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4831960A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g5tzImZb
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-544019b1831so31537971cf.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 18:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795229419; x=1795834219; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrmFpeLJ/38ckjhm/RtP/AIZC3X17uQZsfKeEHaVR4s=;
        b=g5tzImZbFhlZBxxo8HxlxLqb0vMpz/5SPrA893hSP5lQpniPBkwWvepIU50vYPa6Km
         Qbz2jBLn4LcosoRQeLhghcsvbcceJCi//qI28wJmv/dhT64jD1cCPw7GDIxqAY6E9tNO
         rst5SbM9Zphp61RsjBCt8VH0Oy9WOK6UYB9l+OgjQ2YhZPUuIE5g9cuyiFuOW7Aoevut
         O+vS3lz1ipKk7jxGf/xsutylTATz6HUdIp25nLT3oSKsdNqEq1Z3kSDB3R4pYt8ktvSL
         8jISbDVLYAgCwuqh9NOkq7SeoYkDKoPBn4xQcdGTXlgxvNy73fE/ORGdeaceX8uSn6ma
         VSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795229419; x=1795834219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MrmFpeLJ/38ckjhm/RtP/AIZC3X17uQZsfKeEHaVR4s=;
        b=EcqNSUG3fqjibfchMJLK/58LOwNFi0rlkNwP4wIJPxC7CuUwfsjWOdY6ldRE0ajkGh
         t9Fz9Ocs+GR4NIxoTE3tuJhZuQOL8vghEXvy4vIaSfSXt58nu/xKDKH28A1ows8fdNnc
         n8WGf3xH6fZOvcQOqRontEE/tSkZiBujlOWK/FGd5k7EZXtyuzaFZ++TtDG2pYs3UVvS
         v+Njbr9CfUbdTmXeFudEEX1D9Ks+BlH+Wi6qsRXf4mXGpAdvzIiGsXSm1dd6y+p9UUSE
         KNlyIb/jPE+f2vNNSTD3wDZ+BMxHOeLOlY1en1B/qHhOoYIfP4oyPud0FSjwiefDYoWB
         Dhtw==
X-Forwarded-Encrypted: i=1; AL+hErHN4DDIjZkMiZT0tqYAnA0T0Rq/XrSBwctjI2eXyGik5YaIi53CIsbqGieN0bGmrlDUJAEltMXI0fl0Z8ufaA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9eE/FS5noWxJJsdZ++rw69EnB1Xb6usrC0yaeI1YPV45Smr0TQ
	6S6rtf1+H7TqJykc0aaxqILRKhVMSn7heJovas2jOVe0/oK9PJ3QFSyU186R+Y9vkV58UV3Zpt2
	BWgU7dyFFCsvxGrXzBGiCdeezIkiX
X-Received: from qvbqh10.prod.google.com ([2002:a05:6214:4c0a:b0:920:f933:ca92])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:c0a:b0:55d:32b0:69d3 with SMTP id d75a77b69052e-55d76aa5797mr84989231cf.30.1795229418812;
 Fri, 20 Nov 2026 18:50:18 -0800 (PST)
Date: Fri, 20 Nov 2026 21:50:05 -0500
In-Reply-To: <20261121025007.3445723-1-briandaniels@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261121025007.3445723-1-briandaniels@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121025007.3445723-5-briandaniels@google.com>
Subject: [PATCH v12 4/6] media: virtio: Add buffer streaming, event handling,
 and poll
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

Add V4L2 buffer queue state tracking, streaming ioctls, asynchronous
event virtqueue processing, V4L2 event subscription, and poll support.

Set up the event virtqueue to receive VIRTIO_MEDIA_EVT_DQBUF,
VIRTIO_MEDIA_EVT_EVENT, and VIRTIO_MEDIA_EVT_ERROR notifications from
the host, dispatching dequeued buffers, V4L2 events, and unrecoverable
session errors to their respective sessions.

Implement buffer and streaming ioctls (VIDIOC_REQBUFS,
VIDIOC_CREATE_BUFS, VIDIOC_QUERYBUF, VIDIOC_PREPARE_BUF, VIDIOC_QBUF,
VIDIOC_DQBUF, VIDIOC_STREAMON, VIDIOC_STREAMOFF, and VIDIOC_DECODER_CMD)
as well as VIDIOC_SUBSCRIBE_EVENT, VIDIOC_UNSUBSCRIBE_EVENT, and the
poll file operation.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/scatterlist_builder.c |  72 +++
 drivers/media/virtio/scatterlist_builder.h |   8 +
 drivers/media/virtio/session.h             |  51 ++
 drivers/media/virtio/virtio_media.h        |  11 +
 drivers/media/virtio/virtio_media_driver.c | 396 ++++++++++++-
 drivers/media/virtio/virtio_media_ioctls.c | 618 ++++++++++++++++++++-
 include/uapi/linux/virtio_media.h          |  68 +++
 7 files changed, 1218 insertions(+), 6 deletions(-)

diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/virtio/scatterlist_builder.c
index 631c7b13c..f01df04cd 100644
--- a/drivers/media/virtio/scatterlist_builder.c
+++ b/drivers/media/virtio/scatterlist_builder.c
@@ -356,6 +356,78 @@ static int scatterlist_builder_add_userptr(struct scatterlist_builder *builder,
 	return 0;
 }
 
+/**
+ * scatterlist_builder_add_buffer() - Add a &struct v4l2_buffer and its planes
+ *                                    to the descriptor chain.
+ * @builder: builder to use.
+ * @b: &struct v4l2_buffer to add.
+ */
+int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
+				   struct v4l2_buffer *b)
+{
+	int ret;
+
+	/* v4l2_buffer */
+	ret = scatterlist_builder_add_data(builder, b, sizeof(*b));
+	if (ret)
+		return ret;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type) && b->length > 0) {
+		/* Array of v4l2_planes */
+		ret = scatterlist_builder_add_data(builder, b->m.planes,
+						   sizeof(struct v4l2_plane) *
+							   b->length);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * scatterlist_builder_retrieve_buffer() - Retrieve a &struct v4l2_buffer
+ *                                         written by the device on the shadow
+ *                                         buffer, if needed.
+ * @builder: builder to use.
+ * @sg_index: index of the first SG entry of the buffer in the builder's
+ *            descriptor chain.
+ * @b: &struct v4l2_buffer to copy shadow buffer data into.
+ * @orig_planes: the original ``planes`` pointer, to be restored if the buffer
+ *               is multi-planar.
+ *
+ * If the &struct v4l2_buffer pointed to by @sg_index was copied into the
+ * shadow buffer, then its updated content is copied back into @b.
+ * Otherwise nothing is done as the device has written into @b directly.
+ *
+ * @orig_planes is used to restore the original ``planes`` pointer in case it
+ * gets modified by the host. The specification stipulates that the host should
+ * not modify it, but we enforce this for additional safety.
+ */
+int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *builder,
+					size_t sg_index, struct v4l2_buffer *b,
+					struct v4l2_plane *orig_planes)
+{
+	int ret;
+
+	ret = scatterlist_builder_retrieve_data(builder, sg_index++, b);
+	if (ret)
+		return ret;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
+		b->m.planes = orig_planes;
+
+		if (orig_planes) {
+			ret = scatterlist_builder_retrieve_data(builder,
+								sg_index++,
+								b->m.planes);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * scatterlist_builder_add_ext_ctrls() - Add a &struct v4l2_ext_controls and its
  *                                       controls to @builder.
diff --git a/drivers/media/virtio/scatterlist_builder.h b/drivers/media/virtio/scatterlist_builder.h
index bced1e030..f63daca33 100644
--- a/drivers/media/virtio/scatterlist_builder.h
+++ b/drivers/media/virtio/scatterlist_builder.h
@@ -96,6 +96,14 @@ int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builder,
 int scatterlist_builder_add_ioctl_resp(struct scatterlist_builder *builder,
 				       struct virtio_media_session *session);
 
+int scatterlist_builder_add_buffer(struct scatterlist_builder *builder,
+				   struct v4l2_buffer *buffer);
+
+int scatterlist_builder_retrieve_buffer(struct scatterlist_builder *builder,
+					size_t sg_index,
+					struct v4l2_buffer *buffer,
+					struct v4l2_plane *orig_planes);
+
 int scatterlist_builder_add_ext_ctrls(struct scatterlist_builder *builder,
 				      struct v4l2_ext_controls *ctrls);
 
diff --git a/drivers/media/virtio/session.h b/drivers/media/virtio/session.h
index 6fe7ff5ae..16bb86bf4 100644
--- a/drivers/media/virtio/session.h
+++ b/drivers/media/virtio/session.h
@@ -14,17 +14,55 @@
 
 #include "uapi/linux/virtio_media.h"
 
+#define VIRTIO_MEDIA_LAST_QUEUE (V4L2_BUF_TYPE_META_OUTPUT)
+
 /*
  * Size of the per-session virtio shadow and event buffers. 16K should be
  * enough to contain everything we need.
  */
 #define VIRTIO_SHADOW_BUF_SIZE 0x4000
 
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
 /**
  * struct virtio_media_session - A session on a virtio_media device.
  * @fh: file handler for the session.
  * @file: file pointer associated with the session's file handler.
  * @id: session ID used to communicate with the device.
+ * @nonblocking_dequeue: whether dequeue should block or not (nonblocking if
+ *                       file opened with O_NONBLOCK).
+ * @uses_mplane: whether the queues for this session use the MPLANE API or not.
  * @cmd: union of session commands ``close`` and ``ioctl``. A session can have
  *       one command currently running. The rest of the commands are handled by
  *       &struct virtio_media.
@@ -35,12 +73,19 @@
  *              be staged before being sent to the device.
  * @command_sgs: SG table gathering descriptors for a given command and its
  *               response.
+ * @queues: state of all the queues for this session.
+ * @queues_lock: protects all members for the queues for this session.
+ * @dqbuf_wait: waitqueue for dequeued buffers, if ``VIDIOC_DQBUF`` needs to
+ *              block or when polling.
+ * @error: true if the session has encountered an unrecoverable session error.
  * @list: link into the list of sessions for the device.
  */
 struct virtio_media_session {
 	struct v4l2_fh fh;
 	struct file *file;
 	u32 id;
+	bool nonblocking_dequeue;
+	bool uses_mplane;
 
 	__dma_from_device_group_begin();
 	union {
@@ -57,6 +102,12 @@ struct virtio_media_session {
 
 	struct sg_table command_sgs;
 
+	struct virtio_media_queue_state queues[VIRTIO_MEDIA_LAST_QUEUE + 1];
+	struct mutex queues_lock; /* protects queues array and states */
+	wait_queue_head_t dqbuf_wait;
+	bool error;
+	struct mutex error_lock; /* protects error */
+
 	struct list_head list;
 };
 
diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/virtio/virtio_media.h
index a120c1014..8b21c1941 100644
--- a/drivers/media/virtio/virtio_media.h
+++ b/drivers/media/virtio/virtio_media.h
@@ -24,8 +24,12 @@
  * @video_dev: video_device for the media device.
  * @virtio_dev: virtio device for the media device.
  * @commandq: virtio command queue.
+ * @eventq: virtio event queue.
+ * @eventq_work: work to run when events are received on @eventq.
+ * @event_buffer: buffer for event descriptors.
  * @sessions: list of active sessions on the device.
  * @sessions_lock: protects @sessions and &struct virtio_media_session.list.
+ * @events_lock: prevents concurrent processing of events.
  * @cmd: union of device-level commands. Session commands are handled by
  *       &struct virtio_media_session.
  * @resp: union of responses to device-level commands. Session responses are
@@ -39,10 +43,16 @@ struct virtio_media {
 
 	struct virtio_device *virtio_dev;
 	struct virtqueue *commandq;
+	struct virtqueue *eventq;
+	struct work_struct eventq_work;
+
+	void *event_buffer;
 
 	struct list_head sessions;
 	struct mutex sessions_lock; /* protects sessions list */
 
+	struct mutex events_lock; /* prevents concurrent event processing */
+
 	__dma_from_device_group_begin();
 	union {
 		struct virtio_media_cmd_open open;
@@ -68,6 +78,7 @@ to_virtio_media(struct video_device *video_dev)
 int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
 			      const size_t out_sgs, const size_t in_sgs,
 			      size_t minimum_resp_len, size_t *resp_len);
+void virtio_media_process_events(struct virtio_media *vv);
 
 /* virtio_media_ioctls.c */
 
diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/virtio/virtio_media_driver.c
index 0fe20cf50..748357725 100644
--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -16,15 +16,22 @@
 #include <linux/virtio_ids.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
+#include <linux/vmalloc.h>
+#include <linux/workqueue.h>
+#include <linux/dma-mapping.h>
+#include <linux/poll.h>
 
 #include <media/v4l2-dev.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fh.h>
+#include <media/v4l2-event.h>
 
 #include "uapi/linux/virtio_media.h"
 #include "session.h"
 #include "virtio_media.h"
 
+#define VIRTIO_MEDIA_NUM_EVENT_BUFS 16
+
 /**
  * virtio_media_session_alloc() - Allocate a new session.
  * @vv: virtio-media device the session belongs to.
@@ -37,6 +44,7 @@ static struct virtio_media_session *
 virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
 {
 	struct virtio_media_session *session;
+	int i;
 	int ret;
 
 	session = kzalloc_obj(*session, GFP_KERNEL);
@@ -54,11 +62,20 @@ virtio_media_session_alloc(struct virtio_media *vv, struct file *file)
 
 	// The caller is expected to set the ID once the host assigns a value.
 	session->id = 0;
+	session->nonblocking_dequeue = file->f_flags & O_NONBLOCK;
 
 	INIT_LIST_HEAD(&session->list);
 	v4l2_fh_init(&session->fh, &vv->video_dev);
 	virtio_media_session_fh_add(session, file);
 
+	for (i = 0; i <= VIRTIO_MEDIA_LAST_QUEUE; i++)
+		INIT_LIST_HEAD(&session->queues[i].pending_dqbufs);
+	mutex_init(&session->queues_lock);
+
+	init_waitqueue_head(&session->dqbuf_wait);
+
+	mutex_init(&session->error_lock);
+
 	return session;
 
 err_payload_sgs:
@@ -91,11 +108,16 @@ static void virtio_media_session_add(struct virtio_media *vv,
  */
 static void virtio_media_session_free(struct virtio_media_session *session)
 {
+	int i;
+
 	virtio_media_session_fh_del(session);
 	v4l2_fh_exit(&session->fh);
 
 	sg_free_table(&session->command_sgs);
 
+	for (i = 0; i <= VIRTIO_MEDIA_LAST_QUEUE; i++)
+		vfree(session->queues[i].buffers);
+
 	kfree(session->shadow_buf);
 	kfree(session);
 }
@@ -152,6 +174,31 @@ static int virtio_media_session_close(struct virtio_media *vv,
 	return 0;
 }
 
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
 /**
  * struct virtio_media_cmd_callback_param - Callback parameters to the virtio
  *                                          command queue.
@@ -290,6 +337,234 @@ int virtio_media_send_command(struct virtio_media *vv, struct scatterlist **sgs,
 	return 0;
 }
 
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
+				 error_evt->error, error_evt->hdr.session_id);
+
+			mutex_lock(&session->error_lock);
+			session->error = true;
+			mutex_unlock(&session->error_lock);
+
+			virtio_media_session_close(vv, session);
+
+			/* Wake up any waiting dqbuf requests */
+			wake_up(&session->dqbuf_wait);
+
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
+{
+	struct virtio_media *vv =
+		container_of(work, struct virtio_media, eventq_work);
+
+	virtio_media_process_events(vv);
+}
+
 /**
  * virtio_media_device_open() - Create a new session from an opened file.
  * @file: opened file for the session.
@@ -350,7 +625,16 @@ static int virtio_media_device_close(struct file *file)
 	struct virtio_media_session *session =
 		fh_to_session(file->private_data);
 
-	int ret = virtio_media_session_close(vv, session);
+	mutex_lock(&session->error_lock);
+	bool session_error = session->error;
+
+	mutex_unlock(&session->error_lock);
+
+	int ret = 0;
+
+	/* If session is in an error state, then it has already been closed */
+	if (!session_error)
+		ret = virtio_media_session_close(vv, session);
 
 	virtio_media_session_remove(vv, session);
 	virtio_media_session_free(session);
@@ -358,10 +642,66 @@ static int virtio_media_device_close(struct file *file)
 	return ret;
 }
 
+/**
+ * virtio_media_device_poll() - Poll logic for a virtio-media device.
+ * @file: file of the session to poll.
+ * @wait: poll table to wait on.
+ */
+static __poll_t virtio_media_device_poll(struct file *file, poll_table *wait)
+{
+	struct virtio_media_session *session =
+		fh_to_session(file->private_data);
+	enum v4l2_buf_type capture_type =
+		session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
+				       V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	enum v4l2_buf_type output_type =
+		session->uses_mplane ? V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE :
+				       V4L2_BUF_TYPE_VIDEO_OUTPUT;
+	struct virtio_media_queue_state *capture_queue =
+		&session->queues[capture_type];
+	struct virtio_media_queue_state *output_queue =
+		&session->queues[output_type];
+	__poll_t req_events = poll_requested_events(wait);
+	__poll_t rc = 0;
+
+	poll_wait(file, &session->dqbuf_wait, wait);
+	poll_wait(file, &session->fh.wait, wait);
+
+	mutex_lock(&session->error_lock);
+	if (session->error)
+		rc |= EPOLLERR;
+	mutex_unlock(&session->error_lock);
+
+	mutex_lock(&session->queues_lock);
+	if (req_events & (EPOLLIN | EPOLLRDNORM)) {
+		if (!capture_queue->streaming ||
+		    (capture_queue->queued_bufs == 0 &&
+		     list_empty(&capture_queue->pending_dqbufs)))
+			rc |= EPOLLERR;
+		else if (!list_empty(&capture_queue->pending_dqbufs) ||
+			 capture_queue->is_capture_last)
+			rc |= EPOLLIN | EPOLLRDNORM;
+	}
+	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
+		if (!output_queue->streaming)
+			rc |= EPOLLERR;
+		else if (output_queue->queued_bufs <
+			 output_queue->allocated_bufs)
+			rc |= EPOLLOUT | EPOLLWRNORM;
+	}
+	mutex_unlock(&session->queues_lock);
+
+	if (v4l2_event_pending(&session->fh))
+		rc |= EPOLLPRI;
+
+	return rc;
+}
+
 static const struct v4l2_file_operations virtio_media_fops = {
 	.owner = THIS_MODULE,
 	.open = virtio_media_device_open,
 	.release = virtio_media_device_close,
+	.poll = virtio_media_device_poll,
 	.unlocked_ioctl = virtio_media_device_ioctl,
 };
 
@@ -371,29 +711,47 @@ static void virtio_media_release(struct v4l2_device *v4l2_dev)
 		container_of(v4l2_dev, struct virtio_media, v4l2_dev);
 
 	v4l2_device_unregister(&vv->v4l2_dev);
+	kfree(vv->event_buffer);
 	kfree(vv);
 }
 
 static int virtio_media_probe(struct virtio_device *virtio_dev)
 {
 	struct device *dev = &virtio_dev->dev;
-	struct virtqueue *vqs[1];
-	static struct virtqueue_info vq_info[1] = {
+	struct virtqueue *vqs[2];
+	static struct virtqueue_info vq_info[2] = {
 		{
 			.name = "command",
 			.callback = commandq_callback,
 		},
+		{
+			.name = "event",
+			.callback = eventq_callback,
+		},
 	};
 	struct virtio_media *vv;
 	struct video_device *vd;
+	int i;
 	int ret;
 
 	vv = kzalloc_obj(struct virtio_media);
 	if (!vv)
 		return -ENOMEM;
 
+	const size_t virtio_media_event_aligned_size =
+		ALIGN(VIRTIO_MEDIA_EVENT_MAX_SIZE, dma_get_cache_alignment());
+
+	vv->event_buffer = kzalloc(virtio_media_event_aligned_size *
+				   VIRTIO_MEDIA_NUM_EVENT_BUFS,
+				   GFP_KERNEL);
+	if (!vv->event_buffer) {
+		ret = -ENOMEM;
+		goto err_free_virtio_media;
+	}
+
 	INIT_LIST_HEAD(&vv->sessions);
 	mutex_init(&vv->sessions_lock);
+	mutex_init(&vv->events_lock);
 	mutex_init(&vv->vlock);
 
 	vv->virtio_dev = virtio_dev;
@@ -403,15 +761,17 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 
 	ret = v4l2_device_register(dev, &vv->v4l2_dev);
 	if (ret)
-		goto err_free_virtio_media;
+		goto err_free_event_buffer;
 
 	vv->v4l2_dev.release = virtio_media_release;
 
-	ret = virtio_find_vqs(virtio_dev, 1, vqs, vq_info, NULL);
+	ret = virtio_find_vqs(virtio_dev, 2, vqs, vq_info, NULL);
 	if (ret)
 		goto err_v4l2_device_unregister;
 
 	vv->commandq = vqs[0];
+	vv->eventq = vqs[1];
+	INIT_WORK(&vv->eventq_work, virtio_media_event_work);
 
 	vd = &vv->video_dev;
 	vd->v4l2_dev = &vv->v4l2_dev;
@@ -449,13 +809,34 @@ static int virtio_media_probe(struct virtio_device *virtio_dev)
 	if (ret)
 		goto err_del_vqs;
 
+	mutex_lock(&vv->events_lock);
+
+	for (i = 0; i < VIRTIO_MEDIA_NUM_EVENT_BUFS; i++) {
+		void *ebuf = vv->event_buffer +
+			     virtio_media_event_aligned_size * i;
+
+		ret = virtio_media_send_event_buffer(vv, ebuf);
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&vv->events_lock);
+
+	if (ret)
+		goto err_video_unregister_device;
+
 	return 0;
 
+err_video_unregister_device:
+	video_unregister_device(&vv->video_dev);
 err_del_vqs:
+	cancel_work_sync(&vv->eventq_work);
 	virtio_reset_device(virtio_dev);
 	virtio_dev->config->del_vqs(virtio_dev);
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&vv->v4l2_dev);
+err_free_event_buffer:
+	kfree(vv->event_buffer);
 err_free_virtio_media:
 	kfree(vv);
 	return ret;
@@ -469,6 +850,9 @@ static void virtio_media_remove(struct virtio_device *virtio_dev)
 	/* Remove the video device to stop accessing the commandq virtqueue */
 	video_unregister_device(&vv->video_dev);
 
+	/* Stop event handling work queue from accessing eventq virtqueue */
+	cancel_work_sync(&vv->eventq_work);
+
 	/*
 	 * Acquire vlock to ensure no concurrent accesses to the commandq
 	 * virtqueue
@@ -484,6 +868,8 @@ static void virtio_media_remove(struct virtio_device *virtio_dev)
 	 */
 	while (virtqueue_detach_unused_buf(vv->commandq))
 		;
+	while (virtqueue_detach_unused_buf(vv->eventq))
+		;
 
 	/* Delete the virtqueues */
 	virtio_dev->config->del_vqs(virtio_dev);
diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
index d0ea743e7..aa56efe9a 100644
--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -9,6 +9,8 @@
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
 #include <linux/virtio_config.h>
+#include <linux/vmalloc.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
 
 #include "scatterlist_builder.h"
@@ -221,6 +223,101 @@ static int virtio_media_send_wr_ioctl(struct v4l2_fh *fh, u32 ioctl,
 	return 0;
 }
 
+/**
+ * virtio_media_send_buffer_ioctl() - Send an ioctl taking a buffer as
+ * parameter to the device.
+ * @fh: file handler of the session doing the ioctl.
+ * @ioctl: ``VIDIOC_*`` ioctl code.
+ * @b: &struct v4l2_buffer to be sent as the ioctl payload.
+ *
+ * Buffers can require an additional descriptor to send their planes array, and
+ * can have pointers to userspace memory hence this dedicated function.
+ */
+static int virtio_media_send_buffer_ioctl(struct v4l2_fh *fh, u32 ioctl,
+					  struct v4l2_buffer *b)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session = fh_to_session(fh);
+	struct v4l2_plane *orig_planes = NULL;
+	struct scatterlist *sgs[64];
+	/*
+	 * End of the device-readable buffer SGs, to reuse in device-writable
+	 * section.
+	 */
+	size_t num_cmd_sgs;
+	size_t end_buf_sg;
+	struct scatterlist_builder builder = {
+		.descs = session->command_sgs.sgl,
+		.num_descs = DESC_CHAIN_MAX_LEN,
+		.cur_desc = 0,
+		.shadow_buffer = session->shadow_buf,
+		.shadow_buffer_size = VIRTIO_SHADOW_BUF_SIZE,
+		.shadow_buffer_pos = 0,
+		.sgs = sgs,
+		.num_sgs = ARRAY_SIZE(sgs),
+		.cur_sg = 0,
+		.framevecs = NULL,
+	};
+	size_t resp_len;
+	int ret;
+	int i;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
+		orig_planes = b->m.planes;
+
+	/* Command descriptor */
+	ret = scatterlist_builder_add_ioctl_cmd(&builder, session, ioctl);
+	if (ret)
+		return ret;
+
+	/* Command payload (struct v4l2_buffer) */
+	ret = scatterlist_builder_add_buffer(&builder, b);
+	if (ret < 0)
+		return ret;
+
+	end_buf_sg = builder.cur_sg;
+	num_cmd_sgs = builder.cur_sg;
+
+	/* Response descriptor */
+	ret = scatterlist_builder_add_ioctl_resp(&builder, session);
+	if (ret)
+		return ret;
+
+	/* Response payload (same as input, but no userptr mapping) */
+	for (i = 1; i < end_buf_sg; i++) {
+		ret = scatterlist_builder_add_descriptor(&builder, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = virtio_media_send_command(vv, builder.sgs, num_cmd_sgs,
+					builder.cur_sg - num_cmd_sgs,
+					sizeof(struct virtio_media_resp_ioctl) +
+					sizeof(*b), &resp_len);
+	if (ret < 0)
+		return ret;
+
+	resp_len -= sizeof(struct virtio_media_resp_ioctl);
+
+	/* Make sure that the reply length covers our v4l2_buffer */
+	if (resp_len < sizeof(*b))
+		return -EINVAL;
+
+	ret = scatterlist_builder_retrieve_buffer(&builder, num_cmd_sgs + 1, b,
+						  orig_planes);
+	if (ret) {
+		v4l2_err(&vv->v4l2_dev,
+			 "failed to retrieve response descriptor chain\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * virtio_media_send_ext_controls_ioctl() - Send an ioctl taking extended
  * controls as parameters to the device.
@@ -345,6 +442,41 @@ static int virtio_media_send_ext_controls_ioctl(struct v4l2_fh *fh, u32 ioctl,
 	return ret;
 }
 
+/**
+ * virtio_media_clear_queue() - clear all pending buffers on a streamed-off
+ *                              queue.
+ * @session: session which the queue to clear belongs to.
+ * @queue: state of the queue to clear.
+ *
+ * Helper function to clear the list of buffers waiting to be dequeued on a
+ * queue that has just been streamed off.
+ */
+static void virtio_media_clear_queue(struct virtio_media_session *session,
+				     struct virtio_media_queue_state *queue)
+{
+	struct list_head *p, *n;
+	int i;
+
+	mutex_lock(&session->queues_lock);
+
+	list_for_each_safe(p, n, &queue->pending_dqbufs) {
+		struct virtio_media_buffer *dqbuf =
+			list_entry(p, struct virtio_media_buffer, list);
+
+		list_del(&dqbuf->list);
+	}
+
+	/* All buffers are now dequeued. */
+	for (i = 0; i < queue->allocated_bufs; i++)
+		queue->buffers[i].buffer.flags = 0;
+
+	queue->queued_bufs = 0;
+	queue->streaming = false;
+	queue->is_capture_last = false;
+
+	mutex_unlock(&session->queues_lock);
+}
+
 /*
  * Macros suitable for defining ioctls with a constant size payload.
  */
@@ -488,6 +620,431 @@ static int virtio_media_try_ext_ctrls(struct file *file, void *fh,
 						    ctrls);
 }
 
+/*
+ * Subscribe/unsubscribe from an event.
+ */
+
+static int
+virtio_media_subscribe_event(struct v4l2_fh *fh,
+			     const struct v4l2_event_subscription *sub)
+{
+	struct video_device *video_dev = fh->vdev;
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	int ret;
+
+	/* First subscribe to the event in the guest. */
+	switch (sub->type) {
+	case V4L2_EVENT_SOURCE_CHANGE:
+		ret = v4l2_src_change_event_subscribe(fh, sub);
+		break;
+	default:
+		ret = v4l2_event_subscribe(fh, sub, 1, NULL);
+		break;
+	}
+	if (ret)
+		return ret;
+
+	/* Then ask the host to signal us these events. */
+	ret = virtio_media_send_w_ioctl(fh, VIDIOC_SUBSCRIBE_EVENT, sub,
+					sizeof(*sub));
+	if (ret < 0) {
+		v4l2_event_unsubscribe(fh, sub);
+		return ret;
+	}
+
+	/*
+	 * Subscribing to an event may result in that event being signaled
+	 * immediately. Process all pending events to make sure we don't
+	 * miss it.
+	 */
+	if (sub->flags & V4L2_EVENT_SUB_FL_SEND_INITIAL)
+		virtio_media_process_events(vv);
+
+	return 0;
+}
+
+static int
+virtio_media_unsubscribe_event(struct v4l2_fh *fh,
+			       const struct v4l2_event_subscription *sub)
+{
+	int ret = virtio_media_send_w_ioctl(fh, VIDIOC_UNSUBSCRIBE_EVENT, sub,
+					sizeof(*sub));
+	if (ret < 0)
+		return ret;
+
+	ret = v4l2_event_unsubscribe(fh, sub);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Streamon/off affect the local queue state.
+ */
+
+static int virtio_media_streamon(struct file *file, void *fh,
+				 enum v4l2_buf_type i)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	int ret;
+
+	if (i > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	ret = virtio_media_send_w_ioctl(vfh, VIDIOC_STREAMON, &i, sizeof(i));
+	if (ret < 0)
+		return ret;
+
+	session->queues[i].streaming = true;
+
+	return 0;
+}
+
+static int virtio_media_streamoff(struct file *file, void *fh,
+				  enum v4l2_buf_type i)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	int ret;
+
+	if (i > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	ret = virtio_media_send_w_ioctl(vfh, VIDIOC_STREAMOFF, &i, sizeof(i));
+	if (ret < 0)
+		return ret;
+
+	virtio_media_clear_queue(session, &session->queues[i]);
+
+	return 0;
+}
+
+/*
+ * Buffer creation/queuing functions deal with the local driver state.
+ */
+
+static int virtio_media_reqbufs(struct file *file, void *fh,
+				struct v4l2_requestbuffers *b)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	struct virtio_media_buffer *buffers = NULL;
+	struct virtio_media_queue_state *queue;
+	int ret;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	if (b->memory == V4L2_MEMORY_USERPTR)
+		return -EINVAL;
+
+	if (b->count > 0) {
+		buffers =
+			vcalloc(b->count, sizeof(struct virtio_media_buffer));
+		if (!buffers)
+			return -ENOMEM;
+	}
+
+	ret = virtio_media_send_wr_ioctl(vfh, VIDIOC_REQBUFS, b, sizeof(*b),
+					 sizeof(*b));
+	if (ret) {
+		vfree(buffers);
+		return ret;
+	}
+
+	queue = &session->queues[b->type];
+
+	/* REQBUFS(0) is an implicit STREAMOFF. */
+	if (b->count == 0)
+		virtio_media_clear_queue(session, queue);
+
+	vfree(queue->buffers);
+	queue->buffers = buffers;
+
+	queue->allocated_bufs = b->count;
+
+	/*
+	 * If a multiplanar queue is successfully used here, this means
+	 * we are using the multiplanar interface.
+	 */
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type))
+		session->uses_mplane = true;
+
+	b->capabilities &= ~V4L2_BUF_CAP_SUPPORTS_USERPTR;
+
+	/* We do not support DMABUF yet. */
+	b->capabilities &= ~V4L2_BUF_CAP_SUPPORTS_DMABUF;
+
+	return 0;
+}
+
+static int virtio_media_querybuf(struct file *file, void *fh,
+				 struct v4l2_buffer *b)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	struct virtio_media_queue_state *queue;
+	struct virtio_media_buffer *buffer;
+
+	int ret = virtio_media_send_buffer_ioctl(vfh, VIDIOC_QUERYBUF, b);
+
+	if (ret)
+		return ret;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	queue = &session->queues[b->type];
+	if (b->index >= queue->allocated_bufs)
+		return -EINVAL;
+
+	buffer = &queue->buffers[b->index];
+	/*
+	 * Set the DONE flag if the buffer is waiting in our own dequeue
+	 * queue.
+	 */
+	b->flags |= (buffer->buffer.flags & V4L2_BUF_FLAG_DONE);
+
+	return 0;
+}
+
+static int virtio_media_create_bufs(struct file *file, void *fh,
+				    struct v4l2_create_buffers *b)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	struct virtio_media_queue_state *queue;
+	struct virtio_media_buffer *buffers = NULL;
+	u32 type = b->format.type;
+	int ret;
+
+	if (type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	queue = &session->queues[type];
+
+	if (b->count > 0) {
+		/*
+		 * This allocates a new buffer large enough for the existing
+		 * buffers (``queue->allocated_bufs``) as well as the newly
+		 * requested buffers (``b->count``). The host may allocate
+		 * fewer buffers than requested, as indicated by the final
+		 * value of ``b->count``. In this case, we do not re-allocate
+		 * to avoid the case where this new allocation fails and the
+		 * host buffers need to be freed. Instead we simply use the
+		 * larger buffer.
+		 */
+		buffers = vcalloc(queue->allocated_bufs + b->count,
+				  sizeof(*queue->buffers));
+		if (!buffers)
+			return -ENOMEM;
+	}
+
+	ret = virtio_media_send_wr_ioctl(vfh, VIDIOC_CREATE_BUFS, b, sizeof(*b),
+					 sizeof(*b));
+	if (ret) {
+		if (buffers)
+			vfree(buffers);
+
+		return ret;
+	}
+
+	/* If count is zero, we were just checking for format. */
+	if (b->count == 0)
+		return 0;
+
+	memcpy(buffers, queue->buffers,
+	       sizeof(*queue->buffers) * queue->allocated_bufs);
+	vfree(queue->buffers);
+	queue->buffers = buffers;
+
+	queue->allocated_bufs = b->index + b->count;
+
+	return 0;
+}
+
+static int virtio_media_prepare_buf(struct file *file, void *fh,
+				    struct v4l2_buffer *b)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	struct virtio_media_queue_state *queue;
+	struct virtio_media_buffer *buffer;
+	int i, ret;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+	queue = &session->queues[b->type];
+	if (b->index >= queue->allocated_bufs)
+		return -EINVAL;
+	buffer = &queue->buffers[b->index];
+
+	buffer->buffer.m = b->m;
+	if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
+		if (b->length > VIDEO_MAX_PLANES)
+			return -EINVAL;
+		for (i = 0; i < b->length; i++)
+			buffer->planes[i].m = b->m.planes[i].m;
+	}
+
+	ret = virtio_media_send_buffer_ioctl(vfh, VIDIOC_PREPARE_BUF, b);
+	if (ret)
+		return ret;
+
+	buffer->buffer.flags = V4L2_BUF_FLAG_PREPARED;
+
+	return 0;
+}
+
+static int virtio_media_qbuf(struct file *file, void *fh, struct v4l2_buffer *b)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+	struct virtio_media_queue_state *queue;
+	struct virtio_media_buffer *buffer;
+	bool prepared;
+	u32 old_flags;
+	int i, ret;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+	queue = &session->queues[b->type];
+	if (b->index >= queue->allocated_bufs)
+		return -EINVAL;
+	buffer = &queue->buffers[b->index];
+	prepared = buffer->buffer.flags & V4L2_BUF_FLAG_PREPARED;
+
+	/*
+	 * Store the buffer and plane `m` information so we can retrieve
+	 * it again when DQBUF occurs.
+	 */
+	if (!prepared) {
+		buffer->buffer.m = b->m;
+		if (V4L2_TYPE_IS_MULTIPLANAR(b->type)) {
+			if (b->length > VIDEO_MAX_PLANES)
+				return -EINVAL;
+			for (i = 0; i < b->length; i++)
+				buffer->planes[i].m = b->m.planes[i].m;
+		}
+	}
+	old_flags = buffer->buffer.flags;
+	buffer->buffer.flags = V4L2_BUF_FLAG_QUEUED;
+
+	ret = virtio_media_send_buffer_ioctl(vfh, VIDIOC_QBUF, b);
+	if (ret) {
+		/* Rollback the previous flags as the buffer is not queued. */
+		buffer->buffer.flags = old_flags;
+		return ret;
+	}
+
+	queue->queued_bufs += 1;
+
+	return 0;
+}
+
+static int virtio_media_dqbuf(struct file *file, void *fh,
+			      struct v4l2_buffer *b)
+{
+	struct video_device *video_dev = video_devdata(file);
+	struct virtio_media *vv = to_virtio_media(video_dev);
+	struct virtio_media_session *session =
+		fh_to_session(file_to_v4l2_fh(file));
+	struct virtio_media_buffer *dqbuf;
+	struct virtio_media_queue_state *queue;
+	struct list_head *buffer_queue;
+	struct v4l2_plane *planes_backup = NULL;
+	const bool is_multiplanar = V4L2_TYPE_IS_MULTIPLANAR(b->type);
+	int ret;
+	bool error;
+
+	if (b->type > VIRTIO_MEDIA_LAST_QUEUE)
+		return -EINVAL;
+
+	queue = &session->queues[b->type];
+
+	/*
+	 * If a buffer with the LAST flag has been returned, subsequent
+	 * calls to DQBUF must return -EPIPE until the queue is cleared.
+	 */
+	if (queue->is_capture_last)
+		return -EPIPE;
+
+	buffer_queue = &queue->pending_dqbufs;
+
+	if (session->nonblocking_dequeue) {
+		if (list_empty(buffer_queue))
+			return -EAGAIN;
+	} else if (queue->allocated_bufs == 0) {
+		return -EINVAL;
+	} else if (!queue->streaming) {
+		return -EINVAL;
+	}
+
+	/*
+	 * vv->lock has been acquired by virtio_media_device_ioctl. Release it
+	 * while we wait so that other ioctls for this session can be processed
+	 * and potentially trigger dqbuf_wait.
+	 */
+	mutex_unlock(&vv->vlock);
+
+	/*
+	 * It's not possible to acquire ``session->error_lock`` during the
+	 * check, however this shouldn't cause issues because:
+	 *     - The lock is acquired when actually checking the value
+	 *     - The ``session->error`` flag is never reset once set
+	 */
+	ret = wait_event_interruptible(session->dqbuf_wait,
+				       !list_empty(buffer_queue) ||
+				       session->error);
+	mutex_lock(&vv->vlock);
+	if (ret)
+		return -EINTR;
+
+	mutex_lock(&session->error_lock);
+	error = session->error;
+	mutex_unlock(&session->error_lock);
+
+	if (error)
+		return -EIO;
+
+	mutex_lock(&session->queues_lock);
+	dqbuf = list_first_entry_or_null(buffer_queue,
+					 struct virtio_media_buffer, list);
+
+	if (dqbuf)
+		list_del(&dqbuf->list);
+
+	mutex_unlock(&session->queues_lock);
+
+	if (!dqbuf) {
+		v4l2_err(&vv->v4l2_dev, "No buffer found when dqbuf event triggered\n");
+		return -EIO;
+	}
+
+	/* Clear the DONE flag as the buffer is now being dequeued. */
+	dqbuf->buffer.flags &= ~V4L2_BUF_FLAG_DONE;
+
+	if (is_multiplanar) {
+		size_t nb_planes = min_t(u32, b->length, VIDEO_MAX_PLANES);
+
+		memcpy(b->m.planes, dqbuf->planes,
+		       nb_planes * sizeof(struct v4l2_plane));
+		planes_backup = b->m.planes;
+	}
+
+	memcpy(b, &dqbuf->buffer, sizeof(*b));
+
+	if (is_multiplanar)
+		b->m.planes = planes_backup;
+
+	if (V4L2_TYPE_IS_CAPTURE(b->type) && b->flags & V4L2_BUF_FLAG_LAST)
+		queue->is_capture_last = true;
+
+	return 0;
+}
+
 /*
  * s/g_input/output work with an unsigned int - recast this to a u32 so the
  * size is unambiguous.
@@ -541,6 +1098,32 @@ static int virtio_media_s_output(struct file *file, void *fh, unsigned int o)
 					  sizeof(output), sizeof(output));
 }
 
+/*
+ * decoder_cmd can affect the state of the CAPTURE queue.
+ */
+
+static int virtio_media_decoder_cmd(struct file *file, void *fh,
+				    struct v4l2_decoder_cmd *cmd)
+{
+	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
+	struct virtio_media_session *session = fh_to_session(vfh);
+
+	int ret = virtio_media_send_wr_ioctl(vfh, VIDIOC_DECODER_CMD, cmd,
+					 sizeof(*cmd), sizeof(*cmd));
+	if (ret)
+		return ret;
+
+	/* A START command makes the CAPTURE queue able to dequeue again. */
+	if (cmd->cmd == V4L2_DEC_CMD_START) {
+		session->queues[V4L2_BUF_TYPE_VIDEO_CAPTURE].is_capture_last =
+			false;
+		session->queues[V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE]
+			.is_capture_last = false;
+	}
+
+	return 0;
+}
+
 /*
  * s_std doesn't work with a pointer, so we cannot use SIMPLE_W_IOCTL.
  */
@@ -616,6 +1199,25 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops = {
 	.vidioc_try_fmt_meta_cap = virtio_media_try_fmt,
 	.vidioc_try_fmt_meta_out = virtio_media_try_fmt,
 
+	/* Buffer handlers */
+	.vidioc_reqbufs = virtio_media_reqbufs,
+	.vidioc_querybuf = virtio_media_querybuf,
+	.vidioc_qbuf = virtio_media_qbuf,
+	.vidioc_expbuf = NULL,
+	.vidioc_dqbuf = virtio_media_dqbuf,
+	.vidioc_create_bufs = virtio_media_create_bufs,
+	.vidioc_prepare_buf = virtio_media_prepare_buf,
+	/* Overlay interface not supported yet */
+	.vidioc_overlay = NULL,
+	/* Overlay interface not supported yet */
+	.vidioc_g_fbuf = NULL,
+	/* Overlay interface not supported yet */
+	.vidioc_s_fbuf = NULL,
+
+	/* Stream on/off */
+	.vidioc_streamon = virtio_media_streamon,
+	.vidioc_streamoff = virtio_media_streamoff,
+
 	/* Standard handling */
 	.vidioc_g_std = virtio_media_g_std,
 	.vidioc_s_std = virtio_media_s_std,
@@ -667,6 +1269,7 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops = {
 	.vidioc_g_enc_index = virtio_media_g_enc_index,
 	.vidioc_encoder_cmd = virtio_media_encoder_cmd,
 	.vidioc_try_encoder_cmd = virtio_media_try_encoder_cmd,
+	.vidioc_decoder_cmd = virtio_media_decoder_cmd,
 	.vidioc_try_decoder_cmd = virtio_media_try_decoder_cmd,
 
 	/* Stream type-dependent parameter ioctls */
@@ -701,6 +1304,9 @@ const struct v4l2_ioctl_ops virtio_media_ioctl_ops = {
 	.vidioc_g_edid = NULL,
 	.vidioc_s_edid = NULL,
 
+	.vidioc_subscribe_event = virtio_media_subscribe_event,
+	.vidioc_unsubscribe_event = virtio_media_unsubscribe_event,
+
 	/* For other private ioctls */
 	.vidioc_default = NULL,
 };
@@ -714,9 +1320,19 @@ long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
 	struct v4l2_standard standard;
 	v4l2_std_id std_id = 0;
 	int ret;
+	bool error;
 
-	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
+	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags)) {
 		vfh = file_to_v4l2_fh(file);
+		struct virtio_media_session *session = fh_to_session(vfh);
+
+		mutex_lock(&session->error_lock);
+		error = session->error;
+		mutex_unlock(&session->error_lock);
+
+		if (error)
+			return -EIO;
+	}
 
 	mutex_lock(&vv->vlock);
 
diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/linux/virtio_media.h
index f117b97fc..da5c5baf0 100644
--- a/include/uapi/linux/virtio_media.h
+++ b/include/uapi/linux/virtio_media.h
@@ -171,4 +171,72 @@ struct virtio_media_sg_entry {
 	__le32 __reserved;
 };
 
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
+	__le32 event;
+	__le32 session_id;
+};
+
+/**
+ * struct virtio_media_event_error - Unrecoverable device-side error.
+ * @hdr: header for the event.
+ * @error: error code describing the kind of error that occurred.
+ * @__reserved: must be set to zero by the device.
+ *
+ * Upon receiving this event, the session mentioned in the header is considered
+ * corrupted and closed.
+ */
+struct virtio_media_event_error {
+	struct virtio_media_event_header hdr;
+	__le32 error;
+	__le32 __reserved;
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
 #endif // _UAPI__LINUX_VIRTIO_MEDIA_H
-- 
2.56.1.750.gf70dc682cf-goog

