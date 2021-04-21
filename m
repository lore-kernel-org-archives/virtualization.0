Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C655FC43460
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DD061448
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DD061448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEDE240620;
	Wed, 21 Apr 2021 09:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w9T1eqnVemjx; Wed, 21 Apr 2021 09:34:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 275BA405B6;
	Wed, 21 Apr 2021 09:34:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083B9C000F;
	Wed, 21 Apr 2021 09:34:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B34B4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADF5840284
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:34:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMNecD1KTfRW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:34:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E58C440279
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618997656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lpoI9NRVB9qsYiKBOjY+ZdCUBK0VWmcEa3eQmAnrZgM=;
 b=cDVBcaLC8ZBR3d4ON+n63+Vo4FbTXSXtkkwIc4hwOP3BAMO9U3sVYLHTfNTa9MdJs8a27p
 wtgaDtVkRsNrpTvYpHxgldpik6KbaLuV+G7pDPXMRhERX+2u2bDfbVTdrNeJHmXbZJnspl
 Xzxc8eyOBVM8qpb2//lxhJAHaxH4gqM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-7MbmqSP_NP-14Vfl-tr3Aw-1; Wed, 21 Apr 2021 05:34:13 -0400
X-MC-Unique: 7MbmqSP_NP-14Vfl-tr3Aw-1
Received: by mail-ed1-f71.google.com with SMTP id
 l22-20020a0564021256b0290384ebfba68cso10859622edw.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lpoI9NRVB9qsYiKBOjY+ZdCUBK0VWmcEa3eQmAnrZgM=;
 b=JeVhk+swW6x4uzw9FNRpU3JksZnDegGgSzac3LwKpmwFVN99iuObMPJ1KD0eMA9OUY
 b3g7a6mvVOT3P9CM9Q5rj1loosqOrB3hLYp6dKaOGd1ixDvJdPNG3wC4UIwg4rdweeGQ
 Gvo01fMk+rM/KDQbrg9xnFK2BxXzHAWfoAXpEO7U4SVh5k12SG0iVb32OyUaKqIUn0gT
 ay3uOW34TkUIwDBPQoMUW6gNYQHA0CQZHr+TEdcA+HOsOeB1UeCnRYr0EhJdyOsBX64T
 N38E0W1k0C0j9gAPUzRDPoB4bFpw9wd3RBsTry+snrRvPmJE5AOmZWUgUw3+bLPxRnYQ
 8lGw==
X-Gm-Message-State: AOAM533jECT93GppGGjR6aIY94IVkkdHoId+sY6Ct6Syq2+ZpHo5AbIJ
 ngkRRe3mSXndB7AHnQ/XhZHie6O3A8ai7Um1wyzfhp8oygAtgZuPDDCHUD1nN/LS0QLX0u1z39C
 NYqGMqAhX52MjOqC0KyCYfo3vIjEd464uYRusrsZTLw==
X-Received: by 2002:a17:906:5a83:: with SMTP id
 l3mr16652037ejq.50.1618997651891; 
 Wed, 21 Apr 2021 02:34:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydZjMGm8LWfdlf7IEz5Kzgw+nZROXo4yoyEKgJ4CVcOLHoFG40yO1hYMeXrSjiHD1qHIw/Iw==
X-Received: by 2002:a17:906:5a83:: with SMTP id
 l3mr16652025ejq.50.1618997651755; 
 Wed, 21 Apr 2021 02:34:11 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id f19sm2606693edu.12.2021.04.21.02.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:34:11 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:34:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 16/19] vsock/loopback: enable SEQPACKET for
 transport
Message-ID: <20210421093409.latwryhd7scomdav@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124642.3406320-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124642.3406320-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Norbert Slusarek <nslusarek@gmx.net>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 13, 2021 at 03:46:39PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for loopback transport and 'seqpacket_allow()'
>callback.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/vsock_loopback.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a45f7ffca8c5..d38ffdbecc84 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -63,6 +63,8 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> 	return 0;
> }
>
>+static bool vsock_loopback_seqpacket_allow(void);
>+
> static struct virtio_transport loopback_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -89,6 +91,10 @@ static struct virtio_transport loopback_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = vsock_loopback_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -103,8 +109,14 @@ static struct virtio_transport loopback_transport = {
> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
>+	.seqpacket_allow = true
> };
>
>+static bool vsock_loopback_seqpacket_allow(void)
>+{
>+	return loopback_transport.seqpacket_allow;
>+}

here I think we could always return true, since we will remove 
`.seqpacket_allow` from struct virtio_transport.

>+
> static void vsock_loopback_work(struct work_struct *work)
> {
> 	struct vsock_loopback *vsock =
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
