Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EC38656D
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897797; cv=none; b=AaMqua3SIgktJqZU+iAiR4XQSkPTrbMSeXzx8Y9dB9pBqn9FrLP4VFL9BJOG1zKubUMl8oLl7dJ/rjeNPE8e3vhx8KDH+EY7y+/m+vLsombm/o08KtdW24w3t4PvHfzdCMgvNsNT1x92df51LvtyWTZr25v9UgmTmbevEm1KxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897797; c=relaxed/simple;
	bh=hSJ+fVg5DqIhyNfk7G+vNuKE8xNz7vhz0PBxqg7y988=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=C0XZjyXou9iM2SOXGo31jbJD3SoMbraP8Wg+FtgfqzPHKnq8xpbBh5JGk5jDCTFO+JmCJZjRq0GAfftMJ6s2ZPFTUErFG8CAfDZ8vKhVuWsrHF3xoJJKLVFUW48+wSr3Mv1YV01SesxSijDAS3jzB6i9OT80pDzoolQAIBWRrU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsfYHXLo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsfYHXLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782897794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=ujysy+ydPxBsX1pWUIjvfD6kA9LpBP3ShklG8JNE8wg=;
	b=WsfYHXLo7QP5gm/6+mEzMkJH4768X+AyvMkMobfEPOiBdLG/7zI7hKU+Qv8sfepBsgbryY
	R2WuierzG1+DqjfY6nQiAHmK6hjKcusS2Bgyybx2XIImLWPKIw18uYHnNJ7c/oFWyPvHjE
	6fuuw89FwOJpcakJ+ETtofzvAH6Nv98=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Pgnl_qQgNW2UTa_-QCAY_g-1; Wed, 01 Jul 2026 05:23:13 -0400
X-MC-Unique: Pgnl_qQgNW2UTa_-QCAY_g-1
X-Mimecast-MFC-AGG-ID: Pgnl_qQgNW2UTa_-QCAY_g_1782897792
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38001e788d6so496875a91.3
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 02:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782897792; x=1783502592;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WwNeizDBR0L7D6u80TuuTOjUtXht3070o55b7PDf+lc=;
        b=g5XBM+wv/JBQx1JG/a3EW1Yzqc32mZhva9AM5eyGcXtdoiWZ1k784+WAXyuqC4SW+I
         L0vRHXz+4GHgunLV4Aj5S/NGzCluoHQCkhBAx9jdDp87HQu35ZzV4lCqSJ9B51VMehSg
         5czphl5wmuSTmmF/j1EfZo5X668jD+4TCE+37LJeTmK+HHVBf3Us8cg8zpPWVBbv0uYV
         cZZQrmiQo/lkG3h6aT73zUFNGfmWstLsZZl0AztrDNlbMmaIRrnNW/3Nv55cN7fyrD8H
         pQ8dIBqaNgHboFxjXqfSDcc37Pjxu5kwQXGlctyErIwCcWWfhTbsrUaHER+xa4nSHP7d
         cz8w==
X-Forwarded-Encrypted: i=1; AHgh+Roi+k3IuQspj5rvpgt1KQ1I3/uFxZpXb1xKfQW+oRvryMyfkpzi2uyrDpZxPzVse0fL2tVXN1PKVuLRlrTu/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoaNCfA+tIb3T3twcbR4wjhxvubcw9d5jN4prNPP6nN8ZVGu5s
	HRII0/yArOluUywGzLiLzJxpk4M5za62S7Bno0ILclIUxIBdAY+zJIFZFHXMS/n9bHiUY4qb+NV
	S7mOmAcmZs1nA3Yup6T+HnEhvlTsH8E0LXyCkpC32527Y3o/Esayla/N9kIZdHGO/p/dh
X-Gm-Gg: AfdE7ckRXaOUXRRVgbEPn7lgHnJc0fZrpoPHNHZn+B1fXlHwCvkARz9WVsKjgWb9qJv
	Jdbj4p8SoMABKCqaHZnhWqcXBlfEMSRDbSAEjBGoJu7kcVQBHOFinlvWuAQIoguSLWXAADB0c0O
	9NSuCWXwlCZLwv1W4e5kjwZF/7uFmmpVCu9JhD7wgGTRyk7wtDUbobtTmVmnHPceLV0BWf7qz0+
	GClKCA+RN+44ngCPxvjMd6j3VJi0OLSh7pQtyJPxXb6xO6UGwBChlikF+Egxlc8WFcaLOMaUOxy
	Lj9cn0A7HZJngXgcpz5VeAr7R8l5hCOcn9NInp15QNwxHICRHMed2UrOGJ4FtQR8OeWg9Rq9J+t
	3SXODRtv/gLp/Uzh/T1WX2PeRIAqhbQSkJGjkBCqk1JK8USt4
X-Received: by 2002:a17:90b:3a45:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-380aa234f58mr758679a91.27.1782897792170;
        Wed, 01 Jul 2026 02:23:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3a45:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-380aa234f58mr758663a91.27.1782897791674;
        Wed, 01 Jul 2026 02:23:11 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095d46b9esm1493384a91.2.2026.07.01.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:23:11 -0700 (PDT)
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
	"Simona Vetter" <simona@ffwll.ch>, "Dmitry Baryshkov" <lumag@kernel.org>, 
	"Javier Martinez Canillas" <javierm@redhat.com>
In-Reply-To: <5aa634c1-7530-4b1f-931a-a5a5ac6c908a@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid
	 deadlock
Message-ID: <18be2016e26ade27.a6e9e2496bc1f978.9bc3a62421115997@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Wed, 1 Jul 2026 09:23:05 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -oV1OCOe04lu3OufmT1mzsFSqxhKBwHKR-Ei5kJfI6s_1782897792
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 30/06/2026 16:46, Dmitry Osipenko wrote:
> Hi,
>=20
> On 6/30/26 12:16, Ryosuke Yasuoka wrote:
>> A probe-time deadlock can occur between the dequeue worker and
>> drm_client_register(). During probe, drm_client_register() holds
>> clientlist_mutex and calls the fbdev hotplug callback, which triggers an
>> atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
>> waiting for virtqueue space. The dequeue worker that would free that
>> space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
>> drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
>> to acquire the same clientlist_mutex. Since wake_up() is only called
>> after the resp_cb loop, the probe thread is never woken and both threads
>> deadlock.
>>=20
>> Fix this by deferring the hotplug notification from
>> virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
>> display data (outputs[i].info) is still updated synchronously in the
>> callback, and the deferred work only triggers a re-probe notification to
>> DRM clients.
>>=20
>> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a=
 client")
>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45=
c1c6e549453f224
>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7b=
af376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
>>  drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virt=
io/virtgpu_drv.h
>> index 7449907754a4..27ffa4697ae9 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>> @@ -264,6 +264,8 @@ struct virtio_gpu_device {
>> =20
>>  =09struct work_struct config_changed_work;
>> =20
>> +=09struct work_struct hotplug_work;
>> +
>>  =09struct work_struct obj_free_work;
>>  =09spinlock_t obj_free_lock;
>>  =09struct list_head obj_free_list;
>> @@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virti=
o_gpu_device *vgdev,
>>  =09=09=09=09=09uint32_t x, uint32_t y,
>>  =09=09=09=09=09struct virtio_gpu_object_array *objs,
>>  =09=09=09=09=09struct virtio_gpu_fence *fence);
>> +void virtio_gpu_hotplug_work_func(struct work_struct *work);
>>  void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgde=
v,
>>  =09=09=09=09=09 uint32_t resource_id,
>>  =09=09=09=09=09 uint32_t x, uint32_t y,
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virt=
io/virtgpu_kms.c
>> index cfde9f573df6..cfb532ba43a4 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>> @@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, stru=
ct drm_device *dev)
>>  =09INIT_WORK(&vgdev->config_changed_work,
>>  =09=09  virtio_gpu_config_changed_work_func);
>> =20
>> +=09INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
>> +
>>  =09INIT_WORK(&vgdev->obj_free_work,
>>  =09=09  virtio_gpu_array_put_free_work);
>>  =09INIT_LIST_HEAD(&vgdev->obj_free_list);
>> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>  =09flush_work(&vgdev->obj_free_work);
>>  =09flush_work(&vgdev->ctrlq.dequeue_work);
>>  =09flush_work(&vgdev->cursorq.dequeue_work);
>> +=09flush_work(&vgdev->hotplug_work);
>>  =09flush_work(&vgdev->config_changed_work);
>>  =09virtio_reset_device(vgdev->vdev);
>>  =09vgdev->vdev->config->del_vqs(vgdev->vdev);
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virti=
o/virtgpu_vq.c
>> index 67865810a2e7..084d98f5dc7b 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct virti=
o_gpu_device *vgdev,
>>  =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>>  }
>> =20
>> +void virtio_gpu_hotplug_work_func(struct work_struct *work)
>> +{
>> +=09struct virtio_gpu_device *vgdev =3D
>> +=09=09container_of(work, struct virtio_gpu_device, hotplug_work);
>> +
>> +=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>> +=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>> +}
>> +
>>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device=
 *vgdev,
>>  =09=09=09=09=09       struct virtio_gpu_vbuffer *vbuf)
>>  {
>> @@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(struc=
t virtio_gpu_device *vgdev,
>>  =09spin_unlock(&vgdev->display_info_lock);
>>  =09wake_up(&vgdev->resp_wq);
>> =20
>> -=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>> -=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>> +=09schedule_work(&vgdev->hotplug_work);
>>  }
>> =20
>>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device =
*vgdev,
>=20

Hi,
Thank you for your review.

> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init()=
, placing it after wait_event_timeout(display_info_pending)? This will avoi=
d additional work_struct that otherwise needs to be cancelled in virtio_gpu=
_init() on the timeout.

IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
into virtio_gpu_init() after wait_event_timeout() would not prevent the
issue.

Looking at the syzbot call traces[1][2], the deadlock occurs during
drm_client_setup(), which runs after virtio_gpu_init() has already
returned. The display_info_cb that triggers the deadlock is called from
the dequeue worker while drm_client_register() holds clientlist_mutex.

Thread A:
virtio_gpu_probe()
 -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
 -> drm_dev_register()
 -> drm_client_setup()   // deadlock happens HERE
     -> drm_client_register()   // holds clientlist_mutex
     ...
     -> virtio_gpu_queue_fenced_ctrl_buffer()
         -> wait_event() // waits for free space

Thread B:
virtio_gpu_dequeue_ctrl_func()
 -> reclaim_vbufs()   // make free space
 -> resp_cb()
     -> virtio_gpu_cmd_get_display_info_cb
         -> drm_helper_hpd_irq_event()
         -> drm_kms_helper_hotplug_event()
             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
 -> wake_up()   // never reached

IIUC the hotplug notification in display_info_cb is needed because it
notifies DRM after updating by the callback with fresh data from the host.

This work_struct ensures display_info_cb never blocks on
clientlist_mutex in the dequeue worker, while preserving the hotplug
notification with fresh data.

[1] https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45c1c6e54=
9453f224
[2] https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7baf376cc=
873a922e

Best regards,
Ryosuke

