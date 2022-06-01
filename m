Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C349C433EF
	for <virtualization@archiver.kernel.org>; Wed,  1 Jun 2022 18:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FF7982F19;
	Wed,  1 Jun 2022 18:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Il0kdueCaFJD; Wed,  1 Jun 2022 18:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5312A82EB5;
	Wed,  1 Jun 2022 18:58:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3156EC0032;
	Wed,  1 Jun 2022 18:58:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 18:58:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14ECC4168E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 18:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4UQoart3OE1Y
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 18:58:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58EA641686
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 18:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKOJoPC5XHOME4J8+S+w8DzoDchE8ZCsM4U50xd7JFYlgLpp2H2/YjHoNNY4vxK9/crvgtZ0gsZX5594GXCLqJ/M8V80PFBH5JV1rp/inLVGTJvTQe5a2D9CrnNJJAomZ1hsyl6WENPv5p1T+F9pG/uQjJtj9YXkcxWTXMT4c1sic+kD0Ii6Q0ee79MVzsP0qrUsrXe1GgkbK8yFKHZIoIPZCAPUmMmAHj++9cpapoHkitk9panPbghUi2jtMwY5gXPzG+qoDMoGd0hVWV5EL0HnzyvfGp0M8s+x6KyzvYeKoIGKCwofsxNzAAQFiOkl9NTM3Mg4oCcd7sRLeStuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn60ivQJmJV+bG6M13r5JDBfKGyc96V3puCHuVeolJw=;
 b=nuRgLLW8Te6G+Ve202W3CFvTQFcqLuOwegj99I4nBJ/KNtxVI1RmOONib1lI15nmKDQ4CfAhDvAPasjKSIQEnPjschICyYH2oZV/6Rf20ti5LP1Zih9FzKadKVAfJ6Y9bOLJpo4LxyQQjyvsH9JuAfDxkHff2B2upZr06Xk/XJ4Ac5I+2bd7pS0oZrT/GAISPbFUHs4QJzMK+3xsDJyFdq8IhmVta50ygIG+lgSTEKtsomSE92DjYUwPGIpw4vUrFrS9uECbbxAe4Ua3EnBpayZJnLe7POo5RYRXEI5G0IVJ0rC8c5bjO3VRudsEBAxPoUExoJzoMXL/GFqGWSiBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn60ivQJmJV+bG6M13r5JDBfKGyc96V3puCHuVeolJw=;
 b=oD1Fxv94RMEAeBcImSlGOcmmZgRlqKd8sKJpoTQowxX0wn/GG+cYqhTzNwALTowFaS08eKLPgC1kdYYGjsyqgHZaU5fTd1yCPFc4nJ6sWZuCXYDVdQOYuUb6QE6njHhXe/NSPdq/413bp7bOPsQObnwwtpz05x2Fmr5NTgDyBJz65TGkQIqlWyuLk21771YOOd0O3dQAutEC5q+fnX+bqOghhs4a2bZQE56bGPzecoviT3y1AOLARxgmfRhv7DPgitkykqcwZ7HK1aM7lAT2ojhDiO35NCUknVlnqYzOHnqabkRxBTrkciWgGRxqdjcUv5qrMH/GBHkgHaakIxmw3w==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 18:58:50 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::489d:7d33:3194:b854%3]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 18:58:50 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Topic: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Index: AQHYcP5BrBz66eonZEeOxjwIzt98aa0xHKkwgAFx+gCABD0SgIACqRJggABroACAAQ+R4A==
Date: Wed, 1 Jun 2022 18:58:50 +0000
Message-ID: <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
In-Reply-To: <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a25959-63de-4510-5b56-08da4400c3d8
x-ms-traffictypediagnostic: BL1PR12MB5320:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5320CBC9DCF23529BAC7464DDCDF9@BL1PR12MB5320.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCn49QPxbJdYjTfpHLo7/hc4GbiHsZlpD2bHK21G2nh352KrTUKnlLqq6P6aEXoG/3hrT5+GYSUcurFmFvjNHEFZSD11qlPRfwi1J2FjNWcE0ZYN94hCu+sLpFx3BFMFrb52DOu1cLsXSS/UW8LgzxsIijPCjbTAGUlwEXInnf54TUWJtkI8YnftCPxv+P0ObkgcBIXzqZIdIXiIJHmUp9+oHWfHzRBMN2eEV75DorSDQD7hGFwkDTWdOoFk5ITzdp6Hmx+GHkEbZdBEfju66Mq8W2cXJnsS1VDg/wilPrZQFHjrxVMciR3hdJnfSz3BhloC7UbaD84T1ho1Ls3B3f2RBu/NXnlBu3X6hvcZwTxmG7rg7hTyhmSI31vpsKLTzqQHxukym8N2lzG5tzw30sc47H7fz+r8lZWZkJaEqY6pDYtD5N7ltQIdyW7G6sajGRul1QEuzdXVLBEbiBuhL0UlCpSLgZtyQ/iI1g1GFB1PnZiXWPxe4i8Ki8G9E+mOcg6Qq3Wl1Ob4SuMcfY114cCr38E4s1QpZnAKw52LMZBSmg30kKhn58LqioMXVYMlyFNC2rBg0SeHwIMeU4nxECvY76anNePXLu2m7xAZH2fCzjQli+8lf9fo3paQKmJ6B+jhZJy0gzhVQBycJvfjV1NQeVX454HqCjRjBV0UosHv4AEu/3pltnZDN4CGJhSmpakxigEFs3NWWeJUdjbwRYufdxyJpocnWoRSwJdWvcvqPnWxibMkcJnIrMqKNRxU+YEEiJt4pIvoVrKhEODoR6N0KkJ1hpsoNe57jKIsrxs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(86362001)(6506007)(38070700005)(52536014)(2906002)(54906003)(316002)(8676002)(4326008)(38100700002)(66556008)(66476007)(76116006)(66446008)(6916009)(66946007)(64756008)(7416002)(55016003)(71200400001)(4744005)(186003)(83380400001)(9686003)(966005)(122000001)(5660300002)(508600001)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFPYWpDeU9ERkk0ZlBFTjRsMnJGVG0vNTI0MWNaMnNCWkVHOHpSWUkyWWJz?=
 =?utf-8?B?ek5QM2hBRW8rOXN1QlhSY0FpOG1RS3Z2ZWtGVkFZbENhYnNvMDBqZmNJTnkr?=
 =?utf-8?B?VmdnV0o3K2UrNEdjYWdHZDJEVGpiY1VocEFnYWZON1pLaGYzM3pzYm1HTDJn?=
 =?utf-8?B?S0NNa3lnVWE5ellHNWNZSFo4VDhrSVZKK3FJN0FlbG1xaTNWZHpXbDRQR0dB?=
 =?utf-8?B?a3hOM1hYaUNuZUJ6Y0trN2NRclRnUGQzbDc5azhReDA0ckhHMVErNithU3Ra?=
 =?utf-8?B?VGFpblJFYXhYK2pLNkE2VTh3cTFGbGxqSE10ekpxOFJXM3ZycXVsS1BUR1N6?=
 =?utf-8?B?dWZCWGZrbi9neTRYcEtTUEMxRUtxQlZOaFc4Vlpaa0RQdkZ6Z0QzOERNOVpk?=
 =?utf-8?B?bDJuL2M1Vk9sY0J2K2JTUWFtL3NQcHkzR2kzaVpRUXNxcnA1ZEVEUDY2YzRw?=
 =?utf-8?B?cGFHa1ZIVEFncENnMElNY25YTFhnSkp6SXNxQ2Q1UVRiUVN5UXJEZmlra09l?=
 =?utf-8?B?S3RtVlYzRkJ3MlpPQURlRHpmQWtGYzBKaWhNSjdwSTdINFFDRW1Eb002UlVt?=
 =?utf-8?B?ZEZ0SUdJVHhaYTJsM3lWcG9RYXJEcVN1cjE2ajl6OGhKRmhlVmxlNUptM0Vr?=
 =?utf-8?B?U3k5L1RHcXlKeDArVWhFQ2lrQUNsZjFKZDcxTXpmaHhPenpYOTV0MWlqdXRD?=
 =?utf-8?B?ZzBReXBCSThDNU5Zc1ZFV3V2NlltRE1nVDZKMnZGT0JoUjVEcVhHeHE4SUJt?=
 =?utf-8?B?dFg2ZEh3VE5VZ3AxbEhYelorTURzeTBrbDVXMnY5Z0lQK3gvaUt5N2RHaS9H?=
 =?utf-8?B?aVNMcXk0WGhhWUpUQmNGeEhFTzEvL3UxRVRVOEU4T1JURzh2Z05EWHlselFZ?=
 =?utf-8?B?Q0VrZGVpNnYyaXMvODZEU2JrYjFDU2wxR0tabXFiV2xnMzlsNG5nWmtCYlZw?=
 =?utf-8?B?dUtDajNLZEtEbU9UYXRCRzkySmxWRHJHL3p5ZkU5T2ZnczZ1V2ZhWFRrUHNY?=
 =?utf-8?B?MzJSaTB2S0UzN0pBekJOeDBRRVhLa2NsVmpZQjNmSTQvbVNlUDNvMGFOdVdY?=
 =?utf-8?B?aUdLRTlFeTZ1K0EvaGN6dk1wNFY4Qk9CTmNEZnJxc1RiTE9uYVdGUmYyN0k5?=
 =?utf-8?B?UFUzRTFia2xHcDkvT3MxNEdyMnBZcjlXSnBBV1pDU2x5YnlHWFNQelVPV2FB?=
 =?utf-8?B?bkR2OWF1bGVPSys2RkNPb21rQndKbGR1T1IxK1JtT1VvSE5ZQUFmV0JGbHZt?=
 =?utf-8?B?bFJKZm1LV1hFalBHTStyV2dISDU5bm02R2VRc3dkRXh2M0NiU0NaeEJYVG1W?=
 =?utf-8?B?cC9Mb1lCY2xmZU1rR0tYNzBIS2NiZDc2ZmNSY3FqanhuaDZKdUc0OW1uemx3?=
 =?utf-8?B?T0QvNWpZdXZsQjlTWWxTUGhPdkpPNFhUK2ZwM3BIOS9hWXE0b2ovQVZkY0Ji?=
 =?utf-8?B?RUl5cXNacElNdnR4ME1VNnMremZmaEhLR0ZqemdHTHRFcWJGY3FvdDlpR2VU?=
 =?utf-8?B?YWYwV1RURGNOMGJqRXZoY3drRnpDeVRYVVh3WHhlaGRsc0lTb0FPQVg5VjQ4?=
 =?utf-8?B?RmxPK2t5V3lLd0ROZU1ldmxJVWRRU080TXMxUVJsM1NCVzlrVmgrajdwWlRK?=
 =?utf-8?B?MnlKdjdFeUNRdnA5d3ZkNlJTU3hma0w1Q2hOL1NyV1hGYVZxdzN0c2xZM1pr?=
 =?utf-8?B?OEk0VWhWS1p2UEM5T0x0NFRxV2lLdVJmS01OS3RSVkJ2ZmpwUmw5dXFwSC9H?=
 =?utf-8?B?ZGlsanJLK1BMdHdPUEMxTnl2SjFrN1BNMElGK0ZsME5XSWEwcm9hRXpTcC9y?=
 =?utf-8?B?TW9TMTVUejRVeFp5UjBHYUN5UTZXWFllSDVKYTRDeEhrWHRxSWhTdWh1c0Fp?=
 =?utf-8?B?ck1TbXpGMG9BRXBiWXV5RTJweXR2eDFoNHlVbFBYTWZrdlhyQnIyeVU1dkMz?=
 =?utf-8?B?Qks1aVlFbjVQUGRtTnQ3SlZaWXRIR0YzL0d1UWsrUlp3ZnpBYTh2bDVWaCtD?=
 =?utf-8?B?UDY1ZzF1TlRlekVWRXhOUjVrdlJkTFdHZGJ5NW9PTFZCUVE0bVlyNVZaNmdC?=
 =?utf-8?B?VW8rL1NBRUJYOWNlbTg2b281cWlOMHRSK3pvclNlWERRcHQyYVE0eVNsUWFL?=
 =?utf-8?B?bXVaMnp3ay9XMUVtMzlNOFlNUmo2K0JvQm1jYnJCUC91cWlFaVNLTE9BdXBj?=
 =?utf-8?B?WnNZRTVFMko4N0M4bDNOQUl5K3V1VXVkT3pSVU5qMlUxM3Z6US9mcjNvbVZu?=
 =?utf-8?B?a2c1SnQwZ1Baa0MzU2U0M0h5SXhsN0VpZEVTZzM0UFFrdU5Tcks5aWhXNEFm?=
 =?utf-8?B?L0lMbFkwVUFmUlExRVNUNmQ1RDFiNEkzellMV2lxZy9wQmFGT1hvM0c3ZkJo?=
 =?utf-8?Q?tVxN/wPsS1gaBv+MKGvT99QIt9C99mWFJ3wWSyLITVZYM?=
x-ms-exchange-antispam-messagedata-1: kLLLBaaw3QEQ1g==
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a25959-63de-4510-5b56-08da4400c3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 18:58:50.2146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMYXAQdqACFd3kqWqB0gg32nP960djVcPVEf12O6ZC9YdPk0vIZYRQDYpXV4rv8g+ERBwWqm2+o4FLFo09K+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 "pabloc@xilinx.com" <pabloc@xilinx.com>, Eli Cohen <elic@nvidia.com>,
 Zhang Min <zhang.min9@zte.com.cn>, "lulu@redhat.com" <lulu@redhat.com>,
 =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>,
 "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
 "martinh@xilinx.com" <martinh@xilinx.com>,
 Xie Yongji <xieyongji@bytedance.com>, "dinang@xilinx.com" <dinang@xilinx.com>,
 "habetsm.xilinx@gmail.com" <habetsm.xilinx@gmail.com>,
 Longpeng <longpeng2@huawei.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
 "hanand@xilinx.com" <hanand@xilinx.com>,
 "martinpo@xilinx.com" <martinpo@xilinx.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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
> Sent: Tuesday, May 31, 2022 10:42 PM
> 
> Well, the ability to query the virtqueue state was proposed as another
> feature (Eugenio, please correct me). This should be sufficient for making
> virtio-net to be live migrated.
> 
The device is stopped, it won't answer to this special vq config done here.
Programming all of these using cfg registers doesn't scale for on-chip memory and for the speed.

Next would be to program hundreds of statistics of the 64 VQs through giant PCI config space register in some busy polling scheme.

I can clearly see how all these are inefficient for faster LM.
We need an efficient AQ to proceed with at minimum.

> https://lists.oasis-open.org/archives/virtio-comment/202103/msg00008.html
> 
> > Once the device is stopped, its state cannot be queried further as device
> won't respond.
> > It has limited use case.
> > What we need is to stop non admin queue related portion of the device.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
