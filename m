Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29910C433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Jun 2022 02:42:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9570181A39;
	Fri, 17 Jun 2022 02:42:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9570181A39
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ebVk6NU6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dEiJvn4xCZ_j; Fri, 17 Jun 2022 02:42:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29C4F81429;
	Fri, 17 Jun 2022 02:42:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29C4F81429
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0C6CC0039;
	Fri, 17 Jun 2022 02:42:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04681C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 02:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A01004190F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 02:42:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A01004190F
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=ebVk6NU6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcnJ9Hgsu84e
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 02:42:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 938E9418F5
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::626])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 938E9418F5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 02:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLVLb9fUFDH74I4MaMv4wyHXtjHqW8lOakV3oSoDoSCDZilxpDGOknUH/28fprApVzgr0HEosRxngr3FJoKg8TECok7WNojKrAyNbxxSNeulOOgaMnWbgiEJoM/4anzJzImF2eMDuiEJ0e5V7x56djsbw28G+BbLGd7CiuykzBPWdqLwCrAuSg4M863yKa6ZpzJjyRum/NXx6dHJhliMa3K1e6tSR0IF4iHInr0lS5fp/xD5gCVvYIxN0KafwbXA8eGnMoC4NkenNlbFtinnmbLGd5YmTd5iqVWhirSzpGqgjBW6OocA+ni9AvXBgEWfoamp+0D/rSAj+Kav8ikUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzfEDzrYkNA/N9JKYJ35gTfrzejfAQsD3ryOMK03uDM=;
 b=lNPqvNjGyte0qXOA3llTuWL1ScERgT3gPnVIx1Umi7wn+PfFu6ChgiQPay5ltbL6nrkG4qfDjg3j4qRKd3WRfGXCNnlSLDmGbQh0JSG128+e50+vLu7jLb5ws2bJOnusOPf1uS02y75/t0+D6LcmuDKLXgjSGqZZ9IdFf9iD6lyi++TprYHeDob80kiUljtLGdVS31LwW42x6m1zbyXgrkIbaihAACH7DoPKBJZZvfwDbJmI89Rkx4DWII1L/D55mIl2gDH519ROSXvr2jrh1UkOqyZw+6Rt6hpwk6NsHpvRevzH4RXTbt/ZPrTKb/QYXGUE5PjeW2x16iwQd9GXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzfEDzrYkNA/N9JKYJ35gTfrzejfAQsD3ryOMK03uDM=;
 b=ebVk6NU6jnB+Fvn/v+jeoYoBX7No3KrasEar/IwPFHXkfEa/mobv4rZpmOkt7FSJmLcv8xGNXVQRxIMqUV1YUvve9wot5lHjeJ5JvjNPj5eds9fccY0ks1Yksy8JQZcIUOewYVKKSH63sg7qJ2S8dBvYz/4AyvTKxe8Td3w52Tiy9dgl3jgb74TqfR5liykRHDg3l6wG4/xcXJByA5rJodYl4vc5zuJEzB1vYOL3Tb71VW3AI6IZ2HK9KBGyHbwOLmyN8/qAp3xgOmEaID1rj8ajcRfBiUlnIRRjBPqSaDraH/bIvbCpUla2Fn9+J0MBwIkWGdUalIaiI2eFKTDJuQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 02:42:20 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::8c53:1666:6a81:943e%3]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 02:42:20 +0000
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Topic: [PATCH v4 0/4] Implement vdpasim stop operation
Thread-Index: AQHYcP5BrBz66eonZEeOxjwIzt98aa0xHKkwgAFx+gCABD0SgIACqRJggABroACAAQ+R4IAAdxYAgAAMy4CAABLZgIAULSmggAAYr4CAAqccMIAAeciAgAAYI3A=
Date: Fri, 17 Jun 2022 02:42:20 +0000
Message-ID: <PH0PR12MB5481B65329F3F21CE1F938D2DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220526124338.36247-1-eperezma@redhat.com>
 <PH0PR12MB54819C6C6DAF6572AEADC1AEDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220527065442-mutt-send-email-mst@kernel.org>
 <CACGkMEubfv_OJOsJ_ROgei41Qx4mPO0Xz8rMVnO8aPFiEqr8rA@mail.gmail.com>
 <PH0PR12MB5481695930E7548BAAF1B0D9DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsSKF_MyLgFdzVROptS3PCcp1y865znLWgnzq9L7CpFVQ@mail.gmail.com>
 <PH0PR12MB5481CAA3F57892FF7F05B004DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsJJL34iUYQMxHguOV2cQ7rts+hRG5Gp3XKCGuqNdnNQg@mail.gmail.com>
 <PH0PR12MB5481D099A324C91DAF01259BDCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEueG76L8H+F70D=T5kjK_+J68ARNQmQQo51rq3CfcOdRA@mail.gmail.com>
 <PH0PR12MB5481994AF05D3B4999EC1F0EDCAD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtRTyymit=Zmwwcq0jNan-_C9p70vcLP0g7XmwQiOjUbw@mail.gmail.com>
 <PH0PR12MB548104990A5544C738A5A95BDCAC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtytpnCdWdmSh-BuFGXt55DJ9dYxnbw7JQwMXi9bQ8fvQ@mail.gmail.com>
In-Reply-To: <CACGkMEtytpnCdWdmSh-BuFGXt55DJ9dYxnbw7JQwMXi9bQ8fvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 126ddccb-f6f9-48de-fe24-08da500b004d
x-ms-traffictypediagnostic: PH7PR12MB5950:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5950C69F46126B334E8A55A7DCAF9@PH7PR12MB5950.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjP874+07qhM6LQpCWCIfarF2mXdKmLmSn5vFTS3XpsNzZIrlgHLHg5/7DojF6XtzLJNHXRNblMpG7tRvPm5yEi6fclfNsuWu0/0PEbZQXdMGKiI9tOsWeFGrIwMZEpNlp5IKJScU04vNSdDrjbVAYSzh0FVLAusSkbM+DOboT4uyESbuWHJb6lVy0vgRzy6w+ooEcpFR9casRv4gBwgJ50o14L2t1AC7c4Txgf0jc7MCmnIeeBK8Qxp3y8usmO+zX5trlhE9LGleYcxnATPxwuXfvIt+gg99ZQMUTBJDmkY3kw3XqRfy5y3D0picvqg3x+DWVa98sOCFmrtu3LMEVJbAD2OsnPRdK6gBFOaDA6ERBVzlLbsgC7f9vGaN6cjIUY3hWC8Cbdf7660Zuk+/BLgROj/PTx2EODcab38zwJJ6ULaWEODWeYhB0+sVW/reLvrCEuDTkWknmi7t29Zcxl4sOm4/GjHKWt+Kejnxxz8yrXL8c9N+8kLk6dvUNAbfuY4/CVAmLYj0U5yl3odobIVQmDpxTlKYMZKoyKxKWkJgRETKQ8x+hm2ZMsQ67bmtjGvzKWNLrGyqQIgiIXxUtkgEn73bmDhngUKolrPvs1FH1JkyhOB9epnyoKB3o31q0l8RuBVslGh/iANOcBAr9c4dIsBY6nIB9ElrCR/kPKy3mdM6HQzHciuLMzMSLPLFuMql9fNzH6mHUXQ+5Omfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(5660300002)(6506007)(498600001)(9686003)(7416002)(52536014)(8676002)(64756008)(7696005)(66446008)(53546011)(86362001)(26005)(33656002)(122000001)(8936002)(38100700002)(55016003)(2906002)(186003)(38070700005)(316002)(66556008)(83380400001)(54906003)(66946007)(76116006)(6916009)(71200400001)(66476007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWxxMXprYUxiYm5oRW5mazN6THdUbGNEUitrME9HUTJTT2NFN0NmVTFuN1ZP?=
 =?utf-8?B?YW9oUFVMeWlURTZ5K1hGa2dGaXJWTlJnSlZidHJkb25zVlhCMnl3UGU1RDdL?=
 =?utf-8?B?V0Y1U0h5U0FxMnFZSjZFZFcvUEJ3VkZZMS9zRjJKOTcrczlUeHhIaHFveHpO?=
 =?utf-8?B?QmtId2Q1Y0MzTHlHSTNhenFJeE4vWW5ucFZBbjJJaEpJMzhRYy9JVktNeldU?=
 =?utf-8?B?cHMzaGx5RUlBVUJZTXNmOFlhaWQyUStRTmRvTXAwYzArS1FHcjlJamFMUS9I?=
 =?utf-8?B?aEg2UERVUmt4K2lYQzRNWmJlMG0xK3J4YjdGSWlyb3Y1REF2L0tMcHBjbndO?=
 =?utf-8?B?czlodmgxNTB4aFoxQ25DZEdSL1VMOCtHY0VmK3o5dkUrUklpYmc2SVlvblEv?=
 =?utf-8?B?RkV4ZzBtbnVBdjIwZFliRWlFZ04rdlBueUR5dnkzczZGSWM2ZzZEbCtNUTZM?=
 =?utf-8?B?SmxrYVRHZDZOMnJLeHRZNlM2UWorZVVGdmlxekYvNEpoWjJpdlZSS1NxNlNE?=
 =?utf-8?B?WUZxdTJkRXl4MHkzUjRoRWlnOE5qQjJvSXZ2VElNWXBDNXd2QmxETktwQVFI?=
 =?utf-8?B?Y01GL1ZtT3ZlY0VJL1B4eTduNWZUWEJKYXpraTRVU250ZkFGYURsc0JFUjc3?=
 =?utf-8?B?Mjllc2NQbWpMZVk1L1Q0WTZjU1FkckNoU0xtaGhFa2NxQzM0aThSTHViVUtP?=
 =?utf-8?B?cDViNzhvS2VVbXE5MTVDRzJiU3ljOEI4Yk5pNTgvcVNDK3dWV2ZqZnZNdTdN?=
 =?utf-8?B?ZGttVVlNcC92YVJsSHVEUVNnakw3SVJpdUxzTHhaV3VhVFkvckhsTEhWRldM?=
 =?utf-8?B?aDB4dURzT095NlJCVkN1NkFWZ1VrZHlxMTI3T3VuVWhDTE1BS29XREptUXBC?=
 =?utf-8?B?Q3ZHNEJ4czdQeUQ4ZUhQYTFWck9OU1BWRDZsUTBxaEhid003MEVYR2lhOWhE?=
 =?utf-8?B?VFRFRHpvZHM1eWtZNGdWaVV5eDErUUFhcWZscFRyZThsenBYbzdNOWgrb2lt?=
 =?utf-8?B?cEVHdXFIT3NjbVE1eVUyQS9ta21JQmVJN0JmUXpzTnNZSU5QaTFjQmhYR21G?=
 =?utf-8?B?SFBmVi96MXExMFowZjI3d3BmR0ZQcHBHS1FKRTdoNVNsSVh2SCtvbnB1ZlR0?=
 =?utf-8?B?bTYrU2NVNWFrekdxUEpFbTJvSERkcHNEZEtuS0ZEVHBBZGNaM1hxSkJuUDBW?=
 =?utf-8?B?c3BvS215SDdDUmptMlp0dlBRbjB2TjJua21yb2RHYVl5MElsZWxzSndDNjlV?=
 =?utf-8?B?NFV4cjJLRGxIaGN5WCt1bTd1NjYycTZEUkRscEZOZVhkRFJJd2xDNFNPcEc5?=
 =?utf-8?B?cUN5Q2tJd0h2RllwMGVDRVcwcVloRGkxSERhd09TbGh1UmpBVndScHM1ZjVq?=
 =?utf-8?B?RUJ1b3hPRzV1QzYwYmlGcElYbkFSSHJ6S1hTeWt0S0l5ekpScFBhV1ViZFNO?=
 =?utf-8?B?ck1pTVUvdmdDS1RBaWZ6Y1A2bVhxZ2E4UXRBbnZoVTcrS1NxbjNIaFZTUkxo?=
 =?utf-8?B?SWZtSjVQWnNtbzB6U3VDNWtoVlBKUGtBeW5ZbTh6VXNNV1BndXBwU04xMFlN?=
 =?utf-8?B?VE54MW1CWHlrc1BjQmRFYk9DUVRQKytDSjlmWVVWV3pTVUhIY1I5TGVtaHBI?=
 =?utf-8?B?OTJaeUdpSkFlcnd3Q1BXUzdXUFZHV2VDVm8zU2srNy9GQ1RUUWhLbm1nR1Bp?=
 =?utf-8?B?ZlVTTk11YTdja1RvbWlRYnJXVzIveXdZbnhja1ZLRjl6Uk8xcHZ4am5BZ01U?=
 =?utf-8?B?ZlVrb0FabC8vdHRZTjRacGRvdmxGb3ZWRW9pR2tMS1dqSk9YU04rUWVOeFVn?=
 =?utf-8?B?d0dXbjJ1WkRZZzBsN081cHZ5czZ0eUNydGZaUVdXK1h6NnVBSmVpV0JuY2ZG?=
 =?utf-8?B?R0tDaHFiWjY1WFIwVFBud0hZTW9lZmJEUytGYU44eWh4dXB5S0oxcHArYUI3?=
 =?utf-8?B?cDAyOEtuZjhUUjlLODg0NGswenZEd0tKUGtqVHV1N1RSL2Q5czJ3MmgvTUdS?=
 =?utf-8?B?NlhaK3lGWDd5WVNmR2wvaUJKVlVKRG4vdTRPTGxCdXFGN0JodXZiaTh2b091?=
 =?utf-8?B?UWxQYmc0MG1EdVU0YXJueHBJaEl1QlZhWGI0SVNPcjlKTjAyUDZRTExTNXJF?=
 =?utf-8?B?MDlDbGRmRUZ1eEp1QmI5a04vM0NLTUliMDJXOUV2L0Uwd0FES3N0U1c1UExS?=
 =?utf-8?B?cG9FSjVhNXhIRmY5bWVCMmtyNTd1RmFXcVBaKzVUQ0hIRnc3ZmxSWDRjeisy?=
 =?utf-8?B?Nm1xaExuQjM5MEwwSHdDSUlFZHZsMWNRSXZreDZGUkFZdkVTRmoydTR5NGRj?=
 =?utf-8?Q?jr8VOOp3cOXQb3Gp/K?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126ddccb-f6f9-48de-fe24-08da500b004d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 02:42:20.6163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o5wZA/hrvCNwtyPsBO2wJ4Lv6sWYS6MGgk9kaLYfCy6GWK5iU5uH63W3Ybz8cXykIY8j7PmSmHcsjYddpXr16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
Cc: "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bmUgMTYsIDIwMjIgOToxNSBQTQ0KPiANCj4gT24gRnJpLCBKdW4gMTcsIDIwMjIg
YXQgMzozNiBBTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+
ID4NCj4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiBT
ZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDk6MjkgUE0NCj4gPiA+DQo+ID4gPiBXZWxsLCBp
dCdzIGFuIGV4YW1wbGUgb2YgaG93IHZEUEEgaXMgaW1wbGVtZW50ZWQuIEkgdGhpbmsgd2UgYWdy
ZWUNCj4gPiA+IHRoYXQgZm9yIHZEUEEsIHZlbmRvcnMgaGF2ZSB0aGUgZmxleGliaWxpdHkgdG8g
aW1wbGVtZW50IHRoZWlyIHBlcmZlcnJhYmxlDQo+IGRhdGFwYXRoLg0KPiA+ID4NCj4gPiBZZXMg
Zm9yIHRoZSB2ZHBhIGxldmVsIGFuZCBmb3IgdGhlIHZpcnRpbyBsZXZlbC4NCj4gPg0KPiA+ID4g
Pg0KPiA+ID4gPiBJIHJlbWVtYmVyIGZldyBtb250aHMgYmFjaywgeW91IGFja2VkIGluIHRoZSB3
ZWVrbHkgbWVldGluZyB0aGF0DQo+ID4gPiA+IFRDIGhhcw0KPiA+ID4gYXBwcm92ZWQgdGhlIEFR
IGRpcmVjdGlvbi4NCj4gPiA+ID4gQW5kIHdlIGFyZSBzdGlsbCBpbiB0aGlzIGNpcmNsZSBvZiBk
ZWJhdGluZyB0aGUgQVEuDQo+ID4gPg0KPiA+ID4gSSB0aGluayBub3QuIEp1c3QgdG8gbWFrZSBz
dXJlIHdlIGFyZSBvbiB0aGUgc2FtZSBwYWdlLCB0aGUgcHJvcG9zYWwNCj4gPiA+IGhlcmUgaXMg
Zm9yIHZEUEEsIGFuZCBob3BlIGl0IGNhbiBwcm92aWRlIGZvcndhcmQgY29tcGF0aWJpbGl0eSB0
bw0KPiA+ID4gdmlydGlvLiBTbyBpbiB0aGUgY29udGV4dCBvZiB2RFBBLCBhZG1pbiB2aXJ0cXVl
dWUgaXMgbm90IGEgbXVzdC4NCj4gPiBJbiBjb250ZXh0IG9mIHZkcGEgb3ZlciB2aXJ0aW8sIGFu
IGVmZmljaWVudCB0cmFuc3BvcnQgaW50ZXJmYWNlIGlzIG5lZWRlZC4NCj4gPiBJZiBBUSBpcyBu
b3QgbXVjaCBhbnkgb3RoZXIgaW50ZXJmYWNlIHN1Y2ggYXMgaHVuZHJlZHMgdG8gdGhvdXNhbmRz
IG9mDQo+IHJlZ2lzdGVycyBpcyBub3QgbXVzdCBlaXRoZXIuDQo+ID4NCj4gPiBBUSBpcyBvbmUg
aW50ZXJmYWNlIHByb3Bvc2VkIHdpdGggbXVsdGlwbGUgYmVuZWZpdHMuDQo+ID4gSSBoYXZlbuKA
mXQgc2VlbiBhbnkgb3RoZXIgYWx0ZXJuYXRpdmVzIHRoYXQgZGVsaXZlcnMgYWxsIHRoZSBiZW5l
Zml0cy4NCj4gPiBPbmx5IG9uZSBJIGhhdmUgc2VlbiBpcyBzeW5jaHJvbm91cyBjb25maWcgcmVn
aXN0ZXJzLg0KPiA+DQo+ID4gSWYgeW91IGxldCB2ZW5kb3JzIHByb2dyZXNzLCBoYW5kZnVsIG9m
IHNlbnNpYmxlIGludGVyZmFjZXMgY2FuIGV4aXN0LCBlYWNoDQo+IHdpdGggZGlmZmVyZW50IGNo
YXJhY3RlcmlzdGljcy4NCj4gPiBIb3cgd291bGQgd2UgcHJvY2VlZCBmcm9tIGhlcmU/DQo+IA0K
PiBJJ20gcHJldHR5IGZpbmUgd2l0aCBoYXZpbmcgYWRtaW4gdmlydHF1ZXVlIGluIHRoZSB2aXJ0
aW8gc3BlYy4gSWYgeW91DQo+IHJlbWVtYmVyLCBJJ3ZlIGV2ZW4gc3VibWl0dGVkIGEgcHJvcG9z
YWwgdG8gdXNlIGFkbWluIHZpcnRxdWV1ZSBhcyBhDQo+IHRyYW5zcG9ydCBsYXN0IHllYXIuDQo+
IA0KPiBMZXQncyBqdXN0IHByb2NlZWQgaW4gdGhlIHZpcnRpby1kZXYgbGlzdC4NCg0Kby5rLiB0
aGFua3MuIEkgYW0gYWxpZ25lZCB3aXRoIHlvdXIgdGhvdWdodHMgbm93Lg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
