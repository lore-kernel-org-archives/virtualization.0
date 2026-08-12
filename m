Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CB93793AC
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563989; cv=none; b=JuBsiu8PQ56MFAS+2v8BpYv9warGOKvNhloaSlq3PErRxpMtz9uq3ygk790/Awz7USY7QBtkvDBwH7biFOXfuqpLGfuJPC3Ke84xCTsJqA4nGCKigpCcYDcGRuZXx/6BgEBiT5m1yjP9sAewGAF3WEbKI7DABcwaygMOSKsxEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563989; c=relaxed/simple;
	bh=YVpLfl8usuaq3cbL1FayKckeCMbzA+TBG36k8GLBuXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDFPwE53o5KLLaKWkxcLcVpwGpr7E8gjKURbQK43Q2/p/Muil/v/EVlyrIBS/zFvhwrpqVrLUk6EULZ72mSwvqPh5sTnJhjwcNlM39n6CxBlVoZ8Rcqwuybrvi4Bqm8KgoGGY9AlFzfPb/lPS9LhWiXkvJnysYg3PKEKjf0gO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyHweXHj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyHweXHj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so11277495e9.3
        for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 12:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563985; x=1787168785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5PKN0PuFVSn1FX4G/ZJetvpgZ6kYCSRAO6y3JMI5iE=;
        b=UyHweXHjV8kl117WfSXZKAN1lZRH9gUYiNnIAzycN2tho2Kb5+Ua0iRCBXdsdmATdb
         +9mBmKlXMRCpB+jzYaWcuBb0jCXV/KBpc64SoDT7aU7HYpKAWZoEo9YJn55THn5ThpBE
         Jv3eSHuHk8SOHUJm+98Igi1K8NecdAeADJalp+4+BSD7CqvSupmMCP/6BBPF5PmQsF1t
         mwQ6KMdS0CZUdWGhZ4e9uu7LS4lZUYeLNABrTf+6b7DQISTaiwZH7rAquWWk4adCFIhq
         mljAWLuYDlW/jkAgPDsXdVNjTgsZ2SjauHun2WMwoQkoqti9wUKF4r2KZsOlxhuBbx+T
         +kkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563985; x=1787168785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t5PKN0PuFVSn1FX4G/ZJetvpgZ6kYCSRAO6y3JMI5iE=;
        b=QMjZ0ZfNQV0uHTqg1SySMVjUZ7UambVM77VLSfRSC+Gn6b5GHZkhnFhTMCjykQsW1Q
         SuhLN3SpFFskFD2Z0v1PY5wKWZ6A2TPRT+XiKTF8lnSkiEoqtBl8SZUo/A6HcBObvI+i
         kYIm3SgO6hDqiqCYY181BSYQEOg65eLOrpBoNWF4uHBbndnCiR1t3zN+BubeTzVvDNpf
         IJ6//2XdrkjF7wvNnz/CyZn5+yHz6b0DsT4UTGjHDubuIvrM4ZyLlmO32zriNAMeuX6I
         C3rj5eR1dYFgPnGHqIViQeaUjtD96UgMgsbZSutvGyCDpRDgJJm+0nm0YA/Sp1fVkKAR
         oMBg==
X-Forwarded-Encrypted: i=1; AHgh+RpYN27Opd0nKRYGTdfEWjqlufNFMsHWKsYsc3lZkulV9/3As+dfVPN8j3QHtlP2Du5qCjkFCjFyb4R1zbMK2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmU0JNQos5ZGdoYN1vJXny6Hsq2o+GI9Uu7Hnez/8w+Zbwn3Oh
	zfkwy1HXSENAeob9LUySB1tmE3V8R/SixqrRxbDSUbm/pzy5f/wXNTi0
X-Gm-Gg: AR+sD11YyyxdpCka+o96XVA+ctWIKmGHTRNtx6DV9As84oyBkGbsVWYXktJlfCIANV7
	fsmKulbDO1TO/mpe1wEGNDRXSAM5Rsd9t0Jvy33hIOP0mLFTWtrqui/T860VzhDpi+KlOSXgSsQ
	vE6rNHkcucOEiphDqsoGKtRA3hGbjjghGNp1GGNYafZ6mRjgOsE2Jpu1Hmoxu063cZqt10evRsL
	9ufH+c+oxd4OV47+E8iRRncoMtnGenCWQhMD7/Lexmrzqf9ASMl2jOj1DrlzHXEgBPxPX5j03gP
	G+V5TsjCvaXnHZtQAjxxbOlw5g73Nklvi/wcw9CvpZBTr8LjrUuUek7IYYHugNaQ1qFaAC16LzY
	rtf+tzekHHeMXmUDbWoKaRrVuXrJwGtyP6a9+SsERawKiKHl3Keou60CBKhjprdFuqLw/73dWaG
	HftNfoOIpBcu5yxCANF9CW7rVr+fY4TEp/PICtfuf511kljoPosUofeeRIt+GU4G7iI9VHy2pYT
	nI81tL9bGAkbAVA
X-Received: by 2002:a05:600c:19c7:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-4998215a936mr2089045e9.3.1786563985255;
        Wed, 12 Aug 2026 12:46:25 -0700 (PDT)
Received: from ionutnechita-arz2022.local ([2a02:2f07:610c:8500:26e8:bb37:a2f5:aa03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b1063esm14654465e9.6.2026.08.12.12.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:46:24 -0700 (PDT)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: arighi@nvidia.com,
	chleroy@kernel.org,
	christian.loehle@arm.com,
	corbet@lwn.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gregkh@linuxfoundation.org,
	hdanton@sina.com,
	huschle@linux.ibm.com,
	iii@linux.ibm.com,
	jgross@suse.com,
	juri.lelli@redhat.com,
	kernellwp@gmail.com,
	kprateek.nayak@amd.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	maz@kernel.org,
	meted@linux.ibm.com,
	mingo@kernel.org,
	pauld@redhat.com,
	pbonzini@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rdunlap@infradead.org,
	rostedt@goodmis.org,
	seanjc@google.com,
	srikar@linux.ibm.com,
	tglx@kernel.org,
	tj@kernel.org,
	tommaso.cucinotta@gmail.com,
	vincent.guittot@linaro.org,
	vineeth@bitbyteword.org,
	virtualization@lists.linux.dev,
	vschneid@redhat.com,
	ynorov@nvidia.com,
	yury.norov@gmail.com
Subject: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce preferred CPUs and steal-driven vCPU backoff
Date: Wed, 12 Aug 2026 22:45:56 +0300
Message-ID: <20260812194600.52516-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Aug 12, 2026 at 11:10:21AM +0530, Shrikanth Hegde wrote:
> This patch series represents the result of multiple iterations,
> redesigns and community feedback.

Nice work, and thanks for the very readable cover letter.

I looked at this from the KVM and Xen guest angle rather than from
PowerVM, since that is what I run.  Three observations below.  All of
them are from code inspection only -- I have not measured any of this,
so please treat the numbers as arithmetic rather than as results.

Code references are against next-20260812, which already carries your
base commit f2c2ba7219e5, so the series applies there directly.


1) Default thresholds are unreachable on common QEMU command lines
==================================================================

get_system_cpus() returns num_possible_cpus(), and steal_governor_loop()
divides by it:

	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
	steal_ratio = div64_u64(delta_steal, delta_ns);

On x86 the possible map is sized by topology_init_possible_cpus()
(arch/x86/kernel/cpu/topology.c) from assigned + disabled CPUs, where
"disabled" is incremented by topo_register_apic() for every APIC that is
registered but not present.

QEMU emits exactly such MADT entries for the range [smp, maxcpus), and
acpi_is_processor_usable() in arch/x86/kernel/acpi/boot.c documents that
this is deliberate:

	/*
	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as
	 * usable in order to support CPU hotplug in guests.
	 */

So those vCPUs are registered as usable, land in nr_disabled_cpus, and
end up in the possible map.  A guest started with

	-smp 4,maxcpus=32

has num_possible_cpus() == 32 while only 4 vCPUs ever run.  The steal
ratio is then diluted 8x, and the default thresholds of 5% / 2% become
40% / 16% of the steal that is actually observable.  The governor never
leaves the "do nothing" window, and the only symptom is that nothing
happens.

Xen PV guests are affected in the same way, and often more strongly,
because the possible map there tends to be sized for vCPU hotplug.

I understand from the v9 changelog why possible CPUs were chosen -- it
keeps the accumulated steal monotonic across hotplug, which is a real
property worth having.  The documentation does describe the effect and
gives a worked example for recomputing the thresholds by hand.  But for
a mechanism whose whole premise is that every VM on the host opts in
with the same policy, requiring each operator to first derive their own
thresholds seems likely to translate into low real-world adoption.

Some options, roughly in increasing order of intrusiveness:

  - emit a pr_info() (or pr_warn()) at module init when
    num_possible_cpus() significantly exceeds num_online_cpus(), naming
    the ratio and the effective thresholds.  Cheap, and turns a silent
    no-op into something diagnosable.

  - scale the thresholds by num_possible_cpus() / num_online_cpus() at
    init, so the documented defaults keep their intended meaning.

  - keep summing steal over the possible mask, as today, but divide by
    the online count, and handle the hotplug discontinuity by resetting
    the sg_ctx.steal baseline from a hotplug notifier.

I do not have a strong preference among these, and the first one alone
would already be a large improvement.


2) Nothing stops the driver from folding Xen dom0
=================================================

dom0 accounts steal time like any other domain -- xen_time_setup_guest()
in arch/x86/xen/time.c wires up pv_steal_clock unconditionally, with no
feature negotiation and no privileged-domain exemption.

So loading steal_governor in dom0 makes it shrink its own preferred mask
under contention.  That is precisely when the blkback and netback
threads serving every other guest need CPU, and the driver has no notion
that this domain is different from the ones it is trying to be polite
towards.  The effect would be host-wide, not confined to the domain that
loaded the module.

Given that Kconfig carries "default m", the module is built on any
distro kernel with PARAVIRT=y, which includes dom0 kernels.  It is one
modprobe away from being loaded there, quite plausibly by someone who
read the documentation's advice to enable it uniformly across all VMs.

A xen_initial_domain() check that refuses to load, or at minimum a loud
warning, seems worth having.  More generally it may be worth stating in
the documentation that the driver is meant for guests only -- the same
argument applies to a KVM host that is itself running nested guests.

Juergen and the virtualization list are already on Cc -- I would value
their view on this one in particular.


3) Core granularity degenerates to single vCPUs on KVM and Xen
==============================================================

decrease_preferred_cpus() and increase_preferred_cpus() step by
topology_sibling_cpumask(), which matches PowerVM, where the hypervisor
schedules whole cores.

On Xen PV that mask is always the CPU itself, by design.  The header
comment of arch/x86/xen/smp_pv.c is explicit about both the behaviour
and the reason for it:

	/*
	 * Because virtual CPUs can be scheduled onto any real CPU, there's
	 * no useful topology information for the kernel to make use of.  As
	 * a result, all CPUs are treated as if they're single-core and
	 * single-threaded.
	 */

A plain "-smp N" under QEMU gives one thread per core and one core per
socket, with the same result.  So on both hypervisors the step size is
one vCPU, and convergence to a folded state takes proportionally longer
than the PowerVM numbers would suggest.

I do not think this is a correctness problem -- per-vCPU is arguably the
right granularity there, for exactly the reason the Xen comment gives.
The case that does not work as intended is the opposite one: a guest
given a synthetic topology such as

	-smp 16,sockets=1,cores=8,threads=2

will fold what it believes is a core, but those two vCPU threads need
not be co-located on any host core, so nothing in particular is freed.

So mainly a documentation request: a sentence in
Documentation/driver-api/steal-governor.rst noting that the core-level
step assumes the guest topology reflects host scheduling granularity,
and that on KVM and Xen it commonly does not.  It would also explain to
readers why convergence looks slower there than in your PowerVM numbers.


--

I would be happy to run this on x86 KVM and on Xen PV guests if that is
useful -- the series has no Xen coverage that I can see, and points 1
and 3 above would both show up there first.

Thanks,
Ionut
