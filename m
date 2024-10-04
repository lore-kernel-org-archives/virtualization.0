Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACD20FAB8
	for <virtualization@lists.linux.dev>; Fri,  4 Oct 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048716; cv=none; b=bJzfcCHXLvkIc5fd47FNDCofhkUQck8KwejtrS6MTwlQBTJCS8hQi1Sbc93bcDk2OMySiBJKUnXx9yTPzfcLtWB58RJyn2lCM0SxXso2f6fstSBDrimYmbKB+WqITpxNFe4ng69kZN0RxOomAeYx4m2dWDqo8WROn6almeE4ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048716; c=relaxed/simple;
	bh=pKHZFH/Ej/Nl+ncg+maedJ93EJf/kvj5/4vnolIpDs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEAlwxuG9d3FSNvqoiBgxt99SM6CM3EwWVreXPzR8HhQxX7mKVuE9LkyMws1SH5uNXAL3tqzLgyNyJm1yNK26UfHQg2dtA/IbtsVQBAxYLIOzp3HSOMh1crrDhmNBQx6idI3ZTJPciDQkpq9Q3wxjdr+J9GSFhHA6qrxazwQYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k3Qc+wmI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k3Qc+wmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728048713;
	bh=pKHZFH/Ej/Nl+ncg+maedJ93EJf/kvj5/4vnolIpDs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3Qc+wmIDgc4YYRGogDWRKGwnlQkqUoJ3MWCAwK4nqYbyJagchEGLF4a0ExqB4hqR
	 BQaVDKGGA3ycANjq8Wo2FMTNpAtQHW4YZlIJfYv+eFxH48Y4v1/qi9R5pE0LIAWAjI
	 FYdJ+XDhjbh4QN3W7t3XuHpVctDgH8oBDsE4t1zq8LKF4wSqs63xLcCiqeYd/PtPKq
	 Tu1Hi3EhiCsiEJRA/0pFIL9PfPywMPe4510+3lp+5UbbgIVFdX2YpYLMLluxXs6yTy
	 tRKzT5hHWIEZ9wYdZr1XZojZHMe8S9PCWaxy+obB30NLw8kY9L1xYpDSygQjNqL0RJ
	 s+PGKoEYw11Xg==
Received: from localhost.localdomain (unknown [171.76.80.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F65517E35ED;
	Fri,  4 Oct 2024 15:31:50 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	deborah.brouwer@collabora.com,
	dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] drm/ci: refactor software-driver stage jobs
Date: Fri,  4 Oct 2024 19:01:18 +0530
Message-ID: <20241004133126.2436930-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004133126.2436930-1-vignesh.raman@collabora.com>
References: <20241004133126.2436930-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move common job configuration for software-driver
stage jobs to seperate job.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 59 +++++++++++++++----------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 09d8447840e9..81472451ccd1 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -88,6 +88,26 @@
   tags:
     - $RUNNER_TAG
 
+.software-driver:
+  stage: software-driver
+  extends:
+    - .test-gl
+    - .test-rules
+  timeout: "1h30m"
+  tags:
+    - kvm
+  script:
+    - ln -sf $CI_PROJECT_DIR/install /install
+    - mv install/bzImage /lava-files/bzImage
+    - mkdir -p /lib/modules
+    - mkdir -p $CI_PROJECT_DIR/results
+    - ln -sf $CI_PROJECT_DIR/results /results
+    - install/crosvm-runner.sh install/igt_runner.sh
+  needs:
+    - debian/x86_64_test-gl
+    - testing:x86_64
+    - igt:x86_64
+
 .msm-sc7180:
   extends:
     - .lava-igt:arm64
@@ -414,47 +434,16 @@ panfrost:g12b:
     - .panfrost-gpu
 
 virtio_gpu:none:
-  stage: software-driver
-  timeout: "1h30m"
+  extends:
+    - .software-driver
   variables:
     CROSVM_GALLIUM_DRIVER: llvmpipe
     DRIVER_NAME: virtio_gpu
     GPU_VERSION: none
-  extends:
-    - .test-gl
-    - .test-rules
-  tags:
-    - kvm
-  script:
-    - ln -sf $CI_PROJECT_DIR/install /install
-    - mv install/bzImage /lava-files/bzImage
-    - mkdir -p $CI_PROJECT_DIR/results
-    - ln -sf $CI_PROJECT_DIR/results /results
-    - install/crosvm-runner.sh install/igt_runner.sh
-  needs:
-    - debian/x86_64_test-gl
-    - testing:x86_64
-    - igt:x86_64
 
 vkms:none:
-  stage: software-driver
-  timeout: "1h30m"
+  extends:
+    - .software-driver
   variables:
     DRIVER_NAME: vkms
     GPU_VERSION: none
-  extends:
-    - .test-gl
-    - .test-rules
-  tags:
-    - kvm
-  script:
-    - ln -sf $CI_PROJECT_DIR/install /install
-    - mv install/bzImage /lava-files/bzImage
-    - mkdir -p /lib/modules
-    - mkdir -p $CI_PROJECT_DIR/results
-    - ln -sf $CI_PROJECT_DIR/results /results
-    - ./install/crosvm-runner.sh ./install/igt_runner.sh
-  needs:
-    - debian/x86_64_test-gl
-    - testing:x86_64
-    - igt:x86_64
-- 
2.43.0

