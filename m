Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3A38F932
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008108; cv=none; b=cf6JoroIEhWHv9HIcnrQuxB5th2wmL0dAF3/RmtxKJexdOlS359/ujCOnMtZ+e68/SjcCG0mvo98UGtlN+8MRGaEaBtt8e2b3K/ZdBi6mqMXX2qpIJHTaXUTPAqEOQLnIH6LfHSXiMhgZB/oVgsU/MkQZpfdwMiypa+pGA1WC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008108; c=relaxed/simple;
	bh=lGEDaxP9s5MVbkz0GqDIcVYCTfkJX1Q1PY4dt58kBow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U1aVjhpyqyv2Ns1WCNGJcbibNrktnNe5R+VKXHZqkA3PLtCXgFTwrdA3k+Uu/m+xLS0zjuo0NsdsWzCshARTyc55NpUGrUQN/qB/9+8m24me0gJaIx+Ns/V8cF3PmD9H0oLvvfhF6qXrAgaqqQx1iVKrdKwmdDA6IpnMu97bnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pskSvQVz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pskSvQVz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422b544a4bso3465288b3a.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781008107; x=1781612907; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=pskSvQVzNKzwzMkiVSAm8Lp+/YhZT9S7PHkrolL7S66+rZpBknKJ/+umRnH4LG/VtU
         gSrOucHzLm88uDSgTqrBggLuCXg2jQbrjIAKLLeNcYDti8fm2bB9uOaUXkfd5yVyxgca
         XPRQaYsyPHOvaFi+TaKT1wfxv65KB7zSHDvP+v/NxG98Qe+jExXyCfeE/Ik1F+gGmiSn
         ypPqqcHabC2SRv34pjlnz3vQR+9GGzSdSIts28N8vYSktYuyh2BvWPJ/tEaE33FYlWV9
         drXYha1/c49obXPA59shWkeFw3gPwI0Sk8lZC9D7u5NNNJvS5qXDPsxGogSJQWqTz7yz
         ZAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781008107; x=1781612907;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=unmnrNbCXlEEjkFhHM3DLJAuHv468WBx57rOjaror7w=;
        b=JECo9j4bIYz0cx37LM72LC/Xvx6xwGTIs0Q9amuhUB/2oGly6hOPGrnVFMESdpWJop
         waUk2Y/vmfDHeCG/DLGtdd/7vDoA8F+Vrd7mnbGog0UIkxo/6CiaHHEvFedLBspCn1Kh
         Y/ByEa+N/bCURw/5Q7oSrVr85hNdmpADs/qPod3r+ElQNb4vV756Kkyy9O4bA6m56Oz9
         MTSharKHgVYPf8Uw+XOIAiMgW6m1bgCZkTItEBxCzCagNsZB9zepmudBkV9D2bPgTP6B
         dUGpxiFnFGdufxgDPJWJGSz1WMQ+IzthR3VeNOnFEN2/jLZ/kP9OyvIB9U07ewkJ6lHM
         45PQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fNJBC1uFOExsaRLl0ZMp89NKJajeCkHbwLlhvgqrHYcsb7iNWcClI59eXUVltqGyF+jBx7SDnDB67QACMRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXCrgpRcfbBRTq1T6EwU68o4/5zSQFvv+z8CSNuBurjbRVsdNn
	oSXbwkXfRmsQaAY6YxSSLosuugiwhQbQSUxMIk+L5NE15Mg5ZFCQ23KSUDd3/EIXW2SO5dpsNVy
	LoAVyIA==
X-Received: from pfjf5.prod.google.com ([2002:a05:6a00:22c5:b0:842:4720:4013])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2910:b0:842:6fce:6171
 with SMTP id d2e1a72fcca58-8430a62f307mr3223335b3a.3.1781008106459; Tue, 09
 Jun 2026 05:28:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 05:28:24 -0700
In-Reply-To: <87a4t440js.ffs@fw13>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-11-seanjc@google.com>
 <877boc554l.ffs@fw13> <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
 <aidEfvTMjLa2zt43@google.com> <87a4t440js.ffs@fw13>
Message-ID: <aigG6NdLZtbc7prD@google.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026, Thomas Gleixner wrote:
> On Mon, Jun 08 2026 at 15:38, Sean Christopherson wrote:
> > On Sat, Jun 06, 2026, David Woodhouse wrote:
> >> > Along with:
> >> >=20
> >> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring n=
on-sensical tsc_early_khz command line argument\n");
> >> >=20
> >> > or something daft like that.
> >
> > Ya, I ended up in the same place once Sashiko pointed out that skipping=
 the SNP/TDX
> > setup was hazardous[*], and also once I realized that tsc_khz_early *co=
mplemented*
> > the refinement instead of replacing it.
> >
> > This is what I have locally:
> >
> >         if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> >                 known_tsc_khz =3D snp_secure_tsc_init();
> >         else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> >                 known_tsc_khz =3D tdx_tsc_init();
> >
> >         /*
> >          * If the TSC frequency wasn't provided by trusted firmware, tr=
y to get
> >          * it from the hypervisor (which is untrusted when running as a=
 CoCo guest).
> >          */
> >         if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> >                 known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> >
> >         /*
> >          * Mark the TSC frequency as known if it was obtained from a hy=
pervisor
> >          * or trusted firmware.  Don't mark the frequency as known if t=
he user
> >          * specified the frequency, as the user-provided frequency is i=
ntended
> >          * as a "starting point", not a known, guaranteed frequency.
> >          */
> >         if (known_tsc_khz && !tsc_early_khz)
> >                 setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>=20
> If the frequenct is known via the above then you want to set the
> KNOWN_FREQ feature bit unconditionally. SNP/TDX/hypervisor override the
> command line argument as you print below.

Doh, forgot to remove that check when I shuffled things around.  Thank you!
