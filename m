Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857114C9012
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323250; cv=none; b=CJyJBjf3Y26kHr2LsACGHGzoxB0XCr4pmkC9Yr8bh1WeKEhqMRAbatYE5q8uPeDQSS3WHq6zwt5+L8YmWMwHqlbWyeWDj4k4l4KxJ7RrGI4+byYBhEQZZcGcP4Io4MQr9dCoOJvQUyncsugU037xsxnGCO+cGYWIdAPzn4QUjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323250; c=relaxed/simple;
	bh=Lq3nj6xay6Mqg6NTUKSgPhoi9gnhcfzvOTjDBRIWURI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DlogllzBEFepayBhV4pSjgNVMsZr+ZgART3fyuHxJz8w1IJSEHHCzRKcHIFm9j5ysdCMU95PuGUIA4AIa991RTYVIRCJMOFPqnew3Rq06qK0AZDOoOPdP04Nk8mUqPHF34chMJxO/LeLwewM0O+hQh9y736B3K5mjCdXOz++9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsQ3gLEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsQ3gLEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4F01F000E9;
	Fri, 21 Aug 2026 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323242;
	bh=s6gprrgeHxv5WYf7Q409m/tC4l9erXZiKKMa9aFS4MY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WsQ3gLEZzFEadLSkFPsXkwdeQpF9SP7kOdxbYtP3H7hNDgNlgkFfKxj3d3i+Oikl+
	 AXGbadcrw1JXn56+xtj9754UEFtB2g1L9fss5kufQGhvL8SsZ3qcRM4b3li61z2fHr
	 5c/6tWzLeqnGMqTOKHywIgj+LCURl7J4qGG2m2N227d4Yh9cwLfwYC7fa8I9r8JlDB
	 Y7CksP04UkH2a+U2vwJYzPWSoTPU2/XG2BJ0wvTXC7CUjjA9u2zXbIOkgCluuYzea0
	 wyH1zOM6YuJmd2eqfXM3P0t0aSFLGZhtA+yGpIS4gwzdtlWXzqhZm4lTYczvj0YelN
	 tQLerN5Ao25Jw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:09 +0200
Subject: [PATCH 33/70] drm/tiny: cirrus: Switch to
 drm_atomic_helper_crtc_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-33-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Lq3nj6xay6Mqg6NTUKSgPhoi9gnhcfzvOTjDBRIWURI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyey6Ofkbv/P07V7ss+CXy22nhpKGO/vmBt67zaM72
 erQBcspHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiuq2M9fkbpcsm3Xgqe49J
 e9ncZWpaR1Zy6F9Re/Xaa+97UZlf92pVbkR1LX9659KHWVHTxIxTihjrU4x3pU5a+W9j8qobLx5
 U7N7NHX+u8tykKbOjn0Tddmwx8vv1XWV7czODm6V9cpNQ0up+AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The cirrus crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 075221b431d3..73516f631e0b 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -417,11 +417,11 @@ static const struct drm_crtc_helper_funcs cirrus_crtc_helper_funcs = {
 	.atomic_enable = cirrus_crtc_helper_atomic_enable,
 	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
 static const struct drm_crtc_funcs cirrus_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

