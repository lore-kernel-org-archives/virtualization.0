Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD0C636D4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 12:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14CBA4024F;
	Mon, 13 Feb 2023 12:05:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14CBA4024F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIZS/NOe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKxCfSvTyHiI; Mon, 13 Feb 2023 12:05:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0545941496;
	Mon, 13 Feb 2023 12:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0545941496
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C09F9C0033;
	Mon, 13 Feb 2023 12:05:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 618CBC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35F7A60F82
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35F7A60F82
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIZS/NOe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DU1oYu4Rg3-h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:05:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AB576059B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AB576059B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676289928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UaQt4tD4vN8vEYX8llmTWE5DxpRIBPo44MMhOl7gUpg=;
 b=jIZS/NOehbZwJ+oCOLana2itEhso/tSF17Peck9PtSW9kI6K+trPFW3eMJubv1KI4fdnEJ
 mGair+9gTsrVkgKcFdzL5sKD2CcTUzse5p01RfIMwfPasnfH6rQP+Y6GWrDKHSvJptu5/h
 0Z3DEpVw9rCAkmzsmEfbFYmZfeESAd8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-nJj2pM77Pf2e6lTLi--jnQ-1; Mon, 13 Feb 2023 07:05:26 -0500
X-MC-Unique: nJj2pM77Pf2e6lTLi--jnQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 ud13-20020a170907c60d00b0088d773d11d6so7425878ejc.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 04:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaQt4tD4vN8vEYX8llmTWE5DxpRIBPo44MMhOl7gUpg=;
 b=G+O5mwqxT0SnlLV78DZcspcDsSuBanxhE69oJZItsJhXGFh9JGfpmC3rLjOGdHwQGn
 WGf7nSuVfHdI3w+kSQPdUQ3DwdxVNFO0EqithJV4chgUaHGVLBiwloq2/vcFATS57GdU
 CMnO8+84VAcmANtsrHFza1xVscd2+U8s1GoJKKQRYKTKrH94vI/inf7lakoe+lDi2vxm
 lLMmXtS1Rd0Cc7AEl1LpR2VLCJhtL41YYdY9MXlMIVuctmKazLggqCnHvyr6CRynsxbK
 oWHsXDPvr+S/yrNICeuDaf2HzJceteScvxDimbGkEmof2lB8stDLzeRSlqYctHeNNRrh
 fjzg==
X-Gm-Message-State: AO0yUKUX3uZZ6/VPef2yeHhBMbzswO//T+a4HHRhDfDPlZmMy09J1eU+
 bGIvUVHZeKqwGsduXHBVwRuIHWVRMkGte36Y0HpwdjEkfrK02pYFpPEbkp3GbxFAC4nukjAYYN5
 BcN56C6aV0CrjIqTYzV5a90Q61neZ/zh/hjPoagsQKQ==
X-Received: by 2002:a50:cc8f:0:b0:4aa:a9c7:4224 with SMTP id
 q15-20020a50cc8f000000b004aaa9c74224mr25967298edi.30.1676289925671; 
 Mon, 13 Feb 2023 04:05:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8C1H8SL3svwiLGRb2G1yS7hB3/rkA0BDJCFoYEwc0XZzusUMp7unwZ5t+nSHnK6QZN4dA0ag==
X-Received: by 2002:a50:cc8f:0:b0:4aa:a9c7:4224 with SMTP id
 q15-20020a50cc8f000000b004aaa9c74224mr25967266edi.30.1676289925379; 
 Mon, 13 Feb 2023 04:05:25 -0800 (PST)
Received: from redhat.com ([2.52.132.212]) by smtp.gmail.com with ESMTPSA id
 t16-20020a508d50000000b004acbe66e653sm2661308edt.84.2023.02.13.04.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Feb 2023 04:05:24 -0800 (PST)
Date: Mon, 13 Feb 2023 07:05:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] vdpasim: support doorbell mapping
Message-ID: <20230213070446-mutt-send-email-mst@kernel.org>
References: <20230129025034.2000-1-longpeng2@huawei.com>
 <20230129025034.2000-3-longpeng2@huawei.com>
 <CACGkMEvZsfxQW0fVdy0CpqxoWQzz6z=dYK__xFisncuSRms67A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvZsfxQW0fVdy0CpqxoWQzz6z=dYK__xFisncuSRms67A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, yechuan@huawei.com, eperezma@redhat.com,
 huangzhichao@huawei.com, stefanha@redhat.com,
 "Longpeng\(Mike\)" <longpeng2@huawei.com>,
 virtualization@lists.linux-foundation.org
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

On Sun, Jan 29, 2023 at 02:19:51PM +0800, Jason Wang wrote:
> On Sun, Jan 29, 2023 at 10:51 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
> >
> > From: Longpeng <longpeng2@huawei.com>
> >
> > Support doorbell mapping for vdpasim devices, then we can test the notify
> > passthrough feature even if there's no real hardware on hand.
> >
> > Allocates a dummy page which is used to emulate the notify page of the device,
> > all VQs share the same notify register  that initiated to 0xffff. A  periodic
> > work will check whether there're requests need to process ( the value of the
> > notify register is 0xffff or not ).
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 65 ++++++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index b071f0d842fb..4fcfeb6e2fb8 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -39,6 +39,8 @@ MODULE_PARM_DESC(max_iotlb_entries,
> >  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> >  #define VDPASIM_QUEUE_MAX 256
> >  #define VDPASIM_VENDOR_ID 0
> > +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> > +#define VDPASIM_NOTIFY_DEFVAL 0xffff
> >
> >  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >  {
> > @@ -246,6 +248,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
> >  static const struct vdpa_config_ops vdpasim_config_ops;
> >  static const struct vdpa_config_ops vdpasim_batch_config_ops;
> >
> > +static void vdpasim_notify_work(struct work_struct *work)
> > +{
> > +       struct vdpasim *vdpasim;
> > +       u16 *val;
> > +
> > +       vdpasim = container_of(work, struct vdpasim, notify_work.work);
> > +
> > +       if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +               goto out;
> > +
> > +       if (!vdpasim->running)
> > +               goto out;
> > +
> > +       val = (u16 *)vdpasim->notify;
> > +       if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
> > +               schedule_work(&vdpasim->work);
> > +
> > +out:
> > +       schedule_delayed_work(&vdpasim->notify_work,
> > +                             msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> > +}
> > +
> >  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >                                const struct vdpa_dev_set_config *config)
> >  {
> > @@ -287,6 +311,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         set_dma_ops(dev, &vdpasim_dma_ops);
> >         vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
> >
> > +       INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
> > +
> > +       vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +       if (!vdpasim->notify)
> > +               goto err_iommu;
> 
> We can simply avoid the advertising notification area in this case.
> 
> > +       *(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;
> 
> WRITE_ONCE()?

it is just initialization so it should not matter.

> > +
> >         vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> >         if (!vdpasim->config)
> >                 goto err_iommu;
> > @@ -498,16 +529,21 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
> >  static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       bool started = vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK;
> 
> Do we need to do the check under the vdpasim->lock?
> 
> >
> >         spin_lock(&vdpasim->lock);
> >         vdpasim->status = status;
> >         spin_unlock(&vdpasim->lock);
> > +       if (!started && (status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +               schedule_delayed_work(&vdpasim->notify_work,
> > +                                     msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> >  }
> >
> >  static int vdpasim_reset(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >
> > +       cancel_delayed_work_sync(&vdpasim->notify_work);
> 
> Do we need to do this after setting running to zero? Otherwise it's racy.
> 
> Thanks
> 
> >         spin_lock(&vdpasim->lock);
> >         vdpasim->status = 0;
> >         vdpasim_do_reset(vdpasim);
> > @@ -672,11 +708,34 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> >         return 0;
> >  }
> >
> > +static pgprot_t vdpasim_get_vq_notification_pgprot(struct vdpa_device *vdpa,
> > +                                                  u16 qid, pgprot_t prot)
> > +{
> > +       /*
> > +        * We use normal RAM pages to emulate the vq notification area, so
> > +        * just keep the pgprot as it mmaped.
> > +        */
> > +       return prot;
> > +}
> > +
> > +static struct vdpa_notification_area
> > +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> > +{
> > +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       struct vdpa_notification_area notify;
> > +
> > +       notify.addr = virt_to_phys((void *)vdpasim->notify);
> > +       notify.size = PAGE_SIZE;
> > +
> > +       return notify;
> > +}
> > +
> >  static void vdpasim_free(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >         int i;
> >
> > +       cancel_delayed_work_sync(&vdpasim->notify_work);
> >         cancel_work_sync(&vdpasim->work);
> >
> >         for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> > @@ -693,6 +752,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> >         vhost_iotlb_free(vdpasim->iommu);
> >         kfree(vdpasim->vqs);
> >         kfree(vdpasim->config);
> > +       if (vdpasim->notify)
> > +               free_page(vdpasim->notify);
> >  }
> >
> >  static const struct vdpa_config_ops vdpasim_config_ops = {
> > @@ -704,6 +765,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> >         .get_vq_ready           = vdpasim_get_vq_ready,
> >         .set_vq_state           = vdpasim_set_vq_state,
> >         .get_vq_state           = vdpasim_get_vq_state,
> > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > +       .get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
> >         .get_vq_align           = vdpasim_get_vq_align,
> >         .get_vq_group           = vdpasim_get_vq_group,
> >         .get_device_features    = vdpasim_get_device_features,
> > @@ -737,6 +800,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> >         .get_vq_ready           = vdpasim_get_vq_ready,
> >         .set_vq_state           = vdpasim_set_vq_state,
> >         .get_vq_state           = vdpasim_get_vq_state,
> > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > +       .get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
> >         .get_vq_align           = vdpasim_get_vq_align,
> >         .get_vq_group           = vdpasim_get_vq_group,
> >         .get_device_features    = vdpasim_get_device_features,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..0769ccbd3911 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -69,6 +69,9 @@ struct vdpasim {
> >         bool running;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> > +       /* dummy notify page */
> > +       unsigned long notify;
> > +       struct delayed_work notify_work;
> >  };
> >
> >  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> > --
> > 2.23.0
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
