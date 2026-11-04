Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802178;
	b=ea4+TABwHMvFbGpVDU59/YlqxHSwbX8/FdvgUIX4r2p2EUDhNtNUUqdCIOZxy9q154MX
	 sSqs23vQAcRqJreb5c0mCWh8r3KGNYTmFgoH9NujRvpaWXrPG59eE8F+PJlciuihEXG4K
	 4mt9M7zp6CSP11K9QzNmgETD0kaSqa679feS1Jl/EN1SeblPCqcFwJsQrO3OqhopEf3GK
	 t2QhK1Cl5tuaCMr6wBj/owCTLi9pzL00iGAno/vuZe1eN6J8CyYiOJ4mzYSpd/QqpP+aH
	 o0CJ/+gSZnPSif9s2SiZ+wv1DM1QEYTo/Zsb7YfchBNQirALYZFkcnc0r3U12EjZhAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802178;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i2bMK/jqQkCRu3q1LO8vNTLJ40L/bfvtBNu6ZJx6jI4=;
	b=tzTSE2+eDr8kldAcaCghrgjY9dchiG8p0temQ0/hLgFtk1vBacyBByKUsBn48ghGlS+s
	 tYUDY6t2gnDqdUeOEyAimJzYCMVgdhQp+CMezIbVoeMm3PuNBIphlp8E6Ci/WDfreMr7Y
	 aookQePLpB0NeO3fd4yOBU/Oz24F4W8E5Vt8+nDd8oXrcwebucDKzQwav4bgm40El7NB4
	 kkH7uhq4DLJiDFHLFJyEZAfTF2Hrl5TPogE48vinOWKCkGODDnoTW6eZm1a0xvMaE3pzq
	 ekSAuRsVqCmqSwpYLQj0RFbcUR2t+iK9VqCHNwREE9b8mmIQ2xYhDNmkYMXXHol8F5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNdda6mU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5565606A328;
	Wed,  4 Nov 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNdda6mU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F61C1F00919;
	Wed,  4 Nov 2026 14:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802177;
	bh=i2bMK/jqQkCRu3q1LO8vNTLJ40L/bfvtBNu6ZJx6jI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNdda6mUSu9j0EzEPNEYOyzDAFWmpPuu4L/AE+SJet/hBA+dRQnheqgOx0Zg+22yB
	 gqwGQQejNhhoTKKv5jYpZaxLAOGz+7UXUQJg23szwubD/xAr5xt40539Gfyh9rwC5y
	 GH7S5V7v6w11015arzqUPB1QxHAMTIE9ekjZjyTSAk8wqsP4UPtq+g348RXl/xDiUe
	 Vdecqe2msH4fuz6E3xLAn5RrVptCb6NHU2krmuKwBmq96U8Gld1DRf1uwusooZqyfY
	 l73Ln9E3RKI1t+oEeY36Qxaw+u+t2DcLBeeAg7HyQSufNfXwFykOic/MQlI0o1hU6Y
	 22oVeC44XeOfQ==
Message-ID: <sashiko-outbox-197426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Quartulli" <antonio@mandelbit.com>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103142232.1869185-3-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
 <20261103142232.1869185-3-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:22:57 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests: net: native-endian vring access in tv_post() and tv_r=
eap()
- [Medium] selftests: net: global netdev_max_backlog leaked on setup fail o=
r teardown
- [Low] selftests: net: missing tun_vhost entry in selftests/net/.gitignore
--

commit 428d9005b1a3d09435bb7a0e0e6230535e135403
Author: Antonio Quartulli <antonio@mandelbit.com>

selftests: net: add a vhost-net test for the tun NAPI queue bound

This commit adds a tun_vhost selftest that sends packets from vhost-net int=
o a
tap device with IFF_NAPI and netdev_max_backlog set to 8 across batch, copy,
and zerocopy variants to verify that excess packets are dropped, the queue
continues draining, and all ring buffers are returned.

> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 9180b9bec5155..babb684d6f77a 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -202,6 +202,7 @@ TEST_GEN_PROGS :=3D \
>  	tap \
>  	tcp_port_share \
>  	tls \
> +	tun_vhost \
>  	udp_splice_checksum \
>  # end of TEST_GEN_PROGS

[Severity: Low]
This isn't a bug, but since tun_vhost is added to TEST_GEN_PROGS in
tools/testing/selftests/net/Makefile, should tun_vhost also be added to
tools/testing/selftests/net/.gitignore like the other generated test binari=
es
in this directory?

> diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/self=
tests/net/tun_vhost.c
> new file mode 100644
> index 0000000000000..dbf76d324a7e2
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.c
[ ... ]
> +static void tv_vhost_setup(struct __test_metadata *_metadata,
> +			   FIXTURE_DATA(tun_vhost) *self)
> +{
> +	struct vhost_vring_state state =3D { .index =3D TV_TX_VQ };
> +	struct vhost_vring_file file =3D { .index =3D TV_TX_VQ };
> +	struct vhost_vring_addr addr =3D { .index =3D TV_TX_VQ };
> +	size_t memsz =3D sizeof(struct vhost_memory) +
> +		       sizeof(struct vhost_memory_region);
> +	unsigned long long features;
> +	struct vhost_memory *mem;
> +
> +	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_OWNER, NULL), 0);
> +	ASSERT_EQ(ioctl(self->vhost, VHOST_GET_FEATURES, &features), 0);
> +	ASSERT_TRUE(features & (1ULL << VIRTIO_F_VERSION_1));
> +	features =3D 1ULL << VIRTIO_F_VERSION_1;
> +	ASSERT_EQ(ioctl(self->vhost, VHOST_SET_FEATURES, &features), 0);
[ ... ]
> +FIXTURE_SETUP(tun_vhost)
> +{
> +	struct ifreq ifr =3D {};
> +	int hdrlen =3D TV_HDR_LEN;
> +	int sndbuf =3D 1 << 20;
> +	ssize_t n;
> +	int i, fd;
> +
> +	self->tap =3D -1;
> +	self->vhost =3D open("/dev/vhost-net", O_RDWR);
> +	if (self->vhost < 0)
> +		SKIP(return, "no /dev/vhost-net");
> +	if (variant->zerocopy && !tv_zerocopy_enabled())
> +		SKIP(return, "vhost_net experimental_zcopytx not enabled");
> +	if (variant->batch && tv_zerocopy_enabled())
> +		SKIP(return, "vhost_net does not batch with zerocopy");
> +
> +	/* global, and only visible from init_net: keep it open to restore */
> +	self->backlog_fd =3D open("/proc/sys/net/core/netdev_max_backlog",
> +				O_RDWR);
> +	ASSERT_GE(self->backlog_fd, 0);
> +	n =3D read(self->backlog_fd, self->backlog, sizeof(self->backlog) - 1);
> +	ASSERT_GT(n, 0);
> +	self->backlog[n] =3D '\0';
> +	ASSERT_EQ(pwrite(self->backlog_fd, TV_BACKLOG, strlen(TV_BACKLOG), 0),
> +		  strlen(TV_BACKLOG));
> +
> +	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
> +
> +	self->tap =3D open("/dev/net/tun", O_RDWR);
> +	ASSERT_GE(self->tap, 0);
[ ... ]
> +	tv_vhost_setup(_metadata, self);
> +}
> +
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
Can this leave the host-global /proc/sys/net/core/netdev_max_backlog sysctl
clobbered at 8 if setup fails or if teardown hangs waiting for zerocopy
buffers?

In FIXTURE_SETUP(tun_vhost), TV_BACKLOG is written to self->backlog_fd befo=
re
unshare(CLONE_NEWNET), open("/dev/net/tun"), TUNSETIFF, socket setup, and
tv_vhost_setup(). In tools/testing/selftests/kselftest_harness.h
(__TEST_F_IMPL), _metadata->no_teardown remains true until FIXTURE_SETUP
returns, so if any subsequent ASSERT_* fails during setup, teardown is skip=
ped
entirely (and FIXTURE_TEARDOWN also returns early when self->tap < 0).

In addition, in FIXTURE_TEARDOWN(tun_vhost), close(self->vhost) is called
before restoring self->backlog_fd. If the zerocopy variant fails because a
dropped zerocopy packet never completes its ubuf_info, close(self->vhost) ->
vhost_net_release() -> vhost_net_flush() -> vhost_net_ubuf_put_and_wait() w=
ill
block in uninterruptible sleep until the test harness kills the process with
SIGKILL, preventing the pwrite() restore from running.

Should netdev_max_backlog be written only at the end of FIXTURE_SETUP(tun_v=
host)
after all fallible setup steps succeed, and restored in
FIXTURE_TEARDOWN(tun_vhost) before calling close(self->vhost)?

> +/* queue up to @n buffers, return how many */
> +static int tv_post(FIXTURE_DATA(tun_vhost) *self, int pktlen, int n)
> +{
> +	int inflight =3D (unsigned short)(self->avail_idx - self->used_idx);
> +	unsigned long long one =3D 1;
> +	int i;
> +
> +	for (i =3D 0; i < n && inflight < TV_RING_NUM; i++, inflight++) {
> +		unsigned int id =3D self->avail_idx % TV_RING_NUM;
> +
> +		self->vr.desc[id].addr =3D (unsigned long)self->bufs +
> +					 id * TV_BUF_SIZE;
> +		self->vr.desc[id].len =3D TV_HDR_LEN + pktlen;
> +		self->vr.desc[id].flags =3D 0;
> +		self->vr.avail->ring[id] =3D id;
> +		self->avail_idx++;
> +	}
> +	__atomic_store_n(&self->vr.avail->idx, self->avail_idx,
> +			 __ATOMIC_RELEASE);
> +	if (i && write(self->kick, &one, sizeof(one)) !=3D sizeof(one))
> +		return -1;
> +	return i;
> +}
> +
> +/* reap returned buffers, waiting up to @ms for at least one */
> +static int tv_reap(FIXTURE_DATA(tun_vhost) *self, int ms)
> +{
> +	struct pollfd pfd =3D { .fd =3D self->call, .events =3D POLLIN };
> +	unsigned short used;
> +	unsigned long long v;
> +
> +	for (;;) {
> +		used =3D __atomic_load_n(&self->vr.used->idx, __ATOMIC_ACQUIRE);
> +		if (used !=3D self->used_idx) {
> +			int n =3D (unsigned short)(used - self->used_idx);
> +
> +			self->used_idx =3D used;
> +			return n;
> +		}

[Severity: Medium]
Will tv_post() and tv_reap() fail on big-endian architectures such as s390x?

In tv_vhost_setup(), the test negotiates VIRTIO_F_VERSION_1 via
ioctl(self->vhost, VHOST_SET_FEATURES, &features), which causes vhost to
interpret all vring fields as little-endian (vq->is_le =3D true in
vhost_init_is_le()).

However, tv_post() stores self->vr.desc[id].addr, self->vr.desc[id].len,
self->vr.avail->ring[id], and self->vr.avail->idx in CPU-native byte order,
and tv_reap() loads and subtracts self->vr.used->idx in CPU-native byte ord=
er.
On big-endian hosts, vhost will byte-swap those native values when reading
avail->idx and descriptors, and tv_reap() will misread used->idx.

Should these vring accesses use htole64(), htole32(), htole16(), and le16to=
h()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103142232.1869=
185-1-antonio@mandelbit.com?part=3D2
