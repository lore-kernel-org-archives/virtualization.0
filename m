Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FEA1D9A70
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998991; cv=none; b=DXDKTKXeOt0K7z38PFjfDMsemahJeGSLvmfSG4GVo3xmojFcJZNpGo8u7WX0tnPBmx85svcpYCJsEqVRB5EI6MmXIuS+9C3MjgNqjdc7RH0Muvprq1sh0gawPR2yxpIxOCgBil5jEvGbRWHkSPJqhZmrkLNmRR7dGZAVj5njTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998991; c=relaxed/simple;
	bh=BXmAQ18Ly3tUsjFv7E8tgnouUnBe4OS3FqA1yU03lmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeIBn1F0Xz28FH3G1h4CqZeqVcJoLHhHtGpNGFUoSRYYjzDUWViscmDQVUxKswXjkidV5w47CrhAG6o/G/DVyRlprpdAxPJibE0LmGMmhFD1ZVGOvhppSamMQFAUZVOSGcb+nx9JkX+Hl0QV/8kGWHv57IRxchySkffHLFZScKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU+BZts0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU+BZts0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01221F000C4;
	Wed, 14 Oct 2026 17:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998988;
	bh=6ueo7xEMpBoUCoYe7wcZjVjNlQBQrogcrtWCFrFGW3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BU+BZts06W3eNCN5D0cXsBZb9xDaxfkpKRSedAsAv5pz8nSx25tx1gojJMKu2oyiD
	 CoWrRnAOpxKXPnv2TYAild+fA9pXZMMqmsqe5DPy+cKitcAU5GHcFooJomkGg/bwKh
	 07DVYSVwMhI9JnFfZaL+KixX2dy/Hy9T4DQyu4/Q4wt41J1dVObA5WVwx1lYgeePmO
	 za7SPNdYgIjf+D/i96KarAtODBjE9s6m9ENAG7TUYZCl63F1wzzhRfIhTBufwNNJeb
	 kSAGQ6nQS5WaYn6vnUc4a2zVwQHOXIecNpMlgpdl55enJz1zEp9tL5fH3rTFSa9bwi
	 ZVfSZx1tp2sTw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:06 +0200
Subject: [PATCH 43/75] drm/tiny: bochs: Switch to
 drm_atomic_helper_connector_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-43-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BXmAQ18Ly3tUsjFv7E8tgnouUnBe4OS3FqA1yU03lmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8daylS/miQw9Yi3kGOMgEf2zPNCy9dUWUWftDW/2
 8G1V+VYx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI80XGhrs2i4M6I15Nm3hv
 tdIK0Q4R7nyJTtH4TU8uFL28bLXNRzty8d7MCs344yrn3Z33ONrFMzY8zjW/LBtixnN05pMTcmG
 7DPkeJheeDHqzrWKR3vu07oTuzXVXexY+f97zKEwwJrSwQhgA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tiny: bochs connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

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
@@ -590,11 +590,11 @@ static const struct drm_connector_helper_funcs bochs_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs bochs_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static enum drm_mode_status bochs_mode_config_mode_valid(struct drm_device *dev,

-- 
2.55.0

