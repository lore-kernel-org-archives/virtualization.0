Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63662C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 20:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C12D360764;
	Thu, 25 Nov 2021 20:42:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1gL8oVtqcHG; Thu, 25 Nov 2021 20:42:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8A6660737;
	Thu, 25 Nov 2021 20:42:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76136C001C;
	Thu, 25 Nov 2021 20:42:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 545E8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FE5F400AE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t42v3K0Qp_XI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:42:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DEF98408D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637872970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwq6xAkeXeoZO2nAF0/4CjnkcrMErmAxSF0eFHxlv2o=;
 b=YPPvw4/YzYtEbzSt1NynLN7shC0u6LcBKslnerH4QlnXJwaD9jKmBXeVpNa6JoyhkZX+9z
 Dl9lEMhA1WhfAYSD7PgRrEiH8wAkANi593nsgCqT/AYdNBtDlmicRkzBUTDSIW6xpyGcGz
 ySIpu+fDWbV11BMHZz8dq4rzFrv6D4Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-i00Pa4TANmqQGSx5Ykyxmw-1; Thu, 25 Nov 2021 15:42:47 -0500
X-MC-Unique: i00Pa4TANmqQGSx5Ykyxmw-1
Received: by mail-ed1-f69.google.com with SMTP id
 bx28-20020a0564020b5c00b003e7c42443dbso6219428edb.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dwq6xAkeXeoZO2nAF0/4CjnkcrMErmAxSF0eFHxlv2o=;
 b=p4R4RFa6qk9cs/UIb9bpZ/8yPHWiLaFO/XebGMu8eJQshJZgjRKuUfyq0ELbGGYpN0
 sRUROklRBcKv/VkC+bv2TxKMdYdOGHRIBkdTx2NbZsQ7T66cE65XNLhc/C12qvLbl6Ec
 WDPEgVaMpABU0o6tjlZzsi9BveEiMYBzbIstNXOZAqR0BE/Dfo9bsz5crtuUgIYRm1mR
 CS5dVodVIKsBvjIYCxgpUn2llOIfS0uPvefogoUOIk0UmzTJjleJtF84vACRbbdqwjSF
 YPYtAnJqMIQm0COFjrc18ykl4pnYDowqQS/FtbIkG0SLBc/o7PPGGyMLR8zj82Ymyr0s
 ILSA==
X-Gm-Message-State: AOAM530AbQk+s8ScdGhkgSMRm1WYu+wMfkULul30+obDsWvK7MbKEu7z
 RrfG3LNdTJEmVtQn7vdKEJwfFSsI26rp5t3fGhAvn3ykTKnyfIEzBzljUB6YIMed4JMTs0/YpKZ
 o7G6RUX7hJxWMGldc+FOqQ43Bobe1PLvEdFiTXj9FdQ==
X-Received: by 2002:a05:6402:84b:: with SMTP id
 b11mr43326797edz.69.1637872966283; 
 Thu, 25 Nov 2021 12:42:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV1mE6GGlp0m4RJQ4ctf/kluGWw+ZKhP02LcBk5b036FR8ekAzctmtQnt+ZPE8o34dIwamaw==
X-Received: by 2002:a05:6402:84b:: with SMTP id
 b11mr43326764edz.69.1637872966057; 
 Thu, 25 Nov 2021 12:42:46 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
 by smtp.gmail.com with ESMTPSA id ht7sm2186457ejc.27.2021.11.25.12.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 12:42:45 -0800 (PST)
Date: Thu, 25 Nov 2021 15:42:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Offer VIRTIO_NET_F_MTU when setting MTU
Message-ID: <20211125154011-mutt-send-email-mst@kernel.org>
References: <20211124170949.51725-1-elic@nvidia.com>
 <PH0PR12MB5481CD17327097D7E7865B8DDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211125080227.GE214101@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB548163DC0306DB2EF50B76F3DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548163DC0306DB2EF50B76F3DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>
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

On Thu, Nov 25, 2021 at 06:27:15PM +0000, Parav Pandit wrote:
> 
> 
> > From: Eli Cohen <elic@nvidia.com>
> > Sent: Thursday, November 25, 2021 1:32 PM
> > 
> > On Thu, Nov 25, 2021 at 07:29:18AM +0200, Parav Pandit wrote:
> > >
> > >
> > > > From: Eli Cohen <elic@nvidia.com>
> > > > Sent: Wednesday, November 24, 2021 10:40 PM
> > > >
> > > > Make sure to offer VIRTIO_NET_F_MTU since we configure the MTU based
> > > > on what was queried from the device.
> > > >
> > > > This allows the virtio driver to allocate large enough buffers based
> > > > on the reported MTU.
> > > >
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 465e832f2ad1..ed7a63e48335 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1956,6 +1956,7 @@ static u64 mlx5_vdpa_get_features(struct
> > > > vdpa_device *vdev)
> > > >  	ndev->mvdev.mlx_features |=
> > > > BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
> > > >  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> > > >  	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> > > > +	ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> > > It is better to set this feature bit along with the writing the RO config.mtu
> > area, adjacent to query_mtu() call.
> > 
> > Why is that so important? We always query the mtu and if the query fails, we
> > fail the initialization so it does not look critical.
> It is not so important. But it is more appropriate to set read only field and its associated feature bit at one place, which never changes.
> There is no need to perform OR operation for those many feature bits on every get_features() callback when they are immutable.
> 
> So I wanted to move setting other 5 feature bits assignment at one place in device initialization time similar to how you have done VALID_FEATURES_MASK.
> Something like below.
> But again, its minor.
> If you happen to revise the series (I think you should for the supporting dumpit in future), please consider one time assignment like below.
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 63813fbb5f62..21802b25b0f5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1890,11 +1890,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>         ndev->mvdev.mlx_features |= mlx_to_vritio_features(dev_features);
>         if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
>                 ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_VERSION_1);
> -       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_F_ACCESS_PLATFORM);
> -       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VQ);
> -       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR);
> -       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MQ);
> -       ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
> 
>         print_features(mvdev, ndev->mvdev.mlx_features, false);
>         return ndev->mvdev.mlx_features;
> @@ -2522,6 +2517,14 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>         return ret;
>  }
> 
> +#define DEFAULT_FEATURES \
> +       BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) | \
> +       BIT_ULL(VIRTIO_NET_F_CTRL_VQ) | \
> +       BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) \
> +       BIT_ULL(VIRTIO_NET_F_MQ) \
> +       BIT_ULL(VIRTIO_NET_F_STATUS) \
> +       BIT_ULL(VIRTIO_NET_F_MTU)
> +

I would just open-code it, don't see what good does the macro do.
A single assignment is a bit clearer I think I agree,
there's not much of a difference.


>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                              const struct vdpa_dev_set_config *add_config)
>  {
> @@ -2565,6 +2568,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                 goto err_mtu;
> 
>         ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +       ndev->mvdev.mlx_features = DEFAULT_FEATURES;
> 
>         if (get_link_state(mvdev))
>                 ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
