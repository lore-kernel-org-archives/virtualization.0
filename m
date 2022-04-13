Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1798FC433FE
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 08:54:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A28FC81CC3;
	Wed, 13 Apr 2022 08:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G-BlhIuVd5Vc; Wed, 13 Apr 2022 08:54:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C683C819E6;
	Wed, 13 Apr 2022 08:54:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA58C002F;
	Wed, 13 Apr 2022 08:54:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCD15C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 958C341701
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sl0zvkzn6Iyb
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:54:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6AAB416EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649840086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4I1Thc95eXkMkw7mMfQtqcBx+DUgODD/HDaM3C4awEk=;
 b=iZ9g0WOQcF2GbZo9+Tc7UXPn2G69Ox5oPzFE4Vw8lzLBP+aZxApmdMExK8XJl+5mkOc+z5
 2jd7X4FNYeqAj/Iqe4/A7cnHmypzUYjltW7TxvBNk9c2v9mzN/RIo4PSFUsr0Uw15eht0j
 TRB5fs+20TgfYUrMeB5e5GBPJzyMMr0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-qF8bZpeiNqOR7lgX_Tkpew-1; Wed, 13 Apr 2022 04:54:45 -0400
X-MC-Unique: qF8bZpeiNqOR7lgX_Tkpew-1
Received: by mail-wr1-f70.google.com with SMTP id
 r10-20020adfc10a000000b00207a2c7bcf6so185528wre.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 01:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4I1Thc95eXkMkw7mMfQtqcBx+DUgODD/HDaM3C4awEk=;
 b=MZBmhKEVLvEz3eY2/VyuEJXkYPsM62YnlV8WV5SQ9GPTKSLNLj7H9Y83wf/oB46tnB
 RDAqDoW0ZqDX8ZphZucrlzMNEuYfURuzLJaOaPA0438W+fndce/ZhvK+9chJsvsSjBDl
 pZB7jSk3najxr5+uJhWUjNk25qE6SPSnxEgEhOl7MXnELODJRuFZkCQy3VJJMnT+qGA7
 ZswpTna7slNY9Gd+mvYD/aRekx3UPw2I8yHdTssdo4sgGVe5AMSrcBj0Gv30Ef530oHe
 1ppsMYHGQOP2kXY0odkdoGgjVOl+HYnrurWAXcMETpZ3RmHOuzWtboIYdKwS/2p9x8qQ
 Zllw==
X-Gm-Message-State: AOAM530+jSywobqIGxhaV0aL6AynO75q7pHUkuRlZJzcMVSmDZuSGhe0
 F3oNxlFzkeRMQBozI65cBv7C2fKtnXf35tGbqwCnObTvlQRvtg5hSN0PrgYTenI7WT/3FeDMGPw
 L60ezr+NmcICUnqakfMI6xDMqw5NTNXfi2uYhOwPa3A==
X-Received: by 2002:a05:6000:1acc:b0:204:2ae7:da14 with SMTP id
 i12-20020a0560001acc00b002042ae7da14mr31675764wry.609.1649840084049; 
 Wed, 13 Apr 2022 01:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR3DWdqkeBo0XumWWftT5naoJWAhI0n5nGgikkkV1vKRGXohROXCec6zm5AOl3cto90z63tw==
X-Received: by 2002:a05:6000:1acc:b0:204:2ae7:da14 with SMTP id
 i12-20020a0560001acc00b002042ae7da14mr31675743wry.609.1649840083747; 
 Wed, 13 Apr 2022 01:54:43 -0700 (PDT)
Received: from redhat.com ([2.55.135.33]) by smtp.gmail.com with ESMTPSA id
 j36-20020a05600c1c2400b0038ec526a0e3sm2196199wms.9.2022.04.13.01.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 01:54:43 -0700 (PDT)
Date: Wed, 13 Apr 2022 04:54:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vDPA/ifcvf: allow userspace to suspend a queue
Message-ID: <20220413045223-mutt-send-email-mst@kernel.org>
References: <20220411031057.162485-1-lingshan.zhu@intel.com>
 <CACGkMEu7dUYKr7Nv-fDFFBM4M1hvWuO8P17xNMEkwofiiP178A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEu7dUYKr7Nv-fDFFBM4M1hvWuO8P17xNMEkwofiiP178A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Apr 13, 2022 at 04:25:22PM +0800, Jason Wang wrote:
> On Mon, Apr 11, 2022 at 11:18 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> >
> > Formerly, ifcvf driver has implemented a lazy-initialization mechanism
> > for the virtqueues, it would store all virtqueue config fields that
> > passed down from the userspace, then load them to the virtqueues and
> > enable the queues upon DRIVER_OK.
> >
> > To allow the userspace to suspend a virtqueue,
> > this commit passes queue_enable to the virtqueue directly through
> > set_vq_ready().
> >
> > This feature requires and this commits implementing all virtqueue
> > ops(set_vq_addr, set_vq_num and set_vq_ready) to take immediate
> > actions than lazy-initialization, so ifcvf_hw_enable() is retired.
> >
> > To avoid losing virtqueue configurations caused by multiple
> > rounds of reset(), this commit also refactors thed evice reset
> > routine, now it simply reset the config handler and the virtqueues,
> > and only once device-reset().
> >
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >  drivers/vdpa/ifcvf/ifcvf_base.c | 94 ++++++++++++++++++++-------------
> >  drivers/vdpa/ifcvf/ifcvf_base.h | 11 ++--
> >  drivers/vdpa/ifcvf/ifcvf_main.c | 57 +++++---------------
> >  3 files changed, 75 insertions(+), 87 deletions(-)
> >
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > index 48c4dadb0c7c..19eb0dcac123 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > @@ -175,16 +175,12 @@ u8 ifcvf_get_status(struct ifcvf_hw *hw)
> >  void ifcvf_set_status(struct ifcvf_hw *hw, u8 status)
> >  {
> >         vp_iowrite8(status, &hw->common_cfg->device_status);
> > +       vp_ioread8(&hw->common_cfg->device_status);
> 
> This looks confusing, the name of the function is to set the status
> but what actually implemented here is to get the status.
> 
> >  }
> >
> >  void ifcvf_reset(struct ifcvf_hw *hw)
> >  {
> > -       hw->config_cb.callback = NULL;
> > -       hw->config_cb.private = NULL;
> > -
> >         ifcvf_set_status(hw, 0);
> > -       /* flush set_status, make sure VF is stopped, reset */
> > -       ifcvf_get_status(hw);
> >  }
> >
> >  static void ifcvf_add_status(struct ifcvf_hw *hw, u8 status)
> > @@ -331,68 +327,94 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
> >         ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
> >         q_pair_id = qid / hw->nr_vring;
> >         avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
> > -       hw->vring[qid].last_avail_idx = num;
> >         vp_iowrite16(num, avail_idx_addr);
> > +       vp_ioread16(avail_idx_addr);
> 
> This looks like a bug fix.

is this to flush out the status write?  pls add a comment
explaining when and why it's needed.

> >
> >         return 0;
> >  }
> >
> > -static int ifcvf_hw_enable(struct ifcvf_hw *hw)
> > +void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num)
> >  {
> > -       struct virtio_pci_common_cfg __iomem *cfg;
> > -       u32 i;
> > +       struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> >
> > -       cfg = hw->common_cfg;
> > -       for (i = 0; i < hw->nr_vring; i++) {
> > -               if (!hw->vring[i].ready)
> > -                       break;
> > +       vp_iowrite16(qid, &cfg->queue_select);
> > +       vp_iowrite16(num, &cfg->queue_size);
> > +       vp_ioread16(&cfg->queue_size);
> > +}
> >
> > -               vp_iowrite16(i, &cfg->queue_select);
> > -               vp_iowrite64_twopart(hw->vring[i].desc, &cfg->queue_desc_lo,
> > -                                    &cfg->queue_desc_hi);
> > -               vp_iowrite64_twopart(hw->vring[i].avail, &cfg->queue_avail_lo,
> > -                                     &cfg->queue_avail_hi);
> > -               vp_iowrite64_twopart(hw->vring[i].used, &cfg->queue_used_lo,
> > -                                    &cfg->queue_used_hi);
> > -               vp_iowrite16(hw->vring[i].size, &cfg->queue_size);
> > -               ifcvf_set_vq_state(hw, i, hw->vring[i].last_avail_idx);
> > -               vp_iowrite16(1, &cfg->queue_enable);
> > -       }
> > +int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
> > +                        u64 driver_area, u64 device_area)
> > +{
> > +       struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> > +
> > +       vp_iowrite16(qid, &cfg->queue_select);
> > +       vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
> > +                            &cfg->queue_desc_hi);
> > +       vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
> > +                            &cfg->queue_avail_hi);
> > +       vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
> > +                            &cfg->queue_used_hi);
> > +       /* to flush IO */
> > +       vp_ioread16(&cfg->queue_select);
> 
> Why do we need to flush I/O here?
> 
> >
> >         return 0;
> >  }
> >
> > -static void ifcvf_hw_disable(struct ifcvf_hw *hw)
> > +void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
> >  {
> > -       u32 i;
> > +       struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> >
> > -       ifcvf_set_config_vector(hw, VIRTIO_MSI_NO_VECTOR);
> > -       for (i = 0; i < hw->nr_vring; i++) {
> > -               ifcvf_set_vq_vector(hw, i, VIRTIO_MSI_NO_VECTOR);
> > -       }
> > +       vp_iowrite16(qid, &cfg->queue_select);
> > +       vp_iowrite16(ready, &cfg->queue_enable);
> 
> I think we need a comment to explain that IFCVF can support write to
> queue_enable since it's not allowed by the virtio spec.


I think you mean writing 0 there. writing 1 is allowed.


> 
> > +       vp_ioread16(&cfg->queue_enable);
> > +}
> > +
> > +bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid)
> > +{
> > +       struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
> > +       bool queue_enable;
> > +
> > +       vp_iowrite16(qid, &cfg->queue_select);
> > +       queue_enable = vp_ioread16(&cfg->queue_enable);
> > +
> > +       return (bool)queue_enable;
> >  }
> >
> >  int ifcvf_start_hw(struct ifcvf_hw *hw)
> >  {
> > -       ifcvf_reset(hw);
> >         ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >         ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
> >
> >         if (ifcvf_config_features(hw) < 0)
> >                 return -EINVAL;
> >
> > -       if (ifcvf_hw_enable(hw) < 0)
> > -               return -EINVAL;
> > -
> >         ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
> >
> >         return 0;
> >  }
> >
> > +static void ifcvf_reset_vring(struct ifcvf_hw *hw)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < hw->nr_vring; i++) {
> > +               hw->vring[i].cb.callback = NULL;
> > +               hw->vring[i].cb.private = NULL;
> > +               ifcvf_set_vq_vector(hw, i, VIRTIO_MSI_NO_VECTOR);
> > +       }
> > +}
> > +
> > +static void ifcvf_reset_config_handler(struct ifcvf_hw *hw)
> > +{
> > +       hw->config_cb.callback = NULL;
> > +       hw->config_cb.private = NULL;
> > +       ifcvf_set_config_vector(hw, VIRTIO_MSI_NO_VECTOR);
> 
> Do we need to synchronize with the IRQ here?
> 
> > +}
> > +
> >  void ifcvf_stop_hw(struct ifcvf_hw *hw)
> >  {
> > -       ifcvf_hw_disable(hw);
> > -       ifcvf_reset(hw);
> > +       ifcvf_reset_vring(hw);
> > +       ifcvf_reset_config_handler(hw);
> >  }
> >
> >  void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid)
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> > index 115b61f4924b..41d86985361f 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> > +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> > @@ -49,12 +49,6 @@
> >  #define MSIX_VECTOR_DEV_SHARED                 3
> >
> >  struct vring_info {
> > -       u64 desc;
> > -       u64 avail;
> > -       u64 used;
> > -       u16 size;
> > -       u16 last_avail_idx;
> > -       bool ready;
> >         void __iomem *notify_addr;
> >         phys_addr_t notify_pa;
> >         u32 irq;
> > @@ -131,6 +125,11 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
> >  struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
> >  int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
> >  u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
> > +int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
> > +                        u64 driver_area, u64 device_area);
> >  u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
> >  u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
> > +void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num);
> > +void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
> > +bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
> >  #endif /* _IFCVF_H_ */
> > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> > index 4366320fb68d..e442aa11333e 100644
> > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > @@ -374,37 +374,6 @@ static int ifcvf_start_datapath(void *private)
> >         return ret;
> >  }
> >
> > -static int ifcvf_stop_datapath(void *private)
> > -{
> > -       struct ifcvf_hw *vf = ifcvf_private_to_vf(private);
> > -       int i;
> > -
> > -       for (i = 0; i < vf->nr_vring; i++)
> > -               vf->vring[i].cb.callback = NULL;
> > -
> > -       ifcvf_stop_hw(vf);
> > -
> > -       return 0;
> > -}
> > -
> > -static void ifcvf_reset_vring(struct ifcvf_adapter *adapter)
> > -{
> > -       struct ifcvf_hw *vf = ifcvf_private_to_vf(adapter);
> > -       int i;
> > -
> > -       for (i = 0; i < vf->nr_vring; i++) {
> > -               vf->vring[i].last_avail_idx = 0;
> > -               vf->vring[i].desc = 0;
> > -               vf->vring[i].avail = 0;
> > -               vf->vring[i].used = 0;
> > -               vf->vring[i].ready = 0;
> > -               vf->vring[i].cb.callback = NULL;
> > -               vf->vring[i].cb.private = NULL;
> > -       }
> > -
> > -       ifcvf_reset(vf);
> > -}
> > -
> >  static struct ifcvf_adapter *vdpa_to_adapter(struct vdpa_device *vdpa_dev)
> >  {
> >         return container_of(vdpa_dev, struct ifcvf_adapter, vdpa);
> > @@ -477,6 +446,8 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
> >         if (status_old == status)
> >                 return;
> >
> > +       ifcvf_set_status(vf, status);
> > +
> >         if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> >             !(status_old & VIRTIO_CONFIG_S_DRIVER_OK)) {
> >                 ret = ifcvf_request_irq(adapter);
> 
> Does this mean e.g for DRIVER_OK the device may work before the
> interrupt handler is requested?
> 
> Looks racy.
> 
> Thanks
> 
> > @@ -493,7 +464,6 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
> >                                   status);
> >         }
> >
> > -       ifcvf_set_status(vf, status);
> >  }
> >
> >  static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
> > @@ -509,12 +479,10 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
> >         if (status_old == 0)
> >                 return 0;
> >
> > -       if (status_old & VIRTIO_CONFIG_S_DRIVER_OK) {
> > -               ifcvf_stop_datapath(adapter);
> > -               ifcvf_free_irq(adapter);
> > -       }
> > +       ifcvf_stop_hw(vf);
> > +       ifcvf_free_irq(adapter);
> >
> > -       ifcvf_reset_vring(adapter);
> > +       ifcvf_reset(vf);
> >
> >         return 0;
> >  }
> > @@ -554,14 +522,17 @@ static void ifcvf_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev,
> >  {
> >         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> >
> > -       vf->vring[qid].ready = ready;
> > +       ifcvf_set_vq_ready(vf, qid, ready);
> >  }
> >
> >  static bool ifcvf_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
> >  {
> >         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> > +       bool ready;
> >
> > -       return vf->vring[qid].ready;
> > +       ready = ifcvf_get_vq_ready(vf, qid);
> > +
> > +       return ready;
> >  }
> >
> >  static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
> > @@ -569,7 +540,7 @@ static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
> >  {
> >         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> >
> > -       vf->vring[qid].size = num;
> > +       ifcvf_set_vq_num(vf, qid, num);
> >  }
> >
> >  static int ifcvf_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid,
> > @@ -578,11 +549,7 @@ static int ifcvf_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid,
> >  {
> >         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> >
> > -       vf->vring[qid].desc = desc_area;
> > -       vf->vring[qid].avail = driver_area;
> > -       vf->vring[qid].used = device_area;
> > -
> > -       return 0;
> > +       return ifcvf_set_vq_address(vf, qid, desc_area, driver_area, device_area);
> >  }
> >
> >  static void ifcvf_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
> > --
> > 2.31.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
