Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969E22FFDF3
	for <virtualization@lists.linux.dev>; Wed, 27 Aug 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302718; cv=pass; b=kZL7Sl/klxW/G4iT9+yn/Pog8uXm0+cnqCj/xDTyjbg1y3yWJa4fzbyDt/mFy1yd0nLspnpfc/VM+vBAtc1zSPZK/afBxInAwU5Q+xMXyy1rLWvL2Ht/27S6OSvfNNGJ8Ir7fEUGKdtGFExYvbbaYkKPO39xaYh5EkKRwrFNymc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302718; c=relaxed/simple;
	bh=Vxwm7fPLCfOF27s2ioW7LLt2uWYZCG+SENORbSAmjMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkscqt7iRYmTl2EtUViGO77aGTbLcdCVafk6/dy4Iy60OQ5qGdyj/vcgenmJp1jYnbMdYlIuxRahUdJdS21zQmEu6UgjZ5o+yoYawdBNhVk5tmB1EmcLFm3H2aR7h02cI2pdL/5knCAV8373RrCQt7D0KL4pHwUFk4cy4gZSElA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ilyMGL76; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ilyMGL76"
ARC-Seal: i=1; a=rsa-sha256; t=1756302704; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Yh5Nbo9xBtgQquxT/qctZYSJZhiA10KfgVT77xk+HjndUMVTkx93Y2zWNzscwZC5ZKaV42Jyg5FwFbFL65kxwS+J9lYDm6UbvhBrU9cIIQQCUYi/rZD2IJdA3TjFDcpzWZ/sHv7p23FE0ExsfxJZemTxFF63XyEi2FrsJk8PGZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756302704; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EAFsioYoZbKGGEutWEZhd4alxqjm707Aznz1ZWVx3qw=; 
	b=h+/4Ql/bYUF5tjs9LPqYPrJIwNBzH384Rx2dKLSMkmdm77jBTnQtJlzXRvUaAabuT1f5SVjoMCwl4RWSE6KtgCUF4YCaklYG85OC07WyMPnLHBB/AfKzNmukNGUl20rnRgglXimb0oWrvSf2BPFnFMlDlYglqWxWyaTpXGeSQP8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756302704;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EAFsioYoZbKGGEutWEZhd4alxqjm707Aznz1ZWVx3qw=;
	b=ilyMGL76UggPGXRg+vn0XjxklEPTkIjjAKDdHp8p8MwTUFIeBcovPdPpKZlv/Nts
	g0vuz0yROpkReQNaQf93S7B/1W+UzaTDzVlK0dOyBsxnWHFcnyRPdmaQ/lmqZa2zAHS
	qUFLQT1723TX5tF05ClP9ZWOaeiuoc9YMBHSErfQ=
Received: by mx.zohomail.com with SMTPS id 1756302702560280.8524637739665;
	Wed, 27 Aug 2025 06:51:42 -0700 (PDT)
Message-ID: <c38fb2bf-15c4-4cee-be0e-59d998cd03ac@collabora.com>
Date: Wed, 27 Aug 2025 16:51:37 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix host visible memory detection in
 virtio-gpu
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Honglei Huang <honglei1.huang@amd.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250827081231.1878248-1-honglei1.huang@amd.com>
 <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>
 <20250827093320-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20250827093320-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/27/25 16:33, Michael S. Tsirkin wrote:
> On Wed, Aug 27, 2025 at 03:52:05PM +0300, Dmitry Osipenko wrote:
>> On 8/27/25 11:12, Honglei Huang wrote:
>>> From: Honglei Huang <Honglei1.Huang@amd.com>
>>>
>>> Commit 206cc44588f7 ("virtio: reject shm region if length is zero")
>>> enhanced the validation in virtio_get_shm_region() by adding a check
>>> for a zero-length shared memory region.
>>>
>>> It is performed before the underlying transport's .get_shm_region()
>>> implementation is called. This creates an issue in the virtio-gpu
>>> driver, where the `region` struct is part of a larger structure
>>> that is zero-initialized by drmm_kzalloc().
>>>
>>> Consequently, the `len` field is 0 at the time of the check, causing
>>> virtio_get_shm_region() to return false prematurely. This prevents the
>>> host visible memory feature from being enabled, even when the device
>>> supports it.
>>>
>>> To resolve this, this patch bypasses the inline helper and calls the
>>> underlying vdev->config->get_shm_region() function pointer directly.
>>> This ensures that the region's parameters are checked only after they
>>> have been populated by the transport, aligning with the intended logic.
>>>
>>> Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_kms.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> index 7dfb2006c561..ed5981248302 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>> @@ -174,8 +174,10 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>>>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
>>>  		vgdev->has_resource_blob = true;
>>>  	}
>>> -	if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
>>> -				  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
>>> +	if (vgdev->vdev->config->get_shm_region &&
>>> +	    vgdev->vdev->config->get_shm_region(
>>> +		    vgdev->vdev, &vgdev->host_visible_region,
>>> +		    VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
>>>  		if (!devm_request_mem_region(&vgdev->vdev->dev,
>>>  					     vgdev->host_visible_region.addr,
>>>  					     vgdev->host_visible_region.len,
>>
>> Hi, virtio_get_shm_region() change has been reverted by [1]. Don't think
>> anything else needs to be done.
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250827&id=ced17ee32a9988b8a260628e7c31a100d7dc082e
>>
>> +cc Michael Tsirkin
>>
>> Might be only good to send a stable kernel PR with that revert. I see
>> patch available only in linux-next, while stable kernels need to be
>> fixed sooner.
> 
> sooner than what?

Next 6.17 kernel release. I see patch in the linux-next branch. Often
there is a -fixes branch for patches that go into RC kernel, but I don't
see one in your vhost kernel tree. Will the revert land into 6.17-rc4?
Everything is good if yes.

-- 
Best regards,
Dmitry
