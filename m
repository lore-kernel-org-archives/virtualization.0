Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0BC43334
	for <virtualization@archiver.kernel.org>; Fri,  8 Jul 2022 03:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDB3041176;
	Fri,  8 Jul 2022 03:14:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDB3041176
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jm3zIBno
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uAt9215LwIch; Fri,  8 Jul 2022 03:14:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6E2B04010C;
	Fri,  8 Jul 2022 03:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E2B04010C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42573C0033;
	Fri,  8 Jul 2022 03:14:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0AB2C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B5C4840D2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:14:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B5C4840D2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jm3zIBno
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G98MXcvJFZdl
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:14:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFBB18408F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFBB18408F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jul 2022 03:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657250067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6pWJ9vidmXiESXTHRmiFlc+OMg3mXWEt42MkWbaRXFo=;
 b=Jm3zIBnoc6Kh3fSpf9GBnJab6AdKruWc9l8tHqQ9H3EswhpAEx0KkZM6LsO+x7kEJ0EgLw
 RV00vflmtOvoG/k/XkL3D00UsUA7j3Ss4+4dmMV1q3CIjqbuB0fw7PKyI+TkAYJOt4Ji+o
 PXSqhW2JshH6JY1D5eycE3JLsENemKg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-Wy2rP8zfNm-fsu7t8PHUhg-1; Thu, 07 Jul 2022 23:14:26 -0400
X-MC-Unique: Wy2rP8zfNm-fsu7t8PHUhg-1
Received: by mail-lf1-f71.google.com with SMTP id
 bp15-20020a056512158f00b0047f603e5f92so7204229lfb.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Jul 2022 20:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6pWJ9vidmXiESXTHRmiFlc+OMg3mXWEt42MkWbaRXFo=;
 b=w1rtnH3LY39rIY+xShmTTlmjpYV3hcYmUvezOSR5succTb5lhJopwq4GaoZZeNRo7R
 +Cu2dKqcY/qwlYs+ulltFAhpXA/BN+w7DlnpuhKM8W7T+4weCNwRZ5MIJ8/dwq/lJ7Bu
 AyyxR0p3v1+mCGG8idCQU6SshB3nYoySO9at7tgf3Trfob8mMxr4Y1vmonlivjXX1D75
 qxmOB/1xk5BuyzB8ddwGoJOTqAehvhtRumH+c1mqMYZVKuwi1FujWQn9GjVwMcmLnb8D
 8cW05HxcGPlDTMgFSxg3GdzOCxLdtjT6Lui0Ls6oBmw0am3nai9NGIxJvunvtjZXr20x
 T0ZA==
X-Gm-Message-State: AJIora+tb59iF1zFRKinKm7FP9ljd8OLb8qi4Wvjp/mou/O5tN4GOqCt
 2xpWMkpDaSrtUzfXXzEqzein0R1hjLNalKuGc7sAL/J3R+PHnDT6WLrISddPSFDJuaBxQFALHxE
 7q5ZZS9MoO05VVrWQ3hW6rLrdbBPBge2FEJ/Fvh2Jyjs0NfC6P4dGcNqCmA==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr864063lfu.442.1657250064634; 
 Thu, 07 Jul 2022 20:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sL5nNaKVUjLfzqmHqBuyERNjefQaJM/fNkZA4syaavKMsdSCdlbxtRU8opv07Qp1KDTOFhmmsBKmEyTtATiQ0=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr864054lfu.442.1657250064363; Thu, 07
 Jul 2022 20:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <548e316fa282ce513fabb991a4c4d92258062eb5.1654688822.git.robin.murphy@arm.com>
In-Reply-To: <548e316fa282ce513fabb991a4c4d92258062eb5.1654688822.git.robin.murphy@arm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Jul 2022 11:14:13 +0800
Message-ID: <CACGkMEvkHKqOkTCEaTUHK4Ve=naeU5p09BpnvPW-y1cGqOTo_w@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Use device_iommu_capable()
To: Robin Murphy <robin.murphy@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 mst <mst@redhat.com>
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

On Wed, Jun 8, 2022 at 7:53 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Use the new interface to check the capability for our device
> specifically.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 935a1d0ddb97..4cfebcc24a03 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1074,7 +1074,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>         if (!bus)
>                 return -EFAULT;
>
> -       if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> +       if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
>                 return -ENOTSUPP;
>
>         v->domain = iommu_domain_alloc(bus);
> --
> 2.36.1.dirty
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
