Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658435BDC2
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007605; cv=none; b=LBI2U+/G/4qmp+Qv4ByMN9a9k8NAGUtSI642K/XgkSWDyZ8PJTX4wJNvejn9Unndkn5vzusJXkETLnsn4lIVM9Vzlbpt0dKItTpz8OcLQB8S4uVqgYukJ6nI+rwTSHYI+rCg2yZVny+5qYgpzqQzHG3TckKguyhIRQG1p1HSaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007605; c=relaxed/simple;
	bh=Sc8w6Gf1zm0CKPBLiqU85+5AnKipo2xEoc7dR05jPxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PALwA+j3EN23L874HhFkW0XEecGvZNUFD8igTPUu93dP/BfJLX1whgDZ+Epix8bgoB4I1SxzjonQjYv1/uBcbxofSoEsiLd7aBxengCfJqjv2mAIJBHn5/kZCV3DFcft/ZSJqpUCCHkIDDY8y72LSEA6AMxzxxG8pnGEOU7w2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK+xzU4h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK+xzU4h"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so39942675e9.3
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792007602; x=1792612402; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wRoKa+AOyjdQOl1cRipieu5Ib6igoe0K53YRH5w/Cro=;
        b=DK+xzU4hEZnfMZ3/Abf5NYoRFNKcCkllhkpavpehGgG8pGqgRgZSwpfirEUA0/brVa
         8h9cl9l0Zcs/K9HTmDQRMqCKqCtrup1BOsBIPJPZA7Onp3kWNmLwBkgQ6lgnA4pScT4b
         rh6NF5bWk1AyyVH8vgbGhogrPHR3gus6pLjOn+8bZjhCYVlxaoPmHjd5KFdnFNm0dljD
         wYJitQkig6sA9qTRCcPbENP6Wyrvtf9xFVw4OKxgyshnEJn6/KIOfecmchCwZ9IFphB+
         rk81TbCU03MFR6++rgVHTGcJJTxvaJzrshoGr+83g7H4e2GIaL0xwhqFSQrdxGqhua2j
         oc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007602; x=1792612402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRoKa+AOyjdQOl1cRipieu5Ib6igoe0K53YRH5w/Cro=;
        b=uAmwjjCjTZBT6aqChycnsVXBacN4qPp9LgQdLZy/OYr751B2KdndPyPEJE+LtvjGNU
         hIliSyTz2jCvx921Ddcx8TWRfwKHecxqE6iOPMPn8bGBcEqugfHlNUiza4ifKtQ+h4rr
         fHLHSUHgM7dw5Tk6uz0nXaY+wKFrSwMs/e2rQ/cMqomhyLRErmxLaLQYFGzfWnjJz7BK
         IePJ46sF4iqUcKikBdYafrImojS4rDLOAJ3znTPwByrBH4PfXqHjtWfHY8HyVFSDmdxf
         d3GZMc6eIN4dYFKVs9FJSoQBC/uppqJHiGViNQyoyUG+HC3tUlc8LHGwl4lvx13muacA
         Vi0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwf3vKXUXx8rMcnVhHabL9ue1WNF5BFF2ZKZSsv/BwzNfiABWZ0Flcr0XQCmr9PIcM39eews062RDXCuRFfBA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLrLwIJZMAbqK1A6fepIrG/QWrD4k3VdygmQNkO0UvbZbfFIFMj
	OWKjuMjCvJx/7bPq6ZiprR2BvzR2GQNbiQDUbTq36llkrP8EiHtoR9qm0Zr95Q==
X-Gm-Gg: AYBFou11ZJsVHeQuXR4+0Rou28YR3UaHiHudrvo/BRTp86z1J22mFpE1OZWR99kyKI2
	XtlszWyUaF0vJmiAO0ZDmEMC1BxzJzmdez4mjGRXLGlCHd7j+S1JqYKM5qYaUZe01OwK0KvYrUm
	62LH/Mz9x0sMctnhkNz3k3xyT96n4bu74gvuAeq2GfFL6yJvipg0dru5L3GbJ7ht6RYIAQJZAb0
	emmurYCJKUtg1Cng36fM1Oz1JmfyFuhvFeaLgW8U1KyxXL/Fv4WBdkOUiO+dwqe1a/RVIf1BeFR
	jNjomjd0lE+2DXvVwlNy1om6n9OHWgwrHfG6miLBe/XRXvmLQBUEQnnHIFuR1LYMilHspAZDSjs
	Q2I5pL1WOqqxMJ74p+sv/xfIF6VWPGURGN2KHtPZCX+ZOdw6yH/+iCch8FM6Cq25BFAlf/yC4g5
	dJJOn81sf3YWbRIlUrrsDvO/OOhDc8J2KDHONp7jHQeA3tArY2EulnsE5LjJRqvbMahLWDjGU8Y
	E8tvXQvPh7P0fFUlDecTQi2k5LAN/7frKQtTaPiYr1XlE/uKeY=
X-Received: by 2002:a05:600c:8184:b0:49f:ffd0:4039 with SMTP id 5b1f17b1804b1-4a18e4f2221mr303055495e9.32.1792007601487;
        Wed, 14 Oct 2026 12:53:21 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-008-050.2.214.pool.telefonica.de. [2.214.8.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd972aebsm16638485e9.1.2026.10.14.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:53:21 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:53:18 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
Message-ID: <as_drl4kYXmgOfRn@home-desktop>
References: <20260929070714.169412-1-abhinjoses@gmail.com>
 <asxz0Xvv5jO9gAol@home-desktop>
 <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537679fc-8aea-472f-a7af-b15bd3cf27fd@collabora.com>

On Wed, Oct 14, 2026 at 01:16:57AM +0300, Dmitry Osipenko wrote:
> On 10/12/26 08:44, Abhin Parekadan Jose wrote:
> > Gentle ping on this fix for the syzbot report.
> > 
> > Dmitry, Gerd, do you have a preference between moving mutex_destroy()
> > to virtio_gpu_release() (this patch) and using drmm_mutex_init()? I can
> > send a v2 with the other option if you prefer it.
> > 
> > Thanks,
> > Abhin
> > 
> > On Tue, Sep 29, 2026 at 07:07:14AM +0000, Abhin Parekadan Jose wrote:
> >> virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
> >> deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
> >> objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
> >> alive, and the fbdev DRM client holds a drm_device reference. When the
> >> fd is finally closed, the buffer is freed and takes the destroyed lock:
> >>
> >>   fb_release()
> >>     drm_fbdev_shmem_fb_destroy()
> >>       drm_client_buffer_delete()
> >>         virtio_gpu_free_object()
> >>           virtio_gpu_remove_from_restore_list()
> >>             mutex_lock(&vgdev->obj_restore_lock)
> >>
> >>   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> >>   WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec
> >>
> >> virtio_gpu_deinit() should only do hardware teardown in this case
> >> related virtio, its queues and others. Software state that GEM callbacks
> >> still use belongs in virtio_gpu_release(), which runs on the final
> >> drm_dev_put().
> >>
> >> There are two equivalent ways to tie the mutex lifetime to the
> >> drm_device:
> >>
> >>  1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
> >>     virtio_gpu_release(). This is what this patch does. It is the
> >>     smallest change and keeps the teardown next to the rest of the
> >>     final-put software cleanup.
> >>
> >>  2) Initialise the lock with drmm_mutex_init() (checking its return
> >>     value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
> >>     managed release destroys it. This also covers the virtio_gpu_init()
> >>     error path, where release returns early because dev_private is
> >>     NULL. Skipping mutex_destroy() there is harmless, since it only
> >>     matters for mutex debugging.
> >>
> >> Either fix removes the WARN. Option 1 is sent as the smaller change,
> >> and option 2 can be done instead if preferred.
> >>
> >> Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
> >> and PROVE_LOCKING: open /dev/fb0, write 1 to
> >> /sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
> >> patch the WARN is gone, and rebinding brings back /dev/fb0 and
> >> /dev/dri/card0.
> >>
> >> Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
> >> Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
> >> Assisted-by: LLM
> >> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
> >> ---
> >>  drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> index 1d4d3bf46a20..0ec755c35050 100644
> >> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >> @@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
> >>  	virtio_reset_device(vgdev->vdev);
> >>  	virtio_gpu_reclaim_vbufs(vgdev);
> >>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
> >> -	mutex_destroy(&vgdev->obj_restore_lock);
> >>  }
> >>  
> >>  void virtio_gpu_release(struct drm_device *dev)
> >> @@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
> >>  
> >>  	if (vgdev->has_host_visible)
> >>  		drm_mm_takedown(&vgdev->host_visible_mm);
> >> +
> >> +	mutex_destroy(&vgdev->obj_restore_lock);
> >>  }
> >>  
> >>  int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
> Calling virtio_gpu_deinit() from virtio_gpu_release() might be a better
> option

Wouldn't that end up freeing the virtqueues twice, or using them after
they are freed? virtio_gpu_deinit() would then run from both the
virtio_gpu_remove() path and the virtio_gpu_release() path.
or do you mean removing it from virtio_gpu_remove() and calling it only
from virtio_gpu_release()?
This is only from a high-level look so far. I'll look into it more
closely and get back to you.

> 
> -- 
> Best regards,
> Dmitry
