Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E5DC05027
	for <virtualization@archiver.kernel.org>; Fri, 17 Feb 2023 05:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29A9A81F68;
	Fri, 17 Feb 2023 05:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29A9A81F68
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J/cQ3kXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QA6-F-xkgcRv; Fri, 17 Feb 2023 05:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B5E9F81F5B;
	Fri, 17 Feb 2023 05:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5E9F81F5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C4E9C0033;
	Fri, 17 Feb 2023 05:36:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF2AFC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91089419AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91089419AB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J/cQ3kXL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kQGfdgVo4zgl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:36:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1CE2D41933
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1CE2D41933
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Feb 2023 05:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676612175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
 b=J/cQ3kXLd0dAohvw7vAsT25mStdAVLcgpTPA0O5vVdQSNlGs0g/KJNdXDvy3Vz8NpOawat
 UewZzU1+j2sLmBMRtoMr2i8Gp3VXiF44buDZircM6dEDIPX//HcIAU6PwiyrE++8DiSNvL
 AkdhB21yA0tQmj+mjQRNQ5nAuoFsKto=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-137-GST4QjVlP4muJrk6pJLY-Q-1; Fri, 17 Feb 2023 00:36:11 -0500
X-MC-Unique: GST4QjVlP4muJrk6pJLY-Q-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-16df95b8731so2257650fac.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 21:36:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8y4UETkQqs5POhMp8MHo+VmSRaMVJi1lvssc8jHWBA=;
 b=iLlgJmikpobbDeotS1Q7+zsc5zYxLEYNRF6Y/sgoD99dpkE6e/g8jpWWjgRG3TAE3s
 E0aynbdn66psxJ2Uq1arg7HFjI28nZmYXq+Q7n9uw9H2PVpAQDToO9If5gDKtyT3Qu1S
 BT9fQ7Eh6BCzZHMbJhcQwrmMJzIhmoD3uYnZM1WsozmYfQ+vxKuCwrS3eSUMNQ0h8ndZ
 LDtHWwmlR7CMZJuNd3SDI2POHq06GkT4BjPiHL0AxyR5oicjHFWHDEXSILJYveZxydOf
 haaUlItmFRPDZNvNJj/N4tLgf6V3CxFVGFmPCjnz2aBJ6tYa9cyxGLv6JHliSKy8N9Dn
 d1Gg==
X-Gm-Message-State: AO0yUKXercUweEtH8L2QDGW9OC/I5O8xbjs5ief3pC7Vm6Z3teWZSz5T
 VDdD2rMQRMfcL3NBKyKE9kunaNe+CpNrCZ5nJ45E564zEazTCBMCEwQ7bKIMQg2+0nVdONPxZWb
 y16tXPeV+MPSedSO9URSCKXzlcO7uoNaJ61cYQ3Em7qdsYMs2dqzI2tn1XA==
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr296401oib.35.1676612170542; 
 Thu, 16 Feb 2023 21:36:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+hY95HRDtXDD+GXnz1YrR2uwZRZowpsAyCm1bMt4U0npjM2XW+YfzeYKDUlmV5UD794AQCKMHVcQs7RZ9kgLs=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr296388oib.35.1676612170318; Thu, 16 Feb
 2023 21:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20230207120843.1580403-1-sunnanyong@huawei.com>
 <Y+7G+tiBCjKYnxcZ@nvidia.com>
In-Reply-To: <Y+7G+tiBCjKYnxcZ@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Feb 2023 13:35:59 +0800
Message-ID: <CACGkMEtehykvqNUnfCi0VmHR1xpmhj4sSWdYW1-0oATY=0YhXw@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, will@kernel.org, joro@8bytes.org,
 Nanyong Sun <sunnanyong@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, robin.murphy@arm.com, wangrong68@huawei.com
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

On Fri, Feb 17, 2023 at 8:15 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
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

Yes, but we probably need a patch for -stable.

>
> Also the iommu_group_has_isolated_msi() check is missing on the vdpa
> path, and it is missing the iommu ownership mechanism.

Ok.

>
> Also which in-tree VDPA driver that uses the iommu runs on ARM? Please

ifcvf and vp_vpda are two drivers that use platform IOMMU.

Thanks

> don't propose core changes for unmerged drivers. :(
>
> Jason
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
