Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825135;
	b=salakAkwJ2UHbjYVgmr3bUmjEhjbS5LOmO74FVfhWndSqXf7ChbjmAkyLfafUA5Zlw3F
	 SYgqrz6C3Jljfl7THP3x/lZ3Hyzh5UpFW7fDgBlynHsSoJep/S1cPu2NvxA/7Ng8sBUDX
	 3rcn7xpshBSJcAoOSL+G636N9OU4ASOPp44lMC1IhIv1MUlxESGZxKhEk15rCaSfdxBn2
	 gj3eTV7leu/fyoH1JTGtWQixQ+fY3TNkwFKaHWqFnDxNUZq6J517IxJnmMF9tBQJVbEqD
	 +oW+m6f5vCNSFPo7Ig6FWY5DD4jG6f80W1GsXYtAPlmBpYgn/wrbrllfxXXk/A8iu+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825135;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pjFq6EDPgY5f4kPAGyg538uOYX+N8CLjagOfyk/yf7g=;
	b=QDxM7XEMpvfaq+KKwKIOx5m8DfFb9KTjaV7aazqa/GwFKNhAOit32n3zBZGrS75w/qJM
	 OuT4/lcLj/mjDqWGLO8Oyji3akxmmJYwVxz8J5lnGlz9GHICXZGozxUX2sVf+yGkTZ6mZ
	 6C5/8gF1gyEXbemXcABsHkVQChl7OVqTX0sSueWf+D+Jj1cxUIhpL6R1iuNdi51neHOJn
	 aeiH2DSR6CaY8DxOeHHTixs2bwEWP3SWfhk51dDjyA2zL+WMAyN0DvFEtSMwxfEc+bzl/
	 qtTx3ENtgRlX0pLnPu64mXwzbIP/hGnkbePVft6YrawalKX/zU7CY+nwuGPQ0o+fzqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0i0HRLr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619D606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f0i0HRLr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588881F000C5;
	Mon, 16 Nov 2026 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825134;
	bh=pjFq6EDPgY5f4kPAGyg538uOYX+N8CLjagOfyk/yf7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f0i0HRLrhp/A+WXPHdeSp3/iA0ajf5TcvzuMRqtCGeUgI7r/RGceF8PDDEWwVJf2D
	 p/aJ3uZwp6tvBH2QHahaO25CT9y+L8TWvMBZ/DiFwJ57ISp0uo+br6t4uu2EIEkBlp
	 BTfHQEZXLqMgl0JOWuRTlR+Enw/i1cbRZGNEEhduKILbAARIoSNzTEpaAl6fF/EuHJ
	 vtvKI//L661KdxMhPQzaqJOFwLPQvSBh/yI8b0xniLKvR/EmSK3gw51izh5TPwKaIC
	 QH2smfv+BFhBQ3dexubAOGliAiK7iNqpyHrqtVylcabARYsZ+4xp2g3JXaTidvCmoJ
	 TYIc9hJ2prbPw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:40 +0100
Subject: [PATCH v2 24/64] drm/qxl: Switch to
 drm_mode_config_create_initial_state
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-24-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qcoDHjgeByoBcdECpke5jYHpp91MauW3ylKG3jDmMNc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnvFZAeedWDbe+JdT+8TyV/fwr8eS70gNf/7dI+Io
 5GOm1m2dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJzLnC2PDp3BaDG/YpuT5/
 Joozs12VuXDA7oWLWOnPq+IpDyqca27unCrGsN857rJT6p3ETQdnbGVsWHdpwkzR0teip62fnpy
 1Zd7F9AfVX9Zu66/3M70e9ulH2WPjLdz+F7jXx/Jqr7/6zetAAAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 77fbf3c864cc..361265a0d620 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1310,11 +1310,14 @@ int qxl_modeset_init(struct qxl_device *qdev)
 
 	ret = drm_vblank_init(&qdev->ddev, qxl_num_crtc);
 	if (ret)
 		goto destroy_monitors_object;
 
-	drm_mode_config_reset(&qdev->ddev);
+	ret = drm_mode_config_create_initial_state(&qdev->ddev);
+	if (ret)
+		goto destroy_monitors_object;
+
 	return 0;
 
 destroy_monitors_object:
 	qxl_destroy_monitors_object(qdev);
 	return ret;

-- 
2.56.1

