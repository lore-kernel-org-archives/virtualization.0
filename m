Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF173E3C73
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944040; cv=pass; b=vAtZSJbQ0/EDX46oIk8zyyc1SEUx8shmzsWCIem6xcWSUBa0lzqDKA1VNGvzqAtAu/ZxJxcH8HWj3QQbh/p2+TYHUbfcoYdb6ZZoby6J517q28ahu3NYBSNYmEhqBA4fhszOB6B5/sjHZODL7uXoULKFBhgJj7eI50EbqNmz5h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944040; c=relaxed/simple;
	bh=WBlCfgafm2bC+XsIM4YxaxLhOW4FfJwVKHEdH+yOieI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ah0KbR9InY+uZyE0C+vfb525DPZu5Em2DJfRHn3glWApquhDg9Iz+6MTdjyb4GwdmklznMzGQ4dMbQg+5hS0dkRQgWMcZ48oKB7d6+bC4OlQ2/AMpnOZ++KmcYzJeXNm2duE6ETnIjTE3subaFezHp03N0xgKIAS0CL65WjJ/4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=CxtYaqve; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="CxtYaqve"
ARC-Seal: i=1; a=rsa-sha256; t=1780944031; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V+Q0Hlf+InbGgJsbB4Ca3LX/SlvPfkjXOXJ1N1aYCX4Fca+CDdK/cP8gSZzILVc2TuH2gMfsystClJzsnIF/qnhGTkV/OJeLvcypip128chGHqg+zI6S44b8stlpHArmuygRE3Hsq8oahQg9hEewYqHXP+H7nIMQmDBZzpyxn80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780944031; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vDOv6K/z5q4R9/tHJ2kRUQ/ajocq4J9icfQx3EXym8s=; 
	b=LS+i9SsjkKU6wIsN25iBFsHXDhJ1h8OxyUTBOA3tJo5ZuHpy2fdAyoC4pdL6RjJr7uXxzJRvVwSYYeJf3umURhiP7kyHZqwaqGmOjq+sPsf7178DPshLzyzzGKOkRivE/CtKpYIHiOgW6+Hf+US2841oacwUDEX0RhDcJ8M/7zU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780944031;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vDOv6K/z5q4R9/tHJ2kRUQ/ajocq4J9icfQx3EXym8s=;
	b=CxtYaqveK6YN4L77uspBr/zRjmV5Fy6n1wByPBRLuwe0yGgfxhcs+b0ea4w3RRUN
	rIKjXN7QQhUFu9TDL+5caNC/IKdHWctK+kJuh5qgLIBhtCb/RFb+R6ABRBVjulJcxrM
	Lgs5KplSkQ7mmeoanVKQNxZJEDvsSnaa6s8/bp+s=
Received: by mx.zohomail.com with SMTPS id 1780944029758968.0992923301662;
	Mon, 8 Jun 2026 11:40:29 -0700 (PDT)
Message-ID: <f3848234-4258-483f-bc27-cdd31f65e7aa@collabora.com>
Date: Mon, 8 Jun 2026 21:40:25 +0300
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
References: <18b6b23ae1412a71.6d9db1e7acbb9813.37ad12b07518c586@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18b6b23ae1412a71.6d9db1e7acbb9813.37ad12b07518c586@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

On 6/7/26 07:31, Ryosuke Yasuoka wrote:
> Hi Dmitry
> 
> On 04/06/2026 15:27, Dmitry Osipenko wrote:
>> DRM atomic and modesetting aren't initialized if virtio-gpu driver built
>> with disabled KMS, leading to access of uninitialized data on driver
>> removal/unbinding and crashing kernel. Fix it by skipping shutting down
>> atomic core with unavailable KMS.
>>
>> Fixes: 72122c69d717 ("drm/virtio: Add option to disable KMS support")
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> index f0fb784c0f6f..2aaa7cb08085 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -138,7 +138,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>>  
>>  	virtio_gpu_release_vqs(dev);
>>  	drm_dev_unplug(dev);
>> -	drm_atomic_helper_shutdown(dev);
>> +
>> +	if (drm_core_check_feature(dev, DRIVER_ATOMIC))
>> +		drm_atomic_helper_shutdown(dev);
>> +
>>  	virtio_gpu_deinit(dev);
>>  	drm_dev_put(dev);
>>  }
> 
> The patch looks good to me at a glance. I haven't done a full, deep code
> review yet, but I've tested it on my lab and everything works as
> expected.
> 
> Tested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>

Thanks a lot for the testing. The review from you will be very welcomed
too.

-- 
Best regards,
Dmitry
