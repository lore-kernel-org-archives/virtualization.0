Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66C1C00144
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 06:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15E3D80C39;
	Thu,  4 Aug 2022 06:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15E3D80C39
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KvaJG2fM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZoV3S8-nNbX; Thu,  4 Aug 2022 06:59:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79B5080D8C;
	Thu,  4 Aug 2022 06:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79B5080D8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D965C0033;
	Thu,  4 Aug 2022 06:59:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E824C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1483160C03
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1483160C03
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KvaJG2fM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9YdW3PIJd3k
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:59:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D450260C02
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D450260C02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 06:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659596369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExEtxHMeVEdV8bG+hyv5znpbqanF/kL14mBYzm730MI=;
 b=KvaJG2fMx4mDJ0HUlkHDSpevIPET9ZFnaBd5b9N7Vt4VN3m0kQhB0ziQUiEkD6wJABkpuH
 x8iq42368YQaQzLcM0NaQPGeBgnqOu8Y8i2hDBRqqKtM/3Tog61wv+LpFcG3EVFCQY4URf
 GkYJvDUJPXNM8GibtKCRn4hqTYlX2WQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-6AoMGPMuM3KNOE-mcK4OvQ-1; Thu, 04 Aug 2022 02:59:28 -0400
X-MC-Unique: 6AoMGPMuM3KNOE-mcK4OvQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 w5-20020a05640234c500b0043dda025648so5715752edc.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Aug 2022 23:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=ExEtxHMeVEdV8bG+hyv5znpbqanF/kL14mBYzm730MI=;
 b=1JpTkgIna7lkHUdfHW2R5CbbBj16DZPCHPzoEqZ8yOBw5V03oFAnaXcSL6ph/X5Bt/
 D7NTZW/GaTZNY3wAjaXyAUmCVEzP8ucPihRaEIf89YZbOG4Tn2ssbZWUEb4xzdPmemGy
 q9mITchjhBop4ZMMyTyQr+Vi3bNcL/k4c7QDwtq9eSxGpug10d9OnHPIhSEKXxkMi7Bc
 Weasijl5G5m15KKeD6ZQKbFshWQJkA9GILQvcyaN+Mo9KzeD2f8yRfD7Gx9H7QB+f5P3
 1vSPr7vYM97mM2RZtO4QI/YMYiHhN2fhOWj86g5LvgYVg2NowR+9YjkXlB1oGGxqbbpT
 XrMA==
X-Gm-Message-State: ACgBeo2MfjZUAhMi0OOoDyCZroLe1JDOdn3E2d0g4fyZMKjN6YAxDuWG
 kFKKKJZuHR2aSIhI2GSKeD2XuzAAu13K8j8tSzOzzRdDSOX1WZwxjibeWpHsYHIcpxnjt5mwk9Q
 R9PAIVoHvwYk+iCcauKe6bPm5YAdlE8bBueHcYyXLDA==
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id
 l18-20020a170906795200b007306ab76655mr360573ejo.171.1659596367225; 
 Wed, 03 Aug 2022 23:59:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Ik1DuQerRmV01wlFYMNwdnqCD+oKxuFKA0C8LkP/PgPoBMCDxqmCixUtgsIrJfFVs/lJMKQ==
X-Received: by 2002:a17:906:7952:b0:730:6ab7:6655 with SMTP id
 l18-20020a170906795200b007306ab76655mr360560ejo.171.1659596366980; 
 Wed, 03 Aug 2022 23:59:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u1-20020a1709061da100b0072b2ffc662esm167ejh.156.2022.08.03.23.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Aug 2022 23:59:26 -0700 (PDT)
Date: Thu, 4 Aug 2022 08:59:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peilin Ye <yepeilin.cs@gmail.com>
Subject: Re: [PATCH RFC net-next] vsock: Reschedule connect_work for
 O_NONBLOCK connect() requests
Message-ID: <20220804065923.66bor7cyxwk2bwsf@sgarzare-redhat>
References: <20220804020925.32167-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220804020925.32167-1-yepeilin.cs@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peilin Ye <peilin.ye@bytedance.com>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Aug 03, 2022 at 07:09:25PM -0700, Peilin Ye wrote:
>From: Peilin Ye <peilin.ye@bytedance.com>
>
>An O_NONBLOCK vsock_connect() request may try to reschedule
>@connect_work.  Consider the following vsock_connect() requests:
>
>  1. The 1st, non-blocking request schedules @connect_work, which will
>     expire after, say, 200 jiffies.  Socket state is now SS_CONNECTING;
>
>  2. Later, the 2nd, blocking request gets interrupted by a signal after
>     5 jiffies while waiting for the connection to be established.
>     Socket state is back to SS_UNCONNECTED, and @connect_work will
>     expire after 100 jiffies;
>
>  3. Now, the 3rd, non-blocking request tries to schedule @connect_work
>     again, but @connect_work has already been scheduled, and will
>     expire in, say, 50 jiffies.
>
>In this scenario, currently this 3rd request simply decreases the sock
>reference count and returns.  Instead, let it reschedules @connect_work
>and resets the timeout back to @connect_timeout.
>
>Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>---
>Hi all,
>
>This patch is RFC because it bases on Stefano's WIP fix [1] for a bug 
>[2]
>reported by syzbot, and it won't apply on current net-next.  I think it
>solves a separate issue.

Nice, this is better!

Feel free to include my patch in this (inclunding also the Fixes tag and 
maybe senidng to syzbot and including its tag as well).

The last thing I was trying to figure out before sending the patch was 
whether to set sock->state = SS_UNCONNECTED in vsock_connect_timeout(). 

I think we should do that, otherwise a subsequent to connect() with 
O_NONBLOCK set would keep returning -EALREADY, even though the timeout 
has expired.

What do you think?

I don't think it changes anything for the bug raised by sysbot, so it 
could be a separate patch.

Thanks,
Stefano

>
>Please advise, thanks!
>Peilin Ye
>
>[1] https://gitlab.com/sgarzarella/linux/-/commit/2d0f0b9cbbb30d58fdcbca7c1a857fd8f3110d61
>[2] https://syzkaller.appspot.com/bug?id=cd9103dc63346d26acbbdbf5c6ba9bd74e48c860
>
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 194d22291d8b..417e4ad17c03 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1395,7 +1395,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			/* If the timeout function is already scheduled, ungrab
> 			 * the socket refcount to not leave it unbalanced.
> 			 */
>-			if (!schedule_delayed_work(&vsk->connect_work, timeout))
>+			if (mod_delayed_work(system_wq, &vsk->connect_work, timeout))
> 				sock_put(sk);
>
> 			/* Skip ahead to preserve error code set above. */
>-- 
>2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
