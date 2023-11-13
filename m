Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C34168A9
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wROikK0F"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 742AE81008
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 08:54:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 742AE81008
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wROikK0F
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.398
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S2DLMCfmZOcz
	for <virtualization@lists.linux-foundation.org>;
	Mon, 13 Nov 2023 08:54:54 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9DBE280FB9
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Nov 2023 08:54:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9DBE280FB9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dutrm5ccD7TaxoUTd5HetFxAB3OI7e+5hdO7Sj9SVNo=; b=wROikK0F+E/0+gQCY5aizziwZM
	QBnqTdIASK/w4O/XE3EW5v2abecSdYkvK+1zJnluPUtnBngldSvjaMgTnd7kRGV514mvgKT2hU0vC
	zyXBTRnb7A9gFNaBRlwjzsA4yg5tTIt5CaM1p3Y5thi2fixgzbu9gYQs2dMIhNq7ghLsDwXDjPCGW
	c4IO6A3VhEeYayv5zlUHiiN4fSixzrzW2ZU+OFXqHfAYwdcx8Ci4e1LYOZbFbUtVyqtN+xQnmTz7h
	4Bnr6O5PUCwR9sOreXh5yplAfAZI8hKiF8rtnUT8tx3OIE8Nkxzi4qJBpBkKgX1hESNRrFrl/uuYN
	3iMt4jmQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r2Shn-00DHEt-7m; Mon, 13 Nov 2023 08:54:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FD82300427; Mon, 13 Nov 2023 09:54:03 +0100 (CET)
Date: Mon, 13 Nov 2023 09:54:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Alexander Graf <graf@amazon.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Forrest Yuan Yu <yuanyu@google.com>,
	James Gowans <jgowans@amazon.com>,
	James Morris <jamorris@linux.microsoft.com>,
	John Andersen <john.s.andersen@intel.com>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marian Rotariu <marian.c.rotariu@gmail.com>,
	Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
	=?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
	Will Deacon <will@kernel.org>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>,
	=?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
	dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
	x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v2 18/19] heki: x86: Protect guest kernel memory
 using the KVM hypervisor
Message-ID: <20231113085403.GC16138@noisy.programming.kicks-ass.net>
References: <20231113022326.24388-1-mic@digikod.net>
 <20231113022326.24388-19-mic@digikod.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113022326.24388-19-mic@digikod.net>

On Sun, Nov 12, 2023 at 09:23:25PM -0500, Mickaël Salaün wrote:
> From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> 
> Implement a hypervisor function, kvm_protect_memory() that calls the
> KVM_HC_PROTECT_MEMORY hypercall to request the KVM hypervisor to
> set specified permissions on a list of guest pages.
> 
> Using the protect_memory() function, set proper EPT permissions for all
> guest pages.
> 
> Use the MEM_ATTR_IMMUTABLE property to protect the kernel static
> sections and the boot-time read-only sections. This enables to make sure
> a compromised guest will not be able to change its main physical memory
> page permissions. However, this also disable any feature that may change
> the kernel's text section (e.g., ftrace, Kprobes), but they can still be
> used on kernel modules.
> 
> Module loading/unloading, and eBPF JIT is allowed without restrictions
> for now, but we'll need a way to authenticate these code changes to
> really improve the guests' security. We plan to use module signatures,
> but there is no solution yet to authenticate eBPF programs.
> 
> Being able to use ftrace and Kprobes in a secure way is a challenge not
> solved yet. We're looking for ideas to make this work.
> 
> Likewise, the JUMP_LABEL feature cannot work because the kernel's text
> section is read-only.

What is the actual problem? As is the kernel text map is already RO and
never changed.
