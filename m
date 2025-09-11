Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6D29B781;
	Thu, 11 Sep 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576922; cv=none; b=ryWQlvw3eduxJW18V6f/cfLKBYNELI+KC2Qm2IhUyfk/2Jw/OuLt/cBao7AhGiSpiUczEgoi0yoRb9x6kx/w4JGqgbdLsqQNW7pgvOZbJDX3WO4iJHcQomq6vyAX47SGsmuaAuH4guP97/UlvHTEu+MIKPoj3dtKdQRM5kpG/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576922; c=relaxed/simple;
	bh=jbEyhSiC8FqnzGUnmdJ4vWD227e0EMZTC6+/lryewqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slhypd3oSzeeygvrITtaqhUADw0ISeO2Q3HgWnOVukHlx69tC9aZGPiY/gMxNW2gHzyG/Y36lKyQBaUb0AF8QqnLrhYctFR+8uIGXALOD6UPG/IWFSPnd6GhFdpwiOW9KwNYRm167bJiIPkakAIpbzvkZDTCwMvtJfZzfLX12rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rVrDSFK0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVrDSFK0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U+zkD5dacXBFakf/sW3Py81BzX7lYGPL/ab+J9kqcdg=; b=rVrDSFK0bpnhi1r1s83os8o7QQ
	XayC14Rrw5fJaPANeMNniOrj8N2qlmXZE8oUJBQvG5kSAFrlNf0KMvYQRq0gk7u/1f3wItoWc/zSx
	gMRY+yKQ4sBjLvyySadOCkXFheZQ+DVX5dcy+Kawt4/VDIAADK8mtsP0tEVBlVeM6n5nliW9J5by5
	qcxvNNuHTHH3MFrkCcD3e1F5nHscsfjsTcYJksi3IX2HuJ8nFMSKL67BI8jxt/ELGL2WX0z4ME16L
	/SA7AkX24vu99JNGByq6XvVm5ZTsSUxhQ+ASMeIgwxmdEKvg7dsn3+Ahm1ViJVrCJYH4ibFHmaxtg
	rAsWgZlg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwc2T-00000006tc7-2uQY;
	Thu, 11 Sep 2025 07:48:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 455AE3002EB; Thu, 11 Sep 2025 09:48:17 +0200 (CEST)
Date: Thu, 11 Sep 2025 09:48:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 00/14] paravirt: cleanup and reorg
Message-ID: <20250911074817.GX3245006@noisy.programming.kicks-ass.net>
References: <20250911063433.13783-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911063433.13783-1-jgross@suse.com>

On Thu, Sep 11, 2025 at 08:34:19AM +0200, Juergen Gross wrote:
> Some cleanups and reorg of paravirt code and headers:
> 
> - The first 2 patches should be not controversial at all, as they
>   remove just some no longer needed #include and struct forward
>   declarations.
> 
> - The 3rd patch is removing CONFIG_PARAVIRT_DEBUG, which IMO has
>   no real value, as it just changes a crash to a BUG() (the stack
>   trace will basically be the same). As the maintainer of the main
>   paravirt user (Xen) I have never seen this crash/BUG() to happen.
> 
> - The 4th patch is just a movement of code.
> 
> - I don't know for what reason asm/paravirt_api_clock.h was added,
>   as all archs supporting it do it exactly in the same way. Patch
>   5 is removing it.
> 
> - Patches 6-12 are streamlining the paravirt clock interfaces by
>   using a common implementation across architectures where possible
>   and by moving the related code into common sched code, as this is
>   where it should live.
> 
> - Patches 13+14 are more like RFC material: patch 13 is doing some
>   preparation work to enable patch 14 to move all spinlock related
>   paravirt functions into qspinlock.h. If this approach is accepted,
>   I'd like to continue with this work by moving most (or all?)
>   paravirt functions from paravirt.h into the headers where their
>   native counterparts are defined. This is meant to keep the native
>   and paravirt function definitions together in one place and
>   hopefully to be able to reduce the include hell with paravirt.
> 
> Juergen Gross (14):
>   x86/paravirt: remove not needed includes of paravirt.h
>   x86/paravirt: remove some unneeded struct declarations
>   x86/paravirt: remove PARAVIRT_DEBUG config option
>   x86/paravirt: move thunk macros to paravirt_types.h
>   paravirt: remove asm/paravirt_api_clock.h
>   sched: move clock related paravirt code to kernel/sched
>   arm/paravirt: use common code for paravirt_steal_clock()
>   arm64/paravirt: use common code for paravirt_steal_clock()
>   loongarch/paravirt: use common code for paravirt_steal_clock()
>   riscv/paravirt: use common code for paravirt_steal_clock()
>   x86/paravirt: use common code for paravirt_steal_clock()
>   x86/paravirt: move paravirt_sched_clock() related code into tsc.c
>   x86/paravirt: allow pv-calls outside paravirt.h
>   x86/pvlocks: move paravirt spinlock functions into qspinlock.h

With the note that tip typically likes a capital after the prefix, like:

  x86/paravirt: Remove unneeded includes of paravirt.h

For 1-12:

  Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


Now, as to the last two, I'm not sure. Leaking those macros out of PV
isn't particularly nice, then again, not the end of the world either.
Just not sure.
