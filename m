Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121DC1CA82
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845419; cv=none; b=nYxtt1Kw9jOdmBexajcKG3oDDFOJuHEehWNM4idNq2dqjf+1mDuD0O5iBOk2isAFoiuIvblRFrYmmQtvW86v6ApNtw8nQYqN+1RPNV80J98Evln+/KL2rNy9zD6VIEhMJG+CZfxaEigeJAOwWokUxTsQqm2b7m9NS+r9JmYHkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845419; c=relaxed/simple;
	bh=goF/fTNE8wl6AsxxGJwpUshDKR4pSsFtLXytgcbYEpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ITIAICqjBfbRoMfuxC9OToK+TAgWhgb2ek9i6/8yr2cZtk3M6FPrGmwkN7tQPpVJS+ROs2eA8Pk5Fccq9Xnji1tUeMMP13PYAQTMzq7Jy2qvE6J0LW1Q0cV65A5pFtqgUbojtw7qmMC/syXQMiCgunwb4Z7guuQn9WCdy4cjj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pzeWLW4M; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pzeWLW4M"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ADB36072C
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y11AEHpfH3sG for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Apr 2024 04:10:14 +0000 (UTC)
X-Greylist: delayed 405 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 23 Apr 2024 04:10:14 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 957F4606E5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 957F4606E5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=pzeWLW4M
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 957F4606E5
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Apr 2024 04:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713845006;
	bh=goF/fTNE8wl6AsxxGJwpUshDKR4pSsFtLXytgcbYEpc=;
	h=From:To:Cc:Subject:Date:From;
	b=pzeWLW4MCujJs/GAp2jdHGWku8MU/8lFZnetCkkQJYGcsExtYo+WOp6uQR4b4YNAO
	 fD/dz5wUIe0Dp00hWDfhOypem64p/TWXNDMcblcFN/tFl0ekLsgQt5K4qlAE09Iqc/
	 0tGxE7Egs1RKPBzrqCJ+dyoeBNOMrOGyLX+97Cfgw6HZ+ERKqweCwTxl5ymRVKDEQb
	 KL0F29j9bOqWv7GLG9oac+Z5qYK7le8tKeNsOQwCsCCEvbcFxXMW1ITaR/gEgDBcNF
	 RNJEnjCvmWczgzWSDjkoEJedNFxdKll0tUGVdndK0HswnuvIFX/qNvL5Ltm44Ro/AZ
	 TRYsLI1YLm/kw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E96DA378000B;
	Tue, 23 Apr 2024 04:03:22 +0000 (UTC)
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
Subject: [PATCH v1 0/4] Uprev mesa and IGT
Date: Tue, 23 Apr 2024 09:32:39 +0530
Message-Id: <20240423040243.448091-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Uprev mesa and IGT to the latest version. Stop vendoring the
testlist into the kernel. Instead, use the testlist from the
IGT build to ensure we do not miss renamed or newly added tests.
Update the xfails with the latest testlist run.

Also build virtual GPU driver for virtio as module.
This series also includes patch to add vkms testing to drm-ci.

The flakes list needs to be updated upsteam. Will send it
after this series is reviewed.

https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1161026

Vignesh Raman (4):
  drm/ci: uprev mesa version
  drm/ci: build virtual GPU driver as module
  drm/ci: uprev IGT and generate testlist from build
  drm/ci: add tests on vkms

 MAINTAINERS                                   |    1 +
 drivers/gpu/drm/ci/build-igt.sh               |   23 +
 drivers/gpu/drm/ci/build.sh                   |    2 +-
 drivers/gpu/drm/ci/container.yml              |   12 +-
 drivers/gpu/drm/ci/gitlab-ci.yml              |   14 +-
 drivers/gpu/drm/ci/igt_runner.sh              |   15 +-
 drivers/gpu/drm/ci/image-tags.yml             |    7 +-
 drivers/gpu/drm/ci/test.yml                   |   33 +-
 drivers/gpu/drm/ci/testlist.txt               | 2761 -----------------
 drivers/gpu/drm/ci/x86_64.config              |    3 +-
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   45 +-
 .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |   15 +-
 .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   30 +-
 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |   27 +
 .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |    9 +
 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   22 +-
 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   47 +-
 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   24 +-
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |   37 +-
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   20 +
 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   37 +-
 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   21 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   29 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |    1 -
 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   34 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   27 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   28 +-
 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   57 +-
 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   21 +-
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   47 +-
 .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   13 +
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   18 +-
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |    6 +
 .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   15 +
 .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   20 +-
 .../gpu/drm/ci/xfails/meson-g12b-flakes.txt   |    7 +
 .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   15 +
 .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   25 +-
 .../gpu/drm/ci/xfails/msm-apq8016-flakes.txt  |    7 +
 .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   15 +
 .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |    6 +-
 .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |    6 +
 .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |  117 +-
 .../msm-sc7180-trogdor-kingoftown-fails.txt   |   40 +-
 .../msm-sc7180-trogdor-kingoftown-flakes.txt  |    6 +
 .../msm-sc7180-trogdor-kingoftown-skips.txt   |   16 +
 ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   41 +-
 ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |   11 +
 ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   16 +
 .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   76 +-
 .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   |   26 +-
 .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   16 +
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   |   54 -
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   60 +-
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   79 +-
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |   13 +-
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   17 +-
 .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   99 +-
 .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   19 +-
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   46 +
 .../gpu/drm/ci/xfails/vkms-none-flakes.txt    |   21 +
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt |   30 +
 64 files changed, 1109 insertions(+), 3308 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/testlist.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
 delete mode 100644 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-tgl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
 delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt

-- 
2.40.1

