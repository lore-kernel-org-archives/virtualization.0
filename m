Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9255C305;
	Tue, 29 Sep 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707820; cv=none; b=YKIzEliCjfdvYKq/JgbYFkOnZY+QbcUfSTa2wELkITWRaGtnGJBf1efX+Br12RMxG0f6+ElfH1g/7ApERPImJaBaaJVLGg977WKYgax2IRZdFeXac7wOgCOJTh8FXyEbs1x7jUkqd7et3V9L+O1n2BOVXA5Mdd3q4rgO83G6+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707820; c=relaxed/simple;
	bh=a0j9ZYPE0kpuxcGqfOeJqb1F8DjbAgg+aDr2TDXJr2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDv2RLoUMXUceJD8SbUvs7l7UEbtke0Eut+mGUOhiG8Cf7x6ABe4avXb51jDUER/9SeS8jVEvUD23C4EIneZO8tXaGJg48U8ULex8jdS1KV1epsudvSgKqTxfdpDzRVXPCZJ4/UTEPU1PD22iZMKC4H7Hr6PsnFbsEFqqTBVZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKL/NQJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKL/NQJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C211F000FF;
	Tue, 29 Sep 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707818;
	bh=a0j9ZYPE0kpuxcGqfOeJqb1F8DjbAgg+aDr2TDXJr2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AKL/NQJoQyB/VbLk21OaTs+Mad4FePYdN1yez5LipKrQ8ppXndkJ5NvSAie+kvhQ7
	 Yqyl0+b/kdqogNgUALIq95bXiZ9mFnXgC+4UviSh6lZef0lMj6jNLORKe9IN31zuNT
	 Vu8/t9RdpxSVVjF9Al3+GYkpLpqdUtRfCxKhcz0Wriu/JQRqpMn8u5EoboVp/bfF4C
	 cAB0XC1Pnny4KkDArsPRqCbt9dFO62WiZa9rNGDOdAyit5ChZkRHAy8b14ZbocdFUt
	 CA+EzLSqc4y19uaW8WZ9YTKy0iq3H/SVKVhdX4xUFyS1KmdYw5GkoFZzzmgjoSkYbO
	 7CDUOnBLTgKsA==
From: Thomas Gleixner <tglx@kernel.org>
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>, Kees Cook
 <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 rcu@vger.kernel.org, virtualization@lists.linux.dev,
 linux-rt-devel@lists.linux.dev, llvm@lists.linux.dev, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH 12/17] timers: assert static storage for DEFINE_TIMER()
In-Reply-To: <20260915031334.1194975-7-ynorov@nvidia.com>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915031334.1194975-7-ynorov@nvidia.com>
Date: Tue, 29 Sep 2026 20:50:15 +0200
Message-ID: <87o6dfj3iw.ffs@fw13>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 14 2026 at 23:13, Yury Norov wrote:
> DEFINE_TIMER() marks a timer as statically initialized for debugobjects.
> An automatic local timer instead needs timer_setup_on_stack() and the
> corresponding on-stack destruction before leaving scope.
>
> Add ASSERT_STATIC_STORAGE() to catch automatic declarations at compile
> time. The timer lockdep key is already static; this check enforces the
> debugobjects storage contract. Leave __TIMER_INITIALIZER() unchanged.
>
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
