Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9E4503FA
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979028; cv=none; b=faPAxKOttEaBcpqJhfvoEF7FeOIzOJFePzwmqS3Ps62GKj6jIt4S+He3uR4aTwWrAJybaxARx8TIslK3tmVIRGgAj6huA0xwh7oFiGms2IhY5eJvvLILMHABs9cVKUS8BLnkv13B6aOkhV0zAIrCRAQ99vbq0BCYeKxFmBaYO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979028; c=relaxed/simple;
	bh=xcjHNliDAAlJxE4i6y1GMT1/Vnv55RTh/tAGPwCPNZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfrJvmYagfdMOprqWrsdK/2tnurbJ124WEt8onExRY3auJvA+k5jhXbAOJrbcYsDobn4qrsqa8npQnMwD5PrbAZ9RrM4MQQJUz0D8Nphnk7rU3OGIzPc8+75bufnsiePBWTiCBkVvX5GnYidiBxtIgkwgerA3GiWKMIwb1hMbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g6R2pyQs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g6R2pyQs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so19629825e9.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789979023; x=1790583823; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVkcwRd6JhJoKhW863CUio5f3wgxadePOqahgAJN2pE=;
        b=g6R2pyQs2rAn+XgFDFpV/4j523oPRKCUWOIMSDp781awx7fAiVP6qtxZCRixHRzbJr
         keKHhCbCJqbgvI0oRTlIPlpCrevVPkxDdaZiMw1nyevCHK+n5H0sPglpl/7NMAU9+vvw
         2CVjfTtTXyOzy6FUWVIWhhSJoCAi6skpggXiPasA3qlBVoe4rc0vQXxL20fUdUHbNoJV
         UnWkrP9vxAw9dMH1pcRdQwJiiCn3MX4ejYgswE8JLUGnVF9iNHVh+dxeyllgvXMG0XEW
         t1frDKQ06F3gObXgZCvZZznMDj+PzF64VxQDbtn4WWmUG8y0/8FEcEXLlziyxBGmuwFW
         i+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979023; x=1790583823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qVkcwRd6JhJoKhW863CUio5f3wgxadePOqahgAJN2pE=;
        b=JO7HQzrLhgqFMsiFoFLvlZFPU9nUqdpf77MrDkCStSoUuu4k1HlA4n7yieUxVblxbT
         v93DUdnWGToWAVP+OUXUaz+G00Z67iHoyyH+6J7RBODhREI+CelQV4WHZ9BEkbiroN6B
         AhjLkoBLMHDKjHrvxGoooIuBbFOs+o5v2T6sIlQ6od6VTkT50lrOMjDYxtaIFGHRjOA3
         1EY9m0FeuvEL/3sp26TGW1B8r3MnybGBVRr73ej26JJsJgRHghctGP0za8J6GaH93CMB
         +r9RHvjex/9yeWK1Y0T43mtHJZQTFXm4qs1hpHwgd9Fe3SkMfl7s/LM836ltcOOIf3Af
         vbcQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6uBiPHNqsKb0mmpiCE4q03uwQ8vZt/l7h6W0FCo8YKigPm0tzO3Kocxa+92wCgvZoDriP6rRadc4jui1isg==@lists.linux.dev
X-Gm-Message-State: AFuF++k3V3TVygia0FZ6IoU/QMhBOAddIDEJgQkLCpFHYaYkB+W5cBx6
	R/Mf4H/1FT5+D8LhLpMXqa8sPoSbMrbpPANNPGqkXz1G12CoNfCN2Oj7dox+LIK6Ddg=
X-Gm-Gg: AYBFou3PL8cl0hnwcslytm//FLfJPbMjhr4/xEgtUiRMPiMEePuNphhMalbXQe6w+93
	sizX+sFUTjvDGNS6LHuD5FoMhmIUDYe1Af4h5Y8NoGOuKEqdVo5UwB3q1NYKE/5bpN0ojbxrL50
	Hdevnw4JDBTC9lhC/2kLntDYBAljl8scXAbgyWOJFLn/jo/qM6UeKQ0mqUq9iZ1id8m1vSpHQit
	pDlVbCa6I+4UfOrxzQ561kgT6CnlDQtGwTWDyb3NXB1ivq5DK2tUKMKxQu5AXpilQfTMr4qJc1O
	Wc8XGSijfoaS+oJR4E93/GtXuwIWYq9MlEJfboY3ug7t7oUMDVXsWV4mAEfHsY5D0QMNpU6afSR
	9/HEdegq1rSXB9mf3ZxCnFQ8VOIlvfRTTMdQULzQNmIV2wIZ312K7yz7S0oGLNDPggtKCNXGu12
	8S2E71/oskwx/p/KR2OQVYIvKUtwJcCh3Iri7ALgeGhz4N6mfHMnhK+MNxwx9pz7c+1JGfYdK+J
	Q==
X-Received: by 2002:a05:600c:4e14:b0:49e:7cfc:a9b7 with SMTP id 5b1f17b1804b1-49fc5735f17mr121597825e9.18.1789979023335;
        Mon, 21 Sep 2026 01:23:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm582435985e9.4.2026.09.21.01.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:23:42 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:23:40 +0200
From: Petr Mladek <pmladek@suse.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Message-ID: <arDpjCVbUFcdwq1A@pathway.suse.cz>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
 <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
 <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABQX2QMDNHcKotEa_t9Y37L+uHhV-CfqSR2vcRpNT1c2O9C_2Q@mail.gmail.com>

On Fri 2026-09-18 19:00:13, Zack Rusin wrote:
> On Fri, Sep 18, 2026 at 10:26 AM Guilherme G. Piccoli
> <gpiccoli@igalia.com> wrote:
> >
> > Hi Petr, Zack - thanks for CCing me!
> > Some comments below:
> 
> Hi, Guilherme.
> 
> Thanks for looking at this and for adding Stephen. I'll keep you both copied.
> 
> > On 18/09/2026 00:23, Zack Rusin wrote:
> > >> [...]
> > >> Maybe, we should start with something simple, and introduce
> > >> one more panic notifier as a start. It might be called either:
> > >>
> > >>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
> > >>     seems to be primary set on hypervisors.
> > >>
> > >> But I would rather make it more generic and call it
> > >>
> > >>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
> > >>     more notifiers which are either 100% safe and useful or are worth
> > >>     the risk before calling crash dump.
> > >>
> > >> We could put there x86/vmware notifiers as a start. And we could later
> > >> move there other important notifiers.
> > >>
> > >> How does that sound, please?
> > >
> >
> > It's a good idea, IMO. We could start with this, Zach commented some
> > implementation details below...and after it gets merged, we could move
> > other hypervisors that currently set "crash_kexec_post_notifiers" to
> > this list and eventually, unexport this symbol. We should avoid having
> > code forcing this parameter, as Petr said, many notifiers are executed
> > if that is set.
> 
> Agreed. The v2 I'm working on drops VMware's assignment to
> crash_kexec_post_notifiers and leaves the existing setting unchanged.
> 
> > (I'm CCing Stephen Brennan here, I recall he had problems with this
> > being auto-set, we talked about that in the panic notifiers big
> > discussions in the past heh)
> >
> > The only thing I'd like to suggest: I think we should have a parameter
> > that disables running this list, which would be the opposite of
> > "crash_kexec_post_notifiers".
> >
> > I would implement it as something like: "postpone_pre_kexec_notifiers"
> > or something like that. The parameter would basically "move" this list
> > execution to the same time as the current notifiers, gating them to
> > "crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
> > failures maybe related to the "early" notifiers. WDYT?
> 
> I'm happy to add that as a separate patch if Petr agrees. With it set,
> the new list would follow ordinary panic-notifier ordering relative to
> kdump: it would run before a successful transition only when
> crash_kexec_post_notifiers is also set. If panic reaches the late
> site, the list would remain eligible to run there. I'd keep that site
> after sys_info() and before the kmsg dumpers so the log includes the
> additional notifier and panic_print output available at that point.
> 
> I've called it panic_pre_kdump_postpone after the list, but I'm fine
> with whatever name you and Petr prefer.

I do not have strong opinion whether we need the new parameter. It is rather
a call for kexec/crash_dump maintainers.

But if we added it, we should make it clear that it is intended for
debugging of kexec/crash_dump failures. And that it might prevent
correct handling of the crash on hypervisors side.

> > > [...]
> > > I think that without that default though, x86 oops_end() can enter
> > > crash_kexec(regs) before reaching panic(), for example with
> > > panic_on_oops=1. To cover that path too, I'd call the chain from
> > > __crash_kexec() after the image check and register capture, under the
> > > existing kexec lock. A second call in vpanic(), immediately before
> > > kmsg_dump_desc(), would cover the fallback path. And I think a
> > > set-once guard would prevent duplicate or recursive dispatch.
> > >
> >
> > Regarding this, 2 things:
> >
> > a) I think you could change kexec_should_crash() to "return 0" also in
> > case the new list is set to run, the same is done currently for
> > "crash_kexec_post_notifiers". Makes sense?

Honestly, it does not make sense to me ;-) My understanding is
that the new list would allow to run kexec/crash_dump a safe
way under a hypervisor. So, it should be safe to do it
directly in oops_end().

> I'd prefer to leave kexec_should_crash() unchanged. The direct oops
> path supplies the exception registers to crash_kexec(regs), while
> routing it through panic() would capture later state instead. In my
> early v2 tests, the vmcores from the direct-oops path retain the
> original fault registers in the crash notes. Some crash callers, for
> example uv_nmi_kdump(), also bypass kexec_should_crash(). Calling the
> chain from __crash_kexec() after register capture covers those paths
> without changing their routing, and the shared once-only guard
> prevents duplicate or recursive dispatch.

Makes sense to me.

> > b) Well, does this whole panic diag thing you're implementing here aims
> > only at x86 guests ? Or would it be possible to run, for example, arm64
> > guests? Asking this because in x86 and some other architectures (but not
> > arm64[0]), it's possible to override machine_crash_shutdown() handler,
> > and run things prior to a kexec. Take a look on how Hyper-V does that on
> > arch/x86 - this could be just what you need, except if you plan to have
> > it for all architectures heh
> 
> I'd like to support arm64 guests in the near future, but I figured
> especially for review sake to limit our client in this series to x86.
> So I prefer the common chain Petr proposed: as the thread you linked
> shows, arm64 deliberately has no such override, and the chain gives
> other clients a place to migrate away from forcing
> crash_kexec_post_notifiers.

Sounds good to me. Let's start simple. ;-)

Best Regards,
Petr
