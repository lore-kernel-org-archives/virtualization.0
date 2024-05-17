Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78037163
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937936; cv=none; b=giiY0WswYbyfWNOe/0v9jm5iN4NY2288mBm6PHmBK2YRB99tjXeoVDorXJAgouKTp0wLmeqHFFWSocPsVKZm8cyUlOGT54x22raf4XHsq6xV+0BZ79PckIua3ruTi5tQIsgenPL9/8Cfk5RhavvSd1sESp2bi2ZaOVKTCJl2NaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937936; c=relaxed/simple;
	bh=aDp9iI96OBJTQES4yUVp+EROqovPxhZTdAIdqtcnWnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgAO+DtUN6pgmsZYHgLFZXRu8r0X7qOZgCHeBx+nNJ179C1SiIc5GEvKyRWjH2jZ0UYRVd7dXGfFhFOUr/z0NeDEk5zNT6JMki85DyIoVe2gZi/zPOqrO9x5Ijn4XOOAnFONdXcBGDUS2F99gntu05qXFrZjNIl8i0/hjspVxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OthiUZqH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OthiUZqH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEA39400B8
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7uxezG3D_ow for <virtualization@lists.linux-foundation.org>;
 Fri, 17 May 2024 09:25:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B1B1B4021C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1B1B4021C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OthiUZqH
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1B1B4021C
	for <virtualization@lists.linux-foundation.org>; Fri, 17 May 2024 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715937932;
	bh=aDp9iI96OBJTQES4yUVp+EROqovPxhZTdAIdqtcnWnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OthiUZqH7ibnt5nhrHOtzuP8ngSpfTMFtyvDVW3iK6gJO9pHKAp4fVrme+Q9IviDH
	 4R1zmqNkkAedMzUpGQDl/I0DNm8A6XqQXaYpjX5e4oWu+0Ctmecpk6+akgOUe7zeb+
	 ZeB7aFm7RNaMw5hJ7g7TX61zYfrdp5RzMT91PjBnmTzhJg1SMpwK1sKBzN/7hsybCr
	 AqJtQIObFIqC7MLSEiQ6PqmsL8fit6chxx48d/90OS48qca2TDbnyJ7Qr3SLxc6pGv
	 aOXKeYUcS3EnRFkQI0RwGZTonyZetvI0T+1EdA7ASTDbfUA09nPdzIUO9IpLoR36eJ
	 o0CFdxMvDWdUA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33F7E37821BF;
	Fri, 17 May 2024 09:25:28 +0000 (UTC)
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
Subject: [PATCH v2 4/6] drm/ci: uprev IGT
Date: Fri, 17 May 2024 14:55:00 +0530
Message-Id: <20240517092502.647420-5-vignesh.raman@collabora.com>
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

test-list.txt and test-list-full.txt are not generated for
cross-builds and they are required by drm-ci for testing
arm32 targets.

This is fixed in igt-gpu-tools. So uprev IGT to include the
commit which fixes this issue. Disable building xe driver
tests for non-intel platforms.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Split IGT uprev to seperate patch.

---
 drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
index e62244728613..7aa3ce274c64 100644
--- a/drivers/gpu/drm/ci/build-igt.sh
+++ b/drivers/gpu/drm/ci/build-igt.sh
@@ -45,6 +45,10 @@ MESON_OPTIONS="-Doverlay=disabled                    \
                -Dlibunwind=enabled                   \
                -Dprefix=/igt"
 
+if [[ "$KERNEL_ARCH" = "arm64" ]] || [[ "$KERNEL_ARCH" = "arm" ]]; then
+    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
+fi
+
 mkdir -p /igt
 meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
 ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 8f32de63d92e..1b29c3b6406b 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -5,7 +5,7 @@ variables:
   UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
   TARGET_BRANCH: drm-next
 
-  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
+  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56
 
   DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
   DEQP_RUNNER_GIT_TAG: v0.15.0
-- 
2.40.1

