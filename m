Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337A391E74
	for <virtualization@lists.linux.dev>; Mon, 18 May 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138707; cv=none; b=cOaW3Rg+t6zk9bavIPu9WJogRbgknp7Wi4vogk4Rp+uepHSjlkPccq3TDIFAXMtChPHbWRrhuzifNQzSqHSc/8D1xQVy6zIurA2CflPRDM+gHYHK30fx/nKr13lAJOGtZZ+Qyogfxecs8BRd7QBy3uxvHKqNqaW7H/lCMmf4QU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138707; c=relaxed/simple;
	bh=Y9WlSbz5Rarbpnp6OSXzG8yVO1DRu83ex3iEeD+K0qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p/xxvWNXB4kcFFIAx+zqREqZGusIZN3oIm/sg8evXxHcE9xraK6TTaRjmFDEVSTAlzimHbkKgXI04aEj3n0aRNqM3lInEqVv5SkzXvuPBkH7KV6MJ7vxiIcvgcCsHNqxhB0o1igMphbbH/FXcJsegsDa7wb0UJC3D59TOQ7DM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+AZGfwn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+AZGfwn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba3245a43dso29500005ad.0
        for <virtualization@lists.linux.dev>; Mon, 18 May 2026 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779138706; x=1779743506; darn=lists.linux.dev;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0HR0/OeCt5J6wDdP6oTOA3/U+zZIegjjUJa8wpeaiw=;
        b=R+AZGfwnYMkptUTeORL5P6KLGpfSGKJF2V8Q2TKfO5Yw3li7XvezuSWgsjRUo6XL5j
         CXhSGNhT83GHjeAB6z/zpn68+uWGlM1zJPuf8MBBXQLJS3s0MXLqbP0O/Jfu3GBHocqh
         kJIIjEDuaNrHUsj35RwY+o5xb7FqAWJt4QpZv127FbGddtRksz7d4x4hKimB4KrE2VcV
         0DyCvzeqOlPZcP0dUbOUTfCLidFY1o8cttAv1PN2wV6kdPFAenQy06DDnCInm4LNoZne
         qrXDnoMYiXb/UIpzwfA/thK3T3r1s7M0wNQOLkNOwgt2TRs00oNLTDYXPNbvhDnOHmKU
         AA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138706; x=1779743506;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0HR0/OeCt5J6wDdP6oTOA3/U+zZIegjjUJa8wpeaiw=;
        b=cKIFNO2/lu2gXBjSIQzc/VSHLDM3D4TrUiOBbTDovIsxwByiMKRlIch8rHZUks7rfY
         m2/ottOEkz7l/JlpTt6zjNSXkTfA4m11DiPBIuO14LkqFHP4cohjS5KWs/W6y2FljSiZ
         ZwJ9b6psgdhjmgc/OAthphrZt+IYCnQCfG7nJQFnRlvNcfj1CRW2jS2HEdBPYKyomPCf
         5/nn0k9IlLFcsIco1KlL//yUszlzNWVHFRK0OGuBFcm6kG2+E10YjsAVZU9a19Ed+/uS
         bO8rGAgJhFKZ8vE9vKiyU2eyMTIx0tWkEirG292q6xHMY9mrpeLoZR2mt7Em319GaDEa
         YjMg==
X-Forwarded-Encrypted: i=1; AFNElJ9eSPGOJEJ3DCepbVvHYkj94FLAbkWQA+vzbZxmmF9wwHn+VWLdbWFuOduo7gq1OnRuxeMFvg03eoaOWLD8tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxphIXn4kgr/O5562c/yXfdFFuyUcN1u0KeGMVFS+oShCTf4Nmr
	CcElr+cMfREreRqqNdwOxNOlctD029GHO6QmB/Hnv55cemcnfJLpW891i2wI5v5Vl8w0PMNKtpb
	beqHvOg==
X-Received: from plhq16.prod.google.com ([2002:a17:903:11d0:b0:2b2:43c2:a183])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c4:b0:2bd:9766:bd2b
 with SMTP id d9443c01a7336-2bd9766be37mr135740745ad.19.1779138705542; Mon, 18
 May 2026 14:11:45 -0700 (PDT)
Date: Mon, 18 May 2026 14:11:44 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
Message-ID: <aguAkMTrkSVPthal@google.com>
Subject: Re: [PATCH v3 00/41] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Sean Christopherson wrote:
> Dave/Thomas/Peter/Boris, what's the going rate for bribes to take something
> like this through the tip tree?  
> 
> The bulk of the changes are in kvmclock and TSC, but pretty much every
> hypervisor's guest-side code gets touched at some point.  I am reaonsably
> confident in the correctness of the KVM changes.  Michael tested Hyper-V in
> v2, and while there were conflicts when rebasing, they were largely
> superficial (and I've just jinxed myself).  For all other hypervisors, assume
> the code is compile-tested only, but those changes are all quite small and
> straightforward.
> 
> The only changes that are questionable/contentious are the last two patches,
> which have KVM-as-a-guest use CPUID 0x16 to get the CPU frequency, even on
> AMD (that's the dubious part).  I very deliberately put them last, so that
> they can be dropped at will (I don't care terribly if those patches land).
> To merge them, I would want explicit Acks from Paolo and David W.
> 
> So, except for the last two patches, to get the stuff I really care about
> landed, I think/hope it's just the TSC and guest-side CoCo changes that need
> reviews/acks?

FYI, don't bother reviewing this version.  Sashiko found several glaring flaws,
but I just realized that sashiko-bot's emails are only being sent to myself and
linux-hyperv@vger.kernel.org.  I'll make sure to highlight the changes in the
next version.

In the meantime, Sashiko's feedback is archived on lore if you want to see me
get torched by AI :-)
