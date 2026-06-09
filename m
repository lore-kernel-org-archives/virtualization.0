Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA140D569
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033334; cv=none; b=Tjwql5zMftCL3Iip5/ERBsJlFljuRJzMbQ+Cz2W6OYT1jmUInnyOfYqr7lAlf58Mp1d2o/a+V+zY1385EObn/iToOnOqDR+l9+rkIvFD2hIzsE8xoxlw5LXYzHJjSmbtrQ7DUhUePCNt3B/AyhGxwgpDOInqdi9gQ32tq2DEDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033334; c=relaxed/simple;
	bh=DEq1jYRvE+O17je84XUU131j/oCIfTBQGBFCnmOvDsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sLtsUkAbyV4vLmrifRr0nRJAYhFo8tbKqegtRhq4gV3dJWOQQp4aowBXZ9ee9ZZSKJepDTNfDS2UEbxD/xPmJr68nWQc//uULQDjlibzUba7H4sLl+Xf9KxTaJerTY1vmIFou+ETxsXlrvtUJZxoyFnC1Sbop4EeR+SH5AJyx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knVREyl7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knVREyl7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so9707546a91.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781033332; x=1781638132; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guAeemkMCkyys/PJ2ZLLCH34LSaDcqFIXbZHYNdXwyE=;
        b=knVREyl7HsdZ4zP2gXt8MMK6GAi3Su6TSBo+Aj7nheOeIhGu2BOL4zz0VCXLFO4j2M
         tW0qhPtWNiwcOfY+H/1R3GmBObbfav7uQbL0N5lmxDvwX/IwSEanz4pRVHpVxLk/qfhB
         RENsdJbd7LuaDdrHrNqbuRI4l/szNm9kSeq9XqgonATbE4pIEOpEQqIqCXUQGFIxQGs8
         g/Kwl7MG5osfwmXJExe4RVZaxMDOrCiMbwhLJR3gJYdN1yTvsRZ6E8ARBPsL+CR9H2Ob
         7e54hwePyYo3nk1aK/MtDgP78eYMa04YjLmEgC2LalM/UiWUMy6bMppRa86not9EQrYQ
         RzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033332; x=1781638132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guAeemkMCkyys/PJ2ZLLCH34LSaDcqFIXbZHYNdXwyE=;
        b=XMdHKyUn2YRaYSt93DCbEcFEGPrXd13vy+Ot/e25s/OHc4aXggzfpu5/Ojg69HOFQA
         Rta1NqCshGprWxhhqXtqM6hU4hETkCkT2Fn2otUQe/DwhCbN9i92ShRwQaMtaYWWMOUt
         KxT3Pi0tkUrzKUKZ2Q6WWvjrbJCmAUZJioa5dEMrs4b0e/fveJFthQJ4+DN0+o9qj7oX
         jDNJkXq/7xjYCWxEi2h1qTtWaPzbLJl/p6qL++QD5qoCA7DatbAmPhPHR4woGBrCO5XY
         xmsYUcRY5GMB+7lSym1peKWsoYGmnRr5mocmfANZcPqVyDcVtvqb1EnOpKDnGm9haVbQ
         Cpzg==
X-Forwarded-Encrypted: i=1; AFNElJ9OxPKwiqZv8b23exYkryRPZ+WWUU0XuEuXkawr+7DLsIARuJ4I+fpxItx0Nrexz6GpAcqja2RUtmpDLe/TVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTxU9RjGg35+3dgDKglURKgYl+ko75fahVKOxgCU2C+CfzcdPb
	B2sBQwaZTrwc6C+BzCrzrpZM71utXyJVquvj7ra1g1UMH5rNVQguK/tR+/ISGgHMhzeTELorInc
	1ARSNCg==
X-Received: from pjbgq16.prod.google.com ([2002:a17:90b:1050:b0:36d:c3f4:8460])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390c:b0:36d:f28b:72e2
 with SMTP id 98e67ed59e1d1-370ef2ec248mr22562261a91.8.1781033331787; Tue, 09
 Jun 2026 12:28:51 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:28:50 -0700
In-Reply-To: <20260602034916.GGah5SvARd77mkvxe3@fat_crate.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-3-seanjc@google.com>
 <20260602034916.GGah5SvARd77mkvxe3@fat_crate.local>
Message-ID: <aihpch8FG6Esl3Jx@google.com>
Subject: Re: [PATCH v4 02/47] x86/tsc: Add a standalone helpers for getting
 TSC info from CPUID.0x15
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 01, 2026, Borislav Petkov wrote:
> On Fri, May 29, 2026 at 07:43:49AM -0700, Sean Christopherson wrote:
> > +static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
> > +{
> > +	unsigned int ecx_hz, edx;
> > +
> > +	memset(info, 0, sizeof(*info));
> 
> Let's not clear this unnecessarily...
> 
> > +
> > +	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
> > +		return -ENOENT;
> 
> ... just to return here...
> 
> > +
> > +	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> > +	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
> > +
> > +	if (!info->denominator || !info->numerator)
> > +		return -ENOENT;
> 
> ... or here.
> 
> We wanna clear it here, when we'll return success.

Actually, if we take the approach of relying on the user to check the return
code, then there's no need to zero the struct since all fields will be explicitly
written, especially if we drop the "tsc_khz" field.  I was zeroing the field
purely as defense in depth.
