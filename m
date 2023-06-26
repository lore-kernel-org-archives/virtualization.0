Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF208EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86770607AA;
	Mon, 26 Jun 2023 16:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86770607AA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VoE+Za3q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMV6IU_Jn6Aj; Mon, 26 Jun 2023 16:30:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AC8860A71;
	Mon, 26 Jun 2023 16:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AC8860A71
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C447BC007A;
	Mon, 26 Jun 2023 16:30:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2288CC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDEBA60A71
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:30:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDEBA60A71
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4FSx4oTOgNM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:30:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C371C607AA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C371C607AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687797030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
 b=VoE+Za3qGSjQJ79leomd7ZMys4WXxKNx7d1nC/ImTd4bnYBn4AB/9fETSSzOv1+1zafYjU
 Ea82B9V64Gx05Bd9CzWmniSHkYbcDMG4iHHTELlc7/d6V/Cep2GwUVBZCltgG1w2gCdv14
 w0DiZlcHVcVIm9Rje2MulRfmS3I78+Q=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-f_KQj1hdOq-Fv5jXBgtVIg-1; Mon, 26 Jun 2023 12:30:29 -0400
X-MC-Unique: f_KQj1hdOq-Fv5jXBgtVIg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635e3871cf9so9963946d6.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687797028; x=1690389028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17WXujS/YadeWAnXnT2WRgIIGXFkn1Rmc4cmEtM2dPk=;
 b=Yh4h1+v7LrlTRH/HVPtUtvsBO+b0JNRRJMus5EYlXkp38+aHwrqJ3DPgNOexk7uxe9
 MaFbEY2dLkvIQh19uRMZLMXs5IdtopihBColNFkoKZcwlMl+BPzNtrGosEI4HUegpqMV
 V64pHolCQjNlS+cREGi7NzX4+zl8ZTOXnkyEwM7KPyz+Y84LyYGDFVPNy4oYiSvfQ44Q
 2hOoBCuMJDsPKwnemRCr37rOsnCPBwELZCOYg4u1Z/C4JFqc52ZWSGScRXNb3EuA3OBA
 0zmrJY195rM8xkCXZU674aPdjmA7ncXDE75zEJ7XDSZ+60e+j2PR2EYEeH8+ydJ7hSjy
 U9LQ==
X-Gm-Message-State: AC+VfDwZa2nhOsUINvsWeuucPxtlubFa1qbmeOoeSatjBIG3K3Qwo6LR
 ky0o10R0PzOpTDf9uDQoNLOhyoKFNUSm6JTMOhvnfpb9kX1x16wr+cLCChrnc7+u1rzx2PZnWgT
 HlrIiG8NpDliHgXRW5pGB/fUCULdBmT+YZn04PZbwgQ==
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id
 g5-20020a0562141cc500b0062de8a24d36mr34309506qvd.61.1687797028067; 
 Mon, 26 Jun 2023 09:30:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uBH00Gk/fKeQLrvD/GY47XvG7v3BCuca4UyzNoimZCXIfrb0LXztvOgJ/KifRuXdADW4Jbg==
X-Received: by 2002:a05:6214:1cc5:b0:62d:e8a2:4d36 with SMTP id
 g5-20020a0562141cc500b0062de8a24d36mr34309488qvd.61.1687797027844; 
 Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 nd14-20020a056214420e00b006215d0bdf37sm3351810qvb.16.2023.06.26.09.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:30:27 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:30:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/4] virtio/vsock: some updates for MSG_PEEK flag
Message-ID: <tmcj34lrgk7rxlnp4qvkpljwovowlz3wnosqboxssv6f6enr6u@qnf422n6lu6j>
References: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230618062451.79980-1-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Sun, Jun 18, 2023 at 09:24:47AM +0300, Arseniy Krasnov wrote:
>Hello,
>
>This patchset does several things around MSG_PEEK flag support. In
>general words it reworks MSG_PEEK test and adds support for this flag
>in SOCK_SEQPACKET logic. Here is per-patch description:
>
>1) This is cosmetic change for SOCK_STREAM implementation of MSG_PEEK:
>   1) I think there is no need of "safe" mode walk here as there is no
>      "unlink" of skbs inside loop (it is MSG_PEEK mode - we don't change
>      queue).
>   2) Nested while loop is removed: in case of MSG_PEEK we just walk
>      over skbs and copy data from each one. I guess this nested loop
>      even didn't behave as loop - it always executed just for single
>      iteration.
>
>2) This adds MSG_PEEK support for SOCK_SEQPACKET. It could be implemented
>   be reworking MSG_PEEK callback for SOCK_STREAM to support SOCK_SEQPACKET
>   also, but I think it will be more simple and clear from potential
>   bugs to implemented it as separate function thus not mixing logics
>   for both types of socket. So I've added it as dedicated function.
>
>3) This is reworked MSG_PEEK test for SOCK_STREAM. Previous version just
>   sent single byte, then tried to read it with MSG_PEEK flag, then read
>   it in normal way. New version is more complex: now sender uses buffer
>   instead of single byte and this buffer is initialized with random
>   values. Receiver tests several things:
>   1) Read empty socket with MSG_PEEK flag.
>   2) Read part of buffer with MSG_PEEK flag.
>   3) Read whole buffer with MSG_PEEK flag, then checks that it is same
>      as buffer from 2) (limited by size of buffer from 2) of course).
>   4) Read whole buffer without any flags, then checks that is is same
>      as buffer from 3).
>
>4) This is MSG_PEEK test for SOCK_SEQPACKET. It works in the same way
>   as for SOCK_STREAM, except it also checks combination of MSG_TRUNC
>   and MSG_PEEK.
>
>Head is:
>https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=d20dd0ea14072e8a90ff864b2c1603bd68920b4b

Nice cleanup, LGTM, but I'd like a comment from Bobby.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
