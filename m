Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897B45D5D2
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714910; cv=pass; b=oS4MOhgFvF2bLF9ci0xcCIYf0TAmCAFs4GB/0Rsiai/Sv7mHJbPR6Ex799BBPiT6+85ROZ0MO3PBK8KvgSHksSMgWgn1k4BuGlureRFu9obIcZ9Xx58DHIs5a0t8u/lRb9bgD6PbhF0nWFZztKUZGNH2KKI9sjjeaYu/k0mpxqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714910; c=relaxed/simple;
	bh=KnYFu+0Pr+1yWL36FqzLYbua8IH8WMkkgWB58HksJQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIcs0dexKoGT8B5Y+G2pvh+Baqdw4enaY/5kIegEoX2XCwICyvsBIBAlOglkAoTd6d0OVoEkZa0OUt1bqAXkbTwHhux6ld8ebimbOIpNVEMkb1u9Ys7EUfTWX5axOGVSXQfLY35aOhHWgv5i7vQBKCj3djhFt8ERdvAEPaE86tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=YyjayQyj; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YyjayQyj"
ARC-Seal: i=1; a=rsa-sha256; t=1786714880; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RfB+S5eo+B70tgoiJiaUj6B4fvyyXPcPUpxJqlmTO52oMlpnwMS2/Z9QjZ4RtWjU7OsxbjCKQCueZHR8ZmqcXsHsQjWo2QCZyDY/6Az1MTe0JAcZLaVBgzeIgt9WO0GjOSHys4bPlwL8ngX72Gc7L09fV6aV6ecwmooORvNiNt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786714880; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sBlVtjrdGrH7xH4Uq9lPLIVQfaQRHi3iEeSdMZY2a8A=; 
	b=V77MZlpiwrw32hWQoIjEspYSVo6dfsF7DF50fdtYsZXcSSg9Vf8CWIAKuAEmXdRlg76Xqbpxuqdtq5w3Dl7XTr+y5m34SZea1JrIyXsUj67YRUGPA1lxQCL08Eb/p5JPSdTtBYWewigg97VMj/7znBW7G7yD1imVKHyK/VY3p48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786714880;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sBlVtjrdGrH7xH4Uq9lPLIVQfaQRHi3iEeSdMZY2a8A=;
	b=YyjayQyjqWPkXVQNhB9PZO7FU6ojGASJgeo5P6JyfwW6s/BF4rKTTw8yYfhmGDnp
	3IZGHf6/9bCrkw/2/ibvnh8ts2Ar2kxL2ECp+Dfb6INbFc//2ONM4jHr0vJB1KFq+DH
	pMq21zIsmlTPCtWjprD9G0fyAyQLsjmd9llQ7UFc=
Received: by mx.zohomail.com with SMTPS id 1786714879066340.63588891564586;
	Fri, 14 Aug 2026 06:41:19 -0700 (PDT)
Message-ID: <e1100593-ed22-4c22-b202-a03c00f2d56c@collabora.com>
Date: Fri, 14 Aug 2026 16:41:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] drm/virtio: check return value of
 vgdev_output_init()
To: shechenglong <shechenglong@xfusion.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
 chenjialong@xfusion.com
References: <20260802101108.1595-1-shechenglong@xfusion.com>
 <20260811015624.830-1-shechenglong@xfusion.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260811015624.830-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/11/26 04:56, shechenglong wrote:
> The return value of vgdev_output_init(), called by
> virtio_gpu_modeset_init(), is not checked. As a result, modeset
> initialization continues even if an output fails to initialize.
> 
> check the return value and return the error to the caller.
> 
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 44ffffec550f..f2b98d018c1e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -378,8 +378,11 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> 
>     vgdev->ddev->mode_config.fb_modifiers_not_supported = true;
> 
> -   for (i = 0 ; i < vgdev->num_scanouts; ++i)
> -       vgdev_output_init(vgdev, i);
> +   for (i = 0; i < vgdev->num_scanouts; ++i) {
> +       ret = vgdev_output_init(vgdev, i);
> +       if (ret)
> +           return ret;
> +   }
> 
>     ret = drm_vblank_init(vgdev->ddev, vgdev->num_scanouts);
>     if (ret)
> --
> 2.33.0
> 

Applied to drm-misc-fixes, thanks!

-- 
Best regards,
Dmitry
