Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795229429;
	b=V1GmjOgRRnKrgNtCzcN1Rius6eZwtrsdw9AhER1rsl3WKND22esBf80vfgoFzPZDPinB
	 PMod477VzCNaIqhI5c4GuJiVt3JADhMh3tco9XojzK/zVyDtQQQw0GPUlXS6II1HHKOUa
	 82DaH5kWlWJZ3RKE7F5lq7+vvRlocwiiZNOFZuDvHZ7goW5cgbUCJ8ACVlLuA9/w/1XaJ
	 tR+BgpK9Vrblo1JyBBP186OS+mqSo2TcZTA6nOl7uE+89FT/oEPIqNBWIEja87STI9A+t
	 rcswTjHO9WWkJaTDl9viM4QLLTs+58lIHB/QHtWPoCpBZOkNm0GAqM47/K1jSfLxOTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795229429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=DKXb3XP5512p3dJHGo2KoBBF7YTIyEsZxlx/DyWyIB8=;
	b=njqXbk+EUValGmq9qa7AtYLvsgNe0Ab2qRcDHbWPMBtb7hKUcWIPGI53aFLIyHMfGz0u
	 nlSChSbPJC5O3f2JnuRRfgSS5D3Zs3Wl198ywIazyGyhP+SexdgdWWdPPt3UiY4V3oNsY
	 VOZUq4A/XXQSnU4GXzmMcnTzZTI2nPz/UwZW6DVheTOV+GooQUdxH485+iiq6p4maXgK8
	 G0n16hFPV5Hq+h2CeX3cFKcSIVaNWhXtbNec6ljNn8jfj0N65Aua20NW/kInkS/igUKso
	 8VeI+CKf+lU45sNLuQOYoNMLuOB10ACyBxqjQZSZ1wllQm2mgF+g0wcttw3NImixJFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KUIloxA2;
	arc=none smtp.remote-ip=74.125.224.72
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7460A2613
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 02:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B7460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KUIloxA2
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6755fef4f96so2790742d50.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 18:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795229423; x=1795834223; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKXb3XP5512p3dJHGo2KoBBF7YTIyEsZxlx/DyWyIB8=;
        b=KUIloxA2GPtbp8savFfJRf+zB4hqnS/drNJQ3Wxm9B4cyRN1HJR12U6qOfglAiY7Ix
         1p5KfZjH0++UkwcqFE/3hyQLyh+09ZUwTBOG1TJuF4FRiv11/LgmZ0VmThL2I3DMyREG
         LRYIsvau6JKblBVRVBBLX/KI3emIZc/xbojxn/M8phC0+9F+4LOtUYUZNTr1NiK4VYJX
         /9fkcVaA4V4NAPam47Ar3CrGdW+NTW7IJkXQG/kkXeX5ngKrwRGh/WKPSCe7WYIuYxsy
         WjtmwXNz0IXAhsJHYUY7b/Wpcpfc8q5CMBxdY/LqE6CHpZpWAKSVjkOd/QMe12kzz0Gb
         OOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795229423; x=1795834223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKXb3XP5512p3dJHGo2KoBBF7YTIyEsZxlx/DyWyIB8=;
        b=H3YvAmUBQ5TQimrkedkPMtGXE0vZrzcdl3Ts+tpZ2/UQVche/K36gjC44RRe4Ja+fA
         CTp+xtAEJZn7Ie7XlnH7bgYj/wdF4f8j7iCLlAAakRJ/a/yvgip9or0isizRaSbVWAHQ
         MjwbuESD008v3Oz7fOKpVfaXSfPFgM6t0a+XEldeIETdicbpUf8TmPpFfPJejYf3SKjA
         DvYok8zykU1CucPVmKeIi+wwYVsgnTi9rpsrdchGiTYcA/TREn8dokcTgMGa1KQOOJf8
         p0WElpMoNyjWHBkrI9s8z7MRGiljzW4xKV4IgVgzXVI1uKquS/X/8yH9yLc0c8g5lItw
         yDKg==
X-Forwarded-Encrypted: i=1; AL+hErF/AsBJ/wdbygIZ+RkTwjDsmWYky88HQdDimguCxXErPMipgW4hYHY+7uCYJ9KuGTkMZHMRdtOV4hKcoLJ+uQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pH9zgmBV2YijnkYHacYNUsUUYG2mXdMlSJj3xAbDt8KebQjqC
	ykkOZ6tdgNzh/5BScNIqOxHMZgaJ6YXG1z+9HG4Z7+wma8+M3qS18HEnWX8QbzP3Tf8kIerOYr0
	q6TvFMMLN0ev/6bPui2ous5Xk/Ot0
X-Received: from yxvc11.prod.google.com ([2002:a53:ef0b:0:b0:67d:aba9:9204])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:43cc:20b0:67d:baf9:116b with SMTP id 956f58d0204a3-67df42c4555mr1179076d50.9.1795229422929;
 Fri, 20 Nov 2026 18:50:22 -0800 (PST)
Date: Fri, 20 Nov 2026 21:50:07 -0500
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
Message-ID: <20261121025007.3445723-7-briandaniels@google.com>
Subject: [PATCH v12 6/6] media: virtio: clear the size of legacy controls
 built on the stack
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com, 
	Nick Rogers <nick@getfieldwork.ai>, Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Nick Rogers <nick@getfieldwork.ai>

A driver without a control handler receives VIDIOC_G_CTRL and
VIDIOC_S_CTRL from the V4L2 core as a single extended control that the
core builds on its own stack, with the control's size left
uninitialized. virtio_media_send_ext_controls_ioctl() takes a nonzero
size as a payload to copy from userspace, so these ioctls fail with
-EINVAL whenever the stack is dirty. GStreamer's V4L2 encoders set their
profile with VIDIOC_S_CTRL and cannot negotiate, and v4l2-ctl cannot
read the MIN_BUFFERS controls.

Legacy controls carry a 32-bit value and never a payload, and an array
that comes from userspace is copied into an allocation, never onto the
stack. Clear the size of each control when the array is on the stack.

The core is being fixed to zero the structure [1]; this keeps the driver
working on kernels without that fix.

[1] https://lore.kernel.org/all/20260923160936.33445-1-nick@getfieldwork.ai/

Signed-off-by: Nick Rogers <nick@getfieldwork.ai>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 drivers/media/virtio/virtio_media_ioctls.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
index aa56efe9a..ad240073a 100644
--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2024-2026 Google LLC.
  */
 
+#include <linux/sched/task_stack.h>
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
 #include <linux/virtio_config.h>
@@ -593,11 +594,31 @@ static int virtio_media_querycap(struct file *file, void *fh,
  * Extended control ioctls are handled mostly identically.
  */
 
+/*
+ * VIDIOC_G_CTRL and VIDIOC_S_CTRL reach a driver without a control handler
+ * as one extended control the V4L2 core builds on its own stack, with its
+ * size left uninitialized. They carry a 32-bit value and never a payload,
+ * so a size there is stack garbage, which would be sent as a user pointer
+ * to copy and fail the ioctl. An array from userspace is never on the
+ * stack: the core copies it into an allocation.
+ */
+static void virtio_media_legacy_ctrl(struct v4l2_ext_controls *ctrls)
+{
+	u32 i;
+
+	if (!ctrls->count || !object_is_on_stack(ctrls->controls))
+		return;
+	for (i = 0; i < ctrls->count; i++)
+		ctrls->controls[i].size = 0;
+}
+
 static int virtio_media_g_ext_ctrls(struct file *file, void *fh,
 				    struct v4l2_ext_controls *ctrls)
 {
 	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
 
+	virtio_media_legacy_ctrl(ctrls);
+
 	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_G_EXT_CTRLS,
 						    ctrls);
 }
@@ -607,6 +628,8 @@ static int virtio_media_s_ext_ctrls(struct file *file, void *fh,
 {
 	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
 
+	virtio_media_legacy_ctrl(ctrls);
+
 	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTRLS,
 						    ctrls);
 }
@@ -616,6 +639,8 @@ static int virtio_media_try_ext_ctrls(struct file *file, void *fh,
 {
 	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
 
+	virtio_media_legacy_ctrl(ctrls);
+
 	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_TRY_EXT_CTRLS,
 						    ctrls);
 }
-- 
2.56.1.750.gf70dc682cf-goog

