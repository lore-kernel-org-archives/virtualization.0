Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E895382
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838698; cv=none; b=qo2nxy4CloOI9P3cunDqaFwwpFsm9ZgdBBKH7DTnL6cyGnq+y6ExQ+AqjwwAfV1wFAb3xzw1G7DqBHJgetKVvcdKzLBNyy6A3IXO6Rubv1IEUKi10LBj7DHTHKIOSnHn5+psm2JiAftGaUZ8sM1Q8P2P9A2bLlfOHKy4d7PGrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838698; c=relaxed/simple;
	bh=zmevCFhXx6ZuzMCYAfjpOwI5DJ6QN9bdg4fgOkPUdqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRD6ifWtZXG/YXEmb0BPZj6cNrcbFId58H3a0Qpx+ac3kzHv4SDRKTVOAXBilqexc6enu0ecLMEozN2LlJDGoeGkSDrL9gdabs4+X40J0QWqR3D6wKuI41mdrmPbPvCOz/qbsNv7baZ4PYvQVx0sgJpVUjKCIsKJFekmotkLzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qwmnSSbh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qwmnSSbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712838688;
	bh=zmevCFhXx6ZuzMCYAfjpOwI5DJ6QN9bdg4fgOkPUdqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qwmnSSbhoBchnoBCuYnXfp2/6Jh3cN8jMBjFqh9AFIsoZwin9j3UUiUbk6U6zjoEQ
	 ADrLiHD5rMU5plZ6/8l4lXNooe6j1yW+63uH8y6vLZsWmjKI63swv3aSnEFvsr72qr
	 ZM27KFJFjzxFVaS/O97bQ1y/DEGFITe5vyUY/KTwAnyBtRuvfLBx9HzWPCLVf9cIyh
	 8UyhB6kp/XbNKpXQTbtuXeQqzjalp11cbrYLoABsvl3yV+/LEsTBieN3d4WgPJ9VAo
	 6SCIJRqaWzK/6Mg7ZArxaxnbDriu93Qt21D0GAYu6yS2qrbZGPI/P03AZWkqEPye1L
	 xqhzxE9rPH8Qw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0B7C537813C0;
	Thu, 11 Apr 2024 12:31:26 +0000 (UTC)
Message-ID: <6ca1e5de-2188-466f-a05c-ba190702d7a5@collabora.com>
Date: Thu, 11 Apr 2024 15:31:24 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: add driver_priv validation in
 virtio_gpu_create_context
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Ivan Kapranov <i.kapranov@securitycode.ru>,
 lvc-project@linuxtesting.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240328134351.298050-1-korotkov.maxim.s@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240328134351.298050-1-korotkov.maxim.s@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 16:43, Maxim Korotkov wrote:
> The pointer file->driver_priv was dereferenced without checking
> against NULL, but in the "virtio_gpu_transfer_to_host_ioctl" function
> it was checked against NULL after calling virtio_gpu_create_context
> function.
> 
> Found by Security Code and Linux Verification Center(linuxtesting.org)
> Fixes: 72b48ae800da ("drm/virtio: enqueue virtio_gpu_create_context after the first 3D ioctl")
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index e4f76f315550..98fe9ad4ed15 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -64,6 +64,9 @@ void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
>  	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
>  
> +	if (!vfpriv)
> +		return;
> +
>  	mutex_lock(&vfpriv->context_lock);
>  	if (vfpriv->context_created)
>  		goto out_unlock;

NULL check in virtio_gpu_transfer_to_host_ioctl() is bogus, vfpriv can't
be NULL there.

-- 
Best regards,
Dmitry

