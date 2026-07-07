Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6373783C7
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437072; cv=pass; b=u4KOTFFN9kws/rukPKheebR0NREE1k7MWXtrmoBX38r4SoxaeFnPN44HUEUI/clSFoTu0EUcTFi2jNT3wzoOsaqn44lcimzf8dUi97nSKYmRfsaN/IpjCYePxLLI2TSzae2FyaTA7tUpGHYM0uNVP0sj5csKhG2U+5m163pBg9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437072; c=relaxed/simple;
	bh=voi3oyw22CkG0qwclJrZ8GK9ImBElAC2l6KzeNOwFFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6+wT20fvjVCXQUZa0Xh6ySCl8GU/uFdkV5wjShAG1zlw+woJyfbgZjaESgfy7o2QYC6JjYOlY0UH5kD12Q9BIxuk3Y2IcRaYehOsq3rbSEIh+ORnxS1rtFrn/m0xPk9T1R0GeKZ21ivTyCvHIZ2sWbq3b8XuYLs+ce3ZY8ae8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=kSpo+r2W; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kSpo+r2W"
ARC-Seal: i=1; a=rsa-sha256; t=1783437059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d+GEGtixobrI9AQMcY0LkClOUFcI3wi52SiSYU4IlIV2A53YW1AlISLWAyjlpnzTgYwtSvR8UaL9El9YSasjE/ypaW+HwWgd/vbRzrp1aujFdfWfAQO5jF8Rhb1JBLuDvuVDxFVl56DIUaGCTJG4wRfuZD86bz6dSq3OIzpZLD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783437059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zbMlIGQ0sYd7uDW1jFhubeLMro2JlZCRFaoEbfN6HZY=; 
	b=gRFQnkYN0Sg4YW3ooHUt0GznWlMTfZagodfk8lakaBqVzH8XOs0Zy0idBJwgHunuvu4Ioy5Lklxy4kbKIy8GShgG3pia0htkU/3zs6f7yCUyEkkae7foTl9FHQm7hLgYgPlbE33wVIkGyyE7669cqs0zkquh10+/DrBHiNpXsXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783437059;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zbMlIGQ0sYd7uDW1jFhubeLMro2JlZCRFaoEbfN6HZY=;
	b=kSpo+r2Ww8xKg34qcXQL3DPWZaQEuw5QeFH3IZHqUiPs+022zr4hDkIRc4IgMw0e
	WpogWcqXymeYUL0/N85ifdy1UCI9qFTvWQrbaSZTgcKvbWHw7ZhqLBBJOSX0lcAB22k
	SbgV1WIZ3gm+tMp1OtTQjQovgoR/u2cyxpXA+yJU=
Received: by mx.zohomail.com with SMTPS id 1783437057836994.9405528357895;
	Tue, 7 Jul 2026 08:10:57 -0700 (PDT)
Message-ID: <8b02c456-fb23-4c17-ad20-a2bab2d588b1@collabora.com>
Date: Tue, 7 Jul 2026 18:10:52 +0300
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
References: <18beb213335dd544.57cdc20d9a554be2.724d3e176f79ad9@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18beb213335dd544.57cdc20d9a554be2.724d3e176f79ad9@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/3/26 08:58, Ryosuke Yasuoka wrote:
> 
> 
> On 02/07/2026 14:26, Dmitry Osipenko wrote:
>> On 7/1/26 12:23, Ryosuke Yasuoka wrote:
>>>
>>>
>>> On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>>> Hi,
>>>>
>>>> On 6/30/26 12:16, Ryosuke Yasuoka wrote:
>>>>> A probe-time deadlock can occur between the dequeue worker and
>>>>> drm_client_register(). During probe, drm_client_register() holds
>>>>> clientlist_mutex and calls the fbdev hotplug callback, which triggers an
>>>>> atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
>>>>> waiting for virtqueue space. The dequeue worker that would free that
>>>>> space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
>>>>> drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
>>>>> to acquire the same clientlist_mutex. Since wake_up() is only called
>>>>> after the resp_cb loop, the probe thread is never woken and both threads
>>>>> deadlock.
>>>>>
>>>>> Fix this by deferring the hotplug notification from
>>>>> virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
>>>>> display data (outputs[i].info) is still updated synchronously in the
>>>>> callback, and the deferred work only triggers a re-probe notification to
>>>>> DRM clients.
>>>>>
>>>>> Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
>>>>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>>>>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>>>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>>>> ---
>>>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
>>>>>  drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
>>>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
>>>>>  3 files changed, 16 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>> index 7449907754a4..27ffa4697ae9 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>> @@ -264,6 +264,8 @@ struct virtio_gpu_device {
>>>>>  
>>>>>  	struct work_struct config_changed_work;
>>>>>  
>>>>> +	struct work_struct hotplug_work;
>>>>> +
>>>>>  	struct work_struct obj_free_work;
>>>>>  	spinlock_t obj_free_lock;
>>>>>  	struct list_head obj_free_list;
>>>>> @@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>>>>>  					uint32_t x, uint32_t y,
>>>>>  					struct virtio_gpu_object_array *objs,
>>>>>  					struct virtio_gpu_fence *fence);
>>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work);
>>>>>  void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
>>>>>  					 uint32_t resource_id,
>>>>>  					 uint32_t x, uint32_t y,
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>>> index cfde9f573df6..cfb532ba43a4 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
>>>>> @@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
>>>>>  	INIT_WORK(&vgdev->config_changed_work,
>>>>>  		  virtio_gpu_config_changed_work_func);
>>>>>  
>>>>> +	INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
>>>>> +
>>>>>  	INIT_WORK(&vgdev->obj_free_work,
>>>>>  		  virtio_gpu_array_put_free_work);
>>>>>  	INIT_LIST_HEAD(&vgdev->obj_free_list);
>>>>> @@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>>>>>  	flush_work(&vgdev->obj_free_work);
>>>>>  	flush_work(&vgdev->ctrlq.dequeue_work);
>>>>>  	flush_work(&vgdev->cursorq.dequeue_work);
>>>>> +	flush_work(&vgdev->hotplug_work);
>>>>>  	flush_work(&vgdev->config_changed_work);
>>>>>  	virtio_reset_device(vgdev->vdev);
>>>>>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>> index 67865810a2e7..084d98f5dc7b 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>> @@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct virtio_gpu_device *vgdev,
>>>>>  	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
>>>>>  }
>>>>>  
>>>>> +void virtio_gpu_hotplug_work_func(struct work_struct *work)
>>>>> +{
>>>>> +	struct virtio_gpu_device *vgdev =
>>>>> +		container_of(work, struct virtio_gpu_device, hotplug_work);
>>>>> +
>>>>> +	if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>>> +		drm_kms_helper_hotplug_event(vgdev->ddev);
>>>>> +}
>>>>> +
>>>>>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>>>>>  					       struct virtio_gpu_vbuffer *vbuf)
>>>>>  {
>>>>> @@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
>>>>>  	spin_unlock(&vgdev->display_info_lock);
>>>>>  	wake_up(&vgdev->resp_wq);
>>>>>  
>>>>> -	if (!drm_helper_hpd_irq_event(vgdev->ddev))
>>>>> -		drm_kms_helper_hotplug_event(vgdev->ddev);
>>>>> +	schedule_work(&vgdev->hotplug_work);
>>>>>  }
>>>>>  
>>>>>  static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,
>>>>
>>>
>>> Hi,
>>> Thank you for your review.
>>>
>>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(), placing it after wait_event_timeout(display_info_pending)? This will avoid additional work_struct that otherwise needs to be cancelled in virtio_gpu_init() on the timeout.
>>>
>>> IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>> into virtio_gpu_init() after wait_event_timeout() would not prevent the
>>> issue.
>>>
>>> Looking at the syzbot call traces[1][2], the deadlock occurs during
>>> drm_client_setup(), which runs after virtio_gpu_init() has already
>>> returned. The display_info_cb that triggers the deadlock is called from
>>> the dequeue worker while drm_client_register() holds clientlist_mutex.
>>>
>>> Thread A:
>>> virtio_gpu_probe()
>>>  -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>>
>> You mean that the timeout happens and it's again syzkaller report for a
>> broken host. A day ago I applied [1] that should fix this "bogus"
>> syzkaller report.
>>
>> [1] https://patchwork.freedesktop.org/patch/735301/
> 
> Thank you for [1] and the clarificaiton. I agree that [1] addresses the
> broken host scenario where virtio_gpu_init() times out and probe
> continues with a pending display_info response. I think there is another
> scenario causing the same deadlock reported by syzbot and my patch
> addresses both cases.
> 
> The deadlock can also occur with the following scenario:
> after virtio_gpu_init() completes successfully (wait_event_timeout
> returns), if a config_changed event arrives before drm_client_setup()
> completes, config_changed_work_func() sends a new GET_DISPLAY_INFO. Its
> display_info_cb fires in the dequeue worker and blocks on
> clientlist_mutex held by drm_client_register(). This is the same
> deadlock path reported by syzbot.
> 
> Since [1] only prevents the timeout case, I believe the schedule_work()
> approach is still needed to prevent display_info_cb from blocking on
> clientlist_mutex in the dequeue worker context, regardless of the
> trigger.

The config_changed_work_func() already invokes
drm_helper_hpd_irq_event() by itself [1].

[1]
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/virtio/virtgpu_kms.c#L52

The drm_helper_hpd_irq_event() itself calls
drm_kms_helper_hotplug_event() [2].

[2]
https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/drm_probe_helper.c#L1113

Isn't drm_helper_hpd_irq_event() call done by
virtio_gpu_cmd_get_display_info_cb() already partially redundant? I.e.
only it's needed by virtio_gpu_init() and not by
config_changed_work_func(). And then we can move
drm_helper_hpd_irq_event() to virtio_gpu_init():

```
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c
b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 922782bdc9cd..9805283683c1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -303,6 +303,7 @@ int virtio_gpu_init(struct virtio_device *vdev,
struct drm_device *dev)
                virtio_gpu_notify(vgdev);
                wait_event_timeout(vgdev->resp_wq,
!vgdev->display_info_pending,
                                   5 * HZ);
+               drm_helper_hpd_irq_event(vgdev->ddev);
        }

        vgdev->pm_nb.notifier_call = virtio_gpu_pm_notifier;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c
b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 68d097ad9d1d..aa6440a9b81e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -880,9 +880,6 @@ static void
virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
        vgdev->display_info_pending = false;
        spin_unlock(&vgdev->display_info_lock);
        wake_up(&vgdev->resp_wq);
-
-       if (!drm_helper_hpd_irq_event(vgdev->ddev))
-               drm_kms_helper_hotplug_event(vgdev->ddev);
 }

 static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device
*vgdev,
```

Isn't it a bug that config_changed_work_func() doesn't wait for
display_info_pending event?


```
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c
b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 922782bdc9cd..dd2d5c896c39 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -50,6 +50,8 @@ static void virtio_gpu_config_changed_work_func(struct
work_struct *work)
                                virtio_gpu_cmd_get_edids(vgdev);
                        virtio_gpu_cmd_get_display_info(vgdev);
                        virtio_gpu_notify(vgdev);
+                       wait_event_timeout(vgdev->resp_wq,
!vgdev->display_info_pending,
+                                          5 * HZ);
                        drm_helper_hpd_irq_event(vgdev->ddev);
                }
                events_clear |= VIRTIO_GPU_EVENT_DISPLAY;

```

-- 
Best regards,
Dmitry
