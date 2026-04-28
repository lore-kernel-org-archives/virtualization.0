Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA093FCB2F
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372932; cv=none; b=LWFmnN/iShsV2KDFhtrIXQfgfP14retwR3Bvw1zoUmYVaYFKkg2Zq7ib8gRy+hlqh4lyCsNczPO5v/YOVkgUhFOsQgv9AM+L5SciLulyAhPQd4vSprBzom6jrX5noDSbPLxukc0WQ3zweL16LlZx98Jsu1qO1A/tlv7ZuLJVod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372932; c=relaxed/simple;
	bh=kS157A58dRZ/AD1vGLBnOz2jKRlOzCBgyNI/NvQZns8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCTukcHbcGoRUwxeorb2nWxAoKuhLc5lnwXr/pKFTjvmOHya37tSvy12ZrQr5TnaEceQPOL9d3xE48oY3R7AUryYhIrn4Bz7bz1oXFtMoGHEh8LRqywSCK1Me3rkAqjgRBs3bqWtJSVVKzQQlC+CaClHBjJepIUsIOGYKIk/mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ua4ibM8Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ua4ibM8Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ua4ibM8Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ua4ibM8Q"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 283706A82C;
	Tue, 28 Apr 2026 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qwt4ipVlicoVVQWHQjzY6HzZ6+MdaroGCJFvi9kZADc=;
	b=Ua4ibM8QZY+H3I1nc2eszVzDEtWp+olRTLS56wBuy7EHYCYCNdw14spZxmVi8jp3RVVBmQ
	RyMkEysv+PDJl9I8Ttrsi31xViL6fJigQy/SploNqieIjOmPpEPZdqmUNasQCFWBfSxhtz
	rTCni29QIS964Io+5ySTOps6N+z0Gak=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ua4ibM8Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qwt4ipVlicoVVQWHQjzY6HzZ6+MdaroGCJFvi9kZADc=;
	b=Ua4ibM8QZY+H3I1nc2eszVzDEtWp+olRTLS56wBuy7EHYCYCNdw14spZxmVi8jp3RVVBmQ
	RyMkEysv+PDJl9I8Ttrsi31xViL6fJigQy/SploNqieIjOmPpEPZdqmUNasQCFWBfSxhtz
	rTCni29QIS964Io+5ySTOps6N+z0Gak=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481E1593B0;
	Tue, 28 Apr 2026 10:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8dHEP+O8GlrPQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:07 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH RFC 00/11] x86/msr: Reduce MSR access interfaces
Date: Tue, 28 Apr 2026 12:41:54 +0200
Message-ID: <20260428104205.916924-1-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 283706A82C

After my first attempt to rework the MSR access functions [1] this is
the result of the feedback I got.

I have still followed the idea to:

- Reduce the number of MSR access functions by keeping the ones with
  64-bit values only (instead of the dual 32-bit ones).

- Try to have inline functions instead of macros for rdmsr*(), removing
  the hard to read cases where parameters specified the variables for
  the results.

One feedback I got was NOT to rename the access functions, which I
avoided in my new approach.

The first 8 patches are a complete set for achieving especially the
first point above for the *_on_cpu() functions.

Patch 9 is preparing the switch of the CPU-local MSR access functions
to have only rdmsr(), rdmsr_safe(), wrmsr() and wrmsr_safe() (all with
64-bit values and as inline functions) in the end. For this purpose
the already existing functions/macros are overloaded via macros to
accept both variants (64-bit and dual 32-bit values) during the phase
switching the different subsystems to the new scheme. This has the
advantage to avoid having to either patch all users of the current
functions in one patch (like done in the first 8 patches), or having
to use intermediate function names with need to be patched at the end
another time. The resulting patches would be very hard to review due
to their size.

The last 2 patches are examples how switches of subsystems would look
like.

Up to now all of that is compile tested only.

[1]: https://lore.kernel.org/lkml/20260420091634.128787-1-jgross@suse.com/

Juergen Gross (11):
  x86/msr: Switch rdmsr_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_on_cpu() to use rdmsr_on_cpu()
  x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_on_cpu() to use wrmsr_on_cpu()
  x86/msr: Switch rdmsr_safe_on_cpu() to return a 64-bit quantity
  x86/msr: Switch all callers of rdmsrq_safe_on_cpu() to use
    rdmsr_safe_on_cpu()
  x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
  x86/msr: Switch all callers of wrmsrq_safe_on_cpu() to use
    wrmsr_safe_on_cpu()
  x86/msr: Add macros for preparing to switch rdmsr/wrmsr interfaces
  x86/events: Switch core parts to use 64-bit rdmsr/wrmsr() variants
  x86/cpu/mce: Switch code to use 64-bit rdmsr/wrmsr() variants

 arch/x86/events/core.c                        |  42 ++++----
 arch/x86/events/intel/ds.c                    |  11 +-
 arch/x86/events/intel/pt.c                    |   2 +-
 arch/x86/events/intel/uncore_discovery.c      |   2 +-
 arch/x86/events/intel/uncore_snbep.c          |   2 +-
 arch/x86/events/msr.c                         |   2 +-
 arch/x86/events/perf_event.h                  |  26 ++---
 arch/x86/events/probe.c                       |   2 +-
 arch/x86/events/rapl.c                        |   8 +-
 arch/x86/include/asm/msr.h                    |  90 +++++++++-------
 arch/x86/include/asm/paravirt.h               |   6 +-
 arch/x86/kernel/acpi/cppc.c                   |   8 +-
 arch/x86/kernel/cpu/intel_epb.c               |   8 +-
 arch/x86/kernel/cpu/mce/amd.c                 | 101 +++++++++---------
 arch/x86/kernel/cpu/mce/core.c                |  18 ++--
 arch/x86/kernel/cpu/mce/inject.c              |  40 +++----
 arch/x86/kernel/cpu/mce/intel.c               |  32 +++---
 arch/x86/kernel/cpu/mce/p5.c                  |  16 +--
 arch/x86/kernel/cpu/mce/winchip.c             |  10 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   2 +-
 arch/x86/kernel/msr.c                         |   8 +-
 arch/x86/lib/msr-smp.c                        |  79 ++------------
 drivers/cpufreq/acpi-cpufreq.c                |   4 +-
 drivers/cpufreq/amd-pstate-ut.c               |   2 +-
 drivers/cpufreq/amd-pstate.c                  |  21 ++--
 drivers/cpufreq/amd_freq_sensitivity.c        |   4 +-
 drivers/cpufreq/intel_pstate.c                |  64 +++++------
 drivers/cpufreq/p4-clockmod.c                 |  32 +++---
 drivers/cpufreq/speedstep-centrino.c          |  27 ++---
 drivers/hwmon/coretemp.c                      |  44 ++++----
 drivers/hwmon/via-cputemp.c                   |  16 +--
 drivers/platform/x86/amd/hfi/hfi.c            |   4 +-
 .../intel/speed_select_if/isst_if_common.c    |  13 ++-
 .../intel/uncore-frequency/uncore-frequency.c |  12 +--
 drivers/powercap/intel_rapl_msr.c             |   2 +-
 drivers/thermal/intel/intel_tcc.c             |  43 ++++----
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  22 ++--
 37 files changed, 387 insertions(+), 438 deletions(-)

-- 
2.53.0

