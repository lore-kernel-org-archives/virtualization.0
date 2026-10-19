Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784C54F6493
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419063; cv=none; b=Z/2+2hg5aJvDIFmAwDoR2gr0e04oycpr2wCqCvdWMrBsWXnr9wTh5IRy+w0oJCfA/bE9C6nL98DzVl02QwxFga85HRh2juuJchvhpuU+voAgxS1y08qNGEl6MPVA/RiJmtaSPuxpxKwaI2rV6rYXrxp/JkMS60wgXoBvdgI+WyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419063; c=relaxed/simple;
	bh=Zj3kUlx08QelHnXt2PsIv3sn/GVI7uVy5Muk9eGsATI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Kqz7Xg+FyOrGUdha4np2IIuonN1NyleLsdCwJRitrMGQNal5zIe0iwuCSx8X8RBJW+bAEmTbVXLvRdQgAhnJQQG4xYGSXakPbQCMGu/Cshc6LoRAQuBAvNauSny+anIgcKlrHVEttEQdqfzHpCWtvzdd99nTO3lOIwKLs34++Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdp7s6Bs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdp7s6Bs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792419058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgOW7Zlj1K/20x014o5My5tLoawxtT2jFwJJdENYGW0=;
	b=gdp7s6BsGbfK9fnOa85lp9GOqd/DoOIYFWHDr4gB8MEAYKpEIt+cc3z5EsRr8RMJQYzOvC
	pmkxdQBtCtenct5l/+sNXFtiu8JQkBKEgGmJPdssepiko/p9jsx8Ku3Dj9VTMvANGcMPp7
	7hrDOXCvkGjU/HPotQQm01gB2RWmR5g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-3Oqe4Gl_OnCH-Gl14EiBtw-1; Mon, 19 Oct 2026 14:10:57 +0000
X-MC-Unique: 3Oqe4Gl_OnCH-Gl14EiBtw-1
X-Mimecast-MFC-AGG-ID: 3Oqe4Gl_OnCH-Gl14EiBtw_1792419056
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c46582442so1400259f8f.0
        for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 07:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419056; x=1793023856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TgOW7Zlj1K/20x014o5My5tLoawxtT2jFwJJdENYGW0=;
        b=0M9yDiuaPhoWRii1WfgD+MaWSwDsHjLnEvuC1KNQdDO6itxytBlYc6WVnzkqLBBA3M
         1BgU4A6iAhnU9KMxOliGownuMzXxmtjju3Ww+Hd9Ccvea/KFvACwLB2MZOxy/ANOOtkm
         XeFSUZVt6UKf0lX87E6uW7MyRwPwBp5SqZEuqphJN/fyoCKtztyAKwJZJ3rwdJXC8MwB
         XzG1cuEa7kMpXpw3rxuUwnEYlLOL2fQZ9pveElUDiSW/an8gkvWVziZVzMEjA+o+34zC
         yJfB/o4gTtXxxY0QdfUD5M7BKTkr6ndTkaevvlFt/DlGH7u2cewGNTYKLuVGqq0sBtt6
         FUXw==
X-Forwarded-Encrypted: i=1; AKwUvBxwlJapUQRmFkusF8LEKN7Sn+jzxWVKQ3B0JRlkwn3i+5Jq0nNV02pYbsIDIvjXFoSR/yVj8v2B7mUGoEBJPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIKq6UDJ1Ss1uG5PbY5tbLLhdKRGAkNdDeMGLbt9k8xk9dwwBcm
	e8dHRB1aPIJIQIT9hABreUUfvkYkS3ZEubbKv5uHmZRGm0CAR+RQDPV60MYL4xvf+kfJK6ecgwR
	LR1uYR8hdmuiSyYzRnVJgkHXuvbfUaJKKmvB4kjzkkFW0Aq6Ntgr9crkOauEtfPTbNqBr
X-Gm-Gg: AYBFou24s4C7yqo6eXwxR5Jqy7YXYart+Uh7lbFBD6K6BtF8HVgjWbJtFoSfcH1unzu
	90N/qB6kPRrS7m7nDgJJGEVyhstoXGJvd2EEPW1vNHOcYd2Uuuswx9NPADPP/WsZl2ZvKlvUDqo
	Va7yxZZ7Esgh3PFfGYqGEp1cusiX7GlTwvAsfrCACrUH+1GWZgXoG9fVTMLVrmoNtk+7yGdy/rl
	fvUxTEng9idKwr0cI0eW+hbHNzAN+RPgAm6bcn2Iv0yri+7og0tt9LtVD6Wgph+GPeQ6Ps4+mK6
	AsA2PGn0BtjxB0WfJOJkyD5W++R5M92t4/1NuqLcYagxfHHnS8myEM0UgPWpwhi8dXlHRWM/ynN
	ZFPMd
X-Received: by 2002:a05:6000:1ac9:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e07f99197mr16192198f8f.39.1792419055328;
        Mon, 19 Oct 2026 07:10:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e07f99197mr16192044f8f.39.1792419054278;
        Mon, 19 Oct 2026 07:10:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.74.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4fe9d9sm22231972f8f.40.2026.10.19.07.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:10:53 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:10:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v4 3/4] vsock/virtio: coalesce RX write-space
 notifications in lock batches
Message-ID: <atYj6RxulTke6TJG@sgarzare-redhat>
References: <20261014115640.184286-1-physicalmtea@gmail.com>
 <20261014115640.184286-4-physicalmtea@gmail.com>
 <atI1-_FAri2x-k2p@sgarzare-redhat>
 <CAJwVaM+syOjuJ-Vk3dfvZv7WLJ=s2ne3WaFf+jHY1JQY0mc+2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJwVaM+syOjuJ-Vk3dfvZv7WLJ=s2ne3WaFf+jHY1JQY0mc+2Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uaeYONLBxFllsLm0rUJSxLVMcVX0ST-hEkZvi9MmhcE_1792419056
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 12:54:50PM +0800, Jia Jia wrote:
>>
>> On Wed, Oct 14, 2026 at 07:56:39PM +0800, Jia Jia wrote:
>> >Each received packet updates peer credit and may call sk_write_space().
>> >A writer cannot use that credit until the batch releases the socket lock,
>> >so one notification at batch finish is sufficient.
>> >
>> >Save the initial sk_write_space callback when the AF_VSOCK socket is
>> >created and require it to remain installed for batching. This lets the
>> >transport module deliver the deferred notification without referring to
>> >the unexported default callback. Sockets with replaced callbacks retain
>> >their per-packet behavior.
>> >
>> >Record the batch socket before processing its first packet so a batch that
>> >ends on that packet cannot lose the pending notification.
>>
>> mmm, is this a fix of the previous patch?
>>
>
>No. Patch 2 preserves the existing per-packet sk_write_space()
>behavior, so Patch 3 is not a correctness fix for it. Patch 3 only
>coalesces the native/ default notifications.
>
>Moving batch->sk earlier is required only after the deferred state is
>introduced here: the socket must already be recorded before the first
>packet can set write_space_pending, so the notification can still be
>delivered if that packet immediately ends the batch. Sorry, the commit
>message did not make this distinction clear.

Yeah, please, make reviewers life easier explaining these kind of info, 
dependency. Also, incremental performance numbers would be nice to be 
included also in singe patches.

>
>> >
>> >Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>> >---
>> > include/linux/virtio_vsock.h            |  1 +
>> > include/net/af_vsock.h                  |  5 +++
>> > net/vmw_vsock/af_vsock.c                |  1 +
>> > net/vmw_vsock/virtio_transport_common.c | 53 +++++++++++++++++--------
>> > 4 files changed, 44 insertions(+), 16 deletions(-)
>> >
>> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> >index 26dde6909c4ed..bf077ee0ded88 100644
>> >--- a/include/linux/virtio_vsock.h
>> >+++ b/include/linux/virtio_vsock.h
>> >@@ -287,6 +287,7 @@ struct virtio_transport_rx_batch {
>> >       struct sock *sk;
>> >       unsigned int pkts;
>> >       size_t bytes;
>> >+      bool write_space_pending;
>> > };
>> >
>> > void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> >index 5549298c1ec6b..9a40960d10cbe 100644
>> >--- a/include/net/af_vsock.h
>> >+++ b/include/net/af_vsock.h
>> >@@ -63,6 +63,11 @@ struct vsock_sock {
>> >       u32 peer_shutdown;
>> >       bool sent_request;
>> >       bool ignore_connecting_rst;
>> >+      /*
>> >+       * Initial callback, used to identify replacements and deliver deferred
>> >+       * write-space notifications.
>> >+       */
>> >+      void (*default_write_space)(struct sock *sk);
>>
>> This is kind of virtio-vsock specific, why need to be here?
>>
>
>I stored this state here because __vsock_create() can capture the
>native callback before the socket is exposed or any callback
>replacement occurs, and the transport cannot directly reference the
>unexported default callback. However, I agree that exposing this
>virtio-specific state directly in struct vsock_sock is not ideal. I'll
>look at hiding it behind an AF_VSOCK helper in v5 while preserving the
>capture point and the lifetime required by deferred callbacks.
>
>
>> >
>> >       /* Protected by lock_sock(sk) */
>> >       u64 buffer_size;
>> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> >index 44cee74519555..fe7f49da6c4bc 100644
>> >--- a/net/vmw_vsock/af_vsock.c
>> >+++ b/net/vmw_vsock/af_vsock.c
>> >@@ -958,6 +958,7 @@ static struct sock *__vsock_create(struct net *net,
>> >               sk->sk_type = type;
>> >
>> >       vsk = vsock_sk(sk);
>> >+      vsk->default_write_space = sk->sk_write_space;
>> >       vsock_addr_init(&vsk->local_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >       vsock_addr_init(&vsk->remote_addr, VMADDR_CID_ANY, VMADDR_PORT_ANY);
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index ff74e805527a5..f4b5f0230493e 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1820,6 +1820,7 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> >       return sk->sk_state == TCP_ESTABLISHED &&
>> >              sk->sk_type == SOCK_STREAM &&
>> >              READ_ONCE(sk->sk_prot) == sk->sk_prot_creator &&
>> >+             READ_ONCE(sk->sk_write_space) == vsk->default_write_space &&
>>
>> Why?
>>
>
>I believe this check is necessary because notification coalescing is
>only safe for the original native sk_write_space callback. Sockmap can
>replace this callback under sk_callback_lock, which is independent of
>the socket lock held across the batch, and the replacement may require
>per-packet handling. Comparing it with the callback captured at socket
>creation lets us fall back to the existing per-packet behavior when it
>has been replaced. I'll add a comment explaining this.
>
>
>> >              !sock_flag(sk, SOCK_DONE) &&
>> >              vsk->transport == &t->transport &&
>> >              vvs && virtio_transport_rx_skb_has_headroom(vvs) &&
>> >@@ -1828,13 +1829,15 @@ virtio_transport_recv_pkt_batchable(struct virtio_transport *t,
>> >
>> > /*
>> >  * The caller holds sk's socket lock.  Set @batchable if the socket can remain
>> >- * locked for another ordinary STREAM/RW packet.  Return true if the caller
>> >- * must free @skb.
>> >+ * locked for another ordinary STREAM/RW packet.  When @batch is non-NULL,
>> >+ * record a default write-space notification for batch finish instead of
>> >+ * delivering it immediately.  Return true if the caller must free @skb.
>> >  */
>> > static bool
>> > virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >                                struct sk_buff *skb, struct sock *sk,
>> >-                               bool *batchable)
>> >+                               bool *batchable,
>> >+                               struct virtio_transport_rx_batch *batch)
>> > {
>> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> >       struct sockaddr_vm src;
>> >@@ -1863,8 +1866,12 @@ virtio_transport_recv_pkt_locked(struct virtio_transport *t,
>> >       if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
>> >               vsk->local_addr.svm_cid = le64_to_cpu(hdr->dst_cid);
>> >
>> >-      if (space_available)
>> >-              sk->sk_write_space(sk);
>> >+      if (space_available) {
>> >+              if (batch)
>> >+                      batch->write_space_pending = true;
>> >+              else
>> >+                      sk->sk_write_space(sk);
>> >+      }
>> >
>> >       switch (sk->sk_state) {
>> >       case TCP_LISTEN:
>> >@@ -1931,7 +1938,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >       }
>> >
>> >       lock_sock(sk);
>> >-      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL);
>> >+      free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk, NULL, NULL);
>> >       release_sock(sk);
>> >
>> >       /* Release refcnt obtained when we fetched this socket out of the
>> >@@ -1949,22 +1956,27 @@ EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
>> >
>> > /*
>> >  * Finish the RX batch.
>> >- * For a non-empty batch, the caller must hold the socket lock acquired with
>> >- * lock_sock(). This function releases the lock and the batch's lookup
>> >- * reference.
>> >+ * For a non-empty batch, the caller holds the socket lock acquired with
>> >+ * lock_sock(). Deliver any deferred write-space notification while the lock
>> >+ * is held, then release the lock and the batch's lookup reference.
>> >  * An empty batch is a no-op.
>> >  */
>> > void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>> > {
>> >+      bool write_space_pending = batch->write_space_pending;
>> >       struct sock *sk = batch->sk;
>> >
>> >       batch->sk = NULL;
>> >       batch->pkts = 0;
>> >       batch->bytes = 0;
>> >+      batch->write_space_pending = false;
>> >
>> >       if (!sk)
>> >               return;
>> >
>> >+      if (write_space_pending)
>> >+              vsock_sk(sk)->default_write_space(sk);
>> >+
>> >       release_sock(sk);
>> >       sock_put(sk);
>> > }
>> >@@ -2019,7 +2031,8 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>> >                       }
>> >
>> >                       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>> >-                                                                  &batchable);
>> >+                                                                  &batchable,
>> >+                                                                  batch);
>> >                       if (!batchable)
>> >                               virtio_transport_rx_batch_finish(batch);
>> >                       if (free_pkt)
>> >@@ -2059,23 +2072,31 @@ void virtio_transport_recv_pkt_batch(struct virtio_transport *t,
>> >
>> >       lock_sock(sk);
>> >       /*
>> >-       * Sockmap removal restores the native protocol under sk_callback_lock.
>> >-       * Serialize this initial eligibility check with that update.
>> >+       * Sockmap teardown restores callbacks under sk_callback_lock. Keep the
>> >+       * initial eligibility check consistent with that update.
>> >        */
>>
>> Unrelated change?
>>
>
>This is related to the new callback eligibility check, but I agree
>that the original rewrite was unnecessary. I’ll keep the original
>serialization wording and only extend the comment to mention both the
>native protocol and callbacks.
>
>> BTW if you are assisted by AI, please read https://docs.kernel.org/process/coding-assistants.html
>>
>
>Thanks for the reminder. I read the document when you mentioned it
>previously.  take responsibility for every change in it. As this
>review has shown, I missed some netdev conventions, and the patch
>organization can also be improved; those are my mistakes, and I’ll
>address them in v5.
>
>I used an LLM to help set up the test environment, translate and
>polish the English text, and review the series. I ran and verified the
>tests myself. I’ll
>disclose that assistance in v5 as described in the documentation.

Okay, this is a great use of LLMs IMO and maybe don't need the tag.

Thanks,
Stefano

>
>
>> >       read_lock_bh(&sk->sk_callback_lock);
>> >       start_batch = virtio_transport_recv_pkt_batchable(t, sk);
>> >       read_unlock_bh(&sk->sk_callback_lock);
>> >
>> >+      if (start_batch)
>> >+              batch->sk = sk;
>> >+
>> >       free_pkt = virtio_transport_recv_pkt_locked(t, skb, sk,
>> >-                                                  start_batch ? &batchable : NULL);
>> >+                                                  start_batch ? &batchable : NULL,
>> >+                                                  start_batch ? batch : NULL);
>> >       if (start_batch && batchable) {
>> >               /* Keep the lookup reference until the batch is released. */
>> >-              batch->sk = sk;
>> >               return;
>> >       }
>> >
>> >-      release_sock(sk);
>> >-      sock_put(sk);
>> >+      if (start_batch) {
>> >+              virtio_transport_rx_batch_finish(batch);
>> >+      } else {
>> >+              release_sock(sk);
>> >+              sock_put(sk);
>> >+      }
>> >+
>> >       if (free_pkt)
>> >               kfree_skb(skb);
>> > }
>> >--
>> >2.53.0
>> >
>>
>

