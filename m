Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC084C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 12:27:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466A66127A
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 12:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466A66127A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AD12608CE;
	Thu, 13 May 2021 12:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQQSIK83FGJx; Thu, 13 May 2021 12:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DDF0608A0;
	Thu, 13 May 2021 12:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B136C000D;
	Thu, 13 May 2021 12:27:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9954C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1649608A2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uRaaloG0yKn3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:27:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20453608A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620908837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bun77zqk7VkzrXJl00b3NEyJ8M8mJCA5zh/pMnmjFG0=;
 b=iH6J4qdFWgPtLtECOndFNIH+F9dzprVPPh+JFWG2/z5AjSX2CmApH7q+nAgibMD1kZJxzZ
 al3iUBec1gFt3pZy84I22OQzALuTfQo00+fCfQucUkp1on5YoMoKAGQUKNDzq1nfV9MuRl
 KYpN3i7PQjYIWztaGx7lBTHnTwjuMoM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-cHwFI-MzOoWm6k9RYPW0TQ-1; Thu, 13 May 2021 08:27:14 -0400
X-MC-Unique: cHwFI-MzOoWm6k9RYPW0TQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 d8-20020a0564020008b0290387d38e3ce0so14558970edu.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bun77zqk7VkzrXJl00b3NEyJ8M8mJCA5zh/pMnmjFG0=;
 b=gwgHD8VmatBPz188vZozgLpLCRv4CU4eR8hadRYP0gobd6I8/HfPRVOAF7wHudHvFy
 M6yrFc8AUTmBn08Re4KBIyPB/EQSMtEkBFREZEGpEy1R371tpNK+uI3lIktri3eK9k12
 we86bTydKDuQUUJHZqFL16o8NwzYAhJp3J60z4OWtMwINmQSL/QR+Eq0tOSq/n57AAJc
 BaV0PnG46vfFjxiMyLPtjuRQJ5mpqxvxJ9ye58TrE8M4XH+ivWh9kOSN9rUWMUOab0z6
 lZFezPbe2Bd1PNsCGCAZoaY4M6IgjB0PUsIbWBotkzQn1Oa9x14RFQCy4SR8yMS0osDn
 BUKA==
X-Gm-Message-State: AOAM533ZotP53E698AAbo4zoNyxC5eKGtC+2a9/ZjDAQEj9rtxjTYAzY
 WcwRTg7H/mueX7VZ//eo3CYV5cXQJd7FEYqaAexnIuNWvSn/FhDJhMDk1O911LwomvZ+90BKOn0
 EE4uFwUddaSO5CPTVGAC1ptsaK446BwzyP6OYlWtNaw==
X-Received: by 2002:a17:907:dab:: with SMTP id
 go43mr887186ejc.164.1620908832789; 
 Thu, 13 May 2021 05:27:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwue4TmFqWLEu2VxiQaCD7KEItg8q3jSRdx8XvzysQOkYR1mJoopNDC9/BUXvDd7qRZ6CJ1Qw==
X-Received: by 2002:a17:907:dab:: with SMTP id
 go43mr887165ejc.164.1620908832621; 
 Thu, 13 May 2021 05:27:12 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id g17sm2863576edv.47.2021.05.13.05.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 05:27:12 -0700 (PDT)
Date: Thu, 13 May 2021 14:27:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 13/19] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <20210513122708.mwooglzkhv7du7jo@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163558.3432246-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163558.3432246-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
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

On Sat, May 08, 2021 at 07:35:54PM +0300, Arseny Krasnov wrote:
>This adds rest of logic for SEQPACKET:
>1) Send SHUTDOWN on socket close for SEQPACKET type.
>2) Set SEQPACKET packet type during send.
>3) 'seqpacket_allow' flag to virtio transport.

Please update this commit message, point 3 is not included anymore in 
this patch, right?

>4) Set 'VIRTIO_VSOCK_SEQ_EOR' bit in flags for last
>   packet of message.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v8 -> v9:
> 1) Use cpu_to_le32() to set VIRTIO_VSOCK_SEQ_EOR.
>
> include/linux/virtio_vsock.h            |  4 ++++
> net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++--
> 2 files changed, 19 insertions(+), 2 deletions(-)
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
>index 7fea0a2192f7..b6608b4ac7c2 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -74,6 +74,10 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> 		err = memcpy_from_msg(pkt->buf, info->msg, len);
> 		if (err)
> 			goto out;
>+
>+		if (info->msg->msg_iter.count == 0)

Also here is better `msg_data_left(info->msg)`

>+			pkt->hdr.flags = cpu_to_le32(info->flags |
>+						VIRTIO_VSOCK_SEQ_EOR);

Re-thinking an alternative could be to set EOR here...

			info->flags |= VIRTIO_VSOCK_SEQ_EOR;

> 	}

... and move pkt->hdr.flags assignment after this block:

	pkt->hdr.flags = cpu_to_le32(info->flags);

But I don't have a strong opinion on that.

>
> 	trace_virtio_transport_alloc_pkt(src_cid, src_port,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
