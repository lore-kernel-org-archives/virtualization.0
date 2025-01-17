Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563B19C574;
	Fri, 17 Jan 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130301; cv=none; b=UZoE2NfaWNzHv51FUnQwmKO31PBGAL+aIl6kyuDLZtIFBDw+DHuQlquxljuWYH3KcYAAjwGo+lyjSEFrGom/+Wy6LU4K4q+P9d12r4s/zaQagACgAzynOQeF+774QD6asFU6LNBDy9dFEGSEAuzn2taPp88oJ+b3KcEwPP+KB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130301; c=relaxed/simple;
	bh=J+c0tdWpIHr0KlbOLBzEFr0vBExsTwyn4LFfRX4AfIk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsYQEGA4lQ/dnz9J78njIpDzX9CUpxPhk9WMkcEdt6XIoJ1Xj4gSmg7DLx9C2x1qpKRQBbuHJSJWVCu3B23IgX4ry5kAFi8JF5JRzA5gjvhpm8T+5//RhAnsgBsSFFZqhC29GIYTkh3B+fn/2kWmvgUPnLRyUfJ/VMqOj7PvPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svu3CML5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svu3CML5"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-305d840926fso18090621fa.2;
        Fri, 17 Jan 2025 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737130297; x=1737735097; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mwf/8xvajfVfuiw0AKepwMJBFKP0lwWuKM/onBPK6d8=;
        b=Svu3CML5M+UFcgARVFm17ut3/X0W9KsHAul0UckS2nmM6UJ0GiNDF1bZK96SQ2zW0Y
         qRjLA3axRYBWofc2XnBtrbLG4ysAvFjLRwCgoRd1mOe3mZSyMY1RAsZy4hwFKLmTPxAm
         tJT8bThCoFzZyDqgI9wkql3dtfJnZpGYjYzTa0RrTM5botOOVbOFW5aWNvcy491e/FHv
         PKSYorMrDfWicMVQUn9KCL95nU1PQ2nw11pwnAcOs0K4EcYE0QzGZcWyou/pYcZbxgyj
         5vkwEbGobnVihO8uxDum36gTVUMwSMHmlDEXyi+go1yOmLqWQVfPycGJSmhs7itbfauI
         4pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737130297; x=1737735097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwf/8xvajfVfuiw0AKepwMJBFKP0lwWuKM/onBPK6d8=;
        b=DNGtUN9/sVSIOMCb5206KCy7coHK2/x63JwfOuvrOM8sci+NoNZUSeKJvJjwokwoXZ
         aEl6G/9TOG/G+YzaPseu4ONbFppEpnLXlorx/gPdRHLDaBv/2T4bYjxzriSPdnsohQFO
         DuJCjTn7uN9MZ0ZJ0gLDPIa9Zk7b4UPDvC492GaRNOcJL/hhP1E0Kkzm3Ry36H1vuUOY
         Nf8iTpzeSHVED5VhxzGlFgOtEag2eiY4hzwVhsPAPAlK08AGAfDoHESbeyYOcyCOGW/u
         +lm4/QJ5h0UtsKkZyuoCtFF3IvudJqPh+g29ejB+A9C4cxk/UdwDa3DqIevW1Or9UmTr
         lTvA==
X-Forwarded-Encrypted: i=1; AJvYcCUc7bsBg+Aa5gDzhL91aa/EMb50j4vlcJtD1Rb0tpNBPuhGZf1t79fyR82jwt5WrBz2rVYieCziGeQ=@lists.linux.dev, AJvYcCXpNolTPhg6VLwmheQ8X16/WWhqwuS3sdQW2sOOJweO0RuLHYPRI7VyWSqPnz4Jda4PxkgL5t9sDQWYL6Y6DfE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/rsG6Fr+GfXJp3kdfkAtduA5Y3zA+WjyqyDRAVjnKtv7dvP4g
	7xaKkhcIXzPpPM1VPXlHlpFqVzUmTGwCmHoL9uUyRC2SR6+Sr/sX
X-Gm-Gg: ASbGnctrm0PXBiqfaWr/jwUV/cpJDLZTSSV6Z28F2MLnpj6AH2Rmc2ZMJL7EsBytW+H
	nfkkH7e6hW8qQeduAdejuuir10X7R8VOJRITC/Z54tBT4sDNigLSf8JNfloqK71+mOOvhBttz3L
	H4bigK1bVDD7j7Pl5o/C70OGGTTnGWsx7NLsYemDDoVBijISVbdhB0EVMn8IEIBqgtqDeRZhlhA
	LlJgVl4cXpTONM3kHm0uyILJXW6e49XRdnRtsEgg63oR4lDVIPEBxqxEwRzt7StzEREstZyPBCu
	nGxUkjIxDZE=
X-Google-Smtp-Source: AGHT+IFH9kfhzB42dITXdZg9xXnIuIrCtLCGkWK8kDwmfncKlFAzifmDHoUZVUHtKkW5iC7Zz8oHDA==
X-Received: by 2002:a2e:bc27:0:b0:302:40ec:a1b3 with SMTP id 38308e7fff4ca-3072caa166amr12690871fa.21.1737130297134;
        Fri, 17 Jan 2025 08:11:37 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed4bcsm4854351fa.71.2025.01.17.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:11:36 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 17 Jan 2025 17:11:30 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <Z4qBMqcMg16p57av@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
> On 14/01/25 19:16, Jann Horn wrote:
> > On Tue, Jan 14, 2025 at 6:51 PM Valentin Schneider <vschneid@redhat.com> wrote:
> >> vunmap()'s issued from housekeeping CPUs are a relatively common source of
> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
> >> flush_tlb_kernel_range() IPIs.
> >>
> >> Given that CPUs executing in userspace do not access data in the vmalloc
> >> range, these IPIs could be deferred until their next kernel entry.
> >>
> >> Deferral vs early entry danger zone
> >> ===================================
> >>
> >> This requires a guarantee that nothing in the vmalloc range can be vunmap'd
> >> and then accessed in early entry code.
> >
> > In other words, it needs a guarantee that no vmalloc allocations that
> > have been created in the vmalloc region while the CPU was idle can
> > then be accessed during early entry, right?
> 
> I'm not sure if that would be a problem (not an mm expert, please do
> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
> deferred anyway.
> 
> So after vmapping something, I wouldn't expect isolated CPUs to have
> invalid TLB entries for the newly vmapped page.
> 
> However, upon vunmap'ing something, the TLB flush is deferred, and thus
> stale TLB entries can and will remain on isolated CPUs, up until they
> execute the deferred flush themselves (IOW for the entire duration of the
> "danger zone").
> 
> Does that make sense?
> 
Probably i am missing something and need to have a look at your patches,
but how do you guarantee that no-one map same are that you defer for TLB
flushing?

As noted by Jann, we already defer a TLB flushing by backing freed areas
until certain threshold and just after we cross it we do a flush.

--
Uladzislau Rezki
