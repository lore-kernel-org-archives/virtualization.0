Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794654664;
	b=rK7TVsfu8xkxlPQqWGrrQ2IZzj1LcBnQKfgy2GxT/rqb+RbJzhQBgZazlA/5CueVdVMd
	 xnm2tTdc2tbDBz4fAMu4q+vKZl4wv4tuLztaOICdZvr05+mg69CMq46AuKySYA9vB+NMA
	 W0v6/TkzPP63D5mXgUrrmTg3UtYyr7+a7c/IZN/lOzd94xJfXT1SDUzrtOHshDRn/9AmU
	 dl79E3jo1DKdIV7NWFiG8uE5Qq6Y4xE0zcOdTQ59LawkjgEx0V7d+c78VicWjV4kmOXhK
	 9wUVRv6TPhtzUEskKEJUOmGetNLRi+II2H367zgLYpRrulvRjjB87GMlORoBINF2EtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794654664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YMHXKhTk0ecNKUt9XV/VlNwdmNNg447P8iuKMev7L7k=;
	b=BNC554JbTxEsWof4rSoH7BX0goXlo4JhJEwlE7UZdyHPryo2UZ7sjBK9M1j1iLJhTUOI
	 nFXHE37hrpOuitBJpk6oppX44S/0rZWwsxog7LIFacedbdUW9FAxshJEJ529jVQtEe3rJ
	 lwxXoPJPmhO6lu7l2jK9D7oNVNwwQcmG4VZ9ya7kH3HSvjgRwJniuu7oGDZZ4CI1ynjmO
	 VOEhthDiCDWOjA8+A6zY+Wf6kqhOtZbrRjyenh+uFRq/SQbDf0T8f1k7SleCjzAoESL0V
	 j6oIcxetrMfM1l6HxtxA0NLOIL4ZjcVZqL14zoVG13r3NNPtx2CVAOmehm7LmTo4U+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zx0i8C81;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCDF606A8A2
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 11:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCDF606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zx0i8C81
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-945e6d9ceeaso230628685a.0
        for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 03:11:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794654663; cv=none;
        d=google.com; s=arc-20260327;
        b=PnV7KzYsKT2sr4eTfJtzjCyRatozgQwssRlrpUU7db4bL5FenzX9M82S63C94dvnlH
         6AX0zwrAIU3JcWQ6erMF4wgS8uobcfoazz0gi+veAnvZK7fCzpb8Lks/SI7XH2y8MQdr
         ToaF2Jp1/TbJr4a/szrs4DIV8AEEuwaCwkWYO4DYqjdNaDwG4XPvn3EyssW/od6GR5Fi
         oXxoxt/6hGtO2Sc0wqefm+tvQVaAiL1sXTfIYYmjIA2NZEnOwW6SwUicL1vy17yDxvSH
         LKlR76vLA9VNFhi4b34NPnoubauKS1CyEVSsQDnlFHHExeDo90DsA218XVXO2637UtiQ
         d+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YMHXKhTk0ecNKUt9XV/VlNwdmNNg447P8iuKMev7L7k=;
        fh=oPzb/gqDuajadmRD9XkLw4yflqzsy3zyKBni7oPv7mI=;
        b=luHqLWU9ZZdOgg+dPvU+3AuO/+HS36/jqly2j6kqAl6dTMXUZS/Bk6zZzvHKjrWaeS
         bbvxxzsGKc+YHbeRk4kJ5ixdIR1BMp91h0oUG4BcKf9Uh5PC1gi9tCbVxZh94yxUgTkA
         FL83TyXNWUKVX7elb9LoRQwb1gC4HqiwGVfebp9o2KBpjiBEqVQzQc7ZKo4CsHwrExac
         SoHc+mBMorQImqxCZEXM8wfI3uzhX9DtXEk376HGtABQFIIAjgIQlXxTetB5w9VTo//3
         p2wZKZkLF9VTfLVr0/qHRgxemF719X/NTt8VOepnS/eQTVmJB9CDBL+/OpvJNTbqNaa8
         ItiA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794654663; x=1795259463; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMHXKhTk0ecNKUt9XV/VlNwdmNNg447P8iuKMev7L7k=;
        b=Zx0i8C810eVU4CZeNNai4DLbWkNtM5fqSRAN40zNkMokjaSbdQsz3jTAwt1tUCNsqZ
         ZbiMS1cFYuryouqTadXM3SEAydn+bc7n57Ek1/sTq5zy83pKNDm/SyTRnkPmsMkEwjn3
         UOKkb7A9GgEQNmd5Bm6m8z8C/jT+pm1Rty3+xZ4z+0QVT4XSEGzSeVaKDiVx4NrxrdbL
         qdyVuZwC0yJjVeTCQTGwDoe16d3KeXDbB2EgpEXznMW1Zv2z5S3ejDEKSEFLNS8iPfda
         jbnPcNNYnlyPsDl6iBZk/D5LCL7fMk50czI+nEPEAi57M9b8oB3AiBYZSv1/L1UtYtAo
         LOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794654663; x=1795259463;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YMHXKhTk0ecNKUt9XV/VlNwdmNNg447P8iuKMev7L7k=;
        b=JJtoQGErOWWrxwWbEOK/pGJvfZzErxI1Pi7KXPskYHxVqGrUcMtUx6e2Zv8jAs/sSv
         JJvFrOgqh18/D8BJrAEGYeWNm0cfbZPaA0me4gROl4zXugXp01fIVC2Y/bj5K1iq+GWp
         m3snFSVIYtWuinPfGmh8UBqZIyQnQI4zoZ1jeINfOCEmiRZUltPGOsnpxuOAIYlUkiP2
         ZOR76A+KLZ0lT5Fn2bEcaXpi+s3Ic7Bgwmb/1Bul9TLIK4PIJyMUmlov/bqw3zWNEf+n
         OjfRjJrF2lMzYGrot9KmkucsC6t8Fps2DOeD7xXfEuW4fMzJkT6tlZ5ubvZDLJjpjf+r
         tzqA==
X-Forwarded-Encrypted: i=1; AL+hErHS/wDawJg63qbqILB7GZmyY9twe7lDhUFtUm+TjBQDRWqCJ9lczXG8f+v0crnQ9o/XEFRucJF1vVTEoZlJQQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/BPduydBSXKUPfHO4K9TdXZYlftG5ZNf7mDpbGpx5rvy/+ONN8
	6w4Wyy1DLf52idMb7tNsK81ffmzl8K683MCcZ739BsJoEbXFn8q2G6RQDVo0X4RC0CoXK2Hukyi
	16ehsn9dllbIOkGaroKX7hx7QLxgkt/A=
X-Gm-Gg: AYBFou1KA0rB3kfU5fZ1aA5ilVrio4gSPx0IQTzI6nhXWCWnOLIEdTUOwp2KG57CR6N
	J5258rq6h8Z2LmqnJts5wr5fB8K1+DageP2uz8yNYEzoQhQc4PIsZfnzo+QjR097Z/pYmxuGBSB
	mXAgT456kUHW6mEfEwQpXcQcrGxGq6mRPWIq59UtWIu3JS28w/+Ps+oLzyJiNiIanFhM+eM+M2z
	vQU+d0uCsOM+PKCjNk76vbRDmusL0loda522v8m6s9kaFGxSy537GEvkDw1fNQhs9rv5Hl1PUKz
	oUSnC49KHeXrseaf5yUXH0NbxaQyRUEQrG930YF2NLPLjvMDtfMab+3JIVUjaztS9UYKxX6JH8f
	c6e5qa8mT4gKw244tM/owXdH6B77uBNPUga8lECYfWVHkUeWp4EL/3KiYPtpwmougt76jurg=
X-Received: by 2002:a05:620a:28c9:b0:93e:9627:533c with SMTP id
 af79cd13be357-9494bc31abdmr847560285a.50.1794654662952; Sat, 14 Nov 2026
 03:11:02 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-4-physicalmtea@gmail.com> <auxDWISLHB8Ln1x7@sgarzare-redhat>
 <CAJwVaMJbzzK8Sj8DvLjiAyqS8TNgRQ3tjRpGcBNC+anQECg5yw@mail.gmail.com>
 <avXn6E8y5OPtdikQ@sgarzare-redhat> <CAJwVaM+SEhbFtORYgVYNayiQED63sCLO5ibwgkcjBRVvMd=KsA@mail.gmail.com>
 <avdAV2RholA4ana_@sgarzare-redhat>
In-Reply-To: <avdAV2RholA4ana_@sgarzare-redhat>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sat, 14 Nov 2026 19:10:26 +0800
X-Gm-Features: AclHuK9wAWefZkkrHQ6F3DNTtK7nFasUK7nAlyv7TR_puAUfZnwoD7ycVAO-sXk
Message-ID: <CAJwVaMLtt1iKCWbhz2T4BbjqseTxjOb8S7vbvX3845LL8GHEBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket locking
 for stream packets
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Nov 13, 2026 at 04:09:48PM +0800, Jia Jia wrote:
> > >
> > > On Fri, Nov 06, 2026 at 08:27:51PM +0800, Jia Jia wrote:
> > > >>
> > > >> On Tue, Nov 03, 2026 at 12:11:32PM +0800, Jia Jia wrote:
>
> [...]
>
> > > >> >+
> > > >> >+/* The caller holds sk's socket lock. */
> > > >> >+static bool
> > > >> >+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> > > >> >+                                     struct sock *sk, u32 len)
> > > >> >+{
> > > >> >+      struct virtio_vsock_sock *vvs;
> > > >> >+      struct vsock_sock *vsk;
> > > >> >+
> > > >> >+      vsk = vsock_sk(sk);
> > > >> >+      vvs = vsk->trans;
> > > >> >+
> > > >> >+      /*
> > > >> >+       * Keep a connected lookup reference only for the native, established
> > > >> >+       * STREAM path. Sockets outside ESTABLISHED can change table membership;
> > > >> >+       * a completed or reassigned socket must resume the per-packet path.
> > > >> >+       */
> > > >> >+      if (sk->sk_state != TCP_ESTABLISHED ||
> > > >> >+          sk->sk_type != SOCK_STREAM ||
> > > >> >+          sock_flag(sk, SOCK_DONE) ||
> > > >> >+          vsk->transport != &t->transport || !vvs)
> > > >> >+              return false;
> > > >> >+
> > > >> >+      /*
> > > >> >+       * Do not admit a packet that would hit an existing RX limit while the
> > > >> >+       * worker owns the socket lock. The caller holds that lock, so no reader can
> > > >> >+       * dequeue until the batch is released.
> > > >> >+       */
> > > >> >+      return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
> > > >> >+             !virtio_transport_rx_buf_full(vvs);
> > > >>
> > > >
> > > >Hi Stefano,
> > > >
> > > >> I don't understand this. We recently introduce the collapse, so when we
> > > >> will call virtio_transport_recv_enqueue(), all the queue will be
> > > >> collapsed, including packets in the batch.
> > > >>
> > > >> Or am I missing something?
> > > >>
> > > >
> > > >Yes, collapse operates on the same receive queue, which also contains
> > > >skbs queued earlier in the current batch.
> > > >
> > > >The rx_buf_full() check is not intended to bypass collapse. It prevents
> > > >the batch from retaining the socket lock while processing a packet when
> > > >there is no metadata room for another skb. Collapse is best effort:
> > > >some skbs cannot be merged, and allocation of a replacement skb can
> > >
> > > IIUC batches are enabled only for SOCK_STREAM, so, which skbs can't be
> > > merged?
> >
> > My wording in the previous reply may not have been precise. What I meant
> > is that collapse is not guaranteed to free the skb slot needed for the
> > incoming packet for every valid receive-buffer configuration.
> >
> > With the default 256K receive buffer, a queue of small STREAM skbs will
> > normally contain multiple collapse candidates by the time it reaches
> > the metadata limit, so collapse will normally make room.
> >
> > However, SO_VM_SOCKETS_BUFFER_SIZE is configurable through setsockopt().
> > A sufficiently small but valid receive buffer can make queue_max equal
> > to one. After the first small packet has been queued, that skb is
> > eligible for collapse, but there is no adjacent skb to merge it with.
> > virtio_transport_collapse_size() therefore returns only that skb's own
> > length, and the skb is kept unchanged.
> >
> > The incoming second skb is not in rx_queue yet. Provided that the two
> > packets combined payload still fits within buf_alloc, the payload check
> > passes, but virtio_transport_inc_rx_pkt() rejects the second packet on
> > the metadata check. This happens before the later tail-copy optimization
> > is reached.
>
> I'm lost to be honest, why the secondo skb is not collapsed?
>

The second skb triggers the collapse, but it is not itself an input to
that collapse.

The concrete case is a valid receive-buffer configuration where setting
SO_VM_SOCKETS_BUFFER_SIZE makes:

      queue_max = vvs->buf_alloc / SKB_TRUESIZE(0);

equal to one. Assume that rx_queue is initially empty and that two small
STREAM/RW packets for the same flow are available in the same RX
virtqueue drain. Their combined payload still fits within buf_alloc.

The first packet passes the metadata check:

      u64 skb_overhead =
              (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);

It is then queued, so rx_queue contains one skb.

When the second packet enters virtio_transport_recv_enqueue(), the
relevant order is:

      queue_len = skb_queue_len(&vvs->rx_queue);
      if (queue_len >= queue_max)
              virtio_transport_collapse_rx_queue(vvs, ...);

      can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
      if (!can_enqueue)
              goto out;

      /* tail-copy is attempted here */

At the point where virtio_transport_collapse_rx_queue() runs, the second
skb is still only the skb argument passed to
virtio_transport_recv_enqueue(). It has not been linked into
vvs->rx_queue, so the collapse sees only the first skb.

For that skb, virtio_transport_collapse_size() cannot find a next queue
element:

      while ((skb = skb_peek_next(skb, queue)) &&
             virtio_transport_can_collapse(skb))
              ...

It therefore returns only the length of the first skb, and the collapse
code keeps it unchanged:

      if (alloc_size <= src_len) {
              keep = true;
              goto next;
      }

The queue length remains one. virtio_transport_inc_rx_pkt() then
accounts for the existing skb plus the incoming one:

      (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0)

With queue_max == 1, this exceeds the metadata budget and returns false.
This check happens before the tail-copy code, so the second skb cannot
be copied into the first skb even if the first skb has sufficient
tailroom.

virtio_transport_recv_enqueue() then returns false, and the existing
error path resets the connection and sets ENOBUFS:

      if (!virtio_transport_recv_enqueue(vsk, skb)) {
              virtio_transport_reset(vsk, skb);
              virtio_transport_do_close(vsk, true);
              sk->sk_err = ENOBUFS;
              ...
      }

> >
> > Therefore, this case does not require an ineligible STREAM skb or an
> > allocation failure. Collapse simply cannot reduce a one-element queue.
> >
> > If my understanding is wrong, please correct me. Thanks.
> >
> > >
> > > If allocation fails, I guess we have other issues, no?
> > >
> >
> > Yes. I thought about that again, and allocation failure is not the
> > reason for this check. Thanks
> >
> > > >fail. If the packet remained in the batch and collapse did not make
> > > >enough room, virtio_transport_inc_rx_pkt() would fail and
> > > >virtio_transport_recv_connected() would reset the socket with ENOBUFS
> > > >while a waiting reader was still unable to drain the queue.
> > > >
> > > >When the check makes can_continue() return false before the current
> > > >packet has been handled, the caller releases the socket lock and passes
> > > >the packet to virtio_transport_recv_pkt(). This gives a waiting reader a
> > > >chance to make progress. If the queue is still at the metadata limit,
> > > >the normal enqueue path attempts collapse. If that still cannot make
> > > >enough room, the existing ENOBUFS reset occurs.
> > >
> > > I really don't see the difference without batching :-(
> > >
> > > I may be missing something.
> > >
> >
> > The difference is the release_sock() boundary between packets.
> >
> > In the regular per-packet path, the socket lock is released after the
> > first packet. A reader woken by that packet can compete for the lock and
> > fully dequeue the only skb before RX locks the socket for the second
> > packet. If it succeeds, the second packet can be accepted. If it does
> > not acquire the lock in time, or only partially consumes the skb, the
> > queue length remains one and the regular path can still reach the
> > existing ENOBUFS reset.
> >
> > Without the rx_buf_full() check, two same-flow packets processed in the
> > same active batch remain under one uninterrupted socket-lock ownership
> > interval. Once the first packet leaves the only skb in the queue, the
> > reader cannot dequeue it before the second packet is processed.
>
> Why?
>

Because an active RX batch retains the socket lock across the two
packets:

      lock_sock(sk);
      ...
      batch->sk = sk;
      virtio_transport_rx_batch_process(...);

The lock is released only when the batch is finished:

      void virtio_transport_rx_batch_finish(...)
      {
              ...
              release_sock(sk);
              sock_put(sk);
      }

The receive side needs the same socket lock before it can call
stream_dequeue():

      lock_sock(sk);
      ...
      read = transport->stream_dequeue(...);
      ...
      release_sock(sk);

Waking the reader after the first packet does not allow it to dequeue
while the RX batch still owns that lock. Without the rx_buf_full()
boundary, and assuming the other batch-continuation conditions remain
true, RX processes the second packet under the same uninterrupted lock
ownership.

> > Collapse cannot reduce that one-element queue, so the second packet
> > fails the metadata check and resets the connection.
>
> What is unclear to me is why this is not happening without batching.
>

It can also happen without batching. The difference is that it is not
unavoidable there.

The regular per-packet path executes this sequence for every packet:

      lock_sock(sk);
      virtio_transport_recv_pkt_locked(...);
      release_sock(sk);

Therefore, even when both packets come from the same virtqueue drain,
the first packet is followed by release_sock(). A waiting reader can
compete for the lock and fully dequeue the first skb before RX locks the
socket for the second packet.

If the reader wins, the second packet sees an empty queue and can be
accepted. If RX wins the race, or the reader consumes only part of the
skb, the regular path can still reach the same ENOBUFS reset.

Without the rx_buf_full() check, the post-processing check after the
first packet only sees that the payload limit has not been exceeded:

      return (u64)vvs->buf_used + len <= vvs->buf_alloc;

At this point len is zero, so the batch continues to hold the socket
lock and processes the second packet immediately. Under the conditions
described above, the reader cannot intervene and the metadata failure
is deterministic.

With the current check:

      return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
             !virtio_transport_rx_buf_full(vvs);

the metadata slot is already exhausted after the first packet. The
post-processing check returns false,
virtio_transport_rx_batch_finish() releases the socket lock, and the
next packet returns to the regular per-packet path.

This restores the lock-acquisition opportunity. It does not guarantee
that the reader wins it.

> And, why we can't collapse the batch it self...
>

I am not sure whether I understood your suggestion. Do you mean
changing the enqueue order so that the incoming skb can participate in
tail-copy or collapse before the metadata check?

The current implementation does not attempt that change. Its purpose
here is only to preserve the behavior of the existing per-packet path
in this boundary case.

The earlier targeted A/B test also illustrates why I added the
rx_buf_full() check. On a 2-vCPU guest with queue_max == 1, I ran 100
trials in which two STREAM/RW packets for the same flow were available
in the same RX virtqueue drain. With the rx_buf_full() boundary, the
connection continued in 22 trials and reached ENOBUFS in the other 78.
Without the boundary, all 100 trials reached ENOBUFS.

The check does not guarantee that the reader wins the lock race. It
preserves the opportunity that exists in the per-packet path. Without
it, batching removes that opportunity and turns a case that could
previously continue into a deterministic reset when both packets are
processed in the same uninterrupted batch. I consider that a functional
regression from the existing behavior.

Thanks,
Jia

> Thanks,
> Stefano
>
> >
> > The check detects this metadata boundary after the first packet and
> > finishes the batch. It therefore restores the lock-release opportunity
> > that the regular per-packet path had at the same point. It does not
> > guarantee that the reader acquires the lock first; it preserves the
> > original opportunity to do so.
> >
> > Without this check, batching would remove a successful interleaving
> > available to the regular path. For this valid receive-buffer
> > configuration, when both packets are processed in the same uninterrupted
> > batch, an otherwise avoidable reset would become unavoidable. That
> > would be a functional regression introduced by batching.
> >
> > Thanks,
> > Jia
> >
> > > Thanks,
> > > Stefano
> > >
> >
>
