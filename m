Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F1329C7B
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462428; cv=pass; b=cgMRoVADi6mvDXD/NzFbGkEQg+PqNuPsmNNiPj+50oQYrZbLOBwxH4dmCHyIOeSaxyDL8Jk2z1u0utLBiVVnO+DCI+/os0MsCHM/xUaoX4wM9YsAs3Fvaa6rcpKwV6sTm6RAsn7KHaEIrlWsyIv8hsQ0NFPZ4ZKTWX4wtBF0Qn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462428; c=relaxed/simple;
	bh=JmzLAvf3UeO8UetpY1NENFhV951UHSgnHbI29bEBuZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/eS5xF1WoJq3+dFtzvjf0ASgnf7xLw4e2qBFF1pT7HCpOyXVOONIUDcmMa6JQugw4JSSVm4q3ZJt15/BQmgUYiB137yiWAfr1j9Ee4rnpSfjHubozFL8nQ8w4bk55CyBPuTqtSUFEwnqUu4cf2cp76f9URoIZ/VbNGINep4uJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Pkh8lu97; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Pkh8lu97"
ARC-Seal: i=1; a=rsa-sha256; t=1786462396; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S294u1C0hhNjdEUCGrx+Fiy8Do/HMIty+GBAvlp8eBT45TBLEeW5o3mhe7LQs/T87xmTxSlxgtFxEa9teKquNnVQDxiLjdte3CJAdgCEVbVedBLOhwvXhXoIu6SmtHTyaXO9ObXwrA9gY8/Mm4hI2SerY2QX6RYaNkWFADoRnt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786462396; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NzftxuqCfnZGMD603L8dAoBxg2sa6b+SJ0zSZ6iZbGY=; 
	b=mM9fxw8CJh4DycjJlIcJwW7QrGPMPYTxNAAc60os0Vsy0ampKnV46/Corc/xfC29N4FH2YwRxjGEZ67s8W03MJC8Z0zHvgyFONOjeJqeQ02KGNETr9iQQsejzRz00Nrvfg5qrd4pzyTgFITLyHKppQCubEQ0cWOTarrsY4lZZio=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786462396;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NzftxuqCfnZGMD603L8dAoBxg2sa6b+SJ0zSZ6iZbGY=;
	b=Pkh8lu97iMp6GgYWkJwD+kVpjSpDxoRJg7m7pzcaYKsBEO7iiKFLRzBuILRyejHl
	hDcZWPNNEIDQjGKcZgxQIeBZ6kJjdKAKFkvFzt/xZhzp8QUE3J243SenOTDtqK4p2IQ
	HP7E7OkDoLfU0bbQjwWcvHIbmzEa9B7ztoi6dJKs=
Received: by mx.zohomail.com with SMTPS id 1786462394506624.3926760347739;
	Tue, 11 Aug 2026 08:33:14 -0700 (PDT)
Message-ID: <dfec4abe-eee6-4f15-8410-4739ba5ef2de@collabora.com>
Date: Tue, 11 Aug 2026 18:33:08 +0300
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
