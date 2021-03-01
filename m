Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5170CC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:29:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCF164E22
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 07:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCF164E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A5FC8424C;
	Mon,  1 Mar 2021 07:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRoka_vqtWot; Mon,  1 Mar 2021 07:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E54A38424B;
	Mon,  1 Mar 2021 07:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8575C000B;
	Mon,  1 Mar 2021 07:29:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CBE5C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A6408424C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SnIOGx-TWGjs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:29:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47CE78424B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:29:16 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603c97cb0001>; Sun, 28 Feb 2021 23:29:15 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 07:29:14 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 07:29:12 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.57) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 07:29:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkGfv/ChgFqYiEC8zXYMcxKCS+iWZBoeVpGzrjY+OIv3UubktP7kNFhJ5hJWNOM/l3gUNQ0w9fZ0Swwx+7gPsAdtdrY1m1rwfIPpD2VWc73UHriL0aT8qS+hBpPIH43XJxyxlG4vgUZjcRafEVS0LNutNggtUnUJ8XdOA/1ZU5dxpTyfIlEUdW659wj8XXUYcgMO/8W+kspN5yf3roObKOBOgg9XtyUJVfMCMnU4q1YYtRE8rOTmasB/0N1SOM6xbjJiJ00vODXaR+OQT/+iKYZRh4hhyE2B+hh0ivi4sxA5U6yrm7b9zPjHROJ5cFxxQvrBpnTNQPK0FIHipkTNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUbdHoYj5cSIcc37tqzdc+eNw+fRBIjj0Zl6/10tQuk=;
 b=kpcc8sZqOJRCbDYJG6yQjwj8A0AmH4r8/ujVw04NOwcPS8/IN2/akVSJEeDIf+QLxXdAj5tYICDtFoGHq5E26uJ41nnAmmYdC9LsfG+gkW7R4tliSx+WU+y/hWvUrVX3BR5OnT4BSjOvCX/+xiNLxcAkcDfdzi4kRjVYf+c+T0aX4Va/viicH3xn3hfwgpl0TjCCCYvgv3yvoQmIVWJdnt39LASiMy7B5R6lawHPHzTjYoaK7GHqzzFcMqd8q+5O7FG9QnMPG9wLWY/ZPwhG2JBndHYSPme69RR2FNXgwiUu+dHJcw7YVvaB6Iepk4AyUEugH+RotkJcu/LLLmdfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3624.namprd12.prod.outlook.com (2603:10b6:a03:aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 07:29:10 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 07:29:09 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXCnT31njXIAjUUU6IgFe+oKOVAKpm/pCAgALsxWCAADHpAIAABOIwgARneICAADkwAA==
Date: Mon, 1 Mar 2021 07:29:08 +0000
Message-ID: <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
In-Reply-To: <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a0121c9-7733-43bb-9a55-08d8dc83b47a
x-ms-traffictypediagnostic: BYAPR12MB3624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36248F3B8C155F2D3929E78DDC9A9@BYAPR12MB3624.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0G7w2E6M7y6UrVD0NPOIPICUirgLEkRg9Ki/B6FSMRquCJLR5QSr69R2Km2ZC9D+wG3VKwGbsM16HnluCw+NbWlSEvno57P68VGeat7rXGD5UyeGa7vza0WQyPni6Fbsf+xu/kq2M1o4ixvx2ePEySiwx7t6uM/TzaBuN3ys1gSrkaTQ+L+jLH8dIe/Qq0J4YzA6266aEUakGypjABv4TD0xbdFghVhkLetsIwZt71EOFVtLRgUFadGJVQbxqlLGYa7vIDgE0y3FtDFdZjRlVRTtkQ55uw/gxZtRQhMu5BqtLlNJ693280XR8Vr7zGuY9wmFB6VY3JZYhIZYlIAF2RfvG1oUb+Jth53JcqQHszTD/DgY+DMq2ocI7/LB3r2GX6PfXib2RjspS0N/ZgRd5F1WvbEdvVpT3OttjGcUBrEcczlOofurXP8AVjBNzOgMQeARSJsjQPNvBGchUD69TDsT8IpKHhomiUe+T8V4jwhqrA/68bjpH6uUlgX9if9cgYvcq6RVoIJSPVxH8zsJ3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(52536014)(9686003)(66556008)(5660300002)(107886003)(66446008)(8936002)(6506007)(53546011)(66476007)(55016002)(71200400001)(66946007)(76116006)(2906002)(8676002)(110136005)(186003)(316002)(478600001)(26005)(54906003)(7696005)(64756008)(86362001)(33656002)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?OTdXS0RkbkRaWk05aVFWUGwyS2l0dDRIcnQzN1doRFE3ZGxtZHU0QW9GeC8x?=
 =?utf-8?B?NlBsNFZwN1hVb0JYODN1MWJkWWo0aUVmb3Q0M1RpbkRtMnlWcHgrZEdYa21B?=
 =?utf-8?B?UHBHSDY0NHFoc1VzWkZ2cUFwTjlHZkxFa3pKT0o3enJSTHVOeTJVSUhGdnNK?=
 =?utf-8?B?OWxmWi9Oa1N5NERhSVZjVGZUWVZDck41MVJMQmRxYnBNajZxRkZNK2xXdEVC?=
 =?utf-8?B?cUc0eTMzMHNPSEpycUp5bjFobXhCQmh3U3J5QmZRVVhrdVM1TEtISmdBM2Nm?=
 =?utf-8?B?VGErUlhzc3hQdkVKa2E0T2dLd1pETnFnRG1GUzVmN1BWZ0JtemZlQ3V2STJw?=
 =?utf-8?B?Y3JFSUFDbXB1UVBnekVVdEFCMmZXeDVqdlF6WTJZME1tWVBpNktldkVSRllw?=
 =?utf-8?B?SjlsMmNNOVRMTUFmalVRN2VjRnBLR2IzUGo2enF4dmlkZGZJU2lXbVpkUGlG?=
 =?utf-8?B?SUlQZVEzeUNuUnBtK1RpQ0FSWFpNZzQwTVZvZzk3YjdXdmdsNFpiaUtrdmhY?=
 =?utf-8?B?ZzdHd09aWHVCamhmcmtLcGZhNEpiZlRCa2hkOGtMQkh5ZFJvZVZRMzdEY3Uv?=
 =?utf-8?B?bVBxa09sKzNRWkVJQ3ZscmNSSGJnd3hZQXg0aXZ2bGl0QVJnYU0vdnZUSHpr?=
 =?utf-8?B?VXFPR0xDTjRDWGNjTGZaUnM2OHdEVTVXWEhEL240WTNEMWZpOGJscFhuTWND?=
 =?utf-8?B?KzFFcHpvTVV2OXlrZks3aDBrOTVoTHA4dFQzVzM3OEpzdWNwdGdlc2hsUXlD?=
 =?utf-8?B?Z1MzdmtMRkhLOTBwMjVLRmhHN3k1Z1U2bjFKZG93Zm5WNk1MclljVkcvaU04?=
 =?utf-8?B?eVpVUGFObUR6NkcyNzc5ZW9QakFqL3RyMVZwc3pkMFk3QnR0SjN1TVdnLzMy?=
 =?utf-8?B?SFk3Q1RHVWY3RjZlZUVSdlBicDFBQTZsbjB0YW5tUSt0T3lHSUVDSmFqbExa?=
 =?utf-8?B?ZzlKSC9pY2xqRjNuSEZDR0ZOSlFSZ0thaGVZb2RDclRrTW1uSmxwZHJheFhB?=
 =?utf-8?B?cGtLZlRoZUhBOXhqVytObmwrOWVxS0dQeVlxOU51WGw1UjFjMXBMSngrN0py?=
 =?utf-8?B?cUxJbWRsWFhEOVNXRlFSR01xUmhoUDhTZ2d4cE5TRDgyVFhyMFoyYldYdjR2?=
 =?utf-8?B?aGhPb1d1NnVRZDNlVlRYQjRzWHdVZEF6THgyTzcvcFpCb0dqaENOaDFXcVNP?=
 =?utf-8?B?WDlDdzJuVy9tT21qZmxFMXlvaHB2emh6OTlCcTFkY09pZXVYWHoycWNhbmhJ?=
 =?utf-8?B?TUpFSjVjM29CYjR2OTVrdHo5eUR0Y3ptTlhCL1JmbHhnSi9NY3g1bURBcWNZ?=
 =?utf-8?B?bFQxN0o2YmpGMFFWdlVNeG9naGEvbTV2SVRpU21pRzZoeFMzaWh6NFRzUVNF?=
 =?utf-8?B?SGFvSXl0QmdJOS9pcXYxZzR1MWQzZE9nNjRLaDV1dDFEWVl2czdmMXJNVjMy?=
 =?utf-8?B?bDZ3WVFVUlc1QzZ4Zy9pQTlwZk1URG5LTURFQzFqQk83WFlML0lXVCtabldY?=
 =?utf-8?B?VzRmZVZZSDM4akgxSGovaGZ3UDIzUDFES0JKdkJsZVl2MDcwWmZqQytvUzg0?=
 =?utf-8?B?RVF3Z2Ura1ZGZ1dJaHJ6aEtRYTVTMWdtQ283SkoyV3Y3TlhlNXFRNXB1SVp5?=
 =?utf-8?B?Wnd5TWVTRHRORFNCZWhVcForZUFLMG9IL1NoYzlqMlk3YVlnS28rY1E0U0li?=
 =?utf-8?B?Vkx2UXZTeXVWeEFibzMzZkM3b0xmeHJnUEtOVVlwNnRaRk1NblpaVCt4VmNG?=
 =?utf-8?Q?7D0Uh3yuiN7vu9cTgOZNe61VX99fQ3RaIuNbn87?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0121c9-7733-43bb-9a55-08d8dc83b47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 07:29:09.8102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMnDHLwzIe6gF3Ww+T8DsaIDSF0u5IyQ00c2++JumyXvBUHDr79avDwIVPoWw+8Qiyon5ISY2iODTMLX+BPXxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614583755; bh=zUbdHoYj5cSIcc37tqzdc+eNw+fRBIjj0Zl6/10tQuk=;
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
 b=n3BOv56QqhhzPRvipL8M7y9VJ+gAt/ndUw+ZKYyBYLkAyoAw25dKvZ58TQGGrYhIu
 cWcRqtcUkFMibTW6Ir6aCF3wp3CGTwiwPJiVYARcp7FOmCsc9KYlkD3/ItScWecs2z
 5Ur2NFcIYWxKvqAApG6XMrO3sa8G4WQhuHU2XYyruNiMm4dMzTmU8ElXfRuM5Hg1Rv
 Qpt+eOu6PdORrZy67CBb6Vfy5plxWEY+amVlxmiFfwSr9HweQLvi1lWsBwXK9ceMMk
 sOX+eB3Y6t779FLx3HMtKeYic/HsMaHp6DSvXHOZ71fcBoVSLUqCZGlqeIG6lP+Uzw
 Gp/6GRNqNVieQ==
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAxLCAyMDIxIDk6MjkgQU0NCj4gDQo+IE9uIDIwMjEvMi8yNiA0OjUwIOS4i+WN
iCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgRmVicnVhcnkgMjYsIDIwMjEgMTo1
NiBQTQ0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAyMDIxLzIvMjYgMTozMiDkuIvljYgsIFBhcmF2IFBh
bmRpdCB3cm90ZToNCj4gPj4+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pg0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjQsIDIwMjEgMjoxOCBQTQ0KPiA+
Pj4+DQo+ID4+Pj4gT24gMjAyMS8yLzI0IDI6MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6
DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLA0KPiBWRFBBX0FUVFJf
REVWX05FVF9DRkdfTUFYX1ZRUCwNCj4gPj4+Pj4gKwkJCWNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9w
YWlycykpDQo+ID4+Pj4+ICsJCXJldHVybiAtRU1TR1NJWkU7DQo+ID4+Pj4gV2UgcHJvYmFibHkg
bmVlZCB0byBjaGVjayBWSVJUSU9fTkVUX0ZfUlNTIGhlcmUuDQo+ID4+PiBZZXMuIFdpbGwgdXNl
IGl0IGluIHYyLg0KPiA+Pj4NCj4gPj4+Pj4gKwlpZiAobmxhX3B1dF91OChtc2csDQo+IFZEUEFf
QVRUUl9ERVZfTkVUX0NGR19SU1NfTUFYX0tFWV9MRU4sDQo+ID4+Pj4+ICsJCSAgICAgICBjb25m
aWctPnJzc19tYXhfa2V5X3NpemUpKQ0KPiA+Pj4+PiArCQlyZXR1cm4gLUVNU0dTSVpFOw0KPiA+
Pj4+PiArDQo+ID4+Pj4+ICsJcnNzX2ZpZWxkID0gbGUxNl90b19jcHUoY29uZmlnLT5yc3NfbWF4
X2tleV9zaXplKTsNCj4gPj4+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLA0KPiBWRFBBX0FUVFJf
REVWX05FVF9DRkdfUlNTX01BWF9JVF9MRU4sDQo+ID4+Pj4gcnNzX2ZpZWxkKSkNCj4gPj4+Pj4g
KwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCWhhc2hfdHlwZXMgPSBs
ZTMyX3RvX2NwdShjb25maWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKTsNCj4gPj4+Pj4gKwlpZiAo
bmxhX3B1dF91MzIobXNnLA0KPiBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX0hBU0hfVFlQRVMs
DQo+ID4+Pj4+ICsJCQljb25maWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKSkNCj4gPj4+Pj4gKwkJ
cmV0dXJuIC1FTVNHU0laRTsNCj4gPj4+Pj4gKwlyZXR1cm4gMDsNCj4gPj4+Pj4gK30NCj4gPj4+
Pj4gKw0KPiA+Pj4+PiArc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LA0KPiA+Pj4+PiArc3RydWN0IHNrX2J1ZmYgKm1zZykgew0KPiA+
Pj4+PiArCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcgPSB7fTsNCj4gPj4+Pj4gKw0K
PiA+Pj4+PiArCXZkZXYtPmNvbmZpZy0+Z2V0X2NvbmZpZyh2ZGV2LCAwLCAmY29uZmlnLCBzaXpl
b2YoY29uZmlnKSk7DQo+ID4+Pj4gRG8gd2UgbmVlZCB0byBzeW5jIHdpdGggb3RoZXIgcG9zc2li
bGUgZ2V0X2NvbmZpZyBjYWxscyBoZXJlPw0KPiA+Pj4gVG8gcmVhZGVycyBvZiBnZXRfY29uZmln
KCkgaXMgb2suIE5vIG5lZWQgdG8gc3luYy4NCj4gPj4+IEhvd2V2ZXIsIEkgdGhpbmsgc2V0X2Nv
bmZpZygpIGFuZCBnZXRfY29uZmlnKCkgc2hvdWxkIHN5bmMgb3RoZXJ3aXNlDQo+ID4+IGdldF9j
b25maWcgY2FuIGdldCBwYXJ0aWFsIHZhbHVlLg0KPiA+Pj4gV2lsbCBwcm9iYWJseSBoYXZlIHRv
IGFkZCB2ZHBhX2RldmljZS0+Y29uZmlnX2FjY2Vzc19sb2NrKCkuDQo+ID4+DQo+ID4+IFByb2Jh
Ymx5LiBBbmQgdGhlIHNldF9jb25maWcoKSBzaG91bGQgYmUgc3luY2hyb25pemVkIHdpdGggdGhl
DQo+ID4+IHJlcXVyZXN0IHRoYXQgY29tZXMgZnJvbSB2RFBBIGJ1cy4NCj4gPiBZZXMsIGEgcncg
c2VtYXBob3JlIGlzIGdvb2QgZW5vdWdoLg0KPiA+IERldmljZSBjb25maWcgZmllbGRzIGNhbiBi
ZSBjaGFuZ2UgZnJvbSB0aGUgZGV2aWNlIHNpZGUgYW55d2F5LCBzdWNoIGFzDQo+IGxpbmsgc3Rh
dHVzIGFueXdheS4NCj4gPiBTeW5jIHVzaW5nIGxvY2sgc2hvdWxkbuKAmXQgYmUgcHJvYmxlbS4N
Cj4gPg0KPiA+PiBUaGlzIG1ha2VzIG1lIHRoaW5rIHdoZXRoZXIgd2Ugc2hvdWxkIGdvIGJhY2sg
dG8gdHdvIHBoYXNlcyBtZXRob2QsDQo+ID4+IGNyZWF0ZSBhbmQgZW5hYmxlLg0KPiA+Pg0KPiA+
PiBUaGUgdkRQQSBkZXZpY2UgaXMgb25seSByZWdpc3RyZWQgYWZ0ZXIgZW5hYmxpbmcsIHRoZW4g
dGhlcmUncyBubw0KPiA+PiBuZWVkIHRvIHN5bmMgd2l0aCB2RFBBIGJ1cywgYW5kIG1nbXQgaXMg
bm90IGFsbG93ZWQgdG8gY2hhbmdlIGNvbmZpZw0KPiBhZnRlciBlbmFsYmluZz8NCj4gPj4NCj4g
PiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIGJlIGFibGUgdG8gZGlzYWJsZSBpdCBhcyB3ZWxsLiBE
aXNhYmxlIHNob3VsZCB0YWtlIHRoZQ0KPiBkZXZpY2Ugb2YgdGhlIGJ1cy4NCj4gPiBJIGZpbmQg
aXQgd2VpcmQgdG8gaGF2ZSB0aGlzIG1vZGVsIHRvIGxpbmdlciBhcm91bmQgdGhlIGRldmljZSB3
aXRob3V0DQo+IGFuY2hvcmluZyBvbiB0aGUgYnVzLg0KPiA+IEZvciBleGFtcGxlIGRldmljZSBp
cyBub3QgeWV0IGVuYWJsZWQsIHNvIGl0IGlzIG5vdCBhbmNob3JlZCBvbiB0aGUgYnVzLCBidXQN
Cj4gaXRzIG5hbWUgaXMgc3RpbGwgaGF2ZSB0byByZW1haW4gdW5pcXVlLg0KPiANCj4gDQo+IENh
biB3ZSBkbyBzb21lIHN5bmNob3JuaXphdGlvbiBiZXR3ZWVuIHZkcGEgZGV2aWNlIGFsbG9jYXRp
b24gYW5kIHZkcGENCj4gZGV2aWNlIHJlZ2lzdGllciB0byBzb2x2ZSB0aGUgbmFtaW5nIGlzc3Vl
Pw0KbWdtdCB0b29sIHF1ZXJ5aW5nIHRoZSBkZXZpY2UgY29uZmlnIHNwYWNlIGFmdGVyIHZkcGEg
ZGV2aWNlIGlzIGluIHVzZSBpcyByZWFsLg0KU28gSSBkb24ndCBzZWUgc29sdmluZyBpdCBhbnkg
ZGlmZmVyZW50bHkuDQoNCk5vdyB1cHBlciBsYXllcnMgb2YgdmRwYSB0byBub3QgYWNjZXNzIHRo
ZSBkZXZpY2Ugb24gdGhlIHBsYWNlZCBvbiB0aGUgdmRwYSBidXMsIGNhbiBiZSB0YWtlbiBjYXJl
IGJ5IGV4aXN0aW5nIGRyaXZlciBjb2RlIHVzaW5nDQplY2hvIDAgPiAvc3lzL2J1cy92ZHBhL2Ry
aXZlcnNfYXV0b3Byb2JlDQoNCkJ5IGRlZmF1bHQgdmRwYSBkZXZpY2UgcGxhY2VkIG9uIHRoZSBi
dXMgd29udCBiaW5kIHRvIGFueSBkcml2ZXIgKG5ldC92aG9zdCBldGMpLg0KMS4gRGVjaXNpb24g
dG8gYmluZCB0byB3aGljaCBkcml2ZXIgaXMgZG9uZSBhZnRlciBjb25maWcgb2YgdGhlIHZkcGEg
ZGV2aWNlIGlzIGRvbmUuDQoyLiBvcmNoZXN0cmF0aW9uIHN3IGRvZXMgY3JlYXRlIGFuZCBjb25m
aWcgYmVmb3JlIGl0IGJpbmRzIHRvIHRoZSByaWdodCBkcml2ZXINCjMuIHdoaWNoIGRyaXZlciB0
byBiaW5kIHRvIGRlY2lkZWQgYmFzZWQgb24gdGhlIHVzZSBjYXNlIG9mIHRoYXQgaW5kaXZpZHVh
bCB2ZHBhIGRldmljZQ0KRm9yIGV4YW1wbGUsIA0KKGEpIHZkcGEwIGJpbmRzIHRvIG5ldCBkcml2
ZXIgdG8gaGF2ZSBOZXRkZXYgZm9yIGNvbnRhaW5lcg0KKGIpIHZkcGExIGJpbmRzIHRvIHZob3N0
IGRyaXZlciB0byBtYXAgdmRwYSBkZXZpY2UgdG8gVk0NCiANCj4gPg0KPiA+IERvIHdlIGhhdmUg
dG8gYW5jaG9yIHZkcGEgZGV2aWNlIG9uIHRoZSBidXM/IENhbiB2ZHBhIGJlIGEgY2xhc3M/DQo+
IA0KPiANCj4gSSB0aGluayBub3QsIGl0J3MgYSBidXMgdGhhdCBpcyBleHBlY3RlZCB0byBiZSBi
b3VuZCB0byBkaWZmZXJlbnQgZHJpdmVyDQo+IGluc3RlYWQgb2YgYSBzdWJzeXN0ZW0uDQpZZWFo
LCBJIHJlYWxpemVkIGl0IGxhdGVseSBhZnRlciB3cml0aW5nIHRoZSBwcmV2aW91cyBlbWFpbC4N
CkxldHMgc2VlIGlmIGFib3ZlIHNjaGVtZSB3b3JrcyBvciBub3QgdG8gdXNlIGV4aXN0aW5nIGRy
aXZlcnNfYXV0b3Byb2JlIGZpbGUuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
