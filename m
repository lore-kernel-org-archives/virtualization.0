Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DBC43460
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:12:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFDD613E6
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFDD613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE269405C1;
	Wed, 21 Apr 2021 09:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wrRS3Af9tVQd; Wed, 21 Apr 2021 09:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1022C405B0;
	Wed, 21 Apr 2021 09:12:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C613FC000F;
	Wed, 21 Apr 2021 09:12:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF155C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4FEC83D3E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bzjq9OmBCr5b
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4F8983AE0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618996355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFQIJ+5CqCy4do+wsQBitgOFibPbQLAGAyXiYakCXZc=;
 b=Yi3FDya800Kr0D+qM5N2IClPNAxr7YUEr5WK8ISX87kYWIfHo9qsjVESQ8Fp1wd7DMflH4
 bjjSipnYBlaMAZ6v+9b3dJH5a0Hp/ZKDDaoVAtz8ETuORh/zoBu4giNtBprffm9vnyea0k
 JZdlLvam1mNVjCMTJ7tJrOMjyjfamHc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-Iy0P5CwtP8SqYJ6ncRtNRw-1; Wed, 21 Apr 2021 05:12:34 -0400
X-MC-Unique: Iy0P5CwtP8SqYJ6ncRtNRw-1
Received: by mail-ej1-f71.google.com with SMTP id
 d16-20020a1709066410b0290373cd3ce7e6so5649131ejm.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JFQIJ+5CqCy4do+wsQBitgOFibPbQLAGAyXiYakCXZc=;
 b=jrlGEuJ7YJPU7qQaz2bhhYkJIKyD95uS7UOG3iDgTTVfaB5V+CZN78SXgEVYugRmIz
 cmBO6q0cikmB1qNzjtQw0PaC3t0JxiwZPDRC04IERcvKjKFMTYKQOfrf77Sn3egQWYbG
 huwgN6mpGILkn9pGnwwQxMBoGutYEJiqu+1KNAtXUD+M3r8tMHRFUZt6m872FCkgPf93
 V+ouGHAXujbghMfKpm4CdcomhW9RH2wsHGoLyFg0J/+kH4nO8mdJKPK+2UTicyQ2eDd8
 I/qfGQgEFaImVrjYBTDRrnHhRDnmRb95x7Y9f0DIx6vVeDEr30KH6/fcnE3XCVJnxVI8
 s1eQ==
X-Gm-Message-State: AOAM533PxpBv+9NPCjGcZEPIuxpaqTMAmFu0yRNY8zAp5+ZO0/yodn2n
 UwQOnRMqy+3YW2exlBhzRRfOU89p24DbNXisURCSISbL0gd93oD+kvCWoU7JE5EmwGOy3k0IX40
 LQ3OStpTgZEMeYbXqfSi6x1rPJgjzPvqVBlYl11w60A==
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr24562936edq.146.1618996352007; 
 Wed, 21 Apr 2021 02:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4h+POcUCHwJn3anUWZxgfuhqxTTTMI2BlWbtYQhJqOg9+yrbcbRX7689t2hRaE5mbU+0swg==
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr24562907edq.146.1618996351808; 
 Wed, 21 Apr 2021 02:12:31 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id dc24sm1725846ejb.123.2021.04.21.02.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:12:31 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:12:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 13/19] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <CAGxU2F6A3-pY5We-pC7-k-3v-tOdKnFvHEAs7eGo4bHnD=sM5Q@mail.gmail.com>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124528.3404287-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124528.3404287-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 stsp <stsp2@yandex.ru>, kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Apr 13, 2021 at 03:45:25PM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) Send SHUTDOWN on socket close for SEQPACKET type.
>2) Set SEQPACKET packet type during send.
>3) 'seqpacket_allow' flag to virtio transport.
>4) Set 'VIRTIO_VSOCK_SEQ_EOR' bit in flags for last
>   packet of message.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - MSG_EOR handling is removed, i didn't found exact description about
>   how it works in POSIX.
> - SEQ_BEGIN, SEQ_END, etc. now removed.
>
> include/linux/virtio_vsock.h            |  6 ++++++
> net/vmw_vsock/virtio_transport_common.c | 16 ++++++++++++++--
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 02acf6e9ae04..f00a01bfdd7e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -68,6 +68,8 @@ struct virtio_transport {
>
>       /* Takes ownership of the packet */
>       int (*send_pkt)(struct virtio_vsock_pkt *pkt);
>+
>+      bool seqpacket_allow;
> };
>
> ssize_t
>@@ -80,6 +82,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>                              struct msghdr *msg,
>                              size_t len, int flags);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+                                 struct msghdr *msg,
>+                                 size_t len);
> ssize_t
> virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
>                                  struct msghdr *msg,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 572869fef832..4c5b63601308 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -74,6 +74,9 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
>               err = memcpy_from_msg(pkt->buf, info->msg, len);
>               if (err)
>                       goto out;
>+
>+              if (info->msg->msg_iter.count == 0)
>+                      pkt->hdr.flags |= VIRTIO_VSOCK_SEQ_EOR;

We should set the flag in info->flags and assign it using cpu_to_le32() 
or just the following:
			pkt->hdr.flags = cpu_to_le32(info->flags |
						VIRTIO_VSOCK_SEQ_EOR);


>       }
>
>       trace_virtio_transport_alloc_pkt(src_cid, src_port,
>@@ -187,7 +190,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>       struct virtio_vsock_pkt *pkt;
>       u32 pkt_len = info->pkt_len;
>
>-      info->type = VIRTIO_VSOCK_TYPE_STREAM;
>+      info->type = virtio_transport_get_type(sk_vsock(vsk));
>
>       t_ops = virtio_transport_get_ops(vsk);
>       if (unlikely(!t_ops))
>@@ -486,6 +489,15 @@ virtio_transport_seqpacket_dequeue(struct 
>vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>+int
>+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>+                                 struct msghdr *msg,
>+                                 size_t len)
>+{
>+      return virtio_transport_stream_enqueue(vsk, msg, len);
>+}
>+EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_enqueue);
>+
> int
> virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
>                              struct msghdr *msg,
>@@ -905,7 +917,7 @@ void virtio_transport_release(struct vsock_sock *vsk)
>       struct sock *sk = &vsk->sk;
>       bool remove_sock = true;
>
>-      if (sk->sk_type == SOCK_STREAM)
>+      if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
>               remove_sock = virtio_transport_close(vsk);
>
>       list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
