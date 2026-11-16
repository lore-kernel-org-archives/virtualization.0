Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825202;
	b=Ivqq+0AjtS/0g9utoZk5N7V062OgYQ38cF/iARNf/5U3p2snJwYi57jgo6mZNn5pcBEd
	 6SkAq9/bgJfuQhq6Lw2oiv3074Z1vxN7yAqolKtqpk+BOmpbBLEyGkAb9mbCbvCs0/6Vx
	 kE6DZrt16nEAQ1DBZIx4TszO9zmEAIOleJ6/JFwA2CvDqmo9+z75eHlzmBIfggl/PxI7l
	 UFKpqWdhfQuqv9u3ptefjmpxh1o3N/BkUiIJPfz2T/VqzpQz+3P7OFnKBN38NTJpRBqcM
	 XNiuAysdeZyNn/pepX/M53ZFxGwb1w4hb3ThH7R+dRxEpbjCm1Gfg0uBmPqO2Uo99mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825202;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fHCFNhOXm/uYkO/gjcQ2RFXJV+23/BKC2Uf0wMQGvlA=;
	b=hwmV1DU18mACCmr2UxXf2BclJai/2lOefnususRSqNFGnWQ0bUMu3nlFHRxOsFK8oIFZ
	 39L0B9HpSH6R+vOrmqYNuGCUMcPwHb2yNIPjdfJJgS6prErUvVKGPWqUdR13cOR1/fcRL
	 ZzETtZLt9EqxWwBBmRhvh8HjxSluqNbReirDNauJqbxELmPt94PyQmJoXp0HOvvo2c3YY
	 F7qCG63JdlSso6DvyAx3nw1gpB681nkkzLgXuIAlmITGco49Tu3xOQmzZLQzn4SAQJ6pj
	 i1jLdMsrx+MUYHZMK54d1ASOIq/Risz8Ioda66nrbcFVhN2hXdIvzaBLsEMcNpSTsbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk1dznKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED41606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk1dznKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CCA1F000C7;
	Mon, 16 Nov 2026 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825202;
	bh=fHCFNhOXm/uYkO/gjcQ2RFXJV+23/BKC2Uf0wMQGvlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vk1dznKIyVAHDHBDqjO0NZOoybDNxeU+WhCY1nobUNC2RFXWTIgUP+lUtFhNuQ9d+
	 8blC3efoqyf4L8U/nflECRTUp25z2xQqfIREfVtgTlzcqkf5mNIEfBn4YTswvqNpqN
	 dJC0emAgzai72uPw+vl/bZccpHizHCEd8qqsMmEIRMu6W1X2QCEk2vEaNl97eWw+w0
	 2+BfgLloHiRANBbAcvcNNe4EGtNhnMYpzKMhmjMcZhxDtzBSvc45rPYLa+b7Fpn1pF
	 JDnfxO10GDTcsZBhnN2/iKQR77bxfbkMtN1ZJb62CD2ni4bnHLki7JZblTbhB5fWBu
	 uAJckbp+KJo3Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:01 +0100
Subject: [PATCH v2 45/64] drm/bochs: Switch to
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
Message-Id: <20261116-drm-no-more-config-reset-v2-45-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=mripard@kernel.org;
 h=from:subject:message-id; bh=syV7m+r0g1QmWayj52KuQM5e2jAr/hXX0qcoDG5vABg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgcLWLicPhDR5HT6895Or1SnlnW23ItUn/zyrA/kP
 MW8IX9ix1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI3BLGhhspYVsObbbl1/3l
 GZEadt/ijdDifeqXmiV/zvsVWGcfVHHSgr9rxepDInsf9Ye7Xls9nbHed3FO72SN27JVHp2HDqg
 9WsLaWL2tdtflR/dUX+vH6OlXqfQ41EvUSAZ+OKa3zVf+21cA
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
@@ -681,13 +681,11 @@ static int bochs_kms_init(struct bochs_device *bochs)
 
 	ret = drm_vblank_init(dev, 1);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(dev);
-
-	return 0;
+	return drm_mode_config_create_initial_state(dev);
 }
 
 /* ---------------------------------------------------------------------- */
 /* drm interface                                                          */
 

-- 
2.56.1

