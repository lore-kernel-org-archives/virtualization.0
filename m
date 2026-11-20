Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170453;
	b=VaPO5kzOf/FibtcpC4hvmvIhETRWsx+40fOSFnwzTwRxZeedov87kNGMWEuO8OVrRtUL
	 SfswvdqF++Y1gpx32vS51fNYB67qV9fLmYEXJjez9W7UqWv0IpuixIP/LxrwEPg+D8Web
	 tUiIfMdGAaCyE9MrEBlf2H4NnubOWtvsY/mkwyP9SicEFYwuGSZvBRXUAEkAXx8rpxU3E
	 V/pniBzqSdekMkMVZPYvTYqAeVMAg4lr6Eabz4EuTy5Q9RUg6KxDzf4ipXzkwxXzYtz4V
	 11L+dDzVPAF6bgvI4YuBxrljSLLpZVsn5lQW4d09ARL9hEl9uWVrzkxrnZDx6ME2YSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=;
	b=rorV/7/iKsitQY9bUQ+ka+P6P3fz7Cmd9S6vCBIv9ooco9MCnWsNr/Gj9aukmTS/rP11
	 DuaKkTItSCovinnz6K/dQQCoTkbbyvO0KxWJ5Xi00YPGpNZdy/SOgGGp8fWd2kFfeiPL1
	 otvbohqlYsVUlObf3qZZZPyk8TF6AIDQUty2+6ss2bqvzAbZedZMW9k0O15AS4QWoVNSE
	 TpVzT9HbLCauMkL72sBEoxIAB8ZvawCmhIyN1xiPkkf3hwh4v/ZG14DyQWra+vd0slVe/
	 BmWIEigU5niLYeZ1jewHl8kTemg/Eztfrx+XHvJecrEkOMse0Xm9/b4A6rKd/nvKJZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OP6iqZm4;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C16606A325
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 10:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00C16606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=OP6iqZm4
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so5103785e9.2
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 02:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795170451; x=1795775251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=;
        b=OP6iqZm4puva8Zc1/9u/MtPvdUgjMG3J0WDej3Dh/s1bwvnLes1CRH+qNGlTKl79Da
         lHROIPw9y/UvurTdFVYgeoK1xZQkcHxldmSxRQQoHylhpAneB2o+vnR6f/98aTAbr0IK
         JMpMcBkSUfOP8FRmsk/xlvLrcvKo4s+61EZEcpTg0ixM96Lpt2azqxB/mrjYbvbr9iTn
         uBxVnSqE1ihUZzPrfiVpzGC0Srd2IvCFMFOoEqdhib6TuOgcZccXu2oZjIQBsDf/G/Z/
         qSq7lJvKdXF8h7l4PRc/8a8Wa5PT3rKdtjr7ZPTZA5BawqxFtgF8nQvw5iYsS9vUF9M3
         kfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170451; x=1795775251;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J03hAPreVl/WdlY67XpnWOO6QMbJJDuPrc/TmqPAXow=;
        b=UUDcMrlKZq5wHlxofMvm5hTsaZkCkAfKt2BvZOv3BTu8NCb2WhA2I2X92HVeGiahqr
         XESGF1/9y13I0C/FyJ7K0IHZbXybcsigCwDbblTzzFh1oCstv+fOc/DsqpyYV0ySJxQQ
         CZEzaSaCUagXaB1CoXAATAZi9HPlVAKJPNK36Gbyjy4smm1SjWaA0oZUpyjApAgEhIhm
         hkr5Go4yMN1X7xfd5WJteyM5pkUucQgDkUHkw5DYv/7nQHDrFeTn1q3G0X63PtgwHw9h
         itBmB1HKLBqFe3fIxlwjQqRxXyo0yQQEosT4zzha9BPkk8ZFJsO+ntkF7W2yd9XRsjsf
         kw/w==
X-Forwarded-Encrypted: i=1; AL+hErEcSZjWaAGzpwbHpdJr6G3PfJzh/K4cdFq8leE/jiF/YMKQiuPJWnx6P+I3QwJoGeGkT7+o9Z1y5C+BQuBGTw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8IjYM2F2WCaBDgYiG1GZJypcSfcEVERm+38KyxyXuWb2Xs+seh
	c0r7Ao+m/6Yzh3MC6f27NWPRDvzf75Ra5vkUEXbor6sMCiUsToEU0axaNjJCcta1mHU=
X-Gm-Gg: AYBFou3I8n1egxy1VXOVmMXDVLHfAaMDu2thb5YSgu5KiBJQf+wK2UjEgXITG/IpKi5
	4/MF0GiJ7kDLBByqvmZ+Ut8C2QJmW+FE4Sfo6WW+BWb+3maDtgpxuuRKMhsLLS7Nv3rwMfVCVHJ
	FzEWQWDkH/t8DG+4EjW+CyvbPZoLtqVteMYeLLHlGDJZTfKeaVSW+/dzyw4GkxFb2p3krbSW1rG
	iVJmkgpajWzmCVJfxtvLNFe9t44JxuBmGmgN83eDMb5tJ/aU5vaNF4YizQNkFjaHAh7Jzy3JXkc
	iDqHmtxR8b/0SCjO8MvRMuUbzja2+2eKJ8ct70aTdpkZssatgGhYR/8xcrzgySAvPCVnkkqD4WI
	tthAMZz+Pv+CQvmNE34Cynz/7T8NH+KW1WKMCM8OXNginhLCRK6VPS7j2fzcvaTVPaK6RVxPD9E
	Zdrp8Kal2n+B4b6wsH2zp+M2TJHvHhN4MV+3kRqKFKzhrzgARBS9GGwxNAo9WNS4/9Aro7hozd9
	4hlr+YPFjHRvPy44qyN0XghH+wwpCeKHpLCj8B+dIzcMIfnDj0Y3ipFuqoMNYONIS1Q796woY8y
	RbG93lcYStchBmgfLhCl
X-Received: by 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb8881e81cmr57015215e9.29.1795170451305;
        Fri, 20 Nov 2026 02:27:31 -0800 (PST)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm108779875e9.15.2026.11.20.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:27:30 -0800 (PST)
Date: Fri, 20 Nov 2026 11:27:28 +0100
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
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg
 dumpers
Message-ID: <awAgkNoIKpFx764w@pathway>
References: <cover.1794980455.git.zack.rusin@broadcom.com>
 <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
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
In-Reply-To: <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>

Hi,

this patch looks a bit messy, But maybe, I just do not know enough
about VMvare.

On Wed 2026-11-18 01:01:51, Zack Rusin wrote:
> VMware accepts a structured guest-crash event, but a host configured with
> backdoor.coredumpOnCrash may terminate the VM before the hypercall
> returns. Keep this event separate from the log sender, which runs
> earlier in panic.

I am a bit lost here ;-)

What exactly means the "structured guest-crash event"?
Which hypercall are we talking about?

Is this primary about synchronization of vmware_panic_log_notify()
against termination of the crashing guest by the host?
Or is this about something else?

What exactly does vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)?
Does it _block_ or _trigger_ backdoor.coredumpOnCrash?

> Register a panic-only kmsg dumper with late_initcall_sync(), after built-in
> dumpers registered by then.

Is this ordering important?

> Skip the event while a crash kernel is loaded
> so the host cannot terminate the guest before kdump saves its vmcore.

This suggests that vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)
actually triggers the external crash dump procedure made by the host.

> Issue the event at most once. With CONFIG_PRINTK=n, use a late INT_MIN
> panic notifier. An unexpected dumper registration failure with printk
> enabled leaves reporting disabled rather than overtaking working dumpers.

This is another mystery. What do you want to achieve when
CONFIG_PRINTK is not defined, please?

Note that printk() is a NOP when CONFIG_PRINTK is not defined.
There is nothing to dump in this case.

Honestly, I would not complicate the code by this.
I doubt that anyone is using kernel without CONFIG_PRINTK.

> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> +static int __init vmware_crash_report_init(void)
> +{
> +	int ret;
> +
> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
> +		return 0;
> +
> +	ret = kmsg_dump_register(&vmware_crash_report_dumper);
> +	if (!ret)
> +		return 0;
> +	if (IS_ENABLED(CONFIG_PRINTK)) {
> +		pr_err("failed to register crash report dumper: %d\n", ret);
> +		return 0;

This is weird. As I said, printk() is a NOP when CONFIG_PRINTK
is not defined. So, you would achieve the same with:

	ret = kmsg_dump_register(&vmware_crash_report_dumper);
	if (ret)
		pr_err("failed to register crash report dumper: %d\n", ret);
	return 0;

But wait, this means that the code below is never reached.

Ah, I see, you wanted to run the code below when CONFIG_PRINTK
was disabled. It was far from obvious. And I do not understand
the motivation much.

Anyway, it won't work because kmsg_dump_register() returns -EINVAL
when CONFIG_PRINTK is not defined. err != 0 ...

Let's take a step back.

Why do you want to use kmsg_dump infrastructure for notifying
host about the crash, please?

The kmsg_dump API should be used to dump the printk messages.
But this just notifies the host about the crash. It looks like
an API misuse.

> +	}
> +
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &vmware_crash_report_nb);
> +	if (ret)
> +		pr_err("failed to register crash report notifier: %d\n", ret);
> +
> +	return 0;

IMHO, you either want to use the panic_notifier list.

Or you might even use the new panic_notifiers_platform_list
if you make sure that this is called as the last event
and you really want to stop the guest at this point.

My assumption is that the "host" will stop the "crashing guest"
when it gets notified about the crash.

> +}
> +late_initcall_sync(vmware_crash_report_init);
> +
>  #ifdef CONFIG_PARAVIRT
>  static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
>  static bool vmw_sched_clock __initdata = true;

Best Regards,
Petr

PS: It looks to me like Sashiko AI completely failed here. It did not
    mind if the commit message made sense. It did not see the big
    picture. And it even missed that the code did not work with
    CONFIG_PRINTK undefined.
