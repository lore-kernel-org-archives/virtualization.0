Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF8E379ED4
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437919; cv=pass; b=MT5pyv5SVm14K++SSo/TP7bcUttsT0RlxSR+LY4qn8x+Yr37H7TLfKbfrpzIvs8D1N5r+de7eSeJm7GpHobglPkMXXrHgj+fouXFfUsEY4Chiznfk4NP+WmMW2/dTdBWzDSrztvSlI+H/ulafyUALDL0hrEFX5LD+ldeVAdDUVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437919; c=relaxed/simple;
	bh=4Dyn6hcYWGoT7nnBwjmR1BiKWNDPTapMgtolLQ3lR8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keY+vLv6pcbq0/LBELyUbOfAJYzjNDmziGnh8EgJrXIMXqNGqcf6/kYVqInQ7XQvCIFI2JFTHq7oUeKhJ5QFFC1YfWlNVWOITGMu5dr/IgWXEERiVBrZpe0fkL0Q2bdlQoeIp4cMzKmQPKRc7tTW1mm51ukEK+gqYuWejEAiLpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=DkOxlCn4; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="DkOxlCn4"
ARC-Seal: i=1; a=rsa-sha256; t=1783437909; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M2BE90D7Q/L3A4yNLBItSkb+g47e1dmiTtt4eOPkIcO/mjaTGeAKe2+IUw6UrkyM5ft2RBqGdmgOmpeWbDaPUVy5kbvL78Htx4X0/oXG+VedKdZR6TrjeLHe/T/GxNtkp4nre8mMD76V3vnZYifX5556MiyiXT8HS9VvKMGvguw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783437909; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zsHfKDPWHHLaAMDNdNvYd4BAM5Dx0wlAKrG3pw9LTG0=; 
	b=nbLqYLs6GjcFTxT2h5y8SC4li4YxnDVblhWEs2r02O+GdC5nCDvfOeMGa+2Tta1SRUlJ+c5zUUS2+bqMcrZ0lrNXdvaJBG1+8KkVyHgEwAQGQ4gI+rgRpShNZR44RsUmUVq4et3M5lq6kLAuw9bJIlnW5WOwq477+zHzXP/5RbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783437909;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zsHfKDPWHHLaAMDNdNvYd4BAM5Dx0wlAKrG3pw9LTG0=;
	b=DkOxlCn4VtNQNoD/cFYQdmPW6dIUPLyDRxxolFLF0hcsCU6l14Q+U5q13KvMRvZH
	IoRtHzSV+uG5/cqUWq1/XwTLJGsTT1rRt3XS+p9ztzB+/O75H42/TyUi15TkR+Cv2cq
	aaMrqJ56XZvo20V+HxL9vgMoIdGRV9zKbbcV+ek4=
Received: by mx.zohomail.com with SMTPS id 17834379067971023.5993710227946;
	Tue, 7 Jul 2026 08:25:06 -0700 (PDT)
Message-ID: <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
Date: Tue, 7 Jul 2026 18:25:01 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
To: Alyssa Ross <hi@alyssa.is>, Sergio Lopez <slp@redhat.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergi Blanch Torne
 <sergi@collabora.com>, Valentine Burley <valentine.burley@collabora.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <akT1XEW766c7Imst@mbp.qyliss.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/1/26 14:10, Alyssa Ross wrote:
> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>> aligned to blob_alignment. Validate this in verify_blob() so that
>> invalid requests are rejected early.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
> 
> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
> crosvm bug, so hopefully it can be taken care of there.
> 
> https://issuetracker.google.com/issues/529852979
> 
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> index c33c057365f8..d0c4edf1eaf4 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>>  	params->size = rc_blob->size;
>>  	params->blob = true;
>>  	params->blob_flags = rc_blob->blob_flags;
>> +
>> +	if (vgdev->has_blob_alignment &&
>> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>> +		return -EINVAL;
>> +
>>  	return 0;
>>  }
>>
>> --
>> 2.53.0
>>

Thanks for the report. Indeed, crosvm will need to fix its experimental
caps. CI will likely run into this problem first once it will update
guest to 7.2+ kernel.

-- 
Best regards,
Dmitry
