Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90354C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 08:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 386EE80DA5;
	Wed,  9 Mar 2022 08:58:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gv7HlT2h0CSl; Wed,  9 Mar 2022 08:58:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1A5480DAB;
	Wed,  9 Mar 2022 08:58:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84434C001D;
	Wed,  9 Mar 2022 08:58:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90CF3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67B8A4018B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:58:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cxYc0f1tXeG9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:58:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::613])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AC2B4002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 08:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCpB0rzW7Ji8hsrCS1kaOWCo37WV2KD1b6DyJKEoa0WBdyAVUF2lgLpFQCrWXPUq96MdYNIUybPABUqTOIR1z92ifjpF7YilTGo1WPMZkGFwDFbianZA7wOEny2HSGBWjScih+acZG2lqLqMoj+Elwfqwq+xfhlOQdudiujWSRZJICZRgnjXZRhc/AjFXUsbPPRwAf288c4oHKmf63OwSG0ID2bFG5Qk79YkRhfjpl4ZDiP12gg8aAQONHDG8oGO78oXhvOqoyLUNXnJrvenvnHEiQIDUrNGVr1bz54RxP7KoFaM5lhBeKrNP5E4SOFK/u2ZTKCD0vFsbvzChf+1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYx6leoiHYpeacJ9A3UTSjO73JDL7aw3dZaHngzcLJA=;
 b=Lb6VtZkpwYSSGGs36VzU5J+AVIX5ptsgViFX4GwVdprel0tCIjr+z1ny8Tiz1o23TnEwwai/ATy5UKx8LVg+2mCkxsCbBL5p4cI6uXbIFrcF4h/Nr+teJJ/u+weZcMdYhgDSEqZuyx9ZI7KZ953mTjooP0Qe6wwjb5Qie97d1QkxwdMlm1dkraP0dZGeI3ZPxL9NaNZk2QznJohlaE+lNO9bInJs8B8DqRurNtLy7sBmlzYJLAVpXG83weUFOEiYs5kGo0RRA7rU6mRneR+X6y4IDhcajocQvfZQHdkrK1jAWyQwjhwQFN4/olWjoQJ3HSown8sMhAO8HQ+t5Ec/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYx6leoiHYpeacJ9A3UTSjO73JDL7aw3dZaHngzcLJA=;
 b=DnCTWhaTqp46LnmO6iUIY2d7B0OPj+SWmmuYk+HME37giQWqIX0smpCkcpd87yJWE2xQcqXNjIb3DQADjHhfGcyt47CJLePFCMqtdEM2t6MMRTM1ZuZOdfdmpeRSQY1IrXbeqzJpD5TOmVhyTln5ELo0mTpCFaC9GwL/sqnOWHVLFApCyyOyVCxg6RoegXlYjxSkbTGCxN15+2zUREUf3OIFyjxZvjpsrh7wLa8zxgL2k5ovZiQrk6/U7zTzcCxh7WNOd1XIav4qih0SwpVrBOPUhM2NzICuZpxrtnq+0DNBPdKXBLvsiOUv/p6EyWwmJl6+pFCevwE9vFIFpCcssA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 08:58:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8527:54fa:c63d:16b]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8527:54fa:c63d:16b%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 08:58:47 +0000
To: Eli Cohen <elic@nvidia.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH v4 3/4] vdpa: Support for configuring max VQ pairs for a
 device
Thread-Topic: [PATCH v4 3/4] vdpa: Support for configuring max VQ pairs for a
 device
Thread-Index: AQHYLgKNJCWMMmTnQ0OQt9GY7nCXq6y2yyKg
Date: Wed, 9 Mar 2022 08:58:47 +0000
Message-ID: <PH0PR12MB548172B198631CFC8A99D82CDC0A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220302065444.138615-1-elic@nvidia.com>
 <20220302065444.138615-4-elic@nvidia.com>
In-Reply-To: <20220302065444.138615-4-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 982b0059-7257-4cde-de57-08da01ab05f2
x-ms-traffictypediagnostic: BL1PR12MB5271:EE_
x-microsoft-antispam-prvs: <BL1PR12MB52712FD05D264CCAA5D42A26DC0A9@BL1PR12MB5271.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9ScNlHn7p7nSlWlxrQTCk/xx879B3r2uyjJ7wJJzg1mfc2D9t28n4M4BEOvGRc3xICnCIsrXhu1HotZ3xdIaIrPNe3ZESYYE7B5n5g3tA6YSHoFoegtNapZK7cSVUhgvswsDq9xRUwGkStXR6d+5UjRBHY70JGYd5QxWnHVnu+uFPktzOuqyK6mj3S8xwLzhSgNCuOB9tN96DZS97ErNcASi4s4mwuHLCUZKk7IAbu6rW6Jvx/MWWMmTUfxCt0YOqW7ssTw4r1lYOTB5fsAiKaTOsDQvr9TU31yqELwarP+Veai0m7UCVSJGtOQfWHDgjLd/OmkgS+wSVxGzDNU/Dq1jkMZRz+RAgFmNy1zcigp3q6F/mB7SnzsAX4HpeGvkqPGzb7zzHopxs3UO32+JIXCl5KJmBpCRs3ZnurJG21YMbkS+TbXgXrnbofvrZMONyfYLcEtX3rSgxZoXNVQj0pg4C/fr/Ox+9ez7tmQSb/44x2jtJI0jqC7gIq3TTbzKDHhyU+igcabZ2FSkTtL/SjdT3z2Ltfam3oESqox6eXnLnoFSD14fbXFzZ9o9VGvh5kuMftWvBzBs82vJTrMTWxRzvrmlEbEz2pZduOeSrzguJtEUdJw3AHAtdXfUbyMEeQIqRMEcSKEnJ9dO+Q/WNrCb5Mq0kBzXqyGJUK8xtgyclYFOmXCz8sWmGwl+yTlNbIrN44/PdHIN/cmEHbOmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(122000001)(38100700002)(71200400001)(54906003)(4326008)(186003)(38070700005)(83380400001)(66446008)(8676002)(76116006)(66556008)(66946007)(66476007)(64756008)(26005)(6506007)(508600001)(7696005)(55016003)(52536014)(55236004)(316002)(9686003)(5660300002)(8936002)(86362001)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PwO7C4bTG/a0f3Jksg4lAlDPbd4Drunib5D3Kp1OLkjBfu5hlMq4SqiFGfOD?=
 =?us-ascii?Q?/27dkKN1aad2KOR3iQ4mudFCQ7th9LJmzyVHGoCPVqgK5g89+qfucTQZplCq?=
 =?us-ascii?Q?xxOAEqgg8roCicTf60X26+bkMjFuButqteknM5lc1nCtU9Q2Wuh6hoXJuG/S?=
 =?us-ascii?Q?5Kc7tH3sM6NGTQ4gTE8gDjANQ1j9bP1eyPugD5IxUFzBgLVFXV+Sx6T8jdIh?=
 =?us-ascii?Q?993vtpb1imu9OWWWzoq21C+TjfP4K6MFVA9ab1lgydWL6CnEMO4mBImxW3yc?=
 =?us-ascii?Q?haOpTSLB3nroQq61i57SWRoGNFnqZjBPo4RdWhNnDxwWxCouOWayq3CxJogT?=
 =?us-ascii?Q?EJe3xXGum/sxtRsSVW30F3sqv7f4xxUtIPIla3Eu8Aco23AhCqvq86hCn5DR?=
 =?us-ascii?Q?1GcKDfK4vpnNhpaYSUvLVIr1NPid2zzFCzWpuDXCA+WHs/T/XwSsVX4mtgFE?=
 =?us-ascii?Q?e/vqk8J7Y9t+CS+xiFjGlFiVQ2D5HODEsW957FxREWaXASWlLx2hW4hixx/b?=
 =?us-ascii?Q?fG2y8wZL2xX/HkDXWC5zCVkvwRCT8C/u8uuBlGwRxskTCmp2dgT7XjLqbpxV?=
 =?us-ascii?Q?lSdo4I2mFdIp+YkalRNj6tvAqjoEZFF9R4S/ZjujCTavXSBZcEHvqf1mHXDq?=
 =?us-ascii?Q?l5y23VSU8EaeuZQ2yN2tuMGFN4OvKDMiLgO+wB812CzId/ZJUC2SMi+kbuo3?=
 =?us-ascii?Q?7L4GoJOyn2Sss+XAOcpB2jvAlrwHTvOKkXHZ4hbFCBNoBKH2bg4NLdVMI4e2?=
 =?us-ascii?Q?DUDLqNYFDb0YmwZ9o5KP+MLUIAsy1ItYtBIsCIHFgkSkVvxmiMiw3QCA23zq?=
 =?us-ascii?Q?mD4pYU8jvFnWjSOpZoV+HU2EqCQa3j+zPdCmehtASyezLogmK0H+PhgbP9Mw?=
 =?us-ascii?Q?+igew1926IHO+Z4BS24psfezgW6bvW/s9G1MY/vff5PSZVU2OJiW85IrREmw?=
 =?us-ascii?Q?MTgRCuBGcdw4pEm2YQY5EopL4h5kvYuQ1+crCRmOPeJl5Nsio5a2jgmASZ96?=
 =?us-ascii?Q?GhCw4WR0PN5AzWHH1deh4ook4lo0ZvVez6BIc6ct39HyQcxConKsztqDgW25?=
 =?us-ascii?Q?U8PzIhxO7TZhqSUdAH3VtIg9MN/CalvdSRUdLx1ebgUwqBDNyk9jK9JV9/P7?=
 =?us-ascii?Q?dOXenJz4Ax+eVeXDZ4f86xcgCZw2DsIYO6Nup9Xl7PcLggYOSDEeS7WbrJp+?=
 =?us-ascii?Q?Uc6/IZWyoqjm00MFX6y2FHFwZzt+9GIjUQ1yEC8EBlJ9RRcdFx52O5c7O8d6?=
 =?us-ascii?Q?Vw9d9mr1Mpqx8B9FVBv/jNukedA0rBbhzVqnIkDssK1OSNAehR3Ny1Q3uieq?=
 =?us-ascii?Q?6HRwr4DwIWHfgmYv4lYu8NXdNLyhonjWiveofubgGv3BYPklGhuKuczDxydS?=
 =?us-ascii?Q?4HPbIJZOm1iIEk7JUshgYkXiN2PKZtfk7isj1YZnFYDFm3KouRxy5j8Y1ZPj?=
 =?us-ascii?Q?aYnc0h5pYTwwP6muGuoK5FmjrRMKKsfYhwXU3W9k7EFdcc9V23hh2cUr2B99?=
 =?us-ascii?Q?lfwvc8T+BFcujtJEI9CmwoucsNDIDdNqBiBsFHuxaOBzjSkzV8pFiOpp8jen?=
 =?us-ascii?Q?ixfUmozoqApVV+sWaD6LiO6jLfVmSJzuFGs5XXRJeNS04UCrxbc65KHNQWcG?=
 =?us-ascii?Q?I77HopkX9CIRO0zYEEmftQk=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982b0059-7257-4cde-de57-08da01ab05f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 08:58:47.6247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CwFfS+zvFBN1HZSQUHlHvuo+A/QRF3VtBKDN+qOMTjEP7msKwvaxloWx/aFQj0mmPUGc/5oz3LvmZOYZdTGNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Cc: "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
 "lulu@redhat.com" <lulu@redhat.com>, "mst@redhat.com" <mst@redhat.com>
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
> Sent: Wednesday, March 2, 2022 12:25 PM
> --- a/vdpa/include/uapi/linux/vdpa.h
> +++ b/vdpa/include/uapi/linux/vdpa.h
> @@ -41,6 +41,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> 
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
> +	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
> 
Its u32 here, but in the code below at places, it is mix of u16 and u32.
Please make it consistent to be u32 or u16 to match to kernel at all places.
 
>  	/* new attributes must be added above here */
>  	VDPA_ATTR_MAX,
> diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
> index 5f1aa91a4b96..22064c755baa 100644
> --- a/vdpa/vdpa.c
> +++ b/vdpa/vdpa.c
> @@ -25,6 +25,7 @@
>  #define VDPA_OPT_VDEV_HANDLE		BIT(3)
>  #define VDPA_OPT_VDEV_MAC		BIT(4)
>  #define VDPA_OPT_VDEV_MTU		BIT(5)
> +#define VDPA_OPT_MAX_VQP		BIT(6)
> 
>  struct vdpa_opts {
>  	uint64_t present; /* flags of present items */ @@ -34,6 +35,7 @@
> struct vdpa_opts {
>  	unsigned int device_id;
>  	char mac[ETH_ALEN];
>  	uint16_t mtu;
> +	uint16_t max_vqp;
>  };
> 
u16 here.

>  struct vdpa {
> @@ -81,6 +83,7 @@ static const enum mnl_attr_data_type
> vdpa_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_DEV_MAX_VQS] = MNL_TYPE_U32,
>  	[VDPA_ATTR_DEV_MAX_VQ_SIZE] = MNL_TYPE_U16,
>  	[VDPA_ATTR_DEV_NEGOTIATED_FEATURES] = MNL_TYPE_U64,
> +	[VDPA_ATTR_DEV_MGMTDEV_MAX_VQS] = MNL_TYPE_U32,
>  };
u32 here, but code is doing u16.

> 
>  static int attr_cb(const struct nlattr *attr, void *data) @@ -222,6 +225,8 @@
> static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
>  			     sizeof(opts->mac), opts->mac);
>  	if (opts->present & VDPA_OPT_VDEV_MTU)
>  		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts-
> >mtu);
> +	if (opts->present & VDPA_OPT_MAX_VQP)
> +		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> opts->max_vqp);
>  }
> 
u16 here.

>  static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv, @@ -
> 290,6 +295,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char
> **argv,
> 
>  			NEXT_ARG_FWD();
>  			o_found |= VDPA_OPT_VDEV_MTU;
> +		} else if ((matches(*argv, "max_vqp")  == 0) && (o_optional &
> VDPA_OPT_MAX_VQP)) {
> +			NEXT_ARG_FWD();
> +			err = vdpa_argv_u16(vdpa, argc, argv, &opts-
> >max_vqp);
> +			if (err)
> +				return err;
> +
> +			NEXT_ARG_FWD();
> +			o_found |= VDPA_OPT_MAX_VQP;
>  		} else {
>  			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
>  			return -EINVAL;
> @@ -501,6 +514,15 @@ static void pr_out_mgmtdev_show(struct vdpa *vdpa,
> const struct nlmsghdr *nlh,
>  		pr_out_array_end(vdpa);
>  	}
> 
> +	if (tb[VDPA_ATTR_DEV_MGMTDEV_MAX_VQS]) {
> +		uint16_t num_vqs;
> +
> +		if (!vdpa->json_output)
> +			printf("\n");
> +		num_vqs =
> mnl_attr_get_u16(tb[VDPA_ATTR_DEV_MGMTDEV_MAX_VQS]);
> +		print_uint(PRINT_ANY, "max_supported_vqs", "
> max_supported_vqs %d", num_vqs);
> +	}
> +
>  	pr_out_handle_end(vdpa);
>  }
> 
> @@ -560,7 +582,7 @@ static int cmd_mgmtdev(struct vdpa *vdpa, int argc,
> char **argv)  static void cmd_dev_help(void)  {
>  	fprintf(stderr, "Usage: vdpa dev show [ DEV ]\n");
> -	fprintf(stderr, "       vdpa dev add name NAME mgmtdev
> MANAGEMENTDEV [ mac MACADDR ] [ mtu MTU ]\n");
> +	fprintf(stderr, "       vdpa dev add name NAME mgmtdev
> MANAGEMENTDEV [ mac MACADDR ] [ mtu MTU ] [max_vqp
> MAX_VQ_PAIRS]\n");
>  	fprintf(stderr, "       vdpa dev del DEV\n");
>  	fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");  }
> @@ -650,7 +672,8 @@ static int cmd_dev_add(struct vdpa *vdpa, int argc,
> char **argv)
>  					  NLM_F_REQUEST | NLM_F_ACK);
>  	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
>  				  VDPA_OPT_VDEV_MGMTDEV_HANDLE |
> VDPA_OPT_VDEV_NAME,
> -				  VDPA_OPT_VDEV_MAC |
> VDPA_OPT_VDEV_MTU);
> +				  VDPA_OPT_VDEV_MAC |
> VDPA_OPT_VDEV_MTU |
> +				  VDPA_OPT_MAX_VQP);
>  	if (err)
>  		return err;
> 
> --
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
