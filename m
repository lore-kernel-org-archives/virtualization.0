Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6417A931
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488026; cv=none; b=egkp/+/ELogo6t6iYMubgKSwRzX/cPtRAlSydsQmB19HXUCB6slJDGf90bNiQ20DWbIQeUjNHm4LJuNZmhie0XAXX8qks6y0LbjtgprpMvi/nhZh4kRqjgx0Ac7tmUZwDae0ca+7QIUIXzNohSQ/Gck4WKS63JCzMHTkAapnmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488026; c=relaxed/simple;
	bh=08lyesCEKaOnB28Fw3u34HvaM0G+lf8uBMq021leP4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9aDR1BpV2lnXmpkhqKi9uDcnIX68AxrkDmuKvH2N7FId5WHdYIjdRxwHNGnbbGVZPfvEghRRn2roI1s8/V5jYL/a0rUV0GWeG5br7M5If3qXpnLSybBs4TJnpkVUhtScMJSpEg8IKLGR1qPS2nP7BiTHEsWxLymucABU6AGvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ELnbSRWD; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ELnbSRWD"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE4C2414C7
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eS_jDbk_7uSK for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 14:40:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=helen.koike@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 10AC3403D6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10AC3403D6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ELnbSRWD
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10AC3403D6
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714487483;
	bh=08lyesCEKaOnB28Fw3u34HvaM0G+lf8uBMq021leP4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ELnbSRWDFqn73oBgEYJ+2HofrbwUEL9fiAUKRFjRAhKTmp3jClMgXjfJwIdeXB18v
	 6jGMkYTgqmRdFNQeGIT1Kb9snc5sFNOIKqP8LRBMFbmnMUNPCJZb8oC3zdq+QEYYE0
	 oycM7kEzyi90lVMaa7xAoloKsGH42Yj5WSHTYNpDJj073sqN0bumZx8wJGwjooWAo7
	 3opI+K5o0ADfK1nx3H8c2MU/fz39cqLsOXK3c6swPE5KFGxQtj0I0yclS7DK3r6ZtM
	 BF+cv+R7BDQzjOM4Z1R0xLV0JZIN48A48JxAcp8DJlyUp3NlHSps7YfWzym7K1Gpcz
	 9HQVphiC870/A==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7720437820AB;
	Tue, 30 Apr 2024 14:31:17 +0000 (UTC)
Message-ID: <90a0b4ba-52e3-446e-8de1-ca67e0c71a53@collabora.com>
Date: Tue, 30 Apr 2024 11:31:16 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] drm/ci: build virtual GPU driver as module
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
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-4-vignesh.raman@collabora.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <20240430091121.508099-4-vignesh.raman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2024 06:11, Vignesh Raman wrote:
> With latest IGT, the tests tries to load the module and it
> fails. So build the virtual GPU driver for virtio as module.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

> ---
>   drivers/gpu/drm/ci/build.sh       | 1 -
>   drivers/gpu/drm/ci/igt_runner.sh  | 6 +++---
>   drivers/gpu/drm/ci/image-tags.yml | 4 ++--
>   drivers/gpu/drm/ci/test.yml       | 1 +
>   drivers/gpu/drm/ci/x86_64.config  | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> index 8a3baa003904..95493df9cdc2 100644
> --- a/drivers/gpu/drm/ci/build.sh
> +++ b/drivers/gpu/drm/ci/build.sh
> @@ -156,7 +156,6 @@ fi
>   
>   mkdir -p artifacts/install/lib
>   mv install/* artifacts/install/.
> -rm -rf artifacts/install/modules
>   ln -s common artifacts/install/ci-common
>   cp .config artifacts/${CI_JOB_NAME}_config
>   
> diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
> index 20026612a9bd..55532f79fbdc 100755
> --- a/drivers/gpu/drm/ci/igt_runner.sh
> +++ b/drivers/gpu/drm/ci/igt_runner.sh
> @@ -30,10 +30,10 @@ case "$DRIVER_NAME" in
>               export IGT_FORCE_DRIVER="panfrost"
>           fi
>           ;;
> -    amdgpu)
> +    amdgpu|virtio_gpu)
>           # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
> -        mv /install/modules/lib/modules/* /lib/modules/.
> -        modprobe amdgpu
> +        mv /install/modules/lib/modules/* /lib/modules/. || true
> +        modprobe --first-time $DRIVER_NAME
>           ;;
>   esac
>   
> diff --git a/drivers/gpu/drm/ci/image-tags.yml b/drivers/gpu/drm/ci/image-tags.yml
> index d8f72b82c938..fd1cb6061166 100644
> --- a/drivers/gpu/drm/ci/image-tags.yml
> +++ b/drivers/gpu/drm/ci/image-tags.yml
> @@ -4,9 +4,9 @@ variables:
>      DEBIAN_BASE_TAG: "${CONTAINER_TAG}"
>   
>      DEBIAN_X86_64_BUILD_IMAGE_PATH: "debian/x86_64_build"
> -   DEBIAN_BUILD_TAG: "2023-10-08-config"
> +   DEBIAN_BUILD_TAG: "2024-04-22-virtio"
>   
> -   KERNEL_ROOTFS_TAG: "2023-10-06-amd"
> +   KERNEL_ROOTFS_TAG: "2024-04-22-virtio"
>      PKG_REPO_REV: "3cc12a2a"
>   
>      DEBIAN_X86_64_TEST_BASE_IMAGE: "debian/x86_64_test-base"
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 612c9ede3507..864ac3809d84 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -350,6 +350,7 @@ virtio_gpu:none:
>     script:
>       - ln -sf $CI_PROJECT_DIR/install /install
>       - mv install/bzImage /lava-files/bzImage
> +    - mkdir -p /lib/modules
>       - mkdir -p $CI_PROJECT_DIR/results
>       - ln -sf $CI_PROJECT_DIR/results /results
>       - install/crosvm-runner.sh install/igt_runner.sh
> diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
> index 1cbd49a5b23a..78479f063e8e 100644
> --- a/drivers/gpu/drm/ci/x86_64.config
> +++ b/drivers/gpu/drm/ci/x86_64.config
> @@ -91,7 +91,7 @@ CONFIG_KVM=y
>   CONFIG_KVM_GUEST=y
>   CONFIG_VIRT_DRIVERS=y
>   CONFIG_VIRTIO_FS=y
> -CONFIG_DRM_VIRTIO_GPU=y
> +CONFIG_DRM_VIRTIO_GPU=m
>   CONFIG_SERIAL_8250_CONSOLE=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_CONSOLE=y
