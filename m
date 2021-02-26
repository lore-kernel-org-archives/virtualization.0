Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDAC433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:53:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF73F64E28
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF73F64E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EE6B6F90D;
	Fri, 26 Feb 2021 08:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJD8xf-ro--A; Fri, 26 Feb 2021 08:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D327E6F87D;
	Fri, 26 Feb 2021 08:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7637C000A;
	Fri, 26 Feb 2021 08:53:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C6B9C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ABA384125
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wcK9R-tzZoI9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 170D88414A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:53:07 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6038b6f30000>; Fri, 26 Feb 2021 00:53:07 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 08:53:04 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 08:50:47 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 08:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBppsDBrdMNN6tbbEnzyPC7PBUpS/2aIFn63mJGxmULBzb6fe2wsWH+yUjtwCrpgXapv7kSoKugaFLm5AdCgiKzqecsrnq9fskL8rNNHWQtNuECdfh5QDIqoWUihBT3+w1vfHr0BAKd3SH6qv3kt1pCYbuBqERt6zwwet/yJnkpvyGdvr7gKpXiOEDSqzq6XKTcQsQMwC7tnbKZ2ck59ZkonKXCtWfqfsBR0Yf6DBy0Ikz2yzk+pDRlc7kl5wERUtxoeel/VBU/0aGBdrcfzQTZN+9Rt8vfj0uLM2KEJ7Gjdq4PM1s9GMMUfAMytCflul1s6hHt416q0whSC5v0gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2HGz5kLMBzybwZPN3iEgGLItrP0L41QS/97w7ezPT0=;
 b=EQ9NIUiyvHkme3ts0Fzxnb1k/eF7+J6AxkU/3kD2nFx2A0MiLDROPXxTVWjgxaCHeiEaQ2eA21l/d4UjAViI/u58nrmb6b+Y4Id50sxcqGVO9jy1NF8WnK/rVREfHh5Ig0Har6yRr6BKCY6dsSswJx3AMslrCYRVxrYpLrteWP4cIXAWDkAT97fWxzzXAusNA0e1TObmtglGI17UvjFy355BGATtfQFq5rfWTbU+ukhKQfDsChEoh6G4G8oj6zPJE838oK2Xq79EfEJ0A8ENuJ7J8+Q53REFaCjr5x1kcYtshj/8CApd/vcJ0b5uqvO8pZ+igGCGQHkpyLGQzhfweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 08:50:44 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 08:50:44 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXCnT31njXIAjUUU6IgFe+oKOVAKpm/pCAgALsxWCAADHpAIAABOIw
Date: Fri, 26 Feb 2021 08:50:44 +0000
Message-ID: <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
In-Reply-To: <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25909edf-252f-4595-4acb-08d8da339a7a
x-ms-traffictypediagnostic: BY5PR12MB4323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB432387585B9CE41F4E4387A4DC9D9@BY5PR12MB4323.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvULkzYeE1VmEIUqQ3QDq7jqupr+Mal7r7r52Lc3haVICg64tF24LT1PGWpqFhV1R+Ayr0gsknEhljYeH0WRt9rcMLCqW5EgtDT/TO46dOflTpJrBqmDWClqxNdniliwUcp78uMupPGEw3Ke2iLqvgBHzIJBzru984GVYkbL0/oOxbTkCBglK6BuShazrMPKeHqbHQN7w7Uba6N1p62IYG/bm94Q0pC/v1dtZES5jknR/FECbIEG4cCd/JafZ3F+mAbnPB+imWxFTWqmPGoOfYzu7L2QeOtlh4SJj+P8RCQNEil7UiSptI0sLAG8mYST8ZsulIEfXckCJjWVlfOhSbeuu7K6iLihsW77b6X+IbpBKQLefT2cfCStMaS9L3hnKi8VYfKx/oe4RgDUOmloTkxiFY0QKGqeve27ZXlx6GR4UxW6kheBDPh4GoY/bvlpAS9F8dJhqOthE0/To1n9hfS6yLt0t000s/EUxGD4us3caOYGAdMD0mRut3o9ahkYjJ6bzC8SWNdfYJV7ZwzJPw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(86362001)(64756008)(5660300002)(76116006)(66446008)(83380400001)(52536014)(33656002)(2906002)(71200400001)(4326008)(55016002)(478600001)(66476007)(9686003)(53546011)(8676002)(7696005)(6506007)(186003)(26005)(8936002)(110136005)(54906003)(107886003)(316002)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDlmbDZPYlQxanRDcFMyTFIyNGFxY2tHSHJ1NURsdkdNR2J2Z0p4T3ZSV3pQ?=
 =?utf-8?B?RnBZSHNJR0U0c2U5R0RxUEE5d3FGcGIxZmRHV29HQmMxUlBFT2NDSnFqdW9O?=
 =?utf-8?B?TjRZYzBMcm9VR0NNcGZScnh5QUc4SGp4b2htb2hqL0o3c0UxWHV0Y0F4N3E3?=
 =?utf-8?B?U3NNVFNtaldndVRnUnc1KzllSDQrWkc1UFF2Nm1FSElkK21POUFQQ0ZWWTJW?=
 =?utf-8?B?VmtaUmtKdUs4d0RCN1lBQmFBMlRJcHVvM2dCZ2lwUkJYTklnbUM2bW5KYjF6?=
 =?utf-8?B?ZC9SV2NqUWgxTkt3K1ptVE9IMFNFa2MvTHh3cmFabXFRWUZnNll2U0x0Tlc2?=
 =?utf-8?B?QllUUG9Qa1NPd2dvMjlraTZVV1VEcVk1ZWJhekx0NnFUc0JPRjNVQTlGMVF0?=
 =?utf-8?B?TlQ0R05JUlZnTzN2SEZ0MW8ySTM5ak1XOXFLSXB2TFdhcXpJZjNrWGNoNkFE?=
 =?utf-8?B?djFpSjBMSEJsTSswV2lUNFoxWkRZODZwaWJZQTNreTIrb0cxRHZHWjRVVmpu?=
 =?utf-8?B?MzJmOVFKWTV3YWd1bkFrRDBEMVB1MTEvYmwvZDJjRWpKTFN5aWNLRW1lL2dS?=
 =?utf-8?B?MldtUTI0TkRsUkczV3NTaW5tdkY1Y3liaG1jWURPSzhnRFg5d0JvQjB6eStK?=
 =?utf-8?B?V1M2YnlucXJyZjdFUmQrKy9nZ0VScG41S2drM05ZQTFEbU0zZWtua1M1Tjdy?=
 =?utf-8?B?dGlEUlpYNE55bHhSV2xIZmszTmU0VVZnSzg0dzhicFNRZkVKRld1ejVPaWpm?=
 =?utf-8?B?MGlLaWk4aVk5cS9vdDg5NGxJa2ZLWkh4TzRmeWl5UTBYMncrYURqZndzdWdU?=
 =?utf-8?B?NWJ3ckNkZ0libitJTlVxd2xVUmJPUUNtaWVZR05GMFdZa0Zub21EMjJXc3pj?=
 =?utf-8?B?QmZ3UTY2NHlKTGlSL0dDeTZTaTVqVlpVTHlBbXdwN1NMNGRsSHRheUZ2NGFL?=
 =?utf-8?B?TTVscFBHVUI5UEUvZFhQZTg1eG5ITE5ZaXNoaGZzWmpSSHRYc3IwMU1CTnJN?=
 =?utf-8?B?YXZIVnBlZzBjeE5JMWVJOFRPc3FtVW9Vd0xQUFJOcUdobjRkY1ZsRXZ3VmFr?=
 =?utf-8?B?WWUzanVKcU1vVTRVNUgwY0l1UTFxU2o3NmYzL21wRmc5ZGJ5RkN4WDhjdlcr?=
 =?utf-8?B?cmR1Z3dQenRncnBXN3QvdlhLbDdqSlluM05LYlNYcVVyNHo4V3k0L2JXT0l5?=
 =?utf-8?B?ZnRZZVpUTCtKZm1pbURFdVhUeWhOWEtpaXppczBaUEtEWmRWcG0zaStEUGNJ?=
 =?utf-8?B?ZDlaSHNMaUdUOGxvVVFSdFJzOG54dmJxLzc2RS83VEE4VmE3UzUxRTdmcUxW?=
 =?utf-8?B?Ky9PbFBMaUpJaXNPc2RvNmpva2M2VGp0MDZhckl5ZDVXNTN6MnYrdithSFg2?=
 =?utf-8?B?MDI3d2RINElZQ0RMbzNJS3dQRVk5QjlJZFROcWQwUFNLajNqSmFCM3dmNWZD?=
 =?utf-8?B?QWhaMjJMVC9sMGxrcGR3elRpM3ZXRS9mcHlyV250elBNM0htOHUrRityZzFV?=
 =?utf-8?B?aTcwVkhDV3JQTTNwMHJMUDdNTVRSb3ZEeVFNRm0vem4waWFHVXhBVXB4My85?=
 =?utf-8?B?Y3h3YW00a2xidVZqWVBOVnhQaWtvOHlhV2JsTmkxNndPMDFXWmJBaUxFWFB3?=
 =?utf-8?B?bFlTUGRNcDVGLzhkd0xvR2R2RGMvTjIzUHRNTDl1MWI0Nnk3eHdxQVJKK3hw?=
 =?utf-8?B?Qnh4Ny9HNFhYY1VORzd3TUoyajNHVzY4Y1BiS3BnZW04N3AvU1FDSXlwY0sz?=
 =?utf-8?Q?tcMXRvj1X32hNnAg9VG8j5X603+jHqNUxVRi34x?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25909edf-252f-4595-4acb-08d8da339a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 08:50:44.1026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fq6B4VCfXlQ2XIOb+HJbPsZAw6atFIIXHbo6NKY6f+vX7UPdZ2bqn5QMv5+ytqf6EXsFPxOGwCGZnkLo/x/cTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614329587; bh=n2HGz5kLMBzybwZPN3iEgGLItrP0L41QS/97w7ezPT0=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
 x-microsoft-antispam-prvs:x-header:x-ms-oob-tlc-oobclassifiers:
 x-ms-exchange-senderadcheck:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=Z1kzp4sJJMf/C3WQ3lHXA5OS8oaqeFaaEnnnz9BmLBy4Z32D0cajA0ZUZsOxt6tQe
 xAXsD8UP+ATzaMF/LW3a7/Apviw7kmSVlDlBEKcIOmeJX3FfrseyvmksfboeJFZuMp
 SzF2TPIMAUEWpA7Xoi7TepZGaWx+LTGZoS1+42Yr3js0VI5w4NAzDnbM8eg3LVMJSn
 oGpQMeGUQhWq9MSZnwt4Vv5GaiIus/jvTbTg5ZlpBpAIIaFnk80N949g7wKjsYw/KC
 /IYo+DG5Bfv/t7SXrtS4Lwn9bD7J7EYCOZA0bGI9nUX2fXfAT5FmveDHvo5aAatBQ6
 o8YRr6SgVgKbw==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBGZWJydWFyeSAyNiwgMjAyMSAxOjU2IFBNDQo+IA0KPiANCj4gT24gMjAyMS8yLzI2IDE6
MzIg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
NCwgMjAyMSAyOjE4IFBNDQo+ID4+DQo+ID4+IE9uIDIwMjEvMi8yNCAyOjE4IOS4i+WNiCwgUGFy
YXYgUGFuZGl0IHdyb3RlOg0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLCBW
RFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwNCj4gPj4+ICsJCQljb25maWctPm1heF92aXJ0
cXVldWVfcGFpcnMpKQ0KPiA+Pj4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPj4NCj4gPj4gV2Ug
cHJvYmFibHkgbmVlZCB0byBjaGVjayBWSVJUSU9fTkVUX0ZfUlNTIGhlcmUuDQo+ID4gWWVzLiBX
aWxsIHVzZSBpdCBpbiB2Mi4NCj4gPg0KPiA+Pg0KPiA+Pj4gKwlpZiAobmxhX3B1dF91OChtc2cs
IFZEUEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfTUFYX0tFWV9MRU4sDQo+ID4+PiArCQkgICAgICAg
Y29uZmlnLT5yc3NfbWF4X2tleV9zaXplKSkNCj4gPj4+ICsJCXJldHVybiAtRU1TR1NJWkU7DQo+
ID4+PiArDQo+ID4+PiArCXJzc19maWVsZCA9IGxlMTZfdG9fY3B1KGNvbmZpZy0+cnNzX21heF9r
ZXlfc2l6ZSk7DQo+ID4+PiArCWlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVU
X0NGR19SU1NfTUFYX0lUX0xFTiwNCj4gPj4gcnNzX2ZpZWxkKSkNCj4gPj4+ICsJCXJldHVybiAt
RU1TR1NJWkU7DQo+ID4+PiArDQo+ID4+PiArCWhhc2hfdHlwZXMgPSBsZTMyX3RvX2NwdShjb25m
aWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKTsNCj4gPj4+ICsJaWYgKG5sYV9wdXRfdTMyKG1zZywg
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19IQVNIX1RZUEVTLA0KPiA+Pj4gKwkJCWNvbmZpZy0+
c3VwcG9ydGVkX2hhc2hfdHlwZXMpKQ0KPiA+Pj4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPj4+
ICsJcmV0dXJuIDA7DQo+ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbnQgdmRwYV9k
ZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwNCj4gPj4+ICtzdHJ1
Y3Qgc2tfYnVmZiAqbXNnKSB7DQo+ID4+PiArCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25m
aWcgPSB7fTsNCj4gPj4+ICsNCj4gPj4+ICsJdmRldi0+Y29uZmlnLT5nZXRfY29uZmlnKHZkZXYs
IDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsNCj4gPj4NCj4gPj4gRG8gd2UgbmVlZCB0byBz
eW5jIHdpdGggb3RoZXIgcG9zc2libGUgZ2V0X2NvbmZpZyBjYWxscyBoZXJlPw0KPiA+IFRvIHJl
YWRlcnMgb2YgZ2V0X2NvbmZpZygpIGlzIG9rLiBObyBuZWVkIHRvIHN5bmMuDQo+ID4gSG93ZXZl
ciwgSSB0aGluayBzZXRfY29uZmlnKCkgYW5kIGdldF9jb25maWcoKSBzaG91bGQgc3luYyBvdGhl
cndpc2UNCj4gZ2V0X2NvbmZpZyBjYW4gZ2V0IHBhcnRpYWwgdmFsdWUuDQo+ID4gV2lsbCBwcm9i
YWJseSBoYXZlIHRvIGFkZCB2ZHBhX2RldmljZS0+Y29uZmlnX2FjY2Vzc19sb2NrKCkuDQo+IA0K
PiANCj4gUHJvYmFibHkuIEFuZCB0aGUgc2V0X2NvbmZpZygpIHNob3VsZCBiZSBzeW5jaHJvbml6
ZWQgd2l0aCB0aGUgcmVxdXJlc3QgdGhhdA0KPiBjb21lcyBmcm9tIHZEUEEgYnVzLiANClllcywg
YSBydyBzZW1hcGhvcmUgaXMgZ29vZCBlbm91Z2guDQpEZXZpY2UgY29uZmlnIGZpZWxkcyBjYW4g
YmUgY2hhbmdlIGZyb20gdGhlIGRldmljZSBzaWRlIGFueXdheSwgc3VjaCBhcyBsaW5rIHN0YXR1
cyBhbnl3YXkuDQpTeW5jIHVzaW5nIGxvY2sgc2hvdWxkbuKAmXQgYmUgcHJvYmxlbS4gDQoNCj4g
VGhpcyBtYWtlcyBtZSB0aGluayB3aGV0aGVyIHdlIHNob3VsZCBnbyBiYWNrIHRvDQo+IHR3byBw
aGFzZXMgbWV0aG9kLCBjcmVhdGUgYW5kIGVuYWJsZS4NCj4gDQo+IFRoZSB2RFBBIGRldmljZSBp
cyBvbmx5IHJlZ2lzdHJlZCBhZnRlciBlbmFibGluZywgdGhlbiB0aGVyZSdzIG5vIG5lZWQgdG8g
c3luYw0KPiB3aXRoIHZEUEEgYnVzLCBhbmQgbWdtdCBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2Ug
Y29uZmlnIGFmdGVyIGVuYWxiaW5nPw0KPiANCkluIHRoYXQgY2FzZSB3ZSBzaG91bGQgYmUgYWJs
ZSB0byBkaXNhYmxlIGl0IGFzIHdlbGwuIERpc2FibGUgc2hvdWxkIHRha2UgdGhlIGRldmljZSBv
ZiB0aGUgYnVzLg0KSSBmaW5kIGl0IHdlaXJkIHRvIGhhdmUgdGhpcyBtb2RlbCB0byBsaW5nZXIg
YXJvdW5kIHRoZSBkZXZpY2Ugd2l0aG91dCBhbmNob3Jpbmcgb24gdGhlIGJ1cy4NCkZvciBleGFt
cGxlIGRldmljZSBpcyBub3QgeWV0IGVuYWJsZWQsIHNvIGl0IGlzIG5vdCBhbmNob3JlZCBvbiB0
aGUgYnVzLCBidXQgaXRzIG5hbWUgaXMgc3RpbGwgaGF2ZSB0byByZW1haW4gdW5pcXVlLg0KDQpE
byB3ZSBoYXZlIHRvIGFuY2hvciB2ZHBhIGRldmljZSBvbiB0aGUgYnVzPyBDYW4gdmRwYSBiZSBh
IGNsYXNzPw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
