Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551D202F70
	for <virtualization@lists.linux.dev>; Tue, 10 Feb 2026 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770707997; cv=none; b=rp5LBLulyVDlRsxvEYcYxY/OvgFWuoEFQg8C7tQa/WHJeVG/icQcNPzLHhFHC4IxsfQ+s2i/1FIG9f7tmUyFBlxfEz2XyJavTIJE5b0e9PKK0EFtRplxqMAACXnATq6RjfI0r327Jao/4lwrUbEjdUiJqNWWlRTp4XyCf14U5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770707997; c=relaxed/simple;
	bh=mXytY2lL2wi8cjZeNB2IcAirtUMY2l1nJ77qqr3eRgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0sOz1oxdKhuvXNcptoa4dDfWzg2/yp0TTFv4WLliYkV7HK+ButFC20pqsc+jOGmPopz1LmjY9lkyuPDunbs3Wr0ul9dLsO4h5fGX+bUYFCH0IWOp1iZ1IXewqHMp98wGlEbS79hNKT9iS9ypqN6YDxqMSp/JPwuZgfPj2Z+l2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cORE1bB6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cORE1bB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770707995;
	bh=mXytY2lL2wi8cjZeNB2IcAirtUMY2l1nJ77qqr3eRgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cORE1bB6JiXPP7MxYMEIB9mnMgtmqwgQWX81FlF2vw5eQto+1TUUuWBeugjetaSV8
	 Hj+Ua2UaDoaOn3wzQBLNmooz3DV7UbKMkaVOSRxOlRZWasCebnpSw3TCi3wavrMIPR
	 VAF1c/3QFj1yh3vT9Abs/Xzwp/B9+EPUKy3EkSI0xnN/DW0r3RvRro0opIMTKzU4E4
	 uhPC1u5cw0mgJG1qxpa3eSkS6XE0xImmDJtUcFxDzPlTvUnhr6AmuPM35XvHS2uN1u
	 0lUvIGnc7IC+qf+frLWojZ/ioO6Fx2k2K1yWxtkXE4ChKnpDTrOx/y6p8Yjiev5gZL
	 PDXhRtW/OBwxg==
Received: from [192.168.50.190] (unknown [171.76.81.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 36D1717E13A6;
	Tue, 10 Feb 2026 08:19:49 +0100 (CET)
Message-ID: <5ed6508c-78ab-4606-b503-9bc54f5cdea9@collabora.com>
Date: Tue, 10 Feb 2026 12:49:46 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] drm/ci: uprev IGT
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 lumag@kernel.org, robdclark@gmail.com, robin.clark@oss.qualcomm.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 valentine.burley@collabora.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260127104406.200505-1-vignesh.raman@collabora.com>
 <20260127104406.200505-7-vignesh.raman@collabora.com>
 <zi7frtnecrzyei4fl4nmwmth3icnsyycxxobbrcwovbqfsfq4z@eh25dyfrjkqz>
 <9949e82b-6ec2-4975-939b-d6a709ecf43f@collabora.com>
 <5vxrhiilcsaull2airasmc3pjqazvswrtojozz264i5vk3m6zl@pgkdwq46p4ho>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <5vxrhiilcsaull2airasmc3pjqazvswrtojozz264i5vk3m6zl@pgkdwq46p4ho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 27/01/26 19:55, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 06:26:11PM +0530, Vignesh Raman wrote:
>> Hi Dmitry,
>>
>> On 27/01/26 18:01, Dmitry Baryshkov wrote:
>>> On Tue, Jan 27, 2026 at 04:14:01PM +0530, Vignesh Raman wrote:
>>>> Recent IGT [1] seems to be broken on MSM hardware, with many tests
>>>> failing due to the old_primary->index != 0 assertion. Uprev IGT to
>>>> the last known good revision where the tests pass, and update the
>>>> expectation files accordingly.
>>>>
>>>> [1] https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/commit/a909ab05
>>>>
>>>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>
>>> It is not clear, which parts here are due to Mesa uprev (yes, there are
>>> some of those) and which are due to the IGT uprev. Please split into two
>>> commits and make sure that Mesa-uprev passes more or less clearly.
>>
>> The mesa uprev and the IGT uprev are already split into two separate
>> commits. The IGT uprev only updates the IGT version in gitlab-ci.yml and
>> xfails.
> 
> I think I was not clear enough: Mesa uprev also causes some of the
> xfails. Those needs to be a part of the Mesa uprev commit.

I have created v2 where the mesa uprev commit also includes the updated 
xfails. I will send IGT uprev as a separate commit/series.

https://lore.kernel.org/dri-devel/20260210071138.2256773-1-vignesh.raman@collabora.com/T/#t

Regards,
Vignesh

> 
> 

