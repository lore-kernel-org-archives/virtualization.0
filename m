Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6BC4361B
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 18:54:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642142228A
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642142228A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0817487AB3;
	Wed,  9 Dec 2020 18:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWP7wFgMX04A; Wed,  9 Dec 2020 18:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6705987A61;
	Wed,  9 Dec 2020 18:54:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FAD0C0FA7;
	Wed,  9 Dec 2020 18:54:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6DEBC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0C1B86DB1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bybe7ttR4mdb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:54:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 12B0B86DAF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:54:30 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1607540067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Uu7pkTsDY6PR0uRw8JT+RVlLSz62Q8pgzg6y5Vv+F8=;
 b=ZKyRHF02e6C/n1mUBKn5ZR+XVl6dDjKmAKKg5N6crtAg3HJ2EOJsCCYkTM8vHNeLb8e1EE
 woT+FRsq9wRBfKR1H/jU/h5ITtu8upRL+qht0KlSG2FPcGkAH50CYTjWzYIsGM1MBx+iWY
 ZvsmEPNQYKrYuTvetq+cnT9AM+zSzfv26zNUDqMcYYy5Az+ooZ8kxUTRgcQxFQ6FrUZZA7
 tY++O41Ru5wCUH11xGUu3nNNoe1jAmst2c8vb9fs1ROv5DpuiAJAfEGvFi7t2m4iBw9m+F
 U7kRP7HRP7vVZzw7D+fjTVnk7dQ2NJnIZPMHxtpdBE5YJPwHXnrxOYNyE+5jUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1607540067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Uu7pkTsDY6PR0uRw8JT+RVlLSz62Q8pgzg6y5Vv+F8=;
 b=c0VvWr+XQ1eFIDzaipp+m6QkbNpqK8MTFWzd5nGNoue3bmiiBo/fQBptKc2vv17Tly9FpG
 ckQTiaR3Qc/ZrSAA==
To: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
In-Reply-To: <20201209181514.GA14235@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <20201209181514.GA14235@C02TD0UTHF1T.local>
Date: Wed, 09 Dec 2020 19:54:26 +0100
Message-ID: <87tusuzu71.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, luto@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Dec 09 2020 at 18:15, Mark Rutland wrote:
> In arch/x86/kernel/apic/io_apic.c's timer_irq_works() we do:
>
> 	local_irq_save(flags);
> 	local_irq_enable();
>
> 	[ trigger an IRQ here ]
>
> 	local_irq_restore(flags);
>
> ... and in check_timer() we call that a number of times after either a
> local_irq_save() or local_irq_disable(), eventually trailing with a
> local_irq_disable() that will balance things up before calling
> local_irq_restore().
>
> I guess that timer_irq_works() should instead do:
>
> 	local_irq_save(flags);
> 	local_irq_enable();
> 	...
> 	local_irq_disable();
> 	local_irq_restore(flags);
>
> ... assuming we consider that legitimate?

Nah. That's old and insane gunk.

Thanks,

        tglx
---
 arch/x86/kernel/apic/io_apic.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1618,21 +1618,16 @@ static void __init delay_without_tsc(voi
 static int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
-	unsigned long flags;
 
 	if (no_timer_check)
 		return 1;
 
-	local_save_flags(flags);
 	local_irq_enable();
-
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		delay_with_tsc();
 	else
 		delay_without_tsc();
 
-	local_irq_restore(flags);
-
 	/*
 	 * Expect a few ticks at least, to be sure some possible
 	 * glue logic does not lock up after one or two first
@@ -1641,10 +1636,10 @@ static int __init timer_irq_works(void)
 	 * least one tick may be lost due to delays.
 	 */
 
-	/* jiffies wrap? */
-	if (time_after(jiffies, t1 + 4))
-		return 1;
-	return 0;
+	local_irq_disable();
+
+	/* Did jiffies advance? */
+	return time_after(jiffies, t1 + 4);
 }
 
 /*
@@ -2117,13 +2112,12 @@ static inline void __init check_timer(vo
 	struct irq_cfg *cfg = irqd_cfg(irq_data);
 	int node = cpu_to_node(0);
 	int apic1, pin1, apic2, pin2;
-	unsigned long flags;
 	int no_pin1 = 0;
 
 	if (!global_clock_event)
 		return;
 
-	local_irq_save(flags);
+	local_irq_disable();
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -2191,7 +2185,6 @@ static inline void __init check_timer(vo
 			goto out;
 		}
 		panic_if_irq_remap("timer doesn't work through Interrupt-remapped IO-APIC");
-		local_irq_disable();
 		clear_IO_APIC_pin(apic1, pin1);
 		if (!no_pin1)
 			apic_printk(APIC_QUIET, KERN_ERR "..MP-BIOS bug: "
@@ -2215,7 +2208,6 @@ static inline void __init check_timer(vo
 		/*
 		 * Cleanup, just in case ...
 		 */
-		local_irq_disable();
 		legacy_pic->mask(0);
 		clear_IO_APIC_pin(apic2, pin2);
 		apic_printk(APIC_QUIET, KERN_INFO "....... failed.\n");
@@ -2232,7 +2224,6 @@ static inline void __init check_timer(vo
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	legacy_pic->mask(0);
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | cfg->vector);
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed.\n");
@@ -2251,7 +2242,6 @@ static inline void __init check_timer(vo
 		apic_printk(APIC_QUIET, KERN_INFO "..... works.\n");
 		goto out;
 	}
-	local_irq_disable();
 	apic_printk(APIC_QUIET, KERN_INFO "..... failed :(.\n");
 	if (apic_is_x2apic_enabled())
 		apic_printk(APIC_QUIET, KERN_INFO
@@ -2260,7 +2250,7 @@ static inline void __init check_timer(vo
 	panic("IO-APIC + timer doesn't work!  Boot with apic=debug and send a "
 		"report.  Then try booting with the 'noapic' option.\n");
 out:
-	local_irq_restore(flags);
+	local_irq_enable();
 }
 
 /*
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
