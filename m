Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA71A23AC
	for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134131; cv=none; b=ThMwEN6yhLDztkUHAHynxfJDVLeZ6q9N+VlknZFJ9Y413CSpXydShqkAx2K39KBN97tBsz2zxLM+T47TP2TBiiok6FPGzXT6BskADYIC0s4pWZX5rxcJnbF8txREMw5Gj5HJZ0aHxquSn03LoNrK30IQeuJdnfjXmSaQOi/i2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134131; c=relaxed/simple;
	bh=0MFya64nSwrKA4zsNtkUtWH4IKaadp8mDbPpC2PlrFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A1Ixuwt+py2iDQZZZQX8ZmBdxOZgyVFqJgSdekIhW2y2gb2Rc/X8T4qq47ySVrh2l6RQZ8WhTW4+4TiQjfsE6ArXOgvMWPwO37neTUvcC1ms6ACNnt+A2F016HUJDwxrgz3remgJYDicD4kIOPGT27gUf0uiPXLgJFv/nUMdaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18Z4f+W9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18Z4f+W9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2178115051dso44450935ad.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737134129; x=1737738929; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcx17eniD+ASjh3teIfjrJN/d55a+1SMCIjE05N6Y0=;
        b=18Z4f+W92hjQtxbo71KFtykOgNC/nSIyiBuOg6pSBGeK+fiP+YhW1A+bcaS70mKsUI
         oPySjg30DB7ZJHfzznXKfTZIRsJrL/izZB2JqI2YFdd6w+dNwZlfVsiS39MYZn+ibAjJ
         8/yQITZubxofplNLXHmBgg/i5w5aK86iI+0d9OMcBuXUscwKdB/NltlDjGEmfuxGUsV0
         +i3GkIvF9LJRHYV/2hotkd4b6nY7wLnEh6OYZRp3Yv7CcWXUcdmAWI3bqd3YqzuepUXu
         WHQd7Ia/0lcDfUxd9Dfkk6t+23VF4PSZ0VorTNuVlsoaF8nQMqNzyRRibXdCa2HHq4Zs
         ue7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737134129; x=1737738929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcx17eniD+ASjh3teIfjrJN/d55a+1SMCIjE05N6Y0=;
        b=kkwPmwPFX3GMCULU/mojoFx+XvdDjtzEmEcdLQ15AJfTdpjqLkcoigmbA01swJktWJ
         o5gruWDYmiZQz33MG28KoScNgfJwyumz2LY1U0MXw3DQMBFNlmms7GCV8ggs/N1JfLN9
         aMTgQSJ+v09bRKngdkOHJ1OCNrVEUWWS3X/VyyNCqSodmC4aBpSI9xGTDBWwdBxV4fsa
         a86GYb4IldW0gKqcvdOao+6bjB/m+vqXXlPShG/xV6wUl/VRANl5D9+xGsEeRFIM0V4b
         njPq6jvfnGIhf2/uAx8R8+oLfqXArFc3zRy4z5sUFB6XlCeWzZxSXhTLvIaZbpNDn53/
         gdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr9FJn1qiFxF5sxX/RgiDKHLcocP+u/S+uVkam8T8pXC0DNibXCsM0YomgWBupTWwgnAYLNExfk5aDk8PUAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/2tnkrSLC5+wbGtfJ4TgUTJwB5fnUWr43QRe8g77C0P/WH180
	bfwD36uQC4iXQReUlSxQrXNUOSk0N8BuET1FIaS1lbDORPhrbQyIehNs29iuNFOVS5ag+enzOKM
	GgQ==
X-Google-Smtp-Source: AGHT+IFBt8EUJmCBrYJSR6SbgIXxnZj6fm10TNGjaAj4XRK+x0dRIzGirCE9VGAaKkDPtl0zEYTqCFRnILs=
X-Received: from pfbcv2.prod.google.com ([2002:a05:6a00:44c2:b0:725:a760:4c72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:148d:b0:725:eb85:f802
 with SMTP id d2e1a72fcca58-72daf930e3cmr5815077b3a.2.1737134128872; Fri, 17
 Jan 2025 09:15:28 -0800 (PST)
Date: Fri, 17 Jan 2025 09:15:27 -0800
In-Reply-To: <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com> <xhsmhed11hiuy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Message-ID: <Z4qQL89GZ_gk0vpu@google.com>
Subject: Re: [PATCH v4 25/30] context_tracking,x86: Defer kernel text patching IPIs
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 17, 2025, Valentin Schneider wrote:
> On 14/01/25 13:13, Sean Christopherson wrote:
> > On Tue, Jan 14, 2025, Valentin Schneider wrote:
> >> +/**
> >> + * is_kernel_noinstr_text - checks if the pointer address is located in the
> >> + *                    .noinstr section
> >> + *
> >> + * @addr: address to check
> >> + *
> >> + * Returns: true if the address is located in .noinstr, false otherwise.
> >> + */
> >> +static inline bool is_kernel_noinstr_text(unsigned long addr)
> >> +{
> >> +	return addr >= (unsigned long)__noinstr_text_start &&
> >> +	       addr < (unsigned long)__noinstr_text_end;
> >> +}
> >
> > This doesn't do the right thing for modules, which matters because KVM can be
> > built as a module on x86, and because context tracking understands transitions
> > to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
> > being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
> > or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
> > patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
> > use the wrong static path.
> 
> AFAICT guest_state_{enter,exit}_irqoff() are only used in noinstr functions
> and thus such a static key usage should at the very least be caught and
> warned about by objtool - when this isn't built as a module.

That doesn't magically do the right thing though.  If KVM is built as a module,
is_kernel_noinstr_text() will get false negatives even for static keys/branches
that are annotaed as NOINSTR.
