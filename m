Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B024A2D
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299717; cv=none; b=BpH2vTSDmauUT1AZdJcd57EiD5imb3ajadksvsABFq4auBRBEIfMzRBWgz4ViSlcJ25XXybvirF2nN2VIc8C+CxvjNOJQqcQQ+VvUERy+Bn/fDhWyL+nRPeTghbmt580yCD0lN6yQxccM67M0fL637Y+CW7lu0EihIYwMF56vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299717; c=relaxed/simple;
	bh=d/kFBuKQNh0Q9UbIyHywcyGbDWYA2LZn99Y1/6hKjlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MptABeKtgbb558/F7cHhAwlXmi7eRAx7z3FlEz9sdm+BsMR7CnUnNFp4fya2XrNZNDB5iEN0tSV2cSAWL7DkQ5l/Nuot+ak6rVk8HHqfGpaYojEGF8zTK+9z8gtSzSCgztWcVeZCsLFQ2hPHS+EYOrMf3n9hckvjoz2o+3ocTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lj8rKl4c; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lj8rKl4c"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32589405F3
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 00:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ra6rReypiuzy for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 00:35:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b29; helo=mail-yb1-xb29.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A86CC405EF
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A86CC405EF
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lj8rKl4c
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A86CC405EF
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 00:35:13 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2587574276.0
        for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299712; x=1722904512; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQC8o6WuYV9zIhufZ9MsbGx/4n9VJXXESMMI8zl3XZ8=;
        b=lj8rKl4cmm9NFsCbCtCeCcBIy1Ax98wXpJ5h/mMXNoHccWe5Yz83kmelJ5gqwQwhLy
         W1yBeD82U5ow8deZiOi2VGdZCJKWo9hbhzyv/HWABgSRsuHvmdpwQlmXnpDnvfOlqf8M
         07usM82/O02bc97MM9jTlWD2calpjH9i6pdUdvPEMSdG5SKwgY+BrH4S6H7df8SVw7Sk
         UA3cFAT9QLkA1kfzl/mL0J88vlIMb3Skzp4ZAtkbOBKlVMQcHk9dky9z1t40AsvtspK+
         7tLwnjB/Hbi/1H3AZY3luYvbggwomFY8pwDt7e7F9xniemzvNFXZUJGdG5GlM1f6xao9
         /bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299712; x=1722904512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQC8o6WuYV9zIhufZ9MsbGx/4n9VJXXESMMI8zl3XZ8=;
        b=f9Abul2D9CpizENA7odQ2YYXRxgNV1OtY2u/66FqZ6olS4wADMQpazOcIWS+6GLxMN
         HozH7neuQCIyEuJEYUQc5bE6v3m67hMCDq1pxnBjiAuLPPUz4yko8xNFS7p+14HvWFaU
         jhyfg2LTKkSQfyO7Qpy+xKe/oYERUyKCFJpNvy1Tfl4AqAuguerD50rt/1PwLL0944w0
         WZmQn6cW6K4lOTJoI+SlRMZnMhE0GtVeQEcK+482kq4Y4fq5XCNW/Gw/yhWpoXhUAmJ6
         um9Hy86Qs/jO1giGshU6z7uVA+OnFoFQBIPJUXWTzmLvdIKkXzgAxp6QC1ffuwZV/tnr
         1xsA==
X-Forwarded-Encrypted: i=1; AJvYcCXOxxwiiF2vhY7mOG0M3jfed/cQNZWe3eDd40S2MZi088Vs5aFi7OakFnM862TVGmch00LbK8t/mMk8FAKEN22RGoylQ1MV/1L2Q4gK7sxqXOvngYPIXvTJkw==
X-Gm-Message-State: AOJu0YxVo9qaWFGp3Q5ZW+q4cu11Fdmi8lJ/YrLQHelLJPgg7JugWQil
	/hMHdi3eWeOLgdZUo305+UmHZLjdjgkiG7rZq+crwoxvRWLBCbtjoA5+kt77hVDfADDI2uwW6dP
	/Ml6oQL9vD0VoWqX2W1JAWZJGvms=
X-Google-Smtp-Source: AGHT+IFQjYAiuUNdG3Z25QWxW/dvCFzkKCQJekH2WlgkA5EDri9u87GttBOpsXZ4ybgaGUzALcovMGKdNQVJv65VoNw=
X-Received: by 2002:a05:6902:10cd:b0:e08:5b14:dfb4 with SMTP id
 3f1490d57ef6-e0b545f178bmr10382412276.55.1722299712320; Mon, 29 Jul 2024
 17:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-10-amery.hung@bytedance.com> <ldyfzp5k2qmhlydflu7biz6bcrekothacitzgbmw2k264zwuxh@hmgoku5kgghp>
In-Reply-To: <ldyfzp5k2qmhlydflu7biz6bcrekothacitzgbmw2k264zwuxh@hmgoku5kgghp>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 29 Jul 2024 17:35:01 -0700
Message-ID: <CAMB2axNx=nCh-B-=XLtto2nEsKsV0p+b7yzXRX9OKSgUbRzzWA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 09/14] virtio/vsock: add common datagram
 recv path
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:42=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 09:25:50PM GMT, Amery Hung wrote:
> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >
> >This commit adds the common datagram receive functionality for virtio
> >transports. It does not add the vhost/virtio users of that
> >functionality.
> >
> >This functionality includes:
> >- changes to the virtio_transport_recv_pkt() path for finding the
> >  bound socket receiver for incoming packets
> >- virtio_transport_recv_pkt() saves the source cid and port to the
> >  control buffer for recvmsg() to initialize sockaddr_vm structure
> >  when using datagram
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >---
> > net/vmw_vsock/virtio_transport_common.c | 79 +++++++++++++++++++++----
> > 1 file changed, 66 insertions(+), 13 deletions(-)
> >
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/vir=
tio_transport_common.c
> >index 46cd1807f8e3..a571b575fde9 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -235,7 +235,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
> >
> > static u16 virtio_transport_get_type(struct sock *sk)
> > {
> >-      if (sk->sk_type =3D=3D SOCK_STREAM)
> >+      if (sk->sk_type =3D=3D SOCK_DGRAM)
> >+              return VIRTIO_VSOCK_TYPE_DGRAM;
> >+      else if (sk->sk_type =3D=3D SOCK_STREAM)
> >               return VIRTIO_VSOCK_TYPE_STREAM;
> >       else
> >               return VIRTIO_VSOCK_TYPE_SEQPACKET;
> >@@ -1422,6 +1424,33 @@ virtio_transport_recv_enqueue(struct vsock_sock *=
vsk,
> >               kfree_skb(skb);
> > }
> >
> >+static void
> >+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
> >+{
> >+      if (err =3D=3D -ENOMEM)
> >+              kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
> >+      else if (err =3D=3D -ENOBUFS)
> >+              kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
> >+      else
> >+              kfree_skb(skb);
> >+}
> >+
> >+/* This function takes ownership of the skb.
> >+ *
> >+ * It either places the skb on the sk_receive_queue or frees it.
> >+ */
> >+static void
> >+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
> >+{
> >+      int err;
> >+
> >+      err =3D sock_queue_rcv_skb(sk, skb);
> >+      if (err) {
> >+              virtio_transport_dgram_kfree_skb(skb, err);
> >+              return;
> >+      }
> >+}
> >+
> > static int
> > virtio_transport_recv_connected(struct sock *sk,
> >                               struct sk_buff *skb)
> >@@ -1591,7 +1620,8 @@ virtio_transport_recv_listen(struct sock *sk, stru=
ct sk_buff *skb,
> > static bool virtio_transport_valid_type(u16 type)
> > {
> >       return (type =3D=3D VIRTIO_VSOCK_TYPE_STREAM) ||
> >-             (type =3D=3D VIRTIO_VSOCK_TYPE_SEQPACKET);
> >+             (type =3D=3D VIRTIO_VSOCK_TYPE_SEQPACKET) ||
> >+             (type =3D=3D VIRTIO_VSOCK_TYPE_DGRAM);
> > }
> >
> > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->=
mutex
> >@@ -1601,44 +1631,57 @@ void virtio_transport_recv_pkt(struct virtio_tra=
nsport *t,
> >                              struct sk_buff *skb)
> > {
> >       struct virtio_vsock_hdr *hdr =3D virtio_vsock_hdr(skb);
> >+      struct vsock_skb_cb *vsock_cb;
>
> This can be defined in the block where it's used.
>

Got it.

> >       struct sockaddr_vm src, dst;
> >       struct vsock_sock *vsk;
> >       struct sock *sk;
> >       bool space_available;
> >+      u16 type;
> >
> >       vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
> >                       le32_to_cpu(hdr->src_port));
> >       vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
> >                       le32_to_cpu(hdr->dst_port));
> >
> >+      type =3D le16_to_cpu(hdr->type);
> >+
> >       trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
> >                                       dst.svm_cid, dst.svm_port,
> >                                       le32_to_cpu(hdr->len),
> >-                                      le16_to_cpu(hdr->type),
> >+                                      type,
> >                                       le16_to_cpu(hdr->op),
> >                                       le32_to_cpu(hdr->flags),
> >                                       le32_to_cpu(hdr->buf_alloc),
> >                                       le32_to_cpu(hdr->fwd_cnt));
> >
> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
> >+      if (!virtio_transport_valid_type(type)) {
> >               (void)virtio_transport_reset_no_sock(t, skb);
> >               goto free_pkt;
> >       }
> >
> >-      /* The socket must be in connected or bound table
> >-       * otherwise send reset back
> >+      /* For stream/seqpacket, the socket must be in connected or bound=
 table
> >+       * otherwise send reset back.
> >+       *
> >+       * For datagrams, no reset is sent back.
> >        */
> >       sk =3D vsock_find_connected_socket(&src, &dst);
> >       if (!sk) {
> >-              sk =3D vsock_find_bound_socket(&dst);
> >-              if (!sk) {
> >-                      (void)virtio_transport_reset_no_sock(t, skb);
> >-                      goto free_pkt;
> >+              if (type =3D=3D VIRTIO_VSOCK_TYPE_DGRAM) {
> >+                      sk =3D vsock_find_bound_dgram_socket(&dst);
> >+                      if (!sk)
> >+                              goto free_pkt;
> >+              } else {
> >+                      sk =3D vsock_find_bound_socket(&dst);
> >+                      if (!sk) {
> >+                              (void)virtio_transport_reset_no_sock(t, s=
kb);
> >+                              goto free_pkt;
> >+                      }
> >               }
> >       }
> >
> >-      if (virtio_transport_get_type(sk) !=3D le16_to_cpu(hdr->type)) {
> >-              (void)virtio_transport_reset_no_sock(t, skb);
> >+      if (virtio_transport_get_type(sk) !=3D type) {
> >+              if (type !=3D VIRTIO_VSOCK_TYPE_DGRAM)
> >+                      (void)virtio_transport_reset_no_sock(t, skb);
> >               sock_put(sk);
> >               goto free_pkt;
> >       }
> >@@ -1654,12 +1697,21 @@ void virtio_transport_recv_pkt(struct virtio_tra=
nsport *t,
> >
> >       /* Check if sk has been closed before lock_sock */
> >       if (sock_flag(sk, SOCK_DONE)) {
> >-              (void)virtio_transport_reset_no_sock(t, skb);
> >+              if (type !=3D VIRTIO_VSOCK_TYPE_DGRAM)
> >+                      (void)virtio_transport_reset_no_sock(t, skb);
> >               release_sock(sk);
> >               sock_put(sk);
> >               goto free_pkt;
> >       }
> >
> >+      if (sk->sk_type =3D=3D SOCK_DGRAM) {
> >+              vsock_cb =3D vsock_skb_cb(skb);
> >+              vsock_cb->src_cid =3D src.svm_cid;
> >+              vsock_cb->src_port =3D src.svm_port;
> >+              virtio_transport_recv_dgram(sk, skb);
>
>
> What about adding an API that transports can use to hide this?
>
> I mean something that hide vsock_cb creation and queue packet in the
> socket receive queue. I'd also not expose vsock_skb_cb in an header, but
> I'd handle it internally in af_vsock.c. So I'd just expose API to
> queue/dequeue them.
>

Got it. I will move vsock_skb_cb to af_vsock.c and create an API:

vsock_dgram_skb_save_src_addr(struct sk_buff *skb, u32 cid, u32 port)

Different dgram implementations will call this API instead of the code
block above to save the source address information into the control
buffer.

A side note on why this is a vsock API instead of a member function in
transport: As we move to support multi-transport dgram, different
transport implementations can place skb into the sk->sk_receive_queue.
Therefore, we cannot call transport-specific function in
vsock_dgram_recvmsg() to initialize struct sockaddr_vm. Hence, the
receiving paths of different transports need to call this API to save
source address.

> Also why VMCI is using sk_receive_skb(), while we are using
> sock_queue_rcv_skb()?
>

I _think_ originally we referred to UDP and UDS when designing virtio
dgram, and ended up with placing skb into sk_receive_queue directly. I
will look into this to provide better justification.

Thank you,
Amery

> Thanks,
> Stefano
>
> >+              goto out;
> >+      }
> >+
> >       space_available =3D virtio_transport_space_update(sk, skb);
> >
> >       /* Update CID in case it has changed after a transport reset even=
t */
> >@@ -1691,6 +1743,7 @@ void virtio_transport_recv_pkt(struct virtio_trans=
port *t,
> >               break;
> >       }
> >
> >+out:
> >       release_sock(sk);
> >
> >       /* Release refcnt obtained when we fetched this socket out of the
> >--
> >2.20.1
> >
>
