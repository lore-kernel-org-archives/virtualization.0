Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5DBC433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Dec 2021 09:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B86F40917;
	Sun, 12 Dec 2021 09:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fx4WqbkTvRNo; Sun, 12 Dec 2021 09:45:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5DC74408F0;
	Sun, 12 Dec 2021 09:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DADAC001E;
	Sun, 12 Dec 2021 09:45:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED2BC0012
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DCC260E36
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bxi0Fyod3rHl
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F9FF60D80
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639302317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZnzQYkRDO8+AnnwTgVKx9hUoYV0Jm/xwKItFsZKb1GM=;
 b=dSBVt8aovqVAMa5RPcCop11kOvbGonPGBVLGecn6+SInDd6MrIB9iOFCTbJkW1YQRUvw4p
 572gd+0HCt9ah+JY4hCm6X11QvdVnR/yYtTuvzq2xmBJfJp8qzx9LlIWVyYxTq/PcZsqmL
 G8EQ+S51mIvAnC4wBGDaFWmbcAKcChc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-366-mkG-hyj-MmCrLNKMxGvXug-1; Sun, 12 Dec 2021 04:45:16 -0500
X-MC-Unique: mkG-hyj-MmCrLNKMxGvXug-1
Received: by mail-wm1-f72.google.com with SMTP id
 j23-20020a05600c1c1700b0033283ea5facso3069985wms.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 01:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZnzQYkRDO8+AnnwTgVKx9hUoYV0Jm/xwKItFsZKb1GM=;
 b=KheSkfayS53IFqXbLZ/KbrEKdbUF/MjESCb+1iDO24ksBgW5InLQOUKmTy+Vvn4Ib/
 swv+1jt2oYovJbdqBA5zosQzFqScFAZyBo1bWoWrtLkT/aYLmxb09glI3WuPrS9iNWMq
 dB6RCI+ulkDEpwBXuLUtX2dNSwwZpx8VtjKjD2ixK3FgV8fuE9uSfUD718kFc+DHacTd
 osX9Qc7c3CWIkJz3+BSKwlGzeaqNj5H6UsSDpP0BBY5ndV2UO//SmtKXHaUzhpKZV806
 xZ+PawVF92dVvdxiiSfP9wCLRZqhsI0d+r4HMVjXJVIWv/QkBpWYWnQLI0pzSfIf7rAb
 RgVg==
X-Gm-Message-State: AOAM532Vpk9TJse/o3rWzdxsKsq0mBx9NY9MYij2nBl6GdUYQ1Ri9sg+
 rE77LohL6/T/U3eUAEEToRPOtm09KdWKbrwpDhTHlowmxXZIUmu7Q4tU8CVJlkwOgNsm07pBbqu
 nfMf09etRgzhciqk/+A08ucrBG3k7AvtMyZLCN57R6A==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr25229603wrw.138.1639302315343; 
 Sun, 12 Dec 2021 01:45:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/OVWBpShDgY4aC+bYOriaykTGf0DLOrhPet6lj46ETRKd9Bh021yGpuJbnZQ5AVQpx7yuhQ==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr25229579wrw.138.1639302314997; 
 Sun, 12 Dec 2021 01:45:14 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:eefb:294:6ac8:eff6:22df])
 by smtp.gmail.com with ESMTPSA id k8sm7197852wrn.91.2021.12.12.01.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Dec 2021 01:45:14 -0800 (PST)
Date: Sun, 12 Dec 2021 04:45:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v1 1/7] vdpa: Provide interface to read driver features
Message-ID: <20211212044120-mutt-send-email-mst@kernel.org>
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-2-elic@nvidia.com>
 <ff8cdad8-cfbd-1d7a-545f-acda1e51a360@oracle.com>
 <20211209064702.GA108239@mtl-vdi-166.wap.labs.mlnx>
 <9522131f-f3c1-1fdf-c63f-bcff00917fac@oracle.com>
MIME-Version: 1.0
In-Reply-To: <9522131f-f3c1-1fdf-c63f-bcff00917fac@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eli Cohen <elic@nvidia.com>
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

On Thu, Dec 09, 2021 at 02:29:17PM -0800, Si-Wei Liu wrote:
> 
> 
> On 12/8/2021 10:47 PM, Eli Cohen wrote:
> > On Wed, Dec 08, 2021 at 03:57:21PM -0800, Si-Wei Liu wrote:
> > > 
> > > On 12/8/2021 12:14 PM, Eli Cohen wrote:
> > > > Provide an interface to read the negotiated features. This is needed
> > > > when building the netlink message in vdpa_dev_net_config_fill().
> > > > 
> > > > Also fix the implementation of vdpa_dev_net_config_fill() to use the
> > > > negotiated features instead of the device features.
> > > Are we sure the use of device feature is a bug rather than expected
> > > behavior?
> > I think so since in vdpa_dev_net_config_fill() we're returning the
> > current configuration so you you don't want to mislead the user with
> > wrong information.
> You seem to imply vdpa_dev_net_config_fill() should return the
> current/running driver config rather than the initial setting of the device
> side before feature negotiation kicks in. This seems to work for the running
> link status which is propagated to the configuration space, but how do you
> infer the other untrackable running config the driver is operating, such as
> mtu, the effective value of which is not written back to config space or
> propagated back to vdpa backend?
> 
> > 
> > > How do users determine the configured number of queue pairs at any
> > > point in case of a non-multiqueue supporting guest/driver or that the device
> > > is being reset (where actual_features == 0)?
> > I would think if you read during reset (which is really a short period
> > of time), you get what there is at the moment.
> I would stress out the case if guest not supporting multi-queue. For e.g
> guest firmware might only support single queue without control queue, which
> is not considered to be transient. Since the validity of the value connects
> to feature negotiation, how does the host admin user infer feature
> negotiation is complete? What is the administrative value if they have to
> keep track of the change without knowing the effective negotiation status?
> 
> Thanks,
> -Siwei

Right now I think the assumption is that features can be
overwritten multiple times.
I would say the way to detect feature negotiation is complete for
a modern guest would be by using set_status.
Legacy guests also kick before set_status, once they do
feature negotiation is complete.

Having said all that, ability to read config before FEATURES_OK
only caused us pain so far. I think we should at least discourage it
at the spec level.

> > 
> > > Maybe we should differentiate
> > > the static device config against driver/device running state here. I thought
> > > the change to vdpa_dev_net_config_fill() in this patch would break vdpa tool
> > > user's expectation that the value of max_vqp config is a fixed value since
> > > the vdpa creation time.
> > That was not intended to be fixed AFAIU.
> > 
> > > Perhaps worth adding another attribute to represent the running state
> > > (cur_max_qps) based on the negotiated features.
> > > 
> > You can get that information by running e.g. ethtool -l ens1.
> > 
> > > -Siwei
> > > 
> > > > To make APIs clearer, make the following name changes to struct
> > > > vdpa_config_ops so they better describe their operations:
> > > > 
> > > > get_features -> get_device_features
> > > > set_features -> set_driver_features
> > > > 
> > > > Finally, add get_driver_features to return the negotiated features and
> > > > add implementation to all the upstream drivers.
> > > > 
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > >    drivers/vdpa/alibaba/eni_vdpa.c    | 16 ++++++++++++----
> > > >    drivers/vdpa/ifcvf/ifcvf_main.c    | 16 ++++++++++++----
> > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++----
> > > >    drivers/vdpa/vdpa.c                |  2 +-
> > > >    drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++++++++++++------
> > > >    drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++----
> > > >    drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 ++++++++++++----
> > > >    drivers/vhost/vdpa.c               |  2 +-
> > > >    drivers/virtio/virtio_vdpa.c       |  2 +-
> > > >    include/linux/vdpa.h               | 14 +++++++++-----
> > > >    10 files changed, 87 insertions(+), 34 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > index 3f788794571a..ac0975660f4d 100644
> > > > --- a/drivers/vdpa/alibaba/eni_vdpa.c
> > > > +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> > > > @@ -58,7 +58,7 @@ static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
> > > >    	return &eni_vdpa->ldev;
> > > >    }
> > > > -static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > > +static u64 eni_vdpa_get_device_features(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > >    	u64 features = vp_legacy_get_features(ldev);
> > > > @@ -69,7 +69,7 @@ static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> > > >    	return features;
> > > >    }
> > > > -static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +static int eni_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > > >    {
> > > >    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > @@ -84,6 +84,13 @@ static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > >    	return 0;
> > > >    }
> > > > +static u64 eni_vdpa_get_driver_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > +
> > > > +	return vp_legacy_get_driver_features(ldev);
> > > > +}
> > > > +
> > > >    static u8 eni_vdpa_get_status(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> > > > @@ -401,8 +408,9 @@ static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
> > > >    }
> > > >    static const struct vdpa_config_ops eni_vdpa_ops = {
> > > > -	.get_features	= eni_vdpa_get_features,
> > > > -	.set_features	= eni_vdpa_set_features,
> > > > +	.get_device_features = eni_vdpa_get_device_features,
> > > > +	.set_driver_features = eni_vdpa_set_driver_features,
> > > > +	.get_driver_features = eni_vdpa_get_driver_features,
> > > >    	.get_status	= eni_vdpa_get_status,
> > > >    	.set_status	= eni_vdpa_set_status,
> > > >    	.reset		= eni_vdpa_reset,
> > > > diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > index 6dc75ca70b37..6a6a0a462392 100644
> > > > --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> > > > @@ -169,7 +169,7 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
> > > >    	return &adapter->vf;
> > > >    }
> > > > -static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
> > > > +static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
> > > >    {
> > > >    	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
> > > >    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> > > > @@ -187,7 +187,7 @@ static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
> > > >    	return features;
> > > >    }
> > > > -static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
> > > > +static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 features)
> > > >    {
> > > >    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> > > >    	int ret;
> > > > @@ -201,6 +201,13 @@ static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
> > > >    	return 0;
> > > >    }
> > > > +static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
> > > > +{
> > > > +	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> > > > +
> > > > +	return vf->req_features;
> > > > +}
> > > > +
> > > >    static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
> > > >    {
> > > >    	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> > > > @@ -443,8 +450,9 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
> > > >     * implemented set_map()/dma_map()/dma_unmap()
> > > >     */
> > > >    static const struct vdpa_config_ops ifc_vdpa_ops = {
> > > > -	.get_features	= ifcvf_vdpa_get_features,
> > > > -	.set_features	= ifcvf_vdpa_set_features,
> > > > +	.get_device_features = ifcvf_vdpa_get_device_features,
> > > > +	.set_driver_features = ifcvf_vdpa_set_driver_features,
> > > > +	.get_driver_features = ifcvf_vdpa_get_driver_features,
> > > >    	.get_status	= ifcvf_vdpa_get_status,
> > > >    	.set_status	= ifcvf_vdpa_set_status,
> > > >    	.reset		= ifcvf_vdpa_reset,
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 63813fbb5f62..ce2e13135dd8 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1880,7 +1880,7 @@ static u64 mlx_to_vritio_features(u16 dev_features)
> > > >    	return result;
> > > >    }
> > > > -static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> > > > +static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
> > > >    {
> > > >    	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > >    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > @@ -1972,7 +1972,7 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
> > > >    	}
> > > >    }
> > > > -static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > > +static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > > >    {
> > > >    	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > >    	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > @@ -2339,6 +2339,13 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
> > > >    	return -EOPNOTSUPP;
> > > >    }
> > > > +static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> > > > +{
> > > > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > +
> > > > +	return mvdev->actual_features;
> > > > +}
> > > > +
> > > >    static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > >    	.set_vq_address = mlx5_vdpa_set_vq_address,
> > > >    	.set_vq_num = mlx5_vdpa_set_vq_num,
> > > > @@ -2351,8 +2358,9 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
> > > >    	.get_vq_notification = mlx5_get_vq_notification,
> > > >    	.get_vq_irq = mlx5_get_vq_irq,
> > > >    	.get_vq_align = mlx5_vdpa_get_vq_align,
> > > > -	.get_features = mlx5_vdpa_get_features,
> > > > -	.set_features = mlx5_vdpa_set_features,
> > > > +	.get_device_features = mlx5_vdpa_get_device_features,
> > > > +	.set_driver_features = mlx5_vdpa_set_driver_features,
> > > > +	.get_driver_features = mlx5_vdpa_get_driver_features,
> > > >    	.set_config_cb = mlx5_vdpa_set_config_cb,
> > > >    	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
> > > >    	.get_device_id = mlx5_vdpa_get_device_id,
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index 7332a74a4b00..c37d384c0f33 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -733,7 +733,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > >    	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> > > >    		return -EMSGSIZE;
> > > > -	features = vdev->config->get_features(vdev);
> > > > +	features = vdev->config->get_driver_features(vdev);
> > > >    	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > >    }
> > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > index 41b0cd17fcba..ddbe142af09a 100644
> > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > > @@ -399,14 +399,14 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
> > > >    	return VDPASIM_QUEUE_ALIGN;
> > > >    }
> > > > -static u64 vdpasim_get_features(struct vdpa_device *vdpa)
> > > > +static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > >    	return vdpasim->dev_attr.supported_features;
> > > >    }
> > > > -static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > > >    {
> > > >    	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > > @@ -419,6 +419,13 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> > > >    	return 0;
> > > >    }
> > > > +static u64 vdpasim_get_driver_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > > +
> > > > +	return vdpasim->features;
> > > > +}
> > > > +
> > > >    static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
> > > >    				  struct vdpa_callback *cb)
> > > >    {
> > > > @@ -613,8 +620,9 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> > > >    	.set_vq_state           = vdpasim_set_vq_state,
> > > >    	.get_vq_state           = vdpasim_get_vq_state,
> > > >    	.get_vq_align           = vdpasim_get_vq_align,
> > > > -	.get_features           = vdpasim_get_features,
> > > > -	.set_features           = vdpasim_set_features,
> > > > +	.get_device_features    = vdpasim_get_device_features,
> > > > +	.set_driver_features    = vdpasim_set_driver_features,
> > > > +	.get_driver_features    = vdpasim_get_driver_features,
> > > >    	.set_config_cb          = vdpasim_set_config_cb,
> > > >    	.get_vq_num_max         = vdpasim_get_vq_num_max,
> > > >    	.get_device_id          = vdpasim_get_device_id,
> > > > @@ -642,8 +650,9 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> > > >    	.set_vq_state           = vdpasim_set_vq_state,
> > > >    	.get_vq_state           = vdpasim_get_vq_state,
> > > >    	.get_vq_align           = vdpasim_get_vq_align,
> > > > -	.get_features           = vdpasim_get_features,
> > > > -	.set_features           = vdpasim_set_features,
> > > > +	.get_device_features    = vdpasim_get_device_features,
> > > > +	.set_driver_features    = vdpasim_set_driver_features,
> > > > +	.get_driver_features    = vdpasim_get_driver_features,
> > > >    	.set_config_cb          = vdpasim_set_config_cb,
> > > >    	.get_vq_num_max         = vdpasim_get_vq_num_max,
> > > >    	.get_device_id          = vdpasim_get_device_id,
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > index c9204c62f339..1e65af6ab9ae 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -573,14 +573,14 @@ static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
> > > >    	return dev->vq_align;
> > > >    }
> > > > -static u64 vduse_vdpa_get_features(struct vdpa_device *vdpa)
> > > > +static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > >    	return dev->device_features;
> > > >    }
> > > > -static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > > >    {
> > > >    	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > > @@ -588,6 +588,13 @@ static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > >    	return 0;
> > > >    }
> > > > +static u64 vduse_vdpa_get_driver_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > > +
> > > > +	return dev->driver_features;
> > > > +}
> > > > +
> > > >    static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
> > > >    				  struct vdpa_callback *cb)
> > > >    {
> > > > @@ -720,8 +727,9 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
> > > >    	.set_vq_state		= vduse_vdpa_set_vq_state,
> > > >    	.get_vq_state		= vduse_vdpa_get_vq_state,
> > > >    	.get_vq_align		= vduse_vdpa_get_vq_align,
> > > > -	.get_features		= vduse_vdpa_get_features,
> > > > -	.set_features		= vduse_vdpa_set_features,
> > > > +	.get_device_features	= vduse_vdpa_get_device_features,
> > > > +	.set_driver_features	= vduse_vdpa_set_driver_features,
> > > > +	.get_driver_features	= vduse_vdpa_get_driver_features,
> > > >    	.set_config_cb		= vduse_vdpa_set_config_cb,
> > > >    	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
> > > >    	.get_device_id		= vduse_vdpa_get_device_id,
> > > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > index e3ff7875e123..97285bc05e47 100644
> > > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > > @@ -53,14 +53,14 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
> > > >    	return &vp_vdpa->mdev;
> > > >    }
> > > > -static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> > > > +static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > > >    	return vp_modern_get_features(mdev);
> > > >    }
> > > > -static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > > +static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
> > > >    {
> > > >    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > > > @@ -69,6 +69,13 @@ static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> > > >    	return 0;
> > > >    }
> > > > +static u64 vp_vdpa_get_driver_features(struct vdpa_device *vdpa)
> > > > +{
> > > > +	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > > > +
> > > > +	return vp_modern_get_features(mdev);
> > > > +}
> > > > +
> > > >    static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> > > >    {
> > > >    	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> > > > @@ -415,8 +422,9 @@ vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> > > >    }
> > > >    static const struct vdpa_config_ops vp_vdpa_ops = {
> > > > -	.get_features	= vp_vdpa_get_features,
> > > > -	.set_features	= vp_vdpa_set_features,
> > > > +	.get_device_features = vp_vdpa_get_device_features,
> > > > +	.set_driver_features = vp_vdpa_set_driver_features,
> > > > +	.get_driver_features = vp_vdpa_get_driver_features,
> > > >    	.get_status	= vp_vdpa_get_status,
> > > >    	.set_status	= vp_vdpa_set_status,
> > > >    	.reset		= vp_vdpa_reset,
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index 29cced1cd277..6d087a4fb581 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -262,7 +262,7 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
> > > >    	const struct vdpa_config_ops *ops = vdpa->config;
> > > >    	u64 features;
> > > > -	features = ops->get_features(vdpa);
> > > > +	features = ops->get_device_features(vdpa);
> > > >    	if (copy_to_user(featurep, &features, sizeof(features)))
> > > >    		return -EFAULT;
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index f85f860bc10b..a84b04ba3195 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -308,7 +308,7 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
> > > >    	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > >    	const struct vdpa_config_ops *ops = vdpa->config;
> > > > -	return ops->get_features(vdpa);
> > > > +	return ops->get_device_features(vdpa);
> > > >    }
> > > >    static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
> > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > index c3011ccda430..db24317d61b6 100644
> > > > --- a/include/linux/vdpa.h
> > > > +++ b/include/linux/vdpa.h
> > > > @@ -169,14 +169,17 @@ struct vdpa_map_file {
> > > >     *				for the device
> > > >     *				@vdev: vdpa device
> > > >     *				Returns virtqueue algin requirement
> > > > - * @get_features:		Get virtio features supported by the device
> > > > + * @get_device_features:	Get virtio features supported by the device
> > > >     *				@vdev: vdpa device
> > > >     *				Returns the virtio features support by the
> > > >     *				device
> > > > - * @set_features:		Set virtio features supported by the driver
> > > > + * @set_driver_features:	Set virtio features supported by the driver
> > > >     *				@vdev: vdpa device
> > > >     *				@features: feature support by the driver
> > > >     *				Returns integer: success (0) or error (< 0)
> > > > + * @get_driver_features:	Get virtio features in action
> > > > + *				@vdev: vdpa device
> > > > + *				Returns the virtio features accepted
> > > >     * @set_config_cb:		Set the config interrupt callback
> > > >     *				@vdev: vdpa device
> > > >     *				@cb: virtio-vdev interrupt callback structure
> > > > @@ -276,8 +279,9 @@ struct vdpa_config_ops {
> > > >    	/* Device ops */
> > > >    	u32 (*get_vq_align)(struct vdpa_device *vdev);
> > > > -	u64 (*get_features)(struct vdpa_device *vdev);
> > > > -	int (*set_features)(struct vdpa_device *vdev, u64 features);
> > > > +	u64 (*get_device_features)(struct vdpa_device *vdev);
> > > > +	int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
> > > > +	u64 (*get_driver_features)(struct vdpa_device *vdev);
> > > >    	void (*set_config_cb)(struct vdpa_device *vdev,
> > > >    			      struct vdpa_callback *cb);
> > > >    	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> > > > @@ -395,7 +399,7 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> > > >    	const struct vdpa_config_ops *ops = vdev->config;
> > > >    	vdev->features_valid = true;
> > > > -	return ops->set_features(vdev, features);
> > > > +	return ops->set_driver_features(vdev, features);
> > > >    }
> > > >    void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
