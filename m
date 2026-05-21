Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C7C38D3E6
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390166; cv=pass; b=SansJO8MFYyn9tP9XCEobf0fd0SfJ8u+6rcyRrYHhhMs4CArKnzX+x/IaoAsD+icfWjrmXf7q5bc3bHHLgxFMGnoeX2BmuvM3R5pmxbo1fOa0g9NQAKrs+rpXYxBpEF4m7PMQW1AUE0A6shMVUJc3MW9KzRN4y8FuHBzJ0ROILc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390166; c=relaxed/simple;
	bh=1o3/7jMbKccrWu7DqgXsxhPdzDzfANr1twNySgQk1fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sjm4ZnttgWoZq+X//Q4hBseOHmQ4aCkj2PaNOJ+An2o3nmi+OHuT62IHLk8AD/g6ltS4pvhuI+r7ZDPvZxQ0tYQOAzDZmF0TOeRyNs6aslDatDw+fl95X3a8A7gn7Df3kI0Vkgri+dvj1Xj19L+zS6cvDGzWH7fi82opf+ZB3yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=O35bPHXR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="O35bPHXR"
ARC-Seal: i=1; a=rsa-sha256; t=1779390083; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QtFQnWfrqDSOpJKVk6QTILMbQ48kcsCTcVO2qOUOrdNx5yUljoNL8mQ3AuOABkJdT7XFGvG57OgYNiJ6BOTiQWGlRRsDqGaMtWfR2EBA7xlrPEcpAo7rmU/ClLWISMCLnGY36ySlNf1qqt3jt6k6O3hnpcOaFJ+ECwfpCNE8h68=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779390083; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1kRt4VWbNQdDPdtCvmC+JOTMWdntqKcIlWHLvpo213Y=; 
	b=BBb6ojXcp+UGCKaTRp5F+NfMGnJ8HF6OfwrO3a06ImyKsvEvdPLE7sxABi+fsIlIE0h+4vdsaNuYIcr3kiNRjXwgdjeZc16yHgisDFTf4rnHXTVcBHbmDrG0t/VKSZaLcXGk7M+yHEMOBQmCw8k5FdWItWXH1aqrN8H8tBIVudQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779390083;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1kRt4VWbNQdDPdtCvmC+JOTMWdntqKcIlWHLvpo213Y=;
	b=O35bPHXRavWJh44wjuVH1z3A1U/gj5uBH8Ztgek046pR3eH3GB8J8XbOkxUaWnHl
	tGP1JR0fHcc9PORoBRGoAWGf+YSMsf6epu4Mi/Wabiawb6ZhLGJhppep1MpvQ2rb524
	nbhh8Dnt9nwfkDR+4hhArnCIjspqxI/8Bi/+mTZY=
Received: by mx.zohomail.com with SMTPS id 177939008156683.21234787815092;
	Thu, 21 May 2026 12:01:21 -0700 (PDT)
Message-ID: <4bc3709f-21bc-49f5-8fcf-972dec1397f7@collabora.com>
Date: Thu, 21 May 2026 22:01:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com,
 syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
References: <20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

21.05.2026 05:19, Ryosuke Yasuoka пишет:
> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
> wait_event() without any abort condition when waiting for virtqueue
> space. If the host device stops processing commands, these waits block
> indefinitely inside a drm_dev_enter/exit() critical section. Since
> drm_dev_unplug(), which is called in device removal and system shutdown
> call path, blocks on synchronize_srcu() until all critical sections
> complete, device removal and system shutdown also hang.
> 
> Add a vqs_released flag to virtio_gpu_device and include it in the
> wait_event() condition. Set the flag and wake up both queues in a new
> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
> wait returns immediately and the command is aborted, following the same
> cleanup path as drm_dev_enter() failure.
> 
> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> Changes in v2:
> - Update the commit message.
> - Replace wait_event_timeout() with wait_event() using a compound
> condition that includes a new vqs_released flag.
> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
> both queues, called before drm_dev_unplug() in remove and shutdown
> paths.
> - Remove the hardcoded 5-second timeout. Recovery is now driven by
> the driver flag instead of an arbitrary timeout value.
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index a5ce96fb8a1d..e4fe5e0780f9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>  	return ret;
>  }
>  
> +/*
> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
> + */
> +static void virtio_gpu_release_vqs(struct drm_device *dev)
> +{
> +	struct virtio_gpu_device *vgdev = dev->dev_private;
> +
> +	vgdev->vqs_released = true;
> +	wake_up_all(&vgdev->ctrlq.ack_queue);
> +	wake_up_all(&vgdev->cursorq.ack_queue);
> +}
> +
>  static void virtio_gpu_remove(struct virtio_device *vdev)
>  {
>  	struct drm_device *dev = vdev->priv;
>  
> +	virtio_gpu_release_vqs(dev);
>  	drm_dev_unplug(dev);
>  	drm_atomic_helper_shutdown(dev);
>  	virtio_gpu_deinit(dev);
> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
>  {
>  	struct drm_device *dev = vdev->priv;
>  
> +	virtio_gpu_release_vqs(dev);
>  	/* stop talking to the device */
>  	drm_dev_unplug(dev);
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index f17660a71a3e..0bd69a40857e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>  
>  	struct virtio_gpu_queue ctrlq;
>  	struct virtio_gpu_queue cursorq;
> +	bool vqs_released;
>  	struct kmem_cache *vbufs;
>  
>  	atomic_t pending_commands;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..8057a9b7356d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +		wait_event(vgdev->ctrlq.ack_queue,
> +			   vq->num_free >= elemcnt || vgdev->vqs_released);
> +		/*
> +		 * Set by virtio_gpu_release_vqs() to unblock
> +		 * synchronize_srcu() wait in drm_dev_unplug().
> +		 */
> +		if (vgdev->vqs_released) {
> +			if (fence && vbuf->objs)
> +				virtio_gpu_array_unlock_resv(vbuf->objs);
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return -ENODEV;
> +		}
>  		goto again;
>  	}
>  
> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
> +		wait_event(vgdev->cursorq.ack_queue,
> +			   vq->num_free >= outcnt || vgdev->vqs_released);
> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
> +		if (vgdev->vqs_released) {
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return;
> +		}
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {

What about other wait_event in the driver? Why only these?

-- 
Best regards,
Dmitry
