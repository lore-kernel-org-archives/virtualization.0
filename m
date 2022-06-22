Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B759C43334
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 15:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F11A404F3;
	Wed, 22 Jun 2022 15:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F11A404F3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ih8KE7Ek
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dk5Xq2Fy5j8s; Wed, 22 Jun 2022 15:44:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 63AE540012;
	Wed, 22 Jun 2022 15:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63AE540012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44233C0032;
	Wed, 22 Jun 2022 15:44:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C946BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9554B83F36
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9554B83F36
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ih8KE7Ek
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NNRfWDbJIutv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A70484013
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A70484013
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655912692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ihQ51bcQWrzbwEBEWv0BHU9ir5A3unDKhLlROclaoHU=;
 b=ih8KE7EkxSv52VQhowjTwci3hilEtZVrNBEHeDTP1QJDbDLxPOB4nQHe60Os07XQUcprtY
 DPFrRCScl1bgyLd6xl1ijv70K1Zw/rjGaBk+zfHyUfCOCwhAFkYAWJnHA7ADPnE1dFkqUG
 6NyurRbDoxNh5J3YIvf2N3Ean/sucis=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-y4J2mutBOBakKHrtwdvKuA-1; Wed, 22 Jun 2022 11:44:51 -0400
X-MC-Unique: y4J2mutBOBakKHrtwdvKuA-1
Received: by mail-wr1-f71.google.com with SMTP id
 r20-20020adfb1d4000000b0021b8507563eso3051157wra.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ihQ51bcQWrzbwEBEWv0BHU9ir5A3unDKhLlROclaoHU=;
 b=zpV1YgQriT2+BFv2eXE+AqzLIoyMwlmfghZOCQ7lEDT9oft566f4Dphxgx8+NK9flI
 8l2qdtd3vjNTUrkUAp578hm3lnqffblFR0G6++X4YPXPNaHb3eQVFPS9DdVc0q03A/FC
 Sz1H8EWAwjljtwXHj1aZDsX9/gNgieu16IOcjqxTNs7U5o7iVLvqXvKbP4wGHxHjnOQY
 WSSIrXz3XamYb/FYNZ/w0HaI+blue3NF40jLE8SsW83o2dGUNzl/FUYQKNujnaOFfALf
 qCCRZnR9vKD5Tsaj6wITUGilH5h9AFqUKVnkzvlsSZo5n2uOaNIuraduYOOfFMPr/B0i
 61Uw==
X-Gm-Message-State: AJIora9O4ro+rG4qP3Ekc4yPh0ftEXaYjOr+nyy6vHYTRLG4rNKJLRGb
 y/+cCql+ZFYKMF8QoaHPEK6KiP1RXoAvLDVA+GSh+3pdX3dyWjJ6id6s8ciqjreZBAzK9tkYp/C
 yOoiP6C6iAzQGxU1eamfSKrPI8CCW8JoHvHBR5WTrLA==
X-Received: by 2002:adf:e252:0:b0:21b:827e:4c63 with SMTP id
 bl18-20020adfe252000000b0021b827e4c63mr4009480wrb.307.1655912689734; 
 Wed, 22 Jun 2022 08:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7iQW1o9hu0M1BscDqcuqnTBsDy17WvRImGANcMHb/fY6669Lsq7nWLjQNBG3zGujOvpBU4Q==
X-Received: by 2002:adf:e252:0:b0:21b:827e:4c63 with SMTP id
 bl18-20020adfe252000000b0021b827e4c63mr4009443wrb.307.1655912689458; 
 Wed, 22 Jun 2022 08:44:49 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 y6-20020a5d6206000000b0021350f7b22esm21860297wru.109.2022.06.22.08.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jun 2022 08:44:48 -0700 (PDT)
Date: Wed, 22 Jun 2022 17:44:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2 19/19] vdpasim: control virtqueue support
Message-ID: <20220622154444.tjx5ehw47pqyjzjt@sgarzare-redhat>
References: <20220330180436.24644-1-gdawar@xilinx.com>
 <20220330180436.24644-20-gdawar@xilinx.com>
 <CAGxU2F6OO108oHsrLBWJnYRG2yRU8QnRxAdjJhUUcp8AqaAP-g@mail.gmail.com>
 <CAJaqyWd8MR9vTRcCTktzC3VL054x5H5_sXy+MLVNewFDkjQUSw@mail.gmail.com>
 <CAJaqyWc36adK-gUzc8tMgDDe5SoBPy7xN-UtcFA4=aDezdJ5LA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWc36adK-gUzc8tMgDDe5SoBPy7xN-UtcFA4=aDezdJ5LA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Kamde, Tanuj" <tanuj.kamde@amd.com>, kvm <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
 Pablo Cascon Katchadourian <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>,
 Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, Dinan Gunawardena <dinang@xilinx.com>,
 habetsm.xilinx@gmail.com, Longpeng <longpeng2@huawei.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Gautam Dawar <gdawar@xilinx.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Gautam Dawar <gautam.dawar@xilinx.com>, netdev <netdev@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>, ecree.xilinx@gmail.com,
 Harpreet Singh Anand <hanand@xilinx.com>, Martin Porter <martinpo@xilinx.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 22, 2022 at 05:04:44PM +0200, Eugenio Perez Martin wrote:
>On Wed, Jun 22, 2022 at 12:21 PM Eugenio Perez Martin
><eperezma@redhat.com> wrote:
>>
>> On Tue, Jun 21, 2022 at 5:20 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > Hi Gautam,
>> >
>> > On Wed, Mar 30, 2022 at 8:21 PM Gautam Dawar <gautam.dawar@xilinx.com> wrote:
>> > >
>> > > This patch introduces the control virtqueue support for vDPA
>> > > simulator. This is a requirement for supporting advanced features like
>> > > multiqueue.
>> > >
>> > > A requirement for control virtqueue is to isolate its memory access
>> > > from the rx/tx virtqueues. This is because when using vDPA device
>> > > for VM, the control virqueue is not directly assigned to VM. Userspace
>> > > (Qemu) will present a shadow control virtqueue to control for
>> > > recording the device states.
>> > >
>> > > The isolation is done via the virtqueue groups and ASID support in
>> > > vDPA through vhost-vdpa. The simulator is extended to have:
>> > >
>> > > 1) three virtqueues: RXVQ, TXVQ and CVQ (control virtqueue)
>> > > 2) two virtqueue groups: group 0 contains RXVQ and TXVQ; group 1
>> > >    contains CVQ
>> > > 3) two address spaces and the simulator simply implements the address
>> > >    spaces by mapping it 1:1 to IOTLB.
>> > >
>> > > For the VM use cases, userspace(Qemu) may set AS 0 to group 0 and AS 1
>> > > to group 1. So we have:
>> > >
>> > > 1) The IOTLB for virtqueue group 0 contains the mappings of guest, so
>> > >    RX and TX can be assigned to guest directly.
>> > > 2) The IOTLB for virtqueue group 1 contains the mappings of CVQ which
>> > >    is the buffers that allocated and managed by VMM only. So CVQ of
>> > >    vhost-vdpa is visible to VMM only. And Guest can not access the CVQ
>> > >    of vhost-vdpa.
>> > >
>> > > For the other use cases, since AS 0 is associated to all virtqueue
>> > > groups by default. All virtqueues share the same mapping by default.
>> > >
>> > > To demonstrate the function, VIRITO_NET_F_CTRL_MACADDR is
>> > > implemented in the simulator for the driver to set mac address.
>> > >
>> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > > Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
>> > > ---
>> > >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 91 ++++++++++++++++++++++------
>> > >  drivers/vdpa/vdpa_sim/vdpa_sim.h     |  2 +
>> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 88 ++++++++++++++++++++++++++-
>> > >  3 files changed, 161 insertions(+), 20 deletions(-)
>> > >
>> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > index 659e2e2e4b0c..51bd0bafce06 100644
>> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> > > @@ -96,11 +96,17 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
>> > >  {
>> > >         int i;
>> > >
>> > > -       for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
>> > > +       spin_lock(&vdpasim->iommu_lock);
>> > > +
>> > > +       for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
>> > >                 vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
>> > > +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>> > > +                                &vdpasim->iommu_lock);
>> > > +       }
>> > > +
>> > > +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
>> > > +               vhost_iotlb_reset(&vdpasim->iommu[i]);
>> > >
>> > > -       spin_lock(&vdpasim->iommu_lock);
>> > > -       vhost_iotlb_reset(vdpasim->iommu);
>> > >         spin_unlock(&vdpasim->iommu_lock);
>> > >
>> > >         vdpasim->features = 0;
>> > > @@ -145,7 +151,7 @@ static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>> > >         dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>> > >
>> > >         spin_lock(&vdpasim->iommu_lock);
>> > > -       ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
>> > > +       ret = vhost_iotlb_add_range(&vdpasim->iommu[0], (u64)dma_addr,
>> > >                                     (u64)dma_addr + size - 1, (u64)paddr, perm);
>> > >         spin_unlock(&vdpasim->iommu_lock);
>> > >
>> > > @@ -161,7 +167,7 @@ static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>> > >                                 size_t size)
>> > >  {
>> > >         spin_lock(&vdpasim->iommu_lock);
>> > > -       vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
>> > > +       vhost_iotlb_del_range(&vdpasim->iommu[0], (u64)dma_addr,
>> > >                               (u64)dma_addr + size - 1);
>> > >         spin_unlock(&vdpasim->iommu_lock);
>> > >
>> > > @@ -250,8 +256,9 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>> > >         else
>> > >                 ops = &vdpasim_config_ops;
>> > >
>> > > -       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, 1,
>> > > -                                   1, dev_attr->name, false);
>> > > +       vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>> > > +                                   dev_attr->ngroups, dev_attr->nas,
>> > > +                                   dev_attr->name, false);
>> > >         if (IS_ERR(vdpasim)) {
>> > >                 ret = PTR_ERR(vdpasim);
>> > >                 goto err_alloc;
>> > > @@ -278,16 +285,20 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>> > >         if (!vdpasim->vqs)
>> > >                 goto err_iommu;
>> > >
>> > > -       vdpasim->iommu = vhost_iotlb_alloc(max_iotlb_entries, 0);
>> > > +       vdpasim->iommu = kmalloc_array(vdpasim->dev_attr.nas,
>> > > +                                      sizeof(*vdpasim->iommu), GFP_KERNEL);
>> > >         if (!vdpasim->iommu)
>> > >                 goto err_iommu;
>> > >
>> > > +       for (i = 0; i < vdpasim->dev_attr.nas; i++)
>> > > +               vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
>> > > +
>> > >         vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
>> > >         if (!vdpasim->buffer)
>> > >                 goto err_iommu;
>> > >
>> > >         for (i = 0; i < dev_attr->nvqs; i++)
>> > > -               vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu,
>> > > +               vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
>> > >                                  &vdpasim->iommu_lock);
>> > >
>> > >         ret = iova_cache_get();
>> > > @@ -401,7 +412,11 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>> > >
>> > >  static u32 vdpasim_get_vq_group(struct vdpa_device *vdpa, u16 idx)
>> > >  {
>> > > -       return 0;
>> > > +       /* RX and TX belongs to group 0, CVQ belongs to group 1 */
>> > > +       if (idx == 2)
>> > > +               return 1;
>> > > +       else
>> > > +               return 0;
>> >
>> > This code only works for the vDPA-net simulator, since
>> > vdpasim_get_vq_group() is also shared with other simulators (e.g.
>> > vdpa_sim_blk),
>>
>> That's totally right.
>>
>> > should we move this net-specific code into
>> > vdpa_sim_net.c, maybe adding a callback implemented by the different
>> > simulators?
>> >
>>
>> At this moment, VDPASIM_BLK_VQ_NUM is fixed to 1, so maybe the right
>> thing to do for the -rc phase is to check if idx > vdpasim.attr.nvqs?
>> It's a more general fix.
>>
>
>Actually, that is already checked by vhost/vdpa.c.
>
>Taking that into account, is it worth introducing the change for 5.19?
>I'm totally ok with the change for 5.20.
>
>Thanks!
>
>> For the general case, yes, a callback should be issued to the actual
>> simulator so it's not a surprise when VDPASIM_BLK_VQ_NUM increases,
>> either dynamically or by anyone testing it.

Exactly, since those parameters are not yet configurable at runtime 
(someday I hope they will be), I often recompile the module by changing 
them, so for me we should fix them in 5.19.

Obviously it's an advanced case, and I expect that if someone recompiles 
the module changing some hardwired thing, they can expect to have to 
change something else as well.

So, I'm also fine with leaving it that way for 5.19, but if you want I 
can fix it earlier.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
