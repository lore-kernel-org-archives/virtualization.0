Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B80335067
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960292; cv=pass; b=mtYQdI7EW8nzO2w2yZh/l+f+hk9nuzLd4753tdrYDb37wBtk1EvjKCybcVMsihx1gU4CKDD3E/IwdN6d/DU6U2LuH3OHumckV1ARDMR0+GjPudjwOR5PMRnMdAidK42amKxnu2570ecqhanJs2O0pNFTTkrZvP774Uc40i4hNPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960292; c=relaxed/simple;
	bh=OCon9oGLXzvhqdpoIBOnLybztkqznVMdsfxN/0/kEPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K0q9aK5kxunYo3+dIPvOtJ8HXg6UhU0/CjuIENxHjwBDaNELg7dBpbBphkH5dzv3z5zPEOy0Jygkxu2gi2N6IiN6HhgKkiWHnL7rgupmwmPzW+ya1tSR71mvce3aWTEVBhZRBvcqdXGgcPZFC6ddjbiZsuUfYiMCwHcBGh2H0ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=RFFyisxL; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="RFFyisxL"
ARC-Seal: i=1; a=rsa-sha256; t=1783960280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GEUd5sO4Kd331S+tm1yinPmN5WzjrElrLeQNPthbpiF39oM3ndkrMPYOFtmRvOKoW0CRnwMwvS/YGAdqfKUEpq+GeFNq9pIA5iZu+UUcxyLJ9LFbwKH8wUTlCv9O3gz1dGnAZOcrS6UAY76mYozcBmUCqe2Z0KOkVMCvn2e6fUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783960280; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9zEIUPMLCsE36OjvFSukd8t2dWhpMDWdJ+AkDZhPyEE=; 
	b=GVx3VtzJDRFwIWFoI6roAW1Rachrcb0HzWdjI9ZtPHkQdHjI4ezN5RQDMgkRKxBXKrIy8XzcelrPN1jBB8F15krK/0z+bdh4sMHZO+JIbbXEU2cXaObMv6wu9oqMo+doq2h1ji0+E6TztQsLuN9DMGMRQkZRIE3X/+SOX99ahPU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783960280;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9zEIUPMLCsE36OjvFSukd8t2dWhpMDWdJ+AkDZhPyEE=;
	b=RFFyisxLF4DLP5nRF3oiXI6CaoTtMBhdW3FHHGxjucdL5QXUTujusoPRUjJa7m1B
	vgOZJdoGcv04E5w1C+g126B9Y1fxMxc749DuyBdL4MaS8cMeRJg60wYC7lPDhpih6jD
	jxq3bOIJLZoBvakiq5O01D3FydmYJ4feKChZatdI=
Received: by mx.zohomail.com with SMTPS id 1783960278783950.5167538807655;
	Mon, 13 Jul 2026 09:31:18 -0700 (PDT)
Message-ID: <ba8a2de8-8ac7-490d-b48e-767d1e7893a9@collabora.com>
Date: Mon, 13 Jul 2026 19:31:14 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by
 removing hotplug from dequeue worker
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/13/26 16:01, Ryosuke Yasuoka wrote:
> A probe-time deadlock can occur between the dequeue worker and
> drm_client_register(). During probe, drm_client_register() holds
> clientlist_mutex and calls the fbdev hotplug callback, which triggers an
> atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
> waiting for virtqueue space. The dequeue worker that would free that
> space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
> drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
> to acquire the same clientlist_mutex. Since wake_up() is only called
> after the resp_cb loop, the probe thread is never woken and both threads
> deadlock.
> 
> Fix this by removing the hotplug notification from
> virtio_gpu_cmd_get_display_info_cb(). The display data (outputs[i].info)
> is still updated synchronously in the callback.
> 
> For the init path, drm_client_register() already fires an initial
> hotplug when the client is registered, which picks up the connector
> state updated by display_info_cb.
> 
> For the runtime config_changed path, add a wait_event_timeout() in
> config_changed_work_func() so that display_info_cb updates the connector
> data before the hotplug notification is sent. Also replace
> drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event() since
> virtio-gpu never calls drm_kms_helper_poll_init() and thus
> drm_helper_hpd_irq_event() always returns false without doing anything.
> 
> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> I checked whether drm_helper_hpd_irq_event() is needed in
> virtio_gpu_init(), as Dmitry suggested. AFAIS, it is not needed because:
> 
> 1. drm_helper_hpd_irq_event() is always a no-op in virtio-gpu.
>    It returns false immediately probe_helper.c:1088 because
>    dev->mode_config.poll_enabled is false — virtio-gpu never calls
>    drm_kms_helper_poll_init(). Even if it passed that gate, no
>    virtio-gpu connectors set DRM_CONNECTOR_POLL_HPD.
> 
> 1082 bool drm_helper_hpd_irq_event(struct drm_device *dev)
> 1083 {
> ...
> 1088         if (!dev->mode_config.poll_enabled)
> 1089                 return false;
> 
> 2. virtio_gpu_init() runs before drm_dev_register() and
>    drm_client_setup(), so no DRM clients are registered yet.
>    drm_kms_helper_hotplug_event() would iterate an empty client list.
>    The initial hotplug is handled by drm_client_register(), which fires
>    a hotplug callback to the newly registered client. By that time,
>    display_info_cb has already updated the connector data.
> 
> For the same reason, drm_helper_hpd_irq_event() in
> config_changed_work_func() was also a no-op. The actual runtime hotplug
> notification was always delivered by display_info_cb's call to
> drm_kms_helper_hotplug_event(). This patch replaces it with a direct
> drm_kms_helper_hotplug_event() call after waiting for the display info
> response.
> ---
> Changes in v2:
> - Dropped the work_struct approach from v1.
> - Instead, removed the hotplug calls from display_info_cb entirely, as
> suggested by Dmitry.
> - Added wait_event_timeout() in config_changed_work_func() so that the
> display info response is received before sending the hotplug
> notification.
> - Replaced drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event()
> in config_changed_work_func() since drm_helper_hpd_irq_event() is
> always a no-op in virtio-gpu (poll_enabled is never set).
> - No changes to virtio_gpu_init() — drm_client_register() already
> handles the initial hotplug and hotplug event does nothing before DRM
> device/client has been registered.
> - Link to v1: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 5 ++++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 3 ---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index cfde9f573df6..b4329f28e976 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
>  				virtio_gpu_cmd_get_edids(vgdev);
>  			virtio_gpu_cmd_get_display_info(vgdev);
>  			virtio_gpu_notify(vgdev);
> -			drm_helper_hpd_irq_event(vgdev->ddev);
> +			wait_event_timeout(vgdev->resp_wq,
> +					   !vgdev->display_info_pending,
> +					   5 * HZ);
> +			drm_kms_helper_hotplug_event(vgdev->ddev);
>  		}
>  		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
>  	}
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index c8b9475a7472..e5e1af8b8e8a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>  	vgdev->display_info_pending = false;
>  	spin_unlock(&vgdev->display_info_lock);
>  	wake_up(&vgdev->resp_wq);
> -
> -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> -		drm_kms_helper_hotplug_event(vgdev->ddev);
>  }
>  
>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,
> 
> ---
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
> change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5
> 
> Best regards,

Appled to misc-fixes, thanks!

-- 
Best regards,
Dmitry
