Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC57C433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D0640664;
	Thu,  2 Dec 2021 03:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17TH1ncbhvGU; Thu,  2 Dec 2021 03:32:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF81140641;
	Thu,  2 Dec 2021 03:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B99D9C0012;
	Thu,  2 Dec 2021 03:32:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E0C5C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 223F7607B9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AzwVzGAi7tCY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:32:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2B06607B7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni4+U5TUi/6s+/6FsWbuJdAfD9DtfMCbkpryYylGFUCpjQSiv2LDsmzQqD9QkxM0Z6DWhjOnnZf5dVc5wGnbFqysEzXUl3Ddq6KY7oYHHAlQBQYJgjzLqQSO4p/zLgnJ4244nIninDa4h46dszwXmrF4ejpEkeE7PIa3TygXYbO0g6LYL+jV5/w4C1wS0aU/oEbg/LvaLJDpHmTWtIrGzt6K48mDyXwZQ77IleacM3t6IU4orPqBCYq2n/scW87+50AuxG3osmblFIeINR1N3qviTtSd0BXNZPQIEaS4SL/CY3PCCII8KZ1KxqKZ5AvJ2GBUNdZd3J/cN9w5ILdgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PkXyo2iEtMoKBjb0aQ39OUcv/aCLxIZxRZxEETqNH0=;
 b=iaB3Pq/FM14sjPJoAEHo0+W2dI1VOVtlkj7GuffuueCdm+tLqDbxOED1w/GWPFiBIZlaIDrQmTjbk0IPgf+VS5XjNaJEVyJvQpi1TaPFxBAQZHFqechkQscQrskGXU+B7LdS/S2Suew11JySBV/Nx/k29rLVhXZWOiD47wzFBT2gJbdLMhMCCuf6pDOueE4k3il1izfImJkV7L5HLQebMKTs7rTctR36CcUB/ZcLJXUEm/s8TvkxUawOsOVd1hmOtw9d0C1ifk8Rd+WPSF2uDR2tz8WoghC15g62hhte9UuKKBC/kEGjdh9QtkkF1dxq1k3P4cBRaVRJizbIzwaoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PkXyo2iEtMoKBjb0aQ39OUcv/aCLxIZxRZxEETqNH0=;
 b=SfYHLluCHurwTEIIs2mEvPwr0mKiMESh+raR9A0yaV/bnNIHsdnk2hKHD3h8ljOuo1t4jYD0CcG/tGa7SZZG0w26dGeHN3N1dBggiXV5N7XQPDebk2yUbPvMyjkrZmCXuW9/Mi4EbT/goxJ5yAPMbDlytG5l2U75qlJA3uFcTzuwqnP226fKDDVAZmOkSvZNsN33I63wNUpakPaLc1IWY56L9IM9jlasW07NlTsjgOBagp+RXu3klSSUAKuT51BHXJE6zI5cZJWUWdk22voui1Zi0BbIeCSdjwgGwFvVTOIqV3R6J+W6USnvJVxG1rf0w92xy5h6vs8o7QJlURn6ng==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 03:32:26 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 03:32:26 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 1/7] vdpa: Allow to configure max data virtqueues
Thread-Topic: [PATCH 1/7] vdpa: Allow to configure max data virtqueues
Thread-Index: AQHX5u3YwwZGwe8VQ06DL5pVTy5xdqweitgg
Date: Thu, 2 Dec 2021 03:32:25 +0000
Message-ID: <PH0PR12MB54810B8C4147AF8069064512DC699@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-2-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-2-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b650a75d-e195-4620-96ca-08d9b5445c46
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-microsoft-antispam-prvs: <PH0PR12MB5482877353E86F52B3401C60DC699@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwNF4FKBYRfs/Mc6FDUakU5pGrUntjMLODpse+mbXk/yCVebnnv+HbVvAW2O7+A+T+sQrmhIzufxutwjrLBdczbTmL9rkmehxCknxNGzIW/YdEEWE3mXgcF43HSzaZOZevUUYPu5cfvVPG/6wtsHtgG0SC0BDRqsZno1ZXWCSYP5fvQm9kTIm+DDkujBnlohdm4h/tV6G6KpuiVVjh3NaIILuImQCcyTnmexBCzVtFMAk52ajSR3vOcscsxojnuasHE2tKkmN+Mu6/bZmKZ13uftk4mtF/Vm9qO5l2bajKo/HM4QrqqjIqfOVOn6GEY5wniLnVZLgKmDV3AI7ZsKGv6UPz6gsymXqCFKPNcZRrZnHnedDTpt45bsVZVuhY10AKajvuLm6m7wz+q9T4OWZItDUCKMcdc9fD7xIUVFvWXbERfHfEpWhYKS7+9D8yOIzYktkvcIToiVCw1oFUwvAcrTxs3JPVa4MvrWOcfGpG+OdAi7qstkC0GsI9HcuXbIiHBlG64UoNITfNezmvy1EpF6/jmzR7EGWHJd1tFbsN9xFZcaLCAuPVA821UhsaxItlXspDfQQC2jr7htNXfid2XaZ/F7xdyaY6VpZLkZeURTshgJdLwc0PPkP51xKZcGRWOjBhpDjIa0YtFY8mdEKUSsq4HSMCoRITYJXP33UHNjFe8fRmERQlxDc4MyFV4J8eT+ga+Xy2SkrTwbeHE6PQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(71200400001)(508600001)(52536014)(122000001)(38070700005)(110136005)(6506007)(316002)(38100700002)(7696005)(66946007)(66446008)(66556008)(8936002)(4326008)(186003)(64756008)(26005)(33656002)(66476007)(5660300002)(76116006)(8676002)(2906002)(9686003)(86362001)(55016003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yw41IJEzB/El2VNNdmndRSUv7V999zt0FxB0yGxMYiElBPZE1WJV3FxBBwFy?=
 =?us-ascii?Q?obPCLdSD2CFYsaG5K6L/MtNvPXhHy5RhrJ3sxsBvfTkU6yoH7EIh8DMRDysR?=
 =?us-ascii?Q?f0mMW48GJ8/fNtaPYkMdRc2jj7eHTDVMmtdwvl7N3WEOYJHWYVjyebf9ZhY9?=
 =?us-ascii?Q?BEvl9BCi4MmfKY78PLwLiQ1ye1zjyHgYsYlyhbJqGMb+rzWZVlmrcqnvDFzb?=
 =?us-ascii?Q?KGPzB8O7bfbSRTPQDr2I6LDWl0PxHPWFxN8SeP4I/7CL6x+cD/ipoqOGjlau?=
 =?us-ascii?Q?99RXV4glPtPNAyWgeAS8k+BLsZTmhkr/GEXCQl12JsjnuvLk721SjUUc7ppZ?=
 =?us-ascii?Q?mWvjAM+QVHESPZ1HmxH0BI5jqrQfnSX4RcvcTzC9CvhgP2R74n6Rj9Ccx43K?=
 =?us-ascii?Q?jzxVkvSPKtTZeoNlO2/fVWAbnMGuZ+d/kkkuuvEwN4n202DrkqEXh75ITXCA?=
 =?us-ascii?Q?hXYKfyOPPk5i86a0RxBOpAAVzxFo0FZy4s5RUWkbpF7bAuv1ZLx2QFaXung0?=
 =?us-ascii?Q?IYlE075EFNswMaoBnmqfNLo/WlXFqC3SJr8XrjSuNJmZtBUZAsbFXOtIM4Ed?=
 =?us-ascii?Q?bPJBZh4PFPMEoN99LhcSTvQJrqnT7ga25rmFb9rR8qRPfLyt15WZ/0QN1m9p?=
 =?us-ascii?Q?T9JZRjV7fHZmTNQSrP5VuzsE+7IRdRKVcXa2etPqyK4dU87DIokFms/zNoas?=
 =?us-ascii?Q?QxfPPk89VUVRZqvijQKxxrcB2wJMLNrHlbqu4zL267Z9Kb5c3tTjuzcNrO0r?=
 =?us-ascii?Q?TxBqGpIP2KXZUoBhJevXYrglIrPAF0X9cFht0spIAUtb1P/YZsYp1GbBJvHU?=
 =?us-ascii?Q?V97jHGdTtluvQGoEBg37s4Fa18u0sVkUbZ+0rTQo9Ka7QbWbJdwgrIsqGAPT?=
 =?us-ascii?Q?h1Qux82uXl4bYwoSdA3lbOX28hmbettK0tst8m6YNbii1lQJLfwSljXQOY++?=
 =?us-ascii?Q?JoPgdme4yfXpsRjE+q47kFXmqOuRdyhWFZ4f9hXOlbkOV4ZH0WvKgjbEh0Hv?=
 =?us-ascii?Q?6n5mcVEuZuAkWi/eup0Jdm/m6xQw44k5OM2OLjPqe0SsC4N2Yf4VYh2B2AKR?=
 =?us-ascii?Q?RC77pTyo/9p8zX6zcPwVIjmeeqS7ASqyh4r+MAhs4D3/CmscuqgTv6ltxXEO?=
 =?us-ascii?Q?QdIx6mvKc2qZB2F7CWer/df+MObdRPgQ0cI2565hi+B/i3ZkWz/mReOxTV6q?=
 =?us-ascii?Q?bOEvYw8IPIEpDfAby58Ngt9goxMLHI7hhO0OCLI4cdYtnwZ7Lm7iNmWN35kI?=
 =?us-ascii?Q?CNIp3yHmWriANesQ4mp1Ai4NNU3ExZSrU6wgHSe0abl7DjgQYIVtQH2mNwea?=
 =?us-ascii?Q?isL9ISMekQiBe00kL0ApenSytht2FOTJB0xswgitBzFb/MpOx9Vb543Q1kfc?=
 =?us-ascii?Q?bD8P8umS74/2PY1Y0/yiYnStliKkQUEnTHXuH8ll3V7PoTeC2ihjS+jW2IIx?=
 =?us-ascii?Q?W6xZi1p/oq0FXwg6WaRQa8Bi8zknYefqRQzxm2YLG/JPb8U/mUyDMyI2fbmG?=
 =?us-ascii?Q?S9BrIBvTH/gPg4fG7em7TIadHm1Kd4VgmLrkYNo7R3THdhayAJvqJTBqPZl5?=
 =?us-ascii?Q?0f7f9wOy8KLl6UnNc6AaC6D7p3v0gojmo/YWIv+r4LWTmXfJq51hxjqXfAln?=
 =?us-ascii?Q?ahO7u45FrKHxPpdXz0t+Rdc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b650a75d-e195-4620-96ca-08d9b5445c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 03:32:25.8805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrbwOX+2OCvuLhh8u6QAtxONfZxDXIQnpJ9pH52+ipbELc5oxCTpURmMKLZxcaE9EJBvFt7AGPXphc14ImFJhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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


> From: Eli Cohen <elic@nvidia.com>
> Sent: Thursday, December 2, 2021 1:27 AM
> 
> Add netlink support to configure the max virtqueue pairs for a device.
> At least one pair is required. The maximum is dictated by the device.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c  | 14 +++++++++++++-  include/linux/vdpa.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> 7332a74a4b00..f06f949d5fa1 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff
> *msg, struct netlink_callback *cb)  }
> 
>  #define VDPA_DEV_NET_ATTRS_MASK ((1 <<
> VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +				 (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> +				 (1 <<
> VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> 
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct
> genl_info *info)  { @@ -506,6 +507,17 @@ static int
> vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> 
> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
>  		config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
>  	}
> +	if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> +		config.max_vq_pairs =
> +
I think you need to add to the vdpa_nl_policy[] array so that it gets validated for min and max range range.

> 	nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> +		if (!config.max_vq_pairs) {
This will go away one you nl_policy is use for NLA_U16_RANGE(1, 32768) for this attribute.

> +			NL_SET_ERR_MSG_MOD(info->extack,
> +					   "At list one pair of VQs is required");
> +			err = -EINVAL;
> +			goto err;
> +		}
> +		config.mask |=
> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +	}
> 
>  	/* Skip checking capability if user didn't prefer to configure any
>  	 * device networking attributes. It is likely that user might have used
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h index
> c3011ccda430..820621c59365 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -101,6 +101,7 @@ struct vdpa_dev_set_config {
>  		u16 mtu;
>  	} net;
>  	u64 mask;
> +	u16 max_vq_pairs;
This is net only field. Please move it inside the net struct above.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
