Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBE3EBF35
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997606; cv=pass; b=aNW7jNWA3rHTjfFd1IgN4BHFMRx6DlPRNnJMF99FUvp2CEhgTcCCz5jJlmy7nxoA/mABeD3CtSjYkZ7EyJY1TGajHh8zD5KH3SS/i2tW6b/CEqA2fa2BcnO3XMCTAzkgfzAF35xSH2potFxqSF/oDMhEhI0CSgOdEocW5iu4tDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997606; c=relaxed/simple;
	bh=gmgbhTyhQx+wUqximI+fmsjjfqU1tXcJ9cSkcVemAkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSfGJ0OfjE6XqiAXYMjz1UtM8NqOyKq0do/Bti5nBiHiCCq7gL3cPQCFS7CwwOfee+iLo2qGuBZozFDFNk/kGHK2f+DbqT4RNSytTTu7y8Q8avXSYXgmhW8s1v9aYzU9oe1a5fMBQYXr2ushsruysC/KdvCmSuSRvGOYonLN1Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=PtunseUF; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="PtunseUF"
ARC-Seal: i=1; a=rsa-sha256; t=1780997600; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iDEvrw1Dq2HIN7OukvusgryGQoBO+HU/C5GY98vYaOFuEkLtC0TE6HRcK751qTnfaGAWT7fbnwqypTt21GOJ43ot+TnbY3uoWSM/yQEaYXiu4bkKRagmVAfD0eM0rx0U5edMffpqNBx0mDh8g0JSn6ufVaPTDc+L8xxQplsZbbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780997600; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DuGyATpVDCq2U+x6FOCLqzsfKSYEd/RC9gNp5InX4a0=; 
	b=XWU89krI6x8Hp9/Grl4nx1+UO3M7OfJ82Ui5U4lxX45AHrHIoMO5HzcxUqOp1SHBKs9fhzWGx7K6U/CL1zhf7yd+Il22FTiV00Oz5asfYnSwOgo+Isf2P63u6m8/xrjN3RyZbokYmdr2vvIfryR65De9bl60h2JVcgVAF9ZIj/g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780997600;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DuGyATpVDCq2U+x6FOCLqzsfKSYEd/RC9gNp5InX4a0=;
	b=PtunseUFFOOiQ+nL8zRWeeAFx3JxKz0dy3RF/ZaGuQdusB3ivn+utspFf28ii+sU
	OGLeiLqXPRdb093hh2qJmURA+BSr9wsk9O0Pnmk50PMLs5NfIwzsdmIKQI7KlxYtNyb
	WoqKKlFQW7+lyZcLYTunlzOMhCO6dRKSR8TnSn70=
Received: by mx.zohomail.com with SMTPS id 1780997598543587.3355295915643;
	Tue, 9 Jun 2026 02:33:18 -0700 (PDT)
Message-ID: <07dfb87d-ac61-45e4-be83-6df6ffee7f75@collabora.com>
Date: Tue, 9 Jun 2026 12:33:14 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/virtio: Fix driver removal with disabled KMS
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <18b75e0e21e52581.f1a5ca06374b8df6.21049e9ba3a0559d@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18b75e0e21e52581.f1a5ca06374b8df6.21049e9ba3a0559d@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/9/26 11:59, Ryosuke Yasuoka wrote:
> Hi Dmitry
> 
> On 08/06/2026 21:40, Dmitry Osipenko wrote:
>> Hi,
>>
>> On 6/7/26 07:31, Ryosuke Yasuoka wrote:
>>> Hi Dmitry
>>>
>>> On 04/06/2026 15:27, Dmitry Osipenko wrote:
>>>> DRM atomic and modesetting aren't initialized if virtio-gpu driver built
>>>> with disabled KMS, leading to access of uninitialized data on driver
>>>> removal/unbinding and crashing kernel. Fix it by skipping shutting down
>>>> atomic core with unavailable KMS.
>>>>
>>>> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
>>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> index f0fb784c0f6f..2aaa7cb08085 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>>>>  
>>>>  	virtio_gpu_release_vqs(dev);
>>>>  	drm_dev_unplug(dev);
>>>> -	drm_atomic_helper_shutdown(dev);
>>>> +
>>>> +	if (drm_core_check_feature(dev, DRIVER_ATOMIC))
>>>> +		drm_atomic_helper_shutdown(dev);
>>>> +
>>>>  	virtio_gpu_deinit(dev);
>>>>  	drm_dev_put(dev);
>>>>  }
>>>
>>> The patch looks good to me at a glance. I haven't done a full, deep code
>>> review yet, but I've tested it on my lab and everything works as
>>> expected.
>>>
>>> Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>
>> Thanks a lot for the testing. The review from you will be very welcomed
>> too.
> 
> I reviewed your patch and this change looks good to me.
> 
> Reviewed-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Thanks for the review, applied to misc-fixes

-- 
Best regards,
Dmitry
