Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2317C433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 08:30:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E256124D
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 08:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46E256124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B2C880D5C;
	Mon,  8 Nov 2021 08:30:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u906r-AIHQqi; Mon,  8 Nov 2021 08:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CE7FF80D22;
	Mon,  8 Nov 2021 08:30:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1960C0019;
	Mon,  8 Nov 2021 08:30:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E96EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D50460786
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agk-hT_3mqM1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:30:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAD9B6077A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636360221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dZ2Q+DY5lRLHrC4/deim612KwtYNG+pVAfJvd8a6ths=;
 b=CLW87/cstShZbw/9dToNGc+hOQqoOYiNfwXildMQHEWsBnvFXVXNo7cxvL9hSz84ivQYs9
 HH08i5dVQ/v8gKvWP0oxcmh91+MhHTnCOB8Da2t8VdSczLtJIMIHmiqQ5h2hCysmfliYeF
 MINwYAfzFCPWhQbUJ6REgRE/e5TSmLU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-yycBkNCaO_itRrFpph9v0w-1; Mon, 08 Nov 2021 03:30:18 -0500
X-MC-Unique: yycBkNCaO_itRrFpph9v0w-1
Received: by mail-ed1-f72.google.com with SMTP id
 y20-20020a056402359400b003e28c9bc02cso14275346edc.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 00:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dZ2Q+DY5lRLHrC4/deim612KwtYNG+pVAfJvd8a6ths=;
 b=5FmlpFswxCrJxYJ6kx2bSCmHCUv+762XZZr8j4YS5kQ051NrA9wFdXf83DhtrCXFTI
 NTEbDB1QR5iuKS0h1PUlGV/d7WS7U8Xk0HnMGEH/GmHZk2rkDTlHTJJIOCFw0iNhk6/Z
 e9z9yohjG7sKntHBqF719gIOXZTfAXOLihXJwJvxntQsky7XdVZkdc7Pq0ikUK9FpFWd
 a0tkGcHm+aj8yWc/z1cSfEk0n8RSkeio6SbhIErfXhmJkMiBnDhZ/QcCuFbiDr4J3rfn
 YUhOq+fcrZC5C5n7GoRoArZnWFq27ZnUmzjNjljrivZAGtBHUrUoXy2gzC9w+xM5M2KC
 ZeWg==
X-Gm-Message-State: AOAM533obM5qPbQgMW4EPnduXHf4SuKSQgCGKbGZg6UTiA8k/TU0WKDp
 W61S9jXjBUu4B7pwNN7r1F4i/XwaKDq/F6Gnhs5TcvaPVam6w1wcynsv9Enxiv3oEdA38f9rmwO
 cHrXD1dkKpE0HQvtb+PbcV9qUc7Wp5E3tGN5txf9oFQ==
X-Received: by 2002:a17:906:11c5:: with SMTP id
 o5mr91025531eja.42.1636360216944; 
 Mon, 08 Nov 2021 00:30:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx55rmukR33/BtWzxQ4veIc0curLmXRJTSzYxLwdm7CCry7Yxjy1ZS8/OpXpMRCM02Ir5v9qQ==
X-Received: by 2002:a17:906:11c5:: with SMTP id
 o5mr91025508eja.42.1636360216758; 
 Mon, 08 Nov 2021 00:30:16 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id s26sm9112853edq.6.2021.11.08.00.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 00:30:16 -0800 (PST)
Date: Mon, 8 Nov 2021 09:30:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Subject: Re: [PATCH net] vsock: prevent unnecessary refcnt inc for
 nonblocking connect
Message-ID: <20211108083013.svl77coopyryngfl@steredhat>
References: <20211107120304.38224-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20211107120304.38224-1-eiichi.tsukata@nutanix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, Nov 07, 2021 at 12:03:04PM +0000, Eiichi Tsukata wrote:
>Currently vosck_connect() increments sock refcount for nonblocking
>socket each time it's called, which can lead to memory leak if
>it's called multiple times because connect timeout function decrements
>sock refcount only once.
>
>Fixes it by making vsock_connect() return -EALREADY immediately when
>sock state is already SS_CONNECTING.
>
>Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>---
> net/vmw_vsock/af_vsock.c | 2 ++
> 1 file changed, 2 insertions(+)

Make sense to me, thanks for fixing this issue!
I think would be better to add the Fixes ref in the commit message:

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

With that:
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
