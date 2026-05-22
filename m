Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2233A8749
	for <virtualization@lists.linux.dev>; Fri, 22 May 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439903; cv=none; b=oWL07XkiKxp9u73DviBPThBJ+7BMzn+0q9WXs6UV65mU/Ekv70vmKMYxornrpZClzgIJipQMfGU6IUrUbr/yey8bk7UfqPaxKHhR0pVtBr6xoJoR80x7HqCuZ7Prwg6m1dgKe4RDlslyvZQVfzcEYuUe+RN/yfT+TcJ5aLSsfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439903; c=relaxed/simple;
	bh=rWC2wXCqlZiv3TkH2mQ7l+TSfCTVkIQ74+ueR4bGKmo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ma2/FSVdgYgtAPzJ5I1Tag+0Oof+/Dj1sJNY58PVZ+O3CjLJ0+cxxRVF5RNcmrx+u6EN9KI6GQ+bvgZZBvNL3pth/H/8aVyloUsr/sxlrzI3WWfHtff6+lDtvuZeJ3rz5epe2c65J/CY6Are23bK9H4fGZ70zBhW6dD1QW31aZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-482ac93cc7aso6746252b6e.1
        for <virtualization@lists.linux.dev>; Fri, 22 May 2026 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779439900; x=1780044700;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIi3MMN5y++s1UIskbwnxi/GVcsH2WsJKkCbw/xDCoI=;
        b=a19DZRvSFIXbAXrhLcv99HAp5XUKMQ7I3foyc3ixFK6H2A6SuK17YK3DGD/nroMjLF
         bf6QrRfEc7978jTXyuNhc1hpjRwGWhigRdVthD/mq60K7V5E5hu0QZJaDZ5d/fNh8hTO
         RuRINEk/GD4OHlYekPesScjjk8te1iU9uRqaZxQhb4JSlBLpvuAPA/pOKgWlJA4VAYfI
         5SXX+Uhy4sRbdIqvu2wRRNSz+FrFmwZZS8YHZ79unwRS0uNCWTzC33JYibfZ+XKrNvve
         eRWT0pZYLTVtdAbwJ95NQMioBxFDCKB4VxyoZK20Ibt+KNvq8j1H4CxAGjFcQcj+g6yy
         1zJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YCr4BaOu7/Jq1Bw9UyNbuUaGtRNi6c5bqmp/ABTjk1uzA1kczQIWq9bcbmXgiJhULwWLnyoga7HAaBbBjsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBtmZ5io8uN6Idg5+Ok4RYc++W2cel8Ujlwa0iC9w/dPPCkqY5
	FKJnvslyEFH/2qWcLdIIOnlkp97v5MJLtxAzm1JI6W//corHtfl2UEabf3pKYUFffoo0So+5CcA
	56HbNjvGegUb0Tf2e1KwZ356Vd+mdqTQgKBSjxyWHzfnibRSOgrqdDcONVhI=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c6:b0:696:8325:f7f5 with SMTP id
 006d021491bc7-69d7ead8411mr1426872eaf.4.1779439899792; Fri, 22 May 2026
 01:51:39 -0700 (PDT)
Date: Fri, 22 May 2026 01:51:39 -0700
In-Reply-To: <18b1d7267ace8b76.329809b8dd1e13b3.4134c0f069791aa6@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a10191b.170a0220.a3509.0048.GAE@google.com>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hi Dmitry,
> Thank you for your review and the comment.
>
> On 21/05/2026 22:01, Dmitry Osipenko wrote:
>> 21.05.2026 05:19, Ryosuke Yasuoka =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>> wait_event() without any abort condition when waiting for virtqueue
>>> space. If the host device stops processing commands, these waits block
>>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>>> drm_dev_unplug(), which is called in device removal and system shutdown
>>> call path, blocks on synchronize_srcu() until all critical sections
>>> complete, device removal and system shutdown also hang.
>>>=20
>>> Add a vqs_released flag to virtio_gpu_device and include it in the
>>> wait_event() condition. Set the flag and wake up both queues in a new
>>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
>>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, th=
e
>>> wait returns immediately and the command is aborted, following the same
>>> cleanup path as drm_dev_enter() failure.
>>>=20
>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e4=
5c1c6e549453f224
>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7=
baf376cc873a922e
>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>> ---
>>> Changes in v2:
>>> - Update the commit message.
>>> - Replace wait_event_timeout() with wait_event() using a compound
>>> condition that includes a new vqs_released flag.
>>> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
>>> both queues, called before drm_dev_unplug() in remove and shutdown
>>> paths.
>>> - Remove the hardcoded 5-second timeout. Recovery is now driven by
>>> the driver flag instead of an arbitrary timeout value.
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/vir=
tio/virtgpu_drv.c
>>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device =
*vdev)
>>>  	return ret;
>>>  }
>>> =20
>>> +/*
>>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critica=
l
>>> + * sections complete before drm_dev_unplug() blocks on synchronize_src=
u().
>>> + */
>>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>>> +{
>>> +	struct virtio_gpu_device *vgdev =3D dev->dev_private;
>>> +
>>> +	vgdev->vqs_released =3D true;
>>> +	wake_up_all(&vgdev->ctrlq.ack_queue);
>>> +	wake_up_all(&vgdev->cursorq.ack_queue);
>>> +}
>>> +
>>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>>  {
>>>  	struct drm_device *dev =3D vdev->priv;
>>> =20
>>> +	virtio_gpu_release_vqs(dev);
>>>  	drm_dev_unplug(dev);
>>>  	drm_atomic_helper_shutdown(dev);
>>>  	virtio_gpu_deinit(dev);
>>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_devic=
e *vdev)
>>>  {
>>>  	struct drm_device *dev =3D vdev->priv;
>>> =20
>>> +	virtio_gpu_release_vqs(dev);
>>>  	/* stop talking to the device */
>>>  	drm_dev_unplug(dev);
>>>  }
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vir=
tio/virtgpu_drv.h
>>> index f17660a71a3e..0bd69a40857e 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>>> =20
>>>  	struct virtio_gpu_queue ctrlq;
>>>  	struct virtio_gpu_queue cursorq;
>>> +	bool vqs_released;
>>>  	struct kmem_cache *vbufs;
>>> =20
>>>  	atomic_t pending_commands;
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virt=
io/virtgpu_vq.c
>>> index 67865810a2e7..8057a9b7356d 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio=
_gpu_device *vgdev,
>>>  	if (vq->num_free < elemcnt) {
>>>  		spin_unlock(&vgdev->ctrlq.qlock);
>>>  		virtio_gpu_notify(vgdev);
>>> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
>>> +		wait_event(vgdev->ctrlq.ack_queue,
>>> +			   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>>> +		/*
>>> +		 * Set by virtio_gpu_release_vqs() to unblock
>>> +		 * synchronize_srcu() wait in drm_dev_unplug().
>>> +		 */
>>> +		if (vgdev->vqs_released) {
>>> +			if (fence && vbuf->objs)
>>> +				virtio_gpu_array_unlock_resv(vbuf->objs);
>>> +			free_vbuf(vgdev, vbuf);
>>> +			drm_dev_exit(idx);
>>> +			return -ENODEV;
>>> +		}
>>>  		goto again;
>>>  	}
>>> =20
>>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_=
gpu_device *vgdev,
>>>  	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>>  	if (ret =3D=3D -ENOSPC) {
>>>  		spin_unlock(&vgdev->cursorq.qlock);
>>> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >=3D outcnt);
>>> +		wait_event(vgdev->cursorq.ack_queue,
>>> +			   vq->num_free >=3D outcnt || vgdev->vqs_released);
>>> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>>> +		if (vgdev->vqs_released) {
>>> +			free_vbuf(vgdev, vbuf);
>>> +			drm_dev_exit(idx);
>>> +			return;
>>> +		}
>>>  		spin_lock(&vgdev->cursorq.qlock);
>>>  		goto retry;
>>>  	} else {
>>=20
>> What about other wait_event in the driver? Why only these?
>
> There are other wait_event() calls on vgdev->resp_wq in virtgpu_prime.c
> and virtgpu_vram.c. These can also cause a stuck process when the host
> device stops or does not respond and should be fixed. However, they are
> not related to the issue being fixed here. I think they should be
> addressed in a separate commit.
>
> The wait_event(vgdev->resp_wq) calls wait for a host response, not for
> virtqueue ring space. They are not inside a drm_dev_enter/exit()
> critical section, so they don't block drm_dev_unplug() ->
> synchronize_srcu() and are not part of the deadlock reported by syzbot.
>
> However, if a process is stuck in wait_event(vgdev->resp_wq), there is
> no way to recover other than host device recovery itself. We can still
> remove the device and destroy the virtqueues while the process is stuck,
> so the host response can never arrive. IIUC, the stuck thread holds a
> drm_device reference, preventing vgdev from being freed; this is a
> resource leak.
>
> This can be fixed by adding a wake_up_all() and a vqs_released check
> similar to what is done for ctrlq/cursorq. However, I think this should
> be a separate commit since the root cause and problem are different.
>
> Alternatively, the resp_wq wait_event() calls could be converted to
> wait_event_interruptible() to fix the issue. But as you mentioned
> earlier in the v1 comment, we need the wait_event_interruptible()
> rework.
>
> What do you think? Should I include the resp_wq fix as a separate commit
> in this patch series, or leave it for the _interruptible() rework?
>
> Best regards,
> Ryosuke
>
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

