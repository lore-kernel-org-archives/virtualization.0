Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794075605;
	b=dFTky/Z/zko9BPjKQZsrJWnLQH70paL6BGPkmVxexzNURSwle5sfZz/ovqaEKoLmcb6A
	 +KSqsXLsWM5bOdK8ESVAevW1R94otsa3CHHJFmeMkgdQ6e2x7s49XCgSKvxnr/FdONovp
	 CTTpj/9TuGE5CU5SbLazNDQvvDssR2IbGB5BJJGi8JdmZi5oL12WeAEHXdZSZepya7cyk
	 y/XfSrer+I5uMCBPD9f+CUu1ISsVNmMtfIGsfVu8bdN1jdVUu8DDF0cogRqCNaVgtXHqf
	 kGVgMxiwQjz5t6XlP7Nt1LKXLU2Tq+N/wwh6ZonJawqK6CBN/ptanskjIA+ZTTH3qjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794075605;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PcbE8178oPntoCIYGDf9fPZ/08pG7HuTIHnH8G0wBy8=;
	b=e8z8cUAhgaibzY32HISS4NFfLgGwCXHMsFPqEwyB+l/voOElOvylbtN37s+S0k/km8t9
	 Aep0la4/d1hDc2goNusEGUXD6qPWDJDTomqikG7V7XEQyTTUZxcsOhUISjT4rX+XUC47I
	 MK+QmMKjoKNXm8xTlxCYvsHk4bZ4zCP0iUGlgq2UAF2JRs68GACWT53M4pzyay6CF9aJv
	 1sJKLJ6hle0wgJbTI3WDUWhlQe7H9Q8O3RU4c9OAYpCjHKAR6CPJfzE8zN5rzq1AvRY1l
	 qdOiZYggJ5H82Gi4C3c9MwpfE5Oglxku234bpgWJZ/ATZZBZXbf4BGvNYhqjNnF3D0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fj2IJqBY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4D606A33C;
	Sat,  7 Nov 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fj2IJqBY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891A61F008A1;
	Sat,  7 Nov 2026 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794075603;
	bh=PcbE8178oPntoCIYGDf9fPZ/08pG7HuTIHnH8G0wBy8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fj2IJqBYgWE+zkUQgddAHx6jh+yZh66ta7bk7lRnzqN93NUOzUipI735u+Yb5YMTU
	 cFQ9k1K5Zh/cBabfnQKtDlS9+T2/JBnXpW3TI6QuISP3ldZ3H5xWu32IAb7hOAOhvI
	 Xl/tELaGVmKrV/LevrASr2S4Dy4xfbJ6ZGI/PApqnB0sgdDh800m8L7qanjsqYtQdZ
	 ElkovyigC+LL2oydhe6/BqdpwlqSLJF7glVLn2MuUD/0Ym7EVVFgboyv4nvNrrbbMv
	 FRsFL9LwCRg0XPQO/fkh+OGPIQy5ASafwi88bHx/7/t3yNxn7IxI6aoG2800yPghRG
	 heyvouo5i6umw==
Subject: Re: [PATCH net v4 2/2] selftests: net: add a vhost-net test for the
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
Date: Sat, 07 Nov 2026 18:20:02 +0000
Message-ID: <179407560211.994134.6676423379852045885@kernel.org>
In-Reply-To: <20261103142232.1869185-3-antonio@mandelbit.com>
References: <20261103142232.1869185-3-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] FIXTURE_SETUP(tun_vhost) sets the global sysctl
  net.core.netdev_max_backlog to 8 early on: it writes TV_BACKLOG with…
- [Medium] The commit message says the zerocopy variant checks that every
  buffer comes back to the ring, "which it does not if a dropped…
- [Medium] tv_vhost_setup() negotiates only VIRTIO_F_VERSION_1.
- [Low] The file header comment in tun_vhost.c says "Tun schedules NAPI
  only after a batch, or after the last of a series of MSG_MORE packets".
- [Low] tv_post() picks the next descriptor as id = avail_idx %
  TV_RING_NUM and treats it as free whenever avail_idx - used_idx <…
- [Low] tv_zerocopy_enabled() reads the first byte of
  /sys/module/vhost_net/parameters/experimental_zcopytx and returns `c…
- [Low] The test sets the system-wide net.core.netdev_max_backlog
  (net_hotdata.max_backlog, read by tun_napi_queue_full() at…
- [Low] selftests: net: missing tun_vhost entry in
  selftests/net/.gitignore

--

selftests: net: add a vhost-net test for the tun NAPI queue bound

This adds a kselftest that runs its own minimal split virtqueue through
vhost-net into an IFF_NAPI tap device, with netdev_max_backlog set to 8.
It covers the batch, copy and zerocopy transmit paths. It checks that
excess packets are dropped and counted, that the queue keeps draining,
and that every buffer comes back to the ring.

> diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/selftests/net/tun_vhost.c
> new file mode 100644
> index 0000000000000..dbf76d324a7e2
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*

[ ... ]

> + * Tun schedules NAPI only after a batch, or after the last of a series of
> + * MSG_MORE packets, so with a small netdev_max_backlog the queue always
> + * overflows. It must keep draining while the sender keeps sending.

[Severity: Low]
Is this description of tun accurate? tun_get_user() also schedules NAPI
when the queue grows past NAPI_POLL_WEIGHT:

drivers/net/tun.c:tun_get_user() {
    ...
		if (!more || queue_len > NAPI_POLL_WEIGHT)
			napi_schedule(&tfile->napi);
    ...
}

The queue-full drop paths in tun_get_user() and tun_xdp_one() also call
napi_schedule().

TV_BACKLOG (8) is below NAPI_POLL_WEIGHT (64), so the queue_len trigger
never fires in this test. The "still draining" check is really testing
the scheduling done on the drop paths.

Could the comment mention both of these dependencies?

[ ... ]

> +static bool tv_zerocopy_enabled(void)
> +{
> +	char c = '0';
> +	int fd;
> +
> +	fd = open("/sys/module/vhost_net/parameters/experimental_zcopytx",
> +		  O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +	if (read(fd, &c, 1) != 1)
> +		c = '0';
> +	close(fd);
> +	return c == '1';
> +}

[Severity: Low]
Does this check match how vhost-net reads the parameter?
experimental_zcopytx is an int module parameter, and vhost-net enables
zerocopy for any nonzero value:

drivers/vhost/net.c:vhost_sock_zcopy() {
	return unlikely(experimental_zcopytx) &&
		sock_flag(sock->sk, SOCK_ZEROCOPY);
}

vhost_net_init() also only tests if (experimental_zcopytx).

With experimental_zcopytx=2 or -1, the zerocopy variant is skipped. The
batch variant still runs, but handle_tx() goes through
handle_tx_zerocopy(). The batch variant therefore passes without ever
taking the XDP batch path.

> +
> +static void tv_vhost_setup(struct __test_metadata *_metadata,
> +			   FIXTURE_DATA(tun_vhost) *self)
> +{

[ ... ]

> +	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_OWNER, NULL), 0);
> +	ASSERT_EQ(ioctl(self->vhost, VHOST_GET_FEATURES, &features), 0);
> +	ASSERT_TRUE(features & (1ULL << VIRTIO_F_VERSION_1));
> +	features = 1ULL << VIRTIO_F_VERSION_1;
> +	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_FEATURES, &features), 0);

[Severity: Medium]
Does this work on big-endian hosts? Once VIRTIO_F_VERSION_1 is
negotiated, vhost treats every ring field as little-endian:

drivers/vhost/vhost.c:vhost_init_is_le() {
	vq->is_le = vhost_has_feature(vq, VIRTIO_F_VERSION_1)
		|| virtio_legacy_is_little_endian();
}

tv_post() stores desc[id].addr, desc[id].len, desc[id].flags,
avail->ring[id] and avail->idx in native byte order. tv_reap() reads
used->idx the same way. Neither does any htole64/32/16 or le16toh
conversion.

On s390x or ppc64 BE, vhost would see a byte-swapped avail->idx, and
descriptor addresses that do not translate through the single memory
region. tv_reap() would then time out and report "N of M buffers not
returned", even though tun is behaving correctly.

Should the ring accesses be converted to little-endian, or the test be
skipped on big-endian?

[ ... ]

> +FIXTURE_SETUP(tun_vhost)
> +{

[ ... ]

> +	/* global, and only visible from init_net: keep it open to restore */
> +	self->backlog_fd = open("/proc/sys/net/core/netdev_max_backlog",
> +				O_RDWR);

[Severity: Low]
This changes the system-wide netdev_max_backlog for the whole run, and
the unshare(CLONE_NEWNET) below does not contain it. tun reads the
global value:

drivers/net/tun.c:tun_napi_queue_full() {
	return skb_queue_len_lockless(queue) >
	       READ_ONCE(net_hotdata.max_backlog);
}

enqueue_to_backlog() reads the same global value.

If other networking tests or workloads run on the same kernel at the
same time, every netdev in every netns gets an 8 packet per-CPU backlog.
Could loopback, netif_rx or RPS traffic in those tests then drop
packets and fail intermittently?

The standard kselftest runner is sequential, so this only affects
parallel or custom runners.

> +	ASSERT_GE(self->backlog_fd, 0);
> +	n = read(self->backlog_fd, self->backlog, sizeof(self->backlog) - 1);
> +	ASSERT_GT(n, 0);
> +	self->backlog[n] = '\0';
> +	ASSERT_EQ(pwrite(self->backlog_fd, TV_BACKLOG, strlen(TV_BACKLOG), 0),
> +		  strlen(TV_BACKLOG));
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNET), 0);

[Severity: Medium]
Is netdev_max_backlog restored if a later step in setup fails? Every
ASSERT after this pwrite can abort setup. That includes unshare(), the
tun open and ioctls, the SIOCSIFHWADDR/SIOCGIFFLAGS/SIOCSIFFLAGS
ioctls, both posix_memalign() calls, both eventfd() calls, and every
vhost ioctl in tv_vhost_setup().

In kselftest_harness.h, __TEST_F_IMPL clears no_teardown only after
setup succeeds:

	fixture_name##_setup(_metadata, self, variant->data);
	/* Let setup failure terminate early. */
	if (_metadata->exit_code)
		_exit(0);
	*_metadata->no_teardown = false;

When an ASSERT fails during setup, __bail() calls teardown_fn(). That
sees no_teardown still set, skips FIXTURE_TEARDOWN, and then calls
abort(). There is no FIXTURE_TEARDOWN_PARENT either. FIXTURE_TEARDOWN
also returns early when self->tap < 0, before the restore.

Would the host then stay at netdev_max_backlog=8? The next variant's
setup would read "8" and save it as the original value, so the real
value would be lost for the rest of the run.

That seems to contradict the commit message:

  "and restores netdev_max_backlog, which is global, on exit."

[ ... ]

> +FIXTURE_TEARDOWN(tun_vhost)
> +{
> +	if (self->tap < 0)
> +		return;
> +	/* waits for outstanding zerocopy buffers */
> +	close(self->vhost);
> +	close(self->tap);
> +	if (pwrite(self->backlog_fd, self->backlog, strlen(self->backlog),
> +		   0) < 0)
> +		TH_LOG("cannot restore netdev_max_backlog to %s",
> +		       self->backlog);
> +	close(self->backlog_fd);
> +}

[Severity: Medium]
What happens here in the failure the zerocopy variant is meant to
catch? Per the commit message, a buffer does not come back "if a
dropped zerocopy buffer is never completed". In that case tv_reap()
returns 0 after 5 seconds, ASSERT_GT(n, 0) fails, and this teardown
runs.

close(self->vhost) then waits uninterruptibly with no timeout:

vhost_net_release()
  vhost_net_flush()
    vhost_net_ubuf_put_and_wait()
      wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));

vhost_net_release() drops its tx_sock reference only after that flush:

	if (tx_sock)
		sockfd_put(tx_sock);

So closing the tap fd cannot let tun purge the queued skbs and release
the ubufs.

Would the process then sit in D state, where the harness timeout's
SIGKILL cannot reap it? The netdev_max_backlog restore after the two
close() calls would never run. The result would be a hung task warning,
a host left at 8, and pinned vhost/tap objects, rather than a clean
FAIL.

> +
> +/* queue up to @n buffers, return how many */
> +static int tv_post(FIXTURE_DATA(tun_vhost) *self, int pktlen, int n)
> +{
> +	int inflight = (unsigned short)(self->avail_idx - self->used_idx);
> +	unsigned long long one = 1;
> +	int i;
> +
> +	for (i = 0; i < n && inflight < TV_RING_NUM; i++, inflight++) {
> +		unsigned int id = self->avail_idx % TV_RING_NUM;

[Severity: Low]
Does this assume vhost returns buffers in order? The descriptor id
comes from avail_idx alone. tv_reap() only consumes used->idx and never
reads used->ring[].id.

In the zerocopy variant, handle_tx_zerocopy() puts copy-path heads on
the used ring right away. Zerocopy heads wait for their ubuf to
complete:

drivers/vhost/net.c:handle_tx_zerocopy() {
    ...
		if (!zcopy_used)
			vhost_add_used_and_signal(&net->dev, vq, head, 0);
		else
			vhost_zerocopy_signal_used(net, vq);
    ...
}

This test produces both kinds of head. The tun queue-full drop path
completes ubufs with success=false, which raises tx_zcopy_err and makes
vhost_net_tx_select_zcopy() return false for a while.
vhost_exceeds_maxpend() has the same effect.

The ring is kept full. Could the next tv_post() then rewrite and
re-post the oldest slot while its zerocopy head is still pending? That
would put the same head in flight twice, which the split ring rules do
not allow. The test would also lose track of which buffer was never
returned.

The rewritten descriptor has identical contents, so no data corruption
is expected here.

> +
> +		self->vr.desc[id].addr = (unsigned long)self->bufs +
> +					 id * TV_BUF_SIZE;
> +		self->vr.desc[id].len = TV_HDR_LEN + pktlen;
> +		self->vr.desc[id].flags = 0;
> +		self->vr.avail->ring[id] = id;
> +		self->avail_idx++;
> +	}

[ ... ]

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -203,6 +203,7 @@ TEST_GEN_PROGS := \
>  	tap \
>  	tcp_port_share \
>  	tls \
> +	tun_vhost \
>  	udp_splice_checksum \
>  # end of TEST_GEN_PROGS
>  

[Severity: Low]
Should tun_vhost also be added to
tools/testing/selftests/net/.gitignore? The neighbouring
TEST_GEN_PROGS entries, such as tap, tcp_port_share, tls and
udp_splice_checksum, all have matching .gitignore entries. This patch
adds tun_vhost to TEST_GEN_PROGS but does not add a .gitignore entry
for it.

As a result, an in-tree build of the net selftests leaves an
untracked tools/testing/selftests/net/tun_vhost binary in the working
tree, and it shows up in git status.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103142232.1869185-1-antonio%40mandelbit.com
