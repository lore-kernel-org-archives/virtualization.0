Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2D12FF63
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720646760; cv=none; b=grJrEQ2/L4zCitvTLDB+XsiQ3I1EDrqG/nVgZV2Ze6ZGl2udpdejIMPmm2NscIty1ruxMdFOlamH3AeDnGeyW3wony7/ITUISPT9vUqpp6TJUa56eV7u5Tih07W+8PtsCkq1d6UqgJYnNlwA4WPQHiiIKNF1vCcEwDQOGq3QkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720646760; c=relaxed/simple;
	bh=IRtZNpuJNMmXPtNDOFUO3vtkI4/OVSZb2YHRY1Upuy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iK1Lz0z4jPR7cumT4xg1onuYFdvVxlgLBk1FlmmjCSwuMbyK14p7p8/2JPjJ3vxIXEwZgEGApshRUaaCLyFA9b+jmZmnq+KOpzQ3H86x+bEMHgoBM2JuepUjH52Fe2Bi06FJvBmELdgsqREkTNyrxwDv4XFG+PJ90mxmRSG2RLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOPf/UBy; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOPf/UBy"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A099C60EDF
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 1.236
X-Spam-Level: *
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcO5Z4Ay7KNc for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 21:25:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::734; helo=mail-qk1-x734.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86783608A9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86783608A9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cOPf/UBy
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86783608A9
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 21:25:57 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-79f19f19059so14327685a.0
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720646756; x=1721251556; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QbggaOSaHuCesi2CRg2wXU+q+eIk0OlAl3CaZ0eNZU8=;
        b=cOPf/UByCruWT0axmHSydoQ2G9cTFrlEr2y89qH/7p2p/IOUeELmo5Meuf3iDMYbUL
         INh49H3Fg1A9hnsPOKWJqMR4r552VvyHiLhOlR49YsD/j8uqHlKhsRb5nU2Blk4d+ELu
         y0WCFUWEsvHSgUIE2VYbPx/DwgU8TPqp1EJR176fRhcnO3bGYAD08AMwiAe45MknDFdj
         PSgbERcJ46hvE3vbyeFGzzLm/GQkpnKymHWTyv0a3g1+bR58tb7cWcxyCbiT41VcZ07w
         nYQ9OslO3Th7Q0MHl2dHiB45myXCvGEIc/h6hdkzRrdNWpwMIQ20ENcj0Q9Y38xydC69
         6juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720646756; x=1721251556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbggaOSaHuCesi2CRg2wXU+q+eIk0OlAl3CaZ0eNZU8=;
        b=Qh6vkNNq7YmerzZ28jjuKZGDqbHH222dDpuMQ+gt5zNrGlRxKiFQchgcsSANDGAuaU
         y+qOwOy02fVUzgaKho+gqYodqr2fFpDuD0FAt2NoEtfFV4zkL8DS9sXhtq/XobFK0m1s
         QUwOpiswh09dWUlNjLSzugq06Jk1DZiyGyQmBrPo3nqzaGT/mgTkrhMobVYgHs/jkk/o
         ZM6lS3V1ptxM/pSU9b3Sc/PUR+hZ5/B7IqW5aL2RYhta13KuZZXx/vvkHcPxvwtdk66y
         lqD8VOivCwQB3b8jJBn7pwrhm58Omc2IgdZcQ2TvN0jL8IsVcbTTU8QxhHjSLWp5Uy04
         axnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLBy9qzGNQgdQL3Q/8uzT6hXsI10S6wYj/Hd/kBuKq9g/Db+N4MNYJGf/GjzSS3tC/lfCJB5a0LN7g67JoAKgn7fUwwGlacHJ4XB853mj3ShaZUt8wdzlXKQ==
X-Gm-Message-State: AOJu0YweLOX/TBKWZFUfGiVGLHA1Z4JHBQpkUrj0Xf0NpCER1v6a0Oiv
	bFRDMPiYMZRco/d27aOOYQW3Kk4Rye/xog3iqyG074Re2mFvUVdB
X-Google-Smtp-Source: AGHT+IFe0i7wU8rrpD+HqlfKPUEgBWA6vsqjfMceJ75v21AkhfrEYglh+zMZJB1mRaN1tBQCuxzMAw==
X-Received: by 2002:a05:620a:44d4:b0:7a1:41df:cca6 with SMTP id af79cd13be357-7a141dfcf26mr277624185a.23.1720646756076;
        Wed, 10 Jul 2024 14:25:56 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f190b0af1sm228791885a.122.2024.07.10.14.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 14:25:55 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	bryantan@vmware.com,
	vdasa@vmware.com,
	pv-drivers@vmware.com
Cc: dan.carpenter@linaro.org,
	simon.horman@corigine.com,
	oxffffaa@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	bpf@vger.kernel.org,
	bobby.eshleman@bytedance.com,
	jiang.wang@bytedance.com,
	amery.hung@bytedance.com,
	ameryhung@gmail.com,
	xiyou.wangcong@gmail.com
Subject: [RFC PATCH net-next v6 00/14] virtio/vsock: support datagrams
Date: Wed, 10 Jul 2024 21:25:41 +0000
Message-Id: <20240710212555.1617795-1-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey all!

This series introduces support for datagrams to virtio/vsock.

It is a spin-off (and smaller version) of this series from the summer:
  https://lore.kernel.org/all/cover.1660362668.git.bobby.eshleman@bytedance.com/

Please note that this is an RFC and should not be merged until
associated changes are made to the virtio specification, which will
follow after discussion from this series.

Another aside, the v4 of the series has only been mildly tested with a
run of tools/testing/vsock/vsock_test. Some code likely needs cleaning
up, but I'm hoping to get some of the design choices agreed upon before
spending too much time making it pretty.

This series first supports datagrams in a basic form for virtio, and
then optimizes the sendpath for all datagram transports.

The result is a very fast datagram communication protocol that
outperforms even UDP on multi-queue virtio-net w/ vhost on a variety
of multi-threaded workload samples.

For those that are curious, some summary data comparing UDP and VSOCK
DGRAM (N=5):

	vCPUS: 16
	virtio-net queues: 16
	payload size: 4KB
	Setup: bare metal + vm (non-nested)

	UDP: 287.59 MB/s
	VSOCK DGRAM: 509.2 MB/s

Some notes about the implementation...

This datagram implementation forces datagrams to self-throttle according
to the threshold set by sk_sndbuf. It behaves similar to the credits
used by streams in its effect on throughput and memory consumption, but
it is not influenced by the receiving socket as credits are.

The device drops packets silently.

As discussed previously, this series introduces datagrams and defers
fairness to future work. See discussion in v2 for more context around
datagrams, fairness, and this implementation.

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
Changes in v6:
- allow empty transport in datagram vsock
- add empty transport checks in various paths
- transport layer now saves source cid and port to control buffer of skb
  to remove the dependency of transport in recvmsg()
- fix virtio dgram_enqueue() by looking up the transport to be used when
  using sendto(2)
- fix skb memory leaks in two places
- add dgram auto-bind test
- Link to v5: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com

Changes in v5:
- teach vhost to drop dgram when a datagram exceeds the receive buffer
  - now uses MSG_ERRQUEUE and depends on Arseniy's zerocopy patch:
	"vsock: read from socket's error queue"
- replace multiple ->dgram_* callbacks with single ->dgram_addr_init()
  callback
- refactor virtio dgram skb allocator to reduce conflicts w/ zerocopy series
- add _fallback/_FALLBACK suffix to dgram transport variables/macros
- add WARN_ONCE() for table_size / VSOCK_HASH issue
- add static to vsock_find_bound_socket_common
- dedupe code in vsock_dgram_sendmsg() using module_got var
- drop concurrent sendmsg() for dgram and defer to future series
- Add more tests
  - test EHOSTUNREACH in errqueue
  - test stream + dgram address collision
- improve clarity of dgram msg bounds test code
- Link to v4: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com

Changes in v4:
- style changes
  - vsock: use sk_vsock(vsk) in vsock_dgram_recvmsg instead of
    &sk->vsk
  - vsock: fix xmas tree declaration
  - vsock: fix spacing issues
  - virtio/vsock: virtio_transport_recv_dgram returns void because err
    unused
- sparse analysis warnings/errors
  - virtio/vsock: fix unitialized skerr on destroy
  - virtio/vsock: fix uninitialized err var on goto out
  - vsock: fix declarations that need static
  - vsock: fix __rcu annotation order
- bugs
  - vsock: fix null ptr in remote_info code
  - vsock/dgram: make transport_dgram a fallback instead of first
    priority
  - vsock: remove redundant rcu read lock acquire in getname()
- tests
  - add more tests (message bounds and more)
  - add vsock_dgram_bind() helper
  - add vsock_dgram_connect() helper

Changes in v3:
- Support multi-transport dgram, changing logic in connect/bind
  to support VMCI case
- Support per-pkt transport lookup for sendto() case
- Fix dgram_allow() implementation
- Fix dgram feature bit number (now it is 3)
- Fix binding so dgram and connectible (cid,port) spaces are
  non-overlapping
- RCU protect transport ptr so connect() calls never leave
  a lockless read of the transport and remote_addr are always
  in sync
- Link to v2: https://lore.kernel.org/r/20230413-b4-vsock-dgram-v2-0-079cc7cee62e@bytedance.com


Bobby Eshleman (14):
  af_vsock: generalize vsock_dgram_recvmsg() to all transports
  af_vsock: refactor transport lookup code
  af_vsock: support multi-transport datagrams
  af_vsock: generalize bind table functions
  af_vsock: use a separate dgram bind table
  virtio/vsock: add VIRTIO_VSOCK_TYPE_DGRAM
  virtio/vsock: add common datagram send path
  af_vsock: add vsock_find_bound_dgram_socket()
  virtio/vsock: add common datagram recv path
  virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
  vhost/vsock: implement datagram support
  vsock/loopback: implement datagram support
  virtio/vsock: implement datagram support
  test/vsock: add vsock dgram tests

 drivers/vhost/vsock.c                   |   62 +-
 include/linux/virtio_vsock.h            |    9 +-
 include/net/af_vsock.h                  |   24 +-
 include/uapi/linux/virtio_vsock.h       |    2 +
 net/vmw_vsock/af_vsock.c                |  343 ++++++--
 net/vmw_vsock/hyperv_transport.c        |   13 -
 net/vmw_vsock/virtio_transport.c        |   24 +-
 net/vmw_vsock/virtio_transport_common.c |  188 ++++-
 net/vmw_vsock/vmci_transport.c          |   61 +-
 net/vmw_vsock/vsock_loopback.c          |    9 +-
 tools/testing/vsock/util.c              |  177 +++-
 tools/testing/vsock/util.h              |   10 +
 tools/testing/vsock/vsock_test.c        | 1032 ++++++++++++++++++++---
 13 files changed, 1638 insertions(+), 316 deletions(-)

-- 
2.20.1

