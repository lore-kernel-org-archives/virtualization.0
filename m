Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BE4C001B0
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 10:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D706C83FA8;
	Wed, 26 Jul 2023 10:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D706C83FA8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G+gp26ZL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pWh4aOOV4L9K; Wed, 26 Jul 2023 10:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D22583F64;
	Wed, 26 Jul 2023 10:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D22583F64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20AE4C0072;
	Wed, 26 Jul 2023 10:02:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECCBBC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 10:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9DD783FA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 10:02:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9DD783FA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUgZjBEUk8bP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 10:02:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71E8D83F64
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 10:02:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71E8D83F64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690365761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uDfW0dmn1wBVyEER/+9+5+Wl00jeHHLFDEF6erd932c=;
 b=G+gp26ZLTw8PFZJNH+MLmO5BSxPucbuWe0Pb5l+YI8AfnhyclHJ+U5AiKRBFS4PmuDBYgA
 6FHS9RXCr23UpoFW87rHjXfoId+Df6IOKMpHrE83YfavqevUC5Xnqsk5DbbwlNG7F5guCT
 aDFwoTHalLP8uRMsTERe/lnMrhBD+nI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-q0X9j1Y9OqGnN9-J160avA-1; Wed, 26 Jul 2023 06:02:40 -0400
X-MC-Unique: q0X9j1Y9OqGnN9-J160avA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-997d069a914so435247266b.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 03:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690365759; x=1690970559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDfW0dmn1wBVyEER/+9+5+Wl00jeHHLFDEF6erd932c=;
 b=e+P0Kb+yCkt2zPV1FB68jNWJkaxdsdsI8+OfZEbuXaYIRMu9m1ZmjKNcWbr82RaPP0
 8dde4UcAdYdFcZ1KaB4egdIfgJmvTsc9trysU8bygpRzI9oNuBSjLwgMYxPGUHt6kCtg
 42klnuDjsZ9Keb5QkDoExKFeKGfrs23i6ClcROOXu1Rcz5M9AL/ZE18YBTnRNt0vJnys
 wMK5rTwP5fxhCbYD0fpy0OWdpGL/owDxfdwfy4Mcglm21G/V/LW6xjBIYx13o+Faj+pT
 dJ3tcykL0AWyEO3BgVfv1cBAdgdwJNyX6vbSwP2CBL1Tmgifo2dJdm4uTaHUQnM5xmWD
 SqWA==
X-Gm-Message-State: ABy/qLYpojN4Laww5zU1o03Vfca38cAJoIa06hWKG6Af6e6kGOkYz6Bw
 3Hb0UpQbO6FmxQ0w52I8qO6HIWsBPB1PunG+rTQvHVfXBKFPIzv6gkHtgIU8vrYrzIh0jUItG23
 Ikh2QI/Gfvjz1fn/4RO2i2iMkgkzeh/+cQhx+UvL6vg==
X-Received: by 2002:a17:907:a056:b0:994:19:133b with SMTP id
 gz22-20020a170907a05600b009940019133bmr1122949ejc.14.1690365759246; 
 Wed, 26 Jul 2023 03:02:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBSi7S84npQ6k3cQ5CS4OeynkocAoq83S5js72Husbbhk2ptQBqCWgr4yvb/+hN+aI97TDLw==
X-Received: by 2002:a17:907:a056:b0:994:19:133b with SMTP id
 gz22-20020a170907a05600b009940019133bmr1122930ejc.14.1690365758856; 
 Wed, 26 Jul 2023 03:02:38 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a170906924b00b0098e34446464sm9349068ejx.25.2023.07.26.03.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 03:02:37 -0700 (PDT)
Date: Wed, 26 Jul 2023 06:02:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 0/4] virtio/vsock: some updates for MSG_PEEK
 flag
Message-ID: <20230726060150-mutt-send-email-mst@kernel.org>
References: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230725172912.1659970-1-AVKrasnov@sberdevices.ru>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jul 25, 2023 at 08:29:08PM +0300, Arseniy Krasnov wrote:
> Hello,
> 
> This patchset does several things around MSG_PEEK flag support. In
> general words it reworks MSG_PEEK test and adds support for this flag
> in SOCK_SEQPACKET logic. Here is per-patch description:
> 
> 1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>    1) I think there is no need of "safe" mode walk here as there is no
>       "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>       queue).
>    2) Nested while loop is removed: in case of MSG_PEEK we just walk
>       over skbs and copy data from each one. I guess this nested loop
>       even didn't behave as loop - it always executed just for single
>       iteration.
> 
> 2) This adds MSG_PEEK support for SOCK_SEQPACKET. It could be implemented
>    be reworking MSG_PEEK callback for SOCK_STREAM to support SOCK_SEQPACKET
>    also, but I think it will be more simple and clear from potential
>    bugs to implemented it as separate function thus not mixing logics
>    for both types of socket. So I've added it as dedicated function.
> 
> 3) This is reworked MSG_PEEK test for SOCK_STREAM. Previous version just
>    sent single byte, then tried to read it with MSG_PEEK flag, then read
>    it in normal way. New version is more complex: now sender uses buffer
>    instead of single byte and this buffer is initialized with random
>    values. Receiver tests several things:
>    1) Read empty socket with MSG_PEEK flag.
>    2) Read part of buffer with MSG_PEEK flag.
>    3) Read whole buffer with MSG_PEEK flag, then checks that it is same
>       as buffer from 2) (limited by size of buffer from 2) of course).
>    4) Read whole buffer without any flags, then checks that it is same
>       as buffer from 3).
> 
> 4) This is MSG_PEEK test for SOCK_SEQPACKET. It works in the same way
>    as for SOCK_STREAM, except it also checks combination of MSG_TRUNC
>    and MSG_PEEK.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Head is:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=a5a91f546444940f3d75e2edf3c53b4d235f0557
> 
> Link to v1:
> https://lore.kernel.org/netdev/20230618062451.79980-1-AVKrasnov@sberdevices.ru/
> Link to v2:
> https://lore.kernel.org/netdev/20230719192708.1775162-1-AVKrasnov@sberdevices.ru/
> 
> Changelog:
>  v1 -> v2:
>  * Patchset is rebased on the new HEAD of net-next.
>  * 0001: R-b tag added.
>  * 0003: check return value of 'send()' call. 
>  v2 -> v3:
>  * Patchset is rebased (and tested) on the new HEAD of net-next.
>  * 'RFC' tag is replaced with 'net-next'.
>  * Small refactoring in 0004:
>    '__test_msg_peek_client()' -> 'test_msg_peek_client()'.
>    '__test_msg_peek_server()' -> 'test_msg_peek_server()'.
> 
> Arseniy Krasnov (4):
>   virtio/vsock: rework MSG_PEEK for SOCK_STREAM
>   virtio/vsock: support MSG_PEEK for SOCK_SEQPACKET
>   vsock/test: rework MSG_PEEK test for SOCK_STREAM
>   vsock/test: MSG_PEEK test for SOCK_SEQPACKET
> 
>  net/vmw_vsock/virtio_transport_common.c | 104 +++++++++++++-----
>  tools/testing/vsock/vsock_test.c        | 136 ++++++++++++++++++++++--
>  2 files changed, 208 insertions(+), 32 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
