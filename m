Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793D415F08;
	Tue, 15 Sep 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460626; cv=none; b=CZs53Rm+bRTHzC92uk11q/chWrDURkVR1Zm7IuWybJTnX0vOS2gLswt5RUkJt7eL61YNHVvKFh1IGy1r+asOhhRM3iHafG4Tu8mBR2J+l6cTy9ofEKsztmHgOuCs+jnHhXLzfUgz7RHifDqSUUWFfGi7EeXHVdXXwvyUxt/cKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460626; c=relaxed/simple;
	bh=Q6hjAE+9q8egGVVb02CPWb1wLjOusvGxKkXCzWLChHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvbQgqgSdi7M1vDQUiBK5BffDpNG9WcWHcRdD7eJKqsdCvMloM3T4K5xnTrWZbOTB9uCXk9lbXjcZ4qjEtgxO4uXDPx4VnmGQasv04ZKQQoh4qLz6YGv8cmz9n7TBdYzlriXcmdayQ0EgwWY6XQWDZZWM6LQwMW3NVqjj/vAlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipzJcm8I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipzJcm8I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GLQ264WxN6wDQzABD1f2vOcHnnY8r7L3wdbiMWb63xA=; b=ipzJcm8I1ST/GUt421dYmJnfyI
	vMJ7fwLPm50oqJU0jqpXgWe24q407KlTdH7SXHQr7TDXrJ0cM1tEYBnW9xuMF681fSZbRWEhC0xLD
	6pneXq40+9I4oviAF01pBkAh9+iexFHZvr8Q0AJ9eQUZ1IpxpzGhf4HDVrlwFQYzTx+rlpPRZqXIS
	bi5aWaDAYx9YdPtSyaz9+cEy9G45/haDccskEkn/nT4u1JIUGIvbu/z3wOp8oYMS5UFYrgQZ3LkKc
	D4oDDw5Avnj0AUqbEB+wgK/erFclXrfrCAUd2232oXhxiftApCzjDlcWbdLgQanaRy0SwbWde3WVp
	73UWs78A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6ORT-00000006QWj-1Tpq;
	Tue, 15 Sep 2026 08:23:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1FDF3012C6; Tue, 15 Sep 2026 10:23:00 +0200 (CEST)
Date: Tue, 15 Sep 2026 10:23:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	rcu@vger.kernel.org, virtualization@lists.linux.dev,
	linux-rt-devel@lists.linux.dev, llvm@lists.linux.dev,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 01/17] locking/mutex: assert static storage for
 DEFINE_MUTEX()
Message-ID: <20260915082300.GV4121339@noisy.programming.kicks-ass.net>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
 <20260915030336.1192299-2-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915030336.1192299-2-ynorov@nvidia.com>

On Mon, Sep 14, 2026 at 11:03:19PM -0400, Yury Norov wrote:
> DEFINE_MUTEX() uses a static lock initializer whose lockdep class key
> requires a persistent object address. Reject automatic local declarations
> with ASSERT_STATIC_STORAGE(), in both the regular and PREEMPT_RT variants.
> Align the VMA and memblock tools stubs with the kernel declaration.
> 
> The two automatic mutexes in the WireGuard allowedips selftests already
> call mutex_init(). Replace their redundant static initializers with plain
> struct mutex declarations.
> 
> Assisted-by: OpenAI Codex
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/wireguard/selftest/allowedips.c | 4 ++--
>  include/linux/mutex.h                       | 7 +++++--
>  tools/testing/memblock/linux/mutex.h        | 8 ++++++--
>  tools/testing/vma/include/dup.h             | 5 ++++-
>  4 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireguard/selftest/allowedips.c b/drivers/net/wireguard/selftest/allowedips.c
> index 3e857e6fb627..ecb2908228e7 100644
> --- a/drivers/net/wireguard/selftest/allowedips.c
> +++ b/drivers/net/wireguard/selftest/allowedips.c
> @@ -257,7 +257,7 @@ static __init bool randomized_test(void)
>  	u8 ip[16], mutate_mask[16], mutated[16];
>  	struct wg_peer **peers, *peer;
>  	struct horrible_allowedips h;
> -	DEFINE_MUTEX(mutex);
> +	struct mutex mutex;
>  	struct allowedips t;
>  	bool ret = false;
>  
> @@ -499,7 +499,7 @@ bool __init wg_allowedips_selftest(void)
>  	struct allowedips_node *iter_node;
>  	bool success = false;
>  	struct allowedips t;
> -	DEFINE_MUTEX(mutex);
> +	struct mutex mutex;
>  	struct in6_addr ip;
>  	size_t i = 0, count = 0;
>  	__be64 part;

This should probably be a separate patch.

> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 734048c02f4f..2f2d95f3097c 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -11,6 +11,7 @@
>  #ifndef __LINUX_MUTEX_H
>  #define __LINUX_MUTEX_H
>  
> +#include <linux/compiler.h>
>  #include <asm/current.h>
>  #include <linux/list.h>
>  #include <linux/spinlock_types.h>
> @@ -84,7 +85,8 @@ do {									\
>  		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
>  
>  #define DEFINE_MUTEX(mutexname) \
> -	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
> +	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname);	\
> +	ASSERT_STATIC_STORAGE(mutexname)

My tree no has ASSERT_STATIC_STORAGE. Please repost when that lands?
