Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DC29B209;
	Tue,  6 May 2025 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499294; cv=none; b=hiwDGSjGimlEC5S3dFTplyrF0d1U9LLZ4cgtHMMbpOp522Vxm9GmS3hF5DMC8QAwg+RHVokwYp9cqij8pGYoFevxUs6Iwqe5WdNT/K9a1g2ltFP8Pf4NByfm/Vk6gET51V9u39Xf6Em98PvOpuiF/tRN6vIdVNUyeCQorTNS7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499294; c=relaxed/simple;
	bh=dDn4W5v9t6AyHBHxLWO7FuLjj98KbpZnLxWf1Zria3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdAkXFQIXhWHZHecHGbIIoZOFoTcIMjYdvboOhg9D7AvOYz52uD4f0FzE8LIcaE+xBgESfFBZfP/dlWasEE4B/db9gz3025dY23GfvxIS9EkrWM7EdAXcbjBOEHVjXk8fxe6gHDcRkujmE5q5XwF4mBt/CIYDGRDK0VFsVikvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n8r4R3u7; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n8r4R3u7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746499275;
	bh=dDn4W5v9t6AyHBHxLWO7FuLjj98KbpZnLxWf1Zria3s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=n8r4R3u7gzqMxHc2aQ3peYjPOWOKjtBW9b6RgtRAJNk6dHbpxJUR6DPrZeBXWPSF+
	 GczkkIOhC7KbRR9T2Skwi+6r4ccDpcJQF645RYV3AIcSq6bm92mzpeTq02mh5qfw7h
	 qDLlodeU0Vqb3lAfPTGJoozZFJW/oNaQXlsuI5BE=
X-QQ-mid: esmtpgz15t1746499273tdd5e21f0
X-QQ-Originating-IP: DFv7BP+NKyrh1LeMtPooqfMTkzgahDsoi4kuhzdZXsY=
Received: from mail-yb1-f178.google.com ( [209.85.219.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 06 May 2025 10:41:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13048494023631488846
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e75607fe4ceso3133291276.3;
        Mon, 05 May 2025 19:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdph4jO2iasaQjQES+9zjFdZy1bFM5gX0YMv9JUS0PmT+mXP5R7ejsbb12wobg0xLDHksD@lists.linux.dev, AJvYcCXkxpIfomL4VQ7uJtVpDxnycUUhqdk668P1yuSoD1HsG7AIAX96/RQeuVJzjOGz5FW++nD5/9FGf8h3HGSbAp0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXrMBjjQBfPLgq6BMYwYR59LB/3qHTD7D61B3rH8vn390BHVqw
	0S0kDf4Es62AQkQPTI7lESo0VGkzv052nRzz9oxAm5lUi/YZevxxH+XllpB6X/yJo0qV6yuMS7P
	8P+hLClweg2gb61V4/7mIhmwRF9g=
X-Google-Smtp-Source: AGHT+IFgFFlMacdloLtgDC8BYlif3b1M5uLk0pWcJg25Fujp9vccWuhfsfXobAggGBnTnNta+8cIxYeCcW4lzf1hqZQ=
X-Received: by 2002:a05:6902:1ac5:b0:e6d:f3ca:3e15 with SMTP id
 3f1490d57ef6-e75c08b698bmr1960395276.3.1746499270786; Mon, 05 May 2025
 19:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de> <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
 <20250501150229.GU4439@noisy.programming.kicks-ass.net> <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
 <08163d8b-4056-4b84-82a1-3dd553ee6468@acm.org>
In-Reply-To: <08163d8b-4056-4b84-82a1-3dd553ee6468@acm.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 6 May 2025 10:40:59 +0800
X-Gmail-Original-Message-ID: <973B455678FC1BDD+CAC1kPDM2pUEwFRiUZFHKq_7sYpjARkFczJnp_FRu+r9-xYdgKg@mail.gmail.com>
X-Gm-Features: ATxdqUHhA0M6lhr1xavQzClQ8qzartLkG1qHh9aYbVlX-6LFgZ39KxjHPoTQnkI
Message-ID: <CAC1kPDM2pUEwFRiUZFHKq_7sYpjARkFczJnp_FRu+r9-xYdgKg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
To: Bart Van Assche <bvanassche@acm.org>
Cc: Brendan Jackman <jackmanb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Christoph Hellwig <hch@lst.de>, chenlinxuan@uniontech.com, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
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
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-integrity@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Winston Wen <wentao@uniontech.com>, kasan-dev@googlegroups.com, 
	xen-devel@lists.xenproject.org, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OC0Q7tWN8iCR54FjnsmfdJ1xcoyNokmxFwaP34rbXfXhOfLZKkofMTV2
	qNbnwReHm4XIOm2QVhV99csUe3C542cc5e9KpTeUaoS4Z2GNgh69OFdGddHoY2axm05J1PG
	LyM/GbATayh8up36KXEajUA42srohAguDZJSolXvhm9bwdN1fbRUuq8qRoUHC6WrvjgpfI8
	eRrlCWO1ExYFmkTikni1CAPyZUZjsIYKxYpK2SjpEc3uQwX5pbZRZQi0u4hagftgI19wd3L
	YBp1S38Ztz5QDxRzOxQL952aV2LcHVShBWNZ03bxwwHy4L9jFbowMzOaL67ia6ZTVJAXxvP
	OKCgO9ZYJV7ExI2gtHweCtosZHQSUa+Wq8hGFgPwDhnr14whnCyGAxHNwwe5oet5tPunu6u
	6I2Q1HZdMNSHjIwZ6dY9kYKqH8ms7gIVmhn8yMcCdP3I23XMvt0htJOcGdp68TWEXkNG01o
	pkuOFzBZKnh/6bkMnF4wvEpNn38d+873pmXp9fqbymzYyNrNiWBmkQgeDUdgWaolB5S/z3J
	BlphZVZwQlfnlGXtPElGUfQqUV7B8sOT/0FNikKDyBPbS3DvUt6+WBpIs+26BYXwLbwSOkk
	h8hNyU8WqFDq3P/u3zG/gSlzvV4CxLn1jXo8Vmmx2xHofWNfJ1j/QRDwB41KwOVE2pCj8OO
	DhV4FcU5jlkcJAk89muUrPjBsrB1zu4XO2XVtU1Na+Yhf5hghnVPxub74M6bsQgT6JCtxm3
	n7OYx19Aq/Su/oAAkgfqPq+uDKLu8s0y0aes9KGV7WWwLRIVPJ0MEft7uAMaXASpEmK0FSV
	peLg5HMzbWz5d6p+0Q09If7iEEfiAuPl5o5CWtN1NqpgKWiL7UK6OUy9nXQD+Tso06P4N/A
	fvJHOokU1Q7xvNVcpbxJuYF1T3d6lFSOyqRm/8F+dkrNM40O1R873G1qPDJ2sZqCFVrT6hT
	P90Z/ZSApanLi9cJw0s0Bvmth2LQu8ifAlHTKd0WZLi2ykt/p2goQ+b+t7J5xfOOoZbBrOK
	7Ha95qJKr/0Vc/dUoDkIv8tvs5sP6QnMMu0nqBFosUPvslD1PkPau3qtdvRK9UX6cELPCGq
	w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

On Sun, May 4, 2025 at 3:14=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:

> If this is for test builds only, has it been consider to add
> -fno-inline-functions as a local change in the top-level Makefile?

The issue here is that the current kernel cannot be compiled when
these compiler options that reduce inlining behavior are added.
