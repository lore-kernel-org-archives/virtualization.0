Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE657D23A;
	Thu, 17 Sep 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654292; cv=none; b=DkE18Jf2GssASwUr99Fn5wOwj30ukn/U1G5alSeNobUnutI1mObRxokNS6YfD7384jEfnabH+DKQSktamkB54bxvyq5QFa+wgFoqWdtzWC86+bDMtMpINlHfyVeQh16drTkxLGXERB0gOqGqHKbanuc+9TObm+n14E4eXq31JCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654292; c=relaxed/simple;
	bh=ciU4WDb+lcH0Z5OvqNv8yitRvgapjBHaEXNFXV7O6QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5J5W+vePygrgK9FQJnKUR0BCoy8D+3EIgVUOOGG4fvgs5jZ4VfDN0yozA0WyTIgX9tjMXbbp0Uqa3IGB9HziewWEO1MErcNLxNzBBU728ZqGTGmBpt9bOhvHNW+8N62JTUZvlXunbWHO2rmzMTTdAqL9alvMOi6S7hgjFOXa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1gZZBs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1gZZBs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAC01F00898;
	Thu, 17 Sep 2026 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654285;
	bh=sw4l7egVZZpkPzWMWuKshNPwKQcv/aeVFEewmWZph6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m1gZZBs2FdM1OsR9HuCvJkBrBPcyP7FDAAzZnM19MxOjrJLUDxSsUUTiTHDyps8Od
	 qQamiGr2+F78lXRKoIsuDmsnmwBfnRKLt9JtZsXOkMPxONkHm6rmibvVjpFQwgLMoB
	 O3dio6A7ygEsQbXzzPzguIAgOLneOP0XW2Lchzl1T9gplanxkg4QhFAN8i54FBSkT3
	 fTozIrobETMpXpC2U5zruYBoWBZfA9tR6iBbOpgJS9FB/1fhHobzLSG8ZOcTmex8/n
	 tpwruUiqP4HXZ2tmXNNJ1riTncde98KzoboJcjlRs5iid1fOIM2eM+q9jawebzcAur
	 0Z89AJPwywDiQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id DC180198004A;
	Thu, 17 Sep 2026 10:11:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 10:11:21 -0400
X-ME-Sender: <xms:BfWrasERx0bB0bQpen8UY-FjGVSE7vCNnIZ2D0aRNJTX5pjpsZJkFg>
    <xme:BfWrau3XEvQvuLMxZ9WELL-eWCyvs0ZTR171fgmFImTRM0M4G-DO2K_NUF6p9cQ_g
    ixdxYBTMwsdbhqIguHadeIrfg2msPjONvCvamirrUh1PviCBlpRAONd>
X-ME-Received: <xmr:BfWraqYKNKGLnqsM5J2q7-ZHNFwYUxgMtKlaJL_Mz4SgnHGx5nKaGoZTmkw>
X-ME-Proxy-Cause: dmFkZTFQhJTCOy0YHIilx9900UfTpNvB34YFJiLNooiGSVb0X0+i17bCb5sAQsuLM4KruI
    dvsoPorMOMMYqAxO2DV21waGwNq85WpddXnct2choRCqkriiPtWZwJSD/E+2sC/TR/5LJC
    QAXCpBpPsqJAESSaRrlPaePdvhn7KHnK3U3kCpoo+lao8OupTd1eF1VCtRg0LwmpTVEpHm
    WYB3aLcRIwUWTuU/E2rpNvbjSQwXo/nbf71ZypkmtdH5i3YDnrSNkgb2ZQZg4hCpLWQpap
    ZS8iBYkdEdu7VwyUz17Hbw5Z1Ztfq2J376o2mKktQqYnxRczNYRLsD8XZ4ZIzI1LQoxvR4
    7vfmFO60v62faua+6UuZ/FWXjMhET8yC0owKNgiolW8HG4g+JBBhKJZ1JGW5aTKw8/LnwK
    vYfO9iVoP2uUVfzvkEbxeWeuHRr7etQL41JftUTG0QTvYmj762Ikfj8G60IjYN0aS54m4E
    87UOdPS1OclRtHI5oHufH45DAiqQBfREpGW7qfaSjyk45Iy6Umfl5qmHXsn/ALoFC+ZinD
    TygddqlYc4pXgQMnTmjbZI+gBUZ2YUMze9+L074Ub7p4Qz9IIc2XVs4VxnZN0RdS0avSxP
    gDNtd2nFUxqJUJ0fzGHDpmm2qgtliD0UN1bnTXF0R5tOJajKPrDzMO998uZA
X-ME-Proxy: <xmx:BfWralr3PphkjPXQ1w6ofPx7F9fh_RVIqjs7iioZ-5QP97J9akp7UQ>
    <xmx:BfWraq1933UaajS6j7oE36Kyne2rgqCmOhxHTmssnyS7ALzgzy3uJA>
    <xmx:BfWrauUM6FfwyBX7iyjn7m6bI7Ll9uUv0cRzvNmloyri599Lpb2G4A>
    <xmx:BfWrarU_R-VIRJxSjt5VfBYNlNFCobVMeltrAZ3edhioruVNhPFrXA>
    <xmx:BfWraiDP36XwqmVTsJk_pmZ0BVHsjaBgAmARcAGw24PmOEFtS11wilkY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 10:11:16 -0400 (EDT)
Date: Thu, 17 Sep 2026 15:11:15 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted
 guests
Message-ID: <aqvxQoIoYhJTZpAC@thinkstation>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
 <aqqGUAX65s4LdJkr@thinkstation>
 <CABQX2QMAfszf3z+Auo0AdwGsf94kTX0DrTrd8k6G1PTNMYsdXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQX2QMAfszf3z+Auo0AdwGsf94kTX0DrTrd8k6G1PTNMYsdXQ@mail.gmail.com>

On Wed, Sep 16, 2026 at 11:41:19AM -0400, Zack Rusin wrote:
> > I acked 1/2, but I don't like where 2/2 does the conversion.
> 
> I saw that, thank you. Since I'll be respinning v2 of this I can go
> ahead and drop the unused DECLARE_PER_CPU_DECRYPTED in that one if you
> want as well.

Yes, please.

> I went through the linked thread, including the dropped 2022
> Quote-buffer alias approach and the 2024 netvsc work's kexec
> regression, fix and re-review discussion. I will keep TDX vmalloc
> support out of this series and correct the explanation to cover alias
> consistency, direct-map splitting and load_unaligned_zeropad(),
> including removing the suggestion that per-page GPA lookup alone
> resolves it.
> 
> After tracing the boot paths, I think there are two distinct pieces
> here. The SEV boot GHCB needs .bss..decrypted before BSS is cleared,
> whereas the SMP per-CPU instances do not exist until
> setup_per_cpu_areas(). KVM then registers its boot-CPU per-CPU buffers
> in smp_prepare_boot_cpu(), so the common conversion needs the early
> primitive you proposed. A shared early_initcall would be too late for
> KVM. The UP registration path probably also needs handling separately

Agreed on all of that. Leave .bss..decrypted alone in this series; the
SEV boot GHCB pins its conversion to the startup code and nothing on
TDX needs it today.

With the primitive called before smp_prepare_boot_cpu() there is no
readiness state to track.

For the vmalloc-backed case, I would rather not handle it at all. Force
the embed allocator when memory encryption is on: ignore
percpu_alloc=page with a warning and don't fall back to page mode if
embed fails, just let it hit the existing panic. On 64-bit embed only
fails on memblock exhaustion at boot or when the NUMA groups spread over
more than 3/4 of vmalloc space. Neither happens in a guest.

> My suggestion would be to do one of two things (or at least I think
> those two options are realistic to me, given that I'm no expert here):
> - add the central per-CPU infrastructure and migrate KVM/VMware
> together, removing both loops and putting the TDX vmalloc rejection
> and readiness state in common code. Would you and the KVM maintainers
> be happy with that first, and generalizing .bss..decrypted separately
> while preserving its earliest SEV setup? afaict the latter also needs
> to broaden the annotation and linker guards, and changes kvmclock
> storage and sharing on TDX-only builds.
> - a smaller VMware fix using a separately allocated, direct-mapped
> page per CPU while the common infrastructure is developed. Using the
> normal allocator would also defer ordinary-guest registration, unless
> I kept their current static storage as a second path. This option
> would retain caller-managed sharing and buffer lifetime handling.
> 
> The second option is, of course, easier for me, but I'm happy to do
> the first to get steal-time storage working for us. Do you have any
> thoughts on this?

The first one, please. It is the better long-term shape and it removes
the KVM loop as well, so the per-CPU section finally does what its
name says.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
