Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BF396561
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470482; cv=none; b=AKQYEZyDK/5GXB5WqcYCbqlPsN+IWz53yfBedIL0PrICfwY6nI5Th0gHQjFPTIos1eez0XGlvn8RiKyF4Pqsvw9J45KGnR6q4WTl1qR2MLinzAZosDh9JcYzvrf+xEYAcOhp2XGAQH7XRzwTYLrp+8I3dTuaONSODVa/eIg9VYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470482; c=relaxed/simple;
	bh=h7E0bCCyjPRBphsPrc/PYAb0E5BRgrALsOpn+7/7RV0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q62Qll1/xTEF6I75kcpQd7XWSOLZ0jqdAmXyONJrbOV2kcs+Ly7mh8QVc1NHuzOJN7kQhnUIAsY+VyLrukKvbiBYbCtSNIW7/Hr0nntwEApavfl+Gy4VkFZiC2VTOWMo5HPKDapKMx3qpZl5qQSEC+10/l/GNUp2JmnVtap110E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=UxCmIABs; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="UxCmIABs"
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 125322C0C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1791470478; bh=2Yw2tRDXJMyk5Ip7RPiTQ8OFNDBVDqnBINKIKR3kL4g=;
	h=From:To:CC:Subject:Date:From;
	b=UxCmIABs+qWY53fuka1gvqA+7FVMK6o62YD/Ab88+gZR9ZrmDcVTZFEM2WPDEENfd
	 up366SQxpc9niy8+v2B4l++cV8OWiJbQARcVlz/iniOKEREa33Ixax7Q5l1PYc5UZl
	 Y4YY8WFTbajCMvOKblFbWzgFwvD/wpgmtVwg7iLc=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 125322C0C80;
	Thu,  8 Oct 2026 17:41:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt C813B2C07F8
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id C813B2C07F8;
	Thu,  8 Oct 2026 17:41:17 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Stefano Garzarella <sgarzare@redhat.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, George Zhang
	<georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King
	<acking@vmware.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Thread-Topic: [PATCH net v2] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Thread-Index: AQHdVzMTnBJrmR+U9kGz7gaXyNXuXw==
Date: Thu, 8 Oct 2026 14:41:17 +0000
Message-ID: <20261008144046.90853-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059, bases: 2026/10/08 12:42:00 #28666424
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8

During the closure of a datagram socket, the vmci_transport_recv_dgram_cb()
function may be called, which will add the packets
to the socket's backlog; then, after the receive queue is cleared,
the __release_sock() function will move the packet back from the socket's
backlog to the receive queue, which will lead to a memory leak.

sock_close
  __sock_release
    __vsock_release
      // take ownership by user-space
      lock_sock_nested
      sock_set_flag(sk, SOCK_DEAD)
      vmci_transport_release
                                      vmci_dispatch_dgs
                                        vmci_datagram_invoke_guest_handler
                                          vmci_transport_recv_dgram_cb
                                            sk_receive_skb
                                              if (!sock_owned_by_user(sk))
                                                  [...]
                                         (!)  else if sk_add_backlog()
                                                  [...]
  (!) skb_queue_purge(&sk->sk_receive_queue)

      release_sock
        __release_sock
          // move all packets from the backlog
          // to the receive queue
   (!)    sk_backlog_rcv
            vsock_queue_rcv_skb
            [...]
              __sock_queue_rcv_skb
                if (!sock_flag(sk, SOCK_DEAD))
                  // Since the socket is "dead", the function will not
                  // be called
                  sk->sk_data_ready(sk)
        sock_release_ownership(sk);
        sock_put

Add a receive queue cleanup in the socket destructor to fix this.

syzkaller report:

unreferenced object 0xffff8880117bfb80 (size 240):
  comm "irq/56-vmw_vmci", pid 205, jiffies 4295064448 (age 73.992s)
  hex dump (first 32 bytes):
    78 dc 26 1e 80 88 ff ff 78 dc 26 1e 80 88 ff ff  x.&.....x.&.....
    00 00 00 00 00 00 00 00 c0 da 26 1e 80 88 ff ff  ..........&.....
  backtrace:
    [<ffffffff82be8d97>] __alloc_skb+0x287/0x330 net/core/skbuff.c:505
    [<ffffffffa114bcbd>] vmci_transport_recv_dgram_cb+0xbd/0x210 [vmw_vsock=
_vmci_transport]
    [<ffffffffa05072c6>] vmci_datagram_invoke_guest_handler+0x366/0x450 [vm=
w_vmci]
    [<ffffffffa050ad75>] vmci_dispatch_dgs+0x235/0x490 [vmw_vmci]
    [<ffffffffa050b025>] vmci_interrupt+0x55/0x290 [vmw_vmci]
    [<ffffffff8137ad2b>] irq_thread_fn+0x8b/0x1a0 kernel/irq/manage.c:1205
    [<ffffffff8137c7ae>] irq_thread+0x28e/0x530 kernel/irq/manage.c:1314
    [<ffffffff81253dd6>] kthread+0x2e6/0x3a0 kernel/kthread.c:376
    [<ffffffff81004392>] ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:=
295

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
v2: Add a comment referring to the VMCI datagram

 net/vmw_vsock/af_vsock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b71479a2b29..533c733618df 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1048,6 +1048,8 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk =3D vsock_sk(sk);
=20
+	/* Socket buffers may remain in the queue in VMCI datagram mode */
+	__skb_queue_purge(&sk->sk_receive_queue);
 	/* Flush MSG_ZEROCOPY leftovers. */
 	__skb_queue_purge(&sk->sk_error_queue);
=20
--=20
2.47.3
