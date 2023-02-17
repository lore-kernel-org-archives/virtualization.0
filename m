Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E627C05027
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 10:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C06C360BFD;
	Fri, 17 Feb 2023 10:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C06C360BFD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClxYJ0hn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ymxE5sgIm_OZ; Fri, 17 Feb 2023 10:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44EA661766;
	Fri, 17 Feb 2023 10:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44EA661766
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19550C0033;
	Fri, 17 Feb 2023 10:12:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D2B5C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18F3981F8A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:12:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18F3981F8A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClxYJ0hn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZToiyvPOeyo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6C5281F87
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6C5281F87
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676628757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Y7MkPKxQ4b4S+E2uuEcl4fSWKwkp7IBI4B2vVLi24A=;
 b=ClxYJ0hn4Jr7aQog7ltNWg76fmRK3NOEJcdlPIUCrT/eKgm/RZhIgVxlnDvJ6LPyBg8ntL
 ksIYg6CX1U9lbF5oc5QZMsjJ9PfeDRQkVpWQTY+LVaHOxx0b1S910LUrvuYiopCwUSLPRp
 W2bpWxpRBZiHp8Snb9sY+6Cz35DhpcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-WtIh5fnsPuaTR9PPJk1FSA-1; Fri, 17 Feb 2023 05:12:36 -0500
X-MC-Unique: WtIh5fnsPuaTR9PPJk1FSA-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay3-20020a05600c1e0300b003e21fa6f404so750335wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 02:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Y7MkPKxQ4b4S+E2uuEcl4fSWKwkp7IBI4B2vVLi24A=;
 b=q8mjSecvVhWCeuQTajdOgh/Qxyd0bBLMOit+icNSYnM1qfSLlstVOAscREnhblzQUu
 V1RjjiqjBjmul048gemGu6786Wg7s65nCx4/snZC5b8JuOkoVvDAYXOgNlY2TNEzjIQu
 m2gJ2fQ7t3L74Ors+A1qx4VAI26IAETdqWqqFpGMt+kqiUY4A2r+xXFECPbIoS9PRLun
 eNCAY5fhiS05zsS1zqRA7AmCG4drGI+YdQ/aSKEdH3m69tkV16c3u3Q6O9fdO3Uhv3tq
 IOx2prz3DQejd5VbmThbUiDDsPXn8JjWCUurRPEjLChloRBF80QsRGkJA8CvG0zLQ89I
 tHvg==
X-Gm-Message-State: AO0yUKVlpcDyAEJmBlcd5oIuUNcKi9ZCNAKE2rdwxBmd16uLO3YK5bSp
 u107eCqJERrp+kjpQqNXS1jNCFBGMKy/+KKoDhH0v7yc0+oZaMi8+rq3EGYLkTb6wovw+gPVc6v
 2XNgFdgpRgjPk8dcnd/p7V7zQEoJ0iI6xJHv78kcyZA==
X-Received: by 2002:adf:f40b:0:b0:2c5:5ff8:93e5 with SMTP id
 g11-20020adff40b000000b002c55ff893e5mr6717188wro.44.1676628755110; 
 Fri, 17 Feb 2023 02:12:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9h4wA736ZeMYva3jBcgfzObA1Ee5DxMQNCqSjLJtJ9uB6fqQFZuR5r1/3OYbU7YpGJ6GX0bQ==
X-Received: by 2002:adf:f40b:0:b0:2c5:5ff8:93e5 with SMTP id
 g11-20020adff40b000000b002c55ff893e5mr6717163wro.44.1676628754834; 
 Fri, 17 Feb 2023 02:12:34 -0800 (PST)
Received: from redhat.com ([2.52.5.34]) by smtp.gmail.com with ESMTPSA id
 i3-20020a05600011c300b002c4061a687bsm3720864wrx.31.2023.02.17.02.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Feb 2023 02:12:34 -0800 (PST)
Date: Fri, 17 Feb 2023 05:12:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
Message-ID: <20230217051158-mutt-send-email-mst@kernel.org>
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <Y+7G+tiBCjKYnxcZ@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wangrong68@huawei.com, kvm@vger.kernel.org,
 Nanyong Sun <sunnanyong@huawei.com>, will@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, robin.murphy@arm.com
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

On Thu, Feb 16, 2023 at 08:14:50PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 07, 2023 at 08:08:43PM +0800, Nanyong Sun wrote:
> > From: Rong Wang <wangrong68@huawei.com>
> > 
> > Once enable iommu domain for one device, the MSI
> > translation tables have to be there for software-managed MSI.
> > Otherwise, platform with software-managed MSI without an
> > irq bypass function, can not get a correct memory write event
> > from pcie, will not get irqs.
> > The solution is to obtain the MSI phy base address from
> > iommu reserved region, and set it to iommu MSI cookie,
> > then translation tables will be created while request irq.
> 
> Probably not what anyone wants to hear, but I would prefer we not add
> more uses of this stuff. It looks like we have to get rid of
> iommu_get_msi_cookie() :\
> 
> I'd like it if vdpa could move to iommufd not keep copying stuff from
> it..

Absolutely but when is that happening?

> Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> path, and it is missing the iommu ownership mechanism.
> 
> Also which in-tree VDPA driver that uses the iommu runs on ARM? Please
> don't propose core changes for unmerged drivers. :(
> 
> Jason

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
