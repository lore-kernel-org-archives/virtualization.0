Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7881F5438;
	Tue, 21 Jan 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478818; cv=none; b=eqjGUFjB4MqVqnOWfyeKij8bm7yvEDq/H7PC5lwhS9OZ3iXcI2ENuQkwtY9gWMPdH/FdQ634SczUIvycRSdCKhCj2JfKkCHP2KS/8gHxlLBl/np4Ymex8HvtSD3pvfNHCj/0mM6vuNLRUeO3kfc/HV4Vcf8F6CZ9FeFJ202YXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478818; c=relaxed/simple;
	bh=9OS+xRmfz4uuv2J1YGJZ++S2O40MMdmWQmSQIuypaCI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsdgaWBOr1RMTKBeeh3opUfhcv+3ANDvOOOOZwL7SiUEgj+lL6OagaZnsw8fxGz+vy7JlPDdVEKoSsJaUJy2WtsjrX+qffjT8PqNt3XT7aFFASc7g2BeZY9vzV4xXmmb+g5slUlMh3Er3f9ghusMMvksGJ3rVt0iiO9xtOLlt8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmu8Pt60; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmu8Pt60"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5426fcb3c69so4719867e87.3;
        Tue, 21 Jan 2025 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737478814; x=1738083614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6O7kZyVX02YaNVvlK+AnjIGslDTljYFtI1mm3L3G+es=;
        b=Cmu8Pt60s44Qleln3NTiLnwXiErIMyNJc8f2IrDzsk786zvr/uPspLfDSr5erEEMZH
         u6TzsUhSNd/rFIaxvTpF5tqOptDy2odzQwq0pRv7jNvL/kFxa3L8VPaG200e//Tit3i3
         Z1bFMLVZOjH/fof27ad9A1tCzqZmFmfGrcAeL8wXj6igvfkfIfEpBU++qhCsla6iH1WY
         wW1GNAW6tzC5HGTgFxk5WY50QHJVnv8oAm9IkoXLJW/FOkT42ofkNt3bX7amVNPD9gw1
         6/JryYCb8+bzfpGb8AihQ7xFshkdOGJzeWSNasaUlDqwtYxOMGDJ5GUDAnpVH+d1VajX
         RsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737478814; x=1738083614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O7kZyVX02YaNVvlK+AnjIGslDTljYFtI1mm3L3G+es=;
        b=cF5AsKB6IJo3EjWcIN5pREOALFkB0FPPxIU9kUf2SYAvANZyBViludszLwWYY7SNXF
         yTbgDH1iYSJVPME7VFrulkml2K4U3bw5DjfMVypUyBfanHLOUJ2SJv1DQu1ykZNNssmn
         qJNgSSurvWzDHy07kiJneGi31WozSKgP8ma3eg94iNo3RvOpcqnYLBos+vzDHloxDyr2
         o92e7oJxW3E8S6YeAO+GzO8X6d3PtasUBgq1t34znzgpxNwruNInxPaYOFQZt2QJippt
         um9hBCfdKWihBzGN88f/pd4PUhMHNVHaS+goAge2q2zjyPaxRnURbwS3Hr0NrujkChgD
         hOCg==
X-Forwarded-Encrypted: i=1; AJvYcCVa4o5GWjFoX9OyojcC4VpfoWKbQendAKJeyFlJQ8PnKKBlwOSyjg1zRfxVusPj6J4oxhsEt5zU+AE=@lists.linux.dev, AJvYcCX4ElV4/lBHKUdfVnxjBQZYfyuBL5nV6mApnGadnp3M/pro5RWUJo5cqnxzFgKIoLNh7g01iEwHGDxmUpgp4sU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyR+1E3lKqI9OkzNi7MbHn3l70WLaIRtXgN3ipSbvmFdFwtni61
	sEEjA+dXW5hTxFWVrDawJczTiJdblzx16f8mtC8lq7idhbkiPTqC
X-Gm-Gg: ASbGncv3XSnplVnCr0XshpPChkmscwLm2Uu3jELcUFpkMA/3xIxUUOhL7Zj7K/6GifC
	nym3i+cglCBc2KNWeQo5RYl5H4oOP41xFLfBx8KbgeVKrXDDbEBpfNj6AG8ZCK3blWUGWyertQ/
	FgrbAg1pq7eFg9ix/ZbbF6H4UALpCIWH1MtvI+AWyqTcVjcFCMqhgzrbZdJLjTWo7h96gFZrEmw
	qOmM3OE/vO2h5Qb1DyHBa5BecEiRrfN9OM+9Dp9MiXMELNSJD2FjZiFIRZo9h2pSYRPPLX8XmWJ
	W1hFJw1FkZAzuQX602kzfgmQ
X-Google-Smtp-Source: AGHT+IGYPF71D1RmaKnbW82c+U5IMmpDPZJTk/HJCRRaq5z7S90tH0rTVzhA6Sl8Kwc0O/33Vf8jgg==
X-Received: by 2002:a05:6512:104b:b0:543:9b0f:7d39 with SMTP id 2adb3069b0e04-5439c282920mr7151519e87.32.1737478813837;
        Tue, 21 Jan 2025 09:00:13 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af76fe9sm1916768e87.212.2025.01.21.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:00:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 21 Jan 2025 18:00:07 +0100
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
Message-ID: <Z4_Sl-zu7GprkbaL@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

> >
> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
> >
> 
> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
> single userspace application that will never enter the kernel, unless
> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
> 
> Increasing the lazy threshold would unfortunately only delay the
> interference - housekeeping CPUs are free to run whatever, and so they will
> eventually cause the lazy threshold to be hit and IPI all the CPUs,
> including the isolated/NOHZ_FULL ones.
> 
Do you have any testing results for your workload? I mean how much
potentially we can allocate. Again, maybe it is just enough to back
and once per-hour offload it.

Apart of that how critical IPIing CPUs affect your workloads?

> I was thinking maybe we could subdivide the vmap space into two regions
> with their own thresholds, but a task may allocate/vmap stuff while on a HK
> CPU and be moved to an isolated CPU afterwards, and also I still don't have
> any strong guarantee about what accesses an isolated CPU can do in its
> early entry code :(
> 
I agree this is not worth to play with a vmap space in terms of splitting it.

Sorry for later answer and thank you!

--
Uladzislau Rezki
