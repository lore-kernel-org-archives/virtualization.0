Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A500EC63797
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 08:45:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F0061351
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 08:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F0061351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07C75608B1;
	Thu, 22 Jul 2021 08:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NtdjMkUaAwgr; Thu, 22 Jul 2021 08:45:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7C7E608B0;
	Thu, 22 Jul 2021 08:45:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F143C001A;
	Thu, 22 Jul 2021 08:45:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C53C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2841608B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D6D1LPEjQpYW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:45:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE7CA6074A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 08:45:47 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-h0lw6uECM3eZnQ-erC7drw-1; Thu, 22 Jul 2021 09:45:44 +0100
X-MC-Unique: h0lw6uECM3eZnQ-erC7drw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 22 Jul 2021 09:45:42 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 22 Jul 2021 09:45:42 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yunsheng Lin' <linyunsheng@huawei.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 3/4] tools headers UAPI: add cpu_relax() implementation
 for x86 and arm64
Thread-Topic: [PATCH v2 3/4] tools headers UAPI: add cpu_relax()
 implementation for x86 and arm64
Thread-Index: AQHXfQ/RMbMxcgsnGkW4/hrjrWfzM6tN6faQgACviYCAABYlkA==
Date: Thu, 22 Jul 2021 08:45:42 +0000
Message-ID: <9e76aac65edc4d88b141d79496ae3fdf@AcuMS.aculab.com>
References: <1626747709-34013-1-git-send-email-linyunsheng@huawei.com>
 <1626747709-34013-4-git-send-email-linyunsheng@huawei.com>
 <5db490c6f264431e91bcdbb62fcf3be5@AcuMS.aculab.com>
 <9efd2434-feac-a385-f3c5-4a0fb0cc7706@huawei.com>
In-Reply-To: <9efd2434-feac-a385-f3c5-4a0fb0cc7706@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Cc: "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "deanbo422@gmail.com" <deanbo422@gmail.com>,
 "nickhu@andestech.com" <nickhu@andestech.com>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "joe@perches.com" <joe@perches.com>,
 "ndesaulniers@gooogle.com" <ndesaulniers@gooogle.com>,
 "green.hu@gmail.com" <green.hu@gmail.com>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
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

PiA+IEJld2FyZSwgSW50ZWwgaW5jcmVhc2VkIHRoZSBzdGFsbCBmb3IgJ3JlcCBub3AnIGluIHNv
bWUgcmVjZW50DQo+ID4gY3B1IHRvIElJUkMgYWJvdXQgMjAwIGN5Y2xlcy4NCj4gPg0KPiA+IFRo
ZXkgZXZlbiBkb2N1bWVudCB0aGF0IHRoaXMgbWlnaHQgaGF2ZSBhIGRldHJpbWVudGFsIGVmZmVj
dC4NCj4gPiBJdCBpcyBiYXNpY2FsbHkgZmFyIHRvbyBsb25nIGZvciB0aGUgc29ydCBvZiB0aGlu
ZyBpdCBtYWtlcw0KPiA+IHNlbnNlIHRvIGJ1c3ktd2FpdCBmb3IuDQo+IA0KPiBUaGFua3MgZm9y
IHRoZSBpbmZvOikNCj4gSSB3aWxsIGJlIGJld2FyZSBvZiB0aGF0IHdoZW4gcGxheWluZyB3aXRo
ICAncmVwIG5vcCcgaW4gbmV3ZXINCj4geDg2IGNwdS4NCg0KU2VlIDguNC43IFBhdXNlIExhdGVu
Y3kgaW4gU2t5bGFrZSBNaWNyb2FyY2hpdGVjdHVyZSBpbg0KSW50ZWzCriA2NCBhbmQgSUEtMzIg
QXJjaGl0ZWN0dXJlcyBPcHRpbWl6YXRpb24gUmVmZXJlbmNlIE1hbnVhbA0KDQpUaGUgbGF0ZW5j
eSBvZiBQQVVTRSBpbnN0cnVjdGlvbiBpbiBwcmlvciBnZW5lcmF0aW9uIG1pY3JvYXJjaGl0ZWN0
dXJlDQppcyBhYm91dCAxMCBjeWNsZXMsIHdoZXJlYXMgb24gU2t5bGFrZSBtaWNyb2FyY2hpdGVj
dHVyZSBpdCBoYXMgYmVlbg0KZXh0ZW5kZWQgdG8gYXMgbWFueSBhcyAxNDAgY3ljbGVzLg0KDQpB
biBlYXJsaWVyIHNlY3Rpb24gZG9lcyBleHBsYWluIHdoeSB5b3UgbmVlZCBwYXVzZSB0aG91Z2gu
DQpPbmUgb2YgaXRzIGVmZmVjdHMgaXMgdG8gc3RvcCB0aGUgY3B1IHNwZWN1bGF0aXZlbHkgZXhl
Y3V0aW5nDQptdWx0aXBsZSBpdGVyYXRpb25zIG9mIHRoZSB3YWl0IGxvb2sgLSBlYWNoIHdpdGgg
aXRzIG93bg0KcGVuZGluZyByZWFkIG9mIHRoZSBtZW1vcnkgbG9jYXRpb24gdGhhdCBpcyBiZWlu
ZyBsb29rZWQgYXQuDQpVbndpbmRpbmcgdGhhdCBpc24ndCBmcmVlIC0gYW5kIHdhcyBwYXJ0aWN1
bGFybHkgZXhwZW5zaXZlIG9uDQpQNCBOZXRidXJzdCAtIHdoYXQgYSBzdXJwcmlzZSwgdGhleSBy
YW4gZXZlcnl0aGluZyBleGNlcHQNCmJlbmNobWFyayBsb29rcyB2ZXJ5IHNsb3dseS4NCg0KCURh
dmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3Vu
dCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3
Mzg2IChXYWxlcykNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
