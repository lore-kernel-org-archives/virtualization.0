Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0062935E1A3
	for <virtualization@lists.linux.dev>; Fri,  3 Jul 2026 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058313; cv=none; b=iWYxnpsHe+A8bBSduuFGgQf3r6fK6TD5IB3sWQEZ7kNYm9phIln6OKpYQqsn73quN3hJ4dISwx7sFwADuGwjptc45HghOZDXTEIMOi8wHVqqItYxDaNoK/DDNUZWlG1cXU1NdIIOe1tYOtv1jRWviF9tCEyKPr+qsfaayLNm50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058313; c=relaxed/simple;
	bh=rQPpB1Fj0MsZNrN+zIUSc/l+uFINRFmqoxMEasdllQ8=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=rPhENB6BKiModWdMz7PnXzPGjhaGy4T3np/CbZbt4L6u7NJi/pyZAPxqWGMaU4Az3F/WACYWZBhADr66CBD+vKF9rggBWm3xhz81PEQtr8Ac+xcrwh0Q9iugG8q4Y2KE+7ZdeEgU26Yj7sgN19xqstJD9axkQ5c14ygTfIIN2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhH4YerW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhH4YerW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783058310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=T1Ub9EzZwRRVeQ1vc9r5jPdFwTwN77c6/6bNi9H21to=;
	b=FhH4YerWVzJrd27B85aQPbvDMlWfrCcGkm7QcqL3ZKWl/t+p7+CAOKdwKYQkhWj+0NVU3g
	N6mAEkpoirrtJaMNv7JOxE0INN1RSdLwliuMrvmUbcdYRdUqUfDDviwpPpZbRGO9LyogXL
	dWyoSFqYYVAhAus4aK+dsnmmLgYpuh0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-8uwLBeRuMGaEsmSeZ277cA-1; Fri, 03 Jul 2026 01:58:26 -0400
X-MC-Unique: 8uwLBeRuMGaEsmSeZ277cA-1
X-Mimecast-MFC-AGG-ID: 8uwLBeRuMGaEsmSeZ277cA_1783058306
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37c9127e316so490279a91.1
        for <virtualization@lists.linux.dev>; Thu, 02 Jul 2026 22:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783058305; x=1783663105;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GW2Z614cbbyH0tCcImMalWsa+hYlOLUUE+Wc31pCfnc=;
        b=d+mJVtaTRX8Y/2YsSP293zA3EZfR0E8dNgfNUtezNLymg5jvMELliJ1oSGVNDLTZs2
         Mw08XgOZl1vEGOKuQ+/jQzea8SvGM+ID20lqm6JfXOQ5kWMHRCjmv3uIkWjd8f+q5tE4
         QYwDmQAlzRcrThOcSKL3CLqXXBmfXTtHXZkHE0HyM0aq2ZCfcE7LqLY8pTtyUUWjQuU8
         +tF1FYTxOhuw8yux9br6vUL0ifoN/fEQyvASVOWjeQgYqg2n2Zf/6/WyZjFuUsE6B/jL
         UdazcWeZ6H1J5ZMzs4AhQxv/8D3kj6/sDIqzm02W0HqgSQO+gu0rNwcj7ECTXVDdPkHK
         xrLg==
X-Forwarded-Encrypted: i=1; AHgh+Rq05KI3QejyhCay+KkYCPxr05+wMnaLrzVU4iM0NsP4C8oDn83OEV9aWYEOMdafS1hYno547OC5P4maOuzQ5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVQ2hkPZOQ1NKe/FG60zfg/zwrowz+c0fugnLA9OTlQ3Y0JPMi
	5ti+in1sMuf6kugksB9m22yaLq/5KQuRCR+P8hh//RVNpinzwUyYRhLcSnIWkeSsgNGfa9mxlJh
	27Vg5M3BUedHfdy/dB3KfLYXX6AkQZ6WHK4ZZW745oEBYQXSKWDS1j/i8X2oNTzBZ2TcA25D46q
	0WHmGeSbxsvEzpVHMd7E8S6HlfsZd/ws/UBrPJQrjoffpJ9zIoc+ODNiY=
X-Gm-Gg: AfdE7clDIkv69HsEwAiQpeI4fhQqeTgd6Y52aqyWwBWHKGnO/Vu2m43QN5hv25gg3V+
	fP58hktN4Hcolv+9+QYnBkKmIf0yoKmKkO7dMQt5fnh2T5nUpv4V87Dw2YVKS37JLC0b3cjqeDo
	3IcMRjgan/hfApP7JVTxe9umrzuDiD4otOJyjejNhvlk+v/PQRL2FCXihYZN22wY3GNo9ye9XFf
	fQ+b14G3TUmLgunk7S2UuoUwn1+bHD8BAGB7luRj/IP1n7OgxJkqiTJh55X4YWjN0Sz/b0Sy9N1
	w7GErKsBSLuoVtRBh2qPhTSFZL9hlQBP2o1+qZ1weS9wu5dWHes/HMQcfwIovxfdMiMYt7DUK7A
	tiApxUnvWTyRNB2q/RfwkSOkKGcruBynP8DguJpHYfSQ/amcq
X-Received: by 2002:a17:90b:3c44:b0:37f:9ce2:348f with SMTP id 98e67ed59e1d1-380aa2225dfmr9516841a91.32.1783058305486;
        Thu, 02 Jul 2026 22:58:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3c44:b0:37f:9ce2:348f with SMTP id 98e67ed59e1d1-380aa2225dfmr9516792a91.32.1783058304725;
        Thu, 02 Jul 2026 22:58:24 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38097cfcf1dsm2194113a91.1.2026.07.02.22.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:58:24 -0700 (PDT)
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
In-Reply-To: <1b56e514-17b5-4da1-9ebd-4534e3204ea4@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid
	 deadlock
Message-ID: <18beb213335dd544.57cdc20d9a554be2.724d3e176f79ad9@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Fri, 3 Jul 2026 05:58:18 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A1pBuv1RqOZhy3gR3fBg8vNpo_a_-HxGAaljtWjJCC8_1783058306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 02/07/2026 14:26, Dmitry Osipenko wrote:
> On 7/1/26 12:23, Ryosuke Yasuoka wrote:
>>=20
>>=20
>> On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>> Hi,
>>>
>>> On 6/30/26 12:16, Ryosuke Yasuoka wrote:
>>>> A probe-time deadlock can occur between the dequeue worker and
>>>> drm_client_register(). During probe, drm_client_register() holds
>>>> clientlist_mutex and calls the fbdev hotplug callback, which triggers =
an
>>>> atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
>>>> waiting for virtqueue space. The dequeue worker that would free that
>>>> space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
>>>> drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
>>>> to acquire the same clientlist_mutex. Since wake_up() is only called
>>>> after the resp_cb loop, the probe thread is never woken and both threa=
ds
>>>> deadlock.
>>>>
>>>> Fix this by deferring the hotplug notification from
>>>> virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
>>>> display data (outputs[i].info) is still updated synchronously in the
>>>> callback, and the deferred work only triggers a re-probe notification =
to
>>>> DRM clients.
>>>>
>>>> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering=
 a client")
>>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e=
45c1c6e549453f224
>>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf=
7baf376cc873a922e
>>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>>> ---
>>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
>>>>  drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
>>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
>>>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/vi=
rtio/virtgpu_drv.h
>>>> index 7449907754a4..27ffa4697ae9 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>> @@ -264,6 +264,8 @@ struct virtio_gpu_device {
>>>> =20
>>>>  =09struct work_struct config_changed_work;
>>>> =20
>>>> +=09struct work_struct hotplug_work;
>>>> +
>>>>  =09struct work_struct obj_free_work;
>>>>  =09spinlock_t obj_free_lock;
>>>>  =09struct list_head obj_free_list;
>>>> @@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct vir=
tio_gpu_device *vgdev,
>>>>  =09=09=09=09=09uint32_t x, uint32_t y,
>>>>  =09=09=09=09=09struct virtio_gpu_object_array *objs,
>>>>  =09=09=09=09=09struct virtio_gpu_fence *fence);
>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work);
>>>>  void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vg=
dev,
>>>>  =09=09=09=09=09 uint32_t resource_id,
>>>>  =09=09=09=09=09 uint32_t x, uint32_t y,
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/vi=
rtio/virtgpu_kms.c
>>>> index cfde9f573df6..cfb532ba43a4 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>> @@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, st=
ruct drm_device *dev)
>>>>  =09INIT_WORK(&vgdev->config_changed_work,
>>>>  =09=09  virtio_gpu_config_changed_work_func);
>>>> =20
>>>> +=09INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
>>>> +
>>>>  =09INIT_WORK(&vgdev->obj_free_work,
>>>>  =09=09  virtio_gpu_array_put_free_work);
>>>>  =09INIT_LIST_HEAD(&vgdev->obj_free_list);
>>>> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>>>  =09flush_work(&vgdev->obj_free_work);
>>>>  =09flush_work(&vgdev->ctrlq.dequeue_work);
>>>>  =09flush_work(&vgdev->cursorq.dequeue_work);
>>>> +=09flush_work(&vgdev->hotplug_work);
>>>>  =09flush_work(&vgdev->config_changed_work);
>>>>  =09virtio_reset_device(vgdev->vdev);
>>>>  =09vgdev->vdev->config->del_vqs(vgdev->vdev);
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/vir=
tio/virtgpu_vq.c
>>>> index 67865810a2e7..084d98f5dc7b 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>> @@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct vir=
tio_gpu_device *vgdev,
>>>>  =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>>>>  }
>>>> =20
>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work)
>>>> +{
>>>> +=09struct virtio_gpu_device *vgdev =3D
>>>> +=09=09container_of(work, struct virtio_gpu_device, hotplug_work);
>>>> +
>>>> +=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>> +=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>>>> +}
>>>> +
>>>>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_devi=
ce *vgdev,
>>>>  =09=09=09=09=09       struct virtio_gpu_vbuffer *vbuf)
>>>>  {
>>>> @@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(str=
uct virtio_gpu_device *vgdev,
>>>>  =09spin_unlock(&vgdev->display_info_lock);
>>>>  =09wake_up(&vgdev->resp_wq);
>>>> =20
>>>> -=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>> -=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>>>> +=09schedule_work(&vgdev->hotplug_work);
>>>>  }
>>>> =20
>>>>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_devic=
e *vgdev,
>>>
>>=20
>> Hi,
>> Thank you for your review.
>>=20
>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init=
(), placing it after wait_event_timeout(display_info_pending)? This will av=
oid additional work_struct that otherwise needs to be cancelled in virtio_g=
pu_init() on the timeout.
>>=20
>> IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>> into virtio_gpu_init() after wait_event_timeout() would not prevent the
>> issue.
>>=20
>> Looking at the syzbot call traces[1][2], the deadlock occurs during
>> drm_client_setup(), which runs after virtio_gpu_init() has already
>> returned. The display_info_cb that triggers the deadlock is called from
>> the dequeue worker while drm_client_register() holds clientlist_mutex.
>>=20
>> Thread A:
>> virtio_gpu_probe()
>>  -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>=20
> You mean that the timeout happens and it's again syzkaller report for a
> broken host. A day ago I applied [1] that should fix this "bogus"
> syzkaller report.
>=20
> [1] https://patchwork.freedesktop.org/patch/735301/

Thank you for [1] and the clarificaiton. I agree that [1] addresses the
broken host scenario where virtio_gpu_init() times out and probe
continues with a pending display_info response. I think there is another
scenario causing the same deadlock reported by syzbot and my patch
addresses both cases.

The deadlock can also occur with the following scenario:
after virtio_gpu_init() completes successfully (wait_event_timeout
returns), if a config_changed event arrives before drm_client_setup()
completes, config_changed_work_func() sends a new GET_DISPLAY_INFO. Its
display_info_cb fires in the dequeue worker and blocks on
clientlist_mutex held by drm_client_register(). This is the same
deadlock path reported by syzbot.

Since [1] only prevents the timeout case, I believe the schedule_work()
approach is still needed to prevent display_info_cb from blocking on
clientlist_mutex in the dequeue worker context, regardless of the
trigger.

Best regards,
Ryosuke

