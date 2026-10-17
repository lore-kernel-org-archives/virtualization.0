Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6D3EC687
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216120; cv=none; b=MROOjgWZ7YzLqAad8LZEMk0DQGmhrxsoNnkKtVGJywEovSwdOYzVUjYJBaq0A3uLy+9KPgDZHXkVC9fLE0XudmLKcdMui2FH8u69TgB2InoYHuoKnM74kr/NFwOeogDcQSRiukf266t2Wrn/CUbVozewQYgflQSUWUuUngEYeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216120; c=relaxed/simple;
	bh=9fMyyGKTkQEAoDsumbngQp/WWiqq6Jh+va+HSuzquvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVkgP0eWPrxBKYF+d73k08YuvVt4QrXw4bQmvNDc2FdGmSeHbuDgSXzf96vBWudxDp6FmTRYd2zQTqk6anVtwc177O+ek5B+Sm+o2vJda4WFbTIBgpaxuUd9jg1KFqXhZgCZNf5JoTaouD8Yf2Th2qBJtvmGCSFZ2OdHH8kJKdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV9bzCV1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV9bzCV1"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso587565a91.3
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216118; x=1792820918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jL0842hIhQyR5Dge1RIRz6LTLe0BpYG83ykXATA9X5o=;
        b=pV9bzCV1L+6hVunTXgiqE1RG6dP8Fx+K+mzAkYVBaK4qkVPzkp4j9tRNfXqiK0VbJM
         RdcE+B2FLuDJMGg8dJKeUzsP848jbIVomzpms1JKu6ubzhbSpeB2Uhd4qy1GU+bHvfKb
         XNacMoosVKNwFZJGU1pI24r2M5wEG7KFSPGJ7GEZAmlzUFhdN8a5SFDhk66XXeajLmPz
         VF+6x1DkIMwCwJcsx5D7WH0HcPOsdGpxXvdhc33FzTi2Guv9VeIu/wV8Oxg7yIo4EMiV
         ydxYWUwGu21+Ef1UDO2hzOmHwqB4llcrXG2jj/uY2aEsrDVeVZ3th0BIRFKDMbDRRx0N
         KSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216118; x=1792820918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jL0842hIhQyR5Dge1RIRz6LTLe0BpYG83ykXATA9X5o=;
        b=tZgarwa7aBSonosNSqmCCWSH/vJKmfMr6QMY8oQKe893xb9bF84VGMkMvnt5ASQobw
         GnF2wsIu0FVFOgaPWaqq8h9Sw4fQ+eyLunlG8JeprVFUZ2XvVNQ6OFO/4O8dFNZ+VdGH
         /aDJmM3EFerhIG9QSfJWxlvhMjZAKWg677HW8N9ZixVYx2nK0ZvhUQ4HJSVcsVCmEZsL
         esucCy7rXZWnxDsV2MQy/Wddhbriq8oHGdcCRy3IuapH4h7XTKNkBe8/ohFpYyb+o4TD
         nF+ydWj/Rvoff2yGq0DV4EuLrZpIbFez6mWDvrU5Gdve1qJKaH1Lx06ZluoObNyA3MXB
         mZVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZQG+YLUr7TOJ+q2jqHKjoZTg5hA714/kh7bgggui0OuaKtKe7W3ZSgEdVWcPg/nN/9Ohn9ojo71rUEpHbng==@lists.linux.dev
X-Gm-Message-State: AFq9FYLasRQe2qOsPz9pvcQCgscncx9T/7IbvBLviN4SSw7L+V4xVFc3
	5yXhbIi4Qt/R4fDk5OsASOtBpwzVVfegxK2zq6pDm4uKy3t5BFOGcXo3
X-Gm-Gg: AYBFou0tp8KV/QqXg4ZJ++g8I1Xif/hhe88QYReIi4KTaGedh9mj6YhhYVxbAMcYweT
	8VzMA71Rq30H0I5vjJWy3C6nrynnZ+uIMrCDx4+QSVia3VExhO7UvswQ7ENLhp7n6Zmt9o8qZRJ
	QEPrtpS/VYaQd4LY9iLPsWjBSmyauNJZlfmtJvs0apTl80uZnKd1xOIfsj/pj5/KwXptBQEMupM
	4GF/mTPThB7cJpJXUjW6OeNkGnxNFAg2fc38b/4JofR2phSNveU+0LZ+qVXDa9A5rn5zPigBdPR
	ruSzPGBIcnHZ35vejS/Y+ez9JarMLipmE74BTAfjfhh45VKFNy/7Dsz0ngCPPd6pTg64rBbBHCS
	c+UHW3vZ04iddzG0d+14+259gvjh0d6ZDwhRFvTv1vueGrlYHM5bJzXPyDSv+sBD8GOqF/sW63Y
	M8GB0VvbYr+MDgwmuSLudKhUFFEaYNXEZ0tC5NYV7tnGdGQ7bsC8S5i8FGYNzh7jmvWaw29RYmj
	GwzW0vS6NihkcNx3wfg5QeLXYHkYqMbNxtlCL7PB0OgW3JZ1VgG+nS7MgHhtUYPpdHAgFSDGQcx
	qBz9b8wF20xA3cqctHgumxgF
X-Received: by 2002:a17:90b:4d82:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3acee728a94mr1661012a91.8.1792216118185;
        Fri, 16 Oct 2026 22:48:38 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm13570028a91.9.2026.10.16.22.48.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 22:48:37 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/1] ALSA: virtio: trace control message lifecycles
Date: Sat, 17 Oct 2026 14:48:32 +0900
Message-ID: <rfc-v2-virtio-snd-control-trace-1.60ead383067a41ae@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <rfc-v2-virtio-snd-control-trace-0.60ead383067a41ae@gmail.com>
References: <rfc-v2-virtio-snd-control-trace-0.60ead383067a41ae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timed-out control request can complete later or be canceled during
teardown. The existing opcode-only timeout message does not identify the
request or show when the queue gives it back, which makes it difficult to
correlate control stalls with guest scheduling and device reset activity.

Add a virtio_snd_ctl_msg trace event with a per-send identifier and phases
for enqueue, response, cancellation and the sender's wait outcome. Record
PCM stream IDs where the request layout supplies one, the enqueue or wait
result, and the device's used length and response status. Mark optional
fields explicitly and check the writable response capacity before reading
a status for the event.

Assign IDs only to requests sent while the event is enabled. Keep sender
wait outcomes separate from queue completion so a timeout followed by a
late response retains the same ID. Include neither audio data nor kernel
addresses in the event.

Leave protocol results, request ownership and timeout handling unchanged.
The added fields increase each control-message structure by 24 bytes on
the tested ARM64 configurations, including when tracing is disabled. No
events are added to PCM data completions.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v2:
- Group internal helper event arguments in struct virtsnd_ctl_event.
- Use designated initializers and named validity flags instead of positional
  booleans. Keep TRACE_EVENT and its record format unchanged.

 sound/virtio/Makefile               |   2 +
 sound/virtio/virtio_ctl_msg.c       | 178 +++++++++++++++++++++++++++++++++++-
 sound/virtio/virtio_ctl_msg_trace.h | 107 ++++++++++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 3ca41b3c8..3db8ad687 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -2,6 +2,8 @@
 
 obj-$(CONFIG_SND_VIRTIO) += virtio_snd.o
 
+CFLAGS_virtio_ctl_msg.o := -I$(src)
+
 virtio_snd-y := \
 	virtio_card.o \
 	virtio_chmap.o \
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 6433c870f..4cac9aa0d 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -3,11 +3,16 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/device.h>
+#include <linux/limits.h>
 #include <linux/moduleparam.h>
 #include <linux/virtio_config.h>
 
 #include "virtio_card.h"
 
+#define CREATE_TRACE_POINTS
+#include "virtio_ctl_msg_trace.h"
+
 /**
  * struct virtio_snd_msg - Control message.
  * @sg_request: Scattergather list containing a device request (header).
@@ -15,6 +20,13 @@
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
+ * @trace_id: Stable identifier for tracing this request lifecycle.
+ * @trace_opcode: Decoded request opcode for tracing.
+ * @trace_stream_id: Decoded PCM stream identifier for tracing.
+ * @trace_response_capacity: Cached capacity of writable response buffers.
+ * @trace_opcode_valid: Whether @trace_opcode was decoded from the request.
+ * @trace_stream_id_valid: Whether @trace_stream_id was decoded safely.
+ * @trace_canceled: Whether teardown canceled this request.
  */
 struct virtio_snd_msg {
 	struct scatterlist sg_request;
@@ -22,8 +34,111 @@ struct virtio_snd_msg {
 	struct list_head list;
 	struct completion notify;
 	refcount_t ref_count;
+	u64 trace_id;
+	u32 trace_opcode;
+	u32 trace_stream_id;
+	u32 trace_response_capacity;
+	bool trace_opcode_valid;
+	bool trace_stream_id_valid;
+	bool trace_canceled;
+};
+
+static atomic64_t virtsnd_ctl_msg_trace_id = ATOMIC64_INIT(0);
+
+/* Per-event values; request-lifetime metadata stays in virtio_snd_msg. */
+struct virtsnd_ctl_event {
+	u8 phase;
+	u8 outcome;
+	u8 flags;
+	int result;
+	u32 used_len;
+	u32 status;
 };
 
+static inline void virtsnd_ctl_msg_trace(struct virtio_snd *snd,
+					 struct virtio_snd_msg *msg,
+					 const struct virtsnd_ctl_event *event)
+{
+	u8 flags;
+
+	if (!msg->trace_id)
+		return;
+
+	flags = event->flags;
+	if (msg->trace_opcode_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_OPCODE;
+	if (msg->trace_stream_id_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_STREAM_ID;
+
+	trace_virtio_snd_ctl_msg(dev_name(&snd->vdev->dev), msg->trace_id,
+				 event->phase, event->outcome, flags,
+				 msg->trace_opcode, msg->trace_stream_id,
+				 event->result, event->used_len, event->status);
+}
+
+static u32 virtsnd_ctl_msg_trace_capacity(struct virtio_snd_msg *msg,
+					  struct scatterlist *in_sgs)
+{
+	struct scatterlist *sg;
+	u32 capacity = msg->sg_response.length;
+
+	for (sg = in_sgs; sg; sg = sg_next(sg)) {
+		if (capacity > U32_MAX - sg->length)
+			return U32_MAX;
+
+		capacity += sg->length;
+	}
+
+	return capacity;
+}
+
+static void virtsnd_ctl_msg_trace_prepare(struct virtio_snd_msg *msg,
+					  struct virtio_snd_hdr *request,
+					  struct scatterlist *in_sgs)
+{
+	struct virtio_snd_pcm_hdr *pcm_request = (void *)request;
+	size_t request_size;
+	u32 opcode;
+
+	msg->trace_id = 0;
+	msg->trace_canceled = false;
+
+	if (!trace_virtio_snd_ctl_msg_enabled())
+		return;
+
+	request_size = msg->sg_request.length;
+	msg->trace_opcode = 0;
+	msg->trace_stream_id = 0;
+	msg->trace_response_capacity =
+		virtsnd_ctl_msg_trace_capacity(msg, in_sgs);
+	msg->trace_opcode_valid = false;
+	msg->trace_stream_id_valid = false;
+
+	msg->trace_id = atomic64_inc_return(&virtsnd_ctl_msg_trace_id);
+	if (request_size < sizeof(*request))
+		return;
+
+	opcode = le32_to_cpu(request->code);
+	msg->trace_opcode = opcode;
+	msg->trace_opcode_valid = true;
+
+	if (request_size < sizeof(struct virtio_snd_pcm_hdr))
+		return;
+
+	switch (opcode) {
+	case VIRTIO_SND_R_PCM_SET_PARAMS:
+	case VIRTIO_SND_R_PCM_PREPARE:
+	case VIRTIO_SND_R_PCM_RELEASE:
+	case VIRTIO_SND_R_PCM_START:
+	case VIRTIO_SND_R_PCM_STOP:
+		msg->trace_stream_id = le32_to_cpu(pcm_request->stream_id);
+		msg->trace_stream_id_valid = true;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
  * @msg: Control message.
@@ -134,6 +249,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	int rc;
 
 	virtsnd_ctl_msg_ref(msg);
+	virtsnd_ctl_msg_trace_prepare(msg, request, in_sgs);
 
 	/* Set the default status in case the message was canceled. */
 	response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
@@ -154,6 +270,18 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 
 			list_add_tail(&msg->list, &snd->ctl_msgs);
 		}
+
+		virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+			.phase = VIRTSND_CTL_TRACE_ENQUEUE,
+			.outcome = VIRTSND_CTL_TRACE_OUTCOME_NONE,
+			.flags = VIRTSND_CTL_TRACE_VALID_RESULT,
+			.result = rc,
+		});
+		if (!rc && nowait)
+			virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+				.phase = VIRTSND_CTL_TRACE_WAIT,
+				.outcome = VIRTSND_CTL_TRACE_OUTCOME_ASYNC,
+			});
 	}
 
 	if (rc) {
@@ -182,6 +310,19 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 				"control message (0x%08x) timeout\n",
 				le32_to_cpu(request->code));
 			rc = -ETIMEDOUT;
+			virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+				.phase = VIRTSND_CTL_TRACE_WAIT,
+				.outcome = VIRTSND_CTL_TRACE_OUTCOME_TIMEOUT,
+				.flags = VIRTSND_CTL_TRACE_VALID_RESULT,
+				.result = rc,
+			});
+		} else {
+			virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+				.phase = VIRTSND_CTL_TRACE_WAIT,
+				.outcome = VIRTSND_CTL_TRACE_OUTCOME_SIGNAL,
+				.flags = VIRTSND_CTL_TRACE_VALID_RESULT,
+				.result = rc,
+			});
 		}
 
 		goto on_exit;
@@ -202,6 +343,15 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		break;
 	}
 
+	virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+		.phase = VIRTSND_CTL_TRACE_WAIT,
+		.outcome = READ_ONCE(msg->trace_canceled) ?
+			VIRTSND_CTL_TRACE_OUTCOME_CANCEL :
+			VIRTSND_CTL_TRACE_OUTCOME_RESPONSE,
+		.flags = VIRTSND_CTL_TRACE_VALID_RESULT,
+		.result = rc,
+	});
+
 on_exit:
 	virtsnd_ctl_msg_unref(msg);
 
@@ -239,6 +389,11 @@ void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
 			list_first_entry(&snd->ctl_msgs, struct virtio_snd_msg,
 					 list);
 
+		WRITE_ONCE(msg->trace_canceled, true);
+		virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+			.phase = VIRTSND_CTL_TRACE_CANCEL,
+			.outcome = VIRTSND_CTL_TRACE_OUTCOME_CANCEL,
+		});
 		virtsnd_ctl_msg_complete(msg);
 	}
 }
@@ -297,7 +452,28 @@ void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
 	guard(spinlock_irqsave)(&queue->lock);
 	do {
 		virtqueue_disable_cb(vqueue);
-		while ((msg = virtqueue_get_buf(vqueue, &length)))
+		while ((msg = virtqueue_get_buf(vqueue, &length))) {
+			struct virtio_snd_hdr *response =
+				virtsnd_ctl_msg_response(msg);
+
+			if (trace_virtio_snd_ctl_msg_enabled() && msg->trace_id) {
+				bool status_valid =
+					msg->sg_response.length >= sizeof(*response) &&
+					length >= sizeof(*response) &&
+					length <= msg->trace_response_capacity;
+				u32 status = status_valid ?
+					le32_to_cpu(response->code) : 0;
+
+				virtsnd_ctl_msg_trace(snd, msg, &(const struct virtsnd_ctl_event) {
+					.phase = VIRTSND_CTL_TRACE_RESPONSE,
+					.outcome = VIRTSND_CTL_TRACE_OUTCOME_NONE,
+					.flags = status_valid ?
+						VIRTSND_CTL_TRACE_VALID_STATUS : 0,
+					.used_len = length,
+					.status = status,
+				});
+			}
 			virtsnd_ctl_msg_complete(msg);
+		}
 	} while (!virtqueue_enable_cb(vqueue));
 }
diff --git a/sound/virtio/virtio_ctl_msg_trace.h b/sound/virtio/virtio_ctl_msg_trace.h
new file mode 100644
index 000000000..d6d9e9a04
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg_trace.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM virtio_snd
+
+#if !defined(_TRACE_VIRTIO_SND_CTL_MSG_H) || \
+	defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_VIRTIO_SND_CTL_MSG_H
+
+#include <linux/tracepoint.h>
+
+#define VIRTSND_CTL_TRACE_ENQUEUE		0
+#define VIRTSND_CTL_TRACE_RESPONSE		1
+#define VIRTSND_CTL_TRACE_CANCEL		2
+#define VIRTSND_CTL_TRACE_WAIT			3
+
+#define VIRTSND_CTL_TRACE_OUTCOME_NONE		0
+#define VIRTSND_CTL_TRACE_OUTCOME_ASYNC		1
+#define VIRTSND_CTL_TRACE_OUTCOME_RESPONSE	2
+#define VIRTSND_CTL_TRACE_OUTCOME_CANCEL	3
+#define VIRTSND_CTL_TRACE_OUTCOME_TIMEOUT	4
+#define VIRTSND_CTL_TRACE_OUTCOME_SIGNAL		5
+
+#define VIRTSND_CTL_TRACE_VALID_OPCODE		0x01
+#define VIRTSND_CTL_TRACE_VALID_STREAM_ID	0x02
+#define VIRTSND_CTL_TRACE_VALID_RESULT		0x04
+#define VIRTSND_CTL_TRACE_VALID_STATUS		0x08
+
+/*
+ * An ID identifies one send during this module's lifetime. Only requests sent
+ * while this event is enabled receive an ID. Enabling it during an existing
+ * request therefore does not produce a partial lifecycle for that request.
+ *
+ * A wait event describes the sender's return; response and cancel describe
+ * queue ownership ending. A timeout or signal can precede a later response.
+ * Invalid fields contain zero and must be interpreted using their valid flag.
+ */
+TRACE_EVENT(virtio_snd_ctl_msg,
+
+	TP_PROTO(const char *device, u64 request_id, u8 phase, u8 outcome,
+		 u8 flags, u32 opcode, u32 stream_id, int result,
+		 u32 used_len, u32 status),
+
+	TP_ARGS(device, request_id, phase, outcome, flags, opcode, stream_id,
+		result, used_len, status),
+
+	TP_STRUCT__entry(
+		__string(device, device)
+		__field(u64, request_id)
+		__field(u8, phase)
+		__field(u8, outcome)
+		__field(bool, opcode_valid)
+		__field(u32, opcode)
+		__field(bool, stream_id_valid)
+		__field(u32, stream_id)
+		__field(int, result)
+		__field(bool, result_valid)
+		__field(u32, used_len)
+		__field(bool, status_valid)
+		__field(u32, status)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->request_id = request_id;
+		__entry->phase = phase;
+		__entry->outcome = outcome;
+		__entry->opcode_valid = flags & VIRTSND_CTL_TRACE_VALID_OPCODE;
+		__entry->opcode = opcode;
+		__entry->stream_id_valid =
+			flags & VIRTSND_CTL_TRACE_VALID_STREAM_ID;
+		__entry->stream_id = stream_id;
+		__entry->result = result;
+		__entry->result_valid = flags & VIRTSND_CTL_TRACE_VALID_RESULT;
+		__entry->used_len = used_len;
+		__entry->status_valid = flags & VIRTSND_CTL_TRACE_VALID_STATUS;
+		__entry->status = status;
+	),
+
+	TP_printk("device=%s id=%llu phase=%s outcome=%s opcode_valid=%d opcode=0x%08x stream_id_valid=%d stream_id=%u result_valid=%d result=%d used_len=%u status_valid=%d status=0x%08x",
+		  __get_str(device),
+		  (unsigned long long)__entry->request_id,
+		  __print_symbolic(__entry->phase,
+				   { VIRTSND_CTL_TRACE_ENQUEUE, "enqueue" },
+				   { VIRTSND_CTL_TRACE_RESPONSE, "response" },
+				   { VIRTSND_CTL_TRACE_CANCEL, "cancel" },
+				   { VIRTSND_CTL_TRACE_WAIT, "wait" }),
+		  __print_symbolic(__entry->outcome,
+				   { VIRTSND_CTL_TRACE_OUTCOME_NONE, "none" },
+				   { VIRTSND_CTL_TRACE_OUTCOME_ASYNC, "async" },
+				   { VIRTSND_CTL_TRACE_OUTCOME_RESPONSE, "response" },
+				   { VIRTSND_CTL_TRACE_OUTCOME_CANCEL, "cancel" },
+				   { VIRTSND_CTL_TRACE_OUTCOME_TIMEOUT, "timeout" },
+				   { VIRTSND_CTL_TRACE_OUTCOME_SIGNAL, "signal" }),
+		  __entry->opcode_valid, __entry->opcode,
+		  __entry->stream_id_valid, __entry->stream_id,
+		  __entry->result_valid, __entry->result, __entry->used_len,
+		  __entry->status_valid, __entry->status)
+);
+
+#endif /* _TRACE_VIRTIO_SND_CTL_MSG_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE virtio_ctl_msg_trace
+#include <trace/define_trace.h>
-- 
2.50.1
