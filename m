Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20820145B2E
	for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737732457; cv=none; b=rQz2jQWIF26UDDnbAZW9PFNAyiYU0z9LkzSuBF4QO8PhlUBhEgr2jn/0lSNB5dj0Lt43jdBdnf9hgeaiCjrqq2nJmfWxe3tNphtJf6yBqIUoOLvWS+aobTiFrAWjkeDIWFjR00WbuEsZSpg9U2zEU+IUV8qlGtSY3nQgHEvdVzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737732457; c=relaxed/simple;
	bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=coWfW2rBObOP++61nebWuwXpHcVyWCcp5gtarPdz0NU0qBuVPps+bIn8Br4H5hZcDKaV+Wh6S/PKo5uY168oCeufMNXMWjKEscKsEr7nijX6PZWuYExysTfxsmWkIkTYF5eDcvAu/XuVcL17jel6idQZGKBMaOa2pgBIN318EXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PafF1Zi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PafF1Zi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737732455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
	b=PafF1Zi3wWoBkHRhQHBFPnndJ0BZkYhAlBkc/xNo+drUcKREqu8DcjK1Rn6cfBy4eO1GVN
	yl4a/v7w7Lxgbe7XTGhuMdmtc45sdky04U9q8/eyq1FHhlQOy3GOMK6/NAwvu45Hj41koU
	mZvqVdUZkMiEuoYNrQK2BQ0wBo5MiUI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-opfu6CE5M0iLHjcYMkxMVg-1; Fri, 24 Jan 2025 10:27:34 -0500
X-MC-Unique: opfu6CE5M0iLHjcYMkxMVg-1
X-Mimecast-MFC-AGG-ID: opfu6CE5M0iLHjcYMkxMVg
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d88ccf14aeso35586126d6.1
        for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 07:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737732153; x=1738336953;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DwitzjRGQEzgyZZn0UD4LNiBUZsqGx1Qrum3CBb5LtE=;
        b=rbus2J+yLlS/5jNgrn4t3zGJMjb/NAFUdbaefrg2km640CyBAEkfGP1P7eD0nhSuTX
         XpUSDmBhfzytBkVCNRtXghzkrh6GqIy8eITUywjY0mq6VBtPjPTTDtSaQJ92gohoLMbZ
         zr5g2EfoLi0vim0vh5xV8sOecwDiCcwp1g7MMs0YDWbQWp4Mw3AuCmh9AV6IGe45c8jo
         d+3YZeI9u6ulWYjF0uuuZclhVz4vu97V4llAcCVBpFJHxxS2xmf6IZh9bkoBC8hIxqD7
         W7TCMvYSSZMGYHVvAoCqK7ln3/2I0MTCZkpc51sJmPi0zgVbHEDmH1phkHyMvFDmf+5A
         5vow==
X-Forwarded-Encrypted: i=1; AJvYcCUBfO/UzRNFN4daSTGtCDKrPOVfbtYM9i6IQOVooM1kCSayiSrD7iQx+xekyNROljnrno4ERCi0Haes3sTcVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJUAXQX98Ty5UXdNh94t1NjRzX0924gmQcsVGOkw79e0k/HppS
	BJkZ12akEVvv2+Li3eWHm8fYkMMyqZ1PhTmnxtasEPxMqBGb8Jr6Ph0oHwKZBEDPmi/mtMF88nS
	fUrERkq7+BPSekNSfxJqJInL0cumX5OCrqrpGl4nk01xzod9MRa7Ai3N2G3Gb/UCx
X-Gm-Gg: ASbGnctAwRGecE9jixegfknjRv5himSunXvlHv5c2WKaF9uwR6maG9J3fjsVVazpkEZ
	1Wi2ZeT/ND6IiDxCQhR0YtqJmpL4RuxYsXYNA/RDGp92kv0Vy3GvVSySGSZPiNRB8Ux5Xc8yiwb
	2pZLQp7mpUVzCHQnisoaT39Hy7A0O35azbf1+Q0aAas+SBWtGFQCY06j/wdsRzOMCdbXOackOwX
	9J0/F06++a7VBShobOiT9935RSscwC2mOrYw0XQ3rbRdUmoYB0hgFrUINfstaHfzFs/e15NAFcg
	GapTB3Sz27Ov0TkUS1+tKRQp7aIFygFQgEw7ELlpnKi5QP2W7gK02uE=
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id 6a1803df08f44-6e1b2235c9fmr497774736d6.42.1737732153358;
        Fri, 24 Jan 2025 07:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5TeadQAXYF5iUiWYdZcwN/B3B0GhQEA3OgvrN+YGY06rhpOtkdAXjp93P8gBhIIoKYtqxZQ==
X-Received: by 2002:a05:6214:1302:b0:6d8:861f:adca with SMTP id 6a1803df08f44-6e1b2235c9fmr497773786d6.42.1737732152904;
        Fri, 24 Jan 2025 07:22:32 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c2a51sm9344776d6.109.2025.01.24.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:22:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
 <alexey.amakhalov@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski
 <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Tomas Glozar <tglozar@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Kees Cook <kees@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Shuah
 Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, Nicolas Saenz
 Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Yosry Ahmed <yosryahmed@google.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <Z4_Sl-zu7GprkbaL@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4_Sl-zu7GprkbaL@pc636>
Date: Fri, 24 Jan 2025 16:22:19 +0100
Message-ID: <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rhcSR2-zPUkWbzujNIQLs_Qj7xNA5hpjEJb_h5NLQlM_1737732453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 21/01/25 18:00, Uladzislau Rezki wrote:
>> >
>> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
>> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
>> >
>>
>> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
>> single userspace application that will never enter the kernel, unless
>> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
>>
>> Increasing the lazy threshold would unfortunately only delay the
>> interference - housekeeping CPUs are free to run whatever, and so they will
>> eventually cause the lazy threshold to be hit and IPI all the CPUs,
>> including the isolated/NOHZ_FULL ones.
>>
> Do you have any testing results for your workload? I mean how much
> potentially we can allocate. Again, maybe it is just enough to back
> and once per-hour offload it.
>

Potentially as much as you want... In our Openshift environments, you can
get any sort of container executing on the housekeeping CPUs and they're
free to do pretty much whatever they want. Per CPU isolation they're not
allowed/meant to disturb isolated CPUs, however.

> Apart of that how critical IPIing CPUs affect your workloads?
>

If I'm being pedantic, a single IPI to an isolated CPU breaks the
isolation. If we can't quiesce IPIs to isolated CPUs, then we can't
guarantee that whatever is running on the isolated CPUs is actually
isolated / shielded from third party interference.

