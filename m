Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB3438036
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108187; cv=none; b=I0Hq7l0HwlDPOuyoMiLaGqCXSTeSA3f2sYvdT+Pd3YfrNy/PadnUbWEIvVG53+C2qBPBY/mhcuABGBd5+41+KrYrjIOlzDDsSejDv3De3Sp5BRVcGe6CmaDbEaSIvUsQkWq+KGn2HmXpahSxRdl4wd0/0jE7PQURsHffpiO7JBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108187; c=relaxed/simple;
	bh=qCBEc0lLVnvyODJrSLVo6C8mYtRajqqgkMNuhL42ATc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lgzx+pjzYSAe6ZqKDs9XgVOoi20e7viYHOjRui1nVIvGUirj5xR4I4HmGB02EfjNCB9HBn/D5yctbVdE2KZVaZH4h5WyGpMyia3nnd4UdBAyOiw27wSXI+0RyZ0EADGawZrtwUyjWz/2C3VVhuEKHXDpAxTBLw5QTG9fnvLtznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JoIoeVJq; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JoIoeVJq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=qCBEc0lLVnvyODJrSLVo6C8mYtRajqqgkMNuhL42ATc=; b=J
	oIoeVJqXjjr3EMIpNjx6UW0N7MB68XCOEhPneZAvlH2mJp1p73MAnXlGkeDRisWv
	wGE4fjtsda/L6/j1JmK4/KWhi/qpMgT4qEvhKWSdczbK+dhQ3gsFSY1eHz6gTHj9
	ukT97lpoYMIhgfo215jUtGL7gPj+9Tb7P/tMSbE2to=
Received: from xiongwm2026$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-144 (Coremail) ; Wed, 15 Jul 2026 17:36:13 +0800
 (CST)
Date: Wed, 15 Jul 2026 17:36:13 +0800 (CST)
From: xiongwm2026  <xiongwm2026@163.com>
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev
Subject: Re:Re: [PATCH 01/12] vhost-scsi: improve BIDI operation comments
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <aldR5cNr3SlVoBX/@devvm29614.prn0.facebook.com>
References: <20260715080906.21689-1-xiongwm2026@163.com>
 <aldR5cNr3SlVoBX/@devvm29614.prn0.facebook.com>
X-NTES-SC: AL_Qu2TBv2bt0ks5SOQbOkckk8Ugeg8Xsewsvgh249ec+wGggHJyBoQb05hIkLH+sOFFRCKuSK5Xxdf6OZWUIZi2bSHs6jITa1Lh2yYqEp9Ew==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <54f9bf1c.87fc.19f65224854.Coremail.xiongwm2026@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:kCgvCgD3HzONVFdqxLoeAA--.12933W
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7w2oOGpXVI3ebgAA3m
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBCb2JieSwKCgpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4KCgpVbmRlcnN0b29kLiBJIHdp
bGwgZHJvcCB0aGlzIGNvbW1lbnQtb25seSBjaGFuZ2UgYW5kIGZvY3VzIG9uIGZpeGVzIHdpdGgK
YSBjb25jcmV0ZSBidWcgc2NlbmFyaW8gb3IgcmVwcm9kdWNlci4KCgpCZXN0LApXZWltaW4KCgpB
dCAyMDI2LTA3LTE1IDE3OjI0OjUzLCAiQm9iYnkgRXNobGVtYW4iIDxib2JieWVzaGxlbWFuQGdt
YWlsLmNvbT4gd3JvdGU6Cj5PbiBXZWQsIEp1bCAxNSwgMjAyNiBhdCAwNDowOTowNlBNICswODAw
LCBXZWltaW4gWGlvbmcgd3JvdGU6Cj4+IEZyb206IHhpb25nd2VpbWluIDx4aW9uZ3dtMjAyNkAx
NjMuY29tPgo+PiAKPj4gUmVwbGFjZSBGSVhNRSBjb21tZW50cyB3aXRoIGNsZWFyZXIgTm90ZSBj
b21tZW50cyBkb2N1bWVudGluZwo+PiB0aGF0IEJJREkgKGJpZGlyZWN0aW9uYWwpIG9wZXJhdGlv
bnMgYXJlIG5vdCB5ZXQgc3VwcG9ydGVkLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogV2VpbWluIFhp
b25nIDx4aW9uZ3dtMjAyNkAxNjMuY29tPgo+PiBDby1hdXRob3JlZC1ieTogQ3Vyc29yIDxjdXJz
b3JhZ2VudEBjdXJzb3IuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvdmhvc3Qvc2NzaS5jIHwgNCAr
Ky0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+
PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvc2NzaS5jIGIvZHJpdmVycy92aG9zdC9z
Y3NpLmMKPj4gaW5kZXggOWExMjUzYjlkLi44MWU5MDVjNGMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvdmhvc3Qvc2NzaS5jCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvc2NzaS5jCj4+IEBAIC0xMDQ3
LDcgKzEwNDcsNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF9zY3NpX3RhcmdldF9xdWV1ZV9jbWQoc3Ry
dWN0IHZob3N0X3Njc2lfbmV4dXMgKm5leHVzLAo+PiAgCXN0cnVjdCBzZV9jbWQgKnNlX2NtZCA9
ICZjbWQtPnR2Y19zZV9jbWQ7Cj4+ICAJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ19wdHIsICpzZ19w
cm90X3B0ciA9IE5VTEw7Cj4+ICAKPj4gLQkvKiBGSVhNRTogQklESSBvcGVyYXRpb24gKi8KPj4g
KwkvKiBOb3RlOiBCSURJIChiaWRpcmVjdGlvbmFsKSBvcGVyYXRpb25zIGFyZSBub3QgeWV0IHN1
cHBvcnRlZCAqLwo+PiAgCWlmIChjbWQtPnR2Y19zZ2xfY291bnQpIHsKPj4gIAkJc2dfcHRyID0g
Y21kLT50YWJsZS5zZ2w7Cj4+ICAKPj4gQEAgLTExNjgsNyArMTE2OCw3IEBAIHZob3N0X3Njc2lf
Z2V0X2Rlc2Moc3RydWN0IHZob3N0X3Njc2kgKnZzLCBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2
cSwKPj4gIAo+PiAgCS8qCj4+ICAJICogR2V0IHRoZSBzaXplIG9mIHJlcXVlc3QgYW5kIHJlc3Bv
bnNlIGJ1ZmZlcnMuCj4+IC0JICogRklYTUU6IE5vdCBjb3JyZWN0IGZvciBCSURJIG9wZXJhdGlv
bgo+PiArCSAqIE5vdGU6IFNpemUgY2FsY3VsYXRpb24gaXMgbm90IGNvcnJlY3QgZm9yIEJJREkg
b3BlcmF0aW9ucy4KPj4gIAkgKi8KPj4gIAl2Yy0+b3V0X3NpemUgPSBpb3ZfbGVuZ3RoKHZxLT5p
b3YsIHZjLT5vdXQpOwo+PiAgCXZjLT5pbl9zaXplID0gaW92X2xlbmd0aCgmdnEtPmlvdlt2Yy0+
b3V0XSwgdmMtPmluKTsKPj4gLS0gCj4+IDIuNDMuMAo+PiAKPgo+SGV5IFdlaW1pbiwKPgo+VGhp
cyBzZXJpZXMgaXMgcHJvYmFibHkgZ29pbmcgdG8gYmUgaWdub3JlZC4gQ29tbWVudC1vbmx5IGNo
YW5nZXMgYXJlCj5hbG1vc3QgbmV2ZXIgbWVyZ2VkLCBhbmQgdGhlIGNvZGUgY2hhbmdlcyBoZXJl
IGRvbid0IGxvb2sgbGlrZSBnZW51aW5lCj5idWdzLgo+Cj5JbiB0aGUgY2FzZSB0aGF0IHRoZXJl
IGFyZSBzb21lIHJlYWwgYnVncywgSSdkIHJlY29tbWVuZCB0byBzZXR1cCBhCj5zeXN0ZW0gYW5k
IHRyaWdnZXIgYSBidWcsIGFuZCBwcm92aWRlIGEgcmVwcm9kdWNlci4KPgo+QmVzdCwKPkJvYmJ5
Cg==
