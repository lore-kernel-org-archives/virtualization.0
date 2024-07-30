Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623F192B65
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328380; cv=none; b=r9z2nlqduOSceQlnBxmRwjGlGGxpsKH26eznwI593ITMQZkbdBpHh4cqnaF/vmZuZ70IDpkNDDEo55ueQMchUtmU48nyz0WXaoA47kteLAcAq+pOwikhGErk/fZSzdtbfhufPEnYIyJes3RN9l4djeN0ihrRnxJsStzNnGCqDWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328380; c=relaxed/simple;
	bh=E6gmvD0Q7zeWVOo4lEzOWRmLUPeP28JDg0QFfxt2s8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T0AQV7e2OHJYTe2xujBzLtbdDsHQMyiQPzNHW0JqF8YC3ykZiGJlfz4icHfCcZFeslQp7YSFqvX0bwVFqOga9YdBM2FU9cWeoVi3u6cTeHfDf4MOub0ZcvPhwSEa46xfBcPI5reGD382TiJY9exeF8+rfhOszOPV0DBS+OJX71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kp28W/Tk; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp28W/Tk"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7398B4018A
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 08:32:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GrLSTisgj_d for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 08:32:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 00ADD400F1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00ADD400F1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kp28W/Tk
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00ADD400F1
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722328373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUu9DqweMZplPZPw8zixj088PoW8Kyk6wuUBLwD2TsA=;
	b=Kp28W/TkLva9fitao4Iib4y5TH3KR+B+rVKwU9Fr+kj4XCPIhuwBEQVhhVJWo8LCdB5Ll6
	mZ+wBZxAcRu2wQkZNaE6ZXP1rL/Cz5BGPck+40Ikrg7gTReC9sKB3iaXzSMhp1yXBHjuHH
	mRqVIGIuUu/W0TL4w/ZjtZWxH2wheg8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-mNhxx-_xP0OlY1Y31kGl5w-1; Tue, 30 Jul 2024 04:32:51 -0400
X-MC-Unique: mNhxx-_xP0OlY1Y31kGl5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280c6b3614so25263345e9.2
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 01:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328370; x=1722933170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUu9DqweMZplPZPw8zixj088PoW8Kyk6wuUBLwD2TsA=;
        b=SaWD2oupnht9Tm0QVLuP8KTXFdL250hPL1LxWwlvnOYy9DMt/7MFFwVLZzAprAafc5
         wWDRjoS5Ag/qNNyfrr3fVttZGzd3mIttWf2seL0jPeMtwRs4x1ncF7GFjQXLCMLAEw35
         JBxf40lszUO1KSM9XgFR8qbVvGGMm3zZ8lbgNfb/TsjCp4sALaWPhZ/FFwR63Ax42Cr4
         uWwD3y1dX4BthQOAW4dOd0fjTiy9/JbGrwXyJVC5baPO1Rh7I4yZRqQBavv9FG4snLgX
         UZ0ts0NoKJxNYpfXBrrzTynDJfHPmtR1Ms3fAwUsBhGjk/bti//AU3o5ZSNmtXI9sUj1
         cpmg==
X-Forwarded-Encrypted: i=1; AJvYcCVF3c3D584zwNnd6mk+zF4LntO/vjEj47dkWhTLfTd0YO+1QTTwusahZBAd+s9GO200O6mGvmO4/0e0MraZd0dJxf1zfJsl3CtgpkYARrXLFbTPEo5Z6ws7IQ==
X-Gm-Message-State: AOJu0YxXTb0y7LjSdmBMPaLsCkHdfLGXuLXm+1VUY1r079OVotXHWOB8
	RuPJcMhmTrss1KiuVQzJ2GDWG2xycKydq9oMJ7x/bjv0WX9+GJF11Sx7UrUvw4gb70ydzI3qFYe
	DrOcj5XAcqtLRv9tQBpI29nKJPBsH6uGTN+yWA4T6XastXFuCshZFakyu69Respnp+gjs3BnNFl
	YR0l0=
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42811da1b88mr71530275e9.21.1722328369584;
        Tue, 30 Jul 2024 01:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIZbaDTrEZBCLXIF/bnAzy6Ax7DEDAW4LkM0HdYou7XpcwkGyKPBEX2idkqwXBZnxwkKn71A==
X-Received: by 2002:a05:600c:2d53:b0:426:59fc:cdec with SMTP id 5b1f17b1804b1-42811da1b88mr71529585e9.21.1722328368349;
        Tue, 30 Jul 2024 01:32:48 -0700 (PDT)
Received: from sgarzare-redhat ([62.205.9.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280574b2c2sm203448165e9.28.2024.07.30.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:32:47 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:32:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 09/14] virtio/vsock: add common datagram
 recv path
Message-ID: <yx5phoynacbxobystxaa3zca5ehzbupzzwz3ayptb7wu5d74mc@ic3lvpjnvkkr>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-10-amery.hung@bytedance.com>
 <ldyfzp5k2qmhlydflu7biz6bcrekothacitzgbmw2k264zwuxh@hmgoku5kgghp>
 <CAMB2axNx=nCh-B-=XLtto2nEsKsV0p+b7yzXRX9OKSgUbRzzWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMB2axNx=nCh-B-=XLtto2nEsKsV0p+b7yzXRX9OKSgUbRzzWA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 29, 2024 at 05:35:01PM GMT, Amery Hung wrote:
>On Tue, Jul 23, 2024 at 7:42 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Wed, Jul 10, 2024 at 09:25:50PM GMT, Amery Hung wrote:
>> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >
>> >This commit adds the common datagram receive functionality for virtio
>> >transports. It does not add the vhost/virtio users of that
>> >functionality.
>> >
>> >This functionality includes:
>> >- changes to the virtio_transport_recv_pkt() path for finding the
>> >  bound socket receiver for incoming packets
>> >- virtio_transport_recv_pkt() saves the source cid and port to the
>> >  control buffer for recvmsg() to initialize sockaddr_vm structure
>> >  when using datagram
>> >
>> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> >Signed-off-by: Amery Hung <amery.hung@bytedance.com>
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 79 +++++++++++++++++++++----
>> > 1 file changed, 66 insertions(+), 13 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 46cd1807f8e3..a571b575fde9 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -235,7 +235,9 @@ EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
>> >
>> > static u16 virtio_transport_get_type(struct sock *sk)
>> > {
>> >-      if (sk->sk_type == SOCK_STREAM)
>> >+      if (sk->sk_type == SOCK_DGRAM)
>> >+              return VIRTIO_VSOCK_TYPE_DGRAM;
>> >+      else if (sk->sk_type == SOCK_STREAM)
>> >               return VIRTIO_VSOCK_TYPE_STREAM;
>> >       else
>> >               return VIRTIO_VSOCK_TYPE_SEQPACKET;
>> >@@ -1422,6 +1424,33 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> >               kfree_skb(skb);
>> > }
>> >
>> >+static void
>> >+virtio_transport_dgram_kfree_skb(struct sk_buff *skb, int err)
>> >+{
>> >+      if (err == -ENOMEM)
>> >+              kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF);
>> >+      else if (err == -ENOBUFS)
>> >+              kfree_skb_reason(skb, SKB_DROP_REASON_PROTO_MEM);
>> >+      else
>> >+              kfree_skb(skb);
>> >+}
>> >+
>> >+/* This function takes ownership of the skb.
>> >+ *
>> >+ * It either places the skb on the sk_receive_queue or frees it.
>> >+ */
>> >+static void
>> >+virtio_transport_recv_dgram(struct sock *sk, struct sk_buff *skb)
>> >+{
>> >+      int err;
>> >+
>> >+      err = sock_queue_rcv_skb(sk, skb);
>> >+      if (err) {
>> >+              virtio_transport_dgram_kfree_skb(skb, err);
>> >+              return;
>> >+      }
>> >+}
>> >+
>> > static int
>> > virtio_transport_recv_connected(struct sock *sk,
>> >                               struct sk_buff *skb)
>> >@@ -1591,7 +1620,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> > static bool virtio_transport_valid_type(u16 type)
>> > {
>> >       return (type == VIRTIO_VSOCK_TYPE_STREAM) ||
>> >-             (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
>> >+             (type == VIRTIO_VSOCK_TYPE_SEQPACKET) ||
>> >+             (type == VIRTIO_VSOCK_TYPE_DGRAM);
>> > }
>> >
>> > /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>> >@@ -1601,44 +1631,57 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >                              struct sk_buff *skb)
>> > {
>> >       struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>> >+      struct vsock_skb_cb *vsock_cb;
>>
>> This can be defined in the block where it's used.
>>
>
>Got it.
>
>> >       struct sockaddr_vm src, dst;
>> >       struct vsock_sock *vsk;
>> >       struct sock *sk;
>> >       bool space_available;
>> >+      u16 type;
>> >
>> >       vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
>> >                       le32_to_cpu(hdr->src_port));
>> >       vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
>> >                       le32_to_cpu(hdr->dst_port));
>> >
>> >+      type = le16_to_cpu(hdr->type);
>> >+
>> >       trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
>> >                                       dst.svm_cid, dst.svm_port,
>> >                                       le32_to_cpu(hdr->len),
>> >-                                      le16_to_cpu(hdr->type),
>> >+                                      type,
>> >                                       le16_to_cpu(hdr->op),
>> >                                       le32_to_cpu(hdr->flags),
>> >                                       le32_to_cpu(hdr->buf_alloc),
>> >                                       le32_to_cpu(hdr->fwd_cnt));
>> >
>> >-      if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>> >+      if (!virtio_transport_valid_type(type)) {
>> >               (void)virtio_transport_reset_no_sock(t, skb);
>> >               goto free_pkt;
>> >       }
>> >
>> >-      /* The socket must be in connected or bound table
>> >-       * otherwise send reset back
>> >+      /* For stream/seqpacket, the socket must be in connected or bound table
>> >+       * otherwise send reset back.
>> >+       *
>> >+       * For datagrams, no reset is sent back.
>> >        */
>> >       sk = vsock_find_connected_socket(&src, &dst);
>> >       if (!sk) {
>> >-              sk = vsock_find_bound_socket(&dst);
>> >-              if (!sk) {
>> >-                      (void)virtio_transport_reset_no_sock(t, skb);
>> >-                      goto free_pkt;
>> >+              if (type == VIRTIO_VSOCK_TYPE_DGRAM) {
>> >+                      sk = vsock_find_bound_dgram_socket(&dst);
>> >+                      if (!sk)
>> >+                              goto free_pkt;
>> >+              } else {
>> >+                      sk = vsock_find_bound_socket(&dst);
>> >+                      if (!sk) {
>> >+                              (void)virtio_transport_reset_no_sock(t, skb);
>> >+                              goto free_pkt;
>> >+                      }
>> >               }
>> >       }
>> >
>> >-      if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>> >-              (void)virtio_transport_reset_no_sock(t, skb);
>> >+      if (virtio_transport_get_type(sk) != type) {
>> >+              if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>> >+                      (void)virtio_transport_reset_no_sock(t, skb);
>> >               sock_put(sk);
>> >               goto free_pkt;
>> >       }
>> >@@ -1654,12 +1697,21 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >
>> >       /* Check if sk has been closed before lock_sock */
>> >       if (sock_flag(sk, SOCK_DONE)) {
>> >-              (void)virtio_transport_reset_no_sock(t, skb);
>> >+              if (type != VIRTIO_VSOCK_TYPE_DGRAM)
>> >+                      (void)virtio_transport_reset_no_sock(t, skb);
>> >               release_sock(sk);
>> >               sock_put(sk);
>> >               goto free_pkt;
>> >       }
>> >
>> >+      if (sk->sk_type == SOCK_DGRAM) {
>> >+              vsock_cb = vsock_skb_cb(skb);
>> >+              vsock_cb->src_cid = src.svm_cid;
>> >+              vsock_cb->src_port = src.svm_port;
>> >+              virtio_transport_recv_dgram(sk, skb);
>>
>>
>> What about adding an API that transports can use to hide this?
>>
>> I mean something that hide vsock_cb creation and queue packet in the
>> socket receive queue. I'd also not expose vsock_skb_cb in an header, but
>> I'd handle it internally in af_vsock.c. So I'd just expose API to
>> queue/dequeue them.
>>
>
>Got it. I will move vsock_skb_cb to af_vsock.c and create an API:
>
>vsock_dgram_skb_save_src_addr(struct sk_buff *skb, u32 cid, u32 port)

This is okay, but I would try to go further by directly adding an API to 
queue dgrams in af_vsock.c (if it's feasible).

>
>Different dgram implementations will call this API instead of the code
>block above to save the source address information into the control
>buffer.
>
>A side note on why this is a vsock API instead of a member )unction in
>transport: As we move to support multi-transport dgram, different
>transport implementations can place skb into the sk->sk_receive_queue.
>Therefore, we cannot call transport-specific function in
>vsock_dgram_recvmsg() to initialize struct sockaddr_vm. Hence, the
>receiving paths of different transports need to call this API to save
>source address.

What I meant is, why virtio_transport_recv_dgram() can't be exposed by 
af_vsock.c as vsock_recv_dgram() and handle all internally, like 
populate vsock_cb, call sock_queue_rcv_skb(), etc.

>
>> Also why VMCI is using sk_receive_skb(), while we are using
>> sock_queue_rcv_skb()?
>>
>
>I _think_ originally we referred to UDP and UDS when designing virtio
>dgram, and ended up with placing skb into sk_receive_queue directly. I
>will look into this to provide better justification.

Great, thanks.

Maybe we can also ping VMCI maintainers to understand if they can switch 
to sock_queue_rcv_skb(). But we should understand better the difference.

Thanks,
Stefano

