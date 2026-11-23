Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795410887;
	b=q0rb38iS69VMU9EoL9wifjIdBDv2nXiadgdpgF0XiSuLIK3d/q2bH1ttXcp1sitUXt2S
	 wCnCF7NhKqDjJiDYSy1sEk6/B0lJ4YYUpvPh9jid2lLzAB0nv5cbSzmDgK2TOzjuZNqDr
	 VPnee7EaplQNWTxXi8dCmBWkgLEl2F6kJ+yXf3D7923Dhw3SPo46vEy/8KYUVYUDHpccX
	 eOdSB7VP/v0VJeqCF21UBGVrWLuAz+r3k91+Aat+b5H/9IezhCcH/LdunaJD5zhH3GYvY
	 9vN6W/1RVhcNHx72YG+/hQEtItZ4Nf1DpyYvDfAJE0s3tLAOwpd5LHbjcIup8iNr4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410887;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FuEsR0gl/FRBomGQtdy1DpOLnKBF4WvHwtlAdJIMaXk=;
	b=o+jXNnD+0hq9M8x6jPnKcJoB++s1CLD2AflhaytlIG7RdGvdUCcgoKDZ/58PvjhGO45y
	 ExXHN23wxmDEFcP0w6L1YynkpmcRKT5grPAASKvief8geFddxOUbmjce6FzrqTtXatU/X
	 fCrRwd2lj5fL3pog7jtXXBuKftE3mnS+f1VFGkEQM+ro2EM/p0Rkgbi3Lk+vcXMXczF8S
	 iJccYIyMdVZMcHLbLl6wnkL3SubjsxH9Rky+wWYYdx5kI047bTkahX+2aQfV62hL77I6I
	 ht8EK7/4HCqqfABcX6PxZ1geDdaxk1zLOFg5yawxg9UWHaMMq1bIWSZvZF13whSiXnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPEadBDo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF32606A31A;
	Mon, 23 Nov 2026 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPEadBDo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57881F000C0;
	Mon, 23 Nov 2026 05:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795410887;
	bh=FuEsR0gl/FRBomGQtdy1DpOLnKBF4WvHwtlAdJIMaXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DPEadBDo1O+G3J99wgmQd5wQRx/GLhLpE/iAUQjjiacT9Z2xIYN7XtCJ3Kx9P2ltX
	 58uxquPCJ28Z+zukyGXCJlRdt1HF91dseT+FZEPGo8jpeDQvAODr5LMEYWsbnS3baa
	 W1o0xWLD/5lNzkqzhur0d34qRzF70GCa3cuQCt7+J4+f2ED9ERtnr6z40h1Zwh5Flp
	 YDRWabcI3JoZrgNPsB4lgrGlBSDh0wUQkEiQK5pmm1k+pRB4c+yH6Z3Gd9/NE+lHl6
	 6h+EITCArQ0wRxBnTYK8RwUHA92szzqJ78japFV+9BqTfZNJtuqQdQb1pcMpfbMAjp
	 DyWky68Rbo45w==
Subject:
 Re: [PATCH net] virtio_net: mask callbacks before handing off NAPI ownership
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, zcjie0802@qq.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev
Date: Mon, 23 Nov 2026 05:14:46 +0000
Message-ID: <179541088645.3135.14221394097883219540@kernel.org>
In-Reply-To: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
References: <ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] napi_complete_done_finish() (net/core/dev.c:7142-7150) repeats
  the `n->state & (NAPIF_STATE_NPSVC | NAPIF_STATE_IN_BUSY_POLL)` test…
- [Low] The commit has no Signed-off-by trailer.
- [Low] The patch adds a second way to complete NAPI
  (napi_complete_done_prepare()/napi_complete_done_finish(), exported…

--

virtio_net: mask callbacks before handing off NAPI ownership

This commit splits napi_complete_done() into napi_complete_done_prepare()
and napi_complete_done_finish(). With the split, a false return keeps NAPI
ownership until the caller calls finish. virtio_net's
virtqueue_napi_complete() uses this to disable virtqueue callbacks before
ownership passes to another poll, which avoids an RX stall when IRQ
deferral is in use.

Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com/

> Reported-by: Congjie Zhou <zcjie0802@qq.com>
> Closes: https://lore.kernel.org/netdev/tencent_D0650F8CA2AAE4C258BFE5BCE805CDB4CA0A@qq.com/
> Fixes: 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> Message-ID: <20261119064843-mutt-send-email-mst@kernel.org>
> Assisted-by: LLM
> Tested-by: Congjie Zhou <zcjie0802@qq.com>

[Severity: Low]

This isn't a code issue, but the trailer block has no Signed-off-by.

Documentation/process/coding-assistants.rst says AI agents must not add
Signed-off-by. It also says the human submitter is responsible for
"Adding their own Signed-off-by tag to certify the DCO".

This patch carries Assisted-by: LLM. Could the author's Signed-off-by be
added?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 6140fd9d11cd0..4be810fb5175e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -7085,8 +7108,48 @@ bool napi_complete_done(struct napi_struct *n, int work_done)

[ ... ]

> +/**
> + * napi_complete_done_prepare - prepare NAPI completion
> + * @n: NAPI context
> + * @work_done: number of packets processed
> + * @completion: opaque completion token
> + *
> + * Return: true if NAPI is complete and interrupts may remain enabled;
> + * false if ownership is retained. On false, mask interrupts and call
> + * napi_complete_done_finish().
> + */

[Severity: Low]

Should Documentation/networking/napi.rst be updated to cover this API?

It currently says:

  napi_complete_done() releases the ownership of the instance.

and:

  IRQ should only be unmasked after a successful call to napi_complete_done():

The new API uses a different contract. Interrupts are enabled before
completion. A false return from napi_complete_done_prepare() keeps
ownership. The caller must then call napi_complete_done_finish(), or
NAPIF_STATE_SCHED stays set.

Right now that requirement is only described in this kernel-doc.

> +bool napi_complete_done_prepare(struct napi_struct *n, int work_done,
> +				struct napi_completion *completion)
> +{
> +	return __napi_complete_done_prepare(n, work_done, true, completion);
> +}
> +EXPORT_SYMBOL_GPL(napi_complete_done_prepare);
> +
> +/**
> + * napi_complete_done_finish - finish NAPI completion after masking interrupts
> + * @n: NAPI context
> + * @completion: token passed to napi_complete_done_prepare()
> + *
> + * The caller must provide any device-specific interrupt ordering.
> + */
> +void napi_complete_done_finish(struct napi_struct *n,
> +			       struct napi_completion *completion)
> +{
> +	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
> +				 NAPIF_STATE_IN_BUSY_POLL)))
> +		return;
> +
> +	__napi_complete_done_finish(n, completion->timeout, false, false, NULL);
> +}

[Severity: Medium]

Can this second check of n->state disagree with the decision made in
__napi_complete_done_prepare()?

struct napi_completion only records the timeout. So finish() works out
which path prepare() took by testing NPSVC and IN_BUSY_POLL again. The
early return in __napi_complete_done_prepare() never writes
completion->timeout:

	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
				 NAPIF_STATE_IN_BUSY_POLL)))
		return false;

IN_BUSY_POLL is only set by whoever acquires SCHED, so it can't change
while this poll owns the instance.

NPSVC is different. poll_one_napi() sets and clears it while holding only
napi->poll_owner:

net/core/netpoll.c:poll_one_napi() {
	...
	if (test_and_set_bit(NAPI_STATE_NPSVC, &napi->state))
		return;
	...
	clear_bit(NAPI_STATE_NPSVC, &napi->state);
}

A regular poller only takes poll_owner if dev->npinfo was already set
when the poll started:

include/linux/netpoll.h:netpoll_poll_lock() {
	...
	if (dev && rcu_access_pointer(dev->npinfo)) {
		int owner = smp_processor_id();

		while (cmpxchg(&napi->poll_owner, -1, owner) != -1)
			cpu_relax();
	...
}

__netpoll_setup() publishes npinfo with a bare rcu_assign_pointer(). It
does not wait for polls that are already running.

Say netconsole, or a bond/bridge netpoll setup, attaches to a virtio_net
device while a poll is between prepare() and finish(). netpoll_poll_dev()
can then take poll_owner and toggle NPSVC inside that window.

In the first case, prepare() saw NPSVC clear and returned false because of
MISSED or defer_hard_irqs. By then it has already done list_del_init() and
set list_owner to -1, but SCHED is still set. If NPSVC gets set before
finish() runs, finish() returns early:

virtqueue_napi_complete()
  napi_complete_done_prepare()     <- returns false, SCHED kept
  virtqueue_disable_cb(vq)
                                   netpoll sets NPSVC
  napi_complete_done_finish()      <- returns early

Doesn't this leave SCHED set, callbacks masked, and the NAPI on no poll
list? The queue would stall, and a later napi_disable() in
virtnet_close() would spin forever.

The opposite case also looks wrong. If prepare() saw NPSVC set and took
the early return, the on-stack token in virtqueue_napi_complete() is
never written:

	struct napi_completion completion;

Now suppose NPSVC is cleared before finish() runs. Then
__napi_complete_done_finish() runs with an uninitialized
completion->timeout. It clears SCHED and can call hrtimer_start() with
that stack value:

	if (timeout)
		hrtimer_start(&n->timer, ns_to_ktime(timeout),
			      HRTIMER_MODE_REL_PINNED);

The old single-pass napi_complete_done() could not hit either case,
because its cmpxchg ran regardless of a late NPSVC change.

The window for concurrent polls during netpoll attach predates this
patch. What is new is that the decision is now split across two separate
reads of n->state.

Could prepare() record its decision in struct napi_completion, or always
initialize the token, and finish() use that instead of re-reading
n->state?

> +EXPORT_SYMBOL_GPL(napi_complete_done_finish);
> +
>  static void __skb_defer_free_flush(struct skb_defer_node *sdn, int budget)
>  {
>  	struct llist_node *free_list;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ad74886a8429a862c00d1e42f1dc746f2924b75f.1795108341.git.mst%40redhat.com
