Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438B3126AB
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765457731; cv=none; b=VOjkdzGvixlbpHBMT3eRhaTPb6/QIL9I5GIHTq//nrDvKMu3zsvOt0HC/TUcT3WkpXOf720vxipTJc9R7zWORyHJKZ3OqEkYJM36ml/QaAMpP7dsPRlJfr06oPcTl/sEUVlAlE6hKsPHICZeNypg+sALqyRSGrcGJH0cKgK8ZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765457731; c=relaxed/simple;
	bh=GBLapbLKXBRGhmi3VzSpdfUo6M+SRluFuLYf0fhNOzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jmb+NlcCrNXOgSKS6JX9KD9jjOI6wHBkk6weftJLIhrByp/ZMh3ets4AhocaNAEKgrx6WidmUoW6CSJd2W3zzW8ufg6I6IHFubOzlbjCT2b4y383aKq2gRCM42FSx6vuX185W7FdK0yY9NRRffHnhZwS1Pw5KG2Hv5hT1d4FPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzoB6fSR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzoB6fSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765457728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/U3/mIIeh6oyj7R9BdLHvhs0yBtnDcHOXobfBr2NkWQ=;
	b=TzoB6fSRfGkmFHGGvh2XKcOQBSsZIj9VNFyyZrT/VYO3RleLbZXKOaxwSVzxJmt5cczvFN
	3Tq1bDk+SKsRUEUBSIQQ1dsURwVNOc3Q9G332b0R9OSYRxX6HCfuWqLkxhXJd9r2ChNdOt
	O8Qt3NhVtdwUIxJTVNxDQSvmeE/M8pY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-fRZJv5bLNYyaofv4chu1og-1; Thu, 11 Dec 2025 07:55:25 -0500
X-MC-Unique: fRZJv5bLNYyaofv4chu1og-1
X-Mimecast-MFC-AGG-ID: fRZJv5bLNYyaofv4chu1og_1765457724
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2958c80fcabso1096255ad.0
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765457724; x=1766062524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U3/mIIeh6oyj7R9BdLHvhs0yBtnDcHOXobfBr2NkWQ=;
        b=HHKeaefYr3cDjYraZboceBhawfHsx2q5osRBBzC6IhUmkxmr01L8NPTv8RC1wH8oPl
         wjs+YrnfNYhq9RJdbXdlvwOV31tM8GUmro1T86kaSWgaYVD2W6bsqDNY/mhnTzmytwWm
         FtXRHQcS50rA9FpkcJsZwXFMTnimaRteg7uHjEHyn6a78YBWvdu6nkiuDCjs3wJDYF1H
         zAuSVBFWf1hOjLpDkHoZrLQh7Y7WaIfneKUu7lqtYU1/pS4N+0/Hld7kIFKxMd5az565
         TzR35djCLvkcykIkJGzdjvWAKvayabjM9dF+h30g36iPhsLnIKw/yvvHPMiiizZ38VT1
         ziMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+OBCR+o3Mu8K/VnU/lP8JgyuQrz3HXZoLeqoCrfBAnMqV3CvOyhwVkxqnf4G1GmL69gleMSN9F6mptYxigA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+UhrbS70GGGVJ88lCpbJpNh7aeHA0hgf2dCTO7LGdLqNPDgKq
	dOjH0nJ1+qHIa1GUthS3awlQVOh++UEELW7OZjH48tnSc9QuZLDaKIdQUqxZ5Ya2ZE+ElEtFMDs
	gywLdPYAuTUnybQ5nNM6ljCYiBV6mOYyqiPjKcyCUhlGX4TdnUayD/s8HVrglFGJIPkW1sEB1cR
	ix3sZUCpmfxCOcRhmJ116vzTAOuZ9VmfIQ7Zc8roIzbsI=
X-Gm-Gg: AY/fxX5KsPjp7ye0WvslBbUCBbAxk5jZ3VHqwdv4t7XG2MNeKtS3ruP358BOgWzrkOD
	1QRDXY6nKRXlh9ZDmpgkD0i9g5ZENvNRhApE8Ycu2bxiEqo7gPgzqse9NKRGOeFJJ4nj84e8QcO
	EU0C7wLXYek8fyzDnwZc3oVIlixCAOR3iBKFnYdM59igMsRanPnj+3f0n0jX2lG+Qo
X-Received: by 2002:a17:902:e884:b0:295:6122:5c42 with SMTP id d9443c01a7336-29ec231b394mr60323485ad.24.1765457724357;
        Thu, 11 Dec 2025 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKrUwXdtxOoTMBu1hJiIk5hrSkflSXqA/00cWHE0pi1/DVYyeztZ61eYy+lFh4s6sAmcADzgtP6/HmaQ0F6IA=
X-Received: by 2002:a17:902:e884:b0:295:6122:5c42 with SMTP id
 d9443c01a7336-29ec231b394mr60323315ad.24.1765457723923; Thu, 11 Dec 2025
 04:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251210150019.48458-1-mlbnkm1@gmail.com> <ctubihgjn65za4hbmanhkzg7psr6kmj3jeqfj5sfxnnxjjvrsy@l6644u74vrn6>
 <CAGxU2F6TMP7tOo=DONL9CJUW921NXyx9T65y_Ai5pbzh1LAQaA@mail.gmail.com>
In-Reply-To: <CAGxU2F6TMP7tOo=DONL9CJUW921NXyx9T65y_Ai5pbzh1LAQaA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 11 Dec 2025 13:55:12 +0100
X-Gm-Features: AQt7F2oc1BVBAdK92iMl4jOy7fPeE1y7G4q5UMwstrOZRfr8mNpcaD9xZswoaek
Message-ID: <CAGxU2F6RkU-6id5Z9wBFKPfmws9CJ00mnBQgCYZasLshLnYn=w@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: cap TX credit to local buffer size
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q4eZFTzWz6wKgrGKAY3nK5lUHnBu1XOhghTqzYTlzbw_1765457724
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 11:08, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, 11 Dec 2025 at 10:10, Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Wed, Dec 10, 2025 at 04:00:19PM +0100, Melbin K Mathew wrote:
> > >The virtio vsock transport currently derives its TX credit directly
> > >from peer_buf_alloc, which is set from the remote endpoint's
> > >SO_VM_SOCKETS_BUFFER_SIZE value.
> >
> > Why removing the target tree [net] from the tags?
> >
> > Also this is a v2, so the tags should have been [PATCH net v2], please
> > check it in next versions, more info:
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line
> >
> > >
> > >On the host side this means that the amount of data we are willing to
> > >queue for a connection is scaled by a guest-chosen buffer size,
> > >rather than the host's own vsock configuration. A malicious guest can
> > >advertise a large buffer and read slowly, causing the host to allocate
> > >a correspondingly large amount of sk_buff memory.
> > >
> > >Introduce a small helper, virtio_transport_peer_buf_alloc(), that
> > >returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
> > >peer_buf_alloc:
> > >
> > >  - virtio_transport_get_credit()
> > >  - virtio_transport_has_space()
> > >  - virtio_transport_seqpacket_enqueue()
> > >
> > >This ensures the effective TX window is bounded by both the peer's
> > >advertised buffer and our own buf_alloc (already clamped to
> > >buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
> > >cannot force the host to queue more data than allowed by the host's
> > >own vsock settings.
> > >
> > >On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> > >32 guest vsock connections advertising 2 GiB each and reading slowly
> > >drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> > >recovered after killing the QEMU process.
> > >
> > >With this patch applied, rerunning the same PoC yields:
> > >
> > >  Before:
> > >    MemFree:        ~61.6 GiB
> > >    MemAvailable:   ~62.3 GiB
> > >    Slab:           ~142 MiB
> > >    SUnreclaim:     ~117 MiB
> > >
> > >  After 32 high-credit connections:
> > >    MemFree:        ~61.5 GiB
> > >    MemAvailable:   ~62.3 GiB
> > >    Slab:           ~178 MiB
> > >    SUnreclaim:     ~152 MiB
> > >
> > >i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> > >guest remains responsive.
> >
> > I think we should include here a summary of what you replied to Michael
> > about other transports.
> >
> > I can't find your reply in the archive, but I mean the reply to
> > https://lore.kernel.org/netdev/20251210084318-mutt-send-email-mst@kernel.org/
> >
> > >
> > >Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> > >Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > >Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> > >---
> > > net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> > > 1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > >index dcc8a1d58..02eeb96dd 100644
> > >--- a/net/vmw_vsock/virtio_transport_common.c
> > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > >@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> > > }
> > > EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> > >
> > >+/*
> > >+ * Return the effective peer buffer size for TX credit computation.
> >
> > nit: block comment in this file doesn't leave empty line, so I'd follow
> > it:
> >
> > @@ -491,8 +491,7 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> >   }
> >   EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> >
> > -/*
> > - * Return the effective peer buffer size for TX credit computation.
> > +/* Return the effective peer buffer size for TX credit computation.
> >    *
> >    * The peer advertises its receive buffer via peer_buf_alloc, but we
> >    * cap that to our local buf_alloc (derived from
> >
> > >+ *
> > >+ * The peer advertises its receive buffer via peer_buf_alloc, but we
> > >+ * cap that to our local buf_alloc (derived from
> > >+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> > >+ * so that a remote endpoint cannot force us to queue more data than
> > >+ * our own configuration allows.
> > >+ */
> > >+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
> > >+{
> > >+      u32 peer  = vvs->peer_buf_alloc;
> > >+      u32 local = vvs->buf_alloc;
> > >+
> > >+      if (peer > local)
> > >+              return local;
> > >+      return peer;
> > >+}
> > >+
> >
> > I think here Michael was suggesting this:
> >
> > @@ -502,12 +502,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> >    */
> >   static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
> >   {
> > -       u32 peer  = vvs->peer_buf_alloc;
> > -       u32 local = vvs->buf_alloc;
> > -
> > -       if (peer > local)
> > -               return local;
> > -       return peer;
> > +       return min(vvs->peer_buf_alloc, vvs->buf_alloc);
> >   }
> >
> >
> > > u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> > > {
> > >       u32 ret;
> > >@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> > >               return 0;
> > >
> > >       spin_lock_bh(&vvs->tx_lock);
> > >-      ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > >+      ret = virtio_transport_tx_buf_alloc(vvs) -
> > >+            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > >       if (ret > credit)
> > >               ret = credit;
> > >       vvs->tx_cnt += ret;
> > >@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
> > >
> > >       spin_lock_bh(&vvs->tx_lock);
> > >
> > >-      if (len > vvs->peer_buf_alloc) {
> > >+      if (len > virtio_transport_tx_buf_alloc(vvs)) {
> > >               spin_unlock_bh(&vvs->tx_lock);
> > >               return -EMSGSIZE;
> > >       }
> > >@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> > >       struct virtio_vsock_sock *vvs = vsk->trans;
> > >       s64 bytes;
> > >
> > >-      bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > >+      bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> > >+            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >
> > nit: please align this:
> >
> > @@ -903,7 +898,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> >          s64 bytes;
> >
> >          bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
> > -             (vvs->tx_cnt - vvs->peer_fwd_cnt);
> > +               (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >          if (bytes < 0)
> >                  bytes = 0;
> >
> >
> > Just minor things, but the patch LGTM, thanks!
>
> I just noticed that vsock_test are now failing because one peer (client)
> try to send more than TX buffer while the RX is waiting for the whole
> data.
>
> This should fix the test:
>
> From b69ca1fd3d544345b02cedfbeb362493950a87c1 Mon Sep 17 00:00:00 2001
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Thu, 11 Dec 2025 10:55:06 +0100
> Subject: [PATCH 1/1] vsock/test: fix seqpacket message bounds test
>
> From: Stefano Garzarella <sgarzare@redhat.com>
>
> The test requires the sender (client) to send all messages before waking
> up the receiver (server).
> Since virtio-vsock had a bug and did not respect the size of the TX
> buffer, this test worked, but now that we have fixed the bug, it hangs
> because the sender fills the TX buffer before waking up the receiver.
>
> Set the buffer size in the sender (client) as well, as we already do for
> the receiver (server).
>
> Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 9e1250790f33..af6665ed19d5 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -351,6 +351,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>
>  static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  {
> +       unsigned long long sock_buf_size;
>         unsigned long curr_hash;
>         size_t max_msg_size;
>         int page_size;
> @@ -363,6 +364,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>                 exit(EXIT_FAILURE);
>         }
>
> +       sock_buf_size = SOCK_BUF_SIZE;
> +
> +       setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
> +                           sock_buf_size,
> +                           "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
> +
> +       setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
> +                           sock_buf_size,
> +                           "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> +
>         /* Wait, until receiver sets buffer size. */
>         control_expectln("SRVREADY");
>
> --
> 2.52.0
>
> Please add that patch to a series (e.g. v3) which includes your patch,
> and that fix for the test.

I saw you sent v3 without this, never mind, I'll post it directly.

Stefano

>
> Maybe we can also add a new test to check exactly the problem you're
> fixing, to avoid regressions.
>
> Thanks,
> Stefano

