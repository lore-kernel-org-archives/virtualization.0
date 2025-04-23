Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA627D76A
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418523; cv=none; b=EBx+Msl7+ffce39689Jry15kU3o05KXrHzmZRO2qFg6I7hh/UQNIL47GBaCpuVLUoRjEU7vjiD4qWUqsdmySo/9C4LFz7YuzRIlO9FVW3iEf8S+rE47zl7h3RmyArKTstwYeKrcVaZaYlgPOot/E4YgfR4n6yeHFfcds0CqcL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418523; c=relaxed/simple;
	bh=olgEi8hkKOP25EqBnRGPkbqDG4k0ZvkVsXbAyxVuiMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hitDm7YBwXP9HGFp1BnSNPe6HYLiCUxxuBc7NV5BqzQFvKuTUAd1zrtsLLcLZ6ahGmnzzt2Gzbxn9jgiPpOxN12g61aYYaWfnncyv8NUAwjQDCNHxaa6vhU2UsvfICLkI4DP4pZ/NW728nsy+owehkEsJ/zzLd1u+3rVDQk8ZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ih45yH3Q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ih45yH3Q"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-afd3f1adff7so790292a12.1
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745418521; x=1746023321; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=40rtvLOwDeuUbiOuCoW1t5olyX8gz8CZJ5ahJ10eU+w=;
        b=Ih45yH3Q5mBXwEiiMW37Q05gGhwM34LAoVXo7vNAHo4NBUCituUBJII6f9P05PcVKL
         i3M9hbGzM04u9M6qsOJXSmrHFmU8xStnMqBTsKjR5Vij6HStn4ohbPyey1dw43oDm74Q
         H6bqSvkW+kVPvfMrOV03AWiZxB0G1PpV/IEKMMzIDg3Vnku+MyjPaTcvOIZdHLP+1dKx
         kZxNo91o2fjqNsgMqFDFoRrqY1mmUk4xXIVQNBRhMR+Xs6NykGVBZXSmkPjl4Q2QA7yK
         jzVr2sMInkfMoG2u1yhle+r9DLvoKOKFfU2bjUzI0baEKG9LVbAZ3K0D2E7OnMyvhqS5
         ssuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418521; x=1746023321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40rtvLOwDeuUbiOuCoW1t5olyX8gz8CZJ5ahJ10eU+w=;
        b=lrZDFIQjuLDpkm1i2YbYOI/vyGkC6+PVMzmdFuXng2cfGXRI/LHlNtvsDJ8OFKU996
         Fg+Vuj8k2kNJ6AH/r4frq9FaTRMLxelOcnnEoEtS9fq/fqq0/YUAj//JTzoWLTo/J7gs
         BeFYM7+iIHSEqLW4TepFn0SaScxh+jdkVQ5UnDVQsY8rkFfwU59JavV/ws6P5LUmIAPf
         NSZIKYVZ8u2i4bNBZffnw3dPCZpmW2laUEFqA69016sxXWPOWSJn3tuaUNv3CXS/RY21
         7TTZW3dNB+BHyOpYikVdJVEDbNyyic7bixpXgVofeoDzq58UV9jfA9GeZAYUJxqRlBVG
         8oLw==
X-Forwarded-Encrypted: i=1; AJvYcCWBlkR7ZRSQjJVjagS5sDh1HfjqWQOMQJfTWzQvkE366eY9WGpIqZ0Bw+79f8Vm/IfYqQenrdMLAbMmGAAJYA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnfs9x7RwvnwzmfbVF3jKaYigUu1JWnsH5geaWK8usvWMlO9IN
	gSrLnVUjVz/zvbuGJ2LvQR7ctAwCugeytsBtCG9WUCX4DT157noznrtHIPrHnKYbv3AjvSg/+o1
	qTw==
X-Google-Smtp-Source: AGHT+IEHFWhYz0oAsCQCzYVGgs17eJ2RdOv2pA+CJ/89PxdUza1pyAyGtkAfHJad1QU5DCSNGF6B8Gtgtdo=
X-Received: from pjxx4.prod.google.com ([2002:a17:90b:58c4:b0:301:1ea9:63b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c2cd:b0:2fa:21d3:4332
 with SMTP id 98e67ed59e1d1-309df187b6dmr4574319a91.12.1745418521285; Wed, 23
 Apr 2025 07:28:41 -0700 (PDT)
Date: Wed, 23 Apr 2025 07:28:39 -0700
In-Reply-To: <20250422082216.1954310-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250422082216.1954310-1-xin@zytor.com> <20250422082216.1954310-4-xin@zytor.com>
Message-ID: <aAj5F9IZXG7MB0ai@google.com>
Subject: Re: [RFC PATCH v2 03/34] x86/msr: Rename rdpmcl() to rdpmcq()
From: Sean Christopherson <seanjc@google.com>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, 
	jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com, 
	pbonzini@redhat.com, vkuznets@redhat.com, luto@kernel.org, 
	boris.ostrovsky@oracle.com, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Xin Li (Intel) wrote:
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/events/amd/uncore.c              |  2 +-
>  arch/x86/events/core.c                    |  2 +-
>  arch/x86/events/intel/core.c              |  4 ++--
>  arch/x86/events/intel/ds.c                |  2 +-
>  arch/x86/include/asm/msr.h                |  2 +-
>  arch/x86/include/asm/paravirt.h           |  2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 12 ++++++------
>  7 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index f231e1078e51..b9933ab3116c 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -152,7 +152,7 @@ static void amd_uncore_read(struct perf_event *event)
>  	if (hwc->event_base_rdpmc < 0)
>  		rdmsrq(hwc->event_base, new);
>  	else
> -		rdpmcl(hwc->event_base_rdpmc, new);
> +		rdpmcq(hwc->event_base_rdpmc, new);

Now that rdpmc() is gone, i.e. rdpmcl/rdpmcq() is the only helper, why not simply
rename rdpmcl() => rdpmc()?  I see no point in adding a 'q' qualifier; it doesn't
disambiguate anything and IMO is pure noise.
