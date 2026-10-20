Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514252;
	b=2I6/EgtKmSi0K2886HLhzwhWVUasxugd3WDTZt3n2RBD1qdbKZtZ/bPIU47mLBB2a3en
	 WAhryRdZerooFu5DwXPbmFepAQ2Ut8VtOZOK/XJ+/CpqEL4rY3Z4jlwc5IyZbeGdKqYjv
	 suAcDE56ppdCMIOVzLyiyhun5phLNyOQRQ0LM4Wx6OfvVtbFshOaCe1DprpXgTd2Tlr2k
	 BjqPk3oC4uDBVDlZHAAWmCV41zCWab6jOMDBzcrt1tZx1ZglGCIpYMFJQbOuAMPrBGtRn
	 MOj2L4Fd/JIyaDxxULZZF1D0BJPvi5C0AvSSBJ2y1unQ2TMPjBdhLMJIMaB7UWvDRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=;
	b=iEaUl1rBDka5QitIt9Az1okQZM4hoxMI7u9pFPIwv19umPUXfgJ6UaEHMljtCiOdiFxg
	 pA43TZ1gUWDXZ1Ec89/CxnhzoE6yufM/MwCl5hTmVboNE38r3ZG11Jaob4wlzWx5pXH6v
	 5Y0emi1Nm1wWr4AlJHlBh/0zamoAxwGbeXtStS3+w6IlMRcmfLSPygB1N7JugSRNTr1Mo
	 yctT1c6zP4r+4YWtqaMRDbRyfC/it4knD9VaMFis9HhPhFv4YSXeCb8Wite6+Xv1EZJqo
	 k0r4/26t1ogHlR6inGPkadNrDdGWuhOYTCsIoPu/kbH7I3dqr8b6YL8suFo0VFsiVVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NZ6TaQEy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663660A5BE6
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 16:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6663660A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NZ6TaQEy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso27411085e9.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792514250; x=1793119050; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=;
        b=NZ6TaQEyDtiZCbz3/ISpOPWl6OA6QuI83RdRPzQniYNMw+UPjaDQRBNLChwdaqS+3r
         8X4lNAfxpKvlmcNt1bQQBsd5+lNUMyDtlHeCeNZJD5osbyM2XAPatGQSgW1SrDv97J/d
         JDw64sZKj4wQEp27TKeXVCVV57LM/W17ig3GmduNn0ET/nhIaRhzbA0aRTevDvG3prEd
         azSg8vB6RYAFGLMtT3jD/sOA0a4Oslil5GpI+LqH+y/EzcGqcq9eOyPOMSgRRdmf6NM7
         0cqBqMxzX8rNCz43t79ohZjNKmJo4y7VVod7p79pc2dslCvGpT4PORlV/7+fLotz0OiR
         nyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514250; x=1793119050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3huXbL6tfvWL0Pcc+xlEk6CMxUZ1VDARolPUJTgc12w=;
        b=wbVOYE6t4xDNQj5iNWd4h1M6iwVEw3voTY9qtZYih9aafwXzBxSK6weqGwNRc28Lz+
         cFhDkHTaS/XRW3qZ0WxRwGZoKgVxsURL723sFYIg1E/JM4sTS8e+j/8FuB2Od8wfpAX/
         ia7tvZw1tU+EkRn7aOg+u2KU9vauVuqQ7cDurbkIoq4TrqZwmGJ0ekZYE03+DoMw27bq
         JgiwEFKMfR7GxMB8pTehTmhSV5WmRs0UfuE6HXTKl1kLOVxvKeLtVwaOlZt+xVO+6GZM
         c25RHSmiw2za+3U09mYoNnp+z5tVFMkqFxIUqMpet/8v1FJFqzC30tp7+dNPj0W86GuE
         W13Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMJYJ+fvieJSFo+9JzqFs5u6oiygUyKlLLxew920UNFBfgNaZH5V31V39+urebPC/C+ySK3PyBG8lU9YpOag==@lists.linux.dev
X-Gm-Message-State: AFq9FYLbh6cTczj851GBIieXQQHr/qqNMTiygKIxcv0UwrKBlt3+EAW5
	2gIxOSOumjbrIaB2PAwPeDZ9XwLS1B2TbxrtrobSSqMQDUh5xzyaRik0l1bd3JTgWxc=
X-Gm-Gg: AYBFou12YT6qMBOqG1Q1H+7D0KC3SRjHR5YKnGZfxM0pzz/IqdU2TAIo6YR/70rOO4U
	UUJ6o3Wct3izpc04BMencfwHzlh4B3e+gBfI+Y149IBSADjEJHKC4nASULU9aWD1njuOjsPGfEI
	2XiBNvwdhQFERV8wqYy9t5BIwTF7nqHDXh/87qc2o0UHOUGvZv9hMw1MhF773tmEem3hAIPj8eZ
	GqdmtCSgFYn2CGJss8CcX0Gxp4rE6K08ZttPxjhUx+RK5yqLCPfNvdh4ktVIptS+9XiF8+K4GJp
	SlTexb7UcypULosDSOlwkqbgZkFmFq8knUICoXqEflCXmO3WTcSf6oowsPNJmMg/6gFAj/Qvpxw
	AM/PnmW5jGJSY8MhrFiFfk9VlRSBdAgNyJrnvWAB06d6InTq3tq69XfY0YIZADkwB7jskAjQyTF
	AX/KFG+gPn27tLIS+nkP5WumVb9Tg8diqZ0JjSlPKK5s0UPsH6rdBea+n4XzwzZKpr1W3o8hIg
X-Received: by 2002:a05:600c:8709:b0:49f:ff73:9971 with SMTP id 5b1f17b1804b1-4a1d75f8f28mr236777835e9.18.1792514249669;
        Tue, 20 Oct 2026 09:37:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d41c8asm84327885e9.8.2026.10.20.09.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:37:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:37:24 +0200
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
Message-ID: <ateYxCu63pRY9EGq@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz>
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
In-Reply-To: <atd7GInNurGWLUha@pathway.suse.cz>

On Tue 2026-10-20 16:30:53, Petr Mladek wrote:
> On Tue 2026-10-20 14:01:43, Petr Mladek wrote:
> > On Mon 2026-10-19 19:05:21, Guilherme G. Piccoli wrote:
> > > On 28/09/2026 14:55, Zack Rusin wrote:
> > > > Selected crash callbacks should not require running every panic notifier
> > > > before kdump. Add a separate atomic chain with an at-most-once dispatch
> > > > helper, and invoke it before panic reaches the kmsg dumpers.
> > > > 
> > > > The helper permits another call from the crash path without repeating
> > > > callbacks or recursing into them. Document that callbacks may run in NMI
> > > > context, with other CPUs running and the kexec lock held.
> > > > 
> > > > --- a/kernel/panic.c
> > > > +++ b/kernel/panic.c
> > > > @@ -682,6 +707,7 @@ void vpanic(const char *fmt, va_list args)
> > > >  
> > > >  	sys_info(panic_print);
> > > >  
> > > > +	panic_notify_pre_kdump(buf);
> > > >  	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
> > > >  
> > > >  	/*
> > > 
> > > Hi Zack, thanks for trying to improve this conundrum called panic
> > > notifiers heh
> > > 
> > > I confess at first sight I got a bit confused, and only after reading
> > > patch 1 and 2 twice, things made sense to me: you're hooking
> > > __crash_kexec() directly!
> > > 
> > > So, in my head, 2 things that would make sense upfront: merge patches #1
> > > and #2, and comment a bit about it in the code.
> > 
> > +1
> > 
> > But honestly, the semantic and ordering of all the variables and
> > functions is very complicated. It is very hard to follow and
> > understand all the rules.
> 
> I trying to understans why I am confused by the panic notifiers code.
> There are several aspects:
> 
> 1. I was involved in many mail threads where we discussed calling:
> 
> 	notifiers  before/after  kdump
> 
>    but the variable "crash_kexec_post_notifiers" defines calling:
> 
> 	kdump   before/after  notifiers
> 
>    It actually matches the code because __crash_kexec() is called
>    twice in vpanic() before and after the notifiers.
> 
>    Sigh, it looks like a trivial mental switch. But it is not
>    that trivial when we though about splitting the notifiers
>    into more lists and discussed where to call them.
> 
>    The discussion always was where to call notifiers and not where to
>    call kdump.
> 
>    And we are also discussing about disabling notifiers. Not about
>    disabling kdump.
> 
> 
> 2. We call the new list "panic_pre_kdump" and this patchset calls
>    it in both vpanic() and __crash_kexec() code paths.
> 
>    The name "pre_kdump" suggests that it is needed only when kdump
>    is called. But we want to call it in panic() even when
>    kdump is not called.
> 
> 
> 3. The new "pre_kdump" notifiers are called before stopping CPUs.
>    While the rest is called in the more safe environment
>    with stopped CPUs.
> 
> 
> 4. I am a bit confused by this patch set because it allows
>    dumping printk log before kdump. It does not fit with
>    my understanding of having "pre_kdump" list only for
>    the strictly needed operations.
> 
> 
> 5. There is the idea of splitting the remainig notifiers into
>    _safe and _unsafe lists, see
>    https://lore.kernel.org/r/atcjhe4329sYHWvZ@pathway.suse.cz
> 
>    It would complicate the design even more. But it might help
>    with the endless war whether "crash_kexec_post_notifiers"
>    should be "true" or "false" by a platform-specific default.
> 
>    I wonder how all this fits together.
> 
> 
> Top-level look:
> ===============
> 
> Sigh, one problem is that the notifiers have different purpose:
> 
>    1. Notify hypervisor (platform). This looks like a must-to-have.
> 
>    2. Platform specific dump of printk messages. This is
>       nice-to-have. But note that we also have kmsg_dump API
>       for this, see kmsg_dump_desc().
> 
>    3. Print extra info. Also this is nice-to-have.
> 
>       Some is optional when kdump is created because it might be
>       read from there. Some can't be found in crash dump, e.g.
>       dumping lowlevel HW state.
> 
>       In addition, there is sys_info() info API which allows to
>       dump state of various subsystems.
> 
>    4. Some notifiers are smp-safe and some just a best effort
>       and more safe after disabling other CPUs.
> 
>       In addition, I guess that it is better to call crash_kexec()
>       without stopping other CPUs because stopping is not reliable
>       without NMI. And it would create extra noise in the backtrace.
>       And ???
> 
> 
> Now, different people have different preferences but mainly:
> 
>    + the more safe kdump the better
>    + the more safe reboot the better
>    + the more info the better
> 
> 
> Now, the question is how to satisfy the various requirements
> and keep the design sane. We need a compromise but where.

With the above in mind, I think about two approaches. I have the
following constrains in mind:

   + keep it simple (2-3 lists max)

   + If people configure kdump then they want to use it.
     Post crash_kexec() paths are just a fallback.

   + If people configure panic_sys_info + crash dump then they
     want it even in crash dump.

   + If people configure any kmsg dump and configure kdump
     then they want it before crash_kexec().

   + If a platform wants to do something then it wants to do
     it before __crash_kexec().

   + If something cause problems then fix it. But allow to disable
     it for debugging purposes.

One very important aspect is when other cpus should get disabled.
I guess that most people would want to call __crash_kexec() before
disabling other CPU. Even though, I am not completely sure why.
But some notifiers might be hard to do smp_safe.

The disabling of other CPUs seems to be the most critical operation
which would split notifiers into two groups.

Approach A: Two list: smp_safe vs. smp_unsafe
=============================================

We could create two list:

   + panic_notifiers_smp_safe_list
   + panic_notifiers_smp_unsafe_list

Where the safe list would be called before __crash_kexec().
And the other after CPUs get disabled.

In the long term, I would get rid of the controversial
"crash_kexec_post_notifiers" options. Instead, I would add:

    + disable_panic_notifiers_smp_safe
    + disable_panic_notifiers_smp_unsafe
    + disable_cpus_before_kdump

Then we might call:

	panic_notify_smp_safe();

	if (disable_cpus_before_kdump) {
		crash_smp_send_stop();
		panic_notify_smp_unsafe();
	}

	__crash_kexec();

	if (!disable_cpus_before_kdump) {
		crash_smp_send_stop();
		panic_notify_smp_unsafe();
	}

Where the panic_notify* functions would get implemented as:

	void panic_notify_smp_safe(void)
	{
		if (disable_panic_notifiers_smp_safe)
			return;

		...
	}


Approach B: Three lists: platform, smp_safe, and smp_unsafe()
=============================================================

It is similar to approach A. We would just add an extra:

     + panic_notifiers_platform_list
     + disable_panic_notifiers_platform_list

This list would be used for smp-safe notifiers which are
required be some platform. It would be the notifiers which
are crucial. Which are currently the reason to set
"_crash_kexec_post_notifiers".

It might be called also when __crash_kexec() is called
outside panic().

It would allow to separate the most crucial stuff from
the rest. It might help when it might be enough to
disable the less crucial stuff for debugging kdump
issues.


Conclusion:
===========

Of course, there are many details which might need to be sorted,
for example:

  + how to put this together with the existing list
    until all notifiers are migrated.

  + which list should be called when (__)crash_kexec() is
    called explicitly outside vpanic().

This patchset, adding vmware_log_notifier, might implement just
the panic_notifiers_platform_list. The rest might be
added by another volunteer.

How does this sounds, please?

Best Regards,
Petr
