Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D11C6FD1D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 13:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D61B8404A6;
	Mon, 20 Mar 2023 13:58:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D61B8404A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c8WPMUJJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGACLeNLCHQN; Mon, 20 Mar 2023 13:58:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29CE5403CC;
	Mon, 20 Mar 2023 13:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29CE5403CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD885C0035;
	Mon, 20 Mar 2023 13:58:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 674E7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 13:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3563760ECA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 13:58:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3563760ECA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c8WPMUJJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9uYDi8skQmh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 13:58:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1681260E89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1681260E89
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679320702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xluQCIRM9KUg+iS1ks5cvU7xSezg5DUOPbgJwMPELqs=;
 b=c8WPMUJJcAHK9PTmLc2ZgJJ+kU/Xfx9ms053qTHcb33hzgw2+XWzndFQ4UHKVlDoPtjPl4
 PboCQ72LWxNondj24x6Hg0OXjGmplH/PYWajoCtjcc7Clo6psPder1YiyfJPxRw/WY4JsI
 yPw49mF2B4Gfg9GVjG2lsSj6TSHrpr0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-SHT0NcjYMSaITSCSZMweOA-1; Mon, 20 Mar 2023 09:58:18 -0400
X-MC-Unique: SHT0NcjYMSaITSCSZMweOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 bg13-20020a05600c3c8d00b003ed40f09355so5567816wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 06:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679320697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xluQCIRM9KUg+iS1ks5cvU7xSezg5DUOPbgJwMPELqs=;
 b=4/1U/JindL+ScocChbKY22Dd+0aFi6TD0TKTRCvsHVYBwXz9wsvKgOtc1RzCSK1urt
 ctJZ++M7jdB+S04kialc17R7Us3y0Sb0jVr6iI1HTQnYaxIQqnJo8JzxJXyjRe+EMoyK
 w8ZkXKMdCJ0CdQxjRk2yY1rtIsq+2XNlUbsx8pWXek45qvnlSjbz+bmIfuHoIaMM9eAF
 g6FEyafkZwoT8qEwpEHNwLr15vMBSY36pvEotgSSbcafOE4sftUhFahmOkY9Q3NRBa+8
 LP5qzihjWiMRR4xtsF0x/7hx/obxRLwdMLJyqmuemSSrltxI6R/mP+EG/uGXdOO5U7du
 BQVg==
X-Gm-Message-State: AO0yUKUwvb3tqXWfXkoIZVyxPo83mbjXEckuLa1lvS21OW7HZ91+jsiT
 mVL7prVW1/gId8FWyuQPypqM3Js5QkUqc59YipU05ATsBQu46FH4XwNNDOxkSl2i9nc0jjr0jVw
 S6ISR+Q/cWbCdrKIRK3sqdG/PUOWf6wahmVIMmWEfIA==
X-Received: by 2002:adf:ce11:0:b0:2c7:851:c0bf with SMTP id
 p17-20020adfce11000000b002c70851c0bfmr13818708wrn.0.1679320697842; 
 Mon, 20 Mar 2023 06:58:17 -0700 (PDT)
X-Google-Smtp-Source: AK7set+FUDvH/psBKoCx/B613vRQOYlndcOrSX0ahkGfyMMplDZBRpmL9wOqCuvTHwUfmOLfiNDOAg==
X-Received: by 2002:adf:ce11:0:b0:2c7:851:c0bf with SMTP id
 p17-20020adfce11000000b002c70851c0bfmr13818684wrn.0.1679320697599; 
 Mon, 20 Mar 2023 06:58:17 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 s13-20020a5d510d000000b002c794495f6fsm5977998wrt.117.2023.03.20.06.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Mar 2023 06:58:17 -0700 (PDT)
Date: Mon, 20 Mar 2023 14:58:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] virtio/vsock: check transport before skb allocation
Message-ID: <20230320135814.jncpvznka56liu36@sgarzare-redhat>
References: <47a7dbf6-1c63-3338-5102-122766e6378d@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <47a7dbf6-1c63-3338-5102-122766e6378d@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Mar 17, 2023 at 01:37:10PM +0300, Arseniy Krasnov wrote:
>Pointer to transport could be checked before allocation of skbuff, thus
>there is no need to free skbuff when this pointer is NULL.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)

LGTM, I think net-next is fine for this.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index cda587196475..607149259e8b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -867,6 +867,9 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (le16_to_cpu(hdr->op) == VIRTIO_VSOCK_OP_RST)
> 		return 0;
>
>+	if (!t)
>+		return -ENOTCONN;
>+
> 	reply = virtio_transport_alloc_skb(&info, 0,
> 					   le64_to_cpu(hdr->dst_cid),
> 					   le32_to_cpu(hdr->dst_port),
>@@ -875,11 +878,6 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!reply)
> 		return -ENOMEM;
>
>-	if (!t) {
>-		kfree_skb(reply);
>-		return -ENOTCONN;
>-	}
>-
> 	return t->send_pkt(reply);
> }
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
