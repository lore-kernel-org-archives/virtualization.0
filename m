Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F912B9B7
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827247; cv=pass; b=dqjkA+7Y0wbhsYYkAcLr9mhJiRyi3dkbAlMBoWIZl4eop9Y8q74dkxd1cvGxrF2xZ8IkLG4ZpWNL4XkaQWm0aZ3Xg87EJEuBUpQbT6ih5wV3mVY9rnqSic46Pgkb+MIVBLmtOXrm53tB4cbdrwzFi7f9wu/c++asukcRC6IMsRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827247; c=relaxed/simple;
	bh=Em/7oy0ahshqKVKSLJwKxdxkbSOjtmZWA1lFr8eq86s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8bpuKrV5cp000nfWjm3cYhEvVEdRftmaT5+MSzMbvrGT+gR5SQv+FD7ExK5tpTdR20X5IqM/U1DnYYKeefCncS6dD7FMApyROSs5WhDZCZWMjioszSfKcKUJLyl2xDzdJgH2BAtVFEymYDrYR0hz1lVE69vlgsfHTn/qZAZiRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=aSRj2DV0; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="aSRj2DV0"
ARC-Seal: i=1; a=rsa-sha256; t=1782827226; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OoWMVThAaEBf+XimeM6uyOg5styPf5jlT+Z/x08drkQoSVuL91sP/0Vq41jMYxcFAUGC1+rAr3I8GcEiPdtBgFwOYDalCgHQPcwiwhq3aDl6bSqw8xFk3itplJ3Cfwu0jWH12P0XnCPgYRkh0zRiGMnMBst1FESHMJTnhLzLBuw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782827226; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mCUXX/ZAydApsMqIr6dhQIS1Dx+7cVtH8nR8HttmKjQ=; 
	b=TgyYKGj7jDCQ116sLM/swijp5G9zYHvltMcVWqNmncIVaxBRJdwyuONf9ZbShwhpjY2pAVK9MQDr5eBpv+CTRsSdL9QiqYQMVr17nAdEWCj2zhsG/yvq2svpKh61e/GuoOhkqZHPnsv6Hp6wz+EbKKqi03Dohf7NLQ9M2rmcLKk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782827226;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mCUXX/ZAydApsMqIr6dhQIS1Dx+7cVtH8nR8HttmKjQ=;
	b=aSRj2DV0SyYFSI0igaf5/ZSylpdHnw2AS+H7JGgV1SMqFM/h0D+ml6c+GS+rHUcy
	nKgUowJ7/MHJkU4TZalvLYKo+u/jAcoqZHBjWBhngSQt7McavP5zf0zmEBg7uzY9YbT
	l+jnCEqqwPhZFCTHGoFC7tvX5kIXT5vw2rvRtcI4=
Received: by mx.zohomail.com with SMTPS id 1782827223106724.3283705957734;
	Tue, 30 Jun 2026 06:47:03 -0700 (PDT)
Message-ID: <5aa634c1-7530-4b1f-931a-a5a5ac6c908a@collabora.com>
Date: Tue, 30 Jun 2026 16:46:58 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

On 6/30/26 12:16, Ryosuke Yasuoka wrote:
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
> Fix this by deferring the hotplug notification from
> virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
> display data (outputs[i].info) is still updated synchronously in the
> callback, and the deferred work only triggers a re-probe notification to
> DRM clients.
> 
> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
>  drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 7449907754a4..27ffa4697ae9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -264,6 +264,8 @@ struct virtio_gpu_device {
>  
>  	struct work_struct config_changed_work;
>  
> +	struct work_struct hotplug_work;
> +
>  	struct work_struct obj_free_work;
>  	spinlock_t obj_free_lock;
>  	struct list_head obj_free_list;
> @@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  					uint32_t x, uint32_t y,
>  					struct virtio_gpu_object_array *objs,
>  					struct virtio_gpu_fence *fence);
> +void virtio_gpu_hotplug_work_func(struct work_struct *work);
>  void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>  					 uint32_t resource_id,
>  					 uint32_t x, uint32_t y,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index cfde9f573df6..cfb532ba43a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>  	INIT_WORK(&vgdev->config_changed_work,
>  		  virtio_gpu_config_changed_work_func);
>  
> +	INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
> +
>  	INIT_WORK(&vgdev->obj_free_work,
>  		  virtio_gpu_array_put_free_work);
>  	INIT_LIST_HEAD(&vgdev->obj_free_list);
> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	flush_work(&vgdev->obj_free_work);
>  	flush_work(&vgdev->ctrlq.dequeue_work);
>  	flush_work(&vgdev->cursorq.dequeue_work);
> +	flush_work(&vgdev->hotplug_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..084d98f5dc7b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct virtio_gpu_device *vgdev,
>  	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>  }
>  
> +void virtio_gpu_hotplug_work_func(struct work_struct *work)
> +{
> +	struct virtio_gpu_device *vgdev =
> +		container_of(work, struct virtio_gpu_device, hotplug_work);
> +
> +	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> +		drm_kms_helper_hotplug_event(vgdev->ddev);
> +}
> +
>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>  					       struct virtio_gpu_vbuffer *vbuf)
>  {
> @@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>  	spin_unlock(&vgdev->display_info_lock);
>  	wake_up(&vgdev->resp_wq);
>  
> -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
> -		drm_kms_helper_hotplug_event(vgdev->ddev);
> +	schedule_work(&vgdev->hotplug_work);
>  }
>  
>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,

Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(), placing it after wait_event_timeout(display_info_pending)? This will avoid additional work_struct that otherwise needs to be cancelled in virtio_gpu_init() on the timeout.

-- 
Best regards,
Dmitry
