Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5B6D1C8
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062075; cv=none; b=X2SFQkEgafLJtRWacast2PS0+mPuSPwWvjeHU4xJS9+vSeM06wY6iR6S+1ie2zwqaHj0wnFqhaiFJYJU2mxvdQmntCf7CbIxmTkX7WrNgc9DVaFqejeEtY7UyN49u/3sIRDMbKyBc7mLsmV0BSJdelHh93sHoSZfocLb7egeZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062075; c=relaxed/simple;
	bh=PlQSgc+9IxLV0sJ6C1/5bvFwcWpttEUfHiGgnmdu6Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aikqDznvCIW8EyrxQ76alV8GfEjFQ540hdfAxxqzRKrHsN3ARlxaiV1MYpylC0QHPxKlOCdcb/6S7osnnRGenaevZDg4F3lM1rS7c4PXLe0WKfOBYBTvoOlSGdLWyB5xekpq2Yp8HvpQyci1xFeywCMDJYnmM/jENpTIE+8Gu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ipqF4hl/; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ipqF4hl/"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D7C18232E
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 06:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kAnygjPi5y0w for <virtualization@lists.linux-foundation.org>;
 Tue,  7 May 2024 06:07:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1098:ed:100::25; helo=madrid.collaboradmins.com; envelope-from=vignesh.raman@collabora.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8479F82154
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8479F82154
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ipqF4hl/
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8479F82154
	for <virtualization@lists.linux-foundation.org>; Tue,  7 May 2024 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715062070;
	bh=PlQSgc+9IxLV0sJ6C1/5bvFwcWpttEUfHiGgnmdu6Dw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ipqF4hl/Rcm2Qj/XN/NVqODYOMJ6wZnkt9fpAiy98aO/tLdRWOib8pnJYQu2KXfWq
	 nFr9SSNAWgzhhZuIWGSvUbIYAO3FvKoBHBqvJcyZBCP/fAIb4S6dQZaDrSko8AHZqe
	 ghJQ7o3IXG0a9eGDBLCZwXNawWI6oRa3DmJwCkCXzBbR/7dWsX3lp1irUIqgJGy56w
	 TexPPvhiblZgrBX8xS3O/wsGBqPYX/pE8IZridNeFfqFuDPqcoxiSga7I59V3jjvEV
	 wKTl9+sm3eXksZXwIrDdEevFXuH8R4SHwP+g9TCVBVD8PFDssxfR112SS9CSE0ZrQ2
	 EErlUtRQ5weZw==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19B6D3782112;
	Tue,  7 May 2024 06:07:46 +0000 (UTC)
Message-ID: <b143f1e8-e595-4f09-b6ab-d7e5743d586e@collabora.com>
Date: Tue, 7 May 2024 11:37:45 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] drm/ci: update xfails for the new testlist
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 mcanal@igalia.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-6-vignesh.raman@collabora.com>
 <hon4klkoaouuxhtvm3qb3qstsrdcibihksyrmvxkt3taijl6wb@ubitr6namryw>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <hon4klkoaouuxhtvm3qb3qstsrdcibihksyrmvxkt3taijl6wb@ubitr6namryw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 30/04/24 15:45, Dmitry Baryshkov wrote:
> On Tue, Apr 30, 2024 at 02:41:21PM +0530, Vignesh Raman wrote:
>> Now the testlist is used from IGT build, so update
>> xfails with the new testlist.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>   .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt | 47 +++++++----
>>   .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  8 +-
>>   .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt | 15 ++++
>>   drivers/gpu/drm/ci/xfails/i915-amly-fails.txt | 22 ++++-
>>   .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |  8 ++
>>   drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |  8 ++
>>   drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  | 45 +++++-----
>>   drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |  5 ++
>>   drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  | 12 +++
>>   drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  | 26 +++++-
>>   drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |  6 ++
>>   drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |  8 ++
>>   drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  | 28 +++++--
>>   drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  | 12 +++
>>   drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  | 39 ++++-----
>>   drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt | 10 ++-
>>   drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  | 21 +++++
>>   drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  | 75 +++++++++--------
>>   drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  | 13 +++
>>   drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  | 46 +++++------
>>   drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |  8 ++
>>   .../drm/ci/xfails/mediatek-mt8173-fails.txt   | 47 +++--------
>>   .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 17 +---
>>   .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  5 ++
>>   .../gpu/drm/ci/xfails/meson-g12b-fails.txt    | 20 +----
>>   .../gpu/drm/ci/xfails/meson-g12b-flakes.txt   |  5 ++
>>   .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   | 26 ++----
>>   .../gpu/drm/ci/xfails/msm-apq8016-flakes.txt  |  5 ++
>>   .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  5 +-
>>   .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |  5 ++
>>   .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   | 67 +++++++++++++++
>>   .../msm-sc7180-trogdor-kingoftown-fails.txt   | 34 ++++----
>>   .../msm-sc7180-trogdor-kingoftown-flakes.txt  |  5 ++
>>   ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 34 ++++----
>>   ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |  5 ++
>>   .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    | 75 ++++-------------
>>   .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   | 26 ++----
>>   .../drm/ci/xfails/rockchip-rk3288-fails.txt   | 54 ------------
>>   .../drm/ci/xfails/rockchip-rk3399-fails.txt   | 80 ++----------------
>>   .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  7 --
>>   .../drm/ci/xfails/virtio_gpu-none-fails.txt   | 82 +++++++++++++------
>>   .../drm/ci/xfails/virtio_gpu-none-skips.txt   |  3 +
>>   42 files changed, 574 insertions(+), 495 deletions(-)
>>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
>>   create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
>>   delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
>>   delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
>>
> 
> [skipped]
> 
>> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> index 44a5c62dedad..96e9faf0e607 100644
>> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
>> @@ -1,19 +1,9 @@
>> +core_setmaster_vs_auth,Fail
>> +device_reset,Fail
>> +dumb_buffer,Fail
> 
> This doesn't look correct, core tests should be passing.
> 
>>   kms_3d,Fail
>> -kms_addfb_basic@addfb25-bad-modifier,Fail
>> -kms_cursor_legacy@all-pipes-forked-bo,Fail
>> -kms_cursor_legacy@all-pipes-forked-move,Fail
>> -kms_cursor_legacy@all-pipes-single-bo,Fail
>> -kms_cursor_legacy@all-pipes-single-move,Fail
>> -kms_cursor_legacy@all-pipes-torture-bo,Fail
>> -kms_cursor_legacy@all-pipes-torture-move,Fail
>> -kms_cursor_legacy@pipe-A-forked-bo,Fail
>> -kms_cursor_legacy@pipe-A-forked-move,Fail
>> -kms_cursor_legacy@pipe-A-single-bo,Fail
>> -kms_cursor_legacy@pipe-A-single-move,Fail
>> -kms_cursor_legacy@pipe-A-torture-bo,Fail
>> -kms_cursor_legacy@pipe-A-torture-move,Fail
>> -kms_force_connector_basic@force-edid,Fail
>> -kms_hdmi_inject@inject-4k,Fail
>> -kms_selftest@drm_format,Timeout
>> -kms_selftest@drm_format_helper,Timeout
> 
> Fine, kms_cursor_legacy tests were migrated to -flakes. But what
> happened with the rest of the failures? >
>> -msm_mapping@ring,Fail
>> +kms_force_connector_basic,Fail
>> +kms_lease,Fail
>> +msm_mapping,Fail
>> +msm_submit,Fail
>> +tools_test,Fail
>> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>> new file mode 100644
>> index 000000000000..3cc361b3d3b3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>> @@ -0,0 +1,5 @@
>> +# Board Name: apq8016-sbc-usb-host
>> +# Bug Report: TBD
>> +# IGT Version: 1.28-gd2af13d9f
>> +# Linux Version: 6.9.0-rc4
>> +kms_cursor_legacy
> 
> It looks like one of the scripts has lost subtest granularity. It should
> be fixed before the patchset can be merged
I will recheck these files with the script fix. Thanks.

Regards,
Vignesh
