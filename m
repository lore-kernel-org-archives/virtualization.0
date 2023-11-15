Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A01A278
	for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gutia22Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700054160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8baLtlzsuyZcOKODOHaJ6HAGilgrqHGy9qmPbinQNI=;
	b=gutia22ZRcPr06iK+JRZryWQLqelgKQb73aMfgo4dh/gpVvEMc52f83mS/g6aTnaHtc9Jm
	j3XUALcXUDw7b/1Xqqak2rlwWHDBgTSrN4zyqtqoMM8O8yPmjpbmb9Bu6ZpkPJtGIo/+TT
	f0fzqPNY7Kgte/kCQnNDzX3r3HoHL5o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-GVqoqMitOBeSh_LabhmupA-1; Wed, 15 Nov 2023 08:15:58 -0500
X-MC-Unique: GVqoqMitOBeSh_LabhmupA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408f9cee5e8so43275405e9.0
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 05:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054157; x=1700658957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8baLtlzsuyZcOKODOHaJ6HAGilgrqHGy9qmPbinQNI=;
        b=AlrRkEdGjL6mif27R/d3pmS3y01Cz55v+1zuBWX6tEd4yJvdYnG1msV+/XFObdlXag
         UDZ07nuB4NId6mvd4IFi3s4UbSwCk/vvfLBhbdMU7y+fHdByWuHR0LaN/k7zJE7pCnB7
         q3gxG+NxdAOz1zyLUIW77Aq/mArlJPBNzRGM5IfOoZ+dF/LpCs4QG5IxPDxtgMBMQU06
         RXyP20pVFrDQbxQgGuxnBHRhHUUcWVhPruUgDbMAlMPW/h9KqNM6ZRBr5Bvq8jxluklg
         W2FaVLdvJ+ARqrOFYlvlVm7BDlDnOcd6Svpcpg21jNP0ducyc+sRsXMMUeqNFEr0VdBt
         AN7g==
X-Gm-Message-State: AOJu0Yz8z39VbxC4ZEjxwC6HHpZlKsT9mk3kt5bE86tb0s6syE5jfYj4
	SiPRb85eiY8AXttDmGFk/51S8NQamhJhv3xrbSYIf6E336YO0TsS8OQZV7LdpLG6ETzrngpk9lI
	NCHyQir4jOCldwZWPECVRVBLXG7o=
X-Received: by 2002:a5d:6d89:0:b0:32f:7b14:89d9 with SMTP id l9-20020a5d6d89000000b0032f7b1489d9mr10958286wrs.9.1700054157041;
        Wed, 15 Nov 2023 05:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDaKwJNBk2fEmPyHouSjZgkvyhlK79vrfYZN/upvL8mRJpAtkAcw0QUDFTOK7GVHFogRFeXg==
X-Received: by 2002:a5d:6d89:0:b0:32f:7b14:89d9 with SMTP id l9-20020a5d6d89000000b0032f7b1489d9mr10958258wrs.9.1700054156678;
        Wed, 15 Nov 2023 05:15:56 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b0032fbe5b1e45sm10507123wrv.61.2023.11.15.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Simon Ser <contact@emersion.fr>,
	Erico Nunes <nunes.erico@gmail.com>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	stable@vger.kernel.org,
	nerdopolis <bluescreen_avenger@verizon.net>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date: Wed, 15 Nov 2023 14:15:41 +0100
Message-ID: <20231115131549.2191589-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The driver does per-buffer uploads and needs to force a full plane update
if the plane's attached framebuffer has change since the last page-flip.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..a1ef657eba07 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -79,6 +79,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
+										 plane);
 	bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
 	struct drm_crtc_state *crtc_state;
 	int ret;
@@ -86,6 +88,14 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc))
 		return 0;
 
+	/*
+	 * Ignore damage clips if the framebuffer attached to the plane's state
+	 * has changed since the last plane update (page-flip). In this case, a
+	 * full plane update should happen because uploads are done per-buffer.
+	 */
+	if (old_plane_state->fb != new_plane_state->fb)
+		new_plane_state->ignore_damage_clips = true;
+
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
 	if (IS_ERR(crtc_state))
-- 
2.41.0

