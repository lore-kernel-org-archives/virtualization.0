Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF602C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:54:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560CC64E2E
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560CC64E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BBAB8263D;
	Tue, 23 Feb 2021 12:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrKg16vYuPwh; Tue, 23 Feb 2021 12:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9828D8195D;
	Tue, 23 Feb 2021 12:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B883C000A;
	Tue, 23 Feb 2021 12:54:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB317C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8EEF605E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PHfF599MMdPl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:53:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A395F600CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614084838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpKnhF8xzE+xk7DZzBaL35pVUpraUP2Beq7jfgkgyxg=;
 b=JDf+i+xTpUsBgpCIOCMv9NoP6mcF6EwuaMGTEgCImf0DI47m1ACwujfry588i72F8MdOa5
 rfqyNWk4nQC5XtK+YDJEi1Q8XsjS9h3hLdKuIDKlF7oWc1X5QIJfUbvMukgKEnXCfhhTSv
 vNRUMH9+lKngwTWGLvenBVDJNbshnHY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-kEp92bz6NryZkDK8jFaPSQ-1; Tue, 23 Feb 2021 07:52:38 -0500
X-MC-Unique: kEp92bz6NryZkDK8jFaPSQ-1
Received: by mail-wm1-f69.google.com with SMTP id s192so1148758wme.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VpKnhF8xzE+xk7DZzBaL35pVUpraUP2Beq7jfgkgyxg=;
 b=OSBrcwb8yd8oljQZEJ2yWFoMwNhzn+kYjIarEozvIzLkMEm8aU7fd3HqnFhmebrWKi
 MKBO8h6/Dk/4WwRjUx6AF1313jW9q8aCl0dcvF6z6Jz3caiVe62lX/x98UFsaFuhC5qx
 d0u30qPPrCia9w32EZfvC51SP7ewexyC/Yz94NAs7B9tOkGTiVvn3kHYslNULXBFze+k
 rxr3V1fP29N8PuzJZiM+B/5HcjAUPrXPGxia1zRbTTluMiaz8xmQZYQAwOIXxqSzrSh+
 bMfD311MRWh21tieabDGRbNG4Xp7sbm50GppogMLH72c+lFyKF9fDBP2rhvP4YzWPrg4
 5VJg==
X-Gm-Message-State: AOAM530nqYgySh00krLrWgeZbIG7FgsSaOvJ8RYHYIwP5KIxfS0TVO5u
 WZH66JZorDdQgld3xZjTE6JXT9djZZui6T8DqpQmVHSDoH3HckY8xy5b7B1RuQKAyiXlNmHLMLl
 IDATg8XvYzXK3ftoZQHq9a1vwP21Gy2aJjQdMTDI6cQ==
X-Received: by 2002:a05:600c:35c2:: with SMTP id
 r2mr23376669wmq.54.1614084757593; 
 Tue, 23 Feb 2021 04:52:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGEt76S1XmRrvr3buiAqZHZo63kQk76TRhwqBQKdNL6YEogoa1tLlZDqDWzOplA9TFvNjfQw==
X-Received: by 2002:a05:600c:35c2:: with SMTP id
 r2mr23376657wmq.54.1614084757390; 
 Tue, 23 Feb 2021 04:52:37 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id v18sm2777629wml.45.2021.02.23.04.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 04:52:36 -0800 (PST)
Date: Tue, 23 Feb 2021 07:52:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Enable user to add/delete vdpa device
Message-ID: <20210223075211-mutt-send-email-mst@kernel.org>
References: <20210218074157.43220-1-elic@nvidia.com>
 <20210223072847-mutt-send-email-mst@kernel.org>
 <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210223123304.GA170700@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com
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

On Tue, Feb 23, 2021 at 02:33:04PM +0200, Eli Cohen wrote:
> On Tue, Feb 23, 2021 at 07:29:32AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 18, 2021 at 09:41:57AM +0200, Eli Cohen wrote:
> > > Allow to control vdpa device creation and destruction using the vdpa
> > > management tool.
> > > 
> > > Examples:
> > > 1. List the management devices
> > > $ vdpa mgmtdev show
> > > pci/0000:3b:00.1:
> > >   supported_classes net
> > > 
> > > 2. Create vdpa instance
> > > $ vdpa dev add mgmtdev pci/0000:3b:00.1 name vdpa0
> > > 
> > > 3. Show vdpa devices
> > > $ vdpa dev show
> > > vdpa0: type network mgmtdev pci/0000:3b:00.1 vendor_id 5555 max_vqs 16 \
> > > max_vq_size 256
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > 
> > Not sure which tree this is for, I could not apply this.
> > 
> 
> Depends on Parav's vdpa tool patches. We'll send the entire series again
> - Parav's and my patches.


I think I have them in the linux next branch, no?


> > > ---
> > > v0->v1:
> > > set mgtdev->ndev NULL on dev delete
> > > v1->v2: Resend
> > > 
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 79 +++++++++++++++++++++++++++----
> > >  1 file changed, 70 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index a51b0f86afe2..08fb481ddc4f 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1974,23 +1974,32 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > >  	}
> > >  }
> > >  
> > > -static int mlx5v_probe(struct auxiliary_device *adev,
> > > -		       const struct auxiliary_device_id *id)
> > > +struct mlx5_vdpa_mgmtdev {
> > > +	struct vdpa_mgmt_dev mgtdev;
> > > +	struct mlx5_adev *madev;
> > > +	struct mlx5_vdpa_net *ndev;
> > > +};
> > > +
> > > +static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> > >  {
> > > -	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
> > > -	struct mlx5_core_dev *mdev = madev->mdev;
> > > +	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > >  	struct virtio_net_config *config;
> > >  	struct mlx5_vdpa_dev *mvdev;
> > >  	struct mlx5_vdpa_net *ndev;
> > > +	struct mlx5_core_dev *mdev;
> > >  	u32 max_vqs;
> > >  	int err;
> > >  
> > > +	if (mgtdev->ndev)
> > > +		return -ENOSPC;
> > > +
> > > +	mdev = mgtdev->madev->mdev;
> > >  	/* we save one virtqueue for control virtqueue should we require it */
> > >  	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> > >  	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
> > >  
> > >  	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
> > > -				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
> > > +				 2 * mlx5_vdpa_max_qps(max_vqs), name);
> > >  	if (IS_ERR(ndev))
> > >  		return PTR_ERR(ndev);
> > >  
> > > @@ -2018,11 +2027,12 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> > >  	if (err)
> > >  		goto err_res;
> > >  
> > > -	err = vdpa_register_device(&mvdev->vdev);
> > > +	mvdev->vdev.mdev = &mgtdev->mgtdev;
> > > +	err = _vdpa_register_device(&mvdev->vdev);
> > >  	if (err)
> > >  		goto err_reg;
> > >  
> > > -	dev_set_drvdata(&adev->dev, ndev);
> > > +	mgtdev->ndev = ndev;
> > >  	return 0;
> > >  
> > >  err_reg:
> > > @@ -2035,11 +2045,62 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> > >  	return err;
> > >  }
> > >  
> > > +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> > > +{
> > > +	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
> > > +
> > > +	_vdpa_unregister_device(dev);
> > > +	mgtdev->ndev = NULL;
> > > +}
> > > +
> > > +static const struct vdpa_mgmtdev_ops mdev_ops = {
> > > +	.dev_add = mlx5_vdpa_dev_add,
> > > +	.dev_del = mlx5_vdpa_dev_del,
> > > +};
> > > +
> > > +static struct virtio_device_id id_table[] = {
> > > +	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
> > > +	{ 0 },
> > > +};
> > > +
> > > +static int mlx5v_probe(struct auxiliary_device *adev,
> > > +		       const struct auxiliary_device_id *id)
> > > +
> > > +{
> > > +	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
> > > +	struct mlx5_core_dev *mdev = madev->mdev;
> > > +	struct mlx5_vdpa_mgmtdev *mgtdev;
> > > +	int err;
> > > +
> > > +	mgtdev = kzalloc(sizeof(*mgtdev), GFP_KERNEL);
> > > +	if (!mgtdev)
> > > +		return -ENOMEM;
> > > +
> > > +	mgtdev->mgtdev.ops = &mdev_ops;
> > > +	mgtdev->mgtdev.device = mdev->device;
> > > +	mgtdev->mgtdev.id_table = id_table;
> > > +	mgtdev->madev = madev;
> > > +
> > > +	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> > > +	if (err)
> > > +		goto reg_err;
> > > +
> > > +	dev_set_drvdata(&adev->dev, mgtdev);
> > > +
> > > +	return 0;
> > > +
> > > +reg_err:
> > > +	kfree(mdev);
> > > +	return err;
> > > +}
> > > +
> > >  static void mlx5v_remove(struct auxiliary_device *adev)
> > >  {
> > > -	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
> > > +	struct mlx5_vdpa_mgmtdev *mgtdev;
> > >  
> > > -	vdpa_unregister_device(&mvdev->vdev);
> > > +	mgtdev = dev_get_drvdata(&adev->dev);
> > > +	vdpa_mgmtdev_unregister(&mgtdev->mgtdev);
> > > +	kfree(mgtdev);
> > >  }
> > >  
> > >  static const struct auxiliary_device_id mlx5v_id_table[] = {
> > > -- 
> > > 2.29.2
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
