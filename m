Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B733A033
	for <virtualization@lists.linux.dev>; Fri, 22 May 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439903; cv=none; b=efIdjgEk8ruiW1dhJ6bDqUk7AWXzsNT3XkcQAcs3e7tICGOdb3dLSRUWO1hD9pD2bW9FCGKDaUlW+sMfHwJAbGp8ECe6lXfqZrIsa3Qt/RC6QlsGhPiczmyJcyaOsPIfiECYuWmcxojH0gU5h2ja4MzsI6wSEyYffk/QQNjEcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439903; c=relaxed/simple;
	bh=Kics/7zPNA5xtdadlW6/iAe1WIQ+KiYdBblsPbvpcOk=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=sexOjNVKlyDoG3Ico36xHjJTO7HGHuMaT4RkPFBZ0g4AEu+8nwkxhXbP/Hm9ZZQepc3mvrAJPgu7D262jXc4JcF2IWAoIoY3FFiXVJUvjmRyuJTwPGCY8IFB8h6DBAqTSzMJhgJbfLL5W9mfEBMDP6A8r8kM22DZ/uX/Tn2Tumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWrlimJy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWrlimJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779439899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=LFNTiydaEWZkdkw0ESOWwdY15SJjSG2raSmJCflbIpM=;
	b=bWrlimJyTwG/OlpbWdBteEczQotRHzxIzSdMJocT9YYscWjJFZqJStuncbEnHMqLpiZ8i5
	HZmJ/NsPz0/I53DhLN1o7XybSaQyzQr8yX8ABgWOBX4MjV6Jwdup3xT2ZzjybOr728kLyS
	TgxosisOvEIHrEzVxF/FbwJKrWvi4zM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-JbCqro-_MduVpd72WrZHSw-1; Fri, 22 May 2026 04:51:37 -0400
X-MC-Unique: JbCqro-_MduVpd72WrZHSw-1
X-Mimecast-MFC-AGG-ID: JbCqro-_MduVpd72WrZHSw_1779439897
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bc6899bfb1so72149405ad.2
        for <virtualization@lists.linux.dev>; Fri, 22 May 2026 01:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779439896; x=1780044696;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kXBv8+xcZ/GEh5itMC52ovwZicczUHBu0yyPPkFZfZE=;
        b=bpqn4fq2WRTZBMBVs88GOaOFoq2OLvSDEf6Yia2QQDZ7E/+3IgYtfK5UicFWA5wMGL
         OKMkzVFDvlUFye6e20pcg/PXKKjB/1+wiEIgl+8DKcPC9MQ28yC/9wEgdSxT9b/Bh1Kd
         BlB4XGokUUTFh/m1SDe4HwOIE+GtA+qFNeJ08jCphW1hx1LwEcEMt4LssrncM8lhPY2t
         SDJq9DFUgp9os24FKZEGLfPm8pS49LYh+AgsrnM7/c9mCifBY3WEC6K3QpitvuvOiePb
         VIER1MOeVwn5i4HwXr99W2+u6blbyPDjCk0DtmfmYUEuE1zVsw9AQZVLhoEyO9siMbNC
         bX9g==
X-Forwarded-Encrypted: i=1; AFNElJ+7xTkv5Htowc4BxEa0JHSY0QVk1Tb1lIlf+qCmoDQC15EzBly9eWgqNiblXi7uMkQ3ZW+MvVefim70kVhQsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKkR/JvkxRD6kBnU3uWKJNPUaXN0sp5MeIKzJ8zNmL7HOSccw4
	K9K8mVuSwt/VXLzF3/bQjZPKOTjaP5p5zFXE3o8CGGG56LrWtjtGHGHAYgdErJ3cJnHQlA5Rj8A
	9AJZKuRZ+Zov8wd9WinWHC/RItm2b7ckmX2zCjDQ0tMj0JFkrYPFo7ruZTWUy3wwXE1n8
X-Gm-Gg: Acq92OEpiyItGujxUZzQp97bAxO+AjmGu1Ripv35gid4FFtcpYKzzIaumOb1VRtBgNA
	AU84tnhfuH7B8pVYST7Y+O8CjjLDYNiFAmuGeYvRSa7AROb0g/sbQL3SMmOa1l1P4wUvPy77E1e
	c+X5YBy9Hyp5U8Mvfi7P48kEd3LJHxaIX+IcFSgO9TDqJ/Bae6kRYtwvN6E46k7prqwu536PvlZ
	X2jiSd6P4Namg9MrJUIflaSOYMQi5WyEsFUXXlxYncHMhQcObdOXKmPjFuhExq1t8SLF8eEJ+i8
	HgxNOQCFlX+f8IcL4q9WoXO9yyuB8KzxRd9Ok2ROZomtAlgygdz2WUlDSCz25cwbv+e9TL/1QfF
	2RaklSZl8trQgS7V3lk4yyu3yn4HDkbYVKCUye1NqXXGf023wq13OIzjcr9E=
X-Received: by 2002:a05:6a21:8202:b0:3b3:ce0:9f73 with SMTP id adf61e73a8af0-3b328cd80a4mr2948553637.19.1779439896434;
        Fri, 22 May 2026 01:51:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:8202:b0:3b3:ce0:9f73 with SMTP id adf61e73a8af0-3b328cd80a4mr2948512637.19.1779439895774;
        Fri, 22 May 2026 01:51:35 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202902b1sm911085a12.6.2026.05.22.01.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
	"David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
	"Gurchetan Singh" <gurchetansingh@chromium.org>, 
	"Chia-I Wu" <olvaffe@gmail.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"Simona Vetter" <simona@ffwll.ch>
In-Reply-To: <4bc3709f-21bc-49f5-8fcf-972dec1397f7@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	<syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com>, 
	<syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
	 avoid hung task
Message-ID: <18b1d7267ace8b76.329809b8dd1e13b3.4134c0f069791aa6@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Fri, 22 May 2026 08:51:28 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4XzHMuw-yViDd-b9wABq7FdPlEGtq8BmhS2yf88VXM_1779439897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,
Thank you for your review and the comment.

On 21/05/2026 22:01, Dmitry Osipenko wrote:
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
>>  =09return ret;
>>  }
>> =20
>> +/*
>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
>> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu=
().
>> + */
>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>> +{
>> +=09struct virtio_gpu_device *vgdev =3D dev->dev_private;
>> +
>> +=09vgdev->vqs_released =3D true;
>> +=09wake_up_all(&vgdev->ctrlq.ack_queue);
>> +=09wake_up_all(&vgdev->cursorq.ack_queue);
>> +}
>> +
>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>  {
>>  =09struct drm_device *dev =3D vdev->priv;
>> =20
>> +=09virtio_gpu_release_vqs(dev);
>>  =09drm_dev_unplug(dev);
>>  =09drm_atomic_helper_shutdown(dev);
>>  =09virtio_gpu_deinit(dev);
>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device=
 *vdev)
>>  {
>>  =09struct drm_device *dev =3D vdev->priv;
>> =20
>> +=09virtio_gpu_release_vqs(dev);
>>  =09/* stop talking to the device */
>>  =09drm_dev_unplug(dev);
>>  }
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virt=
io/virtgpu_drv.h
>> index f17660a71a3e..0bd69a40857e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>> =20
>>  =09struct virtio_gpu_queue ctrlq;
>>  =09struct virtio_gpu_queue cursorq;
>> +=09bool vqs_released;
>>  =09struct kmem_cache *vbufs;
>> =20
>>  =09atomic_t pending_commands;
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virti=
o/virtgpu_vq.c
>> index 67865810a2e7..8057a9b7356d 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_=
gpu_device *vgdev,
>>  =09if (vq->num_free < elemcnt) {
>>  =09=09spin_unlock(&vgdev->ctrlq.qlock);
>>  =09=09virtio_gpu_notify(vgdev);
>> -=09=09wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
>> +=09=09wait_event(vgdev->ctrlq.ack_queue,
>> +=09=09=09   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>> +=09=09/*
>> +=09=09 * Set by virtio_gpu_release_vqs() to unblock
>> +=09=09 * synchronize_srcu() wait in drm_dev_unplug().
>> +=09=09 */
>> +=09=09if (vgdev->vqs_released) {
>> +=09=09=09if (fence && vbuf->objs)
>> +=09=09=09=09virtio_gpu_array_unlock_resv(vbuf->objs);
>> +=09=09=09free_vbuf(vgdev, vbuf);
>> +=09=09=09drm_dev_exit(idx);
>> +=09=09=09return -ENODEV;
>> +=09=09}
>>  =09=09goto again;
>>  =09}
>> =20
>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_g=
pu_device *vgdev,
>>  =09ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>  =09if (ret =3D=3D -ENOSPC) {
>>  =09=09spin_unlock(&vgdev->cursorq.qlock);
>> -=09=09wait_event(vgdev->cursorq.ack_queue, vq->num_free >=3D outcnt);
>> +=09=09wait_event(vgdev->cursorq.ack_queue,
>> +=09=09=09   vq->num_free >=3D outcnt || vgdev->vqs_released);
>> +=09=09/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>> +=09=09if (vgdev->vqs_released) {
>> +=09=09=09free_vbuf(vgdev, vbuf);
>> +=09=09=09drm_dev_exit(idx);
>> +=09=09=09return;
>> +=09=09}
>>  =09=09spin_lock(&vgdev->cursorq.qlock);
>>  =09=09goto retry;
>>  =09} else {
>=20
> What about other wait_event in the driver? Why only these?

There are other wait_event() calls on vgdev->resp_wq in virtgpu_prime.c
and virtgpu_vram.c. These can also cause a stuck process when the host
device stops or does not respond and should be fixed. However, they are
not related to the issue being fixed here. I think they should be
addressed in a separate commit.

The wait_event(vgdev->resp_wq) calls wait for a host response, not for
virtqueue ring space. They are not inside a drm_dev_enter/exit()
critical section, so they don't block drm_dev_unplug() ->
synchronize_srcu() and are not part of the deadlock reported by syzbot.

However, if a process is stuck in wait_event(vgdev->resp_wq), there is
no way to recover other than host device recovery itself. We can still
remove the device and destroy the virtqueues while the process is stuck,
so the host response can never arrive. IIUC, the stuck thread holds a
drm_device reference, preventing vgdev from being freed; this is a
resource leak.

This can be fixed by adding a wake_up_all() and a vqs_released check
similar to what is done for ctrlq/cursorq. However, I think this should
be a separate commit since the root cause and problem are different.

Alternatively, the resp_wq wait_event() calls could be converted to
wait_event_interruptible() to fix the issue. But as you mentioned
earlier in the v1 comment, we need the wait_event_interruptible()
rework.

What do you think? Should I include the resp_wq fix as a separate commit
in this patch series, or leave it for the _interruptible() rework?

Best regards,
Ryosuke


