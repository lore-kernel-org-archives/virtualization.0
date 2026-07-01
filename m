Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A34189C9
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934382; cv=none; b=PS5fU/RbNt8K7+8c5UGNyo9VDbQh5eR3KUa/R3sdmmbDkOUaEVIs6JqNED9hvyMrcKVJ93hdflGplBltP2JkCeh64fpi2Vor8QzhLRcWYVfz4fClWVkpdK0Pz1ePcPHdt8lo2hUK21Fpi98zQQZTgrtYJTDg+IJOzOag2u4AxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934382; c=relaxed/simple;
	bh=naebGTX3IOtMBaOZ6Pc/blHlj+HGS0vQ3lqqBbsq1SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FOfvuMB67Ajw/6zd/i693wiASyx3vwH4oE01IlxCsVtc8MWh5FkEX8PCCoJXcOzjpsV0LudeYYF4r+mfHx5FUIbE94NfFCbuDi+gxXhB/REyR0hmMdA31Wyr1uesnxKBLJgyda8X/rJ72WomLaUTto+DOpV6zOTEF/OJpK3Yzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1v9x+2Y; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1v9x+2Y"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88d7a75507so1270574a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934378; x=1783539178; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m4IxRx7fOhcWBmMrJhtIUc/shJhrGyqdre87YRmUR5M=;
        b=t1v9x+2YZhrr4XrUpn5xLG7k7eUSq5WmzrDdlHhglV3G96Dlxv/vbObyCcIAn9CNsz
         kkA5E4XZo9GsfEXZWsFcxFKe/2kYkZDYtAOvWvdlKK1bmVaD1HKXiqk6ZoCKb5RUyLvU
         7PZr5r8bZvKLzq84zAPe4BuOA0F0Mwv2BltWy0vhUDX/5R5ueVzpojO3LBBGHgU+dW1Q
         gUgBofTJHpzFZRo5mBRYD3+V10ydXbDcOVNFF3NP1Bhzk7Wso7YdjiIBwwtgO87wKf6t
         sC/IXlsXi5/cUzffjuCKnVugYOLQcudiB9NqcJ40/ax2lQaOkv7BIBt/mwe6C5hkFpRt
         nSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934378; x=1783539178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4IxRx7fOhcWBmMrJhtIUc/shJhrGyqdre87YRmUR5M=;
        b=e0Xw06IqpXvf/1yH5eP3WdxeO/udKxPBG1bf8GmvxhXZW/I39YhS+aRomup9IXgr2q
         PyHMPtIXo0xshhvSL2W99HVFvmsaitlCqIWB/y/yj92VOD/oYRsc3llS78Q5QgidhUsm
         AzMBfIXYEEN76rnNow1hfmsR+zNNbF2u8/QudNHX9GDyMl+Km8uITOdCyhnkTVl8RIE2
         1JLJEBICFKTwA2v6SyHAqXrB8VZBIOXdBdE38/oUP1wdv1LQEZnNrdgGRvLmLmSEkY7Z
         w2IlSwXyH9Afzr16P7z8aa/YGAMOLnfzxDR5j4Y3f/2aTmsJ+jF0ItQ3BrvICI8p0Uur
         nbqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NJWfgjIAHxT1jOxuQBdLxXeOG68Ll/YduV52maqN0QjuN3Olz3THTcjC3T9bFrF5f2BgV9eYu63RKtzbW6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeZ5IQrgJB5SBgGqGcUuFjP5swT/JRxAO/nyoXAWRvG0Khu1/C
	U1VZp/Mp5NZnfD0RYWUhuUbwI389XENFNDMyjYD/AzuFMFyB6lN4wIOTbsKbQw5yzdDJwcRFgdS
	djZieBQ==
X-Received: from pgbda6.prod.google.com ([2002:a05:6a02:2386:b0:c99:7baf:126d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b01:b0:3b4:931c:3c7c
 with SMTP id adf61e73a8af0-3bfed50b68fmr3305567637.44.1782934378058; Wed, 01
 Jul 2026 12:32:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:47 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-27-seanjc@google.com>
Subject: [PATCH v5 26/51] clocksource: hyper-v: Drop wrappers to sched_clock
 save/restore helpers
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
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
index 4293173c3a27..daa8cbfe61ee 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -488,17 +488,6 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
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
@@ -565,12 +554,14 @@ static void (*old_restore_sched_clock_state)(void);
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
@@ -578,23 +569,8 @@ static void restore_hv_clock_tsc_state(void)
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
2.55.0.rc0.799.gd6f94ed593-goog

