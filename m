Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A219EC25B0E
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 18:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C94660B5E;
	Tue, 16 Aug 2022 18:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C94660B5E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256 header.s=selector2 header.b=O/mlzBTq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtP_580ZGi03; Tue, 16 Aug 2022 18:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6C16A60AB9;
	Tue, 16 Aug 2022 18:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C16A60AB9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F458C0032;
	Tue, 16 Aug 2022 18:23:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE177C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD555410AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD555410AB
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=vmware.com header.i=@vmware.com header.a=rsa-sha256
 header.s=selector2 header.b=O/mlzBTq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bEKTLVOBrHu2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:23:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1853409FD
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D1853409FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 18:23:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIz3qaMSxs9kXlBSfCoQNbQ8Wg1u+eonBWCL4BIIU7AP7aa9vWUvdz58Qao17i6OkucruM9oNn7I3BLuTPlE3SqaBS3lYm25gewNHHYuUuymWREX2+KXe4SSvazoceOodSrGbUFW3KoysL6Xl1yQsw47U5mtB2tjIDD84T3mXjdynlimXSIHggOzCeAZF1kqTPmZEx23KPDpJ+sIm9EIqUjcHPOstBxIJ24luuJ4dYOazyHb56VmGXLwBnnzx4hiVBfvRAGWdNDqofGbXMGP6jdPX5V/hhdW5jQvw+Cf+rMC48U2X6BDt1ckV0BwyWdAotB//VahLHmS0/9NuKzkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efGeDvTVpCLTcm1+Qj1xZzwzMlT3Ydfrla/O6rQ07wA=;
 b=WT95DpCE+vPyx9Mp/y7CorIYbTiqR2zlgk2QhnL8okfKBLFjL7VbuhyBYIJxVJpJLqlkHwKDIvax0syQJKF/+U7fKGZ/2s9pIOmIfdycXqEr09+6mwqWyLPaVW5grZxO54PHaknJrqha5XQCMxTBtsoZNRJxnSGvaH/ksBuy5j6R3GMyoe5L+ottOe1qa9tNdFIeV9Ee1bFNl0KuB2Bm6KHjxOWYPln0nMzuNo5mQJlyi7Lx1LbRc+4wfUr5Wa85osHUw17f+Ct8NoyAg+72CSJphRXymzAPoYpc5C6e4dFYd2GwT1KM/c0U/PjHT6DFZolkszmeeBtfowMYNapnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efGeDvTVpCLTcm1+Qj1xZzwzMlT3Ydfrla/O6rQ07wA=;
 b=O/mlzBTq4sS9OGg34SITLOdjaRdixUL2x4f8a8EcOaG1paPDhV1aqqArwzUkttLkWzZQpkk6RXe6bbFX5ytYgxzait5VMQ31d3GQZ6UU1NTOOP7ryzptBq/xFWpyr544dEyvIt0zlp0pr6zEzO55UmTuvoRpUnSK+iVA3bGpMSU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR05MB3530.namprd05.prod.outlook.com (2603:10b6:4:41::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.14; Tue, 16 Aug
 2022 18:23:34 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::d813:9300:4877:39d0%8]) with mapi id 15.20.5546.015; Tue, 16 Aug 2022
 18:23:34 +0000
To: Rajesh Jalisatgi <rjalisatgi@vmware.com>, Vishnu Dasa <vdasa@vmware.com>
Subject: Potential deadlock in Linux VMCI driver
Thread-Topic: Potential deadlock in Linux VMCI driver
Thread-Index: AQHYsZ1L7JA7sCG910mnTNCUkan9Ow==
Date: Tue, 16 Aug 2022 18:23:34 +0000
Message-ID: <2838F0CB-4199-444D-BCA2-39A0FCFEC4D2@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80d50057-3dae-4978-e44c-08da7fb46e3a
x-ms-traffictypediagnostic: DM5PR05MB3530:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFF4Apg1dc5dU5q2scvUyW4KVnBTmWjwu8JUOoRNccGGqH/qL1LAY0xxeL0BPFBiZ/hsp68DsJRm8tnSehmSjGSEn7mt5D05HfCxIDPHeqP8Cgn5K1FmT2N5ceztL55KcTxOPa2p0/rxG8qMaz1H1tOUI97Ew98dEKtIAFdndjKxQ72wGGYoDiXZOynfGta/7Fzo+2DkGCIOcr74HauqnxBWDmbvwm5N/LxHHboPI+uJRpNnItMGAuc5RziuW9GIvMdlTjTW+BqO3C/Z9EhjhTyWpUCYMUTGyIeaBaQqNVGENa7x1aUdzNBRgpW3XDJdumFNPKx6YeGAGoyIYqUd9TKiUT/ly9U63WGKsiX/93exDyqX5zlghjNOntgOq1G3aEpK8HN+X46Khdk6cfYCLfGB1zYzdNtxvVVG05N/g0Rl4B6/1yM+GjIr2MAF5pVSWVA2g9KwxPCSAsMMQBAXSn2Xm33pYsPCyvShYkAkqYkzulhFB6pu2+xxDlB4haLkpQNuPVZamFJPFP1CnZSur7QqJWVNdPkdFY+arOvrQOZmgRWMhwv9JPmSCZVZjIOOZ+bq7k2lpj+YVo+gZUA8EikAm37W+qQ9Gs5Qxe5wKhELys52lq1JDUfU2O4TeSim5PAozURKGPIjVefa5UkpGjRXiDT0XGj/bt6ZfMnCUTQXH7XWBOHBk1/T30E6+INKmbKuU1hd+/Fta3Z3UJRKZ+acuNO24yZC0uoObyji0Rc3GY5RZ9xIGrzG0cuaJb9nS53vwXYOO0o4aAr+QlH5xu720RH01UNun9yAe05qnnB1ly63GtvCS12LAMdZu8C1DLHiRAPfKzqs+t47Gf8vvA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR05MB8531.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(8936002)(66556008)(6636002)(66476007)(64756008)(38070700005)(8676002)(110136005)(4326008)(66946007)(122000001)(76116006)(478600001)(86362001)(36756003)(41300700001)(38100700002)(66446008)(316002)(5660300002)(6486002)(26005)(6512007)(186003)(83380400001)(71200400001)(6506007)(2616005)(33656002)(2906002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVFNL0NvbkY5QUxJcW9GWGJBbExiMXZ1WXQ4eDhQZHRGZlRPZmV3OENMdkdz?=
 =?utf-8?B?N0xmK1FxMThJaFBIZjlMYkdDUWY0VmtkMWdvN3JkVG53L1dwTzVSZnpTS21j?=
 =?utf-8?B?bllJWTBNM2FtWG42WFV2SjFaVjBEdDBPYXFKVkcxdXQvb2pVd044ZVcwOEVi?=
 =?utf-8?B?YklpamNBQnJCVUxTRC9VdXJ4TjNyV1FHdStZWjNBK01DRlZOMVZoNjRVVG0z?=
 =?utf-8?B?bG5vME5VNk83Mi90MjV0VHBKWHMrY3E4NTdRSEVCek9ya2duT1hkU2U0OUNr?=
 =?utf-8?B?ME0zZzZKbkJPQUt3TTA4UjN4OUg1aUxkcm5qeDNrRndlY2syM29hbTQxY3Zj?=
 =?utf-8?B?WEJsQVI3dXdRNDVBa3pMQnNSdURLZXFaU0RtQ0x4SzVJN0JJRDZWWkhKZEpj?=
 =?utf-8?B?L01oWktpUzJTQVZ5cnNUclBpemJLY3NUeE5GVjBVVmFibklSNURCT1BvUWNQ?=
 =?utf-8?B?T3ZuaXhPUWJmeXB6bzBsRU41ckMrOU9IcWMwcXBHZkJUUGdBd3NkbElPaDFi?=
 =?utf-8?B?cEF5cDlZWS8ycE90dk9zYmZLMFEyM1lWbTRITzB5MWdLSmpzODFmK0hUcElH?=
 =?utf-8?B?SzhHYmx2NWVwbEJYME92aHZlcjV0NmRmWFlFUkFCdnJNYmZkc2pmSXNBeGZ3?=
 =?utf-8?B?dU1XM1h2TTF6N251OC9UMVJmTlRkSFJ1RWlMZ2JvRVdNVVd6cDZvMnNWRFRD?=
 =?utf-8?B?MWtpWTZRamdwRzNObzBnSC9EejJYS3kxcVdUdEJ2MW91WHpxODIvUVRhdjJE?=
 =?utf-8?B?TlNOZFRWSnE1VXFNc0F2TmhtSFMwVzlaczVPc1dMSVA1RVp5QWxjM3FQUHpi?=
 =?utf-8?B?M0x0NVZZNWY2TXFkTFc1d012TFRmVGsrOUM5ZW1DWXQrVHVaNXFqSGE0QU1O?=
 =?utf-8?B?c0lTQjk5TU9xNDNGeTZod2kxWnl0OVFHYlNpK3hHUGcwUTBWcmVKTVF5enhH?=
 =?utf-8?B?dkt4NDdzdEdYZzdZTXlsSkpheXU4UHVuY0F5cURnRE1aT1h5Z1ErQmVodmo5?=
 =?utf-8?B?Yk9JaTR4Q2V6dEZjOE51OEozNXBONVg3OWp4Y2R3YzlMUGxyaDVIeWJ1bHJD?=
 =?utf-8?B?b1grM040WHJFUFhWNk5JV0dGOHAwQm9CeXI1OGJ5RVN0ZmFnOHpZaWVFdllx?=
 =?utf-8?B?SU9UNDRuQ3lRM0VHcEV1S05kUmIrdVNYOUd1TVRQL1dwY0tPNjl6UlM2OURE?=
 =?utf-8?B?S1VIREhuOUl4OHBrUlFjNCtDQ2pad0lQbGlzU0U2Q3N4Z2RDWVVrYmQwQ2pi?=
 =?utf-8?B?VWpmVXA5Z3dqelJMbllsMGRGKzZzTzJ0ZXB4WEtvcUYrLzUyZjM4SDV1blIw?=
 =?utf-8?B?ZGk1bDhBUG0xNzBndzdXVzcxM0x5Z29JWHVjczh1Q3ZUbVJndGlFVk9wK1Jl?=
 =?utf-8?B?Mm5OWTVsTW45VmdXVkNSRit1T0poK1lneGdIUmxTdzVmWUdXUXlNYWZzUkd2?=
 =?utf-8?B?MjBkUDhyblNaVE5FQUZnT2EzcDNyc3hZZXc5aHNvVnd5R216TWhZWi91Vmdi?=
 =?utf-8?B?R2JXd1k0YzcveUlpclJHejBCY1ZWZmFieE4wZG0waFZtYW1xc3lDTGpjdTJN?=
 =?utf-8?B?NXVKVllRaURJMXJTaG4rTWRrWWc2dnpnVW1IUUNzNUI3eTJpajFLQ0JvUlNk?=
 =?utf-8?B?ejZRZEdTdUNFUmJhZzNyM1Q3QUJUeTFJb25XN0tmVDNOTTYzQzB3RWxPNzY5?=
 =?utf-8?B?THVZUkU1N2NLWTFCRS90KzhDbThxQ3ljeFFZd1BTS2Z2WHBPRHphUUFjSTZZ?=
 =?utf-8?B?NEUzVkNWVUNSVk1hOXB0eEI5dEhRUnErenpqMDB5LzJ3VEFQNHp3b25MaTZ0?=
 =?utf-8?B?Nlp4Ukd3SkJLNHFRYU9lamxjSE1wcEVlWDV2NHVSYXhRaXBoaGhiVFlTaTRP?=
 =?utf-8?B?RGVHZjRETVlhYXZxVHdkUWoyQVhMSUI1eDViM2Yzem5CWkV0RktBYWY1ZXVn?=
 =?utf-8?B?bVpXZnZwQVhkeEUyN3RxVlpmUE5XQTdiMVhlcjNnanhGcmRMUHkvYzlMNm5u?=
 =?utf-8?B?M0tPWXhCMGYydlZaVGk4UCtWVVZEZ3lEVFhTYzlnWFNZTkc3WkI2S0VoS3hR?=
 =?utf-8?B?dFlFVnpobDhtZENMQ0NMRmtOVkwvbDVtSDlYNUV0MWEwVHpROWhjYnprYVpZ?=
 =?utf-8?Q?4lpKMko2P15EE1tCtUC/CSrgg?=
Content-ID: <C617B9CA96755A41B7BB8A196BD3C837@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d50057-3dae-4978-e44c-08da7fb46e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 18:23:34.6228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HvJ7VewGnx8c/h8NA4jPvVyYnRBkt5y1+HTaqxNnciCiNYVSP1Hf3eraksbjEM0uAJ1c+0plXz2Q+uf+cdUlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3530
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

RHVyaW5nIG15IGRldmVsb3BtZW50LCBJIGVuYWJsZWQgc29tZSBMaW51eCBrZXJuZWwgY2hlY2tl
cnMsIHNwZWNpZmljYWxseQ0KdGhlIOKAnHNsZWVwIGluIGF0b21pY+KAnSBjaGVja2VyLg0KDQpJ
IHJhbiBpbnRvIHVucmVsYXRlZCBpc3N1ZSB0aGF0IGFwcGVhcnMgdG8gYmUgYSByZXN1bHQgb2Yg
Y29tbWl0DQo0NjM3MTNlYjYxNjRiNiAoIlZNQ0k6IGRtYSBkZzogYWRkIHN1cHBvcnQgZm9yIERN
QSBkYXRhZ3JhbXMgcmVjZWl2ZeKAnSkuDQpJSVVDLCB2bWNpX3JlYWRfZGF0YSgpIGNhbGxzIHdh
aXRfZXZlbnQoKSwgd2hpY2ggaXMgbm90IGFsbG93ZWQgd2hpbGUgSVJRcw0KYXJlIGRpc2FibGVk
LCB3aGljaCB0aGV5IGFyZSBkdXJpbmcgSVJRIGhhbmRsaW5nLg0KDQpJIHRoaW5rICJDT05GSUdf
REVCVUdfQVRPTUlDX1NMRUVQPXkiIGlzIHRoZSBvbmUgdGhhdCB0cmlnZ2VycyB0aGUgd2Fybmlu
Zw0KYmVsb3csIHdoaWNoIGluZGljYXRlcyBhIGRlYWRsb2NrIGlzIHBvc3NpYmxlLg0KDQpUaGUg
c3BsYXQgYmVsb3cgKGFmdGVyIGRlY29kaW5nKSB3YXMgZXhwZXJpZW5jZWQgb24gTGludXggNS4x
OS4gTGV0IG1lIGtub3cNCmlmIHlvdSBuZWVkIG1lIHRvIG9wZW4gYSBidWcgaW4gYnVnemlsbGEg
b3Igd2hldGhlciB0aGlzIGlzc3VlIGlzIGFscmVhZHkNCmtub3duLg0KDQoNClsgICAyMi42Mjk2
OTFdIEJVRzogc2xlZXBpbmcgZnVuY3Rpb24gY2FsbGVkIGZyb20gaW52YWxpZCBjb250ZXh0IGF0
IGRyaXZlcnMvbWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmM6MTQ1DQpbICAgMjIuNjMzODk0XSBp
bl9hdG9taWMoKTogMSwgaXJxc19kaXNhYmxlZCgpOiAwLCBub25fYmxvY2s6IDAsIHBpZDogNzc1
LCBuYW1lOiBjbG91ZC1pbml0DQpbICAgMjIuNjM4MjMyXSBwcmVlbXB0X2NvdW50OiAxMDAsIGV4
cGVjdGVkOiAwDQpbICAgMjIuNjQxODg3XSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDAN
ClsgICAyMi42NDU0NjFdIDEgbG9jayBoZWxkIGJ5IGNsb3VkLWluaXQvNzc1Og0KWyAgIDIyLjY0
OTAxM10gIzA6IGZmZmY4ODgxMGUwNTcyMDAgKCZ0eXBlLT5pX211dGV4X2Rpcl9rZXkjNil7Kysr
K30tezM6M30sIGF0OiBpdGVyYXRlX2RpciAoZnMvcmVhZGRpci5jOjQ2KSANClsgICAyMi42NTMw
MTJdIFByZWVtcHRpb24gZGlzYWJsZWQgYXQ6DQpbICAgMjIuNjUzMDE3XSBfX2RvX3NvZnRpcnEg
KGtlcm5lbC9zb2Z0aXJxLmM6NTA0IGtlcm5lbC9zb2Z0aXJxLmM6NTQ4KSANClsgICAyMi42NjAy
NjRdIENQVTogMyBQSUQ6IDc3NSBDb21tOiBjbG91ZC1pbml0IE5vdCB0YWludGVkIDUuMTkuMCsg
IzMNClsgICAyMi42NjQwMDRdIEhhcmR3YXJlIG5hbWU6IFZNd2FyZSwgSW5jLiBWTXdhcmUyMCwx
LzQ0MEJYIERlc2t0b3AgUmVmZXJlbmNlIFBsYXRmb3JtLCBCSU9TIFZNVzIwMS4wMFYuMjAyNTMx
OTkuQjY0LjIyMDgwODE3NDIgMDgvMDgvMjAyMg0KWyAgIDIyLjY3MTYwMF0gQ2FsbCBUcmFjZToN
ClsgICAyMi42NzUxNjVdICA8SVJRPg0KWyAgIDIyLjY3ODY4MV0gZHVtcF9zdGFja19sdmwgKGxp
Yi9kdW1wX3N0YWNrLmM6MTA3IChkaXNjcmltaW5hdG9yIDQpKSANClsgICAyMi42ODIzMDNdIGR1
bXBfc3RhY2sgKGxpYi9kdW1wX3N0YWNrLmM6MTE0KSANClsgICAyMi42ODU4ODNdIF9fbWlnaHRf
cmVzY2hlZC5jb2xkIChrZXJuZWwvc2NoZWQvY29yZS5jOjk4MjIpIA0KWyAgIDIyLjY4OTUwMF0g
X19taWdodF9zbGVlcCAoa2VybmVsL3NjaGVkL2NvcmUuYzo5NzUxIChkaXNjcmltaW5hdG9yIDE0
KSkgDQpbICAgMjIuNjkyOTYxXSB2bWNpX3JlYWRfZGF0YSAoLi9pbmNsdWRlL2xpbnV4L2tlcm5l
bC5oOjExMCBkcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVzdC5jOjE0NSkgdm13X3ZtY2kN
ClsgICAyMi42OTY0NjFdID8gdm1jaV9pbnRlcnJ1cHRfYm0gKGRyaXZlcnMvbWlzYy92bXdfdm1j
aS92bWNpX2d1ZXN0LmM6MTIxKSB2bXdfdm1jaQ0KWyAgIDIyLjY5OTkyMF0gPyBfX3RoaXNfY3B1
X3ByZWVtcHRfY2hlY2sgKGxpYi9zbXBfcHJvY2Vzc29yX2lkLmM6NjcpIA0KWyAgIDIyLjcwMzMw
NV0gPyB3YWtlX3VwX3ZhciAoLi9pbmNsdWRlL2xpbnV4L2xpc3QuaDoyOTIgLi9pbmNsdWRlL2xp
bnV4L3dhaXQuaDoxMjkga2VybmVsL3NjaGVkL3dhaXRfYml0LmM6MTI1IGtlcm5lbC9zY2hlZC93
YWl0X2JpdC5jOjE5MykgDQpbICAgMjIuNzA2NTI2XSA/IGNwdXVzYWdlX3JlYWQgKGtlcm5lbC9z
Y2hlZC93YWl0X2JpdC5jOjE5MikgDQpbICAgMjIuNzA5NjgyXSA/IG1hcmtfaGVsZF9sb2NrcyAo
a2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jOjQyMzQpIA0KWyAgIDIyLjcxMjc3OV0gdm1jaV9kaXNw
YXRjaF9kZ3MgKGRyaXZlcnMvbWlzYy92bXdfdm1jaS92bWNpX2d1ZXN0LmM6MzMyKSB2bXdfdm1j
aQ0KWyAgIDIyLjcxNTkyM10gdGFza2xldF9hY3Rpb25fY29tbW9uLmNvbnN0cHJvcC4wIChrZXJu
ZWwvc29mdGlycS5jOjc5OSkgDQpbICAgMjIuNzE5MDA4XSA/IHZtY2lfcmVhZF9kYXRhIChkcml2
ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9ndWVzdC5jOjMwOCkgdm13X3ZtY2kNClsgICAyMi43MjIw
MThdIHRhc2tsZXRfYWN0aW9uIChrZXJuZWwvc29mdGlycS5jOjgxOSkgDQpbICAgMjIuNzI0ODY1
XSBfX2RvX3NvZnRpcnEgKGtlcm5lbC9zb2Z0aXJxLmM6NTcxKSANClsgICAyMi43Mjc2NTBdIF9f
aXJxX2V4aXRfcmN1IChrZXJuZWwvc29mdGlycS5jOjQ0NSBrZXJuZWwvc29mdGlycS5jOjY1MCkg
DQpbICAgMjIuNzMwMzQ4XSBpcnFfZXhpdF9yY3UgKGtlcm5lbC9zb2Z0aXJxLmM6NjY0KSANClsg
ICAyMi43MzI5NDddIGNvbW1vbl9pbnRlcnJ1cHQgKGFyY2gveDg2L2tlcm5lbC9pcnEuYzoyNDAg
KGRpc2NyaW1pbmF0b3IgMTQpKSANClsgICAyMi43MzU1MTNdICA8L0lSUT4NClsgICAyMi43Mzc4
NzldICA8VEFTSz4NClsgICAyMi43NDAxNDFdIGFzbV9jb21tb25faW50ZXJydXB0ICguL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2lkdGVudHJ5Lmg6NjQwKSANClsgICAyMi43NDI0OThdIFJJUDogMDAx
MDpzdGFja190cmFjZV9jb25zdW1lX2VudHJ5IChrZXJuZWwvc3RhY2t0cmFjZS5jOjgzKSANClsg
MjIuNzQ0ODkxXSBDb2RlOiBiZSA4MCAwMSAwMCAwMCA0OCBjNyBjNyA0MCA4MiBjZCA4MiA0OCA4
OSBlNSBlOCA3ZCAzOCA1MyAwMCA1ZCBjMyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBjYyBj
YyAwZiAxZiA0NCAwMCAwMCA1NSA0OCA4OSBlNSA8NDE+IDU1IDQ5IDg5IGY1IDQxIDU0IDUzIDQ4
IDg5IGZiIDQ4IDgzIGM3IDEwIGU4IDIzIGUwIDM2IDAwIDQ4IDhkDQpBbGwgY29kZQ0KPT09PT09
PT0NCiAgIDA6CWJlIDgwIDAxIDAwIDAwICAgICAgIAltb3YgICAgJDB4MTgwLCVlc2kNCiAgIDU6
CTQ4IGM3IGM3IDQwIDgyIGNkIDgyIAltb3YgICAgJDB4ZmZmZmZmZmY4MmNkODI0MCwlcmRpDQog
ICBjOgk0OCA4OSBlNSAgICAgICAgICAgICAJbW92ICAgICVyc3AsJXJicA0KICAgZjoJZTggN2Qg
MzggNTMgMDAgICAgICAgCWNhbGwgICAweDUzMzg5MQ0KICAxNDoJNWQgICAgICAgICAgICAgICAg
ICAgCXBvcCAgICAlcmJwDQogIDE1OgljMyAgICAgICAgICAgICAgICAgICAJcmV0ICAgIA0KICAx
NjoJY2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCiAgMTc6CWNjICAgICAgICAgICAgICAg
ICAgIAlpbnQzICAgDQogIDE4OgljYyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KICAxOToJ
Y2MgICAgICAgICAgICAgICAgICAgCWludDMgICANCiAgMWE6CWNjICAgICAgICAgICAgICAgICAg
IAlpbnQzICAgDQogIDFiOgljYyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KICAxYzoJY2Mg
ICAgICAgICAgICAgICAgICAgCWludDMgICANCiAgMWQ6CWNjICAgICAgICAgICAgICAgICAgIAlp
bnQzICAgDQogIDFlOgljYyAgICAgICAgICAgICAgICAgICAJaW50MyAgIA0KICAxZjoJY2MgICAg
ICAgICAgICAgICAgICAgCWludDMgICANCiAgMjA6CWNjICAgICAgICAgICAgICAgICAgIAlpbnQz
ICAgDQogIDIxOgkwZiAxZiA0NCAwMCAwMCAgICAgICAJbm9wbCAgIDB4MCglcmF4LCVyYXgsMSkN
CiAgMjY6CTU1ICAgICAgICAgICAgICAgICAgIAlwdXNoICAgJXJicA0KICAyNzoJNDggODkgZTUg
ICAgICAgICAgICAgCW1vdiAgICAlcnNwLCVyYnANCiAgMmE6Kgk0MSA1NSAgICAgICAgICAgICAg
ICAJcHVzaCAgICVyMTMJCTwtLSB0cmFwcGluZyBpbnN0cnVjdGlvbg0KICAyYzoJNDkgODkgZjUg
ICAgICAgICAgICAgCW1vdiAgICAlcnNpLCVyMTMNCiAgMmY6CTQxIDU0ICAgICAgICAgICAgICAg
IAlwdXNoICAgJXIxMg0KICAzMToJNTMgICAgICAgICAgICAgICAgICAgCXB1c2ggICAlcmJ4DQog
IDMyOgk0OCA4OSBmYiAgICAgICAgICAgICAJbW92ICAgICVyZGksJXJieA0KICAzNToJNDggODMg
YzcgMTAgICAgICAgICAgCWFkZCAgICAkMHgxMCwlcmRpDQogIDM5OgllOCAyMyBlMCAzNiAwMCAg
ICAgICAJY2FsbCAgIDB4MzZlMDYxDQogIDNlOgk0OCAgICAgICAgICAgICAgICAgICAJcmV4LlcN
CiAgM2Y6CThkICAgICAgICAgICAgICAgICAgIAkuYnl0ZSAweDhkDQoNCkNvZGUgc3RhcnRpbmcg
d2l0aCB0aGUgZmF1bHRpbmcgaW5zdHJ1Y3Rpb24NCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCiAgIDA6CTQxIDU1ICAgICAgICAgICAgICAgIAlwdXNoICAgJXIx
Mw0KICAgMjoJNDkgODkgZjUgICAgICAgICAgICAgCW1vdiAgICAlcnNpLCVyMTMNCiAgIDU6CTQx
IDU0ICAgICAgICAgICAgICAgIAlwdXNoICAgJXIxMg0KICAgNzoJNTMgICAgICAgICAgICAgICAg
ICAgCXB1c2ggICAlcmJ4DQogICA4Ogk0OCA4OSBmYiAgICAgICAgICAgICAJbW92ICAgICVyZGks
JXJieA0KICAgYjoJNDggODMgYzcgMTAgICAgICAgICAgCWFkZCAgICAkMHgxMCwlcmRpDQogICBm
OgllOCAyMyBlMCAzNiAwMCAgICAgICAJY2FsbCAgIDB4MzZlMDM3DQogIDE0Ogk0OCAgICAgICAg
ICAgICAgICAgICAJcmV4LlcNCiAgMTU6CThkICAgICAgICAgICAgICAgICAgIAkuYnl0ZSAweDhk
DQpbICAgMjIuNzUwMzcwXSBSU1A6IDAwMTg6ZmZmZjg4ODEyNTA2NzRkMCBFRkxBR1M6IDAwMDAw
Mjg2DQpbICAgMjIuNzUyOTA2XSBSQVg6IGZmZmZmZmZmODE2NzYxNTUgUkJYOiBmZmZmZmZmZjgx
MjY5NjAwIFJDWDogZmZmZmZmZmY4MTBlMjEwNg0KWyAgIDIyLjc1NTU3Ml0gUkRYOiBkZmZmZmMw
MDAwMDAwMDAwIFJTSTogZmZmZmZmZmY4MTY3NjE1NSBSREk6IGZmZmY4ODgxMjUwNjc1YTgNClsg
ICAyMi43NTgyMTddIFJCUDogZmZmZjg4ODEyNTA2NzRkMCBSMDg6IGZmZmZmZmZmODEwZTIwZDQg
UjA5OiBmZmZmODg4MTJmMWE0MDAwDQpbICAgMjIuNzYwODc3XSBSMTA6IGZmZmY4ODgxMjUwNjc0
ZTAgUjExOiAwMDAwMDAwMDAwMDAwMDAxIFIxMjogZmZmZjg4ODEyNTA2NzVhOA0KWyAgIDIyLjc2
MzUxM10gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjg4ODEyZjFhNDAwMCBSMTU6IGZm
ZmY4ODgxMGYzM2MxODAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
