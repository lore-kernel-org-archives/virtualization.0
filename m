Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EDAC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:13:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DFF61997
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DFF61997
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E15094066A;
	Wed, 30 Jun 2021 12:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WoauKXcOGGGp; Wed, 30 Jun 2021 12:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC2A340671;
	Wed, 30 Jun 2021 12:12:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 861D9C001A;
	Wed, 30 Jun 2021 12:12:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DE7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32B1B82E29
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LGc6BYeoXEfG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:12:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06C1882410
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625055173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N2yOcyFYV5CPN+IR8aqJYBNH6snD2VpY0jfF5xnCwA=;
 b=HKrRxoPN1kQXddDBiHgYDeo24+X8Zd9lBy2nzUhhHTnwRyfe/IWfH3rDm1pKwVYenxm4dP
 vY7zzNKLygJ1bh6Dl1rMZGhH68gPhPMgTR1F2wSRcKu26h2RQ0prH00wmXy/F9gH2PBULI
 Xrn2e0We6Oy3FLsFQ+CaviPsH5+FuLc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-1nTcsFLIPoaQjZty32tdTA-1; Wed, 30 Jun 2021 08:12:51 -0400
X-MC-Unique: 1nTcsFLIPoaQjZty32tdTA-1
Received: by mail-ed1-f72.google.com with SMTP id
 y17-20020a0564023591b02903951740fab5so1032187edc.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 05:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0N2yOcyFYV5CPN+IR8aqJYBNH6snD2VpY0jfF5xnCwA=;
 b=YzKP+p8zOL4yuRYS4d7/wD2eFaWZ0nyUHMRJehhs9qxLVJwonhsY2f7/zHdTjfPruJ
 5QPtYG71p+YMPwavFoR88ssygMYi4wQIEyFz5w7g+yGGGwg7Pa4bZlTURmeOBR+fALGj
 wQ2CbqsiaHT4Jq4OI/qBXd3dJTSvuwhHRXi6wgbvMiGEaNNZXbhgqY2n/7XD6ORMpr/c
 nkcgeJwy/A+soNCLyEzWZ2gr1tvdRrLGDe7jrEt/TzNfg1MVg743jcT/zXVt0lZqmSNA
 zWQmFDzNIJPtxuTydoo9FDleDkAg33in5/fWrIAeuul7Rpp7s1ZYdHKdmd2XhGoyHgoq
 EQCg==
X-Gm-Message-State: AOAM531wMnbjT+LklOi+wZwp5MYULFuouc4LcMuU/+uyG+wWTXwXYJSa
 hQ1mBkkWAURWYLdu4aYuiUhQO7yC2bLfGG+I8gStEBZIz9ySjHQloZe6sFJqxuIOzcUqKewBlWg
 hAgLICQmGOhS+OiHuLknTYAf9OrhTQHDPoqbGCH457A==
X-Received: by 2002:a17:906:3755:: with SMTP id
 e21mr35502844ejc.0.1625055170500; 
 Wed, 30 Jun 2021 05:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyQieQzL13kfgrAiQdC+xnDKI6+4gnyVHQvGrs/WltryrEMaxVn3e2E8N8jeK6pEWm6l6rvQ==
X-Received: by 2002:a17:906:3755:: with SMTP id
 e21mr35502827ejc.0.1625055170336; 
 Wed, 30 Jun 2021 05:12:50 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id e17sm897093ejz.83.2021.06.30.05.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 05:12:49 -0700 (PDT)
Date: Wed, 30 Jun 2021 14:12:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 11/16] afvsock: add 'seqpacket_drop()'
Message-ID: <CAGxU2F4mX5khjA+a_LQEfZYg1rjEmccXce-ab0DVyEJEX-kYcw@mail.gmail.com>
References: <20210628095959.569772-1-arseny.krasnov@kaspersky.com>
 <20210628100415.571391-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210628100415.571391-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 28, 2021 at 01:04:12PM +0300, Arseny Krasnov wrote:
>Add special callback for SEQPACKET socket which is called when
>we need to drop current in-progress record: part of record was
>copied successfully, reader wait rest of record, but signal
>interrupts it and reader leaves it's loop, leaving packets of
>current record still in queue. So to avoid copy of "orphaned"
>record, we tell transport to drop every packet until EOR will
>be found.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   | 1 +
> net/vmw_vsock/af_vsock.c | 1 +
> 2 files changed, 2 insertions(+)

And also for this change, I think you can merge with patches 12, 13, 14, 
15, otherwise if we bisect and we build at this patch, the 
seqpacket_drop pointer is not valid.

Thanks,
Stefano

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 1747c0b564ef..356878aabbd4 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -141,6 +141,7 @@ struct vsock_transport {
>       int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
>                                size_t len);
>       bool (*seqpacket_allow)(u32 remote_cid);
>+      void (*seqpacket_drop)(struct vsock_sock *vsk);
>
>       /* Notification. */
>       int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ec54e4222cbf..27fa38090e13 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2024,6 +2024,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>               intr_err = vsock_connectible_wait_data(sk, &wait, timeout, NULL, 0);
>               if (intr_err <= 0) {
>                       err = intr_err;
>+                      transport->seqpacket_drop(vsk);
>                       break;
>               }
>
>--
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
