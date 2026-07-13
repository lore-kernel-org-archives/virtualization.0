Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03169437467
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953319; cv=pass; b=LkaDtQ6MdugGBPTLkEYXz6UYT5y/jrCB21RHVCruScroGlEb+7GEInjtUo5t3VKir7HZVdAce32xjzwteMwbdXD6KI2+8TkK9QDGWsE1AKcgxUct+Yj6ccS5kWrlK78Dii9VbLBmkXDxYkZQE/ae5CmGohVBNWiDvHZFcX0C3iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953319; c=relaxed/simple;
	bh=Fkim6C5ofoGrO2AlpvAXTsoLQpFE8yvDGzEzRjEn0r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+CrLPbjI+JbD0zMhKFMZkmGgkIDms14kjnaWVRkCk0H2MdgxOcgFcIhQ3C0Ucq8nXQS9LwCr/y0s3HJsTkVMG+CR9i+l+bV6OGWjEOsyAaRlVni59stn6ZTSonmigtvWlCWcjabR/4kluYQ7vkfBJwn98UbUIPewe2iSNawYNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=RwiSmt3s; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="RwiSmt3s"
ARC-Seal: i=1; a=rsa-sha256; t=1783953305; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dtfwBb+KkqOk5LpS2l9XlY3Isr1cxSe4dyVL5LXR69Z6z6hzhLsQ+m6Y07qIuIS17sSwr/D1yxn8TWV+QxTy+IEpOglvePnj0u4uFfbxnFlGvGP47m7Zh8XlFdGD16tH+rePIikamDkj4VIfT8R2rq6qJTDeJR326ZA2cEPI4NY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783953305; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Vt1ZxcDLSY0cCHvqeRxZcHXVOfGIWEo70HQ03fVvYCk=; 
	b=AZGK5fCQYa6tk1H3Pvcm2xHvlkrhJVTPa6lPPkmtVxgW7BF3flDk03kkiXBIhXGeUtMRAEUQ31Ob3E6R+nWqHpSdHGCOOE78jDhBVuGdCgJCAYu95nz6y2JMJQGRUV6kyD/qc73/yGJZc1h/ZD6pvxUOUx/BlX8newOkg7nomNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783953305;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Vt1ZxcDLSY0cCHvqeRxZcHXVOfGIWEo70HQ03fVvYCk=;
	b=RwiSmt3sorWaCVeer9aJuDH1LQXVyb8VzjGjVaZRnlvjljD7nuGEpWPmc0eghmr6
	lmq2S6EmbamoRtgkK5hOhDRw19S2OOCZ8KX/fO1/q7FhSxsBAvdb2IgxcxoxW67tRHD
	hNpOiW12cxCm3iFze3vOjlv1rxrFCwCsOx1ELd4g=
Received: by mx.zohomail.com with SMTPS id 1783953303349476.0443516936738;
	Mon, 13 Jul 2026 07:35:03 -0700 (PDT)
Message-ID: <17764937-21dc-4b4a-8def-e738b361bcd1@collabora.com>
Date: Mon, 13 Jul 2026 17:34:56 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/virtio: honor blob_alignment requirements
To: Alyssa Ross <hi@alyssa.is>, Sergio Lopez <slp@redhat.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergi Blanch Torne
 <sergi@collabora.com>, Valentine Burley <valentine.burley@collabora.com>
Cc: Chia-I Wu <olvaffe@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20260428194450.518296-1-slp@redhat.com>
 <20260428194450.518296-3-slp@redhat.com> <akT1XEW766c7Imst@mbp.qyliss.net>
 <c8bf0c19-316a-442e-a63e-1b52e7bb67c2@collabora.com>
 <87v7ajyw5j.fsf@alyssa.is>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87v7ajyw5j.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/13/26 14:19, Alyssa Ross wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 7/1/26 14:10, Alyssa Ross wrote:
>>> On Tue, Apr 28, 2026 at 09:44:49PM +0200, Sergio Lopez wrote:
>>>> If VIRTIO_GPU_F_BLOB_ALIGNMENT has been negotiated, blob size must be
>>>> aligned to blob_alignment. Validate this in verify_blob() so that
>>>> invalid requests are rejected early.
>>>>
>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>>>
>>> FYI: this change breaks crosvm, which is squatting the 5 and 6 values
>>> of VIRTIO_GPU_F_* with different meanings.  I've reported it as a
>>> crosvm bug, so hopefully it can be taken care of there.
>>>
>>> https://issuetracker.google.com/issues/529852979
>>>
>>>> ---
>>>>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> index c33c057365f8..d0c4edf1eaf4 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> @@ -489,6 +489,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>>>>  	params->size = rc_blob->size;
>>>>  	params->blob = true;
>>>>  	params->blob_flags = rc_blob->blob_flags;
>>>> +
>>>> +	if (vgdev->has_blob_alignment &&
>>>> +	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>>> +		return -EINVAL;
>>>> +
>>>>  	return 0;
>>>>  }
>>>>
>>>> --
>>>> 2.53.0
>>>>
>>
>> Thanks for the report. Indeed, crosvm will need to fix its experimental
>> caps. CI will likely run into this problem first once it will update
>> guest to 7.2+ kernel.
> 
> I sent
> https://chromium-review.googlesource.com/c/crosvm/crosvm/+/8064741 last
> week but still waiting to hear anything.  Do you have any insight into
> whether it's still used / being pursued?

The GUEST_HANDLE should be used by Android [1]. The FENCE_PASSING
shouldn't be used in production, though don't know for sure.

Crosvm should bump its experimental defines by +10 to prevent clash with
upstream in future.

[1]
https://github.com/google/gfxstream/blob/main/host/vulkan/vk_decoder_global_state.cpp#L107

-- 
Best regards,
Dmitry
