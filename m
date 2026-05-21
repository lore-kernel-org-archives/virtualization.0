Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8A2BE655
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779398248; cv=none; b=okYiu15Flcc/Fl/OWyy3Rvf/NtRrl4nYVUMUPkqClOAv7g1Gdme84g1hndFc5odwpXL+GjhKrS1hX+T2btC8qz6FOZgMZeMACmzLbzWakRCoQ9t6MZl4OtTq0xUJcK1+JEbBLAkV3Zy13ceZOtEM58DICciRrexlJokaKvwtNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779398248; c=relaxed/simple;
	bh=XW2WAcTP4Sm+wf3twJ/QoA4Nko2nJVwNKYlSfZwWKSk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxt3Eo0RkT04HEWp+cbGvyd00xBh7oQ4fNEPTrq8/pIptU2vrlwpN3hIjCfkwyar/C3if6sX5xnFx8yNtn7h/hO4Mcoh19nsRQ8xQ7Bx2ASym7wJuwpnzriW8jQBmapwYPb4PFLrhTCgW2WHaZ0zJ7N8UmqVdPkBjgzy7J1EsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VCIOM9C6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCIOM9C6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba718173d1so113083325ad.0
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779398246; x=1780003046; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jW9XtyrtynBxdJYPv96DfQ4Rw5zedPSv+/BbmcgSxI=;
        b=VCIOM9C6CMJ0FgIcldSHSVXtRE1KcMblsucStgzZ1ALV2jGyaAtAV9DjyWepU3awm/
         fiiNnXyMRcZOjF4IqpbbKKVBEBiTISPJfpSdEMPeKCanINQHKRxMD/u3aZDce5nOc98m
         zZw6VIN2HjP3o45zCtX2kqzZ/xABrbLsoMsGiYjbxD1iP/mEHlhz6UeC+jl2TsGmCSz3
         6kQ6M1lF4Y+tmqTC5yvhwR4hbIsLqukCcfRu42VqDKQBKrY2SMKbvrMKMR2xJxh7d6hw
         MTrJvmAgWMvR2MngT5B7iOtwDg2ZJUeJAqPiN7cYTXruPW8o5uf9S7sQ/UpK00qOBNsD
         x5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779398246; x=1780003046;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jW9XtyrtynBxdJYPv96DfQ4Rw5zedPSv+/BbmcgSxI=;
        b=QRj6PsAwwl2N2gJKMpPMs1en+tD8YAtymk9OrEOAISxCdTR42uwdp8cEIl4nByQ2W6
         Pqtno1Yb2oSOlkzWzdJ6Bb4NdBGCxDoqMfXxOcjMN7tNO1YTMCdLvmKKwmu/ljtm2nCI
         dfslmAY9IPOgIrx/scKpdxQMCHe/XTPSU6F1WD52a1ybpYHtwPhxP8y8i3T6EtAFQPmU
         x2skSXydR51y1L2GnGsodD66C6U7dzQ5WAmBJwmYsQEvaGnOd2l5dbUAPzPn67yVLIo4
         ImX3OGv8QMiEgSJRkzpLeM+osqeM74Lf5HwvlnOEfN/8/+TfpVz+ZfzweWIyHhk9vdJb
         4hUw==
X-Forwarded-Encrypted: i=1; AFNElJ/WZXtkASrNQasL0L9XzYu+cf9zCFszXfBhUP5aMfDfGNbdmamdx5W0eqldytUlmW1/GPqYlblyz9vIZtUtMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqQqHRzZaU6atFg0XYf1JQrAeklBuXkiKMpVYlIh1EDS2NA2hV
	Q7lxdgNm0trHS2tuTlEtJqxnvDnN9ttXW8N6Ngwy7RgTqong8IkkZMG9Few5XWcQTsbGpLiN9Kb
	G/3oq9Q==
X-Received: from plbkh13.prod.google.com ([2002:a17:903:64d:b0:2b0:c78a:4537])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2b4:5f19:1d34
 with SMTP id d9443c01a7336-2beb05eec0amr6266755ad.17.1779398245853; Thu, 21
 May 2026 14:17:25 -0700 (PDT)
Date: Thu, 21 May 2026 14:17:25 -0700
In-Reply-To: <342098f6bfe1e4c7b233433df8f79713b4220614.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
 <ag9wz3RiJOtVZrK0@google.com> <342098f6bfe1e4c7b233433df8f79713b4220614.camel@infradead.org>
Message-ID: <ag92Ze_FADmL1llo@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
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

On Thu, May 21, 2026, David Woodhouse wrote:
> On Thu, 2026-05-21 at 13:53 -0700, Sean Christopherson wrote:
> >=20
> > E.g. this is what I've got for the early flow.=C2=A0 Testing now.=20
> >=20
> > =C2=A0 void __init tsc_early_init(void)
> > =C2=A0 {
> > 	unsigned int known_cpu_khz =3D 0, known_tsc_khz =3D 0;
> >=20
> > 	if (!boot_cpu_has(X86_FEATURE_TSC))
> > 		return;
> > 	/* Don't change UV TSC multi-chassis synchronization */
> > 	if (is_early_uv_system())
> > 		return;
> >=20
> > 	if (x86_init.hyper.get_cpu_khz)
> > 		known_cpu_khz =3D x86_init.hyper.get_cpu_khz();
> >=20
> > 	if (tsc_early_khz)
> > 		known_tsc_khz =3D tsc_early_khz;
> > 	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > 		known_tsc_khz =3D snp_secure_tsc_init();
> > 	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> > 		known_tsc_khz =3D tdx_tsc_init();
> >=20
> > 	/*
> > 	 * If the TSC frequency is still unknown, i.e. not provided by the use=
r
> > 	 * or by trusted firmware, try to get it from the hypervisor (which is
> > 	 * untrusted when running as a CoCo guest).
> > 	 */
> > 	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
> > 		known_tsc_khz =3D x86_init.hyper.get_tsc_khz();
> >=20
> > 	if (known_tsc_khz)
> > 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> >=20
> > 	if (!determine_cpu_tsc_frequencies(true, known_cpu_khz, known_tsc_khz)=
)
> > 		return;
> > 	tsc_enable_sched_clock();
> > =C2=A0 }
>=20
> That seems reasonable. Where does the call to native_calibrate_tsc()
> happen; is that from determine_cpu_tsc_frequencies()?=20

Yep.

static bool __init determine_cpu_tsc_frequencies(bool early,
						 unsigned int known_cpu_khz,
						 unsigned int known_tsc_khz)
{
	/* Make sure that cpu and tsc are not already calibrated */
	WARN_ON(cpu_khz || tsc_khz);

	if (early) {
		/*
		 * Early CPU calibration can only use methods that are available
		 * early in boot (obviously).
		 */
		if (known_cpu_khz)
			cpu_khz =3D known_cpu_khz;
		else
			cpu_khz =3D native_calibrate_cpu_early();
		if (known_tsc_khz)
			tsc_khz =3D known_tsc_khz;
		else
			tsc_khz =3D native_calibrate_tsc();
	} else {
		cpu_khz =3D pit_hpet_ptimer_calibrate_cpu();
	}

	...
