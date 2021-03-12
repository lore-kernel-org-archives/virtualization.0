Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30C7C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:28:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B69864FAB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B69864FAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FCBB6FAD1;
	Fri, 12 Mar 2021 15:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHFe6aLWtFyT; Fri, 12 Mar 2021 15:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0037B60682;
	Fri, 12 Mar 2021 15:28:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDBC9C000B;
	Fri, 12 Mar 2021 15:28:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F11C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 792C943035
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F_95-GhRVDzn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:28:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B76C04017B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615562917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKPy1yb09Ec6cKP/VPrLjTlUwinW20mVG1mfvMCm7HE=;
 b=KREKELFTH/UeB1sy+k58A4PvCYH7zkAPfXeBtYSAEXQbvjNA4HGjBBGKnx4vyVKd04p3Z5
 Gu6UXK+vzHrNJZEKAQl/11P2pwBMNwjAkztxp3tgdkSZb2QrRfgnYAFOjSC1DIWEtoQGOS
 xDNWEpmDL34SyaJPV4P9t1lQzltU9Tk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VD4XzRfqNSGEHxTvQrJdMA-1; Fri, 12 Mar 2021 10:28:35 -0500
X-MC-Unique: VD4XzRfqNSGEHxTvQrJdMA-1
Received: by mail-wm1-f69.google.com with SMTP id n25so5500503wmk.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xKPy1yb09Ec6cKP/VPrLjTlUwinW20mVG1mfvMCm7HE=;
 b=S8zl0OlEJKEda5s/ji1ekqjyz62IgT5xZhipsaZjvoaV+vNVJ7rwR8SZxANpeaUyD6
 RmM/9yNcp0m4u0sBRr/jHwBlIQMwjNo+wCbyLq7jdxgBpgd8ngJOr4THYpJOV5xngyhO
 jHC+so99B7UHmYbX/tW+39SzCOIVVNuRYPLiqJjovM4tcMUaLotuP7w5AKoh/XE9XcEj
 khPPPBqCR5IbQG6Rm1PozjWccRhPzCW5ZcBUBJH65/ExZZlpq/tbmd82hLBVCN2ADENQ
 I4TyRPT/PZqFLpj1drdKBA1GTmUza2KNJwOq0TBn03qtPbgcKJrMFLRwhuFdh0h/F6r9
 Cxpg==
X-Gm-Message-State: AOAM532Xh9ka1uNyKoQk0pPpvvtQAL3vZQpOMwZMBmdRnllR9Gn7H0lo
 pVNt/EyiFxPoLNbyzWd1Dv6k8y9hN3AsaEKOvTqkRoaTkDOGCfH5qnYXL3AQysOLI35D3xMOoqs
 8wOezE/p5jToMeXEm7g6fRb/2YEAQnjMvUFV4E9IrgQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr14224659wru.78.1615562914638; 
 Fri, 12 Mar 2021 07:28:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSyMjIqtO+O1pkI/8s/85VaB5c4FEE2zwfH7noDtmrtsh2lsPEfFCvmwaYBZB8Js/rymbJRQ==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr14224645wru.78.1615562914451; 
 Fri, 12 Mar 2021 07:28:34 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id p17sm2337705wmd.42.2021.03.12.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:28:34 -0800 (PST)
Date: Fri, 12 Mar 2021 16:28:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 07/22] af_vsock: rest of SEQPACKET support
Message-ID: <20210312152831.f37oxryffuohai3r@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180050.3465297-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180050.3465297-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 09:00:47PM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  1 +
> net/vmw_vsock/af_vsock.c | 36 +++++++++++++++++++++++++++++++++++-
> 2 files changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
