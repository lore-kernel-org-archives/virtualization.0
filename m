Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A03201276
	for <virtualization@lists.linux.dev>; Thu,  1 May 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746112980; cv=none; b=IUtYnza/tiJ+j1QQR7qqZq0Q9dwXOxlE6QZTPJYhuHqWbQFGFI4qnVC94Xx9Q213vXnMKTV2VrfBcpkKpDlCBsGFHDopsYcxXGZ50GkLSsrEhYFgz7aN3B3tIvlRZ3FkX9op8A1HxrF0KnNGnl8j+8BsCEurcT9g8sUfuG3F0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746112980; c=relaxed/simple;
	bh=GnwsPoOxW8mCGc7CAgjoDtFw8dTWra4gUIbWL5YCLUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i5+XVT26ILzqqpxUuwW5B+/9ZfXU1dorNV3q9MZmnScFOZP51wSpVQb3BFc4rBpM7UgQ4yJ6l4fg1+w4k/hnlXDVGnNLbx0A8jD692sYguMyktp0DSGKRbJoVVaQZPe7tz4TrA0vQOxlCDGBun7o7cUn2oWxfVhLnSyWDKwQQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yn69Ui8P; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yn69Ui8P"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so5052365e9.2
        for <virtualization@lists.linux.dev>; Thu, 01 May 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746112977; x=1746717777; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8HDKzWcPs/ZOJ7u1MGp3oUtkY4RQR0TPLRQCBj5DQ=;
        b=yn69Ui8PYCjNhi6G7e60HhHeO/ejIaOVFI/Zcx2xDYJl2h/8F+LYdxfV+805iKNOOW
         4RoOIwEo3PHfmf4eFlW6/TSE4H6t+ogfn+UXBwbXKud2mcmXUKXp0BdTrOHB54KGm36Q
         a4euszSjkiITBnDOSLqmCTvK/pjyp9XHTm/sJlPmFYk2I8YwwMkTDyn6QcxjcbSH6gtg
         vrm5MX4Koq/L95sf5xV7RbQNMuK3R+sH8Kq31OAcZaxQIyPXZbAlfcJ7pAPG6WCOAPJG
         ZJQ7QQPMkNmR0jOwg9IxQpnj/5ONcOm2QncGgDwN9Jpa6Dlqkgr8DHPEXbQs9EieYHkn
         OAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746112977; x=1746717777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wm8HDKzWcPs/ZOJ7u1MGp3oUtkY4RQR0TPLRQCBj5DQ=;
        b=NQzpQ7t5U5M//rj6CoBw+xoaC7xNDknfiApj2J1qmKBKUMXIkoIPQU9/gB8Nenf/FD
         VlgDk2zKaYO8O9wRR5DLRXPI4DJ4c/oxr0dsi3Q/HxAyMJc1mm+mNvS8HXGLqIWeb3ef
         bVXRpPcE7kkoGvvY0Z4DfNT4H1121X80Ysv6XqwE87AgvluRYA8PqPjXyfnK293vfsNg
         oSpOrXnCPpbGFH9mYN1r4WKXiakOUVMiddlSmOCXJMBKV++xQ2jwStzbUpZE2O3JLzHZ
         aJI2cNNSxOHXymzccYzZiELBOClteivheKpoce+NwJeo9vhXKEXGihaEUMICYILlk0xv
         mooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdHxcSye8yuaR/f9ZlwxOvsBlDiI6bxkJr74OF72DRFPIRypTmCN13/XcQztrJ2W1MnH6PnBGOzdY9RkX0vg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa462NbhZDJOYWC5pi3ZLS6LRk+TL3etul0xm9MPDfO7WQw0Xu
	DKsoiAqzBUQn5jm453gls9GiIWAnhtwpfJDqveoATwOXPJTnidXO5drb2TkHYA16n1RWEpW9+07
	BBCKApmQMRw==
X-Google-Smtp-Source: AGHT+IG1H8EWFmTdy9mXUfcCJxQBprr6abVa1X9treBvRrD020Cub+yFF9voa0K8UUVl5WCrL4gH+SDc7+SKLQ==
X-Received: from wmbel14.prod.google.com ([2002:a05:600c:3e0e:b0:440:5f8a:667c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec6:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-441b2635482mr61130455e9.6.1746112976936;
 Thu, 01 May 2025 08:22:56 -0700 (PDT)
Date: Thu, 01 May 2025 15:22:55 +0000
In-Reply-To: <20250501150229.GU4439@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de> <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com> <20250501150229.GU4439@noisy.programming.kicks-ass.net>
X-Mailer: aerc 0.20.0
Message-ID: <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
From: Brendan Jackman <jackmanb@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, <chenlinxuan@uniontech.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Yishai Hadas <yishaih@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, <linux-nvme@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>, 
	<virtualization@lists.linux.dev>, <linux-integrity@vger.kernel.org>, 
	<linux-kbuild@vger.kernel.org>, <llvm@lists.linux.dev>, 
	Winston Wen <wentao@uniontech.com>, <kasan-dev@googlegroups.com>, 
	<xen-devel@lists.xenproject.org>, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu May 1, 2025 at 3:02 PM UTC, Peter Zijlstra wrote:
> On Thu, May 01, 2025 at 02:19:47PM +0000, Brendan Jackman wrote:
>> On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
>> > On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>> >> This series introduces a new kernel configuration option NO_AUTO_INLINE,
>> >> which can be used to disable the automatic inlining of functions.
>> >> 
>> >> This will allow the function tracer to trace more functions
>> >> because it only traces functions that the compiler has not inlined.
>> >
>> > This still feels like a bad idea because it is extremely fragile.
>> 
>> Can you elaborate on that - does it introduce new fragility?
>
> given it needs to sprinkle __always_inline around where it wasn't needed
> before, yeah.

Right, I guess I just wouldn't have associated that with the word
"fragility", but that's a reasonable complaint!

> Also, why would you want this? function tracer is already too much
> output. Why would you want even more?

Yes, tracing every function is already too noisy, this would make it
even more too-noisy, not sure "too noisy" -> "way too noisy" is a
particularly meaningful degradation.

Whereas enlarging the pool of functions that you can _optionally target_
for tracing, or nice reliable breakpoints in GDB, and disasm that's
easier to mentally map back to C, seems like a helpful improvement for
test builds. Personally I sometimes spam a bunch of `noinline` into code
I'm debugging so this seems like a way to just slap that same thing on
the whole tree without dirtying the code, right?

Not that I have a strong opinion on the cost/benefit here, but the
benefit seems nonzero to me.
