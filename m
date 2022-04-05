Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D0AC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 19:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04EB940222;
	Tue,  5 Apr 2022 19:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g8pejL3UhAyt; Tue,  5 Apr 2022 19:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9988B402F3;
	Tue,  5 Apr 2022 19:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46FA2C002C;
	Tue,  5 Apr 2022 19:10:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A030C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C896827CE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHvTR6GSJ13R
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:10:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5F7782591
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649185848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
 b=Z9xUuWIFR1s5Ev4w2nyOD2v0z3fHci6g13TOV980JOAop8ZJh1B/KGPbUnOLPzwiod2D5n
 zR9KVBTDx3Z1Fn096cuMlF3ritv9wL0sh6HY7KAWGny3m03LjZYEBUy5itgGqEsLKTFi79
 JEkrQ5Axjt92XOV3XQSYNJdJKHT4Qkg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-37AqgOSgODCoxRRiLZymNA-1; Tue, 05 Apr 2022 15:10:47 -0400
X-MC-Unique: 37AqgOSgODCoxRRiLZymNA-1
Received: by mail-io1-f70.google.com with SMTP id
 i19-20020a5d9353000000b006495ab76af6so179658ioo.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 12:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
 b=injPos5WqEEd9aeypRJA7pRTRfICYoeJkDjkbXo8DPfsN6PBCLbwaTgTqgPuB0lg3q
 7aB4VJnpV/kOq9XVO3EqRbdVsrtKkdwAWYXtyV2iZuxgnSHh0O8qPeAWFHhYmeA1zpjr
 ZeV0w+UpwGBDZ3GYUAE650YuJ5Xznm042P9ef+hafJSPaUgsMDYP41zTIdFtQ//mqkMs
 nSrVEVkEZBImqTQG7np39i2Udl35liigZCFkV6AbBtb+kltJc+Rzj4Zx+ixf5DztfMA4
 oRVgLPRQUz2cDru6Q6gqNIdq1Ant/VFnmPRX9qN6TvKwdEX6XjJfqqd0azchIiU2iDDN
 VHIg==
X-Gm-Message-State: AOAM533h3QgZjqdhXRD7fODiTKdon4DMx8owW387BmbWkYtazT714ETK
 F/qQekbcNbyP1/2PxQxA15CccN7wpxoniQ9hAtOzwHpl1XfPVeyfAfMopExphC7CFYvFBhKT37m
 f0j/7IO0Gd8WNqeD5FLtPq/cxZLKam2xTV0oTM1oI3w==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr2568140ild.5.1649185846546; 
 Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxocs2ZVaXF5YVJwjGBcLRqnK5UBIr3mQlWSQgNmkFdgGBC2rjlpWZLrLl9AI2wrgBUaUJw1w==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr2568112ild.5.1649185846282; 
 Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 x2-20020a056602160200b006463c1977f9sm9314961iow.22.2022.04.05.12.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 12:10:45 -0700 (PDT)
Date: Tue, 5 Apr 2022 13:10:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/5] vfio: Require that devices support DMA cache coherence
Message-ID: <20220405131044.23910b77.alex.williamson@redhat.com>
In-Reply-To: <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Rob Clark <robdclark@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Tue,  5 Apr 2022 13:16:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> dev_is_dma_coherent() is the control to determine if IOMMU_CACHE can be
> supported.
> 
> IOMMU_CACHE means that normal DMAs do not require any additional coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check dev_is_dma_coherent() before allowing a device to join a
> domain. This will block device/platform/iommu combinations from using VFIO
> that do not support cache coherent DMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..2a3aa3e742d943 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -32,6 +32,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
> +#include <linux/dma-map-ops.h>
>  #include "vfio.h"
>  
>  #define DRIVER_VERSION	"0.3"
> @@ -1348,6 +1349,11 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
>  	if (IS_ERR(device))
>  		return PTR_ERR(device);
>  
> +	if (group->type == VFIO_IOMMU && !dev_is_dma_coherent(device->dev)) {
> +		ret = -ENODEV;
> +		goto err_device_put;
> +	}
> +

Failing at the point where the user is trying to gain access to the
device seems a little late in the process and opaque, wouldn't we
rather have vfio bus drivers fail to probe such devices?  I'd expect
this to occur in the vfio_register_group_dev() path.  Thanks,

Alex

>  	if (!try_module_get(device->dev->driver->owner)) {
>  		ret = -ENODEV;
>  		goto err_device_put;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
