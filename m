Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672549;
	b=Z8msFspaLKi23owbU6G0gIi9toaPiE3ZjDRn+iEwChWa8mUccyF3CbGBPQGABUggg8Bv
	 j3LxD/57gQYnL5cSqzNc2j+JAQa5Qc4lNA+/Hg5NBv5+RQtwgWSqowcRpx25D85NSJan7
	 OXb1suSh+vXXChTV0xtUEe5lQ2NXU36GL4Lyajl0+MAZiTBPQqCoWCY5r/6EUFpg+jaI0
	 hcxqQJcGKhw65zpBQIvoaya/qHV/fNQXhB6ltuFBkFjPnxjiSHcD+zMuOo7LWT0Oc9GZD
	 UJzmIr+lJ9CM5e8oII6nM56lh1tS3mHSb5WKYG3F18SgiPX32U553/jHyua8DXLqa+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672549;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=M/Ejr6jZmsNkQJvBJrviI9RjCHIkd8k5n/e+qs9q3yI=;
	b=scli6JNnsRQ0dDY/NUy+eKOMASnkjiulh8dDEymI6bf8YzXWKnsuGxa+4yXakWhqkme+
	 e1zxqw6Ap4BpQaBBDgxvR7bLg3Gy8tuLweWyRvLEUp0prwLLoxqDmsqgOCf16HlDG+x9i
	 GaMIza7jYuhNBgEiYjeZj8hvpswW+ZBPCzZCuTouadhWnueUDPdmQXSxEtUoLDouUUo6X
	 IbPo+vW9DlxlQ721jpJNthkEjgO0aZKoYPbgPCRq3cvti4S9NG3OVJk/xF/z+kcxq6yDF
	 MH893+dJkq7CUIaKgTfiQge/W62CmbIJ9yttvlxF+4S2t772E/BTybjBtjLbWjIIFzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxM9IMcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550C606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxM9IMcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B387F1F000C1;
	Thu, 22 Oct 2026 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672549;
	bh=M/Ejr6jZmsNkQJvBJrviI9RjCHIkd8k5n/e+qs9q3yI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fxM9IMcOvW/P5dOvhN/mLka9mq6qjRgF6v2v+yAYsebDgEutZYzBJSfVYfeK1Rgsh
	 w6mLDfKfM00C3qoZwAz8mPOyzOFpwQB9ilXwKVGVbVuUmvsyMWsY8OtmYkFgpm7/O6
	 n8oD+yH73VOUf31Hb2+S8tcs4vJoqYRtx2nZu9z3m41V4da6L67BPST699b1hX4k5m
	 gVFH3NydMdsuVLjz96IMUatd5NUm7aI1OVOBR3tPCkxDbEN/H0W8l/AwKny7gAomVw
	 SS9z3MP4Pal9w/x2QG/1a2oOscdj2ID0KmDlno1cHBwIktYOZC/gLUMlt4wM33YtGG
	 wi8Ma8QJ6DZow==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:33 +0200
Subject: [PATCH v2 34/59] drm/tiny: cirrus: Switch to
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
Message-Id: <20261022-drm-no-more-connector-reset-v2-34-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=mripard@kernel.org;
 h=from:subject:message-id; bh=D3XE86b8xjYf5OXrtEhX3Rm4gnpwQoQaWjge25eOHTo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOZsfJtmKFiYIb7b4IvF7mBeXbY6lgN1Bfpya7yuu
 27KtufpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABO5foCxvnLTTlH+PL9MKesg
 XlXdTm+9DWUrcuedT+6WveF/YMnb58vZTSfVdLyeE2u1d1F0a3InYzXb8tRPO1J4mzy2666Tsnu
 a0O+ZvvPN2ydb5ji9WZ2yyuPQ8zsbJ3lXdnROq1GteRvN3w4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tiny: cirrus connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 63c242e25662..9e3051b9c3f7 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -451,5 +451,5 @@ static const struct drm_connector_funcs cirrus_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

