Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1591C433FE
	for <virtualization@archiver.kernel.org>; Wed, 30 Nov 2022 00:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E0A54013A;
	Wed, 30 Nov 2022 00:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E0A54013A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=e/AzuKds
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I8EIDwGyOx7f; Wed, 30 Nov 2022 00:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AD71400C0;
	Wed, 30 Nov 2022 00:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AD71400C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E11DC0032;
	Wed, 30 Nov 2022 00:08:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62D99C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 00:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 378FA4010D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 00:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 378FA4010D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RmkS-wQgu0oC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 00:08:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 553B4400C0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 553B4400C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Nov 2022 00:08:44 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id 21so2148245pfw.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1uNcYpPMrI5BUKS+4cI51gDVBMIA/yEg/AUAY95wTKw=;
 b=e/AzuKdsYAHWb3FkvHU4t2hkVxTQgkWyNmOJcccAWQKcQNHjzJPNvB3Cnkq5ORn7v1
 OsHP3UW2UdgIK3u6lfFonG9+MPSdES8+DKsxsJPDdmjmHwN6YlezNNl7FvGJAi8fMrZn
 4fJdUwmF2yZArXNGkx+dWVyyK3xIOBDOzhL5Ew3IMw4uEHbVj2zk7Z13XXR3bEfkorbp
 qQDO9pjAjjvgEVIuu8rcP3lfePEHPerKjqj81D3U8onXLsYHRz83qDSCS14MLk2AKWOW
 bviWwz9juRxi2LQopPz3D3oAFbJnPjsNq0Ulu+AwV5JXmvYfPF8FtdDda6iSN+vZYyH3
 NR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1uNcYpPMrI5BUKS+4cI51gDVBMIA/yEg/AUAY95wTKw=;
 b=DBBnmv+JCKALjcs5KrdX1g+FQTJDmyCyX33dt7PUsZmUymKPP3NxcbWyDhp3H+OJ96
 kzM6z0qYIpVhht9MmKL08l2tO3luX1ljmbY6ezG+ywqpssmO8ohcjslEwwtoD0PrRJEC
 AZ6ujibUS0L1N/+cCmSnGYpvMeXtkg4vqIZUlbpi2+uuH9UrYKhuDmmPnzEdCEzyyW7d
 N+JbYbd1dqGVQvWpBHSzW4b9HKUVoGDZq6UI5QQ3DjUhD9CpaPUBGgkVqQ6StMIFArJD
 z8BhOqu3Z3opCc24JfkSgj2wJoabbPmpSA7ZmHmFKs0YeaUUsanFOuclsNALK7eXZmdk
 /5Zw==
X-Gm-Message-State: ANoB5pnfdtWW0G12IRoXyrctdJf/9F8yxQoauBou5atzQp46/lAFaSyJ
 wgfK3e/anNmFytp8z8Q3lXs=
X-Google-Smtp-Source: AA0mqf6wrXy3pUVubbhsCKYanMOJSCDsa/HXBw7jsyjID2CJl9LuFqBBXRKBhg86aaf6OtYN8bcpSA==
X-Received: by 2002:a05:6a00:1812:b0:575:19b6:dfe9 with SMTP id
 y18-20020a056a00181200b0057519b6dfe9mr14574544pfa.16.1669766923741; 
 Tue, 29 Nov 2022 16:08:43 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 x8-20020aa78f08000000b005745eb7ecc3sm38261pfr.209.2022.11.29.16.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Nov 2022 16:08:43 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/virtio: Spiff out cmd queue/response traces
Date: Tue, 29 Nov 2022 16:08:41 -0800
Message-Id: <20221130000841.318037-1-robdclark@gmail.com>
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

v2: Fix handling of string fields as well

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_trace.h | 26 +++++++++++++++-----------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
 3 files changed, 28 insertions(+), 14 deletions(-)

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
index 711ecc2bd241..031bc77689d5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_trace.h
+++ b/drivers/gpu/drm/virtio/virtgpu_trace.h
@@ -9,40 +9,44 @@
 #define TRACE_INCLUDE_FILE virtgpu_trace
 
 DECLARE_EVENT_CLASS(virtio_gpu_cmd,
-	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr),
-	TP_ARGS(vq, hdr),
+	TP_PROTO(struct virtqueue *vq, struct virtio_gpu_ctrl_hdr *hdr, u32 seqno),
+	TP_ARGS(vq, hdr, seqno),
 	TP_STRUCT__entry(
 			 __field(int, dev)
 			 __field(unsigned int, vq)
-			 __field(const char *, name)
+			 __string(name, vq->name)
 			 __field(u32, type)
 			 __field(u32, flags)
 			 __field(u64, fence_id)
 			 __field(u32, ctx_id)
+			 __field(u32, num_free)
+			 __field(u32, seqno)
 			 ),
 	TP_fast_assign(
 		       __entry->dev = vq->vdev->index;
 		       __entry->vq = vq->index;
-		       __entry->name = vq->name;
+		       __assign_str(name, vq->name);
 		       __entry->type = le32_to_cpu(hdr->type);
 		       __entry->flags = le32_to_cpu(hdr->flags);
 		       __entry->fence_id = le64_to_cpu(hdr->fence_id);
 		       __entry->ctx_id = le32_to_cpu(hdr->ctx_id);
+		       __entry->num_free = vq->num_free;
+		       __entry->seqno = seqno;
 		       ),
-	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u",
-		  __entry->dev, __entry->vq, __entry->name,
+	TP_printk("vdev=%d vq=%u name=%s type=0x%x flags=0x%x fence_id=%llu ctx_id=%u num_free=%u seqno=%u",
+		  __entry->dev, __entry->vq, __get_str(name),
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
