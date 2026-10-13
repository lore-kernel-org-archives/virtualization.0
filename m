Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB636C0DC
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929548; cv=pass; b=C+wVJ2EH3dLAZtjU0JP5OX46jTSm5d80Eur03PWkTUXQlfKnZZhXBAWrIRzckuFjpcQ2Qbu0jaLxt0n6ZZpTTbxje9d7Xt5nLRONBt8RcGHei+3xL9c/Wd4miaGx7ZfYgDYkgYCuwKaOZTcRcsuZztxxYmWiWOtagSMW3k6vb60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929548; c=relaxed/simple;
	bh=sb6lDyvEWxW/tjWYo4JwxUo8AyjP0zcs8wstHaj2Qbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCKrzR2tTolYby50IaCuA88rsL2G8VMHBcJ64ikx0bP2IIx5w5p/gQe0IuKaP17+0ceQoaEOAO6g15dcDYTz9/gMwpSWw0eZbj09kMOAmPQQOPJ2nJ3rkS9SjAsufm7e0UuX9uJH49jZl4kaWhiU0gwxzMZOyJG+yP/r+55qS3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=FgwTvW/Z; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="FgwTvW/Z"
ARC-Seal: i=1; a=rsa-sha256; t=1791929535; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WZ8lGLaO87ls1aXK8rTZT9do0J6fz3Lpy2S6nmQ+8B5E4FvuFP+Js++jGkDAkd0ZHP7KK40QJcg/ixxkMJooUJ7IhRkT9ktVDMk2SKd1jBUmpYMNU05iWBIiTawOlMubJNdNfjXbC2k5yJzTSltxJFPuhlKTYWf2Z1gkmIPlWik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791929535; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wcRc/T/eXCLTFhEcSFkccExr1kJjQjBISfxi0aCVTa0=; 
	b=gJF37XSVKZheqM+qhSL/UvYxl2Ml6/zC4kNEVGVIJhxBITD10HY6nYxf9K+q8jZMiXShQGe7eo67nWzQyMcq2tDrSQSKfz5eKY2kjchhcC8SN0558Oul5QGoLyYibAGIkNMOV77hBGAmiXaCww80KXANs7HWAKb/t6S/mAiJ2OU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791929535;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wcRc/T/eXCLTFhEcSFkccExr1kJjQjBISfxi0aCVTa0=;
	b=FgwTvW/ZRIn4lUW0mVdAVa61kGyLcB1+oc9BqdXLwx2rIhxQA5lLYXjbS0nYXbtq
	4/KTPTX489rpeHnfLGs4BoER6pX2Yy7oL/dzEDi+n1Qo/ku2nRvqO4rUkYiWBv+V7Ej
	33dXRF6mHAfF3Q6YT/NkMmGHSVJRAjWlb0D5ATMM=
Received: by smtp.zohomail.com with SMTPS id 1791929533139758.2008581627222;
	Tue, 13 Oct 2026 15:12:13 -0700 (PDT)
Message-ID: <d9ee1d07-4277-4a18-a857-c82f200fe76c@collabora.com>
Date: Wed, 14 Oct 2026 01:12:08 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: "Huang, Honglei" <honghuan@amd.com>
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 airlied@redhat.com, kraxel@redhat.com
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <dfa2f117-1094-40b9-9445-ab2bbf62ff2e@collabora.com>
 <7c32c182-5b49-4dc0-9c97-a4238743f28c@amd.com>
 <efd5fa89-e888-469a-ac80-e6e605f9a015@collabora.com>
 <317cc6e9-8e15-462d-9e9c-2657011b7128@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <317cc6e9-8e15-462d-9e9c-2657011b7128@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 10/13/26 08:32, Huang, Honglei wrote:
> 
> 
> On 10/10/2026 8:50 PM, Dmitry Osipenko wrote:
>> On 10/10/26 10:37, Huang, Honglei wrote:
>>>
>>>
>>> On 10/10/2026 2:53 AM, Dmitry Osipenko wrote:
>>>> 24.09.2026 12:55, Honglei Huang пишет:
>>>>> +int virtio_gpu_userptr_create(struct virtio_gpu_device *vgdev,
>>>>> +                  struct drm_file *file,
>>>>> +                  struct virtio_gpu_object_params *params,
>>>>> +                  struct virtio_gpu_object **bo_ptr)
>>>>> +{
>>>>> +    struct virtio_gpu_object_userptr *userptr;
>>>>> +    struct virtio_gpu_mem_entry *ents = NULL;
>>>>> +    struct sg_table *sgt;
>>>>> +    struct mm_struct *mm;
>>>>> +    unsigned long lock_limit;
>>>>> +    unsigned long start;
>>>>> +    unsigned long end;
>>>>> +    s64 new_pinned;
>>>>> +    unsigned int nents;
>>>>> +    int ret;
>>>>> +
>>>>> +    *bo_ptr = NULL;
>>>>> +
>>>>> +    if (!params->size || !IS_ALIGNED(params->size, PAGE_SIZE) ||
>>>>> +        params->userptr != (unsigned long)params->userptr)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    start = params->userptr;
>>>>> +    if (!IS_ALIGNED(start, PAGE_SIZE) ||
>>>>> +        check_add_overflow(start, (unsigned long)params->size, &end))
>>>>> +        return -EINVAL;
>>>>
>>>> There is new vgdev->blob_alignment defining host page size as it may
>>>> differ from guest's page. Will be good to validate both.
>>>>
>>>
>>> Will add blob_alignment check in next version, thanks for the review.
>> Missed that verify_blob() already should be validating the userptr
>> blob_alignment. The patches look good.
>>
>> BTW, previously the extra AMD KFD patches were needed on host kernel,
>> did they land upstream?
> 
> According to KFD maintainer, they want to us to add those virtio
> specific feature into drm svm, a new SVM frame work based on drm svm
> helpers. We are working on it:
> https://lore.kernel.org/amd-gfx/20260804094246.1719318-1-ray.huang@amd.com/
> 
> And the amdgpu VM maintainer has agreed that he will help to consider
> how to intergate the virtio requirements into the design of amdgpu drmsvm.
> 
> And for now we can use a user space method to replace the AMD KFD
> patches function, it is mremap, it also works, we tested it, but
> it has some performance loss, I will update the whole thing when all the
> components code are ready.

Thanks for the clarification

-- 
Best regards,
Dmitry
