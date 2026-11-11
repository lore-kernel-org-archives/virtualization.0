Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361344;
	b=w2QLT9w+uBKwade5azUd0OsL8pL+0PuH9cWM3SA3icMpkdNzK2yOVC+UK5uAiL+Q79NN
	 kNajVEKHoVBp97U/vAc1oN8+LtP4svW8i3p3xHLFa1dC/GJjHEPwT0+TzGKvPThwIogqq
	 ksvgWcsJF/LBWjdK+s9v7hOpAJazJGge0RCKAwGubaleuCcms1d+gfx6i22TGcIF+3f+X
	 p3oMLPwCgoi4jwszyP9ekDD9lJxUYfmhP0cmI3/xItBIZjIjGV5ArNSzjtUVC0v/5Jot7
	 fyIAD5Eo4urnAc6fspPq9foRMfJ/qzE0jSxI7E1hTjwJckg0T2D4W48QAwUuXwWjIbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361344;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=g3YMKqL7Zig4N1u5uNQ3udwfmaIwcfVBjpYpAiJaW48=;
	b=XPcVDvlqCMLsDVOFAr2lEOl1zS3Q7EJ8XL+SSIyp2weXxaaQQerXVHfzeuVA6PCKWmUu
	 /7cEyl3FRODuupNl/UwSLnv1VZMlnksIDPFuU2ueet/CM3y7//YK7ao/RFjHxIjCMTtcU
	 ZS3leiqOH4wJsmHiuBUUlfyRYFFyiUb3ArzXSEGCoPPBQtsW/ULrYAzIQDbkddmSIm2ZD
	 Evq3nWkGFWk3LkyVkuGtsoC7ZHyguN8peDtTmOev1viOe9ghcWQ0TiUCJHk6AcAb2DBBF
	 gcclRHDeVAMu7xnbrM6nUuZCh/jtpokzvdnfXrNkiNY9wtChOBPv/bm1DHTjXsyyvow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jcbc3NCE;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89371606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 01:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89371606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jcbc3NCE
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jPR8k6g8tzFq3n;
	Wed, 11 Nov 2026 02:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794361335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g3YMKqL7Zig4N1u5uNQ3udwfmaIwcfVBjpYpAiJaW48=;
	b=jcbc3NCE1+Oc8wULKs2CBF/KuPayvlqKhR4DOPiHiYjyzllL+uijry5Kv8lBl9D4e7MPyi
	aHXPrkPhtA4dwzBYNPLj3hMQdrOfi1kIfLzr2pjfEW5On/xL8HQQi7qp15Qet7TBtSAXqE
	UtVe/HzvYMqvlNnd8Wttq5vwshTz3Hsft+HkJHYcATsHZyMuMON2S9MK3tQrDJROpmyQ/+
	ULdYk5K4VMC1kscFTJmDGJX8Yo6GMOTTAsbXXP0BajQ3y3rJINBpo3RbLT8ETgC7BM5AQQ
	bGPFJbk72UowPJcNqyHftxU2UGZDueJvrNJFqTRLp5wzMRImKfk6Yvu4o11TdA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
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
Subject: [PATCH net v5 0/2] tun: bound the NAPI receive queue
Date: Wed, 11 Nov 2026 02:42:01 +0100
Message-ID: <20261111014208.1795777-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jPR8k6g8tzFq3n

With IFF_NAPI, tun queues written packets for NAPI on an unbounded
list, which an unprivileged user can grow until the system runs out of
memory. Patch 1 bounds it by netdev_max_backlog; patch 2 adds a
kselftest for the vhost-net paths into that queue.

v5:
- Take at most budget packets in the NAPI poll instead of keeping the
  leftovers on a separate queue (Willem)
- Keep only the lockless check, before allocating, also in
  tun_xdp_one() (Willem)
- Say that an OOM is still possible with large packets and many queues,
  if hard to reach in practice (Sashiko)
- selftest: little-endian ring, buffers returned in any order, lower
  netdev_max_backlog only after setup and restore it first, any non-zero
  experimental_zcopytx, .gitignore entry (Sashiko)
- Rebase on net, which conflicted in selftests/net/config

v4: https://lore.kernel.org/netdev/20261103142232.1869185-1-antonio@mandelbit.com/
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

Testing, in an x86-64 VM with 1 and 2 vCPUs, on net ead744fd1ce0:
- Reproducer from patch 1, 15 seconds, 500 and 3000 iptables rules,
  1400 to 65000-byte packets: memory use stays flat, no OOM; forwarding
  rate unchanged (152577 packets in 3 s without the patch, 151277 with
  it).
- tun_vhost (patch 2), with vhost_net experimental_zcopytx=0 and =1:
  passes with patch 1. Without it, every variant fails (nothing is
  dropped); removing the tun_xdp_one() check fails the batch variant,
  removing the zerocopy completion fails the zerocopy one, and removing
  the NAPI scheduling on drop fails the copy and zerocopy ones.
- tun kselftest: pass:91 fail:0 xfail:12, as without the patch.

Notes:
- Affected since 943170998b20 (v4.15).
- Mitigation: disallow unprivileged user namespaces or restrict
  access to /dev/net/tun.

Antonio Quartulli (2):
  tun: bound the NAPI receive queue
  selftests: net: add a vhost-net test for the tun NAPI queue bound

 drivers/net/tun.c                       |  59 +++-
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   1 +
 tools/testing/selftests/net/config      |   1 +
 tools/testing/selftests/net/tun_vhost.c | 409 ++++++++++++++++++++++++
 5 files changed, 463 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/tun_vhost.c

-- 
2.56.0

