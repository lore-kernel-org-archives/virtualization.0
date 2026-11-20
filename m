Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211979;
	b=XjxQRdhr2KELQT2Ev/6QkWHpHTmnrN4E4T2Khf4zuTC1CSJWmvLy72cWJIsemZP2i9PP
	 yGhig1WMlaIhYHfwbMrqiDbpQ0sXwIf5+DxdyPIGJEIA1WasftSzkrzzyFEtRJduv4+rx
	 l3KOp2/wwPDHd6LVEZJlChP85oM7jnpXek6sbUj7ZJy80ZYBdaAIhm9w1i9/fBfe4M3mc
	 K2X47Bodal4flv2Cz1lm++NQW21uQ4NSPb0tDt5ZiLzB9jzaHDt7XpWSbrA4eZTrHLE/t
	 XvRS4i9xuveWBJoAz95gc3qX4fGG5KQPAMae1SADm2HyNFJDoVgJE7qcrJPr4CaQsaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=yQp6wu37grFSLFpLYqDqLuKQZrEDeFa5v47ChyJcE5k=;
	b=4CD8x8H3bUomFgfo508YyjumVntbtNUlHtYxlzUMd1JO3VC4Mk+TShvLdVxpglCgK3WD
	 e4bJ0DlUxy8c+e3nkWnHstkyGQKMcb9ChSLeKuegtL36dA4t3vrt1L/eYzXQ4m/IkMk9+
	 QoNjFNE1BCmg8LBQLfY/mcaAlB/3u45gfEBx/ExvNTdYQ+fNTRKIhhBais6dvgfJ1jv17
	 Cjx29lLX3byknMhKCfLrGqaa3rvvRAlBM6pbdl4gqkTyiPzvai6sGCyUO/4SAax8hFs2H
	 1S1AnD8IbW8JI1p9vTXpw4uPt+f+ow8N4t1n5PWyQk1kV1rCROXVUOWQjRVu3Cknmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FKpy0PwB;
	arc=none smtp.remote-ip=209.85.222.197
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333760A2608
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 21:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B333760A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FKpy0PwB
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so278935485a.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211975; x=1795816775; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQp6wu37grFSLFpLYqDqLuKQZrEDeFa5v47ChyJcE5k=;
        b=FKpy0PwB/ryAl7htj7L082FvXkk8kkj4uWCwUbJu4FMYAZYphnoV+42K4NMaZeHGtG
         MoJdIEuzuTJRSpWt2d5T9z7BGMcTnAJNCOL68pPFUttrZO/5xsYQCMMfgHxvCt/rOB6e
         tjlZlpu3nyymGyFSHs6cmUbN8Ubp+QhJJaypCkWL+nx77s4HY0i+X0WNJ1TGofp9XJwm
         HskYbL9Y/pPYZZKSgNogfGP8NVfRVYauVoo/PXyIpMrpSVcx7sF+vuOYdpnarl0f4rwO
         bYBPyH1G5+yOD6fDGyIq00kTXZVGUGAb6dL/Te6Abx9Ifpl9lVLhMVaqHZZD0yY3h0ui
         KIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211975; x=1795816775;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQp6wu37grFSLFpLYqDqLuKQZrEDeFa5v47ChyJcE5k=;
        b=WDqkL32OErpQMA8gZ89kmhWbeZI9usa0RymWUGpwk/SQR5gPR3GOmwczgOQ5ziIh21
         Gj4R9k+qzjSC1Ap1d6fJzC8ruFsHVNEDuddzYcIxZxV+NegelUw5q1bq0VLraEOoj6Tm
         Rf1/LDb5LxaH01VnRXOBIL/U65G9xSSnv0hts5U+tPB5QW/rhTDfsY7uR+P2Azxtg9do
         98saAQiduR5LyU0LQXW909WFjVOxg8m/0EvqYchH0wCNdqiw+MkhlSlQPb7BF4mSa2yI
         FJF/RmT6mTJrJIetRk+v/9WRdr50GnItyI5OyhHAsjGGsP2oYgBMxXJUSXJGeTWQUcV1
         K67w==
X-Forwarded-Encrypted: i=1; AL+hErGR5ZqVh2Euow/Ty4i00q3itcrBCwH8rFcMGGBDw/V9T6sMAwWhVhupM5/ijc8hZFwECLN7De17yXfeHvm7qQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+JYBBmve/fGKKmWUN3cAVh3+RtjpEDCG7Fzib9RIe4gyFyqzp8
	i5byXrs5QYEYuNimWbLKknZJteVwaxNF0ZtJsK+84ug29fj/h8l/+w/L3G100LFPqXf1CBvHS6N
	QeWu0kPrKVQ5aHVjIGjZhMuYEKtNX
X-Received: from qkil7.prod.google.com ([2002:a05:620a:c07:b0:93e:7793:940c])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4556:b0:93e:c691:a1c with SMTP id af79cd13be357-949bab3d32emr690699785a.76.1795211974300;
 Fri, 20 Nov 2026 13:59:34 -0800 (PST)
Date: Fri, 20 Nov 2026 16:59:16 -0500
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
Message-ID: <20261120215916.3149345-7-briandaniels@google.com>
Subject: [PATCH v11 6/6] media: virtio: clear the size of legacy controls
 built on the stack
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: adelva@google.com, aesteve@redhat.com, changyeon@google.com, 
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com, 
	gurchetansingh@google.com, hverkuil@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	dbassey@redhat.com, laurent.pinchart@ideasonboard.com, 
	Nick Rogers <nick@getfieldwork.ai>
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

Assisted-by: LLM
Signed-off-by: Nick Rogers <nick@getfieldwork.ai>
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

