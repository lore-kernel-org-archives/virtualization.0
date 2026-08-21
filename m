Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0150429004
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323218; cv=none; b=i1PtiTzIWxgv7Q+T43rqxr2a51IjoPuycA9xdx7JzVN2/c7xfKJ5nfrEn70slHoFBhZBRuUqjvoQW+kuxUP2nwg41i2IxBPTEEgQ5Aar8PZwNp3+yWRDjEmZ98aXVtqmSk9hQ28vDZga2Biri6/lM+LbmmPxReZgwKwL0Rcky3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323218; c=relaxed/simple;
	bh=uTrkjrzzF/DuDpEbmVjIeu1g1/HcC+KMsTAk14ivBrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irSeXicJTCDc8c1LBRyjlm9ZDNcieFNhFAXeHH9fdLQ+tvGYuHCXNo/dHJKqfmILWze1/vy6ow6+0xtxrZgp7VyamJm4tv+HOGA4G/k5zFc5u1LUXxVreDGWoZaZ0gDEQGBuZCSZt5AFCW3MkTM3EtLmgUCIIRUMHLVbhFI3r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og/Km4nY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og/Km4nY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1059A1F00A3D;
	Fri, 21 Aug 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323208;
	bh=yz488DmJnWVCw38MVen1WG9InBfyBikaSqjImiSrV6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Og/Km4nYIcfbL3w2u92aLsSzKoJTyLqgVIqEnKyIeg5PoNp6JNalR5fabgx/xV96f
	 rwtQziSueLHNB8WAy65330U/rZ1ZBUlPq6zoA/8H/dZV45e20auvdpyvyDKwdDXGzV
	 wCR65MIBbla9M2pF/I0vOT3ygrrkR7yoNbc0LfLL0mQKcwyYWvVILenh9V6T3V0qPx
	 wXzohugV63aD/HcQK1Z7gT/V+uzb3vyVPfrngwL68Ak1MaoFkqPEuhcQjaWb6FHQFk
	 +eeJ/Sj0SUdiSG6wd8m6WmRUc0+7uZ+GIr+qjiOmQnn71BEQ7TluZ0uB3ByhAbd8hA
	 2TnEHqIZUYi5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:55 +0200
Subject: [PATCH 19/70] drm/qxl: Switch to
 drm_atomic_helper_crtc_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-19-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uTrkjrzzF/DuDpEbmVjIeu1g1/HcC+KMsTAk14ivBrc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyQzBK/52eSS7htXOn97GtPdphsTajoaVtt9NUtZmL
 TbUzm/umMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOZEsDY0OVYur8r6fvCotgY
 NkmWSnlf3/CTk08fLkh/uVZq15LK1HVGokHZXbd/vvOZdush179FjA2fFm55eql7Tcn7jIlCG3b
 v7GYye/JqiXxzrdX0P8m++ULqEy2zcvhSjm9dlPnvaHSUvCoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The qxl crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 7f4178800afd..7654575bcf00 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -416,11 +416,11 @@ static void qxl_crtc_destroy(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs qxl_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = qxl_crtc_destroy,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 

-- 
2.55.0

