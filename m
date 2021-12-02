Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5985CC433F5
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 03:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA12682894;
	Thu,  2 Dec 2021 03:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CUzYLSG9mcRT; Thu,  2 Dec 2021 03:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B04DD827F0;
	Thu,  2 Dec 2021 03:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E575C0012;
	Thu,  2 Dec 2021 03:50:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD42EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C565E4059B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOpEUQ1cxIzH
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:50:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2083.outbound.protection.outlook.com [40.107.100.83])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1E0E40574
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 03:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4UCjt9HohUSo3wWP+ieJ12lRzD2aPm4d3FVU+c/8/QNrErHCcj4W5ApPAanV8mTVx7MLX1SMrw2LpbqCockr89gNHhtisBgl+AkmddhQGfQcMhXUYHBAAg1YazBJMRSA2glSoInuaL+p+k1M+3g6KCLgEMdoM/ap+ENxstGW+XGg2o77e9TNS0n+tY+X+6ZZBHTHU+OF7tHHNtWiRZG5NcsJJw0RNPgIp5V+pYOWrARIkoz368AbVvlPoXwR7hzRSeaChpkmPg2+mqFQg9drqEVgYUZFPejCqN1VI3jmg/+0cDca7E1tMUPbhY+i4e/cZfk3US4HTyHYW3uhPUqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdsX+SxOe9SvX/eSf7fFmSzbMD6onxzDl+r8+foyrcA=;
 b=G8ojRi3O7ndnIh+JS4r0hhqQ3nHTMxqPY3UO2WrlHLnOKSwpU6AhQBiZMRsgoz9N0pLDHGj0qvKbiGUPSvAnLQn11sYeeEPDuRpXF2faJq+T91VWfGcrZL3o4bGWyu/NA4aU3RXhlfZNihyGEmKIfRvi9zHIS2yKGW/1fKQlmyzwzpX4eGeSJWlAOVVQ5nYhyOj9LnBUlw29NZtW/MROrf5+P9g8h8W/uLTdO1n2UoxtKVkA7GPs1IF5yriYTSlCfSaNpbVdRjl0ZcJuMQlIBuXUmV//8d9lxby/Mr2OTf7PdTiTfSdS5CwmQ5t55b/f0Ui2Yp6LxxaUn202ZUJgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdsX+SxOe9SvX/eSf7fFmSzbMD6onxzDl+r8+foyrcA=;
 b=K/F9HuKKV9H9oWVZ666b7jgouAjR3aWnnoGzM7j7ERaPFIV+ZCJZCD0p5GNCP3Lv1KwhSADCr4XDywY3eMb7vS0VbwABkSA3VY/QvxkExUMHtBQr3nvok1r8teMRx0dkRPqXQ845DZEv4EredEuv7BBQONKLHxrsagdu2gd8IovQrJlDCxxra5KIJPPm5iFmwC95OZXQv0vIm/hhEFLNm4bAMWAQZiz9Akrd2U2HX3iHZwmvBP1ua4Rpn/Gk6q8WGsS1wkTWNcAUjnvxqXfGs41MQPlMSaVuMj47w/5FVJpjGtkt5kaNUzXVcEdaW+lpslWjACKpEIsohMfafCJoUA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Thu, 2 Dec
 2021 03:50:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5ce0:ef86:a707:3c51%7]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 03:50:37 +0000
To: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH 1/7] vdpa: Allow to configure max data virtqueues
Thread-Topic: [PATCH 1/7] vdpa: Allow to configure max data virtqueues
Thread-Index: AQHX5u3YwwZGwe8VQ06DL5pVTy5xdqwekTnw
Date: Thu, 2 Dec 2021 03:50:37 +0000
Message-ID: <PH0PR12MB5481A9621EFE160866836E28DC699@PH0PR12MB5481.namprd12.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 51d67307-c309-443a-2425-08d9b546e6b4
x-ms-traffictypediagnostic: PH0PR12MB5420:
x-microsoft-antispam-prvs: <PH0PR12MB542011AC6B7458406E5D4BCADC699@PH0PR12MB5420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0QPOY15AtBMBD4PKSZrR7WftwhYWuYXe7T4iHrLuTFO1AJHuAzAkU2LYcPw6x++Z5iCzlSavmO+J6+Eu6H4VEcclFyo3dB0QjnUG45SaUfG+TuYEujopzVC9iWyhpc8VLnM2+W48+ZoTnpyb/ruEs/6M3oE08cUiz1iFMyRLepoAg8XgZdb965sMU2r9Kn0PgC8itWaiVNrs53DvHLtyH9byavYRAlGXIxK4EMbv5C7JzfajgG7qSFGrj/g9y+8gc/ti8iIjyGd+WZLoCKXLzWZXsQQcziVnvkv+RIYlX6zQ4r0Xkpk9EocelosTfMVdpv9qoo9JjwK1eUXkFeOTmwqikh9uoBvhkLGFxTvJRWgRbhidgUpdS7lJqfRy2Lenc7Lhx5DmwV5RY6t/1TgOJFl0UN5PKcYfljKfEe6lf56vUkikr6+pD9SBh7g+WqrnYy7SXr2pbNRed1YzTdONdMbXDKmVZiI20i7NkRfRhIRsvnYgKxF0d3cGrVrgZ1l+1nGX55+RFSf1Jb80V5uFQjH7M6iccGypNOUtgbEJOWCMEowKkkI25HTcjg2KTn20MSvkTLVe4xpGSEjgx3fWOrFILDb1T4WadKMKJuW7ITUBsIxX7bC+X9JN6EOwdAc0ohHRMhFBbaUmTc1+8BdpIdngGPMlg2B9Q1YV37aGfnRrYdu3LwFfJDCP31b1KwwBQaEVjHXFslL88UMWrq4Nw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(64756008)(8936002)(38100700002)(76116006)(33656002)(316002)(110136005)(4326008)(71200400001)(66446008)(66556008)(38070700005)(66476007)(5660300002)(8676002)(7696005)(186003)(26005)(558084003)(55016003)(2906002)(122000001)(54906003)(9686003)(508600001)(6506007)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YAwAN93eFfv5dW4/2+DXb8m75DQITvP/q9y+KFX0zle4XfsdE1xBoc/qkpRY?=
 =?us-ascii?Q?vWyJUraqsOH+d3VBMbKZnJDvoXIknTZ6ZjPAD/kaWRSpC/UfIHbpv/klfHvM?=
 =?us-ascii?Q?F2bobpqf1vwDyjH2lC1ZpZNbfpVaoajQKkQT0CAMbaTCVYnmwLZj3dEWaFtD?=
 =?us-ascii?Q?jDgvM+s7tPga52ssdZRb1ivzvia8TsiIkRQv/yvxF/XnrpiAC3fP3qLXFRec?=
 =?us-ascii?Q?O4UD9o7s52Yjk+XgtqMj3Lwz/zj45akD5oq1tUhe/V+6zkmcuZxRJ8qHQHyP?=
 =?us-ascii?Q?JPrapq0S7rwEKKxPGabQRkGlL7LVCSXCYIddxWQ9DDj0BDEKHH9MiGgUO8nb?=
 =?us-ascii?Q?vAzjm50q+p5fiCGY4BCD42a07umHOnowkzAfsN+XcXlagKyYvsV1f85EuG88?=
 =?us-ascii?Q?FhmT/1AXcw3dX30SW/MFaGblJvssbGy5BK152jUSv3C+HyK3W6CFzcBJRx8l?=
 =?us-ascii?Q?aFZuxVMc3t50uk+u8uFDGV3TunYzM4hMPW0rAK2wiCBQnynY03/r5wwKr2Pn?=
 =?us-ascii?Q?CRyd3ftKPVrK2wnX5LLbC5XBFgZtjZsXhjh5S1ePwZ6NE9wK6mLq38UVpiqU?=
 =?us-ascii?Q?YTFdf8DNZsBgpVUmAq4W137wMtSdZWIy2GMsyEnk0+CEuW80Pyg9WwThanHj?=
 =?us-ascii?Q?2mXT8gYk40cLEx2ey4pI2CfwpLAxQZLAhX6PEk9dHvXGJAypfKS9FR3Usuwp?=
 =?us-ascii?Q?dCYimWzoKusBsSn9UX7M3mIotVBIwOFqWokVye3GAx59hb3MnSvEENcPjx+5?=
 =?us-ascii?Q?0uSmPUeXW9q8P4SWSvL1sKAcyHqTgVRzd9WC/XAbbvtjBeEgR22ynszF4Voi?=
 =?us-ascii?Q?EAa2f7NotVjnxfXeGD4pND0WAEpPlYFFTHl4AKPwCOym1kjJPRIEtscVQnXp?=
 =?us-ascii?Q?QGfxbNh8alJ9j4pVFtEzssvE+ykiZjsArzcfo0KDFDEln28Og6ush8YfA6+1?=
 =?us-ascii?Q?Cn8HmP76jiqGp8ig8CGFM2yuohM4hAmhG7oQ78NBqzE4YC1Bh66UWHc9sxDA?=
 =?us-ascii?Q?jfE0JaWmwBGMt5K9cUz60/6qOum+I0Zha3tUJbKQPyja33neg3VVpdEvGjuT?=
 =?us-ascii?Q?q6NDoIiQlsdf0ED8h70p4HiGjHNsTck2yRMIwfjCqeLD6p4TJRQ2fP7CYDkv?=
 =?us-ascii?Q?NJrflwFyvYyPnYO0zcNHpJa3UShfwGAtYu6ElhhIcBYndmVnw+k8EYXMSsiO?=
 =?us-ascii?Q?YIriyP+H/BRM4on+s3uN58tbgTDmCiZ8s0XOkbHJFRtkn9/dJ+itoIW+UKks?=
 =?us-ascii?Q?4PR2OwSzIsVRoUxvSA+0d5ADKZnSecIk7L8Szi5gj7vQBOILMlTZib68HiTL?=
 =?us-ascii?Q?Az7GjwwcHw40qwJJ8YWiUupJk3GjvuMmCSyzR594qDHrdwjImk2W+DY5V9JZ?=
 =?us-ascii?Q?FBl135k7sGJ18YxqhtYkv6/OxMUS4Q9xBnPPTyjKZC1kS8sGgVh1jMtlyU5H?=
 =?us-ascii?Q?3DaWrOIk3fuwZ8a6Z1iZZOtvIenWSk4DOH9Cqp5iKkEpFl4SwXEo1YwcTsNZ?=
 =?us-ascii?Q?qzaLtrgUOKqRsZ/Yp9BAVNuj3LMPaEKtWZto/OTCTa9Ej5zg3dyXQuK8dQR5?=
 =?us-ascii?Q?6Da+Mq1iMo6va7jroJQpi50pouohg4n8GvseZxtc77V2jQu0EehTnfgNdlAK?=
 =?us-ascii?Q?UeMRHAJKFtlHe1FNF/tx01c=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d67307-c309-443a-2425-08d9b546e6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 03:50:37.1663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUxiqXJWqlH1AHF6lu5yhqjcT7ULqz7PLx/kDQtB01/DAkDPQwT6y/yi50rCXMkQbIG5g9nomdbkxJ4IoXQzaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
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
Cover letter and this patch is missing the example iproute2 example to do this.
Please add.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
