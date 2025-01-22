Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805772B9A4
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737507848; cv=none; b=I+HBam6QMrgvbFIT/O2oDYf8KAZUMU1MombvIvciTi1W5yqkySx9NtAhQl5JedrsqhUm8tvp4iuO3XI0wyYCFO+GIy7TT2i4vER3pXv8tLdD4Y6d0ZFQdTB5HmgEzI8CDAXsFFGUDnqYRCpBnLEVazpfrxZG7KqLgltEVf2wSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737507848; c=relaxed/simple;
	bh=fBMEEQrP8cCyPVJBx+8XOjAmMFlhjYXlOqE8udqGu/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trxlSg+AMXByKvfp8GWgW1Vqy98ee7HjDUdg5d1uL/MQwTniaZhiMxpJVMK14kz0kFGkPUL7UKb0Gm0i2CctpoJDOxvA2YNe1inRFZsgdg42NLUPXEYBEAKYPkozUWPwrcvGd3xRPGrVIpOLWYtw8vV3KR1TVdUbA4E5Z7HXBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JrmUZPrP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JrmUZPrP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2178115051dso117163745ad.1
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 17:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737507845; x=1738112645; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGAInSW7+q0vU97QD0HUaaeZu0zheatXMugXZrnQnto=;
        b=JrmUZPrPQ5m9Q1OT2RGCQggsB9293Bxo1Wp/dmt7gjftCkFbhMv3oLbRekfUR3CAGN
         Uzps4br/rezedI1zvSdVsGMtBtvAFfZpXmYQrB4zlKp85K6HgKRL0Hma0cQBeu8jNCKB
         ByRgUt4HmojcakTzKu0zvmtx5lNROVcveoOqoHIYqs+Hq+jmJfG/1BAHl3p7x0YT5LiY
         nif8z1Xq1l9xV4XW5yAjJUC8/24kRZNFerndbYUzF3t21AxRoRVY69zwFFTtj8Fkg/Ld
         aBqb8AS/ZmG4nZgwrrpvXXJTy1ghEe9krRUG0IP9UaiU9yGSDWerjI0S2MGK7fGhPAbS
         OAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737507845; x=1738112645;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HGAInSW7+q0vU97QD0HUaaeZu0zheatXMugXZrnQnto=;
        b=Ww/gFKFQRGqXi8+9IDBISnIvz0NAHKoQxTfXouFxo+51HAKe21lTwnNqcHYK4HPOqY
         J9w8Oo6/rwCuL4Wn/t/3DnmIlP2+ntNIJvrb4fBJx7sC2FE5w/AOh8lMB69Zh50uZPhm
         3pLiqRwuaw6UJZNQsRi+3pecQVqdW7uRdhn1MJJ2o3XAxI6MXKFQyCV3zHl46OqEHJFE
         da4IVib4XE1yV8fxu1fvXyi6Z4mvG/+qNpYBrtLW5VU0gI3mskC8S4ncGteoKoO04pXY
         aJmX9IRHNLiHscJ+Wu1J3XKthAPCD1qIF7DTeouMXVEFpvqv6TtuTLmobv2M4QHKDIl8
         uZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCV7fJn+/S/rjzqNLOxXH3MO3YfSb9z8sDrnsHzulZd/GRbBDwJbFEhcT5cv7bHgGlFFWZ5g9UKJn1329H44yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlV7I54DtLt1fQmOHt85CUZbiIVSvoVGgeNYTsLVrxWF1Rs8JR
	IKR0AqQza0TH0vIupEAnuM5/TjnsyFK+oMzuJ0lpzDt7nZFPJOrkbZPTQ0RMalI7aaPvDPgRkCx
	FrQ==
X-Google-Smtp-Source: AGHT+IH6F+XmsAOl9kzgOVOxBLRRXT62oJJbonrrKhR+qzEndDJ3UWVtcgPMx5PJJKXl4IX7nvimBDDp9aQ=
X-Received: from pfau14.prod.google.com ([2002:a05:6a00:aa8e:b0:72d:b2a2:bed7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6088:b0:72a:a9b5:ed91
 with SMTP id d2e1a72fcca58-72daf99ed03mr26365241b3a.13.1737507845610; Tue, 21
 Jan 2025 17:04:05 -0800 (PST)
Date: Tue, 21 Jan 2025 17:04:04 -0800
In-Reply-To: <Z5A6NPqVGoZ32YsN@pavilion.home>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-23-vschneid@redhat.com>
 <Z5A6NPqVGoZ32YsN@pavilion.home>
Message-ID: <Z5BEBCWVWP_fq2zY@google.com>
Subject: Re: [PATCH v4 22/30] context_tracking: Exit CT_STATE_IDLE upon
 irq/nmi entry
From: Sean Christopherson <seanjc@google.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, 
	Yair Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025, Frederic Weisbecker wrote:
> Le Tue, Jan 14, 2025 at 06:51:35PM +0100, Valentin Schneider a =C3=A9crit=
 :
> > ct_nmi_{enter, exit}() only touches the RCU watching counter and doesn'=
t
> > modify the actual CT state part context_tracking.state. This means that
> > upon receiving an IRQ when idle, the CT_STATE_IDLE->CT_STATE_KERNEL
> > transition only happens in ct_idle_exit().
> >=20
> > One can note that ct_nmi_enter() can only ever be entered with the CT s=
tate
> > as either CT_STATE_KERNEL or CT_STATE_IDLE, as an IRQ/NMI happenning in=
 the
> > CT_STATE_USER or CT_STATE_GUEST states will be routed down to ct_user_e=
xit().
>=20
> Are you sure? An NMI can fire between guest_state_enter_irqoff() and
> __svm_vcpu_run().

Heh, technically, they can't.  On SVM, KVM clears GIF prior to svm_vcpu_ent=
er_exit(),
and restores GIF=3D1 only after it returns.  I.e. NMIs are fully blocked _o=
n SVM_.

VMX unfortunately doesn't provide GIF, and so NMIs can arrive at any time. =
 It's
infeasible for software to prevent them, so we're stuck with that.  [In the=
ory,
KVM could deliberately generate an NMI and not do IRET so that NMIs are blo=
cked,
but that would be beyond crazy].

> And NMIs interrupting userspace don't call enter_from_user_mode(). In fac=
t
> they don't call irqentry_enter_from_user_mode() like regular IRQs but
> irqentry_nmi_enter() instead. Well that's for archs implementing common e=
ntry
> code, I can't speak for the others.
>=20
> Unifying the behaviour between user and idle such that the IRQs/NMIs exit=
 the
> CT_STATE can be interesting but I fear this may not come for free. You wo=
uld
> need to save the old state on IRQ/NMI entry and restore it on exit.
>=20
> Do we really need it?
>=20
> Thanks.
