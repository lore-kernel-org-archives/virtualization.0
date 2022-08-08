Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FCC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 07:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19A4B414C4;
	Mon,  8 Aug 2022 07:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19A4B414C4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXrpzcFN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fE0nvVAWd4S0; Mon,  8 Aug 2022 07:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5C0FA410E4;
	Mon,  8 Aug 2022 07:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C0FA410E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4121FC0032;
	Mon,  8 Aug 2022 07:56:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE27EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C87BD826AA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:56:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C87BD826AA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eXrpzcFN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tbS1CKRqLSdn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:56:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7135A82695
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7135A82695
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 07:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659945413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AufWZZEcgThI2xBgpMKruzYOgK1FWSrmvzjD3Nvo93Q=;
 b=eXrpzcFNeKJyXiMp/MNVkHl1qDSMsi6nmvvDa8TeGkCZfVN2KwfoEBeRuS9TG+vAuXeBAr
 xyXUacIJxHu854n1Q3WLMREY3GHLA2UoO9m88PIOi8AEmJBcFhH5fiDK4cz5WK2gZ00UEW
 I93HBcLngCm7Opp8p+6iY58BxK00gFM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-8hQj_DJuM6S-WkWWRnIaZw-1; Mon, 08 Aug 2022 03:56:50 -0400
X-MC-Unique: 8hQj_DJuM6S-WkWWRnIaZw-1
Received: by mail-qv1-f70.google.com with SMTP id
 cz12-20020a056214088c00b004763e7e7d81so4092515qvb.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 00:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=AufWZZEcgThI2xBgpMKruzYOgK1FWSrmvzjD3Nvo93Q=;
 b=BKz93HbwMAVzerQekB85VeHOxvB1t/K7GFDFE7Y6ZFU7h6J4rOc//nFlJ0ghTKl/Bl
 D4s05/9OYhdnL39y8kXVcv9SwDcNK3vdRQMUwa0/Yv7d8JRgF6FkyAb1R5s1AP1AbsjS
 SwdF6VRqkhHyc4RwPA0IthCZDfxHdekoMCBXna6mdscbLfj+5MnRF7I9uyppUmtPBO2O
 /H8PTD6pfo2tqAPeXa7KKUxqrSD3/UrH3edxS3FpSo0Vi4ieQRCmoSUeCwYw8yAiaqE7
 Q2o5pFKl8+qOcGXNb1VeUMyYauV8nbAPuPt6uKKPyoKSuD+3CqrXJaBZG6F79E2n7vKc
 tOig==
X-Gm-Message-State: ACgBeo0B/NLiERSelDw70QJpKgTIpJ2sRmKATYDsfUFltda7wfCjrbzC
 z7cDlnH16wsWqJgFrrMZU0dArrIVqC1SOkgPyykHgvHcuSb0mZVejGFR2Li5EK9CeHC29aZnEzc
 fT7bqW1QK7FfiL8jZ+EDJWisJYD2xg6+ZoS44LrJCFA==
X-Received: by 2002:a05:620a:2b8b:b0:6b9:43ca:4a6 with SMTP id
 dz11-20020a05620a2b8b00b006b943ca04a6mr3566711qkb.346.1659945409702; 
 Mon, 08 Aug 2022 00:56:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5AHQLL6/c6cBtSoanSesmnPrpZdXyxLWrWNaQRi8fOEBNqs018hbyfcdBhlapIkl42VoQl4w==
X-Received: by 2002:a05:620a:2b8b:b0:6b9:43ca:4a6 with SMTP id
 dz11-20020a05620a2b8b00b006b943ca04a6mr3566697qkb.346.1659945409523; 
 Mon, 08 Aug 2022 00:56:49 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 b16-20020a05622a021000b0031eddc83560sm7421933qtx.90.2022.08.08.00.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 00:56:48 -0700 (PDT)
Date: Mon, 8 Aug 2022 09:56:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peilin Ye <yepeilin.cs@gmail.com>
Subject: Re: [PATCH net v2 2/2] vsock: Set socket state back to
 SS_UNCONNECTED in vsock_connect_timeout()
Message-ID: <20220808075640.5it462iozqgecxih@sgarzare-redhat>
References: <a02c6e7e3135473d254ac97abc603d963ba8f716.1659862577.git.peilin.ye@bytedance.com>
 <5cf1337b4f6e82bc0a4eb0bef422a53dcc9d584a.1659862577.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <5cf1337b4f6e82bc0a4eb0bef422a53dcc9d584a.1659862577.git.peilin.ye@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Peilin Ye <peilin.ye@bytedance.com>, "David S. Miller" <davem@davemloft.net>,
 George Zhang <georgezhang@vmware.com>
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

On Sun, Aug 07, 2022 at 02:00:46AM -0700, Peilin Ye wrote:
>From: Peilin Ye <peilin.ye@bytedance.com>
>
>Imagine two non-blocking vsock_connect() requests on the same socket.
>The first request schedules @connect_work, and after it times out,
>vsock_connect_timeout() sets *sock* state back to TCP_CLOSE, but keeps
>*socket* state as SS_CONNECTING.
>
>Later, the second request returns -EALREADY, meaning the socket "already
>has a pending connection in progress", even if the first request has
>already timed out.
>
>As suggested by Stefano, fix it by setting *socket* state back to
>SS_UNCONNECTED, so that the second request will return -ETIMEDOUT.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
>---
>(new patch in v2)

Thanks for sending this :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
