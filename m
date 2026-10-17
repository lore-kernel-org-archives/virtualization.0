Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301103B1022
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214138; cv=none; b=n1ZqzKf/V2sHo80VTBtc1r2OrSHul1il0IQpfD5jOPNhWgKl8frpkKhAToB2pNalY0UM5ze4QQGsSRkk/mJ2ig8uMjJlDKR6oC2oj8fhHIk5K4l+Ud1EUytPu9n3m/w8MFrXzKb0/WE2AgW/ze45Lp/1x/zou+m2sK92ssZOltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214138; c=relaxed/simple;
	bh=fJtyW6jvYZa/dlU0oJ51KK5cyQgUqa3RtIFwFRfkNYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPxbHEaWF06gUQ8DcX41R0PkbzBRV+r2GKs7BwqvQgTWBPdHC7kdhKEdCjwdVrbPF9Wz4WrrZ/IY0LsUVYxeYBp+KKLTf2V17usbxqS/wxBKDh9YZPZ/PTawKj3/Do++JkVBh4HEuO/6do742Sb7FSTEGzP8YeyKTfX+lWQLnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2Mzb6oH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2Mzb6oH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so404141a91.0
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214135; x=1792818935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rSHUTEwOJI4HlGZK9jxBDpxTLm+vRc1mjOw8hYfpDX8=;
        b=a2Mzb6oHL2I7EBeu16ZwS5UFHM0aEcKOLKxNdMj/C0D46T3Nj8AacMC0fTmniNpUfh
         L3/HlZ6hqDUrbnqpShV53MX/z/axqPjea97HZPLjQa2anhsdswfuAw/l7NSmzooKomZh
         f4zPkPssnzjjty177noo1CnxNZ1bNs20964LnGZQEfdy3vXeNV2+LGMD6gOLluRNHZGp
         tn0K0dRqC9h1hYV+8zNyhgDTwx/8/2PHCsYeJX1PbLe1lyoBlS0gMSQz5rFDhjCZkojt
         Tgq9t4+X+lDBn3q20Y2nVVxlvSwzvPMezKpfBKLKJYXilVHEIE0aWshMQnoakXPvd0kO
         9Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214135; x=1792818935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rSHUTEwOJI4HlGZK9jxBDpxTLm+vRc1mjOw8hYfpDX8=;
        b=rlk+bsUk4ZTwTJCzrAC3FNt+TJDwVRpXvTK1+Gqoj+BhupcXKrtxdmdBvdXkwT6VQT
         0yG6x9uXUxF26IYXQYZyCNylBxjT2i+dV5oAhLkm1s1kWE2+VIvjVycobaBmWN8srOJb
         yCbe3mqK8Zzq/RVCkmjJqfTX3cNLaFpkGbqQ1IZxGBHNAwy4HWEF7cPUbwn8sBRsfnnN
         hjJPks7SleQc0aMJ0iMht3F/wdfbGm56ry7DFgtebuKDGXwaMipc/GJrGYoxFVJnOZmT
         JYM1mIkFoPCfjEVjXYEQEnLe74ZKNvKb8kC7LD45XFZ1I4aGY9hS88eDEsSD7cxUDN8C
         X5OQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8B1W5508t15ZWxvD1nJTRSwpp0DQqgiQKxdEg92ZXbWCBysUQeqOeAfgNbKuCZ53TqeSABhWwiKRXnDYRiA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKusPvOJ0yo6O+OOYaS9a+75nsmCYU221XLIvf/xk5lCht2KyEq
	qT0RW1pizPbach9qL1mq3vwcRAqz7kqsA/41HvNboo4qgWU4WmNPfFWB
X-Gm-Gg: AYBFou1HRiPbzCTwFBTNxVK5YuiINrT9NOyFdEgnhcLEgXi9r7j+mM2vCigEUPPWFi3
	FfAFWmFAjCCVgdrEebPKvg4fM5fDOZJegcEY1Bs+GgMbBt57DsfugCdCL8fmljn/J4gb2JvbvYw
	KaDFFTnwA4QFigl3/ItRjBPd6rmSDETz1nKyqKZa65WcA2xaoCpsyndRKroJT+6U8d3bGcKP83u
	W4YWZt2XDi/eglxFGsAcgBdcGBe2fs3k+fO/vAzie6x0HAY5UfhmPJDjNkjiiiYZIlI3zHId/SH
	QXtnxih03flYp6hVNqHNfGqKcDOUuGyLix7DZWISMAMC6cbIUrh7FifM75V7xhnmljYXTvE6K6w
	9gG2TA9GOd2UClxilZhWhQg+AJLHDnpDt2QBLkCYgEKTFmsafDhdtIBVahsHdN6wAJlduQ1pkHC
	ykC2b/nrNBO0O9FZxCKkplBaqu1YaZpo0xUFLV83gZQH/j9hzTsgfyIrKBKQsi2YbnbXOKdQEIF
	9mVWYqvSB0DUTNflYUNl3H9HQcCS9BtIEqO9S+iJGpXJjC+mmieZNTudUPxUbK0LG2pmA+/SiDX
	X8WpoFWR4dLzouE=
X-Received: by 2002:a17:90a:fc48:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3acef135327mr1217823a91.19.1792214135306;
        Fri, 16 Oct 2026 22:15:35 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm7443575a91.0.2026.10.16.22.15.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 22:15:34 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] ALSA: virtio: trace control message lifecycles
Date: Sat, 17 Oct 2026 14:15:27 +0900
Message-ID: <rfc-virtio-snd-control-trace-1.208f05ae8ea44e77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <rfc-virtio-snd-control-trace-0.208f05ae8ea44e77@gmail.com>
References: <rfc-virtio-snd-control-trace-0.208f05ae8ea44e77@gmail.com>
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
Fault-injection validation uses a test-only caller and QEMU backend overlay,
separate from this patch. It covers unknown status, used lengths below the
header and above writable capacity, actual virtqueue -ENOSPC, asynchronous
completion and a SIGUSR1-interrupted wait followed by a late response.
Subsequent queries, capture/reopen at 4,096 frames, and playback recover.
Two boots each of baseline, feature trace-off and feature trace-on passed
42 fault scenarios, with 280 events per trace-on run and no trace loss.
KASAN and lockdep reported no diagnostics.

The malformed-length fixture safely writes a full success response before
reporting the bad length. Existing send semantics return success; the event
reports status_valid=0/status=0. This is diagnostic coverage, with no change
to the driver's response-validation policy. Unknown status 0xdeadbeef is
length-valid and appears unchanged in the event; the sender returns -EINVAL.

 sound/virtio/Makefile               |   2 +
 sound/virtio/virtio_ctl_msg.c       | 156 +++++++++++++++++++++++++++-
 sound/virtio/virtio_ctl_msg_trace.h | 107 +++++++++++++++++++
 3 files changed, 264 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_ctl_msg_trace.h

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
index 6433c870f..2d52c2050 100644
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
@@ -22,8 +34,105 @@ struct virtio_snd_msg {
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
 };
 
+static atomic64_t virtsnd_ctl_msg_trace_id = ATOMIC64_INIT(0);
+
+static void virtsnd_ctl_msg_trace(struct virtio_snd *snd,
+				  struct virtio_snd_msg *msg, u8 phase,
+				  u8 outcome, int result,
+				  bool result_valid, u32 used_len,
+				  bool status_valid, u32 status)
+{
+	u8 flags = 0;
+
+	if (!msg->trace_id)
+		return;
+
+	if (msg->trace_opcode_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_OPCODE;
+	if (msg->trace_stream_id_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_STREAM_ID;
+	if (result_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_RESULT;
+	if (status_valid)
+		flags |= VIRTSND_CTL_TRACE_VALID_STATUS;
+
+	trace_virtio_snd_ctl_msg(dev_name(&snd->vdev->dev), msg->trace_id,
+				 phase, outcome, flags, msg->trace_opcode,
+				 msg->trace_stream_id, result, used_len, status);
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
@@ -134,6 +243,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	int rc;
 
 	virtsnd_ctl_msg_ref(msg);
+	virtsnd_ctl_msg_trace_prepare(msg, request, in_sgs);
 
 	/* Set the default status in case the message was canceled. */
 	response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
@@ -154,6 +264,15 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 
 			list_add_tail(&msg->list, &snd->ctl_msgs);
 		}
+
+		virtsnd_ctl_msg_trace(snd, msg, VIRTSND_CTL_TRACE_ENQUEUE,
+				      VIRTSND_CTL_TRACE_OUTCOME_NONE, rc, true, 0,
+				      false, 0);
+		if (!rc && nowait)
+			virtsnd_ctl_msg_trace(snd, msg,
+					      VIRTSND_CTL_TRACE_WAIT,
+					      VIRTSND_CTL_TRACE_OUTCOME_ASYNC, 0,
+					      false, 0, false, 0);
 	}
 
 	if (rc) {
@@ -182,6 +301,13 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 				"control message (0x%08x) timeout\n",
 				le32_to_cpu(request->code));
 			rc = -ETIMEDOUT;
+			virtsnd_ctl_msg_trace(snd, msg, VIRTSND_CTL_TRACE_WAIT,
+					      VIRTSND_CTL_TRACE_OUTCOME_TIMEOUT,
+					      rc, true, 0, false, 0);
+		} else {
+			virtsnd_ctl_msg_trace(snd, msg, VIRTSND_CTL_TRACE_WAIT,
+					      VIRTSND_CTL_TRACE_OUTCOME_SIGNAL,
+					      rc, true, 0, false, 0);
 		}
 
 		goto on_exit;
@@ -202,6 +328,12 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		break;
 	}
 
+	virtsnd_ctl_msg_trace(snd, msg, VIRTSND_CTL_TRACE_WAIT,
+			      READ_ONCE(msg->trace_canceled) ?
+			      VIRTSND_CTL_TRACE_OUTCOME_CANCEL :
+			      VIRTSND_CTL_TRACE_OUTCOME_RESPONSE,
+			      rc, true, 0, false, 0);
+
 on_exit:
 	virtsnd_ctl_msg_unref(msg);
 
@@ -239,6 +371,10 @@ void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd)
 			list_first_entry(&snd->ctl_msgs, struct virtio_snd_msg,
 					 list);
 
+		WRITE_ONCE(msg->trace_canceled, true);
+		virtsnd_ctl_msg_trace(snd, msg, VIRTSND_CTL_TRACE_CANCEL,
+				      VIRTSND_CTL_TRACE_OUTCOME_CANCEL, 0,
+				      false, 0, false, 0);
 		virtsnd_ctl_msg_complete(msg);
 	}
 }
@@ -297,7 +433,25 @@ void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
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
+				virtsnd_ctl_msg_trace(snd, msg,
+						      VIRTSND_CTL_TRACE_RESPONSE,
+						      VIRTSND_CTL_TRACE_OUTCOME_NONE,
+						      0, false, length, status_valid,
+						      status);
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
