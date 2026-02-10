Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730632F770
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707533; cv=none; b=KFsR1vESXb/KfUWlt2dtb/C9AYF7nXPW4y9WfCeN03ZXJ0Jo4NEAyquhN1EcBLsHsUXjBOni8tlvrgpauHaRR59ANIligyCWYHG9y9v8SM4XxbqQx0zuUlxvA4OOnv3Yl83lR7XiLiKwoD9wTgtf/iIKD6ppSJYsVi8pUuZUmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707533; c=relaxed/simple;
	bh=ym1Rv+ZYXUeNZiVef9wVWUIqAo6DlyDa0CHgN1UokO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8nPg3Jae8tJda0Ec9V1hfz1A49EndJmXXOtOx1t1IAAr8lY6dMxq3CLfM77GJmSgZtpc5cNuIyqSrjMiFoMEAA8qyaCYJo9zhvnrFyfzMI/dI1aCqKTT9S2QlJs1kEQaomdXyQVD/yX3l62g/rNsOD5pFwrETKkhiFrnVew0c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HdQufmAc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HdQufmAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770707530;
	bh=ym1Rv+ZYXUeNZiVef9wVWUIqAo6DlyDa0CHgN1UokO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdQufmAchRPnYZOfWoC3MWnrMVwveYzZFq/07hank5B91WfLztat6NcauQBj58gk8
	 /nLoixEt+/I+JDB3hjRXMM233ELFm4MMuHyLs+EzTclulbyh2yr4XR7I2AveP+tHia
	 ysEvWZeAzjkZC3myWwvNJYrEjYEI6INsFcakoYiE2WLP9iTfcKM/LkwDYDXF/8o87d
	 yx5nojVspIWhZh0daBsXaNN7oA8HBstD2mkkfR+h8pFKoGUorRkeK/eLFZvS3eTWJr
	 y36msTxbPitK2ccdrvp2/hbLYzfx9Mi/TNND/jYdj/Fwx6a/9RLHu9pQoWcTv1oBKu
	 wOg0x5NFpBJsg==
Received: from vignesh-thinkpad.. (unknown [171.76.81.211])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18C4D17E150C;
	Tue, 10 Feb 2026 08:12:05 +0100 (CET)
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
Subject: [PATCH v2 2/5] drm/ci: i915: cml: update runner tag
Date: Tue, 10 Feb 2026 12:41:31 +0530
Message-ID: <20260210071138.2256773-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210071138.2256773-1-vignesh.raman@collabora.com>
References: <20260210071138.2256773-1-vignesh.raman@collabora.com>
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
Reviewed-by: Daniel Stone <daniels@collabora.com>
---

v2:
  - No changes.

---
 drivers/gpu/drm/ci/test.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 762598c7db25..af094153d987 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -277,7 +277,7 @@ i915:glk:
 i915:amly:
   extends:
     - .i915
-  parallel: 2
+  parallel: 3
   variables:
     DEVICE_TYPE: asus-C433TA-AJ0005-rammus
     GPU_VERSION: amly
@@ -304,11 +304,11 @@ i915:whl:
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

