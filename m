Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473B17E8F0
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716950504; cv=none; b=O+pEC9HtOj9YviT5l3W548uysRL0OTN/xBbQ3Fcj3MMvddFsmCGSq0NmH+DezX5/NQCEuajOB22BlQVZzJjUyDjX/SiRN0lhO01pbGKfLphpwE+mqCV59TQVDdZ4qa+8FcDiZ0ws/YPV8rawv9F6fYaxsjAP+C5UpcKnivuU3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716950504; c=relaxed/simple;
	bh=8I5N/bPH995IFvJcI2gT3VcEir2faP4m3D/1Jo2TbsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1T9vRzhboTFqKitoF5Vql1oc1tLOULXqhvH029DqOuBT8v71LRQh29H/G2kWq7gZ+1w5FsGVM70dqG3CvM4H7Lrdy8SrG7KsNgu8UiX9MtOxa5G+Kwd/cnMmkcpYINV3rcuvz2HoRDzBHE6q65kuRZQ4PxNHZF+uJ0upw/swzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LHd3UvEx; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LHd3UvEx"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEDF940278
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQWFdElZbcvq for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 02:41:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B93EC40148
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B93EC40148
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=LHd3UvEx
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B93EC40148
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 02:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716950498;
	bh=8I5N/bPH995IFvJcI2gT3VcEir2faP4m3D/1Jo2TbsI=;
	h=From:To:Cc:Subject:Date:From;
	b=LHd3UvExj3TjVSuh8o857nGSYP8gUy2nERuemFdb7ldwmZX/mxGl3dCc/nAlMV2yo
	 JTll4zrW2byD3wN4nNISCW6P7TpWspg4zvklT/yKNeGRimFMoLunEglZTsdhYVvlcv
	 /oaBaEAGtx/lGz8PzEFJpU3mSdP1HKgJSKCBWysMvBmT9X2VqEvCq3tKGxarTYAIKH
	 7Rt80MfjzqNsva1NrnyNfGKacDBQiRek1aoKboGMLvCgJSR6QzAFJhjHhpdoloLc/c
	 eS6pFt4dwT481gNDolKtc0cr3fptmgpkCYRSbfckbwhxwyz1tqimzMolyhJGTTbRES
	 4HxN0OWDIq9Pw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B337E3781FE6;
	Wed, 29 May 2024 02:41:33 +0000 (UTC)
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
Subject: [PATCH v3 0/6] drm/ci: uprev mesa/IGT and generate testlist
Date: Wed, 29 May 2024 08:10:43 +0530
Message-Id: <20240529024049.356327-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprev mesa and IGT to the latest version and stop vendoring the
testlist into the kernel. Instead, use the testlist from the
IGT build to ensure we do not miss renamed or newly added tests.
Update the xfails with the latest testlist run.

Add farm variable and update device type variable.

https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1187556

Vignesh Raman (6):
  drm/ci: uprev mesa version
  drm/ci: add farm variable
  drm/ci: generate testlist from build
  drm/ci: uprev IGT
  drm/ci: skip driver specific tests
  drm/ci: update xfails for the new testlist

 drivers/gpu/drm/ci/build-igt.sh               |   41 +-
 drivers/gpu/drm/ci/build.sh                   |    6 +-
 drivers/gpu/drm/ci/container.yml              |   12 +-
 drivers/gpu/drm/ci/gitlab-ci.yml              |   46 +-
 drivers/gpu/drm/ci/igt_runner.sh              |    9 +-
 drivers/gpu/drm/ci/image-tags.yml             |    2 +-
 drivers/gpu/drm/ci/lava-submit.sh             |    4 +-
 drivers/gpu/drm/ci/test.yml                   |   17 +-
 drivers/gpu/drm/ci/testlist.txt               | 2761 -----------------
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   41 +-
 .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |    7 +
 .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   33 +-
 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |   31 +
 .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |    9 +
 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   22 +-
 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   46 +-
 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   26 +-
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |   38 +
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   23 +
 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   41 +-
 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |    7 +
 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   26 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   42 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |    7 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   36 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   77 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   28 +-
 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   63 +-
 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   22 +-
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   30 +-
 .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |   11 +
 .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   16 +
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   21 +-
 .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   18 +
 .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   24 +-
 .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   18 +
 .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   12 +-
 .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   15 +
 .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |    7 +
 .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |    6 +
 .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |   26 +-
 .../msm-sc7180-trogdor-kingoftown-fails.txt   |  175 +-
 .../msm-sc7180-trogdor-kingoftown-flakes.txt  |    8 +
 .../msm-sc7180-trogdor-kingoftown-skips.txt   |   19 +
 ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |  175 +-
 ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |    6 +
 ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   16 +
 .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   38 +-
 .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   |   25 +-
 .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   19 +
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   |   62 +-
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   21 +-
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   83 +-
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |   13 +-
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   19 +
 drivers/gpu/drm/ci/xfails/update-xfails.py    |    4 +-
 .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   94 +-
 .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   20 +-
 61 files changed, 1348 insertions(+), 3194 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/testlist.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt

-- 
2.40.1

