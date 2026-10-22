Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672546;
	b=nU2fySdGrEYcWEemPMEgiqBvRdzvoUC23vpgxjgNOYcmeLVb/akk/zN+BMYEm36yRR0H
	 5/lpoqZymjRBJiieFqnKBBfs3B6lFoDK9msfa2ym47qL13kjhVQQt6tmd0+OxmGGQiCHB
	 g9F6UupyY53FnF24MwHkabtrQqY+SxxgyxSWz3at98vgWPmct5q5MBSka1Sjww13qf4ud
	 H9mlTYLskAo20pD5EB2TAUnMw48KFcuNPc1M2Uft1fDZwcrABGpz8Er3pQuhDIuyn0DbP
	 Uvzx4JKRcU86Vm+5Yu+7yv8YFQN05EDMXEipwVNG8nIZ064I32N3MSmHye1NIpJ2wpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672546;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YRoB4ogbv0Ss8dehNXTI8nfyGIauqhXYFuZYYvdD0Jo=;
	b=n3jcDA7lE/QhohSJLfQzy6S6zz+6mR5engRUaDg4rBxvgcumJCdOh9ko5v2VA65Uy6BC
	 qpgAp4Svz4DMipBf5X+ByR8RofAoQR6YuxZjwsPnlh4zY/BWPtpFvg4o3HzHTUawN/EBs
	 S3J3Q3xCZAwYcjlvdPoKmezOMxy3O97nklXZ/VLtD+bTH/VWk8mIFNhZ3AyB1U8qbIweZ
	 Ngc7GRaqtpV2iTyMCaOHJZ0gL0t/b4sy3PXrtI/D08kLaZ1V2yaIsTsXt28Ct2ydwygLM
	 ml81ZKDepuMp2+9IeCKMLCabq+j8C7u4NXoD7vIgoIBzzpVi5nCLMYBRJSSuhRXNrJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wbtz2SyX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECF606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wbtz2SyX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057F71F000C1;
	Thu, 22 Oct 2026 12:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672545;
	bh=YRoB4ogbv0Ss8dehNXTI8nfyGIauqhXYFuZYYvdD0Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wbtz2SyX+VHkkl6wC5KbRqU2nniqWXEDhAazlzCTUyUJmbgtOgy62pqJIet9T08tK
	 tFrJdGVcUFboVIiYaOvZbamUo0whamoVuX76qx5EY2GSXcWOfwLMLg2ZfvvjPBQbrm
	 qqluetK0s/uUp0bWW4kts6zYSEINOahCmY4SQo9423G+yxwNR36lTYdsfY8ZYCyS2z
	 yWCZwZ0DoV5usvQeyEOy8CYzWZWZFstNvficx3x2ieZbMDymQM1bMuhX4LJ3RldWZH
	 E2+R+KW4Yz1DCeuXSGYKmDJIUSByVyKNc8m3UR0j+1+1bM3T1+gASLQnKdv3cTJ87Q
	 RCT+Ln7PIizFQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:32 +0200
Subject: [PATCH v2 33/59] drm/tiny: bochs: Switch to
 drm_atomic_helper_connector_create_state
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
Message-Id: <20261022-drm-no-more-connector-reset-v2-33-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=mripard@kernel.org;
 h=from:subject:message-id; bh=IiX6+qClW817fYH4UcTFlEcGfIoD7q1palqhTLImnK4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOYwpxms7a0o23W9J3d9z8bnOjGeB62n6DnuE5UXy
 olMuNfeMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyhIWxYZG9kbZlperMJKWw
 P1XbdJ8qnbs2W6q6O8GC5+6BfzfOpM6+v3V/mfgKtyfxpU8To82eMtYK+LjeCRHUzhDbYHvQwl5
 v3oObV14kC+R0L2hcmr40pKtWwe4mR6Jr/7ttcb5v7sk2pwAA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tiny: bochs connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1..771d59b92f67 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -593,5 +593,5 @@ static const struct drm_connector_funcs bochs_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

