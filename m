Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD493B19DE
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958337; cv=none; b=HcK1begCCYFrmnB7J4rpepSQWITwTuIZcRDqN90HnibO3wYyDfEZwjULkYW1HCq60ifegL7/M72RZePpzC6pWIBikOyfCJ/gnR2uZTRBv0SWZCyl1ZVvyaB9OTikkyxKsqH9KqGjgrYcg6UbGEoTlVjMENO/O7gq+L5td95N+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958337; c=relaxed/simple;
	bh=g0z45+aYiJC51GAUvnfRAO2uYrqdMzpO8Z4vJI4yeCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hiHGBHwrMKo3CMwmCzVr02akMIYnbNSR6OMlVl1MlycHiSJqRU4z69+Wy9Vhh5qgaGqOAdkDszhmV6PysCh9X1SLUANC8u95cD49o2D3/yX7FMVi4wyQnpULkIequMsQgEeItSp1PF0dyBM/IWp9EmHsfVS4hNMXv2LKqdxgFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGRNHdsV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGRNHdsV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so46261175ad.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 15:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780958335; x=1781563135; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/e8MVVf+gn1nbLHbwfdQ87xOkjbdduwr2NDuGKxrzw=;
        b=EGRNHdsV9Wn2bs6YNmsWfoNXF82D/q8F8sog//IkMHeVr9Bn5OSu/S3Oh987Xxonk0
         JDacm/oX7eaC4bOuFHEL4gC2OmFNM8fxRKREL+XplWtp5Omsn4YV4IAOx1xOwPq7+3zD
         GEP/tsTh295z1QgB55pH3qq4zW6p45YnHjnNFJPGqQ3HBvJcG7kTw+8q1ddX8ZJzFtOg
         vJB6u93YeEhkILkbPP7NYikFU7r4Sarex8KtsulNNRRr2v8Xo6iR3u0BqQtRa0QLzofQ
         Um82iBaeW0KDySABdnAER44i75LXDfmRyrytD7siF/MZ83JBqEMUlPBR/eZoXM1LRjJm
         xHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958335; x=1781563135;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/e8MVVf+gn1nbLHbwfdQ87xOkjbdduwr2NDuGKxrzw=;
        b=X83LqDz5e+CQWsfe5SUWsAbhAA+fDXOORcBAIylm+meZvc2KReOmxbjP4x8AURZjjm
         Uo5affAXCyR9caybdF1vPCpkG7vzGCagvQXqwQBAOv690tMB104R1t+lpQY72nFa9sBO
         p479WcI9XRmGZ5AOx1MuH270/BpTiT1GqEJ5/xDU7FwujjvIAnhqAf7jRd3kkwgOFBRa
         XETQza0mZO51TI5fEoO2V2eOx/79Sp8kYibgpjLofqEVT8Uo2K33yHcwhoGCMowkp5G3
         hUzPwJ1K9FF0znMIpgmKzhmD47bx+Q+oyBDTqULQcLJnnlvIXDwRZBILL5lNKjkne/4c
         UVDg==
X-Forwarded-Encrypted: i=1; AFNElJ+w8y9pU6zREJrPamvH076sUtlsUA0Xw0NP0vtsWCwWXxtCfjoPylSdDMM12CKdOosnut8CbfcaOeEqP1Ev7w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz91F0+K0hOKwUzr/IC+Cj6N1ChsHtprQ6jQhGLS34A2zkfjpJZ
	rxkdWSqevxEMEjglig+EddVnUa7cGg1ugr8+rDQ9sTmHTEFALcaQXvzDJqDWHNj2AuOYWx5Xmcy
	KuHH4gA==
X-Received: from pldv17.prod.google.com ([2002:a17:902:ca91:b0:2b0:ba5a:1fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8d:b0:2be:fda1:42d9
 with SMTP id d9443c01a7336-2c1e7845a08mr176535715ad.0.1780958335144; Mon, 08
 Jun 2026 15:38:55 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:38:54 -0700
In-Reply-To: <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com> <20260529144435.704127-11-seanjc@google.com>
 <877boc554l.ffs@fw13> <eef867eae15e30d08482ba16a1a32159745b64a7.camel@infradead.org>
Message-ID: <aidEfvTMjLa2zt43@google.com>
Subject: Re: [PATCH v4 10/47] x86/tsc: Consolidate forcing of
 X86_FEATURE_TSC_KNOWN_FREQ for PV code
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

On Sat, Jun 06, 2026, David Woodhouse wrote:
> On Sat, 2026-06-06 at 12:34 +0200, Thomas Gleixner wrote:
> > On Fri, May 29 2026 at 07:43, Sean Christopherson wrote:
> >=20
> > > Now that all paravirt code that explicitly specifies the TSC frequenc=
y
> > > also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
> > > and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is kno=
wn.
> > >=20
> > > Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was prov=
ided
> > > by the user.=C2=A0 Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_k=
hz command
> > > line parameter"), one of the goals of the param is to allow the refin=
ed
> > > calibration work "to do meaningful error checking".
> > >=20
> > > Note, preferring the user-provided TSC frequency over the frequency f=
rom
> > > the hypervisor or trusted firmware, while simultaneously not treating=
 the
> > > user-provided frequency as gospel, is obviously incongruous.=C2=A0 Sw=
eep the
> > > problem under the rug for now to avoid opening a big can of worms tha=
t
> > > likely doesn't have a great answer.
> >=20
> > There is a good answer I think.
> >=20
> > early_tsc_khz exists to cater for the overclocking crowd. On their
> > modded systems the firmware supplied TSC frequency (CPUID/MSR) is not
> > matching reality anymore. So they work around that by supplying a close
> > enough tsc_early_khz and then they let the refined calibration work
> > figure it out.
> >=20
> > Arguably that's only relevant for bare metal systems and what's worse i=
s
> > that in virtual environments the refined calibration work can fail,
> > which renders the TSC unstable.
> >=20
> > So I'd rather say we change this logic to:
> >=20
> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tsc_khz =3D x86_init.....();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 force(X86_FEATURE_TSC_KNOWN_FREQ);
> > =C2=A0=C2=A0 } else if (tsc_khz_early) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > =C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0 }
> >=20
> > Along with:
> >=20
> > =C2=A0=C2=A0 if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tsc_khz_early)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn("Ignoring non-=
sensical tsc_early_khz command line argument\n");
> >=20
> > or something daft like that.

Ya, I ended up in the same place once Sashiko pointed out that skipping the=
 SNP/TDX
setup was hazardous[*], and also once I realized that tsc_khz_early *comple=
mented*
the refinement instead of replacing it.

This is what I have locally:

        if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
                known_tsc_khz =3D snp_secure_tsc_init();
        else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
                known_tsc_khz =3D tdx_tsc_init();

        /*
         * If the TSC frequency wasn't provided by trusted firmware, try to=
 get
         * it from the hypervisor (which is untrusted when running as a CoC=
o guest).
         */
        if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
                known_tsc_khz =3D x86_init.hyper.get_tsc_khz();

        /*
         * Mark the TSC frequency as known if it was obtained from a hyperv=
isor
         * or trusted firmware.  Don't mark the frequency as known if the u=
ser
         * specified the frequency, as the user-provided frequency is inten=
ded
         * as a "starting point", not a known, guaranteed frequency.
         */
        if (known_tsc_khz && !tsc_early_khz)
                setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

        /*
         * Ignore the user-provided TSC frequency if the exact frequency wa=
s
         * obtained from trusted firmware or the hypervisor, as the user-
         * provided frequency is intended as a "starting point", not a know=
n,
         * guaranteed frequency.
         */
        if (!known_tsc_khz)
                known_tsc_khz =3D tsc_early_khz;
        else if (tsc_early_khz)
                pr_err("Ignoring 'tsc_early_khz' in favor of firmware/hyper=
visor.\n");

[*] https://lore.kernel.org/all/ahnF-FehodVd474X@google.com

> > The kernel has for various reasons always tried to cater for the needs
> > of users who are plagued by bonkers firmware, but we have to stop to
> > prioritize or treating equal ancient and modded out of spec hardware.
> >=20
> > TBH, I consider that whole KVM clock nonsense to fall into the modded
> > out of spec hardware realm. Do a reality check:
> >=20
> > =C2=A0=C2=A0 How many production systems are out there still which run =
VMs on CPUs
> > =C2=A0=C2=A0 with a broken TSC and the lack of VM TSC scaling?
> >=20
> > I'm not saying that we should not support the few remaining systems
> > anymore, but our tendency to pretend that we can keep all of this
> > nonsense working and at the same time making progress is just a fallacy=
.

FWIW, I have the exact same sentiments about kvmclock, but I'm also trying =
my
best not to break folks that are happily running on what is effectively fla=
wed,
ancient "hardward".=20

> I don't know that we can take the KVM (and Xen) clock away from guests,
> but all of the *horrid* part about it is the way it attempts to cope
> with the possibility that the *host* timekeeping might flip away from
> TSC-based mode at any point in time. By the end of my outstanding
> cleanup series, that is the *only* thing the gtod_notifier remains for.
>=20
> If we can trust the hardware *and* the host kernel, then KVM could
> theoretically hardwire the kvmclock into 'master clock mode' where it
> basically just advertises the TSC=E2=86=92kvmclock relationship *once* to=
 all
> CPUs and it never changes.
>=20
> All the nonsense about updating it every time we enter a CPU could just
> go away completely.

But to Thomas' point, why bother?  For actual old hardware, kvmclock is wha=
t it
is.  For modern hardware, it's completely antiquated.
