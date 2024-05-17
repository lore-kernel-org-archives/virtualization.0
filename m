Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B392C85D
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937931; cv=none; b=p4hWRNaR424kkRA+YMN7b3qhnG0TDfP0Ux03+n9J8bJ0ZsSy3RS/IyRS8/paE92Z+CWKoedgo46Eoda6x/lU8VxQYEZPPygkDrkDjmQVf70f5iAIoM1dC42QifWBUbR0qjEO62RevB7aGvFozJMtMUe9ChFmd20aYh/NuLxe2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937931; c=relaxed/simple;
	bh=iVG5TznlZSbapY+dfzdsSGk+uIVJwQXm3dejanoZ0vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHiOWo0q2ZfESbHnwdIJQ8Qraq73rR9ZvssEkyoUrwsI1j5k+Q+Q6kBVOo0ZrLxhVFav+s3v3TFl+toXt41TF+jxuaqcHfgT3QSxw6qXL403BEv4EHj/f+XIxizgsDzTgvQQK2ya42KoSmmpt2UNmTDnDtQeUFNTLvsQvejuTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xSmje+K4; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xSmje+K4"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4832E6062C
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v574oSkaFuZk for <virtualization@lists.linux-foundation.org>;
 Fri, 17 May 2024 09:25:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.235.227.194; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 866926060A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 866926060A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=xSmje+K4
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 866926060A
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715937927;
	bh=iVG5TznlZSbapY+dfzdsSGk+uIVJwQXm3dejanoZ0vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xSmje+K4XscK5ePBslevLDzyBGG7U45O+jVEn4EXvgEXrIyUV3tSMGtLwuKWYWaPP
	 8v95fH7ZRzaeu3klhSnyHdLRns3MxGVr8T2J4tubV2M5U43rYOmDDNEeai2jzlA5Np
	 mPLAfaQXVvkM2GPH74pHnxH6AX/MUraCpi+3QJc42EmkXuyFo164+Uq5nnHe6kZ6Fz
	 IM7RbfImZc3tYbKZapVpEiNMU7+QD7AXJ0CmC201V7UqNF59Y3KD+3LH4/tVugdy01
	 uObX3gd1vOy9TleG+RDZFXntkersrs5XXLcBXikhpby9E/2+P4pWztPqtmsVpWnxcV
	 40fJlzLtTB6pQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DED9637821C2;
	Fri, 17 May 2024 09:25:23 +0000 (UTC)
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
Subject: [PATCH v2 3/6] drm/ci: build virtual GPU driver as module
Date: Fri, 17 May 2024 14:54:59 +0530
Message-Id: <20240517092502.647420-4-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517092502.647420-1-vignesh.raman@collabora.com>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
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

v2:
  - No changes.

---
 drivers/gpu/drm/ci/build.sh       | 1 -
 drivers/gpu/drm/ci/igt_runner.sh  | 6 +++---
 drivers/gpu/drm/ci/image-tags.yml | 4 ++--
 drivers/gpu/drm/ci/test.yml       | 1 +
 drivers/gpu/drm/ci/x86_64.config  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
index a67871fdcd3f..e938074ac8e7 100644
--- a/drivers/gpu/drm/ci/build.sh
+++ b/drivers/gpu/drm/ci/build.sh
@@ -157,7 +157,6 @@ fi
 
 mkdir -p artifacts/install/lib
 mv install/* artifacts/install/.
-rm -rf artifacts/install/modules
 ln -s common artifacts/install/ci-common
 cp .config artifacts/${CI_JOB_NAME}_config
 
diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 20026612a9bd..55532f79fbdc 100755
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
index 60323ebc7304..328f5c560742 100644
--- a/drivers/gpu/drm/ci/image-tags.yml
+++ b/drivers/gpu/drm/ci/image-tags.yml
@@ -4,9 +4,9 @@ variables:
    DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
 
    DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
-   DEBIAN_BUILD_TAG: "2023-10-08-config"
+   DEBIAN_BUILD_TAG: "2024-05-09-virtio"
 
-   KERNEL_ROOTFS_TAG: "2023-10-06-amd"
+   KERNEL_ROOTFS_TAG: "2024-05-09-virtio"
 
    DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
    DEBIAN_X86_64_TEST_IMAGE_GL_PATH: "debian/x86_64_test-gl"
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
-- 
2.40.1

