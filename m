Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7A343883
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845378; cv=none; b=JENhhpnIU4uLHcWj4pZSWY2QhdzAQXwTbq4C8/v+o7sjln5iBbYSqtX5SBm287MOuFyHNShZSUMQqutAxaGfI5V3zIGsabQSD4BhUVoijciyIQzFnkOKCFPl6WZ4+2QnTBuGd4j4B+hOdWE8hQNjjWgIsSROC10Fmj1Z6fjmAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845378; c=relaxed/simple;
	bh=JzqfvG37ARGE+Iq+rV7o1/nfPLm9RzU6v/YPacuwJH0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=N1Antu6uiCgCqDeq+xCnkCFOsoNQpVIM6V+TvEuP1uPb7narEn91ZxwtHMJFmvONikKWvWiBx/W5bFhnqY4VrLRf7C4JR6HI05+KPjjkNJs/sKnK9GP0ZOcT1ytFGBHjPcGSsOf6JxlvV6t83d7WjER9Dvq4VAngNafVlWUcVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=d59Gc2Rx; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="d59Gc2Rx"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69CJOOOK668408;
	Mon, 12 Oct 2026 15:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=FgD7BY+Lr
	IRfzXfgMrcYit8wpfJ4O0g5BtUo+KhvxC8=; b=d59Gc2RxLsI4fOjhSES3SnWGg
	vE4cj0erGl6Iky3C4XN9xNiVzLxcR/9co4wN0P0yYpLEj5eLJXNHNtSuBNh83Bap
	CUiv/XA6nuDv/xBRaJTY85cRuYxcVt1H8aJWkMmBy045D/e3YX/XJJ9ri9UQEY0t
	uQjvac1XB5FiozEp8quhy3uVTsbVowsrm8teUxND5Oq03k1RfxTmJM95ozSL/334
	19mIA71n60aKYSJT2zZxTrXN5WHxhl5+BCK6nNNW9PEyJjKAXO1Un13kRouCsRNY
	yLrzBHTG4UwM35mif4XYbEyc5W8+lEu2X+Bt3mSOEWnocJX+cBP4BQEtjE6sw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4h7h19thvp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Oct 2026 15:49:15 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Mon, 12 Oct
 2026 22:49:13 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v3 0/7] vsock: assign the guest vsock device to a
 network namespace
Date: Mon, 12 Oct 2026 15:48:31 -0700
Message-ID: <20261012-vsock-guest-ns-v3-0-b32447c66b23@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMBjzWoC/2XOzQ6DIBAE4Fche3YbhPqDp75H0wPKqqQRGqHEx
 vjuTTiZ9jyZb2aHQKulAB3bYaVkg/UOOiYLBsOs3URoDXQMBBc1b2WJKfjhidObQkQX0PBaj9e
 qNLpuoGDwWmm0Wwbv4Ciioy3Co2Aw2xD9+slLqcx5RhUXv2gqkaNSqpKtJKXb/rZQ1JfBL1lK4
 tQWf5eSQI61kr1p2tGQolP7OI4vu7eMdvMAAAA=
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
X-Proofpoint-GUID: t7SCPxBToMdEMHEj8PXXslKT-E3OatJK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX1gMj0q0H+eN0
 Z6aQVR/8HCBgHKWac7SYXtUF3qQ8gNC033pMhC65vRj92J4/cBLSrggG4DEjhruaRegiF/2PwI3
 dp1jZLWuYNwnSM7fQ75e2ID5BRKWLhQ=
X-Proofpoint-ORIG-GUID: t7SCPxBToMdEMHEj8PXXslKT-E3OatJK
X-Authority-Analysis: v=2.4 cv=HpvjiETS c=1 sm=1 tr=0 ts=6acd63eb cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=oOkyVFzGqRdFg-PF3r4A:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5MCBTYWx0ZWRfX6H7OAGzfCUWL
 heLTZuPGNrT1S+S9Tt+pl5hdcZfTFS2rKRmogifmMeja+ZkZt3XMec5B7gOWn/Z7EsugReyDI7q
 nxjg5Ab2pF3pZbvHUnTkwSrFIjmvH2vCWf39iSbhDtEEIC061HEfsrlQbTAIGaPSoXV7ro+zmCp
 jhAi4GSTI4hbfPtqYy6h5HdrcDBuIjZpOLDO2v/fk9OqhwZVi1ynPd7l5DMlB+GDdiq5wPRVGjm
 weu29mgG7rDaRWVnmXmJgxDR2+e5o3pu87mrrkp5UKESBqFuPyY8Xn/ZKzhy7vLYYIgNfUxinNe
 cMJPH0yVUTXg03kYe1fDFtI4XEzj1NUtwXkZ27cfhIEJiJivRlPCYxqhiA9pLi2H+w1aW3L4dKn
 3vLb0rDk7gtxPnLTYLcKDI25UehKn7X0lMmjzLl1CRQwxUFwnAKpPE3EeDv5uHwLRkV8ORXJUl8
 YkEogGljZJEP5IWbovg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01

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

 Documentation/admin-guide/sysctl/net.rst |  37 +++
 Documentation/netlink/specs/vsock.yaml   |  75 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  23 +-
 include/net/af_vsock.h                   |  17 +-
 include/uapi/linux/vsock.h               |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 459 +++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  25 +-
 net/vmw_vsock/virtio_transport_common.c  |  18 +-
 net/vmw_vsock/vsock_nl_gen.c             |  36 ++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/Makefile   |   5 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 554 ++++++++++++++++++++++++++++++-
 16 files changed, 1250 insertions(+), 53 deletions(-)
---
base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

