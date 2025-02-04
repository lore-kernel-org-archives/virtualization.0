Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE92080DA
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Feb 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665969; cv=none; b=msiVezblgydsnfVJQ6Y1WdvaBICQtq1R+NcYfifQR4vk5ia5Cex8ckrpex6u+a2OLAfYFJHidwogZd6MOx8XkRowDWO7qigw/AfAHYaivQq7lO2MWOCZw0XZCBOrLn5UIECaL5YTQuAEdAwZJWdFHdlgrePZNZoPrhAe0zcL4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665969; c=relaxed/simple;
	bh=SAKZdCpF6VWRRRVgXzqc0IBfTpqzPm6KgOgVIbkAD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYRLn98heE/5AZhuu0Yq8b+wE4ntQ6IHgg0t76WYIE8blHE4BvhqK8v/x4FKdloQktMoUeXT4azj1tfIyS8l04h7CZ41UB4AjSFVQzT3LIreGq0FhH+5GoOlVqN+gn8UJ26WT72vH8+fW+bAAbhatgWjnMoYvJ+RpN99/VrGwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=iSxWOXpo; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iSxWOXpo"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CFB260608
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Feb 2025 10:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YavkeQpVoYqh for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Feb 2025 10:46:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=simona.vetter@ffwll.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 02D2B6006A
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02D2B6006A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=iSxWOXpo
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02D2B6006A
	for <virtualization@lists.linux-foundation.org>; Tue,  4 Feb 2025 10:46:02 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-38632b8ae71so4559794f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Feb 2025 02:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738665960; x=1739270760; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTqSzT/TXDWQqYRy4tctsFxrDEke2AKGwuYUOQfB5/U=;
        b=iSxWOXpooKUEACYDdfYiPFuqomHewHS7hmGJ23KX0fsgNkX79eLgCyKtBtUArxKnq6
         tzGJBHQXeCLvw+sYddJxccNXaLjDwTUygD2cB51w0IZOkTixdA/gUO6cDVEdmyTehE8x
         dWPWets6Y8vE+Rp1xlLKWoWzf1ovA5oll0k6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665960; x=1739270760;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTqSzT/TXDWQqYRy4tctsFxrDEke2AKGwuYUOQfB5/U=;
        b=M1YIElC0up7ELB0fEquNAFlSdXnAIXiI2KoIgda4fN27QolfbMq9NDsxBcV40aOx13
         C+SDxq5/pJ1SHPBKqp6iUXhKgD1aGdyR7n8DAv0m2ZDjSSsnueosi7XoUNuuPjlcOeTW
         ppReACVmSow3syfOygO25xBaXlE/KunxdBnu35Ap6aAoOCp4DRGzHLvPz/jyDOCaMKNb
         uG+UCVXj/ch7uFGnycA+BwbFcmcsBQ57/4vyfUwtCwEl7qwi9ye0wM8bSGqzjA2rPDjj
         /5VBsG0rV74cBhx5t5x36Hc2UuJw4FVhcaaA+iBviqu0PwWeDMO7Z86mDYz1GNoRmU8n
         9/xA==
X-Forwarded-Encrypted: i=1; AJvYcCX4mRwIinA9U7yC7SmgenGcW/lQYVr7XegB+i9fvBpzWuaPnpaMHp7z0qn5UILd7NTarIsECqbSZAfR+N44sg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwNL/Lq9IcnkA2+pmea8aISdBmOC1Nck1qYaVsKGB1K8B6P445S
	jIy+5jjTxeWoDxNhT8eXsx7VWAWQffqBrXp822rkGTszyc4DBnU5ISKRubfy+dg=
X-Gm-Gg: ASbGncu7ZQMF545tu1F3QJhDgvXs4UVvlXTc5wruxG4w8cn3I6N/Awh+irGDpFFB7I0
	WfdAkH2fi0cr952YccUOqJpKIg7ojIAiOw9SElSSEr2IdAQuDbii1YyT/sdDdh3QvF97EWWtq1z
	SDFpkcaQAbrjpEAYIC/Sl7HTZYlEMwj8tUCJ0JQXgNgdmdW17Pt+v5JFkPismRhHTASKbCJL9hq
	Fz+lvZ2ba51EQCT2OtIPquEl2ZrRhz055IdkYy/Yv0aa3DXrZAT/KIQqEst9qjiqNC5JGt8m5Ad
	5dprUP6IEglLoX2bQxZD3mLETgM=
X-Google-Smtp-Source: AGHT+IGWhHTEnUp8RUiWMKHvCVuyT8/rXL2ynOFabY336YUpw5mRZI1i4GZUr3SXSEIaoymXJPH+Tw==
X-Received: by 2002:a05:6000:1faa:b0:385:fa3d:1988 with SMTP id ffacd0b85a97d-38c5194ca8emr22392899f8f.8.1738665960211;
        Tue, 04 Feb 2025 02:46:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc13139sm220098775e9.3.2025.02.04.02.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 02:45:59 -0800 (PST)
Date: Tue, 4 Feb 2025 11:45:57 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: "Huang, Honglei1" <Honglei1.Huang@amd.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Lingshan Zhu <Lingshan.Zhu@amd.com>
Subject: Re: [RFC PATCH 3/3] drm/virtio: implement blob userptr resource
 object
Message-ID: <Z6Hv5esGqHWU2TVe@phenom.ffwll.local>
Mail-Followup-To: "Huang, Honglei1" <Honglei1.Huang@amd.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Lingshan Zhu <Lingshan.Zhu@amd.com>
References: <20241220100409.4007346-1-honglei1.huang@amd.com>
 <20241220100409.4007346-3-honglei1.huang@amd.com>
 <Z2WO2udH2zAEr6ln@phenom.ffwll.local>
 <2fb36b50-4de2-4060-a4b7-54d221db8647@gmail.com>
 <40485636-7ea3-4e34-b4bb-1ccaaadd4e47@amd.com>
 <62aeac90-1ba6-4e22-9465-fee95973a6bf@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62aeac90-1ba6-4e22-9465-fee95973a6bf@amd.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Mon, Jan 20, 2025 at 05:54:10PM +0800, Huang, Honglei1 wrote:
> On 2024/12/27 10:02, Huang, Honglei1 wrote:
> > On 2024/12/22 9:59, Demi Marie Obenour wrote:
> > > On 12/20/24 10:35 AM, Simona Vetter wrote:
> > > > On Fri, Dec 20, 2024 at 06:04:09PM +0800, Honglei Huang wrote:
> > > > > From: Honglei Huang<Honglei1.Huang@amd.com>
> > > > > 
> > > > > A virtio-gpu userptr is based on HMM notifier.
> > > > > Used for let host access guest userspace memory and
> > > > > notice the change of userspace memory.
> > > > > This series patches are in very beginning state,
> > > > > User space are pinned currently to ensure the host
> > > > > device memory operations are correct.
> > > > > The free and unmap operations for userspace can be
> > > > > handled by MMU notifier this is a simple and basice
> > > > > SVM feature for this series patches.
> > > > > The physical PFNS update operations is splited into
> > > > > two OPs in here. The evicted memories won't be used
> > > > > anymore but remap into host again to achieve same
> > > > > effect with hmm_rang_fault.
> > > > So in my opinion there are two ways to implement userptr that make sense:
> > > > 
> > > > - pinned userptr with pin_user_pages(FOLL_LONGTERM). there is not mmu
> > > >    notifier
> > > > 
> > > > - unpinnned userptr where you entirely rely on userptr and do not hold any
> > > >    page references or page pins at all, for full SVM integration. This
> > > >    should use hmm_range_fault ideally, since that's the version that
> > > >    doesn't ever grab any page reference pins.
> > > > 
> > > > All the in-between variants are imo really bad hacks, whether they hold a
> > > > page reference or a temporary page pin (which seems to be what you're
> > > > doing here). In much older kernels there was some justification for them,
> > > > because strange stuff happened over fork(), but with FOLL_LONGTERM this is
> > > > now all sorted out. So there's really only fully pinned, or true svm left
> > > > as clean design choices imo.
> > > > 
> > > > With that background, why does pin_user_pages(FOLL_LONGTERM) not work for
> > > > you?
> > > +1 on using FOLL_LONGTERM.  Fully dynamic memory management has a huge cost
> > > in complexity that pinning everything avoids.  Furthermore, this avoids the
> > > host having to take action in response to guest memory reclaim requests.
> > > This avoids additional complexity (and thus attack surface) on the host side.
> > > Furthermore, since this is for ROCm and not for graphics, I am less concerned
> > > about supporting systems that require swappable GPU VRAM.

I kinda ignored this one, because from my point of view it's all clear.
But I guess better to elaborate some more.

> > Hi Sima and Demi, I totally agree the flag FOLL_LONGTERM is needed, I
> > will add it in next version. And for the first pin variants
> > implementation, the MMU notifier is also needed I think.
> > Cause the userptr feature in UMD generally used like this: the
> > registering of userptr
> > always is explicitly invoked by user code like
> > "registerMemoryToGPU(userptrAddr, ...)",
> > but for the userptr release/free, there is no explicit API for it, at
> > least in hsakmt/KFD stack.
> > User just need call system call "free(userptrAddr)", thenkernel driver
> > will release the userptr
> > by MMU notifier callback.Virtio-GPU has no other way to know if user has
> > been free the userptr
> > except for MMU notifior.And in UMD theres is no way to get the free()
> > operation is invoked by user.
> > the only way is use MMU notifierin virtio-GPU driver and free the
> > corresponding data in host
> > by some virtio CMDs as far as I can see.

Yes that's what I meant that you need real svm/hmm here. You cannot fake
the amdkfd/hsakmt model with pin_user_pages, it fundamentally falls apart.
One case is overcommit, where userspace malloc() a huge amount of virtual
address space, registers it with the gpu, but only uses fairly little of
it. If you pin that all, you run out of memory or at least thrash
performance.

For the hsa/kfd model, you must use hmm+mmu_notifier, or you're breaking
the uapi contract.

> > And for the second way that is use hmm_range_fault, there is a
> > predictable issues as far as I can see, at least in hsakmt/KFD stack.
> > That is the memory may migrate when GPU/device is working. In bare
> > metal, when memory is migrating KFD driver will pause the compute work
> > of the device in mmap_wirte_lock then use hmm_range_fault to remap the
> > migrated/evicted memories to GPU then restore the compute work of device
> > to ensure the correction of the data. But in virtio-GPU driver the
> > migration happen in guest kernel, the evict mmu notifier callback
> > happens in guest, a virtio CMD can be used for notify host but as lack
> > of mmap_write_lock protection in host kernel, host will hold invalid
> > data for a short period of time, this may lead to some issues. And it is
> > hard to fix as far as I can see.

I forgot the exact details, but when I looked amdkfd was taking too big
locks in the migration paths, which results in deadlocks. Those were
worked around by taking even bigger locks, the mmap_write_lock. But that's
a design issue with amdkfd, not something fundamental.

hmm only needs the mmu_notifier callbacks to work, meaning either context
preemption and restarting, or tlb invalidation and gpu page fault
handling. Those you can forward between guest and host with no issues, and
with hw support like pasid/ats in iommu this already happens.

Note that the drm_gpusvm library that's under discussion for xe had the
same issue in version 1 of relying on mmap_write_lock to paper over design
issues. But the recent versions should be fixed. Would be really good to
look at all that. And then probably do a full redo of the svm support for
amd in amdgpu.ko using all these new helper libraries, because my personal
take is that fixing amdkfd is probably more work than just writing new
clean code.

> > Finally I will extract some APIs into helper according to your request,
> > and I will refactor the whole userptr
> > implementation, use some callbacks in page getting path, let the pin
> > method and hmm_range_fault can be choiced
> > in this series patches.
> > 
> > Regards,
> > Honglei
> 
> Hi Sima,
> 
> I modified the code, remove all the MMU nitifior and use pin_user_pages_fast
> only. Under this implementation userptr fully
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

pin_user_pages is fundamentally broken for the hsa memory model, no amount
of benchmarking different flavors of it against each another will change
that.

> And I found a another thing, it seems like in intel i915 userptr
> implementation, the pin_user_pages is also used in MMU notifior.
> Code path is: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/i915/gem/i915_gem_userptr.c?h=v6.13#:~:text=ret%20%3D%20pin_user_pages_fast(obj%2D%3Euserptr.ptr%20%2B%20pinned%20*%20PAGE_SIZE%2C

Yeah i915-gem isn't great code and shouldn't be used as example for
anything. This is Dave&me asked Xe developers to create a lot of the
infrastructure in drm libraries, to make sure we have a solid design here
and not what i915-gem did.

Also note that i915-gem userptr is for buffer based userptr, like for
VK_KHR_external_memory if I remember correctly. This is not the hsa memory
model at all.
> 
> Patch set: https://lore.kernel.org/all/159353552439.22701.14005121342739071590@emeril.freedesktop.org/T/
> https://patchwork.kernel.org/project/intel-gfx/patch/20210323155059.628690-17-maarten.lankhorst@linux.intel.com/#24064663
> 
> And I didn't find the hmm_range_fault code path, maybe I missed it?

i915-gem never supported the svm/hsa memory model in upstream, so yeah
it's not there. For drm/xe see the work from Matt Brost that's currently
under discussion on dri-devel for what it should all look like.

Cheers, Sima

> 
> Regards,
> Honglei
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
