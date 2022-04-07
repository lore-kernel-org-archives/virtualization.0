Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB26FC433FE
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 22:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4882241BCE;
	Thu,  7 Apr 2022 22:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6yHNc7GrYyHD; Thu,  7 Apr 2022 22:37:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C7A841BD3;
	Thu,  7 Apr 2022 22:37:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D71EC001D;
	Thu,  7 Apr 2022 22:37:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB1C9C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 22:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA8A684171
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 22:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmhknHkcAAtN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 22:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2151C84170
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649371065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOIZSnS98gQ3xydj16FHLPEIjDJjA+ZwlFfjRBiVUDY=;
 b=O+4RuQV1FMK9QzYWbIX9boxI8FKZDqr1wjn96e8ZZT8RjFaFToXAyQ/dJOhCgtX3l2krzW
 37sI+qEp0gptWNemnnjnogZBa6HqTe6QOzy4ZApnq21ZX0/CR4DvJSDoxT7I0wI6z+kYZO
 Nms+Jg3XEL6tvObGTauAP0FQoyDNA+A=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-NEHuXlQZNqS0__JnPZXhtw-1; Thu, 07 Apr 2022 18:37:42 -0400
X-MC-Unique: NEHuXlQZNqS0__JnPZXhtw-1
Received: by mail-ot1-f72.google.com with SMTP id
 v24-20020a056830091800b005cda775ef7fso3452477ott.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Apr 2022 15:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=NOIZSnS98gQ3xydj16FHLPEIjDJjA+ZwlFfjRBiVUDY=;
 b=U14BpRa0q3QPh2HdNd+c8yhxUgSB0xm+aOCP1SJ2X5kj3orighrfcdgXm1omY/hFXu
 z+Wc1EG2bVFAoSLLnOxmUMdG7AM7xPAOt/9/jWpXCgC0glN6+CsqxvHfaq/rVT5OQ/WL
 xlZAO7S1w05RHwrjgfNc+ZtSHtMRY4923v8lHpUcVyL+yf5J1mb4obhHhX04OrRD2WRi
 kMjsM9tD0ZqqKnl44DYCOZR2YD7e1b/f2PkZn7Wk13LNVYl3zZ2zk5j9kP9WkcoYwWbS
 CHV+zaRIXZS0AE9f3UZX1drlBKx2JUTdx+4j1/pCLHWk0X8XNHWoLSo7Voa8iDk5jeCa
 GA7w==
X-Gm-Message-State: AOAM532GG6g7b0pCF+7lfaAapoksBA2FNXjEkzgcPaMuHv1dJCrg2Cbg
 AyShxHJ0jBbrOp9hE/pIWJXB8pwIZOqFNyIODWlQV+BNClXIDClfFSA2LIYF7UQYl2WxQ2teYMA
 puH1ykkX8V6GPTMs1KYAnhTyHK28rXFENumj9vEWgqg==
X-Received: by 2002:a9d:ee7:0:b0:5cd:feb9:66b5 with SMTP id
 94-20020a9d0ee7000000b005cdfeb966b5mr5515098otj.216.1649371061227; 
 Thu, 07 Apr 2022 15:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcVZwyerJlnB50z195byTw9JBG/9w1iOCvt6QyoKpKsIz/rFvJndsMgHRlm6GD1Fo6Sk8OMg==
X-Received: by 2002:a9d:ee7:0:b0:5cd:feb9:66b5 with SMTP id
 94-20020a9d0ee7000000b005cdfeb966b5mr5515064otj.216.1649371060962; 
 Thu, 07 Apr 2022 15:37:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 c8-20020a4ad788000000b0031ce69b1640sm7642523oou.10.2022.04.07.15.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Apr 2022 15:37:40 -0700 (PDT)
Date: Thu, 7 Apr 2022 16:37:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY
 with dev_is_dma_coherent()
Message-ID: <20220407163737.2a7ccd7a.alex.williamson@redhat.com>
In-Reply-To: <20220407152331.GN2120790@nvidia.com>
References: <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
 <20220406142432.GF2120790@nvidia.com>
 <20220406151823.GG2120790@nvidia.com>
 <20220406155056.GA30433@lst.de>
 <20220406160623.GI2120790@nvidia.com>
 <20220406161031.GA31790@lst.de>
 <20220406171729.GJ2120790@nvidia.com>
 <BN9PR11MB5276F9CEA2B01B3E75094B6D8CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220407135946.GM2120790@nvidia.com>
 <fb55a025-348e-800c-e368-48be075d8e9c@arm.com>
 <20220407152331.GN2120790@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Nelson Escobar <neescoba@cisco.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Rob Clark <robdclark@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Christian Benvenuti <benve@cisco.com>, David Woodhouse <dwmw2@infradead.org>,
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

On Thu, 7 Apr 2022 12:23:31 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 07, 2022 at 04:17:11PM +0100, Robin Murphy wrote:
> 
> > For the specific case of overriding PCIe No Snoop (which is more problematic
> > from an Arm SMMU PoV) when assigning to a VM, would that not be easier
> > solved by just having vfio-pci clear the "Enable No Snoop" control bit in
> > the endpoint's PCIe capability?  
> 
> Ideally.
> 
> That was rediscussed recently, apparently there are non-compliant
> devices and drivers that just ignore the bit. 
> 
> Presumably this is why x86 had to move to an IOMMU enforced feature..

I considered this option when implementing the current solution, but
ultimately I didn't have confidence in being able to prevent drivers
from using device specific means to effect the change anyway.  GPUs
especially have various back channels to config space.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
