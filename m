Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BF3B8130;
	Wed, 24 Jun 2026 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314637; cv=none; b=FNGWF5UI8y1YxPSTaP3PI5J+eXtNHmiUjI8YaRdvpS5e+vWhi8tTbogneYlXyYJZ/bGUyXZZE0DtEmfNaGCX7n0OE1lqH9ArV358PpyN0hP/9a2LDBA/YrRPavlfLhSvcB58KCLbCw2DuSugjtDahgJwyXBOOQbK9ccYDj4DX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314637; c=relaxed/simple;
	bh=L5f4zah5SsB9Z/Ibk5W7PLtq1ziPevbzXRNl3ysXOsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAuQeMjIs53vjoYLN/KyHnXXWfNAO7I4/n/ZHu6tkwOvMk11gOfVprJQyaft59KVoxfBfiFeeyH+Jy/BokenyNKS1q+ROo41OUSCnmF/2Do7+lgUrY5QQ4M0bq9t5guRM65/1I5CSdsvvqhb8lG6GPpTNoLgz3dtNRssHPeeIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRQY7SOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRQY7SOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA671F000E9;
	Wed, 24 Jun 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782314636;
	bh=s0VwPTbT9N1RbL2lLSIyXAJGXxm+6tnXaT8HL4W+nXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JRQY7SOuwt7fxUxXPZ7RtJVdiwdtHCsBOM9q82ngHDza93b+FQrSnsjtOskH0aqaz
	 vNdbotTS3hO3hIgeMCx6AMnG1GEtGLhDkN45M4/Tzl38urOscQk9i1dULG1J/kX8NP
	 QgX7oCV8C0AoczpEdKUHndtfucYFv/ooEDVUNNmcCJzvGpH8h5+7SXzeXgPbcYrili
	 SheyDzjd1KO7nO6J9HDsxU3hLKncNk7Oa1N9xX1Q/194I/SnS74Cqrbu6ih31wi9vG
	 3G7L+CVFc3Ay1w9F8wWWFqw+JFxAhtmzldXh8/k+bLsI+rYVgHWttIoiPlonz0pCo6
	 TKST7wUv8ioCQ==
Message-ID: <76457610-bda4-4714-b888-2f45ad1a21b6@kernel.org>
Date: Wed, 24 Jun 2026 17:23:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] virtio_balloon: quiesce balloon work before device
 shutdown
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 mst@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260624140846.2616797-1-den@openvz.org>
 <20260624140846.2616797-4-den@openvz.org>
 <a1d78845-22e5-42ba-9a9e-ae22529969fc@kernel.org>
 <17b01bf9-13d2-4e61-a11a-0b91db2f2731@virtuozzo.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <17b01bf9-13d2-4e61-a11a-0b91db2f2731@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/26 17:00, Denis V. Lunev wrote:
> On 6/24/26 16:55, David Hildenbrand (Arm) wrote:
>> On 6/24/26 16:08, Denis V. Lunev wrote:
>>> Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
>>> device_shutdown()") added a generic virtio bus .shutdown handler that
>>> breaks and resets every virtio device during device_shutdown(), i.e. on
>>> reboot and kexec.
>>>
>>> virtio_balloon provides no .shutdown of its own, so that generic path
>>> runs while the balloon's asynchronous work is still armed. Once the
>>> device has been broken, virtqueue_add_inbuf() in
>>> virtballoon_free_page_report() returns -EIO and trips its
>>> WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
>>> ordinary reboot, for example a kexec based upgrade, into a fatal panic
>>> in the middle of device_shutdown(), so the machine never reaches the
>>> new kernel.
>>>
>>> Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
>>> inflate/deflate and OOM paths do not warn, they call
>>> wait_event(vb->acked, ...) and would instead block forever on a broken
>>> queue that can no longer complete. The device has to be quiesced, not
>>> just kept quiet.
>>>
>>> Add a .shutdown handler that quiesces the balloon via the shared
>>> virtballoon_quiesce() helper while the device is still alive, and only
>>> then breaks and resets it via virtio_device_shutdown(). Unlike
>>> virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
>>> does not free the device and cancel_work_sync() together with stop_update
>>> already prevent any further work from being queued.
>>>
>>> Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> ---
>>>  drivers/virtio/virtio_balloon.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>>> index 5b02d9191ac6..26fc3c40d5b2 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -1137,6 +1137,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
>>>  	kfree(vb);
>>>  }
>>>  
>>> +static void virtballoon_shutdown(struct virtio_device *vdev)
>>> +{
>>> +	virtballoon_quiesce(vdev->priv);
>>> +	virtio_device_shutdown(vdev);
>>> +}
>> I'm curious why virtio_gpu_shutdown() doesn't need that (did not look into the
>> details).
>>
>> Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
>>
> I would spend more time with other drivers once we will
> done with this. I have strong candidate - virtio-mem.

Heh, I briefly checked and it should handle it better I think.

If virtqueue_add_sgs() fails, it propagates the error (-EIO?) back to the main
loop where we end up in

switch (rc) {
	...
	default:
	/* Unknown error, mark as broken */
	dev_err(&vm->vdev->dev, ...
	vm->broken = true;
}

And just stop.

But I didn't actually look into the details.

-- 
Cheers,

David
