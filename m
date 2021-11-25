Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE25C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 05:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE09540018;
	Thu, 25 Nov 2021 05:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RB-zWiYqZRrt; Thu, 25 Nov 2021 05:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 237954019B;
	Thu, 25 Nov 2021 05:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3ABBC002F;
	Thu, 25 Nov 2021 05:50:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9A5C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6039823E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsiuPyVl7hPY
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:50:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::602])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFD91823E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 05:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWhJJlr0o/LE6bAA72weK2WPAi/m7v5+/JxkKJ3ODnn7SIfrMy1Qu3W7rdK2DywZVICzBsB4IYJ/YMpJcvSqvGO1JXqVzy8WPJJVI8+OkgkxPdbh3qofueJV/PcqTEMq7ckn9YXg6CGP2TO50l9Awe0lV7t3/NIJEWfG+ML4MnkqmnjlKJIdzRcPqsSK7uPbB04lrinMrtsder2MjNbyGa1dd4HYWiD1guLMdYKpUPPRSVtMZAkHj/jk68frnwS8kzwfNwJyYEABGpBpO8iXBJTcchaiRb6fB5T4D/trTM+hVl7wghIpGbbiYnCiwtAAvXJzkmhjpZNlmkpsZgrjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzt98MU5bbvXKskQO5jNpJ5+o/POmwP/lBfBuz0MgWg=;
 b=UQM5ZXe0msGRj/HPu7RDiK2S8rc68k9f7KOZJXrXmlOBepJM6/FfXIA6/XAo/irVffcfqmHcm+2L54Myoiv8tmQdQGkuvGkHHC2Qx5CLiaqdP8X/XJlwy9V140xFvQdk/T33dF4ST+0xp6N+JNqZWi8AS6XwpKOIr4Ql/+AyQqxnmB+PWFLxpoO9Bxdqx+jMTJIqmNXPSkaGIV6OjcaE0fPGqdPXOCT/dFmIjmgJe4VSd/qLX24Xpqet6nXcivqWFRg31Fdg0nfODIzAYuSJiQEJCyoDP2mqb8mUewVz8BQcsC5mxBA31jIKMfRVDsWDN3qHcF1uexUmmCaoooyUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzt98MU5bbvXKskQO5jNpJ5+o/POmwP/lBfBuz0MgWg=;
 b=Mh0KUTxKMLNLTs57+ghC1uvqevmvZv0dsEPzNRp5Tdn47mJFa06hUTLY3D6KROJp7vTHeN1ELRw+diss6664I5jMr7Z2sat8Ps9WJ4DyYHs6EbUuTGZEJG4SJULHdeX7MCECCaNPfwg0xrs6/zFNsu3sG//YnJ6HVxukOXMHNrx+6roGEXxUe/l4h0rzqySBNkiqPWBZBXBf0RWD19g09sTwVYA+ufJoy5wnukAbSWGO9C9fEitvphjSxXUqNhir+w3hrQyHNpdQaErSUcmUY50GwE7gxFhxP5pfkvSDnglNMOVO2NTt7su74QaeDe/bROhudgdcaWdC0E2bacardg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5466.namprd12.prod.outlook.com (2603:10b6:510:d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Thu, 25 Nov
 2021 05:50:34 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 05:50:34 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATH v1 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
Thread-Topic: [PATH v1 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
Thread-Index: AQHX4VQzWfkMX3suM0qCBN0lmmSw4awTulGQ
Date: Thu, 25 Nov 2021 05:50:34 +0000
Message-ID: <PH0PR12MB5481AE5B7549BD57A9263B52DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-3-elic@nvidia.com>
In-Reply-To: <20211124165531.42624-3-elic@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b22321a-8972-4f39-02f2-08d9afd77fa6
x-ms-traffictypediagnostic: PH0PR12MB5466:
x-microsoft-antispam-prvs: <PH0PR12MB5466FF06C3B316E176DC95ABDC629@PH0PR12MB5466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2Ga0xNMCPVMEApCbNSQ4DtHn8OG9WglRZKrqE5S17M8wp10+qvzi5muAfb/nhNRDGhIxnIzOIk9WCcB7D4g5ncldCv2Q2E+AmCVdi9oZBXCnbHuSxOk7Ybkt/T2o659N7lnMbeQNnnIv0Dk0BnO4H3V15gTMi/ckIw7Rjyn81lmtxfoCOGsY4Z3+/TKbzvoJMLr6edBm1q1RgGWKx2QhCz2BGjR/V80D8EtyAYh2CvLYGpMIfXRBPNdQYKuVW07RpVxwbTH5IQIB4tqSXemCXVCOvCVCD/hnP0PuvgBAA312Vx8PixkHEOobeUI/fx6ENyPnMQHl2Gz04Txw8ArwSPNLXXnqsMfmFuFi71fudsHVDvIO4bVAuNybe5eQgMD3/oJ/2yZYkpYSbR2rhFG7lPMnI0VQzbt3Dk0U1efURNYTlc+FxTQHwDxD8sj0f8tIKBZx5rnNPAsHF0U9wh+LBaDo+fnFQJi3NkIOTNwc9gjQHJeU6AtnZ8cFAH2QVcezLTfKZ6C7BJik7foAVysIK98pyJKYelVx4xbOPcPeFaZoD/VMqRpAKUyTSwiCy+NPbfI0NEo2Z96gHWrhUxXTfBJPZtu/TiDNzrrTB5gjZvZ2umvzpRAVyZFV7MrqH6AEwsh418PAHU2nM1T6JGFojzaCCEqV0O7LCq8eTOFrtihTdhOdsFm2447wBGZ1+c0sRoBnUec3l9YU9t4dusJzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(110136005)(26005)(33656002)(55016003)(38070700005)(9686003)(186003)(86362001)(52536014)(83380400001)(5660300002)(122000001)(71200400001)(508600001)(7696005)(4326008)(2906002)(6506007)(54906003)(8936002)(76116006)(66556008)(66476007)(66946007)(8676002)(38100700002)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X8q+tCPf5/H0WRwtqgBRLjdcOLIYPOUBmjFBhV44YdOZh9jnKhDcEmpX5Uvb?=
 =?us-ascii?Q?+/3SjEVn/GvJaFZBsiXFxsvb6s4UV4/D5M/EBsjLb2VhxAmTOXlw0RG+njvm?=
 =?us-ascii?Q?RdbshHv8LYfFiRmQXMtgCX242FNOaq7t3x9lGG7VdSSCa1pMA/KAe6ODQP7w?=
 =?us-ascii?Q?SRvD+CHFHPpvdRO3KYJEVp6Mw4873QYDBfU5c7N758suBZ0NXkn01W7L61Ix?=
 =?us-ascii?Q?CiQfzaMB2QBvcjAKUuxKsbws4DHo+Puw/tcJhHbeRvKUAR/7eAVD7xdL/GhP?=
 =?us-ascii?Q?sfF9GJGL4C5wWSYCiTqoI3QWULhCbs+J1Ok3hJje2eV4nLSLqKyHlWYTOTMl?=
 =?us-ascii?Q?vlVisyMP0P6Xq7xrRlsO0vrsU7RsoA3wEJOHb+NRscpk1wrrywLFApcQYEfA?=
 =?us-ascii?Q?m7bxM2u0gOE1Gk359UBSATBwU633CAdCCkUG+n5PpmbSKaz9SIU2ywa4uteD?=
 =?us-ascii?Q?Fx1jHAMPrrKDDylLyAD3GdIBvCz7J3QIRWf7CMnvORuojtHTiGczltM3+UKz?=
 =?us-ascii?Q?VyByBGkMBsdmRYhsVSdqBE/4FeA6G0iFc2qxk8I7j/vVVSfw16CjLFWzMZ3A?=
 =?us-ascii?Q?pj0HQ26s2Z6inmWu5texGe5xii9neHh6ddWPHgjeuAjmybVTXlagdh9ws/1y?=
 =?us-ascii?Q?aiAhSkDKovq0Dr4E3fXJhJiZJUDSIijTF5maW6khXA+1kMZPMOn2BjO3Tphe?=
 =?us-ascii?Q?v2xhe/3MOuds43QdeeBFzSUTkfzJhL6dP1yd6MO+XzWtPnhgfKZ8Yw0iWtc9?=
 =?us-ascii?Q?M0hh/P8WU0Db/kfEkGXoMYGR6ML4cICHQVi6Zap7fq9vPB6GRfpnx6ZR1J7G?=
 =?us-ascii?Q?1cZA/Usth2Wrgr2KdslGJ+pyDqUiAs2XtzP1gZXBjwPFjsT48SAANvx3KHfJ?=
 =?us-ascii?Q?9l0ohztUh/YVhuPi/1FKlfuFwa075BH23D8bfuuWdlmiTRzYLauwA1xMgvBq?=
 =?us-ascii?Q?xgg4KUOkD9Z5SinvPHnDjSTvzn8VHr8F0HjhwPAGs2Kx4yQCf58erVtqpaAY?=
 =?us-ascii?Q?yj+m5MjlL3Hf93QhN41zper9Hrv9hyMpq3a8jB9KmWStjhp2oUEttPVX76M6?=
 =?us-ascii?Q?tkba/uNYdF7WXfm+BAg5xtoHzOMuSLsqctII5p9VeV9CmRfyeO2PCmx4vOh/?=
 =?us-ascii?Q?wHGshh7Y4BnhLZ5iObbreiElo6oGx/Jj9ZVfpJf4G3ZHWoGIolSCJVkVSFGW?=
 =?us-ascii?Q?+zUQrzf5SLIlb8o7IEdsG8mEksdEoNVolkojx80DQzHfwarChO4orgnsxHi1?=
 =?us-ascii?Q?d59z3VBnIk1NHKeZjyJyb26hQtIWBLa6oNQtk7QYFvXPpl2pZP+lFA46h2/V?=
 =?us-ascii?Q?H6l7ld+wmFwXuZuGlJVX4rmiI8JG0q+3P098Waz0StQiLm7QYuWaEoWF6BcF?=
 =?us-ascii?Q?VNtD25BwS8HNDD1msI3mc+9pMC9jdZKTemvRYiDbcvCZzHPwihZnWrG1Pnw6?=
 =?us-ascii?Q?S2GmZl6vnxU0jyOaM+kURo29yvQFckGBaCA1rJawFERxNjTgE9kBcSqADdV8?=
 =?us-ascii?Q?BBXo1tUrRvU0T2ETK0uCit4M8aGVGihQ/Z9VDQx4Nkcq23qiIxFZ9dq2hkNk?=
 =?us-ascii?Q?1lGpYwAI6BGoKkN21eWTinWpZxEPHfz3Rph6i2wH3V4zoharJIx/7acK9MA+?=
 =?us-ascii?Q?fQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b22321a-8972-4f39-02f2-08d9afd77fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 05:50:34.2388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55kXTfXhgUG77lQ/oldN5u/CO1jDvkbq/8NPXPfyHnFA56AmPN/Dbf2zas41pnAGjUgGKEwQad5jwIXFCbKwiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5466
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
> Sent: Wednesday, November 24, 2021 10:26 PM
> Implement the get_vq_stats calback of vdpa_config_ops to return the statistics
> for a virtqueue.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 -> V1:
> Use mutex to sync stats query with change of number of queues
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 143 +++++++++++++++++++++++++++++
>  include/linux/mlx5/mlx5_ifc.h      |   1 +
>  include/linux/mlx5/mlx5_ifc_vdpa.h |  39 ++++++++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9b7d8c721354..465e832f2ad1 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -119,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>  	struct mlx5_vdpa_umem umem2;
>  	struct mlx5_vdpa_umem umem3;
> 
> +	u32 counter_set_id;
>  	bool initialized;
>  	int index;
>  	u32 virtq_id;
> @@ -164,6 +165,8 @@ struct mlx5_vdpa_net {
>  	u32 cur_num_vqs;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
> +	/* sync access to virtqueues statistics */
> +	struct mutex numq_lock;
It is better to use rw_semaphore, than mutex. 
So get_stats do down/up_read() and change_num_qps() do down/up_write().
This helps to better annotate stats getter is only a reader and handle_ctrl_mq() is updater.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
