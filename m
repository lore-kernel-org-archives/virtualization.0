Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBE3C43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 15:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 873B240640;
	Tue, 21 Jun 2022 15:20:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 873B240640
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRxB6WDh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EoCto-LC7ju3; Tue, 21 Jun 2022 15:20:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E864C404E0;
	Tue, 21 Jun 2022 15:20:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E864C404E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD2FFC0032;
	Tue, 21 Jun 2022 15:20:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6353C0082
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B7DC83F6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:20:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B7DC83F6D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRxB6WDh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R5uajEBO9mj2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:20:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE407812C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE407812C6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655824808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1aTQGCdCd/WCCg+CdRK2dqhWGiAOwiqqFPLYHWnZ4I=;
 b=gRxB6WDhbl+5LsBxxDdZmpCXqzr9RyN+nkmdg4in3Cc9AOZnREh/kdZ80+g6W5kQOgL8Yb
 m9PitzdL64PO9xfavzon8Xgj/ghI9ne7dTnGl+XE9fHVSxLCp76ve95+dznX2OsG6o7bJi
 23J5dyTX0ONoVTsuTiKQPoz/0UDzeYg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-tOiOsZz5MRejBbDFJ9fkFg-1; Tue, 21 Jun 2022 11:20:07 -0400
X-MC-Unique: tOiOsZz5MRejBbDFJ9fkFg-1
Received: by mail-qk1-f200.google.com with SMTP id
 f2-20020a05620a408200b006ab94bb9d09so12971874qko.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 08:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P1aTQGCdCd/WCCg+CdRK2dqhWGiAOwiqqFPLYHWnZ4I=;
 b=YqX0U3QqW/E/3rxZ5L6IVgUXGHfnV2y+NHTDV6YdHYmflxP3MqMsppOsx0ydTn3p8Z
 aTOxhc5evsfHI6iiU0B0kVVAT4n+dNw2biZYTtz5rVvuAtFc/Y1HOtBAVIEblQoEGSdW
 oRVQbCoL0DDqTkIFS7aVwcnsBzA2egNVhS4LK7I9K9SaBTY/pI9OeeamVqwS1DfYhdIS
 4FHA9RpVCrkYrM1h5DjQiH8jVSxXDsw7DEzS81eoKIeABc3JHd9zSDV/y4vy+GUli2Vl
 oOnK4u6FBtroScby7FptH58BoigndM6sbcDAnwAs6o9IOGvG7yWhcEDXoWj3+WKCYKTI
 G29w==
X-Gm-Message-State: AJIora9cs6ZYgpOYMMVt8e3zl/SC3feoc622F6b60z0Dn1Su+UoAw7V5
 DT3W8wZFH+aIIK50zID7R0LV7LkCn2Xdr20xHQfeHaUaVwmDV/eiGxwXE+lir4CLow0vhARYR11
 lKVKcqI5g8vn84CxoSBnkWOPflfHXth6o/JkhgqKMmg==
X-Received: by 2002:a05:622a:f:b0:304:ea08:4227 with SMTP id
 x15-20020a05622a000f00b00304ea084227mr24100696qtw.620.1655824806129; 
 Tue, 21 Jun 2022 08:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ugXnBnBHfSF1q+MNVy/kX/HyG2xqvUeAd8GBefFNsnB10JRRI6pctEPRk+wurKNpL2uMxC1Q==
X-Received: by 2002:a05:622a:f:b0:304:ea08:4227 with SMTP id
 x15-20020a05622a000f00b00304ea084227mr24100667qtw.620.1655824805766; 
 Tue, 21 Jun 2022 08:20:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 bl38-20020a05620a1aa600b006a6bbc2725esm14686589qkb.118.2022.06.21.08.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jun 2022 08:20:05 -0700 (PDT)
Date: Tue, 21 Jun 2022 17:19:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gautam Dawar <gautam.dawar@xilinx.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 19/19] vdpasim: control virtqueue support
Message-ID: <CAGxU2F6OO108oHsrLBWJnYRG2yRU8QnRxAdjJhUUcp8AqaAP-g@mail.gmail.com>
References: <20220330180436.24644-1-gdawar@xilinx.com>
 <20220330180436.24644-20-gdawar@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <20220330180436.24644-20-gdawar@xilinx.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, pabloc@xilinx.com,
 Eli Cohen <elic@nvidia.com>, Zhang Min <zhang.min9@zte.com.cn>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, dinang@xilinx.com,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Gautam Dawar <gdawar@xilinx.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 netdev <netdev@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>,
 ecree.xilinx@gmail.com, Harpreet Singh Anand <hanand@xilinx.com>,
 martinpo@xilinx.com, Zhu Lingshan <lingshan.zhu@intel.com>
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

Hi Gautam,

On Wed, Mar 30, 2022 at 8:21 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>
> This patch introduces the control virtqueue support for vDPA
> simulator. This is a requirement for supporting advanced features like
> multiqueue.
>
> A requirement for control virtqueue is to isolate its memory access
> from the rx/tx virtqueues. This is because when using vDPA device
> for VM, the control virqueue is not directly assigned to VM. Userspace
> (Qemu) will present a shadow control virtqueue to control for
> recording the device states.
>
> The isolation is done via the virtqueue groups and ASID support in
> vDPA through vhost-vdpa. The simulator is extended to have:
>
> 1) three virtqueues: RXVQ, TXVQ and CVQ (control virtqueue)
> 2) two virtqueue groups: group 0 contains RXVQ and TXVQ; group 1
>    contains CVQ
> 3) two address spaces and the simulator simply implements the address
>    spaces by mapping it 1:1 to IOTLB.
>
> For the VM use cases, userspace(Qemu) may set AS 0 to group 0 and AS 1
> to group 1. So we have:
>
> 1) The IOTLB for virtqueue group 0 contains the mappings of guest, so
>    RX and TX can be assigned to guest directly.
> 2) The IOTLB for virtqueue group 1 contains the mappings of CVQ which
>    is the buffers that allocated and managed by VMM only. So CVQ of
>    vhost-vdpa is visible to VMM only. And Guest can not access the CVQ
>    of vhost-vdpa.
>
> For the other use cases, since AS 0 is associated to all virtqueue
> groups by default. All virtqueues share the same mapping by default.
>
> To demonstrate the function, VIRITO_NET_F_CTRL_MACADDR is
> implemented in the simulator for the driver to set mac address.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 91 ++++++++++++++++++++++------
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  2 +
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 88 ++++++++++++++++++++++++++-
>  3 files changed, 161 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 659e2e2e4b0c..51bd0bafce06 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -96,11 +96,17 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
>  {
>         int i;
>
> -       for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
> +       spin_lock(&vdpasim->iommu_lock);
> +
> +       for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
>                 vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
> +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
> +                                &vdpasim->iommu_lock);
> +       }
> +
> +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> +               vhost_iotlb_reset(&vdpasim->iommu[i]);
>
> -       spin_lock(&vdpasim->iommu_lock);
> -       vhost_iotlb_reset(vdpasim->iommu);
>         spin_unlock(&vdpasim->iommu_lock);
>
>         vdpasim->features = 0;
> @@ -145,7 +151,7 @@ static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>         dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>
>         spin_lock(&vdpasim->iommu_lock);
> -       ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
> +       ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
>                                     (u64)dma_addr + size - 1, (u64)paddr, perm);
>         spin_unlock(&vdpasim->iommu_lock);
>
> @@ -161,7 +167,7 @@ static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>                                 size_t size)
>  {
>         spin_lock(&vdpasim->iommu_lock);
> -       vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
> +       vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
>                               (u64)dma_addr + size - 1);
>         spin_unlock(&vdpasim->iommu_lock);
>
> @@ -250,8 +256,9 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>         else
>                 ops = &vdpasim_config_ops;
>
> -       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, 1,
> -                                   1, dev_attr->name, false);
> +       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> +                                   dev_attr->ngroups, dev_attr->nas,
> +                                   dev_attr->name, false);
>         if (IS_ERR(vdpasim)) {
>                 ret = PTR_ERR(vdpasim);
>                 goto err_alloc;
> @@ -278,16 +285,20 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>         if (!vdpasim->vqs)
>                 goto err_iommu;
>
> -       vdpasim->iommu = vhost_iotlb_alloc(max_iotlb_entries, 0);
> +       vdpasim->iommu = kmalloc_array(vdpasim->dev_attr.nas,
> +                                      sizeof(*vdpasim->iommu), GFP_KERNEL);
>         if (!vdpasim->iommu)
>                 goto err_iommu;
>
> +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
> +               vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
> +
>         vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
>         if (!vdpasim->buffer)
>                 goto err_iommu;
>
>         for (i = 0; i < dev_attr->nvqs; i++)
> -               vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu,
> +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>                                  &vdpasim->iommu_lock);
>
>         ret = iova_cache_get();
> @@ -401,7 +412,11 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>
>  static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
>  {
> -       return 0;
> +       /* RX and TX belongs to group 0, CVQ belongs to group 1 */
> +       if (idx == 2)
> +               return 1;
> +       else
> +               return 0;

This code only works for the vDPA-net simulator, since 
vdpasim_get_vq_group() is also shared with other simulators (e.g.  
vdpa_sim_blk), should we move this net-specific code into 
vdpa_sim_net.c, maybe adding a callback implemented by the different 
simulators?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
