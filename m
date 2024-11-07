Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3378192D9C
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974537; cv=none; b=M1V5ClTVyh2jTWrbJYFq9Swui4E6A3JOk0FXmetaZt878Y0CkI3fMfLUVf5jfNfEQQ76s1BfD8rV1rfGQkYAXncIyNhpq/vyCNACq+LnQsB29FnkWka9jONCiSJ2HIXvC+B/FSBmlVVNqu4uyIpFoXL8TLxUnipFzzwKO3A4OIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974537; c=relaxed/simple;
	bh=x7ik3dUZ4qfgretMWTs0q2SwyKs1yvwePHnw90ALGms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aqXFptJcIxu6zRBCU9rMIW2sXWa7qpA1qHexsXwCmOG3iP+XlrlTJ9DE6hMNTDkT+gLsMDANRVwuMsNkjCNSBLmuet4FDnHRtslfGluc4TFf3IwCk47UUcf8HUQ1Qp7bxUlI92AvT0oaT9ymARcV7S8iC2VraEolsgoipRBrjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmueGdT+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmueGdT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730974534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qic0KprwlmFJxdJGsLKtec/+hybwkWidV6RrLX35zxs=;
	b=JmueGdT+9H/ARLZWcrQcGZJluPfHuTcQtYhF2LXKDOKKCMqrrsS7XOyNC/ihAc4s68BupO
	mMw5aYP/7CBnpVxtL4f2tp8eqb7hWBdIm5oakB5TSUALQu6y3ZLzZGvwmNeXDDPpfYnDzV
	Baj1oZOzd7iN4mdHBNoHTIZQ1InXEsQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-bxDeupoWOtKmRpeAxSq16A-1; Thu, 07 Nov 2024 05:15:33 -0500
X-MC-Unique: bxDeupoWOtKmRpeAxSq16A-1
X-Mimecast-MFC-AGG-ID: bxDeupoWOtKmRpeAxSq16A
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d3729a555dso10454606d6.3
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 02:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974533; x=1731579333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qic0KprwlmFJxdJGsLKtec/+hybwkWidV6RrLX35zxs=;
        b=W7IIWTc4mNzSif1kh1knnZmQKHOvdLlip7mAEzt0g4kUU8mq9aPLkdkt92h9fxQUS0
         brmzTW0E0/XTibBI1SONlhmPVNTMRD/FvxjhuhqBv48SiwyKi/rJ5idSdm0g9iq5VwIG
         fmcUIyfajx1RGEf6W+FW89sfcl28AuwFooHnFTNPjmOXiPoNqLPSLqW8/QRpqvW7BZhX
         KbRwtCSUPZ2bs/vjlMOFy/rVNub8Sq2Lils+Hx/qFYdzznYXjaQIiFNdOZOa+VdAiPTK
         Cu0uwiPYXt7U6gbZw+cCXVZv/eTh+R3MlSfHLHJEFGdiifeOxoXKDKnn9SD0UQ4yr9+t
         b0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWru/t7motQhXJMELGSgyYliXqTWHLs9wudl/J7PDxMkTO6eqBwxd9y77aOiumOQGmaQ9ZCdYWq8LN08U39cw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTI6dfzK5K0rUb5fdJtDRTuZbVbiLUaFLDQgfDDnyOvitAnaHn
	2iNE+Y8Kl6ozdAsDs5CsXKi274whR9T1gNy3V4RNu6/xLCBAvKvjO4GkKfLo0+9JlTfclF6i2Rq
	0G1z5NaK8PgJngQpqFV7pRPRnCLnmO3BDHrYMEkm9WfHHLLPhpSvafueufo3wdiVY
X-Received: by 2002:a05:6214:3f8d:b0:6cd:3a49:34e8 with SMTP id 6a1803df08f44-6d39a525c00mr7104696d6.20.1730974533183;
        Thu, 07 Nov 2024 02:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFQWBdcj0fFKhWjLh9ILVMNEnmMAKMSoYgq0CTrZlBpSg2wx5nk5hVOaqP6XnuB6b/bKS9cQ==
X-Received: by 2002:a05:6214:3f8d:b0:6cd:3a49:34e8 with SMTP id 6a1803df08f44-6d39a525c00mr7104366d6.20.1730974532720;
        Thu, 07 Nov 2024 02:15:32 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df223sm5932806d6.5.2024.11.07.02.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:15:32 -0800 (PST)
Date: Thu, 7 Nov 2024 11:15:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/4] virtio/vsock: Fix accept_queue memory leak
Message-ID: <dcboxomaif7b3qt3ofls4wvnobclv3onb32ynnq5uchzqoz6kg@5htm6qcbvmpg>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
 <20241106-vsock-mem-leaks-v1-1-8f4ffc3099e6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241106-vsock-mem-leaks-v1-1-8f4ffc3099e6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3aD-tg8WyjYrzTSdtbBmb40yD8G2SOmn9-MxW0On6fQ_1730974533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 06, 2024 at 06:51:18PM +0100, Michal Luczaj wrote:
>As the final stages of socket destruction may be delayed, it is possible
>that virtio_transport_recv_listen() will be called after the accept_queue
>has been flushed, but before the SOCK_DONE flag has been set. As a result,
>sockets enqueued after the flush would remain unremoved, leading to a
>memory leak.
>
>vsock_release
>  __vsock_release
>    lock
>    virtio_transport_release
>      virtio_transport_close
>        schedule_delayed_work(close_work)
>    sk_shutdown = SHUTDOWN_MASK
>(!) flush accept_queue
>    release
>                                        virtio_transport_recv_pkt
>                                          vsock_find_bound_socket
>                                          lock
>                                          if flag(SOCK_DONE) return
>                                          virtio_transport_recv_listen
>                                            child = vsock_create_connected
>                                      (!)   vsock_enqueue_accept(child)
>                                          release
>close_work
>  lock
>  virtio_transport_do_close
>    set_flag(SOCK_DONE)
>    virtio_transport_remove_sock
>      vsock_remove_sock
>        vsock_remove_bound
>  release
>
>Introduce a sk_shutdown check to disallow vsock_enqueue_accept() during
>socket destruction.
>
>unreferenced object 0xffff888109e3f800 (size 2040):
>  comm "kworker/5:2", pid 371, jiffies 4294940105
>  hex dump (first 32 bytes):
>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    28 00 0b 40 00 00 00 00 00 00 00 00 00 00 00 00  (..@............
>  backtrace (crc 9e5f4e84):
>    [<ffffffff81418ff1>] kmem_cache_alloc_noprof+0x2c1/0x360
>    [<ffffffff81d27aa0>] sk_prot_alloc+0x30/0x120
>    [<ffffffff81d2b54c>] sk_alloc+0x2c/0x4b0
>    [<ffffffff81fe049a>] __vsock_create.constprop.0+0x2a/0x310
>    [<ffffffff81fe6d6c>] virtio_transport_recv_pkt+0x4dc/0x9a0
>    [<ffffffff81fe745d>] vsock_loopback_work+0xfd/0x140
>    [<ffffffff810fc6ac>] process_one_work+0x20c/0x570
>    [<ffffffff810fce3f>] worker_thread+0x1bf/0x3a0
>    [<ffffffff811070dd>] kthread+0xdd/0x110
>    [<ffffffff81044fdd>] ret_from_fork+0x2d/0x50
>    [<ffffffff8100785a>] ret_from_fork_asm+0x1a/0x30
>
>Fixes: 3fe356d58efa ("vsock/virtio: discard packets only when socket is really closed")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index ccbd2bc0d2109aea4f19e79a0438f85893e1d89c..cd075f608d4f6f48f894543e5e9c966d3e5f22df 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1512,6 +1512,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 		return -ENOMEM;
> 	}
>
>+	/* __vsock_release() might have already flushed accept_queue.
>+	 * Subsequent enqueues would lead to a memory leak.
>+	 */
>+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>+		virtio_transport_reset_no_sock(t, skb);
>+		return -ESHUTDOWN;
>+	}
>+
> 	child = vsock_create_connected(sk);
> 	if (!child) {
> 		virtio_transport_reset_no_sock(t, skb);
>
>-- 
>2.46.2
>

