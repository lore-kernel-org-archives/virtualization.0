Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3D4084E
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137751; cv=pass; b=e5TTaCidt5S810mGi+YGZzxfT2oJ1MgvFilhrrSO1cfTWa82cxSHjUR/POZQCpRPfBku38nutF0EtwW6AHyWjlW4d5e5o/IyF+t4uCOriC+LsXeFQoSf+yMfvO+xEXHAq6wM7VX34sexpqzBBxdNcHZy7t+Vw7XqTIsgGhVuzKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137751; c=relaxed/simple;
	bh=btA7n2hNrL0peXlLhjO6aRUvIY6OsG+0yv/3Xr6zrTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbqpnFwjAx4PJj1ca6ZbZO+r5lnKsvCeErPnUnSsJhKsjgIPzo4BAFr05lVt63cdfSJAJN63VZBXQ9mTswkfpfemtcc8DoQgo2AeiAgxG6t5AbbivJNdt/2IMXcHM093XNSX9/g1TLuH6tRbShxDdQ78yoHoobg3rw+0zf157dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b=WIvgmHa3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="WIvgmHa3"
ARC-Seal: i=1; a=rsa-sha256; t=1724137742; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wsf//7UlKFeMXs5mrlbsA3f7Sm4SWFQ4OhMWchFGrGlXmj8gyuwFrLdduALbIjd5yxD/zZ3xWd4GtW5mnphQOV52asjwadd4hDidbod+cjlJ19uEUG9xkh5AwjmM7VJomKofTpUJPPt7uQMy4sR5pRHv5V0wI5vzUBomskToNRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724137742; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0sUDtqU8UXz2+A95knZ7ryFsZBRjCwmhZ1uQAm5xJYI=; 
	b=ey+YqA/aEMyzbL8PrY058CoHw8u3SY9WK2lKKy6B+4+NvOcwr0DHW7DwOqQ25z2R9z6ipQbtVKN6IhGP4vAaPNgiYPiYXQPYoIQmYzCYIH35iciLlKRgcbaU6HO+J0s6srUj8P6mOb6DJRIolVgRJ8bBE1R4AHI7lxbpXFhTuYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
	dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724137742;
	s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0sUDtqU8UXz2+A95knZ7ryFsZBRjCwmhZ1uQAm5xJYI=;
	b=WIvgmHa3eQbPb3a7PFmqg1lZ2yCyvmY6UKsmiivIyQWAx3BGMcQN2zw+HO/so6H0
	m9pD1V6TJJCZTdFNaufvpephnLfyMBltYY2V4cQsnEurCyc6aiM9qoIDdprUYPLn5Fy
	5My6pDr8Isr9zkWPj0ZfqFCewFT+1t8ZfTb20OzE=
Received: by mx.zohomail.com with SMTPS id 172413774108257.39914871221299;
	Tue, 20 Aug 2024 00:09:01 -0700 (PDT)
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
	linux-mediatek@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/ci: increase timeout for all jobs
Date: Tue, 20 Aug 2024 12:38:16 +0530
Message-ID: <20240820070818.1124403-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Set the timeout of all drm-ci jobs to 1h30m since
some jobs takes more than 1 hour to complete.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/test.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index b6f428cdaf94..09d8447840e9 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -10,6 +10,7 @@
 .lava-test:
   extends:
     - .test-rules
+  timeout: "1h30m"
   script:
     # Note: Build dir (and thus install) may be dirty due to GIT_STRATEGY
     - rm -rf install
@@ -71,6 +72,7 @@
     - .baremetal-test-arm64
     - .use-debian/baremetal_arm64_test
     - .test-rules
+  timeout: "1h30m"
   variables:
     FDO_CI_CONCURRENT: 10
     HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
@@ -215,7 +217,6 @@ panfrost:rk3399:
   extends:
     - .lava-igt:x86_64
   stage: i915
-  timeout: "1h30m"
   variables:
     DRIVER_NAME: i915
     DTB: ""
@@ -414,6 +415,7 @@ panfrost:g12b:
 
 virtio_gpu:none:
   stage: software-driver
+  timeout: "1h30m"
   variables:
     CROSVM_GALLIUM_DRIVER: llvmpipe
     DRIVER_NAME: virtio_gpu
@@ -436,6 +438,7 @@ virtio_gpu:none:
 
 vkms:none:
   stage: software-driver
+  timeout: "1h30m"
   variables:
     DRIVER_NAME: vkms
     GPU_VERSION: none
-- 
2.43.0

