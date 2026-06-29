Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B88EADC
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735082; cv=pass; b=KON95njrIVwtRjL8jAm/Ih2H8h067qpZeBSqe8Tgrkkjnj7j0baB54OGw8MfhI2KaTsms2OCgKr+RXUSPYFpKQ9gOWQ1rq95OXr0Yt3CHm5EGJ33aqj/H3WOOJih60roFQ4YOnNGWHSPLfnaS1q6Qrn/Xq+oYfugmImkozmsKEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735082; c=relaxed/simple;
	bh=BplTDAIlOPsCdH4nBX73dSxshg4e+zqSYkNocY5oir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQBNQUFyIRrxWWUlRlzdhDTM9WB5k5nIDQNIow1NQsMNC7tjjV7Vt7wq94F/4DzR06w32+pXEvNpw83GUSSLsA8fLZ7ZZ8ggszAwub1WLg/PMRy98nVaRXOsJytBghX+TZbBOSYe9IRign6I+uH02pPO7C/8XgvR2R5sINr+nXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Q2y3qWI1; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Q2y3qWI1"
ARC-Seal: i=1; a=rsa-sha256; t=1782735071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q8UAKg9PlFbWG+gorAVJCBCxwgsvRqM3It1iWAJ+Tc+J2TUTMbi+zNFC0DGpWXeMlF5NAxxuooFJYUmo1PWZleWeCTkEcHf/9tN1qxtUqQOgQaBLslAaR+npp4ZrNbyb9IDj1a4oba9TRulfJvxSQhv5Ds+4zq2FhCU0qJgxas0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782735071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y7e4bUe5EZmCCqfRKpko/NvHrCnfXUqBCnQky4/FjnE=; 
	b=kdSHQ/iK3G810C/IGRwGgMXhtoYotdwUZXykfR7Q5Z38awKFGZge6pwOTlr2dtC5XAs41Vk3Nvsdrba/MGkSzxSwc8gcbGGBQ1CjKRBa3oRxsApYTmKb7mC00PGD0wTnYYwj6sZbx/34noicKKKt2egZQdvHAlcl5DjbNSJGb6s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782735071;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y7e4bUe5EZmCCqfRKpko/NvHrCnfXUqBCnQky4/FjnE=;
	b=Q2y3qWI1zgmBY7RRYM7o4kxe2Pj54+xUyZuw9sNgS1RefCpo7y+iWEvAZgDE2CIR
	BGbyUQPT+140L1Co73cZ4OBo86ttEVYzWoCUb61WvZYCSPCYvCiM3YUaYjBEbHBtz0c
	zVV8IBrcUTEds/7xfK/vYBCBD/y1P7XdH/9kNQOE=
Received: by mx.zohomail.com with SMTPS id 1782735068822773.9152080952593;
	Mon, 29 Jun 2026 05:11:08 -0700 (PDT)
Message-ID: <111d0a7c-60d3-4451-b214-510c98229883@collabora.com>
Date: Mon, 29 Jun 2026 15:11:04 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: warn when virtqueue has no free space for too
 long
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On 6/18/26 10:18, Ryosuke Yasuoka wrote:
> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() wait for
> virtqueue space using wait_event() with vqs_released as the only abort
> condition. This covers the device removal path, where
> virtio_gpu_release_vqs() sets the flag, but does not help when the host
> simply stops processing the virtqueue while the device remains present.
> 
> In that case, the virtqueue fills up and subsequent command submissions
> block indefinitely in D state with no diagnostic output, making the root
> cause difficult to identify.
> 
> Replace the bare wait_event() with a wait_event_timeout() loop that
> prints a warning every 5 seconds while the virtqueue remains full. The
> wait still blocks indefinitely so driver behavior is unchanged. The
> warnings help identify an unresponsive host device during
> troubleshooting.
> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> When the host stops processing the virtio-gpu virtqueue without
> triggering device removal, the bare wait_event() in
> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() blocks
> indefinitely with no diagnostic output. A DRM atomic commit worker
> blocks in virtio_gpu_queue_fenced_ctrl_buffer() while holding the
> modeset lock. During graceful shutdown, systemd (PID 1) needs the same
> lock — either by writing to the console via fbcon, or by closing a DRM
> file descriptor that triggers framebuffer cleanup — and blocks as well,
> making the VM unrecoverable without a forced power-off.
> 
>   PID: 553    COMMAND: "kworker/u4:3"
>    #0 __schedule
>    #1 schedule
>    #2 virtio_gpu_queue_fenced_ctrl_buffer [virtio_gpu]
>    #3 virtio_gpu_primary_plane_update [virtio_gpu]
>    ...
> 
>   PID: 1      COMMAND: "systemd"  (console write path)
>    #0 __schedule
>    #1 schedule
>    #2 schedule_preempt_disabled
>    #3 __ww_mutex_lock
>    #4 drm_modeset_lock [drm]
>    #5 drm_atomic_get_plane_state [drm]
>    #6 drm_client_modeset_commit_atomic [drm]
>    #7 drm_client_modeset_commit_locked [drm]
>    #8 drm_fb_helper_pan_display [drm_kms_helper]
>    #9 fb_pan_display
>   #10 bit_update_start
>   #11 fbcon_switch
>   #12 redraw_screen
>    ...
> 
> Reproduction steps:
> 1. Build QEMU with the fault injection patch [1] that adds an
>    x-ctrl-queue-broken property to virtio-gpu.
> 2. Boot the VM and trigger the fault injection from the host.
> 3. Fill the ctrlq (e.g., move the mouse on the guest's display).
>    The process gets stuck in virtio_gpu_queue_fenced_ctrl_buffer()
>    in D state.
> 4. Run a graceful shutdown command (shutdown now or reboot).
> 5. The shutdown process hangs.
> 
> My earlier patch a46991b334f6 ("drm/virtio: abort virtqueue wait on
> device removal to avoid hung task") covers the case where the shutdown
> process reaches the device_shutdown() call path, which sets vqs_released
> to unblock the wait. However, during graceful shutdown, systemd (PID 1)
> gets stuck on the modeset lock before ever reaching device_shutdown(),
> so vqs_released is never set and the wait is never unblocked.
> 
> I initially considered adding a module parameter to abort the wait with
> -ENODEV on timeout:
> 
>   +static unsigned int virtio_gpu_vq_timeout;
>   +MODULE_PARM_DESC(vq_timeout,
>   +     "Timeout in seconds for virtqueue wait (0 = no timeout, default)");
>   +module_param_named(vq_timeout, virtio_gpu_vq_timeout, uint, 0444);
>   ...
>   +             if (virtio_gpu_vq_timeout) {
>   +                     if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
>   +                                             vq->num_free >= elemcnt ||
>   +                                             vgdev->vqs_released,
>   +                                             secs_to_jiffies(virtio_gpu_vq_timeout))) {
>   +                             if (fence && vbuf->objs)
>   +                                     virtio_gpu_array_unlock_resv(vbuf->objs);
>   +                             free_vbuf(vgdev, vbuf);
>   +                             drm_dev_exit(idx);
>   +                             return -ENODEV;
>   +                     }
>   +             } else {
>   +                     wait_event(vgdev->ctrlq.ack_queue,
>   +                                vq->num_free >= elemcnt ||
>   +                                vgdev->vqs_released);
>   +             }
> 
> This approach aborts the wait and allows the graceful shutdown process
> to eventually proceed, albeit with a delay.
> 
> But that approach has drawbacks: it allows users to set arbitrarily
> short timeouts that could destabilize the driver, and aborting commands
> mid-flight is a rough recovery path. An unconditional timeout was also
> discussed previously [2] but is not appropriate without virtio
> specification support.
> 
> This patch takes a safer approach: replace the bare wait_event() with
> wait_event_timeout() and print a warning every 5 seconds while the
> virtqueue remains full. The wait still blocks indefinitely and no
> commands are aborted, so driver behavior is unchanged. The warnings
> help identify an unresponsive host device during troubleshooting.
> Once the user notices the warning, they can work around the hang by
> unbinding the VT from fbcon, removing the device, or forcing a shutdown
> via SysRq.
> 
> [1] https://gist.github.com/YsuOS/fbcd181752594af35f954953a1d260b8
> [2] https://lore.kernel.org/all/8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com/
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 68d097ad9d1d..a546130d3b6a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -410,8 +410,13 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue,
> -			   vq->num_free >= elemcnt || vgdev->vqs_released);
> +		while (!wait_event_timeout(vgdev->ctrlq.ack_queue,
> +					   vq->num_free >= elemcnt ||
> +					   vgdev->vqs_released,
> +					   5 * HZ) && !vgdev->vqs_released)
> +			DRM_WARN("ctrlq waiting for host: no free space for %d secs\n",
> +				 5);
> +
>  		/*
>  		 * Set by virtio_gpu_release_vqs() to unblock
>  		 * synchronize_srcu() wait in drm_dev_unplug().
> @@ -592,8 +597,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue,
> -			   vq->num_free >= outcnt || vgdev->vqs_released);
> +		while (!wait_event_timeout(vgdev->cursorq.ack_queue,
> +					   vq->num_free >= outcnt ||
> +					   vgdev->vqs_released,
> +					   5 * HZ) && !vgdev->vqs_released)
> +			DRM_WARN("cursorq waiting for host: no free space for %d secs\n",
> +				 5);
> +
>  		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>  		if (vgdev->vqs_released) {
>  			free_vbuf(vgdev, vbuf);

The [1] has a valid point about the hangcheck warning. Is
wait_event_timeout() worth the change then?

[1]
https://sashiko.dev/#/patchset/20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9%40redhat.com

-- 
Best regards,
Dmitry
