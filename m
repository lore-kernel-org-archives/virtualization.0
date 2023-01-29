Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872CC05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 06:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53F2D60EC6;
	Sun, 29 Jan 2023 06:02:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53F2D60EC6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G79tgvaB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSa-vo0g6GK3; Sun, 29 Jan 2023 06:02:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C9E6160D57;
	Sun, 29 Jan 2023 06:02:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9E6160D57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3DB2C0033;
	Sun, 29 Jan 2023 06:02:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35C48C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0FD8040129
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:02:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FD8040129
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G79tgvaB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-d6m1g9Ztln
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:02:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34CA3400F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34CA3400F6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 06:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674972143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G+y0lNUe2D3FZqvZZMcDdGneE6tCR0dFmD5Cj+Ac+co=;
 b=G79tgvaBjTLpmyegB8gnPsWoT/BJUzE3/3nLQucLh4ZNX4hMTvbbbPCrSYpUGX8OtfPOaB
 gAZXsKcovjrH9SLx5TEhzyHKCAo8pDIQlK6eapV8gR3+yNnXT7yzDgBBuErJyfe/wsSSVi
 62rbLzY3WotJzptmpWyaVq1HRxaRof0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-i_cCSGGKMxSMDCXYAj3Cgg-1; Sun, 29 Jan 2023 01:02:20 -0500
X-MC-Unique: i_cCSGGKMxSMDCXYAj3Cgg-1
Received: by mail-oo1-f70.google.com with SMTP id
 n15-20020a4a954f000000b005176ac0674dso66609ooi.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 22:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G+y0lNUe2D3FZqvZZMcDdGneE6tCR0dFmD5Cj+Ac+co=;
 b=a2HYUHQMbmmMQdTygnWY7v9my9sPSIzdQLb8L7yJDN9rNEn8cPvtF1UCNDB6XHPbei
 uGE0CuX9AMcr1x1B1dz/xOtYZaTstv1Mo3tXEKMCTJf99C1cDno71iUxKAqw3m9TI0r7
 uOgD/x4/wzf7feXib1AzoEe0l81LFbXtZWdQ9IZz40cgWnOH5NEAGpX0oqgh/Qxd5i0n
 M0Sx7WBkV4M1vkac5vOs4x/H8gvTnshhiz8py9ql8q6ZGLLYYLIEdoc8ZH5j4yges54J
 6WPWdBBalqO2hfyUAgQ2NJZPN+pMX9NleH/Pt7GeBzVU/3z7yt1U8H4n107ql3OcN5O5
 gelA==
X-Gm-Message-State: AO0yUKVS9JsCKzSuPURqcXPSu8h/jQD55Y3IRW3W1N5EYD/yNW+oY82M
 hwTKM/mc2dBizJpbdPvw4GVRuPq02rHBqyFvKJfvEVKEQnW4dtCIuP3eAHrl/AK0hNWievuwGlE
 UbPY746twl4SH4sFT4HGTJlxKIK+TRhqTDOH3e7vz+rmuK9XKnQgZShIvqQ==
X-Received: by 2002:a4a:3457:0:b0:517:7850:6483 with SMTP id
 n23-20020a4a3457000000b0051778506483mr951oof.3.1674972139706; 
 Sat, 28 Jan 2023 22:02:19 -0800 (PST)
X-Google-Smtp-Source: AK7set8mW0JZ/n8lyZTTpcC67kMpT2Kinp8/MANimSerBoRFqCNzWu7WVdXpOca4BzGXE3JkgQMmFmJ+hFInW8+aXt4=
X-Received: by 2002:a4a:3457:0:b0:517:7850:6483 with SMTP id
 n23-20020a4a3457000000b0051778506483mr940oof.3.1674972139474; Sat, 28 Jan
 2023 22:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20230128031740.166743-1-sunnanyong@huawei.com>
In-Reply-To: <20230128031740.166743-1-sunnanyong@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 14:02:08 +0800
Message-ID: <CACGkMEtMAFMbhPnaaTwGRFofPM-p8ceKzAUbD2AFBz=fbR6hYQ@mail.gmail.com>
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

On Sat, Jan 28, 2023 at 10:25 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
>
> From: Rong Wang <wangrong68@huawei.com>
>
> Once enable iommu domain for one device, the MSI
> translation tables have to be there for software-managed MSI.
> Otherwise, platform with software-managed MSI without an
> irq bypass function, can not get a correct memory write event
> from pcie, will not get irqs.
> The solution is to obtain the MSI phy base address from
> iommu reserved region, and set it to iommu MSI cookie,
> then translation tables will be created while request irq.
>
> Signed-off-by: Rong Wang <wangrong68@huawei.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  drivers/iommu/iommu.c |  1 +
>  drivers/vhost/vdpa.c  | 53 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..f6c65d5d8e2b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2623,6 +2623,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>         if (ops->get_resv_regions)
>                 ops->get_resv_regions(dev, list);
>  }
> +EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
>
>  /**
>   * iommu_put_resv_regions - release resered regions
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ec32f785dfde..31d3e9ed4cfa 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1103,6 +1103,48 @@ static ssize_t vhost_vdpa_chr_write_iter(struct kiocb *iocb,
>         return vhost_chr_write_iter(dev, from);
>  }
>
> +static bool vhost_vdpa_check_sw_msi(struct list_head *dev_resv_regions, phys_addr_t *base)
> +{
> +       struct iommu_resv_region *region;
> +       bool ret = false;
> +
> +       list_for_each_entry(region, dev_resv_regions, list) {
> +               /*
> +                * The presence of any 'real' MSI regions should take
> +                * precedence over the software-managed one if the
> +                * IOMMU driver happens to advertise both types.
> +                */
> +               if (region->type == IOMMU_RESV_MSI) {
> +                       ret = false;
> +                       break;
> +               }
> +
> +               if (region->type == IOMMU_RESV_SW_MSI) {
> +                       *base = region->start;
> +                       ret = true;
> +               }
> +       }
> +
> +       return ret;
> +}

Can we unify this with what VFIO had?

> +
> +static int vhost_vdpa_get_msi_cookie(struct iommu_domain *domain, struct device *dma_dev)
> +{
> +       struct list_head dev_resv_regions;
> +       phys_addr_t resv_msi_base = 0;
> +       int ret = 0;
> +
> +       INIT_LIST_HEAD(&dev_resv_regions);
> +       iommu_get_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       if (vhost_vdpa_check_sw_msi(&dev_resv_regions, &resv_msi_base))
> +               ret = iommu_get_msi_cookie(domain, resv_msi_base);
> +
> +       iommu_put_resv_regions(dma_dev, &dev_resv_regions);
> +
> +       return ret;
> +}
> +
>  static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>  {
>         struct vdpa_device *vdpa = v->vdpa;
> @@ -1128,11 +1170,16 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>
>         ret = iommu_attach_device(v->domain, dma_dev);
>         if (ret)
> -               goto err_attach;
> +               goto err_alloc_domain;
>
> -       return 0;
> +       ret = vhost_vdpa_get_msi_cookie(v->domain, dma_dev);

Do we need to check the overlap mapping and record it in the interval
tree (as what VFIO did)?

Thanks

> +       if (ret)
> +               goto err_attach_device;
>
> -err_attach:
> +       return 0;
> +err_attach_device:
> +       iommu_detach_device(v->domain, dma_dev);
> +err_alloc_domain:
>         iommu_domain_free(v->domain);
>         return ret;
>  }
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
