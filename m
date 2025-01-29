Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F7194C86
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738179996; cv=none; b=A4uIEovWqUgjUIswxwbW+HGFfTOL+bGkxU1mEtaibm7r6rXiCiRQpCMzXVFg2HqK+dMGmelMfoQmgkkn2UVfC4NIymxLE2/NfFpwaV8dXK0v5cgKGvfxl9jiVJle6D5ibsIsu+vEteosOBuhDM2NDwGVHBUOafWyrDKVnw+PubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738179996; c=relaxed/simple;
	bh=ZCKhtbbpHa/R4rb/sE0fEZ3548nZnqie1z/puRRtdq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eIQRMNh6HgbbJjYv4CjAMTF8LWw4VXrMl7SM50rGuJImbg/M/DeYa+oqN5Yznm5aYJLkkGYXdlzsslXhYFdaDnuM7VfqG8EZFmSCwH/EacGoSk4imaXSp/g8zwJ0zS9DiuioHeKQak6KlTmHwybWijW4eXfYLtFS90JiMhoW654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiXdc+4G; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiXdc+4G"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32A80401B1
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 19:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7A-aSym5QMBr for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jan 2025 19:46:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=demiobenour@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 72ACF40538
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72ACF40538
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PiXdc+4G
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72ACF40538
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 19:46:33 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e39779a268bso1885571276.1
        for <virtualization@lists.linux-foundation.org>; Wed, 29 Jan 2025 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738179992; x=1738784792; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgRC8OeXxOl594KDgwrGWdhbUQ/t+LE/hIy8Z/jf0C4=;
        b=PiXdc+4GQJ2YzN3WZ4SuASOHZtGcQAgOxyRAgmQJUSFeaPV3B8LENZo4+qdIy2JJaS
         3n5bJSwSMEqRndPVma15kzbqB6LStQ2NprDU7CB9kcE7aWrCLfKYaDng0dI9oqWV6DtI
         zO2xopfNUGmcRX9gwosAoRapa/hYiagAKc4sVV+1p5g8KKYa01n/6HeFa3TIuc5F7Rtr
         R2tWaqjf/VxgquTTm0o0wNjxtV8WOPobZZzC2LeF6nyhN2yVlVcoPVTtjNYQpiC4/zp7
         YQZEBBf7UiAzlhD5yX8GVPuGypOq699nv59c9vEu3qL/FK5QOpbpR7gMPPIOGtN/loFK
         PeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738179992; x=1738784792;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgRC8OeXxOl594KDgwrGWdhbUQ/t+LE/hIy8Z/jf0C4=;
        b=biOrH5jW+2tXXKaFpXwsftcFrAmzwhBo3KF2K59guLXCHFHNmelTzIVGtDIKMDFlfB
         wix5pELWeOeLFRq2k3uF8JEGVAIvACMyjqM3MLb/3e5UrDuzw7lBeQfU7TVSWGCnA8t7
         25WeP5W4Lz/t7tLdlTd9oGNmdh//6eT5WIB01I58Bhvce1w8F3U7KlJD/PsR1ose1PBv
         W+xtk9gEFfq5yvZUuQGB4lnXF7N41KhqNmaN2rTuQYxfxIYaPOsx/Um6MMiU9FEHETYZ
         Z4sp18yL5le+nyDjG0WB7y3LytaB5K4rAF2S3i1nYqOJxdgpftCj5Wg46xpd6u1/dPtM
         fmPw==
X-Forwarded-Encrypted: i=1; AJvYcCWQvJWeAM9ljDnG/b80+DvxToRlKTNdtfEUe2O62VgrH6NlH2v5GdnAKXIoJLZ4bwIiXQ0jia65YhfV35DZfg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3QyNrBRz/sZx/ghQYEeAMb7amY3OFHuIr5eigcD8prldGYIne
	FcKhORe/VVuXmzszi7BtCte8fzRXvBa0duDxlOzYubs0gV9Ub6on
X-Gm-Gg: ASbGnctZh0FSJeAu1ZyeQlfowKRkW9xhzCd29N71YGUaKnNQVg3RuEXpcaZ7bp93yKW
	APSBTzZ95liOYysGuxkpHIRtk0Rkd9imBldh1UR9tcYm9ll/jvnkT9BzqC0659TSFLu3U+ar904
	qx/YXFD0oa4ZHNFQrGuLtP4314Zm5gNJq8FaJL4PrPQTfRDBDy6+w3kKzIdkVD4BXt5FcC+F6Ci
	p4XiKSKJcGCakZmZd0wo3aCSFKPQLhZlCeN+4P0tPfNBV5MhC4hmVfmv520/N8B+hDzDTZj3eIC
	FnOUkgVfRqf5E/oH+sY=
X-Google-Smtp-Source: AGHT+IGZHZoRwpLASNm1lhdI/ftLWBK3eJ7E8KD+ljLTQamiuyRlOXTcUIBefFe1tbw2L5oeT2CPAg==
X-Received: by 2002:a05:6902:2207:b0:e57:87db:22b5 with SMTP id 3f1490d57ef6-e5ac88a6cdbmr674094276.6.1738179991974;
        Wed, 29 Jan 2025 11:46:31 -0800 (PST)
Received: from [10.138.7.94] ([45.134.140.51])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b867f3bsm2594747276.45.2025.01.29.11.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 11:46:31 -0800 (PST)
Message-ID: <4b7da777-87bd-4002-a2a8-b44a89281f12@gmail.com>
Date: Wed, 29 Jan 2025 14:46:30 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] drm/virtio: implement blob userptr resource
 object
Content-Language: en-US
To: "Huang, Honglei1" <Honglei1.Huang@amd.com>, Huang Rui
 <ray.huang@amd.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Lingshan Zhu <Lingshan.Zhu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20241220100409.4007346-1-honglei1.huang@amd.com>
 <20241220100409.4007346-3-honglei1.huang@amd.com>
 <Z2WO2udH2zAEr6ln@phenom.ffwll.local>
 <2fb36b50-4de2-4060-a4b7-54d221db8647@gmail.com>
 <40485636-7ea3-4e34-b4bb-1ccaaadd4e47@amd.com>
 <62aeac90-1ba6-4e22-9465-fee95973a6bf@amd.com>
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <62aeac90-1ba6-4e22-9465-fee95973a6bf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/20/25 4:54 AM, Huang, Honglei1 wrote:
> On 2024/12/27 10:02, Huang, Honglei1 wrote:
>> On 2024/12/22 9:59, Demi Marie Obenour wrote:
>>> On 12/20/24 10:35 AM, Simona Vetter wrote:
>>>> On Fri, Dec 20, 2024 at 06:04:09PM +0800, Honglei Huang wrote:
>>>>> From: Honglei Huang<Honglei1.Huang@amd.com>
>>>>>
>>>>> A virtio-gpu userptr is based on HMM notifier.
>>>>> Used for let host access guest userspace memory and
>>>>> notice the change of userspace memory.
>>>>> This series patches are in very beginning state,
>>>>> User space are pinned currently to ensure the host
>>>>> device memory operations are correct.
>>>>> The free and unmap operations for userspace can be
>>>>> handled by MMU notifier this is a simple and basice
>>>>> SVM feature for this series patches.
>>>>> The physical PFNS update operations is splited into
>>>>> two OPs in here. The evicted memories won't be used
>>>>> anymore but remap into host again to achieve same
>>>>> effect with hmm_rang_fault.
>>>> So in my opinion there are two ways to implement userptr that make sense:
>>>>
>>>> - pinned userptr with pin_user_pages(FOLL_LONGTERM). there is not mmu
>>>>    notifier
>>>>
>>>> - unpinnned userptr where you entirely rely on userptr and do not hold any
>>>>    page references or page pins at all, for full SVM integration. This
>>>>    should use hmm_range_fault ideally, since that's the version that
>>>>    doesn't ever grab any page reference pins.
>>>>
>>>> All the in-between variants are imo really bad hacks, whether they hold a
>>>> page reference or a temporary page pin (which seems to be what you're
>>>> doing here). In much older kernels there was some justification for them,
>>>> because strange stuff happened over fork(), but with FOLL_LONGTERM this is
>>>> now all sorted out. So there's really only fully pinned, or true svm left
>>>> as clean design choices imo.
>>>>
>>>> With that background, why does pin_user_pages(FOLL_LONGTERM) not work for
>>>> you?
>>> +1 on using FOLL_LONGTERM.  Fully dynamic memory management has a huge cost
>>> in complexity that pinning everything avoids.  Furthermore, this avoids the
>>> host having to take action in response to guest memory reclaim requests.
>>> This avoids additional complexity (and thus attack surface) on the host side.
>>> Furthermore, since this is for ROCm and not for graphics, I am less concerned
>>> about supporting systems that require swappable GPU VRAM.
>> Hi Sima and Demi, I totally agree the flag FOLL_LONGTERM is needed, I 
>> will add it in next version. And for the first pin variants 
>> implementation, the MMU notifier is also needed I think.
>> Cause the userptr feature in UMD generally used like this: the 
>> registering of userptr
>> always is explicitly invoked by user code like 
>> "registerMemoryToGPU(userptrAddr, ...)",
>> but for the userptr release/free, there is no explicit API for it, at 
>> least in hsakmt/KFD stack.
>> User just need call system call "free(userptrAddr)", thenkernel driver 
>> will release the userptr
>> by MMU notifier callback.Virtio-GPU has no other way to know if user has 
>> been free the userptr
>> except for MMU notifior.And in UMD theres is no way to get the free() 
>> operation is invoked by user.
>> the only way is use MMU notifierin virtio-GPU driver and free the 
>> corresponding data in host
>> by some virtio CMDs as far as I can see.
>> And for the second way that is use hmm_range_fault, there is a 
>> predictable issues as far as I can see, at least in hsakmt/KFD stack. 
>> That is the memory may migrate when GPU/device is working. In bare 
>> metal, when memory is migrating KFD driver will pause the compute work 
>> of the device in mmap_wirte_lock then use hmm_range_fault to remap the 
>> migrated/evicted memories to GPU then restore the compute work of device 
>> to ensure the correction of the data. But in virtio-GPU driver the 
>> migration happen in guest kernel, the evict mmu notifier callback 
>> happens in guest, a virtio CMD can be used for notify host but as lack 
>> of mmap_write_lock protection in host kernel, host will hold invalid 
>> data for a short period of time, this may lead to some issues. And it is 
>> hard to fix as far as I can see.
>> Finally I will extract some APIs into helper according to your request, 
>> and I will refactor the whole userptr
>> implementation, use some callbacks in page getting path, let the pin 
>> method and hmm_range_fault can be choiced
>> in this series patches.
>>
>> Regards,
>> Honglei
> 
> Hi Sima,
> 
> I modified the code, remove all the MMU nitifior and use 
> pin_user_pages_fast only. Under this implementation userptr fully
> managed by UMD. We did a performance test, it decreased by 30% in
> OpenCL stack in Geekbench6 benmark.
> We use AMD V2000 for test:
> use MMU notifior + pin_user_pages:
> near 13000 score: https://browser.geekbench.com/v6/compute/3257793
> 
> use pin_user_pages only:
> near 10000 socre: https://browser.geekbench.com/v6/compute/3496228
> 
> The code is under clean up, I will send out later.
> 
> And I found a another thing, it seems like in intel i915 userptr
> implementation, the pin_user_pages is also used in MMU notifior.
> Code path is: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gem/i915_gem_userptr.c?h=v6.13#:~:text=ret%20%3D%20pin_user_pages_fast(obj%2D%3Euserptr.ptr%20%2B%20pinned%20*%20PAGE_SIZE%2C
> 
> Patch set: 
> https://lore.kernel.org/all/159353552439.22701.14005121342739071590@emeril.freedesktop.org/T/
> https://patchwork.kernel.org/project/intel-gfx/patch/20210323155059.628690-17-maarten.lankhorst@linux.intel.com/#24064663
> 
> And I didn't find the hmm_range_fault code path, maybe I missed it?

A 30% performance penalty is consistent with the GPU being forced
to use 4K pages instead of its preferred 2M huge pages.  AMD GPUs
have TLBs that are optimized for 2M pages, so using 4K pages will
cause lots of TLB misses.

CC Christian König who pointed out that a highly fragmented
physical address space is a bad idea if you care about GPU
performance.
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
