Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82875C4332F
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 07:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0618161361;
	Tue,  7 Nov 2023 07:30:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0618161361
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgWulv5k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dImJxN0fl6mP; Tue,  7 Nov 2023 07:30:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D0656135E;
	Tue,  7 Nov 2023 07:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D0656135E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65F4BC0039;
	Tue,  7 Nov 2023 07:30:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F651C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 07:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 282EA822FA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 07:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 282EA822FA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hgWulv5k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b86QTPF5BP_r
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 07:30:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C66EF8223C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 07:30:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C66EF8223C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699342241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
 b=hgWulv5kXKuByWxGfjyTQad4EvwlLskugOt85lRA0LLyfe4k14Hgn1uTOBwQQzsRlfiWog
 XKEH845ffvs6+Q/7YqUH8J/EPJhL0WmpQTDeDAp4UycDkMtgybAc2Mp1Sot2b0NEetFHjz
 N1dY0S/sTurKzCoAZaWDwdnNdr8VZeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-GM2lb4zJN7qLkaHhk7XaYA-1; Tue, 07 Nov 2023 02:30:40 -0500
X-MC-Unique: GM2lb4zJN7qLkaHhk7XaYA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4091c9bdb8eso38496915e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 23:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699342239; x=1699947039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/lx1rypKszE80C3svlF1BPeyS2bMagooOeOTmeIu3k=;
 b=wrkfWQfvsWK8s63rVzDHDM++YVmYFpkK70YIt/CTzOVv8wULSMHOw9ugqn+DeEu6Ej
 UZzc4PMzqd4AJ9Kjhy38iM55AJuMAhxBtEq4HtO5KDnr9JDAXSUTs8ZecraOpf9wVq2i
 ONHfx+VYyfcDpcdEtmMHUJJa9776bUYlD+Zv2x6LqQefcS3R1GR1sw0v7EuJQrSQ/NU8
 1f89LQPwcuTaFGGzKqOwvKL7fyJ7T2DdZ65e5GjTiP6Qkx/Ji5DaWftLhbqNhqEcynmm
 oRrDjhpJqEr/fCaBCxErtvU8D2fRYjdQygalqC/AkcYsIWMpsXOAywt8Jld91ATzY+mb
 1IQQ==
X-Gm-Message-State: AOJu0YyMn6B6Xwhqf9fHysjF4q4LWR5UrgqivXLJCBtr6+E85el6Ro64
 M47Ei86L9d2BvOTYWdwfRFSRpInZ/Vj0sBMKu53dWdPldstCdIDvqehMKkojeOxVTpvv0mPTjN4
 ptecDdwmD2c+XmIQSWwbg+Hlo/0Gukp6U2Y7UUaZyog==
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id
 j6-20020a05600c1c0600b004053ab3e640mr1563990wms.20.1699342239044; 
 Mon, 06 Nov 2023 23:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKOvrGmXKbiJ4vIeoxB/aU3PS4p7CWdE7g1MzeenXV0fuHrqF0EyczH4kRYvPFqPW5dbKFQg==
X-Received: by 2002:a05:600c:1c06:b0:405:3ab3:e640 with SMTP id
 j6-20020a05600c1c0600b004053ab3e640mr1563976wms.20.1699342238687; 
 Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 e12-20020adffd0c000000b0032d893d8dc8sm1555331wrr.2.2023.11.06.23.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 23:30:38 -0800 (PST)
Date: Tue, 7 Nov 2023 02:30:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107022847-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yi.l.liu@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com
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

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> 
> Hi All
> This code provides the iommufd support for vdpa device
> This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> v6,6-rc3
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

What kind of problems? Understanding that will make it easier
to figure out whether this is worth reviewing.

> I will continue working on it
> 
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Please also Cc iommufd maintainers:

Jason Gunthorpe <jgg@ziepe.ca> (maintainer:IOMMUFD)
Kevin Tian <kevin.tian@intel.com> (maintainer:IOMMUFD)
Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU SUBSYSTEM)
Will Deacon <will@kernel.org> (maintainer:IOMMU SUBSYSTEM)
Robin Murphy <robin.murphy@arm.com> (reviewer:IOMMU SUBSYSTEM)
iommu@lists.linux.dev (open list:IOMMUFD)
linux-kernel@vger.kernel.org (open list)

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
