Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193420;
	b=sK7C1xkWEcOgTuMz0HciLUN1uBF7iQIHjxQZDQYTxLD3Omv41LQBgUBalTxG5bSZBGVC
	 5gJwz0182k+NyrM5I3DmdHaQH+egODtqtDOYW9L0CvTVXKav+J0VT438yRcJEMQRM7OG6
	 JIJqdL05fMmK7HNb23bPJ6Tx1FDt08/hDnPY9aG3TMpPy1cC1nQ0F/GAN6dxcEt/j954G
	 5HWeL+Ak8uoY6rF0N0WE6tA45nYqHuh+eLZN4UjL14vtF0MERwVgTpAeqzkWp1r/YVVyl
	 Ser68AuDlGUFoB7tImZr3o7SSxeSc96660gKf6b/tHEz4z3sFTeDKvI1O3iQKB77MXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193420;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=YViuODv3sBF8sJrOq+FipnyvO3qN8MhhYOh/ijh6GYE=;
	b=VStEt/WHRSopzHy7dpn3HHNvSlf+k71I8zpOXq98KcGAha+4yvCXXQ6jEtlD/pzugwVg
	 DZVSkS2hCl0vyz540TrFz441w7g7lFqH35NZ44/bFjJU8/sj98EAFHbYI2gQxpRPoUYy/
	 txgsMkUdjyPVfezBMYjPZu9QEVU4rqZQl0XgfRTLqF6bKPqIR9XuqU60hQ4I30k4iDaAz
	 xzcQOMj1SVT0t2MocFvusULF9gYZoVLIUdtLEG3Kn6z8VgFEzjsFpzKBnLwqMTP5eto69
	 28z/wG7LfP4cswUQWjQjewZfBR6yMJLAzhcvjX94VFYh2F9gs2hixV5RfgipTn61yXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=T45676MR;
	arc=none smtp.remote-ip=74.125.82.228
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com [74.125.82.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF860A2609
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 16:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CCF860A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=T45676MR
Received: by mail-dy1-f228.google.com with SMTP id 5a478bee46e88-3866a784546so706135eec.0
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 08:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193419; x=1795798219;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YViuODv3sBF8sJrOq+FipnyvO3qN8MhhYOh/ijh6GYE=;
        b=1Ke6xFifz9lAevsTkp0vZXzZLQDDosFYZNM1j95tMrYDqgnB6MbwEoxth4GLtBMkGO
         AHnNgImPmEpVvjI5eUkup/pnXECPrn3q38rvgYxaWmzRiHmBlcRaIUb9ysYQX4sZw62n
         +KuZOI6RddtXyxPQICWjFWsHME6MKFUsYTK2vMdnZqRc/KHa2seUBTFOVbec6chwvt2k
         sSrfS55gnksGijWjMDW+xS25cELVkmLGnnyMLpx5BCE09b9rBeZfI4J+uCkAdmfM41er
         elogH56Y0c75Gt/3nvfpECkKg3h2fvWZ2WlqtTWaJy1jTMQ8U9noC7wK21sQEwCwx6aZ
         zbFg==
X-Forwarded-Encrypted: i=1; AL+hErFpdTFqGz+pwyZyJmzPN6enFIaVsCi6cm1aSAu9/L4R++xFO9k3Wshv2XojoA89LYdoblvCxl2N4ngM92VqXA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/VLyEGdYmZg/plRPAfiYqDnwOE7paBN11Df+tj/kLI0aO+f5oP
	GhxQGiYEMY7+gSv5WspVbPm1HwVdsDhcvW8/7WVn22ZDWpRKqrNcNmdzuqbQDvqJ6LtYA8zE9hB
	r6XbwCFW27bxe8bSl+BF8vAAlB/j2IvfNWUezOVBbo2i/F+xc2lOztZFUqCZTeTFS+MgXSc69Gz
	I1qyA9TmUMft/RPl9e3tGGVSHm79/rIcEvNGh2OW2f0hAf2iN+jvCoevo5DczU3DfMNs2PCibxk
	qhcONoHY2DYlSruB8Y=
X-Gm-Gg: AZFdTZej12iTOvrvwrNwDIM3VHuZ6MbedMi+yfaL3rm0mhbI/vGL/QMOOOToRQPS5ca
	0I/Cq32ksE71zxVs9JNqts7EO7915tskctpyi8M10rICj5pobQ2te0KUihu98zJIa9KtyFkwlKM
	HIgcNFPfwiUNPqMyMpk0mpJS0vX28qBg+bXnDmyZBDo/QCwsgBAy9d2PA0WyBcSEpJ6Jjodrsuw
	DhkTrx0H/TVH8zeYdoMgB+Y0lQF8ZYqMaustppqIGk9EX8WpIcj87EIAVR/Xd17rw38PrUfAFog
	cNKioPSXy9sqEe0mjtHgH5gCNevHqpt9cDz7F7o52jdus+NyeU8VbveVv3F/egYPpQzAuURYDfg
	m4+HLof8fpwI37McZvsOKk7tjq8iHIIe+C7SQ/1bfLYnOkjZJXnsCyBZ6uyVZNZoduvKjha0kIh
	FKyCHAk0rs9FlVGAkZ1ZnL5CSZZc/PYqhZSrI=
X-Received: by 2002:a05:7300:3e93:b0:383:bef:b6f6 with SMTP id 5a478bee46e88-385701574f4mr3885880eec.21.1795193418747;
        Fri, 20 Nov 2026 08:50:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-385677c01dcsm250578eec.20.2026.11.20.08.50.18
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2026 08:50:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3ab442d8d13so4174731fa.1
        for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795193416; x=1795798216; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YViuODv3sBF8sJrOq+FipnyvO3qN8MhhYOh/ijh6GYE=;
        b=T45676MRgVru1+JkFRjBqClLWG9G6zGbKe0aEyZDziiWn9ZkwFIjLSjSB8znOvwrV/
         BsDHiwa9sXlFyBdIskZ3PquKAky4tcRXJq49KUZWNNahOsdZzT26wIFDv0kyz8dhOJ4+
         4b8yehj+0Zo+IPBepNkg7tzHH7ZfjDxr0kq4Y=
X-Forwarded-Encrypted: i=1; AL+hErGUtIgQ6QM56uOyG/+qwHe0xyF2YgwcTbxM1hByV+g64Vt2jhpcVOxeTwxGrQeywID+xLVYcvB8+J9aVBf2wQ==@lists.linux.dev
X-Received: by 2002:a05:651c:4217:b0:3ab:4412:354b with SMTP id 38308e7fff4ca-3ae7f8d487dmr10593561fa.1.1795193416253;
        Fri, 20 Nov 2026 08:50:16 -0800 (PST)
X-Received: by 2002:a05:651c:4217:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3ae7f8d487dmr10593461fa.1.1795193415716; Fri, 20 Nov 2026
 08:50:15 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1794980455.git.zack.rusin@broadcom.com> <d0f9c1188b5f78bb20bb43737b3cf80c5c0f94f4.1794980455.git.zack.rusin@broadcom.com>
 <awAgkNoIKpFx764w@pathway>
In-Reply-To: <awAgkNoIKpFx764w@pathway>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 20 Nov 2026 11:50:02 -0500
X-Gm-Features: AclHuK9GQbfZsE-e_FygJiBCaH9fgQM-jyLJG0lFbO4vRhXl8iPcfZYOTlFChxY
Message-ID: <CABQX2QN7qbaJWzk7APtB4x82d-=Wf7=tdBQQnjBnuvjS6nBa9g@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] x86/vmware: Report guest crashes after kmsg dumpers
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, 
	Joel Granados <joel.granados@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>, 
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Michael Kelley <mhklinux@outlook.com>, Ian Forbes <ian.forbes@broadcom.com>, 
	Bradley Morgan <brads@mainlining.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e8c14e0660b80935"

--000000000000e8c14e0660b80935
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 5:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Hi,
>
> this patch looks a bit messy, But maybe, I just do not know enough
> about VMvare.

It's my fault for not explaining it better. I'm trying to find a
balance between being overly verbose and explaining only what's
necessary for review, while omitting details irrelevant outside of
VMware, and I'm failing.

> On Wed 2026-11-18 01:01:51, Zack Rusin wrote:
> > VMware accepts a structured guest-crash event, but a host configured wi=
th
> > backdoor.coredumpOnCrash may terminate the VM before the hypercall
> > returns. Keep this event separate from the log sender, which runs
> > earlier in panic.
>
> I am a bit lost here ;-)
>
> What exactly means the "structured guest-crash event"?
> Which hypercall are we talking about?

VMWARE_CMD_REPORTGUESTCRASH, the vmware_hypercall1() in
vmware_report_guest_crash(). It takes no arguments and carries no
data. It tells the host that the guest OS has crashed. The host
records that, and vSphere can raise a "Guest OS crashed" event for the
VM that management tools and alarms act on.

"Structured" was a poor way of saying "a crash state the host
understands". Patch 2, by contrast, only copies log text into the VM's
log file on the host. I can drop the word "structured".

> Is this primary about synchronization of vmware_panic_log_notify()
> against termination of the crashing guest by the host?
> Or is this about something else?

It's about ordering rather than synchronization. Patch 2 sends the log
from the platform list, before kdump, so it is done before the report
can happen. Patch 4 is about the other side: it skips the report when
a crash kernel is loaded, and otherwise tries to give the guest's own
log dumpers (pstore etc.) a chance to finish first.

> What exactly does vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)?
> Does it _block_ or _trigger_ backdoor.coredumpOnCrash?

It triggers it. Normally the call records the guest OS crash and
returns, and Linux continues its panic path. backdoor.coredumpOnCrash
is a debugging option in the VM's configuration, off by default. With
it enabled, the host attempts a dump of the guest and stops the VM
during the call, so the hypercall never returns.

So with that option set, anything panic() still has to do after the
report never happens. That always includes the kmsg dumpers that come
after the report, and, without the crash-kernel check, kdump too when
crash_kexec_post_notifiers is set. That is also why the report can't
share the platform list with the log sender.

> > Register a panic-only kmsg dumper with late_initcall_sync(), after buil=
t-in
> > dumpers registered by then.
>
> Is this ordering important?

Yes. kmsg_dump_desc() calls the dumpers in registration order, since
kmsg_dump_register() appends with list_add_tail_rcu(). Registering
from late_initcall_sync() puts the report after the panic dumpers that
are already registered at that point, giving them a chance to save
their records before a coredumpOnCrash host stops the VM. Dumpers
registered later, by modules or late-probing drivers, end up behind
it. It only makes a difference with that option set.

> > Skip the event while a crash kernel is loaded
> > so the host cannot terminate the guest before kdump saves its vmcore.
>
> This suggests that vmware_hypercall1(VMWARE_CMD_REPORTGUESTCRASH, 0)
> actually triggers the external crash dump procedure made by the host.

Yes, when the option is set. With crash_kexec_post_notifiers, kdump
runs after kmsg_dump_desc(), so the report would stop the VM before
the capture kernel started. A guest with a crash kernel loaded
therefore leaves the crash to kdump and does not report it.

> > Issue the event at most once. With CONFIG_PRINTK=3Dn, use a late INT_MI=
N
> > panic notifier. An unexpected dumper registration failure with printk
> > enabled leaves reporting disabled rather than overtaking working dumper=
s.
>
> This is another mystery. What do you want to achieve when
> CONFIG_PRINTK is not defined, please?
>
> Note that printk() is a NOP when CONFIG_PRINTK is not defined.
> There is nothing to dump in this case.
>
> Honestly, I would not complicate the code by this.
> I doubt that anyone is using kernel without CONFIG_PRINTK.
>
> > --- a/arch/x86/kernel/cpu/vmware.c
> > +++ b/arch/x86/kernel/cpu/vmware.c
> > +static int __init vmware_crash_report_init(void)
> > +{
> > +     int ret;
> > +
> > +     if (!hypervisor_is_type(X86_HYPER_VMWARE))
> > +             return 0;
> > +
> > +     ret =3D kmsg_dump_register(&vmware_crash_report_dumper);
> > +     if (!ret)
> > +             return 0;
> > +     if (IS_ENABLED(CONFIG_PRINTK)) {
> > +             pr_err("failed to register crash report dumper: %d\n", re=
t);
> > +             return 0;
>
> This is weird. As I said, printk() is a NOP when CONFIG_PRINTK
> is not defined. So, you would achieve the same with:
>
>         ret =3D kmsg_dump_register(&vmware_crash_report_dumper);
>         if (ret)
>                 pr_err("failed to register crash report dumper: %d\n", re=
t);
>         return 0;
>
> But wait, this means that the code below is never reached.
>
> Ah, I see, you wanted to run the code below when CONFIG_PRINTK
> was disabled. It was far from obvious. And I do not understand
> the motivation much.
>
> Anyway, it won't work because kmsg_dump_register() returns -EINVAL
> when CONFIG_PRINTK is not defined. err !=3D 0 ...

That -EINVAL is what the fallback relies on. With CONFIG_PRINTK=3Dn the
stub returns -EINVAL and IS_ENABLED(CONFIG_PRINTK) is false, so init
falls through and registers the INT_MIN panic notifier instead. The
pr_err() branch is only for a real registration failure with printk
enabled.

The motivation was that the report doesn't need the log, so a kernel
without printk could still report its crash. Now having said that, is
CONFIG_PRINTK=3Dn actively used inside vmware? Not to my knowledge, I
did it for completness more than a very specific need so if you really
don't want it in, I can remove all the CONFIG_PRINTK=3Dn handling, at
least until I have a specific need for it.

> Let's take a step back.
>
> Why do you want to use kmsg_dump infrastructure for notifying
> host about the crash, please?
>
> The kmsg_dump API should be used to dump the printk messages.
> But this just notifies the host about the crash. It looks like
> an API misuse.

The only reason is ordering. In vpanic() the platform list runs before
kdump, and panic_notifier_list, even at INT_MIN, runs before
kmsg_dump_desc(). Registering a late dumper is the only way to run
after the dumpers registered before it. I agree that a dumper which
never reads the log is a bit hacky :)

> > +     }
> > +
> > +     ret =3D atomic_notifier_chain_register(&panic_notifier_list,
> > +                                          &vmware_crash_report_nb);
> > +     if (ret)
> > +             pr_err("failed to register crash report notifier: %d\n", =
ret);
> > +
> > +     return 0;
>
> IMHO, you either want to use the panic_notifier list.
>
> Or you might even use the new panic_notifiers_platform_list
> if you make sure that this is called as the last event
> and you really want to stop the guest at this point.

I don't think that the platform can be last: by design it runs before
kdump, and it already holds the log sender from patch 2.

panic_notifier_list at INT_MIN would work, and it would cover
CONFIG_PRINTK=3Dn without a special case. The cost applies only when
coredumpOnCrash is set and no crash kernel is loaded: the VM would
stop before panic_print's sys_info() output and before all of the kmsg
dumpers, pstore included. The host's dump would win over pstore. On a
default host the dumpers still run; the host just hears about the
crash a little earlier.

I'm fine with either. If you don't like this approach for v5 I can
switch to a panic_notifier_list entry at INT_MIN (still skipped while
a crash kernel is loaded), or keep the dumper and add a comment
explaining why it ignores the log. Which would you prefer?

> My assumption is that the "host" will stop the "crashing guest"
> when it gets notified about the crash.

Not by default. Normally the host records the crash and the call
returns, so the guest continues its panic path. It's stopped during
the call only when backdoor.coredumpOnCrash is enabled.

> PS: It looks to me like Sashiko AI completely failed here. It did not
>     mind if the commit message made sense. It did not see the big
>     picture. And it even missed that the code did not work with
>     CONFIG_PRINTK undefined.

I don't know if sashiko reads commit messages, that one is on me. I'm
trying to get better at finding the right balance between oversharing
and not sharing enough and it's not easy.

The CONFIG_PRINTK=3Dn case isn't a miss, though. As above, init falls
back to the panic notifier when kmsg_dump_register() returns -EINVAL,
so that path works. It's just a question of whether it's worth having:
for me it was easy enough to handle it but I wouldn't object to
dropping it if you find it too complex.

Thanks for the careful review!

z

--000000000000e8c14e0660b80935
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIPMn
W0OwsrA3c+frpPAomFNZcG/4YYQqEFPwLBcgnXiLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTEyMDE2NTAxNlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHKuLdBaXx5PB9XwgCLoDJszdJwf7DHjnmwxyqOp
wwnEMoZz8EXw9PKxN8ZqIlhTWTW3G/NB60LEiIbEoXRib+r7cqLYe7N6KexHrN/csL8y4GZzG37S
aM9mcNba2FeRRIBXDgFoC38wwb/7zwAZ3yOQyVjlfczmXy9rUQgM1vXs6pazNpM82iCTvs3zWGnm
heQONHr6gkUuJ0EtbX85cZu7UTXWpPdUQPORWhzTeXUlWNW82P155dXkjYmi8ryKxLxIjGtz2bXW
rdUbzp9NOkFegGO3FWdzP4XTvV8PWfxN4mCb+evoTSMzVG6be/tETZN0u3kOmC7r3MEmhg1nMBc=
--000000000000e8c14e0660b80935--
