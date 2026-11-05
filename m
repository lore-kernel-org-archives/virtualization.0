Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892737;
	b=PfTsXzugpijJ5GN2xPwMNy4oLknMj+j9wxm5o11GaiIXxSplK/sewYk2JUA5kNMdsBHx
	 VrwyMXaaBO9rxv8K5BIBGI2/Rvc5dC4ZHhvEX5jJne5A1Wi0rbIv6QDvymDVcvjcj6GFW
	 bDnK7K4asfgHpaOr87FnFzhQzqp+ke+AFTjib6xAzIOYoyXwb4IofMjPp2oOoXVJrvtqO
	 rU1R6OerMDumH0JM1UlYfIjotZPlKDV6g5phrYrSLBYgz+NC4Jkfl9uJdZJqqyxoL2aZG
	 DqYHBbOkBsoSiPb45lDZykwhurIfI/nnk4nRgm3Wg9qXB7RfM0uWew5fUrD17X4M4AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892737;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/+2ONKaoV6IzTGGYYJW55T5A5jiTSV5R4wIry1IrHGM=;
	b=3oUT1VD1SXQzEP9DCR0wNGpMieYE68g8UGpy+rHZ3BSlqWuk/0ZXu0W10ybC4XjVNvzE
	 ZBvO4ZEySDPS2b9Xf6IZECnMPvhJEaUg130Xeekkf9OuQKFby+anF1Afi7Ve0d1tyLuK3
	 pQWUUfu9jVmun6Z2GCcZHAeFvOKCcAb5FCykota0SEs6gwoLwGvXGpj5s/+IuNtA3a/b9
	 ekgQpMyFIFbEdhwaVYFpwlOp+ELlNiSm1dFlKqVWcs47ncwbKvvZafc+AEdVPxacN/juY
	 FMLn0NF1XYJ5Vo6mTPBGyM/bwWktpF4BlXAPtHlq1h5gVEPTWQ7piE0bmCi1wh3J6nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHdINUqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51725606D811
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHdINUqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B441F0093A;
	Thu,  5 Nov 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892737;
	bh=/+2ONKaoV6IzTGGYYJW55T5A5jiTSV5R4wIry1IrHGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WHdINUqXA+ytlBTNW2HcUWvF37mYNxOCxmppJlshV2Vy/K0MHPeW7os4SizfZAFZ5
	 VFnJg9znLqG4fr85IKe58111czMMvjXB7KNtaf+pidFrYT6GDGH3hjTtedFHy9zVRe
	 UAKvO1ineh++Nz9QgVBmifiER4ivZvNHiBmGhN0frkwGotynYmAl3HbwHLQ9WaV7gj
	 i0gpCgneryA6L0EGBc0kVdc7+4oWFR+EOZw4zQC6mX5QimpcFpghT4X8KNiTaLp8NO
	 j31UlsAoqH1x1vKcdHGRPwjURl/4QBlKhIvCoC+8QAjceR4GF0do0ZlIDn+ShXfTFO
	 7wEcz/o8U5Wjw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:43 +0100
Subject: [PATCH RESEND 34/83] drm/qxl: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-34-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ldl6ijul3QdFV66wGmaDh7N43eVOWOlaVmdgUZ+Lwn0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrxhX2ecOfXSpkMmjh+rG/e6/a1Umau09ddizYAu1
 VK5I9IGHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAit08yNvwPOXxL68PjzTf9
 du/P2Hr/8NpMjaPzXz86yxa4avGqJc7GvlMPzNld7zDdcwv/r46/D+wYG/bmRKXmVXAEf/MPY5W
 3f/BtagLLVr3TE97e1+zw5vn+xqLxFFd8DPv8WaK/np7jeC5zEwA=
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
 drivers/gpu/drm/qxl/qxl_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 204c47d61373..7f719e200d31 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1313,6 +1313,5 @@ int qxl_modeset_init(struct qxl_device *qdev)
 		return ret;
 
-	drm_mode_config_reset(&qdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(&qdev->ddev);
 }
 

-- 
2.55.0

