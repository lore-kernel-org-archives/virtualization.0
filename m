Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD434AB1D
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830562; cv=pass; b=ZG9jUMk+I0Y5UZk7sukRqmi0yGdiGxBQdQ3VvKiocBJODqXDHmCSjEubah8sNBaVRenrTNLfL9GtfMt+hPldvYxTzkXV4Zdp+znrJcwJZM8TktN8heEmx/MgvXpNonlP95YLqVzhsSQyCQDdJVIXulBvf9v5ksa1q1Y7Qoq8fbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830562; c=relaxed/simple;
	bh=vwP7hI6SWbOwF/x2X0FZRudTT7JXvS/1okAxZF4h6iI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gw4/xPVcqyFw578bAaJflUuhQyd0a1aum7Q9PbKpJAHKaAfRRMkKz4NRFJz6UK2/VMtkEYYAUVsHKhrm+1hDrhskvrSyYahPbq0YGPQ2qy/C2xquX6ItmUyoEBo9Rm7QpOxjaqApDzPlsARokf6RGzB38+ywa5xikHh7iPHx1fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=TYmuFuPU; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="TYmuFuPU"
ARC-Seal: i=1; a=rsa-sha256; t=1782830553; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PD3N0zSWqcHkBLUJXXVo9xmsR9Bk/edTQ1Zj++EMrOPWI5Xxm5PrgRzwbNuVTVWcmsxskMXP7PxX+vXHq2yPXLh4zvVJ84klk1gWwzuRqtnrVfWDlUoP3Kq2wUzFLOXavh0vUDGZdaa5scp4ML+8VEk9oNAUK9ynAjhiaBqiBA4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782830553; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nDzUCinhqLX/oyWxM4Vcrz12+bJW/6luK783RfqJDio=; 
	b=OQ4YgzWgDZI6jAPQ2gWPmFmpJBsQHyYHKk6d9ahkRqJ00tcgy5pI2lQvJVgSflWuX0r+enjczTGwqD0ndFswcEda/gq8GVkxY+t11hmpIuVcxi2hhkkY7g+XB9CRkbeE+xN+vGmIbYv0+LybnjNUgC2rurn294dniw7EgXj237k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782830553;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nDzUCinhqLX/oyWxM4Vcrz12+bJW/6luK783RfqJDio=;
	b=TYmuFuPUVvdG4tllhAtGrK7QBv3EHpcLhGuOJreqwQU32VVmelkQjWW0Um30QxAs
	FWFHoFM29a6F7y0Ysa0t1Xj2nmxWynXIswVukT5+J4HwaxMbI+dVDutVdmb1Xuq1pKm
	c6ncUyOlfW6H3NlN5dK19eWUVf6FBcuyozVb/tlU=
Received: by mx.zohomail.com with SMTPS id 1782830551361970.0532585868376;
	Tue, 30 Jun 2026 07:42:31 -0700 (PDT)
Message-ID: <857b0af4-968e-4152-96a1-1fa221f0085c@collabora.com>
Date: Tue, 30 Jun 2026 17:42:26 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fail init on display-info timeout
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
 <f5c5fc6c-3c6e-4068-80d7-f1acebff7168@collabora.com>
Content-Language: en-US
In-Reply-To: <f5c5fc6c-3c6e-4068-80d7-f1acebff7168@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/30/26 16:36, Dmitry Osipenko wrote:
> On 6/25/26 06:02, Pengpeng Hou wrote:
>> virtio_gpu_init() sends GET_DISPLAY_INFO when scanouts are present and
>> waits for display_info_pending to clear. If the response never arrives,
>> the wait result is ignored and probe still succeeds.
>>
>> Return -ETIMEDOUT on display-info timeout. Because this happens after
>> virtio_device_ready(), reset the device and tear down modesetting before
>> using the existing vbuf and virtqueue cleanup path.
>>
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_kms.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> index cfde9f573df6..31209bea97ae 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -262,11 +262,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>>  			virtio_gpu_cmd_get_edids(vgdev);
>>  		virtio_gpu_cmd_get_display_info(vgdev);
>>  		virtio_gpu_notify(vgdev);
>> -		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
>> -				   5 * HZ);
>> +		if (!wait_event_timeout(vgdev->resp_wq,
>> +					!vgdev->display_info_pending,
>> +					5 * HZ)) {
>> +			DRM_ERROR("timed out waiting for display info\n");
>> +			ret = -ETIMEDOUT;
>> +			goto err_ready;
>> +		}
>>  	}
>>  	return 0;
>>  
>> +err_ready:
>> +	virtio_reset_device(vgdev->vdev);
>> +	virtio_gpu_modeset_fini(vgdev);
>>  err_scanouts:
>>  	virtio_gpu_free_vbufs(vgdev);
>>  err_vbufs:
> 
> Rebased and applied to misc-next, thanks!

Now see [1] having valid point on a leaked memory allocations. It's not
trivial to free that memory properly. Perhaps best will be to revert
this change and use wait_event() without timeout, will think further on
it before proceeding.

[1]
https://sashiko.dev/#/patchset/20260625030202.82590-1-pengpeng%40iscas.ac.cn

-- 
Best regards,
Dmitry
