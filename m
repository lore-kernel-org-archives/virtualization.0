Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F41CA96
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845419; cv=none; b=hCEw0SRk9u7Oz2oTP8iYeH2zD5+XgPNOWmySw7ZRxQzw757kpDm241tTqLlpgkGrBvy3JFGI/G9chZP/c34rgvsBBcQhM5C9DiGFsv/hPe87U5BHkF9RHseMViF+DoKUctggB0cgRY1zcDHvke6mODuT+0WesmftsPH+rWff1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845419; c=relaxed/simple;
	bh=0It0Qs3oLGL49eT+4lgJbtyH9jMymo8SfQKGBHrJpCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5ieNMP3tAKt0pPMZXSavKEXDb41DFCyRQV1iIgCd6HbNRJEnuqSPtCzeGYeM+XVkt88MvbKTPFLNYziX3SN3do+IKqbTOPsxstikwSbtN/NpVP+B5OlLNGMcPma8vVsz5Ic7P/+8A2dbZBpLMuTay58O2drGBPtAP064DtRHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZeZIBc5J; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZeZIBc5J"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F58A400D5
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VT8ZVRtqpIN0 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Apr 2024 04:10:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A115400DF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A115400DF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZeZIBc5J
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A115400DF
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713845013;
	bh=0It0Qs3oLGL49eT+4lgJbtyH9jMymo8SfQKGBHrJpCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZeZIBc5JysaPy/PnEnBfnE2xNj0uu2J6vUStlJoGCPdy6PgfC4MoLsB8oaWRQoObn
	 X+5F5KoFPB8SM3mopPx/P/tW/cQeFb4pLZYyfnfv4TOuzrtMcMe3RSD1+RT6mCxysv
	 pXLPzAdhPCZsgIlx0yr7pD1Yi8YvRE90sGCTn6ZUPuQpfEFmxtU+u3APPqYpCBItJk
	 VFE0umprzOLddFppeuB2JQp1dIBcH8pcFnBZVtzUOk0jHwBlUi4cHRAqfYzRKP86lE
	 BR8hB28Ql2w0LMmMjrzH3A56jkIN7qLInnNhtQZbPnEFwoCu7K7e0XL8VuSJyN1RwV
	 P29m8QFbCwCjQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 64D67378212B;
	Tue, 23 Apr 2024 04:03:30 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robdclark@gmail.com,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	dmitry.baryshkov@linaro.org,
	mcanal@igalia.com,
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] drm/ci: build virtual GPU driver as module
Date: Tue, 23 Apr 2024 09:32:41 +0530
Message-Id: <20240423040243.448091-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423040243.448091-1-vignesh.raman@collabora.com>
References: <20240423040243.448091-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With latest IGT, the tests tries to load the module and it
fails. So build the virtual GPU driver for virtio as module.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/build.sh                       |  1 -
 drivers/gpu/drm/ci/igt_runner.sh                  |  6 +++---
 drivers/gpu/drm/ci/image-tags.yml                 |  4 ++--
 drivers/gpu/drm/ci/test.yml                       |  1 +
 drivers/gpu/drm/ci/x86_64.config                  |  2 +-
 .../gpu/drm/ci/xfails/virtio_gpu-none-fails.txt   | 15 +++++++++++++++
 6 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index 8a3baa003904..95493df9cdc2 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -156,7 +156,6 @@ fi
 
 mkdir -p artifacts/install/lib
 mv install/* artifacts/install/.
-rm -rf artifacts/install/modules
 ln -s common artifacts/install/ci-common
 cp .config artifacts/${CI_JOB_NAME}_config
 
diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index f1a08b9b146f..7d2ba69294dd 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -30,10 +30,10 @@ case "$DRIVER_NAME" in
             export IGT_FORCE_DRIVER="panfrost"
         fi
         ;;
-    amdgpu)
+    amdgpu|virtio_gpu)
         # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
-        mv /install/modules/lib/modules/* /lib/modules/.
-        modprobe amdgpu
+        mv /install/modules/lib/modules/* /lib/modules/. || true
+        modprobe --first-time $DRIVER_NAME
         ;;
 esac
 
diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
index d8f72b82c938..fd1cb6061166 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -4,9 +4,9 @@ variables:
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
    DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
-   DEBIAN_BUILD_TAG: "2023-10-08-config"
+   DEBIAN_BUILD_TAG: "2024-04-22-virtio"
 
-   KERNEL_ROOTFS_TAG: "2023-10-06-amd"
+   KERNEL_ROOTFS_TAG: "2024-04-22-virtio"
    PKG_REPO_REV: "3cc12a2a"
 
    DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 612c9ede3507..864ac3809d84 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -350,6 +350,7 @@ virtio_gpu:none:
   script:
     - ln -sf $CI_PROJECT_DIR/install /install
     - mv install/bzImage /lava-files/bzImage
+    - mkdir -p /lib/modules
     - mkdir -p $CI_PROJECT_DIR/results
     - ln -sf $CI_PROJECT_DIR/results /results
     - install/crosvm-runner.sh install/igt_runner.sh
diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
index 1cbd49a5b23a..78479f063e8e 100644
--- a/drivers/gpu/drm/ci/x86_64.config
+++ b/drivers/gpu/drm/ci/x86_64.config
@@ -91,7 +91,7 @@ CONFIG_KVM=y
 CONFIG_KVM_GUEST=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_VIRTIO_FS=y
-CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_CONSOLE=y
diff --git a/drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt b/drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt
index 007f21e56d89..5b8cbb28b25c 100644
--- a/drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/virtio_gpu-none-fails.txt
@@ -68,6 +68,7 @@ kms_plane_scaling@upscale-with-rotation-20x20,Fail
 kms_selftest@drm_format,Timeout
 kms_selftest@drm_format_helper,Timeout
 kms_setmode@basic,Fail
+kms_vblank@accuracy-idle,Fail
 kms_vblank@crtc-id,Fail
 kms_vblank@invalid,Fail
 kms_vblank@pipe-A-accuracy-idle,Fail
@@ -82,3 +83,17 @@ kms_vblank@pipe-A-wait-busy,Fail
 kms_vblank@pipe-A-wait-forked,Fail
 kms_vblank@pipe-A-wait-forked-busy,Fail
 kms_vblank@pipe-A-wait-idle,Fail
+kms_vblank@query-busy,Fail
+kms_vblank@query-forked,Fail
+kms_vblank@query-forked-busy,Fail
+kms_vblank@query-idle,Fail
+kms_vblank@ts-continuation-dpms-rpm,Fail
+kms_vblank@ts-continuation-dpms-suspend,Fail
+kms_vblank@ts-continuation-idle,Fail
+kms_vblank@ts-continuation-modeset,Fail
+kms_vblank@ts-continuation-modeset-rpm,Fail
+kms_vblank@ts-continuation-suspend,Fail
+kms_vblank@wait-busy,Fail
+kms_vblank@wait-forked,Fail
+kms_vblank@wait-forked-busy,Fail
+kms_vblank@wait-idle,Fail
-- 
2.40.1

