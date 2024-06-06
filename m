Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2691991C6
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685292; cv=none; b=UsFoGKfs3bsB28KK68tHcYO7Zq/HqRsk++vKEO69mfTYTfSL625PfCTb4YdmGrFZO1usvUXPJ4JQvIxO4zOqXnHb1jcRLN3aXfVtyOLTVKidK7bXOHcNcdpl+JRIABVUqHrXcZXlnzJiTOErp7HAf9tiSmaSLgRu3zVmcAnNB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685292; c=relaxed/simple;
	bh=dQuMVnPcFvL2rm7IsOiVG0+PEE/oKkyHvTcPJNmZa+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWPYh21jLyNMLxoyrjbBK5Bpxk8SlwORq/bBzUyGqCsBFJQHgkIVf6x0AFYPkuoQXrtxCF5Fjtyjv0+mNtvjH17K6tOyk+Ord45amQf1ii0lP7/XXxsBNeCd/B/VPSJXvp6ilhR/40Q+J0vv63+AiHgCloDLQ6Op0NvgyLAL55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YtRrkQHK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YtRrkQHK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A451440521
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ikj6_5X4k-T for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 14:48:09 +0000 (UTC)
X-Greylist: delayed 1743 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 06 Jun 2024 14:48:09 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 19D8B4050B
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19D8B4050B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YtRrkQHK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=helen.koike@collabora.com; receiver=<UNKNOWN> 
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19D8B4050B
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717685287;
	bh=dQuMVnPcFvL2rm7IsOiVG0+PEE/oKkyHvTcPJNmZa+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YtRrkQHKb+X7xskObtg8FVCsFdwW8ShtHfCWtk4KRWoyx36T/q0AyGDwcPLitgXD0
	 juSSzZ3cVZnQbEDdzMDSSm8xGeGxl3vLT/L53APO2Uo9mJm74o3YO7FrEl2BM+EyDS
	 RHflhbHlPHGWQ7EThEjdeN/fGUeVCYOlIKGO8DrwcAr/iYf/5sLnc4QHnStmIq0v0h
	 xLL7JMpSpaAnGsWurIR2SiEcuC0uSUEfaXkzCyK0B0+QnKCJRPycr/Fv0n4gXpkoOX
	 CpotkDssPI/ghb/8UWFmzZvE0qBspVDQY2C+F0VYLb5GEI9kUvXljorsWjykBsbJu8
	 LAPtwkBjkdYrA==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 233DF37821F4;
	Thu,  6 Jun 2024 14:48:01 +0000 (UTC)
Message-ID: <da1366fa-4d48-4227-ae4b-4b39a6607973@collabora.com>
Date: Thu, 6 Jun 2024 11:47:59 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] drm/ci: uprev mesa/IGT and generate testlist
To: Vignesh Raman <vignesh.raman@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 dmitry.baryshkov@linaro.org, mcanal@igalia.com,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240529024049.356327-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/05/2024 23:40, Vignesh Raman wrote:
> Uprev mesa and IGT to the latest version and stop vendoring the
> testlist into the kernel. Instead, use the testlist from the
> IGT build to ensure we do not miss renamed or newly added tests.
> Update the xfails with the latest testlist run.
> 
> Add farm variable and update device type variable.
> 
> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1187556
> 
> Vignesh Raman (6):
>    drm/ci: uprev mesa version
>    drm/ci: add farm variable
>    drm/ci: generate testlist from build
>    drm/ci: uprev IGT
>    drm/ci: skip driver specific tests
>    drm/ci: update xfails for the new testlist
> 
>   drivers/gpu/drm/ci/build-igt.sh               |   41 +-
>   drivers/gpu/drm/ci/build.sh                   |    6 +-
>   drivers/gpu/drm/ci/container.yml              |   12 +-
>   drivers/gpu/drm/ci/gitlab-ci.yml              |   46 +-
>   drivers/gpu/drm/ci/igt_runner.sh              |    9 +-
>   drivers/gpu/drm/ci/image-tags.yml             |    2 +-
>   drivers/gpu/drm/ci/lava-submit.sh             |    4 +-
>   drivers/gpu/drm/ci/test.yml                   |   17 +-
>   drivers/gpu/drm/ci/testlist.txt               | 2761 -----------------
>   .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   41 +-
>   .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |    7 +
>   .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   33 +-
>   drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |   31 +
>   .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |    9 +
>   drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   22 +-
>   drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   46 +-
>   drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |    6 +
>   drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   26 +-
>   drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |   38 +
>   drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |    6 +
>   drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   23 +
>   drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |   41 +-
>   drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |    7 +
>   drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   26 +-
>   drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   42 +-
>   drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |    7 +-
>   drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   36 +-
>   drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |   77 +-
>   drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   28 +-
>   drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |   63 +-
>   drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |    6 +
>   drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   22 +-
>   .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   30 +-
>   .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |   11 +
>   .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   16 +
>   .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   21 +-
>   .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   18 +
>   .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   24 +-
>   .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   18 +
>   .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   12 +-
>   .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   15 +
>   .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |    7 +
>   .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |    6 +
>   .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |   26 +-
>   .../msm-sc7180-trogdor-kingoftown-fails.txt   |  175 +-
>   .../msm-sc7180-trogdor-kingoftown-flakes.txt  |    8 +
>   .../msm-sc7180-trogdor-kingoftown-skips.txt   |   19 +
>   ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |  175 +-
>   ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |    6 +
>   ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   16 +
>   .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   38 +-
>   .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   |   25 +-
>   .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   19 +
>   .../drm/ci/xfails/rockchip-rk3288-fails.txt   |   62 +-
>   .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   21 +-
>   .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   83 +-
>   .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |   13 +-
>   .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   19 +
>   drivers/gpu/drm/ci/xfails/update-xfails.py    |    4 +-
>   .../drm/ci/xfails/virtio_gpu-none-fails.txt   |   94 +-
>   .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   20 +-
>   61 files changed, 1348 insertions(+), 3194 deletions(-)
>   delete mode 100644 drivers/gpu/drm/ci/testlist.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
> 


Applied to drm-misc-next

Thanks
Helen
