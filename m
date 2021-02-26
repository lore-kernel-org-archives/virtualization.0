Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD53C433E0
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 05:33:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE1C64ED3
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 05:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE1C64ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33A8084250;
	Fri, 26 Feb 2021 05:33:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7F1VyHwNEv4W; Fri, 26 Feb 2021 05:33:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92B05840E0;
	Fri, 26 Feb 2021 05:32:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6209FC000E;
	Fri, 26 Feb 2021 05:32:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD406C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1DB1840E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pH8KViUf5iOd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:32:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E939E840E3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 05:32:56 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603888080000>; Thu, 25 Feb 2021 21:32:56 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 05:32:55 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 05:32:53 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.51) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS)
 id
 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 05:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO8Gde51Gsr8T9pvAVpi/9RAFNctrlTQiloLKUYGYWO+ONVnS5sYIdypoZ/2TPh4WUlGAjXB763eJs5T7271DcWk9X8Zz5Q43lWELp+tu2WUkEd/uichqLQ3gAAgEF4c2mqMAgZQXc9GBNWo9bN6Pu0M6QA2efRfhiX5CKC4En5Xih5dEX+Whf/YwCNuW/U6FWSFlbMXSWCEO+5A+rdskI3P3OZdHY5jg0bAQkXMZbrpd9rER62ik7zBJcwGC5fBZehVCs+grTookkWktzmWB2CgEQ8Q2r5fKM1jqKvrwszkQLjoPWGA73cAQNS4FRWpyatw9qmQ6TnqEbclSekDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbJmDqtwWTdoOtCctHy8vnVnsuMtCZgYXtcpTAzk5wY=;
 b=h9rulMWdBD2+ynw8xLbp60Zzft1siQI+yMj/dcfn7YuXWIEHZkKLe8uRqw0IudVhaVBmZlLI72v7wJbAfT+Cg9MFPjTyDtOKz35TDHmAsB9NeoxE7NeCbxj9adWs3syxw7fSEvMEq7qSlLc+n1Th/wiOVD2WgoHjhybLm0xTqeF5X71KCOSBWPT5DX2GLH3Neiqea2WblhVJCw+TXolF9Nq6Zdp+yQ29DFRfaeq7+bxZ6Pi7VjtgzvsTHE9N6q6APPreLO+ixwiYbfcK/hCZ+3duyehIIA3NtOutHuNngW+xfYd5fyBYrsVEdRLpPgursyhThIA+TwR57aNPe3GanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 05:32:50 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::f9f4:8fdd:8e2a:67a4%4]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 05:32:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXCnT31njXIAjUUU6IgFe+oKOVAKpm/pCAgALsxWA=
Date: Fri, 26 Feb 2021 05:32:50 +0000
Message-ID: <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
In-Reply-To: <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [122.166.131.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84628275-5987-4e16-0b33-08d8da17f544
x-ms-traffictypediagnostic: BYAPR12MB3494:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3494DDFA78A0885A2F9D80D3DC9D9@BYAPR12MB3494.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJkbHvHWKlLznBGIu5CQZdtcs7khjIwWN9oxPd5G+xdEo7M5hJftmqDIzbW9cjdcXURz/s/9PTGKRtE1NZB4es3Vn8WuOljTLubGTHX0UOmKQNmzG0t1KC7PfFohqWdRDslU1bXY0+qo8wlTHZTRw95gMwB1KN3mSPAKE2YReC97xBUp5KGxXZjpnun0YLZ5yVRzYXJHI/Rm/ReoGs3LQDYR+bRtl+7WX9PSfFAnkZFi3y7tQUsErVPea+Fh5f1xsWqUEqDvWwfBtOEo3Abos3GE7I3S1jdhJX5y3znnZupmje27zL70aB36wDEJ3eEZQTl6YM0ttaBWA0bXMwqmizQhUFaRiIo5LIF9sUI/2luknjg1dawwiITD2dVIMLGHw8594J4rDY/J5jMevdTrbcW5Hu13urLCXJlPzLbDtY78GjZTcHNNNyS6HBD8bYZSCpTtU3amikk98C8od3a+bNtyZdyZFZyI8Jaa+bF9D/D5LavSmcOfyqbHQt3AdDZr5PN+VxwFA4eeRoJooGPEBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4322.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66946007)(86362001)(6506007)(7696005)(66476007)(33656002)(66446008)(5660300002)(478600001)(186003)(64756008)(76116006)(316002)(107886003)(2906002)(53546011)(54906003)(9686003)(26005)(52536014)(55016002)(8676002)(110136005)(71200400001)(8936002)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?S0JsWVlmOFFUd3E4MmVEeWlUVDZjWEgySXc5cVltZ0NBNXkybUxoK2Fyc3lV?=
 =?utf-8?B?dEswOURLWHh4VlFGdDBtUzQ5WTk5ZHBUYkZtOVk3dFdiS1N6QkduNnp4ZGlx?=
 =?utf-8?B?L0plWWZ4REtUOGpqbWl1MjdGellHaFY1VjNTK3QwRmx4clEvSlZYakladVJG?=
 =?utf-8?B?a21wenZqcnJ3MFppUTJ1U2YwTGVSazI3THlQZnRrcGY3YnphT3kwZU9YSUFm?=
 =?utf-8?B?SW40Sy95bmFka1VzK29VbWZlemRJQXVpdE5XTnhJODFnakZQMldKOEVhNldL?=
 =?utf-8?B?dWZ3VmxEejZYbkxFMmdrTElyK0xMMzhTSGQ1RDV3R0t0a3Zmd1paVm5PL1Aw?=
 =?utf-8?B?SXIzaFNqWmZwcVV2Y28xYXhqcW1YTTJPaE51bDFHR1UvWGMraGtlNFlvSVhN?=
 =?utf-8?B?cXY3anR4NG9xUXhEdStwNzFuV3JNQ3VOVnNVbXhsNFJYQlZpWDJ5Um1iZS9I?=
 =?utf-8?B?TERIdmw2Mk5ocjhyKzQ2RkNzMTBPck8wTUpKWkhSeXkyb1d2VFdHM3Q5Wnk2?=
 =?utf-8?B?QkNOdk9YMGNxTE9BNEJXQnNaOGRWSC9ubUZBT29YOGxtWnJaY3p2b3hwRUhN?=
 =?utf-8?B?UTdaUzczWGdYZUJOYmJlaWxNK0FRQi8wb1Vuc0JFZUJyRDZ0OUJUR2MxZGRt?=
 =?utf-8?B?T2hnUlpLQUd6K2xrRDFJMXNTUHJCNitZdVVnWTBiR2pPVnVNMWdCbjBWTTVX?=
 =?utf-8?B?UGo4KzBHaTIvS21MckNHM2c3VUx5bWRnbjhDSExYdXhlVTc4OXRCSnlvZjNu?=
 =?utf-8?B?ZVB2U3ZDbjB1SHlnSWs1YlVPV1AvRVVhSWd0VHREbWRyZG5RMUxiRjVoRlJ5?=
 =?utf-8?B?YWNaYVJSbEJkZ2ZQcEVUWkVqSEYrVmR4TVBKQlhOSnVJUkRrR1NsOHhPa2kv?=
 =?utf-8?B?U3FHNDRXM3o3ZzFNTVBqTVZNK3dLTkFncmltMXNYUWwvN0l0V0tCTEhPQUhN?=
 =?utf-8?B?b1A4UHBoeDVmYWZrcTdZNE1JVDRxRGthRHRjQXBFQXMvSXZUUXk0MWhtcWpk?=
 =?utf-8?B?VEZJZDZ2Z09BRUhaWTR5SkRYUXpWcU00ZnZyZ3duaWdITjdUMUFxclhNUUM1?=
 =?utf-8?B?RmFpcFFnYm9naVhuVDBCY01DRFJ2NHQ3TzRXbzg0RmpKSEdyN01rWGhvY2d6?=
 =?utf-8?B?TXdaNURlemxTVkdvVkp4dU14c0s5L2FvNjlwenVvTjFhUitCYVduNVpHZEV4?=
 =?utf-8?B?OVVSbWR1RFlIc0dZNVI0dGdXWEhFajJDRUdNM1pjWXpVejR3a2czNDJmdWl0?=
 =?utf-8?B?cGpxNjNOaGVmMms3ODhPOHF0WHpUcWFURlVia1RvYzdmN2lIUmp0Q2syVmRh?=
 =?utf-8?B?ZmQ1M3hlZjN1eDJZbHBMbUJqS29IbTB3S1g1NFVHQUNUcU4rQ0RVeU40T1A4?=
 =?utf-8?B?dEkzU2RFcitGc3VxZ1dnVXVsNEFvQnBGUTBxelQ1anU3L1VjMGxYazIzQzdu?=
 =?utf-8?B?MnozZXJoRDNtNGJrdmZ3K21ZR01tckJKQUFtQ1ZXcG1LNDRyRzNjVEt0Y2Jm?=
 =?utf-8?B?aS9RSXFZUm9UWnR2bWF6L0VpaHJZbXBjM3VQQ000LzZBSkNXVktGSUZlUWpK?=
 =?utf-8?B?TjA1djZGRGt6d0hjSHNsMTN3bis5TUtmWVBQSEJCTXhaMVZLR3dLeGJLZzlN?=
 =?utf-8?B?d095TWU1b0hlSVhzOUhjZlhtMnB5ZHRFMy9RTlRVeWx3UGhqS1hnRmk5TTNj?=
 =?utf-8?B?bUMzT0VsOTgzeTNQMUU4dFFxSXk0bkF5Snl3MUI1K1p5Y3N3VmlydkVDeDF6?=
 =?utf-8?Q?YwHN6RFpVWQLyK6fLDZfMsYWOTdwfwPywMjnppT?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84628275-5987-4e16-0b33-08d8da17f544
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 05:32:50.5342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/ea8hn09EULLvMJfBcrxiO1h2/z5Ls/Qq1e4IPoslaOgjXXCK3FHhvQl/FH8hsvZfQEvHOx2huZ8Ha7ccz8dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3494
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614317576; bh=wbJmDqtwWTdoOtCctHy8vnVnsuMtCZgYXtcpTAzk5wY=;
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
 b=ErAsbguJSzHXvKgz14jqQUUNuBALnTIE1xP1O4+kkj2Ul9h4AGKTDa19BBhZRX+xz
 WIxeuHypU6wtmFIAOpZK+PZi0S2/um96moAQmjxOUb01XdJUYWVIAgrbm2tBhEdZud
 6UiSQJ7Yy40h81w+LiBoQ+ieQ3RydBCztVqRR8GzgEAA/lZOwHCJwxlUvGFnQoVzgg
 OFtcK69uvcI1vbbf5ileEMOepHoOB38q/TGRuL+alYedXKhpBhViX+PddC/uncFL1T
 0RvRADYz4Xmc9+OKoqEXzPcm7tSF5YFchjA9LdBXRkLQZRbhQ+rrE//IAOTZcXb1v+
 UHBZI/5opk0/g==
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAyNCwgMjAyMSAyOjE4IFBNDQo+IA0KPiBPbiAyMDIxLzIvMjQgMjox
OCDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiArDQo+ID4gKwlpZiAobmxhX3B1dF91
MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFYX1ZRUCwNCj4gPiArCQkJY29uZmlnLT5t
YXhfdmlydHF1ZXVlX3BhaXJzKSkNCj4gPiArCQlyZXR1cm4gLUVNU0dTSVpFOw0KPiANCj4gDQo+
IFdlIHByb2JhYmx5IG5lZWQgdG8gY2hlY2sgVklSVElPX05FVF9GX1JTUyBoZXJlLg0KDQpZZXMu
IFdpbGwgdXNlIGl0IGluIHYyLg0KDQo+IA0KPiANCj4gPiArCWlmIChubGFfcHV0X3U4KG1zZywg
VkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfS0VZX0xFTiwNCj4gPiArCQkgICAgICAgY29u
ZmlnLT5yc3NfbWF4X2tleV9zaXplKSkNCj4gPiArCQlyZXR1cm4gLUVNU0dTSVpFOw0KPiA+ICsN
Cj4gPiArCXJzc19maWVsZCA9IGxlMTZfdG9fY3B1KGNvbmZpZy0+cnNzX21heF9rZXlfc2l6ZSk7
DQo+ID4gKwlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01B
WF9JVF9MRU4sDQo+IHJzc19maWVsZCkpDQo+ID4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPiAr
DQo+ID4gKwloYXNoX3R5cGVzID0gbGUzMl90b19jcHUoY29uZmlnLT5zdXBwb3J0ZWRfaGFzaF90
eXBlcyk7DQo+ID4gKwlpZiAobmxhX3B1dF91MzIobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdf
UlNTX0hBU0hfVFlQRVMsDQo+ID4gKwkJCWNvbmZpZy0+c3VwcG9ydGVkX2hhc2hfdHlwZXMpKQ0K
PiA+ICsJCXJldHVybiAtRU1TR1NJWkU7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCB2ZHBhX2Rldl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LCBzdHJ1Y3QNCj4gPiArc2tfYnVmZiAqbXNnKSB7DQo+ID4gKwlzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcgY29uZmlnID0ge307DQo+ID4gKw0KPiA+ICsJdmRldi0+Y29uZmlnLT5n
ZXRfY29uZmlnKHZkZXYsIDAsICZjb25maWcsIHNpemVvZihjb25maWcpKTsNCj4gDQo+IA0KPiBE
byB3ZSBuZWVkIHRvIHN5bmMgd2l0aCBvdGhlciBwb3NzaWJsZSBnZXRfY29uZmlnIGNhbGxzIGhl
cmU/DQoNClRvIHJlYWRlcnMgb2YgZ2V0X2NvbmZpZygpIGlzIG9rLiBObyBuZWVkIHRvIHN5bmMu
DQpIb3dldmVyLCBJIHRoaW5rIHNldF9jb25maWcoKSBhbmQgZ2V0X2NvbmZpZygpIHNob3VsZCBz
eW5jIG90aGVyd2lzZSBnZXRfY29uZmlnIGNhbiBnZXQgcGFydGlhbCB2YWx1ZS4NCldpbGwgcHJv
YmFibHkgaGF2ZSB0byBhZGQgdmRwYV9kZXZpY2UtPmNvbmZpZ19hY2Nlc3NfbG9jaygpLg0KDQo+
IA0KPiANCj4gPiArCWlmIChubGFfcHV0KG1zZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FE
RFIsDQo+IHNpemVvZihjb25maWcubWFjKSwgY29uZmlnLm1hYykpDQo+ID4gKwkJcmV0dXJuIC1F
TVNHU0laRTsNCj4gPiArCWlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NU
QVRVUywgY29uZmlnLnN0YXR1cykpDQo+ID4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPiArCWlm
IChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsIGNvbmZpZy5tdHUp
KQ0KPiA+ICsJCXJldHVybiAtRU1TR1NJWkU7DQo+IA0KPiANCj4gQW5kIGNoZWNrIFZJUlRJT19O
RVRfRl9TUEVFRF9EVVBMRVguDQoNClllcywgd2lsbCBkby4NCg0KPiANCj4gDQo+ID4gKwlpZiAo
bmxhX3B1dF91MzIobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfU1BFRUQsDQo+IGNvbmZpZy5z
cGVlZCkpDQo+ID4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPiArCWlmIChubGFfcHV0X3U4KG1z
ZywgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX0RVUExFWCwNCj4gY29uZmlnLmR1cGxleCkpDQo+ID4g
KwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gdmRwYV9kZXZfbmV0X21x
X2NvbmZpZ19maWxsKHZkZXYsIG1zZywgJmNvbmZpZyk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQNCj4gPiArdmRwYV9kZXZfY29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBz
dHJ1Y3Qgc2tfYnVmZiAqbXNnLCB1MzINCj4gcG9ydGlkLCB1MzIgc2VxLA0KPiA+ICsJCSAgICAg
aW50IGZsYWdzLCBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spIHsNCj4gPiArCXUzMiBk
ZXZpY2VfaWQ7DQo+ID4gKwl2b2lkICpoZHI7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiAr
CWhkciA9IGdlbmxtc2dfcHV0KG1zZywgcG9ydGlkLCBzZXEsICZ2ZHBhX25sX2ZhbWlseSwgZmxh
Z3MsDQo+ID4gKwkJCSAgVkRQQV9DTURfREVWX0NPTkZJR19HRVQpOw0KPiA+ICsJaWYgKCFoZHIp
DQo+ID4gKwkJcmV0dXJuIC1FTVNHU0laRTsNCj4gPiArDQo+ID4gKwlpZiAobmxhX3B1dF9zdHJp
bmcobXNnLCBWRFBBX0FUVFJfREVWX05BTUUsIGRldl9uYW1lKCZ2ZGV2LQ0KPiA+ZGV2KSkpIHsN
Cj4gPiArCQllcnIgPSAtRU1TR1NJWkU7DQo+ID4gKwkJZ290byBtc2dfZXJyOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWRldmljZV9pZCA9IHZkZXYtPmNvbmZpZy0+Z2V0X2RldmljZV9pZCh2ZGV2
KTsNCj4gPiArCWlmIChubGFfcHV0X3UzMihtc2csIFZEUEFfQVRUUl9ERVZfSUQsIGRldmljZV9p
ZCkpIHsNCj4gPiArCQllcnIgPSAtRU1TR1NJWkU7DQo+ID4gKwkJZ290byBtc2dfZXJyOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCXN3aXRjaCAoZGV2aWNlX2lkKSB7DQo+ID4gKwljYXNlIFZJUlRJ
T19JRF9ORVQ6DQo+ID4gKwkJZXJyID0gdmRwYV9kZXZfbmV0X2NvbmZpZ19maWxsKHZkZXYsIG1z
Zyk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwlkZWZhdWx0Og0KPiA+ICsJCWVyciA9IC1FT1BOT1RT
VVBQOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlnb3Rv
IG1zZ19lcnI7DQo+ID4gKw0KPiA+ICsJZ2VubG1zZ19lbmQobXNnLCBoZHIpOw0KPiA+ICsJcmV0
dXJuIDA7DQo+ID4gKw0KPiA+ICttc2dfZXJyOg0KPiA+ICsJZ2VubG1zZ19jYW5jZWwobXNnLCBo
ZHIpOw0KPiA+ICsJcmV0dXJuIGVycjsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCB2
ZHBhX25sX2NtZF9kZXZfY29uZmlnX2dldF9kb2l0KHN0cnVjdCBza19idWZmICpza2IsDQo+ID4g
K3N0cnVjdCBnZW5sX2luZm8gKmluZm8pIHsNCj4gPiArCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRl
djsNCj4gPiArCXN0cnVjdCBza19idWZmICptc2c7DQo+ID4gKwljb25zdCBjaGFyICpkZXZuYW1l
Ow0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4g
KwlpZiAoIWluZm8tPmF0dHJzW1ZEUEFfQVRUUl9ERVZfTkFNRV0pDQo+ID4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ID4gKwlkZXZuYW1lID0gbmxhX2RhdGEoaW5mby0+YXR0cnNbVkRQQV9BVFRSX0RF
Vl9OQU1FXSk7DQo+ID4gKwltc2cgPSBubG1zZ19uZXcoTkxNU0dfREVGQVVMVF9TSVpFLCBHRlBf
S0VSTkVMKTsNCj4gPiArCWlmICghbXNnKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsN
Cj4gPiArCW11dGV4X2xvY2soJnZkcGFfZGV2X211dGV4KTsNCj4gPiArCWRldiA9IGJ1c19maW5k
X2RldmljZSgmdmRwYV9idXMsIE5VTEwsIGRldm5hbWUsDQo+IHZkcGFfbmFtZV9tYXRjaCk7DQo+
ID4gKwlpZiAoIWRldikgew0KPiA+ICsJCU5MX1NFVF9FUlJfTVNHX01PRChpbmZvLT5leHRhY2ss
ICJkZXZpY2Ugbm90IGZvdW5kIik7DQo+ID4gKwkJZXJyID0gLUVOT0RFVjsNCj4gPiArCQlnb3Rv
IGRldl9lcnI7DQo+ID4gKwl9DQo+ID4gKwl2ZGV2ID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0
IHZkcGFfZGV2aWNlLCBkZXYpOw0KPiA+ICsJaWYgKCF2ZGV2LT5tZGV2KSB7DQo+ID4gKwkJTkxf
U0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgInVubWFuYWdlZCB2ZHBhDQo+IGRldmljZSIp
Ow0KPiA+ICsJCWVyciA9IC1FSU5WQUw7DQo+ID4gKwkJZ290byBtZGV2X2VycjsNCj4gPiArCX0N
Cj4gDQo+IA0KPiBUaG91Z2ggaXQncyBmaW5lIGJ1dCBpdCBsb29rcyB0byBtZSBtZGV2IGlzIG5v
dCByZXF1aXJlZCB0byB3b3JrIGhlcmUuDQo+IA0KWWVzLCBtZGV2IGlzIG5vdCByZXF1aXJlZCBo
ZXJlLiBIb3dldmVyIGl0IHdhcyBsaXR0bGUgd2VpcmQgdG8gYWxsb3cgJCB2ZHBhIGRldiBjb25m
aWcgc2hvdywgYnV0IG5vdCBhbGxvdyAkIHZkcGEgZGV2IHNob3cuDQpJdCB0cmFuc2l0aW9uIHBo
YXNlIHJpZ2h0IG5vdy4gU3Vic2VxdWVudGx5IHdpbGwgYWJsZSB0byBhbGxvdyB0aGlzIGFzIHdl
bGwuDQpBZnRlciB0aGlzIHNlcmllcyBvbmx5IGlmYyBkcml2ZXIgd2lsbCBiZSBsZWZ0IHRvIGNv
bnZlcnQgdG8gdXNlciBjcmVhdGVkIGRldmljZXMuDQpBdCB0aGF0IHBvaW50LCB0aGlzIGNoZWNr
cyB3aWxsIGhhdmUgY2hhbmNlIHRvIHNpbXBsaWZ5Lg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
