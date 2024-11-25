Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24753291E
	for <virtualization@lists.linux.dev>; Mon, 25 Nov 2024 02:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501637; cv=pass; b=CW/0s0r10onaBZnYHS65cZSjfBGm0K9KkwlE9pIXaddsGiijTIjOb30NMT321GQFuGyvhxpzWz6xfTCfIqk/zUFMTybhxTCQ6VuiVUKF+6PKxFKIMUYYOsOrbAZWGV3vqJMzXCvlYKWo8x3XbfJSiq0VAIKStDJKCYiuEgSSVsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501637; c=relaxed/simple;
	bh=OsngzhzwuGgioRorZyPbkDs5oV3AqcAeX2CKASGQjZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lfvine81Pd824KdoIDtWVzKj9JcmK2C8u/a7ZVvG1G1FHAWE5RCVLI7y4ta4P2ze+uY7SA3lquRQ6trrhFICE+UVeiOgM2Duz8YYPZjRDTF+oNd2xpvWd7GT11l0TvSIiPIa+xVngacUFb/kW2lOE1XvgH4TkwzVhgOLZ0ajsV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=knt0YtML; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="knt0YtML"
ARC-Seal: i=1; a=rsa-sha256; t=1732501627; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fJpivCCVoYfEfffjpL5apbvH9/uGwDpZrfE1Z95icqqsOh3sr6NLOXUjbhMt0p49ceePTw9flsVshEQFGWCrELPHymLWtQxdrF+I4cf+lth90yT95jfUKUr5Rt6ciswQnfPqGjISGY5mMeHDTZDlr3x0JNtp0hRmzISOQejlvDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732501627; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2nk6VSWF+Iuc9RGMA/OqxVUYgtDe0wGGIq2xy5toCOw=; 
	b=ntHwh4YHAk+ltg6f7AAqWE6Kqrc1vmOb3DL3HODcHZGEJQ4EbONybNtZ3BOxXsrMVZYGejzfKQLSSEO/kZNsPPOLyimtXIRGG3GgeENOab+S130pg0uhOGD7R1UtfdaT+tsk7lxxtfgA/GIN1vXXHMDS/O2RAIdo/tsxGdLOJjg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732501627;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2nk6VSWF+Iuc9RGMA/OqxVUYgtDe0wGGIq2xy5toCOw=;
	b=knt0YtMLsB5Wn2ILz721uHiTxSOBY9AcO6z19mNZH6z96I8Gam24DpmYQVZCj+2Z
	2U5zS8UVv/kySLWBgyhGsuAUYtuz806P56cOgdg7ykW2rtLIuEQ6AkdXc2Fuw1GaiTM
	MSzqZ+3GNLB2gzAvCzrp6K55Qvata4cozwiXyKGQ=
Received: by mx.zohomail.com with SMTPS id 173250162485169.82787247272529;
	Sun, 24 Nov 2024 18:27:04 -0800 (PST)
Message-ID: <4ba9da71-535d-4579-907f-8ff2ccc505e5@collabora.com>
Date: Mon, 25 Nov 2024 05:27:00 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/virtio: Add drm_panic support
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241113084438.3283737-1-ryasuoka@redhat.com>
 <f31a8d1f-73d5-424e-ad09-2ae39712e230@collabora.com>
 <ec721548-0d47-4c40-9e9d-59f58e2181ae@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ec721548-0d47-4c40-9e9d-59f58e2181ae@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/19/24 13:21, Jocelyn Falempe wrote:
...
>> In the virtio_panic_flush() below,
>> virtio_gpu_panic_cmd_transfer_to_host_2d() is invoked only for dumb BOs.
>> Thus, only dumb BO supports panic output and should be accepted by
>> get_scanout_buffer(), other should be rejected with ENODEV here, AFAICT.
>> Correct?
> 
> Yes, it's correct

Please fix in v5.

...
>>> +struct virtio_gpu_panic_object_array {
>>> +    struct ww_acquire_ctx ticket;
>>> +    struct list_head next;
>>> +    u32 nents, total;
>>> +    struct drm_gem_object *objs;
>>> +};
>>
>> This virtio_gpu_panic_object_array struct is a hack, use
>> virtio_gpu_array_alloc(). Maybe add atomic variant of the array_alloc().
> 
> We can't allocate memory in the panic handler, but maybe it can be pre-
> allocated, like the virtio_panic_buffer ?

We certainly can allocate memory from any context using GFP_ATOMIC flag
for the allocation. You already doing that in
virtio_gpu_panic_queue_ctrl_sgs().

>>> +static void virtio_gpu_panic_put_vbuf(struct virtqueue *vq,
>>> +                      struct virtio_gpu_vbuffer *vbuf,
>>> +                      struct virtio_gpu_object_array *objs)
>>> +{
>>> +    unsigned int len;
>>> +    int i;
>>> +
>>> +    /* waiting vbuf to be used */
>>> +    for (i = 0; i < 500; i++) {
>>> +        if (vbuf == virtqueue_get_buf(vq, &len)) {
>>
>> Is it guaranteed that virtio_gpu_dequeue_ctrl_func() never runs in
>> parallel here?
> 
> Yes, in the panic handler, only one CPU remains active, and no other
> task can be scheduled.

Awesome. thanks for the clarification.

...
>>> +    ret = virtio_gpu_panic_resource_flush(plane, vbuf_resource_flush,
>>> +                          plane->state->src_x >> 16,
>>> +                          plane->state->src_y >> 16,
>>> +                          plane->state->src_w >> 16,
>>> +                          plane->state->src_h >> 16);
>>> +    if (ret) {
>>> +        virtio_gpu_panic_put_vbuf(vgdev->ctrlq.vq,
>>> +                      vbuf_dumb_bo,
>>> +                      (struct virtio_gpu_object_array *)&objs);
>>
>> The virtio_gpu_panic_notify() hasn't been invoked here, thus this
>> put_vbuf should always time out because vq hasn't been kicked. Again,
>> best to leak resources on error than to have broken/untested error
>> handling code paths.
> 
> agreed

Please change it in v5.

...
>> If there is more than one virtio-gpu display, then this panic buffer is
>> reused by other displays. It seems to work okay, but potential
>> implications are unclear. Won't it be more robust to have a panic buffer
>> per CRTC?
> 
> The drm panic handler call each plane sequentially, so it's not a
> problem. Having one buffer per CRTC would just add more complexity.

Please add a clarifying comment for that to the code.

-- 
Best regards,
Dmitry
