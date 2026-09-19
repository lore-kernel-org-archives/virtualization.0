Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42163B3C05;
	Sat, 19 Sep 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789804866; cv=none; b=HMxtfye3VXKAbjxCoqoGuMd6D3ptXpI+YEnqDDg5G1RUBANc3yrgVfO3BiDeeNaidIYweouZpJABNW55gLMoPrQYBJH1hooUR9SeEl98zI989n0IaDp4RKWd7avq824TQpCySxO7O7oThWP3mmmAIzDLy5/CF/O3pc1JYT8BjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789804866; c=relaxed/simple;
	bh=UgN7N6JMldNefvy9Knxsqci8DW0w0dio4CtB6cjhUpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCq9Zm75znegbQkor6FNreFtYI8nYt9ofETM8Kb1dP0W5xvs3DP6W/Qz4dn59jOLA41wtAuFEGevSTVO4dH/PHL4DiniDitcZTchpzBms3MB+NW5bDAYJmi2tYhfBQk+kbqdvJ5z1hW/fyb+busLNS4DyFN9V1cp1smjIf1W5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=XLEFoVOu; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="XLEFoVOu"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68J80pdf081376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 17:00:51 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mw6u70djCGiwpB17jPa/69aiMtBcQKLs7biIosnqhEs=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1789804852; v=1;
        b=XLEFoVOue+PPPFfmRvvj5P7mEPBfZ60Tul7XsbuwG0A3TPJKnwUFqJxWM8/m4nNr
         7iDuGRECKXQwaD+sw2lm/v0BIuMFn+sOIlgq3lYGdYpjSRaTqRBzxe3tilrAljmo
         8uKf2rnwuJaTlro7GxWvBLDYzCoYrKoHhLFxKcbiPbu21n8URogNUzR8RdxwYwzi
         RXGtfI4Teox1FxLhX0xTF2NeG3ASNKg7TCvthidkWqqUVBJJluCqbD0H9i4H03/j
         wCahN+DQbmnOeO0qneo+M5jjYKhjxG3O5/IA+mTWPqg5kAfqfu61c72c56XsLviR
         d/SaesRZ4kV8TrKjbgK2yQ==
Message-ID: <de906373-8359-43b3-8786-f6a657743f7b@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 19 Sep 2026 17:00:51 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM
 capability
To: "Huang, Honglei" <honghuan@amd.com>, sashiko-reviews@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev,
        Eugenio Perez <eperezma@redhat.com>, dri-devel@lists.freedesktop.org
References: <20260918095940.2253018-1-honghuan@amd.com>
 <20260918095940.2253018-2-honghuan@amd.com>
 <20260918100746.2BB741F000FF@smtp.kernel.org>
 <9fcb3203-63f4-4332-a47e-916774e11eb3@amd.com>
 <0e644466-8b4e-48bb-9322-e47c59c5c77c@rsg.ci.i.u-tokyo.ac.jp>
 <52c825a5-1b47-47c7-8717-d194953e2986@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <52c825a5-1b47-47c7-8717-d194953e2986@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/19 0:46, Huang, Honglei wrote:
> 
> 
> On 9/18/2026 7:27 PM, Akihiko Odaki wrote:
>> On 2026/09/18 19:13, Huang, Honglei wrote:
>>>
>>>
>>> This patch is for adding ROCm capset only, can be spited into another 
>>> thread if it is needed.
>>>
>>> Regards,
>>> Honglei
>>>
>>> On 9/18/2026 6:07 PM, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 2 potential 
>>>> issue(s) to consider:
>>>> - [Medium] virtio-gpu: premature UAPI exposure of unfinalized 
>>>> capability ID
>>>> - [Low] virtio-gpu: missing DRM UAPI alias for ROCM capability set
>>>> -- 
>>>>
>>>> commit a394228d77eeafc9f1dcc36150380f8561f1ee49
>>>> Author: Honglei Huang <honghuan@amd.com>
>>>>
>>>> drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
>>>>
>>>> This commit adds a new GPU capability set VIRTIO_GPU_CAPSET_ROCM 
>>>> with ID 8
>>>> to support ROCm compute workloads. The commit message notes that the
>>>> matching virtio-gpu specification change is currently in progress.
>>>>
>>>>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/ 
>>>>> virtio_gpu.h
>>>>> index 4f530d90058c7..3d4dfadc9d789 100644
>>>>> --- a/include/uapi/linux/virtio_gpu.h
>>>>> +++ b/include/uapi/linux/virtio_gpu.h
>>>>> @@ -321,6 +321,7 @@ struct virtio_gpu_cmd_submit {
>>>>>   #define VIRTIO_GPU_CAPSET_VENUS 4
>>>>>   #define VIRTIO_GPU_CAPSET_CROSS_DOMAIN 5
>>>>>   #define VIRTIO_GPU_CAPSET_DRM 6
>>>>> +#define VIRTIO_GPU_CAPSET_ROCM 8
>>>>
>>>> [Severity: Medium]
>>>> Is it safe to expose this speculative capability ID to userspace 
>>>> before the
>>>> virtio-gpu specification is finalized?
>>>>
>>>> The commit message states the specification change for ID 8 is in 
>>>> progress.
>>>> Because the Linux UAPI is frozen once released, exposing this ID now 
>>>> could
>>>> permanently commit the kernel to ID 8 for ROCm. If the OASIS virtio
>>>> technical committee assigns a different ID or rejects the proposal, 
>>>> would
>>>> this leave the Linux UAPI permanently incompatible with the standard?
>>
>> It is actually somewhat common to introduce a capset before updating 
>> the virtio specification, as capsets remain opaque to both the spec 
>> and the kernel without strict interface stability enforcement (for 
>> example, VIRTIO_GPU_CAPSET_DRM is still not in the spec). However, we 
>> must at least wait until the virglrenderer developers agree to 
>> implement it.
>>
>> An unfortunate complication is that gfxstream has already claimed 
>> capsets 7–9 prior to updating the spec or kernel headers:
>>
>> https://github.com/magma-gpu/rutabaga_gfx/blob/v0.1.85/ffi/src/ 
>> include/ rutabaga_gfx_ffi.h#L41-L43
>>
>> You could target capset 10 instead, but I advise coordinating with the 
>> VCL developers first to avoid further collisions.
> 
> Got it, will use 10 or 11 in next version.
> 
>>
>> Additionally, "[PATCH v8 2/4] drm/virtgpu api: add blob userptr 
>> resource" poses a more critical issue: it adds 
>> VIRTIO_GPU_F_BLOB_READONLY and VIRTIO_GPU_BLOB_FLAG_USE_READONLY, 
>> directly altering semantics explicitly defined in the spec. We should 
>> see at least a draft spec patch posted before moving forward, so this 
>> series should remain an RFC until then.
> 
> Will change to RFC in next version.
> 
> the VIRTIO_GPU_F_BLOB_READONLY  flag is for ensure host side will handle
> the readonly flag instead of ignoring that. Actually I think 
> VIRTIO_GPU_BLOB_FLAG_USE_READONLY is enough, but AI review requests 
> needs a VIRTIO_GPU_F_BLOB_READONLY  feature flag, maybe can remove it.

The AI review makes a valid point: we have to ensure the host actually 
handles the readonly flag rather than silently ignoring it. 
VIRTIO_GPU_F_BLOB_READONLY may or may not be the best solution, but 
whichever approach you choose, please ensure the patch explicitly 
explains how this host-side compatibility is handled.

Regards,
Akihiko Odaki
