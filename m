Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8720F090
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889865; cv=none; b=N7dZXZZZvgSopWu9PoJeiFRpHAg5ER6oBI281SgiIf+0hxKUYQ19rzuSDbJEwU1jPaWGup1Q5Dyj9I0w1nRql+YfYC+JDeT/3aKetXWd4MPjsz9R6a1lXfKqdqBHC/xHPny579WEgB53x5wogtBfhpW7SJ6XFSQP7/YGyeBH2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889865; c=relaxed/simple;
	bh=UhsLziMJuir9EcfHw8J9VL7USXU5IkN4Qt5js8SLo28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6TORALnfzaiZ6FNx7skNnmtyRn4cUuEkeyvg3rard6RDMbjN8ARCMrSnbPXy8pI4RSsDR55FC6JJMOY9upviEfcaO8muZhdIH3BIjtqkNQDJQXW5jRyqDhz/v91YL/+JT2oQBkIJ+6ACxv/jduEp+W8Arb2ehucXfI6iR1Vmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnRaMYqk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnRaMYqk"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so10814291a91.2
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736889862; x=1737494662; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSsXdzV+ZwQOEMikMUZ9KmnzJy+D1+up+g+W/Xr/ho=;
        b=KnRaMYqk+rBWhO+fixW6ZIXBLvqPn375bH8KzKgJDt4+34Ir0mHjrKjaj1wvHlx5z3
         IJjJbovZAwL2cqdyj7/W+m80+y6PK5eoKYGdF/WfPXuSRV7uwqITx5MHE1AB3rEYPh1M
         3MnGmBnsuptsOLq1JpRMAlGJ30pGOZFn1Qm9iabtX/L5M7OUF4UoJQwGViGJQ9+A9t1P
         n/xmklLcij/uJ7TFjAOn7+Vrx+YwMfxEoeFvTYEL0yR4RtYCc3YK6vpEobIhikFdWmXH
         kQsRqRF44gCNVJQAbpTWo3f3qRs70FGGiLFQ53MAO1pof26Zo3iGPhkXKBLZaPmNp0v3
         XcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736889862; x=1737494662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cSsXdzV+ZwQOEMikMUZ9KmnzJy+D1+up+g+W/Xr/ho=;
        b=FMCYWRITuEINcHfB43roX9MeR7V71SxCyXW8cB132+ETN/ykxck1ztSDUnkFvIFJMY
         3mQZxgT3FFrIpn/+3Z+zcpEBC1DauRHKNTn4KFyd4qS5Rpx3dN63pcieNrixrk2n/aPJ
         mS90vpRRSTJOAJCv3cXAeuMRssyVlDtQFCvIzaMXmaHr2vRycEbtdOhi3UOwuMI6GZ1x
         VQBiXEsOcgbe3skHdLFYWP1iX3XsiNDf4CtnkWM40z2KyqVQdmhutklsdHGbDZDU9Kg5
         D2NnkLvP+3I458XQyBp51BGVCiSL6WCZWy+vJnlya6pj9RgeawzKaFEY4elBEWzVWmFM
         m7JA==
X-Forwarded-Encrypted: i=1; AJvYcCV0AlZPummlkJdzBwyuJaEo0r38Z866tUIPfs6P/w6zKTaCidHh1EBUjuGbzkSmQWuQ4iktPQkCjv9Usr3v8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YywLwkPE0U1vbPjTO0nFvTNOM/pd5HZckrVeeOaP5Q/kXfXnrVK
	1MsltGVjrZf1CHXj0eDS6XwLIhBd9ug4PaxB2gde5PGmYQY117S388B1HaeHpblvJCgJYZEEgYY
	i2g==
X-Google-Smtp-Source: AGHT+IGaqEwoic7xvDyznY8cDg+F7K5+qe11MRhfXOt+1PBXtCG3HV5nSK8yv8Q3/q/HTXMyOsqLmKxvwkg=
X-Received: from pjbtc8.prod.google.com ([2002:a17:90b:5408:b0:2ef:abba:8bfd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b87:b0:2ee:8031:cdbc
 with SMTP id 98e67ed59e1d1-2f548f1ec3fmr32208440a91.23.1736889862547; Tue, 14
 Jan 2025 13:24:22 -0800 (PST)
Date: Tue, 14 Jan 2025 13:24:21 -0800
In-Reply-To: <20250114175143.81438-28-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-28-vschneid@redhat.com>
Message-ID: <Z4bWBUGUH34qLUt0@google.com>
Subject: Re: [PATCH v4 27/30] x86/tlb: Make __flush_tlb_local() noinstr-compliant
From: Sean Christopherson <seanjc@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
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
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 14, 2025, Valentin Schneider wrote:
> Later patches will require issuing a __flush_tlb_all() from noinstr code.
> This requires making both __flush_tlb_local() and __flush_tlb_global()
> noinstr-compliant.
> 
> For __flush_tlb_local(), xen_flush_tlb() has already been made noinstr, so
> it's just native_flush_tlb_global(), and simply __always_inline'ing
> invalidate_user_asid() gets us there
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---

...

> @@ -1206,7 +1206,7 @@ STATIC_NOPV noinstr void native_flush_tlb_global(void)
>  /*
>   * Flush the entire current user mapping
>   */
> -STATIC_NOPV void native_flush_tlb_local(void)
> +STATIC_NOPV noinstr void native_flush_tlb_local(void)

native_write_cr3() and __native_read_cr3() need to be __always_inline.

vmlinux.o: warning: objtool: native_flush_tlb_local+0x8: call to __native_read_cr3() leaves .noinstr.text section
