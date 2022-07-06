Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63940CCA473
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 18:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4E8960C09;
	Wed,  6 Jul 2022 18:03:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4E8960C09
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T69uL2I2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yPMqdEb9Z0O2; Wed,  6 Jul 2022 18:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D975607C9;
	Wed,  6 Jul 2022 18:03:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D975607C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D529C0033;
	Wed,  6 Jul 2022 18:03:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7141EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 18:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45AB483E58
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 18:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45AB483E58
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T69uL2I2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agVNSUaUTJjc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 18:03:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F9E383123
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F9E383123
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657130609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBlFjIiB9ZC4gvoYyy90cQtMpZILwrGOgeqSFzZ8m1s=;
 b=T69uL2I2+AIs3O44T7hyHDeWFfoUxlJOz67wyck2UJQFSkC3CFnhqpx86PyapwfClWoARO
 rt+rmjatcSjZoqkVuoA9b7216IAXWXQkAvHi99vVqetL+EjiR+PA94E3Bof1r/A+QMCS6Y
 Vej+8JWaIohWA4qNX2sD50cNoMGbt6k=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-erXpY0AWMTyiEztB5XYiBA-1; Wed, 06 Jul 2022 14:03:29 -0400
X-MC-Unique: erXpY0AWMTyiEztB5XYiBA-1
Received: by mail-io1-f70.google.com with SMTP id
 x4-20020a6bd004000000b00675354ad495so8617752ioa.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Jul 2022 11:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=VBlFjIiB9ZC4gvoYyy90cQtMpZILwrGOgeqSFzZ8m1s=;
 b=amSWD/KOBZNMCEdft0xKJ0TxsDYrIqzXvuIgZ8+26yQTi+c5mQVloceRi3Be79lY+g
 VLeOPjLkbcgQ2gSZKLeBBob3Bxu1iyadjLeBGluTXYN57znCcOai5q9LPcQaCWIXMPPb
 n86Aphc1vfTOa2Twrma+kedqnQLHyJJgwh7uBbULVxEZ+G99WOffCpF8vRmqjL4qC+NJ
 zKJDY1vjjWiFPMKcPmt8HHKONmnm24SClnQC0FcaotFhTG/rwpRyBvDk2HpZjhMmffUp
 lhLBiF5dZB9K0lIl82Pzw0+b03xJ9Vm6Xjn5yKnF2lOJ7TSVaQqVHtTsI1HsJzBb7VLp
 znug==
X-Gm-Message-State: AJIora80dl2vt7jR/JRfr7W9AYxn1ve4Qhz/yJJ3NXlI5xGAVq69iSxo
 An+wGN/T9p2FirsDwzYJdKXl0ATiQE/Wn4wvUINfd3zRcjf2YNP/iyUJV1Xd/zkJhVJ/86LERPL
 iOYR9ZR50kDFEtCBCgTZUFGjOFfisHIf6wGWlW4V8WA==
X-Received: by 2002:a05:6638:218f:b0:33c:caf0:a61c with SMTP id
 s15-20020a056638218f00b0033ccaf0a61cmr26531493jaj.198.1657130608162; 
 Wed, 06 Jul 2022 11:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tABH1Ic8RqUAALPXzLJn+RofmhnwMLRPJ18ZPWLjNFSi2aNVbpdWUQPpp6mJB+LAKijjE03g==
X-Received: by 2002:a05:6638:218f:b0:33c:caf0:a61c with SMTP id
 s15-20020a056638218f00b0033ccaf0a61cmr26531473jaj.198.1657130607865; 
 Wed, 06 Jul 2022 11:03:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 co14-20020a0566383e0e00b0033efe711a37sm1538401jab.35.2022.07.06.11.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jul 2022 11:03:27 -0700 (PDT)
Date: Wed, 6 Jul 2022 12:03:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 0/5] cover-letter: Simplify vfio_iommu_type1
 attach/detach routine
Message-ID: <20220706120325.4741ff34.alex.williamson@redhat.com>
In-Reply-To: <YsXMMCX5LY/3IOtf@Asurada-Nvidia>
References: <20220701214455.14992-1-nicolinc@nvidia.com>
 <20220706114217.105f4f61.alex.williamson@redhat.com>
 <YsXMMCX5LY/3IOtf@Asurada-Nvidia>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, marcan@marcan.st, mjrosato@linux.ibm.com,
 virtualization@lists.linux-foundation.org, thierry.reding@gmail.com,
 will@kernel.org, alyssa@rosenzweig.io, jean-philippe@linaro.org,
 kvm@vger.kernel.org, zhang.lyra@gmail.com, joro@8bytes.org,
 jonathanh@nvidia.com, iommu@lists.linux.dev, jgg@nvidia.com,
 yangyingliang@huawei.com, orsonzhai@gmail.com, gerald.schaefer@linux.ibm.com,
 sven@svenpeter.dev, linux-arm-msm@vger.kernel.org, john.garry@huawei.com,
 vdumpa@nvidia.com, christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 chenxiang66@hisilicon.com, dwmw2@infradead.org, cohuck@redhat.com,
 linux-kernel@vger.kernel.org, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, baolin.wang7@gmail.com, robin.murphy@arm.com,
 baolu.lu@linux.intel.com
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

On Wed, 6 Jul 2022 10:53:52 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Wed, Jul 06, 2022 at 11:42:17AM -0600, Alex Williamson wrote:
> 
> > On Fri, 1 Jul 2022 14:44:50 -0700
> > Nicolin Chen <nicolinc@nvidia.com> wrote:
> >   
> > > This is a preparatory series for IOMMUFD v2 patches. It enforces error
> > > code -EMEDIUMTYPE in iommu_attach_device() and iommu_attach_group() when
> > > an IOMMU domain and a device/group are incompatible. It also drops the
> > > useless domain->ops check since it won't fail in current environment.
> > >
> > > These allow VFIO iommu code to simplify its group attachment routine, by
> > > avoiding the extra IOMMU domain allocations and attach/detach sequences
> > > of the old code.
> > >
> > > Worths mentioning the exact match for enforce_cache_coherency is removed
> > > with this series, since there's very less value in doing that as KVM will
> > > not be able to take advantage of it -- this just wastes domain memory.
> > > Instead, we rely on Intel IOMMU driver taking care of that internally.
> > >
> > > This is on github:
> > > https://github.com/nicolinc/iommufd/commits/vfio_iommu_attach  
> > 
> > How do you foresee this going in, I'm imagining Joerg would merge the
> > first patch via the IOMMU tree and provide a topic branch that I'd
> > merge into the vfio tree along with the remaining patches.  Sound
> > right?  Thanks,  
> 
> We don't have any build dependency between the IOMMU change and
> VFIO changes, yet, without the IOMMU one, any iommu_attach_group()
> failure now would be a hard failure without a chance falling back
> to a new_domain, which is slightly different from the current flow.
> 
> For a potential existing use case that relies on reusing existing
> domain, I think it'd be safer to have Joerg acking the first change
> so you merge them all? Thank!

Works for me, I'll look for buy-in + ack from Joerg.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
