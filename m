Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B64219F2
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600267; cv=none; b=qVkOQcSfyy0ArxD3IbaivhwybmGVM3853E6MahJLIBAB+ywrJhcw6WigY3fExlUlk+wc+djc9TJVxsWkJehMguHonNqu3XWVexDYV/1C9JMlp7a1hj7WK0CgkpuvdLUlD7EcjEnKjQeyL8mKod+rE99lO/HYXY0l9IQuGzYhMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600267; c=relaxed/simple;
	bh=6ZMWD1m+QdafWj96HPDqQ/HvS2ezPpGxuUWnm4jlSpk=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=coF7JkYQTkKl4sCQ+y8k+VysxOW9nIiV091P9vBVcr8QX3QcCIBH//y1tZwhn/5lZK0tTrrtsqPi68UII4U40r6Vrr3uQp1Jf02B6voZ0Cd+ptWriN9ZwGVKgbS+1PldFG80A6Jh+cSQUtCB9gjCqiOS3J3SnQ66eFxcArkYkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h55/GGlF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h55/GGlF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783600264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=lXKPGtIkkQ9hFJySDcL2hUHhTrWR2v5dfymubmoHRZ8=;
	b=h55/GGlFTm8VBzKhHhDE/xeVWiRTqkgVZ7Byb6gllXKZSIo6qoSSYQBb8Uk8mbRM1r5Ds4
	+wrh6anBZPmUXnNg/A9OGOtHlJrjk4OoK3Djwu/TQ+s11q0REMhV4AixfHYZG/o3iUqUDA
	5Nk2d/9tof/JCBaR+rgztuomcWYA+FE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-bwmJRVyRPJ6ZSjjzEBH2nQ-1; Thu, 09 Jul 2026 08:31:02 -0400
X-MC-Unique: bwmJRVyRPJ6ZSjjzEBH2nQ-1
X-Mimecast-MFC-AGG-ID: bwmJRVyRPJ6ZSjjzEBH2nQ_1783600262
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484b9fb055so4092346b3a.0
        for <virtualization@lists.linux.dev>; Thu, 09 Jul 2026 05:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600262; x=1784205062;
        h=content-transfer-encoding:content-type:date:message-id:subject:cc
         :in-reply-to:to:from:mime-version:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuZXYe9E4UnOW3M5JnOHkj7jwpeywGNDcze3LLgSOHU=;
        b=GrQUt2+S3D9mmuFVapKwUmJqpfrtJ9dmx4bbYRTI2JTe54X00fo9yN9ueAiYxPfBXV
         ejjyKGFNCtbQe5K0sBibNgXUjvOUNIJPhtpQDrKlsn2EZSN8xsHU45N+9EkGKz/gu6f7
         51PuFuRrcofqJQxVrDRa3TzFt+1Nr7KeeJyoiFTqt9flBkI9P+2ZkNmRRG8W33GCIxJQ
         JP6rdi0jPUtRZCZYjw5/Oo7HRAdK0Gc06zMqjHRSUE5fhRPhOz2+DMQ/Hpjpy4r6+35i
         Z25v+B5c54WtT4Yl0kDxlbQGuxaC3hblr7+RWLlwlSuQ6Aei37D50dzo6njYgKz1k9q/
         JSAA==
X-Forwarded-Encrypted: i=1; AHgh+RqHBSUggNe2RQNZmLFb0oMu8zYi/+hDCGiNC7e0ewkfH1/Zym6oPxLkULJo7MYN7gpdD32SRYdF/MkybJREJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtBPyUKnmwFjSAa9R66pFR38JThGeWdPJZw+5bO4eC61JgEYbd
	Y5rqQcQA+lqt6VYm8JZdCFgWACJywIePkz2BNmaQb9eWGDp1uTMV1c/6KV5p++nDotJCurw/9Nb
	+a0t0ZOfIISCkutQquIoMQJEvmeuW9rYiVTiwiOXuWoGk8Mo/KAaCIy3Wb/Y6/t/L1b38
X-Gm-Gg: AfdE7cno5F5veMAV0YSxAdUJ6ea4xlmBTGIUFA64ExHMfb7gw7gnO60feMWTrazBxkP
	3qEonGtqtOhlWKDtgGcNVTVPUD0V64Q5wJjZNOt5a2W5EmNdlA016+WRI/DziL+vtzAMzqtxSgi
	9uezUKOWLAdJbP2Xf0KpTr3f/LLp+s4Mbr3kuYk6RnSju04BHVZQAToQ+45mHmNI2+/2Rq1TuXj
	CxHF+izMZ6u/PL1eW1eiEZRjmY7ZDp0IMWaM8wCbMN/r7s2BuvEjpAmT7pVUoRgckmorYn9GqhC
	xdIDvNkOHivVRhKIln63d34wLeWGUxKXNU7eoQaB0fHvAGFCW1kV6qHM0XSn+74/Et7BJ2Xa37y
	zpe+vcFcvyI94IC6ljDLQzsnJapbQtQvX0rUURvUK76M4AKRZ
X-Received: by 2002:a05:6a00:3989:b0:848:354f:4f8f with SMTP id d2e1a72fcca58-8484327d807mr6742167b3a.22.1783600261668;
        Thu, 09 Jul 2026 05:31:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:3989:b0:848:354f:4f8f with SMTP id d2e1a72fcca58-8484327d807mr6742124b3a.22.1783600261143;
        Thu, 09 Jul 2026 05:31:01 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8596374b3a.38.2026.07.09.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:31:00 -0700 (PDT)
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
In-Reply-To: <8b02c456-fb23-4c17-ad20-a2bab2d588b1@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to avoid
	 deadlock
Message-ID: <18c09efbacafbff3.b25d31827bed23c9.829612c1dfc3d1e4@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Thu, 9 Jul 2026 12:30:56 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I4YkIczdm8TYZ5FGCv6Jukgo3woUHAOXUQc4kNNbDbI_1783600262
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 07/07/2026 18:10, Dmitry Osipenko wrote:
> On 7/3/26 08:58, Ryosuke Yasuoka wrote:
>>=20
>>=20
>> On 02/07/2026 14:26, Dmitry Osipenko wrote:
>>> On 7/1/26 12:23, Ryosuke Yasuoka wrote:
>>>>
>>>>
>>>> On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>>>> Hi,
>>>>>
>>>>> On 6/30/26 12:16, Ryosuke Yasuoka wrote:
>>>>>> A probe-time deadlock can occur between the dequeue worker and
>>>>>> drm_client_register(). During probe, drm_client_register() holds
>>>>>> clientlist_mutex and calls the fbdev hotplug callback, which trigger=
s an
>>>>>> atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
>>>>>> waiting for virtqueue space. The dequeue worker that would free that
>>>>>> space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
>>>>>> drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempti=
ng
>>>>>> to acquire the same clientlist_mutex. Since wake_up() is only called
>>>>>> after the resp_cb loop, the probe thread is never woken and both thr=
eads
>>>>>> deadlock.
>>>>>>
>>>>>> Fix this by deferring the hotplug notification from
>>>>>> virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
>>>>>> display data (outputs[i].info) is still updated synchronously in the
>>>>>> callback, and the deferred work only triggers a re-probe notificatio=
n to
>>>>>> DRM clients.
>>>>>>
>>>>>> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registeri=
ng a client")
>>>>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe740=
6e45c1c6e549453f224
>>>>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4=
cf7baf376cc873a922e
>>>>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
>>>>>>  drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
>>>>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
>>>>>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/=
virtio/virtgpu_drv.h
>>>>>> index 7449907754a4..27ffa4697ae9 100644
>>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>>> @@ -264,6 +264,8 @@ struct virtio_gpu_device {
>>>>>> =20
>>>>>>  =09struct work_struct config_changed_work;
>>>>>> =20
>>>>>> +=09struct work_struct hotplug_work;
>>>>>> +
>>>>>>  =09struct work_struct obj_free_work;
>>>>>>  =09spinlock_t obj_free_lock;
>>>>>>  =09struct list_head obj_free_list;
>>>>>> @@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct v=
irtio_gpu_device *vgdev,
>>>>>>  =09=09=09=09=09uint32_t x, uint32_t y,
>>>>>>  =09=09=09=09=09struct virtio_gpu_object_array *objs,
>>>>>>  =09=09=09=09=09struct virtio_gpu_fence *fence);
>>>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work);
>>>>>>  void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *=
vgdev,
>>>>>>  =09=09=09=09=09 uint32_t resource_id,
>>>>>>  =09=09=09=09=09 uint32_t x, uint32_t y,
>>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/=
virtio/virtgpu_kms.c
>>>>>> index cfde9f573df6..cfb532ba43a4 100644
>>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>>>> @@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, =
struct drm_device *dev)
>>>>>>  =09INIT_WORK(&vgdev->config_changed_work,
>>>>>>  =09=09  virtio_gpu_config_changed_work_func);
>>>>>> =20
>>>>>> +=09INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
>>>>>> +
>>>>>>  =09INIT_WORK(&vgdev->obj_free_work,
>>>>>>  =09=09  virtio_gpu_array_put_free_work);
>>>>>>  =09INIT_LIST_HEAD(&vgdev->obj_free_list);
>>>>>> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>>>>>  =09flush_work(&vgdev->obj_free_work);
>>>>>>  =09flush_work(&vgdev->ctrlq.dequeue_work);
>>>>>>  =09flush_work(&vgdev->cursorq.dequeue_work);
>>>>>> +=09flush_work(&vgdev->hotplug_work);
>>>>>>  =09flush_work(&vgdev->config_changed_work);
>>>>>>  =09virtio_reset_device(vgdev->vdev);
>>>>>>  =09vgdev->vdev->config->del_vqs(vgdev->vdev);
>>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/v=
irtio/virtgpu_vq.c
>>>>>> index 67865810a2e7..084d98f5dc7b 100644
>>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>>> @@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct v=
irtio_gpu_device *vgdev,
>>>>>>  =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>>>>>>  }
>>>>>> =20
>>>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work)
>>>>>> +{
>>>>>> +=09struct virtio_gpu_device *vgdev =3D
>>>>>> +=09=09container_of(work, struct virtio_gpu_device, hotplug_work);
>>>>>> +
>>>>>> +=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>>>> +=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>>>>>> +}
>>>>>> +
>>>>>>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_de=
vice *vgdev,
>>>>>>  =09=09=09=09=09       struct virtio_gpu_vbuffer *vbuf)
>>>>>>  {
>>>>>> @@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(s=
truct virtio_gpu_device *vgdev,
>>>>>>  =09spin_unlock(&vgdev->display_info_lock);
>>>>>>  =09wake_up(&vgdev->resp_wq);
>>>>>> =20
>>>>>> -=09if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>>>> -=09=09drm_kms_helper_hotplug_event(vgdev->ddev);
>>>>>> +=09schedule_work(&vgdev->hotplug_work);
>>>>>>  }
>>>>>> =20
>>>>>>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_dev=
ice *vgdev,
>>>>>
>>>>
>>>> Hi,
>>>> Thank you for your review.
>>>>
>>>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_in=
it(), placing it after wait_event_timeout(display_info_pending)? This will =
avoid additional work_struct that otherwise needs to be cancelled in virtio=
_gpu_init() on the timeout.
>>>>
>>>> IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>>> into virtio_gpu_init() after wait_event_timeout() would not prevent th=
e
>>>> issue.
>>>>
>>>> Looking at the syzbot call traces[1][2], the deadlock occurs during
>>>> drm_client_setup(), which runs after virtio_gpu_init() has already
>>>> returned. The display_info_cb that triggers the deadlock is called fro=
m
>>>> the dequeue worker while drm_client_register() holds clientlist_mutex.
>>>>
>>>> Thread A:
>>>> virtio_gpu_probe()
>>>>  -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>>>
>>> You mean that the timeout happens and it's again syzkaller report for a
>>> broken host. A day ago I applied [1] that should fix this "bogus"
>>> syzkaller report.
>>>
>>> [1] https://patchwork.freedesktop.org/patch/735301/
>>=20
>> Thank you for [1] and the clarificaiton. I agree that [1] addresses the
>> broken host scenario where virtio_gpu_init() times out and probe
>> continues with a pending display_info response. I think there is another
>> scenario causing the same deadlock reported by syzbot and my patch
>> addresses both cases.
>>=20
>> The deadlock can also occur with the following scenario:
>> after virtio_gpu_init() completes successfully (wait_event_timeout
>> returns), if a config_changed event arrives before drm_client_setup()
>> completes, config_changed_work_func() sends a new GET_DISPLAY_INFO. Its
>> display_info_cb fires in the dequeue worker and blocks on
>> clientlist_mutex held by drm_client_register(). This is the same
>> deadlock path reported by syzbot.
>>=20
>> Since [1] only prevents the timeout case, I believe the schedule_work()
>> approach is still needed to prevent display_info_cb from blocking on
>> clientlist_mutex in the dequeue worker context, regardless of the
>> trigger.
>=20
> The config_changed_work_func() already invokes
> drm_helper_hpd_irq_event() by itself [1].
>=20
> [1]
> https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/virtio/vir=
tgpu_kms.c#L52
>=20
> The drm_helper_hpd_irq_event() itself calls
> drm_kms_helper_hotplug_event() [2].
>=20
> [2]
> https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/drm_probe_=
helper.c#L1113
>=20
> Isn't drm_helper_hpd_irq_event() call done by
> virtio_gpu_cmd_get_display_info_cb() already partially redundant? I.e.
> only it's needed by virtio_gpu_init() and not by
> config_changed_work_func(). And then we can move
> drm_helper_hpd_irq_event() to virtio_gpu_init():
>=20
> ```
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c
> b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 922782bdc9cd..9805283683c1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -303,6 +303,7 @@ int virtio_gpu_init(struct virtio_device *vdev,
> struct drm_device *dev)
>                 virtio_gpu_notify(vgdev);
>                 wait_event_timeout(vgdev->resp_wq,
> !vgdev->display_info_pending,
>                                    5 * HZ);
> +               drm_helper_hpd_irq_event(vgdev->ddev);
>         }
>=20
>         vgdev->pm_nb.notifier_call =3D virtio_gpu_pm_notifier;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c
> b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 68d097ad9d1d..aa6440a9b81e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -880,9 +880,6 @@ static void
> virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>         vgdev->display_info_pending =3D false;
>         spin_unlock(&vgdev->display_info_lock);
>         wake_up(&vgdev->resp_wq);
> -
> -       if (!drm_helper_hpd_irq_event(vgdev->ddev))
> -               drm_kms_helper_hotplug_event(vgdev->ddev);
>  }
>=20
>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device
> *vgdev,
> ```
>=20
> Isn't it a bug that config_changed_work_func() doesn't wait for
> display_info_pending event?
>=20
>=20
> ```
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c
> b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 922782bdc9cd..dd2d5c896c39 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -50,6 +50,8 @@ static void virtio_gpu_config_changed_work_func(struct
> work_struct *work)
>                                 virtio_gpu_cmd_get_edids(vgdev);
>                         virtio_gpu_cmd_get_display_info(vgdev);
>                         virtio_gpu_notify(vgdev);
> +                       wait_event_timeout(vgdev->resp_wq,
> !vgdev->display_info_pending,
> +                                          5 * HZ);
>                         drm_helper_hpd_irq_event(vgdev->ddev);
>                 }
>                 events_clear |=3D VIRTIO_GPU_EVENT_DISPLAY;
>=20
> ```

Thank you for your suggestion. I agree that removing the hotplug calls
from display_info_cb and waiting for the response in
config_changed_work_func() and virtio_gpu_init() is a cleaner approach.
I'll send a v2 based on this.

Best regards,
Ryosuke

