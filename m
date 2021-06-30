Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7FAC11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:11:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED45619A1
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 12:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED45619A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05FC183AE6;
	Wed, 30 Jun 2021 12:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UAqWeQbMfUg; Wed, 30 Jun 2021 12:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A2A5183AD6;
	Wed, 30 Jun 2021 12:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77C84C001A;
	Wed, 30 Jun 2021 12:10:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15EF5C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04FEF83AD9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L0B8CSYu1qqY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:10:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3B5C83AD6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625055051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fPmSNjorX8tf2eCOIhHKnRjZ2avWw2QnQ177mXZw2z8=;
 b=E8wr54vge4tJRZbeWQKQ5kp6nARyeXAfLEwabPO6/fYxI07LWH8Dew4dVqgaxJ2RaeKgF2
 ry1CURIDFwYiDpABDe6ty1ILaW06W27Tng/C+V5G69tDvFOkP1Sa9LCWOOhyVPatFDckbZ
 CKCvDTg8eXoO9z2U1xgtjE2+pDGqxM0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-rON9hUi_Nl6kZFXxAfBDOw-1; Wed, 30 Jun 2021 08:10:48 -0400
X-MC-Unique: rON9hUi_Nl6kZFXxAfBDOw-1
Received: by mail-ed1-f72.google.com with SMTP id
 n13-20020a05640206cdb029039589a2a771so1046067edy.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 05:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fPmSNjorX8tf2eCOIhHKnRjZ2avWw2QnQ177mXZw2z8=;
 b=FGZEyTd5rYeV8LAfY5xf9jMH0J8OSLqJ2peIm7DHQ7BlUery2gSTDDTM7+0LRnKiGa
 gXFIIc8NSqGHTjmDE6Ytw9sfo53hyGXzE7NR6TEnojvFd+CF9ROp681nOAvynZUmqoIe
 E2UkbnW+Z9hLzLPHCyjz6/BHckjPetVcFGl9nvK4yDq4qlkCRx9H9KM5IALc4QrU7zt3
 uQ/kaM7vN/ywHP8uwOm1Ugjnteu/A+qf42q+OlK10Lc8Q5nRoVWpektGRekvPaj/Ru1Q
 p9iQXfHQzd+99wyBK1Z7UEpGAyKk0L9LBKeDsCI8IefrdxJq5xmsooNqzJSUU/lioWVm
 tBcQ==
X-Gm-Message-State: AOAM5316FHi0OGuc0/7tbaW31WDD//ze1HthpvSrPcA6if+Ai4rdENtt
 Cc1cblA7Irc9jjTYwnlMbMtjT66oi0P5l4k5xz7zLKzmdam2bq95N8ZVZoEYR4N7h4730FLhr5o
 P27A+k6LOHwfxoJfq+oOxZG8rITMuW9hsqhS1luG83g==
X-Received: by 2002:a17:906:3a53:: with SMTP id
 a19mr20641903ejf.88.1625055046853; 
 Wed, 30 Jun 2021 05:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo3BecDCYPDPNSBAsV0lGMAxuPsG5my6j1jlO1OzMo1m4o9qrQKj6ON3wbX0lfltMQbD4JSw==
X-Received: by 2002:a17:906:3a53:: with SMTP id
 a19mr20641875ejf.88.1625055046551; 
 Wed, 30 Jun 2021 05:10:46 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id v5sm947889edy.50.2021.06.30.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jun 2021 05:10:46 -0700 (PDT)
Date: Wed, 30 Jun 2021 14:10:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v1 05/16] af_vsock: use SOCK_STREAM function to check
 data
Message-ID: <CAGxU2F6owSKJWEkYSTBGy+yrVhp1tcjDmC+gwj9NAJzddMrFkQ@mail.gmail.com>
References: <20210628095959.569772-1-arseny.krasnov@kaspersky.com>
 <20210628100250.570726-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210628100250.570726-1-arseny.krasnov@kaspersky.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Jun 28, 2021 at 01:02:47PM +0300, Arseny Krasnov wrote:
>Also remove 'seqpacket_has_data' callback from transport.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 -
> net/vmw_vsock/af_vsock.c | 12 +-----------
> 2 files changed, 1 insertion(+), 12 deletions(-)

In order to avoid issues while bisecting the kernel, we should have
commit that doesn't break the build or the runtime, so please take this
in mind also for other commits.

For example here we removed the seqpacket_has_data callbacks assignment
before to remove where we use the callback, with a potential fault at
runtime.

I think you can simply put patches from 1 to 5 together in a single
patch.

In addition, we should move these changes after we don't need
vsock_connectible_has_data() anymore, for example, where we replace the
receive loop logic.

Thanks,
Stefano

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index ab207677e0a8..bf5ea1873e6f 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -141,7 +141,6 @@ struct vsock_transport {
>       int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
>                                size_t len);
>       bool (*seqpacket_allow)(u32 remote_cid);
>-      u32 (*seqpacket_has_data)(struct vsock_sock *vsk);
>
>       /* Notification. */
>       int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 21ccf450e249..59ce35da2e5b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -860,16 +860,6 @@ s64 vsock_stream_has_data(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>
>-static s64 vsock_connectible_has_data(struct vsock_sock *vsk)
>-{
>-      struct sock *sk = sk_vsock(vsk);
>-
>-      if (sk->sk_type == SOCK_SEQPACKET)
>-              return vsk->transport->seqpacket_has_data(vsk);
>-      else
>-              return vsock_stream_has_data(vsk);
>-}
>-
> s64 vsock_stream_has_space(struct vsock_sock *vsk)
> {
>       return vsk->transport->stream_has_space(vsk);
>@@ -1881,7 +1871,7 @@ static int vsock_connectible_wait_data(struct
>sock *sk,
>       err = 0;
>       transport = vsk->transport;
>
>-      while ((data = vsock_connectible_has_data(vsk)) == 0) {
>+      while ((data = vsock_stream_has_data(vsk)) == 0) {
>               prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);
>
>               if (sk->sk_err != 0 ||
>-- 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
