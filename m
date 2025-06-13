Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A51481C4
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820859; cv=none; b=nVT5BDreGFzLw/rxrl84qlHdcEmC2v3hbzvJxxIxCd2pu1nqhKo2RgMGj0UXvpeZqDctAl+U5x4lIX9oG6m5he8V1TOGMi4P++X5/ajqjz/KTV9otwDkqsQjzu8WfVa8ICiNgZIqWBaKeSOPk8T/9F9HmUyRmiz4jTzLe7xtGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820859; c=relaxed/simple;
	bh=cprFsDhlPvg9I3voB75Z5llSh0d1SD1azopoEw6opfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=sf2J9SgDO4uBlkPiOxZxFb0Ije4NiJ9Nw0hXtEbrkPfShmOX6f46yKqkAyY7X+jkNDF4KrqSDdSiZ3Fsdv6hHMm5sYwfMPkFnPJeb5WQEwf156LNIHfsqt+d9lmbnycCkMdEsEysbOvGzZdFn0vU2DhA2FrWjPx9Da6gq+Hohyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrJ/euOH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrJ/euOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749820857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfsl7na8vBkAH1D5HNAgOxCb5PMcLNTUrB21akYCqLA=;
	b=WrJ/euOHDd3/zEJCOavNps/YdlK9Ykyn5VrUVPiYHrat8j75enc0CRnJ9qx25GGZCGpM8n
	oVGiLLM2Q6KMvJUBLt3iHRZhGpZrkCoXGKHNdFir6TgkZi4I1y3felrEfXVGUvVBubZ+Pv
	FcaDmD/i3NC15++W3tFOMpvUAgmilB8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-uT1fAlVgMImDm_421kQaQA-1; Fri, 13 Jun 2025 09:20:56 -0400
X-MC-Unique: uT1fAlVgMImDm_421kQaQA-1
X-Mimecast-MFC-AGG-ID: uT1fAlVgMImDm_421kQaQA_1749820855
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b00e4358a34so1425518a12.0
        for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 06:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749820855; x=1750425655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfsl7na8vBkAH1D5HNAgOxCb5PMcLNTUrB21akYCqLA=;
        b=niaVtQk7K8D/71KGS39a6a6G1VXqKwC5MDT4NFXYqkEfZyhhF36A3nFMb74tERFsY5
         8TOCNgWbC84l7ZB1F4ZgptyuM/+8qMdYlLXnjddoIEbCiXc7PUkII4AmzFyyhQ8820f6
         mi+z+0qokxK+HcR1GdTR8O1SXXjsJh5jc1sijyZht56dS4R+3JGxISaVi3rFL4RzMKyP
         sL1K51nFNnJ7uQBMrKyo0br53BuYHM2fZ6q3cp2RY6css122Hom9vmJQrlFCxP90lJ8m
         0dvefvaTDtTsbylqn8AnnR7umfYHQfPzCp3E/uJJbSg7mIaTdSxABPQpmXihW5th6Kvg
         xOVg==
X-Forwarded-Encrypted: i=1; AJvYcCWtrGpbaXAerf6xooz/wUMAO5wWZMftmW6lvX+x93Q7rwJ8x44MM4t5chFz14d0sdUk5GJY8apwoi6rh30XHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO9E1b08d2RnJeEAX/d4SwWpdB+ch4QAD8ONXk1uu2EDq8pwkj
	7xfLMBWl9Qp43zpzqo+1Wxy2yT5TpIkk17Md1uzWbxvBCxxslDpN8ujhzZrPPGwkY6OknkvvyVR
	o651CTra8paBeiPnsD3b0aYEGkR3w216pp2beuOJj52DFEIBlu8Ql5z05USYC3jDDYvWl
X-Gm-Gg: ASbGncvUA1ak5J0GM+NCbO5jj+pzQzzEYD4JkjTJQIM2Szgh+lOjjLIWR1OixR3bVrH
	6r9fgw+d9IXBjDkF17pEkz9VteWyUCkLCcBPCx4idPYEVxRd+ttXjzfpvwJbl8pGt057Kd+Ma3J
	EPytkvAWEBpPPD+zThMQ1FXoVB3iFM7WfFQtVQJnWHh0YAiHkdyEfvwfOdjA8UsXmiu7svWJvUJ
	UxtP+sXPD9+ivvVqq120tI21LWvLHTy05cpeaDSn6N06iIPODlf5i4bxZ50NM/h4A8voW/W5Jl1
	jblJ7XBicA0Hdy9kBm8=
X-Received: by 2002:a05:6a20:e196:b0:21f:775d:107e with SMTP id adf61e73a8af0-21facb26c8dmr3968609637.17.1749820854902;
        Fri, 13 Jun 2025 06:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE223H+TJ8TXd6oDEioev4iMoI2/YxUX5Dfw+NXpEW25126CIcGpxhbG1+TbmG1LTliCo7ulA==
X-Received: by 2002:a05:6a20:e196:b0:21f:775d:107e with SMTP id adf61e73a8af0-21facb26c8dmr3968563637.17.1749820854422;
        Fri, 13 Jun 2025 06:20:54 -0700 (PDT)
Received: from zeus.. ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1643e9esm1651732a12.25.2025.06.13.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:20:53 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-next] drm/bochs: Add support for drm_panic
Date: Fri, 13 Jun 2025 22:20:14 +0900
Message-ID: <20250613132023.106946-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oMRVcB2WMYJkeQ00mgTfUXPbH7L_MJGpaoTi9yXb1g8_1749820855
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add drm_panic moudle for bochs drm so that panic screen can be displayed
on panic.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/tiny/bochs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8706763af8fb..ed42ad5c4927 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -19,6 +19,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_module.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
 
@@ -469,10 +470,28 @@ static void bochs_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	bochs_hw_setformat(bochs, fb->format);
 }
 
+static int bochs_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
+							  struct drm_scanout_buffer *sb)
+{
+	struct bochs_device *bochs = to_bochs_device(plane->dev);
+	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(bochs->fb_map);
+
+	if (plane->state && plane->state->fb) {
+		sb->format = plane->state->fb->format;
+		sb->width = plane->state->fb->width;
+		sb->height = plane->state->fb->height;
+		sb->pitch[0] = plane->state->fb->pitches[0];
+		sb->map[0] = map;
+		return 0;
+	}
+	return -ENODEV;
+}
+
 static const struct drm_plane_helper_funcs bochs_primary_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 	.atomic_check = bochs_primary_plane_helper_atomic_check,
 	.atomic_update = bochs_primary_plane_helper_atomic_update,
+	.get_scanout_buffer = bochs_primary_plane_helper_get_scanout_buffer,
 };
 
 static const struct drm_plane_funcs bochs_primary_plane_funcs = {

base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.49.0

