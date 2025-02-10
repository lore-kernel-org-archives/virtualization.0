Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3A24E4A9
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225377; cv=none; b=oVxfnLUJYrrxkBQqN2QBAbakfxrSIzux6duXAfHdiAMaiPHH0mDW+TSe4/DDb+ubCGUpc26njE/l5ng86TRn8GiN09GBi4311HzzkyWNqzQbMh5tH6wf/9kl9WmtEmVP6XkD4lTndttNlKfvLKrdRWLYunTYWC723cc8ARvw9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225377; c=relaxed/simple;
	bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6Nfu8VSCAlVE4W7gyi2cIVys0tfzsAr9MsL9DQgIF4J6EbULm12F9oZYXJQTqqi/2VZis6AFUXEhbPfZPV0z8C/8x54UV2TBG2vIaA1rNka2xYajvW1synGqxiY9NdUJPUAC/vuQlGsfik/p7dFM4VHDizLxG4HemJz1QfRsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ddpvrPTl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ddpvrPTl"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de6d412ee9so900a12.1
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739225374; x=1739830174; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=ddpvrPTl6OIfebNhBCe54yIF3KRPhYi8hUMsBY9GVXB78k8mnMJfl7ZiDo7+/SXys3
         aqGJhEZFEJgkpaTfBeMMxhPg19WJNXf2EBmxjvc6IgE3kQCOCQuv0fJPXkeHlIJjAjMC
         rk4AN2AxWwB8yRsg1VfJxAs6yxFCQKoekbiNK2/z3yZnC+le75OZ4RvpFTnSoukTjq1L
         VGleor+xw5Jx87bSwHw07zRFn9ykcPAuh/AdW5C4YLM8ZlYk33qrLIR8sgvhisNIfdHM
         0hJzQCMwoN7Xe7rDQYh3uKGBIQi03dDvtQbRUAR8A1Fyt57n6+dvtQ2CnR+A9k/IdLVm
         XqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225374; x=1739830174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44AOn8KPG/5b/gwXWVMZM4o0cSu0C5gCOO/mytEsVzc=;
        b=nszS0p9uFy2itJhNTdJHzZq1LHCVpWyU5xZJH56EufUyILXlR0vkws+uk826GgFHI1
         njnwQQ6u8QcBBzH9ArfepP8yww2cXcnHUAbBAwkZ0fuEF+Diizcee8J+a+a8DMOZ4ldn
         CVcqPd5C18qRuPHVfmau/SGH3kAJdbVznBCNndlGJEEKeY6QsTRvsZSMzSLEE0HTXNj1
         iyXGycQg7tsYJBrrPJK2KAeI3V3zlJRqARo8zHgrXYCOA20yiK9H04shPLZmdtxGnAnk
         X9Z257mizBkKSvq6ks464r/Xpq6G2Sp/DsNlLz6fho6MKLkZtJtmXNtI8iMwl3ACgukw
         1cnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2cT461bEXS97nM60hKzo4xJLUC/cNgQzsu1ZVlXJE84JtHINjFg7DWS+R4itnB6Ajnzb/2wdoLSqRrb9frQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4XSkMAUul5iUg29U2ziN1eg6FujY6iGwUZM08W6C/vou5FKhS
	Tf23c5vApG1pq+p7oSKhIJ8sMpoH3ajmI5h3MXkhC/DaZtPLpEoGScOx59njeZa4Q1i51hsqghV
	xqzIeqKnep5apmowLQXjY7UQoqapshV2oIf+E
X-Gm-Gg: ASbGncueZMA5aaCLxF2+JsiD3pZ6VOEgy/GWnpl99Jpm3CYKFt6SLeftzAecuaLcsiT
	iVE/JwVlaaGiK7ppde6NXT9NMY7jxqg9r5yosaxqerd+9PlQm8GBmqfPcJxBCaSoOrfy8aUVgVf
	Z+xgwiz/A5itvGhilqzFE3Qo8=
X-Google-Smtp-Source: AGHT+IG6JmQxBrqAHiHQy9r7fd0aAn9Heiw/iaJpJbhcsh707Pq8kG+sl2h6STthD8Ujnt3Wdn5OEmJdDMQ5PMlBL9s=
X-Received: by 2002:a50:aa93:0:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5dea05e7838mr1520a12.5.1739225373121; Mon, 10 Feb 2025 14:09:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com> <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Mon, 10 Feb 2025 23:08:55 +0100
X-Gm-Features: AWEUYZmtdNVDV_xq3vvo5TVQ7aaS79EFzdycTCfl72XGpztchND9QHjN9zcxWNo
Message-ID: <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
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

On Mon, Feb 10, 2025 at 7:36=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> What if isolated CPUs unconditionally did a TLBi as late as possible in
> the stack right before returning to userspace? This would mean that upon
> re-entering the kernel, an isolated CPU's TLB wouldn't contain any kernel
> range translation - with the exception of whatever lies between the
> last-minute flush and the actual userspace entry, which should be feasibl=
e
> to vet? Then AFAICT there wouldn't be any work/flush to defer, the IPI
> could be entirely silenced if it targets an isolated CPU.

Two issues with that:

1. I think the "Common not Private" feature Will Deacon referred to is
incompatible with this idea:
<https://developer.arm.com/documentation/101811/0104/Address-spaces/Common-=
not-Private>
says "When the CnP bit is set, the software promises to use the ASIDs
and VMIDs in the same way on all processors, which allows the TLB
entries that are created by one processor to be used by another"

2. It's wrong to assume that TLB entries are only populated for
addresses you access - thanks to speculative execution, you have to
assume that the CPU might be populating random TLB entries all over
the place.
