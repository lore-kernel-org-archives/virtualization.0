Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA01F3B8A
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872812; cv=none; b=gRMHYujjsPgTK+cCE7o6njNnYzK8RlpjFSVbg77Sl0B9ahbEScvSvjw08BRteGyuPfb8v5kZKDjUX13P1h43mW9TVjJYbfYQfhfmclTN3YkHkgigz6oa1FfQFeEHiSuOnI6BnwgSQKwHGPlZLT7ZNxQZR7uC8cboQmLBzHti7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872812; c=relaxed/simple;
	bh=mbZ13gEHfodDhcP4yEh41LFGqTZKndN96BUAiSrFJkQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ivfYuqW4p9PYQKvsOhIOwMuOqEI+/2EOqF2Qi+As2b5wLEDD0IJax7W12F4amDOK7fW1bI4bTI5cMRPMg+stRD1r1EyPhBC2y4rQWdFpWhRjrBtXfuWs/cMTVbUBaosrdkNw9WrDUYtDgYdG15XEpde2baWEUhz+7CH6lSaytt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUMDTW4q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUMDTW4q"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso184380a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872808; x=1779477608; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6Bo/RhEQ+ohQ2bSS/OTKsKl1FaExY7Ds1WzHI7v1C0=;
        b=mUMDTW4qW84HGE5WD9lkMk9bzdQqE6yo4smPaAEgvK0k+m9Rz7Tcy42ruTdNf07Jps
         r+t1FOmXRoEKXQI0mS5qxeg8CCNJxKcQC6QV9i3pgdqvlD4GNCZSiktLX7JzNX3S/8ZB
         aKi3Zwqdd0gTaIh2Z7qO3hioYpNgslTm2P9NsXHASGRZPAX8go+BDGB6Rc63OSxgJ8nC
         kUlxsmuj0pcpt1G740a6KIsL/Fow1D2jDdJhNeD+hbQtZJX0b7BA89TU6EMBgfbPyKsD
         Z4VhwhjiYYasKmhgrH73HgpY/oP9TMmeim6mOvlms3chzVYa1+APlY62FQ9hh2Sde8Cw
         gWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872808; x=1779477608;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6Bo/RhEQ+ohQ2bSS/OTKsKl1FaExY7Ds1WzHI7v1C0=;
        b=bvg61fY4Li1ucHLXjxT31Po7/ztkTMlvuk2S5iDNWUmvNSI4WVmmGtEfM++ncFkG0w
         uHPciqnx6/bCy2tqByvbxleKClvzQ6a14jwSCuzIawlMOQtvTJwo+o3q6aAHT1wt8Uh+
         DpLdxEOcb8ClGqPfO8ugODGbuQEenklhBlCB2QlXux4isIwos8WoIJCWJGWaxPzXFas6
         sOsWTBHf4y7pg/lq0BNosA+ua/JwnnmIqR7hO6TWzY/A72QGk1Ho7BzwlsVZANd8l1Qq
         Eycfg83oNpNEZstktwfS1RSInUCbafLbhuWOIFExKHlrEKZ47qVrGIoqIOGYQpF4oUx6
         KwaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8muO0AAkYkl0tqsfNRG0jEUkzeVv6wssuRhzqs/5x3M9H25fhoH+PhntFk8CBrBsezysGJ2+AIutIWa6MroA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycfFq0k9Qj3vQBumpVB7WEvyblf4lKcObh8m757rniGwseI5qf
	+g+7cxK/GJ91U7ANIXlSdfOKh2vjJTi6QNR7mmRLO+Fqh8sJF1kyX3RDdwuyxrta4DLHJhBsD7+
	gUUgC1Q==
X-Received: from pgbcq13.prod.google.com ([2002:a05:6a02:408d:b0:c80:26d4:20ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1595:b0:398:7df5:2dae
 with SMTP id adf61e73a8af0-3b22e67bbfbmr6212145637.9.1778872807764; Fri, 15
 May 2026 12:20:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:01 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-1-seanjc@google.com>
Subject: [PATCH v3 00/41] x86: Try to wrangle PV clocks vs. TSC
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Dave/Thomas/Peter/Boris, what's the going rate for bribes to take something
like this through the tip tree?  

The bulk of the changes are in kvmclock and TSC, but pretty much every
hypervisor's guest-side code gets touched at some point.  I am reaonsably
confident in the correctness of the KVM changes.  Michael tested Hyper-V in
v2, and while there were conflicts when rebasing, they were largely
superficial (and I've just jinxed myself).  For all other hypervisors, assume
the code is compile-tested only, but those changes are all quite small and
straightforward.

The only changes that are questionable/contentious are the last two patches,
which have KVM-as-a-guest use CPUID 0x16 to get the CPU frequency, even on
AMD (that's the dubious part).  I very deliberately put them last, so that
they can be dropped at will (I don't care terribly if those patches land).
To merge them, I would want explicit Acks from Paolo and David W.

So, except for the last two patches, to get the stuff I really care about
landed, I think/hope it's just the TSC and guest-side CoCo changes that need
reviews/acks?

The primary goal of this series is (or at least was, when I started) to
fix flaws with SNP and TDX guests where a PV clock provided by the untrusted
hypervisor is used instead of the secure/trusted TSC that is controlled by
trusted firmware.

The secondary goal is to draft off of the SNP and TDX changes to slightly
modernize running under KVM.  Currently, KVM guests will use TSC for
clocksource, but not sched_clock.  And they ignore Intel's CPUID-based TSC
and CPU frequency enumeration, even when using the TSC instead of kvmclock.
And if the host provides the core crystal frequency in CPUID.0x15, then KVM
guests can use that for the APIC timer period instead of manually calibrating
the frequency.

The tertiary goal is to clean up all of the PV clock code to deduplicate logic
across hypervisors, and to hopefully make it all easier to maintain going
forward.

Lots more background on the SNP/TDX motiviation:
https://lore.kernel.org/all/20250106124633.1418972-13-nikunj@amd.com

Note, I deliberately omitted:

  jailhouse-dev@googlegroups.com

from the To/Cc, as those emails bounced on v1, AFAICT nothing has changed, and
I have zero desire to get 41 emails telling me an email couldn't be delivered.

v3:
 - Collect reviews. [Michael, Thomas]
 - Use Hyper-V reference counter / refcounter instead of Hyper-V timer. [Michael]
 - Use the paravirt CPUID interface first proposed by VMware for KVM's
   "official" mechanism for communicating frequency to KVM-aware guests,
   instead of abusing Intel's CPUID leafs. [David]
 - Deal with paravirt code being moved into asm/timers.h and
   arch/x86/kernel/tsc.c.

v2:
 - https://lore.kernel.org/all/Z8YWttWDtvkyCtdJ@google.com
 - Add struct to hold the TSC CPUID output. [Boris]
 - Don't pointlessly inline the TSC CPUID helpers. [Boris]
 - Fix a variable goof in a helper, hopefully for real this time. [Dan]
 - Collect reviews. [Nikunj]
 - Override the sched_clock save/restore hooks if and only if a PV clock
   is successfully registered.
 - During resome, restore clocksources before reading persistent time.
 - Clean up more warts created by kvmclock.
 - Fix more bugs in kvmclock's suspend/resume handling.
 - Try to harden kvmclock against future bugs.

v1: https://lore.kernel.org/all/20250201021718.699411-1-seanjc@google.com

David Woodhouse (2):
  KVM: x86: Officially define CPUID 0x40000010 as PV Timing Info (TSC
    and Bus)
  x86/kvmclock: Obtain TSC frequency from CPUID if present

Sean Christopherson (39):
  x86/tsc: Add a standalone helpers for getting TSC info from CPUID.0x15
  x86/tsc: Add helper to register CPU and TSC freq calibration routines
  x86/sev: Mark TSC as reliable when configuring Secure TSC
  x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
  x86/tdx: Override PV calibration routines with CPUID-based calibration
  x86/acrn: Mark TSC frequency as known when using ACRN for calibration
  clocksource: hyper-v: Register sched_clock save/restore iff it's
    necessary
  clocksource: hyper-v: Drop wrappers to sched_clock save/restore
    helpers
  clocksource: hyper-v: Don't save/restore TSC offset when using HV
    sched_clock
  x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
  x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
  x86/paravirt: Remove unnecessary PARAVIRT=n stub for
    paravirt_set_sched_clock()
  x86/paravirt: Move handling of unstable PV clocks into
    paravirt_set_sched_clock()
  x86/kvmclock: Move sched_clock save/restore helpers up in kvmclock.c
  x86/xen/time: Nullify x86_platform's sched_clock save/restore hooks
  x86/vmware: Nullify save/restore hooks when using VMware's sched_clock
  x86/tsc: WARN if TSC sched_clock save/restore used with PV sched_clock
  x86/paravirt: Pass sched_clock save/restore helpers during
    registration
  x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
  x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
  x86/pvclock: Mark setup helpers and related various as
    __init/__ro_after_init
  x86/pvclock: WARN if pvclock's valid_flags are overwritten
  x86/kvmclock: Refactor handling of PVCLOCK_TSC_STABLE_BIT during
    kvmclock_init()
  timekeeping: Resume clocksources before reading persistent clock
  x86/kvmclock: Hook clocksource.suspend/resume when kvmclock isn't
    sched_clock
  x86/kvmclock: WARN if wall clock is read while kvmclock is suspended
  x86/kvmclock: Enable kvmclock on APs during onlining if kvmclock isn't
    sched_clock
  x86/paravirt: Mark __paravirt_set_sched_clock() as __init
  x86/paravirt: Plumb a return code into __paravirt_set_sched_clock()
  x86/paravirt: Don't use a PV sched_clock in CoCo guests with trusted
    TSC
  x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration
  x86/tsc: Rejects attempts to override TSC calibration with lesser
    routine
  x86/kvmclock: Mark TSC as reliable when it's constant and nonstop
  x86/kvmclock: Get local APIC bus frequency from PV CPUID Timing Info
  x86/kvmclock: Use TSC for sched_clock if it's constant and non-stop
  x86/paravirt: kvmclock: Setup kvmclock early iff it's sched_clock
  x86/paravirt: Move using_native_sched_clock() stub into timer.h
  x86/tsc: Add standalone helper for getting CPU frequency from CPUID
  x86/kvmclock: Get CPU base frequency from CPUID when it's available

 Documentation/virt/kvm/x86/cpuid.rst |  12 ++
 arch/x86/coco/sev/core.c             |   9 +-
 arch/x86/coco/tdx/tdx.c              |  27 ++-
 arch/x86/include/asm/kvm_para.h      |  12 +-
 arch/x86/include/asm/tdx.h           |   2 +
 arch/x86/include/asm/timer.h         |  18 +-
 arch/x86/include/asm/tsc.h           |  20 +++
 arch/x86/include/asm/x86_init.h      |   2 -
 arch/x86/include/uapi/asm/kvm_para.h |  11 ++
 arch/x86/kernel/cpu/acrn.c           |   5 +-
 arch/x86/kernel/cpu/mshyperv.c       |  69 +-------
 arch/x86/kernel/cpu/vmware.c         |  11 +-
 arch/x86/kernel/jailhouse.c          |   6 +-
 arch/x86/kernel/kvm.c                |  62 +++++--
 arch/x86/kernel/kvmclock.c           | 250 +++++++++++++++++++--------
 arch/x86/kernel/pvclock.c            |   9 +-
 arch/x86/kernel/smpboot.c            |   3 +-
 arch/x86/kernel/tsc.c                | 184 +++++++++++++++-----
 arch/x86/kernel/x86_init.c           |   1 -
 arch/x86/mm/mem_encrypt_amd.c        |   3 -
 arch/x86/xen/time.c                  |  13 +-
 drivers/clocksource/hyperv_timer.c   |  38 ++--
 include/clocksource/hyperv_timer.h   |   2 -
 kernel/time/timekeeping.c            |   9 +-
 24 files changed, 537 insertions(+), 241 deletions(-)


base-commit: 1196e304db58189264bb5953b4e8da7e90cda615
-- 
2.54.0.563.g4f69b47b94-goog

