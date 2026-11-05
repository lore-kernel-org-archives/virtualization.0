Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892835;
	b=4kl8nmoCXAHgmU2ExTMfZakidRXs+xhzIpfEUivRXpXF+D/Rz0REicACj0CdfYymtnYb
	 lzQLWtSRgXnBHFW0Suu78xd6k5Ogj6q1qfOw9or8d8DUETbwme05WPWXASFIlJVMYE6ae
	 rU7hWvi+Tln+YXN1XWQNVFY/xYKodr1QJfJ1Ef21QxOYRPu1EV2Nsu9C1ScPniVuGg13W
	 8jV67Uq+wPUcPMjkCzrpbLkyTg52ODx1xIUBPpeOimMkC7VMT16lciewftf4K9CuuaDnJ
	 UmzjlZBFOJTEz+V8Jw42c54emU3eWyaArLjPdGi5AJR/yxuC/ICkotNSHHPigyDTvAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892835;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=edlGyYJBDHhLFdheiJZ6eJh/MNF3LYYEC+B3sWyAQDw=;
	b=LoxvU+wvvqyWK3vSYV1Ng4erIsMGlH6XDFUilHRt+bYvCGO8nQ11otjFa46yOJfEdoPc
	 Rs433P/khH/KftHgfbqMgc7rK/fja+WDsKehUQH/HOyY2ZRWqYcD973niolu8EW4JFqLA
	 Six5MZNH/oOWDLcIV3fHrf9bsD2ktxv3OKcv9Q5cNFuf9Thb/dDy+JuYNonrf9aPARsW3
	 hN0ZkS5xk/PF0Dz1TxLsGYfVHMj5ujEgPu5ln0QGAwzQyHcz1khjIT3ntf2AMeG2yhXxH
	 laijWO6W/9ZPouODLYrPXOEZlGS+AyCE85hrlTwb0OXNoWsLga353h1yKP8xbhawkmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XChvG8gz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA9A606D808
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XChvG8gz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E061F00A18;
	Thu,  5 Nov 2026 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892834;
	bh=edlGyYJBDHhLFdheiJZ6eJh/MNF3LYYEC+B3sWyAQDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XChvG8gzv/rjp6gIxQ63hbSB7K/CE0YnAgp6WxZPMH5OybhgLbZDuuu5DyTfgobDp
	 ARg+wjy8GZdGQxFXXiMttsBRka2l527W7JF3ZddUoKOY5G1T12IFWJKcVN/hK6zLo/
	 8FTDE5KtE4IW2Gwtxi5RjllbdL410JIMWHmgNeDw5YETZoiEQV0MNCPE238TE4tGuk
	 q95Wa7HRULKWbGge9XHTerW9JKqFCPcLcx0iAnDMY/cXmawT1rzA8srAnTVCn17l8Y
	 bobfke9K7W+wsG/Fp7cBeo9y7cfEO8gFCUZonevqAqAxovJGkwnIKYNtArMGvuk89M
	 QROryvsVmXJRg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:10 +0100
Subject: [PATCH RESEND 61/83] drm/bochs: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-61-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZwkBm0UFhP6dWFIKOPO4FQOgIFGw/LVtHuvvpOPp6e8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvzoCl1RO2FL+6ef/0N2NYmmKC52tv3W0KqaOU/v2
 x7hmfxbO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEpq5gbLg85db//gNK/zii
 ki0aX728/Ytx96Oj++Tyv/4/ZTrdzd546VemOVwxS65cV32x83XA9PmM9cVtpi9K9v/XdOji/Xz
 i+6ttahXLGe45RP2bcWFTVs+f2CW/3j14dL1i8fQQJyfLEr7yuwA=
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/bochs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 771d59b92f67..c24adbcb77a3 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -684,7 +684,5 @@ static int bochs_kms_init(struct bochs_device *bochs)
 		return ret;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }
 

-- 
2.55.0

