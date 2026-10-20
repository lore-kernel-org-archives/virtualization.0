Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506656;
	b=ZThxMh/SAcumaXNAZW5y75+TYgMCt2sJ4NF1+VyFkcUz97QkK5ZLbDm/uI3LkHiEDblw
	 JxuzfV9iJ4PoNGGplKMb5H7orVfvw249w6JXMk4jtFOfv+Pw94ACF+14W6hcdPDcqrvTI
	 OzkdTjQ1Hz6TMUNpM0z73pi78ah5Idip4EPP8/SphM7dY9wdPLqYZWHh+01TXNp+K7G+P
	 pDXdWYvNhEZEgct22ajgk4qKKCsf8A9iPdOgLAlKBMqzpUE1J2r0fMdZ2cJnNMxNMZs00
	 djD476Dv+xjo17eVB59VYz2/RQKaAi+x6OBsQF3l2mwI/9HpJWJMyW+KlBqH/XcHWmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=;
	b=ZhCi8bqKpOF9q+4NLKSn+3Cl36CMs7pSY/bqDaPcaDv4TmfqgCdtvpRwcWroPDPsy6zT
	 iEhceRZsSsL7+BZEvwbkXb0+9t9MSi+DKUOCW5sbJDOtSOpL6SRfoG448XNbTq2eA9C9I
	 M0AxBkMOd9ylads9clxSIF3nLAxXEw5ozLPRkUugsBH3bwEeCKE0qKBnvGGGEYfI1v8Ue
	 tvfUKO7ikZjRfNWuFN77Pfuf4353O80/pdWN+0TOROXjb/YFXRLGW7WSKePHnFKe7hOyJ
	 clmmQZyofoAW2hg9Qwdc6XQbkWiRRgo03Amp5MaRp9z0rCg716Gk9ykfIE9mE1gvTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CiwMS9po;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2165606A31D
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 14:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2165606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CiwMS9po
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2747678f8f.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792506653; x=1793111453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=;
        b=CiwMS9poA9DeS+gnnOHjT5mh/piKhi6ic7Jqb/ZjhKKg6ySjyGLRzMwlBdAEFBUiMW
         Ku6AgCk8e1rMiXILogyf/hps5UMvx62HTaF/DJcBhMHCHY38RfkCpjAT7P/+byJgIloX
         K6Zh19o1UkYqW3g87LkTV0ubmxb5iIJBPxceZMViQlsLOzGF9K2LVpZP+ymrxrtk/4Ip
         pqZde+PXFZkgn4nGSZLqvz0qO9YY+U2hQrcyXbLgh2+8/HD52FXaR0hHi1jCqT1YGukS
         e0HaIzvMcfia3LQojjp7Zz2/HeEB+xUTfLr3gM1NJMdkib5M60Xnk3vVKHQ586BXlC+R
         0ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506653; x=1793111453;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CniGtgnti6KdC6pQIvauHlETM08FpIVgz45KXnuEH4=;
        b=Df7Tf6FrFY1wXy06IhsMy0EvMXiWZnuJFqKwf8iNBZmkMEhbR8VCeBcZO4jzwiJGam
         WH/q200630HO/smazUxSc6eQLfHMd7BHeoLGDSAxNcZY/yc/NFhBKLOJaIadD/ekVQPc
         dY8grT+sbIS4WG2dnvldgxe2ZAvBJFyuLWvMa7kGsRz2ay2/aaaYcDf2HqrzSK8/g/Z3
         nYkzmVYLoPTKck4akdbCqdIV1A0c2VYe700J4mTAtDxX+QrmiI9yjcu/2uJ4ZdUBLdzx
         wmnjglEgUT4X8aGOfTo8XRwuFdhJ7QX33BexDzmNlAl8XlwNo1kGHGwxBsryYrGM5HQ0
         q37w==
X-Forwarded-Encrypted: i=1; AKwUvBzuaTgGwtWGKeaJtTuxW7FX7XVJzlf3qdJKRJ8Q05cJI7cV1GnYvItR3u0OK2bsZA4YcreapUwiAJLHWQGn4g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIr5h/xJu3iBoMTzXhN4HYFgVZiBXD3QFPHTT9wACyTCgHAY8qb
	aBHktEvpJWXefSThWBWgREzvVHkIlEmhTfJTQoCqa8GNMi3V3TgafoR7yvcZexgvrOY=
X-Gm-Gg: AYBFou3o/6J6x6YhQt7WHd4KuvH0CAyU3QH6+8CYGyTUSpI0agY4ymV8nH5znM+XolA
	58Zg3Adw6BJAuoTCLwKfQCap27pXtRJDXQCSmgQEjqKG2fc8d6AwM7h2tpGYkkEaCcmxb3vMWgS
	mBadwQjlL2kywB1E5bW7KAeHROV/pWx6RXgIrVP4xAiw6/xeWvIgDP7K6mTAetFPe4YbGA/Szlq
	CQNqQeDDh0tpwXe0cUdct2t78ntPapCfnZEDXkrviUf9pMPAYpCyByuTIiWK3yRSVjQ55LIkyh+
	TiEB3T1CM8273aftibg8A1xKq6Q+Uu1lbHXBAgv+kyiFWp/zznYwKMiP7JnLXl2C4aen3p7K9zG
	TJ8oT0w8YxG8v5uQC4+l+BOHDQr5mpPctGqFtT9BAjVonSf4M7NsyeAFhZUZ9h9ZembgQFXxjFL
	9g1pa/47od1j+mRQOdaZ3Rj+aw5uu4QSTcdPnE7lt3B+z14KT+NEwhYYlcxkNDPZFM38JoGlTv
X-Received: by 2002:a05:6000:2887:b0:48c:571a:a1aa with SMTP id ffacd0b85a97d-48e07bbc6e6mr23535312f8f.19.1792506653058;
        Tue, 20 Oct 2026 07:30:53 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214e1sm6395924f8f.37.2026.10.20.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:30:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:30:48 +0200
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
Message-ID: <atd7GInNurGWLUha@pathway.suse.cz>
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
> 
> > > +		atomic_notifier_call_chain(&panic_pre_kdump_list, 0, msg);
> > > +	local_irq_restore(flags);
> > > +}
> > > +
> > >  /**
> > >   * vpanic - halt the system
> > >   * @fmt: The text string to print
> > > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> > >  
> > >  	sys_info(panic_print);
> > >  
> > > +	panic_notify_pre_kdump(buf);
> > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > >  
> > >  	/*
> > 
> > Hi Zack, thanks for trying to improve this conundrum called panic
> > notifiers heh
> > 
> > I confess at first sight I got a bit confused, and only after reading
> > patch 1 and 2 twice, things made sense to me: you're hooking
> > __crash_kexec() directly!
> > 
> > So, in my head, 2 things that would make sense upfront: merge patches #1
> > and #2, and comment a bit about it in the code.
> 
> +1
> 
> But honestly, the semantic and ordering of all the variables and
> functions is very complicated. It is very hard to follow and
> understand all the rules.

Warning: You might skip the first part about my confusion.
	Maybe, I am the only one who is a bit lost this way.

	My motivation is to do not repeat the mess which I saw in
	the printk registration code. People added many features
	there for over two decades. Each change made sense on its own.
	But, for me, it was really hard to understand and distinguish
	what were the wanted and unwanted effects.


I trying to understans why I am confused by the panic notifiers code.
There are several aspects:

1. I was involved in many mail threads where we discussed calling:

	notifiers  before/after  kdump

   but the variable "crash_kexec_post_notifiers" defines calling:

	kdump   before/after  notifiers

   It actually matches the code because __crash_kexec() is called
   twice in vpanic() before and after the notifiers.

   Sigh, it looks like a trivial mental switch. But it is not
   that trivial when we though about splitting the notifiers
   into more lists and discussed where to call them.

   The discussion always was where to call notifiers and not where to
   call kdump.

   And we are also discussing about disabling notifiers. Not about
   disabling kdump.


2. We call the new list "panic_pre_kdump" and this patchset calls
   it in both vpanic() and __crash_kexec() code paths.

   The name "pre_kdump" suggests that it is needed only when kdump
   is called. But we want to call it in panic() even when
   kdump is not called.


3. The new "pre_kdump" notifiers are called before stopping CPUs.
   While the rest is called in the more safe environment
   with stopped CPUs.


4. I am a bit confused by this patch set because it allows
   dumping printk log before kdump. It does not fit with
   my understanding of having "pre_kdump" list only for
   the strictly needed operations.


5. There is the idea of splitting the remainig notifiers into
   _safe and _unsafe lists, see
   https://lore.kernel.org/r/atcjhe4329sYHWvZ@pathway.suse.cz

   It would complicate the design even more. But it might help
   with the endless war whether "crash_kexec_post_notifiers"
   should be "true" or "false" by a platform-specific default.

   I wonder how all this fits together.


Top-level look:
===============

Sigh, one problem is that the notifiers have different purpose:

   1. Notify hypervisor (platform). This looks like a must-to-have.

   2. Platform specific dump of printk messages. This is
      nice-to-have. But note that we also have kmsg_dump API
      for this, see kmsg_dump_desc().

   3. Print extra info. Also this is nice-to-have.

      Some is optional when kdump is created because it might be
      read from there. Some can't be found in crash dump, e.g.
      dumping lowlevel HW state.

      In addition, there is sys_info() info API which allows to
      dump state of various subsystems.

   4. Some notifiers are smp-safe and some just a best effort
      and more safe after disabling other CPUs.

      In addition, I guess that it is better to call crash_kexec()
      without stopping other CPUs because stopping is not reliable
      without NMI. And it would create extra noise in the backtrace.
      And ???


Now, different people have different preferences but mainly:

   + the more safe kdump the better
   + the more safe reboot the better
   + the more info the better


Now, the question is how to satisfy the various requirements
and keep the design sane. We need a compromise but where.

Continue thinking...

Best Regards,
Petr
