Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B630C15E
	for <virtualization@lists.linux.dev>; Thu, 28 May 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957428; cv=none; b=WG9TMF2Kd6hLzQ2T5fROXTYhp3obLYZGvRyfTwldi1R3B17+g6B6X50QwySQ8jXRiUjjYM0/hq/3kTLn/26P71l10AqellZUkv8Fc6ac5qC76EtCdeEpmvh09cidAdapOknMo7NQ6TOBIicZcwkan8FEBaiCrtQOpEIy8syVUaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957428; c=relaxed/simple;
	bh=m8LHrP3TCb0t/n0xfihT0s0aJSokXly2qglYwfxf6Sg=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=oGT1pyQxXFLgoQJNN8m4zGvE7Nns9amX1s3PP5dXTGwoD2lYetJTNXR1k7RhpFTUW1Ot3gq1vDlRtxkDs1+YnQ7B+nQgPJ7HvIyMm3hXU8HXEomMGCwrqXpzg/b+5nVXLn5lSMhkg/O6Uv/4wK2LXOEQeWknHeD/7aA4QUw9h0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIxPzLb5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIxPzLb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779957424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=PC98DFJJYj6pMUAqlbj9jwtGyGpOgv8qE/aIsYksKhk=;
	b=EIxPzLb5eTp6CKw4cp4b2NapoMMNKPineREo0GWcDji7Pew2oChqlDyI5mI35YkHb5B1EQ
	doet77o8spaExS+YDLYFlF8FOi+jTpXQtmvgGy3JQF5giC8Id3goJyXCPxoWqGkYacouZU
	t34yeheXd0dRTKw5zUVnuIZnkpVRT+A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-llkSH3y_Mr-2TFU6pf_CfA-1; Thu, 28 May 2026 04:37:03 -0400
X-MC-Unique: llkSH3y_Mr-2TFU6pf_CfA-1
X-Mimecast-MFC-AGG-ID: llkSH3y_Mr-2TFU6pf_CfA_1779957422
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36781927b4dso6514809a91.0
        for <virtualization@lists.linux.dev>; Thu, 28 May 2026 01:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779957422; x=1780562222;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oq+lTIk+CoM6LUDz2MyWeM9Dcf8keMMkzhCBCnXUco4=;
        b=Wd4LI9KFOZjB0TD5h/w09pYh3UXqPq0yiZkQCWDOXu6g9cNgTPGzhfAH4ppR3W2HXF
         ElF58eWUzC5oagr+ggBkFSK29YE7x6OrM/0VDisdHA6qBXuXMOipDMUvJyMTVAq2S8g0
         i1bqGwi2fr8dRy94Ri8s9ir1kywCDZOI8neYSciwjEY1o5xtaehQpQQN7zQ0pSuyjQVf
         +IdLmpHB06G5yU2f2PHSjshHo+rrwfWfpJtdh6S7PRjjQ3EQ0j/CL6nfimNtjrWkWyog
         WC4rHbbc9cPrLsHlI2fRmFHdqlxHe9Mowe0xkfYovWV/ZpuGVM4X7oIN1lej+wfYBqQ7
         U7YA==
X-Forwarded-Encrypted: i=1; AFNElJ80UxNdI1t6rZ3DBTIwX/5u7gsgXceVcdjburoq76jDGFyNCjuG99kopcuEIHfa3tdTkJxQVIBFAhv1jci/0w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5j0hH37Ij5RuwQ5QtyCd2BA69alifWI8VZgUn61tcRGUb/VpX
	rxfH4YfY5ijMZopdgZ5CGDJeg4hHdDKAHg6ctnSlcrc2wxcQ7neQWPLZADL2h7szRVUahGsm+NX
	RmxAKok2UWgUt9911J+ZrIJstRnSBrJiPlWG3nKVYHpOghpYLaARfplsl3wX1nJir+IYp
X-Gm-Gg: Acq92OGiWXi45BRU7RZeHLlon2/mqgIZtgcFXOVmr5MYY0MSa4ukGsvUAkA2H9EjVAt
	iH+j+WX58eUZgaTYsfj2Q5N+B0SC6gePTUdeVv50E3Ebzcm/OT1PDaXWLfcMvDdFprsTgCMdARV
	B2VyZnblzY+8tGmNov0tyOR03GQvTsgKQuiHVU1QqAJGZCl2AjWGo6UOjdojUfXayY2/g89ibDn
	ojiIngggXP5oSGNaGw/YQied+MNFHGQqBmz5cuN+yj5fu+lnz9YxzjuZcgETgKDtW2zOK5GkSiW
	tIY3CNHOIjVrIvj+EFaTk+M2qO+3zMl1Js0d7qp264OKAqI+DDz+1uou3jB8Ev2i+e3+y+RUV7Q
	V5Ah/v0ZQs2GnRGmZGoKOCrF5sFXbTMXq6UuB0hvybNVnoHTaAVnCSIM6i/dF0VrJbdT6sw==
X-Received: by 2002:a17:90b:3d4c:b0:36b:293:68d1 with SMTP id 98e67ed59e1d1-36b02937336mr11428203a91.16.1779957421959;
        Thu, 28 May 2026 01:37:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4c:b0:36b:293:68d1 with SMTP id 98e67ed59e1d1-36b02937336mr11428160a91.16.1779957421341;
        Thu, 28 May 2026 01:37:01 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90900f36sm1014431a91.5.2026.05.28.01.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 01:37:00 -0700 (PDT)
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
In-Reply-To: <e6b414a1-db9e-45a1-9cb8-e9459c028f6f@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
	 avoid hung task
Message-ID: <18b3add6b57b04df.b301120b59b2db5f.d33efc07a092f2a2@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Thu, 28 May 2026 08:36:55 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y4R5gcfQ-MfYH9V80qrCiCCpAM62fAWzjDDqa4erqSE_1779957422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Dmitry,
Thank you for the detailed review and follow-up.

On 28/05/2026 07:18, Dmitry Osipenko wrote:
> On 5/26/26 13:24, Dmitry Osipenko wrote:
>> On 5/22/26 11:51, Ryosuke Yasuoka wrote:
>>> Hi Dmitry,
>>> Thank you for your review and the comment.
>>>
>>> On 21/05/2026 22:01, Dmitry Osipenko wrote:
>>>> 21.05.2026 05:19, Ryosuke Yasuoka =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>>>> wait_event() without any abort condition when waiting for virtqueue
>>>>> space. If the host device stops processing commands, these waits bloc=
k
>>>>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>>>>> drm_dev_unplug(), which is called in device removal and system shutdo=
wn
>>>>> call path, blocks on synchronize_srcu() until all critical sections
>>>>> complete, device removal and system shutdown also hang.
>>>>>
>>>>> Add a vqs_released flag to virtio_gpu_device and include it in the
>>>>> wait_event() condition. Set the flag and wake up both queues in a new
>>>>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in bo=
th
>>>>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, =
the
>>>>> wait returns immediately and the command is aborted, following the sa=
me
>>>>> cleanup path as drm_dev_enter() failure.
>>>>>
>>>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkalle=
r.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406=
e45c1c6e549453f224
>>>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkalle=
r.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4c=
f7baf376cc873a922e
>>>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Update the commit message.
>>>>> - Replace wait_event_timeout() with wait_event() using a compound
>>>>> condition that includes a new vqs_released flag.
>>>>> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
>>>>> both queues, called before drm_dev_unplug() in remove and shutdown
>>>>> paths.
>>>>> - Remove the hardcoded 5-second timeout. Recovery is now driven by
>>>>> the driver flag instead of an arbitrary timeout value.
>>>>> ---
>>>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>>>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>>>>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/v=
irtio/virtgpu_drv.c
>>>>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_devic=
e *vdev)
>>>>>  =09return ret;
>>>>>  }
>>>>> =20
>>>>> +/*
>>>>> + * Release pending virtqueue waits so the drm_dev_enter/exit() criti=
cal
>>>>> + * sections complete before drm_dev_unplug() blocks on synchronize_s=
rcu().
>>>>> + */
>>>>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>>>>> +{
>>>>> +=09struct virtio_gpu_device *vgdev =3D dev->dev_private;
>>>>> +
>>>>> +=09vgdev->vqs_released =3D true;
>>>>> +=09wake_up_all(&vgdev->ctrlq.ack_queue);
>>>>> +=09wake_up_all(&vgdev->cursorq.ack_queue);
>>>>> +}
>>>>> +
>>>>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>>>>  {
>>>>>  =09struct drm_device *dev =3D vdev->priv;
>>>>> =20
>>>>> +=09virtio_gpu_release_vqs(dev);
>>>>>  =09drm_dev_unplug(dev);
>>>>>  =09drm_atomic_helper_shutdown(dev);
>>>>>  =09virtio_gpu_deinit(dev);
>>>>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_dev=
ice *vdev)
>>>>>  {
>>>>>  =09struct drm_device *dev =3D vdev->priv;
>>>>> =20
>>>>> +=09virtio_gpu_release_vqs(dev);
>>>>>  =09/* stop talking to the device */
>>>>>  =09drm_dev_unplug(dev);
>>>>>  }
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/v=
irtio/virtgpu_drv.h
>>>>> index f17660a71a3e..0bd69a40857e 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>>>>> =20
>>>>>  =09struct virtio_gpu_queue ctrlq;
>>>>>  =09struct virtio_gpu_queue cursorq;
>>>>> +=09bool vqs_released;
>>>>>  =09struct kmem_cache *vbufs;
>>>>> =20
>>>>>  =09atomic_t pending_commands;
>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/vi=
rtio/virtgpu_vq.c
>>>>> index 67865810a2e7..8057a9b7356d 100644
>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virt=
io_gpu_device *vgdev,
>>>>>  =09if (vq->num_free < elemcnt) {
>>>>>  =09=09spin_unlock(&vgdev->ctrlq.qlock);
>>>>>  =09=09virtio_gpu_notify(vgdev);
>>>>> -=09=09wait_event(vgdev->ctrlq.ack_queue, vq->num_free >=3D elemcnt);
>>>>> +=09=09wait_event(vgdev->ctrlq.ack_queue,
>>>>> +=09=09=09   vq->num_free >=3D elemcnt || vgdev->vqs_released);
>>>>> +=09=09/*
>>>>> +=09=09 * Set by virtio_gpu_release_vqs() to unblock
>>>>> +=09=09 * synchronize_srcu() wait in drm_dev_unplug().
>>>>> +=09=09 */
>>>>> +=09=09if (vgdev->vqs_released) {
>>>>> +=09=09=09if (fence && vbuf->objs)
>>>>> +=09=09=09=09virtio_gpu_array_unlock_resv(vbuf->objs);
>>>>> +=09=09=09free_vbuf(vgdev, vbuf);
>>>>> +=09=09=09drm_dev_exit(idx);
>>>>> +=09=09=09return -ENODEV;
>>>>> +=09=09}
>>>>>  =09=09goto again;
>>>>>  =09}
>>>>> =20
>>>>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virti=
o_gpu_device *vgdev,
>>>>>  =09ret =3D virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>>>>  =09if (ret =3D=3D -ENOSPC) {
>>>>>  =09=09spin_unlock(&vgdev->cursorq.qlock);
>>>>> -=09=09wait_event(vgdev->cursorq.ack_queue, vq->num_free >=3D outcnt)=
;
>>>>> +=09=09wait_event(vgdev->cursorq.ack_queue,
>>>>> +=09=09=09   vq->num_free >=3D outcnt || vgdev->vqs_released);
>>>>> +=09=09/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>>>>> +=09=09if (vgdev->vqs_released) {
>>>>> +=09=09=09free_vbuf(vgdev, vbuf);
>>>>> +=09=09=09drm_dev_exit(idx);
>>>>> +=09=09=09return;
>>>>> +=09=09}
>>>>>  =09=09spin_lock(&vgdev->cursorq.qlock);
>>>>>  =09=09goto retry;
>>>>>  =09} else {
>>>>
>>>> What about other wait_event in the driver? Why only these?
>>>
>>> There are other wait_event() calls on vgdev->resp_wq in virtgpu_prime.c
>>> and virtgpu_vram.c. These can also cause a stuck process when the host
>>> device stops or does not respond and should be fixed. However, they are
>>> not related to the issue being fixed here. I think they should be
>>> addressed in a separate commit.
>>>
>>> The wait_event(vgdev->resp_wq) calls wait for a host response, not for
>>> virtqueue ring space. They are not inside a drm_dev_enter/exit()
>>> critical section, so they don't block drm_dev_unplug() ->
>>> synchronize_srcu() and are not part of the deadlock reported by syzbot.
>>>
>>> However, if a process is stuck in wait_event(vgdev->resp_wq), there is
>>> no way to recover other than host device recovery itself. We can still
>>> remove the device and destroy the virtqueues while the process is stuck=
,
>>> so the host response can never arrive. IIUC, the stuck thread holds a
>>> drm_device reference, preventing vgdev from being freed; this is a
>>> resource leak.
>>>
>>> This can be fixed by adding a wake_up_all() and a vqs_released check
>>> similar to what is done for ctrlq/cursorq. However, I think this should
>>> be a separate commit since the root cause and problem are different.
>>>
>>> Alternatively, the resp_wq wait_event() calls could be converted to
>>> wait_event_interruptible() to fix the issue. But as you mentioned
>>> earlier in the v1 comment, we need the wait_event_interruptible()
>>> rework.
>>>
>>> What do you think? Should I include the resp_wq fix as a separate commi=
t
>>> in this patch series, or leave it for the _interruptible() rework?
>>=20
>> Let's leave it for the later rework.
>>=20
>> I briefly tried testing this patch and it's not apparent what exact
>> problem this patch solves.
>>=20
>> With a regular Linux OS running systemd, during normal shutdown, systemd
>> waits for processes to be terminated before it would perform kernel
>> shutdown, hence virtio_gpu_shutdown() doesn't have a chance to be
>> invoked in my scenario.
>>=20
>> In the referenced syzkaller reports, I don't see anything related to
>> shutdown or driver removal. Could you please clarify how to reproduce
>> and test the original issue?

You are right that the syzkaller reports show a different issue; a
probe-time lock ordering deadlock between clientlist_mutex and the
dequeue worker, not a device removal hang. I will drop the Reported-by
and Closes tags in the next revision.=20

Regarding reproduction: the scenario this patch fixes is as follows:

1. The host device stops processing virtqueue commands (host process
crash, resource exhaustion, or a hypervisor bug)
2. A guest GPU operation fills the virtqueue and blocks in wait_event()
inside virtio_gpu_queue_ctrl_sgs() or virtio_gpu_queue_cursor(),
within a drm_dev_enter/exit() critical section
3. Device removal or system shutdown calls virtio_gpu_remove() or
virtio_gpu_shutdown(), which call drm_dev_unplug()
4. drm_dev_unplug() blocks on synchronize_srcu() because the
drm_dev_enter/exit() critical section from step 2 never completes
5. Both the GPU operation and the removal/shutdown hang indefinitely
with no recovery path

Since wait_event() uses TASK_UNINTERRUPTIBLE, the blocked process
cannot be killed by signals during shutdown, so the hang persists even
after systemd's process cleanup phase.

This is difficult to reproduce because it depends on host-side failure.
In a normal QEMU/KVM environment the virtqueue is always serviced.

> To make it more clear, the patch looks okay, but I'm not convinced that
> it fixes the reported issue. We likely need a full solution with
> handling interrupt signals, using a reasonable timeout and etc for all
> wake_event().

I agree that a full solution with wait_event_interruptible() and proper
signal handling for all wait_event() calls is the right long-term
direction, and I am happy to work on that as a follow-up series.

However, converting to wait_event_interruptible() alone does not fully
solve the device removal case. The remove/shutdown path does not send
signals to waiting processes; it only calls drm_dev_unplug(). So even
with interruptible waits, the driver still needs a mechanism to
explicitly wake up waiters during teardown. The vqs_released flag in
this patch provides that mechanism, and remains necessary even after
the interruptible rework.

I will resubmit with updated tags and commit message, and work on the
syzkaller probe-time deadlock and the interruptible rework as follow-up
patches.

Best regards,
Ryosuke


