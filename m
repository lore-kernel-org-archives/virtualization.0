Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792545345;
	b=OPWN6WLhMfSP7xOTBXynhPQnavMJWs3Li0Lm/9SHKI0ErYy3Rn/lzBwQnffRp3Zi7L8M
	 ZD4Ut+pG5hTD+xcj4rTE36vc/A4iNjkygAzqSueCJRggZ4dDMOOi+OtZOoTXEqeZ/JLOT
	 pP9TivibOFmJifK0EQ86NNphzTYkTjpEahfFUGMjXulQri1A16+NqMqTje8H4sVI/+kf6
	 eBwdAcaegry5I4SpUqwU6fwW5wmfGJy26TK4Nx3RP1m+8G2ZrCcWGBmCQKgMpsnYTh/da
	 71EIrTIPM5KeAkka4syoDe0EcSPXPg/waDDgvOn9dmoqVNCU3Ap2ZssKeTATirlFJsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792545345;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=EK3PTVYNAVYcgsVFS3ToEFPKThB3sKCWLz41AyMkjZQ=;
	b=LTMA4TC+4u+095JfwLiUeb6YHIiPK3BvLXts+gP3LAWskIa5KM9KQEMHNCUc0PSvcMLA
	 WOIzN+2pHQPXxLCDshHYDr9cTvQFdlJpXUT3P/x0oe3Slo02bIyKq8fwUR7/8yNyRZBrs
	 SmC0eKmq0j4/VRdRbh4bAWaT8bu/UbHv11QfB1o/ZUiY3NHywxFalkgnhavCdCjHpjmo9
	 TlHTYqvHZEbPhZbsT8/sr5HFC8KRyortZBq6xO0n4iqNxEI73LYsK44eWubQmxrnFwuaU
	 un6t/+fMe69G2SfMiQWox0iwsB2GHxxSnk+xyZ3yBOMBQXvswPH0tk1xIwrl7Pn928A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=BCdf+zby;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53F606A31C
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 01:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD53F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=BCdf+zby
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNF301935979;
	Tue, 20 Oct 2026 18:15:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=EK3PTVYNA
	VYcgsVFS3ToEFPKThB3sKCWLz41AyMkjZQ=; b=BCdf+zbyrU7Wgyq7S4FxYJtW5
	paOodEUj93YqN8wXscwx2+9ytHpOlutoDHNnKf/iBb08Mposz3bO2N92/Ks4qLzn
	kKK0mU1O84/Q9hH035Ijt5TsYKvWYEeHx5Ld+cgnZWLjQFePdUn60knvC2Has1Ts
	pcCnbIGfDB0Nn22cX+jEKNgwhBELomSJ1GYx/BhnPSdOqqdJFHKLs4Z7K4hY3efv
	KT1JF/2OPoHcHQgQqNiUS68gJ0WB42NExzJmKVSxCMiXvHoTYz2Qe7IkXOLiC6gj
	zLGzjRjO3FAYHy7yEVB9FNWZ6eaJ4dfgR+K+y1QQLOZCs/WARSACm17CpEtSg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50r1hn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 Oct 2026 18:15:16 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.49; Wed, 21 Oct
 2026 01:15:15 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v4 0/7] vsock: assign the guest vsock device to a
 network namespace
Date: Tue, 20 Oct 2026 18:15:03 -0700
Message-ID: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
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
X-B4-Tracking: v=1; b=H4sIABgS2GoC/2WOyw6CMBBFf6WZNWP6wEJZ+R/GRaGDNsZiaG0wh
 n836cIQXN+cc+4HIs2eInTsAzNlH/0UoGN1xWC42XAl9A46BpJLzVslMMdpuOP1RTFhiOi4tmN
 9FM7qBioGz5lGvxThGQIlDLQkuFQMbj6maX6XUhZlL1LD5V6aBXI0xhxVq8jYtj89KNnDMD2KK
 csNLf8uZYkctVG9a9rRkaEdrX604OK/rZBjr2RdN4PWvVQbel3XL/Xu2LIxAQAA
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
X-Authority-Analysis: v=2.4 cv=XYwcX455 c=1 sm=1 tr=0 ts=6ad81224 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=vyxJ_gUn7OJKIBmdbXsA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX9WjaruDQeMdm
 dqbDSX49vHGTsy2ioWobLCG8LTl/IkyJVhgvX3Of11Ky1o+Eg/OsZ+etgnKFKqt/dXe/hhy7CsH
 773iKbtJ7DpiF9fYh5sT8hoNPQwwJwc=
X-Proofpoint-GUID: xkrdXrelPKkrD2a63cBAI9DkktQssZjm
X-Proofpoint-ORIG-GUID: xkrdXrelPKkrD2a63cBAI9DkktQssZjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNCBTYWx0ZWRfX6B0i176DMBfz
 cUesMY2I12xFSYESK60tDSSGcBRF2TluZvutTyx1AxnDV3SoBtXJm8JmhIH8ThXxX2GonC731Ao
 iiy/FZ1V/X+BxEK+tPDCY5JJRl1V7e4EWnN524l3Fixsiadi7jlm1oVmHjTSa9l/Ns784GtSsS+
 AneADWAyFgfAkOQtVpo1YXdtiX436Fe6iD7BofpTY1e7UYFwyagYKLpeqODaKqaeH1/kgj5XoFM
 elaL+7BCWHhnGu2guRrC8LS+YZDPdbQUvtbSQGoj4fGHR8ZKRiIV+e4WHgAD8JWJamNURywhpB+
 P4BgfQYQ/aQBeR2/Kxvo39bHFwqCsnMx29y08krkiFcJ5yn03uosarNUmngIVO6qkegLNqORo/N
 7tZwAHaNTHO3JaqelHw2afhdNtP6diWJygh05q5yD60J1vxOIyZ9I77JyCJn6Nk3h37+tFe0Jua
 R1ibLCH4RnGEZvIvwAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01

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
 Documentation/netlink/specs/vsock.yaml   |  75 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  23 +-
 include/net/af_vsock.h                   |  17 +-
 include/uapi/linux/vsock.h               |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 501 ++++++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  34 +-
 net/vmw_vsock/virtio_transport_common.c  |  18 +-
 net/vmw_vsock/vsock_nl_gen.c             |  36 ++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/Makefile   |   5 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 550 ++++++++++++++++++++++++++++++-
 16 files changed, 1299 insertions(+), 56 deletions(-)
---
base-commit: 599d0e97610f09162d84c4ede4164628c066921e
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

