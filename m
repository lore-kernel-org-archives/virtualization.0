Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E1C433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32F474055A;
	Thu,  2 Dec 2021 03:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tXf_wvcu0aH; Thu,  2 Dec 2021 03:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F073404AD;
	Thu,  2 Dec 2021 03:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DAB4C0012;
	Thu,  2 Dec 2021 03:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B35C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1881D403BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3CqqzvKKZS04
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:34:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D4AF403A5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:34:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnhBI4zqc6MZAmVqYLiaSJsfq98jjBE3dAt481xn2aryJHonBcgd15t9MNMasI8TedwH3i0VMACAljXa0ftOmzEkzy4ANMulOJesMu3+MeMsOwlvOFfqBdUQlyezir3YPrX6SFZbUnIwmHTj+4HSWkXh641oEslwP7yrt/L+5GokjunoR2EYJgfmAZRUaGKMXm65dbE+9eLEtESWa526I7HxF2H492x8/xrqAw7LpuUH6wiamYAyxoYS64QBZ04jmK0XVVIWzXqT70euxEgoStJ1w3jllKZaxOxXBL40+a5eBZ70ThU3mu7xTyZ2K6JFF3knLzsW1bwJTmkWQTX3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEfMxcgC/ti3/sJlPW7cwrUQEJg6dcczKS5lKQcPPvQ=;
 b=UrS34PI/wxPLv8UONRzfOk7zAX2c6drgMQ3GOgiSd1jtKQRB2T9VCD2bqN8ZPZAEYPDgDDB+v9GDjDZNlSJ7cLynA1KvRFYTRIoaFNLl98TYJRmHwwVowGOMpmK+hFsbYgsU+YqxWBOr2JmGm2Hn8528kw8iv2G6ad9Rgp3W3SrCbr6APTMiy9pKM2ti4UR33jttByUz7FJB1OL7xGTqVICT21Xe1epaa1nZavejkkSHNYyFvd3wBR6YqiZiifrZtZTALVIIoyeQ2foqPeVIPtsmkmhbsh3/BOXCXXPR/Rj7d/Kh0IaN0pOqukSDmYkxar4xYErz5u4s7b23EfpiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEfMxcgC/ti3/sJlPW7cwrUQEJg6dcczKS5lKQcPPvQ=;
 b=EYINaFJSnl7une7yrvI9CuQy+f9COuMVNqwE0D16lqvSxZROFOwXqnoAbY7QcW4R1reoylW5qo3YCN5puBERYPrJfaMOjVqMYpCPjYdqGCrKUWo64U3Yv9XBCPjWmqc5YlucOpcdqO8bWO1USfRlLJrZg5q7apy2dKfPjPJkLIfsGHWYzReq+2oVfUYMS5vQW5ehdRZpvwXv8iLmO4nHY2IefXLAgotm/O1cDt9Q3LtcFo/lrLeNxnzST/mVRmJEsO6ulAQvblGshhGiPDnxspMkaRet9NJo0bxqh4aSabUWpfy4QppeTR5gZnZ4bsSg/mw7OWSMhqOIOFpMfqX8ng==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 03:34:13 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 03:34:13 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 2/7] vdpa/mlx5: Fix config_attr_mask assignment
Thread-Topic: [PATCH 2/7] vdpa/mlx5: Fix config_attr_mask assignment
Thread-Index: AQHX5u3e4toS3JQLvEWCexL1cQ+wGawejO+A
Date: Thu, 2 Dec 2021 03:34:13 +0000
Message-ID: <PH0PR12MB5481AF69027C01ADEB74273EDC699@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-3-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-3-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853ffbc1-3ea3-4740-5608-08d9b5449c74
x-ms-traffictypediagnostic: PH0PR12MB5482:
x-microsoft-antispam-prvs: <PH0PR12MB548260E332397ADEAA1F398CDC699@PH0PR12MB5482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMbLcGDV5AaX58Cvp7/ueM9YOjFFuoPWo0oCN6VE8WQZTnlnNbtCsVD7LgHmOtxzNLOopgmtDqghVm2Raz3YTaT+zps/nmKAyrYrby6nTTH4nxxVp2jVSZcoZ9JSgBgItXbkUYvmJ9IBXxN9spSyXCUGJQEIGAkNL1zBNREpQQE70oh55PMbHhmTwBcS1tQWuDXTvdgZAMs74wWetXAVojvwusoO3noioKKraQVKmOT+y0qjaI5aAMGZd7oSZWg3fw1hPs+rQZ1AJ+qLoQo1FtQMgVZDDZfc6pND7YlUqYEcdlP8j3MhhlROgfQr/sH7cbOvxvn2vEWx9g3KFpqI+U2/otM2v0si3EaVEHYutFyhVY7rSnkE3JbrwZclL5KmEYqOhtT2lSiPO/Pg3e38EP1UWS7eydxOT1G4EwogTpHkwjCrZbmiHSVygzKT6OBqjMwE3zne9THapA7TWLu/AqFa40TQMppMzA6ZvTd1jysrV6uMXuY4etz6KGh5kLxkbiyFGMHpvvW/HrfokxxLeFPiY/lh5OlyYr8/h7bikB67dppakKuN8+fAqmTnJpTwJzmTkeZ1JNVUICrWNossMJVVfp05Cv34un9+YbqNS+TrWzzVcraImaB0Z7WYLetQpAd7skgSB0b3UA5w7skneqgvBYZUmVRaGfcmf22g0OnQxVsXrH4c21n4Jr6aBEC82qrKO+x3RPCeGZXOHJfo2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(5660300002)(76116006)(8676002)(2906002)(54906003)(86362001)(55016003)(110136005)(52536014)(122000001)(38070700005)(508600001)(83380400001)(71200400001)(7696005)(66946007)(38100700002)(66446008)(186003)(64756008)(26005)(33656002)(66476007)(4326008)(66556008)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qDg81t/Py0mZz1zOBjIx11wHI9VQ/bKgokDKBnVqJLOKdD6G5sYBB9lCmuc0?=
 =?us-ascii?Q?hvrt8M++5pZ5Ip5yNEpIsEfqPbJllV4vH4LgHuexTJrrYVrlplQOca/Xxj0u?=
 =?us-ascii?Q?v6/VQJ65ypA3UG/sYlrBX2Y4uo84LreI4pE63kb3nbgANa3xCmV4Hdunghfw?=
 =?us-ascii?Q?LbmMBVApTkNV4R1q/1VW7MRAPF8N9aLoR7ZU+/qNsd/mLjKG5bWj3CRED5YH?=
 =?us-ascii?Q?famsRDqzhSQcTOW63qL/3YviDlKbQWn1J6hv9SLBFgDrnwxJPrYZGwH8NH5Z?=
 =?us-ascii?Q?hCC08EOUO600BQRppAycB1WMQXdIDUauGSkGRP+hR5SBjzCpUH4LaCei4eWY?=
 =?us-ascii?Q?ggXhQcUKGSSTM0w1Iompso7qosiUrpWGKamNXoHLvv+NC1eybgR0NsGqsRrY?=
 =?us-ascii?Q?SUkYpniln8W5vL/qp9AN9wZc7xyNxH5qBWhXADjY0GDfSMySTyIQaogdZzXZ?=
 =?us-ascii?Q?e97tL6cvf7SgZXktPLqEZPNW8EhPj1wcZfrPW48LFqV0jFYaMseOXB+pKJ05?=
 =?us-ascii?Q?SkOkt4101Rt0n7wvp/9NoJmSFXTYnntd8y8yX/pATuPO4W0T9okY6p5gGLBN?=
 =?us-ascii?Q?L9bMSbon8z48CuciXNCVZuLte/Ep5X0BZD7SWbx1QaYDhy2pQxXWvijdenzw?=
 =?us-ascii?Q?Tge7ik6XJ+XzCr01zl9fAjjSEfJSNIjRwYj5mOEG9BleCC3gSu1e/fNlNkW7?=
 =?us-ascii?Q?1DjcL20r6KWJVJgk9Y3iNcOhpuOZduYREVZSqhT97dt4oeYtnyiNLfYrxaiw?=
 =?us-ascii?Q?iLWVKRgwcOicGsSHt7UXBeiFMiOG/vInqHlR1+23ldhlUo1cpxNAunCwT5DB?=
 =?us-ascii?Q?NGN+DI1sUX6IrNK8QRvoIQWENs8B3LZmefSmK6rlPgpq0hOlDkZAoB7cn9tg?=
 =?us-ascii?Q?LDN20Yxcl8M+qxHKwXP6BTSSLqbCm+NS/kSzu/B+08cP5MTVybI/RuDVOufJ?=
 =?us-ascii?Q?nB75cez08t53Bh31cNpEX2ghQyc3UlQJ6H/ZKEgtq9lKak/6rthExPR1cim+?=
 =?us-ascii?Q?ARIhGwZqe+ZjTLQtHSk4MylzCd+Oq4rnGc2IQALLyvOy3XvtPbg7Z5YKfSEG?=
 =?us-ascii?Q?9SUo+ycT3rJermccAfxYJUA3CFZBf2MCJZcV87NjFwh1SM63hvLlK7Lkhwec?=
 =?us-ascii?Q?6oFYeEvcNBF3A3fn5k/ujsOj/2STn4s36yXlCrq29MqYQ8aqHsuXxDoE9d9G?=
 =?us-ascii?Q?eEtUlSigAKtP9j/cVhHVS8epCCgvlK+JyCiGAwdM3CXkvtzvxED63B4kmbhD?=
 =?us-ascii?Q?vQP3PT8rWib6yGVOaNBOyqv6U/IvjtExwk3kWkANeNznHTaW4KVsLzhIb8qF?=
 =?us-ascii?Q?hDP0JeSBYVzkwB5YmkJiVIimDz5eKEBWPhRFoOoDmNUVYGfHXwWt1PTntvFN?=
 =?us-ascii?Q?xn6l6giSH/q8Q/N9IR8zrsoVUaiNh+SOrxQA512yA8HO5qUf1d9M4G8XOE78?=
 =?us-ascii?Q?F7b5gkxFuKyyMovgvMqdlTJbCCrssuYbAJ730QaFyborqSP25UkbMtelBDWj?=
 =?us-ascii?Q?MyhBZObc4KAarxMwX2YvaKbzhv08biFPwMt6njnPBdI1WIMVzR2d16FOItBT?=
 =?us-ascii?Q?hNckctpJIRObKttd2eBbfZ0uEQ3kuS04zYuedpIOBq3J8kIwtyVk7M47mOsh?=
 =?us-ascii?Q?AE0r2H/pRH/Zyx3ILhZWnv0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853ffbc1-3ea3-4740-5608-08d9b5449c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 03:34:13.5704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aysYzPkdZg1ppbkH6PRNxh21x1E+TpPutA+KPG7kyHyjL4P/KL2tk7VvfG+gHREtK1o62j780kcAUnaQnGaRZg==
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
> Fix VDPA_ATTR_DEV_NET_CFG_MACADDR assignment to be explicit 64 bit
> assignment.
> 
> No issue was seen since the value is well below 64 bit max value.
> Nevertheless it needs to be fixed.
> 
> Fixes: a007d940040c ("vdpa/mlx5: Support configuration of MAC")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 63813fbb5f62..b66f41ccbac2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2676,7 +2676,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	mgtdev->mgtdev.ops = &mdev_ops;
>  	mgtdev->mgtdev.device = mdev->device;
>  	mgtdev->mgtdev.id_table = id_table;
> -	mgtdev->mgtdev.config_attr_mask = (1 <<
> VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +	mgtdev->mgtdev.config_attr_mask =
> +BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>  	mgtdev->madev = madev;
> 
>  	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> --
> 2.33.1
Reviewed-by: Parav Pandit <parav@nvidia.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
