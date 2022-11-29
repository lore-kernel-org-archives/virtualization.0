Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616CBC4332F
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 17:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9A8E4015E;
	Tue, 29 Nov 2022 17:43:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9A8E4015E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ZjD8MZVq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F37JWHGIJTfW; Tue, 29 Nov 2022 17:43:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55B49400F6;
	Tue, 29 Nov 2022 17:43:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55B49400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28F92C0033;
	Tue, 29 Nov 2022 17:43:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54207C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21F1F80BE1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:43:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21F1F80BE1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=ZjD8MZVq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jAnHLM1ZPdX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:43:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A04580B7E
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A04580B7E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 17:43:39 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id d3so9156844plr.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iXCWILef2PDcL9sLeguo1E8rwfZJ6oNabKhO5H8Gxiw=;
 b=ZjD8MZVqQwGAMlT9t2izaMXVJU8jMqvIKuBePdb/fltwaex9aK3k0K8d5CtmYAz0oZ
 Gd4jdz46JxqNygZsNz6S4b+QNLWJye/YbdS0LdoNT8mqHc1Nfrum+jrRPAx5EIqux9IG
 Pc0zyGudAO5hqgWlNNl9liAX3ezO7n3sVyZn8OubwAHBVY/zjwi7+d+l9akgFsHSKrxl
 TKW7OZ1VTC05I96JDWw5aNhktRLGiDUci7iS/qPAwwJqoI8odrJQxdry9ItLS98eUfI5
 AmORBuSvMHZGSR6s67R/CqdEg+nXn2EJPRgmCMWl6tjFhqN6Bxg7Doz/yJAVbVcoSnMT
 d8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXCWILef2PDcL9sLeguo1E8rwfZJ6oNabKhO5H8Gxiw=;
 b=4a7SFHqDSwiIhc2fmTTpurkjEbH+lNeuRbupqmakAV/e8RNfI97IiM1jJsRlr12EOR
 ctxQuHubvfAGDA1iwPvmxYpuYCGcVexZQAbg/edq2X2J3b8QNpqgMKvi5VLPyavxQ52I
 3l0tvu/Jlsm8U+oQPYTLRZNlLHpczAd3Oll3ZTVu+0ajLrcEti1UgId6V0w7Ihk3QNFf
 ThENvE6N+Jv8NwLa91IYfSBWQWpRDsX9E1BqghIhMgfG+/jMZQ6lZbqo5RSGKOl+zTae
 JkSjRl8unSwOBe+XFPsKbfJLUOmqLWv21arrvr5sOIKW/gtxCNs3dcE751/5DZtMYUye
 eYyA==
X-Gm-Message-State: ANoB5plmA5RspCjsPWwi3W7NBpcwgSSJa9XlSWbi4oFwERUWORiyx8ur
 bWvoiEWM63B+DXZqSNl5u/A=
X-Google-Smtp-Source: AA0mqf7+2AEstG2zQZWqQIE3UtBcDlP+tNxEcHG7VqwJTz3I0h+3H54yM8gaQDgA2qDzQbmuZ1wi+g==
X-Received: by 2002:a17:90b:2690:b0:213:f2c9:ce71 with SMTP id
 pl16-20020a17090b269000b00213f2c9ce71mr60558650pjb.62.1669743819324; 
 Tue, 29 Nov 2022 09:43:39 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 x29-20020aa78f1d000000b00575a578a717sm1522947pfr.206.2022.11.29.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Nov 2022 09:43:38 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Spiff out cmd queue/response traces
Date: Tue, 29 Nov 2022 09:43:30 -0800
Message-Id: <20221129174330.262751-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Rob Clark <robdclark@chromium.org>

Add a sequence # for more easily matching up cmd/resp, and the # of free
slots in the virtqueue to more easily see starvation issues.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_trace.h | 20 ++++++++++++--------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9b98470593b0..cdc208d9238c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -166,6 +166,8 @@ struct virtio_gpu_vbuffer {
 
 	struct virtio_gpu_object_array *objs;
 	struct list_head list;
+
+	uint32_t seqno;
 };
 
 struct virtio_gpu_output {
@@ -195,6 +197,7 @@ struct virtio_gpu_queue {
 	spinlock_t qlock;
 	wait_queue_head_t ack_queue;
 	struct work_struct dequeue_work;
+	uint32_t seqno;
 };
 
 struct virtio_gpu_drv_capset {
diff --git a/drivers/gpu/drm/virtio/virtgpu_trace.h b/drivers/gpu/drm/virtio/virtgpu_trace.h
index 711ecc2bd241..087e860a66f7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_trace.h
+++ b/drivers/gpu/drm/virtio/virtgpu_trace.h
@@ -9,8 +9,8 @@
 #define TRACE_INCLUDE_FILE virtgpu_trace
 
 DECLARE_EVENT_CLASS(virtio_gpu_cmd,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr),
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno),
 	TP_STRUCT__entry(
 			 __field(int, dev)
 			 __field(unsigned int, vq)
@@ -19,6 +19,8 @@ DECLARE_EVENT_CLASS(virtio_gpu_cmd,
 			 __field(u32, flags)
 			 __field(u64, fence_id)
 			 __field(u32, ctx_id)
+			 __field(u32, num_free)
+			 __field(u32, seqno)
 			 ),
 	TP_fast_assign(
 		       __entry->dev = vq->vdev->index;
@@ -28,21 +30,23 @@ DECLARE_EVENT_CLASS(virtio_gpu_cmd,
 		       __entry->flags = le32_to_cpu(hdr->flags);
 		       __entry->fence_id = le64_to_cpu(hdr->fence_id);
 		       __entry->ctx_id = le32_to_cpu(hdr->ctx_id);
+		       __entry->num_free = vq->num_free;
+		       __entry->seqno = seqno;
 		       ),
-	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u",
+	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u num_free=%u seqno=%u",
 		  __entry->dev, __entry->vq, __entry->name,
 		  __entry->type, __entry->flags, __entry->fence_id,
-		  __entry->ctx_id)
+		  __entry->ctx_id, __entry->num_free, __entry->seqno)
 );
 
 DEFINE_EVENT(virtio_gpu_cmd, virtio_gpu_cmd_queue,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr)
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno)
 );
 
 DEFINE_EVENT(virtio_gpu_cmd, virtio_gpu_cmd_response,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr)
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno)
 );
 
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 9ff8660b50ad..a04a9b20896d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -215,7 +215,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	list_for_each_entry(entry, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
 
-		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
+		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp, entry->seqno);
 
 		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
 			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
@@ -261,6 +261,10 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	spin_unlock(&vgdev->cursorq.qlock);
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		struct virtio_gpu_ctrl_hdr *resp =
+			(struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
+
+		trace_virtio_gpu_cmd_response(vgdev->cursorq.vq, resp, entry->seqno);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
@@ -353,7 +357,8 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
 	WARN_ON(ret);
 
-	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf));
+	vbuf->seqno = ++vgdev->ctrlq.seqno;
+	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
 
 	atomic_inc(&vgdev->pending_commands);
 
@@ -465,8 +470,10 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {
+		vbuf->seqno = ++vgdev->cursorq.seqno;
 		trace_virtio_gpu_cmd_queue(vq,
-			virtio_gpu_vbuf_ctrl_hdr(vbuf));
+			virtio_gpu_vbuf_ctrl_hdr(vbuf),
+			vbuf->seqno);
 
 		notify = virtqueue_kick_prepare(vq);
 	}
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
