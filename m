Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B33127E02
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468342; cv=none; b=JGnLSB/yEaabEY170iKc8e1GSjhAmcizDGPWBLmTho4bNAUrvKqw3+17Dg7QyxgNFNLC56bX5szlUC1OOirDVlQsGy480hhOXRCqirkByM1Etav0l+PlodsQCIR9q9rZkO2HPWs0F3uz8dNgvgzKNcZ4cA0UuRL37mM5hnsNPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468342; c=relaxed/simple;
	bh=Q6up+U23E5APYIMETLmfiB1ibki5YAl7MpYr3vD7xLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pczrh2zW7MnsETlQ4cmXPoM45Z4mAEBTeFhBeZvWkQQMSeSVPP6dy3HODO+j6fAZpzJcuZO80YIWd72vEmCb/O1yJUowiMYGHIKjUOO+GwTUnBn+G8IR8qL65Nwtl/1z1LfrbEkiUB/rh5fCgXdRaLYMCE3yJUcTBA40I/aAcxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KE5WpSPb; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KE5WpSPb"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8150402D4
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 09:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VIJQ5h_7FOY for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 09:12:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F26A74026B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F26A74026B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KE5WpSPb
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F26A74026B
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714468335;
	bh=Q6up+U23E5APYIMETLmfiB1ibki5YAl7MpYr3vD7xLE=;
	h=From:To:Cc:Subject:Date:From;
	b=KE5WpSPbzhjMWvlaKe8+wAl5amqx/bo+kGu0nR8qV0BnT+EpHef2nFuLTNyuV/FUG
	 OXpRrnwMw0UusKK2qo2ccvla2/MnwHsXXViKbFIU4DVI9bgWcvF7BrypK/E88QMIps
	 rdZcASyjzRKYXiKVE3dp/I6f7PDihykSPDSyfLLC57JF9XN8KO9V2BLtL/YW7vESVq
	 td7cUTrvNX/lZgp9E0jndbl9NKdAxHOlJevkfK4U3P6PVYbMCbY3+oGnDCmfxGf9Lq
	 SCZG8TAY0vrh76a6z+gUYV/jdriHAZQwzAlVfLDGy3e3skmZF3EvWxop+G6+DSlx+v
	 C6OVGbLdQR+Gg==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 53E3D3782165;
	Tue, 30 Apr 2024 09:12:11 +0000 (UTC)
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
Subject: [PATCH v1 0/5] drm/ci: uprev mesa and generate testlist
Date: Tue, 30 Apr 2024 14:41:16 +0530
Message-Id: <20240430091121.508099-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprev mesa to the latest version and stop vendoring the
testlist into the kernel. Instead, use the testlist from the
IGT build to ensure we do not miss renamed or newly added tests.
Update the xfails with the latest testlist run.

Also build virtual GPU driver for virtio as module.

The flakes list needs to be reported upsteam. Will send it
after this series is reviewed.

https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1166575

Vignesh Raman (5):
  drm/ci: uprev mesa version
  drm/ci: generate testlist from build
  drm/ci: build virtual GPU driver as module
  drm/ci: skip driver specific tests
  drm/ci: update xfails for the new testlist

 drivers/gpu/drm/ci/build-igt.sh               |   23 +
 drivers/gpu/drm/ci/build.sh                   |    2 +-
 drivers/gpu/drm/ci/container.yml              |   12 +-
 drivers/gpu/drm/ci/gitlab-ci.yml              |   11 +-
 drivers/gpu/drm/ci/igt_runner.sh              |   15 +-
 drivers/gpu/drm/ci/image-tags.yml             |    7 +-
 drivers/gpu/drm/ci/test.yml                   |    3 +
 drivers/gpu/drm/ci/testlist.txt               | 2761 -----------------
 drivers/gpu/drm/ci/x86_64.config              |    2 +-
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   47 +-
 .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |    8 +-
 .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   29 +-
 drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |   22 +-
 .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |    8 +
 drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   22 +-
 drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   45 +-
 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |    5 +
 drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   26 +-
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |   26 +-
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |    6 +
 drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   20 +
 drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   28 +-
 drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   26 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   39 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |   10 +-
 drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   35 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   75 +-
 drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   27 +-
 drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   46 +-
 drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   22 +-
 .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   47 +-
 .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   12 +
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   17 +-
 .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |    5 +
 .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   14 +
 .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   20 +-
 .../gpu/drm/ci/xfails/meson-g12b-flakes.txt   |    5 +
 .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   14 +
 .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   26 +-
 .../gpu/drm/ci/xfails/msm-apq8016-flakes.txt  |    5 +
 .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   14 +
 .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |    5 +-
 .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |    5 +
 .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |   81 +-
 .../msm-sc7180-trogdor-kingoftown-fails.txt   |   34 +-
 .../msm-sc7180-trogdor-kingoftown-flakes.txt  |    5 +
 .../msm-sc7180-trogdor-kingoftown-skips.txt   |   15 +
 ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   34 +-
 ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |    5 +
 ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   15 +
 .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   75 +-
 .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   |   26 +-
 .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   15 +
 .../drm/ci/xfails/rockchip-rk3288-fails.txt   |   54 -
 .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   17 +-
 .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   80 +-
 .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |    7 -
 .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   15 +
 .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   82 +-
 .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   18 +-
 60 files changed, 886 insertions(+), 3289 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/testlist.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
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
 delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt

-- 
2.40.1

