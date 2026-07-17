Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECF35959
	for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254644; cv=none; b=A1UeWtNLlu+lNQNDguswYjzRexiHp0HdLTIU3lez0dBPhdwZFhcVHt8JtW+5mDaW2x8ifExvL08sddtnwWXBrNuZDfx7sh3JyZomr6Txx76iPg8atE1v3Ph7IWJh6R/TR71VT52JTxavWvl7ez2vZdcxAk3evwlY/x7Zpx528vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254644; c=relaxed/simple;
	bh=xDgkpvNQqfHrhFey0IHivSOFo7DoPR4Zz2HXVwGF/DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BMuu+s6Ic8lyvVcCY7VodN1giz5Mb87ywoh8JsdNthfdT5FBi5hqx66hd4/TXBY3QJ3d/PudrfPiWxD407hFiweQeLjf/YhllRj8dSmyuqxBcldHL8VJ7qzhysYfSxi55SL7EzOGtMryv9tVjplRkoBXvcI3nD8OUhMQzJUk8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IQeZTsDF; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IQeZTsDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=xDgkpvNQqfHrhFey0IHivSOFo7DoPR4Zz2HXVwGF/DU=; b=I
	QeZTsDFHbvDpDAe5i7omm9x5a0ghyqbd3fwZ+f5GtrGTQD1Kfyu5UWoyEIlZBkSb
	y3C7/1v8740EnTtoyf3HEQitF8MOHhGKozA6bYRkW8nycBN+5piSs2QjEAeBELet
	Q8k0Nr8XZ0WFw+YKxGYo88Mua8pfP1Gx4kJRhg3NCY=
Received: from xiongwm2026$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Fri, 17 Jul 2026 10:17:11 +0800
 (CST)
Date: Fri, 17 Jul 2026 10:17:11 +0800 (CST)
From: "Weimin Xiong" <xiongwm2026@163.com>
To: eperezma@redhat.com
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com,
	netdev@vger.kernel.org, kvm@vger.kernel.org, xiongweimin@kylinos.cn
Subject: Re: Re: [PATCH] vhost-vdpa: propagate set_map error to caller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
References: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
X-NTES-SC: AL_Qu2TBv6eu04o5yeRbekckk8Ugeg8Xsewsvgh249ec+IEgC3DxAc7ZUV/JFL5+t+2BASjkwWLfTtNyOVnb4ZZTET/v5QqVaNDtyH5WsdzUw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1f3989d4.1c32.19f6ddd0f7e.Coremail.xiongwm2026@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bSgvCgD3F3aokFlqhukfAA--.17787W
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7wg-zmpZkKiI6AAA39
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

RnJvbTogeGlvbmd3ZWltaW4gPHhpb25nd2VpbWluQGt5bGlub3MuY24+CgpIaSBFdWdlbmlvLAoK
VGhhbmtzIGZvciB5b3VyIHJldmlldyEKCllvdSBhcmUgcmlnaHQuIE15IG9yaWdpbmFsIHBhdGNo
IGhhcyBhbiBpc3N1ZSB3aXRoIHRoZSBgYnJlYWtgIHN0YXRlbWVudCwKd2hpY2ggc2tpcHMgdGhl
IGB2LT5pbl9iYXRjaCA9IGZhbHNlYCBhc3NpZ25tZW50IHdoZW4gYHNldF9tYXBgIGZhaWxzLgpU
aGUgY29ycmVjdCBhcHByb2FjaCBpcyB0byBzaW1wbHkgY2FwdHVyZSB0aGUgcmV0dXJuIHZhbHVl
IHdpdGhvdXQKYnJlYWtpbmc6CgpgYGBjCmNhc2UgVkhPU1RfSU9UTEJfQkFUQ0hfRU5EOgogICAg
aWYgKHYtPmluX2JhdGNoICYmIG9wcy0+c2V0X21hcCkKICAgICAgICByID0gb3BzLT5zZXRfbWFw
KHZkcGEsIGFzaWQsIGlvdGxiKTsKICAgIHYtPmluX2JhdGNoID0gZmFsc2U7CiAgICBicmVhazsK
YGBgCgpUaGlzIHdheToKMS4gVGhlIHJldHVybiB2YWx1ZSBvZiBgc2V0X21hcGAgaXMgcHJvcGFn
YXRlZCB0byB0aGUgY2FsbGVyCjIuIGB2LT5pbl9iYXRjaGAgaXMgYWx3YXlzIHJlc2V0LCByZWdh
cmRsZXNzIG9mIHN1Y2Nlc3Mgb3IgZmFpbHVyZQoKVXBkYXRlZCBwYXRjaCBhdHRhY2hlZCBiZWxv
dy4KCi0tLQoKU3ViamVjdDogW1BBVENIXSB2aG9zdC12ZHBhOiBwcm9wYWdhdGUgc2V0X21hcCBl
cnJvciB0byBjYWxsZXIKClRoZSByZXR1cm4gdmFsdWUgb2Ygb3BzLT5zZXRfbWFwKCkgaXMgY3Vy
cmVudGx5IGlnbm9yZWQgd2hlbiBoYW5kbGluZwpWSE9TVF9JT1RMQl9CQVRDSF9FTkQuIElmIHRo
ZSBiYWNrZW5kIGZhaWxzIHRvIHByb2dyYW0gdGhlIElPVExCLAp0aGUgVk1NIGluY29ycmVjdGx5
IGJlbGlldmVzIHRoZSBvcGVyYXRpb24gc3VjY2VlZGVkIGFuZCBtYXkgY29udGludWUKd2l0aCBz
dGFsZSBvciBpbmNvcnJlY3QgbWFwcGluZ3MuCgpQcm9wYWdhdGUgdGhlIGVycm9yIGZyb20gb3Bz
LT5zZXRfbWFwKCkgdG8gdGhlIGNhbGxlci4KClNpZ25lZC1vZmYtYnk6IHhpb25nd2VpbWluIDx4
aW9uZ3dlaW1pbkBreWxpbm9zLmNuPgotLS0KIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwppbmRleCBiYjk2
YjFhYTUuLmI1MmQ4ZDk0ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKKysrIGIv
ZHJpdmVycy92aG9zdC92ZHBhLmMKQEAgLTEyOTgsNyArMTI5OCw3IEBAIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9wcm9jZXNzX2lvdGxiX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHUzMiBhc2lk
LAogCQlicmVhazsKIAljYXNlIFZIT1NUX0lPVExCX0JBVENIX0VORDoKIAkJaWYgKHYtPmluX2Jh
dGNoICYmIG9wcy0+c2V0X21hcCkKLQkJCW9wcy0+c2V0X21hcCh2ZHBhLCBhc2lkLCBpb3RsYik7
CisJCQlyID0gb3BzLT5zZXRfbWFwKHZkcGEsIGFzaWQsIGlvdGxiKTsKIAkJdi0+aW5fYmF0Y2gg
PSBmYWxzZTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKLS0KMi4zOS4zCg==
