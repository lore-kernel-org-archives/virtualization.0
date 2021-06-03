Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89AC47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:14:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAE861408
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAE861408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9108C83EFF;
	Thu,  3 Jun 2021 15:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1y7gQduSA9gX; Thu,  3 Jun 2021 15:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69653834E8;
	Thu,  3 Jun 2021 15:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8A8C000E;
	Thu,  3 Jun 2021 15:14:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAE95C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A50D5405C0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGO_ce5E7OxB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2E544023D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622733284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TbnjPejbYwVan9HkOykuBL+tAV4BzyESSrfqanFgRE=;
 b=G8G+/20/tkQbMnXpvX8HFRinXvufLQ3bNOoduXVp/EJc1DCTRGJnyB7LDuEcpXEMI1LZiM
 Ph0PSJrX/4dorCOqQDsjK/IDHS5jlsRxoZqIvyeBtzMf75BffYVhHmvzus8cmPdzkBtgEZ
 GFXLUyaiBKMOk6hkz9A2eDues5yEudE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-YVgCN2vlNKagO_gogxv2HQ-1; Thu, 03 Jun 2021 11:14:42 -0400
X-MC-Unique: YVgCN2vlNKagO_gogxv2HQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 am5-20020a1709065685b02903eef334e563so2086027ejc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 08:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/TbnjPejbYwVan9HkOykuBL+tAV4BzyESSrfqanFgRE=;
 b=NBqrHxStrFIk0DpnSpcCW3obsCv7xGyGwdTJcw4760gF1QmtP5qrdTi4PRZZ79YP5D
 Jd8v1JmLaRGfgGr1vTBvAU0yVk5hsWEdMjRGVX7gB0jcllnu2vThYLFhfF7gRgRJkjUC
 SP6uKuNlJ6hQoL4tNLvxS3SjvVhizloJCmZxLpsIm6ohav6yeHzhEu4k8a3/+qgniZSL
 2/1suM1mYbfEA4GqWNSXa0YmFs96QEXZ0K23B9MmEoQW+bg9HmBdBIbAoxVWLy1LYL6B
 ZkEOwLKtKYf5irIKmE06r68QiPvCT310A2PzjzMabbRP5QK0d/V2SzfTQ+y6n4gud6A6
 5+ng==
X-Gm-Message-State: AOAM530Nl/5E3Sr/AIvseQTQeQfCKoS9S4S3ef1q2PAEjetpCgI1LcvC
 r7BbnX59gD7Ha2xa9AxVmBm2FZNWLlLOTI65n5HkuPZ3UXFFjszOAiUcHX5LkJMfq72+FzarCdP
 0TRXvw0It0Uk0jdUDLpo8Eay38j/iwj4w+HrhBNUYBQ==
X-Received: by 2002:a17:906:15c2:: with SMTP id
 l2mr102910ejd.348.1622733281791; 
 Thu, 03 Jun 2021 08:14:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0x5W1f0mRcMdebhikIGS3xszHMVLQeFtJfQT5T5MgWSrP7f8pNxRu7aXb5Lg9wKUHaELxKA==
X-Received: by 2002:a17:906:15c2:: with SMTP id
 l2mr102880ejd.348.1622733281491; 
 Thu, 03 Jun 2021 08:14:41 -0700 (PDT)
Received: from steredhat ([5.170.129.82])
 by smtp.gmail.com with ESMTPSA id v21sm1894572edt.48.2021.06.03.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 08:14:40 -0700 (PDT)
Date: Thu, 3 Jun 2021 17:14:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 13/18] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210603151433.3tbiibmcfacpcjt2@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191840.1272290-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191840.1272290-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 20, 2021 at 10:18:37PM +0300, Arseny Krasnov wrote:
>Small updates to make SOCK_SEQPACKET work:
>1) Send SHUTDOWN on socket close for SEQPACKET type.
>2) Set SEQPACKET packet type during send.
>3) Set 'VIRTIO_VSOCK_SEQ_EOR' bit in flags for last
>   packet of message.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Use 'msg_data_left()' instead of direct access to 'msg_hdr'.
> 2) Commit message updated.
> 3) Add check for socket type when setting SEQ_EOR bit.
>
> include/linux/virtio_vsock.h            |  4 ++++
> net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 02acf6e9ae04..7360ab7ea0af 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -80,6 +80,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
> 			       size_t len, int flags);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len);
> ssize_t
> virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> 				   struct msghdr *msg,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index a6f8b0f39775..f7a3281b3eab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -74,6 +74,11 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> 		err = memcpy_from_msg(pkt->buf, info->msg, len);
> 		if (err)
> 			goto out;
>+
>+		if (msg_data_left(info->msg) == 0 &&
>+		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET)
>+			pkt->hdr.flags = cpu_to_le32(info->flags |
>+						VIRTIO_VSOCK_SEQ_EOR);

`pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR)` should be enough, 
no?

Stefano

> 	}
>
> 	trace_virtio_transport_alloc_pkt(src_cid, src_port,
>@@ -187,7 +192,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	struct virtio_vsock_pkt *pkt;
> 	u32 pkt_len = info->pkt_len;
>
>-	info->type = VIRTIO_VSOCK_TYPE_STREAM;
>+	info->type = virtio_transport_get_type(sk_vsock(vsk));
>
> 	t_ops = virtio_transport_get_ops(vsk);
> 	if (unlikely(!t_ops))
>@@ -478,6 +483,15 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+				   struct msghdr *msg,
>+				   size_t len)
>+{
>+	return virtio_transport_stream_enqueue(vsk, msg, len);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> 			       struct msghdr *msg,
>@@ -912,7 +926,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
> 	struct sock *sk = &vsk->sk;
> 	bool remove_sock = true;
>
>-	if (sk->sk_type == SOCK_STREAM)
>+	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> 		remove_sock = virtio_transport_close(vsk);
>
> 	if (remove_sock) {
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
