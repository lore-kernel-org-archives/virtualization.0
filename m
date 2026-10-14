Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393B3F7884
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998994; cv=none; b=mfz2KtseGAJSkbrF/bamufGChLDFZAsl3QsF5m984BiOGMIQMFXwebgGFJxnLkC7qFrEuJHjVxheJsRdMyAUzBKAOZXc2ujyXFgZtheft3cD66X3hVlWLqPaQt09B3GKcRNElCcQLA+WSJLI69bQPr2OhRrYdPhWQ9XFtCRRVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998994; c=relaxed/simple;
	bh=f1MTrqWhtx/O+ufSaS7ufzMqffILm6+Ds2swPNaq1Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYiDIXeb+zucVNXeBhuTeSF+UUllpS/GgZXdlfJghj9aeETl2cIlc6kb9pe8QsOOUp3z6qalEYKEpHCWZQBhjylQNZRiyZKYGQZLRTao710Y8aLLygZ9Q1jd9ERCwAzS6cBssrJDMA0UWVjBRwS9+ARdOS+WU2P/PMSbprHzsqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHcI5XGv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHcI5XGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852171F000C4;
	Wed, 14 Oct 2026 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998992;
	bh=jT9wZYNzhYW9hE7CCRQJYIUuYN0T5s8pVemrG8Vi1L4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NHcI5XGvrRlqAUf4XdflLpqRjEueKuYfE/HGoMe2CmTOGl9NtpzsRA4RY8LGYPEm8
	 RrQhcC//jVX8iyZSOxHcN1+NeS0A+5eSxKNKQcxTStX74oRmByO0DLPfxtygqQNCHm
	 zOR4qjwY/LmkfnpETlgvOocdKkkI+fK1wPxemro7I8nW2iDIKc4uOI9G8emBATxi/f
	 6Q5Uem6elyZLWHHF4MSV6c6KCnRAQ5bx2WJ1mxLqpCqE53Wzi/tP5/WWCPNo5htaBj
	 lvN8qZ/VlYeS66VanEC/u9P88LiDEItDs5RVf2syuhUA9lQabZ50+QefUQ7br/c04R
	 29TfjUmqQx/EA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:07 +0200
Subject: [PATCH 44/75] drm/tiny: cirrus: Switch to
 drm_atomic_helper_connector_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-44-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=mripard@kernel.org;
 h=from:subject:message-id; bh=f1MTrqWhtx/O+ufSaS7ufzMqffILm6+Ds2swPNaq1Cc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8du8zcMb5xbbf+ipWVxtoNKjR5n8OtrER0mOZ1Le
 FfGTPLpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNxecPYMOeeaJ9BjEaE3if9
 JbNPLDnPVNZrYt9/PXh/SNvSZ0n7ctv/+CuKunD0iZTVX/Nv4dRnrE994pQ8R7shkKvz0rvaiqU
 uWx4cmXp5h+evU5/iAvIflOdOMMgSre/zbz/UVaVru3jfNwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tiny: cirrus connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

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
@@ -448,11 +448,11 @@ static const struct drm_connector_helper_funcs cirrus_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs cirrus_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int cirrus_pipe_init(struct cirrus_device *cirrus)

-- 
2.55.0

