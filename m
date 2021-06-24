Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E3C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:59:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FE9613C1
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 07:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FE9613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CB6E4067A;
	Thu, 24 Jun 2021 07:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X4N4MkMj3_Ze; Thu, 24 Jun 2021 07:59:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B89DC40676;
	Thu, 24 Jun 2021 07:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 883D6C001A;
	Thu, 24 Jun 2021 07:59:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D56C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9718D605EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XLAZKTzdScJx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:59:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 515E360596
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 07:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE4A+7mFs0IqehijzzUUrQE3TTxrgkOKrkRrCBYF9Is9e+yDxo2JjmIon9SuRwF3lNrSu+JejJ/loUcPWVEP9IMEDy7gDHnTa/KPV9kUOhtY0HgbCzF1InMqlK03o5nZ5lx+zU0eQOviAtLOChZOF34tqYz3xCDtCMxGXiP1djHWsYq5iy0lolDzdPa2fPqaMaU6ZWOjB2YcK438kn0xzUctnpe/WEnmvAwOWggMR7QwZJzF0COoMpuQVW8Qw/GzatQzWiM7JoHZpmt6T02t8fEWcRDBup0lowDLRsLbS/IwNdObuKqh4ZPrI/ngmxMGqz6vpju7YGSyft7K91Gf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqF8hWLeRYiVwHBMrzpmE2H3wXlP/wPiYqlUFj+lnIY=;
 b=QGsDzFmzMnKn5jmFgwYFK5K4YE2xHseN+DMVL6HC4bBR2tzt9DfyEjTKVrppBX6Octoo7iJhmcrMgTnbUB6AkblzpOaKZb6JojpblKJ1m9+R0qSnZqo3pwdE89w7TVLJIKokOLcH6bdUFZgOiOu2/yVMvW5vIgAn9ekRIbBZ54ZqIzFg+QLJ7USg1E4KYbZHGKgYoGmJhTf/DpjaGpT9KTFXeJHEoPLByt42ifxA/pEnxLzpAGjWYT4W/24kZBI/61cc7PpHkiaHonW8202eU0gdo05dRbFF7fW4ll0VHs16Wdg0xHQejEHtdNPy9f8hjWp5Ayx8YBezZoJNpVxYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqF8hWLeRYiVwHBMrzpmE2H3wXlP/wPiYqlUFj+lnIY=;
 b=OV4MzQ3J+MtIzZb/mKwaOtB3VXfYKZ3M7xyxHgRXUJzpv7DFZSwtqD03Sleuw+SHZ6tRtjTst6IW1JCS0OjztyYn51+TA7jTTmVGVVYV0U8VL+pIvO9kvpOv/A3PnZDJbNqNdIXQ9KeOlq8MRR1VKVFPx+5E/6U6RQkp5/2/TRuKwqeJuhwSE5u0d5wkgWcYn4W2wkID39uNIX6eDTsZRhOt4sapWwi+aPRqDbW4B/Rd7kL7WJca62RUzus+kLtfsY8WvjCqVpM8Cb5GM4f4qps/blAakebTaDnRWTogpo/uoej2mJ30AKEVvd3UDh91y++H87ch6jazJDcm0T1F8g==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 07:59:21 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::cdf9:42eb:ed3b:1cdb%7]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 07:59:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Topic: [PATCH linux-next v3 2/6] vdpa: Introduce query of device config
 layout
Thread-Index: AQHXYuOJanS3dn7OPkyC8IVj+8AUaqsfqEMAgABt2KCAAO8RAIAAAJPAgAGsGACAAAPf8IAAEweAgAAIirA=
Date: Thu, 24 Jun 2021 07:59:21 +0000
Message-ID: <PH0PR12MB54811C39B86AC8D6BECA9E05DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210616191155.102303-3-parav@nvidia.com>
 <aa7899c0-4b6b-dee3-a175-91e0394bc999@redhat.com>
 <PH0PR12MB5481AE651E0E9BFA6A1839EEDC099@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0434617e-f960-eb1a-a682-49b6a754413f@redhat.com>
 <PH0PR12MB548147BE1B95CB294785470CDC089@PH0PR12MB5481.namprd12.prod.outlook.com>
 <d361bd10-3967-8844-1457-48e7e9422fb2@redhat.com>
 <PH0PR12MB54812DD2DADAD0897E24CFA7DC079@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
In-Reply-To: <4e0708fb-34e3-471d-ca98-44c75f693b32@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [223.184.81.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf6823b7-8be2-4de0-a293-08d936e5f999
x-ms-traffictypediagnostic: PH0PR12MB5404:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5404AAE2D9BE4258C484D70BDC079@PH0PR12MB5404.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I20GlU5DDsriat6wfN0itJ6Yjax41UaDA1EedHLO/6TE+NCOFjYFpWSyYuwxESfIbNxRLOtHe1FfN55GeiKDDXy3AM5XAWM6hsAtUiE0sTzN/ypq0e5kuBDT/UqirI3XjtKxOR5egO6g+CLlynvsIW6zAIw5X9peeXy73qbo+JgdaZ/wU9syoIPYQNgizOS5nS5k5SRsrgvkFw32PdQ+po41f9zpbEoT6IxldVbD4hoel8R83NTlRsuJSj//GlTAK5Q3FqzUNcJOxA5QG+c03ihJP1BRbf3a8/vWuhW3lSgv/JGY+ban2bP/d6i0qTmmntSkNYmKK3EHL67mYQg9YrmV1enHyJfu3J00Ur2a4huE0OPaX5h7JilY/JwfYW69OEjNTOVYp0330uoX1e9k/O2tHMCStul2BeIFg/jRYJbhqSsbUKJRA3QZcFoDj2ApwrosglbQoUmjne1lprPoUyWuwMPtP7cIOE2geFdJP9WVZVOfvKUcXYpDQJOcCTciVBqUBnkhe/YL62ArZQhbgaxfsF1bOogrtOwS377pPWI5E4xHakmapsIr24U63VC3NLGRzzF+b9i3gPnKu+auDvTWM7v/YkzHsmUpeLzGubYXaG7BNqsiD0ril89hNOq7YnAFIusfYc0RXpYwhpVXkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(4326008)(83380400001)(54906003)(52536014)(186003)(478600001)(110136005)(2906002)(316002)(9686003)(107886003)(122000001)(8676002)(7696005)(71200400001)(86362001)(33656002)(8936002)(66556008)(64756008)(66476007)(66446008)(38100700002)(76116006)(6506007)(66946007)(55016002)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c21mZFNYSGpxeWpiQWNwTTJmK2RDTmR5UzBRNnlMZ1NPalNCVTAzVlFtV2V3?=
 =?utf-8?B?MC9IVk5EN00zZXdEOE5aTXlVVzRNdzV4citXNWxDU0g5d1BqLzBsRGh0WEo2?=
 =?utf-8?B?MEZnRDAySHFHVStjNElRb3RaR2RQNFpjRlcwVE85RDFUQ2ZPa056ZitRYnk3?=
 =?utf-8?B?M05wOHFDSTBNV3dpT1h2QlMyRzJWN2MzWGJkdnBORTdmTlVUSG9EVzBKblBh?=
 =?utf-8?B?UFdYbStjekNzd0ZZbzJOYlY2VHZQTk9GbVVCR2pyT0VpRERiMi9hNUJJK0FF?=
 =?utf-8?B?c044ZDYyS0cyRWZjUEJrQUdGZW9EaG5Uc1NEdFdodjBHbzI1eStPcVoybkly?=
 =?utf-8?B?UUVhQzJaWHh1RkJESWZianprazNpMFVPN3ZLREFtdUxkekd2VlJlZWp5Z29Z?=
 =?utf-8?B?Vm9iVVNzSEVuZGluWkl2QmlHZ1Zhd3RlVGZKbUhnaHJRUG5UOU5EeFZ1NFQz?=
 =?utf-8?B?cW5ETGhFdGFFL1RyNGY5bFlZZENxS1dzb0JpMUpIV3lqWExMYzJLZTJicjc0?=
 =?utf-8?B?M2lHQllWeVJraXpNWWpXcnhSZDBnaG1RQnhWakVHNlhCNnlkOWV0MFh2N1NM?=
 =?utf-8?B?QlFXSFU5K1BSbFV4aWhTK05FZGR0cDRSYUcwZnVZZFlGanZpd21hcHlHSDZ4?=
 =?utf-8?B?L0dHSXZlRXlyS2s4VTUzMWpoaTVKQlM0U3RrTVNyT20vT2ZQbGoxdGFqd3M2?=
 =?utf-8?B?dXBqR3ZQWG94MkM4MDVHam41c2xjZFlza2pZdXZsUkJnRVowK1NwMTBtMVph?=
 =?utf-8?B?MkdJRzUveGxkN3JFV1ZpdEpUUk5LNnRIRm80M2JNaUJSK0pnTTFMWWErWEts?=
 =?utf-8?B?WlA1N0ZUMFB0LzVxaG9SSFBPZ1AybXpVa0FYaU5xTlhBZVdLa253aUMzNWdt?=
 =?utf-8?B?T2dEME9FRVlSdGxKQjYwNlZiUEtVZ2VCYTErL1FXaTBJKzVQcWtjQ0FqRkZ4?=
 =?utf-8?B?S1lYUTNUNWkrakZKYkkxYkErV3BCQkdOTWhqQmhXVXlLb3pXb3BQQ2tvSzlv?=
 =?utf-8?B?SHJnTnIzcWF2QkY5amNLTVZuMWIyQ3hFdzg3VU5pMTFNU0VrNkFxUGR5a0E1?=
 =?utf-8?B?Z2JFZFJvZXVhNHJuUlhUZVRmektpUjJXR05kRndVbU4xbDFydXBDaFhiT2lP?=
 =?utf-8?B?RTUzd0FtY0JTTWFsSEFxL0NoV3B2OVlFcG1YVkZTbDJiK0RVNWR0elloSzFp?=
 =?utf-8?B?aHB3S3RCNzBlL0NOckc1VUNwdElLVTVFWVcwa29vYjgxZFhQU2wyczJFUzBO?=
 =?utf-8?B?THhVUnVtV1VIWlNCYklxNDg4cXFEckJiQW15VzBkaEEvS3JINkIxZ0xMNVYv?=
 =?utf-8?B?akRVMDRYTzI4UkV3RWJyMlJFZG9DeFdGUTB6OXpmV3ZBN05lNVQwMDBxL2xz?=
 =?utf-8?B?b1l2MUFjeERWL0J5Nlo0d0RLYlVSU2xCQUFYUk13WUo5SnhVMWt3djJEcFJJ?=
 =?utf-8?B?NVlvVC9xcE5NeDRnMnk0NnVFdGluYnBLR255ekphQnp5V0hqMEQraENGeUVu?=
 =?utf-8?B?aHNVMnV6TjU4RnpKam00UUJFTVRmczNKYXhHTHNvY1lzSTcvdUFpeW1KR3pO?=
 =?utf-8?B?S2MybldaQU1nczBURnV0TUlHbVVRMCthdlFOUER3enA5c2M1S1lrUVdFSG8v?=
 =?utf-8?B?WkdQMGhMVjl0RXppcEhndEU5OEFhNmVlY0ovMi9vN0FBU1UwOGJSS0xtZ1RV?=
 =?utf-8?B?a3BycFM4MzNYSFdmQmJHbVE4S2FIS094MUdZd21zYUl1RUFRUkhOckg5S1hh?=
 =?utf-8?Q?geX5cbZyUWwt/liFjwWUK+mqWgWNyFf17qg9Xnl?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6823b7-8be2-4de0-a293-08d936e5f999
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 07:59:21.1058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RjwctPtzAx82qhMi35mFHoqIvsMzx3SwlHekRIYkmad91nKobZF0qIubtf6GR0x1OD1y08KohgsOeu4nQztrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5404
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

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEp1bmUgMjQsIDIwMjEgMTI6MzUgUE0NCj4gDQo+ID4+IENvbnNpZGVyIHdlIGhhZCBh
IG1hdHVyZSBzZXQgb2YgdmlydGlvIHNwZWNpZmljIHVBUEkgZm9yIGNvbmZpZyBzcGFjZS4NCj4g
Pj4gSXQgd291bGQgYmUgYSBidXJkZW4gaWYgd2UgbmVlZCBhbiB1bm5lY2Vzc2FyeSB0cmFuc2xh
dGlvbiBsYXllciBvZg0KPiA+PiBuZXRsaW5rIGluIHRoZSBtaWRkbGU6DQo+ID4+DQo+ID4+IFt2
RFBBIHBhcmVudCAodmlydGlvX25ldF9jb25maWcpXSA8LT4gW25ldGxpbmsNCj4gPj4gKFZEUEFf
QVRUUl9ERVZfTkVUX1hYKV0gPC0+IFt1c2Vyc3BhY2UNCj4gKFZEUEFfQVRUUl9ERVZfTkVUX1hY
KV0NCj4gPj4+IDwtPiBbIHVzZXIgKHZpcnRpb19uZXRfY29uZmlnKV0NCj4gPiBUaGlzIHRyYW5z
bGF0aW9uIGlzIG5vdCB0aGVyZS4gV2Ugc2hvdyByZWxldmFudCBuZXQgY29uZmlnIGZpZWxkcyBh
cw0KPiBWRFBBX0FUVFJfREVWX05FVCBpbmRpdmlkdWFsbHkuDQo+ID4gSXQgaXMgbm90IGEgYmlu
YXJ5IGR1bXAgd2hpY2ggaXMgaGFyZGVyIGZvciB1c2VycyB0byBwYXJzZSBhbmQgbWFrZSBhbnkg
dXNlDQo+IG9mIGl0Lg0KPiANCj4gDQo+IFRoZSBpcyBkb25lIGltcGxpY2l0bHksIHVzZXIgbmVl
ZHMgdG8gdW5kZXJzdGFuZCB0aGUgc2VtYW50aWMgb2YNCj4gdmlydGlvX25ldF9jb25maWcgYW5k
IG1hcCB0aGUgaW5kaXZpZHVhbCBmaWVsZHMgdG8gdGhlIHZkcGEgdG9vbCBzdWItDQo+IGNvbW1h
bmQuDQpNb3N0bHkgbm90IHZpcnRpb19uZXRfY29uZmlnIGlzIGZvciB0aGUgcHJvZHVjZXIgYW5k
IGNvbnN1bWVyIHN3IGVudGl0aWVzLg0KSGVyZSB1c2VyIGRvZXNuJ3Qga25vdyBhYm91dCBzdWNo
IGxheW91dCBhbmQgd2hlcmUgaXRzIGxvY2F0ZWQuDQpVc2VyIG9ubHkgc2V0cyBjb25maWcgcGFy
YW1zIHRoYXQgZ2V0cyBzZXQgaW4gdGhlIGNvbmZpZyBzcGFjZS4NCih3aXRob3V0IHVuZGVyc3Rh
bmRpbmcgd2hhdCBpcyBjb25maWcgbGF5b3V0IGFuZCBpdHMgbG9jYXRpb24pLg0KDQo+IA0KPiAN
Cj4gPg0KPiA+IEl0IGlzIG9ubHkgb25lIGxldmVsIG9mIHRyYW5zbGF0aW9uIGZyb20gdmlydGlv
X25ldF9jb25maWcgKGtlcm5lbCkgLT4gbmV0bGluaw0KPiB2ZHBhIGZpZWxkcy4NCj4gPiBJdCBp
cyBzaW1pbGFyIHRvICdzdHJ1Y3QgbmV0ZGV2aWNlJyAtPiBydG5sIGluZm8gZmllbGRzLg0KPiAN
Cj4gDQo+IEkgdGhpbmsgbm90LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBuZXRkZXZpY2UgaXMg
bm90IGEgcGFydCBvZiB1QVBJIGJ1dA0KPiB2aXJ0aW9fbmV0X2NvbmZpZyBpcy4NClZpcnRpb19u
ZXRfY29uZmlnIGlzIGEgVUFQSSBmb3Igc3cgY29uc3VtcHRpb24uDQpUaGF0IHdheSB5ZXMsIG5l
dGxpbmsgY2FuIGFsc28gZG8gaXQsIGhvd2V2ZXIgaXQgcmVxdWlyZXMgc2lkZSBjaGFubmVsIGNv
bW11bmljYXRlIHdoYXQgaXMgdmFsaWQuDQoNCj4gDQo+IA0KPiA+DQo+ID4+IElmIHdlIG1ha2Ug
bmV0bGluayBzaW1wbHkgYSB0cmFuc3BvcnQsIGl0IHdvdWxkIGJlIG11Y2ggZWFzaWVyLiBBbmQg
d2UNCj4gaGFkDQo+ID4+IHRoZSBjaGFuY2UgdG8gdW5pZnkgdGhlIGxvZ2ljIG9mIGJ1aWxkX2Nv
bmZpZygpIGFuZCBzZXRfY29uZmlnKCkgaW4gdGhlDQo+IGRyaXZlci4NCj4gPiBIb3c/IFdlIG5l
ZWQgYml0IG1hc2sgdG8gdGVsbCB0aGF0IG91dCBvZiAyMSBmaWVsZHMgd2hpY2ggZmllbGRzIHRv
IHVwZGF0ZQ0KPiBhbmQgd2hpY2ggbm90Lg0KPiA+IEFuZCB0aGF0IGlzIGZ1cnRoZXIgbWl4ZWQg
d2l0aCBvZmZzZXQgYW5kIGxlbmd0aC4NCj4gDQo+IA0KPiBTbyBzZXRfY29uZmlnKCkgY291bGQg
YmUgY2FsbGVkIGZyb20gdXNlcnNwYWNlLCBzbyBkaWQgYnVpbGRfY29uZmlnKCkuDQo+IFRoZSBv
bmx5IGRpZmZlcmVuY2UgaXM6DQo+IA0KPiAxKSB0aGV5J3JlIHVzaW5nIGRpZmZlcmVudCB0cmFu
c3BvcnQsIGlvY3RsIHZzIG5ldGxpbmsNCj4gMikgYnVpbGRfY29uZmlnKCkgaXMgb25seSBleHBl
Y3RlZCB0byBiZSBjYWxsZWQgYnkgdGhlIG1hbmFnZW1lbnQgdG9vbA0KPiANCj4gSWYgcWVtdSB3
b3JrcyB3ZWxsIHZpYSBzZXRfY29uZmlnIGlvY3RsLCBuZXRsaW5rIHNob3VsZCB3b3JrIGFzIHdl
bGwuDQo+IA0KbWx4NSBzZXRfY29uZmlnIGlzIG5vb3AuDQp2ZHBhX3NldF9jb25maWcoKSBuZWVk
IHRvIHJldHVybiBhbiBlcnJvciBjb2RlLiBJIGRvbid0IA0KdnBfdmRwYS5jIGJsaW5kbHkgd3Jp
dGVzIHRoZSBjb25maWcgYXMgaXRzIHBhc3N0aHJvdWdoLg0KUGFyc2luZyB3aGljaCBmaWVsZHMg
dG8gd3JpdGUgYW5kIHdoaWNoIG5vdCwgdXNpbmcgb2Zmc2V0IGFuZCBsZW5ndGggaXMgYSBtZXNz
eSBjb2RlIHdpdGggdHlwZWNhc3QgYW5kIGNvbXBhcmUgb2xkIHZhbHVlcyBldGMuDQoNCj4gQnR3
LCB3aGF0IGhhcHBlbnMgaWYgbWFuYWdlbWVudCB0b29sIHRyaWVzIHRvIG1vZGlmeSB0aGUgbWFj
IG9mIHZEUEENCj4gd2hlbiB0aGUgZGV2aWNlIGlzIGFscmVhZHkgdXNlZCBieSB0aGUgZHJpdmVy
Pw0KQXQgcHJlc2VudCBpdCBhbGxvd3MgbW9kaWZ5aW5nLCBidXQgaXQgc2hvdWxkIGJlIGltcHJv
dmVkIGluIGZ1dHVyZSB0byBmYWlsIGlmIGRldmljZSBpcyBpbiB1c2UuDQoNCj4gPj4+PiBBbmQg
YWN0dWFsbHksIGl0J3Mgbm90IHRoZSBiaW5hcnkgYmxvYiBzaW5jZSB1YXBpIGNsZWFybHkgZGVm
aW5lIHRoZQ0KPiA+Pj4+IGZvcm1hdCAoZS5nIHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyksIGNh
biB3ZSBmaW5kIGEgd2F5IHRvIHVzZSB0aGF0Pw0KPiA+Pj4+IEUuZyBpbnRyb2R1Y2UgZGV2aWNl
L25ldCBzcGVjaWZpYyBjb21tYW5kIGFuZCBwYXNzaW5nIHRoZSBibG9iIHdpdGgNCj4gPj4+PiBs
ZW5ndGggYW5kIG5lZ290aWF0ZWQgZmVhdHVyZXMuDQo+ID4+PiBMZW5ndGggbWF5IGNoYW5nZSBp
biBmdXR1cmUsIG1vc3RseSBleHBhbmQuIEFuZCBwYXJzaW5nIGJhc2VkIG9uDQo+IGxlbmd0aA0K
PiA+PiBpcyBub3Qgc3VjaCBhIGNsZWFuIHdheS4NCj4gPj4NCj4gPj4NCj4gPj4gTGVuZ3RoIGlz
IG9ubHkgZm9yIGxlZ2FsIGNoZWNraW5nLiBUaGUgY29uZmlnIGlzIHNlbGYgY29udGFpbmVkIHdp
dGg6DQo+ID4+DQo+ID4gVW5saWtlbHkuIFdoZW4gc3RydWN0dXJlIHNpemUgaW5jcmVhc2VzIGxh
dGVyLCB0aGUgcGFyc2luZyB3aWxsIGNoYW5nZSBiYXNlZA0KPiBvbiB0aGUgbGVuZ3RoLg0KPiA+
IEJlY2F1c2Ugb2xkZXIga2VybmVsIHdvdWxkIHJldHVybiBzaG9ydGVyIGxlbmd0aCB3aXRoIG9s
ZGVyIGlwcm91dGUyIHRvb2wuDQo+IA0KPiANCj4gVGhpcyBpcyBmaW5lIHNpbmNlIHRoZSBvbGRl
ciBrZXJuZWwgb25seSBzdXBwb3J0IGxlc3MgZmVhdHVyZXMuIFRoZSBvbmx5DQo+IHBvc3NpYmxl
IGlzc3VlIGlmIHRoZSBvbGQgaXByb3V0ZSAyIHJ1bnMgb24gbmV3IGtlcm5lbC4gV2l0aCB0aGUg
Y3VycmVudA0KPiBwcm9wb3NhbCwgaXQgbWF5IGNhdXNlIHNvbWUgY29uZmlnIGZpZWxkcyBjYW4n
dCBub3QgYmUgc2hvd2VkLg0KPiANCk5vdCBzaG93aW5nIGlzIG9rLg0KQnV0IHRoZSBjb2RlIGlz
IG1lc3N5IHRvIHR5cGVjYXN0IG9uIHNpemUuDQoNCj4gSSB0aGluayBpdCBtaWdodCBiZSB1c2Vm
dWwgdG8gaW50cm9kdWNlIGEgY29tbWFuZCB0byBzaW1wbHkgZHVtcCB0aGUNCj4gY29uZmlnIHNw
YWNlLg0KPiANCj4gDQo+ID4gU28gdXNlciBzcGFjZSBhbHdheXMgaGF2ZSB0byBkZWFsIGFuZCBo
YXZlIG5hc3R5IHBhcnNpbmcvdHlwZWNhc3RpbmcNCj4gYmFzZWQgb24gdGhlIGxlbmd0aC4NClN1
Y2ggbmFzdHkgcGFyc2luZyBpcyBub3QgcmVxdWlyZWQgZm9yIG5ldGxpbmsgaW50ZXJmYWNlLg0K
DQo+IA0KPiANCj4gVGhhdCdzIGhvdyB1c2Vyc3BhY2UgKFFlbXUpIGlzIGV4cGVjdGVkIHRvIHdv
cmsgbm93LiBUaGUgdXNlcnNwYWNlDQo+IHNob3VsZCBkZXRlcm1pbmUgdGhlIHNlbWFudGljIG9m
IHRoZSBmaWVsZHMgYmFzZWQgb24gdGhlIGZlYXR1cmVzLg0KPiANCj4gRGlmZmVyZW50aWF0ZSBj
b25maWcgZmllbGRzIGRvZXNuJ3QgaGVscCBtdWNoLCBlLmcgdXNlcnNwYWNlIHN0aWxsIG5lZWQN
Cj4gdG8gZGlmZmVyIExJTktfVVAgYW5kIEFOTk9VTkNFIGZvciB0aGUgc3RhdHVzIGZpZWxkLg0K
WWVzLCB0aGlzIHBhcnNpbmcgaXMgZnJvbSBjb25zdGFudCBzaXplIHUxNiBzdGF0dXMuDQo+IA0K
PiANClsuLl0NCg0KPg0KPiA+IEl0cyBub3QgYWJvdXQgcGVyZm9ybWFuY2UuIEJ5IHRoZSB0aW1l
IDFzdCBjYWxsIGlzIG1hZGUsIGZlYXR1cmVzIGdvdA0KPiB1cGRhdGVkIGFuZCBpdCBpcyBvdXQg
b2Ygc3luYyB3aXRoIGNvbmZpZy4NCj4gPg0KPiA+PiAxKSBnZXQgY29uZmlnDQo+ID4+IDIpIGdl
dCBkZXZpY2UgaWQNCj4gPj4gMykgZ2V0IGZlYXR1cmVzDQo+ID4+DQo+ID4gVGhpcyByZXF1aXJl
cyB1c2luZyBmZWF0dXJlcyBmcm9tIDNyZCBuZXRsaW5rIG91dHB1dCB0byBkZWNvZGUgb3V0cHV0
IG9mDQo+IDFzdCBuZXRsaW5rIG91dHB1dC4NCj4gPiBXaGljaCBpcyBhIGJpdCBvZGQgb2YgbmV0
bGluay4NCj4gPiBPdGhlciBuZXRsaW5rIG5sYV9wdXQoKSBwcm9iYWJseSBzZW5kaW5nIHdob2xl
IHN0cnVjdHVyZSBkb2VzbuKAmXQgbmVlZCB0bw0KPiBkbyBpdC4NCj4gDQo+IA0KPiBXZWxsLCB3
ZSBjYW4gcGFjayB0aGVtIGFsbCBpbnRvIGEgc2luZ2xlIHNrYiBpc24ndCBpdD8gKHByb2JhYmx5
IHdpdGggYQ0KPiBjb25maWcgbGVuKS4NCj4gDQpZb3Ugd2FudCB0byBwYWNrIGZlYXR1cmVzIGFu
ZCBjb25maWcgYm90aCBpbiB0aGUgc2luZ2xlIG5sYV9wdXQoKT8NCklmIHNvLCBpdCBpc24ndCBu
ZWNlc3NhcnkuIFRoZXJlIGFyZSBtb3JlIGV4YW1wbGVzIGluIGtlcm5lbCB0aGF0IGFkZHMgaW5k
aXZpZHVhbCBmaWVsZHMgaW5zdGVhZCBvZiBubGFfcHV0KGJsb2IpLg0KSSB3b3VsZG7igJl0IGZv
bGxvdyB0aG9zZSBubGFfcHV0KCkgY2FsbGVycy4NCg0KPiANCj4gPg0KPiA+PiBGb3IgYnVpbGQg
Y29uZmlnLCBpdCdzIG9ubHkgb25lDQo+ID4+DQo+ID4+IDEpIGJ1aWxkIGNvbmZpZw0KPiA+Pg0K
PiA+Pg0KPiA+Pj4gSSBwcmVmZXIgdG8gZm9sbG93IHJlc3Qgb2YgdGhlIGtlcm5lbCBzdHlsZSB0
byByZXR1cm4gc2VsZiBjb250YWluZWQNCj4gPj4gaW52aWRpdmlkdWFsIGZpZWxkcy4NCj4gPj4N
Cj4gPj4NCj4gPj4gQnV0IEkgc2F3IGEgbG90IG9mIGtlcm5lbCBjb2RlcyBjaG9vc2UgdG8gdXNl
IGUuZyBubGFfcHV0KCkgZGlyZWN0bHkgd2l0aA0KPiA+PiBtb2R1bGUgc3BlY2lmaWMgc3RydWN0
dXJlLg0KPiA+Pg0KPiA+IEl0IG1pZ2h0IGJlIHNlbGYtY29udGFpbmVkIHN0cnVjdHVyZSB0aGF0
IHByb2JhYmx5IGhhcyBub3QgZm91bmQgdGhlIG5lZWQNCj4gdG8gZXhwYW5kLg0KPiANCj4gDQo+
IEkgdGhpbmsgaXQncyBqdXN0IGEgbWF0dGVyIG9mIHB1dHRpbmcgdGhlIGNvbmZpZyBsZW5ndGgg
d2l0aCB0aGUgY29uZmlnDQo+IGRhdGEuIE5vdGUgdGhhdCB3ZSd2ZSBhbHJlYWR5IGhhZCAuZ2V0
X2NvbmZpZ19zaXplKCkgb3BzIGZvciB2YWxpZGF0aW5nDQo+IGlucHV0cyB0aHJvdWdoIFZIT1NU
X1NFVF9DT05GSUcvVkhPU1RfR0VUX0NPTkZJRy4NClRoaXMgbGVuZ3RoIGNvbWVzIGFzIHBhcnQg
b2YgdGhlIG5ldGxpbmsgaW50ZXJmYWNlIGFscmVhZHksIG5vIG5lZWQgZm9yIGV4dHJhIGxlbmd0
aC4NClRoZSB3aG9sZSBwb2ludCBpcyB0byBhdm9pZCBwYXJzaW5nIGJhc2VkIG9uIGxlbmd0aC4N
CldlIGNhbm5vdCBjaGFuZ2UgdGhlIHZpcnRpb19uZXRfY29uZmlnIFVBUEkgaW4gdXNlLCBidXQg
bmV0bGluayBjb2RlIGRvZXNu4oCZdCBuZWVkIHRvIGJlIGJvdW5kIHRvIHNpemUgYmFzZWQgdHlw
ZWNhc3RpbmcgYW5kIGNvbXBhcmUgZmllbGRzIGR1cmluZyBidWlsZF9jb25maWcoKS4NCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
