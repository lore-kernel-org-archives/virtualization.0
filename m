Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335C5625E4
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999031; cv=none; b=bm5WMMwciT9vqfrqRR8PkN9o9FGRJR8h/gomTBCHNfn32gyVAmUizW4VVuiU8YYyzvtC1QN6c3LHPSfTiWOdKxDV0c8ikCVXb7oXaVm9+mQsUNJtC8AWaNua5u3XY9Dk/kweqXeE45duOSGPpGi2JFK2VW86dCkBHJYR0byc4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999031; c=relaxed/simple;
	bh=kGMdDttyNhDYgu9OXIpibrgOeAy+z20/ZBmsJbJHIHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLrPaQEeUANpo/ftKfHq9JoZjQZI4CV7Dwq1yKYLB2boNTevXDN2jOlG8yccExff61zKaYDfYIeuO0OXUaYYz4sZkPrWS/xenVxVdWpSZ5adYmON5AxJdZSMrODAIsSDvyes4Dt5dkV9KQuGaREEeRp0g3mgnfbo+zqq6N5pP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHH+iYzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHH+iYzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF881F000C4;
	Wed, 14 Oct 2026 17:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999021;
	bh=zRJQ8BGMbAOnp/rvE0+RdIyNcCA0jD4VwebdD+8Nq5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XHH+iYzMSctBIjX6cYXRXVwKRtFXsZ/yD0N4/RdPx2Abg80YEN3p+CTLU+OUs1uzt
	 EJbMkUKGk1cj5eFuesx0t9RgaiIgCAtw9Ea0Gr/Ugi+5SBiqGmEyQSUsmursVofM2l
	 gAapX2oTRW2bQeN57IFKUti6Ll0nIocwZ2uhmpnsHJPGq8TYwLx7vljS4ovufBlBr2
	 s8jxNKDnN4ejw+d81ZtHxTr4cWK8RMtnD+8nXQvA04PW1QGWON8MhXN86PEGnuOiPy
	 +8JRO20LLzbK0/s1SVDUOBQsqap6NKp1S13GiD8RF6k7MuYaCCt4OFSwwaU5vw6W5S
	 rcnbYEQ/ix7xg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:15 +0200
Subject: [PATCH 52/75] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-52-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kGMdDttyNhDYgu9OXIpibrgOeAy+z20/ZBmsJbJHIHI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndyeufbk0WcuV9aHkDYbHMvIHBdjm/MrWnfLhisGT3
 XWn0xXkOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvixibNjWvXvpV6PQiuwF
 s9TOftC1ubM3U7pcMsqx0etmwU5PddHIE7zXNoZ8+PbCfUvly/VySxkbvjxfEa3h88XjzMM+c93
 fD7tlojdZGj+6edH64qPX1afa7ofc+3XV+qWXueIjY+7Q3PQkAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The virtio connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index b60aab07e78d..f0ed9bd27a91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -268,11 +268,11 @@ static void virtio_gpu_conn_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.detect = virtio_gpu_conn_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = virtio_gpu_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)

-- 
2.55.0

