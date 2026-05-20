Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3C31328C
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264814; cv=pass; b=lToUEnPhazpL4Mzm4axEo3EpVyoVm/PCkH8apQ3ivTpkZp9990UbcHX5HXdlBtrKrwRNeLT44JI2hsPMPza+UpVf1qccDDRYvXdUXyZ7u6JJuwMfy2H+7r4cQBAqHtZ7TzqTSxEZt2grkqOnx1NaJ3ZFs984rv0H5bZ/9XT/mwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264814; c=relaxed/simple;
	bh=UuHZN8bLdDb35hsZfOIbiCsj2GNcJv+JahtKBFao7JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBlv7jmiVkawC0o9X1cf2epSMbF5wDnlcYPlPVOAFOwcfLsCO8z6lN/34Z/AJHC59haUF0navruBUqnzncMrpNSCphr1YwjcnUQ7OAut13BXxEF6L0zgASzSFFr1QwKaxTv2NQIyh/gQ3H4DP5PPezjv1GcectxwnkUE+/dlfrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Uh3wbPHC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Uh3wbPHC"
ARC-Seal: i=1; a=rsa-sha256; t=1779264795; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fhoFZAGE734g7YrwnK69+Fp+SlBP+e532/rwFxqqOg8FV5tdEIfaFORTiqM7n7YHad3es+GlWxlzsGHFrGKmdpYlnHvbmI07PynfxC0MmNg3KoTVLwV5hv//8Qm7A/9yCp5Bqp5lY06N0LRgOXEXr1Tm2J2d+40YejVZHso/9qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779264795; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1DaCzDhRImq3pbfy2r8JVXerCF/X/rQL52mfTWicG4k=; 
	b=K3aH/+VmSSz2zNU3CCHPtj8w3HqysMSbIPKHzatggDefM46va4bIfeUqv9Yi8u7NpUttUonl5naq6Pn/swZE223u1Adj+zj2Zvh30+EWyGv6ZzG7yNetKASukVSTLQVsaovI58YmPid6/GP6ZYkLAv9PWmFKpTYTPnzTcqVhyL4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779264795;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1DaCzDhRImq3pbfy2r8JVXerCF/X/rQL52mfTWicG4k=;
	b=Uh3wbPHCLetqao1sJ7Ww936T/0G+TEuQ9eZT1Mp+poKOwsOIjUnwdOOdRXAk4InP
	Uaty3nP1NfXa2mETMeGvPFJJqqvNUqPmcIWGCohU4EwEQ1nDdkykQdd/R7m2KjrSQ51
	g2CJSVyOSfXMx1O01zyUaaPNsikI0NgfwcNfxCrI=
Received: by mx.zohomail.com with SMTPS id 1779264793673372.72174741381184;
	Wed, 20 May 2026 01:13:13 -0700 (PDT)
Message-ID: <f37bdc63-3575-49e5-aa5b-7b93428b293d@collabora.com>
Date: Wed, 20 May 2026 11:12:53 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/virtio: use uninterruptible resv lock for plane
 updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Deepanshu Kartikey <kartikey406@gmail.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260519082247.34470-1-kartikey406@gmail.com>
 <2e23513c-9d59-4891-acfe-9f1fbcbce778@amd.com>
 <f6bcef23-5510-4aad-bf6a-4e1ecfc8d474@collabora.com>
 <a0f2cfd5-d4df-4e50-a52b-d5befbc2e481@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <a0f2cfd5-d4df-4e50-a52b-d5befbc2e481@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/20/26 10:05, Christian König wrote:
> On 5/20/26 08:50, Dmitry Osipenko wrote:
>> On 5/19/26 11:27, Christian König wrote:
>>> On 5/19/26 10:22, Deepanshu Kartikey wrote:
>>>> virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush() lock
>>>> the framebuffer BO's dma_resv via virtio_gpu_array_lock_resv() and
>>>> ignore its return value. The function can fail with -EINTR from
>>>> dma_resv_lock_interruptible() (signal during lock wait) or with
>>>> -ENOMEM from dma_resv_reserve_fences() (fence slot allocation),
>>>> leaving the resv lock not held. The queue path then walks the object
>>>> array and calls dma_resv_add_fence(), which requires the lock held;
>>>> with lockdep enabled this trips dma_resv_assert_held():
>>>>
>>>>   WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
>>>>   Call Trace:
>>>>    virtio_gpu_array_add_fence
>>>>    virtio_gpu_queue_ctrl_sgs
>>>>    virtio_gpu_queue_fenced_ctrl_buffer
>>>>    virtio_gpu_cursor_plane_update
>>>>    drm_atomic_helper_commit_planes
>>>>    drm_atomic_helper_commit_tail
>>>>    commit_tail
>>>>    drm_atomic_helper_commit
>>>>    drm_atomic_commit
>>>>    drm_atomic_helper_update_plane
>>>>    __setplane_atomic
>>>>    drm_mode_cursor_universal
>>>>    drm_mode_cursor_common
>>>>    drm_mode_cursor_ioctl
>>>>    drm_ioctl
>>>>    __x64_sys_ioctl
>>>>
>>>> Beyond the WARN, mutating the dma_resv fence list without the lock
>>>> races with concurrent readers/writers and can corrupt the list.
>>>
>>> Well why are you trying to add a fence on an atomic mode set in the first place?
>>>
>>> That is usually an illegal operation here.
>> That is pre-existing in the driver. It performs draw operation and in
>> some cases waits for the completion during atomic. Whether all that
>> syncing is correct is hard to say immediately as some of it may be
>> historical edge cases.
> 
> I'm not not so deeply in the atomic mode setting stuff but it strongly sounds like that this is seriously broken.
> 
> The background is that the atomic mode set framework allows an output dma_fence which is signaled when the commit is finished.
> 
> So when you allocate a fence slot and add a new fence to finish the atomic commit it is trivially possible that this cycles back and waits for the atomic commit to finish. In other words you have a deadlock.
> 
> You probably need specially crafted userspace with the right timing to trigger that, but such issues are usually a rather big no-no and need to be fixed in the long term.
> 
> Try to add dma_fence_begin_signaling() and dma_fence_end_signaling() annotation and enable lockdep, the tool should be able to point out if and what exactly goes wrong.
> 
> The usual fix is to prepare everything before commit_tail is called (alloc memory, create, reserve slot, add dma_fence etc....) and then just send out the prepared commands later on.

We tried with moving resv alloc to prepare_fb() in a previous patch
version, it resulted in a non-trivial deadlocks. The goal of this patch
is to fix immediate problem with a minimal code change.

What you're saying is correct, but it may require a rather big
refactoring of the code. In general, everything works okay today, so not
really an urgent problem.

-- 
Best regards,
Dmitry
