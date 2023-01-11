Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C8C5479D
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 08:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BA534048E;
	Wed, 11 Jan 2023 08:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BA534048E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFZN1XwZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tY2ScjCWp0jS; Wed, 11 Jan 2023 08:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79AA5403E9;
	Wed, 11 Jan 2023 08:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79AA5403E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53DEFC0032;
	Wed, 11 Jan 2023 08:30:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7523C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B6F881FBC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B6F881FBC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFZN1XwZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXMgQhsWQJ5s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:30:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E5DF81FBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E5DF81FBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 08:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673425836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4mw9pfc+UQaXbGaY67GT+joOfvL7NA5BN3JPp+Zx/M=;
 b=jFZN1XwZH0ivpo8k8+Zp6Vzz49Rw/xDmJaVVQ3LoU4T3pkvPb7IpTFWjOerZ4Gm/ObkI6X
 5P35qjtJAQLMN1CmwguKL849+IJbwEafh/fcNS29yNKvPQPFFMaC04RmvfBGyCud5+20de
 30gllj63qD2uphxfvwXA0g0zhATTvtk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-Ox4DqvibMQSK9jnv4cvGRg-1; Wed, 11 Jan 2023 03:30:35 -0500
X-MC-Unique: Ox4DqvibMQSK9jnv4cvGRg-1
Received: by mail-qv1-f72.google.com with SMTP id
 lp10-20020a056214590a00b0053180ee70f1so8106401qvb.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 00:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4mw9pfc+UQaXbGaY67GT+joOfvL7NA5BN3JPp+Zx/M=;
 b=hhCbNwXnkauVUZSpuKkyqHSWIU78RSB1HyivYtOISjEnObsB6QZeHiQdHDQtr6K38V
 dpJRGUQLVhYXEOOh97hr9ZBKbntAzY7n9qWtLxEMME1QnLllqJ2EyNq2UrDfSt0UR8b/
 Wte0nJDd2ViGc9Rq01I0yRUFPNxUnaqEPun39j0XtBPS94S2qJRfHJRJ9FH8QUc23yLU
 ZxGrmA+s9QA/q8uPGdRjwgUjw1Dl0M1iMVx3p7FZA+QkYoZAe1qJSqFqsrXfGih77OpA
 XDjeiW5mzrdVoYyj9DHY0hjhaUv+2MRx89ElH8eE6n8QMmlSjtDUnWnTPfQKT3reSd+d
 +J4Q==
X-Gm-Message-State: AFqh2kpu2ROUg7V0cnE/qajL3gyODEhupUTHcZfxE/PpCnZxPzRZMFMl
 mt/n4P7GTs4SsWuWQcbXyaCXXe9kLqNCra7HSo9Y2wUFWPwRopNwkHL7zntO/bmpIIdEjKdK4R+
 9fYEKHZQ0fgZAsOo+tpbl3cvmDcV4bjhIBWZruw2zfw==
X-Received: by 2002:a05:622a:1e13:b0:3ab:b012:f173 with SMTP id
 br19-20020a05622a1e1300b003abb012f173mr52942408qtb.28.1673425835056; 
 Wed, 11 Jan 2023 00:30:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEk8vF6mc4Kf3RCImUwGjvS1uNUoaxaRyBiqLhtMpL5P+KvrQjkw/dFJf7NPNXlHYfzSbFgA==
X-Received: by 2002:a05:622a:1e13:b0:3ab:b012:f173 with SMTP id
 br19-20020a05622a1e1300b003abb012f173mr52942386qtb.28.1673425834804; 
 Wed, 11 Jan 2023 00:30:34 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-244.retail.telecomitalia.it.
 [79.46.200.244]) by smtp.gmail.com with ESMTPSA id
 fw13-20020a05622a4a8d00b003b1180f40d7sm94872qtb.40.2023.01.11.00.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jan 2023 00:30:34 -0800 (PST)
Date: Wed, 11 Jan 2023 09:30:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v7 4/4] test/vsock: vsock_perf utility
Message-ID: <20230111083029.yfcbkzohe5cr6u2k@sgarzare-redhat>
References: <67cd2d0a-1c58-baac-7b39-b8d4ea44f719@sberdevices.ru>
 <0a9464eb-ad31-426b-1f30-c19d77281308@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <0a9464eb-ad31-426b-1f30-c19d77281308@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
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

On Tue, Jan 10, 2023 at 10:18:32AM +0000, Arseniy Krasnov wrote:
>This adds utility to check vsock rx/tx performance.
>
>Usage as sender:
>./vsock_perf --sender <cid> --port <port> --bytes <bytes to send>
>Usage as receiver:
>./vsock_perf --port <port> --rcvlowat <SO_RCVLOWAT>
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/Makefile     |   3 +-
> tools/testing/vsock/README       |  34 +++
> tools/testing/vsock/vsock_perf.c | 427 +++++++++++++++++++++++++++++++
> 3 files changed, 463 insertions(+), 1 deletion(-)
> create mode 100644 tools/testing/vsock/vsock_perf.c

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
