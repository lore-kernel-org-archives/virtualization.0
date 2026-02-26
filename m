Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738323B5303
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130300; cv=none; b=SC5tMjyoURZNVV6liQegRe/xcbjCfipcqMjSrigcE67R6ZnYfT7uamYeI9Sd0Du2ttwJWCAFNgv1/fr3MRmzzT3P+ep9JQH4pFQrWc5h3VmvBvPI1Vbcu6h6aYQqGcaoRhTUclroHG1bjE9mI9Cn5UuYLVdhWOHFfEiuIxzPS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130300; c=relaxed/simple;
	bh=k3soXQkk7YLuqSivAHD1V0eG6RUMSXYigk1r/BeTy8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qbkZI0aJDDMYq+yBeK1I826SKZMPqf7UwSarvD64zKEvLsojCbdUgNvlRumFEWpTCEfgWVx9BwCZFEQEAcztQd/N/TiO3c5eBOefOaYButjKWiber8buZdq7u0WzmEexC6oTVYbxm8YNnLpePaFRiEWbfEW/FNXUklG4gC6yx+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeMbif8Z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeMbif8Z"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2add59d1a5aso10255225ad.3
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772130298; x=1772735098; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3CnbC2LzEBnADf0H4jNpgSa/BKh2OZoa8tvpC3rGZ8=;
        b=CeMbif8ZVCTcO4I3noDWjIjatjpJZZ7F/+D2BHo6j8tW5dOCxU0M0PDSWo4uSD6xcK
         psiGcwMI3meZzQIghHL66NwNUtLT73WA6ZWmqh4na2hIv+brcpWhTLr716u406svXa3W
         ok5WoPAJRV3EdlybieKG2HHUryqNJdLgYW4eITyoR7lGRtWoEXphq5UXG1TX+5sPuTIJ
         hnptfqyU9djfuZ01VFX/Z5GIy10hXfyih9bHY2E5L2ed2M7y2jogfwqH4a3i+oHCgVOO
         VsdkWFhN5PHlIkTdPvOwKjBPj0qK1QeW7asDnWrMxyPbkBJ0MFDjE/XsLZFjdmw1mHGe
         OShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772130298; x=1772735098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3CnbC2LzEBnADf0H4jNpgSa/BKh2OZoa8tvpC3rGZ8=;
        b=K6YsQZgrRHO2htD19Qla166gc/oHU5lIlfqbPBPoFgtlqYk+HU6HtFKuF8ZQd6oNWg
         pCCYwD416XaGf9V9a/zOBDaP8yY161EPZpO9JP1AwDhK1BsC3sieL0Rw01qAEaOUeyF3
         0mDZjIcXrwwmOENQn1wF7BiTc1rylTQ0i345zEAPDxdFHpXqUTb7sdKCfIwBlyjoMAyl
         +Tn786p4hA0X7CciLYFKHt8a/w+cfKxojAwNh++FrlcKW0pTNk4wxcSH/ti44VC4fh4f
         cjW9Gfr5wEdzn/3nK7LrulWM7tYmXjlGFc3o6+xEXlMTvCcK8PqmAm80m7XEdHCGwwFP
         JDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHiZhReCXUJDvmwULbDmTPSgijnWYQA1DcliJhdTGRkYS3L8phrMRjGMqOenalhwQnHFwS/y3oPsN0tJuZEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdY2vTYn9HL8jBNDUtO3R61MhvycTW9cwKD6TVoYIWcTkRKjEv
	ij3X0/upyvf5Tjei4+waO+4VKuKsRXZrjDQtoW2Q8SNtL5aI/tYXY0RfsjQuxotYtW7ZdziR9YU
	6sz7GTA==
X-Received: from plau11.prod.google.com ([2002:a17:903:304b:b0:2aa:e682:e951])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e849:b0:2a7:d5c0:c659
 with SMTP id d9443c01a7336-2ae0305efc8mr36873085ad.5.1772130297522; Thu, 26
 Feb 2026 10:24:57 -0800 (PST)
Date: Thu, 26 Feb 2026 10:24:55 -0800
In-Reply-To: <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260202074557.16544-1-lance.yang@linux.dev> <20260202074557.16544-4-lance.yang@linux.dev>
 <aZ9Xcgxa0_ouGr31@google.com> <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
Message-ID: <aaCP95l-m8ISXF78@google.com>
Subject: Re: [PATCH v4 3/3] x86/tlb: add architecture-specific TLB IPI
 optimization support
From: Sean Christopherson <seanjc@google.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com, 
	pbonzini@redhat.com, boris.ostrovsky@oracle.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 26, 2026, Lance Yang wrote:
> On 2026/2/26 04:11, Sean Christopherson wrote:
> > On Mon, Feb 02, 2026, Lance Yang wrote:
> > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > index 37dc8465e0f5..6a5e47ee4eb6 100644
> > > --- a/arch/x86/kernel/kvm.c
> > > +++ b/arch/x86/kernel/kvm.c
> > > @@ -856,6 +856,12 @@ static void __init kvm_guest_init(void)
> > >   #ifdef CONFIG_SMP
> > >   	if (pv_tlb_flush_supported()) {
> > >   		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
> > > +		/*
> > > +		 * KVM's flush implementation calls native_flush_tlb_multi(),
> > > +		 * which sends real IPIs when INVLPGB is not available.
> > 
> > Not on all (virtual) CPUs.  The entire point of KVM's PV TLB flush is to elide
> > the IPIs.  If a vCPU was scheduled out by the host, the guest sets a flag and
> > relies on the host to flush the TLB on behalf of the guest prior to the next
> > VM-Enter.
> 
> Ah, I see. Thanks for the correction!
> 
> KVM only sends IPIs to running vCPUs; preempted ones are left out of the mask
> and flushed on VM-Enter. So the old comment was wrong ...
> 
> IIUC, we still set the flag to true because only running vCPUs can be in a
> software/lockless walk, and they all get the IPI, so the flush is enough.
> 
> Does that match what you had in mind?

No, because from the guest kernel's perspective, the vCPU is running.  The kernel
can't make any assumptions about what code the vCPU was executing when the vCPU
was preempted by the host scheduler, i.e. it's entirely possible the vCPU is in
a software/lockless walk.
