Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1890C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F00F60A81;
	Fri, 10 Mar 2023 08:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F00F60A81
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2oGD4te
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1BlHoubvw1up; Fri, 10 Mar 2023 08:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94B686077D;
	Fri, 10 Mar 2023 08:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94B686077D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D044C0071;
	Fri, 10 Mar 2023 08:13:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95670C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68EFF60784
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68EFF60784
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpD3p_YArQDy
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3896B6077D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3896B6077D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678435979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4menN7fwfSLVDmAjbndF3FdL8Pr+ImxUGDY+Cq2WrmA=;
 b=L2oGD4teVcUJjlZjXgk3BaNkOaKOuMD9BV2A7dtsiEr7uAcgWE13S8BQ0xWayYE6FYEAzk
 6o0jaBlJtqC8AwO3PH20uTGtduPXmbdxI5hEKeGr8oz8pvQ9eQLl+85Fkb28OUXYfwwFDG
 29vRSTuR8rdoF14KGA1DmAF3ex8T2Sg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yja8lFAYPu-Mx7GdxVixsA-1; Fri, 10 Mar 2023 03:12:58 -0500
X-MC-Unique: yja8lFAYPu-Mx7GdxVixsA-1
Received: by mail-ed1-f71.google.com with SMTP id
 z14-20020a05640235ce00b004e07ddbc2f8so6553146edc.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678435977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4menN7fwfSLVDmAjbndF3FdL8Pr+ImxUGDY+Cq2WrmA=;
 b=LxmOxmZ7Dt0RGxB8T72q76iHprswNLl6oT3CFtQG2SrH4YsbXVQ09O8mhPo4qcgMY4
 e+tIRywf/7HU/xWuaISTfxXkMHPBmK4PhP3xbdbEHC0+r0JizHhBblataoQI5Cg2armU
 v3dPuAemOJW1OUSRrDclvPBUeQZebzCOG0fkwV+2+U9cxeUaAYehEsPOY8jGTn5y/N8u
 nEa/BvdZxfrzm5p5R8fBXbn7GfB3gG0fiGZe+HkRXR4FU4z2RfUeylVsbhPwQrefvUqn
 wXKJR+bngedQSfJZuPE4YbESkEz1zpcBV0/HoLkUxtZUY31vli4LmXt/ZGxLvxr8ploF
 a0og==
X-Gm-Message-State: AO0yUKVLPli1LoFe50OEz2dZUD9sWHLgPfZRoXG+DXNSsWIeG4IYBeHe
 ZiUJLwP4Sa+ng7Eth11QuZ3U4xDeesginpkZIvGgDiz3TOOGFvSNyyzBe1GK3L7n6QXiP5lRIdm
 pUhD83pnFp/+mWUoOUhPaC4y7zn5yOtJv/hYdxXN9sIJlj1Z7JA==
X-Received: by 2002:a17:907:1ca3:b0:8ea:2055:4f1b with SMTP id
 nb35-20020a1709071ca300b008ea20554f1bmr31288926ejc.24.1678435977134; 
 Fri, 10 Mar 2023 00:12:57 -0800 (PST)
X-Google-Smtp-Source: AK7set9YkJwiHxP4aW6TNkCCziNZnRVL+jdnwcjWTVNXib5hejJtrEAdZPhLFQQaAXoXDwDUZ0cEYQ==
X-Received: by 2002:aa7:d915:0:b0:4ad:7224:ce9d with SMTP id
 a21-20020aa7d915000000b004ad7224ce9dmr22232202edr.17.1678435597865; 
 Fri, 10 Mar 2023 00:06:37 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 o25-20020a1709061b1900b008dceec0fd4csm646195ejg.73.2023.03.10.00.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:06:37 -0800 (PST)
Date: Fri, 10 Mar 2023 03:06:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Message-ID: <20230310030624-mutt-send-email-mst@kernel.org>
References: <20230310053428.3376-1-feliu@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230310053428.3376-1-feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
> This patch series performs a clean up of the code in virtio_ring and
> virtio_pci, modifying it to conform with the Linux kernel coding style
> guidance [1]. The modifications ensure the code easy to read and
> understand. This small series does few short cleanups in the code.
> 
> Patch-1 Allow non power of 2 sizes for virtqueues
> Patch-2 Avoid using inline for small functions.
> Patch-3 Use const to annotate read-only pointer params.
> 
> [1]
> https://www.kernel.org/doc/html/v6.2-rc3/process/coding-style.html#the-inline-disease
> 
> All of the patches have been verified based on the kernel code
> commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

verified how?

> Feng Liu (3):
>   virtio_pci_modern: Allow non power of 2 sizes for virtqueues
>   virtio_ring: Avoid using inline for small functions
>   virtio_ring: Use const to annotate read-only pointer params
> 
>  drivers/virtio/virtio_pci_modern.c |  5 ----
>  drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
>  include/linux/virtio.h             | 14 ++++-----
>  3 files changed, 31 insertions(+), 36 deletions(-)
> 
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
