Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A0C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:38:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA9164F23
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 14:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA9164F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E17940180;
	Fri, 12 Mar 2021 14:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T911AxUv3gsq; Fri, 12 Mar 2021 14:38:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8B884017B;
	Fri, 12 Mar 2021 14:38:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE65C000A;
	Fri, 12 Mar 2021 14:38:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE9E3C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFCE284589
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_gpZxtLEIaO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:38:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A4BA84588
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615559891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqR2VXBD9ShzLCVtX+qqk63mSGBNYYonntBUYfSNkBU=;
 b=Mm60Bo2e9yTWVZ52pVV9uU01ukeFBadzn8StzfYHq/JOajRhK09MS4M6rPh7rrrhBau4Na
 BVLQWuagqmheopdTtuNQfhVqD6xyPfV4KNIUWvilTZfWYMdWFmUZisPuCFK93WDOj7i8/s
 heKmq5nwTajareOJOKrDH3oGvtQAr1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-wQGoRw39MrmEu9Ygg62TMA-1; Fri, 12 Mar 2021 09:38:07 -0500
X-MC-Unique: wQGoRw39MrmEu9Ygg62TMA-1
Received: by mail-wm1-f69.google.com with SMTP id y9so2121250wma.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 06:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wqR2VXBD9ShzLCVtX+qqk63mSGBNYYonntBUYfSNkBU=;
 b=q4hj+oNlld5vuGEyC6br5L8VYTosJs+M+7FZYBbUt4Z4Wgp1FC9Dw5DlgLMqYso1ay
 dtuv6hB8TjJqq2TxrR6ZD2Ot+2Jbkb49lQ9Yez4JOhI3WNbTcure4COqFAc/0ndhjSyz
 RhDzHab8suLMJhlKpXGrf/3FcZiHwHXPVAjfsjN8MI+uTowIOp3ajW38roy8ZiXEjnnn
 KTrci5Ws8Yfj8l++H27a8939RXfOUDOQK4hmLRJcAIHfd85d5mKndeTdG5iul+oFt7cW
 LxPVVXMSPthxCgsXN2GJJoAcfFvM4ya1AA3rmTlKU9NC5jb5S5egXAwJkQv5CNg0S3vs
 h2XA==
X-Gm-Message-State: AOAM532YrBC7QL4hOXeRN8zqjGG7IU1cgNsOIXP0Gp25Nmhw+muEMy8I
 jh2AEjGzFly9WrnOr70mg0t9zZ3WlhVVYWrfq4Mn9Z7OhTqUH9Sl+Z7EHNz24ch96j36nKOLj7l
 iYE4mfI042P7zswWY9DDq1813Altr26x6X60zR8d6CQ==
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr14234124wrb.52.1615559886546; 
 Fri, 12 Mar 2021 06:38:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCMOehTT6EynoUYujDmF8ZxV5JxPQ3Xa+h0M2h9lyxZbt2sDFpKhYb/X+GcurEHDbm83cQTA==
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr14234110wrb.52.1615559886374; 
 Fri, 12 Mar 2021 06:38:06 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id x11sm2760458wme.9.2021.03.12.06.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 06:38:05 -0800 (PST)
Date: Fri, 12 Mar 2021 15:38:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 01/22] af_vsock: update functions for connectible
 socket
Message-ID: <20210312143803.hcq4byotzx5x65j7@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307175843.3464468-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307175843.3464468-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 08:58:39PM +0300, Arseny Krasnov wrote:
>This prepares af_vsock.c for SEQPACKET support: some functions such
>as setsockopt(), getsockopt(), connect(), recvmsg(), sendmsg() are
>shared between both types of sockets, so rename them in general
>manner.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 64 +++++++++++++++++++++-------------------
> 1 file changed, 34 insertions(+), 30 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
