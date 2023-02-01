Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C653C38142
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 16:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7EA86100F;
	Wed,  1 Feb 2023 16:11:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E7EA86100F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw7t1bra
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5MLb6zr2IN7z; Wed,  1 Feb 2023 16:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8100860E4A;
	Wed,  1 Feb 2023 16:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8100860E4A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56515C0033;
	Wed,  1 Feb 2023 16:11:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B81E5C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C43A60FFA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C43A60FFA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c5D9EhQZAT-C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:11:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8EAA60E4A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B8EAA60E4A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675267893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCNzhgbsT7harPHDgUVLPlkp85+yy8d8grMTrA+fNpY=;
 b=Zw7t1braPsbDmJ0muvAd3QD2iUvht0tuZENIwALL3VBRo8/kvSuhRHFllqog9amnXWIy5+
 7o9t0d7vJkWggvNCr1bBG13ypakFXMQtkHbsgTvfAdX3EZQc8LcM4hemsSUiY5IjnY/26u
 UMEHKLSFaf56eueG6Zf6wXe1SZA3SY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-6t6fiS1SNdu9ayCuO9-nIw-1; Wed, 01 Feb 2023 11:11:31 -0500
X-MC-Unique: 6t6fiS1SNdu9ayCuO9-nIw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l38-20020a05600c1d2600b003ddff4b9a40so1205731wms.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 08:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SCNzhgbsT7harPHDgUVLPlkp85+yy8d8grMTrA+fNpY=;
 b=OUOMOWEnD0k/SC3Zv+rhIXAnI2v95cDZSTP9+m7boxSiiTeixwFKeTGonA7rGyGABK
 6WKvrx2z694m73pUeM+IjyIrDOZIo2zFE/46sQ3DUAWnGHv8o6/i9kh83L9jrq5zc/GK
 BF8Po0LACDDd2114NWqVCF0/WH44nvl0h+arS+9vROBcbG+cfsAiAPshztRLqIhe6qMb
 Y4ekUiNpLs5AbpFN6lY9KEYEETo+/+3nzM/tiCDy68iwqCMWx4Y80zURyKYjXEW9sGo2
 Z6ZJ49pgWCGAfl3jK30/rVyehtyb4QIGVnNQM17CMVbQcoYGxYF4M50imbLu1EnApiXx
 eZ1g==
X-Gm-Message-State: AO0yUKVkgmMQpsjb4Cjgqy22QLSKH42bQOTL9O5fIE11XdpfCZZTNQ3+
 2u5YRluEcFaV0YGWGBDJnkXY69/LDBZs3MAns/rvDyk6XqjkpaEGhLjPNhHIXtBAo5TsgfxfrbO
 9dY2K8n7Hzohvhh/Iwrm68vjWLCq8+nt+1k5KiU0Khw==
X-Received: by 2002:a5d:4bce:0:b0:2c3:24f3:8b47 with SMTP id
 l14-20020a5d4bce000000b002c324f38b47mr2849933wrt.31.1675267890486; 
 Wed, 01 Feb 2023 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AK7set++NDgUi9uhBvV1xDGEBywenU3gTcP+mOhc1EqOEjLk4Za/27YTUIix/oEOJhT7SgB8iFK/lw==
X-Received: by 2002:a5d:4bce:0:b0:2c3:24f3:8b47 with SMTP id
 l14-20020a5d4bce000000b002c324f38b47mr2849912wrt.31.1675267890249; 
 Wed, 01 Feb 2023 08:11:30 -0800 (PST)
Received: from redhat.com ([2.52.144.173]) by smtp.gmail.com with ESMTPSA id
 e28-20020a5d595c000000b002bfd8ad20a0sm13733573wri.44.2023.02.01.08.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 08:11:29 -0800 (PST)
Date: Wed, 1 Feb 2023 11:11:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
Message-ID: <20230201111108-mutt-send-email-mst@kernel.org>
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230118164359.1523760-3-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jan 18, 2023 at 05:43:59PM +0100, Eugenio P=E9rez wrote:
> Starting from an used_idx different than 0 is needed in use cases like
> virtual machine migration.  Not doing so and letting the caller set an
> avail idx different than 0 causes destination device to try to use old
> buffers that source driver already recover and are not available
> anymore.
> =

> While callers like vdpa_sim set avail_idx directly it does not set
> used_idx.  Instead of let the caller do the assignment, fetch it from
> the guest at initialization like vhost-kernel do.
> =

> To perform the same at vring_kernel_init and vring_user_init is left for
> the future.
> =

> Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>


So I applied 1/2 and dropped 2/2 for now, right?

> ---
>  drivers/vhost/vringh.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 33eb941fcf15..0eed825197f2 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1301,6 +1301,17 @@ static inline int putused_iotlb(const struct vring=
h *vrh,
>  	return 0;
>  }
>  =

> +/**
> + * vringh_update_used_idx - fetch used idx from driver's used split vring
> + * @vrh: The vring.
> + *
> + * Returns -errno or 0.
> + */
> +static inline int vringh_update_used_idx(struct vringh *vrh)
> +{
> +	return getu16_iotlb(vrh, &vrh->last_used_idx, &vrh->vring.used->idx);
> +}
> +
>  /**
>   * vringh_init_iotlb - initialize a vringh for a ring with IOTLB.
>   * @vrh: the vringh to initialize.
> @@ -1319,8 +1330,18 @@ int vringh_init_iotlb(struct vringh *vrh, u64 feat=
ures,
>  		      struct vring_avail *avail,
>  		      struct vring_used *used)
>  {
> -	return vringh_init_kern(vrh, features, num, weak_barriers,
> -				desc, avail, used);
> +	int r =3D vringh_init_kern(vrh, features, num, weak_barriers, desc,
> +				 avail, used);
> +
> +	if (r !=3D 0)
> +		return r;
> +
> +	/* Consider the ring not initialized */
> +	if ((void *)desc =3D=3D used)
> +		return 0;
> +
> +	return vringh_update_used_idx(vrh);
> +
>  }
>  EXPORT_SYMBOL(vringh_init_iotlb);
>  =

> -- =

> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
