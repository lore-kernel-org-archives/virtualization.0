Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDB3B27D8
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791687686; cv=none; b=sAF6QxU42uxcla/X+RuOYyvXx/yGOTpO5CQwKig840KHELC0aLzhpEmVkZOiLpxudavnZThnB5sIBv2vBLyKPu1X9rpgt4/YWxhfPM/qVItcmDWRIsEpJPY2MT6LhFp1s2pt2sZZanJMxQGh8N+KziaJRCdI8Hr6aIZn8zuz4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791687686; c=relaxed/simple;
	bh=XQ1Dlstz3NP3/Cjvh5yBTsuoGHYsA6EGNZVH+AIxY38=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type; b=c3ohVVsU48feBv2Si52mQnU0bM9VECehm5aWrhNadyN0lxIYciEOMmkpNqiGXhIdUnD2nuCQf4xnVKtQGPRiseQdpDNGphZgjWZ8BwE7kMRsPgGIUB+7axlXo29FBsGwq0DWDDELp3Ft27KagRRBz8dqa0frOGmk1lz2nn8v2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEa/GWYd; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEa/GWYd"
Received: by mail-pj2-f3.google.com with SMTP id 98e67ed59e1d1-3ab1a154579so275403a91.1
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791687684; x=1792292484; darn=lists.linux.dev;
        h=content-type:mime-version:subject:cc:to:from:date:message-id:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rNcSfb2fz+pnEjz/bC8gFntw6Gwe17MPr3niIZnTHK0=;
        b=AEa/GWYdLfXyIrVG4+26fWROVhiyOPLqLS9yhLzcDmNXJKRmbjcFg2KtS0T1HBzxE2
         Q2r2eGuAlWpfOBjXOKqUSLAnxXdLx4UGyKfrWwTM7biS8gJaKoT8RF5MedMTv4lvtGDD
         lk2o5YSnnTQ6D2kwRzfmF0jie1r3OU1wi3ijFxsWZybtSKOuQb+9ymC3t8FeYei3liqX
         RnEa7PD9iwywH5Q5k+1KkPpjP7VOXbHOl672YtiV1ntWV72be1DfMpI2U512tFR/v+cD
         lzNMKPuScXsMhg28lWMkn0Ocwr5egywOmBtzK9Pl33WuUDs0/UVdyuOlc2h6ywbQD46R
         AWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791687684; x=1792292484;
        h=content-type:mime-version:subject:cc:to:from:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rNcSfb2fz+pnEjz/bC8gFntw6Gwe17MPr3niIZnTHK0=;
        b=O9q+WQaFgw4jPE0m3vLq8POskWmQehQmk6SC/Hvmz8nLv7bvoaUs1fmIL1DwWnMRBK
         YpCpqZDww9At5g1BQXs+qP11uFajO46upUvXzfnoybpdGP6CzHen2xWDjPZ99M6eSGfU
         whmaF+aA0o+s6AtXufaPMjfImMTj7gexnimydejh+NQk4mWPZVgM7pSaGbDgfZv/8YQ1
         C/pEr4J3uLUSFFNmvKS4fzTjNPXwO89DJXfk5djzvx2Pg5yoJTCpG/z8/C5627szghsz
         Wu90/ZozRAPv8Q5NfsnwIj4vumKcECAHDBbaBHKP5CDwbe0clWU7sZAmOzzCaCpFEwz4
         /BKg==
X-Forwarded-Encrypted: i=1; AKwUvBwTnYDGp1GHko89Uwwh+XZiUvy84/jSswu2NXERl5iICEHWl0Oa5oDaa2oxx+R7wyHqqHak2Tf05jnQAvW9sA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLXQ2izGYF7fKs71Uw3VCK495XgGJ+SGD8s701HxmXRQY5wRudH
	eYQaI4RTMBy4uEt+4i55ZDbaI5NXxafw32K2Uha+mOXIGIMEcWmq/nIKisSeuwNEfEA=
X-Gm-Gg: AYBFou0YHwTmxU7x8M6/FzpwQ0I4wdawCg4cEcrfa2peKmpUEv6gL0USJ1OYccovURh
	/4Jjbnkst+z6NcseREOk7ACyycM+H/z0A+deeMFs0cBvz+CigcqfsblwKt4PDaGKZp46QkV5Hv2
	Pf9m8z0OuCPoDlii0gAvFLrP7z/vop5JmjeruaXaTsxuHpfuteqjkH+ZjrNm8gij2DbVShfRKvF
	aLuGi7vREVSwWM7cCpLDJ+7HlpAwe5hImubxkaHGqfRgBtyGZ6pgzX+Kh2Cq1zi5ZIdg93ET4eJ
	Aq+ImA/JL6P7o5L7xxc6ui1I5DEe4X9K4qsfDQx6djVQqPYM78UuRdsHzzmWdkMLV/eK6i3zJew
	EFcY255KuIoVO03+jyF/UErKXNX+bacx1NohyN8DnzdQDvOlyaMdmswS0gisUw5oBMu9/EXr2FM
	AIZDvWS8XdEGz7DvriTzxSiHVY90ESOmBZKPlVjnOToDSY0r6DB52Qfj0dHVG67FtAbhi+oqKt9
	COkjeCZ/9MrPv34WqOuFBZ6XIKTVpPQqjHA6jJypJbN3FY=
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a4f with SMTP id 98e67ed59e1d1-3ab3af75ac1mr4671255a91.51.1791687683539;
        Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
Received: from send-qxl-v2-public.eml (bb116-14-52-5.singnet.com.sg. [116.14.52.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm6645866a91.1.2026.10.10.20.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
Message-ID: <6acafc03.6b76d992.279a8.b343@mx.google.com>
Date: Sat, 10 Oct 2026 20:01:23 -0700 (PDT)
From: Zhou Qiuyue <n0ps1edzz@gmail.com>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [PATCH v2] drm/qxl: validate relocation destination offsets
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

The QXL execbuffer ioctl lets userspace request relocations into a
destination buffer object at an arbitrary offset.  The offset is never
validated against the size of that object, and the relocation is applied
with a plain pointer write into the object's io-mapping window:

  apply_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint64_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = ...;

  apply_surf_reloc():
      reloc_page = qxl_bo_kmap_atomic_page(qdev, dst_bo, dst_offset & PAGE_MASK);
      *(uint32_t *)(reloc_page + (dst_offset & ~PAGE_MASK)) = id;

so a user supplied dst_offset turns into an out-of-bounds kernel write of
8 (or 4) bytes.  As the offset is additionally truncated into a 32bit
member and handed on as "int page_offset" to qxl_bo_kmap_atomic_page(),
the write can even be placed before the object (sign extension).

Validate the offset plus the access size against the destination object
size, and make the offset/parameter types wide enough that the check is
not defeated by truncation or sign extension.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Zhou Qiuyue <n0ps1edzz@gmail.com>
---
v2: use a real-name Signed-off-by (noted by Willy Tarreau).
    The reproducer and full report were sent to the maintainers on 2026-10-06;
    the reproducer can be shared on request.
 drivers/gpu/drm/qxl/qxl_ioctl.c  | 20 +++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_object.c |  2 +-
 drivers/gpu/drm/qxl/qxl_object.h |  2 +-
 3 files changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -73,7 +73,7 @@
 struct qxl_reloc_info {
 	int type;
 	struct qxl_bo *dst_bo;
-	uint32_t dst_offset;
+	uint64_t dst_offset;
 	struct qxl_bo *src_bo;
 	int src_offset;
 };
@@ -149,6 +149,7 @@
 	void *fb_cmd;
 	int i, ret;
 	int unwritten;
+	u32 reloc_size;
 
 	switch (cmd->type) {
 	case QXL_CMD_DRAW:
@@ -231,6 +232,23 @@
 			reloc_info[i].dst_offset = reloc.dst_offset + release->release_offset;
 		}
 
+		/*
+		 * The relocation is applied with a plain write into the memory
+		 * window of the destination object, so the user supplied offset
+		 * must be validated against the object size.  Otherwise userspace
+		 * can write anywhere in the mapping window set up by
+		 * qxl_bo_kmap_atomic_page(), i.e. outside of the object.
+		 */
+		reloc_size = (reloc.reloc_type == QXL_RELOC_TYPE_BO) ?
+			     sizeof(uint64_t) : sizeof(uint32_t);
+		if (reloc_info[i].dst_offset > reloc_info[i].dst_bo->tbo.base.size ||
+		    reloc_size > reloc_info[i].dst_bo->tbo.base.size -
+				 reloc_info[i].dst_offset) {
+			DRM_DEBUG("reloc dst offset out of bounds\n");
+			ret = -EINVAL;
+			goto out_free_bos;
+		}
+
 		/* reserve and validate the reloc dst bo */
 		if (reloc.reloc_type == QXL_RELOC_TYPE_BO || reloc.src_handle) {
 			ret = qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -204,7 +204,7 @@
 }
 
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
-			      struct qxl_bo *bo, int page_offset)
+			      struct qxl_bo *bo, unsigned long page_offset)
 {
 	unsigned long offset;
 	void *rptr;
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -63,7 +63,7 @@
 int qxl_bo_vmap_locked(struct qxl_bo *bo, struct iosys_map *map);
 int qxl_bo_vunmap_and_unpin(struct qxl_bo *bo);
 void qxl_bo_vunmap_locked(struct qxl_bo *bo);
-void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
+void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, unsigned long page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
 extern struct qxl_bo *qxl_bo_ref(struct qxl_bo *bo);
 extern void qxl_bo_unref(struct qxl_bo **bo);

