Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC9FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 06:58:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31DB61C14
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 06:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F31DB61C14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B605940173;
	Mon, 15 Nov 2021 06:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zqUF8PsOcBB8; Mon, 15 Nov 2021 06:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A87640141;
	Mon, 15 Nov 2021 06:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC22C001E;
	Mon, 15 Nov 2021 06:58:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30F09C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C73C6075F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:58:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6aiQj4p0kkh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:58:12 +0000 (UTC)
X-Greylist: delayed 01:05:40 by SQLgrey-1.8.0
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3CED6075A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:58:12 +0000 (UTC)
Received: from BC-Mail-Ex27.internal.baidu.com (unknown [172.31.51.21])
 by Forcepoint Email with ESMTPS id 01D2D5228B479DA181C0;
 Mon, 15 Nov 2021 14:58:07 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex27.internal.baidu.com (172.31.51.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 15 Nov 2021 14:58:06 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Mon, 15 Nov 2021 14:58:06 +0800
From: "Liu,Feng(INF)" <liufeng32@baidu.com>
To: Jason Wang <jasowang@redhat.com>
Subject: =?utf-8?B?562U5aSNOiBxdWVzdGlvbiBhYm91dCB2ZHBhX21nbXRfZGV2?=
Thread-Topic: question about vdpa_mgmt_dev
Thread-Index: AdfZ4sMOlabm7KnAQ6a4Hg+80hubZf//iSKA//9yeiA=
Date: Mon, 15 Nov 2021 06:58:06 +0000
Message-ID: <d80cd5e13867416fad4ad23313004cee@baidu.com>
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

SmFzb24NCglUaGFua3MgZm9yIHlvdXIgY29tbWVudHMNCg0KVGhhbmtzDQpGZW5nDQoNCj4gLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAyMeW5tDEx5pyIMTXml6UgMTQ6MzENCj4g5pS2
5Lu25Lq6OiBMaXUsRmVuZyhJTkYpIDxsaXVmZW5nMzJAYmFpZHUuY29tPg0KPiDmioTpgIE6IHZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IOS4u+mimDogUmU6IHF1
ZXN0aW9uIGFib3V0IHZkcGFfbWdtdF9kZXYNCj4gDQo+IE9uIE1vbiwgTm92IDE1LCAyMDIxIGF0
IDI6MDggUE0gTGl1LEZlbmcoSU5GKSA8bGl1ZmVuZzMyQGJhaWR1LmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPiBIaSBFeHBlcnRzDQo+ID4gICAgICAgICBJIGhhdmUgcmVhZCB0aGUgdXBzdHJlYW0g
Y29kZSBhYm91dCB2ZHBhLCBhbmQgSSBub3RpY2UgdGhhdA0KPiB0aGVyZSBpcyBhIG5ldyBzdHJ1
Y3QgdmRwYV9tZ210X2RldiBoYXZlIGJlZW4gYWRkZWQuDQo+ID4gICAgICAgICBFdmVyeSBkcml2
ZXIgaW1wbGVtZW50cyBkZXZfYWRkKCkgaW50ZXJmYWNlLCBzdWNoIGFzIG1seDUgdXNlDQo+IG1s
eDVfdmRwYV9kZXZfYWRkKCkuIFRoaXMgaW50ZXJmYWNlIGNvbXBsZXRlcyB0aGUgY3JlYXRpb24g
b2YgdGhlIHZkcGENCj4gZGV2aWNlLCBoYXJkd2FyZSBpbml0aWFsaXphdGlvbiBhbmQgc3lzdGVt
IHJlZ2lzdHJhdGlvbi4gQW5kIEkgZm91bmQgdGhhdCBvbmx5DQo+IG5ldGxpbmsgd2lsbCBjYWxs
IHRoZSBkZXZfYWRkKCkgaW50ZXJmYWNlLCBpbiB2ZHBhX25sX2NtZF9kZXZfYWRkX3NldF9kb2l0
KCkuDQo+IFdoaWxlIHRoZSBwcm9iZSgpIGZ1bmN0aW9uIGp1c3QgcmVnaXN0ZXIgdmRwYV9tZ210
X2RldiB3aXRob3V0IGNhbGwNCj4gZGV2X2FkZCgpDQo+ID4gICAgICAgICBTbywgbXkgcXVlc3Rp
b25zIGFyZToNCj4gPiAgICAgICAgIERvZXMgaXQgY3JlYXRlIGEgdmRwYSBkZXZpY2Ugb25seSB0
aHJvdWdoIHRoZSBuZXRsaW5rIGludGVyZmFjZT8NCj4gDQo+IFllcywgdGhpcyBpcyB0aGUgcGxh
biwgYW5kIHdlJ3JlIHdvcmtpbmcgb24gY29udmVydGluZyBhbGwgdGhlIGRyaXZlcnMgdG8NCj4g
c3VwcG9ydCB0aGF0Lg0KPiANCj4gPiBUaGUgc3lzdGVtIHNjYW5zIHRoZSBQQ0kgZGV2aWNlIGFu
ZCBkb2VzIG5vdCBhdXRvbWF0aWNhbGx5IGNyZWF0ZSB0aGUNCj4gY29ycmVzcG9uZGluZyB2ZHBh
IGRldmljZT8NCj4gDQo+IEl0J3MgYSBjaG9pY2UgZm9yIHRoZSB2RFBBIHBhcmVudCBkcml2ZXIg
YnV0IHdlIHN1Z2dlc3QgY3JlYXRpbmcgdkRQQSB2aWENCj4gbmV0bGluaygpLCB0aGlzIGdpdmVz
IGEgcGVyc2lzdGVudCBtZXRob2QgZm9yIHRoZSBtYW5hZ2VtZW50IGxheWVyLg0KPiANCj4gVGhh
bmtzDQo+IA0KPiA+DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBGZW5nDQo+ID4NCg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
