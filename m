Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728579;
	b=D8bP+M2kCXO7yF9v3ezEfCdxFNERPJ7rZO641hRHdiALMl1BieE1XFI8VtChqulFvGlc
	 8vDxCfjuru+07RInhEwbjDgnQzscTn6UD/zS9II2Un06jDmP7AJ8gnmLJ0QjI5rOILoKk
	 LJGKznEEyyuprrkEwGZ9wjSutPxW2pfg0dMha7gY68yI6FTTpjsWZMlk5p/fmP+KKu7k1
	 wk7T15u7Y9yBXofoDvgSiBHtN2LEOEzrJq3eDt/b/pg8YRojuUGdMquA0d6qci60Zo+di
	 MQoKM+oUDu2GGNRPfMaonRfxZUMiwL1j+kfP92QYsDaQ49dzVkJJPz6L8+C4228IoNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728579;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BnAgR70dI64mrGytYJ8dh2rslfwpurTWIUgVQFHKtog=;
	b=3HS7e7Gtp9qcRt38aWgqp5Y99TxUzjXVWj5pzt4T6UZFgFE63/QrCQOrz6D4RnG/tMTt
	 ZRD1sZ3AhgQ36OwluduK65Kn8YXT+7SY/akyhBZO5ZhEZxbvSSQmONyWSS6BG+7qiJsgK
	 RKxn51Y0G1HQz7hPpAkBDstysOVmCXzOa4142b9t5RRLuD4ugOloAH6R6QNVEiOyNjsEu
	 19fnPe3CCSWYTDLgjorDYhrwiUJbisaIUTN3l8M+gWF0+NIIT1y7q8RcJMcdbgr/oY2tt
	 JKXDNIIARegBpxMY8P26SOFhp56EcWZIu6XW/cjQ0ZECf/voKWFroW2V/5odowIVlEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jG9ILaf6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE01606A331;
	Sun, 15 Nov 2026 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jG9ILaf6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB231F000C4;
	Sun, 15 Nov 2026 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728579;
	bh=BnAgR70dI64mrGytYJ8dh2rslfwpurTWIUgVQFHKtog=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jG9ILaf62hiV+h0J94yiV39nP/SghgM7S/2YiZWx+1zAzXhiq/g1Enhw9CmLSAUIL
	 6aFMio48HgSxsdKFO7R5GYifcBypAfbuLDya6inq0PRuqy3JZ5W+Zc5WED7MYNhttX
	 rVIVdLhiVR2Px34l4uAzQ0gDMM3hyvjbWsUhQjVblx4EuulKClK+WZY0ZSZSJKWN1p
	 ic0Ck20pRhXSjsIxCS9/Uxy5iUJgQulgRTAqtniNMTHTgZ5+OCX3E6Bz33PkwtkQhw
	 PbZvhp8stOxmAUvccijHFo3PMqDA4SsWR0/AD7eVj7NKnjq014orhjn67cAkdK6S4m
	 n+K3/4G0uYVuA==
Subject: Re: [PATCH net v5 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Date: Sun, 15 Nov 2026 07:42:57 +0000
Message-ID: <179472857762.2199510.12782959547104801304@kernel.org>
In-Reply-To: <20261111014208.1795777-3-antonio@mandelbit.com>
References: <20261111014208.1795777-3-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] napi_queue_bounded lowers the system-wide
  net.core.netdev_max_backlog to 8 (tun_vhost.c:379).
- [Low] Claim: the zerocopy variant only tests a dropped zerocopy buffer
  by chance, because vhost_net_tx_select_zcopy() turns zerocopy off once…
- [Low] The commit message says that if a dropped zerocopy buffer is
  never completed, 'closing vhost-net then blocks until the buffer is…
- [Low] The header comment in tun_vhost.c (lines 15-19) says that with
  netdev_max_backlog below 64, only the NAPI schedule done on a queue-…
- [Low] Claim: tv_reap() (tun_vhost.c:353-357) trusts used-ring ids and
  used->idx from vhost, so a bad id or an inflated count could overflow…

--

selftests: net: add a vhost-net test for the tun NAPI queue bound

This adds a kselftest that sends 16k packets from vhost-net into an
IFF_NAPI tap device with netdev_max_backlog lowered to 8. It covers the
batch, copy and zerocopy paths. It checks that excess packets are dropped
and counted, that the queue keeps draining, and that every buffer comes
back to the ring.

> to the ring. If a dropped zerocopy buffer is never completed, the test
> fails, and closing vhost-net then blocks until the buffer is released.

[Severity: Low]
Is "blocks until the buffer is released" accurate for the case this test
is meant to catch? A buffer that is never completed is also never
released.

FIXTURE_TEARDOWN(tun_vhost) calls close(self->vhost). That goes through
vhost_net_release()->vhost_net_flush()->vhost_net_ubuf_put_and_wait():

	wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));

This is an uninterruptible wait with no timeout.

The harness still records a failure. After 30s, __wait_for_test() sends
SIGKILL to the process group and prints "Test terminated by timeout".

The child stuck in D state still holds its inherited stdout/stderr,
though. So the tap_prefix side of the pipeline in run_one() in
kselftest/runner.sh never sees EOF, and run_kselftest.sh hangs. The stuck
process also pins the vhost_net module and triggers hung task warnings.

Could the commit message say that on an affected kernel this variant
leaves an unkillable process and can hang the runner?

> diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/selftests/net/tun_vhost.c
> new file mode 100644
> index 0000000000000..ed35435df90eb
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.c
> @@ -0,0 +1,409 @@

[ ... ]

> + * Tun schedules NAPI after a batch, after the last of a series of MSG_MORE
> + * packets, once more than NAPI_POLL_WEIGHT (64) packets are queued, and
> + * when it drops a packet because the queue is full. With netdev_max_backlog
> + * below 64, the queue always overflows and only the last of these keeps it
> + * draining while the sender keeps sending.

[Severity: Low]
Is this accurate for the batch variant?

tun_sendmsg() handles the whole TUN_MSG_PTR batch under
local_bh_disable(). It schedules NAPI whenever anything was queued:

	if (tfile->napi_enabled && queued > 0)
		napi_schedule(&tfile->napi);

local_bh_enable() follows, which runs the NET_RX softirq inline and drains
the queue. Each batch therefore starts with an empty queue. About 9 of
every 64 XDP buffers get queued, so queued > 0 is always true.

That means the drop-time napi_schedule() in tun_xdp_one() never runs in
the case it exists for, where nothing in the batch gets queued:

	if (tfile->napi_enabled &&
	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
		napi_schedule(&tfile->napi);

If that schedule were removed, delivery would stay around 2300 of 16384.
That is well above TV_PKTS / 64.

So can EXPECT_GE(delivered, TV_PKTS / 64) catch a regression of that
schedule in the batch variant?

The copy and zerocopy variants do seem to depend on the drop-time schedule
in tun_get_user(). There the last packet without MSG_MORE is itself
dropped before it can reach the !more napi_schedule().

[ ... ]

> +FIXTURE_VARIANT_ADD(tun_vhost, zerocopy)
> +{
> +	.limit_sndbuf = true,
> +	.zerocopy = true,
> +	.pktlen = 1000,
> +};

[Severity: Low]
Does this variant always reach the dropped zerocopy path?
vhost_net_tx_select_zcopy() turns zerocopy off once errors build up:

	return !net->tx_flush &&
		net->tx_packets / 64 >= net->tx_zcopy_err;

>From the current code, it looks like it does reach that path on every run:

- VHOST_NET_SET_BACKEND resets tx_packets and tx_zcopy_err, and
  vhost_net_tx_packet() resets them again every 1024 packets.
- tv_post() publishes all 256 descriptors at once, so MSG_MORE is set on
  every packet but the last.
- Packet 10 is then dropped in tun_get_user() while tx_zcopy_err is still
  0:

	if (tfile->napi_enabled &&
	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
		...
			uarg->ops->complete(NULL, uarg, false);

So the coverage claim in the commit message appears to hold, and no change
seems needed here. The test just doesn't assert that a zerocopy drop
actually happened.

[ ... ]

> +/* reap returned buffers, waiting up to @ms for at least one */
> +static int tv_reap(struct tv_ring *r, int ms)
> +{

[ ... ]

> +		while (r->used_idx != used) {
> +			struct vring_used_elem *e;
> +
> +			e = &r->vr.used->ring[r->used_idx % TV_RING_NUM];
> +			r->free[r->nfree++] = le32toh(e->id);

[Severity: Low]
This isn't a bug, but tv_reap() stores the id written by the kernel into
free[] without checking it against TV_RING_NUM. tv_post() later uses that
id to index vr.desc[].

vhost_get_vq_desc() already rejects heads outside the ring:

	if (unlikely(head >= vq->num)) {
		vq_err(vq, "Guest says index %u > %u is available",

Used entries also only come from heads the test made available. So with a
correct kernel this can't overflow free[], and a broken vhost could at
worst crash the test process itself.

[ ... ]

> +TEST_F(tun_vhost, napi_queue_bounded)
> +{
> +	struct tv_stats before, after;
> +	unsigned long long delivered, dropped;
> +	int posted = 0, reaped = 0, n;
> +
> +	ASSERT_EQ(tv_read_stats(TV_IFNAME, &before), 0);
> +	/* lowered only now, so that a failed setup leaves it alone */
> +	ASSERT_EQ(pwrite(self->backlog_fd, TV_BACKLOG, strlen(TV_BACKLOG), 0),
> +		  strlen(TV_BACKLOG));
> +
> +	while (reaped < TV_PKTS) {
> +		n = tv_post(&self->ring, variant->pktlen, TV_PKTS - posted);
> +		ASSERT_GE(n, 0);
> +		posted += n;
> +		n = tv_reap(&self->ring, 5000);

[Severity: Medium]
What restores the global net.core.netdev_max_backlog if the test is killed
before FIXTURE_TEARDOWN(tun_vhost) runs?

That teardown only runs in the forked test child. With a plain
FIXTURE_TEARDOWN, the parent-side teardown_fn(true, ...) call in
__TEST_F_IMPL() does nothing.

On the default 30s harness timeout, __wait_for_test() does:

	kill(-(t->pid), SIGKILL);

That kills the whole process group, wrapper and child, without running any
teardown. SIGINT, SIGSEGV or an OOM kill of the child have the same
effect.

The loop has no overall deadline either. Each tv_reap(..., 5000) returns
as soon as one buffer comes back, and at least 64 rounds are needed. A
slow kernel that keeps returning buffers slowly can therefore run past 30s
without any ASSERT firing.

In that case the host is left with netdev_max_backlog set to 8 until a
reboot or manual reset. This affects later tests in the same run and any
traffic that uses the per-CPU backlog.

FIXTURE_TEARDOWN_PARENT alone would not help, because the wrapper is in
the killed process group too. Would a per-loop deadline well under the
harness timeout, and/or TEST_F_TIMEOUT, make sure the restore path runs?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111014208.1795777-1-antonio%40mandelbit.com
