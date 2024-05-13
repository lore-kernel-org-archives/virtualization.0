Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B72AF09
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640368; cv=none; b=Gf7NVOR047giSDofpalqpMNMJbfhCdWH5EopexCyqdYOC8Vg0e2kds+ey1Nvw1zrUaY7D/iPUzM5dFwtqK1xE5BoIWLOVQnKTo9sWGnlrwAHj6RABX7BCRwcD+LBookWwQ4vJ82y/+B/LESSGWEN11i7hBE8/SiCfgP7q44JNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640368; c=relaxed/simple;
	bh=xgS8ctYmFDYeO4W8cynYAk5l9G01HMcEDRkVMRZle2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ehk6uOHNzgrP+y47emz2xGEodk4ttT9TTo5C5vvtnKzIGi1U+My5DfojtwBrU+olEznj+q2B+p5dLgtG8KFT5gfz1Oh0O4RvhP+IZH7hk+LFtCWAi3U9/UfPlEFtNl7y6GUr4JJbBbxHdZUpZK/gYJX7lZcqrO5LM6WDtlWD12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BrSURgpd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KM3ZlG9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrSURgpd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KM3ZlG9F"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715640363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr0dlAhwjPUp2s9a7M72hVlk72/s1iwl2G42Yl1sj6o=;
	b=BrSURgpdmTdCaEsXhJ89OpLao6XttoGfbYGR+sltBkGnN7W+KxLaDqqZPN1Rzgibdl4qAX
	45qgEcckdYlCBZFAcZHcBIryvF7E5U0co2BpoM3aTdWR4xqHHK8dZW6P8yw4irek6vBhp7
	uEnA7jJLE1keO3Q+SqufLi6phQUwso2YWDBo16S0QySPhmySj9LguH0BJz0qXR2TIyAmDY
	AYOZabSo/m1c/ceIxdjjgft0apcmHs7ta9PnPL9mAkJQX4Z1N/FCfsGWnbodG6pVnWMJCl
	9E+ZIc9lbRw+G/T31W/yWuPd+OQfm6REaH4MpNeerWNk9vIrLxClrTJdBUL1/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715640363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr0dlAhwjPUp2s9a7M72hVlk72/s1iwl2G42Yl1sj6o=;
	b=KM3ZlG9F4HWvmDFUnKJC/jzDP7Ii9xl7fJjZnT3VJbeubXyQCn6cNWQGWK1b16yCft9flr
	BkGtWsvNGkZNmNDQ==
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc: mingo@redhat.com, Borislavbp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
In-Reply-To: <2b8e02cd-2f2e-4bf1-9332-6dde502c22b1@oracle.com>
References: <20240510190623.117031-1-dongli.zhang@oracle.com>
 <87msotnaow.ffs@tglx> <2b8e02cd-2f2e-4bf1-9332-6dde502c22b1@oracle.com>
Date: Tue, 14 May 2024 00:46:03 +0200
Message-ID: <87eda5mitw.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 13 2024 at 10:43, Dongli Zhang wrote:
> On 5/13/24 5:44 AM, Thomas Gleixner wrote:
>> On Fri, May 10 2024 at 12:06, Dongli Zhang wrote:
>> Any interrupt which is affine to an outgoing CPU is migrated and
>> eventually pending moves are enforced:
>> 
>> cpu_down()
>>   ...
>>   cpu_disable_common()
>>     fixup_irqs()
>>       irq_migrate_all_off_this_cpu()
>>         migrate_one_irq()
>>           irq_force_complete_move()
>>             free_moved_vector();
>> 
>> No?
>
> I noticed this and finally abandoned the solution to fix at migrate_one_irq(),
> because:
>
> 1. The objective of migrate_one_irq()-->irq_force_complete_move() looks to
> cleanup before irq_do_set_affinity().
>
> 2. The irq_needs_fixup() may return false so that irq_force_complete_move() does
> not get the chance to trigger.
>
> 3. Even irq_force_complete_move() is triggered, it exits early if
> apicd->prev_vector==0.

But that's not the case, really.

> The apicd->prev_vector can be cleared by __vector_schedule_cleanup() because
> cpu_disable_common() releases the vector_lock after CPU is flagged offline.

Nothing can schedule vector cleanup at that point because _all_ other
CPUs spin in stop_machine() with interrupts disabled and therefore
cannot handle interrupts which might invoke it.

So it does not matter whether the vector lock is dropped or not in
cpu_disable_common().

> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -1035,8 +1035,6 @@ static void __vector_schedule_cleanup(struct
> apic_chip_data *apicd)
>                         cl->timer.expires = jiffies + 1;
>                         add_timer_on(&cl->timer, cpu);
>                 }
> -       } else {
> -               apicd->prev_vector = 0; // or print a warning

This really wants to be a warning.

>> In fact irq_complete_move() should never see apicd->move_in_progress
>> with apicd->prev_cpu pointing to an offline CPU.
>
> I think it is possible. The fact that a CPU is offline doesn't indicate
> fixup_irqs() has already been triggered. The vector_lock is released after CPU
> is flagged offline.

No.

stop_machine()
        _ALL_ CPUs rendevouz and spin with interrupts disabled

        Outgoing CPU invokes cpu_disable_common()

So it does not matter at all whether vector lock is dropped before
fixup_irqs() is invoked. The new target CPU _cannot_ handle the
interrupt at that point and invoke irq_complete_move().

>> If you can trigger that case, then there is something fundamentally
>> wrong with the CPU hotplug interrupt migration code and that needs to be
>> investigated and fixed.
>> 
>
> I can easily reproduce the issue.

Good.

> I will fix in the interrupt migration code.

You need a proper explanation for the problem first otherwise you can't
fix it.

I understand the failure mode by now. What happens is:

1) Interrupt is affine to CPU11

2) Affinity is set to CPU10

3) Interrupt is raised and handled on CPU11

   irq_move_masked_irq()
     irq_do_set_affinity()
       apicd->prev_cpu = 11;
       apicd->move_in_progress = true;

4) CPU11 goes offline

   irq_needs_fixup() returns false because effective affinity points
   already to CPU 10, so irq_force_complete_move() is not invoked.

5) Interrupt is raised and handled on CPU10

   irq_complete_move()
        __vector_schedule_cleanup()
           if (cpu_online(apicd->prev_cpu))    <- observes offline

See? So this has nothing to do with vector lock being dropped.

> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 1ed2b1739363..5ecd072a34fe 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
>                 return false;
>         }
>
> +       /*
> +        * Complete an eventually pending irq move cleanup. If this
> +        * interrupt was moved in hard irq context, then the vectors need
> +        * to be cleaned up. It can't wait until this interrupt actually
> +        * happens and this CPU was involved.
> +        */
> +       irq_force_complete_move(desc);

You cannot do that here because it is only valid when the interrupt is
affine to the outgoing CPU.

In the problem case the interrupt was affine to the outgoing CPU, but
the core code does not know that it has not been cleaned up yet. It does
not even know that the interrupt was affine to the outgoing CPU before.

So in principle we could just go and do:

 	} else {
-		apicd->prev_vector = 0;
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);

but that would not give enough information and would depend on the
interrupt to actually arrive.

irq_force_complete_move() already describes this case, but obviously it
does not work because the core code does not invoke it in that
situation.

So yes, moving the invocation of irq_force_complete_move() before the
irq_needs_fixup() call makes sense, but it wants this to actually work
correctly:

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1036,7 +1036,8 @@ static void __vector_schedule_cleanup(st
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -1097,10 +1098,11 @@ void irq_force_complete_move(struct irq_
 		goto unlock;
 
 	/*
-	 * If prev_vector is empty, no action required.
+	 * If prev_vector is empty or the descriptor was previously
+	 * not on the outgoing CPU no action required.
 	 */
 	vector = apicd->prev_vector;
-	if (!vector)
+	if (!vector || apicd->prev_cpu != smp_processor_id())
 		goto unlock;
 
 	/*

Putting a WARN() into __vector_schedule_cleanup instead of the pr_warn()
is pretty pointless because it's entirely clear where it is invoked
from.

The whole thing wants a

Fixes: f0383c24b485 ("genirq/cpuhotplug: Add support for cleaning up move in progress")

tag.

Thanks,

        tglx
