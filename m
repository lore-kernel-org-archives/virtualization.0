Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD67A3F
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604259; cv=none; b=dHHggqGRGta6aZ9CdywdtlsGOcCOfBofGtMD3jT9uWIKw+AjnBEJiFuPFKwUwnDazzJS3q0onr7iapivLghxycoks7vFSIBKMxz7+IgM77duu/6U8eLc3YfH4/MDRgDyXj8fmqsN05EfpmD0LHKYpwQ7iqKm0wiVvL0GFy7Q5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604259; c=relaxed/simple;
	bh=8KSUVzTvqxp7OIdS+GOnbv91geAiKRiZv1Q7eZCzMQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBrB4nW1bDM+P3an98D+dytbsuHODCHG8mDagCjj9WNeobMarA6X9+g9WfxEH45nEewGARy+fhZkxa5NwatGjr55At2YxE4CYRVdiVywRFAhVriBDn5oGbrHKtFwzMFFCkdOT6BZuArgZnwtt2qIwmQHPCUCw2Vs8me/x/tvLQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kL6heHlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8PQOmpRe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kL6heHlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PQOmpRe"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715604255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAB6AC0uf4kU0wwIw6N445hCMYVKJ7r1lOXf9S9Bb5c=;
	b=kL6heHlSPMN/pHLoNZnqKMl30/S5c6EGVaohafb3ZLJrndk7gd3/VWYn5uZ8OL45HoZiMP
	YTPtp8yQG9+LQCEa8uFjPBXUZMKGKpHAqB07i3LanfCAtgLtIh9NaIPyM7PnAEUVSmIlNt
	oExT8knvUv0siYIwnr1SAMd3RUqGdF95IVYFRstmi3VJVbS4O0RlixfaJYX7CJrdA+3s7V
	9UiGJczxrBP7Ojxm0XvQ/75cbhTzK923acjp83pMIpH+UXjqLkAWg4VtdehvDcbbH618ak
	4il4PoaqgI5nr0Ei8SZ7g2EWNaWbaQUbyxNnqsinpo/jWMNxMqaI+3mqZLUBmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715604255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oAB6AC0uf4kU0wwIw6N445hCMYVKJ7r1lOXf9S9Bb5c=;
	b=8PQOmpReg3DfXxCsRL+7m3s8iwztutKUd+RWc0d4ypaxfy6pMG9iUjllvTSzqaQCTGBu1X
	ESvttDPH+iekbdDw==
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org
Cc: mingo@redhat.com, Borislavbp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, joe.jin@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH 1/1] x86/vector: Fix vector leak during CPU offline
In-Reply-To: <20240510190623.117031-1-dongli.zhang@oracle.com>
References: <20240510190623.117031-1-dongli.zhang@oracle.com>
Date: Mon, 13 May 2024 14:44:15 +0200
Message-ID: <87msotnaow.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 10 2024 at 12:06, Dongli Zhang wrote:
> The absence of IRQD_MOVE_PCNTXT prevents immediate effectiveness of
> interrupt affinity reconfiguration via procfs. Instead, the change is
> deferred until the next instance of the interrupt being triggered on the
> original CPU.
>
> When the interrupt next triggers on the original CPU, the new affinity is
> enforced within __irq_move_irq(). A vector is allocated from the new CPU,
> but if the old vector on the original CPU remains online, it is not
> immediately reclaimed. Instead, apicd->move_in_progress is flagged, and the
> reclaiming process is delayed until the next trigger of the interrupt on
> the new CPU.
>
> Upon the subsequent triggering of the interrupt on the new CPU,
> irq_complete_move() adds a task to the old CPU's vector_cleanup list if it
> remains online. Subsequently, the timer on the old CPU iterates over its
> vector_cleanup list, reclaiming vectors.
>
> However, if the old CPU is offline before the interrupt triggers again on
> the new CPU, irq_complete_move() simply resets both apicd->move_in_progress
> and apicd->prev_vector to 0. Consequently, the vector remains unreclaimed
> in vector_matrix, resulting in a CPU vector leak.

I doubt that.

Any interrupt which is affine to an outgoing CPU is migrated and
eventually pending moves are enforced:

cpu_down()
  ...
  cpu_disable_common()
    fixup_irqs()
      irq_migrate_all_off_this_cpu()
        migrate_one_irq()
          irq_force_complete_move()
            free_moved_vector();

No?

In fact irq_complete_move() should never see apicd->move_in_progress
with apicd->prev_cpu pointing to an offline CPU.

The CPU offline case in __vector_schedule_cleanup() should not even
exist or at least just emit a warning.

If you can trigger that case, then there is something fundamentally
wrong with the CPU hotplug interrupt migration code and that needs to be
investigated and fixed.

Thanks,

        tglx

