Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F582E62C9
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758260; cv=none; b=GoXiI9T13/m2R7ZMER6lDlXqn9dysWlPPQaRyGh9vGtrvv+rnGSbnf2zUHG+YcmSdotZJEZaIzADcaRzXtoOaRhvWtfl7J5e+7OzY35V4lCzc7WN0EXTUUWoXG3OO/gYlLMBLQ+NI1elRLfVD/LiyEe1PC4XwHxIXfL5hYoz7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758260; c=relaxed/simple;
	bh=Bhskp+8KUmzT6+yWnWxUIv+I1Ci7IWHGxaZ5DAc6aF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=DHaznIPxwFl4SdNZlvXwJW7QgMK1kTiIwohmbP5LH1qjd5Aw47N8K/OZ5T5vOS5TXmnRvLhrkaOeAHCg+fdv70p9+4wjAOyvzb+OI1btZ8yNQzo4OdWjEVaNxg4TeLKFsV5xaA93uvPGe4abGbqPEpbwFcbw12/nOBSpzML72GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fGG3cCsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGG3cCsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743758257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jdt0UC5Y+YSICWNN9M7UpOd4+QGCXUQrqY/ZjKnsARY=;
	b=fGG3cCshquFG0rzvVS2cee7KpdoMZoiFjj+f99QP0QBqdAp0j7jXqAwBjuDyIToyFqf+tp
	69jbjvsgbDPYUvvYizgSnOydf08fWT5fHkOTaQak0tr062U5koXmlBNMyYUwchmmgO0FN3
	FKsTABKn6V0FYkYt+jgmamVZpOizUxM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-MePOSRhlO0WD13RE33BKaQ-1; Fri, 04 Apr 2025 05:17:36 -0400
X-MC-Unique: MePOSRhlO0WD13RE33BKaQ-1
X-Mimecast-MFC-AGG-ID: MePOSRhlO0WD13RE33BKaQ_1743758255
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af96cdd7f5bso1280129a12.1
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 02:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743758255; x=1744363055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdt0UC5Y+YSICWNN9M7UpOd4+QGCXUQrqY/ZjKnsARY=;
        b=PS0Bcz/Xq0xTCzVEgwNpRzmxl3OrDEJgdvWcB/fVYnVwOr+kGXExaYtpyjb/DLi+0X
         msejR9fikAXOETIuvkKdbYmfMcjH1M2WFQRCfj18uxRj3TkeYHWeIHxgJe/4yqzHuort
         xh7qbjYuXUCzZ4JsMEvxM4qEz8zBwFg1K1fA1kq7/QYP+UDE4DIHHLLUu3E7wWHD1u4g
         Nx0IGGNm1Y4aqgqY0OvwkxzSxwInfgSKkUYRUt1TwkCLm/JRzUfVyGkjR8mLar0HBYNo
         wQGe+oX0LUHM4hYO+0+bszUuZTndVePRjzJNMIruWcYN8jrIcOXMxUicjbOmlNArRqpo
         qEzg==
X-Forwarded-Encrypted: i=1; AJvYcCU8HEL6RN8cDtxc+Z/V7WAQqEKRekaBX952h3lHTCqVZAs1PCGMu5OAU4P6FRdShZ4mM+AA+qrkLa8vJovkmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAapuGVpEPIBE8zkPB5HiJVeKg/AQdGBwp/jgYZvVIUKcH/O5l
	Sve7C68JCvyXhzXhHrTZV4pMS3K+7OljK5ROZlg509Qgu+5WcnYiKh179Fj1QKja1CAyb/OQKSp
	HqHHquVdJ7x/BivANf3YRiJV3+1SI+OJ6aJDpuc557uErNl7H0dmenU5Y1girm/Q7
X-Gm-Gg: ASbGnct2rbYdViAmvIgwaNbW9AZWV1RneoPZ4QmLH7ba4SvlDLnNSjc8hVWnQc+fC7M
	fM68qZo5QKxVXzAlUTIVhC3xTq8p4bG/pT4dVjHdMFfAtOrJJvIDMpWcx1U1qQ46Nz9pWF6faIp
	W/p5AN8PRgAxecY4iUTXwR9izwrt54xDzn0CSBjMdWXwJsv7oo60RMGaWNgniI9KhlUEKG/MUAv
	lzPvPTWTo8L9uSadB+gCfyNLysrWUG45DmRNpVnbTQL4mUKl5P1kNj5OwOp9iG2F4P8u8o1VDmB
	dfZoOROz8TZDqUaQ
X-Received: by 2002:a05:6a20:2d14:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-201045a6c2dmr4306815637.11.1743758255250;
        Fri, 04 Apr 2025 02:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4cF4AJ9IrgwOr6kkgUgDT+AZY2Wj7fW+I4Ga378jGkThhOH+aHldzacKBbkECHVRoyItLUQ==
X-Received: by 2002:a05:6a20:2d14:b0:1f5:55b7:1bb4 with SMTP id adf61e73a8af0-201045a6c2dmr4306786637.11.1743758254905;
        Fri, 04 Apr 2025 02:17:34 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc3fd411sm2432493a12.52.2025.04.04.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 02:17:34 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: Remove unused argument from qxl_alloc_release_reserved
Date: Fri,  4 Apr 2025 18:16:51 +0900
Message-ID: <20250404091654.1664838-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YIm2FIvpXJNtD3rtFyLgSuJNpGxLXmdCDvfz2HZE8vk_1743758255
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The `size` argument in the `qxl_alloc_release_reserved` function is
currently unused and has no effect on the function's logic. So remove
this argument to clean up the code. No functional changes are expected.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 9 +++------
 drivers/gpu/drm/qxl/qxl_draw.c    | 3 +--
 drivers/gpu/drm/qxl/qxl_drv.h     | 5 ++---
 drivers/gpu/drm/qxl/qxl_ioctl.c   | 7 +------
 drivers/gpu/drm/qxl/qxl_release.c | 8 +++-----
 5 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 70aff64ced87..c0c65efbfa32 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -496,8 +496,7 @@ static int qxl_primary_apply_cursor(struct qxl_device *qdev,
 	if (!qcrtc->cursor_bo)
 		return 0;
 
-	ret = qxl_alloc_release_reserved(qdev, sizeof(*cmd),
-					 QXL_RELEASE_CURSOR_CMD,
+	ret = qxl_alloc_release_reserved(qdev, QXL_RELEASE_CURSOR_CMD,
 					 &release, NULL);
 	if (ret)
 		return ret;
@@ -541,8 +540,7 @@ static int qxl_primary_move_cursor(struct qxl_device *qdev,
 	if (!qcrtc->cursor_bo)
 		return 0;
 
-	ret = qxl_alloc_release_reserved(qdev, sizeof(*cmd),
-					 QXL_RELEASE_CURSOR_CMD,
+	ret = qxl_alloc_release_reserved(qdev, QXL_RELEASE_CURSOR_CMD,
 					 &release, NULL);
 	if (ret)
 		return ret;
@@ -714,8 +712,7 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	struct qxl_cursor_cmd *cmd;
 	int ret;
 
-	ret = qxl_alloc_release_reserved(qdev, sizeof(*cmd),
-					 QXL_RELEASE_CURSOR_CMD,
+	ret = qxl_alloc_release_reserved(qdev, QXL_RELEASE_CURSOR_CMD,
 					 &release, NULL);
 	if (ret)
 		return;
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..b4c41545fb06 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -64,8 +64,7 @@ static struct qxl_rect *drawable_set_clipping(struct qxl_device *qdev,
 static int
 alloc_drawable(struct qxl_device *qdev, struct qxl_release **release)
 {
-	return qxl_alloc_release_reserved(qdev, sizeof(struct qxl_drawable),
-					  QXL_RELEASE_DRAWABLE, release, NULL);
+	return qxl_alloc_release_reserved(qdev, QXL_RELEASE_DRAWABLE, release, NULL);
 }
 
 static void
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..fbc15338ae3c 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -372,9 +372,8 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 				       enum qxl_surface_cmd_type surface_cmd_type,
 				       struct qxl_release *create_rel,
 				       struct qxl_release **release);
-int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
-			       int type, struct qxl_release **release,
-			       struct qxl_bo **rbo);
+int qxl_alloc_release_reserved(struct qxl_device *qdev, int type,
+			       struct qxl_release **release, struct qxl_bo **rbo);
 
 int
 qxl_push_command_ring_release(struct qxl_device *qdev, struct qxl_release *release,
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 506ae1f5e099..5e0321b6f319 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -171,12 +171,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	if (!reloc_info)
 		return -ENOMEM;
 
-	ret = qxl_alloc_release_reserved(qdev,
-					 sizeof(union qxl_release_info) +
-					 cmd->command_size,
-					 release_type,
-					 &release,
-					 &cmd_bo);
+	ret = qxl_alloc_release_reserved(qdev, release_type, &release, &cmd_bo);
 	if (ret)
 		goto out_free_reloc;
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 05204a6a3fa8..52c444a482be 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -279,13 +279,11 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 		return 0;
 	}
 
-	return qxl_alloc_release_reserved(qdev, sizeof(struct qxl_surface_cmd),
-					 QXL_RELEASE_SURFACE_CMD, release, NULL);
+	return qxl_alloc_release_reserved(qdev, QXL_RELEASE_SURFACE_CMD, release, NULL);
 }
 
-int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
-				       int type, struct qxl_release **release,
-				       struct qxl_bo **rbo)
+int qxl_alloc_release_reserved(struct qxl_device *qdev, int type,
+			       struct qxl_release **release, struct qxl_bo **rbo)
 {
 	struct qxl_bo *bo, *free_bo = NULL;
 	int idr_ret;

base-commit: e48e99b6edf41c69c5528aa7ffb2daf3c59ee105
-- 
2.48.1

