Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604971;
	b=Zxx/+MQvcwcedpbN0IfxW+/o9XOvG9DwV76IvBJXAPUuLO29GVK7ap8najeVhtdmYF63
	 3RpgdK6sq98etaXw/5v7Ib/mLNH1g1J26+QQkXEYCxRUbzhporJ7c2DJpRjofbPfI9TLi
	 h8tMmYypM6Q3ERBL9azZMbL+ryLGgse86e/VBbLGwE3cJ/jHWvNe6eTMuqlCUvSDAgfRE
	 odrZ71+sv9fQL0rCD2xwuKPIxP9z9/G9tL7R7DEJTqmfjALejikOu7IF+KHksx9TpXasa
	 rleleLiYPA+MSMqHxll/xzqw4KCH9skOMmCwpGVt5I30Uh7E5Wy/eQW9k/78oLNXM2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604971;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=VPnnnYLXSk8CSUf7R95OZDKV8BqykYO6+l1ofQyoXNU=;
	b=YewS+W9BTuyyPCTmRSh6fAmlYbP7E4TfdTUL4cArzuPnEWT66PjnqovhymYepSGkeFj/
	 15AnwNlJvFSVdbtwf7lyS5sm1hiHjoM0xOIUfPDX1L1BRHfxr9S3c9yeCadru5KLpQDl3
	 wAKDAVynVJvm6pWKlyJXTBLCq8O5DimvBA515e36Y7qBXWG0Sn54lhq4l1qKCqFYONL1p
	 0h696CAJnTnLlj5OLZJYav4tjuGv/EMBn9wkviG2SbxtuGvFeP9fIoPzSYouFudowVkzP
	 XNDMMePotanWaSv4GKQtzh+QtzHxgNQ2AKb5cich6ASaJzCXCIes4mUZyEsi5CFDUzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=TOHTITDA;
	arc=none smtp.remote-ip=195.10.208.61
Received: from mout-b-201.mailbox.org (mout-b-201.mailbox.org [195.10.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EEF606A333
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EEF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=TOHTITDA
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4jR9Fx2mnWzLm2v;
	Fri, 13 Nov 2026 22:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794604965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VPnnnYLXSk8CSUf7R95OZDKV8BqykYO6+l1ofQyoXNU=;
	b=TOHTITDA+0YVf69VA8D/rhN/UEIPkneY574BXqQzbCrfTQ5AhTQlJgrRyzTOAWWrVheLxN
	BtXjzQ4SYa3N+wPMIoB3MufE0o0P+eUqtPDovQOTUep1vIWkpL7EXV+QZb3JFXYo1PTDoI
	f/1Os9565bH6RN9CRh7fQ+c59f1t8Vlja/9zuzeN3PFcSvtHdiNRI6DF9Zj4pBnrokmEMj
	ruRFh9eMJ5nhMr+ZCmxUKsfq3655cdfvbmC6qKK+iwg5GdplWfdxyAQjkWqBFmafVWCRUa
	JTXRRjSi8OP7WoKlHUTTn+uUPeM6eR/6nrn2IZbmS7v2Id6SNsIoZTEVuAl0gw==
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
Subject: [PATCH net v6 0/2] tun: bound the NAPI receive queue
Date: Fri, 13 Nov 2026 22:22:32 +0100
Message-ID: <20261113212237.1742984-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jR9Fx2mnWzLm2v

With IFF_NAPI, tun queues written packets for NAPI on an unbounded
list, which an unprivileged user can grow until the system runs out of
memory. Patch 1 bounds it by netdev_max_backlog; patch 2 adds a
kselftest for the vhost-net paths into that queue.

v6:
- Complete the zerocopy buffer of a dropped packet with net_zcopy_put(),
  as a success, so that vhost-net does not fall back to copying (Willem)
- selftest: slim it down, and add a wrapper that loads vhost_net and
  also runs the zerocopy variant (Willem)
- Rebase on net

v5: https://lore.kernel.org/netdev/20261111014208.1795777-1-antonio@mandelbit.com/
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

Testing, in an x86-64 VM with 1 and 2 vCPUs, on net 7e1392a42ea2:
- Reproducer from patch 1, 15 seconds: memory use stays flat, no OOM;
  forwarding rate unchanged (113755 packets in 3 s without the patch,
  113990 with it).
- tun_vhost (patch 2), through the wrapper and with vhost_net
  experimental_zcopytx=0 and =1: passes with patch 1. Without it, every
  variant fails; removing the tun_xdp_one() check fails the batch
  variant, removing the zerocopy completion fails the zerocopy one, and
  removing the NAPI scheduling on drop fails the copy and zerocopy ones.
- tun kselftest: pass:91 fail:0 xfail:12, as without the patch.

Notes:
- Affected since 943170998b20 (v4.15).
- Mitigation: disallow unprivileged user namespaces or restrict
  access to /dev/net/tun.

Antonio Quartulli (2):
  tun: bound the NAPI receive queue
  selftests: net: add a vhost-net test for the tun NAPI queue bound

 drivers/net/tun.c                        |  55 +++++-
 tools/testing/selftests/net/.gitignore   |   1 +
 tools/testing/selftests/net/Makefile     |   2 +
 tools/testing/selftests/net/config       |   1 +
 tools/testing/selftests/net/tun_vhost.c  | 222 +++++++++++++++++++++++
 tools/testing/selftests/net/tun_vhost.sh |  23 +++
 6 files changed, 296 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/tun_vhost.c
 create mode 100755 tools/testing/selftests/net/tun_vhost.sh


base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.56.0

