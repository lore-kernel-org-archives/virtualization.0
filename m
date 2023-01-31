Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01469C61DA4
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 03:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C1AA400BB;
	Tue, 31 Jan 2023 03:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C1AA400BB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lrortqv7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VAz-x-CV3pBD; Tue, 31 Jan 2023 03:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3751400AF;
	Tue, 31 Jan 2023 03:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3751400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBCA4C0032;
	Tue, 31 Jan 2023 03:06:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACB8CC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79491400B8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79491400B8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pse6cy01R6h3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22EBB400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22EBB400AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 03:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675134392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KdMSX2PGXe45qBgqP8RMLgntuCYyndOvWlGnSWr1I1w=;
 b=Lrortqv7icKfhEub19HsWOVMh8X/pZjigrG+ootNdXQaHreHpsRKbYpRK/+4lBQSkH84FZ
 M7bz0VP6U54Bfb0LiWfbgRRQqtkaLI5dQsmZXSyBKtnC+8MIcMXBytuDzHitD4BFSMFE/E
 4zAhmEzKBG5sFzwUV9j1Ukvt00JO1Ls=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-7GrKvvfgMgyrLV3kAw7-5w-1; Mon, 30 Jan 2023 22:06:29 -0500
X-MC-Unique: 7GrKvvfgMgyrLV3kAw7-5w-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1632b78625cso5026951fac.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 19:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdMSX2PGXe45qBgqP8RMLgntuCYyndOvWlGnSWr1I1w=;
 b=dPCXsnDgHEqGs7Yb7nozn7CPqe9F5wVeQVe4SS67Xl1NVB1PETwMA0By4r+XCtX4/t
 rwn69WXlhJe0I7TOrlj5tPaVWDCeAiaAZBacqDD9gJTkfuvlAWJRVcOI9VGGXXj1wIUe
 9ZEr5PWQbmch5AYScPhrNHha01i/DKxnl7GYIz+0YqRHFxwKdp5qFLKnqKQv7QyE5wUY
 1fq8z8sUBtDeeaCNJxH8iLLMnLERRGF9aRTb2eL9PbHJbWgplmpMR9rtCNZe1N2FapuE
 Tenc9Ot6JFF3yESpJsj6BbUoChWSzL7c9li1AFj3rqyzfnY9xzaJ2uHGFYzb96IyaJzP
 garw==
X-Gm-Message-State: AO0yUKWWL+xxfq9pkW4WPt3aMmMLAjLFY60EB79RrDX/ADJXRlFGxSxz
 sDKQ1fuiT1fg4PftheEQnjrBfCsaozf9g3TpejKEIF4N3pF/WcP4gumkDVbXuRR9CHa3E9tvmFd
 g4Dk4lR903K3gPQr1yVQSpN+KeC7IHr6Ltc7YAccZEeFlEGQGriC+rWgchA==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr565255oao.35.1675134389154; 
 Mon, 30 Jan 2023 19:06:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/gy6zeCHS7dDqTzLgm0l0HH281Gpnu1QcOaLODISHVTb7n1+4QzN8Fzmkkj1rEtYbW+m8iASC8yFpzqnKRkFM=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr565247oao.35.1675134388839; Mon, 30 Jan
 2023 19:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20230128031740.166743-1-sunnanyong@huawei.com>
 <CACGkMEtMAFMbhPnaaTwGRFofPM-p8ceKzAUbD2AFBz=fbR6hYQ@mail.gmail.com>
 <ffe21085-13cf-e2e9-e5cc-8755e9e3250b@huawei.com>
In-Reply-To: <ffe21085-13cf-e2e9-e5cc-8755e9e3250b@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Jan 2023 11:06:17 +0800
Message-ID: <CACGkMEsuYLen=pXd0e3hFNcUj-GQzj8ggh_8NDgWR2HbsD2S1A@mail.gmail.com>
Subject: Re: [PATCH] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: Nanyong Sun <sunnanyong@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, will@kernel.org, joro@8bytes.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, netdev@vger.kernel.org, robin.murphy@arm.com,
 wangrong68@huawei.com
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

On Tue, Jan 31, 2023 at 9:32 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> On 2023/1/29 14:02, Jason Wang wrote:
> > On Sat, Jan 28, 2023 at 10:25 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
> >> From: Rong Wang <wangrong68@huawei.com>
> >>
> >> Once enable iommu domain for one device, the MSI
> >> translation tables have to be there for software-managed MSI.
> >> Otherwise, platform with software-managed MSI without an
> >> irq bypass function, can not get a correct memory write event
> >> from pcie, will not get irqs.
> >> The solution is to obtain the MSI phy base address from
> >> iommu reserved region, and set it to iommu MSI cookie,
> >> then translation tables will be created while request irq.
> >>
> >> Signed-off-by: Rong Wang <wangrong68@huawei.com>
> >> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> >> ---
> >>   drivers/iommu/iommu.c |  1 +
> >>   drivers/vhost/vdpa.c  | 53 ++++++++++++++++++++++++++++++++++++++++---
> >>   2 files changed, 51 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index de91dd88705b..f6c65d5d8e2b 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -2623,6 +2623,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
> >>          if (ops->get_resv_regions)
> >>                  ops->get_resv_regions(dev, list);
> >>   }
> >> +EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
> >>
> >>   /**
> >>    * iommu_put_resv_regions - release resered regions
> >> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> >> index ec32f785dfde..31d3e9ed4cfa 100644
> >> --- a/drivers/vhost/vdpa.c
> >> +++ b/drivers/vhost/vdpa.c
> >> @@ -1103,6 +1103,48 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
> >>          return vhost_chr_write_iter(dev, from);
> >>   }
> >>
> >> +static bool vhost_vdpa_check_sw_msi(struct list_head *dev_resv_regions, phys_addr_t *base)
> >> +{
> >> +       struct iommu_resv_region *region;
> >> +       bool ret = false;
> >> +
> >> +       list_for_each_entry(region, dev_resv_regions, list) {
> >> +               /*
> >> +                * The presence of any 'real' MSI regions should take
> >> +                * precedence over the software-managed one if the
> >> +                * IOMMU driver happens to advertise both types.
> >> +                */
> >> +               if (region->type == IOMMU_RESV_MSI) {
> >> +                       ret = false;
> >> +                       break;
> >> +               }
> >> +
> >> +               if (region->type == IOMMU_RESV_SW_MSI) {
> >> +                       *base = region->start;
> >> +                       ret = true;
> >> +               }
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> > Can we unify this with what VFIO had?
> Yes, these two functions are just the same.
> Do you think move this function to iommu.c, and export from iommu is a
> good choice?

Probably, we can try and see.

> >
> >> +
> >> +static int vhost_vdpa_get_msi_cookie(struct iommu_domain *domain, struct device *dma_dev)
> >> +{
> >> +       struct list_head dev_resv_regions;
> >> +       phys_addr_t resv_msi_base = 0;
> >> +       int ret = 0;
> >> +
> >> +       INIT_LIST_HEAD(&dev_resv_regions);
> >> +       iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> >> +
> >> +       if (vhost_vdpa_check_sw_msi(&dev_resv_regions, &resv_msi_base))
> >> +               ret = iommu_get_msi_cookie(domain, resv_msi_base);
> >> +
> >> +       iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>   static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> >>   {
> >>          struct vdpa_device *vdpa = v->vdpa;
> >> @@ -1128,11 +1170,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
> >>
> >>          ret = iommu_attach_device(v->domain, dma_dev);
> >>          if (ret)
> >> -               goto err_attach;
> >> +               goto err_alloc_domain;
> >>
> >> -       return 0;
> >> +       ret = vhost_vdpa_get_msi_cookie(v->domain, dma_dev);
> > Do we need to check the overlap mapping and record it in the interval
> > tree (as what VFIO did)?
> >
> > Thanks
> Yes, we need to care about this part, I will handle this recently.
> Thanks a lot.

I think for parents that requires vendor specific mapping logic we
probably also need this.

But this could be added on top (via a new config ops probably).

Thanks

> >> +       if (ret)
> >> +               goto err_attach_device;
> >>
> >> -err_attach:
> >> +       return 0;
> >> +err_attach_device:
> >> +       iommu_detach_device(v->domain, dma_dev);
> >> +err_alloc_domain:
> >>          iommu_domain_free(v->domain);
> >>          return ret;
> >>   }
> >> --
> >> 2.25.1
> >>
> > .
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
