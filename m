Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D53C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 13:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87FD840CA4;
	Thu, 16 Feb 2023 13:40:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87FD840CA4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eu6sf+9u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eGUduD0bFG_Y; Thu, 16 Feb 2023 13:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F082240339;
	Thu, 16 Feb 2023 13:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F082240339
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCED2C0033;
	Thu, 16 Feb 2023 13:40:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B6E2C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED28F82044
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:40:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED28F82044
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eu6sf+9u
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z9JzxLGurcNF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:40:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 448DB8203C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 448DB8203C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676554846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y98TLzC7T3MjlRAfco0hk5x9PJvmulya2RupI5c7FMk=;
 b=eu6sf+9ulluL7PPyS9xUmzmMaQiKjWuigF0RfzhMm3p/FX+xAEay1UcDdiDgt6RFjJOMGe
 ONRpS5jm9gIxj6lHCtE9DRRzA3e/si3X4ZLMMJtC8+qciM4T1aGL0MRGT5H/xQWoxgzNtG
 R3I+NSCGdETpOvH3OyigIZloVfh9DZo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-bixbhn9ZN6ig7Aq0bBgjdw-1; Thu, 16 Feb 2023 08:40:44 -0500
X-MC-Unique: bixbhn9ZN6ig7Aq0bBgjdw-1
Received: by mail-qt1-f198.google.com with SMTP id
 z12-20020ac8710c000000b003b829a0eda2so1196466qto.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y98TLzC7T3MjlRAfco0hk5x9PJvmulya2RupI5c7FMk=;
 b=N/rYMeAJ0IlYREJB6DAnAg4wCyH26OW4F1X5WC89s0T0P6wK8zPeA3do+VXH2XpolE
 TG+gQea1GRSUqtbGEOTnzOeTBl6a643lOe7VDHqlHkzGeIC96Vn0mi+XOe7lF+hAtNnG
 PHt0uNXQ+gOtHkdt0HQ15W627APDvkq5VbUCpffrBmI7bLXZUYK9Ma09MEDW+pV2pwc9
 PmE+Oa3LbYI3nkaBgy2qt5IUza4ly/k62vUPamIi2Zklk556/J5vFoFUcHJ0UBADTFrV
 +0NlaDwRjOc32BaySAMnZnZ91U66Z4q1mVseoyz4u7fxnrnzfaZGhQlRXixkgP+PS1Oq
 7KCQ==
X-Gm-Message-State: AO0yUKX4pbw/3jm1ar7mYrWhPF74DG9SfZpdB2u6n3S1y2vSkMqvt755
 DiWg6HABhL6bwqVcIDprkp5bm8jjtYE5dKQJHvpHc/Cf7lv+Gm1m5JuSMJHyTReGFl3p/ARy3ff
 9+cZnrZ6iQqd3My5AyBlNTifcusmObajLr9kF6VZpzQ==
X-Received: by 2002:ac8:5c8a:0:b0:3b6:36a0:adbe with SMTP id
 r10-20020ac85c8a000000b003b636a0adbemr9858806qta.6.1676554844470; 
 Thu, 16 Feb 2023 05:40:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+u2XfrViYGYBUOAnQ+C6klosItAnWhnmgPEyZDck8HDSLvs4kyoFZDdTEvpoeeeF5P7hlYrA==
X-Received: by 2002:ac8:5c8a:0:b0:3b6:36a0:adbe with SMTP id
 r10-20020ac85c8a000000b003b636a0adbemr9858769qta.6.1676554844177; 
 Thu, 16 Feb 2023 05:40:44 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 z143-20020a376595000000b0073ba211e765sm228285qkb.19.2023.02.16.05.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 05:40:43 -0800 (PST)
Date: Thu, 16 Feb 2023 14:40:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 01/12] vsock: check error queue to set EPOLLERR
Message-ID: <20230216134039.rgnb2hnzgme2ve76@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <17a276d3-1112-3431-2a33-c17f3da67470@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <17a276d3-1112-3431-2a33-c17f3da67470@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 06, 2023 at 06:53:22AM +0000, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set.

Could this patch go regardless of this series?

Can you explain (even in the commit message) what happens without this
patch?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 19aea7cba26e..b5e51ef4a74c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1026,7 +1026,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
