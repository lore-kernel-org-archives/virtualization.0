Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4E0C433F5
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 02:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FFFD82C2E;
	Thu,  9 Dec 2021 02:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0J81PakUjLM9; Thu,  9 Dec 2021 02:12:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CF6C82BEB;
	Thu,  9 Dec 2021 02:12:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C81C001E;
	Thu,  9 Dec 2021 02:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12193C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F37346074C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zBKhdK2liasV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D186606F9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 02:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639015973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEWVgWgffKxw4U2CvNG/Nz2R6p0InYBLy3bcY3R6wRg=;
 b=VAmx8YfYdFIoJkzi3E+aXeE+4Fkhvb2lUno+Nb4GNTpwcF9pHAXrM5xFP0EZxiFRNyQAfx
 Mpn/yvOy/86pvGsrucTCLCOzTiJwAo18ff+wmDrKaJEqQZ3UL8+L63X6Fy9bVLzE64gDio
 D+OpufV6sYjWqjU20Qt1VC5wadeqLyI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-FOQ3FtciO3KTc5WtpO9skg-1; Wed, 08 Dec 2021 21:12:52 -0500
X-MC-Unique: FOQ3FtciO3KTc5WtpO9skg-1
Received: by mail-lj1-f199.google.com with SMTP id
 n6-20020a2e82c6000000b00221698ffa68so1217532ljh.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 18:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MEWVgWgffKxw4U2CvNG/Nz2R6p0InYBLy3bcY3R6wRg=;
 b=ehbZ0eJwb+2e94vY18FMUW9dhhQtkt0RlqTwXhQ+fevQ5VDdtRNavskqUilB7i+cW4
 QfqMmbbzf31FUJ860G0S1MnmZ21au/5Cpubc/aOM3BY1kd1Erd6AqvYfXKkeokc/pFTq
 /RvrKApvz7CqquuaPqOhxj3nOB2L5fCGAXFkRpPT3FyGMU+d3S22RHvxh845pWJPs9Gj
 JaAUOCyjt+SWyPILRlahlCqUxoMg6eH2cdk1TtIs6eIhfFdI1I2CprMGooFhHi63IroV
 Uu4vcubUxZ2QBTeYLr4/dXdk0A95k/VHq3C3p9uEH+pT3Imu8A0sLz9wYHH2+eXDXe4l
 j2Yw==
X-Gm-Message-State: AOAM530jIA5M5apW1GZJm614vHQS1LUfZVy+mR2WpNwRvh8zN+soBwvK
 MrFi1bQ/bnRASF09EJlvg9GTe/7TUj27CPpsVPRLSwL07qruBYC2+s62+iJpeX5nWsW5O06aOq3
 9t3x/WdOt7qc23NKNZ5TG/G/AoJfW/PY0uRUZrEAPvUc/IhAD9WyrEkMbNA==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3180198lfe.84.1639015970586; 
 Wed, 08 Dec 2021 18:12:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWSd19fYzNfzF0iKgDq8dz6O3KSiopO1bKJF9lx/YJwa4HcsU1ukxk7ZBqxihKr9YzOp/zGv6WN1NjNiAR38o=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr3180178lfe.84.1639015970369; 
 Wed, 08 Dec 2021 18:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20211208103307.GA3778@kili> <20211208103337.GA4047@kili>
In-Reply-To: <20211208103337.GA4047@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 10:12:39 +0800
Message-ID: <CACGkMEtp+29Y4zcUppakRmQLqKbkUfFN-dm6a70bvn9GUCrWRA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] vdpa: check that offsets are within bounds
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Tiwei Bie <tiwei.bie@intel.com>, kvm <kvm@vger.kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>
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

On Wed, Dec 8, 2021 at 6:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> In this function "c->off" is a u32 and "size" is a long.  On 64bit systems
> if "c->off" is greater than "size" then "size - c->off" is a negative and
> we always return -E2BIG.  But on 32bit systems the subtraction is type
> promoted to a high positive u32 value and basically any "c->len" is
> accepted.
>
> Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> Reported-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v4: split into a separate patch
>
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 29cced1cd277..e3c4f059b21a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -197,7 +197,7 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>         struct vdpa_device *vdpa = v->vdpa;
>         long size = vdpa->config->get_config_size(vdpa);
>
> -       if (c->len == 0)
> +       if (c->len == 0 || c->off > size)
>                 return -EINVAL;
>
>         if (c->len > size - c->off)
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
