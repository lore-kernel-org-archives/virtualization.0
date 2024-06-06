Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E58EEDB
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642224; cv=none; b=fqmvGWW3tiqla9ne/LrSbRLgIa1EjNMzyorv0zNpiW+i3QOaFbDgZmFqFFIHRT3abXpXBAU03C30ELsRitVApB9XLGffwgnT+Wi/ypX1p2ZuIXKRg8ZzPYt/P25Wy8p2BJtLFqEhaqsUYZ0Y+5kJEKhgqSh6guUT0b5Q0Vi67AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642224; c=relaxed/simple;
	bh=Drt8AOP+XZfdMVCj3qu0cVyUD3OYs4OfTxOsXxiVk3E=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=YFp6cPdfzHF3pSzKzxHj5Sdyb8+PUKxtKyocQ9gErAO+/hD+0cwG3bBrEeLZlloLdakW0TyH7C84pPPmK9isbYoykQeiO6RvWYFkU4h1knEz/A4CZaRJoxlkoqrduW9+V3jy36huzBPwlnmy1nPnLt6PPW8M2bwV/pUtYEXs40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7f58565e23af11ef9305a59a3cc225df-20240606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:20e6044c-b319-443c-94c8-4e89e187f3af,IP:20,
	URL:0,TC:16,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:31
X-CID-INFO: VERSION:1.1.38,REQID:20e6044c-b319-443c-94c8-4e89e187f3af,IP:20,UR
	L:0,TC:16,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:31
X-CID-META: VersionHash:82c5f88,CLOUDID:7999dd9a4e5afa53e73f53f368c24e64,BulkI
	D:2406061050165QCTDKIB,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,TC:0
	,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 7f58565e23af11ef9305a59a3cc225df-20240606
Received: from node4.com.cn [(39.156.73.12)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1277897102; Thu, 06 Jun 2024 10:50:13 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 3352616002081;
	Thu,  6 Jun 2024 10:50:13 +0800 (CST)
Received: by node4.com.cn (NSMail, from userid 0)
	id 29BDB16002081; Thu,  6 Jun 2024 10:50:13 +0800 (CST)
From: =?UTF-8?B?5bSU5rab?= <cuitao@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSB0b29scy92aXJ0aW86IFVzZSB0aGUgX19HRlBfWkVSTyBmbGFnIG9mIGttYWxsb2MgdG8gY29tcGxldGUgdGhlIG1lbW9yeSBpbml0aWFsaXphdGlvbi4=?=
To: 	=?UTF-8?B?amFzb3dhbmc=?= <jasowang@redhat.com>,
Cc: 	=?UTF-8?B?bXN0?= <mst@redhat.com>,
	=?UTF-8?B?dmlydHVhbGl6YXRpb24=?= <virtualization@lists.linux.dev>,
	=?UTF-8?B?eHVhbnpodW8=?= <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?B?ZXBlcmV6bWE=?= <eperezma@redhat.com>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>,
Date: Thu, 06 Jun 2024 10:50:12 +0800
X-Mailer: NSMAIL 7.0.0
Message-ID: <27dbkaepjvt-27de461jnje@nsmail7.0.0--kylin--1>
References: CACGkMEvB4MoGqqOLvNyY8css8kq56-D5J2M4VZCM1AfGCojiRw@mail.gmail.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Thu, 06 Jun 2024 10:50:12 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-2an7umb8d0s-2anaehy2god
X-ns-mid: webmail-666123e4-2a79lwl3
X-ope-from: <cuitao@kylinos.cn>

This message is in MIME format.

--nsmail-2an7umb8d0s-2anaehy2god
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHA+U29ycnksIHRoaXMgaXMgYSBzdHVwaWQgbWlzdGFrZS48L3A+CjxwPiZu
YnNwOzwvcD4KPHA+SSB3b25kZXIgaWYgdGhlIGdmcCBwYXJhbWV0ZXIgaW4g
c3RhdGljIGlubGluZSB2b2lkICprbWFsbG9jKHNpemVfdCBzLCBnZnBfdCBn
ZnApIGNhbiBiZSBkZWxldGVkIGlmIGl0IGlzIG5vdCB1c2VkLjwvcD4KPHA+
Jm5ic3A7PC9wPgo8cD5PciB3b3VsZCBiZSBiZXR0ZXIgdG8gbW92ZSBtZW1z
ZXQgdG8ga21hbGxvYy48L3A+CjxwPkxpa2UgdGhpczo8L3A+CjxwPiNkZWZp
bmUgX19HRlBfWkVSTyAweDE8L3A+CjxwPnN0YXRpYyBpbmxpbmUgdm9pZCAq
a21hbGxvYyhzaXplX3QgcywgZ2ZwX3QgZ2ZwKTwvcD4KPHA+ezwvcD4KPHA+
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBub3JtYWw7Ij48c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+dm9pZCAqcDs8L3NwYW4+
PC9wPgo8cD48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6IG5vcm1hbDsiPjxz
cGFuIHN0eWxlPSJ3aGl0ZS1zcGFjZTogcHJlOyI+IDwvc3Bhbj5pZiAoX19r
bWFsbG9jX2Zha2UpPC9zcGFuPjwvcD4KPHA+PHNwYW4gc3R5bGU9IndoaXRl
LXNwYWNlOiBub3JtYWw7Ij48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6IHBy
ZTsiPiA8L3NwYW4+cmV0dXJuIF9fa21hbGxvY19mYWtlOzwvc3Bhbj48L3A+
CjxwPiZuYnNwOzwvcD4KPHA+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBu
b3JtYWw7Ij48c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3Nw
YW4+cCA9IG1hbGxvYyhzKTs8L3NwYW4+PC9wPgo8cD48c3BhbiBzdHlsZT0i
d2hpdGUtc3BhY2U6IG5vcm1hbDsiPjxzcGFuIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTogcHJlOyI+IDwvc3Bhbj5pZiAoIXApPC9zcGFuPjwvcD4KPHA+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOiBub3JtYWw7Ij48c3BhbiBzdHlsZT0id2hp
dGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+Jm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7IHJldHVybiBwOzwvc3Bhbj48L3A+CjxwPiZuYnNwOzwvcD4KPHA+
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBub3JtYWw7Ij48c3BhbiBzdHls
ZT0id2hpdGUtc3BhY2U6IHByZTsiPiA8L3NwYW4+aWYgKGdmcCAmYW1wOyBf
X0dGUF9aRVJPKTwvc3Bhbj48L3A+CjxwPjxzcGFuIHN0eWxlPSJ3aGl0ZS1z
cGFjZTogbm9ybWFsOyI+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOiBwcmU7
Ij4gPC9zcGFuPm1lbXNldChwLCAwLCBzKTs8L3NwYW4+PC9wPgo8cD48c3Bh
biBzdHlsZT0id2hpdGUtc3BhY2U6IG5vcm1hbDsiPjxzcGFuIHN0eWxlPSJ3
aGl0ZS1zcGFjZTogcHJlOyI+IDwvc3Bhbj5yZXR1cm4gcDs8L3NwYW4+PC9w
Pgo8cD59PC9wPgo8cD4tLS0tPC9wPgo8ZGl2IGlkPSJjczJjX21haWxfc2ln
YXR1cmUiPjwvZGl2Pgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9InJlIiBzdHls
ZT0ibWFyZ2luLWxlZnQ6IDAuNWVtOyBwYWRkaW5nLWxlZnQ6IDAuNWVtOyBi
b3JkZXItbGVmdDogMXB4IHNvbGlkIGdyZWVuOyI+PGJyPjxicj48YnI+Cjxk
aXYgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6ICNmNWY3ZmE7Ij48c3Ryb25n
PuS4u+OAgOmimO+8mjwvc3Ryb25nPjxzcGFuIGlkPSJzdWJqZWN0Ij5SZTog
W1BBVENIXSB0b29scy92aXJ0aW86IFVzZSB0aGUgX19HRlBfWkVSTyBmbGFn
IG9mIGttYWxsb2MgdG8gY29tcGxldGUgdGhlIG1lbW9yeSBpbml0aWFsaXph
dGlvbi48L3NwYW4+IDxicj48c3Ryb25nPuaXpeOAgOacn++8mjwvc3Ryb25n
PjxzcGFuIGlkPSJkYXRlIj4yMDI0LTA2LTA2IDA4OjI5PC9zcGFuPiA8YnI+
PHN0cm9uZz7lj5Hku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iZnJvbSI+
amFzb3dhbmc8L3NwYW4+IDxicj48c3Ryb25nPuaUtuS7tuS6uu+8mjwvc3Ry
b25nPjxzcGFuIGlkPSJ0byIgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFs
bDsiPuW0lOa2mzs8L3NwYW4+PC9kaXY+Cjxicj4KPGRpdiBpZD0iY29udGVu
dCI+CjxkaXYgY2xhc3M9InZpZXdlcl9wYXJ0IiBzdHlsZT0icG9zaXRpb246
IHJlbGF0aXZlOyI+CjxkaXY+T24gV2VkLCBKdW4gNSwgMjAyNCBhdCA5OjU2
4oCvUE0gY3VpdGFvIHdyb3RlOjxicj4mZ3Q7PGJyPiZndDsgVXNlIHRoZSBf
X0dGUF9aRVJPIGZsYWcgb2Yga21hbGxvYyB0byBpbml0aWFsaXplIG1lbW9y
eSB3aGlsZSBhbGxvY2F0aW5nIGl0LDxicj4mZ3Q7IHdpdGhvdXQgdGhlIG5l
ZWQgZm9yIGFuIGFkZGl0aW9uYWwgbWVtc2V0IGNhbGwuPGJyPiZndDs8YnI+
Jmd0OyBTaWduZWQtb2ZmLWJ5OiBjdWl0YW8gPGJyPiZndDsgLS0tPGJyPiZn
dDsgdG9vbHMvdmlydGlvL2xpbnV4L2tlcm5lbC5oIHwgNSArLS0tLTxicj4m
Z3Q7IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlv
bnMoLSk8YnI+Jmd0Ozxicj4mZ3Q7IGRpZmYgLS1naXQgYS90b29scy92aXJ0
aW8vbGludXgva2VybmVsLmggYi90b29scy92aXJ0aW8vbGludXgva2VybmVs
Lmg8YnI+Jmd0OyBpbmRleCA2NzAyMDA4ZjdmNWMuLjllNDAxZmI3YzIxNSAx
MDA2NDQ8YnI+Jmd0OyAtLS0gYS90b29scy92aXJ0aW8vbGludXgva2VybmVs
Lmg8YnI+Jmd0OyArKysgYi90b29scy92aXJ0aW8vbGludXgva2VybmVsLmg8
YnI+Jmd0OyBAQCAtNjYsMTAgKzY2LDcgQEAgc3RhdGljIGlubGluZSB2b2lk
ICprbWFsbG9jX2FycmF5KHVuc2lnbmVkIG4sIHNpemVfdCBzLCBnZnBfdCBn
ZnApPGJyPiZndDs8YnI+Jmd0OyBzdGF0aWMgaW5saW5lIHZvaWQgKmt6YWxs
b2Moc2l6ZV90IHMsIGdmcF90IGdmcCk8YnI+Jmd0OyB7PGJyPiZndDsgLSB2
b2lkICpwID0ga21hbGxvYyhzLCBnZnApOzxicj4mZ3Q7IC08YnI+Jmd0OyAt
IG1lbXNldChwLCAwLCBzKTs8YnI+Jmd0OyAtIHJldHVybiBwOzxicj4mZ3Q7
ICsgcmV0dXJuIGttYWxsb2MocywgZ2ZwIHwgX19HRlBfWkVSTyk7PGJyPiZn
dDsgfTxicj4mZ3Q7PGJyPiZndDsgc3RhdGljIGlubGluZSB2b2lkICphbGxv
Y19wYWdlc19leGFjdChzaXplX3QgcywgZ2ZwX3QgZ2ZwKTxicj4mZ3Q7IC0t
PGJyPiZndDsgMi4yNS4xPGJyPiZndDs8YnI+PGJyPkRvZXMgdGhpcyByZWFs
bHkgd29yaz88YnI+PGJyPmV4dGVybiB2b2lkICpfX2ttYWxsb2NfZmFrZSwg
Kl9fa2ZyZWVfaWdub3JlX3N0YXJ0LCAqX19rZnJlZV9pZ25vcmVfZW5kOzxi
cj5zdGF0aWMgaW5saW5lIHZvaWQgKmttYWxsb2Moc2l6ZV90IHMsIGdmcF90
IGdmcCk8YnI+ezxicj5pZiAoX19rbWFsbG9jX2Zha2UpPGJyPnJldHVybiBf
X2ttYWxsb2NfZmFrZTs8YnI+cmV0dXJuIG1hbGxvYyhzKTs8YnI+fTxicj48
YnI+VGhhbmtzPGJyPjxicj48L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4=


--nsmail-2an7umb8d0s-2anaehy2god--
