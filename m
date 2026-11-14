Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794626445;
	b=rSVU2zQgrZdmeHhGIsMuBLdPstqUhGJVfFLtaBiC0fuXi7vnupBRCOfUZ92zKP3bSLt7
	 MgDOSac81+NoxB+YZiRrzBs3Tufd0RRQBOyvtvI29S056MmQ6R9VeCWsV5Oor+ksFyHJo
	 MWdThc5KBgJ2amRIstx8t+0jQ+c7SZ7Q+ev48x4x48RTt94TXP7t8CuIW1bdyNEW7WOjW
	 +i8uTJfcbyWMyvSgQhxJ1AAYAnvZq0kDS/rdiNpp8VHwNu05w736EKcOxmsl0p4xUgDgF
	 bZIfsHe6P5rUniXbnkHIAyMatrsjvcJisUWTfxloPhnYVNozuwxkcMuYp+2mbSgGqcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794626445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=Sxs4xhvXXypRdDHtl1yl3yW9x+OfR4O8mIIwy0tBs+c=;
	b=3prxW+HjYHC226KjiApH/gllUi31F3uMjTrSIfQC/XNofN83NR1Z+VsU6HY4LNGMtW/4
	 yOsWxRweW2Klfc/xdAlBATEoAupAuppatmb5Tl/i8kV+flgg83fJUdkl2f1drP8Wa5BXf
	 FcOt0UcDrTVV0n7hvd2xcDJ+HBCiPxX+FjVuDmKFjy3J2E0D4dwekXjkRmFYEHSD4+jQy
	 WGg8AXaP9gQlQYEt6KX+o2sbhiv6D/tNK3lxw7sLLSv8SwhNsv8od9QSHzPEDxXAO6gY8
	 NC9bl16uCKiczwpAvfQD42th515/0i9tZESUmVP2/Gxn91VENjwGm70HoP1YKwK/RcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JXdwLaLa;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40A606A332
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E40A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=JXdwLaLa
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE22QKm3157778;
	Fri, 13 Nov 2026 19:20:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=Sxs4xhvXX
	ypRdDHtl1yl3yW9x+OfR4O8mIIwy0tBs+c=; b=JXdwLaLanV/cuiiCZIu6zTM4t
	I79M4wdRDWn6+T+dOsX9UMv8ycU/Udx14Y1E2KJ9CmQNH93nwku/efUVV/wAtKk2
	/ck18LzmiTidyHbFmYJsKa8uGLe2LSKd/GeptqMwb5kuiZiJP3NELg11Cr0vc4AI
	vw9tljQ3E6wfRbzTHuM4ktz8Hpv9G7203xl7R7G/c5ASI1OPuNaI57kzE+fa+L5Y
	0lw7DuHr+J5VJ4NUjtqzK4FOnleSMgrUJw+YtL8HG8LPdfhp6YVXY0gkSlIW/E6D
	JWEudMSUOMhhmMhLVL0XmlNlNbEobVwUfA4NzwCFVOTO2ubnktqeDgG8DMsdg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5tf9d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 19:20:21 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 14 Nov
 2026 03:20:20 +0000
From: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH net-next v6 0/8] vsock: assign the guest vsock device to a
 network namespace
Date: Fri, 13 Nov 2026 19:14:11 -0800
Message-ID: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
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
X-B4-Tracking: v=1; b=H4sIAATS92oC/2XOy26DMBCF4VexZp2pxhd8YdX3qLrAZkisKhBha
 qWKePdKLFoE69H3n3lB4TlzgVa8YOaaS55GaIW9CEi3brwy5h5aAYqUJa8l1jKlL7x+c1lwLNi
 T7QbTyL6zDi4CHjMP+bkFP2DkBUd+LvB5EXDLZZnmn22pyu2+RQOpY7RKJAwhNNprDp2P73deu
 rc03bdSVTutTi9VhYQ26Ng7P/Qc+KD1n5Ykz9saCaNWxrhkbVT6oM1OKzppg4RkXKNcGlIa0kE
 3/1qSPukGCY2XLsQQrY1+p9d1/QWQM12/rQEAAA==
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
	<bobbyeshleman@meta.com>, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: T5MKg8120aucI2XEcqqtoOCF8xQnozBK
X-Proofpoint-GUID: T5MKg8120aucI2XEcqqtoOCF8xQnozBK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfX6zKjJaYUGfAS
 baDXqQrxn1EQSJXt4RzQ5tjWVi8DaQOz6PBLxkRJ77hSp+iRhlnApsXAkyz1Wq5r7KR4z6rndZc
 e2bc9oay3FftBxCj/PUf5kANkP1U7Z0=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af7d375 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VabnemYjAAAA:8 a=khtqCetA8w8CRhafVWAA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxMiBTYWx0ZWRfXy0ISsyL9Ts4S
 vi+m4soezhe7cpIMpm3pv4s/+xrgVj94GQu/tHsDS/jI12lPmqj/ounLms/u3j2aPGEcrZIO/1y
 XGqM/H+wJyodHCdLSNkt1ij/rwj8G4/EU4ViZOqdtZfS9whqTmmsVTwL66Tkv/vRh+fEKU+s3E9
 uUE90UZxOKJN5Su4f4ywq3Gd2x/gwCSdCb2EKRoeVtm196zG+j6S3s+JG//yXHtvqQIbG5UIwmY
 TX5ire/fGf3Y5my39Hgm5aJBQdQm7vBX/d2kgAre21loI42IEoDAcbWeK1OgjN+8v7VUKrSZUgP
 jw/R+xu8/HpLdBBAelZ6rG5PHrosELBcE+qXVIRzK5JnePt7VWj9DdEJGJ2Q1hwktZfOZSmKWmZ
 1ZJ910wty8xbgiQV5D9mdyTun+jp7jh0/PNO3fGlxtFda9Ya7XhKj6LARvPWBLlGrzyXAKBNAD/
 nZRTZl+JTUJLFmLv18w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new generic netlink family, "vsock", supports the command
VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace given
by fd or PID, or else to the namespace the request was sent from. The namespace's existing ns_mode then decides who
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
Bobby Eshleman (8):
      vsock: only undo SS_CONNECTING when connect() fails
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: rename the vsock pernet operations
      vsock: pass the netns to ->has_remote_cid()
      vsock: add a netlink command to assign the g2h device to a netns
      vsock/virtio: support guest device network namespace
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the netns assign privilege checks

 Documentation/admin-guide/sysctl/net.rst |  43 +++
 Documentation/netlink/specs/vsock.yaml   |  89 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |  23 +-
 include/net/af_vsock.h                   |  19 +-
 include/uapi/linux/vsock_netlink.h       |  30 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 552 ++++++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  25 +-
 net/vmw_vsock/virtio_transport_common.c  |  37 +-
 net/vmw_vsock/vsock_nl_gen.c             |  44 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 +
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/Makefile   |   5 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 601 ++++++++++++++++++++++++++++++-
 16 files changed, 1430 insertions(+), 64 deletions(-)
---
base-commit: 599d0e97610f09162d84c4ede4164628c066921e
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

