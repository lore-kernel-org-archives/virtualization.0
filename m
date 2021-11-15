Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 07:02:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA7061AA5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 07:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAA7061AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 891EC40445;
	Mon, 15 Nov 2021 07:02:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2kqkI60lg9ec; Mon, 15 Nov 2021 07:02:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3604C40442;
	Mon, 15 Nov 2021 07:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0191FC001E;
	Mon, 15 Nov 2021 07:02:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99529C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 07:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D32B40432
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 07:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DW4eybZUTgCk
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 07:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC89040430
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 07:02:15 +0000 (UTC)
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
 by Forcepoint Email with ESMTPS id F0ECD788F5EDFD490879;
 Mon, 15 Nov 2021 15:02:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 15 Nov 2021 15:02:13 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 15 Nov 2021 15:02:13 +0800
From: "Liu,Feng(INF)" <liufeng32@baidu.com>
To: Jason Wang <jasowang@redhat.com>
Subject: =?utf-8?B?562U5aSNOiBxdWVzdGlvbiBhYm91dCB2ZHBhX21nbXRfZGV2?=
Thread-Topic: question about vdpa_mgmt_dev
Thread-Index: AdfZ4sMOlabm7KnAQ6a4Hg+80hubZf//iSKA//9xexA=
Date: Mon, 15 Nov 2021 07:02:13 +0000
Message-ID: <4db91875f3424ff184188f68ee4e31e1@baidu.com>
References: <10b3825413da4a73ac8cdce9eca5e860@baidu.com>
 <CACGkMEszkt9w9sbSqT9kAE+t=cm5S48rc6bnvGpYy_rvFEXjhw@mail.gmail.com>
In-Reply-To: <CACGkMEszkt9w9sbSqT9kAE+t=cm5S48rc6bnvGpYy_rvFEXjhw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.205.44]
MIME-Version: 1.0
Cc: "virtualization@lists.linux-foundation.org"
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SmFzb24NCglJdCdzIGNsZWFyLCB0aGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KVGhhbmtzDQpG
ZW5nDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyMeW5tDEx5pyIMTXml6Ug
MTQ6MzENCj4g5pS25Lu25Lq6OiBMaXUsRmVuZyhJTkYpIDxsaXVmZW5nMzJAYmFpZHUuY29tPg0K
PiDmioTpgIE6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IOS4
u+mimDogUmU6IHF1ZXN0aW9uIGFib3V0IHZkcGFfbWdtdF9kZXYNCj4gDQo+IE9uIE1vbiwgTm92
IDE1LCAyMDIxIGF0IDI6MDggUE0gTGl1LEZlbmcoSU5GKSA8bGl1ZmVuZzMyQGJhaWR1LmNvbT4N
Cj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBFeHBlcnRzDQo+ID4gICAgICAgICBJIGhhdmUgcmVhZCB0
aGUgdXBzdHJlYW0gY29kZSBhYm91dCB2ZHBhLCBhbmQgSSBub3RpY2UgdGhhdA0KPiB0aGVyZSBp
cyBhIG5ldyBzdHJ1Y3QgdmRwYV9tZ210X2RldiBoYXZlIGJlZW4gYWRkZWQuDQo+ID4gICAgICAg
ICBFdmVyeSBkcml2ZXIgaW1wbGVtZW50cyBkZXZfYWRkKCkgaW50ZXJmYWNlLCBzdWNoIGFzIG1s
eDUgdXNlDQo+IG1seDVfdmRwYV9kZXZfYWRkKCkuIFRoaXMgaW50ZXJmYWNlIGNvbXBsZXRlcyB0
aGUgY3JlYXRpb24gb2YgdGhlIHZkcGENCj4gZGV2aWNlLCBoYXJkd2FyZSBpbml0aWFsaXphdGlv
biBhbmQgc3lzdGVtIHJlZ2lzdHJhdGlvbi4gQW5kIEkgZm91bmQgdGhhdCBvbmx5DQo+IG5ldGxp
bmsgd2lsbCBjYWxsIHRoZSBkZXZfYWRkKCkgaW50ZXJmYWNlLCBpbiB2ZHBhX25sX2NtZF9kZXZf
YWRkX3NldF9kb2l0KCkuDQo+IFdoaWxlIHRoZSBwcm9iZSgpIGZ1bmN0aW9uIGp1c3QgcmVnaXN0
ZXIgdmRwYV9tZ210X2RldiB3aXRob3V0IGNhbGwNCj4gZGV2X2FkZCgpDQo+ID4gICAgICAgICBT
bywgbXkgcXVlc3Rpb25zIGFyZToNCj4gPiAgICAgICAgIERvZXMgaXQgY3JlYXRlIGEgdmRwYSBk
ZXZpY2Ugb25seSB0aHJvdWdoIHRoZSBuZXRsaW5rIGludGVyZmFjZT8NCj4gDQo+IFllcywgdGhp
cyBpcyB0aGUgcGxhbiwgYW5kIHdlJ3JlIHdvcmtpbmcgb24gY29udmVydGluZyBhbGwgdGhlIGRy
aXZlcnMgdG8NCj4gc3VwcG9ydCB0aGF0Lg0KPiANCj4gPiBUaGUgc3lzdGVtIHNjYW5zIHRoZSBQ
Q0kgZGV2aWNlIGFuZCBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5IGNyZWF0ZSB0aGUNCj4gY29ycmVz
cG9uZGluZyB2ZHBhIGRldmljZT8NCj4gDQo+IEl0J3MgYSBjaG9pY2UgZm9yIHRoZSB2RFBBIHBh
cmVudCBkcml2ZXIgYnV0IHdlIHN1Z2dlc3QgY3JlYXRpbmcgdkRQQSB2aWENCj4gbmV0bGluaygp
LCB0aGlzIGdpdmVzIGEgcGVyc2lzdGVudCBtZXRob2QgZm9yIHRoZSBtYW5hZ2VtZW50IGxheWVy
Lg0KPiANCj4gVGhhbmtzDQo+IA0KPiA+DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBGZW5nDQo+ID4N
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
