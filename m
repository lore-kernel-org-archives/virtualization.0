Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757A511E97
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419130; cv=none; b=aoe4xs93AMFKNADInNU8wye8+sE3aw7V6IrmhOhWrRsx+53fDwPKRRM0aM8R7H5cPccYthEV9IzC8Ny6Eq6h9dkVnUUT/kBGCEC1+K2hW8Vg7o/1aSeCAV/1SxOPd4/U7onvL/badXAGzDsAGp+HmHwLy3zwbiYfUsWQ8POhWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419130; c=relaxed/simple;
	bh=38h+2Yebx/4frhJrkasMSHfDfWCWtifqCUTxn5bBarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bB9ZNsIGe7rlfFCWrfJK4kwDZrhZZrbuzjpgSyuRdqeksshZgdpQCzz1DeiIJdeoPPoIZv04A0KMT5YWNR+iAaPHIf2PrxVFijV33tV3PyK4hDOoTsuOMGwO2QexPlUj60OqYuljMgsDzNOc6fDmofGNJB3CyMekBzcPZFUhCKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKdywTIk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKdywTIk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792419127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2M95tyOOQgifHQf5+1v9W4pLBHiwR5Qq/5/JuiYMWjk=;
	b=FKdywTIkVlVN0ezEdPKhmef1eBqZlKY1XpqYqOa711OY/lHLHfM+TL1Ge3FUIUxMtFXsjM
	4dHw85/0S3LWFgWHHimaB2ih8AXBn0fB8vhFx3RTS5lzyXaq+VSaMDG9JyNN30CldCJ0y1
	IDbEIxm4dmw9fuGuMDUjMhprL+v7tOo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-mErH81dZNtyBcqZLkH2sFA-1; Mon, 19 Oct 2026 14:12:06 +0000
X-MC-Unique: mErH81dZNtyBcqZLkH2sFA-1
X-Mimecast-MFC-AGG-ID: mErH81dZNtyBcqZLkH2sFA_1792419125
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c430f0f01so1830045f8f.1
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 07:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419125; x=1793023925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2M95tyOOQgifHQf5+1v9W4pLBHiwR5Qq/5/JuiYMWjk=;
        b=k5/FWSsw4QBR/zRRHGg/6AnHdcbspipIjKJ+EHlpgCGauK1SCxAtM23ONN1DXJPK8A
         tSDW1disvM2tViovV8eaqBXE3tw/uGcMGYNMvhtohiUzLGbJcpJzFDcQbPjTAbvpFa3e
         dLP/U1zTQu+Jnwemxfufy8BpbltfunHvcWfCg24GJzlqbfndljjfmlH7KqmEiYJPYgp2
         JfsIBUzCcp0YuuMWt0YIHY40quJUDHzvcZUHUytX4k4q/p+Wzffwv9cPgY3kdbtQ16cT
         s7hv06Rzm3hA5TWHKXotwtMWbE1Z3pf602eDFC9P6ukGpx5Jf34ofrAD6vMJlDH68rBc
         XcBg==
X-Forwarded-Encrypted: i=1; AKwUvByQJ6fRMVZ8CgyvDVHeiH9I83nlJP1qvV94D5NERzsuNEAV5UCWJOmnY8uUnNyTCPDhfNbqzqmjfJ40TISB7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKnPhWT8TCjINBmVaBI5CL29Mr/7LVyFYXqXO3sMtS3COKaKAgK
	d0gXHkUW+fY/GjTFV1/7/laaikhdf8if3YQF2xv81U+e3gKOjH2LbbEWv7bHhXi1RardNcojF11
	iWw0T6b+L0X5MZP+AfNtUOFVpKn8LN58kqni54NqmgBlWcL2ImtBsFfSZIjKR0MtBAbyF/LwAKk
	QB
X-Gm-Gg: AYBFou2iFqjYNRHFADAMtnxJrenLm/Exzdp88YgLfy8aLpglUFgXTIVbl5IZpuUYxG2
	e/qwShs3v8F8+Z1xwr/ilxoh2nHnHCLTeesWORJVw47VD9YHviS4TeXGf2awjgHIv4T/tCp1yYN
	lpe/xK1wT4SZo/VRqU0Zp1bSWlxTsjVlxJG1BFKH9PjXcoUR4SxW9lKxCg1ZP9VmXUyRuGqr0UX
	NkxT6FwTygQi9pF18UWsKbk5Y/iTEPHFqEhR2gvRL4jYyOVIr8w2zwW9ymAhlTPUpH0pSHpC3rD
	D20Xi21qLQyZrv6ymzZQkVUuZzaA+GaO4vRIdsYcLQzfZ5eOx+0XEQMuKzZ19+uCiotvzFvUOV2
	dMZYP
X-Received: by 2002:a5d:534f:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48e07f9a00emr12076078f8f.33.1792419124940;
        Mon, 19 Oct 2026 07:12:04 -0700 (PDT)
X-Received: by 2002:a5d:534f:0:b0:486:e707:42eb with SMTP id ffacd0b85a97d-48e07f9a00emr12076004f8f.33.1792419124225;
        Mon, 19 Oct 2026 07:12:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.74.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a72sm25288394f8f.4.2026.10.19.07.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:12:03 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:11:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 4/4] vsock/virtio: defer RX notifications
 until batch unlock
Message-ID: <atYlFHcjGMFxHCuM@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-5-physicalmtea@gmail.com>
 <atI3neoHXhgiEpYJ@sgarzare-redhat>
 <CAJwVaMLmMf1iyWmoZMAJuS2551DsSWSkcRsUVz3M5xi9AXWsWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJwVaMLmMf1iyWmoZMAJuS2551DsSWSkcRsUVz3M5xi9AXWsWg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZRbHYR3RVYWkSc5wOnN0_uGOx1V7UQxvM2xqIdDc3h4_1792419125
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Oct 18, 2026 at 12:55:35PM +0800, Jia Jia wrote:
>>
>> On Wed, Oct 14, 2026 at 07:56:40PM +0800, Jia Jia wrote:
>> >An RX batch can make a socket readable while the worker still holds its
>> >socket lock. Waking a blocking reader then only moves it to waiting for
>> >the same lock.
>> >
>> >Record the existing low-watermark condition and notify once after
>> >release_sock(). Move the coalesced write-space notification after the
>> >unlock as well, since both callbacks wake sk_sleep(sk). Deliver
>> >write-space before data-ready and keep the lookup reference until both
>> >callbacks complete.
>> >
>> >As with write-space, save the initial sk_data_ready callback and batch only
>> >while both saved callbacks remain installed. Sockets with replaced
>> >callbacks retain their per-packet behavior.
>> >
>> >The existing psock-marker check also covers a concurrent sockmap attach:
>> >at most the already admitted packet completes on the native path, and the
>> >next packet ends the batch.
>> >
>> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>> >---
>> > include/linux/virtio_vsock.h            |  1 +
>> > include/net/af_vsock.h                  |  5 ++--
>> > net/vmw_vsock/af_vsock.c                |  1 +
>> > net/vmw_vsock/virtio_transport_common.c | 35 ++++++++++++++++++-------
>> > 4 files changed, 31 insertions(+), 11 deletions(-)
>> >
>> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >index bf077ee0ded88..f1396ca3ad9b5 100644
>> >--- a/include/linux/virtio_vsock.h
>> >+++ b/include/linux/virtio_vsock.h
>> >@@ -288,6 +288,7 @@ struct virtio_transport_rx_batch {
>> >       unsigned int pkts;
>> >       size_t bytes;
>> >       bool write_space_pending;
>> >+      bool data_ready_pending;
>> > };
>> >
>> > void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> >index 9a40960d10cbe..78bab5820f528 100644
>> >--- a/include/net/af_vsock.h
>> >+++ b/include/net/af_vsock.h
>> >@@ -64,9 +64,10 @@ struct vsock_sock {
>> >       bool sent_request;
>> >       bool ignore_connecting_rst;
>> >       /*
>> >-       * Initial callback, used to identify replacements and deliver deferred
>> >-       * write-space notifications.
>> >+       * Initial callbacks, used to identify replacements and deliver deferred
>> >+       * notifications.
>> >        */
>> >+      void (*default_data_ready)(struct sock *sk);
>> >       void (*default_write_space)(struct sock *sk);
>> >
>> >       /* Protected by lock_sock(sk) */
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index fe7f49da6c4bc..f40659ec29df0 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
>> >               sk->sk_type = type;
>> >
>> >       vsk = vsock_sk(sk);
>> >+      vsk->default_data_ready = sk->sk_data_ready;
>> >       vsk->default_write_space = sk->sk_write_space;
>> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index f4b5f0230493e..8b62b789b71c5 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1588,7 +1588,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> >
>> > static int
>> > virtio_transport_recv_connected(struct sock *sk,
>> >-                              struct sk_buff *skb)
>> >+                              struct sk_buff *skb,
>> >+                              bool *data_ready_pending)
>> > {
>> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> >       struct vsock_sock *vsk = vsock_sk(sk);
>> >@@ -1607,7 +1608,13 @@ virtio_transport_recv_connected(struct sock *sk,
>> >                       vsock_remove_sock(vsk);
>> >                       break;
>> >               }
>> >-              vsock_data_ready(sk);
>> >+              if (!data_ready_pending) {
>> >+                      vsock_data_ready(sk);
>> >+              } else if (!*data_ready_pending &&
>> >+                         (vsock_stream_has_data(vsk) >= sk->sk_rcvlowat ||
>> >+                          sock_flag(sk, SOCK_DONE))) {
>> >+                      *data_ready_pending = true;
>> >+              }
>> >               return err;
>> >       case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>> >               virtio_transport_send_credit_update(vsk);
>> >@@ -1820,6 +1827,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> >       return sk->sk_state == TCP_ESTABLISHED &&
>> >              sk->sk_type == SOCK_STREAM &&
>> >              READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>> >+             READ_ONCE(sk->sk_data_ready) == vsk->default_data_ready &&
>> >              READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
>> >              !sock_flag(sk, SOCK_DONE) &&
>> >              vsk->transport == &t->transport &&
>> >@@ -1830,8 +1838,9 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> > /*
>> >  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>> >  * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
>> >- * record a default write-space notification for batch finish instead of
>> >- * delivering it immediately.  Return true if the caller must free @skb.
>> >+ * record default write-space and data-ready notifications for batch finish
>> >+ * instead of delivering them immediately.  Return true if the caller must
>> >+ * free @skb.
>> >  */
>> > static bool
>> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >@@ -1883,7 +1892,9 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >               kfree_skb(skb);
>> >               break;
>> >       case TCP_ESTABLISHED:
>> >-              virtio_transport_recv_connected(sk, skb);
>> >+              virtio_transport_recv_connected(sk, skb,
>> >+                                              batch ?
>> >+                                              &batch->data_ready_pending : NULL);
>> >               break;
>> >       case TCP_CLOSING:
>> >               virtio_transport_recv_disconnecting(sk, skb);
>> >@@ -1957,27 +1968,33 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>> > /*
>> >  * Finish the RX batch.
>> >  * For a non-empty batch, the caller holds the socket lock acquired with
>> >- * lock_sock(). Deliver any deferred write-space notification while the lock
>> >- * is held, then release the lock and the batch's lookup reference.
>> >- * An empty batch is a no-op.
>> >+ * lock_sock(). Release the lock, deliver any deferred write-space and
>> >+ * data-ready notifications in that order, then drop the batch's lookup
>> >+ * reference. An empty batch is a no-op.
>> >  */
>> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>> > {
>> >       bool write_space_pending = batch->write_space_pending;
>> >+      bool data_ready_pending = batch->data_ready_pending;
>> >       struct sock *sk = batch->sk;
>> >
>> >       batch->sk = NULL;
>> >       batch->pkts = 0;
>> >       batch->bytes = 0;
>> >       batch->write_space_pending = false;
>> >+      batch->data_ready_pending = false;
>> >
>> >       if (!sk)
>> >               return;
>> >
>> >+      release_sock(sk);
>> >+
>>
>> Why in the previous patch we release the socket after calling
>> default_write_space() and now we are moving before?
>>
>
>My intention was to keep the two behavioral changes separately
>testable. Patch 3 is a complete intermediate state: it coalesces
>repeated sk_write_space()
>notifications while preserving the existing under-lock callback
>context. Patch 4 then adds data-ready coalescing and moves both
>deferred notifications
>after release_sock(). Patch 4 therefore builds on Patch 3 rather than fixing it.

Okay, I see, makes sense, please make it clear in the commit 
description.

Thanks,
Stefano

>
>> >       if (write_space_pending)
>> >               vsock_sk(sk)->default_write_space(sk);
>> >
>> >-      release_sock(sk);
>> >+      if (data_ready_pending)
>> >+              vsock_sk(sk)->default_data_ready(sk);
>> >+
>> >       sock_put(sk);
>> > }
>> > EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);
>> >--
>> >2.53.0
>> >
>>
>

