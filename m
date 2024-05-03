Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8115442B
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745007; cv=none; b=m93mR01/wC+sbNtpp/xcygJxTZ3TyD2iAYpPQhxXIqWrkn6hTl8qs90zBVnKt3DN6lSvmIXLwm7knwKKLPeMaRHTAU6wx26qAIFN5vdXdeecwFn468ba7q2GEW7ixIFuiM4jtS8YtHCUWVyorN7At1DwAZXTQdGZXEHfSALEekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745007; c=relaxed/simple;
	bh=7+85l5gtG9BMCJsXUhbIe6mJsJUfD1GuV0eeYeZs6G4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEuMhTm8unvHDdkWNtuNU3EVkmXmnP4gxT4cK5gvP1EJCLFCdw2j7q8zDbb+8HMb0o3DAgtfeFFOsWS72CrRnwLxTYfwzFg2e1eWzwcffgPG6P4k6OG2x0+5TmPFHFYUy4Vd3U7VvZRu3RRKYizRrpioV6BtR4vFMkLMfvLrlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eedEyfGg; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eedEyfGg"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EBE9241D42
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 14:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.601
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Apx0tCCKTcKW for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 14:03:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3q-40zgykajqg2yb704cc492.0ca@flex--seanjc.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D124141D3C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=google.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D124141D3C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=eedEyfGg
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D124141D3C
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 14:03:24 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so15285773276.3
        for <virtualization@lists.linux-foundation.org>; Fri, 03 May 2024 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714745003; x=1715349803; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
        b=eedEyfGgsDgt1TcEysl4hat0uKz/jcBHxsxQ3o6r5VsYnJlPUaeVhQkBf5uCp3uLjS
         j21vA/kQheTKgSdmziFsJopOJ5kINFKyDQx6VnmPKP5+8RqvDfF0NdyddxYcG66ZQ2/q
         bwJfr0seFn0EmWv6rNPqOeuvQFIBEX+6DP08N+K7UeFzUaUlyX5l5Y1BS9LVy3BrNGVt
         uMOi3k0lnqdzZ/gVcK6k2EqyIpFvZr5Qu3jW9F94xj/m7V6e0rM1mwsiJVmchI/zH8J7
         FhGNoYOVEISmvbKNl35+cLxyr2GlIDlVuG1+z+fUu7J9O95fvf+5liaJBe+ZrJC8eIjG
         /iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745003; x=1715349803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
        b=qBmlw2/wvUQZ9EAhpLOj6Ds7sQ4f+fe2+A+UtoL4gUDY63spSG6rFV3/kzmf+HUQau
         p6mw0GjQXCQ6o7pAcG3VgByEP4Y5cGoHSRxiy3HSbr9PZVtPgPvPLAZJM3kHm5g479/7
         FiBXb/NNzGK8Nsb8ZxQiGgwyU4ksRC89CMamBR4Ad98jtepO+iS9OznNwTCATYFIFBRO
         kgmPpFfASI8WcdP9kagVSHgTDlZNuD1IYaFchxMh3xFKiBXw0HGWQgoG8F2N66d67jNW
         +Om2U/jtLlb4Fc7P/9nxe+KmO9HZD7X91iHLX5HvZHLiI/vU+BnejcOvZ2aFbaI5aXOP
         mmyg==
X-Forwarded-Encrypted: i=1; AJvYcCXoOM+a9zHhS/zccrQUavd+6fVxwxFQ9UBIZYE8zbJV8S9FNqq6MEkv62VpN45oDw7T1DK4eursAa5YW8s/0o8XcdeXNP0FqjAX04Xj2L8fizGSWf3ThpZ+6Q==
X-Gm-Message-State: AOJu0YyJmi0n23BzvKC/OZeDrr40EYwoENPf5FbPqG8xTpAj9mu0FzFM
	geevREVxYFB+fYnyV2M/AB/gekvbuAQIYYdKM/cq8zssyon1/EuZxhxTY+mPRHuy7qmXIqw8MwO
	sgA==
X-Google-Smtp-Source: AGHT+IG8Se+FDx3icVQiBS8y3Ql+XygTIGhFwTldpFeLgMxDQJNLd2QsRcCHI+DmhaCm9MeTHgIbmJIbKcw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1201:b0:de6:141a:b0de with SMTP id
 s1-20020a056902120100b00de6141ab0demr337561ybu.10.1714745003300; Fri, 03 May
 2024 07:03:23 -0700 (PDT)
Date: Fri, 3 May 2024 07:03:21 -0700
In-Reply-To: <20240503131910.307630-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
Message-ID: <ZjTuqV-AxQQRWwUW@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> Add an interface for user space to be notified about guests' Heki policy
> and related violations.
>=20
> Extend the KVM_ENABLE_CAP IOCTL with KVM_CAP_HEKI_CONFIGURE and
> KVM_CAP_HEKI_DENIAL. Each one takes a bitmask as first argument that can
> contains KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4. The
> returned value is the bitmask of known Heki exit reasons, for now:
> KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4.
>=20
> If KVM_CAP_HEKI_CONFIGURE is set, a VM exit will be triggered for each
> KVM_HC_LOCK_CR_UPDATE hypercalls according to the requested control
> register. This enables to enlighten the VMM with the guest
> auto-restrictions.
>=20
> If KVM_CAP_HEKI_DENIAL is set, a VM exit will be triggered for each
> pinned CR violation. This enables the VMM to react to a policy
> violation.
>=20
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240503131910.307630-4-mic@digikod.net
> ---
>=20
> Changes since v1:
> * New patch. Making user space aware of Heki properties was requested by
>   Sean Christopherson.

No, I suggested having userspace _control_ the pinning[*], not merely be no=
tified
of pinning.

 : IMO, manipulation of protections, both for memory (this patch) and CPU s=
tate
 : (control registers in the next patch) should come from userspace.  I hav=
e no
 : objection to KVM providing plumbing if necessary, but I think userspace =
needs to
 : to have full control over the actual state.
 :=20
 : One of the things that caused Intel's control register pinning series to=
 stall
 : out was how to handle edge cases like kexec() and reboot.  Deferring to =
userspace
 : means the kernel doesn't need to define policy, e.g. when to unprotect m=
emory,
 : and avoids questions like "should userspace be able to overwrite pinned =
control
 : registers".
 :=20
 : And like the confidential VM use case, keeping userspace in the loop is =
a big
 : beneifit, e.g. the guest can't circumvent protections by coercing usersp=
ace into
 : writing to protected memory.

I stand by that suggestion, because I don't see a sane way to handle things=
 like
kexec() and reboot without having a _much_ more sophisticated policy than w=
ould
ever be acceptable in KVM.

I think that can be done without KVM having any awareness of CR pinning wha=
tsoever.
E.g. userspace just needs to ability to intercept CR writes and inject #GPs=
.  Off
the cuff, I suspect the uAPI could look very similar to MSR filtering.  E.g=
. I bet
userspace could enforce MSR pinning without any new KVM uAPI at all.

[*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com
