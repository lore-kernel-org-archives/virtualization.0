Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6815B102
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950520; cv=none; b=KS5avu2bZFDo5dfMCibuANlHmuNcDBOuP+UDSV+TayiSKhbwjZs22HxotZUoVfh4bk5SjaPBC8Rz44jrd+BgpOLOdPCZDr+oA0SoY16l48lP8IvDWKdwdL1ixDkATMO6NGWJf0Br0fswAR5SnHZlChusY/fIkOr9ys+RSeA7/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950520; c=relaxed/simple;
	bh=on0EOWF+GkQb1PJcpMNExjb9HNOdj76aATPkzOg3PAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k78bXNGIGo1MsiitLMcmBRf0lyNbsx6lOaLLdfO3JnVXT/m737cIaF4gc9NPGm9pGATHIVKm+MQxnrTo/+W1QzeoCuB4qlYeDFeFasgOAhPFLAE4il4rLN0za4lctF9023VaGRSrqEGqY4oIQAD/fsWBZolf6zgUhpXtsMCe5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=41Y/EPEA; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="41Y/EPEA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FE5D82135
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1McrkbdFrLl for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 02:41:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5E90B820AE
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E90B820AE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=41Y/EPEA
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E90B820AE
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716950516;
	bh=on0EOWF+GkQb1PJcpMNExjb9HNOdj76aATPkzOg3PAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=41Y/EPEAiCbuxuQnH4Q92zY4teEN8tmt/m7HJ5dHcGdr5VPAKPagjuEeYHoIBgC7X
	 EMIgr2nlop2O1Cqp44+whbpYLZAXdYyuTYP4/R+fkqtRLppGSCFA6LsA/6HVw7+oUR
	 25XOVhMc6NVJBjVHS6ehxO1S6qrUaNvwJJm/RtSoREKw81KiMUDlykgjMQ4Vn8k05A
	 IYIvghzwU5DNsjnbw0yTrAKrVfwbovrYppgx8GBYQfX8LFKxKJh03JYsAt2SwZMOVP
	 iupqyKSv+ibOnL2r2ST/t4XN8u6LHbIGr9S6eiMq1UYVbmwx2UHSFz/4aHR9xgiezt
	 deQSjTukXh+Cg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D7130378215E;
	Wed, 29 May 2024 02:41:52 +0000 (UTC)
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
Subject: [PATCH v3 4/6] drm/ci: uprev IGT
Date: Wed, 29 May 2024 08:10:47 +0530
Message-Id: <20240529024049.356327-5-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529024049.356327-1-vignesh.raman@collabora.com>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test-list.txt and test-list-full.txt are not generated for
cross-builds and they are required by drm-ci for testing
arm32 targets. This is fixed in igt-gpu-tools. So uprev
IGT to include the commit which fixes this issue. Also
disable building xe driver tests for non-intel platforms.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Split IGT uprev to seperate patch.

v3:
  - No changes.

---
 drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
index b7d2a49a6db3..eddb5f782a5e 100644
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

