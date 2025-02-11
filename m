Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88224E4C3
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291304; cv=none; b=NGbjArf7iBLKcd6yTTBM39s+bFR7ygTh9GMNV5xojBiB95vTVlSBkHPchEbnWQYjUeMxLLK3Hf4MNXFkpsAYCJ5DYAKFjxz5cHmSZ3jvRupKVENz7SoXx4Ssc6jjv+kW9PD6GbpU4HklWdnE6pEfpHVJ1ZmI+J5f83g8BdZUpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291304; c=relaxed/simple;
	bh=yilJGqWW4RYMKFOjUyyusb+5EmeDe91eA1bXhwR/YFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EzRqsAfxCQQbO+9+BCn/nFmo2dvXkWNB+ZJsZqqM7zG2Fxm5gwass5nW619Q95cjwaddwIzWKbVJ2gUP/C2lEuZ33/x52WAaYWDu1+ncqetvdUtaSyd+LyxWqYejzedGJzUT4AfhqAZt+mlxLcb/rLF5MJsJGH9krfLifXwS1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BV8gyqEQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BV8gyqEQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa3b466245so7334132a91.0
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739291301; x=1739896101; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MEK/stSb+AMRyC9Zhx6OFHXRnHPVcvklj9Pc8LhwOQ=;
        b=BV8gyqEQ8Bo/dEWAAdR3aL3XgwtOcqF7BNB7v5dn8HgnIE9gKi56z680tOVvcUJEl8
         J++kUakbd2lfLWUYWsHqqEJTjiwSFTSbNQdsjeK3IHpuUSGtYiX+CyFiRGauYZPZqyqN
         1Bp0BCRB1NHF9FALR69/4ynEpKTGBxqwUK3E2fdc8PgFD/YgL6oViU+g9Qv1cTlCzPnO
         gcnJnTLlkPOybTrb+2R0Afk3210pMHRUtlDEEXN/OQeK7DRsr9qHpvCsKNuCAfUBa6MT
         5ymvH4XwK27IGYqt0/084kzcv3qcDDYUXCeW3aOTTTnXwpLwDFX6cGfD9Su4OXXYUb0B
         a29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739291301; x=1739896101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MEK/stSb+AMRyC9Zhx6OFHXRnHPVcvklj9Pc8LhwOQ=;
        b=GKNLSD+wUgT3yRJt+hqGUgdyOlctffHAlTypVeX7yOjJ6Edr2nbkWA74j0qB0gZyaw
         rPGpBjHiYBJFDdWybjp1Pys5ti6mstTGzReElvvZABgo/m8la5loH6YnOx9b+DuFp8Ng
         H1me3zfdRUEQAeCmZ32SnQN8N0Jc4TYfTmt9ES8dE6Q7DWEzf2aF97FcRjR8023Xc0Xh
         NKc2RdfevRsSndJ8JPugjRYw5uH3XY+r2V4c2WLF9us+GLf703a3MoWAytu8ffAsULfH
         EzJNOHLwF7bxpnMTx5fC3760RPMcKlVx6Mx7RxEJs5x0GY28cV0K3GQbX5moPzopi5z3
         2S3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnJ33OHrEULkm7hlHr2wh3keImiTryuQZRvCNgUP21fPowk0ZrAO6PeGxqQErMRQZrNYoC+MOTAo3hF3e15g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPlThEHrWWzwOkFc3Wa3F+ctNI8B35OR5ESCNNvH1tWEUnDLeQ
	7KTebQ43jWHVr+FwkG/O+r8F9KQXj7dLjjSdwifY1LWfd5d4MrJjZMLetGzwJlHA3tvT39gb6qJ
	KKg==
X-Google-Smtp-Source: AGHT+IEW6FT5SzWSOj0JB0UAPg+blRK0ibYMj54XT+2rd1e326WroNU4nUmkSnUDL4aqV/75Jp14hq1SYiM=
X-Received: from pfrc11.prod.google.com ([2002:aa7:8e0b:0:b0:730:7648:7a74])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:188f:b0:732:2170:b69a
 with SMTP id d2e1a72fcca58-7322170b72bmr3189092b3a.18.1739291301572; Tue, 11
 Feb 2025 08:28:21 -0800 (PST)
Date: Tue, 11 Feb 2025 16:28:20 +0000
In-Reply-To: <20250211143919.GBZ6thF2Ryx-D2YpDz@fat_crate.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250211143919.GBZ6thF2Ryx-D2YpDz@fat_crate.local>
Message-ID: <Z6t6pMgAjHckWMs_@google.com>
Subject: Re: [PATCH 00/16] x86/tsc: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, jailhouse-dev@googlegroups.com, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Borislav Petkov wrote:
> On Fri, Jan 31, 2025 at 06:17:02PM -0800, Sean Christopherson wrote:
> > And if the host provides the core crystal frequency in CPUID.0x15, then KVM
> > guests can use that for the APIC timer period instead of manually
> > calibrating the frequency.
> 
> Hmm, so that part: what's stopping the host from faking the CPUID leaf? I.e.,
> I would think that actually doing the work to calibrate the frequency would be
> more reliable/harder to fake to a guest than the guest simply reading some
> untrusted values from CPUID...

Not really.  Crafting an attack based on timing would be far more difficult than
tricking the guest into thinking the APIC runs at the "wrong" frequency.  The
APIC timer itself is controlled by the hypervisor, e.g. the host can emulate the
timer at the "wrong" freuquency on-demand.  Detecting that the guest is post-boot
and thus done calibrating is trivial.

> Or are we saying here: oh well, there are so many ways for a normal guest to
> be lied to so that we simply do the completely different approach and trust
> the HV to be benevolent when we're not dealing with confidential guests which
> have all those other things to keep the HV honest?

This.  Outside of CoCo, the hypervisor is 100% trusted.  And there's zero reason
for the hypervisor to lie, it can simply read/write all guest state.
