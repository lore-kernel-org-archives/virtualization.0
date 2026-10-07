Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D63876B2
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409505; cv=pass; b=Vkqt1wn5+38JWMZAfXkwsl9PHduQ1HG4PWXb859781uuwhszYrnDrFwYMbpN122SumnwuclPrOAyrheWH5CKXHnTz15GaVWMGi6t6wapDMIIDSbDilsjuO/P23Td8ZfUbxqwqVSf2C+F2CL9q0TMUEU5ATrXE2KeqqCTnijQFZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409505; c=relaxed/simple;
	bh=3b6Rc5/htYCJctJO6KumkwjdUFIPDEZUAt9Ksy8zy5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojaWtjxe0CAZK+hrUlzgi4k7fREu13vlSWwc1C9EE/UMSMBHdc3qQ6LW/ClWfZRW/1dAXmSOG769AU0nt9pJfMwGj+CKczN047PYk1q6R/8xFXwnFu3idxjf1ygm6hX86miFQG7GumOMj5Ua3vKg8y7a7ah+T5c2LpN50YPBZ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZQJER1hU; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZQJER1hU"
ARC-Seal: i=1; a=rsa-sha256; t=1791409482; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VmLYWhSzgnezPjGJ4M9d9Rb5GHvw+4+TblzvznrsbQX5MloUM21hCzBhtbMDXDddLQS8xUEl/VNOAryu2//yQcXqCb85tl0p36tjKryb3fGS+GNaQPzhnPsLC57a0tNPHEf0EPxJuMrni/uD2BUvU8L8tFA0u1t335iCzndA76s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791409482; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kGvUDiLie0dPMCDwrW6Vkkj/cP8ggVC9Hknrr+6OM28=; 
	b=jLonqA0kH/5mo4SVt/L8rrQMvJtIp8D1PqZR6/pdF+21BipE1SCBRBKgN9E0qU3bQkmPGk/iROJK5XDCi5txB4D6JiH4HvUfn6Qr5pOBje9/FXSkXDV3jDGZc+u4oiGYSNV05IUhFZQ1In5zOi5fTp043Dei0cp5yag4Thw8D7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791409482;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kGvUDiLie0dPMCDwrW6Vkkj/cP8ggVC9Hknrr+6OM28=;
	b=ZQJER1hU6AXDyit5wU9gfobSu6mZNV5z741FIzNSkqRjaO5xXdmhkRkE819HQDt+
	Kp+LSdD+XxJVFBVnEfTaF0/UUmHIw+0cO7XDXPgOETUwBoD144mMFtWb4MJxfqC4qDc
	Gj4q2UFK9GY5IinEFOw839Yv2r5UJ5aVt2wAgwLI=
Received: by smtp.zohomail.com with SMTPS id 1791409480437494.77731485644426;
	Wed, 7 Oct 2026 14:44:40 -0700 (PDT)
Message-ID: <ce72b2f5-1343-44e9-89fe-e2de4efb7e9c@collabora.com>
Date: Thu, 8 Oct 2026 00:44:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/virtio: expose GEM memory statistics through
 fdinfo
To: shechenglong <shechenglong@xfusion.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stone.xulei@xfusion.com,
 chenjialong@xfusion.com
References: <20260922094455.1799-1-shechenglong@xfusion.com>
 <20260928133635.1835-1-shechenglong@xfusion.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260928133635.1835-1-shechenglong@xfusion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/28/26 16:36, shechenglong wrote:
> virtio-gpu does not expose per-client GEM memory usage through DRM
> fdinfo, leaving monitoring tools unable to account for buffers owned by a
> client.
> 
> Wire up the DRM fdinfo helpers and use drm_show_memory_stats() to report
> the standard drm-total-memory, drm-shared-memory and drm-active-memory
> fields for GEM objects referenced by each DRM file.
> 
> Tested on a QEMU/KVM guest with virtio-gpu. After running:
> 
>   modetest -M virtio_gpu -s 40:1024x768
> 
> the DRM file descriptor of the modetest process shows the following in
> /proc/<pid>/fdinfo/<fd>:
> 
>   drm-driver:         virtio_gpu
>   drm-client-id:      8
>   drm-pdev:           0000:00:02.0
>   drm-total-memory:   3 MiB
>   drm-shared-memory:  3 MiB
> 
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> Signed-off-by: chenjialong <chenjialong@xfusion.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 2aaa7cb0808..d43d7ddac60 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -323,7 +323,17 @@ MODULE_AUTHOR("Dave Airlie <airlied@redhat.com>");
>  MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
>  MODULE_AUTHOR("Alon Levy");
> 
> -DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
> +static void virtio_gpu_show_fdinfo(struct drm_printer *p,
> +                                  struct drm_file *file)
> +{
> +       drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations virtio_gpu_driver_fops = {
> +       .owner = THIS_MODULE,
> +       DRM_GEM_FOPS,
> +       .show_fdinfo = drm_show_fdinfo,
> +};
> 
>  static const struct drm_driver driver = {
>         /*
> @@ -347,6 +357,7 @@ static const struct drm_driver driver = {
> 
>         .gem_create_object = virtio_gpu_create_object,
>         .fops = &virtio_gpu_driver_fops,
> +       .show_fdinfo = virtio_gpu_show_fdinfo,
> 
>         .ioctls = virtio_gpu_ioctls,
>         .num_ioctls = DRM_VIRTIO_NUM_IOCTLS,
> --
> 2.43.0

Usefulness of this change is dubious. VirtIO-GPU has different types of
RAM, I'd expect them all represented properly instead of only shmem.

-- 
Best regards,
Dmitry
