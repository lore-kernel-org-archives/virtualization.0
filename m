Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.93
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548301;
	b=2Fe1v4Kk/pSlCbdAceFgo2sht7RFweL0YrVCaqryAzaKzmnITH3UROp16arkwrXwNyad
	 fJXQ7KEzoOn2qoDK9Tgil2rBUWe3N/wPYO0rr33t0gofaEUGmqcq2PLXyCzFFHiiZAvoM
	 H3kVLXfxWIjWgUVFvl//otq1HGGH+aS1s2oxDTjVif5f8ABJJw4i1ODGVBa5Oo2tGQgu8
	 4xu8CmQuYNctbEQj/FarmWZtjgQEK3M6R2SjSSf2GRsU+fIQ8uw0zKetQYRP0Hetl6l1Z
	 RrVJZveTCNM6j4jJcMuHjnh4CXIzigUatWx3nNrVYBW/LD/2ZJIQMAhi6HxkcqV7gDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548301;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zgK2/EbQq4Wko0fal9WMxNMt30UIOgXg5MWzZwgJ9rg=;
	b=A+waia5DAtKdMZ4Gn8kCpOvQ/wXZyxdVmW+H0bXzWkS1yUKUAjRerqu1oNp2dblPv68E
	 0/Wd7/k/HCcPqBJAytJEi88zQWhLSEaM4ggytecij9l9F/Dbc2lohuXGeyJKQvFZS1NB4
	 KU8vldJhkW75vUDqGxY8ZM0F/aLmryI9adpXj07uma2Cr8EH57UCnY0k9uL/hijLYjhSO
	 xfi0A3NVX8zPmDo9x1Wygj3xyJpxpX58Ds567LSWkOCXbCf98sSeRiUwT3WKeMH6caTwk
	 4Z1eWZDoiqkbeB85pWPTn4WlN/akPYJWdKwKg2WMh1LGti47YaaAddvFRR26kcLzy0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GmtlhePM;
	arc=none smtp.remote-ip=95.215.58.93
Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95A606A324
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 02:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE95A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GmtlhePM
X-Envelope-To: virtualization@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ysiCbX/B8PX9EOlUItfenqtvSRkF3eedWpo/CA62AIo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792548297; v=1; x=1793153097;
 b=GmtlhePMFLdrntnHY5IPjUDWGSrQcGrTO35U95TTrNNnNz9J3TiVfT4UB3wem69JM1iP46yT
 0wRetimE/NesrwcF2HXjMwuPJiuLIW6LjqBGyWoJZ+vgWQzvyX9oOINlhiEtYsdnKH0UnQpHi4X
 Pqnj1N0vlPbJ+zB7vW1eblb4=
X-Envelope-To: virtualization@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 186e51eaaad1686a;
	Wed, 21 Oct 2026 02:04:57 +0000
X-Mizu-Trace-ID: 186e51eaaad1686a
X-Migadu-Flow: FLOW_OUT
Date: Wed, 21 Oct 2026 10:04:50 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Petr Mladek <pmladek@suse.com>,
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
Message-ID: <atgdwrSbsZD5iWsX@fedora>
References: <cover.1790014793.git.zack.rusin@broadcom.com>
 <81cb85568b36273a8e66215b3e6d671b8488d402.1790014793.git.zack.rusin@broadcom.com>
 <bc783856-9480-3944-67fb-675e4c11d8c2@igalia.com>
 <atdYIxwz8ksYNty6@pathway.suse.cz>
 <atd7GInNurGWLUha@pathway.suse.cz>
 <ateYxCu63pRY9EGq@pathway.suse.cz>
 <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com>
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
In-Reply-To: <CABQX2QOKCpoUY_ObhFif7xN7OF-NzcxEM0JABAXo9n9KaacO7A@mail.gmail.com>

On 10/20/26 at 03:23pm, Zack Rusin wrote:
> Hi, Petr.
> 
> First of all I really appreciate you going over this. Thanks!
> 
> On Tue, Oct 20, 2026 at 12:37 PM Petr Mladek <pmladek@suse.com> wrote:
> > Approach B: Three lists: platform, smp_safe, and smp_unsafe()
> > =============================================================
> >
> > It is similar to approach A. We would just add an extra:
> >
> >      + panic_notifiers_platform_list
> >      + disable_panic_notifiers_platform_list
> >
> > This list would be used for smp-safe notifiers which are
> > required be some platform. It would be the notifiers which
> > are crucial. Which are currently the reason to set
> > "_crash_kexec_post_notifiers".
> >
> > It might be called also when __crash_kexec() is called
> > outside panic().
> [...]
> > This patchset, adding vmware_log_notifier, might implement just
> > the panic_notifiers_platform_list. The rest might be
> > added by another volunteer.
> >
> > How does this sounds, please?
> 
> That sounds good to me. For v3 I'd do just the platform list:
> 
> - One call in vpanic(), right after kgdb_panic() and before the first
> __crash_kexec(), whatever crash_kexec_post_notifiers is set to. The
> list runs before kdump and before the other CPUs are stopped.
> - One call in __crash_kexec(), after it has taken the kexec lock,
> found a crash image and saved the registers, for paths that enter
> kdump without panic(), like oops_end() or Hyper-V's hv_crash_handle().
> Once the early panic call has run the list, the guard makes this one a
> no-op. That removes the dependence on crash_kexec_post_notifiers you
> pointed out before.
> - A once-only guard shared by both, so the list also runs only once
> when a callback panics.
> - disable_panic_notifiers_platform_list as a boot and runtime switch,
> checked in the same helper, replacing panic_pre_kdump_postpone.
> - Kernel-doc with your definition: smp-safe callbacks a platform
> needs, which would otherwise be a reason to set
> crash_kexec_post_notifiers.
> 
> Roughly:
>         kgdb_panic(buf);
> 
>         panic_notify_platform();
> 
>         if (!_crash_kexec_post_notifiers)
>                 __crash_kexec(NULL);
> 
> and in __crash_kexec():
> 
>         crash_setup_regs(&fixed_regs, regs);
>         /* Direct entry outside panic() */
>         panic_notify_platform();
>         crash_save_vmcoreinfo();
> 
> I'd keep the second call in __crash_kexec() rather than crash_kexec(),
> because afaict crash_kexec() can return without a crash image, e.g.
> from the BPF kfunc, or from oops_end() before it panics. Calling the
> list there would use up the guard even when no kdump follows.
> 
> crash_kexec_post_notifiers, the existing list and the kmsg dumpers
> stay as they are, and moving other platforms over can come later.
> 
> The VMware log copy would be the only user, and it's still best-effort
> diagnostics: kdump and the reboot don't depend on it. It copies the
> log tail into an 8 KiB buffer. On panic() that happens after the panic
> message and any local backtrace; on direct entry from an oops, after
> the exception output. With the list enabled throughout, the copy
> precedes the later panic notifiers, sys_info() and the all-CPU
> backtrace step. The guest-crash report stays a late kmsg dumper that's
> skipped while a crash kernel is loaded, because the host can power off
> the VM inside that call.
> 
> If that matches what you had in mind, I'll do it that way in v3.
> 
> Guilherme, Stephen, Baoquan, does that work for you too?

Hi Zack,

Sorry I didn't check this series before, just trying to catch up.

I like the Approach B direction: one panic_notifiers_platform_list for
platform callbacks that must run before kdump. While I have one concern
about the long term.

Today the list has only the VMware log sender. Later, more handlers may join
(for example pvpanic, Hyper-V, Xen, gsmi, SNP). When the list grows, someone
will want to run only their handler, or to skip some handlers. The easy
answer is "add a new list for my handler". I think this will be a problem too
in the future. Every new list adds a new global ordering rule and a new disable
switch. Petr already said we should keep the number of lists small.

Currently, atomic_notifier_call_chain() runs all registered callbacks. There
is no per-handler enable/disable and no filter. NOTIFY_STOP_MASK can stop the
chain, but we must not use it here, because one handler could hide all the
later handlers. The list-level disable_panic_notifiers_platform_list can
only disable the whole list.

I have some rough though, just for reference:

1. Keep one panic_notifiers_platform_list.

2. Give each handler a small wrapper with a name and an enabled flag:

   struct panic_pre_kdump_notifier {
           struct notifier_block nb;
           const char *name;
           bool enabled;
   };

3. In the dispatch, skip a handler when enabled is false. Print the name
   before calling it. This also helps when a handler hangs and we want to
   know which one it was.

4. Add a boot parameter to disable handlers by name, for example:

           panic_pre_kdump.disable=vmware_log,hyperv_crash

   Parse it early. At panic time we only read the flag. We do not parse
   strings in the panic path.

5. Keep the list-level disable_panic_notifiers_platform_list. It is still
   useful to disable the whole list for debugging.

6. If the list is still too broad later, we can add a reason/class argument
   (for example PANIC, OOPS_DIRECT). A handler can then decide if it cares.
   This is better than adding a new list.

So with them:

- We keep one place to register, one ordering rule, and one place to look
  when something goes wrong.
- "Run only my handler" becomes a debug switch (disable the others), not a
  new global list. Or vice versa.
- We do not change the general struct notifier_block.
- The panic path only reads a bool, so it is safe and cheap.

just some rough thoughts, maybe not well polished, just for reference.
Thinking of these becasue I do meet requirement in real use case where
they really want to run their own one specific panic handler before
kdump while not easy to make it.

Thanks,
Baoquan

