Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8F18050
	for <virtualization@lists.linux.dev>; Tue, 26 May 2026 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791096; cv=pass; b=FaLQrl7Qxanoy3GLSUZdmIVY7VobS/JR1WPjqcehLe2wfXaUSnyH4VItQPnScZC3z6UeeE47SVIu6BURFmJfHgPWCxi8EHrJQB0n3jhx3AssC/evgfM9yYL6Gw9TUq2kjbRfyvQqt5aM9E4GmM97+X1QDzHPpUcD+qVNI1MLNLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791096; c=relaxed/simple;
	bh=3dHMUEaeZ30gWLho9Ve4yTrv1Gm1MGlaG8PWIlIKOus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtAHovaWe2InFlOznDrZaU4CP5AI6QFdkXoeCQmfbvjjSWvb18/dlGn8i8NwicvVIQj8uMG82i1wucut9vM62MAIJGGwxKKDPpJgv6mmaIwQcZiEdGdj+QTi90oegPKDqjiJR0ufhwD+c39M91UdnzPYRJ36gRI3qjAESo0EiJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=VUlBoxOS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="VUlBoxOS"
ARC-Seal: i=1; a=rsa-sha256; t=1779791087; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NOlIH75qqa25JWfAzCjVhpwWxIA32hgCADvtVH+num61w0z6sTh82SHZIb1YIVYVH4kbfBQeF038k9l7PQFMv4Ot5CuV5I0DhWe/pzXqWij1DLxt5agML8W+T+cuv0hcCsb0dnya17bbYQZWKMCnByoxxNWSaZWtQ0aVxoTcTMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779791087; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TDVXsSWvApJd6i2RkpLsXQc7NgLFn0Lda0b1N9smog0=; 
	b=VJefMagrXWU6x9sFNy94uvQvpq5t6FoTrTAcUdSSjBOQNXoaaRdQrzmSCSFYB8WqM7m+FX+0JO/wcv0RV7jWczMYoB3SNIjVFdKDcJwRWpLXMqYfhTpFNn27Tjh13G7Xt3KZpqn0N8I7UklRxRcs7mOEgH0z4Xa+pRc5SHpSJ0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779791087;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TDVXsSWvApJd6i2RkpLsXQc7NgLFn0Lda0b1N9smog0=;
	b=VUlBoxOSF4MJy/oB1Obqy7TcIjq0Y+FstJUHYZNRfs3aP2Vj2AzB8Lb5epKfCDbN
	G+FMX+EY7jizlvwBFUFQYsmxyptjFyo8NvJ5EYAKWwbRQSMeMIpItBt3UzHVHgEKz0Q
	oCiBKbNNG2900ZRZ2xKhbOvm/XFWdlqKH7/IHLro=
Received: by mx.zohomail.com with SMTPS id 1779791085350818.9103831316124;
	Tue, 26 May 2026 03:24:45 -0700 (PDT)
Message-ID: <f684508b-ec0e-4e71-80be-95ae874d8e85@collabora.com>
Date: Tue, 26 May 2026 13:24:40 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <18b1d7267ace8b76.329809b8dd1e13b3.4134c0f069791aa6@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <18b1d7267ace8b76.329809b8dd1e13b3.4134c0f069791aa6@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/22/26 11:51, Ryosuke Yasuoka wrote:
> Hi Dmitry,
> Thank you for your review and the comment.
> 
> On 21/05/2026 22:01, Dmitry Osipenko wrote:
>> 21.05.2026 05:19, Ryosuke Yasuoka пишет:
>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>> wait_event() without any abort condition when waiting for virtqueue
>>> space. If the host device stops processing commands, these waits block
>>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>>> drm_dev_unplug(), which is called in device removal and system shutdown
>>> call path, blocks on synchronize_srcu() until all critical sections
>>> complete, device removal and system shutdown also hang.
>>>
>>> Add a vqs_released flag to virtio_gpu_device and include it in the
>>> wait_event() condition. Set the flag and wake up both queues in a new
>>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
>>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
>>> wait returns immediately and the command is aborted, following the same
>>> cleanup path as drm_dev_enter() failure.
>>>
>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
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
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>>>  	return ret;
>>>  }
>>>  
>>> +/*
>>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
>>> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
>>> + */
>>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>>> +{
>>> +	struct virtio_gpu_device *vgdev = dev->dev_private;
>>> +
>>> +	vgdev->vqs_released = true;
>>> +	wake_up_all(&vgdev->ctrlq.ack_queue);
>>> +	wake_up_all(&vgdev->cursorq.ack_queue);
>>> +}
>>> +
>>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>>  {
>>>  	struct drm_device *dev = vdev->priv;
>>>  
>>> +	virtio_gpu_release_vqs(dev);
>>>  	drm_dev_unplug(dev);
>>>  	drm_atomic_helper_shutdown(dev);
>>>  	virtio_gpu_deinit(dev);
>>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
>>>  {
>>>  	struct drm_device *dev = vdev->priv;
>>>  
>>> +	virtio_gpu_release_vqs(dev);
>>>  	/* stop talking to the device */
>>>  	drm_dev_unplug(dev);
>>>  }
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>> index f17660a71a3e..0bd69a40857e 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>>>  
>>>  	struct virtio_gpu_queue ctrlq;
>>>  	struct virtio_gpu_queue cursorq;
>>> +	bool vqs_released;
>>>  	struct kmem_cache *vbufs;
>>>  
>>>  	atomic_t pending_commands;
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>> index 67865810a2e7..8057a9b7356d 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>>>  	if (vq->num_free < elemcnt) {
>>>  		spin_unlock(&vgdev->ctrlq.qlock);
>>>  		virtio_gpu_notify(vgdev);
>>> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
>>> +		wait_event(vgdev->ctrlq.ack_queue,
>>> +			   vq->num_free >= elemcnt || vgdev->vqs_released);
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
>>>  
>>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>>>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>>  	if (ret == -ENOSPC) {
>>>  		spin_unlock(&vgdev->cursorq.qlock);
>>> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>>> +		wait_event(vgdev->cursorq.ack_queue,
>>> +			   vq->num_free >= outcnt || vgdev->vqs_released);
>>> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>>> +		if (vgdev->vqs_released) {
>>> +			free_vbuf(vgdev, vbuf);
>>> +			drm_dev_exit(idx);
>>> +			return;
>>> +		}
>>>  		spin_lock(&vgdev->cursorq.qlock);
>>>  		goto retry;
>>>  	} else {
>>
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

Let's leave it for the later rework.

I briefly tried testing this patch and it's not apparent what exact
problem this patch solves.

With a regular Linux OS running systemd, during normal shutdown, systemd
waits for processes to be terminated before it would perform kernel
shutdown, hence virtio_gpu_shutdown() doesn't have a chance to be
invoked in my scenario.

In the referenced syzkaller reports, I don't see anything related to
shutdown or driver removal. Could you please clarify how to reproduce
and test the original issue?

-- 
Best regards,
Dmitry
