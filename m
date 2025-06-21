Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CA1A23B6
	for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497682; cv=none; b=ikckKn6/LImOz4NYbyjSyLYcRMu+hBD3vRovC7Nn4uheOz0UtbiP3SD6Pczpgr18n+sJdAjjUSZPmhFnbo6vv7HT7c0MQLaKV7LeI3T+Yd7ZURbrGgzskRor/LQKRGWVxS8FitCMceYSrgRGGdNzFYkKtzh1+bks5vdhDSFlhPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497682; c=relaxed/simple;
	bh=IW7isRjTLoW+T4/DV/HZq1QMYESTQizLyehDftMSoyU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYUvmCKGsMwZfa6VavfdhlwnLTEubsSvc0jnFytHxDYP0jq+Kj90Hcs51CpbAGbZmMWdH0AbkbHndYBTnsPsBl4JCAdwfr5dRCEmc2fNRUmBCkmoJI/cSGtpJQfkFmnA2Vbtxl50BWZavwkHKW+EphOz53EDk9oLgNAbtGi+1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "vgoyal@redhat.com" <vgoyal@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB2aXJ0aW9fZnM6IFJlbW92ZSByZXF1ZXN0IGFkZGl0?=
 =?gb2312?Q?ion_to_processing_list?=
Thread-Topic: [PATCH] virtio_fs: Remove request addition to processing list
Thread-Index: AQHb4dlpUCyax0B+7UiUt1kRzbOkt7QNVxZw
Date: Sat, 21 Jun 2025 09:21:12 +0000
Message-ID: <9f6cfbeb39ac477e80a3cdd7ce31d48e@baidu.com>
References: <20250620114925.2671-1-lirongqing@baidu.com>
In-Reply-To: <20250620114925.2671-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.51.56
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IFNpbmNlIHZpcnRpb19mcyBkb2VzIG5vdCB1dGlsaXplIHRoZSBmdXNlX3BxdWV1ZS0+cHJv
Y2Vzc2luZyBsaXN0LCB3ZSBjYW4gc2FmZWx5DQo+IG9taXQgYWRkaW5nIHJlcXVlc3RzIHRvIHRo
aXMgbGlzdC4gVGhpcyBjaGFuZ2UgZWxpbWluYXRlcyB0aGUgYXNzb2NpYXRlZA0KPiBzcGluX2xv
Y2sgb3BlcmF0aW9ucywgdGhlcmVieSBpbXByb3ZpbmcgcGVyZm9ybWFuY2UuDQo+IA0KDQoNCnBs
ZWFzZSBpZ25vcmUgdGhpcyBtYWlsLCBzb3JyeSBmb3IgdGhlIG5vaXNlLCBJIG1pc3VuZGVyc3Rh
bmQgDQoNCg0KLUxpDQo=
