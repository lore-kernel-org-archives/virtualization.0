Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3157333
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714770688; cv=none; b=ezW0B7PbR2e0cW6NmsIn33hAI9uvxd6Qd0erU48Ey0JocLutnxlo7UHk7Sls7yYeWthyDOcHb21KHuUFgHFDiAp0mYYOQFZNhG/LsQGXJPRCsDJORqPLQBFJtU0g/WeUuargH737huge8PNRzsvXZLbz+xwbNasGHbOdrsV5TqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714770688; c=relaxed/simple;
	bh=GQMl/ZMjQH+yE6pO5lv00tf82rh65qrvDhQORINV/U8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ff5JzIaMzndIepM3+Y65qk5xe1URsseoRmyq42hkwkdtLgasWvHwmUXzpQ9/IsyHUVEn98CXm1ZrkVbeQLyUpOvHAJ+84S8Ax7h4MmvWJBGHbI5Fl2zutJgJwn2hV4KrML5PwumXeeiXDgZe+3erORqiWszKIElq0xWu2SFDUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA278607B9
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 21:11:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fkz5CM0tToga for <virtualization@lists.linux-foundation.org>;
 Fri,  3 May 2024 21:11:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.58.86.151; helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4B810606FF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B810606FF
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B810606FF
	for <virtualization@lists.linux-foundation.org>; Fri,  3 May 2024 21:11:23 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-241-Q1lJQQW8PeWRE9Y4W_F7wg-1; Fri, 03 May 2024 22:11:20 +0100
X-MC-Unique: Q1lJQQW8PeWRE9Y4W_F7wg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 3 May
 2024 22:10:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 3 May 2024 22:10:53 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHexhPrXlAAAq+3cA=
Date: Fri, 3 May 2024 21:10:53 +0000
Message-ID: <a2c35933c3de481faec0b201ab1a0c16@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <9d4024ba-6422-4775-b934-bfa80a72a858@redhat.com>
 <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
In-Reply-To: <16557e30-8353-4cd1-995b-23ec763d2b07@redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMDMgTWF5IDIwMjQgMTc6MDANCi4uLg0KPiBEYXZp
ZCwNCj4gDQo+IENvdWxkIHlvdSByZXNwaW4gdGhlIHNlcmllcyBiYXNlZCBvbiB0aGUgbGF0ZXN0
IHVwc3RyZWFtIGNvZGU/DQoNCkkndmUganVzdCByZWFwcGxpZWQgdGhlIHBhdGNoZXMgdG8gJ21h
c3RlcicgYW5kIHRoZXkgYWxsIGFwcGx5DQpjbGVhbmx5IGFuZCBkaWZmaW5nIHRoZSBuZXcgcGF0
Y2hlcyB0byB0aGUgb2xkIG9uZXMgZ2l2ZXMgbm8gZGlmZmVyZW5jZXMuDQpTbyBJIHRoaW5rIHRo
ZXkgc2hvdWxkIHN0aWxsIGFwcGx5Lg0KDQpXZXJlIHlvdSBzZWVpbmcgYSBzcGVjaWZpYyBwcm9i
bGVtPw0KDQpJIGRvbid0IHJlbWVtYmVyIGFueSBzdWdnZXN0ZWQgY2hhbmdlZCBlaXRoZXIuDQoo
QXBhcnQgZnJvbSBhIHZlcnkgbG9jYWwgdmFyaWFibGUgSSB1c2VkIHRvIGtlZXAgYSBwYXRjaCBp
c29sYXRlZC4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

