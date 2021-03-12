Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC5C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:04:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCB864F80
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCB864F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02B954ED22;
	Fri, 12 Mar 2021 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NNpNu6dPBnI; Fri, 12 Mar 2021 15:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 776204ECE7;
	Fri, 12 Mar 2021 15:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C9D5C000B;
	Fri, 12 Mar 2021 15:04:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27D4DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3683A83B24
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com header.b="eRRX6SOn";
 dkim=pass (1024-bit key) header.d=redhat.com header.b="PSGRc1nS"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPbvQIDAU7al
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:04:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E08968458F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615561283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dY5uAwZg117bNtRKEEBL+2LzAlswxrz2wq+X03tujc0=;
 b=eRRX6SOnNsa5AcJpu8G379SFL1I7BNbIL72HMw0hW0viPeEoVjO0tb9OOuzDC2Eaxz4baO
 guk0GzeesovP345+mlU16ZuZvDpykEWezL0ynycMZ9Z/FNr4M91YJDawGw9zjTw5IJRd41
 49o08R86ZhJSZEQFWXj4lM7QbGEjVRI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615561485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dY5uAwZg117bNtRKEEBL+2LzAlswxrz2wq+X03tujc0=;
 b=PSGRc1nSD7xuXt4nPNDkiKVB0xZiHmeaRgXl39hCuTbd4jjgFCqtLat1FTwujetsyEzNmh
 46+mIOkos0Q301XknB48cnlDNmpaoqUUcyZN+it7I5+LX9Iav5ZU3wqgglTeFQTanbrSjs
 OatJqE4DWez+eQx0n650kJe9GFQ0UKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Hvn8cUpsNFWkgL4epZsyeA-1; Fri, 12 Mar 2021 10:01:22 -0500
X-MC-Unique: Hvn8cUpsNFWkgL4epZsyeA-1
Received: by mail-wm1-f71.google.com with SMTP id a63so2141873wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dY5uAwZg117bNtRKEEBL+2LzAlswxrz2wq+X03tujc0=;
 b=JQTR5L/KHccdQBu2SY10e5ayBN7mXn4Wr8pkvj/aVCfES6690+yuE0gFc/09T3xntS
 Lyp4jBCWNjHrAu3AnKKyD1/N7sEXlj+wbnOAwksqtmcoTdlkffVL5hDvbdRR1HtMff4c
 w6eGykv3MDXgQkASyEUgukqymZDXZiaI0E3Wt2tlil0urEE+HXTPxxCXIb2nIiDzcS2Z
 rrij0h0Ia+QNQTRhEA0+UhBrZRg0mvp/ObSOn78Wksm2KZLMAxLCSZZp5MFlCLoHy4Qn
 BKPxThiVkSCWMWP/Y4L5Ohk/RFNKE6hoJ7tmiTstZohgp33CanjKsmGIeh4SuGwcjWuG
 GN9w==
X-Gm-Message-State: AOAM531tqxdL1C6oTHRRKTQmcDBK1jqL+cK+arf8GSUfJu02mUP6KyNi
 2At5+k5TXQToIZgWb3PWFBhT/X1O9nBuyt3cKNcSxlnMXZBSnf0PbCrFaGoA3UD4r2PAnYkhIEV
 Z7mFg1K5lvyMXfmmOKF5D8bPeTLVRHCQ9F7nnl/DC7Q==
X-Received: by 2002:a1c:195:: with SMTP id 143mr13139957wmb.81.1615561276145; 
 Fri, 12 Mar 2021 07:01:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwU/+j7YIHGGD7r2/oDTZXMPTuZH3Lx7EWKi5joHVZyKzFAUrs1mT0L3T9QcEyLqXmzz7K7Aw==
X-Received: by 2002:a1c:195:: with SMTP id 143mr13139730wmb.81.1615561274237; 
 Fri, 12 Mar 2021 07:01:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id c8sm691886wmb.34.2021.03.12.07.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:01:13 -0800 (PST)
Date: Fri, 12 Mar 2021 16:01:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 04/22] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210312150110.344tr3wgz5cwruzz@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307175948.3464885-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307175948.3464885-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 08:59:45PM +0300, Arseny Krasnov wrote:
>This adds receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there is a little bit difference:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  5 +++
> net/vmw_vsock/af_vsock.c | 95 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 99 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
