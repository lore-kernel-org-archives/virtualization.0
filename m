Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C01BF916
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683559; cv=none; b=sDhQCa+4CtwLGenOW5ICwY85/Kpw4EEOoAyvI7xIlWev8N7jOEL2msi+Gs94NNU7hax1MaghJ9qFy3H4b2S/kl2xsOmb0SVhsmSSliwEkQvPuVt40ftCjAe4sdNpiLLz5DQ22k4WXJig14Jb/CpDHvfPeCA4J4Zf+Bm2CKDNlzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683559; c=relaxed/simple;
	bh=4TkfymXhZni13bl4zIia9hXBLpsc7d/HZrJcyEK53uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvPSzKs0rbCaPxlP/g+JaPrKTYVTZLBHhDHOs1j9z1Pa2CiaBri2RwifQ5Qizi6AshJMUmd+OfOP9lCJOqh3l8KRxgElgT5p48M8AB0il3wyd1ZMcUSFQHUT4sheFW/1XaQ/aiE4PoeKwIs+qIQqxP2sTx+GZegDd3U4h0/eoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YYJzAMfm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YYJzAMfm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C08B781000
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A9PdrC3gXlSc for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 14:19:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.235.227.194; helo=madrid.collaboradmins.com; envelope-from=helen.koike@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AE86081005
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE86081005
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YYJzAMfm
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE86081005
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717683554;
	bh=4TkfymXhZni13bl4zIia9hXBLpsc7d/HZrJcyEK53uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YYJzAMfmKb0Sl998xS57d6Y2oXgCJXzbp64dD6iufiPya+cyK/Yh8/bmqAwyRXH79
	 OMhbtx6SWkjgl0XzM0qeO/w8DqLWgtyr4MwPwtJ1Vm8V2t0gWeOozKJyvyD0Oi+G26
	 0kGx4sgDYPgWmAhOc30W7A6I+rZs4qMl6iejTh88t073Zrcwt3xGGRX5uTHc1cXIwj
	 zWfj0xjnuNmVVQeZ8DPdnE00hqD68dGQS9G8adx35MWhz4AUVBetZb3NLTMvbDAFWg
	 WLYTK2N1S6cgbncH+x88ry+IqXgHPE2775C56+P5E4yRF7nFR9AAx+U+fpuNvXRmAA
	 q4rO/xIwsS9yA==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED18337820B5;
	Thu,  6 Jun 2024 14:19:08 +0000 (UTC)
Message-ID: <99fe00bf-003c-4295-8cfc-562068e11f98@collabora.com>
Date: Thu, 6 Jun 2024 11:19:08 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] drm/ci: add farm variable
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
 <20240529024049.356327-3-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240529024049.356327-3-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/05/2024 23:40, Vignesh Raman wrote:
> Mesa uses structured logs for logging and debug purpose,
> https://mesa.pages.freedesktop.org/-/mesa/-/jobs/59165650/artifacts/results/job_detail.json
> 
> Since drm-ci uses the mesa scripts, add the farm variable
> and update the device type for missing jobs.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>


> ---
> 
> v3:
>    - New commit to add farm variable and update device type variable.
> 
> ---
>   drivers/gpu/drm/ci/test.yml | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 8bc63912fddb..2615f67f6aa3 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -24,6 +24,7 @@
>     variables:
>       HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
>       DEBIAN_ARCH: "armhf"
> +    FARM: collabora
>     dependencies:
>       - testing:arm32
>     needs:
> @@ -39,6 +40,7 @@
>     variables:
>       HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
>       DEBIAN_ARCH: "arm64"
> +    FARM: collabora
>     dependencies:
>       - testing:arm64
>     needs:
> @@ -54,6 +56,7 @@
>     variables:
>       HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
>       DEBIAN_ARCH: "amd64"
> +    FARM: collabora
>     dependencies:
>       - testing:x86_64
>     needs:
> @@ -74,6 +77,7 @@
>       S3_ARTIFACT_NAME: "arm64/kernel-files"
>       BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/Image.gz
>       BM_CMDLINE: "ip=dhcp console=ttyMSM0,115200n8 $BM_KERNEL_EXTRA_ARGS root=/dev/nfs rw nfsrootdebug nfsroot=,tcp,nfsvers=4.2 init=/init $BM_KERNELARGS"
> +    FARM: google
>     needs:
>       - debian/arm64_test
>       - job: testing:arm64
> @@ -116,8 +120,9 @@ msm:apq8016:
>       - .baremetal-igt-arm64
>     stage: msm
>     variables:
> +    DEVICE_TYPE: apq8016-sbc-usb-host
>       DRIVER_NAME: msm
> -    BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/apq8016-sbc-usb-host.dtb
> +    BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/${DEVICE_TYPE}.dtb
>       GPU_VERSION: apq8016
>       # disabling unused clocks congests with the MDSS runtime PM trying to
>       # disable those clocks and causes boot to fail.
> @@ -132,9 +137,10 @@ msm:apq8096:
>       - .baremetal-igt-arm64
>     stage: msm
>     variables:
> +    DEVICE_TYPE: apq8096-db820c
>       DRIVER_NAME: msm
>       BM_KERNEL_EXTRA_ARGS: maxcpus=2
> -    BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/apq8096-db820c.dtb
> +    BM_DTB: https://${PIPELINE_ARTIFACTS_BASE}/arm64/${DEVICE_TYPE}.dtb
>       GPU_VERSION: apq8096
>       RUNNER_TAG: google-freedreno-db820c
>     script:
> @@ -146,6 +152,7 @@ msm:sdm845:
>     stage: msm
>     parallel: 6
>     variables:
> +    DEVICE_TYPE: sdm845-cheza-r3
>       DRIVER_NAME: msm
>       BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
>       GPU_VERSION: sdm845
