Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493993914E8
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779390180; cv=none; b=S6QGXTXVr7GvzrWfyo2suQLYwKD7hICa+780Dgs94kxuvIOGl1FHv+KzNpEOCA6Qf3bl13NLOtH46JO7wFHmdbUgtC2M6Vy6wSHp15N0ILTtk6EOlIVbKCeDkr+te2SHK5S7D0JnHqYvxAUjTQ64Qqu5i7wBL2RYvurj+GqjG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779390180; c=relaxed/simple;
	bh=lamLueXQs2j9rC4MhRl8BlvILn6+G8yNbXVTCUJVdoA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Fke6AWiJ+DwMj/hJDOdAtP9JaKgZG7DDUi5pR3PLWGxw54T+3VrSzuF3JSyHysPZfuksk92Q87GozjVDRnrGqoPzgTN1F1gAO/aXpJf/Fy38vWuoVkap4HXyENqez1sxa05FGc1nx/taWd4NxEIZIZyVbVl+oxjeTKghIoBmC4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dccdbdf5c2so10426573a34.3
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 12:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390176; x=1779994976;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0krv0nUw1/ioDEFf9ZMQESopIiNp/OLFryuhF9m9kKI=;
        b=XTkJyYBizQJuNfMPJp5zRN2LJ8EsJsXMwMiJamlr/ntQDj2ug0qTNtln8XpMupEnrs
         FP41QkNIrFUSKIqG0K3Xqb0Czi2PRd1pas1MZUiatdpPM5qtIhZZlJhqVkj4rmK67Be1
         IG/PZa1USH5dgfVc5lPtaPpHCMurgOcgw98rWPHPjZYwk1U1K2xmlTn6AmLtRRajUxpx
         jjLTKSM02AyrnhRN0nslLmNDjGGoL80TyQE4rIEp9vBdEAyAqvDiFsFpNMKRRfSASNzr
         NyGlvboEyQrPyGjylX+x8/9TeLZ3QyDm0XXkXHe+iQZEtl6gYAcv6Rd9t5LjzOkBlTMr
         KnlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8sdc7iE7Oe1G9RYT4qeIFUtAQACdxLdFujEoSBgPGGTfZERAe4LiQuEv5YfaVcEssqF6tT/d1HjlTxFPKZsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv5Lf73szgxhEsW6LVhn7u4VzSaLipRW7PAJfbSWVaZk4ld/A5
	LXHcuCKxVRji1Rpwpg9cqLz5QpFNW9uL35f3+ygesZomFJfAjZ6zAc3CDtXoX4qYo1+eh8h54vb
	c+k3ahIzAiSlxEXL2Tu6L+FdBtYBmDdtglQqMtNRtOJY0vC/lHGnI7acNUPQ=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:6d0c:b0:7dc:d99c:c441 with SMTP id
 46e09a7af769-7e5fedc8241mr302592a34.8.1779390176127; Thu, 21 May 2026
 12:02:56 -0700 (PDT)
Date: Thu, 21 May 2026 12:02:56 -0700
In-Reply-To: <4bc3709f-21bc-49f5-8fcf-972dec1397f7@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0f56e0.050a0220.3a257.0000.GAE@google.com>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: dmitry.osipenko@collabora.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 21.05.2026 05:19, Ryosuke Yasuoka =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>> wait_event() without any abort condition when waiting for virtqueue
>> space. If the host device stops processing commands, these waits block
>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>> drm_dev_unplug(), which is called in device removal and system shutdown
>> call path, blocks on synchronize_srcu() until all critical sections
>> complete, device removal and system shutdown also hang.
>>=20
>> Add a vqs_released flag to virtio_gpu_device and include it in the
>> wait_event() condition. Set the flag and wake up both queues in a new
>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
>> wait returns immediately and the command is aborted, following the same
>> cleanup path as drm_dev_enter() failure.
>>=20
>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.a=
ppspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45=
c1c6e549453f224
>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.a=
ppspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7b=
af376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>> Changes in v2:
>> - Update the commit message.
>> - Replace wait_event_timeout() with wait_event() using a compound
>> condition that includes a new vqs_released flag.
>> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
>> both queues, called before drm_dev_unplug() in remove and shutdown
>> paths.
>> - Remove the hardcoded 5-second timeout. Recovery is now driven by
>> the driver flag instead of an arbitrary timeout value.
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virt=
io/virtgpu_drv.c
>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *=
vdev)
>>  	return ret;
>>  }
>> =20
>> +/*
>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
>> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu=
().
>> + */
>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>> +{
>> +	struct virtio_gpu_device *vgdev =3D dev->dev_private;
>> +
>> +	vgdev->vqs_released =3D true;
>> +	wake_up_all(&vgdev->ctrlq.ack_queue);
>> +	wake_up_all(&vgdev->cursorq.ack_queue);
>> +}
>> +
>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>  {
>>  	struct drm_device *dev =3D vdev->priv;
>> =20
>> +	virtio_gpu_release_vqs(dev);
>>  	drm_dev_unplug(dev);
>>  	drm_atomic_helper_shutdown(dev);
>>  	virtio_gpu_deinit(dev);
>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device=
 *vdev)
>>  {
>>  	struct drm_device *dev =3D vdev->priv;
>> =20
>> +	virtio_gpu_release_vqs(dev);
>>  	/* stop talking to the device */
>>  	drm_dev_unplug(dev);
>>  }
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virt=
io/virtgpu_drv.h
>> index f17660a71a3e..0bd69a40857e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>> =20
>>  	struct virtio_gpu_queue ctrlq;
>>  	struct virtio_gpu_queue cursorq;
>> +	bool vqs_released;
>>  	struct kmem_cache *vbufs;
>> =20
>>  	atomic_t pending_commands;
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virti=
o/virtgpu_vq.c
>> index 67865810a2e7..8057a9b7356d 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_=
gpu_device *vgdev,
>>  	if (vq->num_free < elemcnt) {
>>  		spin_unlock(&vgdev->ctrlq.qlock);
>>  		virtio_gpu_notify(vgdev);
>> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
>> +		wait_event(vgdev->ctrlq.ack_queue,
>> +			   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>> +		/*
>> +		 * Set by virtio_gpu_release_vqs() to unblock
>> +		 * synchronize_srcu() wait in drm_dev_unplug().
>> +		 */
>> +		if (vgdev->vqs_released) {
>> +			if (fence && vbuf->objs)
>> +				virtio_gpu_array_unlock_resv(vbuf->objs);
>> +			free_vbuf(vgdev, vbuf);
>> +			drm_dev_exit(idx);
>> +			return -ENODEV;
>> +		}
>>  		goto again;
>>  	}
>> =20
>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_g=
pu_device *vgdev,
>>  	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>  	if (ret =3D=3D -ENOSPC) {
>>  		spin_unlock(&vgdev->cursorq.qlock);
>> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >=3D outcnt);
>> +		wait_event(vgdev->cursorq.ack_queue,
>> +			   vq->num_free >=3D outcnt || vgdev->vqs_released);
>> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>> +		if (vgdev->vqs_released) {
>> +			free_vbuf(vgdev, vbuf);
>> +			drm_dev_exit(idx);
>> +			return;
>> +		}
>>  		spin_lock(&vgdev->cursorq.qlock);
>>  		goto retry;
>>  	} else {
>
> What about other wait_event in the driver? Why only these?
>
> --=20
> Best regards,
> Dmitry

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

