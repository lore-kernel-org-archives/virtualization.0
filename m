Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027713D45F4
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454595; cv=none; b=jhHoA4X4snjm9SBDrqJ1L9XkKIuIw0Bb/d2AzrBAsjYpg2P4zUV+2gWbbhb2TDFG1RBmXfyycotTE/LMXhg5txVlJ1FsMIbnmcB1Jdc6sCV8b54s0hc2GMYbLgZkPJUgx682lxElDSqlCNSbiFZaKW0Isg8lFcu4xoktrkNUwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454595; c=relaxed/simple;
	bh=U28lcf97/CjhFUZfOOidZjKnIealHaMgfzCpUp3Xteo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OOf7FnCWA4ZXzIQd+lojszFR0cBeic0EMOfGuEZTHeqBfVVTKNXLetB/efgVAyDzWrPUqDiaOhBSE349j39LOb2lDP+47RHD8teXI2t6n0zy4Zx6sThrm9uqj3Rl7W5QXjxpnP2uO8jMjGen6Dy6h7lQTiTj290PtNXigUamUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkN1osq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkN1osq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791454592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SP1f9UNmtX0LiVyYf6TXLIff3crRsFq13nTHi/mc7ek=;
	b=LkN1osq1VF7WrSb8WQcbHQlpYtWq0jMqnrHkQ9pxOVhviU+T3JFAG8Ky/0asTBUBkWb2Nx
	skysUldKPNiK1CV1wC1onmZy3SjRPRM0txtdgYtqY2ElxIwBSJ/cYWyjas38zfsUjevG6c
	vzAJ1SjP8r7c2L5UwX4OoYBEDzBdtCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-nXyMUTfBMuKeFdtVz6TBqA-1; Thu, 8 Oct 2026 10:16:30 +0000
X-MC-Unique: nXyMUTfBMuKeFdtVz6TBqA-1
X-Mimecast-MFC-AGG-ID: nXyMUTfBMuKeFdtVz6TBqA_1791454590
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so74591605e9.2
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 03:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454589; x=1792059389;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SP1f9UNmtX0LiVyYf6TXLIff3crRsFq13nTHi/mc7ek=;
        b=wcwK839E2EVBCtugUvGNgYqwMuZ6fjqdYTfsU7/MSyiwul2Bdy3i3GCgYqeYFXmLZa
         ETyBmdvl4psAwUkd5jT4zz945q0jawh4kBzDtdouk4Ty3a0mjsZOklUs/7mXEnAasYjO
         8hXpnfCtWUi9UdtjenDYHocpZzRoRagE5IC+I+hVVnL/pOun3/wRab6uJPCVu9vkpiPS
         6aNjiEcGjozMqwXW2O2sUoRDkCEkp1VqfsnS8nxaaHSBw2t+ez1rK3q4NOquB4rFXqjz
         br/v1oeszSokU7V6HUctBYqC3BzrC8VlzmRXxTqD6qLqsh9X/ljyYQKGEFoS1YKEqjRt
         4hUg==
X-Forwarded-Encrypted: i=1; AKwUvBzjzQEnAS6VTD5gkCQbqzxsEdavJqomyIiBSBT9ZJwPth5can2daW8CxvmcYEIyeKXQrlWuiinVB2+46IGrrQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nSoFfTX45ZugRmb/OWGD6HGAh/vbyq/Zxd+wL3RZZnu39m4rC9
	mefXby0WOxhQcLtPV15tNmvat7KnuXyyztIjl/pkRcxwEQKovBUPOnqH8F9Cng88QbjV3rtxDJJ
	PiwFHQIOupHSQgZac+azWbKGVSQFtAxtMC41XBldLjtyr9j3TqQMr/EAsIIP/eefo90Zy
X-Gm-Gg: AYBFou0Xs3J+dusw5/DvTbHW4yjAaeSaZ7szLsraxzXEs8HQXONu+EzXDtJxegGBI4r
	qsspuH4MpAC0PA67zS4qcKQ8L4qS5Yw2WCJCxLoId8TiFwxn5QWQrVnzR7kOIT5se7PvZBi5K9o
	aMwvKWH6SxUjL31YjMwurgjD5Kf5/ngnHyMQpVo7jiml+4qhVN86Kverb7yyf65YFi9UX6h3fk4
	Why7TWJN8a7mAgPPiNes8jZxDi4y7iIRiAfoCPyBMokk/TG45DRiiMeVIxSm63wUwW+7a5LGcdZ
	Oet46Ax+oOjyKUDWdQEFOrrGDVlokFG8Y+YBvscC/JxolorQnqeEoj5fcXArgpA8bLs0siiSjXu
	MVcW/W+tl8Lmmq/gdFX74qgDd+JIw
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a18045995fmr80698285e9.28.1791454589601;
        Thu, 08 Oct 2026 03:16:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4a18045995fmr80696665e9.28.1791454588042;
        Thu, 08 Oct 2026 03:16:28 -0700 (PDT)
Received: from sgarzare-redhat (90-181-163-241.rco.o2.cz. [90.181.163.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843d1ea0sm60309235e9.8.2026.10.08.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:16:27 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:16:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] vsock: Fix memory leak in
 vmci_transport_recv_dgram_cb()
Message-ID: <asds3RsjgMTh8OFj@sgarzare-redhat>
References: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261007143716.1984702-1-Ilia.Gavrilov@infotecs.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wbfpCU9TVQe2gqNkh1qep-3gpUuUxRSdDs4hY0RdPA0_1791454590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 07, 2026 at 02:37:47PM +0000, Ilia Gavrilov wrote:
>During the closure of a datagram socket, the vmci_transport_recv_dgram_cb()
>function may be called, which will add the packets
>to the socket's backlog; then, after the receive queue is cleared,
>the __release_sock() function will move the packet back from the socket's
>backlog to the receive queue, which will lead to a memory leak.
>
>sock_close
>  __sock_release
>    __vsock_release
>      // take ownership by user-space
>      lock_sock_nested
>      sock_set_flag(sk, SOCK_DEAD)
>      vmci_transport_release
>                                      vmci_dispatch_dgs
>                                        vmci_datagram_invoke_guest_handler
>                                          vmci_transport_recv_dgram_cb
>                                            sk_receive_skb
>                                              if (!sock_owned_by_user(sk))
>                                                  [...]
>                                         (!)  else if sk_add_backlog()
>                                                  [...]
>  (!) skb_queue_purge(&sk->sk_receive_queue)
>
>      release_sock
>        __release_sock
>          // move all packets from the backlog
>          // to the receive queue
>   (!)    sk_backlog_rcv
>            vsock_queue_rcv_skb
>            [...]
>              __sock_queue_rcv_skb
>                if (!sock_flag(sk, SOCK_DEAD))
>                  // Since the socket is "dead", the function will not
>                  // be called
>                  sk->sk_data_ready(sk)
>        sock_release_ownership(sk);
>        sock_put
>
>Add a receive queue cleanup in the socket destructor to fix this.
>
>syzkaller report:
>
>unreferenced object 0xffff8880117bfb80 (size 240):
>  comm "irq/56-vmw_vmci", pid 205, jiffies 4295064448 (age 73.992s)
>  hex dump (first 32 bytes):
>    78 dc 26 1e 80 88 ff ff 78 dc 26 1e 80 88 ff ff  x.&.....x.&.....
>    00 00 00 00 00 00 00 00 c0 da 26 1e 80 88 ff ff  ..........&.....
>  backtrace:
>    [<ffffffff82be8d97>] __alloc_skb+0x287/0x330 net/core/skbuff.c:505
>    [<ffffffffa114bcbd>] vmci_transport_recv_dgram_cb+0xbd/0x210 [vmw_vsock_vmci_transport]
>    [<ffffffffa05072c6>] vmci_datagram_invoke_guest_handler+0x366/0x450 [vmw_vmci]
>    [<ffffffffa050ad75>] vmci_dispatch_dgs+0x235/0x490 [vmw_vmci]
>    [<ffffffffa050b025>] vmci_interrupt+0x55/0x290 [vmw_vmci]
>    [<ffffffff8137ad2b>] irq_thread_fn+0x8b/0x1a0 kernel/irq/manage.c:1205
>    [<ffffffff8137c7ae>] irq_thread+0x28e/0x530 kernel/irq/manage.c:1314
>    [<ffffffff81253dd6>] kthread+0x2e6/0x3a0 kernel/kthread.c:376
>    [<ffffffff81004392>] ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:295
>
>Found by InfoTeCS on behalf of Linux Verification Center
>(linuxtesting.org) with Syzkaller.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9b71479a2b29..fbafd882a12c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1048,6 +1048,7 @@ static void vsock_sk_destruct(struct sock *sk)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>

nit: maybe a comment here referring to vmci datagram could be nice to 
have if you send a v2. In any case, also this version is fine to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+	__skb_queue_purge(&sk->sk_receive_queue);
> 	/* Flush MSG_ZEROCOPY leftovers. */
> 	__skb_queue_purge(&sk->sk_error_queue);
>
>-- 
>2.47.3
>

