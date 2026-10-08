Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD894AF14F
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470330; cv=none; b=bkWOhihgqoMP7pWvw7JwuKfxEWnmUazImwEpPs01Gv4rOo+5cJPlhHKW5ziGsHwKbc+TwoQAqhPfjIlaGM2pw1NETzN1mx0VFohjcblzEE4ho/g6BHPhRr2WXI7I/SbEFt/L/K44Ws1AvD5JN9DehGa/GJ/6RUzVL3anH40+iNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470330; c=relaxed/simple;
	bh=SvnYYBxdfdpjmcYG5sNvTSf9Ty62rmIIqCC9XEmp0I0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SCv4L0SuSOX7zg309gtlfh1r67DDg8u1pI0n8J/e0oOPvpjFZHVOFLzstQ/e0Z09WDSL8CdyeT3+a960UE41RF/7uT316aeC7fgi8Pi4GO4GjsLAI4Y2QkNWU5a+Gfcu8Zm7N0kYdR6moVLTWFcF/+j/vOLuJofAFufdHmctpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=RSu9p6Oa; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="RSu9p6Oa"
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 71ACD2C0AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1791470317; bh=htPXIEhRGs69ipmacXA0sfdS032MwL4Sz2/AfLnlVmo=;
	h=From:To:CC:Subject:Date:From;
	b=RSu9p6Oajt2xDYXzQ4JG4WYVZgVJyj9opo0c8xWveTkmPIuCG1EpQsryEH8pqYWVU
	 YPCksgtDTpcerpgyb2cv6+e/nIqfLmhO/YcEioDxXohW4V4qGRbFADf491YDeNpD4T
	 trK+iFFfbVI3YY1oxZ5BJJ4MOiTCG5ffOboUDBWM=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 71ACD2C0AF4;
	Thu,  8 Oct 2026 17:38:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 180DD2C07F8
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 180DD2C07F8;
	Thu,  8 Oct 2026 17:38:37 +0300 (MSK)
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
Subject: [PATCH net] vsock: Fix memory leak in vmci_transport_recv_dgram_cb()
Thread-Topic: [PATCH net] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Thread-Index: AQHdVzKz7XEhPTpWk0WlXpednvmcFg==
Date: Thu, 8 Oct 2026 14:38:36 +0000
Message-ID: <20261008143805.86227-1-Ilia.Gavrilov@infotecs.ru>
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
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9b71479a2b29..fbafd882a12c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1048,6 +1048,7 @@ static void vsock_sk_destruct(struct sock *sk)
 {
 	struct vsock_sock *vsk =3D vsock_sk(sk);
=20
+	__skb_queue_purge(&sk->sk_receive_queue);
 	/* Flush MSG_ZEROCOPY leftovers. */
 	__skb_queue_purge(&sk->sk_error_queue);
=20
--=20
2.47.3
