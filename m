Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA2DC433F5
	for <virtualization@archiver.kernel.org>; Mon, 22 Nov 2021 10:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 742B680E28;
	Mon, 22 Nov 2021 10:15:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ct0bqXYviXQX; Mon, 22 Nov 2021 10:15:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C60680E12;
	Mon, 22 Nov 2021 10:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD4ECC002E;
	Mon, 22 Nov 2021 10:15:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAD9CC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4B70605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJnl8k_eEo3w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:15:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED9F4600CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTyQXYgqZ9h51n8d8kyfYSD8t181NVk8Vttnvbh00aWSiSxLMbzyuIuu2wqJ/KJScgqYLWPss7tlWI4JVb9fecw9LKOIZg6UEB0ApYrF3rVNhVnLyoE+VX8DrZJYECrRVYiUmpWv9GpbTSQPmKpoeJkokii+v10PhX5p6lZhWxNzDQI9mw5LN+wEOObzllrTmXaJTKneBptPeFOpOYeTt/aQewYp9sL2r45bMYfNdfGPgHfk+0PEyGhXDHEnIl0QMzJA0tJ9xG6eSV5Cv2yi1G7mDCbYmqOBmHvLpFg1bu8BwbZAONZ5pSPFZS4eCILhk41x5wlHOoBYdVE27WcHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHAfVZJ/lP3EtT8ZYKE+fHmhncCjaYDqFcRi1oF0Ip0=;
 b=ndUodsNAQXTVToesooLQ0JV9zk2riZV3CDFoGX4XZslcS3FVNBLc84C68MaGT3JUNDmJ/lSFRcOUWCigqsOZBD9SOFUVwUnUwBfHn+/i5rSlrSzJE7beTd3254mqnN251HLaAfNWCyj1AqNa6EoB7GqEspoNMiGWD5NynlVzq+sSfB+ZmzM9W+iWSETizULP6BToSR5yfLq02SLJ9ddOjL/Ucxmw431GiQtiOh+guTVBU4a2/W5/qw52PlWNvhlLzXNK3Bagj0Xvog+/QbBgy69dIY2f8A8HO831BulqmOAYMbo5/oynLQFnBqXWDmE8SUt44yEnDwEU/Uh+4ItzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHAfVZJ/lP3EtT8ZYKE+fHmhncCjaYDqFcRi1oF0Ip0=;
 b=eMNYjKwAsf27VsgnKsDOs0D8SXWW0cpgh8WbwStLko5pYuVXmcjDbb6zgVxP95eQvPL9W03w45i6+ej4V8h9vFJSxoU59HmNm1xtTYPnRjLlvjhirl7lQD/v8jamOYfm9HBOOogjqv7hQp/FVH6EhMzxgfzw1FXwK4WlRQwGZ8J+8SmopNwkFetpzHZ7TgTHJ0Y1z4Y61oyD8zZTRqtdrOsZb+ZQXniL7ZeVdQ51I7GVLg6Gq9oJaXzztcP1L4EXt0e5xgabOAMoItlsGuL1vnmuNnJknNXaxUEoWvQhMDcznzzk/02nDf6b/k8XcYc4fkwJ0LnK2bpdK6gsyF2dvA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 10:15:37 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Mon, 22 Nov 2021
 10:15:37 +0000
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Topic: [PATCH 1/2] vdpa: Add support for querying statistics
Thread-Index: AQHX3EFM7M5U7I8roEu6kosjxQg7cKwKJX8AgAAE5hCABK7YAIAAWxmAgAADHQCAABDpgIAABq2AgAALlDA=
Date: Mon, 22 Nov 2021 10:15:36 +0000
Message-ID: <PH0PR12MB548147E2266D0A8D7B1951F1DC9F9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
 <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
 <PH0PR12MB548187F4DE8C789908839F9DDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEssVx-quDa+c7wYAyB6a3j88EBAYTW+y8e_FcxW2mA1nQ@mail.gmail.com>
 <20211122075615.GB74340@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEs0mCKV4iF=O7Psxip38tL5iiu92Kzj_LqLgTqXV-M+NA@mail.gmail.com>
 <20211122090755.GA75489@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
In-Reply-To: <CACGkMEtMB78O7K5E+dV6M7_K3U1fOV_8Q7pArD05THVWszjZKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dc9d058-60b2-45aa-9bb8-08d9ada10733
x-ms-traffictypediagnostic: PH0PR12MB5436:
x-microsoft-antispam-prvs: <PH0PR12MB543670C2AF67B4DEDE6B146CDC9F9@PH0PR12MB5436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9EsJg5FnXEyda+4SvErZcFY08Z9xiMi+QwQfEGih76otctULHtJRXvGtNfvVK4Q6QIvnvU9wCL3kEpYlTVNf6UQvSNC20f0n5GI6QTXk2VX454encHWLVbjQnqKV6W8jo9zEphfJFZNVpr20up4vOESIWraJPfzISkVcP3gkKw5CBAsNM5RPPdS0EabU132ci62+Ji9veGQFbmF0A++5YMomOC0HcprQzIccdn7TrM9h+cXG4uDIxloowvt70+8uYtXtFJ8ZwsZipnhmQU6bvSnWOx61g7+dfHC99GS81LyEaWjDFeUsDWHZ+h6p2AyKm/KhuCIdb7nwMjRTqWlO+IVyx5uO5oduxFwdBGWQcVe9BtyD3LfN3Q3wK4asRXQDwA5BXknmlYSKnq8ntRkL6SM66IkKpfacgO7F67JJZVggWyxz2f8VHDxChpE7U6qNF4ehzYbIlbtvZJbHWQRMCpbrOHiy0oeTvirNPq0tOdQ3KeE3Cqg0mggnfj1PBeq/pNEIByi7skuRiLDrvsXjEgyNDuJGp5dp45oGdIV3BwXBlPO6BIt2hzZ+/FF0cpkhntPT3FtctOzOFeoYsHBA9g9FN+qAbiFXJBSwrWFqAJzh2VIYh5wE6mE/RM3Wy4FuoQkhouUwcGZZNPqym1n8QBADdNLoDIfTkL3UrSZBisHlwwLSxDNehACTXLTXYU2mHQWaQ9rz9zjFxmviDPS+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(6506007)(5660300002)(316002)(6636002)(8936002)(9686003)(2906002)(55016002)(52536014)(55236004)(54906003)(4744005)(4326008)(38070700005)(110136005)(86362001)(66476007)(64756008)(66446008)(186003)(508600001)(66946007)(66556008)(8676002)(76116006)(26005)(33656002)(71200400001)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0M5cDdsdm0va2hnNUNjVmFTSWxscmxBTWNFV3NLN2ZweDBKT1ZkK0Y3b3ZB?=
 =?utf-8?B?Q012dGJrVkZnYnRkYUJNYi9CSGRYQSt0WmExemJTZTloZ3MzNEpGZzZEeTg3?=
 =?utf-8?B?S2grRzg2cWU4Wm9BMTFHaXhDVXB5QjY4bzl1TWtsRUc5SEJqMlF6OVBKVGMx?=
 =?utf-8?B?NkNsRHFvbE40VjYydlBtRmk5UmRNdGoxbkN6c0VTVE81VEFZSy9hL0ZpQ0cx?=
 =?utf-8?B?S3IwL25DQmMxZzRMS082N2ZudWJTOU1DcFZ4YTRUQWVVRE5IWW5zWW5KQU9z?=
 =?utf-8?B?dS9LQS9ybmNuRFdQTVh6elVxdUZkbkd2bHB6a0pUc0ovWmliS3lONEpoYW03?=
 =?utf-8?B?UCttRy9KbE9rejZlVFdFOUN6U2ZjNCtkTlV3dW1rakJWWnA4MjVpTys5d25P?=
 =?utf-8?B?UDJhaE5MbGdZdU1vWEhNV2JOTGlBekRvQVBGNjVRcE1DdGhLTHpVZkNJT0U5?=
 =?utf-8?B?QURwZFpMZXVCRmZjS2I5UmhBajM1TjdQQ1pNeENxbjVINHVWczVMZUFpM2E0?=
 =?utf-8?B?S3VGUDdIQ2tJMjU1Q2l1cnNWTU44WWthU3V2WlA5ZHdFTkMyWldUb2JxclpN?=
 =?utf-8?B?Nk9wenhIeU1TZWJvWXJFRFFXNi9tZWFiK1JGZG9qNkplRmR4bTRuOW9vSXJq?=
 =?utf-8?B?bWlIbGRvQ1h4SG1rOXdLemNObVp6Tzc1NlJkQ2doczhFYU9sbW1nbmJKNklR?=
 =?utf-8?B?bEE3YkhmanRYZC9DLzZDa3pHaTVYTVo3ZnlzZ3d1bDI1U2RBY2ZtMUJ5UUJx?=
 =?utf-8?B?OUZ2SHR0NEZ4R2srVzdNVDZMdzBRQ3ltVXM4VXNIbGw3bmw0NlpIWGI0SkhH?=
 =?utf-8?B?Tnc3MllOZWorZWxJNEFzSkk4OVFNM2JaOUxjNENoTysxbEZWbXFkNzYyVzlJ?=
 =?utf-8?B?NUVqb2FJVElQZG9pWlI2TGJKTmtzSzZZVlhBL0ZEMndDTDBJQzNXams5VWV3?=
 =?utf-8?B?OGU3aUFrOTlMa1Q3SUNzaVRFTkhXVVNvcHFjVkFwMjcvUTBHWEQxa0g4TWZh?=
 =?utf-8?B?OGpkTGttNWNlYm84UGRPZ2syOUd0dXVGVmQ4UmVXMXFVTjBEZjJQR1d4alN4?=
 =?utf-8?B?VkxqWWs1Y0VrMEZPRzlSbUN3enpYWENzMllobS9kVVpEVHQ1OTBzOVZiZ1NB?=
 =?utf-8?B?R3d4OXZocExlRE9nSG5lV3lBQk5JUVJCOFp2WGw0WDRKVkhoQ2tTUzBleEYw?=
 =?utf-8?B?ZUhxWlZmdlQ5TGFYdkVqZkVhMnZRQUR6cjJEU1FERGNCR3dBMVRjeHZyZDFp?=
 =?utf-8?B?VzBXR1NSVStFZ0psMnY3MFJ3bkk4K2JLNmtHOXZncXAxRlJpSVJIcnZvWXE0?=
 =?utf-8?B?YnZlNkw0aW5MY2dVREVaeUJpc05QQytxc3ovQys0emN2MXd1c3d6dW9TMWZv?=
 =?utf-8?B?YVRFRHBGaHBLQzE0K2MvOXFTdE9MS2R2TERTdGRwL2ZwbnVpdE5CY0ZBaWlL?=
 =?utf-8?B?Ny9aVHRhM3R0eWc2Y2huamJCVmhObGFCaEpFTERsSzhha01pMlZPQ1Y0dlhu?=
 =?utf-8?B?NXZLemtlMlo2a2s5ckZ0M1VhZ0NWVlpEckxHRis2dDZVdHFvdDFmVjRIQlZk?=
 =?utf-8?B?K0xwWVRWMzUvdzVzRkhSTDZuZGNMVkJzL3hUK29mdzlxT21wYXRVNUI3Umt1?=
 =?utf-8?B?dlM3YzM4c1ZOYzRpY21XYzdPcmM1WEJQSElzQ0orRUpkN2h6cjgzRDFkeVB5?=
 =?utf-8?B?TU0wdXovNVkySnlDblphMVAwaDdRbEtVcUZsa0p2V0ZzU3BaTXdWQkt3VTVM?=
 =?utf-8?B?eWM5ZXJTYy90Wk9vL1ZKZUxXZXkxMmF6dEtnUTcwQVNiOTMzV3Y2djRISW9i?=
 =?utf-8?B?ZitsSnNQQ2tGaVREUlh0M05uczJxa2FRZGRjUUFoYzhVK241U2wyY1kxYkN4?=
 =?utf-8?B?Z0RiMlZ5YVZRUWI4OC9idHRrdG9KNDJRa1E5eWlFWEhzMzk5YkVsbGw4UUxv?=
 =?utf-8?B?OUxuMjcvUE85RExraUMwRUQxVlVzc2dsM1gwRlZiTUhUOGkyUzRJUjQ4ekNE?=
 =?utf-8?B?YjFCREl4OGcxelcvNEpHeFZ0VWdJVU52NFdVbmpzYktZcHljb2tZM2s4ZmFZ?=
 =?utf-8?B?ZUMyVjg2cXhNd1dmZTM3dzJWeXVYd21uWHJaR0lVR2ZXSFRmdjZ4d0xCYnpx?=
 =?utf-8?B?ci84UENiV3kvWUl1K24zMFlUOXFGRy8wdzMwZnNtckpzSzBMWE1lRzltNXlt?=
 =?utf-8?Q?nQNKugdKLaw84ZqpEhmUKWY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc9d058-60b2-45aa-9bb8-08d9ada10733
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2021 10:15:37.0155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Mmz0ZwVVNVKNw315Liq0wGCL/JF4thI57vMX7R1ds5eLzIf2GMDjnirxiJ4bpa8qqKDsb05xwPk1VmOs/U+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
Cc: Laurent Vivier <lvivier@redhat.com>, eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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



> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, November 22, 2021 3:02 PM
> 
> > If we go with vendor stats, how can we communicate the information to
> > userspace? Currenlty we use netlink attributes defined to pass this
> > information.
> 
> It can be done exactly as what have been done in the patch, we can document
> it as vendor stats.
> 
Yes, attribute to have VENDOR_ prefix in it.
> 
> Ok, I think I get you. So I wonder if it's more useful to use device specific
> counters. For networking, it could be packets send/received etc.

Yes, I equally discussed this previously with Eli as its more meaningful for end users.
We just return the device id of it along with queue number that helps to show tx and rx.
For ctrl q, it is just ctrl commands and ctrl completions.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
