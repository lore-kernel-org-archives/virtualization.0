Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953832;
	b=Xrmcc0ShiGqVfHaKOTGGnO5DiXCnbl2qFXgD6iXDYaHtG9xL2dGDR6dJTloI0zAlSI5H
	 2pwL9qui7nxv1nFKl8f2Z1rfVdBIGjpPkvmZ707BgceEqmimJkZUfaEcpvJ0Qe3BlzuFz
	 2ZitY4jA0Hs7QSLZV0BlU669u0olNX/eQDbWUuiyDEXIqiGciSThuUZzkThgO6iqIT3O7
	 s/vJEm1e+a2gzPwfeoFSryvgfOUOGZctPl1foO5/48siFNlPpejXCurc9QTECNK1DvriU
	 Oz/5Ht9jJuBeHA5XGSSePmvj6jh5pwY/upaZcB0WwRFy0l2hVJiWS3ul45e1Tmk6bUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953832;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HZmOEPvPxYerhC/fCvV29tXtjTOQjkEufMh7FEDGzeY=;
	b=uu1pShMa5H0NjbYsJdAIcZrof7pG5bEDoj9P4+bABmxMmWIkYFixcPRbZLllWPED+cXZ
	 4mb6ipr5Rt6RvLW9AoCciNUpiDHX+YkCyij6Tps4aZROVoydLcN1EzoO72uqKDtTFE/hS
	 /ryJcnwDxZDsGhHXPf+6vsXhdvsbCB8UVq1AQApJx100T18pH2xzc0os1tfM8fFaNDPtV
	 QQ5D9qd/10CwRxmRHC3lbzTUvVZiZnEX7dg99YSvN0oKLTLfpRmW40OZT2wPGRO2SZTHo
	 pvKgjzjLXGNskD2PygzlvwCc8yk5wjp/NC1Nr33UTD/lhDMeQHk61gHgEJb42ZqyOcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWHuT+Gm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E8606A880;
	Tue, 17 Nov 2026 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWHuT+Gm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB7E1F000C5;
	Tue, 17 Nov 2026 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953832;
	bh=HZmOEPvPxYerhC/fCvV29tXtjTOQjkEufMh7FEDGzeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nWHuT+GmznUHvzPMjK3A5hMsIa5xkMTH2p+O6c0TqGgm/xW6TJRqWTPA+LxdmxbkZ
	 tllXWoMDFwVvyyeOTSL3xv8m4BhlKJC9jw+a/8C5aG95bcxVapEJDEIfORBA2bF40u
	 wYxkA7Lpk1uZyf09PRUkZKVGcjB1Wc/DBp/k8odC4iEVGL4tZ9WygrkMckKVeoarUu
	 7J5e7YyndkKKqfHyPBC9w63U1IyL8jD7jatCHeQ9hxS2MwhRGgo3uyiaZ1/ymtrKlg
	 7ROsaIOrbdPg1X7o/6ibkWMQn1Q3xMmBwipb+6oVYjlGuQn4L6n32jVpM+fDd/HpMb
	 TEEPiciyIlXEg==
Subject: Re: [PATCH net v6 2/2] selftests: net: add a vhost-net test for the
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
Date: Tue, 17 Nov 2026 22:17:10 +0000
Message-ID: <179495383061.3136.10369646169201165375@kernel.org>
In-Reply-To: <20261113212237.1742984-3-antonio@mandelbit.com>
References: <20261113212237.1742984-3-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/tun_vhost.c, TEST_F(tun_vhost,
  napi_queue_bounded) opens /proc/sys/net/core/netdev_max_backlog at…
- [Medium] napi_queue_bounded() writes "8" to the system-wide
  /proc/sys/net/core/netdev_max_backlog (line 198) and restores it only…
- [Medium] tools/testing/selftests/net/tun_vhost.sh does not reliably
  restore vhost_net's module parameter.
- [Medium] In the zerocopy variant, when ASSERT_LT(ms, 5000) fires
  because buffers were not returned, __bail() runs FIXTURE_TEARDOWN,…
- [Low] The test is named after the tun NAPI queue bound, but it cannot
  catch a regression in the poll half of that fix.
- [Low] The comment in tun_vhost.c FIXTURE_SETUP (lines 126-128) says the
  IPv4 frame for another host is one "which the stack drops without…

--

selftests: net: add a vhost-net test for the tun NAPI queue bound

This adds a kselftest that feeds an IFF_NAPI tap device from vhost-net
with netdev_max_backlog lowered to 8, covering XDP batches, MSG_MORE
single packets and zerocopy buffers. It checks that excess packets are
dropped and counted, that the queue keeps draining and that every buffer
comes back. A wrapper script loads vhost_net and, if possible, reloads it
with experimental_zcopytx=1 for the zerocopy variant.

> diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/selftests/net/tun_vhost.c
> new file mode 100644
> index 0000000000000..c9bf6d07cc265
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.c
> @@ -0,0 +1,222 @@

[ ... ]

> +FIXTURE_SETUP(tun_vhost)
> +{

[ ... ]

> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	ASSERT_EQ(ioctl(fd, SIOCGIFFLAGS, &ifr), 0);
> +	ifr.ifr_flags |= IFF_UP;
> +	ASSERT_EQ(ioctl(fd, SIOCSIFFLAGS, &ifr), 0);
> +	close(fd);

[Severity: Low]
Would this test notice a regression in the poll side of the tun NAPI
queue bound, the "dequeue at most budget" change in tun_napi_receive()?

The tap is brought up here, but threaded NAPI is never turned on through
/sys/class/net/<ifname>/threaded. So the NAPI poll runs inline from the
vhost worker's local_bh_enable(), serialised with the writer, and the
queue is already empty when the next packet arrives.

Turning on threaded NAPI would not be enough either. netdev_max_backlog=8
is below the NAPI budget of 64. The old behaviour (splice the whole
queue, process budget, splice the rest back) would process everything it
took out and never put anything back.

The checks at the end of napi_queue_bounded():

    EXPECT_GT(dropped, 0);
    EXPECT_GE(rx, PKTS / 16);
    EXPECT_EQ(rx + dropped, PKTS);

would all still pass if that tun_napi_receive() change were reverted. The
drop threshold and the schedule-NAPI-on-drop changes do look covered.

> +
> +	/* each buffer: vnet header and an IPv4 frame for another host, which
> +	 * the stack drops without counting it
> +	 */

[Severity: Low]
Is this comment accurate? The destination MAC 02:00:00:00:00:02 makes
eth_type_trans() mark the frame PACKET_OTHERHOST, and ip_rcv_core()
counts it:

net/ipv4/ip_input.c:ip_rcv_core() {
    ...
	if (skb->pkt_type == PACKET_OTHERHOST) {
		dev_core_stats_rx_otherhost_dropped_inc(skb->dev);
		drop_reason = SKB_DROP_REASON_OTHERHOST;
		goto drop;
	}
    ...
}

dev_get_stats() reports this as rx_otherhost_dropped. The drop is
counted, just not in rx_dropped, which is the only counter the test
reads.

[ ... ]

> +FIXTURE_TEARDOWN(tun_vhost)
> +{
> +	/* restore first: closing vhost blocks if buffers are not returned */
> +	if (self->bl_fd >= 0 &&
> +	    pwrite(self->bl_fd, self->bl, strlen(self->bl), 0) < 0)
> +		TH_LOG("cannot restore netdev_max_backlog to %s", self->bl);
> +	close(self->vhost);

[Severity: Medium]
In the zerocopy variant, can this close() leave the test process stuck
in D state for good?

When ASSERT_LT(ms, 5000) fires because buffers were not returned, the
teardown runs while skbs in the tap's NAPI queue still hold zerocopy
ubufs. The last fput of the vhost fd then goes through:

vhost_net_release()
  vhost_net_flush()
    vhost_net_ubuf_put_and_wait()
      wait_event(ubufs->wait, !atomic_read(&ubufs->refcount));

That wait is uninterruptible and has no timeout. Nothing in the teardown
schedules the tap's NAPI, and restoring netdev_max_backlog does not do it
either. The tun file can only be released, which purges the queue, after
sockfd_put(tx_sock). In vhost_net_release() that call comes after the
flush:

	vhost_net_stop(n, &tx_sock, &rx_sock);
	vhost_net_flush(n);
	...
	if (tx_sock)
		sockfd_put(tx_sock);

One concrete case is a regression in the schedule-NAPI-on-drop part of
the tun fix. The final non-MSG_MORE packet would be dropped without a
napi_schedule(), and several zerocopy skbs would stay queued.

The harness SIGKILL on timeout cannot reap such a task. It keeps
/dev/vhost-net and the tap open, keeps vhost_net from being unloaded
(which also breaks the restore in tun_vhost.sh), and triggers hung task
warnings.

Would kicking the queue before close(self->vhost) avoid this? For
example, a write() to the tap fd without MSG_MORE would make
tun_get_user() call napi_schedule().

> +	close(self->tap);
> +}
> +
> +TEST_F(tun_vhost, napi_queue_bounded)
> +{

[ ... ]

> +	/* lowered only here, so that a failed setup leaves it alone */
> +	self->bl_fd = open("/proc/sys/net/core/netdev_max_backlog", O_RDWR);
> +	ASSERT_GE(self->bl_fd, 0);

[Severity: Medium]
What happens when this runs outside init_net? netdev_max_backlog is in
net_core_table, which is only registered for init_net:

net/core/sysctl_net_core.c:sysctl_core_init() {
    ...
	register_net_sysctl(&init_net, "net/core", net_core_table);
    ...
}

The per-netns table does not include it. In any other network namespace
the file is missing, so this open() fails with ENOENT.

run_kselftest.sh -n runs each test in a fresh netns through
run_in_netns() in kselftest/runner.sh. FIXTURE_SETUP still passes there,
because /dev/vhost-net, /dev/net/tun, TUNSETIFF and SIOCSIFFLAGS all work
inside the namespace. In that mode the test reports FAIL rather than
SKIP every time.

Should this SKIP when the sysctl is not present?

> +	n = pread(self->bl_fd, self->bl, sizeof(self->bl) - 1, 0);
> +	ASSERT_GT(n, 0);
> +	self->bl[n] = '\0';
> +	ASSERT_EQ(pwrite(self->bl_fd, "8", 1, 0), 1);
> +
> +	/* post the whole ring, wait for every buffer to come back, repeat */
> +	for (n = 0; n < PKTS; n += RING) {
> +		idx += RING;
> +		__atomic_store_n(&self->vr.avail->idx, htole16(idx),
> +				 __ATOMIC_RELEASE);
> +		ASSERT_EQ(eventfd_write(self->kick, 1), 0);
> +		for (ms = 0; le16toh(__atomic_load_n(&self->vr.used->idx,
> +						     __ATOMIC_ACQUIRE)) != idx;
> +		     ms++) {
> +			ASSERT_LT(ms, 5000) TH_LOG("buffers not returned");
> +			usleep(1000);
> +		}
> +	}

[Severity: Medium]
Can netdev_max_backlog stay at 8 for the whole system if this loop runs
past the harness timeout?

The only restore is in FIXTURE_TEARDOWN, which runs only in the forked
test child. With FIXTURE_TEARDOWN, unlike FIXTURE_TEARDOWN_PARENT,
_teardown_parent is false, so the parent-side teardown does nothing.

TEST_F uses the default 30 second timeout. On timeout, __wait_for_test()
does:

		kill(-(t->pid), SIGKILL);

so no cleanup runs in the child.

The 5000 x usleep(1000) bound resets for each of the PKTS / RING = 64
rings. The body can therefore run for about 320 seconds without any
assertion firing. A drain that is slow but still making progress, for
example on a debug or KASAN kernel, would hit the timeout.

tun_vhost.sh does not save or restore the value either. Later tests and
workloads on the host would then run with netdev_max_backlog=8.

[ ... ]

> diff --git a/tools/testing/selftests/net/tun_vhost.sh b/tools/testing/selftests/net/tun_vhost.sh
> new file mode 100755
> index 0000000000000..d92707de5e29e
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.sh
> @@ -0,0 +1,23 @@

[ ... ]

> +modprobe -q vhost_net
> +[ -e /dev/vhost-net ] || exit $ksft_skip
> +
> +./tun_vhost
> +ret=$?
> +
> +zc=$(cat "$param" 2>/dev/null)
> +if [ "$zc" = 0 ] && modprobe -q -r vhost_net 2>/dev/null; then
> +	modprobe vhost_net experimental_zcopytx=1 &&
> +		{ ./tun_vhost -v zerocopy || ret=1; }
> +	modprobe -q -r vhost_net
> +	modprobe vhost_net experimental_zcopytx="$zc"
> +fi

[Severity: Medium]
Can experimental_zcopytx still be 1 after this script exits?

The parameter is read-only at runtime:

drivers/vhost/net.c:
module_param(experimental_zcopytx, int, 0444);

so only a reload can change it back. The result of the second
modprobe -q -r is not checked. Removal fails if something still holds
/dev/vhost-net open, such as a tun_vhost child stuck in
vhost_net_release() as described above, or another vhost user that
started in the meantime. In that case the next modprobe finds the module
already loaded and returns success without changing anything.

The script also sets no EXIT or INT trap, so interrupting it during the
zerocopy run skips the restore.

A separate point: the first modprobe -q vhost_net always loads the
module, and nothing unloads it afterwards if it was not loaded before.

> +exit $ret

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113212237.1742984-1-antonio%40mandelbit.com
