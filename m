Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C000C4346E
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:17:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E091220754
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 07:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWXV3iA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091220754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F27920336;
	Tue, 29 Sep 2020 07:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i--vZ27apyte; Tue, 29 Sep 2020 07:17:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9C88F20481;
	Tue, 29 Sep 2020 07:17:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F683C0890;
	Tue, 29 Sep 2020 07:17:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4028CC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2AD6A85108
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8SmULNF6Peh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:17:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D716C8462A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 07:17:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601363843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFFAkA3/1aZz/o+ZDBqbYbAsb3pp0PKXRHscgx88F1k=;
 b=FWXV3iA+aecQ3gtsEddVCNb89l3zmGlh/4Tz0SdDDgcCzCqWLsItzYId7dZpuM+tbpAu++
 LRTTouXbbXaJa8J3OqG9lCXukQr8ubw2Dfz28umoGGva4zr860Bsp+y4VmobSfrVfT3ZWm
 Bec1npsaHRg/9XaM90UKrKmHe4jw0UM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-EOckc9EdP5u42vlvcmmW0A-1; Tue, 29 Sep 2020 03:17:21 -0400
X-MC-Unique: EOckc9EdP5u42vlvcmmW0A-1
Received: by mail-wm1-f70.google.com with SMTP id l26so1346945wmg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 00:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uFFAkA3/1aZz/o+ZDBqbYbAsb3pp0PKXRHscgx88F1k=;
 b=URlXJOrkkDbDke8+Ko6qDISsdYfs0LJa//r1mDKbM3GHnENUXsx3TcuWwz4HCDyMa6
 RXjXwcQEAP7R9zkNZ8zMtWKZOX42E8eeRGySNRUXDWHp5U4ZGmET64kaPtgD3IoVjwb1
 WJ5bH5rUvmlciddcJnpu/AjTW4laGI2ElSumGGGwSsLKomBkzkgDrPmgza+iIWq4CMc8
 0nvaUjOT/bbt5/4fxtjhAwTGw98ZCmcZRWhyo9ID8NGgTXSYiCrtV5Hp2ilsmUp5aAKd
 rOjuy8Cr5z0WPaR66qtyTOx7dw7VoacEkrsP6CS6ADBJslLKj8kYKhydolap2pkemQ6e
 oEsg==
X-Gm-Message-State: AOAM530TZm60WhgnwazhWBJx2YbFkpg6apU1zwf6Rr7hpl1GwQi8FN0D
 yLTVLzMKKKU/cINDb/2uU1Og2S/WgzEIBURKpQBlNvL+uLQgTOHyicaet2SkEwclZn5osky8sbA
 ri1dcoNRBB51w5d/1ARJBsgm+gfogIvWi7N6fvp4WSw==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2923767wmf.93.1601363839304; 
 Tue, 29 Sep 2020 00:17:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM9slXPoYtcGdR2naRrQhkb2gEeBL2pP9tzwp7rdb0hF40OioFgPNIp6/uZtfjPtINhPMNVg==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr2923739wmf.93.1601363838975; 
 Tue, 29 Sep 2020 00:17:18 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id z15sm4722542wrv.94.2020.09.29.00.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:17:18 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:17:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH V1 vhost-next] vdpa/mlx5: Make vdpa core driver a
 distinct module
Message-ID: <20200929031348-mutt-send-email-mst@kernel.org>
References: <20200924143231.GA186492@mtl-vdi-166.wap.labs.mlnx>
 <20200928155448-mutt-send-email-mst@kernel.org>
 <20200929062026.GB120395@mtl-vdi-166.wap.labs.mlnx>
 <20200929022430-mutt-send-email-mst@kernel.org>
 <20200929063433.GC120395@mtl-vdi-166.wap.labs.mlnx>
 <20200929025038-mutt-send-email-mst@kernel.org>
 <20200929065744.GE120395@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200929065744.GE120395@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Sep 29, 2020 at 09:57:44AM +0300, Eli Cohen wrote:
> On Tue, Sep 29, 2020 at 02:51:12AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 29, 2020 at 09:34:33AM +0300, Eli Cohen wrote:
> > > On Tue, Sep 29, 2020 at 02:26:44AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Sep 29, 2020 at 09:20:26AM +0300, Eli Cohen wrote:
> > > > > On Mon, Sep 28, 2020 at 03:55:09PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Thu, Sep 24, 2020 at 05:32:31PM +0300, Eli Cohen wrote:
> > > > > > > Change core vdpa functionality into a loadbale module such that upcoming
> > > > > > > block implementation will be able to use it.
> > > > > > > 
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > 
> > > > > > Why don't we merge this patch together with the block module?
> > > > > > 
> > > > > 
> > > > > Since there are still not too many users of this driver, I would prefer
> > > > > to merge this as early as possible so pepole get used to the involved
> > > > > modules.
> > > > > 
> > > > > Anyways, I will send another version of the patch which makes use of
> > > > > 'select' instead of 'depends'.
> > > > > 
> > > > > Hope you agree to merge this.
> > > > 
> > > > Are you quite sure there will be a block driver though?
> > > > I'd like to avoid a situation in which we have infrastructure
> > > > in place but no users.
> > > >
> > > 
> > > I know it's in our plans but I see your point. Let me know if you
> > > prefer me to send the patch that fixes the 'depends' thing or defer it
> > > to a later time.
> > 
> > Not sure what's the depends thing.
> > 
> 
> Use "select MLX5_CORE"
> instead of "depends on MLX5_CORE"
> 
> Wasn't this agreed upon?

Hmm I don't know. I recall a similar discussion around VHOST_IOTLB.
That's different ...

I see

[linux]$ git grep MLX5_CORE|grep depends
drivers/infiniband/hw/mlx5/Kconfig:     depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on NETDEVICES && ETHERNET && INET && PCI && MLX5_CORE
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN && RFS_ACCEL
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN && NET_SWITCHDEV
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN && DCB
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on TLS=y || MLX5_CORE=m
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on TLS=y || MLX5_CORE=m
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN
drivers/net/ethernet/mellanox/mlx5/core/Kconfig:        depends on MLX5_CORE_EN && MLX5_ESWITCH
drivers/vdpa/Kconfig:   depends on MLX5_CORE

and no selects of this symbol, I guess you are saying you are changing everything
else to select - is that right? Then I guess vdpa should follow suit ...


> > > > > > > ---
> > > > > > > V0 --> V1:
> > > > > > > Removed "default n" for configu options as 'n' is the default
> > > > > > > 
> > > > > > >  drivers/vdpa/Kconfig               |  8 +++-----
> > > > > > >  drivers/vdpa/Makefile              |  2 +-
> > > > > > >  drivers/vdpa/mlx5/Makefile         |  7 +++++--
> > > > > > >  drivers/vdpa/mlx5/core/core_main.c | 20 ++++++++++++++++++++
> > > > > > >  drivers/vdpa/mlx5/core/mr.c        |  3 +++
> > > > > > >  drivers/vdpa/mlx5/core/resources.c | 10 ++++++++++
> > > > > > >  6 files changed, 42 insertions(+), 8 deletions(-)
> > > > > > >  create mode 100644 drivers/vdpa/mlx5/core/core_main.c
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > > > > > > index 4271c408103e..57ff6a7f7401 100644
> > > > > > > --- a/drivers/vdpa/Kconfig
> > > > > > > +++ b/drivers/vdpa/Kconfig
> > > > > > > @@ -29,10 +29,9 @@ config IFCVF
> > > > > > >  	  To compile this driver as a module, choose M here: the module will
> > > > > > >  	  be called ifcvf.
> > > > > > >  
> > > > > > > -config MLX5_VDPA
> > > > > > > -	bool "MLX5 VDPA support library for ConnectX devices"
> > > > > > > +config MLX5_VDPA_CORE
> > > > > > > +	tristate "MLX5 VDPA support library for ConnectX devices"
> > > > > > >  	depends on MLX5_CORE
> > > > > > > -	default n
> > > > > > >  	help
> > > > > > >  	  Support library for Mellanox VDPA drivers. Provides code that is
> > > > > > >  	  common for all types of VDPA drivers. The following drivers are planned:
> > > > > > > @@ -40,8 +39,7 @@ config MLX5_VDPA
> > > > > > >  
> > > > > > >  config MLX5_VDPA_NET
> > > > > > >  	tristate "vDPA driver for ConnectX devices"
> > > > > > > -	depends on MLX5_VDPA
> > > > > > > -	default n
> > > > > > > +	depends on MLX5_VDPA_CORE
> > > > > > >  	help
> > > > > > >  	  VDPA network driver for ConnectX6 and newer. Provides offloading
> > > > > > >  	  of virtio net datapath such that descriptors put on the ring will
> > > > > > > diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> > > > > > > index d160e9b63a66..07353bbb9f8b 100644
> > > > > > > --- a/drivers/vdpa/Makefile
> > > > > > > +++ b/drivers/vdpa/Makefile
> > > > > > > @@ -2,4 +2,4 @@
> > > > > > >  obj-$(CONFIG_VDPA) += vdpa.o
> > > > > > >  obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
> > > > > > >  obj-$(CONFIG_IFCVF)    += ifcvf/
> > > > > > > -obj-$(CONFIG_MLX5_VDPA) += mlx5/
> > > > > > > +obj-$(CONFIG_MLX5_VDPA_CORE) += mlx5/
> > > > > > > diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
> > > > > > > index 89a5bededc9f..9f50f7e8d889 100644
> > > > > > > --- a/drivers/vdpa/mlx5/Makefile
> > > > > > > +++ b/drivers/vdpa/mlx5/Makefile
> > > > > > > @@ -1,4 +1,7 @@
> > > > > > >  subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
> > > > > > >  
> > > > > > > -obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
> > > > > > > -mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/main.o net/mlx5_vnet.o core/resources.o core/mr.o
> > > > > > > +obj-$(CONFIG_MLX5_VDPA_CORE) += mlx5_vdpa_core.o
> > > > > > > +mlx5_vdpa_core-$(CONFIG_MLX5_VDPA_CORE) += core/resources.o core/mr.o core/core_main.o
> > > > > > > +
> > > > > > > +obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa_net.o
> > > > > > > +mlx5_vdpa_net-$(CONFIG_MLX5_VDPA_NET) += net/main.o net/mlx5_vnet.o
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/core_main.c b/drivers/vdpa/mlx5/core/core_main.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..4b39b55f57ab
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/vdpa/mlx5/core/core_main.c
> > > > > > > @@ -0,0 +1,20 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > > > > > +/* Copyright (c) 2020 Mellanox Technologies Ltd. */
> > > > > > > +
> > > > > > > +#include <linux/module.h>
> > > > > > > +
> > > > > > > +MODULE_AUTHOR("Eli Cohen <elic@nvidia.com>");
> > > > > > > +MODULE_DESCRIPTION("Mellanox VDPA core driver");
> > > > > > > +MODULE_LICENSE("Dual BSD/GPL");
> > > > > > > +
> > > > > > > +static int __init mlx5_vdpa_core_init(void)
> > > > > > > +{
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void __exit mlx5_vdpa_core_exit(void)
> > > > > > > +{
> > > > > > > +}
> > > > > > > +
> > > > > > > +module_init(mlx5_vdpa_core_init);
> > > > > > > +module_exit(mlx5_vdpa_core_exit);
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> > > > > > > index ef1c550f8266..c093eab6c714 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > > > > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > > > > > @@ -434,6 +434,7 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > > > > >  	mutex_unlock(&mr->mkey_mtx);
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_create_mr);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > > >  {
> > > > > > > @@ -456,6 +457,7 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > > > >  out:
> > > > > > >  	mutex_unlock(&mr->mkey_mtx);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_destroy_mr);
> > > > > > >  
> > > > > > >  static bool map_empty(struct vhost_iotlb *iotlb)
> > > > > > >  {
> > > > > > > @@ -484,3 +486,4 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
> > > > > > >  
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_handle_set_map);
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > > > > > index 96e6421c5d1c..89606a18e286 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > > > > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > > > > > @@ -98,6 +98,7 @@ int mlx5_vdpa_create_tis(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tisn)
> > > > > > >  
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_create_tis);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_destroy_tis(struct mlx5_vdpa_dev *mvdev, u32 tisn)
> > > > > > >  {
> > > > > > > @@ -108,6 +109,7 @@ void mlx5_vdpa_destroy_tis(struct mlx5_vdpa_dev *mvdev, u32 tisn)
> > > > > > >  	MLX5_SET(destroy_tis_in, in, tisn, tisn);
> > > > > > >  	mlx5_cmd_exec_in(mvdev->mdev, destroy_tis, in);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_destroy_tis);
> > > > > > >  
> > > > > > >  int mlx5_vdpa_create_rqt(struct mlx5_vdpa_dev *mvdev, void *in, int inlen, u32 *rqtn)
> > > > > > >  {
> > > > > > > @@ -121,6 +123,7 @@ int mlx5_vdpa_create_rqt(struct mlx5_vdpa_dev *mvdev, void *in, int inlen, u32 *
> > > > > > >  
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_create_rqt);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_destroy_rqt(struct mlx5_vdpa_dev *mvdev, u32 rqtn)
> > > > > > >  {
> > > > > > > @@ -131,6 +134,7 @@ void mlx5_vdpa_destroy_rqt(struct mlx5_vdpa_dev *mvdev, u32 rqtn)
> > > > > > >  	MLX5_SET(destroy_rqt_in, in, rqtn, rqtn);
> > > > > > >  	mlx5_cmd_exec_in(mvdev->mdev, destroy_rqt, in);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_destroy_rqt);
> > > > > > >  
> > > > > > >  int mlx5_vdpa_create_tir(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tirn)
> > > > > > >  {
> > > > > > > @@ -144,6 +148,7 @@ int mlx5_vdpa_create_tir(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tirn)
> > > > > > >  
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_create_tir);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_destroy_tir(struct mlx5_vdpa_dev *mvdev, u32 tirn)
> > > > > > >  {
> > > > > > > @@ -154,6 +159,7 @@ void mlx5_vdpa_destroy_tir(struct mlx5_vdpa_dev *mvdev, u32 tirn)
> > > > > > >  	MLX5_SET(destroy_tir_in, in, tirn, tirn);
> > > > > > >  	mlx5_cmd_exec_in(mvdev->mdev, destroy_tir, in);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_destroy_tir);
> > > > > > >  
> > > > > > >  int mlx5_vdpa_alloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 *tdn)
> > > > > > >  {
> > > > > > > @@ -170,6 +176,7 @@ int mlx5_vdpa_alloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 *tdn)
> > > > > > >  
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_alloc_transport_domain);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_dealloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 tdn)
> > > > > > >  {
> > > > > > > @@ -180,6 +187,7 @@ void mlx5_vdpa_dealloc_transport_domain(struct mlx5_vdpa_dev *mvdev, u32 tdn)
> > > > > > >  	MLX5_SET(dealloc_transport_domain_in, in, transport_domain, tdn);
> > > > > > >  	mlx5_cmd_exec_in(mvdev->mdev, dealloc_transport_domain, in);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_dealloc_transport_domain);
> > > > > > >  
> > > > > > >  int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, struct mlx5_core_mkey *mkey, u32 *in,
> > > > > > >  			  int inlen)
> > > > > > > @@ -266,6 +274,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> > > > > > >  	mutex_destroy(&mvdev->mr.mkey_mtx);
> > > > > > >  	return err;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_alloc_resources);
> > > > > > >  
> > > > > > >  void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
> > > > > > >  {
> > > > > > > @@ -282,3 +291,4 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
> > > > > > >  	mutex_destroy(&mvdev->mr.mkey_mtx);
> > > > > > >  	res->valid = false;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(mlx5_vdpa_free_resources);
> > > > > > > -- 
> > > > > > > 2.27.0
> > > > > > 
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
