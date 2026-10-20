Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792499340;
	b=4U/iLTThlDFptt7ExSku3mDS7zkZ+0/sn/D/HZfUd9pxemRDVWF1EQesj6dDASUs8Nbe
	 4qHa9JYRxMfUCEum3KzaNmDP8rbCxpPa28t2uUdTb23cIF96uCdq6q1i5LK+WhhgANLac
	 OJa3O6f70r2sWJ9aJNhJwDY5oXgmzN/DntxqoxynCUe75OINCrj5LmXQUVoxZMTSU8Ybs
	 j2as/8qNTecH6dZf16r0ig2l4t405Om1nuLW2Ag9WGvR1/sK3Q7MHbqfOIGs3T+0uFajo
	 a2uQNhVF1JT5QI74gTFitpIwRhmDxzEsaCeQfptQYPHOjJkQf3AaDXjlDQr0F9wSLqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=;
	b=SbGZFCJYdksUqapdtj7rMctuc0pnDvm3iI8HMhYUgGplyM+9q0TWreyK6sW2aEPN9VIJ
	 Rri+2vUAGJaeDzEgyoQt+4mq7RwH8eIp6Uzgg/hXV4lIiqEZT8PHWYaQf60Mg29DWZ7tE
	 c2jwC6z6sRFSIUQvK7F5yVy8R43239vageKTqNZC4GZQVSMl0RM25heSrDwNNpuiM2hn8
	 ilbsib3fJ+a3AfXc5rM5tagR42g0o/0/qdn5CmoNkNPQhXGuKBCCCN8KCYZjO1o124L9Q
	 HdedPpygD9agweTzEy0b32uow37zfu7jg00DITxdzG3Entfw0aLj+VNC0HMwb7AG6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WHQn4ari;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D70606A320
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83D70606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WHQn4ari
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso501613f8f.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792499338; x=1793104138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=;
        b=WHQn4ari59bAFIEk+esWLdifXZw8tT78Pg7ft/Y1S3RgsyQsDvnFZBAWXQ9N3vfvSS
         64N9O9pCslGSz6NyOKTHL4mbq2Rosc6aa05940xH4l3CjAN8DXoujPniLRtV2N6Iz7yB
         TeTIcJ7iPq8XA901niXtcwDdNeKe8BOrrxNhtAX4aPpWStruof99/fmw83Cl6OwJbwHB
         S+d+zSXcFCsOuVMQAd8Hvb6OQ8ATJVFw6QgaynL+A55QPacOd6Vr2HVdeH/OrD5sEJkU
         KZPqhS9DRJUW+hdKg7IfTT2y5kbDO5nEeg6+xXnZQ+d8DyYOYpYctHEWboxaZ/7JTgea
         F7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499338; x=1793104138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfZbqFmLr8Q6MECdNX562ifwqH83lxZBW8nCUfGoGTs=;
        b=Zfc9CmQCqb28xlTT0ZvLBou0y0sJ4GfL9J7ea35e3rBNzb0IuJ2TWdI5kMZRoPMJYe
         ae8VWj4wT3J0ouHY2tKHlBfa8B/+ftqCAzqxxshcn8X/Nuo3TCh1HeIOua7VUwTTXRwf
         +qX8uTtbj/Rn+kPuVRrphMPOyAWvftPEinIdTPNYWSBHZ7/qJFFM2cFAsFJB5Qc29bTA
         jD9pHs85S4Y2Lk57o+f5inOC6PX6yswF5LIfo6TlcrS/zraP6e3aXm3BzK4NUTMaTEZ3
         oO0ZgLgyaHLXh1MJUvINqBV2iQZnARV1pszBD0rmI5H6ruCT87PlnD5+POpHt2OiVtMV
         NtMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJD6MaVWEyT0W2oeZpxq/QbfXH12m+m3Rq6gNu17Ims5bnmapo0hyRiaPWq6uSYEAEC6XdXPMkq06aoAQt1A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKtOfodgfjBob46ZhJD2QbHFJvWgjQtztRbiwg2uDwA9iUnz2et
	qWfqdvEA+VPf8S+Sc9k3+oJvmEJE07E+JgPmR+xsmN6yaQugdURiR1Ozndi/FRrZqUw=
X-Gm-Gg: AYBFou1NmyzDCC2skd8Wdj44/drNOdKDvvoycwJx/YQVEq2Rq+f0RM87MAIpiqNRMG2
	UJXRAdxpo8E3cXrpvG3sZrHFwAYX9X+lyH0F6ifFyujaTCqYmMfxAKObb6UQlsnFnN7/5ZyGN/0
	vhW0nz7aJ1PnRKSEE104U5vXELJ99BQ9kg3VUhKStnKLSpbXw2Fb4NeSUxjPHdCjJwVPNJddWCj
	Gn/SGeHwDmNQXOmavoyKi1+FSw3WiAmmlAIt9zq7BagjvxtyVIpwm4ruB/dkkAmz9KcyzdQR17i
	8FDdafjtoH2smh6oP77WmwhvkzoysiZ/PjunycqBBgN/tu1uRZT658JliUt5p2tAMNNRUD47AJC
	JgIGHmIKICygqc2yQwUE4vaX2aLmfDEonGgzVUw7iSOcy4TJc38EyTaIM1ZOcuXg3Iu5op70CB4
	fiMYxtK5DZmHZhDpyYXv1yWwWJwyPcyfbquw/5u5NtGg/5UMOc03ltQv8Z/H6s0BD60fX+YvAEZ
	ZiKLlahq2o=
X-Received: by 2002:a05:6000:4694:b0:48c:414f:cc12 with SMTP id ffacd0b85a97d-48e07f9c387mr16153415f8f.40.1792499337854;
        Tue, 20 Oct 2026 05:28:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d6dbd33sm5588977f8f.8.2026.10.20.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:28:56 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:28:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>, Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH v2 3/6] panic: Allow postponing pre-kdump notifiers
Message-ID: <atdee9q7DExYLGPE@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52183acf25209275a9a57fe5d746f82d3b7efc3c.1790014793.git.zack.rusin@broadcom.com>

On Mon 2026-09-28 13:55:37, Zack Rusin wrote:
> Provide an escape hatch for debugging kdump failures that may involve
> pre-kdump callbacks. Add panic_pre_kdump_postpone to skip their early
> invocation in crash core without consuming the once-only guard.
> 
> When enabled, the chain runs before kdump only when
> crash_kexec_post_notifiers is also enabled. Leave the late panic call
> unchanged so callbacks remain eligible if that path is reached.
> Skipping the callbacks may prevent hypervisor crash handling.
> 
> Suggested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Link: https://lore.kernel.org/r/bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
> New in v2: optional postponement policy suggested by Guilherme.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>  include/linux/panic_notifier.h                  |  1 +
>  kernel/crash_core.c                             |  3 ++-
>  kernel/panic.c                                  |  2 ++
>  4 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 33cd30996e47..3d722df30838 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4904,6 +4904,20 @@ Kernel parameters
>  			This option should only be used for systems with the above
>  			constraints as it might cause the panic operation to be less reliable.
>  
> +	panic_pre_kdump_postpone=
> +			[KNL] Defer pre-kdump notifiers to the late panic path.
> +			They run before kdump only when
> +			crash_kexec_post_notifiers is also enabled. If panic
> +			reaches the late path without entering kdump, they
> +			can still run there.
> +			Intended for debugging kexec/crash-dump failures.
> +			Skipping these callbacks may prevent correct crash
> +			handling by the hypervisor.
> +			Format: <bool>
> +			Default: 0
> +			Writable at runtime via
> +			/sys/module/kernel/parameters/panic_pre_kdump_postpone.
> +
>  	panic_print=	Bitmask for printing system info when panic happens.
>  			User can chose combination of the following bits:
>  
> diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> index 3ad390764a41..655ee5c77181 100644
> --- a/include/linux/panic_notifier.h
> +++ b/include/linux/panic_notifier.h
> @@ -11,5 +11,6 @@ extern struct atomic_notifier_head panic_pre_kdump_list;
>  void panic_notify_pre_kdump(char *msg);
>  
>  extern bool crash_kexec_post_notifiers;
> +extern bool panic_pre_kdump_postpone;
>  
>  #endif	/* _LINUX_PANIC_NOTIFIERS_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 5d9fe9e00f39..d6b2293dd0fe 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -140,7 +140,8 @@ void __noclone __crash_kexec(struct pt_regs *regs)
>  			struct pt_regs fixed_regs;
>  
>  			crash_setup_regs(&fixed_regs, regs);
> -			panic_notify_pre_kdump(NULL);
> +			if (!READ_ONCE(panic_pre_kdump_postpone))
> +				panic_notify_pre_kdump(NULL);

Honestly, it looks a bit confusing to me.

The name "postpone" suggests that they will be called later.
But they likely will never be called because the crash kernel
will take over the control and eventually reboot the system.
The panic() path will never run.

Also there is:

void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
{
	if (regs && kexec_should_crash(current))
		crash_kexec(regs);

where

int kexec_should_crash(struct task_struct *p)
{
	/*
	 * If crash_kexec_post_notifiers is enabled, don't run
	 * crash_kexec() here yet, which must be run after panic
	 * notifiers in panic().
	 */
	if (crash_kexec_post_notifiers)
		return 0;

So, when: "crash_kexec_post_notifiers == true" then
kexec_should_crash() returns "0" then
crash_exec() is not called. The system might still
call panic() but remember "crash_kexec_post_notifiers == true"
so the notifiers are called before __crash_kexec().
So panic_notify_pre_kdump() will still get called
before __crash_exec().

Is this intended, please?
What is use case, please?

Maybe, it would make sense to add "panic_pre_kdump_disable"
which would completely disable the notifiers when they cause
problems.

Best Regards,
Petr
