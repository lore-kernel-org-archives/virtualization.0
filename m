Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757264;
	b=ku08PGuNZGPk9jsk0o4F9eTxuD2iHExgvwJxYxh7WaR4/HrlRr4XFGsH79h0f/3Dl+oo
	 pN1+ZLFAiCqH6Y3tnYTZL9qiEB3Iu965XWnsNwsHcOaeUP9EZ7ovhnVqf217cLUIzTpxg
	 8T9bqETv6tVnr1t6guW8PCoeD2loSsVM6yaRwlYCdSNhHq+lSwpYIraptzQFXh5fg4To+
	 YU87xoKzUX1oDLGzNC1eeZ9EGs5c1fFyThX+15SSS+xnXIBy5e/6P/tNGvh8ykU6crZ66
	 W/rDaoav2yHU2IA7AXkE5rO78dOvjLkeVU4Vb8wJRweIYcaNr0sS7hIiWRru3yfAs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757264;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=LSeW2bIn6BgxLSAOT2Lw9B2rplEpw5sJn6WUcX7UXc4=;
	b=e5Grp0llEvnu3NwgVvn9TVzdAwKXu9UpsTy6EIaYTf5w4kCha3na2nvEbdvm3NOz4OXv
	 uGSKjuNV32PcO4J0jNgrNJn8JbmBTZXVZNh+9mQ7T8Gb61LoPygKVUhRyJUW0Pd77WEjK
	 j0cnlgvBEy4/sCD0KsAYa/VHewKPxk4EnJEVqvH2Y1iRAFYKO1BAdLG4FneDE/cfW1s4i
	 KDBb8HWDWueWWuSpyeGG5wYNyII+mT0V1NzKhRpLSu8xSy7oFcLyuHWwYhoUUCvKBheQI
	 RuUF8Kk0r/aG3X8xoeF6zzDWYLOhH6VH2FnkaALQ9PONKpX0L9BTgMS6XxVp1wjTPeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EZK4eA1D;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF55606A336
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 01:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF55606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=EZK4eA1D
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A40Ss6h1797857;
	Tue, 3 Nov 2026 17:54:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=LSeW2bIn6
	BgxLSAOT2Lw9B2rplEpw5sJn6WUcX7UXc4=; b=EZK4eA1Dr+c3PcRcL9qiPzptK
	d7f01ikf2DaYwYe7PkpP7/UZXtO9A/oxE6jJdaRyfxUIctPXd5EVe+1dmGxRTR3K
	aRjkl3G53iOcKJxLAGL1YUYFamtfPi81PCjWZib5JhP2Ofb1Du50tLbWGJX/QIOz
	wg5KSEDkkKFMb+n3JGsDH3RJCiNWCmV4On8IbQbSCt73FA7kTNJYUNjdDNh3dVQ6
	LJh5nE30v4T/jdm+kdGv1/n0aJPKEAcBs22mYn7WluWE72nj6/ThWZ4u0dMKsMFx
	w3PgWoHDvX/+6OfhNu9qHKEdqelXv9Qsz02SRO/f4rfudpLJFsy9eG2TsMURw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hqm44bbmk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Nov 2026 17:54:11 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 4 Nov
 2026 01:53:55 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v5 0/7] vsock: assign the guest vsock device to a
 network namespace
Date: Tue, 3 Nov 2026 17:53:15 -0800
Message-ID: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
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
X-B4-Tracking: v=1; b=H4sIAAyQ6moC/2XOz2qEMBDH8VcJc3bK5I+J8dT3KD3EONkNZbUYG
 7YsvnvBQxE9D5/vb15QeMlcoBcvWLjmkucJetE2AuI9TDfGPEIvQJGy1GmJtczxC28/XFacCo5
 kQzKtHIN10Aj4Xjjl5x78gIlXnPi5wmcj4J7LOi+/+1KV+32PelLnaJVI6L1vdafZh254f/Aa3
 uL82EtVHbS6vFQVElqvh9F1aWTPJ63/tSR53dZIOGhljIvWDkqftDloRRdtkJCMa5WLKcYUD3r
 btj8crXHmbwEAAA==
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
        Eric Dumazet
	<edumazet@kernel.org>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <sargun@sargun.me>, <jlinbox@meta.com>,
        Bobby Eshleman <bobbyeshleman@gmail.com>,
        Bobby Eshleman
	<bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX1+5t3y9M8kaz
 kK4AABIOek0V08ipiGDAYTC155K0cNxew27UcvOZIQyOAKalgeSOK7aRVRezDVcVy44w9Tqc+QO
 wqI3ZDaSHrAnmbCcrH70v3m22bTTp/8=
X-Proofpoint-GUID: gvy76xoU1-6znoIqGJXM4vJHl0VUwmeX
X-Proofpoint-ORIG-GUID: gvy76xoU1-6znoIqGJXM4vJHl0VUwmeX
X-Authority-Analysis: v=2.4 cv=OMGyTiaB c=1 sm=1 tr=0 ts=6aea9043 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=_eT-hsJ4gDFAW4DEsJ0A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwNyBTYWx0ZWRfX3sNEecdM0+Lb
 dT35JxCLyvAPEH3kZGYxyjMQRvQY0LQXjgAGk33KDDVgwFo0EhNOcuFv3jYNU4+aFilg5k06wcK
 cfFKpoh3QRN315OxcSPpTxxF7jERDTs+l2BYCOFUNxIrmmfmMjmFoq3n+bmqWRHLYUq9lKT0rlD
 sDoXf4XxbbXB8l+H6HFoy8dUa/ELdeDy26qArnrdnp06xMsQFUxx4pwbNYuzkVTyKwcG9nHCc0f
 SzFgllujC8bHyv8vkT3Z7N7hwmrDesPzFi0Su8CITCEdvnUd0apPDmPhVg3gCHOHQMrmxrfiaGs
 c0jvpiHURq2uQax6iTH1GRwnAxiFhgK4xEpVFlZL3Y2FGjvzOs+ZyLnghsF/MeBUVKx83fnQtV1
 LsOOOsYfVesrA9X0nvvII3HdTTr6o3zpnsoXOcThZTaJ8Pe3trnQvN1o0mFB9lXZ6mvCo27Fo/l
 dOanq9LT2lmi1e95+jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new generic netlink family, "vsock", supports the command
VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
request was sent from. The namespace's existing ns_mode then decides who
may use it: a "global" namespace shares the device with every other
global namespace, and a "local" namespace keeps the host connection to
itself. The device starts out in the initial namespace, so until the
command is issued nothing has moved and no mode has changed. There is no
explicit unassign as assigning the device back to the initial namespace
is equivalent.

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

 Documentation/admin-guide/sysctl/net.rst |  42 +++
 Documentation/netlink/specs/vsock.yaml   |  72 ++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  23 +-
 include/net/af_vsock.h                   |  18 +-
 include/uapi/linux/vsock_netlink.h       |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 523 +++++++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  34 +-
 net/vmw_vsock/virtio_transport_common.c  |  40 ++-
 net/vmw_vsock/vsock_nl_gen.c             |  36 ++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/Makefile   |   5 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 550 ++++++++++++++++++++++++++++++-
 16 files changed, 1326 insertions(+), 71 deletions(-)
---
base-commit: 599d0e97610f09162d84c4ede4164628c066921e
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

