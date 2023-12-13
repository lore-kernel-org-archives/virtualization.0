Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81A24B20
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HKaHHKc0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEC0C4160D
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 18:30:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEC0C4160D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HKaHHKc0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6qFAuI44yCnZ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 18:30:17 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95C32410B2
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 18:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95C32410B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702492214;
	bh=siA7LXSw/cWZOr3eONb6GU7+2W3xc0vUDDvqYVEXHo4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HKaHHKc0GUtMtMwGqB+JhK/Vd2s7zl9h17X37TcWvqJ0glMkrpvUvtD8ZM5zP8oTb
	 Oj4pz9a2wJo3jO39ryXI/U1WQnYL+fCTObQZwpY+LyftemSP7OKFByncn0wiOqL0kC
	 /R1gMJO5f0fFI42K/EPxi5SXCGcG2Xw4aifPcDczViY3hkFFI1nPp0pYsRjl4YWwCG
	 ag3BhjF/myOaupGXZQYNhPbCmDhTDYQuojNMX3AFXDhFkgl+6ltnI1kbYK8l8ZDfzW
	 kfTH6jskaTJOYZBhR6GtJsxacD1N9KrTqBgrdxzKkZTo8fXUZJeiEstd75yGdAhLHg
	 7Svf5ssqsr+0g==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 95141378149B;
	Wed, 13 Dec 2023 18:30:10 +0000 (UTC)
Message-ID: <dd153cf3-541b-40c8-b33c-ce9e7074cc37@collabora.com>
Date: Wed, 13 Dec 2023 15:30:07 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] drm: ci: fixes
To: Vignesh Raman <vignesh.raman@collabora.com>, airlied@gmail.com,
 daniel@ffwll.ch
Cc: daniels@collabora.com, emma@anholt.net, gustavo.padovan@collabora.com,
 linux-arm-msm@vger.kernel.org, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 david.heidelberg@collabora.com, linux-mediatek@lists.infradead.org
References: <20231207091831.660054-1-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20231207091831.660054-1-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/12/2023 06:18, Vignesh Raman wrote:
> The patch series contains improvements, enabling new ci jobs which
> enables testing for Mediatek MT8173, Qualcomm APQ 8016 and VirtIO GPU,
> fixing issues with the ci jobs and updating the expectation files.
> 
> v2:
>    - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
>    - Reworded the commit message for enabling jobs
>    - Added a new patch in the series to use scripts/config to enable/disable configs
> 
> v3:
>    - New patch in the series to add device tree overlay in arch/arm64/boot/dts/qcom
>    - drm-ci scripts to use device tree overlay from arch/arm64/boot/dts/qcom and compile base device tree with overlay support
>    - New patch in the series to enable CONFIG_REGULATOR_DA9211 in defconfig
>    - Remove CONFIG_RTC_DRV_MT6397=y as it is already enabled in defconfig
> 
> v4:
>    - Drop 'enable CONFIG_REGULATOR_DA9211 in defconfig' patch as it is sent upstream as a seperate patch
>    - Use apq8016-sbc-usb-host.dtb which allows the USB controllers to work in host mode.
>      This patch depends on https://lore.kernel.org/lkml/20230911161518.650726-1-vignesh.raman@collabora.com/
> 
> v5:
>    - Added a new patch in the series to set IGT_FORCE_DRIVER to 'mediatek' for mt8173
>    - Added a new patch in the series to make artifacts available for virtio jobs
>    - Added a new patch in the series to add pipeline url to fails and flakes files
>    - Generate fails and flakes file with the updated xfails script - https://www.spinics.net/lists/kernel/msg4959630.html
>    - Drop 'virtio: Update ci variables' patch as the tests which causes the malloc issue are skipped
> 
> v6:
>    - Updated commit message for enable DA9211 regulator fix
>    - Use GPU_VERSION instead of CI_JOB_NAME to check if it is mt8173 while setting IGT_FORCE_DRIVER
>    - Added a new patch in the series to uprev IGT to fix memory corruption
>    - Added a new patch in the series to update drm ci documentation
>    - Generate fails file with drm-misc-next
> 
> v7:
>    - Fix checkpatch style problems in commit message
>    - Rework mt8173 IGT_FORCE_DRIVER fix and reword the commit message
> 
> Vignesh Raman (10):
>    drm: ci: igt_runner: Remove todo
>    drm: ci: Force db410c to host mode
>    drm: ci: arm64.config: Enable DA9211 regulator
>    drm: ci: Enable new jobs
>    drm: ci: Use scripts/config to enable/disable configs
>    drm: ci: mt8173: Do not set IGT_FORCE_DRIVER to panfrost
>    drm: ci: virtio: Make artifacts available
>    drm: ci: uprev IGT
>    drm/doc: ci: Add IGT version details for flaky tests
>    drm: ci: Update xfails
> 
>   Documentation/gpu/automated_testing.rst       |  7 +--
>   drivers/gpu/drm/ci/arm64.config               |  1 +
>   drivers/gpu/drm/ci/build.sh                   | 16 +++----
>   drivers/gpu/drm/ci/gitlab-ci.yml              |  2 +-
>   drivers/gpu/drm/ci/igt_runner.sh              | 10 +++-
>   drivers/gpu/drm/ci/test.yml                   | 13 ++----
>   .../drm/ci/xfails/mediatek-mt8173-fails.txt   | 13 ++++--
>   .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |  5 ++
>   .../drm/ci/xfails/virtio_gpu-none-fails.txt   | 46 +++++++++++++++++++
>   9 files changed, 86 insertions(+), 27 deletions(-)
> 


Applied to drm/drm-misc (drm-misc-next).

Thanks!
Helen

