Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5F3C4B91
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368359; cv=none; b=KCQr+20YAOhWIZ4YAhYS1J4ix4SnVnPCkd4oapzvm4ZNgw8QedOOi6nwWiNuNLEUM/1q6IlnBajVoUE6lziOFtg5XO2t2CE/x3HeY/IMMI/lFT0vusMknF/6AyOoHZi3olLHO5ujXSXFGNPyYpk2vc2IJpPGOKaD6PPsCTy3PBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368359; c=relaxed/simple;
	bh=0rVVosXepCYQeGWe7dkZUA8zbJznpObfcXBvPIXEpbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bok4J3SIFMUnyg7nNEZc3rGb+kPLULY0Uiij8Ysw7LgvZh63cjYRTL2OHewGgywBYLZqBO4UX1StbSeztJ5b+S36Z/c6mI4QGYJ9hPSvos3TDSgL0BiyV4LpWZPbTs653UItvmqJXlnLUt3A6MINAmEnjT4zCjTGRty7ZrBjprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmQGIKsE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmQGIKsE"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso3141570b3a.2
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779368358; x=1779973158; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=OmQGIKsE89QeeEVCMAkhpEep014jMePmLgZ09K06BvS2ZfzRAPpUMnduv/y5hHD0bn
         Xg4wu7cVjY6IUoQCzG4CgTQLGhETp6UTpZPTdsjHnHd4k04P22GIPZdU5x/H/SsBqMS3
         rz13kAeyoRerlLGErGF4RhItPCJQBXngGfg5Eln8yQkVOoHiLtHCtPUYpD+SltAwz2BN
         kKDfxhgXyzPufaAAi4LVVSiOlOBI6ilL+wCao5lyZNUjzxHMS4MVje8DgFMWy6a7f7lX
         QGhzIHAFk++ia6QTxtRotM+fx1iwgbY3v0LzX1DM19X6RO1xdD4utmvLWnzI7+5rXZMC
         iaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368358; x=1779973158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqcHY/DvmkAZ9QjHGP0kTeF7mk7WkCMN/ZHV20HdBXo=;
        b=RS4vxg+gBQZydWCz/qt/tAnfLpR1JKHTNEVxeUuffKKRvbOxLBj8G3p2+nACRj7AVZ
         PnPiLWqZQ9hRIttM534CEyib9WP0bnjGESArbCGkQARjAiM9L732Z7dir4kwl20v1sh2
         qI8XlUrwG0NI6Hqt1oLthN8AZPVwPMfmUv9GYJqPxOwdWlRl4Ddzjbh9TfGYRUHp0bZf
         JV+G1IEPWY2oT8Ee7oTqDrr94Wirt5CSI+JZA6BhipcoECguLLnJDt6JWpW33EU5+swO
         1DyF67rQssjTyeKcy4eWT9mrSBRzXcu0Ha7GC0CoA4+m9UoG+5vhXF8c6XuLD3wkF1dj
         6RIA==
X-Forwarded-Encrypted: i=1; AFNElJ8OV/ZxqJZ3HZYelPXqQnxS+P/R+0riWpKkJ+sBs3FOF5zdjkCfHQoIyYum3IYF3xT3PZ5ss0WPSTACEP1xrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXAuWxooATUyBgiXTpJVlutSZfTFY3l/tQJ/yKmgrBy6viGTCt
	toXQWmiKP9Q3n05yjHuTMoaLAwq2TuW7z744nIIPvTX/SatYtqmfkbmcJdmBx6N60Nr/FBKDWN8
	vuP+LaQ==
X-Received: from pfdc18.prod.google.com ([2002:aa7:8c12:0:b0:834:df9e:8e02])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4655:b0:82f:de7:d29
 with SMTP id d2e1a72fcca58-8414ae013a1mr2977074b3a.31.1779368357753; Thu, 21
 May 2026 05:59:17 -0700 (PDT)
Date: Thu, 21 May 2026 05:59:17 -0700
In-Reply-To: <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-28-seanjc@google.com>
 <423b37f056f0d4d596d5f4cc73802fb1079ecf63.camel@infradead.org>
Message-ID: <ag8Bpc_uVNrNWqfX@google.com>
Subject: Re: [PATCH v3 27/41] x86/kvmclock: Enable kvmclock on APs during
 onlining if kvmclock isn't sched_clock
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
> On Fri, 2026-05-15 at 12:19 -0700, Sean Christopherson wrote:
> > In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
> > kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
> > invoked if and only if kvmclock is set as sched_clock, ensure APs enabl=
e
> > their kvmclock during CPU online.=C2=A0 While a redundant write to the =
MSR is
> > technically ok, skip the registration when kvmclock is sched_clock so t=
hat
> > it's somewhat obvious that kvmclock *needs* to be enabled during early
> > bringup when it's being used as sched_clock.
> >=20
> > Plumb in the BSP's resume path purely for documentation purposes.=C2=A0=
 Both
> > KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
> > not super obvious that using KVM's hooks would be flawed.=C2=A0 E.g. it=
 would
> > work today, because KVM's hooks happen to run after/before timekeeping'=
s
> > hooks during suspend/resume, but that's sheer dumb luck as the order in
> > which syscore_ops are invoked depends entirely on when a subsystem is
> > initialized and thus registers its hooks.
> >=20
> > Opportunsitically make the registration messages more precise to help
> > debug issues where kvmclock is enabled too late.
>=20
> That's a hard word to type, isn't it?

Heh, you have no idea.  I've been "this" close to creating a VIM binding fo=
r a
while, it is time...
