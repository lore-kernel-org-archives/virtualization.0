Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F51FF1BB
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355935; cv=none; b=kSX2Y+YVLi9L25zHOHviEFo5IiuOp28cMbUlsJkvLEsbnzjJrcfgSgRtNsQJY+ALmeWbruulYE/KrmnkQhIh6mtBKLCU/1KGiUvzkGtFf/5r6JeUbRo1ob5JTJ/lVSn1LTKJ9Qmw5T9vJt1GQ6uhh6IhkG3lwhIGLOdiJvPxShk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355935; c=relaxed/simple;
	bh=9JT+ZDoAZ4iNRNoY0HJ1Su4PdVAt0nVZ6qmmMaDoW4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKKJCJShd34lVufvO5/d739YucYukl5nhAiWDv79t73YRTDknTf7kyzHJdjLTv67aG40/6E3dsX/cAr2/EB4lOMyqkRm+rFfX4HBA60IAi+WK++bt3nJfDGMtyrTNKbl3qDWgl26NxZBK0/dexc3U61/lPExHES8GmAYHbGr7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=TO1V2bMW; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TO1V2bMW"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B756C6081F
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 17:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eS7wUkmtLTxR for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 17:05:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=simona.vetter@ffwll.ch; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 54FB560835
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54FB560835
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=TO1V2bMW
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54FB560835
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 17:05:32 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-436249df846so356325e9.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736355930; x=1736960730; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKvx99e6g4Z0rpqLB9wRUAqjWOH2T8CbRV87JKLyuz8=;
        b=TO1V2bMWGyyOV/BroFVPLgOQ40hbQV2JLW9W9XzadHFj3KMVqCoT3XjYAuI8PPo685
         g2RfrjNd06jz3V0t0grhisU3dn8wZzlHRBrY4HV/Dyg/9k4URmGysTTt/V1kilQOpCBK
         YONs/yo/b984uG+K2uwCUfqxXvuIvuMRs/MBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355930; x=1736960730;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKvx99e6g4Z0rpqLB9wRUAqjWOH2T8CbRV87JKLyuz8=;
        b=eE4yiDWoKcgVbtemJh6qVaoj6sLVCtTw1gRKNhx7rqPntprUu6+ppAV/eoI4wZYPHL
         xN+YpFR+JJ+bg/NRgXebbezNliphM1Cbwi722QezvWd4FlCNQ5iO+/a1fsVDOgFOt76e
         U25FWsiMozDn3DZupHJI7hBBznpsTo59UXhJhCVm2XK8UeseZqxX2uJYNDkZx+3Zc3mx
         aUSg8xYi5MYAjEkzPTRPW6pFjmXIPse0+Eu6fJPk3gj8IYIGzM4MY4tiWMGxSo8Matnl
         KTJ17oXGuD3QVrguo3pHZ6lyPXRAFyB+jsFs4rPOoyJrCqL9yi30tNlBcPEHsuxnyKZL
         ZJmA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Zmi9+Kcfc0KaFFS1p7rCx51hH/lm4VLxC/6UdsqvCDtODza8n7cRF83N6s+ZUCIuKVYrcJfMZ7AYl7J+sA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzkYZwle0cjoUcClSclryxJeMzI4A4C8c0+JMN4ZR0PWXNCDETo
	UpNPxJ3njWeHd7yaIZa/drVjhK5xakSNSu8rX1cenUMxk6B/718SSYtH7pDSQaQ=
X-Gm-Gg: ASbGncvaNZwfz6OvpAlZmxWgOR757RRA/lA7i05t9XB2afjqKvOD7plNmmH8mHBsZjD
	2ZBxx5Nfcnxz7lDlh4lYANoU4fgu080+ySQ2L+OvWht6XSJSpbWeOIShsP5wBjO3iIe7PF1IUbj
	gi0HoqQbKQNWYBtS3kqa+ICPARWnz7dKOJ9gzyQzHk5D6Dj8BaJb8nXP+xhsBLEpEMJd/vfVhby
	Ad3V0JY75GCXG4UOwtd9NsnLglM/P2LcOb6EHfjaE67iZxMF2XGqAqDnW3F0udngYvk
X-Google-Smtp-Source: AGHT+IEvX8sJF+22nN0j17naG8VSCjm7ShZTKBpfpfH1JpRjytMJdmQiTcsKEjTDhwAIeG3CgHjK7A==
X-Received: by 2002:a05:6000:156c:b0:386:1cd3:8a0e with SMTP id ffacd0b85a97d-38a8731007fmr3232471f8f.48.1736355930091;
        Wed, 08 Jan 2025 09:05:30 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e357sm54692891f8f.72.2025.01.08.09.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:05:29 -0800 (PST)
Date: Wed, 8 Jan 2025 18:05:27 +0100
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
Message-ID: <Z36wV07M8B_wgWPl@phenom.ffwll.local>
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
 <de8ade34-eb67-4bff-a1c9-27cb51798843@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de8ade34-eb67-4bff-a1c9-27cb51798843@amd.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Fri, Dec 27, 2024 at 10:24:29AM +0800, Huang, Honglei1 wrote:
> 
> On 2024/12/22 9:59, Demi Marie Obenour wrote:
> > On 12/20/24 10:35 AM, Simona Vetter wrote:
> > > On Fri, Dec 20, 2024 at 06:04:09PM +0800, Honglei Huang wrote:
> > > > From: Honglei Huang <Honglei1.Huang@amd.com>
> > > > 
> > > > A virtio-gpu userptr is based on HMM notifier.
> > > > Used for let host access guest userspace memory and
> > > > notice the change of userspace memory.
> > > > This series patches are in very beginning state,
> > > > User space are pinned currently to ensure the host
> > > > device memory operations are correct.
> > > > The free and unmap operations for userspace can be
> > > > handled by MMU notifier this is a simple and basice
> > > > SVM feature for this series patches.
> > > > The physical PFNS update operations is splited into
> > > > two OPs in here. The evicted memories won't be used
> > > > anymore but remap into host again to achieve same
> > > > effect with hmm_rang_fault.
> > > 
> > > So in my opinion there are two ways to implement userptr that make sense:
> > > 
> > > - pinned userptr with pin_user_pages(FOLL_LONGTERM). there is not mmu
> > >    notifier
> > > 
> > > - unpinnned userptr where you entirely rely on userptr and do not hold any
> > >    page references or page pins at all, for full SVM integration. This
> > >    should use hmm_range_fault ideally, since that's the version that
> > >    doesn't ever grab any page reference pins.
> > > 
> > > All the in-between variants are imo really bad hacks, whether they hold a
> > > page reference or a temporary page pin (which seems to be what you're
> > > doing here). In much older kernels there was some justification for them,
> > > because strange stuff happened over fork(), but with FOLL_LONGTERM this is
> > > now all sorted out. So there's really only fully pinned, or true svm left
> > > as clean design choices imo.
> > > 
> > > With that background, why does pin_user_pages(FOLL_LONGTERM) not work for
> > > you?
> > 
> > +1 on using FOLL_LONGTERM.  Fully dynamic memory management has a huge cost
> > in complexity that pinning everything avoids.  Furthermore, this avoids the
> > host having to take action in response to guest memory reclaim requests.
> > This avoids additional complexity (and thus attack surface) on the host side.
> > Furthermore, since this is for ROCm and not for graphics, I am less concerned
> > about supporting systems that require swappable GPU VRAM.
> 
> Hi Sima and Demi,
> 
> I totally agree the flag FOLL_LONGTERM is needed, I will add it in next
> version.
> 
> And for the first pin variants implementation, the MMU notifier is also
> needed I think.Cause the userptr feature in UMD generally used like this:
> the registering of userptr always is explicitly invoked by user code like
> "registerMemoryToGPU(userptrAddr, ...)", but for the userptr release/free,
> there is no explicit API for it, at least in hsakmt/KFD stack. User just
> need call system call "free(userptrAddr)", then kernel driver will release
> the userptr by MMU notifier callback.Virtio-GPU has no other way to know if
> user has been free the userptr except for MMU notifior.And in UMD theres is
> no way to get the free() operation is invoked by user.The only way is use
> MMU notifier in virtio-GPU driver and free the corresponding data in host by
> some virtio CMDs as far as I can see.
> 
> And for the second way that is use hmm_range_fault, there is a predictable
> issues as far as I can see, at least in hsakmt/KFD stack. That is the memory
> may migrate when GPU/device is working. In bare metal, when memory is
> migrating KFD driver will pause the compute work of the device in
> mmap_wirte_lock then use hmm_range_fault to remap the migrated/evicted
> memories to GPU then restore the compute work of device to ensure the
> correction of the data. But in virtio-GPU driver the migration happen in
> guest kernel, the evict mmu notifier callback happens in guest, a virtio CMD
> can be used for notify host but as lack of mmap_write_lock protection in
> host kernel, host will hold invalid data for a short period of time, this
> may lead to some issues. And it is hard to fix as far as I can see.
> 
> I will extract some APIs into helper according to your request, and I will
> refactor the whole userptr implementation, use some callbacks in page
> getting path, let the pin method and hmm_range_fault can be choiced
> in this series patches.

Ok, so if this is for svm, then you need full blast hmm, or the semantics
are buggy. You cannot fake svm with pin(FOLL_LONGTERM) userptr, this does
not work.

The other option is that hsakmt/kfd api is completely busted, and that's
kinda not a kernel problem.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
