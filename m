Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883121;
	b=iM9J2RcKIyKIRx5/x4wcLacmS2AIRqcEWZYfiAId9eVPteFVo00Eu0aXGqddEaxaeaLZ
	 q2A4BKLxA9eFpzJJFFwMTtiIeDU6X78aElq91gneSE/ShRdnTXaQUdUpdhoeJ930xYiHf
	 Pi+5PAT8/I+1qD39BdUc/f7z15TqiGn9jR2IR8EquEq1WJMjEWBrWoSZLEFcE6sEucgT4
	 FzuixpBfaIXTPV4B3mXxO5oU3VuyNk0bNGqU1T4d2gv5uer3p6PBqMDtt4qx2KYygXd3y
	 d/kQnl/9CUH1vYsKjYAwsi7gnPAgpbAFDTIHKYQNsTIN9gyzKByXA9prCB0cg2pswjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yUVtnfb+24FhiEw1xC0kVlOFkTCWbPbBFLZFvy+b0Jc=;
	b=iNPuTs0e/IRl68fFsz6HFNmBrNIgGkevD93Y8r7jnKyOijgiz1ky1T/5gp2PG7GQeMbD
	 8yFZni6nFlffmTx7TJGIOnmtuL7D4fuOUpxiE2uOQIoVEZMLNzYIl/AONLy5yQX44eQwq
	 sp+MxtIoKsNov5edsaEzn/fjrp6N1XNKz3zvdqTWOuAJSD7wpbVjw1yEIliYD6aqE980d
	 wU6+oSln1MOt7+Q/RuvqNUfv790WEe2iDipcMmdvRzuoYCx3HVY8+dQSfpJzgrK+LliL9
	 icMdRhe918nFRIWfxzZpIeevO+9bly9nuc9OQE8J7oipjILFDvY3iJ0c1vqPqUOuj3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ursulin.net;
	spf=pass smtp.mailfrom=ursulin.net;
	dkim=pass header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=oZEIDWNO;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6108606D806
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6108606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ursulin.net header.i=@ursulin.net header.a=rsa-sha256 header.s=google header.b=oZEIDWNO
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e47347279so1079906f8f.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1793883118; x=1794487918; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUVtnfb+24FhiEw1xC0kVlOFkTCWbPbBFLZFvy+b0Jc=;
        b=oZEIDWNOIgmbSWF+guFDzzE86eyI9HczNrNnLSBeFvgd0mlnUG2tAuoZvJT3Aky5R5
         JcSC/v2umeSwphDxuGb/i83R4N+j4U5p6/bqtmU4abHvObsxaI3cSKZ6rhCkKr/jC7Vp
         c6qlTOXTWcSvWV2l2ffQ/scAPtX/+k+NNJJrNEo5gLvPbVSyXcJHT/mF7ZpD9W7yxZfY
         LPVpeUUnW11d+4gvlwoHqeOkHl/qwZAFnaRSPBsyOyScdC2ec6YFaGET0fVJa1QvjX43
         kd3nrtcHVoLcYUJQNtOKhsxX4/TvphF3OSTuWr2wmawadnBqDoly7UQ0/7PKLkhlE/rj
         DWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883118; x=1794487918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yUVtnfb+24FhiEw1xC0kVlOFkTCWbPbBFLZFvy+b0Jc=;
        b=GXnQLGpfZm+RXQNN9HsKi7B54aWqwi5iGYYoFp0TGFu+m0NjEECFImFSjtqFNQtyT6
         lTHEKBpP3m20eVITClraocvwQAi9O045ODRkigJundiWsYAoV5juEOMlTky5kL6RdQXk
         Jmkx3IluLOS7jwNLSQ9uCkcdKxGPuyfKQe+MFbLQJOW6HIilZ/inklWX+i/gOY/V//KC
         t8qV9caxcOppq1OWaWQ2wvzMojDQphAolBStyJ/eHjP8LUdlHyGO+tGXzLoyfXobTb/x
         nVLuEM6sLtUtbkZAMjgUqk4EEI61tsKsI+a1Ht9JaBGj3MACjjoavRCr+pm7oNWLTMew
         Y9fg==
X-Forwarded-Encrypted: i=1; AKwUvBwzAjCfBKv9CP/n/ufH9aJIvULEG1r5YB1SZ7HYv4KTIFVsKBDxR2iY5ugfEsP6p0N9Ow+vN0/64Jy5FtfEaA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/gBGzqXoGajd+3RePx2BBLmouoW8DpHVdvKpotbxOsSJr52KSE
	Z9fzfvAoypCumL1jbLOgjCMSqqxXwTpo9QUCp9+57RvOtVyueyxbxiQplwCo5NJLwFQ=
X-Gm-Gg: AYBFou2RQUTVWVI53526xS+JSmFQpQFhXXuIAQceB0kVCVbfxc5cj7V+ccoQYiUII0h
	lZ9ShegfjgSM1+Bk7iBIZ1u/kyXQwUk9o1nja67Du7rdtinJbo4NteXFve3ccT1yJ8l+jaVu0qe
	YD3Ng2UvJJdxe9aRz9RfS+WA6+ANDsMyMw3FCeWzLUh6zdHE46S6tkW7ClOpXkE+KLfA+vn5/Dj
	icHFulZATLr9aDDuVUvb9LDknbiFzGs99TuURnio8nrTG47GhoRcq1q1uWwUEX/GZMve7nvrzXO
	L8btpDwN/VyrLjQBLMn+HMiQ52+6S4rKzlEDtKonYrpx3CzaC9e8e+E5ZW+Ognv3tnvvfzeRuj2
	5m8vJYesKGrrJAuAGIxG+iqBlYY0Ok+OzDn5x2F1IkiwyJrR9CelFt28Jl72lpFmk3aPkiYrWlO
	GoS+wGjUNhOHA2UfDoe1fpT8IEAGsI9WQOel256rZnDi3NQUd3ahmS24c3I+6vFdlFVpnWfiyJP
	rveHQ2R8e6TDnWgoeNeIW2xPJo8Z1br8GYRdILcjIj443L7xwiQK9A/+d1CVlEl8AcEsqZxYfyz
	1nLACTVTnYTGjyNWYHRS6Ffc8D8iAIMXAaCvPi5+Trwc
X-Received: by 2002:a05:6000:40d9:b0:48e:202:6718 with SMTP id ffacd0b85a97d-48e6e3042camr42967559f8f.25.1793883117658;
        Thu, 05 Nov 2026 04:51:57 -0800 (PST)
Received: from [192.168.0.116] ([81.79.79.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm10598510f8f.19.2026.11.05.04.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 04:51:56 -0800 (PST)
Message-ID: <b8179edb-bc59-49af-b8d0-f62e39752f3a@ursulin.net>
Date: Thu, 5 Nov 2026 12:51:55 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 imagination@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.or
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-3-phasta@kernel.org>
 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
 <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/11/2026 12:35, Christian König wrote:
> On 11/5/26 13:06, Tvrtko Ursulin wrote:
>>
>> [I aggresively rewrote the To: list because my SMTP won't let me send this as it was.]
>>
>> On 05/11/2026 11:35, Philipp Stanner wrote:
>>> Currently, there are two init functions for dma_fence, dma_fence_init()
>>> and dma_fence_init64().
>>>
>>> Since more future user options for dma_fence initialization would
>>> require distinct init functions, too, it is better to do this in a
>>> unified way.
>>
>> Why not add something like dma_fence_init_flags() and leave the 99% of the callers out of the (huge) diff? Ie. just port dma_fence_init64() to dma_fence_init_flags().
> 
> Well one advantage of the Linux kernel is to avoid such wrappers. I think having more than one function for the same thing basically just adds more confusion.

Sure we can churn if we really want. But as 99% of callers will be 
passing 0 it's not even very readable. Another option is variadic like 
kmalloc_objs so flags can be optional. Anyway, for consideration only.

> That's also why I would really like to just have one dma_fence_signal() and not like five (or was it four?) variants.
>   
>> Also best to move the addition of dma_fence_flags_invalid() to the patch which adds dma_fence_init_flags() and not have it in this one which is supposed to be functionality neutral.
> 
> Well this is the first time you can actually specify flags so that kind of makes sense to now add the check as well.

Right, that comment was together with suggestion to add the 
dma_fence_init_flags() as a separate patch.

Regards,

Tvrtko

>>> Add a flags field to dma_fence_init(). Adjust all affected drivers,
>>> preserving the old behavior.
>>>
>>> Support the SEQNO64 flag, and add a check-function so that the user only
>>> sets valid bits.
>>>
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>> ---
>>>    drivers/accel/amdxdna/amdxdna_ctx.c           |  2 +-
>>>    drivers/accel/ethosu/ethosu_job.c             |  2 +-
>>>    drivers/accel/ivpu/ivpu_job.c                 |  2 +-
>>>    drivers/accel/rocket/rocket_job.c             |  2 +-
>>>    drivers/dma-buf/dma-fence-array.c             |  2 +-
>>>    drivers/dma-buf/dma-fence.c                   | 31 ++++++++++++++++---
>>>    drivers/dma-buf/st-dma-fence-chain.c          |  2 +-
>>>    drivers/dma-buf/st-dma-fence-unwrap.c         |  2 +-
>>>    drivers/dma-buf/st-dma-fence.c                |  2 +-
>>>    drivers/dma-buf/st-dma-resv.c                 |  2 +-
>>>    drivers/dma-buf/sw_sync.c                     |  2 +-
>>>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  2 +-
>>>    drivers/gpu/drm/drm_crtc.c                    |  2 +-
>>>    drivers/gpu/drm/drm_writeback.c               |  2 +-
>>>    drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  2 +-
>>>    drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c  |  2 +-
>>>    drivers/gpu/drm/i915/i915_request.c           |  2 +-
>>>    drivers/gpu/drm/i915/i915_sw_fence_work.c     |  2 +-
>>>    drivers/gpu/drm/i915/i915_vma_resource.c      |  2 +-
>>>    .../gpu/drm/i915/selftests/i915_sw_fence.c    |  2 +-
>>>    drivers/gpu/drm/imagination/pvr_ccb.c         |  2 +-
>>>    drivers/gpu/drm/imagination/pvr_queue.c       |  2 +-
>>>    drivers/gpu/drm/lima/lima_sched.c             |  2 +-
>>>    drivers/gpu/drm/msm/msm_fence.c               |  2 +-
>>>    drivers/gpu/drm/nouveau/nouveau_fence.c       |  4 +--
>>>    drivers/gpu/drm/panfrost/panfrost_job.c       |  2 +-
>>>    drivers/gpu/drm/panthor/panthor_sched.c       |  2 +-
>>>    drivers/gpu/drm/qxl/qxl_release.c             |  2 +-
>>>    drivers/gpu/drm/radeon/radeon_fence.c         |  2 +-
>>>    drivers/gpu/drm/scheduler/sched_fence.c       |  4 +--
>>>    .../gpu/drm/scheduler/tests/mock_scheduler.c  |  2 +-
>>>    drivers/gpu/drm/ttm/tests/ttm_bo_test.c       |  2 +-
>>>    .../gpu/drm/ttm/tests/ttm_bo_validate_test.c  |  2 +-
>>>    drivers/gpu/drm/v3d/v3d_fence.c               |  2 +-
>>>    drivers/gpu/drm/vc4/vc4_gem.c                 |  2 +-
>>>    drivers/gpu/drm/vgem/vgem_fence.c             |  2 +-
>>>    drivers/gpu/drm/virtio/virtgpu_fence.c        |  2 +-
>>>    drivers/gpu/drm/vmwgfx/vmwgfx_fence.c         |  2 +-
>>>    drivers/gpu/drm/xe/xe_hw_fence.c              |  2 +-
>>>    drivers/gpu/drm/xe/xe_oa.c                    |  2 +-
>>>    drivers/gpu/drm/xe/xe_preempt_fence.c         |  2 +-
>>>    drivers/gpu/drm/xe/xe_tlb_inval.c             |  2 +-
>>>    drivers/gpu/host1x/fence.c                    |  2 +-
>>>    drivers/iio/industrialio-buffer.c             |  2 +-
>>>    drivers/usb/gadget/function/f_fs.c            |  2 +-
>>>    include/linux/dma-fence.h                     | 12 +++++--
>>>    rust/kernel/dma_buf/dma_fence.rs              |  2 +-
>>>    48 files changed, 83 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
>>> index f4004630dc1b..f2245541f1ee 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>>> @@ -53,7 +53,7 @@ static struct dma_fence *amdxdna_fence_create(struct amdxdna_hwctx *hwctx)
>>>          spin_lock_init(&fence->lock);
>>>        /* Unique timeline context prevents eviction from shared BO reservation. */
>>> -    dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0);
>>> +    dma_fence_init(&fence->base, &fence_ops, &fence->lock, dma_fence_context_alloc(1), 0, 0);
>>>        return &fence->base;
>>>    }
>>>    diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
>>> index d656b3ec670e..d4fc71436cae 100644
>>> --- a/drivers/accel/ethosu/ethosu_job.c
>>> +++ b/drivers/accel/ethosu/ethosu_job.c
>>> @@ -219,7 +219,7 @@ static struct dma_fence *ethosu_job_run(struct drm_sched_job *sched_job)
>>>            return NULL;
>>>          dma_fence_init(fence, &ethosu_fence_ops, &dev->fence_lock,
>>> -               dev->fence_context, ++dev->emit_seqno);
>>> +               dev->fence_context, ++dev->emit_seqno, 0);
>>>        dma_fence_get(fence);
>>>          ethosu_switch_perfmon(dev, job);
>>> diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
>>> index 76bacabe496b..6b4f059fb209 100644
>>> --- a/drivers/accel/ivpu/ivpu_job.c
>>> +++ b/drivers/accel/ivpu/ivpu_job.c
>>> @@ -519,7 +519,7 @@ static struct dma_fence *ivpu_fence_create(struct ivpu_device *vdev)
>>>          fence->vdev = vdev;
>>>        spin_lock_init(&fence->lock);
>>> -    dma_fence_init(&fence->base, &ivpu_fence_ops, &fence->lock, dma_fence_context_alloc(1), 1);
>>> +    dma_fence_init(&fence->base, &ivpu_fence_ops, &fence->lock, dma_fence_context_alloc(1), 1, 0);
>>>          return &fence->base;
>>>    }
>>> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
>>> index b2a00992c889..574c9ea802c9 100644
>>> --- a/drivers/accel/rocket/rocket_job.c
>>> +++ b/drivers/accel/rocket/rocket_job.c
>>> @@ -61,7 +61,7 @@ static struct dma_fence *rocket_fence_create(struct rocket_core *core)
>>>            return ERR_PTR(-ENOMEM);
>>>          dma_fence_init(fence, &rocket_fence_ops, &core->fence_lock,
>>> -               core->fence_context, ++core->emit_seqno);
>>> +               core->fence_context, ++core->emit_seqno, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
>>> index 5e10e8df372f..e2dddbfddea2 100644
>>> --- a/drivers/dma-buf/dma-fence-array.c
>>> +++ b/drivers/dma-buf/dma-fence-array.c
>>> @@ -205,7 +205,7 @@ void dma_fence_array_init(struct dma_fence_array *array,
>>>        array->num_fences = num_fences;
>>>          dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
>>> -               seqno);
>>> +               seqno, 0);
>>>        init_irq_work(&array->work, irq_dma_fence_array_work);
>>>          /*
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
>>> index bd58688b81a7..a511cf755ee8 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -122,7 +122,7 @@ static const struct dma_fence_ops dma_fence_stub_ops = {
>>>      static int __init dma_fence_init_stub(void)
>>>    {
>>> -    dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0);
>>> +    dma_fence_init(&dma_fence_stub, &dma_fence_stub_ops, NULL, 0, 0, 0);
>>>        set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>>>            &dma_fence_stub.flags);
>>>        dma_fence_signal(&dma_fence_stub);
>>> @@ -156,7 +156,7 @@ struct dma_fence *dma_fence_allocate_private_stub(ktime_t timestamp)
>>>        if (fence == NULL)
>>>            return NULL;
>>>    -    dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0);
>>> +    dma_fence_init(fence, &dma_fence_stub_ops, NULL, 0, 0, 0);
>>>        set_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>>>            &fence->flags);
>>>    @@ -1063,7 +1063,6 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>                 spinlock_t *lock, u64 context, u64 seqno, unsigned long flags)
>>>    {
>>>        BUG_ON(!ops || !ops->get_driver_name || !ops->get_timeline_name);
>>> -
>>>        kref_init(&fence->refcount);
>>>        /*
>>>         * While it is counter intuitive to protect a constant function pointer
>>> @@ -1087,6 +1086,21 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>        trace_dma_fence_init(fence);
>>>    }
>>>    +static bool dma_fence_flags_invalid(unsigned long flags)
>>> +{
>>> +    const unsigned long valid_fence_bits =
>>> +        BIT(DMA_FENCE_FLAG_SEQNO64_BIT);
>>> +    const unsigned long valid_user_bits =
>>> +        GENMASK(
>>> +            BITS_PER_TYPE(unsigned long) - 1,
>>> +            DMA_FENCE_FLAG_USER_BITS
>>> +               );
>>> +    const unsigned long invalid_bits =
>>> +        ~(valid_fence_bits | valid_user_bits);
>>> +
>>> +    return flags & invalid_bits;
>>> +}
>>> +
>>>    /**
>>>     * dma_fence_init - Initialize a custom fence.
>>>     * @fence: the fence to initialize
>>> @@ -1094,6 +1108,7 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>     * @lock: optional irqsafe spinlock to use for locking this fence
>>>     * @context: the execution context this fence is run on
>>>     * @seqno: a linear increasing sequence number for this context
>>> + * @flags: flags modifying a fence's behavior
>>>     *
>>>     * Initializes an allocated fence, the caller doesn't have to keep its
>>>     * refcount after committing with this fence, but it will need to hold a
>>> @@ -1108,12 +1123,18 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>     * introduction of the callback, but the external lock is still around. New
>>>     * users MUST NOT use external locks, as they force the issuer to outlive all
>>>     * fences that reference the lock.
>>> + *
>>> + * The @flags you can specify here are either DMA_FENCE_FLAG_SEQNO64_BIT or
>>> + * user-specified bits >= DMA_FENCE_FLAG_USER_BITS.
>>>     */
>>>    void
>>>    dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>> -           spinlock_t *lock, u64 context, u64 seqno)
>>> +           spinlock_t *lock, u64 context, u64 seqno,
>>> +           unsigned long flags)
>>>    {
>>> -    __dma_fence_init(fence, ops, lock, context, seqno, 0UL);
>>> +    WARN_ON(dma_fence_flags_invalid(flags));
>>> +
>>> +    __dma_fence_init(fence, ops, lock, context, seqno, flags);
>>>    }
>>>    EXPORT_SYMBOL(dma_fence_init);
>>>    diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
>>> index e0d9b69bfa76..b9610df3ff19 100644
>>> --- a/drivers/dma-buf/st-dma-fence-chain.c
>>> +++ b/drivers/dma-buf/st-dma-fence-chain.c
>>> @@ -52,7 +52,7 @@ static struct dma_fence *mock_fence(void)
>>>            return NULL;
>>>          spin_lock_init(&f->lock);
>>> -    dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0);
>>> +    dma_fence_init(&f->base, &mock_ops, &f->lock, 0, 0, 0);
>>>          return &f->base;
>>>    }
>>> diff --git a/drivers/dma-buf/st-dma-fence-unwrap.c b/drivers/dma-buf/st-dma-fence-unwrap.c
>>> index c5353b36f0e4..dbebc3046d42 100644
>>> --- a/drivers/dma-buf/st-dma-fence-unwrap.c
>>> +++ b/drivers/dma-buf/st-dma-fence-unwrap.c
>>> @@ -36,7 +36,7 @@ static struct dma_fence *__mock_fence(u64 context, u64 seqno)
>>>            return NULL;
>>>          spin_lock_init(&f->lock);
>>> -    dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno);
>>> +    dma_fence_init(&f->base, &mock_ops, &f->lock, context, seqno, 0);
>>>          return &f->base;
>>>    }
>>> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
>>> index cb62e606d0a2..b3f88e89cc44 100644
>>> --- a/drivers/dma-buf/st-dma-fence.c
>>> +++ b/drivers/dma-buf/st-dma-fence.c
>>> @@ -31,7 +31,7 @@ static struct dma_fence *mock_fence(void)
>>>        if (!f)
>>>            return NULL;
>>>    -    dma_fence_init(f, &mock_ops, NULL, 0, 0);
>>> +    dma_fence_init(f, &mock_ops, NULL, 0, 0, 0);
>>>        return f;
>>>    }
>>>    diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
>>> index 0b96136bbd54..c3a920ab3fcf 100644
>>> --- a/drivers/dma-buf/st-dma-resv.c
>>> +++ b/drivers/dma-buf/st-dma-resv.c
>>> @@ -35,7 +35,7 @@ static struct dma_fence *alloc_fence(void)
>>>        if (!f)
>>>            return NULL;
>>>    -    dma_fence_init(f, &fence_ops, &fence_lock, 0, 0);
>>> +    dma_fence_init(f, &fence_ops, &fence_lock, 0, 0, 0);
>>>        return f;
>>>    }
>>>    diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
>>> index 8df20b0218a9..ce43af7e735e 100644
>>> --- a/drivers/dma-buf/sw_sync.c
>>> +++ b/drivers/dma-buf/sw_sync.c
>>> @@ -258,7 +258,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
>>>          sync_timeline_get(obj);
>>>        dma_fence_init(&pt->base, &timeline_fence_ops, &obj->lock,
>>> -               obj->context, value);
>>> +               obj->context, value, 0);
>>>        INIT_LIST_HEAD(&pt->link);
>>>          spin_lock_irq(&obj->lock);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>> index 9b10d015671c..30ccdb3e0b47 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>> @@ -77,7 +77,7 @@ struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>>>        spin_lock_init(&fence->lock);
>>>        fence->context_id = context_id;
>>>        dma_fence_init(&fence->base, &amdkfd_fence_ops, &fence->lock,
>>> -           context, atomic_inc_return(&fence_seq));
>>> +           context, atomic_inc_return(&fence_seq), 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index bff2d38f3571..03e1974f8dda 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -112,7 +112,7 @@ void amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
>>>        seq = ++ring->fence_drv.sync_seq;
>>>        dma_fence_init(fence, &amdgpu_fence_ops,
>>>                   &ring->fence_drv.lock,
>>> -               adev->fence_context + ring->idx, seq);
>>> +               adev->fence_context + ring->idx, seq, 0);
>>>          amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>>>                       seq, flags | AMDGPU_FENCE_FLAG_INT);
>>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>>> index 63ead8ba6756..92641bc0a378 100644
>>> --- a/drivers/gpu/drm/drm_crtc.c
>>> +++ b/drivers/gpu/drm/drm_crtc.c
>>> @@ -190,7 +190,7 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc)
>>>            return NULL;
>>>          dma_fence_init(fence, &drm_crtc_fence_ops, &crtc->fence_lock,
>>> -               crtc->fence_context, ++crtc->fence_seqno);
>>> +               crtc->fence_context, ++crtc->fence_seqno, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
>>> index b4a002e6d043..64b06b890f19 100644
>>> --- a/drivers/gpu/drm/drm_writeback.c
>>> +++ b/drivers/gpu/drm/drm_writeback.c
>>> @@ -592,7 +592,7 @@ drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
>>>          dma_fence_init(fence, &drm_writeback_fence_ops,
>>>                   &wb_connector->fence_lock, wb_connector->fence_context,
>>> -               ++wb_connector->fence_seqno);
>>> +               ++wb_connector->fence_seqno, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> index e75dab5e407d..a10e4e4cf372 100644
>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>>> @@ -1199,7 +1199,7 @@ static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
>>>        f->gpu = gpu;
>>>          dma_fence_init(&f->base, &etnaviv_fence_ops, &gpu->fence_spinlock,
>>> -               gpu->fence_context, ++gpu->next_fence);
>>> +               gpu->fence_context, ++gpu->next_fence, 0);
>>>          return &f->base;
>>>    }
>>> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>>> index 56489cc127d6..ffaa70191f27 100644
>>> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
>>> @@ -437,7 +437,7 @@ i915_ttm_memcpy_work_arm(struct i915_ttm_memcpy_work *work,
>>>        int ret;
>>>          spin_lock_init(&work->lock);
>>> -    dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0);
>>> +    dma_fence_init(&work->fence, &dma_fence_memcpy_ops, &work->lock, 0, 0, 0);
>>>        dma_fence_get(&work->fence);
>>>        ret = dma_fence_add_callback(dep, &work->cb, __memcpy_cb);
>>>        if (ret) {
>>> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
>>> index f66f8efc7062..0f4fc9cc0033 100644
>>> --- a/drivers/gpu/drm/i915/i915_request.c
>>> +++ b/drivers/gpu/drm/i915/i915_request.c
>>> @@ -953,7 +953,7 @@ __i915_request_create(struct intel_context *ce, gfp_t gfp)
>>>            goto err_free;
>>>          dma_fence_init(&rq->fence, &i915_fence_ops, &rq->lock,
>>> -               tl->fence_context, seqno);
>>> +               tl->fence_context, seqno, 0);
>>>          RCU_INIT_POINTER(rq->timeline, tl);
>>>        rq->hwsp_seqno = tl->hwsp_seqno;
>>> diff --git a/drivers/gpu/drm/i915/i915_sw_fence_work.c b/drivers/gpu/drm/i915/i915_sw_fence_work.c
>>> index 366418108f78..4cd44dd26e35 100644
>>> --- a/drivers/gpu/drm/i915/i915_sw_fence_work.c
>>> +++ b/drivers/gpu/drm/i915/i915_sw_fence_work.c
>>> @@ -85,7 +85,7 @@ void dma_fence_work_init(struct dma_fence_work *f,
>>>    {
>>>        f->ops = ops;
>>>        spin_lock_init(&f->lock);
>>> -    dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0);
>>> +    dma_fence_init(&f->dma, &fence_ops, &f->lock, 0, 0, 0);
>>>        i915_sw_fence_init(&f->chain, fence_notify);
>>>        INIT_WORK(&f->work, fence_work);
>>>    }
>>> diff --git a/drivers/gpu/drm/i915/i915_vma_resource.c b/drivers/gpu/drm/i915/i915_vma_resource.c
>>> index a8f2112ce81f..19596410e32f 100644
>>> --- a/drivers/gpu/drm/i915/i915_vma_resource.c
>>> +++ b/drivers/gpu/drm/i915/i915_vma_resource.c
>>> @@ -263,7 +263,7 @@ void __i915_vma_resource_init(struct i915_vma_resource *vma_res)
>>>    {
>>>        spin_lock_init(&vma_res->lock);
>>>        dma_fence_init(&vma_res->unbind_fence, &unbind_fence_ops,
>>> -               &vma_res->lock, 0, 0);
>>> +               &vma_res->lock, 0, 0, 0);
>>>        refcount_set(&vma_res->hold_count, 1);
>>>        i915_sw_fence_init(&vma_res->chain, i915_vma_resource_fence_notify);
>>>    }
>>> diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>>> index ecb2d718f6a6..d8d4f7057031 100644
>>> --- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>>> +++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
>>> @@ -641,7 +641,7 @@ static struct dma_fence *alloc_dma_fence(void)
>>>          dma = kmalloc_obj(*dma);
>>>        if (dma)
>>> -        dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0);
>>> +        dma_fence_init(dma, &mock_fence_ops, &mock_fence_lock, 0, 0, 0);
>>>          return dma;
>>>    }
>>> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
>>> index e408df74853d..7043b491fe54 100644
>>> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
>>> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
>>> @@ -645,7 +645,7 @@ pvr_kccb_reserve_slot(struct pvr_device *pvr_dev, struct dma_fence *f)
>>>            dma_fence_init(&fence->base, &pvr_kccb_fence_ops,
>>>                       &pvr_dev->kccb.fence_ctx.lock,
>>>                       pvr_dev->kccb.fence_ctx.id,
>>> -                   atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno));
>>> +                   atomic_inc_return(&pvr_dev->kccb.fence_ctx.seqno), 0);
>>>            out_fence = dma_fence_get(&fence->base);
>>>            list_add_tail(&fence->node, &pvr_dev->kccb.waiters);
>>>        } else {
>>> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
>>> index 24a8645aa913..34b826381aa2 100644
>>> --- a/drivers/gpu/drm/imagination/pvr_queue.c
>>> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
>>> @@ -305,7 +305,7 @@ pvr_queue_fence_init(struct dma_fence *f,
>>>        INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
>>>        dma_fence_init(&fence->base, fence_ops,
>>>                   &fence_ctx->lock, fence_ctx->id,
>>> -               atomic_inc_return(&fence_ctx->seqno));
>>> +               atomic_inc_return(&fence_ctx->seqno), 0);
>>>    }
>>>      /**
>>> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
>>> index 9a1e6b9ecbe5..fee595b9629a 100644
>>> --- a/drivers/gpu/drm/lima/lima_sched.c
>>> +++ b/drivers/gpu/drm/lima/lima_sched.c
>>> @@ -97,7 +97,7 @@ static struct lima_fence *lima_fence_create(struct lima_sched_pipe *pipe)
>>>          fence->pipe = pipe;
>>>        dma_fence_init(&fence->base, &lima_fence_ops, &pipe->fence_lock,
>>> -               pipe->fence_context, ++pipe->fence_seqno);
>>> +               pipe->fence_context, ++pipe->fence_seqno, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
>>> index 3dca8e09c192..1ec59919c32e 100644
>>> --- a/drivers/gpu/drm/msm/msm_fence.c
>>> +++ b/drivers/gpu/drm/msm/msm_fence.c
>>> @@ -197,5 +197,5 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
>>>        WARN_ON(kref_read(&fence->refcount));
>>>          dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
>>> -               fctx->context, ++fctx->last_fence);
>>> +               fctx->context, ++fctx->last_fence, 0);
>>>    }
>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
>>> index 11e95c37ce50..97e20954c71b 100644
>>> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
>>> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
>>> @@ -216,10 +216,10 @@ nouveau_fence_emit(struct nouveau_fence *fence)
>>>          if (priv->uevent)
>>>            dma_fence_init(&fence->base, &nouveau_fence_ops_uevent,
>>> -                   &fctx->lock, fctx->context, ++fctx->sequence);
>>> +                   &fctx->lock, fctx->context, ++fctx->sequence, 0);
>>>        else
>>>            dma_fence_init(&fence->base, &nouveau_fence_ops_legacy,
>>> -                   &fctx->lock, fctx->context, ++fctx->sequence);
>>> +                   &fctx->lock, fctx->context, ++fctx->sequence, 0);
>>>        kref_get(&fctx->fence_ref);
>>>          ret = fctx->emit(fence);
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> index 4ddf4b722ddf..de242d275978 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
>>> @@ -105,7 +105,7 @@ static struct dma_fence *panfrost_fence_create(struct panfrost_device *pfdev, in
>>>        fence->queue = js_num;
>>>        fence->seqno = ++js->queue[js_num].emit_seqno;
>>>        dma_fence_init(&fence->base, &panfrost_fence_ops, &js->job_lock,
>>> -               js->queue[js_num].fence_context, fence->seqno);
>>> +               js->queue[js_num].fence_context, fence->seqno, 0);
>>>          return &fence->base;
>>>    }
>>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>>> index a343c5180e01..c46f69ade7a0 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>>> @@ -3322,7 +3322,7 @@ queue_run_job(struct drm_sched_job *sched_job)
>>>                   &panthor_queue_fence_ops,
>>>                   &queue->fence_ctx.lock,
>>>                   queue->fence_ctx.id,
>>> -               atomic64_inc_return(&queue->fence_ctx.seqno));
>>> +               atomic64_inc_return(&queue->fence_ctx.seqno), 0);
>>>          job->profiling.slot = queue->profiling.seqno++;
>>>        if (queue->profiling.seqno == queue->profiling.slot_count)
>>> diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
>>> index 06979d0e8a9f..2608d82f7370 100644
>>> --- a/drivers/gpu/drm/qxl/qxl_release.c
>>> +++ b/drivers/gpu/drm/qxl/qxl_release.c
>>> @@ -430,7 +430,7 @@ void qxl_release_fence_buffer_objects(struct qxl_release *release)
>>>         * set the highest bits. This will break if we really allow exporting of dma-bufs.
>>>         */
>>>        dma_fence_init(&release->base, &qxl_fence_ops, &qdev->release_lock,
>>> -               release->id | 0xf0000000, release->base.seqno);
>>> +               release->id | 0xf0000000, release->base.seqno, 0);
>>>        trace_dma_fence_emit(&release->base);
>>>          list_for_each_entry(entry, &release->bos, list) {
>>> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
>>> index 8e9402b8811b..1360b5215f5e 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>>> @@ -148,7 +148,7 @@ int radeon_fence_emit(struct radeon_device *rdev,
>>>        dma_fence_init(&(*fence)->base, &radeon_fence_ops,
>>>                   &rdev->fence_queue.lock,
>>>                   rdev->fence_context + ring,
>>> -               seq);
>>> +               seq, 0);
>>>        radeon_fence_ring_emit(rdev, ring, *fence);
>>>        trace_radeon_fence_emit(rdev_to_drm(rdev), ring, (*fence)->seq);
>>>        radeon_fence_schedule_check(rdev, ring);
>>> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
>>> index b7a4cb921234..94ba0cf4fe02 100644
>>> --- a/drivers/gpu/drm/scheduler/sched_fence.c
>>> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
>>> @@ -229,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
>>>        fence->sched = entity->rq->sched;
>>>        seq = atomic_inc_return(&entity->fence_seq);
>>>        dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
>>> -               &fence->lock, entity->fence_context, seq);
>>> +               &fence->lock, entity->fence_context, seq, 0);
>>>        dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
>>> -               &fence->lock, entity->fence_context + 1, seq);
>>> +               &fence->lock, entity->fence_context + 1, seq, 0);
>>>    }
>>>      module_init(drm_sched_fence_slab_init);
>>> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> index 2dfa3efef210..169792a4b329 100644
>>> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
>>> @@ -173,7 +173,7 @@ static struct dma_fence *mock_sched_run_job(struct drm_sched_job *sched_job)
>>>                   &drm_mock_sched_hw_fence_ops,
>>>                   &sched->lock,
>>>                   sched->hw_timeline.context,
>>> -               atomic_inc_return(&sched->hw_timeline.next_seqno));
>>> +               atomic_inc_return(&sched->hw_timeline.next_seqno), 0);
>>>          dma_fence_get(&job->hw_fence); /* Reference for the job_list */
>>>    diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>>> index f3103307b5df..633cc7458505 100644
>>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
>>> @@ -450,7 +450,7 @@ static void ttm_bo_fini_shared_resv(struct kunit *test)
>>>        KUNIT_ASSERT_NOT_NULL(test, fence);
>>>          spin_lock_init(&fence_lock);
>>> -    dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0);
>>> +    dma_fence_init(fence, &mock_fence_ops, &fence_lock, 0, 0, 0);
>>>          dma_resv_lock(external_resv, NULL);
>>>        dma_resv_reserve_fences(external_resv, 1);
>>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>>> index 56ad8ef32584..e22a1335f166 100644
>>> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>>> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
>>> @@ -57,7 +57,7 @@ static struct dma_fence *alloc_mock_fence(struct kunit *test)
>>>        fence = kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
>>>        KUNIT_ASSERT_NOT_NULL(test, fence);
>>>    -    dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0);
>>> +    dma_fence_init(fence, &fence_ops, &fence_lock, 0, 0, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
>>> index c500136d0455..1fdba5a21580 100644
>>> --- a/drivers/gpu/drm/v3d/v3d_fence.c
>>> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
>>> @@ -16,7 +16,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
>>>        fence->queue = q;
>>>        fence->seqno = ++queue->emit_seqno;
>>>        dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
>>> -               queue->fence_context, fence->seqno);
>>> +               queue->fence_context, fence->seqno, 0);
>>>          return &fence->base;
>>>    }
>>> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
>>> index ff611c618d6b..420988d516c1 100644
>>> --- a/drivers/gpu/drm/vc4/vc4_gem.c
>>> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
>>> @@ -648,7 +648,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
>>>        exec->seqno = seqno;
>>>          dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
>>> -               vc4->dma_fence_context, exec->seqno);
>>> +               vc4->dma_fence_context, exec->seqno, 0);
>>>        fence->seqno = exec->seqno;
>>>        exec->fence = &fence->base;
>>>    diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
>>> index 0e53ba7db629..18700e5f9167 100644
>>> --- a/drivers/gpu/drm/vgem/vgem_fence.c
>>> +++ b/drivers/gpu/drm/vgem/vgem_fence.c
>>> @@ -77,7 +77,7 @@ static struct dma_fence *vgem_fence_create(struct vgem_file *vfile,
>>>          spin_lock_init(&fence->lock);
>>>        dma_fence_init(&fence->base, &vgem_fence_ops, &fence->lock,
>>> -               dma_fence_context_alloc(1), 1);
>>> +               dma_fence_context_alloc(1), 1, 0);
>>>          timer_setup(&fence->timer, vgem_fence_timeout, TIMER_IRQSAFE);
>>>    diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
>>> index c3e66ef2133a..8e469391d2e4 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
>>> @@ -76,7 +76,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev,
>>>         */
>>>          dma_fence_init(&fence->f, &virtio_gpu_fence_ops, &drv->lock,
>>> -               fence_context, 0);
>>> +               fence_context, 0, 0);
>>>          return fence;
>>>    }
>>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>>> index 384c6736cf6b..15f355dc6881 100644
>>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
>>> @@ -163,7 +163,7 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
>>>        int ret = 0;
>>>          dma_fence_init(&fence->base, &vmw_fence_ops, &fman->lock,
>>> -               fman->ctx, seqno);
>>> +               fman->ctx, seqno, 0);
>>>        fence->destroy = destroy;
>>>          spin_lock(&fman->lock);
>>> diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
>>> index 14720623ad00..30bfc42972e0 100644
>>> --- a/drivers/gpu/drm/xe/xe_hw_fence.c
>>> +++ b/drivers/gpu/drm/xe/xe_hw_fence.c
>>> @@ -243,7 +243,7 @@ void xe_hw_fence_init(struct dma_fence *fence, struct xe_hw_fence_ctx *ctx,
>>>        INIT_LIST_HEAD(&hw_fence->irq_link);
>>>          dma_fence_init(fence, &xe_hw_fence_ops, &ctx->irq->lock,
>>> -               ctx->dma_fence_ctx, ctx->next_seqno++);
>>> +               ctx->dma_fence_ctx, ctx->next_seqno++, 0);
>>>          trace_xe_hw_fence_create(hw_fence);
>>>    }
>>> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>>> index c9320feeafba..912840eeec50 100644
>>> --- a/drivers/gpu/drm/xe/xe_oa.c
>>> +++ b/drivers/gpu/drm/xe/xe_oa.c
>>> @@ -1053,7 +1053,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
>>>          /* Point of no return: initialize and set fence to signal */
>>>        spin_lock_init(&ofence->lock);
>>> -    dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
>>> +    dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0, 0);
>>>          for (i = 0; i < stream->num_syncs; i++) {
>>>            if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
>>> diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
>>> index 4aa570fe745d..343f1ba1e1cd 100644
>>> --- a/drivers/gpu/drm/xe/xe_preempt_fence.c
>>> +++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
>>> @@ -154,7 +154,7 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
>>>        pfence->q = xe_exec_queue_get(q);
>>>        spin_lock_init(&pfence->lock);
>>>        dma_fence_init(&pfence->base, &preempt_fence_ops,
>>> -              &pfence->lock, context, seqno);
>>> +              &pfence->lock, context, seqno, 0);
>>>          return &pfence->base;
>>>    }
>>> diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
>>> index c9cc5842d65b..1fd39434dc0e 100644
>>> --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
>>> +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
>>> @@ -544,7 +544,7 @@ void xe_tlb_inval_fence_init(struct xe_tlb_inval *tlb_inval,
>>>          spin_lock_irq(&tlb_inval->lock);
>>>        dma_fence_init(&fence->base, &inval_fence_ops, &tlb_inval->lock,
>>> -               dma_fence_context_alloc(1), 1);
>>> +               dma_fence_context_alloc(1), 1, 0);
>>>        spin_unlock_irq(&tlb_inval->lock);
>>>        INIT_LIST_HEAD(&fence->link);
>>>        if (stack)
>>> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
>>> index 1acf579c562b..7e074e72a055 100644
>>> --- a/drivers/gpu/host1x/fence.c
>>> +++ b/drivers/gpu/host1x/fence.c
>>> @@ -136,7 +136,7 @@ struct dma_fence *host1x_fence_create(struct host1x_syncpt *sp, u32 threshold,
>>>        fence->timeout = timeout;
>>>          dma_fence_init(&fence->base, &host1x_syncpt_fence_ops, &sp->fences.lock,
>>> -               dma_fence_context_alloc(1), 0);
>>> +               dma_fence_context_alloc(1), 0, 0);
>>>          INIT_DELAYED_WORK(&fence->timeout_work, do_fence_timeout);
>>>    diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>>> index 4294101810fd..f7d6b294b63c 100644
>>> --- a/drivers/iio/industrialio-buffer.c
>>> +++ b/drivers/iio/industrialio-buffer.c
>>> @@ -1904,7 +1904,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
>>>         * the dma_fence.
>>>         */
>>>        dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
>>> -               &fence->lock, priv->context, seqno);
>>> +               &fence->lock, priv->context, seqno, 0);
>>>          ret = iio_dma_resv_lock(dmabuf, nonblock);
>>>        if (ret)
>>> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
>>> index c64a268e98a4..eb367a1666c2 100644
>>> --- a/drivers/usb/gadget/function/f_fs.c
>>> +++ b/drivers/usb/gadget/function/f_fs.c
>>> @@ -1733,7 +1733,7 @@ static int ffs_dmabuf_transfer(struct file *file,
>>>        seqno = atomic_add_return(1, &epfile->seqno);
>>>          dma_fence_init(&fence->base, &ffs_dmabuf_fence_ops,
>>> -               &priv->lock, priv->context, seqno);
>>> +               &priv->lock, priv->context, seqno, 0);
>>>          resv_dir = epfile->in ? DMA_RESV_USAGE_READ : DMA_RESV_USAGE_WRITE;
>>>    diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
>>> index dd07d128adc3..6f5c245d89ec 100644
>>> --- a/include/linux/dma-fence.h
>>> +++ b/include/linux/dma-fence.h
>>> @@ -103,6 +103,12 @@ struct dma_fence {
>>>        int error;
>>>    };
>>>    +/** enum dma_fence_flag_bits - internal dma_fence flags
>>> + *
>>> + * These flags are all only for internal usage, except for
>>> + * @DMA_FENCE_FLAG_SEQNO64_BIT and the user bits beginning at
>>> + * @DMA_FENCE_FLAG_USER_BITS.
>>> + */
>>>    enum dma_fence_flag_bits {
>>>        DMA_FENCE_FLAG_INITIALIZED_BIT,
>>>        DMA_FENCE_FLAG_INLINE_LOCK_BIT,
>>> @@ -110,6 +116,7 @@ enum dma_fence_flag_bits {
>>>        DMA_FENCE_FLAG_SIGNALED_BIT,
>>>        DMA_FENCE_FLAG_TIMESTAMP_BIT,
>>>        DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT,
>>> +
>>>        DMA_FENCE_FLAG_USER_BITS, /* must always be last member */
>>>    };
>>>    @@ -279,11 +286,10 @@ struct dma_fence_ops {
>>>    };
>>>      void dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>> -            spinlock_t *lock, u64 context, u64 seqno);
>>> -
>>> +            spinlock_t *lock, u64 context, u64 seqno,
>>> +            unsigned long flags);
>>>    void dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,
>>>                  spinlock_t *lock, u64 context, u64 seqno);
>>> -
>>>    void dma_fence_release(struct kref *kref);
>>>    void dma_fence_free(struct dma_fence *fence);
>>>    void dma_fence_describe(struct dma_fence *fence, struct seq_file *seq);
>>> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
>>> index 18a43e1bb442..ee8fa4ecd6c1 100644
>>> --- a/rust/kernel/dma_buf/dma_fence.rs
>>> +++ b/rust/kernel/dma_buf/dma_fence.rs
>>> @@ -736,7 +736,7 @@ pub fn new_fence(self) -> DriverFence<'a, T> {
>>>            // SAFETY: `fence_ptr` has been created directly above. It will live
>>>            // at least as long as `Self`. The same applies to `&Self::OPS`.
>>>            unsafe {
>>> -            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno)
>>> +            bindings::dma_fence_init(fence_ptr, self.ops, null_ptr, self.data.fctx.nr, seqno, 0)
>>>            };
>>>              self.data.fctx.nr_of_unsignaled_fences.fetch_add(1, Relaxed);
>>
> 

