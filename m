Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6F20C00A
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736891332; cv=none; b=YGhRrhaZ4EjdBTZMfGxOOc08otCeE4mX/ynYHR4PrjUvCJo6nJmWjfTkr1zXVCSCwvV51qEMeNVNhCk7WvTx1UAaES6M1O2CNgfwp/Jhpo+Vtgr4BbI3AokwAmmVE5ff4dm1yVvTfyWJ6YU8urIa3A20q2TVy6Kp9OFCXo9SzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736891332; c=relaxed/simple;
	bh=Qnfv3RXewSZryKcbeV9ntSt9VoSXcn2RU5Cczbey1Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EpNHd261b85N5Yp86PqKa2A4OW7Nkpxmd6oLG7AhesjMHYPZdoQek1t782cJ6WcXbviG9YbDXTXfTB2roFcpKUbVqArjiIXKRyNuoI0xSSor7WmCFhuAL91fdri9wadCrAtlZAk0hb9baDDk4/6Puz4xZ/y74RaOtK93i+dNwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+NqAYGJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+NqAYGJ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so10433565a91.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736891330; x=1737496130; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SY5ohLi34L7dYoduVlaYy23kjKtiA3foJ9V2Q6nj8Ew=;
        b=h+NqAYGJwk++rkjJMyJPEvIgot6gOqOyeyAcdBnolMAQr66+qy3+2K/PBr0Q7iV5HJ
         3gJbLbEP8AtNaVnXQQsM1s2JyRtwX+xKZy8E/jwkhh+e26EFelVDRcpKu/bFADCbFCIJ
         PoBch8ca6qgoasLmaWdLPWBiziHPpnoe5m/Q51OGVnOes/zZGJiKIzThxJCcuOlj/5S1
         2QMU4D/lBH5kLM3nA3jgzIpPrNndSCZNpKoLu/iqAQxqx4dOgOx0X+HdqKcyb8JkTF+R
         IUDmsjTKKm6HRQNmyVsWBTjab2JMHB/NDtr/wnSEEVjtBgW8FfJM0Ei+MqYAySsuzDtQ
         0WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736891330; x=1737496130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY5ohLi34L7dYoduVlaYy23kjKtiA3foJ9V2Q6nj8Ew=;
        b=vId5H8Pg0NCoL+MDPwTXqHpcdqJ9y/djhA7EcrKUtMk0bSP9i4DhFH00ZtOlMnGCSO
         M003axIoNdgt2EVUZjj+0dbMsvd/Fd2LGNEz4kFOD6VKpT/LfAF2R/l49GY3sFFVM/1v
         VNS6MTqKP4WSz4EbzxjPB835sFaB9DWCVpzFOBDeaJ93oEYse4SnO9QzKjZutXMEyDlh
         Ql7ecm3zAP/cECB176xZjvz54xZdN1+5jwA/yvvN7fVDWit11WW4kNYHMR9POgE9UpCJ
         uAJ8dopWZEfvYmVdCVUQD+u8g3fVI+GCX1gM8CswgVu3GGNVmQpqQbb8fX2e3iNbBWSg
         xmwg==
X-Forwarded-Encrypted: i=1; AJvYcCVNidp+35nevHlmbMBVotsQnd18vKH6o1D+eHDPECdCtwePRogPVEk/Js6mTU9ypf/JYcXx2bNy3lQu11Hxfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBgMjoD854CTXIGwMLrdhYqF0WbRW/MroSaqArGxygRzxBUjqX
	FIU8lrkQcefm9AhFHEBNt541WgjDdZv85OhpM2P6KW5xyf4LlsHqp2Iwx4NbAXiax4KBH/rtJrt
	mXQ==
X-Google-Smtp-Source: AGHT+IGwfpH2TIl0yoCx6tHXuYKAWJYGIodcKzr2p0TmFaGwbmX4878qRqYpxqFQD7ygsze3Eu4GllOh0sY=
X-Received: from pjbtc14.prod.google.com ([2002:a17:90b:540e:b0:2f2:ea3f:34c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d00b:b0:2ee:d63f:d8f
 with SMTP id 98e67ed59e1d1-2f548ebf53cmr37053651a91.13.1736891330040; Tue, 14
 Jan 2025 13:48:50 -0800 (PST)
Date: Tue, 14 Jan 2025 13:48:48 -0800
In-Reply-To: <Z4bTlZkqihaAyGb4@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-26-vschneid@redhat.com>
 <Z4bTlZkqihaAyGb4@google.com>
Message-ID: <Z4bbwE8yfg349gBx@google.com>
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

On Tue, Jan 14, 2025, Sean Christopherson wrote:
> On Tue, Jan 14, 2025, Valentin Schneider wrote:
> > +/**
> > + * is_kernel_noinstr_text - checks if the pointer address is located in the
> > + *                    .noinstr section
> > + *
> > + * @addr: address to check
> > + *
> > + * Returns: true if the address is located in .noinstr, false otherwise.
> > + */
> > +static inline bool is_kernel_noinstr_text(unsigned long addr)
> > +{
> > +	return addr >= (unsigned long)__noinstr_text_start &&
> > +	       addr < (unsigned long)__noinstr_text_end;
> > +}
> 
> This doesn't do the right thing for modules, which matters because KVM can be
> built as a module on x86, and because context tracking understands transitions
> to GUEST mode, i.e. CPUs that are running in a KVM guest will be treated as not
> being in the kernel, and thus will have IPIs deferred.  If KVM uses a static key
> or branch between guest_state_enter_irqoff() and guest_state_exit_irqoff(), the
> patching code won't wait for CPUs to exit guest mode, i.e. KVM could theoretically
> use the wrong static path.
> 
> I don't expect this to ever cause problems in practice, because patching code in
> KVM's VM-Enter/VM-Exit path that has *functional* implications, while CPUs are
> actively running guest code, would be all kinds of crazy.  But I do think we
> should plug the hole.
> 
> If this issue is unique to KVM, i.e. is not a generic problem for all modules (I
> assume module code generally isn't allowed in the entry path, even via NMI?), one
> idea would be to let KVM register its noinstr section for text poking.

Another idea would be to track which keys/branches are tagged noinstr, i.e. generate
the information at compile time instead of doing lookups at runtime.  The biggest
downside I can think of is that it would require plumbing in the information to
text_poke_bp_batch().
