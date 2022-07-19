Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BE1C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 12:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66D6940A06;
	Tue, 19 Jul 2022 12:44:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66D6940A06
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lsr2t1Mh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ylLg7r2M7RlY; Tue, 19 Jul 2022 12:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8AB7B409E6;
	Tue, 19 Jul 2022 12:44:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8AB7B409E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64667C0033;
	Tue, 19 Jul 2022 12:44:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07F7DC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D472A60671
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D472A60671
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lsr2t1Mh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cLuRcsO-vQIp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C31C60597
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C31C60597
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658234680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwoURb29VClO3NnOpfstDR3d53hCEYhJJWEs1w35jSE=;
 b=Lsr2t1MhPK7rsygzSoiCs7YiMfQrlv/MmxOOLM/xtwVHHJIlvzkaXUIGJqIFKJaApNkfeQ
 HvC1OMWj4v0bKQxuOAP8u3PNKclzWfS27LdHEIsSyuoUaP5R7m84NaeebAE4hjdFX679pJ
 0yx/MkKj+H6AeLMl7tpLJ/WYx9mdc9c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-prGcd4YUNRurKy5MSmttTg-1; Tue, 19 Jul 2022 08:44:38 -0400
X-MC-Unique: prGcd4YUNRurKy5MSmttTg-1
Received: by mail-qv1-f72.google.com with SMTP id
 eb3-20020ad44e43000000b00472e7d52ce6so7326911qvb.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nwoURb29VClO3NnOpfstDR3d53hCEYhJJWEs1w35jSE=;
 b=HKeWkRp3aX6fyZTePyQDQ+BPslAZPSYeTq5Av9FIcCNBh8UDVpNsM030onHL3PBBSH
 GDnNHtEbOZpLFUbsbzCKDitC3at/BTuuhqkKs/LF6H5sDkIjyYEu8PBPKGh8//+RZSnR
 JCqaRZu+WtchrFje0fwENlhGZbjx2PW5c4Y/QRdnxiokeR3ghoTQQChOuI1ZdjDhmRxG
 yAIbMdcnRnxqx1BsDJxglY26JrrDHS3CnQQZD8/m/eiCnfTCL53AbvrGzWRRIx9NPUvS
 hTntxvdReBQu2yGBAeEAH3Y7x4/snJWchCzY7HxF8rem/pEsPIu4qgHZZU/cg7RR5L7a
 csGA==
X-Gm-Message-State: AJIora8JNid2NwBLFqJkb7Ha/N8+QO480iEWkBLDsXlwuP8dWax96s0u
 8wfD1wg3vUD5QhGk002+57PGxRSO62E5WHq3K9omIh31lNqALJWlgTO9TVbblYGu5zewuPygwFN
 MQ5MZ2PWMp2f73i0rXWv1UWKzPYUaduvw9m8RIWizRA==
X-Received: by 2002:a05:620a:4409:b0:6b5:9563:2357 with SMTP id
 v9-20020a05620a440900b006b595632357mr20517121qkp.394.1658234678311; 
 Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vfYt5xMGWnPHxRK79lORLDfPCOEjuG06J02WcZOiurWkTLl4+3VDRo/4HLmjvxNof1xrPgsQ==
X-Received: by 2002:a05:620a:4409:b0:6b5:9563:2357 with SMTP id
 v9-20020a05620a440900b006b595632357mr20517108qkp.394.1658234678086; 
 Tue, 19 Jul 2022 05:44:38 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 t13-20020a37ea0d000000b006af147d4876sm13363159qkj.30.2022.07.19.05.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 05:44:37 -0700 (PDT)
Date: Tue, 19 Jul 2022 14:44:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/3] vsock: use sk_skrcvlowat to set
 POLLIN,POLLRDNORM, bits.
Message-ID: <20220719124429.3y5hi7itx4hdkqbz@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
 <637e945f-f28a-86d9-a242-1f4be85d9840@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <637e945f-f28a-86d9-a242-1f4be85d9840@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 18, 2022 at 08:15:42AM +0000, Arseniy Krasnov wrote:
>Both bits indicate, that next data read call won't be blocked,
>but when sk_rcvlowat is not 1,these bits will be set by poll
>anyway,thus when user tries to dequeue data, it will wait until
>sk_rcvlowat bytes of data will be available.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..0225f3558e30 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1067,7 +1067,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		    !(sk->sk_shutdown & RCV_SHUTDOWN)) {
> 			bool data_ready_now = false;
> 			int ret = transport->notify_poll_in(
>-					vsk, 1, &data_ready_now);
>+					vsk, sk->sk_rcvlowat, &data_ready_now);

In tcp_poll() we have the following:
     int target = sock_rcvlowat(sk, 0, INT_MAX);

Maybe we can do the same here.

Thanks,
Stefano

> 			if (ret < 0) {
> 				mask |= EPOLLERR;
> 			} else {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
