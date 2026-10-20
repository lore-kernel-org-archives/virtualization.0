Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502410;
	b=RxfI0iLiNQR0n41TEmadb6BnRGFyZnI1WVgoiZLy7sAPY7qiWR9iLsWve9gLlrvUc7D3
	 aWOBb8nIy0iruhYiTW+0o9Su2Q+tBfMfe3Kv6UHUduNQk8KQGE71PvFd4nqs5LcpUgvr/
	 jcUDaPFyEIzeuHxjVSnoPnn7BINRwJNXgMmG/OjOe1WhjIG+qzxRRsc4y1CFKojwT2UF0
	 nhS2SZSuA6yxQoX1QOrkUZnDm77ZxvShWxocq5rInf5X+Nr/QOzNxMSTF/p62otsIFZT0
	 iVdPStmloikDgbEPafbmJTWBo5iyIm5akbwvpgPBiFiNcaeCkp9YBYwLHsjU5zvc4yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=;
	b=egjhOz3t2S6GmEBpUK6Fo0pVa/c9v8gp8vqsv4vmHU1GBs+ECmLXXAOcgsKZQ8JtLSi4
	 42E8GnIseOANWPXXThy2kL2ErFpU9ofbz0nQbefqfCp1KcjmGqbNvXqeJ4vROqs12hnAn
	 oZRgcvMXsp9dKeORTllEqyFUiUw/sA1wkMXjkhPEeyUPpyJKQkIgUvhA6nkIXysLeQ+Al
	 V7jVckXKFWR1d7lJlMxsxJ05yY0+4ASU+fr5px/ncr2MR3Xy6Sy5J+gcAy4xfCZ5wP4Ob
	 UJjsXeEorHx9G90I+jbQ1ukACzFsT9UHsyNWvWxRAJUZEQUGvB5g1wsSqOb+NY61gbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Oeu7t1ks;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF960A2600
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AF960A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Oeu7t1ks
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso2184284f8f.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792502408; x=1793107208; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=;
        b=Oeu7t1ksO4+WnRR9OgYqd2cStVrgILkpb0ea6KmofVRyAJo4UBBk8zFkRdSpbp1hLG
         MGH4srfmCi6yjLwdVoTeT77yu31JFTPAKJiJYy3vVxv7zjCZi4zGZIlkNLd9YIWqxSeT
         Flym9AtBMuPRz4V84ZK7C0mxS+mU+PqARwIpGjcMNXLG4VrMlp29KXe5ARCIyVEOGiud
         B0GQ9MmkGRtP88KLFeOMmZbXuDx5pwmpQgwKQ5vZhuc8YiP40YY6H7JRhpiX2S0vlPVH
         0s72MFtXFLHxWb1QU2XeBSFv7iTStZyB6d2WyORdhTINu2f2uqNjSgREhEdM3c2f1YjP
         Zyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502408; x=1793107208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4p1f+D4ihXNqpiH1QSa2hiu1MulUajBwYpao7q44aQ=;
        b=aMdU/CTTPnXwWGu2B+OQ3Aw/wStR9EjF7qcpFatVr6oT7gxI/TrA8SquwL1hRN9cEe
         Lqnj2uqBh/ktMUWbos6xjPm6czZYNCPQWzQBk6GcVomvKr2ew1S6iaRvM+zb03jTKy60
         P3q9cgJAOl/syV+4PTsmPuBrD26gXnVBi6SS4bSvzIuoLNj7k20t2AxFsJMFNFypQpRR
         AosaNdPObF+LG+ZexCrzaoiNfjfvQNKIZMh9uxFBDAlfswHSxZ2KZLHR55fH0sR9OlSY
         Tw4ajDAIZ2INZ3/hnZkLkFAsDeRC00ERlNh/RdFazaTNTYJqfZQGfeocxG1+7faS5+GB
         UTGg==
X-Forwarded-Encrypted: i=1; AKwUvBy2NhjEbmWMIYJkyIFPU2DHu6EWYLuOx5wNx9O1caLikP/+wofK1PlGFqr5YAsOtrdlKD9oRKJerubchcyyFQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLIK3d4NSfM+5os8RidgteJUWWB25ELy/7dMcDS8p8t2WHcOdYU
	oQEFqrXyDGnT2wgRcPtrouAP4kjbyMFzyaoQGkRtpcwmhwGEwG6RQMKspiCPRSI8HJI=
X-Gm-Gg: AYBFou1lo+kdKCPr9SW2cMokCFHpqBHJ8aajJl110sVm+60HgPpN+3GDl/D4ERBeEf4
	V2ZsMj+6Txe4mZHGp6czk6xEaSZOPeE8TVO9wem4i+sQAyX+0n4kCL/3QlGBgx3gtTcV/gwj2ao
	24Is/2KqLKIPEQoPbXItWOo+SJLlYEmUI1tEcVhaVPsuSSHYEsx335LmEx8Y1seenl9VJIdVSbM
	RPCZgo4JMtM+drQ/ctXUxBgnYkeXXoIXQPloa2j+KbMoQLj0R0izW0bm6ERWyv02u1TQmccrsNm
	xqySM5cBRfsppisIxEC3NnNAnotsWtewvTITiZ+EsPSfWRxYjkGDfxefjXuEV119ZcU+dvt2NXs
	Ccc15Eur9UCxeHgeDXPsoCzSZfk9y33ZDHwcIyi+wG/T5Tcgmq25R0a3vEEqjv6NTzrNhqWt4UO
	6PkNn+h9quEtVkuNOoG2yyTfS/8z0xpQxnoWwmxqXLa8xCXqhAkCdbP+gYuIxl6anGu+cMUDlmy
	j4w7X0GJMPY
X-Received: by 2002:adf:fcca:0:b0:48d:fbf4:8961 with SMTP id ffacd0b85a97d-48e07bc6c5fmr16247962f8f.23.1792502405199;
        Tue, 20 Oct 2026 06:20:05 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8208b1sm6409645f8f.33.2026.10.20.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:20:04 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:20:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	Dave Young <ruirui.yang@linux.dev>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Pratyush Yadav <pratyush@kernel.org>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>
Subject: Re: [PATCH v2 1/6] panic: Add a notifier chain for pre-kdump
 callbacks
Message-ID: <atdqgZQrGbp36_O_@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
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
In-Reply-To: <atdYIxwz8ksYNty6@pathway.suse.cz>

On Tue 2026-10-20 14:01:43, Petr Mladek wrote:
> On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> > On 28/09/2026 14:55, Zack Rusin wrote:
> > > Selected crash callbacks should not require running every panic notifier
> > > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > > helper, and invoke it before panic reaches the kmsg dumpers.
> > > 
> > > The helper permits another call from the crash path without repeating
> > > callbacks or recursing into them. Document that callbacks may run in NMI
> > > context, with other CPUs running and the kexec lock held.
> > > 
> > > Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > > ---
> > > New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> > > 
> > >  include/linux/panic_notifier.h |  3 +++
> > >  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
> > >  2 files changed, 29 insertions(+)
> > > 
> > > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > > index 41e32483d7a7..3ad390764a41 100644
> > > --- a/include/linux/panic_notifier.h
> > > +++ b/include/linux/panic_notifier.h
> > > @@ -6,6 +6,9 @@
> > >  #include <linux/types.h>
> > >  
> > >  extern struct atomic_notifier_head panic_notifier_list;
> > > +extern struct atomic_notifier_head panic_pre_kdump_list;
> > > +
> > > +void panic_notify_pre_kdump(char *msg);
> > >  
> > >  extern bool crash_kexec_post_notifiers;
> > >  
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 213725b612aa..d78e90abb192 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> > >  
> > >  EXPORT_SYMBOL(panic_notifier_list);
> > >  
> > > +struct atomic_notifier_head panic_pre_kdump_list =
> > > +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> > > +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> > > +
> > >  static void panic_print_deprecated(void)
> > >  {
> > >  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> > > @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
> > >  		crash_smp_send_stop();
> > >  }
> > >  
> > > +/**
> > > + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> > > + * @msg: Panic message, or NULL for direct crash-kexec entry
> > > + *
> > > + * Dispatch at most once per boot, including recursive entry. Callbacks run
> > > + * with interrupts disabled, possibly in NMI context, before other CPUs have
> > > + * necessarily stopped. The kexec lock may be held. They must not sleep,
> > > + * allocate, wait for other CPUs, or call into kexec management operations.
> > > + * The message is read-only and may only be used during the callback.
> > > + */
> > > +void panic_notify_pre_kdump(char *msg)
> > > +{
> > > +	static atomic_t started = ATOMIC_INIT(0);
> > > +	unsigned long flags;
> > > +
> > > +	local_irq_save(flags);
> > > +	if (!atomic_xchg(&started, 1))
> 
> It is far from clear why this is needed. It would deserve a comment in
> the code and explanation in the commit message.
> 
> Well, I am not even sure whether this synchronization is enough.
> If __crash_exec() and vpanic() are running in parallel on two CPUS
> then one path will skip the notifiers but it will not wait until
> they are finished.
> 
> But I think that the problem is the explicitly called __crash_exec()
> is not synchronized against vpanic() in the first place. IMHO,
> it is an existing problem which probably should get fixed.

It seems that __crash_exec() should be called only when panic_cpu
is set. This is why crash_exec() does:

__bpf_kfunc void crash_kexec(struct pt_regs *regs)
{
	if (panic_try_start()) {
		/* This is the 1st CPU which comes here, so go ahead. */
		__crash_kexec(regs);

The only exception seems to be (found by gemini) in Hyper-V code:

static void __noreturn hv_crash_handle(void)
{
	hv_crash_restore_tss();
	hv_crash_clear_kernpt();

	/* we are now fully in devirtualized normal kernel mode */
	__crash_kexec(NULL);

	hv_panic_timeout_reboot();
}

I belive that it is a bug and it should do:

	/* Only one CPU is allowed to process with kdump and panic. */
	if (!panic_try_start())
		return;

But it is possible that it is serialized another way. Anyway, even
Hyper-V must make sure that __crash_kexec() is called only on
one CPU.

Result: We should not need any extra synchronization for
	the panic_notify_pre_kdump().

	We might just need to prevent calling them twice if we
	decide to call this function in __crash_exec() as well.
	A simple bool variable should be enough. But I am still
	not sure if it is a good design.

Continue thinking...

Best Regards,
Petr
