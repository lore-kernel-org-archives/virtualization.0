Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A3C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:17:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB4464DE7
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB4464DE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4AE46061E;
	Tue, 23 Feb 2021 14:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MrW6EK1GPmBa; Tue, 23 Feb 2021 14:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 350B86061D;
	Tue, 23 Feb 2021 14:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3E16C000B;
	Tue, 23 Feb 2021 14:17:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54BBCC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3413D60612
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 67lpLa6C2Cow
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:17:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B772D600D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614089828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sdXyf3LSwUfaOHdYYNvJzMwzVE2QLNggB+GkV4jURgg=;
 b=SMbfH51Fc+Ar46fH5urrW8wOvay2i6Z/9v9y6wU893Ox17+pQmH2GUDsla/w1aPWHmzQEJ
 96BzHeM1w/8SLu41HrhMjjikdS6PHdl9Jka3E62XKYNDXa5DR2V0fdQhyPTOBhfPZ9F9Pq
 b8TnVeah3AYuLMqtBsg4XswDFld3K40=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FlRHk3tQO-ah6q9Q--crwg-1; Tue, 23 Feb 2021 09:17:06 -0500
X-MC-Unique: FlRHk3tQO-ah6q9Q--crwg-1
Received: by mail-wr1-f71.google.com with SMTP id h30so142700wrh.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sdXyf3LSwUfaOHdYYNvJzMwzVE2QLNggB+GkV4jURgg=;
 b=ltjoJKDP99wx0X5ih5TaOhqeGoP0jjiykXqQ1oZRJy3WvfDcp59zXifgnBKSEUca1D
 ffqVsJ9rGPeyXTVAAqkSQYUxpD6SDo2pe8981A2/IlXC9p3x8WsMguEK/WQGz7PUI5y2
 i5NQraPpVSU3oC/1thYai/l/EUwliMfitnhVKEYWpNqbUgi0l0dwX18usJ6otw6GozDY
 gIlIfv/zUnlS96Tpg+LniS53iSs8wEzQTsVPvx2jSzZboIG1v8m2XYjmBQmcKZ9VfNYm
 ajpimueHuf+ucIaE2Jl9DAcOqsRJGHt/luaxrIPU9p+okDDB8rso9OzJccEOtdBSmhU/
 4fvA==
X-Gm-Message-State: AOAM532rd9u1we95nPf30J8kr1QyuQKo1XVn4YOjy07sgHmQJdt43WBT
 5C28cwb9YgKmzW2gED6S9A02nfVwpEeNXP94MCqcayAYCtrCjw7ZOGqSoDw756VdChoK1MpOawu
 1F64G0x3iMAvGZJo4kiRe7dgh10wdO8RlqW8zkTZeWw==
X-Received: by 2002:a5d:6281:: with SMTP id k1mr348213wru.405.1614089825287;
 Tue, 23 Feb 2021 06:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJRkCFoKbQo6xkTrUQIfNHvZqxmgXuNRPSXDblbZ7p/K2Lm7SUd5TdeJEawHMxG9rT2h8eEQ==
X-Received: by 2002:a5d:6281:: with SMTP id k1mr348184wru.405.1614089825095;
 Tue, 23 Feb 2021 06:17:05 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id 6sm40310912wra.63.2021.02.23.06.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 06:17:04 -0800 (PST)
Date: Tue, 23 Feb 2021 09:17:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 11/19] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210223091536-mutt-send-email-mst@kernel.org>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053940.1068164-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Feb 18, 2021 at 08:39:37AM +0300, Arseny Krasnov wrote:
> This adds transport callback and it's logic for SEQPACKET dequeue.
> Callback fetches RW packets from rx queue of socket until whole record
> is copied(if user's buffer is full, user is not woken up). This is done
> to not stall sender, because if we wake up user and it leaves syscall,
> nobody will send credit update for rest of record, and sender will wait
> for next enter of read syscall at receiver's side. So if user buffer is
> full, we just send credit update and drop data. If during copy SEQ_BEGIN
> was found(and not all data was copied), copying is restarted by reset
> user's iov iterator(previous unfinished data is dropped).
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  include/linux/virtio_vsock.h            |  10 +++
>  include/uapi/linux/virtio_vsock.h       |  16 ++++
>  net/vmw_vsock/virtio_transport_common.c | 114 ++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
> 
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index dc636b727179..003d06ae4a85 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -36,6 +36,11 @@ struct virtio_vsock_sock {
>  	u32 rx_bytes;
>  	u32 buf_alloc;
>  	struct list_head rx_queue;
> +
> +	/* For SOCK_SEQPACKET */
> +	u32 user_read_seq_len;
> +	u32 user_read_copied;
> +	u32 curr_rx_msg_cnt;


wrap these in a struct to make it's clearer they
are related?

>  };
>  
>  struct virtio_vsock_pkt {
> @@ -80,6 +85,11 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>  			       struct msghdr *msg,
>  			       size_t len, int flags);
>  
> +int
> +virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> +				   struct msghdr *msg,
> +				   int flags,
> +				   bool *msg_ready);
>  s64 virtio_transport_stream_has_data(struct vsock_sock *vsk);
>  s64 virtio_transport_stream_has_space(struct vsock_sock *vsk);
>  
> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
> index 1d57ed3d84d2..cf9c165e5cca 100644
> --- a/include/uapi/linux/virtio_vsock.h
> +++ b/include/uapi/linux/virtio_vsock.h
> @@ -63,8 +63,14 @@ struct virtio_vsock_hdr {
>  	__le32	fwd_cnt;
>  } __attribute__((packed));
>  
> +struct virtio_vsock_seq_hdr {
> +	__le32  msg_cnt;
> +	__le32  msg_len;
> +} __attribute__((packed));
> +
>  enum virtio_vsock_type {
>  	VIRTIO_VSOCK_TYPE_STREAM = 1,
> +	VIRTIO_VSOCK_TYPE_SEQPACKET = 2,
>  };
>  
>  enum virtio_vsock_op {
> @@ -83,6 +89,11 @@ enum virtio_vsock_op {
>  	VIRTIO_VSOCK_OP_CREDIT_UPDATE = 6,
>  	/* Request the peer to send the credit info to us */
>  	VIRTIO_VSOCK_OP_CREDIT_REQUEST = 7,
> +
> +	/* Record begin for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_BEGIN = 8,
> +	/* Record end for SOCK_SEQPACKET */
> +	VIRTIO_VSOCK_OP_SEQ_END = 9,
>  };
>  
>  /* VIRTIO_VSOCK_OP_SHUTDOWN flags values */
> @@ -91,4 +102,9 @@ enum virtio_vsock_shutdown {
>  	VIRTIO_VSOCK_SHUTDOWN_SEND = 2,
>  };
>  
> +/* VIRTIO_VSOCK_OP_RW flags values */
> +enum virtio_vsock_rw {
> +	VIRTIO_VSOCK_RW_EOR = 1,
> +};
> +
>  #endif /* _UAPI_LINUX_VIRTIO_VSOCK_H */

Probably a good idea to also have a feature bit gating
this functionality.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
