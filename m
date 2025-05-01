Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029991F12FA
	for <virtualization@lists.linux.dev>; Thu,  1 May 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109192; cv=none; b=D9MWI7wznIW1PBsTnV7oLFyd8YLLWk6sMV1PiM6grjrcCZZWRErkgdTIXTqQhhQGW2wEheknRF1G/ir4P0OY8IaS/pRbqu+TG4JMMv6nEQZU2TdUGCKkXL35l7liC0kLkAGxMY4I/bD+hVfmvF7PmFjh4YfA0NUwWslxswk8jJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109192; c=relaxed/simple;
	bh=RFwLAdDJzHnRsl1AiuqY7ErKiNdGVq/+PnAbJFngrNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hoh9jvuzfRfr3aztizNCoCmdV8UFrUnqWn2uZ/EBmrHS26qGSkGauLYw0WNzqmq9BLW5PmcBtk/6BjGz39/1CsttvNxRvQMjYXCobxG8+lPgacqdANs8FWVR/y/KK5zpfnzJPyb2xdAlfoEKMnEd4cEXRygOTWCsb3qUTti1E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2js7HtA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2js7HtA"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so3858615e9.3
        for <virtualization@lists.linux.dev>; Thu, 01 May 2025 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746109189; x=1746713989; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=t2js7HtAQ4kk0ogn8DclLEqOmIEpWzbG5DKswbUDQcQRfNNhQ5m/9nHonu6LM2+Q7W
         i7q0DZYVkj53QhCMZJFxVLuiFlUta+2BtDDreIfGdA8slimxC+mAx/+N9UFlTTxYgHYU
         s2uLVlTjOL50GX/2T1j44p1oWUe/t4gp5Iz8nSIeZhoF4dWUU1GsZ/vtAVHnTiTGlRDu
         0/x+O+i2z5k30xmdjRhXd0qGbfJbjeZ2JvCGXOkiYKX22+o+SHWVTgefEVm/9a0W4Ph/
         IuT2CIoUx3jZXHtW/0Qw7swd44TYUpehajfBs0Fr3icwQHPRvAZ9Az43mSy9JMAcVKKc
         pL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109189; x=1746713989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmEF1yP8U0niebBh9hfc5iyUEhI2jhPWqahRuFkaIQM=;
        b=DG01VdjEY70JKiVVqDY0SMkbE+on+Anylp4vSfeQbPQ+nSODX8eGpRDyHFDTsVhjba
         3ZMPVtR/toCG182Dv4ubOyIShWoMWlZkMd5tEnNcmvijehFN4fq7pjAx1b+idOmBQIWr
         O1fHigT3q9cFQIaTV1IFQjY+YEFJ3DupuBFloPzc2mfqBkdXOeIZbkiQpZnnDw4nUEyn
         4iRKJJchIPSkfmom+kYgiON9s7NF17auXpqR/58N2N445+BMUxbjMzmYDgT3IcrtGxDR
         NnxllW+50+UOBa5FWa9SQVAacvjEZCHRLyJAKD7UegCjnp1p3asxM/vFKfhbgNfGk2ZL
         vIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlZgwJvuHDSvSqi8+7dLJnQifgmtGNSTDiaS2q+8oX+FgX5PEETC4zRYo1j+DAoP0eCU6XqFvGVjCKkekX3A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyq0WzAscJxjECzTAyVHMb5GAPdjytaji+ansLthfGKgzuHYRJ8
	1+wlwSwsrwV+jyh0fDABK/mCYJPFSxsamuK7b2aXGZM9H5vl2thn6PJJoZxOOkVDAOcoSz2GB0W
	3W0eTI2a8bQ==
X-Google-Smtp-Source: AGHT+IE4OWD5XxcERH4cgRX5gY9PM+u+mzYGVEd/YlTx4e+t3SrV5tDi5azUj0xMuNVR7NdRXpnF4uWQLtuxPQ==
X-Received: from wmbhe15.prod.google.com ([2002:a05:600c:540f:b0:441:b79a:76cf])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d6:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-441b64ed9d8mr27510245e9.3.1746109189194;
 Thu, 01 May 2025 07:19:49 -0700 (PDT)
Date: Thu, 01 May 2025 14:19:47 +0000
In-Reply-To: <20250429123504.GA13093@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com> <20250429123504.GA13093@lst.de>
X-Mailer: aerc 0.20.0
Message-ID: <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
From: Brendan Jackman <jackmanb@google.com>
To: Christoph Hellwig <hch@lst.de>, <chenlinxuan@uniontech.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>, 
	Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, <linux-nvme@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>, 
	<virtualization@lists.linux.dev>, <linux-integrity@vger.kernel.org>, 
	<linux-kbuild@vger.kernel.org>, <llvm@lists.linux.dev>, 
	Winston Wen <wentao@uniontech.com>, <kasan-dev@googlegroups.com>, 
	<xen-devel@lists.xenproject.org>, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue Apr 29, 2025 at 12:35 PM UTC, Christoph Hellwig wrote:
> On Tue, Apr 29, 2025 at 12:06:04PM +0800, Chen Linxuan via B4 Relay wrote:
>> This series introduces a new kernel configuration option NO_AUTO_INLINE,
>> which can be used to disable the automatic inlining of functions.
>> 
>> This will allow the function tracer to trace more functions
>> because it only traces functions that the compiler has not inlined.
>
> This still feels like a bad idea because it is extremely fragile.

Can you elaborate on that - does it introduce new fragility?
