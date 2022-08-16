Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C659C25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 18:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B87A7410D7;
	Tue, 16 Aug 2022 18:34:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B87A7410D7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=vMQwlK2M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DW3SMAa9BmCt; Tue, 16 Aug 2022 18:34:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D78474035F;
	Tue, 16 Aug 2022 18:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D78474035F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA39FC0032;
	Tue, 16 Aug 2022 18:34:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB18C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D833360B4B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:34:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D833360B4B
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=vMQwlK2M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q1O3mz7xE-Oa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:34:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDD1860B28
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDD1860B28
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibi9Zxwkpiop3spD4VKDpFXKFdJ/O8wOa2YutlPZUfV9942Cn59D9tcRr7iKzKAfNQwHXxn5rUSfL8d8qTKF9EiPHZDKq48Yw3Shymj37z0gYaPocIfwvzcj8uEqP16SK8CzVTxkntPDlbxLMV33gaDrKWT7MUCLyGIWAlDYjNu9xax+lXnJQirTBxwrwl+Re2E0MrGQYmkoZfuwjovbHQUShwkmumn1Hnb1zNoNwee8yAmkGjiLEGViX8WMDMyCqCk79LD0fJCC+/yIx+EQupjPHwlKI6IxnD9UzzI/aEU0QCIq8fK0l+7H0mgEUBisezLGPHKWWNLcqXcqFC84eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFrb5gzk58REfMc5zW6yZRAl0br91AANgWk/hHIa1v4=;
 b=OWp2DvrutgBFmPg/aZlHvw4QapuNy/ivROPT1KXN/pWLLEYUI2omC9dnHh3npE4UHItqPHsfMF/YnRs1bnRcI6ENSVK7AYJNlEU2Z9U21rcozO9eYBJvMkRglqyKizfCj/tI1wAKLzuKZgFP39+WSXpBv3VNK/WflmXz3lYY79OFXLr2VkAXW0OjIB3mTSKBlTp2ndLol/r4mgrMRxiYRNUZBx7mt11vhHiwwn0TjHdBAcxt9desBf6nPGxRSZ8E7sZqVNqf4XfpZ4EgF8uH0Sdp/McrVtXyHFrxk1cCOswtDPiXHDuD93/y8jVP8+1M2uPHZ16P4YiJ99iU5wJ2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFrb5gzk58REfMc5zW6yZRAl0br91AANgWk/hHIa1v4=;
 b=vMQwlK2MzCms8d62aZWS6Vt9eoeb3lXL7ssszqxkrxJY8QHCh7+NpvjTr2Som5rOK/P518KAFrANE09JdZYLYLXbqYxf/KHWDQwArihbyd/Ow1vi5suJQPkRjw0s122S6EPplprwfxd5i+ddtRGGBn7NZJNEwbUVsGhXdl68SS4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA0PR05MB7498.namprd05.prod.outlook.com (2603:10b6:806:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.6; Tue, 16 Aug
 2022 18:34:43 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5546.015; Tue, 16 Aug 2022
 18:34:43 +0000
To: Rajesh Jalisatgi <rjalisatgi@vmware.com>, Vishnu Dasa <vdasa@vmware.com>
Subject: Re: Potential deadlock in Linux VMCI driver
Thread-Topic: Potential deadlock in Linux VMCI driver
Thread-Index: AQHYsZ1LveqHoA4AFUuhkDoNsdmCqK2x2nmA
Date: Tue, 16 Aug 2022 18:34:43 +0000
Message-ID: <EC37B13A-44D5-4D9D-BBB2-D4B829B6A380@vmware.com>
References: <2838F0CB-4199-444D-BCA2-39A0FCFEC4D2@vmware.com>
In-Reply-To: <2838F0CB-4199-444D-BCA2-39A0FCFEC4D2@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456d8cc9-8cb5-45ce-163e-08da7fb5fcdf
x-ms-traffictypediagnostic: SA0PR05MB7498:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfuzDOmZAcrYVDDiivJWm/AXB3fCPUHECFO0mRiqyCbktgGnGUI6b6EXs9vof8nOAlhYjUteAosBQHGPvndqDx/yEcmo5mtIpaLsyhI5wi7QUS74CxM1HrJXsTR3kwhrmzIsS1qsKWNLf9stb6T+9xIHeQp0QR2VwdHsqNi+74/ZPc84/zNNlfhmw4VwpPC7bMiahhtRYv9JRsVCnQJeYrbAnbalL6GzQLXMO/3LM0BIjWtdvCRMZKskRWJbi/u1zo0j4FuRvNJF1+5u6y38IRAiKCbl9G8w20w7ZYOel8sxxw1yYaK/leN5wKDzibAd+9mXN+aRg8zvadXO+JsGvmIqai9DyqXRiR2Lp4YrZWZp0/LOZH+XvZNaeOBpfldlTjZyQbu+/0hJrg8CzD7mUPbErXEiKQH7+r7HEBFnYj9aNRjf2/q2ehYx8nkUqqE1TuOCKoJ66Dsb6Zxasi24t44aBuI+huY1ZXPwysfjoSfkn5iNmDAmTQNAVzkCDd+7xNQd4AP0kFCXu7//br4jbMCoAUaFwtKzmloazjFTtflXiP0gD3DIyJ8E5OCVGPHqlPNMqjVhVQGhG/1LySnVOKVDCVjBj/VLNWKCKZHHBYuW1UmMBo5SuaCcDQDFsczQhJWfrxoHXixEu0rbZxehaEsSiGIgjiNn55D+5yy3Alrdm2e5m0IXO+diB/2Ptx8CLaFHsqbEyfyKGEYQ+8fpI4b1dzKoc9jYEaQDAZ6p/3FY6NloeTGZ+YoULqcX3z6rFs/NCfp9+wMFsRuA5chzReyKljg7UMTQhwxf2Vh4kPSXdhdB6zgYyB9F44lpsyC+jkI/2HbVAqF58bKCnja6/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(6512007)(6506007)(53546011)(5660300002)(71200400001)(83380400001)(26005)(2616005)(8936002)(33656002)(36756003)(6486002)(478600001)(186003)(41300700001)(86362001)(38070700005)(316002)(6636002)(4744005)(2906002)(38100700002)(122000001)(110136005)(66446008)(76116006)(64756008)(4326008)(66556008)(66476007)(8676002)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkRMQloxZElrY09ab05lN1UwQ3MwaWpXLzJnNFUybU1FVzhSVldMNHdBZWc2?=
 =?utf-8?B?L0YraU5oVU1vZld6dU80ZWxidlhDQzcwTjdLMWlaWFFtOEhnNi9FZHpIS3F6?=
 =?utf-8?B?T3N0R3oveFgvTTdPNTRNMSs4eXdsYjZiRUkxQkdOVFF6Z0ROSjVhNWhrTGVI?=
 =?utf-8?B?WmF1cVNlUW1PSVpGSG0rWW9jeDZvWWllYzc0YUNoT3RoNTgveGZBK1BBTVh6?=
 =?utf-8?B?SXZtRndIRUlYQ25rckdpcWVHUDlaM3NnVTkyVGlDTlRsWGdJM2VCTDl6NUdK?=
 =?utf-8?B?NUVLMVQwVVZCZFh6c056ZTRicW5aUW5WMW41VWhrdHdkTUpzeDhFdlNtWUxB?=
 =?utf-8?B?UTVya0NVUUt4V3VOM1Q0bVFYWGg2a3ZyeHM3MVBuRmJNckVSRktqSTBOVDVk?=
 =?utf-8?B?aVVVcUpJLzI2Zzl3ZVByMVFtTldkWHdxMU92ZUxadUNpejlTbndwSk1kK1Yz?=
 =?utf-8?B?QzhyT3o5V3pBRElOUjZReG5iRzRFUWo5ajVXSCt5V2xxemszUm9BODlabDJV?=
 =?utf-8?B?dXUwVnlxVVhPT3VzeldJdmhLejczaHd3RGtNaUxzbXh3NVJ5Y3hYWEt4TVpE?=
 =?utf-8?B?ZzBsZmtSRUlka2FLQkZaRSt6VmFCak1OR2ZRZkRjZGtMTmJCWjBOTmxPR2Ny?=
 =?utf-8?B?WjVSZTY0Z1lWWDdlMnM3K2c2L2R5bGcweDB3R0N6NTArbDZ1WHRIejRocloy?=
 =?utf-8?B?dVkzY3N5TlNCRE5VeTNFaHRZT0hiMDRiU21jSytxWThRVk5vZlFYSEpWMkUz?=
 =?utf-8?B?U1hqY1NmODRvdnJVTW5QOHp5RnA4eUtycU1nV0xuM3YxenBSUmpVeDZ4N2xE?=
 =?utf-8?B?Yyt2T3NHYVVSU21XKzdIN1owakVKcmdtZnlFYU1PRVkyRmNrOVlDTk1QcWo2?=
 =?utf-8?B?WmRhTUdDNDRFTjV6aVpMeEJ0Q3hFUG5mMkNRcm5iOUI3SGZiQmR5ZXdtSzNo?=
 =?utf-8?B?UjU5eTlCVzYrUk9SYThXU2ZNT2V5UnQrenpzT2NZR3pJWHpNWEdNY1pXWTVs?=
 =?utf-8?B?ejUzVXhRN1FUdlVETU0rWjkzZVJZT3Y3RklLb01PQWF3cWhWa3RXeVkzMnpr?=
 =?utf-8?B?OTJvY2FMVmEvKzFHZjNndkNQSUhlUUh2RldaRXRmdTdiSXRVUlNlSjU1c0dD?=
 =?utf-8?B?NnBXK1d6UjQrTWZwYzBOcW1YK01pRXlHZk1OcHkwS3cwL0NjYzRISDVNamg4?=
 =?utf-8?B?Slc3dTU0dWE2dDBkaVJTZVVZOUZTZWw2ZEE0alFLL3ZyVzU2NmdGeUlpL09S?=
 =?utf-8?B?YWJ6WlQ0ZlkyZjA2Zkc2ZU5IRTFWZFlYdUFIdEJNeDZQU2VIQnp5ZGY2Zllz?=
 =?utf-8?B?blVoOU9sY3RRNlVYVmVndzlIbm1XQlhKV0E5Wmp1SlZQNDRHZEZ1NVVjN25E?=
 =?utf-8?B?WndTVVdPUnhNbXhwQWQ0NCtaR3pFYU9vVGN4bUQxVmZSRGVDTi96bjUxaUhX?=
 =?utf-8?B?Q3JNQVYxM01nQWd1c1pwUGF6dm1xNUxaOE5sUzlBbUNsM1lzL3B0ZExBTjBS?=
 =?utf-8?B?b1A0ZW5ET0xzZzY0VWJUSHptNTFkSksvekdxd3BtU3VPUXNHcnNJMzdMVkU4?=
 =?utf-8?B?ZVFjcTVSMENrSjkzclJ5blM1RmhyWWpKNnBUMmxwNXZwdHc0Z2JHdkJsVEJ0?=
 =?utf-8?B?RnRlbEszbzhRYlU2M1FPemtBWFA2YWRzUXlMMks3VkQ1aXpKTDk4cXlOTzJh?=
 =?utf-8?B?WllBemI1QlRyajltdS9RWWxKa2dtSGFJVG9KQXQ2ZjVnU3VXaFkrL3R4dG40?=
 =?utf-8?B?eHB3dUp1WlJCTXNSYS9VMjZTeEFFYXIzd3lORGU4QmtqZ2pRQTZkR3hRSTg0?=
 =?utf-8?B?S1hIR2k3Q0JrT3doQ3pvS2hnSWdYRnVDYWRBb2IzOW9zOTZIZnVGVmxFU0JB?=
 =?utf-8?B?M095VDZSME5MOGpaWW1NT1BtV3ZtVXJ1N1BYMlF6MmlLL2hQU1dMZlNBZ1VG?=
 =?utf-8?B?cFlieVBWQUhmSExOUWRsWklrODNMb1FTQ0k1SndWZzdDb3FURzByV1BNZTd4?=
 =?utf-8?B?MlZZWTVzUC9rWXhRRC9xOG1RakcvcDZJVzVRV2pZNnVqRml2L1BNd2EzcHJI?=
 =?utf-8?B?cHpJNGYxWTRtUWh5VmQ0R1lvNjhId2NPMEpVUkVmZUc3TUthdEl6Vml1SUlk?=
 =?utf-8?Q?NntreSkUvfSlUkKlDbbrKxNz2?=
Content-ID: <0AFFCAD6E2AC3A42BB88F59A5DDC8A36@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456d8cc9-8cb5-45ce-163e-08da7fb5fcdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 18:34:43.4008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZA1ZbPHlfSNFcjcEmtGg28hiNyu+5O5ZqPdehDwFCOWU05Zy0EPw4hUidMYWZYo1fc9six3+rL9rHlYbGRCmnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7498
Cc: Linux Virtualization <virtualization@lists.linux-foundation.org>
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
From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gQXVnIDE2LCAyMDIyLCBhdCAxMToyMyBBTSwgTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNv
bT4gd3JvdGU6DQoNCj4gRHVyaW5nIG15IGRldmVsb3BtZW50LCBJIGVuYWJsZWQgc29tZSBMaW51
eCBrZXJuZWwgY2hlY2tlcnMsIHNwZWNpZmljYWxseQ0KPiB0aGUg4oCcc2xlZXAgaW4gYXRvbWlj
4oCdIGNoZWNrZXIuDQo+IA0KPiBJIHJhbiBpbnRvIHVucmVsYXRlZCBpc3N1ZSB0aGF0IGFwcGVh
cnMgdG8gYmUgYSByZXN1bHQgb2YgY29tbWl0DQo+IDQ2MzcxM2ViNjE2NGI2ICgiVk1DSTogZG1h
IGRnOiBhZGQgc3VwcG9ydCBmb3IgRE1BIGRhdGFncmFtcyByZWNlaXZl4oCdKS4NCj4gSUlVQywg
dm1jaV9yZWFkX2RhdGEoKSBjYWxscyB3YWl0X2V2ZW50KCksIHdoaWNoIGlzIG5vdCBhbGxvd2Vk
IHdoaWxlIElSUXMNCj4gYXJlIGRpc2FibGVkLCB3aGljaCB0aGV5IGFyZSBkdXJpbmcgSVJRIGhh
bmRsaW5nLg0KDQpKdXN0IG1pbm9yIGNvcnJlY3Rpb24gb2YgbXlzZWxmOiBJUlEgYXJlIG5vdCBk
aXNhYmxlZCwgcHJlZW1wdGlvbiBpcw0KZGlzYWJsZWQuDQoNCj4gDQo+IFsgICAyMi42NTMwMTJd
IFByZWVtcHRpb24gZGlzYWJsZWQgYXQ6DQo+IFsgICAyMi42NTMwMTddIF9fZG9fc29mdGlycSAo
a2VybmVsL3NvZnRpcnEuYzo1MDQga2VybmVsL3NvZnRpcnEuYzo1NDgpIA0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
