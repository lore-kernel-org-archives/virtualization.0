Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966924;
	b=ztRR6TysWJlajSGsrGQOp5tfRD16tWomO+NRVTo3H7GqB+swLhFqpemql3QG25pI8T5D
	 Hl/0C5V0nlL8UxNoxGSNdjkudg4rOytv6X/AFdv7Y37wdDpTpNEj6BpgDxmBkPTBveYYi
	 tAvNzreDLC/c2flPIk65Bnp6xB2INS6wg04A/fbqwyT7YctPpoodEadoXn90izxP7LMfw
	 XwSB5xHjqsPBV6qzY6vg7Lfv/+HCgYg7cpTrAUuay+cATVrasjGA/5+j/vaYtvj44N12I
	 B+AqV7peBUNDIqzlN4CUB2KkfeD23y60QOLIFRk9n+kRJUw1E3oDCMi90I5iBjRmsiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966924;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=q8YEJgF7CIIPd2vUFvUMuhyzBAULakByEFFvnXQRjFc=;
	b=4wRWZWkr9CgWYtlySwRD2iLXOqNG3GkLUH28WmR9VzXeuLUaSJrH2sAWrMyzFcxfH2xO
	 yaEjImV6m+HnH5RbliJ8x5CoZgwmwfnk1Brh6PVti4cgCCvKBn7JFqUWoDO7noiCIg/co
	 PmTLpu9itulgO0D0+7B9TPWj44hQPBneUd3sxr54kFFzEPn8O2gg1DFh3Op2+kmF4d3Pu
	 /q1tOyRleiYyhSb+pKok+mb7/N0VRk6T+4cZEp2gIPBeygCyUMTiqOQPDeNvEK04bvk6x
	 NuQps3VWP8P5KDY3ZPoll2AsAlxoXO+h+5BRe7C+FEMaAZBCfQBa2Omy5LdttNbOqig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=QnuVX2Gp;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117E606A32A
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 01:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F117E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=QnuVX2Gp
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI11os41516132;
	Tue, 17 Nov 2026 17:55:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=q8YEJgF7C
	IIPd2vUFvUMuhyzBAULakByEFFvnXQRjFc=; b=QnuVX2GpPc1qsjVUZbQ9BzBA0
	yBGCOBOJ5lcPTZeAESpTClFfyyLOd3g+OH/XTIHkL7TJHwO3jyJUvdhtxceazPqV
	eVBzoo7GRNShbIo8d5pVYflvvJyRvgYCSl8cSX3CFIapNPpvy+K6IxWjZLowBh0R
	nFhb+B/WekPSrarF3xr7elWQxRr4FjPoYd3I3HyxfYUPqAMnGe1LUC+eQqlw9oRt
	PMyw4QyBJB+RNyvQa+fbEHNobHHTEYdYXXT2BcSLyC4oYLg7o0C6iIyOc9J0JLc6
	jWwOSmdXApBpoUK7UNI67lx0hrMpp3JcKIuPU1W6DG3389AJEa1C1RHvspFSA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu61by7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Nov 2026 17:55:11 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 18 Nov
 2026 01:55:02 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v7 0/7] vsock: assign the guest vsock device to a
 network namespace
Date: Tue, 17 Nov 2026 17:54:43 -0800
Message-ID: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQF/WoC/2XS20rEMBCA4VcJud6RnNMUEd9DvEimUw3adm1iU
 WTfXayLlvY6fP+ETL54oTlT4S374jMtueRp5C3zJ8bxOY5PBLnjLeNKKCcaLWEpE77A0zuVCmO
 BTrjYGyu76Dw/MX6eqc8fa/CBj1RhpI/KH0+MP+dSp/lznbTI9XyNBqH20UWCgBCC1Y2mEJt0P
 1CNNzgNa2lRG60OV1oUCHBBp843fUeBdlr/aSnkcbYGAUkrYzw6l5TeabPRShy0AQHCeKs89og
 97rT911Log7YgwDTShxSSc6nZabfR8qgdCNBeeyTjvEax0Zff1cz09p5Lrtf9DFRKXFfcsttr1
 l2zNZ7hZ3+LBAmelOmNjV3s/t/jjm8/Sct2AZzGkbACvk6FQCZKHpOV5GO7qB+aYiHAaRhybRm
 mvqHgREixs1ErEYwl41Rwyiqk6KxGUhj54+XyDZZPBQa1AgAA
X-Change-ID: 20260831-vsock-guest-ns-d06af451da67
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stefan Hajnoczi
	<stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang
	<jasowangio@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Shuah Khan
	<shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Donald Hunter
	<donald.hunter@gmail.com>,
        Eric Dumazet <edumazet@kernel.org>,
        George Zhang
	<georgezhang@vmware.com>, Andy King <acking@vmware.com>,
        Dmitry Torokhov
	<dtor@vmware.com>, Eric Dumazet <edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX7m4lQi6ekD+S
 HjbBOJeSp45oCQIS92R9bt2kbPfLNdISQmXybi3VWeyegm2EWztX/RQ6Uc94C3H0qst9s8Mi+6R
 afqeVzxKUuJOhzvCqc2uauj3UyWD6ABovoF7VMUvJWSeXyhFtpUhB5OZouEB7HPLjPrfHFlNSXr
 5epq2dNX7p5M6CXgDSdDhkLhWz9nl4pwvD1CkvMQJ2oaRt/PdqvOuiRCYZXYSA6vhxcRc6VaEgJ
 Xp6MGtj9RSpSVkIn+SYGQN5RLWEjyzUzN6IY4m6ePenPLwm3NMvFc7Ou3DbioDBrkNPMYopQbpi
 yTnnAxoXhAYHxaOBN+ReQewlZ7DVnc6Q/sEuLW5gcb2cNfqIP0Q3vN92aHvxl8FMxpaUb4VM9hq
 Yggz3hDSaMLDYXwOopRtupGtui4hVidOTCY1tcMPnYiA0ZyKifYv3sX0aH/qTA/fScs9r5y7Q92
 ghlouoCA43zUY/WbqCQ==
X-Proofpoint-ORIG-GUID: P6cfV9eCzZ8mQAvg5gg9yYeU0nA0tg7e
X-Authority-Analysis: v=2.4 cv=DrnDa2/+ c=1 sm=1 tr=0 ts=6afd057f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=GJaTUcCZCEZQLXJfTmQA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNyBTYWx0ZWRfX3PSIVhLjWVwA
 UHVjZWhtA1sFWRKSXr4FntUTNo2p4IPvkpc5G+OKkONePrJEKHADMjIFNRbFDmAtxVPj6NkEdUI
 Iy7MX43ZS+bU9vbXirn7sRIS+7dK0gs=
X-Proofpoint-GUID: P6cfV9eCzZ8mQAvg5gg9yYeU0nA0tg7e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new generic netlink family, "vsock", supports the command
VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace given
by fd or PID, or else to the namespace the request was sent from. The
namespace's existing ns_mode then decides who may use it: a "global"
namespace shares the device with every other global namespace, and a
"local" namespace keeps the host connection to itself. The device starts
out in the initial namespace, so until the command is issued global
namespaces see no change, and local namespaces still cannot use it.
There is no explicit unassign as assigning the device back to the
initial namespace is equivalent.

The command requires CAP_NET_ADMIN in the initial user namespace, so
that an unprivileged user namespace cannot claim the device.

Connections that can no longer reach the device after a move are reset,
so that a namespace which has lost access cannot keep using a socket it
opened while it still had access. The assignment holds a reference on
the namespace, so deleting that namespace does not move the device; only
another assignment does.

Transports opt in through a new netns_assign_allow flag. Only
virtio-vsock sets it here, because it is the only guest transport
that I am able to test against.

Based off of Stefano's original series:
https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- Post the tap netns fix separately to net:
  https://lore.kernel.org/all/20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com/
- Post the connect() fix separately to net:
  https://lore.kernel.org/all/20261117-vsock-connect-close-v2-1-db5388323770@meta.com/
- Keep swept sockets in the connected table (Sashiko). Reproduced with
  an ad-hoc Python test, not included as it isn't realy mergeable
- Reply to VSOCK_CMD_DEV_NETNS_SET now that the return is meaningful (Sashiko)
- Fail CID 2 with ENETUNREACH when the g2h device is in another netns,
  instead of falling back to loopback
- Cancel queued packets of reset swept sockets to avoid driving a bunch
  of pkts into the tap device that never actually get sent
- Keep swept sockets readable until drained, so that the behavior is the same
  as for sockets that are actually reset by a peer (and so that SIOCINQ
  doesn't report bytes that are never readable)
- Fix stale docs and comments
- Link to v6: https://lore.kernel.org/r/20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com

Changes in v6:
- New patch 1: move vsock_connect_close() out of the netlink patch, since
  it also fixes connect() vs transport reset races (Michal)
- Set swept sockets to TCP_CLOSING instead of TCP_CLOSE, as a peer RST
  does: they were established, and vsock_connect() handles TCP_CLOSING
  as such rather than as a failed connect (Sashiko)
- Accept netns-fd and netns-pid attributes in VSOCK_CMD_DEV_NETNS_SET to
  name the target namespace, and test the netns-pid one (Stephen)
- Check reachability in virtio_transport_send_pkt_info() instead of
  virtio_transport_send_pkt(), so RSTs from
  virtio_transport_reset_no_sock() reach the host after an assign
  (Paolo, Sashiko)
- Revert the v5 change that sent the recv_listen()/recv_connecting()
  RSTs to the netns the packet arrived on; sock_net(sk) works again now
  that those RSTs skip the check
- Export vsock_g2h_reachable_sk() for virtio_transport_send_pkt_info()
- Rewrite the commit message of the virtio patch (Paolo)
- Require setpriv only for the two privilege tests, not every ns_guest_
  test (Sashiko)
- Link to v5: https://lore.kernel.org/r/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com

Changes in v5:
- Rename the uapi header to linux/vsock_netlink.h (Stefano)
- Drop the VSOCK_CMD_DEV_NETNS_SET reply and rely on the netlink ack
  (Stefano)
- Keep vsock_register_mutex static, export vsock_cid_lock() and
  vsock_cid_unlock() for vhost_vsock_set_cid() instead (Stefano)
- Replace vsock_g2h_next_unreachable() with a generic
  vsock_next_connected_socket() next to vsock_for_each_connected_socket(),
  which cannot be reused because the sweep takes lock_sock() (Stefano)
- Use rcu_dereference_protected() in vsock_nl_dev_netns_fill(), drop the
  RCU read lock and allocate the nsid with GFP_KERNEL (Stefano)
- Point to the vsock_g2h_assign_mutex comment for the lock ordering in
  vsock_g2h_net_assign() (Stefano)
- Reverse xmas tree in vsock_dev_do_ioctl() (Stefano)
- Set SOCK_DONE and peer_shutdown on swept sockets, so recv() returns EOF
  and send() fails with -EPIPE/-ECONNRESET instead of -ENOTCONN (Sashiko)
- Only move sock->state back to SS_UNCONNECTED in vsock_connect() if it is
  still SS_CONNECTING, via the new vsock_connect_close(), so a socket
  swept while connect() sleeps cannot be connect()ed again and have
  vsk->trans freed under in-flight skbs (Michal)
- Send the RSTs in virtio_transport_recv_listen() and
  virtio_transport_recv_connecting() to the netns the packet arrived on,
  not the socket's: after an assign the socket's netns may no longer
  reach the device, so the RST would be dropped by the reachability
  check this patch adds to virtio_transport_send_pkt() (Stefano, Sashiko)
- Pick up Stefano's RoBs on patches 2 and 3
- Link to v4: https://lore.kernel.org/r/20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com

Changes in v4:
- All Sashiko fixes (see individual patch change lists)
- Link to v3: https://lore.kernel.org/r/20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com

Changes in v3:
- Lots of fixes for race conditions found by local and upstream Sashiko.
  Sorry for the delayed reposting, it took significant time to track
  down and confirm that these were real issues, and come up with a
  decent solution for each...
- Pin the assigned netns instead of returning the device to init_net
  when it is deleted, and refuse an assign that would make the device's
  CID collide with a nested H2G vhost-vsock with the same CID
- Drop the idea of sending RST to the peer from the reset sweep. Sending
  a RST required a lock_sock, which can't be acquired underneath the
  vsock_table_lock.  Splitting into two phases of locking opened up new
  races, I couldn't find a solution I was really happy with. Probably
  not worth the complexity
- New prep patch passing the netns to ->has_remote_cid(), which is used
  in a later patch in the series for avoid CID collisions between nested
  H2G guests and the G2H device
- Various fixes (see individual patch change lists for more details)
- Link to v2: https://lore.kernel.org/r/20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com

Changes in v2:
- Replace the IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl with the "vsock"
  genl family and VSOCK_CMD_DEV_NETNS_SET
- RST the peer from the reset sweep, v1 only set TCP_CLOSE locally, so
  the peer waited on a connection the guest had abandoned (Stefano)
- Drop the vsock_assign_g2h_netns helper patch, the tests use ynl cli.py
- Note why only virtio-vsock opts in (Stefano)
- Add a getter to the uAPI
- Various fixes (see individual patch change list for more details)
- Link to v1: https://lore.kernel.org/r/20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com

---
Bobby Eshleman (7):
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: rename the vsock pernet operations
      vsock: pass the netns to ->has_remote_cid()
      vsock: add a netlink command to assign the g2h device to a netns
      vsock/virtio: support guest device network namespace
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the netns assign privilege checks

 Documentation/admin-guide/sysctl/net.rst |  43 +++
 Documentation/netlink/specs/vsock.yaml   |  95 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  23 +-
 include/net/af_vsock.h                   |  20 +-
 include/uapi/linux/vsock_netlink.h       |  30 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 574 +++++++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  32 +-
 net/vmw_vsock/virtio_transport_common.c  |  37 +-
 net/vmw_vsock/vsock_nl_gen.c             |  44 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 +
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/Makefile   |   5 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 611 ++++++++++++++++++++++++++++++-
 16 files changed, 1472 insertions(+), 68 deletions(-)
---
base-commit: cbf8e9609bad5a320945e46296252cea653ce2ca
change-id: 20260831-vsock-guest-ns-d06af451da67
prerequisite-message-id: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
prerequisite-patch-id: 556ae59ccb4191bb260c31c09c0480aee4843bd4
prerequisite-change-id: 20261116-vsock-connect-close-1beb7cb51e7a:v2
prerequisite-patch-id: ff6a06be92b69c1df866fc1e119e484c4ca8950c

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

