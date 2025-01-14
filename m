Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A720E709
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890017; cv=none; b=US5c6xtHR5DUiZg/xf8d3lav5H9cb1+db5OOAO/SbXvvl/iflPsOlwNHht54eHWzb5CZOj4tcrnAnEJQz5IwwgNZjHzdj/p1MzhpQexZait0cXr7F+wwKa1uRwP961Ve586sumlqcu0YtL/px67Q1wtjaQg49zNLlWWlYfheoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890017; c=relaxed/simple;
	bh=oPosukRuS5Ny6CBCBgfqsCfB0dNx94vYjIEcmowMxlo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1BSUs70goCLqNCsEEnG2Ptn8lxDpb1yXokwjlZgqqSrEwWs48c6DK4ZSjatQs6xJNRSFhHKLUsZ32yjpcmVTCl6R/VYOzho+vzFQrKB+PXGhJTVKJZCS8D/Q9dHbBI3x2ZSQmnRsrtF6bYW11lwqBbUPKhFCtof8WwRj4kr8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7bGLanc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7bGLanc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eebfd6d065so15458729a91.3
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736890015; x=1737494815; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=P7bGLanctuzOtveWS1UrYK2R3tV/+b7E5j7MJleEu2+l3DjGP4iYWtVYL6AilHF7U4
         fd6OHv+SdPFcSOaISnn9QBZTTUYYeEIeCeJn6zEeESbScveXlGOSmUjSqHPKPGZIUFpg
         s9avpDwXoSmYqukoCDu3Dpwa3IX5nryUMASGZDfhFwSb/t7NJSfhpR9fm6Myq+V+IJrL
         hUJU8HCPHzj9JRd9Q4XQPZJkHtpF5oeF/1vzyPzqDLGKpyicPjsy7rExgXww3FXii0+P
         9UP2bU8Y/fOSfrXdd1+9hrPSI5xtstRI9cCmpdvCAiTv3e0WFg/MvmRWrpAdiOajcoTH
         +2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736890015; x=1737494815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8zpuNawVjToL3i20ZYrbUddkmOaJHAfbCZJnZQ478w=;
        b=j1UhqEFHx9+OiCYvMqMjcVN53nUkI2p6p7tonYvEMbUt0rhdqdrTolbNvEl12AWNKH
         SeQIBwZc3Cl9340XCBDDiR3aYcDEM/mWSMoRlHYdgMXJVjQ7k4h16IpvEa7/gFEbLm1e
         I0X/X23GR81dinWLkntRGT46Dzcr24UUIj8Xx+l2SaO//of3SI/BjHQ7aWL76T4khmdD
         oYpR05qng3ozIitYVJ5iB6whly8Nij8cOlnTMRSQE3jfXDEMnSFZsezt6/zto2IKio53
         6x2gKfUK8mkqzbTSUJr7P+QDFY+kxjY9BrBSh/RJkFqfjUlDpHSe6VFN0l0rVumLj6SY
         +fEg==
X-Forwarded-Encrypted: i=1; AJvYcCVh6w2FAPtXADaTmw7ojFEUiDqi/l7Kied5rosSUcqByCtdC1nQZDYmc7O9bs89r7FhXpQsNhewsQ/1H0jBFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbvvGUTfiQxKFmHkLm85me4tak44NGEdondf3mjR2eMuXzgIuM
	Akx0knM5GC4iU0F+zZGQiilFCDk85nGOay5AL7hgCXmdAw/mngxJBDJPRmJ/14wSN4139i1uSKJ
	CHQ==
X-Google-Smtp-Source: AGHT+IGDv4Ej+tMoSohr/AoTazwT/WbetgA7Nr8qE8BLNxmtc1cUUDk0TRGuDLxFKlrZpHzOjZy+L7iCKdA=
X-Received: from pjbsx15.prod.google.com ([2002:a17:90b:2ccf:b0:2ef:8ef8:2701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:2ee:9902:18b4
 with SMTP id 98e67ed59e1d1-2f548f61fe6mr37131771a91.27.1736890015061; Tue, 14
 Jan 2025 13:26:55 -0800 (PST)
Date: Tue, 14 Jan 2025 13:26:53 -0800
In-Reply-To: <20250114175143.81438-26-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
Message-ID: <Z4bWnWYqu1LaD-JG@google.com>
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

On Tue, Jan 14, 2025, Valentin Schneider wrote:
>  static __always_inline void arch_context_tracking_work(enum ct_work work)
>  {
>  	switch (work) {
> -	case CT_WORK_n:
> -		// Do work...
> +	case CT_WORK_SYNC:
> +		sync_core();

Not your bug, but serialize() needs to be __always_inline.  Not sure what exactly
caused it to be uninlined, but this is the obvious new usage.

vmlinux.o: warning: objtool: __static_call_update_early+0x4e: call to serialize() leaves .noinstr.text section
vmlinux.o: warning: objtool: ct_work_flush+0x69: call to serialize() leaves .noinstr.text section
