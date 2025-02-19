Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248F1FDE2B
	for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981906; cv=none; b=J2ReApPadIZ+llLkBHYC395c+/7EsgNR0jizxSG1qSjRVnuy9vKZbGzPyw9aK+dBeaX476eMgBoeVCOTJsNMdZAx4N55FX1jFQQg6FZeGFgO0ahxfcN08aVpSWEP8VeUcH+hpcSyc7RW/xkboiRIGYQO5ovP6NaYUa0Rloo/DzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981906; c=relaxed/simple;
	bh=/+vVVMJTXnY0V8Ji7GQili3vpyK+jYVcqRgGTJ9UsZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4yA2el7zYLw9aOosrXKgIFJ5uyId2nMuXCZC91zoQUum+dOpZGGhNDeQhpv4OkqHgSFr6LoAHO1OeZ8l6K6+UNubk0D92fl8l6FAmM+uSszDFsUfrlDkeGAfAa11xxoStS+CrFm0Z7FAGEL4brTB6xnfUxZF5YHVA9wuIkmfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPseWBCv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPseWBCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739981903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+vVVMJTXnY0V8Ji7GQili3vpyK+jYVcqRgGTJ9UsZo=;
	b=dPseWBCvxEUKGDAnomFowcrLJELXuEiy++mfoGO8OMblO4FfO5fQpLhTQ2HMsFyhS53JxK
	Nmk1y7ifHVV2rQ8gxzcyAJ0dd+ARXJ5Z1z3ShTSlM8U+bBfXItsSksvh48kXzxjX2uTkUt
	k14H/X0lah3aMmBRufhrfaXJ2nsWzoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-Id_wlIiaNruLG2T8-G6OBw-1; Wed, 19 Feb 2025 11:18:21 -0500
X-MC-Unique: Id_wlIiaNruLG2T8-G6OBw-1
X-Mimecast-MFC-AGG-ID: Id_wlIiaNruLG2T8-G6OBw_1739981900
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso58176415e9.2
        for <virtualization@lists.linux.dev>; Wed, 19 Feb 2025 08:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981899; x=1740586699;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b38N2G5pI18KXCo6dYoQ0A/4T04VhxVdQ6rNeU31Ph8=;
        b=O5VN1RxUVsKUBhMEj5aaNEWvy13KU43S/1GsT6vCk20zS4ccZh7TLoqJwBI+7FUZPD
         /uIxngoZXakCyATffSCutK9ufjJiqWJ5AowafVINLAAQPShcffCZmzZHzzfYJqLhYetm
         YPtJIZYvH9VBkVSOJn03EDEb1gg8m+kU1YF05BxAV9NzbdQhUnOKBoJjRtdyASZTEpIU
         otASqlZDuh8yRIDOhMEfhwmNEYkkzuSvcyYGXeD4r+KkUmvxYq6/rb+ZOADNTx9bnbCi
         i4LNMkXzw4TfsNlDD5Qh/KHtt4XGXHLb7/v5FBV9SBJ9auY/WP2m9Bb2gjPnt8v+Bgna
         wiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxpcXU/igfy4e+2Sjdlt8z46/Mzd0Tri1+0CQUFfVza1faBDBf8+ooBnpUMuEOq+o4zI55pPNtYqZivqKp3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywji/3G2bUA2sxI+OnjzpAWF90/Dl/gFZVmN/Sw/JCUm71g7Muu
	jCEV32wNdbvW9H+g0vveKjN6K/woaD3lGvtAR4jDPli6eCjIz7gQVk5MRFPGKDTh4GobqAsMkuw
	3TnOSiWe4HAVExOiweDZN2dejNeiIA06giecC4/YE/Kc/3Rdm5U66xlKwM5uPxyIJ
X-Gm-Gg: ASbGncutyoB2B5VpHFvXws/DjtESsxdy9s24Yn2z4/JqAsb1h3Ey5EOkKsVpwCDIrSC
	dpJLDoUdm8sYrScb9WQlAW9s02K46t8hKM67eg/A0bCIfNiQH/iQZ/InIUXprILMbx/Cm322xeM
	arGitBbgcV0zEbrRI6vqjuuuUMK6NZcwynRXMJo9povinJW/USEju8nWxlIMdnE5wmzpn90dS9N
	jcdCDb+63mhBBK1rKShbJfzz/HAbkaBwnU+CFMyi+D5bwZp+KT28jXaO1xI3jPKYKNXmYA50Upe
	z472aAgPIcROJR6IJwgQWJK1dFlLR1BnwYQc8jXcdU5NXxTHR1bWnQFxwoSPQ+elrQ==
X-Received: by 2002:a05:600c:5246:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-4399d75b257mr27951735e9.28.1739981899405;
        Wed, 19 Feb 2025 08:18:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrgaKWzB18Ksr+NPSQeT1o3+i2kAVUfh7lIILUz6n7wULpVTIiD8VAP1UIlBXohEkgY6+FYQ==
X-Received: by 2002:a05:600c:5246:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-4399d75b257mr27950675e9.28.1739981898863;
        Wed, 19 Feb 2025 08:18:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2591570esm18461449f8f.59.2025.02.19.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:18:17 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
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
In-Reply-To: <20250219145302.GA480110@joelnvbox>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmhzfjpfkky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250219145302.GA480110@joelnvbox>
Date: Wed, 19 Feb 2025 17:18:14 +0100
Message-ID: <xhsmhecztj4c9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4-NPoI5YlScTt5g2L00d96teeOBLgA0Y4zKJl8t5254_1739981900
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/02/25 10:05, Joel Fernandes wrote:
> On Fri, Jan 17, 2025 at 05:53:33PM +0100, Valentin Schneider wrote:
>> On 17/01/25 16:52, Jann Horn wrote:
>> > On Fri, Jan 17, 2025 at 4:25=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
>> >> On 14/01/25 19:16, Jann Horn wrote:
>> >> > On Tue, Jan 14, 2025 at 6:51=E2=80=AFPM Valentin Schneider <vschnei=
d@redhat.com> wrote:
>> >> >> vunmap()'s issued from housekeeping CPUs are a relatively common s=
ource of
>> >> >> interference for isolated NOHZ_FULL CPUs, as they are hit by the
>> >> >> flush_tlb_kernel_range() IPIs.
>> >> >>
>> >> >> Given that CPUs executing in userspace do not access data in the v=
malloc
>> >> >> range, these IPIs could be deferred until their next kernel entry.
>> >> >>
>> >> >> Deferral vs early entry danger zone
>> >> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> >>
>> >> >> This requires a guarantee that nothing in the vmalloc range can be=
 vunmap'd
>> >> >> and then accessed in early entry code.
>> >> >
>> >> > In other words, it needs a guarantee that no vmalloc allocations th=
at
>> >> > have been created in the vmalloc region while the CPU was idle can
>> >> > then be accessed during early entry, right?
>> >>
>> >> I'm not sure if that would be a problem (not an mm expert, please do
>> >> correct me) - looking at vmap_pages_range(), flush_cache_vmap() isn't
>> >> deferred anyway.
>> >
>> > flush_cache_vmap() is about stuff like flushing data caches on
>> > architectures with virtually indexed caches; that doesn't do TLB
>> > maintenance. When you look for its definition on x86 or arm64, you'll
>> > see that they use the generic implementation which is simply an empty
>> > inline function.
>> >
>> >> So after vmapping something, I wouldn't expect isolated CPUs to have
>> >> invalid TLB entries for the newly vmapped page.
>> >>
>> >> However, upon vunmap'ing something, the TLB flush is deferred, and th=
us
>> >> stale TLB entries can and will remain on isolated CPUs, up until they
>> >> execute the deferred flush themselves (IOW for the entire duration of=
 the
>> >> "danger zone").
>> >>
>> >> Does that make sense?
>> >
>> > The design idea wrt TLB flushes in the vmap code is that you don't do
>> > TLB flushes when you unmap stuff or when you map stuff, because doing
>> > TLB flushes across the entire system on every vmap/vunmap would be a
>> > bit costly; instead you just do batched TLB flushes in between, in
>> > __purge_vmap_area_lazy().
>> >
>> > In other words, the basic idea is that you can keep calling vmap() and
>> > vunmap() a bunch of times without ever doing TLB flushes until you run
>> > out of virtual memory in the vmap region; then you do one big TLB
>> > flush, and afterwards you can reuse the free virtual address space for
>> > new allocations again.
>> >
>> > So if you "defer" that batched TLB flush for CPUs that are not
>> > currently running in the kernel, I think the consequence is that those
>> > CPUs may end up with incoherent TLB state after a reallocation of the
>> > virtual address space.
>> >
>>
>> Ah, gotcha, thank you for laying this out! In which case yes, any vmallo=
c
>> that occurred while an isolated CPU was NOHZ-FULL can be an issue if sai=
d
>> CPU accesses it during early entry;
>
> So the issue is:
>
> CPU1: unmappes vmalloc page X which was previously mapped to physical pag=
e
> P1.
>
> CPU2: does a whole bunch of vmalloc and vfree eventually crossing some la=
zy
> threshold and sending out IPIs. It then goes ahead and does an allocation
> that maps the same virtual page X to physical page P2.
>
> CPU3 is isolated and executes some early entry code before receving said =
IPIs
> which are supposedly deferred by Valentin's patches.
>
> It does not receive the IPI becuase it is deferred, thus access by early
> entry code to page X on this CPU results in a UAF access to P1.
>
> Is that the issue?
>

Pretty much so yeah. That is, *if* there such a vmalloc'd address access in
early entry code - testing says it's not the case, but I haven't found a
way to instrumentally verify this.

