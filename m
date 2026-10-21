Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574392;
	b=CFLgMi3bONuC16YD9N/QDlaaWVWwsYMlImEEgDXXZ+CIGaCj7b7PsdDd9NilWCtR71q5
	 4MkmZDMpFgiXkOIH9wgbm4aw2FPMvGodP44EAJOA+ivZVFBPEPgkIxXzF9BgM6u1IMk4X
	 DqjDDM8Ufq1w+NROm3zC2sBvqrWPE7PF6tM0lzY6umCC5elkYjTkE7EyQZFUVa0CloKE7
	 yhgcGGc4M2RtYHoH3AlaCyB8HPm05YT/sNuw0ehbqNA+YjqASjjyK/7bK7r00zU6uVJTT
	 03jJC94cAZPrtpA7Ozap6DpK8FemFbTNT2XZALw8AEt1FcMWCePl9cHPXvwTzyCsVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6/75JVjkGfUZNuP8NFIFjHczXUWWhov5nZZde6RyI+M=;
	b=XdmKv74YBO0SDH4RWElAvXylI+891dWG6NTd6eez0fiDtAXr1bVXkupyVMOqSG4A8Pk1
	 SeJ3fqBcNFiEy86Dpoe2EhQigU9alNGI5fAU9MAgEHFdPDIgpt0mNSgJHOluVYu5XQgFc
	 etQ12lEVwLn94g72e4yCOfkJwCdNGiyg0qFifUfH3fL77Ul9QPGW86Y3FQOq3+GCyLuEo
	 l1fFDjkaTJoK0rmAcG1zloYUbBy4ZHx66S0Ipi3FOyQfoINa7fKQYaRPP4bJpgVMC4YU/
	 6+Fg69HE4l5mSNYAUCZHStSYinBlhG5YZLaRDBV7cp9RkylqXczhAWh7sVda/okx5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gqnEAybg;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8C606A31B
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 09:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78C8C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gqnEAybg
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e011d370dso361547f8f.0
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792574390; x=1793179190; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6/75JVjkGfUZNuP8NFIFjHczXUWWhov5nZZde6RyI+M=;
        b=gqnEAybgaaG16eWS3HRsar9MtUptcpF8QmTpwaq1oh72x5IziVvpysUA2+zw6Z/3rI
         9tPaQlzCMArMug1XJblxdHDQFB7tRzfxoAif+t8vTWUJ+WbzG62iU4TvTOxBVWvKNG3C
         9CQQl8t349zbPyRUyTXzzeUzTCD7bPU2rf4POjDqwI0WqdbIj51L8C4036l8+c8lRMrD
         g6tCJA+jU2SwXjPquWhaQ9Ep42to7jqPTupIZdtSR6bZgxvHUeIyCUkd9qMNTSgimZfv
         yZrI9ImbY87cJD2f9Jopexrvr0YUjoSJlo959+LtO22vP8ZwDZx2TY/rl7HMIWm43pdD
         rChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792574390; x=1793179190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6/75JVjkGfUZNuP8NFIFjHczXUWWhov5nZZde6RyI+M=;
        b=jPbHpdgc6kPsopHzCwCRG81q0AIQtTztWS+SNsVXX9hatB8gpvqSF8ZD2XLjWykCyf
         MG51+RoMJteyUj4P+ro69m+KiPP0McNeJZs4irhQPnh3IzPKuhlymgNFx8JeeR7tCVZZ
         MQzScCK6YWaqOdrGCthuvkeqOkI8gXwpTkopaYXhxLph7Kdw7bw4tmn2Bg4tF3PeXYlf
         WrVqc8StcQPu9e4fWU90sfmlDp5BsH5LEXtvx7JiOjiQoWOvcivTaIDMRdPvzwcup8eA
         SVrrHhq0gm34iOCxzOiTkqY94j7poBMPnCBhcSd8EMyIr+Op8J+bjHzD8Nt04QHXx2Ph
         oHlQ==
X-Forwarded-Encrypted: i=1; AKwUvBycWfoxBHah4GsWH04TLb76GY2gbWq+M8iu5JkWgFihsAAbfW8+qXvy85HNKVELB+UH8b8fMmAmJEInDRgNXw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIceMEFHYbA89BbLMgrHk8s9vKNzBzTn/UdWwBsV0ix6jPsJaHB
	yuQfXzn5pUBLOK6x64CR7eQBrnT7EcDr9UGr9WyDtAIcNz6O3RwFvi+WI5kQxaq4wIA=
X-Gm-Gg: AYBFou0t6AEUJ5KnVdynUS55wo2JDa3EOygykDaeFoK9jivZZSXLJFQSTZh8a6VZVND
	YTBYCc0fIyyYTNCFT/8kHzObYs0P1vc9OkEp2R5OmtilJqKgum5Y4xzxgHKaLypz9BlL5ixzz2z
	xEl+8GM1+QaWgBUltXGdiwv18diXXI/lO4Ax4pz2dXj/i1drhW4+gPiL5IWwdNUSY+4an2t/C/j
	oE9QVtUr95dm/DikU5qPC/BX7S2EHCmKlzGhsn0U+UudX4u7l7hkXhwoSW/Y6QDM2yQSU+kXTWN
	DntuihNH+MZqbLuihmF31CveP7I8qtkxAv7gcCZCCwAh2YcOJ2ZrJS9GPcyEISM2yFbBFxij398
	rV6+0EYw7bW6/kIQ65L/L4KM3dwx9cRlga0dWPUNjzCMmJq40/V9buphYj8M7WI62t0T/4aRhLj
	mr4Z1chj40q/mWASLMUY5kv8cmlxlPkIW3t/xREPeSVNEpaBq3aoEwbsdE8MevfxYmuWfCz5THY
	1VW8nH1SW/Hp0vq8ZnSdzWgWV56J4OSVJXAYYYCVBA2mJw4mjCVa5RyFMZjYDq+9hWG049O
X-Received: by 2002:a05:6000:4805:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-48e2647cbedmr2527057f8f.18.1792574389649;
        Wed, 21 Oct 2026 02:19:49 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25834086sm4358154f8f.34.2026.10.21.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:19:48 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:19:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Baoquan He <baoquan.he@linux.dev>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
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
Message-ID: <atiDsmnUM7v2UJkY@pathway.suse.cz>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz>
 <ateYxCu63pRY9EGq@pathway.suse.cz>
 <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com>
 <atgdwrSbsZD5iWsX@fedora>
 <CABQX2QO6fwvKZwG34uOYDU_ae4M4_n2SMsYmqoLgOPnWkao02w@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABQX2QO6fwvKZwG34uOYDU_ae4M4_n2SMsYmqoLgOPnWkao02w@mail.gmail.com>

On Wed 2026-10-21 01:10:25, Zack Rusin wrote:
> On Tue, Oct 20, 2026 at 10:04 PM Baoquan He <baoquan.he@linux.dev> wrote:
> >
> > On 10/20/26 at 03:23pm, Zack Rusin wrote:
> > > Hi, Petr.
> > >
> > > First of all I really appreciate you going over this. Thanks!
> > >
> > > On Tue, Oct 20, 2026 at 12:37 PM Petr Mladek <pmladek@suse.com> wrote:
> > > > Approach B: Three lists: platform, smp_safe, and smp_unsafe()
> > > > =============================================================
> > > >
> > > > It is similar to approach A. We would just add an extra:
> > > >
> > > >      + panic_notifiers_platform_list
> > > >      + disable_panic_notifiers_platform_list
> > > >
> > > > This list would be used for smp-safe notifiers which are
> > > > required be some platform. It would be the notifiers which
> > > > are crucial. Which are currently the reason to set
> > > > "_crash_kexec_post_notifiers".
> > > >
> > > > It might be called also when __crash_kexec() is called
> > > > outside panic().
> > > [...]
> > > > This patchset, adding vmware_log_notifier, might implement just
> > > > the panic_notifiers_platform_list. The rest might be
> > > > added by another volunteer.
> > > >
> > > > How does this sounds, please?
> > >
> > > That sounds good to me. For v3 I'd do just the platform list:
> > >
> > > - One call in vpanic(), right after kgdb_panic() and before the first
> > > __crash_kexec(), whatever crash_kexec_post_notifiers is set to. The
> > > list runs before kdump and before the other CPUs are stopped.
> > > - One call in __crash_kexec(), after it has taken the kexec lock,
> > > found a crash image and saved the registers, for paths that enter
> > > kdump without panic(), like oops_end() or Hyper-V's hv_crash_handle().
> > > Once the early panic call has run the list, the guard makes this one a
> > > no-op. That removes the dependence on crash_kexec_post_notifiers you
> > > pointed out before.
> > > - A once-only guard shared by both, so the list also runs only once
> > > when a callback panics.

Just to be sure. I think that a simple static bool or int should be
enough. The caller is responsible for the synchronization. I believe
that it should be done by the "panic_cpu".

> > > - disable_panic_notifiers_platform_list as a boot and runtime switch,
> > > checked in the same helper, replacing panic_pre_kdump_postpone.
> > > - Kernel-doc with your definition: smp-safe callbacks a platform
> > > needs, which would otherwise be a reason to set
> > > crash_kexec_post_notifiers.
> > >
> > > Roughly:
> > >         kgdb_panic(buf);
> > >
> > >         panic_notify_platform();
> > >
> > >         if (!_crash_kexec_post_notifiers)
> > >                 __crash_kexec(NULL);
> > >
> > > and in __crash_kexec():
> > >
> > >         crash_setup_regs(&fixed_regs, regs);
> > >         /* Direct entry outside panic() */
> > >         panic_notify_platform();
> > >         crash_save_vmcoreinfo();
> > >
> > > I'd keep the second call in __crash_kexec() rather than crash_kexec(),
> > > because afaict crash_kexec() can return without a crash image, e.g.
> > > from the BPF kfunc, or from oops_end() before it panics. Calling the
> > > list there would use up the guard even when no kdump follows.
> > >
> > > crash_kexec_post_notifiers, the existing list and the kmsg dumpers
> > > stay as they are, and moving other platforms over can come later.
> > >
> > > The VMware log copy would be the only user, and it's still best-effort
> > > diagnostics: kdump and the reboot don't depend on it. It copies the
> > > log tail into an 8 KiB buffer. On panic() that happens after the panic
> > > message and any local backtrace; on direct entry from an oops, after
> > > the exception output. With the list enabled throughout, the copy
> > > precedes the later panic notifiers, sys_info() and the all-CPU
> > > backtrace step. The guest-crash report stays a late kmsg dumper that's
> > > skipped while a crash kernel is loaded, because the host can power off
> > > the VM inside that call.
> > >
> > > If that matches what you had in mind, I'll do it that way in v3.
> > >
> > > Guilherme, Stephen, Baoquan, does that work for you too?
> >
> > Hi Zack,
> >
> > Sorry I didn't check this series before, just trying to catch up.
> >
> > I like the Approach B direction: one panic_notifiers_platform_list for
> > platform callbacks that must run before kdump. While I have one concern
> > about the long term.
> >
> > Today the list has only the VMware log sender. Later, more handlers may join
> > (for example pvpanic, Hyper-V, Xen, gsmi, SNP). When the list grows, someone
> > will want to run only their handler, or to skip some handlers. The easy
> > answer is "add a new list for my handler". I think this will be a problem too
> > in the future. Every new list adds a new global ordering rule and a new disable
> > switch. Petr already said we should keep the number of lists small.

My hope is most of the potential users won't be registered at the same
time or will be a NOP in the real life. Because each particular system
will actively used only some technology.

But maybe I am naive and there will be selection and ordering problems.

> > Currently, atomic_notifier_call_chain() runs all registered callbacks. There
> > is no per-handler enable/disable and no filter. NOTIFY_STOP_MASK can stop the
> > chain, but we must not use it here, because one handler could hide all the
> > later handlers. The list-level disable_panic_notifiers_platform_list can
> > only disable the whole list.
> >
> > I have some rough though, just for reference:
> >
> > 1. Keep one panic_notifiers_platform_list.
> >
> > 2. Give each handler a small wrapper with a name and an enabled flag:
> >
> >    struct panic_pre_kdump_notifier {
> >            struct notifier_block nb;
> >            const char *name;
> >            bool enabled;
> >    };

This looks good to me.

> > 3. In the dispatch, skip a handler when enabled is false. Print the name
> >    before calling it. This also helps when a handler hangs and we want to
> >    know which one it was.
> >
> > 4. Add a boot parameter to disable handlers by name, for example:
> >
> >            panic_pre_kdump.disable=vmware_log,hyperv_crash

I like this. I think that we just would want to do s/_pre_dump/_notifiers_platform/.

> >    Parse it early. At panic time we only read the flag. We do not parse
> >    strings in the panic path.
> >
> > 5. Keep the list-level disable_panic_notifiers_platform_list. It is still
> >    useful to disable the whole list for debugging.
> >
> > 6. If the list is still too broad later, we can add a reason/class argument
> >    (for example PANIC, OOPS_DIRECT). A handler can then decide if it cares.
> >    This is better than adding a new list.
> 
> Thanks for looking at it. I agree we shouldn't add a separate list for
> each handler, and named handlers with their own switch on the one list
> sound like the right way to grow it.
> 
> For v3 I'd like to keep the series to the list itself. With VMware as
> the only callback, the list-wide boot switch already lets us disable
> platform logging. The sender also has its own sysctl,
> kernel.vmware_record_panic_msg. We can add per-handler selection with
> the next user, when there's an actual choice between handlers. I'm
> happy to help with that when it comes up.

Sound good to me. I would like to start simple. We could add the selection
later when it is needed in the real life.

> Two of your points do fit in v3 as documentation. I'll change the
> panic_notify_platform() kernel-doc to also say that:
> - callbacks must return NOTIFY_DONE, because NOTIFY_STOP would skip
> the callbacks after them
> - the notifier value is 0.

Great catch!

> The VMware callback ignores that value, which leaves room to add
> reason information later.
> 
> Petr, does keeping v3 to that sound right to you?

Sounds good to me. But you might want to wait few more days for
more potential feedback.

Best Regards,
Petr
