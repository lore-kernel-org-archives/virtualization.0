Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497706;
	b=jAzw1yjLTB+BiznG8krGgYgGux6uK5+WQaQ7+t0ympflngRlPPLMAKYBXzBntmbwai1V
	 +16HMKmEN/jwBSSwmZJKyqeC3HEqq7MHMHDSwulZZIgiy2RJyKeX1sSw7BSamsb0xlDZ3
	 PYK6T0+jB8a/yfoXjfz4p4NdGFnutNlynWb9qBAN08KW4Ia8zPrXknzeO7fN/zZJv3eqH
	 El4N6GHuuMhCVYiRat3ZPxwZitwvnX71f6XMmOFzhK8xVKS3tVKH+psFuncppK2aj8+SS
	 Wocd2gvpYGNNjMD+xBIRICnBT+F7tFl/C6w3KvxwaT/t5miXNU9ZtDbJAIv+BTGp+AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=;
	b=hwOf2839Yo5mnKH1V42+MQVXSHBbxS1URjCtgekdEUHOGGea9T8WOkmIp4Ko9xMbgH1F
	 geGCRSXdckr8tdF4TO7zoaX7nLIY4UCgZbG1xyacDXw/2wBJr2d861FpJbpdNNFaGsfqR
	 ggAy/OQArUW7f5DFDEJFiMO4/NE9cIHPNfvAg5y0rjYznMSdYNIDRBDHNpCcELKAC8Z5y
	 0kX0EtMXJ6ic0pjwJuNJJNtm2hLA2bSPz2UMiqzTvepv3SFQjF/Eg15eRC93/86mhh8um
	 KWJg9S8+jeQTdfxDVxZrVlthL6gneYRSScrojP2y4KlJBCKSgbggn8C8jbwk/MJvRLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ea+nND3j;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E9606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A29E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Ea+nND3j
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so4983725a12.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 05:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792497704; x=1793102504; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=;
        b=Ea+nND3jjM7iPZZAv/zCOlqQ0jQl96yR2nNrSTpQzl0PyGHA+/jcXNmP30zrN4t9qK
         xYzjo2e/LlKd2w2nFSTVbh22uylq/9ilfnFCOfHk4Hy401VTTG5H3wXhC9V9DT/I8UEz
         lfhz7Grdg+o8paxg0tQ1TawoXM1sqsy6m3KgcrKrBSowg1j5MmBZCY8PHYBR8ip4ISS0
         sndcEWrO5VZaLGkK6y4bsbfyf5GRyqnl4YXFOo8af40kMJp57p31xHNJ5Kb1tW5xDjQp
         UMeQEfx0Oq8oE1UP3jDOXb/M5yCxGDCKN56ydaTfTpTqjlWcABMHyjw2Zz5S939R+WN+
         Twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792497704; x=1793102504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoiKgrlu3jS2oBRKxPzmeURp2GOIi7ThEavPNJNThX0=;
        b=kgFNzwJNNL8CZSSgNyBxuAtST6WqgSz15w4hzEBmK4/mVom8wCNofEWY6RydMAL2Eo
         b2ED/JxJnBH2Wa0Epnj1xT9gPnXekVHnqMxfHoZIZ+cwCsfoi1PUACQyjvUrw9NXycNG
         qLIQ0pK7GuZe2qABJQ3nJucrgSdgcoOagFE4DUkybNrqboICuDQ/g/sW4RbgPXLLqcSZ
         2zNDAGbzETEpZw9FINx1aBCvzD2x5lp7B652GYRi5nOP4sJ0B2Ocvomi+08aRiZyTsd5
         c/IaT5YreZhJI9iQqpuL2ZN50CKy+zZQfyUF/mzSVFRZ5lqOQRL0tYr60vKq38aaAMEY
         5qKA==
X-Forwarded-Encrypted: i=1; AKwUvBy07I0vVKpJa4m/vptr0CRqxFnQK4O/OZz59+sAMIt43IfW9bywEm1a4EzOA8PSc/iDA+GZg3oNsfYD7EIzFg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9R1ttuAFOjAU1mpFygSPWDUW0BemnKUZd/EHThfBW1OdieIkO
	Pc0MypDI0X8+u3m2IP7X4ffCfRUPT/5W9fQCHOpVTsFSY/cPKdgDf7EuUGZoQbO/U4A=
X-Gm-Gg: AYBFou281IgFP6CNv7pLaQBrMWq7vUw2oiS15+spuDBCuZkxAAKQYFWWBPor7Uia7ZZ
	PwSbtgiOk8mr2IhHAbwap1n7sdELvbFGMg+wJ6Lr2BSOxqNGoijHU4Z5VSTsmVLmxo/4waw2Gm5
	OWpuszQe44N1W5KbKDXSZ21BeK4m6i1y1cl2X3XGIPCyMJZpYPgFhOP2QR25+E5bZ45rJeevDiK
	Rm/eL/iiYqms/f/e5b3L1WUdUO/UguvTE1WtKFgdVFMys9Vo5IK5Tu9p3rSk5PMV3JEis2bC8UM
	uRFcy80wsNCkHno48UC/h73dUiVoot02A/Jnnho2nP2QMrzzHkOlOp4FeIY1MZRzlLGoIueIJ/p
	uIlcsrz+qzMScXJfHY8iRXkK8xemtHWSKkPt9a8jf7BqFP7wjo5pbt2MfNvgQsV2vfB+2sm16lj
	+Mw6hn51Khv868dwuxr5puhT/KTBTM7Avqpg59oVDhCYh3usjULFPppwr/47OfSAubM2sromdf
X-Received: by 2002:a17:907:9347:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c41a10c2ddemr789464366b.47.1792497703502;
        Tue, 20 Oct 2026 05:01:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80fc6csm5503140f8f.14.2026.10.20.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:01:42 -0700 (PDT)
Date: Tue, 20 Oct 2026 14:01:39 +0200
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
Message-ID: <atdYIxwz8ksYNty6@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
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
In-Reply-To: <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>

On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> On 28/09/2026 14:55, Zack Rusin wrote:
> > Selected crash callbacks should not require running every panic notifier
> > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > helper, and invoke it before panic reaches the kmsg dumpers.
> > 
> > The helper permits another call from the crash path without repeating
> > callbacks or recursing into them. Document that callbacks may run in NMI
> > context, with other CPUs running and the kexec lock held.
> > 
> > Link: https://lore.kernel.org/r/aquttpMVKX8e6zGB@pathway.suse.cz
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> > New in v2: separate pre-kdump chain, with a set-once dispatch guard.
> > 
> >  include/linux/panic_notifier.h |  3 +++
> >  kernel/panic.c                 | 26 ++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > index 41e32483d7a7..3ad390764a41 100644
> > --- a/include/linux/panic_notifier.h
> > +++ b/include/linux/panic_notifier.h
> > @@ -6,6 +6,9 @@
> >  #include <linux/types.h>
> >  
> >  extern struct atomic_notifier_head panic_notifier_list;
> > +extern struct atomic_notifier_head panic_pre_kdump_list;
> > +
> > +void panic_notify_pre_kdump(char *msg);
> >  
> >  extern bool crash_kexec_post_notifiers;
> >  
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 213725b612aa..d78e90abb192 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -82,6 +82,10 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> >  
> >  EXPORT_SYMBOL(panic_notifier_list);
> >  
> > +struct atomic_notifier_head panic_pre_kdump_list =
> > +	ATOMIC_NOTIFIER_INIT(panic_pre_kdump_list);
> > +EXPORT_SYMBOL_GPL(panic_pre_kdump_list);
> > +
> >  static void panic_print_deprecated(void)
> >  {
> >  	pr_info_once("Kernel: The 'panic_print' parameter is now deprecated. Please use 'panic_sys_info' and 'panic_console_replay' instead.\n");
> > @@ -567,6 +571,27 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
> >  		crash_smp_send_stop();
> >  }
> >  
> > +/**
> > + * panic_notify_pre_kdump - invoke selected callbacks before kdump
> > + * @msg: Panic message, or NULL for direct crash-kexec entry
> > + *
> > + * Dispatch at most once per boot, including recursive entry. Callbacks run
> > + * with interrupts disabled, possibly in NMI context, before other CPUs have
> > + * necessarily stopped. The kexec lock may be held. They must not sleep,
> > + * allocate, wait for other CPUs, or call into kexec management operations.
> > + * The message is read-only and may only be used during the callback.
> > + */
> > +void panic_notify_pre_kdump(char *msg)
> > +{
> > +	static atomic_t started = ATOMIC_INIT(0);
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> > +	if (!atomic_xchg(&started, 1))

It is far from clear why this is needed. It would deserve a comment in
the code and explanation in the commit message.

Well, I am not even sure whether this synchronization is enough.
If __crash_exec() and vpanic() are running in parallel on two CPUS
then one path will skip the notifiers but it will not wait until
they are finished.

But I think that the problem is the explicitly called __crash_exec()
is not synchronized against vpanic() in the first place. IMHO,
it is an existing problem which probably should get fixed.

> > +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> > +	local_irq_restore(flags);
> > +}
> > +
> >  /**
> >   * vpanic - halt the system
> >   * @fmt: The text string to print
> > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> >  
> >  	sys_info(panic_print);
> >  
> > +	panic_notify_pre_kdump(buf);
> >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> >  
> >  	/*
> 
> Hi Zack, thanks for trying to improve this conundrum called panic
> notifiers heh
> 
> I confess at first sight I got a bit confused, and only after reading
> patch 1 and 2 twice, things made sense to me: you're hooking
> __crash_kexec() directly!
> 
> So, in my head, 2 things that would make sense upfront: merge patches #1
> and #2, and comment a bit about it in the code.

+1

But honestly, the semantic and ordering of all the variables and
functions is very complicated. It is very hard to follow and
understand all the rules.

I am going to think about it. But I'll first comment the 2nd
and 3rd patch.

Best Regards,
Petr
