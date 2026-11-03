Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715774;
	b=gSKwySDlLuaqT48XMIdekFsZtoF3cgT/8/bBsxSoZXeIwCqp9VLtSDjiRnkih3fvZEzM
	 BobGoVmHjJ76O+l5fvihBI4cBixfanPOHb5Sw/nqe6fMR5ppuhrpS+v8M+ai3WrB3mxug
	 X3Pzl7dhHUfYJPW3nJPFC24oe+eRQ2b7DyL4F+IHgPfEVYIE21bltfEQr2FXkfgvjjVMM
	 H0T6twz+sEfGra2Z044CLZXJpySdxOLxHVf3mxSbWnq7yoxXQEhhKPJwMyNvtdpiBY8oh
	 enNFqaW63hjp1n+H/ZA5ix8BPqwkem1NDsIBx4rBA6lL9XeKStAz0U+j23ZCgcWwNQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715774;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=UwIyMDhSrSKTyt+83psKeyoXfPEnExDxP5qigMbsr7I=;
	b=GjHMnjN122kx1ghaG+qbzIkv5gyA65BWslfXuPmZRm29pyibsbUhJqqCaZIO/Klgv2SS
	 IK5yBpSfWFZqPbLOgclilmTRh/smuJKyKYcEVAsYkP9HBBunUiGAFeUe9anGdPVzBSR93
	 Al54DK9uNqOej1neteskmIRnNmGsttDudDliSvBYCzpeb3WgE90PXQMN5lYb76Pqalr9t
	 OIyOTUxEGccPTO/bHo/cZORetAFlfxryVUF1Uwly1ZlAF9m5bdPgVpLcw/3MQPLxwJqmT
	 PBC6YYIAKvrDv4tpfnNaqXbuwn51+YHpiKlJt+6pkqdBz//Rl9WOndHxFQb5QijT9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=0ZiGcmx+;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7A606D82D
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E7A606D82D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=0ZiGcmx+
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jJrPs0rXMz9sQr;
	Tue, 03 Nov 2026 15:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793715761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UwIyMDhSrSKTyt+83psKeyoXfPEnExDxP5qigMbsr7I=;
	b=0ZiGcmx+HoTGuhRSoPS/d3lLFVtKiratO5FO6+OLCUC6eYcoPrzzgJ36WVDGz5ojAFYpxV
	SkmdfBD7iFpP9dKnPjkrIZbWRtjrHEDbckU+eD01ELidi9pvXSASXRtJaUHGELLkKU9vrl
	89A/OrwHA2jhk3t6FUQ2rT9vt3G2j5r0TuvoGlS0D24v9trFNQpxoSFe6ITvSZ7OlEZPFn
	F5kV2+hqHNfq/DR/PNUbrckcdcshJBv9jpzhJBwsFTP9HCH4P62sxlYFOGsmtD80who8Bw
	n2LUfiQo8LTUXt8j9nn+A4VFPkTWG7KMhRkH8e2AdhvBVmJuVLkfbBTV1o/xiA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
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
Subject: [PATCH net v4 0/2] tun: bound the NAPI receive queue
Date: Tue,  3 Nov 2026 15:22:28 +0100
Message-ID: <20261103142232.1869185-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJrPs0rXMz9sQr

With IFF_NAPI, tun queues written packets for NAPI on an unbounded
list, which an unprivileged user can grow until the system runs out of
memory. Patch 1 bounds it by netdev_max_backlog; patch 2 adds a
kselftest for the vhost-net paths into that queue.

v4:
- Keep the poll's leftovers on a separate queue, like process_backlog():
  v3 did not bound the queue when the poll ran on another CPU (Sashiko)
- Schedule NAPI when dropping: with netdev_max_backlog below
  NAPI_POLL_WEIGHT, MSG_MORE senders (vhost-net) stalled the queue
  (Sashiko)
- Use goto free_skb for the locked drop (Willem)
- Add a vhost-net kselftest (patch 2); the tun kselftest passes (Willem)
- Cc vhost, kselftest and XDP maintainers and the Fixes author/acker

v3: https://lore.kernel.org/netdev/20261031231444.1528758-1-antonio@mandelbit.com/
- Also bound the sendmsg() paths, which share the queue: zerocopy
  buffers are completed when dropped early, and the batched XDP buffers
  of tun_xdp_one() are covered too (Willem)
- Drop the IFF_NAPI_FRAGS exclusion (Willem)
- Recheck under the queue lock before queueing (Willem)
- Compare with > like enqueue_to_backlog() (Willem)
- Keep the includes sorted (Willem)
- Add the reproducer and a testing statement to the commit message

v2: https://lore.kernel.org/netdev/20261030152540.1409884-1-antonio@mandelbit.com/
- Cc netdev and the maintainers

Testing, in an x86-64 VM with 1 and 2 vCPUs:
- Reproducer from patch 1, 15 seconds, 500 and 3000 iptables rules:
  memory use stays flat, no OOM; forwarding rate unchanged (112962
  packets in 3 s without the patch, 113822 with it).
- tun_vhost (patch 2), with vhost_net experimental_zcopytx=0 and =1:
  passes with patch 1. Without it, every variant fails (nothing is
  dropped); removing the tun_xdp_one() check fails the batch variant,
  and removing the zerocopy completion fails the zerocopy one.
- tun kselftest: pass:91 fail:0 xfail:12, as without the patch.

Notes:
- Affected since 943170998b20 (v4.15). Based on net/main 94cea342e891.
- Mitigation: disallow unprivileged user namespaces or restrict
  access to /dev/net/tun.

Antonio Quartulli (2):
  tun: bound the NAPI receive queue
  selftests: net: add a vhost-net test for the tun NAPI queue bound

 drivers/net/tun.c                       |  82 +++++-
 tools/testing/selftests/net/Makefile    |   1 +
 tools/testing/selftests/net/config      |   1 +
 tools/testing/selftests/net/tun_vhost.c | 361 ++++++++++++++++++++++++
 4 files changed, 431 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/net/tun_vhost.c

-- 
2.56.0

