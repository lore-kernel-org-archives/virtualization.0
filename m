Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526476;
	b=F4Oby+m2yoROSTo1G1GWoAuJhAoI8tzVgUEPNFqLDc7Rz+vCMRM07O9DSwR6Q8K2b5UB
	 iE3DZZq4KG1rv87QL5WiPBLYhbQLZZqjOujeNLQW4FyyRBwz8D8mGzvgob9DHgi8pXpyE
	 pH+xVSMRNXrVwaMJvvJwVwDzsag0MUkWGGcoV919zKfJUH3gpdps/l7WQi2Dxtbdos6jO
	 ck8ntEn8AU4zlm7wmtqH/3j58KT6kFxROv/NRxE/93SjDn1hGVAr+VZyZJ/x4t/lOQPa2
	 Av9udjOEpyGY6zJSu1zoybQaHxrcGGbp5rNXCIEw+f9umfe5h2x5QreyOlf+O4JCtRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5pUMH9I36rMJwVX2r0uC060lbA07xl1xnyP5zsVG3ro=;
	b=1GD7ja5C1WKMhol/vzui/+8kzopfPG0P1Hi9ASASaS9wMYax3rqyduSPKH3Mg3/qIymZ
	 qJRhb3PnxfkSD96nigXECKBbfp9hFcux/4ut4DdSbLhF5o1qHlCDexJRuxpBdHOoToye0
	 K+gwf6pWg2SyPsONiHrfQ6gYJoH+moAarZ38ilA3PrnYpjoAdK2oYTV21Y71LNTs00dMu
	 sVfeKbWWXqS5XOzBDgy8AkKUamCOvaW23XtOiEz9c0+dPymlbIGVglj++3f7XdGd0zCoA
	 4dVx7xpu9ZvCdAh8pJPbxzBSbyzMxn5vbNkN6c7GyAvL7/7H/Wv2QyswWVnBBpjdIIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x35x/d9x";
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB69606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 23:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB69606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x35x/d9x
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso467595137.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794526474; x=1795131274; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5pUMH9I36rMJwVX2r0uC060lbA07xl1xnyP5zsVG3ro=;
        b=x35x/d9xL+nXsslgNUt0o+ic1lBvwXMoFrPBO2E3D42o2rPyYZ5Z58N/hWF95BRuMH
         +5+85KCZZ6pBTKgTNJR42dKfQSHxBcW5t2PNSGgze/GuXzRsaGEnNWfQcg4Od48OLt6O
         IE2gl2VbTDlLlBq1wK/SAbI6s3oJcSkheWFicGWCdVSibE0tSLWn5dkHSC1IA92DUUag
         lz7M/gS+kf9aHISD2WG8h3FztkEtItuq/FzMa0luJWpf6LL+1zjPHGRG3oikk/H7NJTA
         OMyZ5589/uxkIenw4Qdmg1Zq2+JkxmMgTxka7ZowjnJ/VC8+hKzxkp+fkLp88w7GXokk
         JIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526474; x=1795131274;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pUMH9I36rMJwVX2r0uC060lbA07xl1xnyP5zsVG3ro=;
        b=AdX4WIOL0lrZuRJIq2yQ/IOUtKjJ+6buUZH2iSIaqW6dF4pe7dGLMOYSBd/pvtP9V7
         GFMx21Sm9xPYQAhxnNwNkd8aABydw076o6l152trKfFr5+Wfa/YKwWrz0KYKpTQFDDFQ
         4pgt+KyyOzwmOmsV5wb9QgkqKHGCDb2EUEfNVRKWMndV99VFjQ7s1sXlqJ86HFFVEUjj
         7d0W4LC8iAceWhWxNisB2FRhSSied/izBXUSmYdPckGdxeRTkDeLGSDT3xePgwMvr0jW
         SCz5M4PAXIXQ4pAJumvZaXAK5tPqOytnTx5di1AgAypqKHoqq8/fST/qM2WYPFaxeQKh
         eDUQ==
X-Forwarded-Encrypted: i=1; AL+hErE6ffun/yTk6WiaWczdUSzsDC8h+dDOlFz0rHkBMcwqNM8Cr1QzaJJif73QfjQh2SAS1pcu6QYgwWaWfLkg3Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jYzImmRq3wJc35iBfB3NUnWmUPesf+kH0pOCuhhbX6pV/pLXA
	rgGHlfIUFeQStJA3khQQvsMY/YqrNex7/lgQZ0i+V9GyRINRp65xb4Ag
X-Gm-Gg: AYBFou2RH4hLZ0HBboxOCHGpsG86E2CBpKvxIBoTKwa8GQUz4/ljp0W0Icxy5mVrjcd
	u+35CXxJ/w9EvFUeLh9Y2eNCRqFXKmn4kLT9hE2o8LrPIicwm/Tk/K70FMYm7Mm2h5dke5MeAG1
	4k6+cSauP/M4g+6VV/aTLDEL/KF8rG+/MMGV/J+Xor6HA5UNHy6dVUtZnJ+LUKxGKy1VtFAJW+W
	VyldvY1BTvnk3MeH+zqGFp+t01Vg770hurGufxfpXPEReziOjsJsDeR6OfvthDC1pjCHMYJI4MR
	gI6ii8Ywv4NnCkrtGIj+yvBp1YUSjjrgR8RwPmbAJiF36tqCocYc32utHjPU1IVpTZ2cUVOeWxB
	FNTi2JTETAhdhdmEZ/OoByclni8EcK81M4VTNiecfFT2/UnZy//A0UZ7kbblB4EcecF8Wt0ZFpa
	AqHC6yarLoaQfBfOydvjxFhl0Gxpbp3QBG/Et0YZnEG6BYQsSXRddLkUpFEfuTtwd1+ZaAaaS29
	wUfzvv8LPjEoaLY8FV7HgU9IqbBHA6vM+Q230bZZCLRD0odNqoqhua/11NW2fK5fIx00D3S4yEW
	ImtsM/ft8okfG7U2LPyCYA2HMthMr4PHSvVtcOnZnFfPCuOC7IAc9az+942NdzOWtNFnY6x6hmT
	HchoB9RhvIkdJF/kF3Y7t9NiLNphF72mv6nJF97hyp/7S8HdkskrZLdavLf6N/uE=
X-Received: by 2002:a05:6102:84c2:b0:7cc:56a:58e5 with SMTP id ada2fe7eead31-7d64db10101mr213232137.37.1794526474339;
        Thu, 12 Nov 2026 15:34:34 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c4b47aesm560592137.7.2026.11.12.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:34:33 -0800 (PST)
Date: Thu, 12 Nov 2026 18:34:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 shuah@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 maheshb@google.com, 
 peterpenkov96@gmail.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1220f3b31f685@gmail.com>
In-Reply-To: <20261111014208.1795777-3-antonio@mandelbit.com>
References: <20261111014208.1795777-1-antonio@mandelbit.com>
 <20261111014208.1795777-3-antonio@mandelbit.com>
Subject: Re: [PATCH net v5 2/2] selftests: net: add a vhost-net test for the
 tun NAPI queue bound
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antonio Quartulli wrote:
> Send 16k packets from vhost-net into a tap device with IFF_NAPI and
> netdev_max_backlog set to 8, in the three ways vhost-net passes packets
> to tun: batches of XDP buffers, one packet per sendmsg() with MSG_MORE,
> and zerocopy buffers. Check that excess packets are dropped and counted,
> that the queue keeps draining while vhost-net keeps sending, that every
> packet is either delivered or dropped, and that every buffer comes back
> to the ring. If a dropped zerocopy buffer is never completed, the test
> fails, and closing vhost-net then blocks until the buffer is released.
> 
> The zerocopy variant needs vhost_net loaded with experimental_zcopytx
> set and is skipped otherwise; with it, vhost-net does not batch and the
> batch variant is skipped instead.

That means it will be skipped as part of kselftests.

And as a misc device all tests may be skipped in minimal environments
if vhost-net is not autoloaded.

Maybe a .sh wrapper could resolve both.
 
> The test drives a minimal split virtqueue itself, in little-endian as
> VIRTIO_F_VERSION_1 requires. It needs root and CONFIG_VHOST_NET.
> netdev_max_backlog is global: the test lowers it only once setup has
> succeeded and restores it first in teardown, and should not run in
> parallel with other tests.
> 
> Written and tested with the help of an AI coding assistant (Claude
> Code).
> 
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
>  tools/testing/selftests/net/.gitignore  |   1 +
>  tools/testing/selftests/net/Makefile    |   1 +
>  tools/testing/selftests/net/config      |   1 +
>  tools/testing/selftests/net/tun_vhost.c | 409 ++++++++++++++++++++++++
>  4 files changed, 412 insertions(+)
>  create mode 100644 tools/testing/selftests/net/tun_vhost.c

That's a lot of code for a fairly narrow test.

Not that long ago I would have applauded all test coverage we can get.
But now that LLMs generate them instantly, not sure where to draw the
line.


> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 21412510ac26..aafd07910058 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -54,6 +54,7 @@ timestamping
>  tls
>  tools
>  tun
> +tun_vhost
>  txring_overwrite
>  txtimestamp
>  udp_splice_checksum
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 9180b9bec515..babb684d6f77 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -202,6 +202,7 @@ TEST_GEN_PROGS := \
>  	tap \
>  	tcp_port_share \
>  	tls \
> +	tun_vhost \
>  	udp_splice_checksum \
>  # end of TEST_GEN_PROGS
>  
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index d4416f8bdcfd..9afa82dea11d 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -135,6 +135,7 @@ CONFIG_TRACEPOINTS=y
>  CONFIG_TUN=y
>  CONFIG_USER_NS=y
>  CONFIG_VETH=y
> +CONFIG_VHOST_NET=m
>  CONFIG_VLAN_8021Q=y
>  CONFIG_VXLAN=m
>  CONFIG_XFRM_INTERFACE=m
> diff --git a/tools/testing/selftests/net/tun_vhost.c b/tools/testing/selftests/net/tun_vhost.c
> new file mode 100644
> index 000000000000..ed35435df90e
> --- /dev/null
> +++ b/tools/testing/selftests/net/tun_vhost.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Send packets from vhost-net into a tap device with IFF_NAPI and check
> + * that the NAPI queue is bounded by netdev_max_backlog: excess packets
> + * are dropped and counted, and every buffer is returned to the driver,
> + * zerocopy ones included.
> + *
> + * vhost-net passes packets to tun in three ways:
> + *  - batch: batches of XDP buffers (tun_xdp_one()), the default when the
> + *    socket send buffer is unlimited and zerocopy is disabled
> + *  - copy: one packet per sendmsg(), when the send buffer is limited
> + *  - zerocopy: one packet per sendmsg() with a ubuf_info to complete,
> + *    only with vhost_net experimental_zcopytx set (else skipped)
> + *
> + * Tun schedules NAPI after a batch, after the last of a series of MSG_MORE
> + * packets, once more than NAPI_POLL_WEIGHT (64) packets are queued, and
> + * when it drops a packet because the queue is full. With netdev_max_backlog
> + * below 64, the queue always overflows and only the last of these keeps it
> + * draining while the sender keeps sending.
> + *
> + * netdev_max_backlog is global: the test lowers it for the whole system
> + * while it runs, so it should not run in parallel with other tests.
> + *
> + * Author: Antonio Quartulli <antonio@mandelbit.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <endian.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <poll.h>
> +#include <sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/if.h>
> +#include <linux/if_arp.h>
> +#include <linux/if_ether.h>
> +#include <linux/if_tun.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ring.h>
> +#include <sys/eventfd.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +
> +#include "kselftest_harness.h"
> +
> +#define TV_IFNAME	"tvh0"
> +#define TV_RING_NUM	256
> +#define TV_BUF_SIZE	2048
> +#define TV_HDR_LEN	sizeof(struct virtio_net_hdr_v1)
> +#define TV_PKTS		(64 * TV_RING_NUM)
> +#define TV_BACKLOG	"8"
> +#define TV_TX_VQ	1
> +
> +static const unsigned char tv_mac_tap[ETH_ALEN] = { 2, 0, 0, 0, 0, 1 };
> +static const unsigned char tv_mac_dst[ETH_ALEN] = { 2, 0, 0, 0, 0, 2 };
> +static const unsigned char tv_mac_src[ETH_ALEN] = { 2, 0, 0, 0, 0, 3 };
> +
> +/* TX virtqueue, little-endian as negotiated with VIRTIO_F_VERSION_1 */
> +struct tv_ring {
> +	void *mem;
> +	struct vring vr;
> +	char *bufs;
> +	int kick;
> +	int call;
> +	unsigned short avail_idx;
> +	unsigned short used_idx;
> +	/* descriptors not owned by vhost: buffers may come back in any order */
> +	unsigned short free[TV_RING_NUM];
> +	int nfree;
> +};
> +
> +struct tv_stats {
> +	unsigned long long rx_packets;
> +	unsigned long long rx_dropped;
> +};
> +
> +static int tv_read_stats(const char *ifname, struct tv_stats *st)
> +{
> +	char line[512], *p;
> +	FILE *f;
> +	int ret = -1;
> +
> +	f = fopen("/proc/net/dev", "r");
> +	if (!f)
> +		return -1;
> +	while (fgets(line, sizeof(line), f)) {
> +		p = strchr(line, ':');
> +		if (!p)
> +			continue;
> +		*p = '\0';
> +		if (strcmp(line + strspn(line, " "), ifname))
> +			continue;
> +		if (sscanf(p + 1, "%*u %llu %*u %llu", &st->rx_packets,
> +			   &st->rx_dropped) == 2)
> +			ret = 0;
> +		break;
> +	}
> +	fclose(f);
> +	return ret;
> +}
> +
> +FIXTURE(tun_vhost)
> +{
> +	int backlog_fd;
> +	char backlog[32];
> +	int tap;
> +	int vhost;
> +	struct tv_ring ring;
> +};
> +
> +FIXTURE_VARIANT(tun_vhost)
> +{
> +	bool batch;
> +	bool limit_sndbuf;
> +	bool zerocopy;
> +	int pktlen;
> +};
> +
> +FIXTURE_VARIANT_ADD(tun_vhost, batch)
> +{
> +	.batch = true,
> +	.pktlen = 64,
> +};
> +
> +FIXTURE_VARIANT_ADD(tun_vhost, copy)
> +{
> +	.limit_sndbuf = true,
> +	.pktlen = 64,
> +};
> +
> +FIXTURE_VARIANT_ADD(tun_vhost, zerocopy)
> +{
> +	.limit_sndbuf = true,
> +	.zerocopy = true,
> +	.pktlen = 1000,
> +};
> +
> +/* vhost-net uses zerocopy for any non-zero value */
> +static bool tv_zerocopy_enabled(void)
> +{
> +	char buf[16] = {};
> +	int fd;
> +
> +	fd = open("/sys/module/vhost_net/parameters/experimental_zcopytx",
> +		  O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +	if (read(fd, buf, sizeof(buf) - 1) <= 0)
> +		buf[0] = '\0';
> +	close(fd);
> +	return atoi(buf) != 0;
> +}
> +
> +static int tv_vhost_setup(int vhost, int tap, struct tv_ring *r)
> +{
> +	struct vhost_vring_state state = { .index = TV_TX_VQ };
> +	struct vhost_vring_file file = { .index = TV_TX_VQ };
> +	struct vhost_vring_addr addr = { .index = TV_TX_VQ };
> +	size_t memsz = sizeof(struct vhost_memory) +
> +		       sizeof(struct vhost_memory_region);
> +	unsigned long long features;
> +	struct vhost_memory *mem;
> +	int ret;
> +
> +	if (ioctl(vhost, VHOST_SET_OWNER, NULL) ||
> +	    ioctl(vhost, VHOST_GET_FEATURES, &features) ||
> +	    !(features & (1ULL << VIRTIO_F_VERSION_1)))
> +		return -1;
> +	features = 1ULL << VIRTIO_F_VERSION_1;
> +	if (ioctl(vhost, VHOST_SET_FEATURES, &features))
> +		return -1;
> +
> +	/* buffer addresses are passed as is: map them 1:1 */
> +	mem = calloc(1, memsz);
> +	if (!mem)
> +		return -1;
> +	mem->nregions = 1;
> +	mem->regions[0].guest_phys_addr = (unsigned long)r->bufs;
> +	mem->regions[0].userspace_addr = (unsigned long)r->bufs;
> +	mem->regions[0].memory_size = TV_RING_NUM * TV_BUF_SIZE;
> +	ret = ioctl(vhost, VHOST_SET_MEM_TABLE, mem);
> +	free(mem);
> +	if (ret)
> +		return -1;
> +
> +	state.num = TV_RING_NUM;
> +	if (ioctl(vhost, VHOST_SET_VRING_NUM, &state))
> +		return -1;
> +	state.num = 0;
> +	if (ioctl(vhost, VHOST_SET_VRING_BASE, &state))
> +		return -1;
> +	addr.desc_user_addr = (unsigned long)r->vr.desc;
> +	addr.avail_user_addr = (unsigned long)r->vr.avail;
> +	addr.used_user_addr = (unsigned long)r->vr.used;
> +	if (ioctl(vhost, VHOST_SET_VRING_ADDR, &addr))
> +		return -1;
> +	file.fd = r->kick;
> +	if (ioctl(vhost, VHOST_SET_VRING_KICK, &file))
> +		return -1;
> +	file.fd = r->call;
> +	if (ioctl(vhost, VHOST_SET_VRING_CALL, &file))
> +		return -1;
> +	file.fd = tap;
> +	return ioctl(vhost, VHOST_NET_SET_BACKEND, &file);
> +}
> +
> +static int tv_ring_init(struct tv_ring *r)
> +{
> +	int i;
> +
> +	if (posix_memalign((void **)&r->bufs, 4096, TV_RING_NUM * TV_BUF_SIZE))
> +		return -1;
> +	memset(r->bufs, 0, TV_RING_NUM * TV_BUF_SIZE);
> +
> +	/* every buffer: zeroed vnet header + IPv4 frame for another host,
> +	 * which the stack drops without counting it in rx_dropped
> +	 */
> +	for (i = 0; i < TV_RING_NUM; i++) {
> +		unsigned char *eth = (unsigned char *)r->bufs +
> +				     i * TV_BUF_SIZE + TV_HDR_LEN;
> +
> +		memcpy(eth, tv_mac_dst, ETH_ALEN);
> +		memcpy(eth + ETH_ALEN, tv_mac_src, ETH_ALEN);
> +		eth[12] = ETH_P_IP >> 8;
> +		eth[13] = ETH_P_IP & 0xff;
> +		eth[14] = 0x45;
> +		r->free[i] = i;
> +	}
> +	r->nfree = TV_RING_NUM;
> +
> +	if (posix_memalign(&r->mem, 4096, vring_size(TV_RING_NUM, 4096)))
> +		return -1;
> +	memset(r->mem, 0, vring_size(TV_RING_NUM, 4096));
> +	vring_init(&r->vr, TV_RING_NUM, r->mem, 4096);
> +
> +	r->kick = eventfd(0, EFD_NONBLOCK);
> +	r->call = eventfd(0, EFD_NONBLOCK);
> +	return r->kick < 0 || r->call < 0 ? -1 : 0;
> +}
> +
> +/* save the global netdev_max_backlog, to restore it in teardown */
> +static int tv_backlog_save(int *fd, char *old, size_t size)
> +{
> +	ssize_t n;
> +
> +	/* only visible from init_net: keep it open across unshare() */
> +	*fd = open("/proc/sys/net/core/netdev_max_backlog", O_RDWR);
> +	if (*fd < 0)
> +		return -1;
> +	n = read(*fd, old, size - 1);
> +	if (n <= 0)
> +		return -1;
> +	old[n] = '\0';
> +	return 0;
> +}
> +
> +FIXTURE_SETUP(tun_vhost)
> +{
> +	struct ifreq ifr = {};
> +	int hdrlen = TV_HDR_LEN;
> +	int sndbuf = 1 << 20;
> +	int fd;
> +
> +	self->backlog_fd = -1;
> +	self->vhost = open("/dev/vhost-net", O_RDWR);
> +	if (self->vhost < 0)
> +		SKIP(return, "no /dev/vhost-net");
> +	if (variant->zerocopy && !tv_zerocopy_enabled())
> +		SKIP(return, "vhost_net experimental_zcopytx not enabled");
> +	if (variant->batch && tv_zerocopy_enabled())
> +		SKIP(return, "vhost_net does not batch with zerocopy");
> +
> +	ASSERT_EQ(tv_backlog_save(&self->backlog_fd, self->backlog,
> +				  sizeof(self->backlog)), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
> +
> +	self->tap = open("/dev/net/tun", O_RDWR);
> +	ASSERT_GE(self->tap, 0);
> +	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR | IFF_NAPI;
> +	memcpy(ifr.ifr_name, TV_IFNAME, sizeof(TV_IFNAME));
> +	ASSERT_EQ(ioctl(self->tap, TUNSETIFF, &ifr), 0);
> +	ASSERT_EQ(ioctl(self->tap, TUNSETVNETHDRSZ, &hdrlen), 0);
> +	if (variant->limit_sndbuf)
> +		ASSERT_EQ(ioctl(self->tap, TUNSETSNDBUF, &sndbuf), 0);
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	ASSERT_GE(fd, 0);
> +	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
> +	memcpy(ifr.ifr_hwaddr.sa_data, tv_mac_tap, ETH_ALEN);
> +	ASSERT_EQ(ioctl(fd, SIOCSIFHWADDR, &ifr), 0);
> +	ASSERT_EQ(ioctl(fd, SIOCGIFFLAGS, &ifr), 0);
> +	ifr.ifr_flags |= IFF_UP;
> +	ASSERT_EQ(ioctl(fd, SIOCSIFFLAGS, &ifr), 0);
> +	close(fd);
> +
> +	ASSERT_EQ(tv_ring_init(&self->ring), 0);
> +	ASSERT_EQ(tv_vhost_setup(self->vhost, self->tap, &self->ring), 0);
> +}
> +
> +FIXTURE_TEARDOWN(tun_vhost)
> +{
> +	/* restore first: closing vhost may block if buffers are not returned */
> +	if (self->backlog_fd >= 0) {
> +		if (pwrite(self->backlog_fd, self->backlog,
> +			   strlen(self->backlog), 0) < 0)
> +			TH_LOG("cannot restore netdev_max_backlog to %s",
> +			       self->backlog);
> +		close(self->backlog_fd);
> +	}
> +	close(self->vhost);
> +	close(self->tap);
> +}
> +
> +/* queue up to @n buffers, return how many */
> +static int tv_post(struct tv_ring *r, int pktlen, int n)
> +{
> +	unsigned long long one = 1;
> +	int i;
> +
> +	for (i = 0; i < n && r->nfree; i++) {
> +		unsigned short id = r->free[--r->nfree];
> +
> +		r->vr.desc[id].addr = htole64((unsigned long)r->bufs +
> +					      id * TV_BUF_SIZE);
> +		r->vr.desc[id].len = htole32(TV_HDR_LEN + pktlen);
> +		r->vr.desc[id].flags = 0;
> +		r->vr.avail->ring[r->avail_idx % TV_RING_NUM] = htole16(id);
> +		r->avail_idx++;
> +	}
> +	__atomic_store_n(&r->vr.avail->idx, htole16(r->avail_idx),
> +			 __ATOMIC_RELEASE);
> +	if (i && write(r->kick, &one, sizeof(one)) != sizeof(one))
> +		return -1;
> +	return i;
> +}
> +
> +/* reap returned buffers, waiting up to @ms for at least one */
> +static int tv_reap(struct tv_ring *r, int ms)
> +{
> +	struct pollfd pfd = { .fd = r->call, .events = POLLIN };
> +	unsigned short used;
> +	unsigned long long v;
> +	int n = 0;
> +
> +	for (;;) {
> +		used = le16toh(__atomic_load_n(&r->vr.used->idx,
> +					       __ATOMIC_ACQUIRE));
> +		while (r->used_idx != used) {
> +			struct vring_used_elem *e;
> +
> +			e = &r->vr.used->ring[r->used_idx % TV_RING_NUM];
> +			r->free[r->nfree++] = le32toh(e->id);
> +			r->used_idx++;
> +			n++;
> +		}
> +		if (n)
> +			return n;
> +		if (ms <= 0 || poll(&pfd, 1, 100) < 0)
> +			return 0;
> +		if (pfd.revents & POLLIN && read(r->call, &v, sizeof(v)) < 0)
> +			return -1;
> +		ms -= 100;
> +	}
> +}
> +
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
> +		ASSERT_GE(n, 0);
> +		if (!n) {
> +			TH_LOG("%d of %d buffers not returned",
> +			       posted - reaped, posted);
> +			ASSERT_GT(n, 0);
> +		}
> +		reaped += n;
> +	}
> +
> +	ASSERT_EQ(tv_read_stats(TV_IFNAME, &after), 0);
> +	delivered = after.rx_packets - before.rx_packets;
> +	dropped = after.rx_dropped - before.rx_dropped;
> +	TH_LOG("sent %d, delivered %llu, dropped %llu", TV_PKTS, delivered,
> +	       dropped);
> +	/* bounded, */
> +	EXPECT_GT(dropped, 0);
> +	/* still draining, */
> +	EXPECT_GE(delivered, TV_PKTS / 64);
> +	/* and every packet accounted for */
> +	EXPECT_EQ(delivered + dropped, TV_PKTS);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.56.0
> 


