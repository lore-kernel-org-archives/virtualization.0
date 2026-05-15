Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2838D40F
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872836; cv=none; b=kc4fVBxBwKAV1D/vt8jtSFgChxTDZtJOJYzkmc9nBrMCuHh6LZiLudGD9qpLEeebXXim7pDqlBds83H0BPowDS1QlxobR/qOrlyxCWyu3ADWv89D/oc5mxeHkKvYFTiXGZnhS/NkWdmklZ2S3osExhA4Ty0Ym4Ftpy0r0cSKNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872836; c=relaxed/simple;
	bh=0OAy/73FzHT+UGKLaUEv1rdfbYM8J+GWTsfDYnT1B0g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGuR4yczauZ7Hi38WVZaE4J0YSAmai0SsVDCYbmJZYCZEN8srhn6hZeKipUiwH6qo5lDDtAgEkOveIho6odlc7iHcLrKBXviaOiau9WppA4+r7U/n1XqmZd78weIecH5ETu7evLuDgYDOnyEsdOuvVFzV2z/xsXsg84C037kyQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ellHAJMl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ellHAJMl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c802545ae0eso150351a12.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872833; x=1779477633; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VjouJF8LEnMo7j8C1cTkogOjB+phr08sb021HWXTXd8=;
        b=ellHAJMlmRr0INjHxFZfJ6HiRSJvqSScNCFMuGfyZkPuGcu1y2ITSSO1ibiwfqoVf4
         rwE8N5ts7AB/rHsQ+0nRpvzv/tGxYZydLgl1ZylN+AXZ1pquMB+MnlBtbdTfA6a1J9UZ
         4oaSRwk0qfYltfDCI61EBbYEZ7dFDMIu7wa34VCwcPEA38fWkdVvoHt6SWadLb3GSpcO
         WalVJC5UH3npY2Vu+9LOnnkSR/Zud34B4o/Fzhzt91qy0mzDaDutO1a1sjMIN8J9asnT
         8iMurqvvNRLSJ2Uy8G6uYpmudyET0nNQXba8ARjLSSJhTuLmjv4W8APEjXpNv4iW4bDg
         8wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872833; x=1779477633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjouJF8LEnMo7j8C1cTkogOjB+phr08sb021HWXTXd8=;
        b=iAUmEOOJsslALunfhTqX4QLVKQvRN31mxJQlIzbS5twv1xX42W/tJHPhAPFxeUQtnM
         ii7M31n8H4YTjnO45S8K/lJVs7KDFygobLNs5+eEZEie1XG1I8zo+EUASTGjPZbN2XGx
         /fmzY+nQ45nPO3PJ6dpWK6mWSCrVGJW/54KDBeoBuUNGl+5MIyjMKXX8mqjRQfH+Mosw
         dlFy3alMb/SJ7HNaGwVdePQm5gJelxBhamrlogisV+CjVb/vgluSpG8xJqSMOxmUOsj7
         lEiLOOybwCTFDGcA2p92JEa7LA0YZGzIoa/vAonKMxX2DWNg3wUi6DoXlIq8ihpTxDPV
         gr6w==
X-Forwarded-Encrypted: i=1; AFNElJ8V2tKm1Q7BA2EBZ57IhLh+/2Dxgph23MzXXDr5DDxO4VrHS1KOTdsrLOQpMI4B0tjjTw0c0nWPL3qCdUUpug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJUxjMt88JzKEUoVrqxWZ+0WqZHwVKN6GiH8VN3WLTVWPGKAWf
	3p8ZU328M6aC81CsAoRpvwRnOIxvIpZqdvDNlp0IQ+vLR0N8WViboCMOAublM4/M3HHjdd++SWO
	tupbf3g==
X-Received: from pfbcg6.prod.google.com ([2002:a05:6a00:2906:b0:836:ed4a:203f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72ab:b0:3a0:d88:6d6b
 with SMTP id adf61e73a8af0-3b22ecf592fmr6792680637.49.1778872833039; Fri, 15
 May 2026 12:20:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:09 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-9-seanjc@google.com>
Subject: [PATCH v3 08/41] clocksource: hyper-v: Drop wrappers to sched_clock
 save/restore helpers
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

Now that all of the Hyper-V reference counter sched_clock code is located
in a single file, drop the superfluous wrappers for the save/restore flows.

No functional change intended.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
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
2.54.0.563.g4f69b47b94-goog

