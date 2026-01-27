Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8889734575F
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510679; cv=none; b=pMuw1Y6sbiinSksEVjBP7+wGGjPRNQcBK7V822u56WTQuHViBdItl1R0HycM6ZE8U891pqh+PzZYOdt05fq2waXYbfi4BJj6uAeq0PGpaC4kzghP5ZFAcM+VKscIiRTpQahw7Mq8FHXjQZqzgbOEIGZETo71kjjAytScIfvWWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510679; c=relaxed/simple;
	bh=K2y+JopQp3ML1S2HyFFzzOui07CPYp0h2VnhObjlXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az2QCq5DiOUSscL0RI3SAtuf4LMbcaHD0etaxG3OpnWZrYcgb46n95n8FZyjNLW+ds/O5Da18WJxRCuUM77K1iZcnjVza3A8W48OwZsgGF2tHnfrAnJcEpJI1zSprLJRgNFlSXvWw8iZ/pTMWrIIKpCZFrO+OhqFua4SK/EhGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=okzC/emD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="okzC/emD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1769510675;
	bh=K2y+JopQp3ML1S2HyFFzzOui07CPYp0h2VnhObjlXHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=okzC/emDwg2m0ZwJ8YgnHjUgdkHIkFydWwQPM/eSkAY+6VO8J2a+u5z9puPzvrPIZ
	 7Pac23Coc06sUKA0H7kiY55KdlmLPP/CYsRByx+gFCP2c063eAM4gQycSsZro60+gZ
	 helDi4bzLttqkZq7cPT4eZXukQTEmhDe3OOXE25/m+YnrIxGI3WqpsbmI4r7bMxk5p
	 vqpAn2EUCCPolL/RHhh5Kv1JV/GDtJSeymaYwwbD0FTAHBmKVFtUblmtcEu8r9N59G
	 qzMCMp/xkzjY1BRYJoKZUxQn4IyvPGgys+c6uZNNQhcehtCGx7R0gKAmmCNdpr2M9L
	 Nt6WSXThva+6w==
Received: from vignesh-thinkpad.. (unknown [171.76.81.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 024C517E00AC;
	Tue, 27 Jan 2026 11:44:31 +0100 (CET)
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
Subject: [PATCH v1 4/7] drm/ci: i915: cml: update runner tag
Date: Tue, 27 Jan 2026 16:13:59 +0530
Message-ID: <20260127104406.200505-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127104406.200505-1-vignesh.raman@collabora.com>
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

asus-C436FA-Flip-hatch has fewer devices available in the LAVA lab and
drm-ci uses only 2 DUTs, causing tests to time out. Update drm-ci to
use puff instead of hatch so the tests can run on 5 DUTs.

Also increase parallel count for amly jobs to 3.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 05eccda6bb9e..b7409f8a13a5 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -258,7 +258,7 @@ i915:glk:
 i915:amly:
   extends:
     - .i915
-  parallel: 2
+  parallel: 3
   variables:
     DEVICE_TYPE: asus-C433TA-AJ0005-rammus
     GPU_VERSION: amly
@@ -285,11 +285,11 @@ i915:whl:
 i915:cml:
   extends:
     - .i915
-  parallel: 2
+  parallel: 5
   variables:
-    DEVICE_TYPE: asus-C436FA-Flip-hatch
+    DEVICE_TYPE: acer-chromebox-cxi4-puff
     GPU_VERSION: cml
-    RUNNER_TAG: mesa-ci-x86-64-lava-asus-C436FA-Flip-hatch
+    RUNNER_TAG: mesa-ci-x86-64-lava-acer-chromebox-cxi4-puff
 
 i915:tgl:
   extends:
-- 
2.47.3

