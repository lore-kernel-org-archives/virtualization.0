Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999DCA4E
	for <virtualization@lists.linux.dev>; Thu, 28 May 2026 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779941908; cv=pass; b=BKanfHLn7yk1HBZ1pcxHLeYn20l51FMpyp27Itcj5lVoRJudLMPpzg0fwwfCniMRt5IRfSL1rYVSgBteGJp0GOhl4/2qtQP8ZHm58EmWOTb278XcudAz8YiLL84Bxlmt8sPBg8bJ88fKKEIDYTuCTnrpscXjAea5rYnOB5uDugc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779941908; c=relaxed/simple;
	bh=n5MONX/LjWXxfKF+9OG5n9D35bKsWP2UD/miqlSUADk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XTXAiuKDrSZ7GMJB/ypkLMu65PrZ/NMXo1SQL48plb9qM8mpPA5ZmacgMFTDm+2THP7YPqpTOFCR63M3ZKPMul6tZtGwiuvDCWas77N49NOFx9DZy6x/h/cX11svoaLbQ3u8Zu94fP8CKipQ4/N17yLjC2GMJJ3fgzUB1nu8KEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Xq44ZgXD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Xq44ZgXD"
ARC-Seal: i=1; a=rsa-sha256; t=1779941899; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sc+mORCUgAvGazUVYLDJeMUMDw6upf4YXvSa879GXGHyEQIruuykY4ZrpRAM7TQxWtx9HB2oIyaMV04ze8r/bJi4U1E9CTBozi7b2zo4QVKOzjCPwm/ChFfg423W4xfY14TVGey4HBZnbESZlRr3HWJvs0Ak/KtgI7MwSH+si4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779941899; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8o1XLSa5F/j62VrWfLWilpe1LiNSehmG9D20djbFbCU=; 
	b=Nrp6gQY9sOLy2/u+S0YNCdNNKoyVDFSYEZrxtYpqEhJDRZa+gUIaNDZYDp6gqBeF0SgQOwcxMCpUMfR+lXER82lnUfsef4qNJfFgX16Jtx8WpiaJ3oAodg04V9282ytx7b1d8DsEi43xWUmJAojTGBA1SPaiTsXkJ/eIZV185lw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779941898;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8o1XLSa5F/j62VrWfLWilpe1LiNSehmG9D20djbFbCU=;
	b=Xq44ZgXDo/kRUl/B3V2oBtmllM6wCwtAklzvxHwSUZsZumJvM7wCYJVAneAqGPcE
	Gsit15XMb/VyV+5TcYJTDsam9YuX5B/CUW3FSPaFkwGSetlMA28veT8kjkM4MBYGe8A
	TMXjQFc5gvJNe2gZcpF7XRRUl1wwmKVFiiRLYqKU=
Received: by mx.zohomail.com with SMTPS id 1779941897157316.1392316428663;
	Wed, 27 May 2026 21:18:17 -0700 (PDT)
Message-ID: <e6b414a1-db9e-45a1-9cb8-e9459c028f6f@collabora.com>
Date: Thu, 28 May 2026 07:18:12 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <18b1d7267ace8b76.329809b8dd1e13b3.4134c0f069791aa6@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
 <f684508b-ec0e-4e71-80be-95ae874d8e85@collabora.com>
Content-Language: en-US
In-Reply-To: <f684508b-ec0e-4e71-80be-95ae874d8e85@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/26/26 13:24, Dmitry Osipenko wrote:
> On 5/22/26 11:51, Ryosuke Yasuoka wrote:
>> Hi Dmitry,
>> Thank you for your review and the comment.
>>
>> On 21/05/2026 22:01, Dmitry Osipenko wrote:
>>> 21.05.2026 05:19, Ryosuke Yasuoka пишет:
>>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>>> wait_event() without any abort condition when waiting for virtqueue
>>>> space. If the host device stops processing commands, these waits block
>>>> indefinitely inside a drm_dev_enter/exit() critical section. Since
>>>> drm_dev_unplug(), which is called in device removal and system shutdown
>>>> call path, blocks on synchronize_srcu() until all critical sections
>>>> complete, device removal and system shutdown also hang.
>>>>
>>>> Add a vqs_released flag to virtio_gpu_device and include it in the
>>>> wait_event() condition. Set the flag and wake up both queues in a new
>>>> virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
>>>> virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
>>>> wait returns immediately and the command is aborted, following the same
>>>> cleanup path as drm_dev_enter() failure.
>>>>
>>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>>> ---
>>>> Changes in v2:
>>>> - Update the commit message.
>>>> - Replace wait_event_timeout() with wait_event() using a compound
>>>> condition that includes a new vqs_released flag.
>>>> - Add virtio_gpu_release_vqs() helper to set the flag and wake up
>>>> both queues, called before drm_dev_unplug() in remove and shutdown
>>>> paths.
>>>> - Remove the hardcoded 5-second timeout. Recovery is now driven by
>>>> the driver flag instead of an arbitrary timeout value.
>>>> ---
>>>>  drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
>>>>  drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
>>>>  drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
>>>>  3 files changed, 37 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> index a5ce96fb8a1d..e4fe5e0780f9 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
>>>> @@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Release pending virtqueue waits so the drm_dev_enter/exit() critical
>>>> + * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
>>>> + */
>>>> +static void virtio_gpu_release_vqs(struct drm_device *dev)
>>>> +{
>>>> +	struct virtio_gpu_device *vgdev = dev->dev_private;
>>>> +
>>>> +	vgdev->vqs_released = true;
>>>> +	wake_up_all(&vgdev->ctrlq.ack_queue);
>>>> +	wake_up_all(&vgdev->cursorq.ack_queue);
>>>> +}
>>>> +
>>>>  static void virtio_gpu_remove(struct virtio_device *vdev)
>>>>  {
>>>>  	struct drm_device *dev = vdev->priv;
>>>>  
>>>> +	virtio_gpu_release_vqs(dev);
>>>>  	drm_dev_unplug(dev);
>>>>  	drm_atomic_helper_shutdown(dev);
>>>>  	virtio_gpu_deinit(dev);
>>>> @@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
>>>>  {
>>>>  	struct drm_device *dev = vdev->priv;
>>>>  
>>>> +	virtio_gpu_release_vqs(dev);
>>>>  	/* stop talking to the device */
>>>>  	drm_dev_unplug(dev);
>>>>  }
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>> index f17660a71a3e..0bd69a40857e 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
>>>> @@ -235,6 +235,7 @@ struct virtio_gpu_device {
>>>>  
>>>>  	struct virtio_gpu_queue ctrlq;
>>>>  	struct virtio_gpu_queue cursorq;
>>>> +	bool vqs_released;
>>>>  	struct kmem_cache *vbufs;
>>>>  
>>>>  	atomic_t pending_commands;
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>> index 67865810a2e7..8057a9b7356d 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>>>> @@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>>>>  	if (vq->num_free < elemcnt) {
>>>>  		spin_unlock(&vgdev->ctrlq.qlock);
>>>>  		virtio_gpu_notify(vgdev);
>>>> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
>>>> +		wait_event(vgdev->ctrlq.ack_queue,
>>>> +			   vq->num_free >= elemcnt || vgdev->vqs_released);
>>>> +		/*
>>>> +		 * Set by virtio_gpu_release_vqs() to unblock
>>>> +		 * synchronize_srcu() wait in drm_dev_unplug().
>>>> +		 */
>>>> +		if (vgdev->vqs_released) {
>>>> +			if (fence && vbuf->objs)
>>>> +				virtio_gpu_array_unlock_resv(vbuf->objs);
>>>> +			free_vbuf(vgdev, vbuf);
>>>> +			drm_dev_exit(idx);
>>>> +			return -ENODEV;
>>>> +		}
>>>>  		goto again;
>>>>  	}
>>>>  
>>>> @@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>>>>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>>>  	if (ret == -ENOSPC) {
>>>>  		spin_unlock(&vgdev->cursorq.qlock);
>>>> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>>>> +		wait_event(vgdev->cursorq.ack_queue,
>>>> +			   vq->num_free >= outcnt || vgdev->vqs_released);
>>>> +		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
>>>> +		if (vgdev->vqs_released) {
>>>> +			free_vbuf(vgdev, vbuf);
>>>> +			drm_dev_exit(idx);
>>>> +			return;
>>>> +		}
>>>>  		spin_lock(&vgdev->cursorq.qlock);
>>>>  		goto retry;
>>>>  	} else {
>>>
>>> What about other wait_event in the driver? Why only these?
>>
>> There are other wait_event() calls on vgdev->resp_wq in virtgpu_prime.c
>> and virtgpu_vram.c. These can also cause a stuck process when the host
>> device stops or does not respond and should be fixed. However, they are
>> not related to the issue being fixed here. I think they should be
>> addressed in a separate commit.
>>
>> The wait_event(vgdev->resp_wq) calls wait for a host response, not for
>> virtqueue ring space. They are not inside a drm_dev_enter/exit()
>> critical section, so they don't block drm_dev_unplug() ->
>> synchronize_srcu() and are not part of the deadlock reported by syzbot.
>>
>> However, if a process is stuck in wait_event(vgdev->resp_wq), there is
>> no way to recover other than host device recovery itself. We can still
>> remove the device and destroy the virtqueues while the process is stuck,
>> so the host response can never arrive. IIUC, the stuck thread holds a
>> drm_device reference, preventing vgdev from being freed; this is a
>> resource leak.
>>
>> This can be fixed by adding a wake_up_all() and a vqs_released check
>> similar to what is done for ctrlq/cursorq. However, I think this should
>> be a separate commit since the root cause and problem are different.
>>
>> Alternatively, the resp_wq wait_event() calls could be converted to
>> wait_event_interruptible() to fix the issue. But as you mentioned
>> earlier in the v1 comment, we need the wait_event_interruptible()
>> rework.
>>
>> What do you think? Should I include the resp_wq fix as a separate commit
>> in this patch series, or leave it for the _interruptible() rework?
> 
> Let's leave it for the later rework.
> 
> I briefly tried testing this patch and it's not apparent what exact
> problem this patch solves.
> 
> With a regular Linux OS running systemd, during normal shutdown, systemd
> waits for processes to be terminated before it would perform kernel
> shutdown, hence virtio_gpu_shutdown() doesn't have a chance to be
> invoked in my scenario.
> 
> In the referenced syzkaller reports, I don't see anything related to
> shutdown or driver removal. Could you please clarify how to reproduce
> and test the original issue?
To make it more clear, the patch looks okay, but I'm not convinced that
it fixes the reported issue. We likely need a full solution with
handling interrupt signals, using a reasonable timeout and etc for all
wake_event().

-- 
Best regards,
Dmitry
