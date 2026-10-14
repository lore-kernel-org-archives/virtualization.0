Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF564A2A4A
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011760; cv=pass; b=bcsKZdiueaZ1Ns2hfPviEA2mJ9INCePTmw5PjUiD7Fk2PsMZu31W6bkCnpF1pPUp+Tnch2aLkbYsAu+8VgXkUpiQIh6jr5Hcv2rcxFM2Az4JWjdMFVJSymh5wZR4FWMPfsoihuomWDR/u5tmv5oBPfCRYtpZCL36TxVfPsO7NQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011760; c=relaxed/simple;
	bh=AggDeTcSQkCXzqrfyH77JXRMkSatFNE22kphl7JxcTs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uzpXpUevxgXgnUWqpQQqFbPtfYRa/kNUfb+oAG8bOTH43GiXyt0GUmGNwpOtXvWc3Zlz3IaF16QNuOkxYEHZ99lQXr0G7Gl9tWd6m/i+qjbTf0HSXuzkG8Iz14N5rmhDJ8N1+xqD80HfybJSVkINabkvCpWrJ5fVeRz22Ag3Hdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=OaRrc1zI; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="OaRrc1zI"
ARC-Seal: i=1; a=rsa-sha256; t=1792011745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lYNTdWVFF97u70Tf+c8K1WJGtLlOIlGREp542fs1/lpNV6J8H0Nnl+9CoM1euxl23t2H6dVaK/HYLtZqnphgOKWfds5jfBf07/upbU1tt022QzBX0crsz3d0PaYAP/cY8q2Gk8NU4SAkl+QeHyIXRXi75fDypjclVC8awix1N2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792011745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jhhvsN4ExcnX7pHhsI2wNoBnhSu5FDiZCbkI5WrCx0E=; 
	b=KU+e+WLUCdFHUbW8CsND02KOS7lr4zsdOuz8gVvl59MhjsIOcTi5FyBSW5QPWt0fOpaDMoDVEZRvMnfUMCdWxo0UHzWOfInSczC//0LJJfTV55OBam9KYdeo3y6UtRw1evUUzYwrR9FICFCsu+32KnRjFJImCYdnNsC+4SfwVkU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792011745;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jhhvsN4ExcnX7pHhsI2wNoBnhSu5FDiZCbkI5WrCx0E=;
	b=OaRrc1zIg+ciVXU1hI/IMhYHVVqSm24bV2mYeIjmvip6m84YOs9H6KhdvdFNW3Vm
	2DoU/QVfLSE+NTdEq/okYs4Fst8D4zTGu1wVH4dh2ZmWgocAoZuUbkaLXHeCKkC+kUE
	f5hfEBlhyXAm9Lezsom0Hd0bDtR5fLqMhGpmJrPI=
Received: by smtp.zohomail.com with SMTPS id 1792011743470340.1435335265422;
	Wed, 14 Oct 2026 14:02:23 -0700 (PDT)
Message-ID: <6c0f26af-e363-46b8-b3b9-8d3910297dc0@collabora.com>
Date: Thu, 15 Oct 2026 00:02:18 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Ryan Neph <ryanneph@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
 <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
 <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
 <f717bc84-57f4-4001-a15b-fcdca67bb9b4@collabora.com>
Content-Language: en-US
In-Reply-To: <f717bc84-57f4-4001-a15b-fcdca67bb9b4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/10/26 22:40, Dmitry Osipenko wrote:
> On 10/8/26 23:59, Val Packett wrote:
>>
>> On 10/8/26 4:33 AM, Dmitry Osipenko wrote:
>>> On 10/6/26 18:42, Val Packett wrote:
>>>> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
>>>> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
>>>> created under cross-domain contexts are arbitrary shared system memory
>>>> files, which includes unusual things like Wayland keymaps received
>>>> from the host compositor. Do not enforce alignment requirements there.
>>>>
>>>> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
>>>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>>>> ---
>>>>
>>>> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
>>>> v1: https://lore.kernel.org/all/20261006004044.2242154-1-
>>>> val@invisiblethingslab.com/
>>>>
>>>> ~val
>>>>
>>>> ---
>>>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/
>>>> drm/virtio/virtgpu_ioctl.c
>>>> index 3ddd5481d6bc..4d5ae062834d 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>>>> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device
>>>> *vgdev,
>>>>       params->blob_flags = rc_blob->blob_flags;
>>>>       params->blob_hints = rc_blob->blob_hints;
>>>>   -    if (vgdev->has_blob_alignment &&
>>>> +    if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
>>>> +        (vfpriv->context_init &
>>>> VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
>>>> +        VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>>>>           !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>>>           return -EINVAL;
>>>>   
>>> What userspace has this problem and why it re-purposes virtio-gpu to act
>>> as udmabuf for arbitrary data that never reaches host?
>>
>> Sorry, what do you mean by that?
>>
>> This is not related to data that "never reaches host" at all! The error
>> I referred to in the patch message literally says "received *from* the
>> host"…??
>>
>> Guest userspace is any of the cross-domain proxies:
>>
>> * https://codeberg.org/drakulix/wl-cross-domain-proxy
>> * https://github.com/talex5/wayland-proxy-virtwl
>> * https://github.com/google/sommelier-rs (or old C++ version)
>>
>> VIRTIO_GPU_CAPSET_CROSS_DOMAIN "repurposes virtio-gpu" to act as a
>> cross-VM UNIX socket transport that supports fd passing. By referring to
>> virtio-gpu resources in the send command the guest can make the device
>> send the resources' corresponding host fds to the host Wayland
>> compositor. It can refer to resources from other contexts, in order to
>> present drm/venus/etc rendered buffers on Wayland surfaces. (i.e. the
>> host would send the actual dma-buf from virglrenderer) But the resources
>> created on the cross-domain context itself are system memory buffers,
>> generally used for software rendering and miscellaneous Wayland "stuff"
>> like keymaps which are sent *from* the host, and exposed to Wayland
>> clients in the guest. Socket receive handling in rutabaga-gfx stores
>> incoming fds and returns their IDs to the guest, then the guest does a
>> CREATE_BLOB with matching blob_id, which creates a virtio-gpu resource
>> from the incoming buffer, so the guest can just MAP_BLOB it. These are
>> the blobs that are not aligned to anything because they're just
>> arbitrary memfds on the host.
> 
> RE "These are the blobs that are not aligned to anything because they're
> just arbitrary memfds on the host." I'll appreciate confirmation from
> people more familiar with Sommelier internals like Gurchetan, Yiwei or Ryan.
> 
> In a case it is a correct claim, might be better to remove the
> blob_alignment check entirely and let blob sharing fail naturally if
> alignment is wrong.
> 

Reproduced the bug with Sommelier.

Driver always implicitly rounds up BO size up to PAGE_SIZE for both
guest and host blobs [1][2], hence need to retain this old behavior to
fix the problem properly.

Please send v2

[1]
https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/virtgpu_object.c#L217
[2]
https://elixir.bootlin.com/linux/v7.2.10/source/drivers/gpu/drm/virtio/virtgpu_vram.c#L210

--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -539,9 +539,15 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
        params->blob_flags = rc_blob->blob_flags;
        params->blob_hints = rc_blob->blob_hints;

-       if (vgdev->has_blob_alignment &&
-           !IS_ALIGNED(params->size, vgdev->blob_alignment))
-               return -EINVAL;
+       /*
+        * Blob sizes always implicitly rounded up to PAGE_SIZE by the
+        * driver, userspace may be unaware of the host's alignment.
+        * Round up to the larger of the host and guest page sizes.
+        */
+       if (vgdev->has_blob_alignment)
+               params->size = ALIGN(params->size,
+                                    max_t(u32, vgdev->blob_alignment,
PAGE_SIZE));

        return 0;
 }



-- 
Best regards,
Dmitry
