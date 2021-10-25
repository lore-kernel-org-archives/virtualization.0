Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B768C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:10:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D9060EE9
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A6D9060EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75A3C40253;
	Mon, 25 Oct 2021 08:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83zLyG_cRP3p; Mon, 25 Oct 2021 08:10:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CD4240251;
	Mon, 25 Oct 2021 08:10:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7A0FC0019;
	Mon, 25 Oct 2021 08:10:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 409CEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FBB580DAC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGbtG8pYHI3t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CF3F80CCB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDD1V5cHGYJEQYWn23b9VsypTsqGiFT/PB79iGYrKQyPZrkzIh4u9Ef/iTXJiZVlvr0f1nkp+RHHzJ2jc5rgJjscszEfTXAnAvXOvGohKXn/MO3G0RoJXmlL5bCpcwuzZkw1neIUzZnVSvaCUYuLA4j+c22qCJJKmzGCW3QSikBs1XooA7DdrDewbPD0Omkk7u3Zx28hmEh7uM+mjjn51XPFs+b0sfpbe5jCfR9x/boXkdrF33AOsHR5K14RWLUUFKE0dQ9OXNlkjjRewczuub1owQkunpd3XKueo+HWOHDHZMVeX8Le92YxzMS9tROT+fkE7jo49qdYbubnKsq7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iQlm+y5ECIHAh2cU+62BRjVeQSlAgwmgnYU5NfpuW8=;
 b=Md43EykmbkWjDodxhq5aM5AswVOa8cZIxD5Z+RIIyjN+BhufqrreRfhu33/RbBxS66smzVCYcs9hsXesJB3dOBtQJ7ddQ0QjZagVibWpVW/398YxaN3zWOrcEdXE989CfcQP6NV0Br9mgibKqymVquveEf45aMtS44/SkisMl8YvUmMspqiGKXcycA92TvfVQNEa4IGIKr362u1n4sfmOXGYzAsBYzC36QV61ZrEaCBKeVAvNp31bXX5FyjPsvoTowcqlys+2C68ciwqdVDRtpfkfc6lq0ifzQuiZw/pW2sBZPinSMYmcq7cwnJa0hUx5hdObS4b+kNbJckX1D6hrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iQlm+y5ECIHAh2cU+62BRjVeQSlAgwmgnYU5NfpuW8=;
 b=IKVbmOSddpm8vVWhIpuXejEC9v2Eu6fVe6LCZIkmqhIYYbJkNz8njZvoAvcNH5AtPsmFN2u+MVf/ViREXXYHx5k+zQo0c3MjxazgFLEMT/hY+Q+NPPrtA+2QTzmOiZhJXlhU2Azf901I4zW1KjjbeP4iRxZfEU0Fjsh9nytIEOkalP7CyOiskZocm8Y4BcsZue3gTe7NcsmELak2BD1fw46u1kqaF4yU5Brv8J7kZUwottzroulG4FwMyuL5jrXL2T/0v7EGP71ESBwVaC+95sMSdaO4PC8eYOlxdw8aYCo9YlRvUuE96Hxc3o9NN9TFi+k4k6gHy4XSZvszc2JiDg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:10:15 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::e061:9284:b153:e633%3]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 08:10:15 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Topic: [PATCH linux-next v4 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Thread-Index: AQHXxpm1m80mTV7hq0uYnXMEWxV+O6vjT0WAgAACM+CAABB/AIAAACoA
Date: Mon, 25 Oct 2021 08:10:15 +0000
Message-ID: <PH0PR12MB5481624C8C6F35197B5AF6A1DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-6-parav@nvidia.com>
 <03d8d907-f54d-f9e2-a058-fd8d50ff927e@redhat.com>
 <PH0PR12MB54818C925D446110117F01DCDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211025040853-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211025040853-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 900963da-704e-4963-5789-08d9978ee06c
x-ms-traffictypediagnostic: PH0PR12MB5433:
x-microsoft-antispam-prvs: <PH0PR12MB54331CC9DEAA43B40115665DDC839@PH0PR12MB5433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SGbUgYzq86RDZqWftr1wN1eP3a7x0f+LV4kFXiVdbq/GxBS2F9QL7J180Isl6RG+jlvrXFBYrwFmWBPG8IJyv4dsK655fP1Uo9qlypvFQArZc/zR9dNrDbJGc+WPnC+RE7a8bYKTd3iEMgsDNEWieAIeRIX8aRXWj4AtVc07CuR9XSdEYzUK/x1KCKusbwSO7huKlYCcRPAyHSd3ZmDYMtuYivA/C8/Iif2//QReDnEKkZ2u4peZiPK2gd0kotxiYRojIrqsLCYqcljqqYuAvPJ9UB4nzvB2pjf05q16lvsWpdT2UWgbWHelYRGtk/pRmYfU6XOfeVcvasoc8WxwgAp3YPKb3vv0y3ywaCMe6NJo+Qq1EPsnfdXE7Vb9AcK3k+jkPSOLv8xYcMj1OpAwBgOYCVYwTwt5BYiPMzMf0nQNAg+K/IhlWlXf5gUxfen85qnazaaCJZokfmcbsdC1Wz+aWCYmhxdRW80DavgyS7G4n4bTUA5Aj5jerhW4HFa77C2mNseU3wsFkJkSvnw8Jent4hBMerlAne7bOJzZ4DOYoHEzBxlsKTNVoQezLAYJVHks6Yj8NE78VZUBAiD4+C6+BprCggtSOQEwFb4htOOn8mQE+iN0hizBrhkTt0EbwrQURu8uiljI96Qr+lbVAGa7EhmsXR/vJat8XSpkxnkI/x5E/nHcDmllOtO9+3wHh86u0v+vsTHig2orso1jg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66946007)(71200400001)(55016002)(66476007)(107886003)(2906002)(86362001)(508600001)(26005)(186003)(5660300002)(4326008)(66446008)(6506007)(33656002)(316002)(64756008)(38100700002)(7696005)(9686003)(8936002)(8676002)(38070700005)(54906003)(6916009)(52536014)(122000001)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXFrcGhjT0Q3M1pGcFNQd2Fmd2ZPRVk4d09QYWFUb2Vlc1V2NGdqbUVwYlpl?=
 =?utf-8?B?ODlJNVNTeU85WUhoNm5LN3hYTDZPbHk1b281NURycFlkenJZdTF6K1plRXdM?=
 =?utf-8?B?Rit1WFBLVHowTzdiNE9HUU8wd29GRkpKa1hRR254YzJ0UWszVmF3OGJQRTZk?=
 =?utf-8?B?eFJrQkNud09GTmFTbGFCNHZML0dpdUhZNm1RNmluazREWkJoZVVvYWR0RlBP?=
 =?utf-8?B?bDJiaUhPQ0RoRk9mWFB4ZzdTWFRHS2NsTlEwcEdwdGV2RGZuWUJKMkN4TXp6?=
 =?utf-8?B?UWU3VmJEeFl1dHFOTUN3d2NRSU5ibStNR09lSUp6bVdTMnlLMVFYMjhmRnk1?=
 =?utf-8?B?R2d2ZVUrM2RrOUdDcDlhNzgrdXRBWFBRdzE1RHVxTVVsUHRIbDFuQ2lnOXZD?=
 =?utf-8?B?WjRlN3NDM2lzejArTzRlSThyMVJYYkxuaTdJcDRQZEUyVWI4bnBrRCtqdnNX?=
 =?utf-8?B?Tlp2M2p2aFdCTXZ2UFJUZ2UxbW5iUUFFbmlBYjZYSGhSNFVyUlUwblJDbkp2?=
 =?utf-8?B?SmxMZkxna0grOU42WFUvbUMvVVczM2gyZmNSSW5peC9neG5OZlozUUNoc3p2?=
 =?utf-8?B?d25pWVhZcHUwdFIycU9QdGdwSXlkSmp3Vkl2NEpZRGJGemFuUnZGRjF1bUNp?=
 =?utf-8?B?Y3g5ZmFuQzIzUWNSWnBYS1lVTUtZeVVFSmtGVjNTbDdkc2ZRMnllcm5jSkY0?=
 =?utf-8?B?SWhUdngvdm9yQWdpQ1Zxak8vQldrMllsUHgxWEZZMnJYY3ZvWHhIOHYySDhL?=
 =?utf-8?B?dEdJWHRZRUJuQXlOcTBKdmp3aTNudmN4UWszUzI4Y05RSUxobG43bnB6WU1x?=
 =?utf-8?B?STVpem5SM01lMDVOMDFmdFI2a3NJTHorSGprRWlHaU9sbHhhRVA1M2lJaGph?=
 =?utf-8?B?djBMaDJ6VjFZSXcvVVZMY25HaEo5aDVIT1RMdWdodlErRVQ2YjdNT0ZmUkY4?=
 =?utf-8?B?bGxyUFQ2Z1dMT2M0VG1sRTdKOVNZNXpwRkhCUFdaQ2VUMjhZa2ptVkk1YlB1?=
 =?utf-8?B?N1ltRXpad0VzUGwwVzdnK1BoTGVUelRTYmtLS0JuUUw4SXBueGw4SkZJZVhv?=
 =?utf-8?B?cStxZ3ZNT2RIQStscndSSG5teG56L0M3SG5tTWY0MW05bU42ZzdrOFMzN09J?=
 =?utf-8?B?U09kdXZmYStSTS9xYTI1WXozWm9OaDBlaGdjT1JsWU1DSGp0ZXVWNW16cUh3?=
 =?utf-8?B?QUk2ZE5ZTVdiN0VJem5HMU95d3k2Q3c2Y09aanJrTzFNeW9Ub2YwSWZ1Z3kr?=
 =?utf-8?B?YkN3ckszMFpuaWduOVgyQXpkSnZVYllkcTl0RDF3amdaUmR5UVBGV3NKeHEz?=
 =?utf-8?B?ZXhMZHo5Nk5OSGoweGVpMkZwTHFJWGE4Z1JSbTA1UjJ5d0tyd0pMTGdYV1g5?=
 =?utf-8?B?VUpWL2lWSHQwQmdRckttQjJhemx1eHJsUlVMNEFuTG9UZFB5Vms2TFhYbTFD?=
 =?utf-8?B?RkpUblAzR0dZTFJDL1ZicUc3aStsSHVpUFlsZ3pnRGRteGhXZy96Z2lIbVlz?=
 =?utf-8?B?OS9iWWhVOHR4dEFpNFVMOVlWUnpDRmRPOWIyR25FMHBXR0VDTVFkOHpWK1dD?=
 =?utf-8?B?TU95YW5hNkg2cllVUzdTc0IrRDdxc3cwUlZ5VnB3b2FzWWJZdEwvNkhFdTRj?=
 =?utf-8?B?MWd0WGVpTEdjTXFHeGFnSDltU2ZOSnNVeWVleE5ZdFplSEE1V2FCczBneUhi?=
 =?utf-8?B?aXJsMEQ1clo2d0tMRjVrNjdqRFVCQzJCbVZKZXp1Qi95ZDJXb2RTWXhiTVV0?=
 =?utf-8?B?b2ZFOXRLQTdsS1lJWVhROUdGY3NCay8xbjVHbURIdGhWL01yODNPeXFzZ3Nr?=
 =?utf-8?B?WjBJNWwrUVFxL1pYZmMwU3dQZmdld3dNNENya1dkVGl3clljZ1QxL3FzZzJ3?=
 =?utf-8?B?SnpxQSt6bWpjeUNwemN3MVRXdWM3QVNZQ3d6N2ticnVQRXRnZWVhZHQveDNO?=
 =?utf-8?B?Ni93WXlpN2NYZXRQOUx2MnFIZTJ3MVdFV0FHQ1RYWHhmWnhiK3NpL2V3Tjlo?=
 =?utf-8?B?cUd4YnhWRnhFQXVVVjRyYytESHNMZmtCdzZNZU1UZ0lxenBCRU0rV0MxZnZK?=
 =?utf-8?B?Y3hIOGZ3MytLU3lONU5DRFU2N1dOU1J6bkJKTzRqN1V6dFNNODd1bXVBNlAr?=
 =?utf-8?B?N3hjc3YzR0pzVkY1a08zOFlmaFc0QXc3YTdKK2xzelhnU0dxZlJHL2VkMnhQ?=
 =?utf-8?Q?EEoWZS4+84wPE02JaXMF2Co=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900963da-704e-4963-5789-08d9978ee06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 08:10:15.5275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ieua9tmoAveQG/mtH2FMOSEbSOBboRzhqx+i786zmK6kGM3irUcoYR6/NWjM+1i9ZpJx5RkXTf/BS0qzvQhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
TW9uZGF5LCBPY3RvYmVyIDI1LCAyMDIxIDE6MzkgUE0NCj4gDQo+IE9uIE1vbiwgT2N0IDI1LCAy
MDIxIGF0IDA3OjExOjIzQU0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+DQo+
ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gU2VudDog
TW9uZGF5LCBPY3RvYmVyIDI1LCAyMDIxIDEyOjMyIFBNDQo+ID4gPg0KPiA+ID4NCj4gPiA+IOWc
qCAyMDIxLzEwLzIyIOS4iuWNiDEyOjM1LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOg0KPiA+ID4gPiBF
bmFibGUgdXNlciB0byBzZXQgdGhlIG1hYyBhZGRyZXNzIGFuZCBtdHUgc28gdGhhdCBlYWNoIHZk
cGENCj4gPiA+ID4gZGV2aWNlIGNhbiBoYXZlIGl0cyBvd24gdXNlciBzcGVjaWZpZWQgbWFjIGFk
ZHJlc3MgYW5kIG10dS4NCj4gPiA+ID4gVGhpcyBpcyBkb25lIGJ5IGltcGxlbWVudGluZyB0aGUg
bWFuYWdlbWVudCBkZXZpY2UncyBjb25maWd1cmF0aW9uDQo+ID4gPiA+IGxheW91dCBmaWVsZHMg
c2V0dGluZyBjYWxsYmFjayByb3V0aW5lLg0KPiA+ID4gPg0KPiA+ID4gPiBOb3cgdGhhdCB1c2Vy
IGlzIGVuYWJsZWQgdG8gc2V0IHRoZSBtYWMgYWRkcmVzcywgcmVtb3ZlIHRoZSBtb2R1bGUNCj4g
PiA+ID4gcGFyYW1ldGVyIGZvciBzYW1lLg0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgZXhhbXBsZSBv
ZiBzZXR0aW5nIG1hYyBhZGRyIGFuZCBtdHU6DQo+ID4gPiA+ICQgdmRwYSBtZ210ZGV2IHNob3cN
Cj4gPiA+ID4NCj4gPiA+ID4gJCB2ZHBhIGRldiBhZGQgbmFtZSBiYXIgbWdtdGRldiB2ZHBhc2lt
X25ldCAkIHZkcGEgZGV2IGNvbmZpZyBzZXQNCj4gPiA+ID4gYmFyIG1hYyAwMDoxMToyMjozMzo0
NDo1NSBtdHUgOTAwMA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGUgYXR0cmlidXRlcyB3ZXJlIHNl
dCBkdXJpbmcgZGV2IGFkZCBpZiBJIHdhcyBub3Qgd3JvbmcuDQo+ID4gPg0KPiA+IFlvdSBhcmUg
cmlnaHQuIEkgbWlzc2VkIHRvIHVwZGF0ZSB0aGUgZXhhbXBsZSBoZXJlLiBDb2RlIGlzIGp1c3Qg
ZmluZS4NCj4gPg0KPiA+ID4gVGhhbmtzDQo+ID4gPg0KPiANCj4gV2FudCB0byBzZW5kIGEgY29y
cmVjdGVkIGNvbW1pdCBsb2c/DQpZZXMuIHdvdWxkIGxpa2UgdG8gc2VuZCB2NSB3aXRoIHRoZSBj
b3JyZWN0ZWQgY29tbWl0IGxvZyBhbmQgQUNLIGZyb20gSmFzb24gb24gb3RoZXIgcGF0Y2hlcy4N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
