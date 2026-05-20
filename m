Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99934D3B0
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303967; cv=none; b=cw1z7DDbL80HMPRWINWR1/2miKCJgOPltqSSx1UdRHHSBO6XDEkizORluYJiob+O/5bx6gKyAmCnhy3+LNCNWcEwJvT+V2d1Ec2L5tIfchRszFqt6or20vxpzitY74hZPoKV+C19Z7ybC3gBl9ZKbmnen/cha9Z400Rw2R7r72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303967; c=relaxed/simple;
	bh=RgcPTv4wMW8kG16l9+v1ZPwo8tS4sdbfT4dPD82hdzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R78CZiGt5oGogz4y8lSKzBzuohfCK7zH2rTjtaZYjJTn1QALD0leRxooXEupesODsMclDnSquhktOxr9ZiU509O+HXWkJfeRt/+N3jHwUYZlSYxp+LK5xghyA1zM9t0kyuAx5P9HUJdpJhA3A+9cUHuzZBNsu8Rdl+omO4WEjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwHWd/it; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwHWd/it"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd6cc53fd6so53194435ad.3
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 12:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303965; x=1779908765; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WNRv8jV4IoEb/swCa+lI2OUcbnWLzJ/hZWZsifg+pw=;
        b=rwHWd/itUVrmxE2Rglb6bKFMPpVViYI60uyf6VVGAM5igN/PKCByj/5ZJJwROEq7oE
         lOt2tzdzLoBqO74LQ2EikgQmXF2k0uM4hy1vDAPJzurnUw8PAzfWdsajDhfjpK0Fr8N4
         w/Ldodbjk0iyeuVwa/Yxsph0rl6lQIObgcq+cMRTgahEmGeooaSdHQs8gqELi1aQc0L0
         LgKapEY2p4nUkElVDRzg2tpDBG70xI6bbcJL8XCyccoVrK0+pAd0Yb/S9TWaWjG1EzBD
         hfLn+1fk2tpeWqhLuSGouAk0XrAm1Q3ufMLS04HAAhR2dohDrwNSb6j2/jABkWiZzOEZ
         KYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303965; x=1779908765;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WNRv8jV4IoEb/swCa+lI2OUcbnWLzJ/hZWZsifg+pw=;
        b=AKbLtrzAIBAjwCqx6doCIbxzEaOWcVE9dlQEhZULVIDzuE8XY2m2ooecGLh4G7ddT8
         V3Ticm8QQY7qAomsFCzdUxYGYtgJ+86+eW7TfyBT5jpXWBMw11XNgxXx0WBFC6j4hRNF
         Z221Stdgbha0FEl+q9UGZ1Rrwqw04YszMwNFsUnJMKSsWs0ZXamPWxBmVkjVKVtu6iXl
         1o7zB7YaROeIpEPLsPycHWmkwxp/ckw69W+EBpZ/DSiNfP1+MCwlPFGbW4VQj6uxKgBv
         64kaoHoibSjbEBmSmYQ16eRIcy6OP3gTl0IkxJk8afXYrvTMHkEgh2UNktHLos4yVFmO
         fHiw==
X-Forwarded-Encrypted: i=1; AFNElJ/YXt0F2OU29b86fBmlNmyCr537acn9Og0rgThPDznZUZS1yCONCzZ/SxEG0s8eTIrioeM/o9rsW4An3FShmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywre7GqudkorG3/Ih6eS4EY59aRZbPiupMlkySTm7K+dzCxNle5
	sLQtJszPiJOwLPYf+EmEXlt+p9fCOnskuNPdH/ThgypxLGEOZn5DZv6iKi3h8G4VGzoXzAXG4GO
	SLkSaTA==
X-Received: from plup11.prod.google.com ([2002:a17:903:4b2b:b0:2ba:67f8:6257])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7d96:b0:2b0:bed1:46f7
 with SMTP id d9443c01a7336-2bd7e910f99mr193795045ad.37.1779303964438; Wed, 20
 May 2026 12:06:04 -0700 (PDT)
Date: Wed, 20 May 2026 12:06:02 -0700
In-Reply-To: <0a3aa07a1d3c4bec2b89f8026093969155b73caa.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-42-seanjc@google.com>
 <0a3aa07a1d3c4bec2b89f8026093969155b73caa.camel@infradead.org>
Message-ID: <ag4GGqYv0DHoVx-C@google.com>
Subject: Re: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID
 when it's available
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026, David Woodhouse wrote:
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > If CPUID.0x16 is present and valid, use the CPU frequency provided by
> > CPUID instead of assuming that the virtual CPU runs at the same
> > frequency as TSC and/or kvmclock.=C2=A0 Back before constant TSCs were =
a
> > thing, treating the TSC and CPU frequencies as one and the same was
> > somewhat reasonable, but now it's nonsensical, especially if the
> > hypervisor explicitly enumerates the CPU frequency.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > =C2=A0arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
> > =C2=A01 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index 62c8ea2e6769..7607920ae386 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action=
 action)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +static unsigned long kvm_get_cpu_khz(void)
> > +{
> > +	unsigned int cpu_khz;
> > +
> > +	/*
> > +	 * Prefer CPUID over kvmclock when possible, as the base CPU frequenc=
y
> > +	 * isn't necessarily the same as the kvmlock "TSC" frequency.
> > +	 */
> > +	if (!cpuid_get_cpu_freq(&cpu_khz))
> > +		return cpu_khz;
> > +
> > +	return pvclock_tsc_khz(this_cpu_pvti());
>=20
> I'm fine with this in principle but shouldn't the fallback be calling
> kvm_get_tsc_khz() instead of directly calling pvclock_tsc_khz()?

Oh, yeah, for this patch, definitely yes, so that there's no side effects. =
 The
question really should be answered in the context of "x86/kvmclock: Obtain =
TSC
frequency from CPUID if present", which subtly impacts the CPU frequency, b=
ut I
think the answer is "yes" there as well.
