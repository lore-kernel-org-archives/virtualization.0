Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C2CC38142
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 05:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C236E416FC;
	Tue, 24 Jan 2023 05:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C236E416FC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fv+zftM/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6_RZUX7V3-Bm; Tue, 24 Jan 2023 05:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC19F41705;
	Tue, 24 Jan 2023 05:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC19F41705
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB50C0033;
	Tue, 24 Jan 2023 05:55:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A6A1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 05:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61C3B81E87
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 05:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61C3B81E87
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fv+zftM/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vNP28--obDdq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 05:55:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CD9581E6E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CD9581E6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674539717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9+nMn4Y7ib+ksp4an8hs+mxpzKixV/6cqrHGLxmxmZs=;
 b=Fv+zftM/+sdrzkt6rdetvf/WJi6bEZ2SsstXemXyQrpRJ3fmrYrDGhqUdH0JcAW3dESW+P
 hc8x7Zz6VZ53s4Vff+RN9wZqfkEXCRqOIanlbsboXXhBzAl6T7uprwDIH2qitYh2NePZVp
 j+5kgltXBJADMgAFT2cFsSDmIe1mTt8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-390-Ql-X5Wi-OeK4V-hqyh11ww-1; Tue, 24 Jan 2023 00:55:15 -0500
X-MC-Unique: Ql-X5Wi-OeK4V-hqyh11ww-1
Received: by mail-ua1-f71.google.com with SMTP id
 z22-20020ab05656000000b00652f9577464so480501uaa.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 21:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+nMn4Y7ib+ksp4an8hs+mxpzKixV/6cqrHGLxmxmZs=;
 b=i34OhIfJ5nQtK1HFVFI+IC3DxNtkMbSXYp13CBqxLM0w3MCRu7WCT2vx/wHNpZuxLg
 X5Gac8W0uRJRs8JClJUV51a1D54Wls5APuhDv6PQdGtH2PkZc73CF8l0W6F4z8pv2JUd
 +lPB/quDX6E1pzpNGaHbYK0jLsUSAsXppCV8dasIECHTf9wJJEeSk0/radeQEyqIx/SN
 fJ7TNv9V+Cs5yjC4FWmRPbzDQ8RVqgvmPFncx6PDAeLGEoeGqqeASvDDE9aJLsjC08pt
 zPbo41uI6PxDwWc/7j+XDjLmKw8hsb+ez6yUcP8TAiiZusymqUiEEAgc/18filFLQ8UX
 ZOVw==
X-Gm-Message-State: AFqh2kojs5N9wrn2msrF97/BZJMESLNNodCxhdIxcWBvRglWwphJrwe0
 NkCQY8yNOsd+OuoR5fd3q8eHMblfeHLgvqGFKAAwmZJ3FzmI08b/a/tgISkXfP9vaj8A+3481Jo
 AZA52hKUkk9AI+sitPI/T3n8HhIoDtBswJd8vuEXUrw==
X-Received: by 2002:a05:6102:1517:b0:3d3:c855:bf54 with SMTP id
 f23-20020a056102151700b003d3c855bf54mr16402954vsv.34.1674539714858; 
 Mon, 23 Jan 2023 21:55:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtIO8aXO9i+HLzZc6kLGRsWHVrO9s72UFSgMG1EytTFL2SpZojIc12K4cwqrrKZT6og3irEcA==
X-Received: by 2002:a05:6102:1517:b0:3d3:c855:bf54 with SMTP id
 f23-20020a056102151700b003d3c855bf54mr16402943vsv.34.1674539714642; 
 Mon, 23 Jan 2023 21:55:14 -0800 (PST)
Received: from redhat.com ([45.144.113.7]) by smtp.gmail.com with ESMTPSA id
 r15-20020ab04a4f000000b006180bedf1b8sm83195uae.26.2023.01.23.21.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jan 2023 21:55:14 -0800 (PST)
Date: Tue, 24 Jan 2023 00:55:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Subject: Re: [RFC PATCH 02/19] drivers/vhost: Convert to use vm_account
Message-ID: <20230124005356-mutt-send-email-mst@kernel.org>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
 <97a17a6ab7e59be4287a2a94d43bb787300476b4.1674538665.git-series.apopple@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <97a17a6ab7e59be4287a2a94d43bb787300476b4.1674538665.git-series.apopple@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: daniel@ffwll.ch, kvm@vger.kernel.org, jhubbard@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, mkoutny@suse.com, jgg@nvidia.com,
 hannes@cmpxchg.org, cgroups@vger.kernel.org, surenb@google.com,
 tjmercier@google.com
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

On Tue, Jan 24, 2023 at 04:42:31PM +1100, Alistair Popple wrote:
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f78..a31dd53 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c

...

> @@ -780,6 +780,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	u32 asid = iotlb_to_asid(iotlb);
>  	int r = 0;
>  
> +	if (!vdpa->use_va)
> +		if (vm_account_pinned(&dev->vm_account, PFN_DOWN(size)))
> +			return -ENOMEM;
> +
>  	r = vhost_iotlb_add_range_ctx(iotlb, iova, iova + size - 1,
>  				      pa, perm, opaque);
>  	if (r)

I suspect some error handling will have to be reworked then, no?

> -- 
> git-series 0.9.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
