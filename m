Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C91FDE06;
	Mon, 27 Jan 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974223; cv=none; b=Bt6emrMAv0A4MWO1+utdB08Nz4+CxmFt9ScHED4NU7oueuQWGQ6R1qDbMZ70To3M5rw/m+uGza/+zMPSpGBZ4INNpCNqGymVJIaCJVWMyPI2dTMircBN5lS7KvtXiXjDdhCMK5/vJd4YptXR332ladh/FWL1/SIE/0HGZrIdy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974223; c=relaxed/simple;
	bh=jxECeMXjdkYPN8Gg6gBfLrTjeCyPn6+e948JqztZKrc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFl9rHEq+kNCgUFMQ8s6ptM0CM+eDhKwDj84bwSCqpBawBkEk7rLyd5Da7v8J6gtc8vNAgVlvXvrmW+YAnGiWBZj9V0lwRY5NRR/oappCawkQVgKoZCV9iCQwzdfYArQ8YzceOVw+HrVs+1Q/75eoMD9vxfsarMj7DU4ARCzCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fi9HymXz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi9HymXz"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-540201cfedbso4142057e87.3;
        Mon, 27 Jan 2025 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737974220; x=1738579020; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4QFE15tzxGQeI7M/zW2nqDheIV1bS+m/FQTTUzpTLk=;
        b=fi9HymXzZ8+4wyzyTmASCA97DFLhqvVT6O1vaqRrnRGFog4SWU9SinBQ4QlAJ9eP3w
         sQv6Wl4c2WaHnoTsI92ipcZLT771xW+vRPy3toqXI4wDL/VcmYI+dZX/9KKaOV0gkGQk
         rQbYdMeFWWRK3/RKfiZjqYA+Kpi2k1YJP19xPxOFcQLB5YybdUev1ve1gjQipg6LoS5X
         5ikX/DZdyvcU5DvpxFG1HSHwuNTNeBnltE0QzJd9x+V2Q4zTq6xjd+Q9uatREQ/j1LNo
         25ntpZ4ejFGBgcVbWq8dJczX7eO19uJOyEtk/TwOpjQuWD9pIdH0YOaoHh83mhGfdwmh
         t/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974220; x=1738579020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4QFE15tzxGQeI7M/zW2nqDheIV1bS+m/FQTTUzpTLk=;
        b=IXFc+r7mbDkA8vhhJ+vPtmqU2WWalRV6w90iXDdnnU4ZRWhbCo5zMwqkhmPlT/OUbY
         Kzdm/X3YTNHWnUixlamZ7ZN1QD+OH5E2l3yZsSJ/9whWSGejx9AvM5mK6eQ3O7BiHepE
         NBS76oP/iJS4y5c0ETlUdX71YGd8AkPg3riIL7RA6RfpZP5Mz2NlZZOpulf6nTRUj4dI
         BIukL20HrEMnGGTCCtrE1W7OBh4LdVEknE8o2Z2JhK2Bj4cJTdJcF8PJbaSBG2PMDIkF
         +Fqj9ivzpp/ocrOEQdxASjrL9tg20W+XojdXrh93zidcpd62NxcVhXJwJ6xg0Nbz5+xb
         rQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUU9bJJUdxYRd4FbbQ0EMNn6GRhKzji6XpeAEhAtRaHR4wON250I14Q9ZnBRfutfdJ5yfB+SftOSn9i2CFSlcE=@lists.linux.dev, AJvYcCUdQgkjpbJ7DzYZViP/DKPIEh23hnZIY431yuilhqaGpeNsSKGCUR+OGz/YNAXf6ndscoZE926kCtY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwgVyWaBWUjdOe6bZN0nNxRg0dJyUdFXovv+YXKFc183Q7C74IH
	2skS/Hhx5nv5AMPzfWzLLCE+YZLIcTKrrZtrzLEDnPAbwWGHy7sa
X-Gm-Gg: ASbGncvlhTjpmm/h0gdt7UN9HBf0jHyMZEW7wMK+fSUXlpzn2AtZNOhTDFFQhZINwcV
	oq69WjlmWjVlk4gvdGRRjdgc7dciJ7j7rmNU5NJbesDCu8FXcKn9/Vvc+NY6Rz8+zRUigVSodnV
	RufXCS7/MQKb9k+WY8jC8Zq9+0bZPbLu9j5cWBP/iYqQ2UalWz43PNo6ItxbgIwJYBLP7wTOYdD
	9OPBU4xd1QHb9579KPmAMJk2EOTqa9dAsXm9hxcaAtxa1BLp/go+oyrO1ioBLdGgG+MuYBq8NfN
	1AqgwsfWJVlrJgUvIznI0zqzmN8aJ1UdCRY=
X-Google-Smtp-Source: AGHT+IEcn2mDT5d0SWT5jg0poO+BtsvQPwWj5ydN+QiFTcCpstqFwzzlc4zIAZ/gMSqSpGuiyMrqQQ==
X-Received: by 2002:a19:8c1d:0:b0:543:baa9:a48a with SMTP id 2adb3069b0e04-543baa9a4bcmr6967602e87.27.1737974219462;
        Mon, 27 Jan 2025 02:36:59 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc1956csm14103761fa.70.2025.01.27.02.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:36:58 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 27 Jan 2025 11:36:51 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
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
Message-ID: <Z5dhw0Ml4KGEfaUv@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4_Sl-zu7GprkbaL@pc636>
 <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh8qr0p784.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Jan 24, 2025 at 04:22:19PM +0100, Valentin Schneider wrote:
> On 21/01/25 18:00, Uladzislau Rezki wrote:
> >> >
> >> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
> >> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
> >> >
> >>
> >> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
> >> single userspace application that will never enter the kernel, unless
> >> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
> >>
> >> Increasing the lazy threshold would unfortunately only delay the
> >> interference - housekeeping CPUs are free to run whatever, and so they will
> >> eventually cause the lazy threshold to be hit and IPI all the CPUs,
> >> including the isolated/NOHZ_FULL ones.
> >>
> > Do you have any testing results for your workload? I mean how much
> > potentially we can allocate. Again, maybe it is just enough to back
> > and once per-hour offload it.
> >
> 
> Potentially as much as you want... In our Openshift environments, you can
> get any sort of container executing on the housekeeping CPUs and they're
> free to do pretty much whatever they want. Per CPU isolation they're not
> allowed/meant to disturb isolated CPUs, however.
> 
> > Apart of that how critical IPIing CPUs affect your workloads?
> >
> 
> If I'm being pedantic, a single IPI to an isolated CPU breaks the
> isolation. If we can't quiesce IPIs to isolated CPUs, then we can't
> guarantee that whatever is running on the isolated CPUs is actually
> isolated / shielded from third party interference.
> 
I see. I thought you are fixing some issue. I do not see a straight
forward way how to remove such "distortion". Probably we can block the
range which we defer for flushing. But it also can be problematic
because of other constraints.

Thanks!

--
Uladzislau Rezki
