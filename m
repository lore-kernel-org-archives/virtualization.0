Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A55C388F9
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 05:56:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A6F221FF
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 05:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVgUDyjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A6F221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 18A8E85C5C;
	Mon,  2 Nov 2020 05:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcVsm3RcVODR; Mon,  2 Nov 2020 05:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42D8885C54;
	Mon,  2 Nov 2020 05:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24E2BC0889;
	Mon,  2 Nov 2020 05:56:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDEC0C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D86D186A3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCJK0LYZ4IcU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:56:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F2EAB86A36
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 05:56:30 +0000 (UTC)
Received: from localhost (host-213-179-129-39.customer.m-online.net
 [213.179.129.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C7DC820870;
 Mon,  2 Nov 2020 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604296590;
 bh=H4bxrHgb7QzAd4s6R7ZAcPSYQsd0k6a8eql72d8Wh3g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IVgUDyjOS+GO22O0osaO3K3VzLaZ5+NfqDzIdn3mEMC6Vw5Yp7Pm/EgRYKkZQqnLK
 R1Gw0mAB9KsxH2iSTGv+VOVRvic3kO2Q+DRP+NkrKNolUy5EZgtKHfaAXdGEBNeGb7
 7kW+SggiAe5YWsZ2eXZnpDk8Hnz9ZN5kCTnuZ+Jo=
Date: Mon, 2 Nov 2020 07:56:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH mlx5-next v1 03/11] net/mlx5_core: Clean driver version
 and name
Message-ID: <20201102055626.GD5429@unreal>
References: <20201101201542.2027568-1-leon@kernel.org>
 <20201101201542.2027568-4-leon@kernel.org>
 <BY5PR12MB4322B244D7AEBDCED43B906EDC100@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4322B244D7AEBDCED43B906EDC100@BY5PR12MB4322.namprd12.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "tiwai@suse.de" <tiwai@suse.de>,
 "ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "fred.oh@linux.intel.com" <fred.oh@linux.intel.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "kiran.patil@intel.com" <kiran.patil@intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>, Roi Dayan <roid@nvidia.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
 gregkh <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S . Miller" <davem@davemloft.net>
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

On Mon, Nov 02, 2020 at 05:07:59AM +0000, Parav Pandit wrote:
>
>
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, November 2, 2020 1:46 AM
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Remove exposed driver version as it was done in other drivers, so module
> > version will work correctly by displaying the kernel version for which it is
> > compiled.
> >
> > And move mlx5_core module name to general include, so auxiliary drivers
> > will be able to use it as a basis for a name in their device ID tables.
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/devlink.c     |  2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c  |  4 +---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rep.c      |  1 -
> >  .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c   |  2 +-
> >  drivers/net/ethernet/mellanox/mlx5/core/main.c        | 11 +++++++----
> >  drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h   |  3 ---
> >  include/linux/mlx5/driver.h                           |  2 ++
> >  7 files changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > index a28f95df2901..1a351e2f6ace 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> > @@ -52,7 +52,7 @@ mlx5_devlink_info_get(struct devlink *devlink, struct
> > devlink_info_req *req,
> >  	u32 running_fw, stored_fw;
> >  	int err;
> >
> > -	err = devlink_info_driver_name_put(req, DRIVER_NAME);
> > +	err = devlink_info_driver_name_put(req, KBUILD_MODNAME);
> >  	if (err)
> >  		return err;
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > index d25a56ec6876..bcff18a87bcd 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> > @@ -40,9 +40,7 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv
> > *priv,  {
> >  	struct mlx5_core_dev *mdev = priv->mdev;
> >
> > -	strlcpy(drvinfo->driver, DRIVER_NAME, sizeof(drvinfo->driver));
> > -	strlcpy(drvinfo->version, DRIVER_VERSION,
> > -		sizeof(drvinfo->version));
> > +	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo-
> > >driver));
> >  	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> >  		 "%d.%d.%04d (%.16s)",
> >  		 fw_rev_maj(mdev), fw_rev_min(mdev),
> > fw_rev_sub(mdev), diff --git
> > a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > index 67247c33b9fd..ef2f8889ba0f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
> > @@ -64,7 +64,6 @@ static void mlx5e_rep_get_drvinfo(struct net_device
> > *dev,
> >
> >  	strlcpy(drvinfo->driver, mlx5e_rep_driver_name,
> >  		sizeof(drvinfo->driver));
> > -	strlcpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
> >  	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
> >  		 "%d.%d.%04d (%.16s)",
> >  		 fw_rev_maj(mdev), fw_rev_min(mdev),
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> > index cac8f085b16d..97d96fc38a65 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
> > @@ -39,7 +39,7 @@ static void mlx5i_get_drvinfo(struct net_device *dev,
> >  	struct mlx5e_priv *priv = mlx5i_epriv(dev);
> >
> >  	mlx5e_ethtool_get_drvinfo(priv, drvinfo);
> > -	strlcpy(drvinfo->driver, DRIVER_NAME "[ib_ipoib]",
> > +	strlcpy(drvinfo->driver, KBUILD_MODNAME "[ib_ipoib]",
> >  		sizeof(drvinfo->driver));
> >  }
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > index 71e210f22f69..9827127cb674 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> > @@ -77,7 +77,6 @@
> >  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
> > MODULE_DESCRIPTION("Mellanox 5th generation network adapters
> > (ConnectX series) core driver");  MODULE_LICENSE("Dual BSD/GPL"); -
> > MODULE_VERSION(DRIVER_VERSION);
> >
> >  unsigned int mlx5_core_debug_mask;
> >  module_param_named(debug_mask, mlx5_core_debug_mask, uint, 0644);
> > @@ -228,7 +227,7 @@ static void mlx5_set_driver_version(struct
> > mlx5_core_dev *dev)
> >  	strncat(string, ",", remaining_size);
> >
> >  	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
> > -	strncat(string, DRIVER_NAME, remaining_size);
> > +	strncat(string, KBUILD_MODNAME, remaining_size);
> >
> >  	remaining_size = max_t(int, 0, driver_ver_sz - strlen(string));
> >  	strncat(string, ",", remaining_size);
> > @@ -313,7 +312,7 @@ static int request_bar(struct pci_dev *pdev)
> >  		return -ENODEV;
> >  	}
> >
> > -	err = pci_request_regions(pdev, DRIVER_NAME);
> > +	err = pci_request_regions(pdev, KBUILD_MODNAME);
> >  	if (err)
> >  		dev_err(&pdev->dev, "Couldn't get PCI resources,
> > aborting\n");
> >
> > @@ -1617,7 +1616,7 @@ void mlx5_recover_device(struct mlx5_core_dev
> > *dev)  }
> >
> >  static struct pci_driver mlx5_core_driver = {
> > -	.name           = DRIVER_NAME,
> > +	.name           = KBUILD_MODNAME,
> >  	.id_table       = mlx5_core_pci_table,
> >  	.probe          = init_one,
> >  	.remove         = remove_one,
> > @@ -1643,6 +1642,10 @@ static int __init init(void)  {
> >  	int err;
> >
> > +	WARN_ONCE(strcmp(MLX5_ADEV_NAME, KBUILD_MODNAME) ||
> > +		  strlen(MLX5_ADEV_NAME) != strlen(KBUILD_MODNAME),
> > +		  "mlx5_core name not in sync with kernel module name");
> > +
> In which case, both the strings are same but their length not?
> You likely don't need the string length check.

Yes, I was overzealous, I'll remove when will apply the series.

>
> >  	get_random_bytes(&sw_owner_id, sizeof(sw_owner_id));
> >
> >  	mlx5_core_verify_params();
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> > b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> > index 8cec85ab419d..b285f1515e4e 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> > @@ -42,9 +42,6 @@
> >  #include <linux/mlx5/fs.h>
> >  #include <linux/mlx5/driver.h>
> >
> > -#define DRIVER_NAME "mlx5_core"
> > -#define DRIVER_VERSION "5.0-0"
> > -
> >  extern uint mlx5_core_debug_mask;
> >
> >  #define mlx5_core_dbg(__dev, format, ...)				\
> > diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h index
> > 317257f8e0ad..ed1d030658d2 100644
> > --- a/include/linux/mlx5/driver.h
> > +++ b/include/linux/mlx5/driver.h
> > @@ -56,6 +56,8 @@
> >  #include <linux/ptp_clock_kernel.h>
> >  #include <net/devlink.h>
> >
> > +#define MLX5_ADEV_NAME "mlx5_core"
> > +
> >  enum {
> >  	MLX5_BOARD_ID_LEN = 64,
> >  };
> > --
> > 2.28.0
>
>
> Other than strlen removal check,
> Reviewed-by: Parav Pandit <parav@nvidia.com>
>

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
