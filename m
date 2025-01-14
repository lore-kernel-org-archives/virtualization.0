Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48D120E00F
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878644; cv=none; b=KeudzJ2BiwXFfcE5z11eoS+W9VodUb15Qjn1lwawn/XxlwH541UGrh4qw5PRtRwVB5lqc4fSoT1mIkH9IYYO5nooi9GQ0Xok1daov3l8sij3g8lnIUJanODMP+2hJ3V2Pz6xBKqkxJHrBuy7g226vqlslxL1xIlhjHRdFue2MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878644; c=relaxed/simple;
	bh=I0aYHuk99JA9dU0puEhTqa+Ivu5XtOv7dOMzqH0MLLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb1EW0Bqe7JGpl5pdIJUDPANhD5RBFDt0+At5syDS3mVempWlDovHPI+zhyVebvUoSNQoS7Uzt+byuYZodg2KzHrpA0J2l1r6+btbIartdld7eBWvgJf2YK+ukfkkeaSTirDrTX0GuplnY36C3bIXzbRixj+a1ZyjuBTxvsRnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nS+Vup7p; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nS+Vup7p"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d9f0ab2313so10860a12.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736878641; x=1737483441; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0aYHuk99JA9dU0puEhTqa+Ivu5XtOv7dOMzqH0MLLU=;
        b=nS+Vup7pWRvphRTLk5FZWiJ46DL9jFEp+gL1RFC3AlTVrhGqaeZPt8/yFQ5r7tq96q
         BgVz9zF6Hph8Es9jYI7x9k72sCczZxH5asuByF3wDgcimQY+6Xu20pjYnScQVLO59dwM
         SijTi+I5N5jKe47MsGaaRvsJZU1esPOzwzThfDqk6hB9hMVSDciahuzPf2GoGtO2e9Mo
         sYDxMfZUzQwI7tphALpGq/qnooeAvpsV50O55sGOa1u6rzveg623hV7uUI9C7lRWbACU
         40m62D7CP4Jky1QjvMbSWSyVysM0xgd9S8eW8pxmOAU5+WklBhHFCOaPlR3jfq6nwHO0
         /tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736878641; x=1737483441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0aYHuk99JA9dU0puEhTqa+Ivu5XtOv7dOMzqH0MLLU=;
        b=GlfkI8Yx2ZQncaXjKcbuQMX6GIJVx2dTGVDUf4xX0UnRzG7mqhzPMf1dSkGIrTiGg3
         u/KmxAY60mx+rPTFTSWFas7NlE3prGGhh250u6JswTYnH8hLVnfEaFDk/RTXaka3iaQ1
         TcGBPNQbNuJEu+M7IF80s0y4JYoSLjFBeT+fh9GvV9FK94SIcYC6wM/juiEvwm3VNPft
         hFsTY1qAoN9d7bY5dYN1wqir4GaEFIgMJAAwbZ73TllByBUnsEkckR0RfudoZ3t9WDxG
         i9vDjbotoz4Qd/7No7YjZoNpAAF/Pc2eSIHwSRq+UkXYKYVIg0Lie4aWCxLsxZcSs48b
         oc8A==
X-Forwarded-Encrypted: i=1; AJvYcCUjsfddOvjvrxM+qrTUc4ARW7t5vtzPePwCsg+owGKsYIfn8k1aK+IbRjZBefHlWc5dJMka9YGP5oLxjYJ6lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyb3e4oHe+zpcCNCxTp3tLpOtpq8nqO2m4vCvtlpjxHhtdr0gzz
	6kHXRP3MsEPLZ4NVibQ7+JrMvXDe0IHWYkW+o2lbsow7fynVVAR+HRHTykfW0/1xv3+7oZsQCq7
	6goITibKFyS+sR3Kyyy4Pv6y+pyUZfpdrGezy
X-Gm-Gg: ASbGncsBhsTxjHcr36sElI5RlTKnT9hucjr6MjYS7em/+tK28ewpC6wfeBE2uO+VCfQ
	vJ5I0yRTjeFLiMWbrIbgxtwvS8c5KO5qSWHsHJKd/eRaCbcqLnteYUk3WkA0s2+KVnQ==
X-Google-Smtp-Source: AGHT+IFOWOuSvDhgzEqoKb2CNkVmA/sXHofQ9hZDfWF+l4vbbQk0RN2k51cQSZIijLzKAw1RUyxlH5Nb9O1wedqOjko=
X-Received: by 2002:a50:d4d2:0:b0:5d1:22e1:7458 with SMTP id
 4fb4d7f45d1cf-5d9f695dda7mr124694a12.4.1736878640478; Tue, 14 Jan 2025
 10:17:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
In-Reply-To: <20250114175143.81438-30-vschneid@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 14 Jan 2025 19:16:44 +0100
X-Gm-Features: AbW1kvY7dNxOnvBqE7JSPz560QoJfBjiwfsZgS18MpZMQ07ZRC1TBr6Zwl5A-60
Message-ID: <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
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
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> vunmap()'s issued from housekeeping CPUs are a relatively common source o=
f
> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> flush_tlb_kernel_range() IPIs.
>
> Given that CPUs executing in userspace do not access data in the vmalloc
> range, these IPIs could be deferred until their next kernel entry.
>
> Deferral vs early entry danger zone
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This requires a guarantee that nothing in the vmalloc range can be vunmap=
'd
> and then accessed in early entry code.

In other words, it needs a guarantee that no vmalloc allocations that
have been created in the vmalloc region while the CPU was idle can
then be accessed during early entry, right?
