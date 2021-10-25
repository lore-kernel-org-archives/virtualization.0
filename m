Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3783C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 18:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118BE60FC2
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 18:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 118BE60FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA1E280F0C;
	Mon, 25 Oct 2021 18:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6i7-QImkfa-1; Mon, 25 Oct 2021 18:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60F3A80EA2;
	Mon, 25 Oct 2021 18:35:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44794C0019;
	Mon, 25 Oct 2021 18:35:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 271A2C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 18:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21C3540462
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 18:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BRnFQTUPDNQq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 18:35:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 080DC40461
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 18:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l23aYUh/afOLnk0//pbLNLUnaDN6yGKA5nT5SxdoX8M/Plf0kWVFM0aEb/JR7a17SEehE2Ya2T6AxnHmpHBmTzeSPFJ9lOsAeaPGSpGbRBJL33F9Kw/FjUXq8swsQqk0F/EFFMTzFPM9e6yEWh53QvphtkDiDirpWFjCBnxVUekTxQbUTvGsKV8lMZG396tzQXYI88Ue9ch2RyxL0bFcxN7giyMYZp5DI4x4pp3rdLo9ZzdKBsu2TainY7WikHp6VG4ewqIaeXkcTMQPV6VaC7ThLrWTab6RUxab7SPE2jnwb/R8Cd4Zp3ztLXbxo7fqkNNDTHE7mjPRzzwdGFee1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hmxcs3rgmuRykHRVATcffDU8u2GacUWuY+VE1SpQX2o=;
 b=MGDzZlEliWXcKa3uZpHn/tPHN+S5JOO6KjLbUTcYPjHIJ3+9P4bqezKEqMN5uUnw4xOzaSqMqClv6ogWUoNj6e6YeHsA5vIRR3Bm+wB0flrKljasTEK8S7aCxTRpsX+d1Ep213mvV9n3ARhLWFcm+Yeq6N46OgCoC0Vqhl0Ba+0ATNUR1PG5B3T1woJTlXNImegKcftJFA+8y0RdI9gtwl2u0v/YQ5Ey6n/Nj3T+wv6leexrvSmLN8AQ7XJ/Z+0eCj1y5uhgGpYSVxWARlkakj9D3TnmKcVJZQGYXu3AdMzYN6LHrsJxFnd5z3KWuqapotH35JaiILuyyxIoRRB4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hmxcs3rgmuRykHRVATcffDU8u2GacUWuY+VE1SpQX2o=;
 b=mOr9m8ZaciMCNUXG+f4QcPG/4TCouiHE6F/rlQEaEZWIYhb6+/IEQTozdDTo24lRIWvubu7xNCV4+M9GTyl6wzoI4E2DeExvouA+DxreoKzwvg0mDL1DB9wH5UoqmCaxLlHmb17wVJ/AQWtlq0U7R+lUpL6UyP+pPqLf1GrI8uhpj4+TXwlZe/zr2bu3svGLHXKqrkQfnbTAHRvaac5ySNxAeLUuEGmHrzsjohxTLeAiVJfh0TLpMqgqUyZ+lpH8J/hm+Zb7cOVqwFsG/TPSgFGc4PAAJmk1fBzm/nMtAOZrLTfjU3H0SXGrfpm1K/RUspOKs/KRskUklgPoYx7evg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 18:35:35 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 18:35:35 +0000
To: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Topic: [PATCH linux-next v5 7/8] vdpa/mlx5: Support configuration of MAC
Thread-Index: AQHXyZ9Zee9PnHCFgkCpho/IiIavRavkCf8Q
Date: Mon, 25 Oct 2021 18:35:35 +0000
Message-ID: <PH0PR12MB5481911ACF48EE43603F5EA6DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-8-parav@nvidia.com>
In-Reply-To: <20211025125316.67664-8-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a19bd26-b375-4065-74cf-08d997e63beb
x-ms-traffictypediagnostic: PH0PR12MB5418:
x-microsoft-antispam-prvs: <PH0PR12MB5418215374B9B55CA7B59034DC839@PH0PR12MB5418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbPoCj30Umogqz8ey9c/TJ7mng0qq1VI89MuXFZfUW9jocd10esbknhEczq5CtYc2pQ8EMxxsLFcuy4TVls5DiHDyfc2Ocdu54bgOcrhZqOKTYRTXy8Uk5snb5OmPhNzMggEhXal3VySLkmCCdU1uP7zV4lV1JvUJ573Tm+o59R9mPjBF/+xAGhyuyrFiDbVgMCah99rY6QZ15NTQcs5j7SXGrnJ7EkWJwA9jCgVpoDr2kQfdfCIKd65eWyH5fXhtzoawaEenCBqmNJ/22jCmFHTTEP3DBWgAusDFRUemAYbPmauUQSm/Gv3BLx4RE61iBqrxMa/A5T6cjZ0iJagfwQWdojxIlwvXy2O10KuA+zK/Juk0GGkASqx6TdUr5MS1clIwqQ55ObytH29h9UUModvXKcdbBN8CC/MCm5Fcm5wvKdbgmLjc3i+Hk8BosTACMbFe34Q8wKXRn3RH0HaHRPJUuvHr141Ta3AX1sKJSjnqi6pomC3UMpLjx9JWFrYYkQMjJ5339makc7pPqy2C/2NJm4+myHL4LhhX6BvazKOROp8XHEqAzcNJrcG2YMCE1XmijfDrDctcDeH8CSG6UfKdwQNg62p5pBE66K6D1zOe1D6xENuGJGmWFY24xKxcPOZFHrieXFSZI5y/W/lx5xV4kUaSf4IpJDWz5VzT35oAB+XAVQUR8q8HrG3oggcv8vr555NKd7tQ+6vQ/6OFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(5660300002)(107886003)(52536014)(186003)(6916009)(38070700005)(54906003)(508600001)(86362001)(316002)(6506007)(55016002)(71200400001)(83380400001)(8936002)(7696005)(66556008)(66476007)(76116006)(64756008)(4326008)(66446008)(2906002)(26005)(122000001)(38100700002)(33656002)(66946007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gcXqM6Ahcz5aGJ7QMFkCUDNGUBXds08eVa3Vrf30HImpkO5+nvM08u8xEC6E?=
 =?us-ascii?Q?99NOJolLVv/Ob0XGlyMX7d7Jtl+a1fV8X0j97XkPr5ylRzODWri11x1kBa/X?=
 =?us-ascii?Q?LDh3dVli+Wf0BCam9NpbujM9V3S/9ceU6nCpb1AzaxRxxDhtbBUomXOltnrz?=
 =?us-ascii?Q?sbpTcjB7Y+vaGUd6ftwlJqPr8dJ0p1e7K5xfzkU2BNB2VkXf4/XiY1/J8js2?=
 =?us-ascii?Q?ume5Y1jqLgkZgSHSeQYUj0kAWC5VefW9jtFZyVlx4am7QlUa1UAX5y4W8H0/?=
 =?us-ascii?Q?41Wd4Sa4h8B6o0uSHQGJimejAgEsJFmvU1840SuxlyH/07YARuRX1RbBagHs?=
 =?us-ascii?Q?FiGJBbYLj1uHhTEzUm38uReGse3hAriDNIjkdz9ZSAmmLSACj8wJ8aQmGXR4?=
 =?us-ascii?Q?+vDLptUYtMZs/GJZcL/Z9qdyPOgvXjPkqCEEq768aBa05nItyuDRrvJZjAET?=
 =?us-ascii?Q?u+IKRKWZeEuYGLihoxlOSJgaNKky1YmjbIUFrsr0K4I5N6Sowaj77tYcelaY?=
 =?us-ascii?Q?72+b0tF+DcvNJ3SH+iN48/z7cC9H1crsfzPNR9y3lReQ9N4iek9s/n9E19N4?=
 =?us-ascii?Q?F8cXYQ5eICrBueVowjsw2JWMgzJQA5hCwVwc/CAKiyUeQP29vRDu2uu0AyLw?=
 =?us-ascii?Q?2EtHhnfYnWL0+DvmuFvOz2N6TiliuSqyJ5QI983TNVxtlyWg5IrCDsjVPAo+?=
 =?us-ascii?Q?kBGhjfyA+FBYME3nFGgyxlxOBZ6sUe1gbTcBjUDYqlywVzRMmFBUWuatfelG?=
 =?us-ascii?Q?rDFaOsMM61i2GC7mPHEd9muWJeuKK34TzE4PVsBnldDvtCJajZfFbC8f0wA6?=
 =?us-ascii?Q?ZVh9voCzMV8/YchQ7yrzXg3XWm15rSfmQE6oazgb90cfZM142QQq2gqQu1Al?=
 =?us-ascii?Q?Jh7eqgfgcSolkSOQFuG0Oclg6JtXJhd1IYXBpRlwCQD0mCQgZkhEpYVuTL/5?=
 =?us-ascii?Q?SeZTWp9vEI4QW/P2FIIiSAHbw2xm3PFpe2QPcI/b+DIu2+mZOyiE/CFrrepU?=
 =?us-ascii?Q?y+15Z5kHPUPU9gPC3/WMhAw+U8gzV3jKBRcJxEVNYrqQC+B6gT+bZ9QBpajD?=
 =?us-ascii?Q?t8Af/aHgmje5AQiyV7GKtLMx8vHDCS+50ySG6YMcEQ+lGvP9k6ogJHt4s6J6?=
 =?us-ascii?Q?/BVIS9xCtXRtQ1dPSOO6ze8vxB1Cz0VhC9M+f8nvdjVxN9Rc4531JFvZmktS?=
 =?us-ascii?Q?QquOkiuGBLAmp63qZo4ColQPw8FO8h5IHG4c7VCjKoantHaY4tawVKZnoJIG?=
 =?us-ascii?Q?/0kuf9y0MFBcMieYDaXhzCCO3l4LUoytQnRPkMt5OXjFT4TIE8P76uIQxBAl?=
 =?us-ascii?Q?WoYRl58KQrJSfA6ZV8RpszaXMxDzGQO/elfZdOm8zBjt3IIrXbVVhUXBokft?=
 =?us-ascii?Q?YNQTHTo/U5jNg49QY5DjvNLg+v753udeNcutP1Cxkxtg7R0a2sDI1e79D7/j?=
 =?us-ascii?Q?lqNSBMLZEWRpNJx/itrtxlGog1CMk4INIKo4eSdsB5DqqZcMHb+JomQuR20C?=
 =?us-ascii?Q?2JemQX+fp5URoq91snsfbyW2WeBflZxuJRiPpAgg+aT3akvuymd6Ejr7XwKs?=
 =?us-ascii?Q?fCDJDjSJZsCNQad1GmcmBSmKc+9d/ua3+cEIpdS5RGrr+5AmhGPx+z8H+3Q3?=
 =?us-ascii?Q?rwfw24wUGNTS4Ivn0S3H78s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19bd26-b375-4065-74cf-08d997e63beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 18:35:35.2069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UOv7oZ/wfHgbl0vop9ygmZp73M6cFjMEUUuw9U/4rGcJI6/IHrgaS+AuwbPOuP0DNKc+LnxELatuBB+GTEChg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


> From: Parav Pandit <parav@nvidia.com>
> Sent: Monday, October 25, 2021 6:23 PM
> 
> From: Eli Cohen <elic@nvidia.com>
> 
> Add code to accept MAC configuration through vdpa tool. The MAC is written
> into the config struct and later can be retrieved through get_config().
> 
> Examples:
> 1. Configure MAC while adding a device:
> $ vdpa dev add mgmtdev pci/0000:06:00.2 name vdpa0 mac 00:11:22:33:44:55
> 
> 2. Show configured params:
> $ vdpa dev config show
> vdpa0: mac 00:11:22:33:44:55 link down link_announce false max_vq_pairs 8
> mtu 1500
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 8d1539728a59..860d80efa5d1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -6,6 +6,7 @@
>  #include <linux/vringh.h>
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_ids.h>
> +#include <uapi/linux/vdpa.h>
>  #include <linux/virtio_config.h>
>  #include <linux/auxiliary_bus.h>
>  #include <linux/mlx5/cq.h>
> @@ -2523,18 +2524,19 @@ static int mlx5_vdpa_dev_add(struct
> vdpa_mgmt_dev *v_mdev, const char *name,
>  	if (err)
>  		goto err_mtu;
> 
> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
I messed up above line in the rebase conflict.
Let me resend the series.

> -	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev,
> VIRTIO_NET_S_LINK_UP);
> -
> -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> -	if (err)
> -		goto err_mtu;
> -
>  	if (get_link_state(mvdev))
>  		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev,
> VIRTIO_NET_S_LINK_UP);
>  	else
>  		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev,
> ~VIRTIO_NET_S_LINK_UP);
> 
> +	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR))
> {
> +		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
> +	} else {
> +		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config-
> >mac);
> +		if (err)
> +			goto err_mtu;
> +	}
> +
>  	if (!is_zero_ether_addr(config->mac)) {
>  		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
>  		err = mlx5_mpfs_add_mac(pfmdev, config->mac); @@ -2632,6
> +2634,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	mgtdev->mgtdev.ops = &mdev_ops;
>  	mgtdev->mgtdev.device = mdev->device;
>  	mgtdev->mgtdev.id_table = id_table;
> +	mgtdev->mgtdev.config_attr_mask = (1 <<
> +VDPA_ATTR_DEV_NET_CFG_MACADDR);
>  	mgtdev->madev = madev;
> 
>  	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> --
> 2.25.4
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
