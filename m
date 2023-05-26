Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00E9C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 10:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4475D42CBC;
	Fri, 26 May 2023 10:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4475D42CBC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PR3/v2wy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xcuHG9uxXazR; Fri, 26 May 2023 10:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1E4540136;
	Fri, 26 May 2023 10:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1E4540136
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E5AC0036;
	Fri, 26 May 2023 10:30:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44B70C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B5DC8382F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B5DC8382F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PR3/v2wy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nT6p807Np_LU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:30:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13715837AC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13715837AC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685097017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mg7/ojhaSlvyz/vXgtSMO2mGG83UKNLR01zwLceFGek=;
 b=PR3/v2wyPlKZZo07PDZ1HdjsbN6PI8ECQzOHpW0Z+EhRZ+LKP0BUc78v+EPOdJqHs+uVsp
 Spx5HdYtbIQ/YrdPXE4yZKnYhn2rpTy9yAyST5bpki19niORtia/skv+RbD6N8i+hiBA/o
 pkNTnuqEEfz0gvafR2sBq+eJKb+bsBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-HGRBsODjNLWYNHmx5ryKcQ-1; Fri, 26 May 2023 06:30:16 -0400
X-MC-Unique: HGRBsODjNLWYNHmx5ryKcQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso4002055e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 03:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685097015; x=1687689015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mg7/ojhaSlvyz/vXgtSMO2mGG83UKNLR01zwLceFGek=;
 b=JBEU0O/lvzoDR7R1UKjOHe+BlogwjweejtxiWW0SgVJ0FndLeydXPCWkpbiqpNQMfj
 iSls3LUVt8v0pIa/F2uXlH++EuM0oglwgbPWKacnuseRYjHqIXrPL0CtD5EIzsWEZ34C
 Rc5ErjE8UY6EY15z8BuDdZOtObz/ge6JjmjXgmvFA05jhNYc+Wii2iOlfUa/cTmvsXos
 pUtf1CfFgb2uMyptfSx0AcLbwgj4jG7x4aiJlN5YZOpST1KHyGVJ/ZAjID2gJFQrwp9W
 au854UAmYMDPneoY6W/FF9Y+V7dc1rPypEuA4N0xhg6pOj6UtWSLEM8ehGWdcwge4MUS
 PREg==
X-Gm-Message-State: AC+VfDzYz6lsmOw5uT7YMqGuIPOua694TLwRFrKrhJ2IS20cJhenWWQU
 YSUy7sgbnsTzF9V9twMAauku2EjgyVD26ysJzxd8tLNkR+9oLHiyK43RJD76vzQz6nKRbeMYYLl
 vm4UPZcX55W5IRi4OjlPS61h3dnCYDHqgH1Nrq1xGlw==
X-Received: by 2002:a05:600c:3b13:b0:3f6:f81:385e with SMTP id
 m19-20020a05600c3b1300b003f60f81385emr4386164wms.17.1685097015598; 
 Fri, 26 May 2023 03:30:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7azWOTs7u22NKP+c/72YjQZNnbnYXTsbR5Iqy6Gxd/0ppYvVT8VSjnd/KLYwpjJ1ml7uASbg==
X-Received: by 2002:a05:600c:3b13:b0:3f6:f81:385e with SMTP id
 m19-20020a05600c3b1300b003f60f81385emr4386137wms.17.1685097015327; 
 Fri, 26 May 2023 03:30:15 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f4f89bc48dsm8530412wml.15.2023.05.26.03.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 03:30:14 -0700 (PDT)
Date: Fri, 26 May 2023 12:30:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 00/17] vsock: MSG_ZEROCOPY flag support
Message-ID: <y5tgyj5awrd4hvlrsxsvrern6pd2sby2mdtskah2qp5hemmo2a@72nhcpilg7v2>
References: <20230522073950.3574171-1-AVKrasnov@sberdevices.ru>
 <76270fab-8af7-7597-9193-64cb553a543e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <76270fab-8af7-7597-9193-64cb553a543e@sberdevices.ru>
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

On Thu, May 25, 2023 at 06:56:42PM +0300, Arseniy Krasnov wrote:
>
>
>On 22.05.2023 10:39, Arseniy Krasnov wrote:
>
>This patchset is unstable with SOCK_SEQPACKET. I'll fix it.

Thanks for let us know!

I'm thinking if we should start split this series in two, because it
becomes too big.

But let keep this for RFC, we can decide later. An idea is to send
the first 7 patches with a preparation series, and the next ones with a
second series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
