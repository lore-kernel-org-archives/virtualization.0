Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CD35E92B
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065922; cv=none; b=U0oEJr3W3AgfaspMxGq1jde7dfQNMwzA/X275Sx43JKgcO+BJ0e0tTg5eghNx4XdlF83FXkgtS/0BfAmHE97Y091PZtAfrIEadCz3nD27gmmMXjnethWPXp8jfyMwdg9VjrXHYKDC4eL5FbMfYSoI8byxu16koGmvN4TYQrRHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065922; c=relaxed/simple;
	bh=izB9cLMxHRX9u+xy2OSKLpoF4+D8fUVi7wdBGuKKNuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTkfu5VjTCLQVOKEwvbhcP7Ci/aiTPiHhVOBFRICPT06obOtl94EUOTpEJuq0rWSB+TTCnc6ZTBghz/WoHiRdSTlao5kiIUxg4Q7Cbr83VERLJOmHizqQFFccrDfJwkMWiive2aMGvgMWSLxsYTYAXNop2xYvWgG/kbmGQ+Zw+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwJ0SROu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwJ0SROu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857befe561so173134a12.0
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065920; x=1780670720; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xvpEF1xGV6Ftnv9ed9XR60tkQggfkzBgS3+mRoziVCo=;
        b=MwJ0SROu8MhENMv/JQpnHBhvr3OYfzDmd0qw8AIMjdLn7WCYu7/IF9cjYXluOUp1Mo
         Nb8tWBbJvxOcRHYKDym3/yGWwMXfdmoSJfIFHitNGWo5tT1Ouee6IeVTKTrMeDVeHKsh
         8lxGVDLV9yzx8ESGGJ8s6cpi5CRsvwxGFmNlGhQrU0h1q742IrpGoe2Hw1PoSZ4nsC+l
         1bvBHP+L2ifcUrbnNE+wZWIjvgi54UX76BthMaueUcEMRnXZVWI+mjWtF4dVHH0Y9+IT
         gkjQJbTZePXxF4G1K0jKGEwyQT3nf0lEp8dmrKsTpZK6vUrxMh5D01EkAQAl4+8ASPMK
         vTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065920; x=1780670720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvpEF1xGV6Ftnv9ed9XR60tkQggfkzBgS3+mRoziVCo=;
        b=maHyY+V+WCqqpTq9ulelw3AGlFVep7eHugG8xJjLvu7Te1wnzFDzTyZTJ/MJreCFH8
         TCtxVxTdzRcJzbMSEx+4KFM2mse1YkMt2eN2l6V7G1qVkBGtcucqhHjOdDB3PfrQ7p1X
         MNPgizI3Nvy9LnJ0h+d4tmRZUw+C11puyoWU0uC1h+jnfnENR5VsWdBmaCs1TeyDJ+D0
         KVrNsUYJtrteLOTK72dFBtmQa4VzT0Af9WEdJ0MgzT5U8lYcck0dyazvgQT1+MpXqfXM
         mfsi9twiOa0jtK4bWNkyz0KW95PnqzXgD+RqAsAotl2JC6Ls2lCvlZnxfpiQVu0zOAE/
         jJzw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ae7ndmZrFbjPBQ4yiQRnp3V0hlsDA6xEHc3M/g4FAxcdRjw9H1nxcliIXjHAF1uEq5Pc9lSYV2z6aHqDvQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySodlfn89AaY92HD+yLczWBgU+Rnxm685a/Jr/yQzmILIrGuQ/
	qsI8q5RF3HoRys+6A8RvJVEJMVMWYKvlR7bARzgLF+DQtS+tTjo+9+lexqjrQ51HtVei53/k5FY
	GlibwEg==
X-Received: from pgc4.prod.google.com ([2002:a05:6a02:2f84:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b87:b0:3b3:d4a:793b
 with SMTP id adf61e73a8af0-3b411e5b284mr4253221637.43.1780065919253; Fri, 29
 May 2026 07:45:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:10 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-24-seanjc@google.com>
Subject: [PATCH v4 23/47] clocksource: hyper-v: Drop wrappers to sched_clock
 save/restore helpers
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that all of the Hyper-V reference counter sched_clock code is located
in a single file, drop the superfluous wrappers for the save/restore flows.

No functional change intended.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/clocksource/hyperv_timer.c | 34 +++++-------------------------
 include/clocksource/hyperv_timer.h |  2 --
 2 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 72b966340a46..69c1c7264e5d 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -472,17 +472,6 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_msr(HV_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
-/*
- * Called during resume from hibernation, from overridden
- * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
- * used to calculate time for hv tsc page based sched_clock, to account for
- * time spent before hibernation.
- */
-void hv_adj_sched_clock_offset(u64 offset)
-{
-	hv_sched_clock_offset -= offset;
-}
-
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
@@ -548,12 +537,14 @@ static void (*old_restore_sched_clock_state)(void);
  * based clocksource, proceeds from where it left off during suspend and
  * it shows correct time for the timestamps of kernel messages after resume.
  */
-static void save_hv_clock_tsc_state(void)
+static void hv_save_sched_clock_state(void)
 {
+	old_save_sched_clock_state();
+
 	hv_ref_counter_at_suspend = hv_read_reference_counter();
 }
 
-static void restore_hv_clock_tsc_state(void)
+static void hv_restore_sched_clock_state(void)
 {
 	/*
 	 * Adjust the offsets used by hv tsc clocksource to
@@ -561,23 +552,8 @@ static void restore_hv_clock_tsc_state(void)
 	 * adjusted value = reference counter (time) at suspend
 	 *                - reference counter (time) now.
 	 */
-	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
-}
-/*
- * Functions to override save_sched_clock_state and restore_sched_clock_state
- * functions of x86_platform. The Hyper-V clock counter is reset during
- * suspend-resume and the offset used to measure time needs to be
- * corrected, post resume.
- */
-static void hv_save_sched_clock_state(void)
-{
-	old_save_sched_clock_state();
-	save_hv_clock_tsc_state();
-}
+	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
 
-static void hv_restore_sched_clock_state(void)
-{
-	restore_hv_clock_tsc_state();
 	old_restore_sched_clock_state();
 }
 
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index d48dd4176fd3..a4c81a60f53d 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -38,8 +38,6 @@ extern void hv_remap_tsc_clocksource(void);
 extern unsigned long hv_get_tsc_pfn(void);
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
-extern void hv_adj_sched_clock_offset(u64 offset);
-
 static __always_inline bool
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 		     u64 *cur_tsc, u64 *time)
-- 
2.54.0.823.g6e5bcc1fc9-goog

