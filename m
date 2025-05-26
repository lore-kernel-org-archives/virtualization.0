Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75117AE11
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274509; cv=pass; b=NKdx7TNgxNqCiqxJ3mhl+EQMRgrsDpSZwSd4V20frADG3RiF36PyRLXoIO2VKZ7daCzIp7h0kotaidqCcx0GiMLgVn3EkqG70MANPhfR78tPwJWfDZ/74scVip0wPCUJBf+jq/f3r3vKZaHWp1qQNY28USVvAlqRf8TTe3DTo+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274509; c=relaxed/simple;
	bh=82GBUa9Nldr58fzW7VM8zNc+/lL2Ued6wFmqFQSfTEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yuy76Lqi3fEnaRLfVH7YzjXHNb2lBBQo7kttURUCK7Me7fDPNMqmSk2iX9AiCFpPENiyVOyR7oZ1f8XtphCHQc3W6kOIRXsXRsrIirgpGY/KPM36cgIwXMO8M9JGH0tEApEdnWEjT7YQbfvPiQmTDQhHhNvLxKo1kcQIHupvWRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WfZ1TXlu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WfZ1TXlu"
ARC-Seal: i=1; a=rsa-sha256; t=1748274499; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=naFkj9zmjJ2xcCm8fV/FlsMk8/dkeMOcl1YwlHmZX7ds/XoeeYF1klyHunWpoq0qG/M+W2tatyAX1Ym4HlpAk0pcX6ydAiQoGV5cziCIKpF8gvpSEECvP0v5OtJi2CwOQMTQR57gedDcVsD0xmPLX4hj6wvfYOSn82k50OoKCbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748274499; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7u8vO7Ws768JnzmKvh2GmG4PF4lJ+CEAJNx0uPhyhQE=; 
	b=PUCvEeiZ+HlRLeM5uZhsKIKqMkZ6GGJs6i5MmTEKThCw+crouqHwC1MTIpAYfYmAHmCyHs6aEEi4WMyF9qcmekXci8tMOHOJxWgsUFTBVovV+AbQEor2AyQMm2fAFuNhViKUyZlcOO0fzlK+tuiLJWEc0A9yX0eRQKSVgDvXHV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748274499;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7u8vO7Ws768JnzmKvh2GmG4PF4lJ+CEAJNx0uPhyhQE=;
	b=WfZ1TXlusW0K9YtTSApB3YEK7QfvL25+JrmhothPBfSMvMZG06jBawJPNenNuQbA
	FBa6IxiJkTYRgxuBtQndDvVU8npG7NhqrQlfJ/7lUN7ml6WdX6PSnSDnarekr1OjSVb
	rvaaUNot1I4/xqu0jB/ZPyKmB9mSDKxK+LKUt/Iw=
Received: by mx.zohomail.com with SMTPS id 1748274498096817.1869686603382;
	Mon, 26 May 2025 08:48:18 -0700 (PDT)
Message-ID: <28c64a39-1deb-4e0e-a395-2b243019ae70@collabora.com>
Date: Mon, 26 May 2025 18:48:13 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250507082821.2710706-1-kraxel@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250507082821.2710706-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/7/25 11:28, Gerd Hoffmann wrote:
> Calling drm_dev_unplug() is the drm way to say the device
> is gone and can not be accessed any more.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index e32e680c7197..71c6ccad4b99 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>  
>  static void virtio_gpu_shutdown(struct virtio_device *vdev)
>  {
> -	/*
> -	 * drm does its own synchronization on shutdown.
> -	 * Do nothing here, opt out of device reset.
> -	 */
> +	struct drm_device *dev = vdev->priv;
> +
> +	/* stop talking to the device */
> +	drm_dev_unplug(dev);
>  }
>  
>  static void virtio_gpu_config_changed(struct virtio_device *vdev)

Could you please describe whether this patch is fixing a specific
problem or it's a generic improvement for avoiding potential problems on
shutdown.

-- 
Best regards,
Dmitry

