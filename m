Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F15344DAA
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510674; cv=none; b=eye5ZIEtsc7wFcclR4MRqRP0yNMRBwjVnnMLzkNBb1ulmxfeuxUqNI6HEkw7aPbGnUIbX0TCC6r7tzZxlDC29EKxhQZ/JvJX0njwA2bn8ukJcMbbtOiQ9trCRNGcoX/mYowc854sLClp8auOFrmhMZ0IuIp4lCfOBy95uPhHnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510674; c=relaxed/simple;
	bh=amghtbTgMVRqGK2Q18rOlkKA8D2jlojijDT68se66Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kujwiKS5BnEb13STx5aFzZSTFUygSR1b9pmnn9VQyxGDdfYk8Ah+1sI8N8j4CW2hEIWCmh0YtvyKLr/Neet0t2pOVRlKs8l1i8Cg5P1yBSdQX7Gc9h1j7B1Leh8Izj12SOJoxIwXAwhmG9yzdadETtB+WPZX1pbcOejMsCeKEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AXD5bvGp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AXD5bvGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769510671;
	bh=amghtbTgMVRqGK2Q18rOlkKA8D2jlojijDT68se66Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXD5bvGpt/F0r9E4jvJRKM/tuEXEAXbY0jvh9xi/Zvgeos+YVfF+94h52HzoRZhQS
	 91hRoX7xzdoMrv7x3LiqU1KEjy/gChTcRQrfJNdXhzquRyiLVEQEw4kcb6x6WUtVDr
	 3/lBoXrOZnJxp+EfqUi5dG6LaYmz4TXBp9jA6N+Hvi0rOrK30pdUuWGbsji3UPpyyi
	 kB3ywe2pnUQziXBiANARrDK4qBCxNgWzFHanLHYhsOBN8M6IAoR/18vEeVwq01e6Xn
	 NpJTOTS4Bmqt0VhsGKGXS4nQNdxTbROXlJbTu/mh5vD0ZS4twVggsXmO8TytBz3mnj
	 aDiIS4MFBqzqg==
Received: from vignesh-thinkpad.. (unknown [171.76.81.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 96B1217E1274;
	Tue, 27 Jan 2026 11:44:27 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com,
	lumag@kernel.org,
	robdclark@gmail.com,
	robin.clark@oss.qualcomm.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] drm/ci: reduce sm8350-hdk parallel jobs from 4 to 2
Date: Tue, 27 Jan 2026 16:13:58 +0530
Message-ID: <20260127104406.200505-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127104406.200505-1-vignesh.raman@collabora.com>
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sm8350-hdk jobs are short and each test takes around 2–3 minutes and
the full job completes in about 10 minutes. Running 4 parallel jobs uses
4 devices at once, which is not needed. Set parallel to 2 to reduce
device usage.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 84153aa2ad68..05eccda6bb9e 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -160,7 +160,7 @@ msm:sm8350-hdk:
   extends:
     - .lava-igt:arm64
   stage: msm
-  parallel: 4
+  parallel: 2
   variables:
     BOOT_METHOD: fastboot
     DEVICE_TYPE: sm8350-hdk
-- 
2.47.3

