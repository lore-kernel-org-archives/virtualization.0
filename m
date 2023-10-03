Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DAFE7AD76
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 16:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2049822C5;
	Tue,  3 Oct 2023 16:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2049822C5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FK2ehec1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RAX7XIBjcT-7; Tue,  3 Oct 2023 16:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24AC4822C7;
	Tue,  3 Oct 2023 16:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24AC4822C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB62AC0071;
	Tue,  3 Oct 2023 16:23:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26B50C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8B164052A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:22:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8B164052A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FK2ehec1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kj21ecttSx8F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:22:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3589440182
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:22:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3589440182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696350178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r147ix/t4ru4DZEC+DJrb4DBuvtWEoQLF9djs4ZSusI=;
 b=FK2ehec1A43sOvGpAHObG4mRRRskgWIIuTm0o2WFLRlMuedcWFeaj1D15NPB8BQLo6Ib9S
 mj/xLEC9dlPim5hp1tZ5yFi6gAfST+oPC2ev003iL4Dm0K3SHvXC9t9cqsOr9P6cWp2ibn
 nfi8lFkyFMQv6K/hqQC7iPc7L2z7B7g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-XqZWx26dMUOB6Ct66iHOcA-1; Tue, 03 Oct 2023 12:22:46 -0400
X-MC-Unique: XqZWx26dMUOB6Ct66iHOcA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65afd7515aaso12340316d6.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 09:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350166; x=1696954966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r147ix/t4ru4DZEC+DJrb4DBuvtWEoQLF9djs4ZSusI=;
 b=WzeuXP9ab4gOhX9m8HSm3TRMASGbdAREfLMW2bWd/USxuDtd7T75IYZmfg1QGZeSg3
 PbWZ6WUocZ0bTTR8NBiKILd5L0FcvJW5N1/BWwNFcl0JnvElqnl/hD15ESzkVxfZUKlO
 YeKHFwgI3Ygx+Uz6K4smqVBZ1JUitAAMhZcO4/InKyePua+AmBQCJV3XeMh67TyiOVLM
 x4r/eqXcQrBVdR2b+maLToZSCgKC0zPw0TUIrUxlGYMRCfiwamdNxK/Sgx5nEzfCeCAj
 rCVv2ugCluWAYJ3QwLmGeqlZQaGjNraeAJ4zepHW2STtCnfC+5I2SVAEdCOCtOhPwn1z
 sEDQ==
X-Gm-Message-State: AOJu0Yw01j4vxOAAYlBwGLAdB/PXrAYy9OIqb0MCc112NvNHvo2/gB44
 OlCPzxXgjpJ2rfMKN/nU2OQeibYGsX958Ctx6MoULsTw0ZEIOCQbBDT+FaVSPJsbnhtrgD7p7RT
 F+a2266x0HL40gDxV7JXEfbeRgLZrXynhGdLeXE5OpA==
X-Received: by 2002:a05:6214:488d:b0:64f:51fe:859c with SMTP id
 pc13-20020a056214488d00b0064f51fe859cmr17355781qvb.43.1696350165794; 
 Tue, 03 Oct 2023 09:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqvM306M50A2rjJC5L4OkATm7mDAd1KWNSEosWc5K4oFW+hSL2rCEcu1U+nylxnoxNFfNg/Q==
X-Received: by 2002:a05:6214:488d:b0:64f:51fe:859c with SMTP id
 pc13-20020a056214488d00b0064f51fe859cmr17355759qvb.43.1696350165512; 
 Tue, 03 Oct 2023 09:22:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 a21-20020a0ca995000000b0063d162a8b8bsm612637qvb.19.2023.10.03.09.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:22:44 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:22:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 01/12] vsock: set EPOLLERR on non-empty error
 queue
Message-ID: <qylubfxwihribskuw25sc6rvvjv7rz2loz6h6sdea464hzpq36@5gdhsu363gnx>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-2-avkrasnov@salutedevices.com>
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

On Sun, Oct 01, 2023 at 12:02:57AM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>Currently for AF_VSOCK this is actual only with MSG_ZEROCOPY, as this
>feature is the only user of an error queue of the socket.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'fix' word.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 013b65241b65..d841f4de33b0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 	poll_wait(file, sk_sleep(sk), wait);
> 	mask = 0;
>
>-	if (sk->sk_err)
>+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
