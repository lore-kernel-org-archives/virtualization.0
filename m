Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DE41E6D9
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323245; cv=none; b=gsUDjM1VZbOIn1/V/ls+yJsE4JQ8IvttaL6bJ/cwoVQFWzMeh88lRQ4P3naAr1dCw9JbuHv47O+XA5DMkb4o9vdUBJZ1qmn22e21EAmNKoLfO2OrILHEpi/O0RHxhTXPLJ+LM7t8bQmi9sA4O+AGUkWFRU3QXvW+bQTlieTjQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323245; c=relaxed/simple;
	bh=2vbQazdPBY/m/aSeSEpE7kovE9rAUmvZ8tiHumQ4c6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipZJ0bXyRpu4T1caMvW6qxFs5aYmqDUdo0LJoW7UmsyUBj101hIO+w/yt/GDS1pFw2sBzQcdzcdcN0l0N3vSmccPxL3rVKmRzVy+/IBEOg0rz1jw87Ejngcp+9feV9nyDMFkbZXhCOY+hWlPrDY0B/BxUny4Il/CZmzj14d/+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvk4JkrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvk4JkrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283431F00A3A;
	Fri, 21 Aug 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323239;
	bh=qg/yO4KZoOqSa6/Q6wSjKOg/+it1laiC1fptKV2X8bI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fvk4JkrPwFjY3SBCA0bI5HPVgwbsmIKwtKW3oaQAMB8nd2mWBmhmH3ky75Ky+ZYQk
	 Ox0DqIovnvSC2ZvBTXNlD5GminLsOEywi0FqgHyuRc2r3eiNv1MuxyGeq9aBSIhRIm
	 dqLYcQM8a5kX/KOMxqaQg1t523s4FktkmiAoQwVrbj6Oc5aoSbykIeCxrwKPEUhdN2
	 n5zZsxuLDeGAhksei+nBzVvmy4+7IGdCbgjvALWeV9JjkMqiPdTJvFwABGKoLd5hMy
	 M1Oi8ngGehTA3pBlj8aEKIQ5JcHmncmLGCncZONu76BAN0UBWCSsI9umVd9JbbFj5v
	 aqFtdCrSL4RXA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:08 +0200
Subject: [PATCH 32/70] drm/tiny: bochs: Switch to
 drm_atomic_helper_crtc_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-32-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=mripard@kernel.org;
 h=from:subject:message-id; bh=2vbQazdPBY/m/aSeSEpE7kovE9rAUmvZ8tiHumQ4c6g=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyWwOZ4TEfi3XZDseLxkb89XLdOLMkzWzuOr+avlcP
 rJUXaC4YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwk5jJjQ7/NOeYPceIPxMtj
 iosn//yTHpvK+P7Sxc624oQ+/8irUUnnhYpqfPexswRcXpCruGM9Y32+9iadP/c+sq9NZGdwWFD
 PdEXj09p19z6ca+67/EL+yo25kdxzris0vZgncjSi9Klu7zQA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The bochs crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index e2d957e51505..524d387f1d53 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -548,11 +548,11 @@ static const struct drm_crtc_helper_funcs bochs_crtc_helper_funcs = {
 	.atomic_enable = bochs_crtc_helper_atomic_enable,
 	.atomic_disable = bochs_crtc_helper_atomic_disable,
 };
 
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

