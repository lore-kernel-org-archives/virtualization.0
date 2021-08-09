Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39C0C4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 06:01:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CFB61019
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 06:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47CFB61019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B5E2400D4;
	Mon,  9 Aug 2021 06:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKwU8dYEz0qo; Mon,  9 Aug 2021 06:01:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32104400BE;
	Mon,  9 Aug 2021 06:01:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F3FBC001A;
	Mon,  9 Aug 2021 06:01:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69BDEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51999606A6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJqbwlMX0mYj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:01:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A7806068B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 06:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knfw3MeuGJIcJYE4coQ80RjekC4GeGlvEzgL5ott6yPxS31VJ4NTxryKmq3hX9D2bFwMe69UK9Q+4l9DcYSkRSGoW+OzLTGNorre2Q849nKQsf+wIOqPq8893ptAwnXY7lnA7Jvxkck91kV40kJgHMkvzGs711O267j6HoEpFw+qjxbWx6RmnaQNxddJ1E7HKbY27Qu2EaARAU7tr23zxg08xMQudkYnDYK/lhdIowscztTJgdGWN1YEsiZbLIe0dpDv76EEI5mlCA/P21JkzI8jOlJ/asgW3jgZs6paNuWWc0Yh2lwpbGcB9jnTe/TtgxMJJTfOHA4yhjE3b9vlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p360TDauHS3XTZVBdtdwYcp0SWssIzlYcsSw7jczuCY=;
 b=Ve1v8EEJ+lERhnTGamcB3z73+QDE9YOYoMupMNCAEWdZPUsXkuIVADt3hTouwweXM+MMHMq3IEfms0HlV/R9QaolPoUxyXtd8f9bLgQwTX6cVZ9k9q4/26EbPG9WRyNb+yrFjT/C2NeoMtaPYSyD3MZlIx6BW51oFE3AAD2pAR74pIC/TYcv6R6SEFpoUPROGaRoIRPIpAptK8gLumy3siCbMPxDpERndCGUhz5QypgoTXni0A3GBB484IjNTh227gLgaw2QTr1NCFmahTMiUIq9LUNFHD57QOPQEevA1eSA5U9ZhKjCTlrENPhqnMzM4X3hoCyUEvSlDZe0levPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p360TDauHS3XTZVBdtdwYcp0SWssIzlYcsSw7jczuCY=;
 b=jKINB/5SBk0/XhNY3x1MsolmFoKhLqcMoVRxiv9qweuU0pbKXzgKn2arQEvsbLcrl1Zb9W9S7q2XqmZpCjnPuxXlNOwbh10EauFG6BKc+VN4GMML5lQ6F0h/dGhmkfYuTpi2c/YXzLHOWIViHpJV6lx7brc1DXeo0vLqnAdnipbmL28n79gKg7HRrRt8GOFBR3qG8CZBVITs1YUwDYlA5cyrZAqgAOI0K4ny9UkggQadaWzKqBkwXJzNxHnTr3pt9dRcvC0qLr7E6RfAlrUoIq3C3qQLCPwZxFBrBf8GMrpTLfudAhejKnbZRoDbkG/A9QVuRl+ZuyF7dSVDIWfrYg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 06:01:49 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::249d:884d:4c20:ed29%4]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 06:01:48 +0000
To: Eli Cohen <elic@nvidia.com>
Subject: RE: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Topic: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Thread-Index: AQHXYuOH3YVTcMY6VEeAGlknhW/FN6tk+uIAgAEa9oCAAGJZgIAAALAggARY0QCAACVNgIAABSwggAAFAwCAAAB4gA==
Date: Mon, 9 Aug 2021 06:01:48 +0000
Message-ID: <PH0PR12MB5481E4454B3785A40AB8A181DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <be8a0173-b7fb-eabf-bc4a-9492133674ef@redhat.com>
 <20210809052121.GA209158@mtl-vdi-166.wap.labs.mlnx>
 <PH0PR12MB5481F74DCC09018C476D7262DCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809055748.GA210406@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210809055748.GA210406@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e54f3c-32ab-4d9f-1e7c-08d95afb2d1b
x-ms-traffictypediagnostic: PH0PR12MB5403:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5403F3C821A0B5FC93827375DCF69@PH0PR12MB5403.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sU2LB+ACqk/cH+0FaC/yJu0VvMF9YDcRG6LzKvjpcBtJ5+aiCX3+sk6VXeoYjCgMOTZejqSAYvCkVxtj4ssI9USE0LkvXYyrHmftLMnVjJcVD3AqkDIyypa0vW8EFgk/Qcj1gKKaYuqjMmYQ2BaXH2v8sUt0/i5Ikoplkgp0R/Hh6MWsawqHhzIS4i+KNtcDOf4mzh5H0+YRAUILyhqXRNRYuEyOo0DSRJPiqqtlPZQ2aN1EUC0TOHm+dyxEeoiyzmNhgJSs+hZsfw5DvumcXMDSDmtgk+6xYe+NbJY866ydKchS/TERkQP1ckUUuvSqQEbcq5a99XQDRSd13kKLHzV0kiWGJEV5B6UUvoKK2jP3XBKj1GTc2vW+sXRX5Gi5iN/HlKn0ehlfQac9Z2Xy7TZ58zBKHmaa3nfnLtj8OZ+t3ycAHJ8hxwJRwozgmgqKt8DY4YpsbgzPBm51wCEMuqzDFXqUUBrXFkoJ5fCnZiHZt8LQ1Y2/jtGcNyjwxhmmHo34a/lyGwYJo4JixRSjzxmXXHFb9dnmzy792xaVwyyu8rik3hcIMuMeMhOqRj2eHJP2P01ZZkV4CSbswZTFotpQQwrAOxrh948QjiN0zzrlaFOSUNZrlBKrahrQILyD1drGvtwTsKz86eUB1CMfJ2JYQWuyQa/egJ3BsUm6kXDFuM5Tr60fbAkjZfuLyT/U3F5JiMt0vvlX0SSn93jQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(26005)(186003)(6636002)(52536014)(83380400001)(86362001)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(55016002)(71200400001)(2906002)(9686003)(54906003)(122000001)(4326008)(8936002)(38100700002)(38070700005)(33656002)(316002)(6862004)(8676002)(7696005)(508600001)(6506007)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzZRcU9rdEJqbEhFdWdHVTNoUDBJMXpvQUN1aUtpMm5JZkRFR29GOHJmSFl6?=
 =?utf-8?B?OHk3V0dpTFQ1WmdFdWFhbHMvRzQ3YkVYY3B0dHhlOVZ3d21HK050TGRSWWJz?=
 =?utf-8?B?cjBFOTdndk9FWnB6SjNHWjFjZnZwUncyQ3BwWFR4TUgwWlRqU3pXMkpTUkJM?=
 =?utf-8?B?WjVhWUJ0VzFRcjdmL1gvTkVuMms5UnhNYW9pR1BoRnFQeW5Ya0NZTjVOcjl1?=
 =?utf-8?B?WmVLQTdEMWR4aUMvVStHYnJYMWhmemljTDdBR1VwbnhSajJXVU1MdjBSZGph?=
 =?utf-8?B?eC95bWh0a1cxdGdQVThEQytxM21vellQWVE3M3ovWGkzRmVCMnNNRmVEL1pt?=
 =?utf-8?B?Ri92VFBwM1dmRHZ2WU9EeGNDMFRkMDR5cmVnM0dHeU9OQWpnM3N6c0laSXpP?=
 =?utf-8?B?TDFSazREM3ZJb1J0QTNYblBYeEJ4Snc4M0lLbHQxNWRaS1NQdFU2eG5obTAv?=
 =?utf-8?B?dVpRenBSMWh1MEx0Q1Z4Z25OUlRMbEp0ZzduaytJSzg1elExbFhPQWN4R2xi?=
 =?utf-8?B?Z0wwM0ZQdXp1YzlBRnZjby9OR05iaW1ocjJpZmc0QzVHL3NjYmhkRk1yTWxC?=
 =?utf-8?B?MHFjU2VxM3hGZ3Z1dHZ2S3FRQ3o1SHdFRmFYYkpOZ2NMYnlJWnQxWmtJeDlk?=
 =?utf-8?B?UXRwZWIweE12dVVqQ1VLeC8xRmdvMUIzWUJvNkhRbzJONVBsTHhRUXFnWlhN?=
 =?utf-8?B?Q3JucmRmZTZQVmJaWXpETWhqbnpwemZ3amVyK05IZTI4aUZMYTlRNFNleitv?=
 =?utf-8?B?SnhvNHVVcFRFK0R3dzFmVGtvbDRyNDF0Qk8wakVQT01sOGk3eGpLOURPQnF2?=
 =?utf-8?B?TGgxY2J4elF1eG4rQlFIcXhnK1BLUExLQXczWXNVa0FoM0JIYlhEZzFBM3dR?=
 =?utf-8?B?ZlE3UVpiWW5peVgrVHVjY2tLVHRDOUt6dnhkQXRiSS9LVk9hMFJNQzRXakhP?=
 =?utf-8?B?WVE5UUVIRHlJWGVRZG91a0hQOTFEaHREU1l0Q2ZzemJhc0NOUy92T2Jqamcv?=
 =?utf-8?B?RmRqQm1mak9GVVh1V2x1dm1jUG5tVGVtbExSQXdHbDd0MCtQc2dXMFJaZnhz?=
 =?utf-8?B?ODFlb3l3VGtaSHdaeGlyWUFMaDh6QWg4VVZneWo1NWpsS1poV244VWVGa3Vr?=
 =?utf-8?B?dk56dXljTzM1SDV6VkNwTllOcVcweEJTT01HeTlQNkxQZmIzSEFpQWRxYkIr?=
 =?utf-8?B?TkwyUGp3bkZEa1VOeTBQNXpZdmRpSzVEcVFTRXZRWXlGYUREd25jSHB4Y0Np?=
 =?utf-8?B?MzJ2ZzZFNXEyMVFxNEtYTERKRDZLYzJCVzdBWVVmeUh4Uit6R2t2REpPMjll?=
 =?utf-8?B?VXE3M2VNVXpLZWdWMUN5UnpvQnp6cWF6bGxYc2dibEk3WmZNTDZUcThseXhQ?=
 =?utf-8?B?RFRuS3ZsSlNUdTNVL3ZQN0ZUbE15TTRuS1NFMzU4RXdIR0luRm9WaFUySlEx?=
 =?utf-8?B?L25wNlhOZGN2TGhESUw2aVAxTWxPT2J4clk1aGZEZWxwa2lEY1RoQ2IxRWsz?=
 =?utf-8?B?K2g4T20wckNrUSs0RTVqYklRbWdpajV0YzlJckdmUHhDbTNpMXlEWWI2cVB2?=
 =?utf-8?B?ZVh0RDBzWE41L1hBbnBrRkM5ajJvVnFNSVNpbU1senNMSDNWMTlHOHNjSjRB?=
 =?utf-8?B?dzZnazY3K1pFWG8yby81UHlpNHBxMUtCVm82T0lQSnpLV1N1dmdaVnZKQ3d6?=
 =?utf-8?B?ekQ4MWlQeG8vNUorR2FJbEdIS0VyR0dkdUVKSXF2Z1ZlRFMvMk0vSnlGRmQr?=
 =?utf-8?Q?XmTLWDnljEtvkbAX4Y65nimcVQhKFih9cjcLTbD?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e54f3c-32ab-4d9f-1e7c-08d95afb2d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 06:01:48.7976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Snw1pLVVg65wdjBqH+YfFHCui6KVPP+32c9Ix6PGTlXX3nbpDsrCC5CopZEn3GXOvaXAV7Zqd+EToPzt4sDecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

DQoNCj4gRnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+DQo+IFNlbnQ6IE1vbmRheSwg
QXVndXN0IDksIDIwMjEgMTE6MjggQU0NCj4gDQo+IE9uIE1vbiwgQXVnIDA5LCAyMDIxIGF0IDA4
OjQyOjU4QU0gKzAzMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiBGcm9t
OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0
IDksIDIwMjEgMTA6NTEgQU0NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEF1ZyAwOSwgMjAyMSBhdCAx
MTowNzo1MEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiDlnKgg
MjAyMS84LzYg5LiL5Y2INDo1NSwgUGFyYXYgUGFuZGl0IOWGmemBkzoNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPiA+
ID4gPiA+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDYsIDIwMjEgMjoxMiBQTQ0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+ICAgZW51bSB2ZHBhX2F0dHIgew0KPiA+ID4gPiA+ID4gPiBAQCAtMzMsNiAr
MzQsMTYgQEAgZW51bSB2ZHBhX2F0dHIgew0KPiA+ID4gPiA+ID4gPiAgIAlWRFBBX0FUVFJfREVW
X01BWF9WUVMsCQkJLyogdTMyICovDQo+ID4gPiA+ID4gPiA+ICAgCVZEUEFfQVRUUl9ERVZfTUFY
X1ZRX1NJWkUsCQkvKiB1MTYgKi8NCj4gPiA+ID4gPiA+ID4gKwlWRFBBX0FUVFJfREVWX05FVF9D
RkdfTUFDQUREUiwJCS8qDQo+ID4gPiBiaW5hcnkgKi8NCj4gPiA+ID4gPiA+ID4gKwlWRFBBX0FU
VFJfREVWX05FVF9TVEFUVVMsCQkvKiB1OCAqLw0KPiA+ID4gPiA+ID4gPiArCVZEUEFfQVRUUl9E
RVZfTkVUX0NGR19NQVhfVlFQLAkJLyoNCj4gPiA+IHUxNiAqLw0KPiA+ID4gPiA+ID4gPiArCVZE
UEFfQVRUUl9ERVZfTkVUX0NGR19NVFUsCQkvKiB1MTYgKi8NCj4gPiA+ID4gPiA+ID4gKwlWRFBB
X0FUVFJfREVWX05FVF9DRkdfU1BFRUQsCQkvKiB1MTYgKi8NCj4gPiA+ID4gPiA+ID4gKwlWRFBB
X0FUVFJfREVWX05FVF9DRkdfRFVQTEVYLAkJLyogdTE2ICovDQo+ID4gPiA+ID4gPiA+ICsJVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfS0VZX0xFTiwJLyogdTgNCj4gPiA+ICovDQo+ID4g
PiA+ID4gPiA+ICsJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19NQVhfSVRfTEVOLAkvKg0KPiA+
ID4gdTE2ICovDQo+ID4gPiA+ID4gPiA+ICsJVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19IQVNI
X1RZUEVTLAkvKg0KPiA+ID4gdTMyICovDQo+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4g
ICAJLyogbmV3IGF0dHJpYnV0ZXMgbXVzdCBiZSBhZGRlZCBhYm92ZSBoZXJlICovDQo+ID4gPiA+
ID4gPiA+ICAgCVZEUEFfQVRUUl9NQVgsDQo+ID4gPiA+ID4gPiA+ICAgfTsNCj4gPiA+ID4gPiA+
IFRoZSBwb2ludCBpcyB0byB0cnkgYW5kIG5vdCByZWludmVudCBhIGRlZGljYXRlZCB2cGRhDQo+
ID4gPiA+ID4gPiBpbnRlcmZhY2Ugd2hlcmUgYSBnZW5lcmljIG9uZSBleGl0cy4NCj4gPiA+ID4g
PiA+IEUuZy4gZm9yIHBoeSB0aGluZ3Mgc3VjaCBhcyBtYWMgc3BlZWQgZXRjLCBJIHRoaW5rIG1v
c3QgcGVvcGxlDQo+ID4gPiA+ID4gPiBhcmUgdXNpbmcgZXRodG9vbCB0aGluZ3MgcmlnaHQ/DQo+
ID4gPiA+ID4gQXMgeW91IGtub3cgdmRwYSBpcyB0aGUgYmFja2VuZCBkZXZpY2UgZm9yIHRoZSBm
cm9udC1lbmQNCj4gPiA+ID4gPiBuZXRkZXZpY2UNCj4gPiA+IGFjY2Vzc2VkIGJ5IHRoZSBldGh0
b29sLg0KPiA+ID4gPiA+IHZkcGEgbWFuYWdlbWVudCB0b29sIGhlcmUgaXMgY29tcG9zaW5nIHRo
ZSB2ZHBhIGRldmljZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZvciBleGFtcGxlIGNyZWF0b3Ig
KGh5cGVydmlzb3IpIG9mIHRoZSB2ZHBhIGRldmljZXMga25vd3MgdGhhdA0KPiA+ID4gPiA+IGEg
Z3Vlc3QgVk0gaXMgZ2l2ZW4gNCB2Y3B1cywgU28gaHlwZXJ2aXNvciBjcmVhdGVzIGEgdmRwYQ0K
PiA+ID4gPiA+IGRldmljZXMgd2l0aCBjb25maWcgc3BhY2UgbGF5b3V0IGFzLCBtYXhfdmlydHF1
ZXVlX3BhaXJzID0gNC4NCj4gPiA+ID4gPiBBbmQgdGhlIE1BQyBhZGRyZXNzIGNob3NlbiBieSBo
eXBlcnZpc29yIGluIG1hY1s2XS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEd1ZXN0IFZNIGV0aHRv
b2wgY2FuIHN0aWxsIGNob3NlIHRvIHVzZSBsZXNzIG51bWJlciBvZiBjaGFubmVscy4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IFR5cGljYWxseSwNCj4gPiA+ID4gPiBldGh0b29sIGlzIGZvciBndWVz
dCBWTS4NCj4gPiA+ID4gPiB2ZHBhIGRldmljZSBpcyBpbiBoeXBldmlzb3IuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBIb3cgY2FuIGh5cGVydmlzb3IgY29tcG9zZSBhIHZkcGEgZGV2aWNlIHdpdGhv
dXQgYW55IHRvb2w/DQo+ID4gPiA+ID4gSG93IGNhbiBpdCB0ZWxsIGV0aHRvb2wsIHdoYXQgaXMg
c3VwcG9ydGVkIGFuZCB3aGF0IGFyZSB0aGUgZGVmYXVsdHM/DQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+IFJlcmVhZCB0aGUgY292ZXIgbGV0dGVyOg0KPiA+ID4gPg0KPiA+ID4gPiAiDQo+ID4g
PiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2hzZXQgZW5hYmxlcyB1c2VycyB0byBzZXQgdGhlIG1hYyBh
ZGRyZXNzIGFuZCBtdHUgb2YgdGhlDQo+ID4gPiA+IHZkcGEgZGV2aWNlIG9uY2UgdGhlIGRldmlj
ZSBpcyBjcmVhdGVkLg0KPiA+ID4gPg0KPiA+ID4gPiAiDQo+ID4gPiA+DQo+ID4gPiA+IEl0IGxv
b2tzIHRvIG1lIHRoZSBtZWNoYW5pc20gdGhhdCBpbnRyb2R1Y2VkIGluIHRoZSBzZXJpZXMgaXMg
bm90DQo+ID4gPiA+IGZvciBwcm92aXNpb25pbmcgYnV0IGZvciBwb3N0LWNyZWF0aW9uIGNvbmZp
Z3VyYXRpb24/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gVGhlIGRpZmZlcmVuY2UgaXMgc3VidGxl
LiBJbiBib3RoIGNhc2VzIHlvdSBwcm92aWRlIGNvbmZpZ3VyYXRpb24uDQo+ID4gPg0KPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgbXVzdCBiZSBtaXN1bmRlcnN0YW5kaW5n
IHlvdXIgY29tbWVudCBhYm91dCBldGh0b29sLg0KPiA+ID4gPiA+IENhbiB5b3UgcGxlYXNlIGV4
cGxhaW4/DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkgZ3Vlc3MgdGhlIG1lYW5pbmcgaXMg
dGhhdCwgaWYgdGhlIHZEUEEgaXMgYXNzaWduZWQgdG8gZ3Vlc3QsDQo+ID4gPiA+IGl0J3MgdGhl
IGNoYXJnZSBvZiBndWVzdCB0byBjb25maWd1cmUgdGhlIE1UVS9NQUMvUlNTIHZpYSB0aGUNCj4g
PiA+ID4gZXhpc3RpbmcgbWFuYWdlbWVudCBpbnRlcmZhY2UgbGlrZSBldGh0b29sL2lwcm91dGUy
IG5ldGxpbmsNCj4gPiA+ID4gcHJvdG9jb2wuIFRoZSBjb250cm9sIHZpcnRxdWV1ZSBpcyBkZXNp
Z25lZCBmb3IgdGhpcy4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJIHdhcyB1bmRlciB0aGUgaW1w
cmVzc2lvbiB0aGF0IHdlIHdhbnQgc29tZWhvdyB0byBjb250cm9sIHRoZQ0KPiA+ID4gY2FwYWJs
aXR5IGlmIHRoZSBndWVzdCB0byB1c2UgYXJiaXRyYXJ5IE1BQyBhZGRyZXNzZXMuDQo+ID4gPiBJ
ZiB0aGlzIGlzIGlzIG5vdCByZXF1aXJlZCB0aGFuIEkgdGhpbmsgY29udHJvbCBWUSBpcyB0aGUg
bWVjaGFuaXNtIHRvIHVzZS4NCj4gPiBIb3cgZG9lcyB0aGUgZ3Vlc3QgVk0gaWRlbnRpZnkgd2hp
Y2ggdW5pcXVlIG1hYyBhZGRyZXNzIHRvIHNldCBvbiB0aGlzDQo+IHZpcnRpbyBuZXQgZGV2aWNl
IHdoZW4gdGhpcyBpcyB0aGUgb25seSBkZXZpY2UgaW4gdGhlIFZNPw0KPiA+IFVzdWFsbHkgaHlw
ZXJ2aXNvciBrbm93cyB3aGF0IG1hYyB0byBzZXQgZm9yIGEgVk0uDQo+IA0KPiBZb3UgZG9uJ3Qg
bmVlZCB0byBrbm93LiBZb3UgY291bGQgdXNlIGFueSBNQUMgeW91IHdhbnQsIGlmIG5vIG9uZSBl
bHNlIGlzDQo+IHVzaW5nIGl0IGluIHlvdXIgc3VibmV0LCBhbmQgZXZlcnl0aGluZyB3aWxsIHdv
cmsgZmluZS4gVGhlIHBvaW50IGlzIGRvIHlvdQ0KPiB3YW50IHRvIGFsbG93IHRoZSBndWVzdCB0
byBjaG9vc2UgaXRzIE1BQy4gVGhpcyBoYXMgaW1wbGljYXRpb25zIG9mIHNlY3VyaXR5Lg0KPiAN
CkxldHMgYXNzdW1lIGZvciBhIG1vbWVudCB0aGF0IGEgZ3Vlc3QgVk0gaXMgYWJsZSB0byBwcm9n
cmFtIGEgTUFDIG9mIG5ldGRldmljZSBvZiB2aXJ0aW9fZGV2aWNlIG9mIG5ldCB0eXBlLg0KSG93
IGRvZXMgYSBWTSBrbm93IHRoYXQgYSByYW5kb21seSBjaG9zZW4gbWFjIGlzIG5vdCB1c2VkIGlu
IG5ldHdvcmsgd2hlbiB0aGlzIFZNIGRvZXNu4oCZdCBoYXZlIGFueSBleHRlcm5hbCBjb25uZWN0
aXZpdHk/DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
