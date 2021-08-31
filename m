Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0345DC432BE
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 21:15:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9529E6101A
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 21:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9529E6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57F3540267;
	Tue, 31 Aug 2021 21:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FgODFOJote_S; Tue, 31 Aug 2021 21:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5E604021C;
	Tue, 31 Aug 2021 21:15:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A82B9C0010;
	Tue, 31 Aug 2021 21:15:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27E63C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 21:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F410480FC6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 21:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gj1ZkxnU7eGV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 21:15:07 +0000 (UTC)
X-Greylist: delayed 14:48:29 by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04D4580EDC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 21:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630444505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UyB/+ZPljx2VgfRt0jNlq40owEOQB0AZTp3i8TfltT0=;
 b=UfrcANbQS0Lbo8DF4tnxKEhs2E85U3rwbUhb1gaZc8/MLSqXFKMuNCYRcvG3nx9qgogUle
 w2wYbnXMHxgG7N1Z5cU30WfH8VNVgU1qXDvbZeUf87UUBMdqSJNtIwJUSUxGGrHwosX1F1
 ALII8xnDEwWRaXdVEGDK+HxN2m4c5/k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-CZUCOK_2MkaFYnAYv0IqNA-1; Tue, 31 Aug 2021 17:15:04 -0400
X-MC-Unique: CZUCOK_2MkaFYnAYv0IqNA-1
Received: by mail-ej1-f72.google.com with SMTP id
 f23-20020a17090624d700b005d7f8be91eeso370626ejb.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UyB/+ZPljx2VgfRt0jNlq40owEOQB0AZTp3i8TfltT0=;
 b=jmi3itbZX1mGb3htYFtUb506Xyr5IWX2BLU+Q9SaHHQG1Ks7ODNgQAI/c93jKku7cr
 1Q12OG3EyepNKQbW8qTiAeM9S9p3Nw0p2YkIUQXT17lltrD0w42D9egrbEASZ9xPU19t
 E6nxCinzdcfC1pHUcYUq2TJ2lsNcIYkBDbFdXWHlDuDAObeZxFLzxIN2KbwCh6TUJE+f
 LTq0xR1imzHDcOQ9JbbU/15Q5J8cTfImGPcRMiaAZqCuq/jKowfjhlxima+2L6IXoRO9
 HMcrucY25QsPTQHbfy6bA6fytMEH5oFD4ExVRPkRZegHeJeEw1hgswLVC68l2Mf9bRKf
 xpjg==
X-Gm-Message-State: AOAM53316w7D1foEIKQDw3uFvR+CObwcVYlVOY/qCf+cI1IFccasprNA
 dz+mdmObL9sHRMBOF4II5ESwAYoyVWX/hX9DWnfCGxddJgJBovLUOgnCsI3xr8kQZeD/SA4YepR
 l6tc+SwLZ6ir08MEeRXC7u8m6PN95/XRWCdSdL15dCw==
X-Received: by 2002:a17:906:d04d:: with SMTP id
 bo13mr33759761ejb.351.1630444503406; 
 Tue, 31 Aug 2021 14:15:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAk4BqRZ6zbg8SZFwPGTMXZUCG1XOIB1+iMF0pmBSWVtcR+Nrm4En33QLBaZmx0zPjwsqh4g==
X-Received: by 2002:a17:906:d04d:: with SMTP id
 bo13mr33759739ejb.351.1630444503247; 
 Tue, 31 Aug 2021 14:15:03 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id p21sm5587802ejm.88.2021.08.31.14.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 14:15:02 -0700 (PDT)
Date: Tue, 31 Aug 2021 17:14:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v4 0/6] Add support for control VQ and multique
Message-ID: <20210831171332-mutt-send-email-mst@kernel.org>
References: <20210823052123.14909-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210823052123.14909-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Aug 23, 2021 at 08:21:17AM +0300, Eli Cohen wrote:
> This series adds support for control virtqueue.
> patch 1: A simple cleanup.
> patch 2: Modify functions to pass struct struct mlx5_vdpa_dev which
>          holds information requried in subsequent patches.
> patch 3: Save the callbacks of virtqueue in its own array and not on
>          struct mlx5_vdpa_virtqueue. Needed to avoid issue in qemu.
> patch 4: Enforce valid indices based on negtiated features.
> patch 5: Support multique and MAC modification
> patch 6: Add multiqueue support

Eli I don't know what went wrong but it looks like this patchset never actually
reached the virtualization@lists.linux-foundation.org mailing list.

See e.g. https://lore.kernel.org/virtualization/ad10d3ea-24c1-7f18-630d-be9f2bf0b036@redhat.com/

I tried bouncing it which maybe will fix it, we'll see.


> v3 -> v4:
> make some functions static in the file
> 
> Eli Cohen (6):
>   vdpa/mlx5: Remove redundant header file inclusion
>   vdpa/mlx5: function prototype modifications in preparation to control
>     VQ
>   vdpa/mlx5: Decouple virtqueue callback from struct mlx5_vdpa_virtqueue
>   vdpa/mlx5: Ensure valid indices are provided
>   vdpa/mlx5: Add support for control VQ and MAC setting
>   vdpa/mlx5: Add multiqueue support
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  26 +-
>  drivers/vdpa/mlx5/core/mr.c        |  81 +++--
>  drivers/vdpa/mlx5/core/resources.c |  35 ++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 517 +++++++++++++++++++++++++----
>  4 files changed, 575 insertions(+), 84 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
