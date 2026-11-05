Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887906;
	b=dF4FSHo7YplHelyIFE1OhmRsMWIQZ/T7HzvHiFr3HMyLGQz/oBl/QC6FrcOHB2tAHWnK
	 Xj+XXSkp40dLGoGRxhVAeKArd6uG1ySVMlU1FdxyL33+ElNzhdedogS5FGUAy9Wynfmdf
	 LN6aoT1W++I+bEwsCZePY8zS4hOoBekd3RJUEsXM3ytSzHgUCOUflkXfhrQfN0Sdz4/OS
	 BwwlnyTu7jEIV92CzqYHJm0oCxOa5w061bO4deIXfC5T2kv5FL6l9Aj3FUWnb9T+DWiui
	 Ii5yx1K33MI9plYIuSbKaibq5i+DySX7hCHcUjrZPXFMmkJ3hWHwkpElKJQCVRM9inQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887906;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=edlGyYJBDHhLFdheiJZ6eJh/MNF3LYYEC+B3sWyAQDw=;
	b=oDLA3WE/tMxWHQ2lx9Qdo+vCcld8Fkm78PVDaRQ+9iwNliajr11CEfcthCHL8vaO7yL6
	 KzTzU57xBrw2Hy5N4a51LKAcvu51tzPVjAE1RinzgYG6trBT8z/Izg7Q5h6FMXRVtqJjK
	 Jl+t8rNeRrKXnEh1mdhCWJvHgvQUbE52BrqkGD6avINcrqerZBc3JAUqKF640+2SMxMCN
	 Ht6aTqmJp0MFn7zUP4xOb1lkPvsyTTH6BTUiFBknzwgJ3pIVdDtzCS4mh+GX3A8GoLhXU
	 GK1mcntt4tGClNYr5OylT4IrzVbg2vAGseAAggSIufcwVXjkqxR+8U6arbPrL3p/M3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPOMwejQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC2606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPOMwejQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0B1F000C1;
	Thu,  5 Nov 2026 14:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887905;
	bh=edlGyYJBDHhLFdheiJZ6eJh/MNF3LYYEC+B3sWyAQDw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FPOMwejQvoTqKc23ACgiCQWlMWwhO2CYpAnpriMk8Fo7KmV59qDilaoLqhufA/VFb
	 V+1AnSV5bO9CiDqqZFepHC+WDaOSiMEN8J5Zm7KVIq7YISgvykeaQTNNC22gs0eyhd
	 9DtursiIF0nbrwoOjdN3tHw3YqcrKAwAOUhPjH86xMEEGVkNFof/vpXYd3lVMkcE8e
	 n4McIWPIxLXqwcJa63CRSO+OLjiOaKNVlt42LjLoII9Oo1NV67uVdOn/k4Xj9abe1/
	 OzO/Mf7nbGMX1k1lIX0o5Ya9EGVezPCZ+nnk0WXIHiHrmux5Lsa1229LUYo4+r6Yp2
	 QABC27vyvXQFQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:08:18 +0100
Subject: [PATCH 61/83] drm/bochs: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-61-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZwkBm0UFhP6dWFIKOPO4FQOgIFGw/LVtHuvvpOPp6e8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlverfFLt1bocxu3Ma+bev5B89TOmoldiYelzGaYK2Z/
 H6Z9LnMjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR5iDGWlHNDdv6F2at/uTO
 9KUmftU0/zrmx0Xn7v+Om3aW50ye5srJVwqaTZ3u5uwR2aNzTVnYlbHht92kND2GZ7ePuXvNOC9
 T8mjDPKM1snusJ23g2XOMY961RSYrHxj92X3+pt//hxPtzq/OBQA=
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

