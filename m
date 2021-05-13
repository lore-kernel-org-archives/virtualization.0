Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922E2C433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEB561154
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 14:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEB561154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D56940F52;
	Thu, 13 May 2021 14:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1n3eUPv09sqI; Thu, 13 May 2021 14:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id F359F40408;
	Thu, 13 May 2021 14:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4481C000E;
	Thu, 13 May 2021 14:01:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F773C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D504400D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4xNpGx4-o8Ck
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B56DC400C4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620914516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzzbRMtR/ux/HKuN2b3P0GhQTxIlq9su8CHUI1jg3KU=;
 b=SiQOYK/MO0LdSgxD7UJuu8x2ECv0tT5oWCkX+0PVldL3e8qzVmUMnLoKTE33t7t2xzzhmj
 LEqGqkp23MGDcelovfZrMV//aYb6vUGvjbRung5hktboDzesJeKMDsWhYONwNouBVLy4yL
 AAK4i8lPncT0UWEMVYgKkCFE+QX1cBQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-sUQNVSLSNVGjG60IazBaoQ-1; Thu, 13 May 2021 10:01:55 -0400
X-MC-Unique: sUQNVSLSNVGjG60IazBaoQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 h18-20020a05640250d2b029038cc3938914so3012178edb.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 07:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dzzbRMtR/ux/HKuN2b3P0GhQTxIlq9su8CHUI1jg3KU=;
 b=EeUK0lV41u69EuHY1K3Nb8cQqxcgo9V6D/C3iyKMLRdRJ1UpyCOVK4067cs1L9Es+t
 lfQiFU4VRGX/RtZpS9YUj/+WtLID4Elva8qwpABIIJnznQzbtUb1Irkks1mFNPijPKoy
 /oRW9C4+ExaNFUems8itd3ypPYHmnEzKU4jHWOj/JKr9OdN0i5WaMjYOkojvyWEf+GE1
 CyYEQLFHCwiXnMuYTX/P/t1OlR3V/h8z4RFiBhfhcv/Ft3szdIGnMSgy3LAo5AX8oMGx
 tb9R0w9RF9IfFzE4PIZMrtVwnur79K87DAa0Q1SEqei1Ar/4imC/c/HOAbQkOALrvQJo
 V3EA==
X-Gm-Message-State: AOAM5338ZmxJPc0p519GtnpCCq7d1jn1uheBr2glE6fk+86YN1HgGBiA
 v5IPeQoc8Hsiu9SdwAjkJIFyfRmcVcJyLYAoL1Fa66Yf7VxGeAuNdl4Pt3ssxwSNMuswacJUZ2A
 eGAxThjDr76xXW3ifWiUAEW1I4HcaFloASQ8uuQqycA==
X-Received: by 2002:a17:906:dc8:: with SMTP id
 p8mr43396593eji.75.1620914513343; 
 Thu, 13 May 2021 07:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw39IWhXvW7OgV46gQBGVCcCQQk3NNZ/aEpvFouiESvkXXJwhBo18CCtS6V20sKwwrVlEsIFQ==
X-Received: by 2002:a17:906:dc8:: with SMTP id
 p8mr43396565eji.75.1620914513141; 
 Thu, 13 May 2021 07:01:53 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id x7sm1820591ejc.116.2021.05.13.07.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 07:01:52 -0700 (PDT)
Date: Thu, 13 May 2021 16:01:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210513140150.ugw6foy742fxan4w@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, May 08, 2021 at 07:37:35PM +0300, Arseny Krasnov wrote:
>This add logic, that serializes write access to single socket
>by multiple threads. It is implemented be adding field with TID
>of current writer. When writer tries to send something, it checks
>that field is -1(free), else it sleep in the same way as waiting
>for free space at peers' side.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 10 +++++++++-
> 2 files changed, 10 insertions(+), 1 deletion(-)

I think you forgot to move this patch at the beginning of the series.
It's important because in this way we can backport to stable branches 
easily.

About the implementation, can't we just add a mutex that we hold until 
we have sent all the payload?

I need to check other implementations like TCP.

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 1747c0b564ef..413343f18e99 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -69,6 +69,7 @@ struct vsock_sock {
> 	u64 buffer_size;
> 	u64 buffer_min_size;
> 	u64 buffer_max_size;
>+	pid_t tid_owner;
>
> 	/* Private to transport. */
> 	void *trans;
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7790728465f4..1fb4a1860f6d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -757,6 +757,7 @@ static struct sock *__vsock_create(struct net *net,
> 	vsk->peer_shutdown = 0;
> 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
> 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
>+	vsk->tid_owner = -1;
>
> 	psk = parent ? vsock_sk(parent) : NULL;
> 	if (parent) {
>@@ -1765,7 +1766,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		ssize_t written;
>
> 		add_wait_queue(sk_sleep(sk), &wait);
>-		while (vsock_stream_has_space(vsk) == 0 &&
>+		while ((vsock_stream_has_space(vsk) == 0 ||
>+			(vsk->tid_owner != current->pid &&
>+			 vsk->tid_owner != -1)) &&
> 		       sk->sk_err == 0 &&
> 		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
> 		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
>@@ -1796,6 +1799,8 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				goto out_err;
> 			}
> 		}
>+
>+		vsk->tid_owner = current->pid;
> 		remove_wait_queue(sk_sleep(sk), &wait);
>
> 		/* These checks occur both as part of and after the loop
>@@ -1852,7 +1857,10 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	vsk->tid_owner = -1;
> 	release_sock(sk);
>+	sk->sk_write_space(sk);
>+

Is this change related? Can you explain in the commit message why it is 
needed?

> 	return err;
> }
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
