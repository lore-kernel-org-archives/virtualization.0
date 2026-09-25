Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E7471408
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323307; cv=none; b=Ppbqs/Onz7yc08YGcZdG6ghspU1cj6IWH+b20BC9gN2u1Q11DxRLQ2ky6Fr9zse6usU5MzdigcY4Ouu6jJYn9U5SYtlU+D+KaVxEMz+Y1AAbD4KozCpaBp9jhh4fUI2W2iRUF8rlg7KvIKy4A93aJ0qBtG4Uon9jI2hqDH9joHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323307; c=relaxed/simple;
	bh=l+UTWai1dYY/ZEpL8dyIn91Ds9SFYRgRbj357nizg5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUNfgwp03XqaWQRFrSTXB0bnGgbEvStWw0WpEeQEnEp57pO241ZsbZwyyteQO9ehqIxB10aKnqBsMj51MlmBZbkXut/WmUw4SbkLIaYSQhAjaOo1pIAwXOPeN5kZT37kWBtiRO7fSb5U8XvipoSqK+Ig5Vb00uGWrGFwkLJdENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getfieldwork.ai; spf=pass smtp.mailfrom=getfieldwork.ai; dkim=pass (2048-bit key) header.d=getfieldwork.ai header.i=@getfieldwork.ai header.b=PMwLXsiR; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getfieldwork.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getfieldwork.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getfieldwork.ai header.i=@getfieldwork.ai header.b="PMwLXsiR"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4887840c529so175650f8f.1
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getfieldwork.ai; s=google; t=1790323302; x=1790928102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOlBBpGD3Y0REYiLwhaWxhjVYik9/CfvZxRnEgnvMuo=;
        b=PMwLXsiRL2ckVIJG6sEShnViZic3rLo5j/VKJ9pcTgGi5Kt6ybseMokydOqlkKmDnv
         cJ+m6k6PC1ku4rBzOZIEVJy0557GHHt6fEDLEgJGSGzYPSyTQ4pOggEF429aS2sdu9di
         tL2ApmCKsHm3psPOZquX30BQ9wL2GNshKdKOe18SomMahj+zh/mRAtAorr1CTTAfHQLg
         XMTj9uchHtNfJcawHnz0YjnejYiNwhuYT5xVBwTJsEgGU6uP8IkBbVquUBX6srujXYKK
         /6Y+OPNU9j1pxYGAqHROHj3TcE9vpgXhqa5pJustxw0BKZP1vZkMHFpqnjGrLX4i/Y8n
         TLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790323302; x=1790928102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOlBBpGD3Y0REYiLwhaWxhjVYik9/CfvZxRnEgnvMuo=;
        b=NlVbVebv33EZclh8qmY0uQ2fmmzMixw5hNUDiMzhgGJb4OoLYb/IyPdo7uDU8utAiE
         SKElMnbF5dlw5LfeFQpPuDFfSMFWHTiqxKKjfk/tPFVtqYp09JrmpgcgCP1dnDTPDhq1
         xBRMpaIYKL/ONgp54AeO88iyXOe+1T4xFnv1O9DJ/oydjzx3PFDI1RJ8v9Adu0nHkCNq
         ROY9mc7nyJtkDodTRERKoWvYlZNqDQH+88qPn3m5WJAVY0rpIRvX4Gpe0CVXDYo3izJV
         LahnXJHCjcyMV2CqyS73NWbPuC17K0ZS4f2z+nidBUgTdWlw4LUNXGeHoD0X2BV8c91q
         LdBg==
X-Forwarded-Encrypted: i=1; AKwUvBySwuf9IZj3qGzzyspzAc2RGszoE3axHFt4U2N+u67aLYe3A6GioMHnzm0bRAZSBZoPJiEdUAuC3wlCoG804A==@lists.linux.dev
X-Gm-Message-State: AFuF++nGM0rJ8LWiv3rRnE6uH9VwlxXVyaJrS4ee2/QS7uFTrYS9SNjH
	v/KCRyiYnuigIXomndT9V+LddWLO8RVLy7nvn95sChbVLjc292Mjl1u7sT+nfa0YjWEr
X-Gm-Gg: AYBFou1JEpWNtlFnhDSRVBjIazEdfjn0fA8AiY3aWaYj8yObXm+VDxuVZyY2+UJPQCD
	loPje4HVTdNQZLGXWmPyXAzLQryMBQK04ZR9WU4NIVo1kcR/iPCzI7+eeRJVaDOK9Ktj9YjhpOq
	bqWb1V8aKzxT5RN1vPxqVwWoQyRV8utvzplMga26DfMGnzCtoWtDl3BeFhxoGbXGMwy0ao1mzdc
	3WE96cB87/bQzyRMwI/kkJXtrDpt5j+JyXEe5Sqm/9IVpkPN1odxaTd8/V2frAfnCTpk5nG4LtQ
	pKXSQzTyCFJCW+Z1keojAJTiC1Z2H3xbzkMCCJCPbVlZ1IgKj3zy4Fzfc1aEji5HrGp/yQOuGZK
	1HlG4/o8r+C7vp4ocZZ1avCXmL8fb5d3imZD9X4PsRxW4VT2gI/PgObYwwD7lgGPoHdHBjIO30V
	/VPNlLeTkCxjPlLwBmwk/3CuvMTAh7i5/qVN4Mu/4QBCNQh0CTabg2ApdE2RNcpZ9U4DjEklkNi
	E2BbIH9/ArScOLVTnTkHX9HtEqoly54iO1J/TiuqL5R2Mw+1d2vBLkPlrcaaGUyHWqSnlOZvqYA
	vvA4O/NU1JN16mChQFlflefrFquj6j5dVCChoF1793fB5EBKe0Z28noZHoI=
X-Received: by 2002:a05:600c:6986:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-49fe66d05d7mr77962585e9.8.1790323301545;
        Fri, 25 Sep 2026 01:01:41 -0700 (PDT)
Received: from NicksFWMBP.taile41d51.ts.net ([2a00:23c8:b064:8301:e401:b461:4e5:786c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff43ad975sm21662945e9.13.2026.09.25.01.01.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 01:01:41 -0700 (PDT)
From: Nick Rogers <nick@getfieldwork.ai>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	adelva@google.com,
	aesteve@redhat.com,
	changyeon@google.com,
	daniel.almeida@collabora.com,
	eperezma@redhat.com,
	Alexandre Courbot <gnurou@gmail.com>,
	gurchetansingh@google.com,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mst@redhat.com,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	dbassey@redhat.com,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH] media: virtio: clear the size of legacy controls built on the stack
Date: Fri, 25 Sep 2026 09:01:40 +0100
Message-ID: <20260925080140.44696-1-nick@getfieldwork.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923162928.73497-1-nick@getfieldwork.ai>
References: <20260923162928.73497-1-nick@getfieldwork.ai>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
This applies on top of the virtio-media v9 series and turns point 3 of
my review above into a patch. Build-tested on media.git next with v9
applied (arm64, W=1, no new warnings).

 drivers/media/virtio/virtio_media_ioctls.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/virtio/virtio_media_ioctls.c
index f0b82b5ec..19abcf95e 100644
--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2024-2026 Google LLC.
  */
 
+#include <linux/sched/task_stack.h>
 #include <linux/mutex.h>
 #include <linux/videodev2.h>
 #include <linux/virtio_config.h>
@@ -576,11 +577,31 @@ static int virtio_media_querycap(struct file *file, void *fh,
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
@@ -590,6 +611,8 @@ static int virtio_media_s_ext_ctrls(struct file *file, void *fh,
 {
 	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
 
+	virtio_media_legacy_ctrl(ctrls);
+
 	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_S_EXT_CTRLS,
 						    ctrls);
 }
@@ -599,6 +622,8 @@ static int virtio_media_try_ext_ctrls(struct file *file, void *fh,
 {
 	struct v4l2_fh *vfh = file_to_v4l2_fh(file);
 
+	virtio_media_legacy_ctrl(ctrls);
+
 	return virtio_media_send_ext_controls_ioctl(vfh, VIDIOC_TRY_EXT_CTRLS,
 						    ctrls);
 }
-- 
2.54.0 (Apple Git-157)

