Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E882FDC4D
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447715; cv=none; b=E+bLndp3+k0LVxzpYubOSO8VwFRawmmjSiAOin7ngrJduB68ACiA6gmKIR3VGQCdrf7JCP0bG+nNKsMy1nzcSNVPZgqOUq/kweBtWWFTUQQp0VAhu+m9f9A8HORap2r7p9kXCHwfHqfo9crehsWE7D9iFLaHgw9FAPu5poY+6uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447715; c=relaxed/simple;
	bh=Z6F4cyJG0ag9g4o6gvbAfAEBxmgGeyUKxQcpLWwALwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t05s488gFsTNbGpzv8xzP5DBPfCBvP6kEyEjDMNz786/F03xVgKpa96/OF02pXZSnNSKi6K6yZAOT4ugTZ54fdvHxLmRA3gr4KHO93YnkcKsDVJNjwECejhycxE1L0xVS4do/9w45wOGxiDlNr8ueTBGL8pMcGDN8/kWL9PTwN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDl+7uZW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDl+7uZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765447712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=It7DxdigJxddZuWUloOutXizs1cOeKKTv93WFfqSdUU=;
	b=UDl+7uZWzHfeTTiRYo9OP7bYqodTJH2CcWMQjkE1ChW0siV3Ki8Zf8KsslkDEvJbWbRKgL
	a2eTrTQVcICU5QB4SvzLIztL8ZRtDY+1f8F0Cng2LzkdHLQ2fw2vxUR3j8zLPaigk94Vd8
	kjtJhXfXVoH+Xzlnz424X3CZLL7IRv4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-P5d2TSKwPT6EBinYPz_OdQ-1; Thu, 11 Dec 2025 05:08:31 -0500
X-MC-Unique: P5d2TSKwPT6EBinYPz_OdQ-1
X-Mimecast-MFC-AGG-ID: P5d2TSKwPT6EBinYPz_OdQ_1765447710
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b79f6f91bcbso184079966b.0
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 02:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765447710; x=1766052510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It7DxdigJxddZuWUloOutXizs1cOeKKTv93WFfqSdUU=;
        b=AeDpJTEOUYRjnRB6T/H7+lONdN+UcU+I8iqeQgcLLNMwvgdYOtyF0CNWDbmjFL7vxN
         dcuw3rwxSfKS34qK75Wn+viu/EiRR2mgrTMaaCfOmcD07Y2ZI5t7X7h4Ma4sVwtsW4v8
         vzBGrT5CEUYxON4aTNuz4qk0N6T12hIG4mpIC6a5zhrPtaazO8oOiJ8goRDnRCuE94cP
         gJOK56pzJXgXSItPN5SFOoQKcni9xjJYPeh96pq8dGV6AKV8aBerg9z1yDfL2tF2CZfw
         0Gopi29UfAqKQ2OD5RvQLTi6pRkNPY0AaQt+A2IgN2zEfI+MtYcYifqEG1Qx8CzLRmbT
         bIjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJq8K2cxQPqBA6u9Feo4GH3fCT86KHNECn8VkUF00IBsMXsvlcppvH+4gWgZAdQh5u4AtRlva7ZVHSph+PGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8Fr3zk5Ia/TD4hcGthm+y3royck5j2efht0QLFADBAUDTO+wu
	uQ3+ondckxgXTSXfqK2VT81Wm2qHZ9RBu12ZJTyl3HlKdKkSoR0lBYsalbHuKhvdMuJ84hEdS0f
	Woe+Ipu5Z2GETxIC3Dp7bCG/PeBJoa6SbsZ7V0lAvlFpIWJBC0Wa+6Z3p81ny3KHRqQpw
X-Gm-Gg: AY/fxX7sIzUOVHlLBxJl8/1l6s+mRC0Xm0QFR+RMnETOngypjn8Nx4j6rLmHk7A6IkS
	oOmGFRCqAOCoZ6lcaBzn0sYvw5jz9ibX9zHm2NSuE06liKsJRC0j9ExaKhu5dEGtgw7lCP3kdgt
	EL0XtbtUQZvBpGFWCp8fPPLY0KJ1Qyce8/RZd6i2S59GuJ8z7J4lcJHNSoH09PMYAWAd8l3jBWP
	BS8693+h64RbSHKCLZcfNJ5k29+3wQIkhYnhVjm/qfb8ibWuIbGeGlK2MEZkBHT9dSCWh7WvJyW
	inmVcIt7sVErjyhJW3293rI0L4YJMnKCrLykIOv4ab3NGg9ArA7YWOamdfLFwbWeeRUYNsJDdOL
	4na4e40g97rJGlFGtBi36QM9fZFw5MxySsXingpdbbABoyoJeB48tP59EOaZI0w==
X-Received: by 2002:a17:907:da2:b0:b73:43ee:a262 with SMTP id a640c23a62f3a-b7ce847d2f4mr637242866b.51.1765447709756;
        Thu, 11 Dec 2025 02:08:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIvJ2BgbEFzBe9LXBrZFx1TCLyohl5hausmIEk65oCIi6GUKf+K0NeBup5hRhrXwmZL3RA0g==
X-Received: by 2002:a17:907:da2:b0:b73:43ee:a262 with SMTP id a640c23a62f3a-b7ce847d2f4mr637239766b.51.1765447709120;
        Thu, 11 Dec 2025 02:08:29 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb69sm230379866b.6.2025.12.11.02.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:08:27 -0800 (PST)
Date: Thu, 11 Dec 2025 11:08:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: cap TX credit to local buffer size
Message-ID: <CAGxU2F6TMP7tOo=DONL9CJUW921NXyx9T65y_Ai5pbzh1LAQaA@mail.gmail.com>
References: <20251210150019.48458-1-mlbnkm1@gmail.com>
 <ctubihgjn65za4hbmanhkzg7psr6kmj3jeqfj5sfxnnxjjvrsy@l6644u74vrn6>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ctubihgjn65za4hbmanhkzg7psr6kmj3jeqfj5sfxnnxjjvrsy@l6644u74vrn6>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e7IpcmOctOZOeIOivx7ZbnV3gkXHNG49eG9tmgURZCk_1765447710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, 11 Dec 2025 at 10:10, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Dec 10, 2025 at 04:00:19PM +0100, Melbin K Mathew wrote:
> >The virtio vsock transport currently derives its TX credit directly
> >from peer_buf_alloc, which is set from the remote endpoint's
> >SO_VM_SOCKETS_BUFFER_SIZE value.
>
> Why removing the target tree [net] from the tags?
>
> Also this is a v2, so the tags should have been [PATCH net v2], please
> check it in next versions, more info:
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line
>
> >
> >On the host side this means that the amount of data we are willing to
> >queue for a connection is scaled by a guest-chosen buffer size,
> >rather than the host's own vsock configuration. A malicious guest can
> >advertise a large buffer and read slowly, causing the host to allocate
> >a correspondingly large amount of sk_buff memory.
> >
> >Introduce a small helper, virtio_transport_peer_buf_alloc(), that
> >returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
> >peer_buf_alloc:
> >
> >  - virtio_transport_get_credit()
> >  - virtio_transport_has_space()
> >  - virtio_transport_seqpacket_enqueue()
> >
> >This ensures the effective TX window is bounded by both the peer's
> >advertised buffer and our own buf_alloc (already clamped to
> >buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
> >cannot force the host to queue more data than allowed by the host's
> >own vsock settings.
> >
> >On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> >32 guest vsock connections advertising 2 GiB each and reading slowly
> >drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> >recovered after killing the QEMU process.
> >
> >With this patch applied, rerunning the same PoC yields:
> >
> >  Before:
> >    MemFree:        ~61.6 GiB
> >    MemAvailable:   ~62.3 GiB
> >    Slab:           ~142 MiB
> >    SUnreclaim:     ~117 MiB
> >
> >  After 32 high-credit connections:
> >    MemFree:        ~61.5 GiB
> >    MemAvailable:   ~62.3 GiB
> >    Slab:           ~178 MiB
> >    SUnreclaim:     ~152 MiB
> >
> >i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> >guest remains responsive.
>
> I think we should include here a summary of what you replied to Michael
> about other transports.
>
> I can't find your reply in the archive, but I mean the reply to
> https://lore.kernel.org/netdev/20251210084318-mutt-send-email-mst@kernel.org/
>
> >
> >Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> >Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> > 1 file changed, 24 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index dcc8a1d58..02eeb96dd 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> > }
> > EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> >
> >+/*
> >+ * Return the effective peer buffer size for TX credit computation.
>
> nit: block comment in this file doesn't leave empty line, so I'd follow
> it:
>
> @@ -491,8 +491,7 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>   }
>   EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
> -/*
> - * Return the effective peer buffer size for TX credit computation.
> +/* Return the effective peer buffer size for TX credit computation.
>    *
>    * The peer advertises its receive buffer via peer_buf_alloc, but we
>    * cap that to our local buf_alloc (derived from
>
> >+ *
> >+ * The peer advertises its receive buffer via peer_buf_alloc, but we
> >+ * cap that to our local buf_alloc (derived from
> >+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> >+ * so that a remote endpoint cannot force us to queue more data than
> >+ * our own configuration allows.
> >+ */
> >+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
> >+{
> >+      u32 peer  = vvs->peer_buf_alloc;
> >+      u32 local = vvs->buf_alloc;
> >+
> >+      if (peer > local)
> >+              return local;
> >+      return peer;
> >+}
> >+
>
> I think here Michael was suggesting this:
>
> @@ -502,12 +502,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>    */
>   static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>   {
> -       u32 peer  = vvs->peer_buf_alloc;
> -       u32 local = vvs->buf_alloc;
> -
> -       if (peer > local)
> -               return local;
> -       return peer;
> +       return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>   }
>
>
> > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> > {
> >       u32 ret;
> >@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> >               return 0;
> >
> >       spin_lock_bh(&vvs->tx_lock);
> >-      ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >+      ret = virtio_transport_tx_buf_alloc(vvs) -
> >+            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >       if (ret > credit)
> >               ret = credit;
> >       vvs->tx_cnt += ret;
> >@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
> >
> >       spin_lock_bh(&vvs->tx_lock);
> >
> >-      if (len > vvs->peer_buf_alloc) {
> >+      if (len > virtio_transport_tx_buf_alloc(vvs)) {
> >               spin_unlock_bh(&vvs->tx_lock);
> >               return -EMSGSIZE;
> >       }
> >@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> >       struct virtio_vsock_sock *vvs = vsk->trans;
> >       s64 bytes;
> >
> >-      bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >+      bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> >+            (vvs->tx_cnt - vvs->peer_fwd_cnt);
>
> nit: please align this:
>
> @@ -903,7 +898,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>          s64 bytes;
>
>          bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> -             (vvs->tx_cnt - vvs->peer_fwd_cnt);
> +               (vvs->tx_cnt - vvs->peer_fwd_cnt);
>          if (bytes < 0)
>                  bytes = 0;
>
>
> Just minor things, but the patch LGTM, thanks!

I just noticed that vsock_test are now failing because one peer (client)
try to send more than TX buffer while the RX is waiting for the whole
data.

This should fix the test:

From b69ca1fd3d544345b02cedfbeb362493950a87c1 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 11 Dec 2025 10:55:06 +0100
Subject: [PATCH 1/1] vsock/test: fix seqpacket message bounds test

From: Stefano Garzarella <sgarzare@redhat.com>

The test requires the sender (client) to send all messages before waking
up the receiver (server).
Since virtio-vsock had a bug and did not respect the size of the TX
buffer, this test worked, but now that we have fixed the bug, it hangs
because the sender fills the TX buffer before waking up the receiver.

Set the buffer size in the sender (client) as well, as we already do for
the receiver (server).

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9e1250790f33..af6665ed19d5 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
+	unsigned long long sock_buf_size;
 	unsigned long curr_hash;
 	size_t max_msg_size;
 	int page_size;
@@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	sock_buf_size = SOCK_BUF_SIZE;
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
+			    sock_buf_size,
+			    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
+
+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+			    sock_buf_size,
+			    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+
 	/* Wait, until receiver sets buffer size. */
 	control_expectln("SRVREADY");
 
-- 
2.52.0

Please add that patch to a series (e.g. v3) which includes your patch,
and that fix for the test.

Maybe we can also add a new test to check exactly the problem you're
fixing, to avoid regressions.

Thanks,
Stefano

