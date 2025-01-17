Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620A19E979
	for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133239; cv=none; b=YUKwwbxcar2V3uexfisJgB67VMTILS9nf7VA7Y7MntYPhb2lzrQtA6OnmX7y+lcPpq/Yo8aHGCmt+RGBIm7zlxHEYR64Yy1ms+F154cPAoDWAJft5i1w6pKOaEqh101gcL/u23lD/tuRF4jBUC39ZZIDrNIYFLXSoooLAbjFLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133239; c=relaxed/simple;
	bh=2zB9z7u7dclAVOo2ULVj1p74p7CXPvWK/XjFblVO3P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nv15PkmgmBKSrlM5UtJbv+TWeXahEB7a9JtR6ed0BQyJU6/K3EW7xdxLrKLnWtOp77NzwK/q8si2ZL3yDQFMYdw6RIfiavsVrqzerRp86K3ibgJIzE+PVDOtbXI6x3X+mdQx0MoI49XqFm4fDkKs5ACe0ra95vUMSuE07LM1c4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XnTWdTDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnTWdTDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737133237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zB9z7u7dclAVOo2ULVj1p74p7CXPvWK/XjFblVO3P8=;
	b=XnTWdTDEfozNSXhNWM4vP6dfiTPqEIhPGM045rIVLcdmL4NGUldnh+nOVCppvrcuAI0swS
	BCkWFgfEoKAgBmwv6p+s9DwqRnk4OUmz0+nZ0+k6v3NfvE7Jn8URZ87cfQkK0bF2wtRu7q
	7LuyEFJ/cZS3+Lrc1+qqV5lMdP33kww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-zWkbEDsbNjioibqmEt97aA-1; Fri, 17 Jan 2025 12:00:35 -0500
X-MC-Unique: zWkbEDsbNjioibqmEt97aA-1
X-Mimecast-MFC-AGG-ID: zWkbEDsbNjioibqmEt97aA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436219070b4so11176045e9.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jan 2025 09:00:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133234; x=1737738034;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGvTpyNczRvA62kOrzrUa3TgLdL0aqoCD5BBfkghzOs=;
        b=AH+FSufxSdcdF1ZizFPPTpcdpVaINuJRDPGUCkctb5YCTc0Nu5Eim9kyznGLBA8po7
         Dvicz6d1ZENglgAi+QnCWwVAwAAbRs/PTN7wL2WW+JylZZY8+Bu2c0WFdfv/l1wOqDAK
         ciROxZdK/2Ob+/qINjAuYld3xTuOoA0AG+0yhs4CYfzk5dpERsk1BxN9K54Yp8j0JqOu
         zFxK51ag0CEA74d6i6l20yMCZQsj4ofERp2EQmVLwyOThxVcObo7AMt/hqkC7NHWXaQz
         /loxsR/urCuNRjP+M60iWYsMM+vCW433cp8j1V0yBPERT3pJZzsOzuGPdIRXhIGXuzAz
         dO/g==
X-Forwarded-Encrypted: i=1; AJvYcCW9pnmXxH47tr5F3MedouRzEz6/nNyf9dSjwvlKMC29dF2Gq0XlnSMxjk6xUsopc3I6y7OmC9x5Ax8sUrAp/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5OANk/94Kev4Vkp0jWG/J+zeNVNWPEwLwUNKrGJRuVI8uHh8C
	Ga6UL0C9XiVym1/iFDNCItfXCpMJIg59w6ceTdX0rePWWlxTDY4zGOnhryOsWa/vKXno34N5i2i
	0kO4xi5IL1BWHtPpcxTdJoqDqTMGLvXXSnPTYDxphRb7vTJTq0s3Kuo0QK9u+LMKt
X-Gm-Gg: ASbGncvMb9pzg+NNp+MpfHObSlnhHPdV2kybscjsFY9ySSrjbpIrHG0KMHV18P3ZWjN
	09ayGPVINdjzqzZsDb6bxhl6ShJo3N+xzOpv1glXlwqB+x3mgrHFdxwefMxgntrX1CevHK1W1qU
	HZ2yY0vTNVGIfrmuRDMmuaTFdUdmzc7WjBT7X9dDFlRaLSpaHddFCN8id+75kQtp9cqPuNbSpWk
	Eaty1/qZ8YcGkBkzULb8cv67Ssrg+TGuQ89J4S90GB7IACs5bUQK+gE18V4YhzWJdADxlDPcgCd
	oXFJU7rYub/vohG8Rhhi8Bw2pi1kiafHEbU68O5DLg==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-438913ef6d0mr38316895e9.18.1737133234115;
        Fri, 17 Jan 2025 09:00:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFagDashmtCONr1e0mPjwxw78kvxvfLwflTa5M+wz0yje22vE2jx/prTk0zBbNIWdtqILag4w==
X-Received: by 2002:a05:600c:3585:b0:434:9936:c823 with SMTP id 5b1f17b1804b1-438913ef6d0mr38315575e9.18.1737133233397;
        Fri, 17 Jan 2025 09:00:33 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499932sm99166875e9.7.2025.01.17.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:00:32 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, rcu@vger.kernel.org,
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
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Kees Cook
 <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Hellwig <hch@infradead.org>, Shuah Khan <shuah@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>,
 Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Yosry Ahmed <yosryahmed@google.com>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, Luis
 Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
In-Reply-To: <Z4qBMqcMg16p57av@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
Date: Fri, 17 Jan 2025 18:00:30 +0100
Message-ID: <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f_hCPGkxlvJIA-ozQCxWybKlB7MlU0Gt0H9oAI_4BzA_1737133235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/25 17:11, Uladzislau Rezki wrote:
> On Fri, Jan 17, 2025 at 04:25:45PM +0100, Valentin Schneider wrote:
>> On 14/01/25 19:16, Jann Horn wrote:
>> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> vunmap()'s issued from housekeeping CPUs are a relatively common sour=
ce of
>> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> flush_tlb_kernel_range() IPIs.
>> >>
>> >> Given that CPUs executing in userspace do not access data in the vmal=
loc
>> >> range, these IPIs could be deferred until their next kernel entry.
>> >>
>> >> Deferral vs early entry danger zone
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>
>> >> This requires a guarantee that nothing in the vmalloc range can be vu=
nmap'd
>> >> and then accessed in early entry code.
>> >
>> > In other words, it needs a guarantee that no vmalloc allocations that
>> > have been created in the vmalloc region while the CPU was idle can
>> > then be accessed during early entry, right?
>>
>> I'm not sure if that would be a problem (not an mm expert, please do
>> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> deferred anyway.
>>
>> So after vmapping something, I wouldn't expect isolated CPUs to have
>> invalid TLB entries for the newly vmapped page.
>>
>> However, upon vunmap'ing something, the TLB flush is deferred, and thus
>> stale TLB entries can and will remain on isolated CPUs, up until they
>> execute the deferred flush themselves (IOW for the entire duration of th=
e
>> "danger zone").
>>
>> Does that make sense?
>>
> Probably i am missing something and need to have a look at your patches,
> but how do you guarantee that no-one map same are that you defer for TLB
> flushing?
>

That's the cool part: I don't :')

For deferring instruction patching IPIs, I (well Josh really) managed to
get instrumentation to back me up and catch any problematic area.

I looked into getting something similar for vmalloc region access in
.noinstr code, but I didn't get anywhere. I even tried using emulated
watchpoints on QEMU to watch the whole vmalloc range, but that went about
as well as you could expect.

That left me with staring at code. AFAICT the only vmap'd thing that is
accessed during early entry is the task stack (CONFIG_VMAP_STACK), which
itself cannot be freed until the task exits - thus can't be subject to
invalidation when a task is entering kernelspace.

If you have any tracing/instrumentation suggestions, I'm all ears (eyes?).

> As noted by Jann, we already defer a TLB flushing by backing freed areas
> until certain threshold and just after we cross it we do a flush.
>
> --
> Uladzislau Rezki

