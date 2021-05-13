Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB75C433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:03:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F670611CE
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 13:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F670611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF093404BE;
	Thu, 13 May 2021 13:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KTz6o3qhlgrT; Thu, 13 May 2021 13:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DBCB40F15;
	Thu, 13 May 2021 13:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD714C000D;
	Thu, 13 May 2021 13:03:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E256C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19C44608A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pW3Q01b8o768
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4072A608F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620911001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reFKUH6rrlF+AA2394T7GVrIVtOgj3DePRS0lsPMuB0=;
 b=W79G/SckGQbwzHM6ol7qbF/q+QWBwmZBlL2Ccvd8F/g7UtKqU8OJJXS5mIGQ2bcxB4zT8H
 Ov4+GKxiOhi3fY8y1hXauyee6uTvYcCrmHDaEtJ61ErFaUfTOH1SJ+k2yCx0ECVbAIDT3+
 07/A8HRsh1HGwA6gdPQIn3RjmPah4mk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-rt9DkAFIPLOBsK6YLKjQjg-1; Thu, 13 May 2021 09:03:17 -0400
X-MC-Unique: rt9DkAFIPLOBsK6YLKjQjg-1
Received: by mail-ej1-f69.google.com with SMTP id
 o18-20020a17090637d2b02903bf3465db95so4206874ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=reFKUH6rrlF+AA2394T7GVrIVtOgj3DePRS0lsPMuB0=;
 b=dYbHwsLu3lAd5iTyvbWsfrCQbUSO5LjIfNbg1oyQ/5ISLh5XTIHhkaBYYny+w1Px1S
 UmsxN2imPFDVIGBhLZWEEUXyk23X9///9rhURCxna/qR/qBx3M1cW85X+r+72a5/NJ17
 eCtQ3LnDGTaaL1a7a/D1aFaWTPyf5bksMBo87YCoLjSKyxfZJrPlgJzH45G2CyWkKKh9
 Zm7NuT/13LE20QWt44/Xrz6QmYX+ejLjKaIc6ejB3AnCvKqmHfHGT08NZYkKa/3KxOiG
 Cm31f95vJXgZR7IWc2XgamJLmzdZYGN1VgOLO/319c6LkMdlAGhNoj4UR+AT0MEMQaat
 4zQg==
X-Gm-Message-State: AOAM532IRo4zWEB0oe8lVbPRtZJhLjbpB7irvBImM0UddaG/sEUYCV8r
 TodQhjbBYqSCq/Y4nZARgshmgA1YMIpdHOuX3PZ65WKVV7q9MNNd5NP15thtLazN7vXgh7W+4cJ
 YPINfy7eu0xtn+IiMZSsouxT8LGHWYKDmd3+AlnRvGQ==
X-Received: by 2002:a17:906:a017:: with SMTP id
 p23mr44269247ejy.460.1620910996139; 
 Thu, 13 May 2021 06:03:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlZU02TavvxbBUmfRJG32boBnlj1iP4tM0Qg/JAmvchXWsqL5Ii9AcVBluYmGFZU6Zj7oJcg==
X-Received: by 2002:a17:906:a017:: with SMTP id
 p23mr44269235ejy.460.1620910995957; 
 Thu, 13 May 2021 06:03:15 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id h4sm2157154edv.97.2021.05.13.06.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 06:03:15 -0700 (PDT)
Date: Thu, 13 May 2021 15:03:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 13/19] virtio/vsock: rest of SOCK_SEQPACKET support
Message-ID: <CAGxU2F5M8rMCTAoQLnEorwtnmJ14L3v9mJpywjAsUwUCtNCjDg@mail.gmail.com>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163558.3432246-1-arseny.krasnov@kaspersky.com>
 <20210513122708.mwooglzkhv7du7jo@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210513122708.mwooglzkhv7du7jo@steredhat>
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

sdf

On Thu, May 13, 2021 at 2:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Sat, May 08, 2021 at 07:35:54PM +0300, Arseny Krasnov wrote:
> >This adds rest of logic for SEQPACKET:
> >1) Send SHUTDOWN on socket close for SEQPACKET type.
> >2) Set SEQPACKET packet type during send.
> >3) 'seqpacket_allow' flag to virtio transport.
>
> Please update this commit message, point 3 is not included anymore in
> this patch, right?
>
> >4) Set 'VIRTIO_VSOCK_SEQ_EOR' bit in flags for last
> >   packet of message.
> >
> >Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> >---
> > v8 -> v9:
> > 1) Use cpu_to_le32() to set VIRTIO_VSOCK_SEQ_EOR.
> >
> > include/linux/virtio_vsock.h            |  4 ++++
> > net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++--
> > 2 files changed, 19 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >index 02acf6e9ae04..7360ab7ea0af 100644
> >--- a/include/linux/virtio_vsock.h
> >+++ b/include/linux/virtio_vsock.h
> >@@ -80,6 +80,10 @@ virtio_transport_dgram_dequeue(struct vsock_sock *vsk,
> >                              struct msghdr *msg,
> >                              size_t len, int flags);
> >
> >+int
> >+virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
> >+                                 struct msghdr *msg,
> >+                                 size_t len);
> > ssize_t
> > virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> >                                  struct msghdr *msg,
> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >index 7fea0a2192f7..b6608b4ac7c2 100644
> >--- a/net/vmw_vsock/virtio_transport_common.c
> >+++ b/net/vmw_vsock/virtio_transport_common.c
> >@@ -74,6 +74,10 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
> >               err = memcpy_from_msg(pkt->buf, info->msg, len);
> >               if (err)
> >                       goto out;
> >+
> >+              if (info->msg->msg_iter.count == 0)
>
> Also here is better `msg_data_left(info->msg)`
>
> >+                      pkt->hdr.flags = cpu_to_le32(info->flags |
> >+                                              VIRTIO_VSOCK_SEQ_EOR);
>
> Re-thinking an alternative could be to set EOR here...
>
>                         info->flags |= VIRTIO_VSOCK_SEQ_EOR;

Or just `pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR)`, as you 
did in vhost-vsock :-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
