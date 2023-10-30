Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5BBC4332F
	for <virtualization@archiver.kernel.org>; Mon, 30 Oct 2023 15:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BF0460743;
	Mon, 30 Oct 2023 15:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BF0460743
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JSu/5pdA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DIANa7NFyA7Q; Mon, 30 Oct 2023 15:59:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9565F6070A;
	Mon, 30 Oct 2023 15:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9565F6070A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B8CEC0071;
	Mon, 30 Oct 2023 15:59:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5E98C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DBC96070A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DBC96070A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lKQCscG9tfQm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:59:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38E8C60737
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 15:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 38E8C60737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698681588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IIgh8kG2TQT8ChaB+uGYIXXsWLNdP6VpZ6rpKcqCXY=;
 b=JSu/5pdASTEXwPQorStifCn2vvjsInbsJjmpIvl4lY8KH2JHy8fJptZW7OdSTCidCPKSHo
 c3BLfIXRvTUFY/Au8SPiLYOb/KBU7OvXybtVEM6e6IhRKnfWdGUKPQUVuyDoy8OOxss0B5
 qxw+A5suam6/FWF1G+ipKKCvsB6GodU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ZCjU3wRFO7CsuMrc_uLOFA-1; Mon, 30 Oct 2023 11:59:31 -0400
X-MC-Unique: ZCjU3wRFO7CsuMrc_uLOFA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso33779995e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 08:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698681570; x=1699286370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IIgh8kG2TQT8ChaB+uGYIXXsWLNdP6VpZ6rpKcqCXY=;
 b=miFvI2ybxY17isbCh2VDil7XhqrCpO3vXluadrp8Fg0TY3ogJJ3cSfmAMtuRdLqbu0
 ReaGwvf9jGGGwShCyg5sdvz74XhEdxRIo2rbqPgBAxpjiW1DuBWhmsNa+7ilrDIV9uDe
 9YvX/I/4WsSAuzZVGXnZyhR9BUCPXlKtBlN11yd1I73QjB8pcBtu+mk+L4zjJxpW7J7V
 OFZPtv0JDdfhMxUrlPQVP8/8wc1mI/UuhUDC49NOKfsPEQ8KO1VTx5w3k2VIn3f2MlMM
 MgS2aB4hbgBqdaZoJWj4jGvZd/et1rjoaWZm6f5guCdygesFO4g7PSGrpEvxdHLv0JAy
 HwRg==
X-Gm-Message-State: AOJu0YxOUMUc202bbJFx6w4xdK4axpwOrY91xMI95mvIHJHb93w6WLIr
 WPtGvWQ7L3YlFs70zF07xgCeQVnfHnZMosXXH9lSoBI0qYNt3nLHmu4QGjT/8xFPV//oUcno9IW
 UadfQtdR0klsfW4RhNLnttMuHsANNNFVgSAzBLLdQ5g==
X-Received: by 2002:a05:600c:3154:b0:408:39d3:a26b with SMTP id
 h20-20020a05600c315400b0040839d3a26bmr8215177wmo.40.1698681570158; 
 Mon, 30 Oct 2023 08:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC+ciZeYOYRxIfFBcwzx4qqGf/LqpWM0q+i9GiHYoTm/RVdPEMB+azsieXWdybiAHVlJUKtg==
X-Received: by 2002:a05:600c:3154:b0:408:39d3:a26b with SMTP id
 h20-20020a05600c315400b0040839d3a26bmr8215156wmo.40.1698681569675; 
 Mon, 30 Oct 2023 08:59:29 -0700 (PDT)
Received: from redhat.com ([2.52.26.150]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b004064ac107cfsm9708527wmq.39.2023.10.30.08.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:59:28 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:59:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V2 vfio 2/9] virtio-pci: Introduce admin virtqueue
Message-ID: <20231030115759-mutt-send-email-mst@kernel.org>
References: <20231029155952.67686-1-yishaih@nvidia.com>
 <20231029155952.67686-3-yishaih@nvidia.com>
 <20231029161909-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810E45C628DE3A5829D438DCA1A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Mon, Oct 30, 2023 at 03:51:40PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, October 30, 2023 1:53 AM
> > 
> > On Sun, Oct 29, 2023 at 05:59:45PM +0200, Yishai Hadas wrote:
> > > From: Feng Liu <feliu@nvidia.com>
> > >
> > > Introduce support for the admin virtqueue. By negotiating
> > > VIRTIO_F_ADMIN_VQ feature, driver detects capability and creates one
> > > administration virtqueue. Administration virtqueue implementation in
> > > virtio pci generic layer, enables multiple types of upper layer
> > > drivers such as vfio, net, blk to utilize it.
> > >
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> > >  drivers/virtio/virtio.c                | 37 ++++++++++++++--
> > >  drivers/virtio/virtio_pci_common.c     |  3 ++
> > >  drivers/virtio/virtio_pci_common.h     | 15 ++++++-
> > >  drivers/virtio/virtio_pci_modern.c     | 61 +++++++++++++++++++++++++-
> > >  drivers/virtio/virtio_pci_modern_dev.c | 18 ++++++++
> > >  include/linux/virtio_config.h          |  4 ++
> > >  include/linux/virtio_pci_modern.h      |  5 +++
> > >  7 files changed, 137 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c index
> > > 3893dc29eb26..f4080692b351 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -302,9 +302,15 @@ static int virtio_dev_probe(struct device *_d)
> > >  	if (err)
> > >  		goto err;
> > >
> > > +	if (dev->config->create_avq) {
> > > +		err = dev->config->create_avq(dev);
> > > +		if (err)
> > > +			goto err;
> > > +	}
> > > +
> > >  	err = drv->probe(dev);
> > >  	if (err)
> > > -		goto err;
> > > +		goto err_probe;
> > >
> > >  	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
> > >  	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > 
> > Hmm I am not all that happy that we are just creating avq unconditionally.
> > Can't we do it on demand to avoid wasting resources if no one uses it?
> >
> Virtio queues must be enabled before driver_ok as we discussed in F_DYNAMIC bit exercise.
> So creating AQ when first legacy command is invoked, would be too late.

Well we didn't release the spec with AQ so I am pretty sure there are no
devices using the feature. Do we want to already make an
exception for AQ and allow creating AQs after DRIVER_OK
even without F_DYNAMIC?

> > 
> > > @@ -316,6 +322,10 @@ static int virtio_dev_probe(struct device *_d)
> > >  	virtio_config_enable(dev);
> > >
> > >  	return 0;
> > > +
> > > +err_probe:
> > > +	if (dev->config->destroy_avq)
> > > +		dev->config->destroy_avq(dev);
> > >  err:
> > >  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > >  	return err;
> > > @@ -331,6 +341,9 @@ static void virtio_dev_remove(struct device *_d)
> > >
> > >  	drv->remove(dev);
> > >
> > > +	if (dev->config->destroy_avq)
> > > +		dev->config->destroy_avq(dev);
> > > +
> > >  	/* Driver should have reset device. */
> > >  	WARN_ON_ONCE(dev->config->get_status(dev));
> > >
> > > @@ -489,13 +502,20 @@ EXPORT_SYMBOL_GPL(unregister_virtio_device);
> > >  int virtio_device_freeze(struct virtio_device *dev)  {
> > >  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> > > +	int ret;
> > >
> > >  	virtio_config_disable(dev);
> > >
> > >  	dev->failed = dev->config->get_status(dev) &
> > VIRTIO_CONFIG_S_FAILED;
> > >
> > > -	if (drv && drv->freeze)
> > > -		return drv->freeze(dev);
> > > +	if (drv && drv->freeze) {
> > > +		ret = drv->freeze(dev);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (dev->config->destroy_avq)
> > > +		dev->config->destroy_avq(dev);
> > >
> > >  	return 0;
> > >  }
> > > @@ -532,10 +552,16 @@ int virtio_device_restore(struct virtio_device *dev)
> > >  	if (ret)
> > >  		goto err;
> > >
> > > +	if (dev->config->create_avq) {
> > > +		ret = dev->config->create_avq(dev);
> > > +		if (ret)
> > > +			goto err;
> > > +	}
> > > +
> > >  	if (drv->restore) {
> > >  		ret = drv->restore(dev);
> > >  		if (ret)
> > > -			goto err;
> > > +			goto err_restore;
> > >  	}
> > >
> > >  	/* If restore didn't do it, mark device DRIVER_OK ourselves. */ @@
> > > -546,6 +572,9 @@ int virtio_device_restore(struct virtio_device *dev)
> > >
> > >  	return 0;
> > >
> > > +err_restore:
> > > +	if (dev->config->destroy_avq)
> > > +		dev->config->destroy_avq(dev);
> > >  err:
> > >  	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > >  	return ret;
> > > diff --git a/drivers/virtio/virtio_pci_common.c
> > > b/drivers/virtio/virtio_pci_common.c
> > > index c2524a7207cf..6b4766d5abe6 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -236,6 +236,9 @@ void vp_del_vqs(struct virtio_device *vdev)
> > >  	int i;
> > >
> > >  	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> > > +		if (vp_dev->is_avq(vdev, vq->index))
> > > +			continue;
> > > +
> > >  		if (vp_dev->per_vq_vectors) {
> > >  			int v = vp_dev->vqs[vq->index]->msix_vector;
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.h
> > > b/drivers/virtio/virtio_pci_common.h
> > > index 4b773bd7c58c..e03af0966a4b 100644
> > > --- a/drivers/virtio/virtio_pci_common.h
> > > +++ b/drivers/virtio/virtio_pci_common.h
> > > @@ -41,6 +41,14 @@ struct virtio_pci_vq_info {
> > >  	unsigned int msix_vector;
> > >  };
> > >
> > > +struct virtio_pci_admin_vq {
> > > +	/* Virtqueue info associated with this admin queue. */
> > > +	struct virtio_pci_vq_info info;
> > > +	/* Name of the admin queue: avq.$index. */
> > > +	char name[10];
> > > +	u16 vq_index;
> > > +};
> > > +
> > >  /* Our device structure */
> > >  struct virtio_pci_device {
> > >  	struct virtio_device vdev;
> > > @@ -58,9 +66,13 @@ struct virtio_pci_device {
> > >  	spinlock_t lock;
> > >  	struct list_head virtqueues;
> > >
> > > -	/* array of all queues for house-keeping */
> > > +	/* Array of all virtqueues reported in the
> > > +	 * PCI common config num_queues field
> > > +	 */
> > >  	struct virtio_pci_vq_info **vqs;
> > >
> > > +	struct virtio_pci_admin_vq admin_vq;
> > > +
> > >  	/* MSI-X support */
> > >  	int msix_enabled;
> > >  	int intx_enabled;
> > > @@ -86,6 +98,7 @@ struct virtio_pci_device {
> > >  	void (*del_vq)(struct virtio_pci_vq_info *info);
> > >
> > >  	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
> > > +	bool (*is_avq)(struct virtio_device *vdev, unsigned int index);
> > >  };
> > >
> > >  /* Constants for MSI-X */
> > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > > b/drivers/virtio/virtio_pci_modern.c
> > > index d6bb68ba84e5..01c5ba346471 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -26,6 +26,16 @@ static u64 vp_get_features(struct virtio_device *vdev)
> > >  	return vp_modern_get_features(&vp_dev->mdev);
> > >  }
> > >
> > > +static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
> > > +{
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +
> > > +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> > > +		return false;
> > > +
> > > +	return index == vp_dev->admin_vq.vq_index; }
> > > +
> > >  static void vp_transport_features(struct virtio_device *vdev, u64
> > > features)  {
> > >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev); @@ -37,6
> > > +47,9 @@ static void vp_transport_features(struct virtio_device *vdev,
> > > u64 features)
> > >
> > >  	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > >  		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> > > +
> > > +	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
> > > +		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
> > >  }
> > >
> > >  /* virtio config->finalize_features() implementation */ @@ -317,7
> > > +330,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device
> > *vp_dev,
> > >  	else
> > >  		notify = vp_notify;
> > >
> > > -	if (index >= vp_modern_get_num_queues(mdev))
> > > +	if (index >= vp_modern_get_num_queues(mdev) &&
> > > +	    !vp_is_avq(&vp_dev->vdev, index))
> > >  		return ERR_PTR(-EINVAL);
> > >
> > >  	/* Check if queue is either not available or already active. */ @@
> > > -491,6 +505,46 @@ static bool vp_get_shm_region(struct virtio_device
> > *vdev,
> > >  	return true;
> > >  }
> > >
> > > +static int vp_modern_create_avq(struct virtio_device *vdev) {
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +	struct virtio_pci_admin_vq *avq;
> > > +	struct virtqueue *vq;
> > > +	u16 admin_q_num;
> > > +
> > > +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> > > +		return 0;
> > > +
> > > +	admin_q_num = vp_modern_avq_num(&vp_dev->mdev);
> > > +	if (!admin_q_num)
> > > +		return -EINVAL;
> > 
> > 
> > We really just need 1 entry ATM. Limit to that?
> >
> Above check is only reading and validating that number of admin queues being nonzero from the device.
> It is ok if its > 1. 
> Driver currently using only 1 aq of default depth (entries) reported by the device.
> 
> Did I misunderstand your question about 1 entry?
>  
> > > +
> > > +	avq = &vp_dev->admin_vq;
> > > +	avq->vq_index = vp_modern_avq_index(&vp_dev->mdev);
> > > +	sprintf(avq->name, "avq.%u", avq->vq_index);
> > > +	vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq-
> > >vq_index, NULL,
> > > +			      avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
> > > +	if (IS_ERR(vq)) {
> > > +		dev_err(&vdev->dev, "failed to setup admin virtqueue,
> > err=%ld",
> > > +			PTR_ERR(vq));
> > > +		return PTR_ERR(vq);
> > > +	}
> > > +
> > > +	vp_dev->admin_vq.info.vq = vq;
> > > +	vp_modern_set_queue_enable(&vp_dev->mdev, avq->info.vq->index,
> > true);
> > > +	return 0;
> > > +}
> > > +
> > > +static void vp_modern_destroy_avq(struct virtio_device *vdev) {
> > > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > +
> > > +	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
> > > +		return;
> > > +
> > > +	vp_dev->del_vq(&vp_dev->admin_vq.info);
> > > +}
> > > +
> > >  static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
> > >  	.get		= NULL,
> > >  	.set		= NULL,
> > > @@ -509,6 +563,8 @@ static const struct virtio_config_ops
> > virtio_pci_config_nodev_ops = {
> > >  	.get_shm_region  = vp_get_shm_region,
> > >  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
> > >  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> > > +	.create_avq = vp_modern_create_avq,
> > > +	.destroy_avq = vp_modern_destroy_avq,
> > >  };
> > >
> > >  static const struct virtio_config_ops virtio_pci_config_ops = { @@
> > > -529,6 +585,8 @@ static const struct virtio_config_ops virtio_pci_config_ops
> > = {
> > >  	.get_shm_region  = vp_get_shm_region,
> > >  	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
> > >  	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
> > > +	.create_avq = vp_modern_create_avq,
> > > +	.destroy_avq = vp_modern_destroy_avq,
> > >  };
> > >
> > >  /* the PCI probing function */
> > > @@ -552,6 +610,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device
> > *vp_dev)
> > >  	vp_dev->config_vector = vp_config_vector;
> > >  	vp_dev->setup_vq = setup_vq;
> > >  	vp_dev->del_vq = del_vq;
> > > +	vp_dev->is_avq = vp_is_avq;
> > >  	vp_dev->isr = mdev->isr;
> > >  	vp_dev->vdev.id = mdev->id;
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c
> > > b/drivers/virtio/virtio_pci_modern_dev.c
> > > index 9cb601e16688..4aab1727d121 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -714,6 +714,24 @@ void __iomem *vp_modern_map_vq_notify(struct
> > > virtio_pci_modern_device *mdev,  }
> > > EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
> > >
> > > +u16 vp_modern_avq_num(struct virtio_pci_modern_device *mdev) {
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev-
> > >common;
> > > +	return vp_ioread16(&cfg->admin_queue_num);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_avq_num);
> > > +
> > > +u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev) {
> > > +	struct virtio_pci_modern_common_cfg __iomem *cfg;
> > > +
> > > +	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev-
> > >common;
> > > +	return vp_ioread16(&cfg->admin_queue_index);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vp_modern_avq_index);
> > > +
> > >  MODULE_VERSION("0.1");
> > >  MODULE_DESCRIPTION("Modern Virtio PCI Device");
> > MODULE_AUTHOR("Jason
> > > Wang <jasowang@redhat.com>"); diff --git
> > > a/include/linux/virtio_config.h b/include/linux/virtio_config.h index
> > > 2b3438de2c4d..da9b271b54db 100644
> > > --- a/include/linux/virtio_config.h
> > > +++ b/include/linux/virtio_config.h
> > > @@ -93,6 +93,8 @@ typedef void vq_callback_t(struct virtqueue *);
> > >   *	Returns 0 on success or error status
> > >   *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
> > >   *	set.
> > > + * @create_avq: create admin virtqueue resource.
> > > + * @destroy_avq: destroy admin virtqueue resource.
> > >   */
> > >  struct virtio_config_ops {
> > >  	void (*get)(struct virtio_device *vdev, unsigned offset, @@ -120,6
> > > +122,8 @@ struct virtio_config_ops {
> > >  			       struct virtio_shm_region *region, u8 id);
> > >  	int (*disable_vq_and_reset)(struct virtqueue *vq);
> > >  	int (*enable_vq_after_reset)(struct virtqueue *vq);
> > > +	int (*create_avq)(struct virtio_device *vdev);
> > > +	void (*destroy_avq)(struct virtio_device *vdev);
> > >  };
> > >
> > >  /* If driver didn't advertise the feature, it will never appear. */
> > > diff --git a/include/linux/virtio_pci_modern.h
> > > b/include/linux/virtio_pci_modern.h
> > > index 067ac1d789bc..0f8737c9ae7d 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -10,6 +10,9 @@ struct virtio_pci_modern_common_cfg {
> > >
> > >  	__le16 queue_notify_data;	/* read-write */
> > >  	__le16 queue_reset;		/* read-write */
> > > +
> > > +	__le16 admin_queue_index;	/* read-only */
> > > +	__le16 admin_queue_num;		/* read-only */
> > >  };
> > >
> > >  struct virtio_pci_modern_device {
> > > @@ -121,4 +124,6 @@ int vp_modern_probe(struct
> > > virtio_pci_modern_device *mdev);  void vp_modern_remove(struct
> > > virtio_pci_modern_device *mdev);  int vp_modern_get_queue_reset(struct
> > > virtio_pci_modern_device *mdev, u16 index);  void
> > > vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16
> > > index);
> > > +u16 vp_modern_avq_num(struct virtio_pci_modern_device *mdev);
> > > +u16 vp_modern_avq_index(struct virtio_pci_modern_device *mdev);
> > >  #endif
> > > --
> > > 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
