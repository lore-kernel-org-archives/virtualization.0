Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D301BC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 19:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C9C860B28;
	Tue, 16 Aug 2022 19:00:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C9C860B28
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=vkN+rgll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ulk52vikq2O5; Tue, 16 Aug 2022 19:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8840607F9;
	Tue, 16 Aug 2022 19:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8840607F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D11CC0032;
	Tue, 16 Aug 2022 19:00:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50803C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 19:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AA51400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 19:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AA51400E4
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=vkN+rgll
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BIziLG0TavAI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 19:00:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46B8F40119
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46B8F40119
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 19:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCwO2FERsa9rKrW35QHxmqjTlhN5hRgbwg4pXzD78fNuhjucwHOtwpQBBp3nQFdzCVx6tT4qtPkUA+4pJqdMNzgqcuKna52VP8fJwdKEc9dyBsnB4FrB59Y3NeUyCMwk34AltVwcaSuJUG86fk4AuFftaES94g+GBTVsA08nWNLxM8ifkJpDAg/d8wQc/c7cf7TwO7+Oa1oA0JveV0fiuSw43N6TQfzkKOK7G8j+Tc7Dyb15HA7iXk78dH7j+54LhKgMvQKLIVgvzyfo4bIbhHSsOQazq0HOSDD/CFoAdoyPIbh4AubjA3Ocdj8sY/G422IIYZMtkq5r9Lk3BUhjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYCpkk4eptdggb9EmA+3zJOSmFBMdBOLUcVKDdV2L5o=;
 b=RkByex1i6jAHhneScc2Fyy1OKoC3ihBJ22uKpGWpihDlT5s3Ck/8XDCOT9jBpzo5PSWYXTEmYmHEBJ/2aIKxibFhMhRU6RURITH3TYRU3GutGPDC5q0ukd7biAJOon0Bkyjwsg7Vkd431QlAu+2YZMeYBSl63LuHAo4NQA7bXGypKiWtw1Z5ErWV4GCuDchqbsXBbQYJrXiCnbkiujTXuYRU+FpFJEc6mPZX7mvp4ZK1/7X63ZiOhYaz4Ar9vU+F/hRqEsv5po1tyYer4GhzXtnfic2L/8v5TFT+ACoxR3Mf7D5ZD98nhp1ht7Zd95sBqHBfH4hKvVtJBVnFUn+RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYCpkk4eptdggb9EmA+3zJOSmFBMdBOLUcVKDdV2L5o=;
 b=vkN+rgllJLoCyMnPJr+oLJ0bLEjvYMOxYtp6bz67cWsI3J34ona3ezHMSV8IaNOBerrcTJ2idqfn4opvG2F3NckUdWPIB5aY1mlrdb1zGl4+kXsdwrFEDCs9hZY+SQoLalE40fYejTjoF3dWFtCDPvx3hIqfyEAxZSkRkCvoWdE=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by SN6PR05MB5760.namprd05.prod.outlook.com (2603:10b6:805:fb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Tue, 16 Aug
 2022 19:00:09 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::30dd:741a:330:383c]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::30dd:741a:330:383c%3]) with mapi id 15.20.5504.026; Tue, 16 Aug 2022
 19:00:08 +0000
To: Nadav Amit <namit@vmware.com>
Subject: Re: Potential deadlock in Linux VMCI driver
Thread-Topic: Potential deadlock in Linux VMCI driver
Thread-Index: AQHYsZ1L7JA7sCG910mnTNCUkan9O62x4ZKA
Date: Tue, 16 Aug 2022 19:00:08 +0000
Message-ID: <B40B28C3-3D0F-4575-9D82-BC7965652F37@vmware.com>
References: <2838F0CB-4199-444D-BCA2-39A0FCFEC4D2@vmware.com>
In-Reply-To: <2838F0CB-4199-444D-BCA2-39A0FCFEC4D2@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7625f40-9791-4086-9f0f-08da7fb98a06
x-ms-traffictypediagnostic: SN6PR05MB5760:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8+1tB5P5xl3MB+ZyvGFNaMJLpamsMHRI7vxyY/iyUOyrNrzuHywSwCgfty+eRC04yyFc0ZYHsY96l6W+X3eC/fKQ7N4meSb6tBTvGmcuKVeagacmArEKK6mH8EVNyrxeGbN9Nx/tNgUZd2fS8EOJTK8krPvSbEm1jCw7LHxcD106C4a6FMyZVZTpl7uXXe7EuSjNWiQwuOC/iuPg3wWRKr/mfunilptJe0HKdIC+e4yyeOfFIorr/y+RCyOi5f4ROz0tPom+JDyNOEQRDs68o90lbJ1tgr7do5APk+G2xKrgUQvdReg2+X68gGTFcBaOTWbstbThhsboRTQANfAZOTO3uso6JNgY41yWZO09g5lTLFsbH342Jvc46et3u06PwL2AdfdjOofWIUTtFoSqCbQnWAgWb3rUcm2NFM8v/vXi1eWQUOur5vXTdZlW4ncLwvryqpGR6EkCvvvuxN0BZlV6YhjawobsvltNzxffOx4pJRUifq7tQ2CXUqjRzRMAriorB6iD34lMWIOZwkqq5scesFFhNfMk1JDnCbXOWJxCSq8Alp/0OyvEgO8qXHIhb5XviF7fc01thuFwTXWhkZ9o4XVa2o4f5qJzz3bA9D7TfSieJs+jx+XH5wN4MyMnmzCvauEH35l9bYxX57PjRFvlAVfCmGK6oX7sRdMGvDgM0i4OO7c63c0F/5liAlSnbJD9aNgrPFp8FfZ9L+bYIW9d2r2VJ0CeU9+7tTO3zGl1528fTG2Vj7vZkvozDAuWwDz55UGLxuhcEDgWVNz4cP3UyW2+mkLjLXHlLHQv6SJJjo+ArkVKffmtI6qcQZ/z8AzSgZrlyx2mxtxnhUcuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR05MB3960.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(38100700002)(122000001)(38070700005)(5660300002)(66946007)(66556008)(66476007)(66446008)(8676002)(64756008)(76116006)(186003)(71200400001)(478600001)(2616005)(53546011)(41300700001)(6506007)(6486002)(54906003)(37006003)(6512007)(83380400001)(4326008)(6636002)(86362001)(8936002)(36756003)(6862004)(316002)(33656002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkZyQXQwWjYxMlgrejByY2hZRFNTeGt0cVFadWd6OE5pY09aV3JlRldJeHli?=
 =?utf-8?B?YjBQOGQ2RzFuSStDTmtMdUhybkQxOWhsTC9ZVTNrNXNnME0wYjQ2aHV0amxI?=
 =?utf-8?B?dk1FZGkrb2g2R1l0d1hsb042Mlh5T3FxbUxWSDgrSVlqWm5XZnZhSm84WUxH?=
 =?utf-8?B?cHMza0d2OWREeEpqWEdkUnZRSm4rNE1SajRkWU9FVFozL20xK1ZoQ2ZrNmNX?=
 =?utf-8?B?RzlLU3ZzNHBLczBadVRsNEdHb3VxL0JGdmhVTVJ3MmVoUTNESnFaNjZLckl4?=
 =?utf-8?B?d2ZLRldleGd1OStOai83MFFSNFFKaDRmc1craE93cE9QK0JyU3RqWVlJMkRm?=
 =?utf-8?B?c2VpcXVUMlR3T0c4aGRZYlZNT1pYeXY2ZjJ6NEt3S3Vaa0dNK0s5OXByQ05q?=
 =?utf-8?B?OFcrRzlRK1NkWkdFUzJsbkVjWjJKbm5WSU9JN3dZUUVoZVBlamladWYrMmkv?=
 =?utf-8?B?TlJpNS9BS3pFSzlEeVhJdmZIK280ei9Wc3hKRHBsdGU4UjFoOFU0TTdYdG9r?=
 =?utf-8?B?M1QvVEMvdHBGZG5rTVpUL2xmVnVMY3NXU2FmeC9LeUJYR3hwY2RSV1hjb3JS?=
 =?utf-8?B?TU9oOW1aRjZkNlB4SWVicWRscER6VXRKWlN4eVQ0R0lJWDd0b2FWNUNXSG13?=
 =?utf-8?B?WFVyT3RMSWlrVHhpa2ZLeGhzeFAveWNmL01HenNkNjBPSDhmdHUxYU9TRU9Y?=
 =?utf-8?B?MjJiL1dCdHFNWTMrb3JmL2xXcFZtck9acWJ1aXBQZktFMHc0Q1pFUmJiT1FE?=
 =?utf-8?B?Z0hqQWRiTzZpcmZ3Q1FOMEFvdVZkN1hoU0VQK0JENkM0UG82MFVackRaa3Ni?=
 =?utf-8?B?N1JPbnlERU9nR21uL2FJZnoxUGFIY1dpNUoxRFFkcHlyOG1FV1VJdmVTYVFx?=
 =?utf-8?B?TUFXVlJJaFJvclRseWkrMi9oZkxjZVlFeWp5aFhDQ3lPRS9UWEpqdEZYdjZP?=
 =?utf-8?B?NU5ETFY1dzB5NGpmWkJBMkswRUtFZGlzNjNQQlRjVlpBMlFlZURIeHpwenpq?=
 =?utf-8?B?OFIvYnFSS0RqOFJHam1aMWVQckxEYXgxWm9vcitUKzJEVFozeWFGVU1nMkdr?=
 =?utf-8?B?b3EvSWtlL2J0VGJDNzhJcWVNcmozNyt6Y08wUTFWak5pd3ZoV1JBLzM4Q21Q?=
 =?utf-8?B?bklIbmd4Q3JpcWpUWURjUk9zcWREUkV6V1c0QWhNMGhDZ0FyZTVCL2xJWnM0?=
 =?utf-8?B?cFowdWVpMDVLekdzNzNETE8vaE9aZWlsU2ttWGFZYnR1cGh2SThPZzdZOFFx?=
 =?utf-8?B?WVFhcUcydEFNdmtUalZnRTB1UjNoNTQvYVNoTjF1dzNLeEVqVmhCT1Q4OGlH?=
 =?utf-8?B?R3IxRVA3ZHIzQUVNTjBwdDRqL3Z6ZEFqZFA5QnZ2U2dHRER1amhzK29nSC9O?=
 =?utf-8?B?aW15QTVkeldZbDRzVEV5RWFkMkxjRkN5RUdmMUllSVpTN1NhWHVZZTRXQmdw?=
 =?utf-8?B?NHdBbUZJT1pXMlpvVkdxMVhlN2QzdmZTTjRRcS9XdkpOVCs1S1AxYUlBMGFu?=
 =?utf-8?B?RTFSQTBVMDV4UXN1eWxOcnVLcDdUQjFpWEZIZmd4QmVOZlRjMnpabWxuako5?=
 =?utf-8?B?Q2g5dHM0bnlvMzhhY0RaMlZpaDI3UlN0VWR6VlIveDF6dzNvaVZuS3VRWENr?=
 =?utf-8?B?aC81VTZJN1ZROVZnWmhpbEtPYit6c3p2L012VGhMYW9kZDJ1VnM1aVhlNGlK?=
 =?utf-8?B?QjcvUWFSemlibUVWdTRudWdOZXNyQmtQd3FUcDRLMUE4OFJOZERlQlNjSkFJ?=
 =?utf-8?B?b016VW1tYW00ZVA5d2diWTI5ckVUSlI5VjRDYm0zNlppNUhSbHo3d3VUMVky?=
 =?utf-8?B?S0J1QSt4V0xTZFhOUWRrcElYZEZha3NKNVJ3MUxxZnRxM1hVSVRPQ0Z2V29J?=
 =?utf-8?B?VHduK3Z1YkVYQWpobzJKM0l6Q2FsRE9JM2s3TkV0NnhZcWZHejlscW5PTE80?=
 =?utf-8?B?NjVicW9aaExBRjFTL1Zacjg0U3dSWkYvcnZBeHBDVm9zTFlTY2xTVVVJcGJP?=
 =?utf-8?B?RzEydU95d2xJeUF3dDRlRTFQNUlHd093VlVLM3BVRTZsSWdEUlhRbld5YTlz?=
 =?utf-8?B?RUg5ZGdsRWM1MEZpMkt3UU5uU3NaVk5JaFduRFgycjB4Z3pqZzJvWS9lRXlT?=
 =?utf-8?B?d2FhZWV2clBYc3RwWlZzMXVsZDNZNUNZQ3FRUUxVekhjc3Q2SWRyZ2RpTzNF?=
 =?utf-8?Q?J74dCeVnHjZymegf9emFMqnJ/7mMiDCtKR7+jxDzPyTN?=
Content-ID: <424565EA3F921F4ABB7FA8635541521E@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7625f40-9791-4086-9f0f-08da7fb98a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 19:00:08.7244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AR3IcXq6Jpa2Rl8Y/C/LwvUpxs/6QZ8XUOVC4g6RPcArQSRxp9bW80gSoEqe4Rr7bRZsg/1bcIo+b/pBTt1Mcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5760
Cc: "nathan@kernel.org" <nathan@kernel.org>, Bryan Tan <bryantan@vmware.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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
From: Vishnu Dasa via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Vishnu Dasa <vdasa@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

DQoNCj4gT24gQXVnIDE2LCAyMDIyLCBhdCAxMToyMyBBTSwgTmFkYXYgQW1pdCA8bmFtaXRAdm13
YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiBEdXJpbmcgbXkgZGV2ZWxvcG1lbnQsIEkgZW5hYmxlZCBz
b21lIExpbnV4IGtlcm5lbCBjaGVja2Vycywgc3BlY2lmaWNhbGx5DQo+IHRoZSDigJxzbGVlcCBp
biBhdG9taWPigJ0gY2hlY2tlci4NCj4gDQo+IEkgcmFuIGludG8gdW5yZWxhdGVkIGlzc3VlIHRo
YXQgYXBwZWFycyB0byBiZSBhIHJlc3VsdCBvZiBjb21taXQNCj4gNDYzNzEzZWI2MTY0YjYgKCJW
TUNJOiBkbWEgZGc6IGFkZCBzdXBwb3J0IGZvciBETUEgZGF0YWdyYW1zIHJlY2VpdmXigJ0pLg0K
PiBJSVVDLCB2bWNpX3JlYWRfZGF0YSgpIGNhbGxzIHdhaXRfZXZlbnQoKSwgd2hpY2ggaXMgbm90
IGFsbG93ZWQgd2hpbGUgSVJRcw0KPiBhcmUgZGlzYWJsZWQsIHdoaWNoIHRoZXkgYXJlIGR1cmlu
ZyBJUlEgaGFuZGxpbmcuDQo+IA0KPiBJIHRoaW5rICJDT05GSUdfREVCVUdfQVRPTUlDX1NMRUVQ
PXkiIGlzIHRoZSBvbmUgdGhhdCB0cmlnZ2VycyB0aGUgd2FybmluZw0KPiBiZWxvdywgd2hpY2gg
aW5kaWNhdGVzIGEgZGVhZGxvY2sgaXMgcG9zc2libGUuDQo+IA0KPiBUaGUgc3BsYXQgYmVsb3cg
KGFmdGVyIGRlY29kaW5nKSB3YXMgZXhwZXJpZW5jZWQgb24gTGludXggNS4xOS4gTGV0IG1lIGtu
b3cNCj4gaWYgeW91IG5lZWQgbWUgdG8gb3BlbiBhIGJ1ZyBpbiBidWd6aWxsYSBvciB3aGV0aGVy
IHRoaXMgaXNzdWUgaXMgYWxyZWFkeQ0KPiBrbm93bi4NCg0KTmF0aGFuIHJlcG9ydGVkIHRoaXMg
YSBmZXcgZGF5cyBhZ28sIGJ1dCB3ZSBoYXZlbid0IGdvdHRlbg0KYXJvdW5kIHRvIGl0IHlldC4g
IENvdWxkIHlvdSBwbGVhc2UgZmlsZSBhbiBpbnRlcm5hbCBidWd6aWxsYSBQUiBmb3INCnRoaXM/
DQoNCk5hdGhhbiwNClNvcnJ5IHdlIGRpZG4ndCByZXNwb25kIHRvIHlvdXIgZW1haWwuICBKb3Jn
ZW4gaXMgbm8gbG9uZ2VyIHdpdGgNClZNd2FyZSBhbmQgaXMgbm90IHdvcmtpbmcgb24gVk1DSS9W
U09DS0VUUy4gIFdlIHdpbGwgdGFrZQ0KYSBsb29rIGF0IHRoaXMuDQoNCk5hZGF2LA0KUmFqZXNo
IGlzbid0IHdpdGggVk13YXJlIG5vdyBlaXRoZXIsIHJlbW92aW5nIGhpbSBmcm9tIGNjLg0KDQo+
IFsgICAyMi42Mjk2OTFdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxp
ZCBjb250ZXh0IGF0IGRyaXZlcnMvbWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmM6MTQ1DQo+IFsg
ICAyMi42MzM4OTRdIGluX2F0b21pYygpOiAxLCBpcnFzX2Rpc2FibGVkKCk6IDAsIG5vbl9ibG9j
azogMCwgcGlkOiA3NzUsIG5hbWU6IGNsb3VkLWluaXQNCj4gWyAgIDIyLjYzODIzMl0gcHJlZW1w
dF9jb3VudDogMTAwLCBleHBlY3RlZDogMA0KPiBbICAgMjIuNjQxODg3XSBSQ1UgbmVzdCBkZXB0
aDogMCwgZXhwZWN0ZWQ6IDANCj4gWyAgIDIyLjY0NTQ2MV0gMSBsb2NrIGhlbGQgYnkgY2xvdWQt
aW5pdC83NzU6DQo+IFsgICAyMi42NDkwMTNdICMwOiBmZmZmODg4MTBlMDU3MjAwICgmdHlwZS0+
aV9tdXRleF9kaXJfa2V5IzYpeysrKyt9LXszOjN9LCBhdDogaXRlcmF0ZV9kaXIgKGZzL3JlYWRk
aXIuYzo0NikgDQo+IFsgICAyMi42NTMwMTJdIFByZWVtcHRpb24gZGlzYWJsZWQgYXQ6DQo+IFsg
ICAyMi42NTMwMTddIF9fZG9fc29mdGlycSAoa2VybmVsL3NvZnRpcnEuYzo1MDQga2VybmVsL3Nv
ZnRpcnEuYzo1NDgpIA0KPiBbICAgMjIuNjYwMjY0XSBDUFU6IDMgUElEOiA3NzUgQ29tbTogY2xv
dWQtaW5pdCBOb3QgdGFpbnRlZCA1LjE5LjArICMzDQo+IFsgICAyMi42NjQwMDRdIEhhcmR3YXJl
IG5hbWU6IFZNd2FyZSwgSW5jLiBWTXdhcmUyMCwxLzQ0MEJYIERlc2t0b3AgUmVmZXJlbmNlIFBs
YXRmb3JtLCBCSU9TIFZNVzIwMS4wMFYuMjAyNTMxOTkuQjY0LjIyMDgwODE3NDIgMDgvMDgvMjAy
Mg0KPiBbICAgMjIuNjcxNjAwXSBDYWxsIFRyYWNlOg0KPiBbICAgMjIuNjc1MTY1XSAgPElSUT4N
Cj4gWyAgIDIyLjY3ODY4MV0gZHVtcF9zdGFja19sdmwgKGxpYi9kdW1wX3N0YWNrLmM6MTA3IChk
aXNjcmltaW5hdG9yIDQpKSANCj4gWyAgIDIyLjY4MjMwM10gZHVtcF9zdGFjayAobGliL2R1bXBf
c3RhY2suYzoxMTQpIA0KPiBbICAgMjIuNjg1ODgzXSBfX21pZ2h0X3Jlc2NoZWQuY29sZCAoa2Vy
bmVsL3NjaGVkL2NvcmUuYzo5ODIyKSANCj4gWyAgIDIyLjY4OTUwMF0gX19taWdodF9zbGVlcCAo
a2VybmVsL3NjaGVkL2NvcmUuYzo5NzUxIChkaXNjcmltaW5hdG9yIDE0KSkgDQo+IFsgICAyMi42
OTI5NjFdIHZtY2lfcmVhZF9kYXRhICguL2luY2x1ZGUvbGludXgva2VybmVsLmg6MTEwIGRyaXZl
cnMvbWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmM6MTQ1KSB2bXdfdm1jaQ0KPiBbICAgMjIuNjk2
NDYxXSA/IHZtY2lfaW50ZXJydXB0X2JtIChkcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVz
dC5jOjEyMSkgdm13X3ZtY2kNCj4gWyAgIDIyLjY5OTkyMF0gPyBfX3RoaXNfY3B1X3ByZWVtcHRf
Y2hlY2sgKGxpYi9zbXBfcHJvY2Vzc29yX2lkLmM6NjcpIA0KPiBbICAgMjIuNzAzMzA1XSA/IHdh
a2VfdXBfdmFyICguL2luY2x1ZGUvbGludXgvbGlzdC5oOjI5MiAuL2luY2x1ZGUvbGludXgvd2Fp
dC5oOjEyOSBrZXJuZWwvc2NoZWQvd2FpdF9iaXQuYzoxMjUga2VybmVsL3NjaGVkL3dhaXRfYml0
LmM6MTkzKSANCj4gWyAgIDIyLjcwNjUyNl0gPyBjcHV1c2FnZV9yZWFkIChrZXJuZWwvc2NoZWQv
d2FpdF9iaXQuYzoxOTIpIA0KPiBbICAgMjIuNzA5NjgyXSA/IG1hcmtfaGVsZF9sb2NrcyAoa2Vy
bmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQyMzQpIA0KPiBbICAgMjIuNzEyNzc5XSB2bWNpX2Rpc3Bh
dGNoX2RncyAoZHJpdmVycy9taXNjL3Ztd192bWNpL3ZtY2lfZ3Vlc3QuYzozMzIpIHZtd192bWNp
DQo+IFsgICAyMi43MTU5MjNdIHRhc2tsZXRfYWN0aW9uX2NvbW1vbi5jb25zdHByb3AuMCAoa2Vy
bmVsL3NvZnRpcnEuYzo3OTkpIA0KPiBbICAgMjIuNzE5MDA4XSA/IHZtY2lfcmVhZF9kYXRhIChk
cml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVzdC5jOjMwOCkgdm13X3ZtY2kNCj4gWyAgIDIy
LjcyMjAxOF0gdGFza2xldF9hY3Rpb24gKGtlcm5lbC9zb2Z0aXJxLmM6ODE5KSANCj4gWyAgIDIy
LjcyNDg2NV0gX19kb19zb2Z0aXJxIChrZXJuZWwvc29mdGlycS5jOjU3MSkgDQo+IFsgICAyMi43
Mjc2NTBdIF9faXJxX2V4aXRfcmN1IChrZXJuZWwvc29mdGlycS5jOjQ0NSBrZXJuZWwvc29mdGly
cS5jOjY1MCkgDQo+IFsgICAyMi43MzAzNDhdIGlycV9leGl0X3JjdSAoa2VybmVsL3NvZnRpcnEu
Yzo2NjQpIA0KPiBbICAgMjIuNzMyOTQ3XSBjb21tb25faW50ZXJydXB0IChhcmNoL3g4Ni9rZXJu
ZWwvaXJxLmM6MjQwIChkaXNjcmltaW5hdG9yIDE0KSkgDQo+IFsgICAyMi43MzU1MTNdICA8L0lS
UT4NCj4gWyAgIDIyLjczNzg3OV0gIDxUQVNLPg0KPiBbICAgMjIuNzQwMTQxXSBhc21fY29tbW9u
X2ludGVycnVwdCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRyeS5oOjY0MCkgDQo+IFsg
ICAyMi43NDI0OThdIFJJUDogMDAxMDpzdGFja190cmFjZV9jb25zdW1lX2VudHJ5IChrZXJuZWwv
c3RhY2t0cmFjZS5jOjgzKSANCj4gWyAyMi43NDQ4OTFdIENvZGU6IGJlIDgwIDAxIDAwIDAwIDQ4
IGM3IGM3IDQwIDgyIGNkIDgyIDQ4IDg5IGU1IGU4IDdkIDM4IDUzIDAwIDVkIGMzIGNjIGNjIGNj
IGNjIGNjIGNjIGNjIGNjIGNjIGNjIGNjIDBmIDFmIDQ0IDAwIDAwIDU1IDQ4IDg5IGU1IDw0MT4g
NTUgNDkgODkgZjUgNDEgNTQgNTMgNDggODkgZmIgNDggODMgYzcgMTAgZTggMjMgZTAgMzYgMDAg
NDggOGQNCj4gQWxsIGNvZGUNCj4gPT09PT09PT0NCj4gICAwOgliZSA4MCAwMSAwMCAwMCAgICAg
ICAJbW92ICAgICQweDE4MCwlZXNpDQo+ICAgNToJNDggYzcgYzcgNDAgODIgY2QgODIgCW1vdiAg
ICAkMHhmZmZmZmZmZjgyY2Q4MjQwLCVyZGkNCj4gICBjOgk0OCA4OSBlNSAgICAgICAgICAgICAJ
bW92ICAgICVyc3AsJXJicA0KPiAgIGY6CWU4IDdkIDM4IDUzIDAwICAgICAgIAljYWxsICAgMHg1
MzM4OTENCj4gIDE0Ogk1ZCAgICAgICAgICAgICAgICAgICAJcG9wICAgICVyYnANCj4gIDE1Oglj
MyAgICAgICAgICAgICAgICAgICAJcmV0ICAgIA0KPiAgMTY6CWNjICAgICAgICAgICAgICAgICAg
IAlpbnQzICAgDQo+ICAxNzoJY2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCj4gIDE4Oglj
YyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KPiAgMTk6CWNjICAgICAgICAgICAgICAgICAg
IAlpbnQzICAgDQo+ICAxYToJY2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCj4gIDFiOglj
YyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KPiAgMWM6CWNjICAgICAgICAgICAgICAgICAg
IAlpbnQzICAgDQo+ICAxZDoJY2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCj4gIDFlOglj
YyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KPiAgMWY6CWNjICAgICAgICAgICAgICAgICAg
IAlpbnQzICAgDQo+ICAyMDoJY2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCj4gIDIxOgkw
ZiAxZiA0NCAwMCAwMCAgICAgICAJbm9wbCAgIDB4MCglcmF4LCVyYXgsMSkNCj4gIDI2Ogk1NSAg
ICAgICAgICAgICAgICAgICAJcHVzaCAgICVyYnANCj4gIDI3Ogk0OCA4OSBlNSAgICAgICAgICAg
ICAJbW92ICAgICVyc3AsJXJicA0KPiAgMmE6Kgk0MSA1NSAgICAgICAgICAgICAgICAJcHVzaCAg
ICVyMTMJCTwtLSB0cmFwcGluZyBpbnN0cnVjdGlvbg0KPiAgMmM6CTQ5IDg5IGY1ICAgICAgICAg
ICAgIAltb3YgICAgJXJzaSwlcjEzDQo+ICAyZjoJNDEgNTQgICAgICAgICAgICAgICAgCXB1c2gg
ICAlcjEyDQo+ICAzMToJNTMgICAgICAgICAgICAgICAgICAgCXB1c2ggICAlcmJ4DQo+ICAzMjoJ
NDggODkgZmIgICAgICAgICAgICAgCW1vdiAgICAlcmRpLCVyYngNCj4gIDM1Ogk0OCA4MyBjNyAx
MCAgICAgICAgICAJYWRkICAgICQweDEwLCVyZGkNCj4gIDM5OgllOCAyMyBlMCAzNiAwMCAgICAg
ICAJY2FsbCAgIDB4MzZlMDYxDQo+ICAzZToJNDggICAgICAgICAgICAgICAgICAgCXJleC5XDQo+
ICAzZjoJOGQgICAgICAgICAgICAgICAgICAgCS5ieXRlIDB4OGQNCj4gDQo+IENvZGUgc3RhcnRp
bmcgd2l0aCB0aGUgZmF1bHRpbmcgaW5zdHJ1Y3Rpb24NCj4gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIDA6CTQxIDU1ICAgICAgICAgICAgICAgIAlwdXNo
ICAgJXIxMw0KPiAgIDI6CTQ5IDg5IGY1ICAgICAgICAgICAgIAltb3YgICAgJXJzaSwlcjEzDQo+
ICAgNToJNDEgNTQgICAgICAgICAgICAgICAgCXB1c2ggICAlcjEyDQo+ICAgNzoJNTMgICAgICAg
ICAgICAgICAgICAgCXB1c2ggICAlcmJ4DQo+ICAgODoJNDggODkgZmIgICAgICAgICAgICAgCW1v
diAgICAlcmRpLCVyYngNCj4gICBiOgk0OCA4MyBjNyAxMCAgICAgICAgICAJYWRkICAgICQweDEw
LCVyZGkNCj4gICBmOgllOCAyMyBlMCAzNiAwMCAgICAgICAJY2FsbCAgIDB4MzZlMDM3DQo+ICAx
NDoJNDggICAgICAgICAgICAgICAgICAgCXJleC5XDQo+ICAxNToJOGQgICAgICAgICAgICAgICAg
ICAgCS5ieXRlIDB4OGQNCj4gWyAgIDIyLjc1MDM3MF0gUlNQOiAwMDE4OmZmZmY4ODgxMjUwNjc0
ZDAgRUZMQUdTOiAwMDAwMDI4Ng0KPiBbICAgMjIuNzUyOTA2XSBSQVg6IGZmZmZmZmZmODE2NzYx
NTUgUkJYOiBmZmZmZmZmZjgxMjY5NjAwIFJDWDogZmZmZmZmZmY4MTBlMjEwNg0KPiBbICAgMjIu
NzU1NTcyXSBSRFg6IGRmZmZmYzAwMDAwMDAwMDAgUlNJOiBmZmZmZmZmZjgxNjc2MTU1IFJESTog
ZmZmZjg4ODEyNTA2NzVhOA0KPiBbICAgMjIuNzU4MjE3XSBSQlA6IGZmZmY4ODgxMjUwNjc0ZDAg
UjA4OiBmZmZmZmZmZjgxMGUyMGQ0IFIwOTogZmZmZjg4ODEyZjFhNDAwMA0KPiBbICAgMjIuNzYw
ODc3XSBSMTA6IGZmZmY4ODgxMjUwNjc0ZTAgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogZmZm
Zjg4ODEyNTA2NzVhOA0KPiBbICAgMjIuNzYzNTEzXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0
OiBmZmZmODg4MTJmMWE0MDAwIFIxNTogZmZmZjg4ODEwZjMzYzE4MA0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
