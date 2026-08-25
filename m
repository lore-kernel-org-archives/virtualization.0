Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C953DB63D
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645656; cv=none; b=HyYCz/qnGbfQaDAPTzyHRL5Vs4rMX4EZQOH4+lt3Iy8GQA/hoj50fZLg9jacHHBf8Kr4sJ+AJQl4ewDpGVxwFupOJNjpzqhWqeuAugCyaxwl02P1GOBh9T/2fU6h1bLZve9lXBXdi/rKJaRAqau3XVeZ/XDLUAIIcIQyExy7j2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645656; c=relaxed/simple;
	bh=vmeagQmHgmqDHl8uivB7+4iX27w03s0n3GIWhsfm/74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=APJg3eis+Oump1eFrqzGiH0f1UgL7xCE7OGNriy1CJPjoPZineKmAiIFzDnZFKdGxaJjhanbhJ6RoBWY108WaQs6D7SKiqOmBdusj+Y97psfqcp6fr1sER8eRT8Ptpz3yCBaMfO34LXj0wg/BmHaeFU289ocQW8LbSShnfZQQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=INLxCGra; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="INLxCGra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vmeagQmHgmqDHl8uivB7+4iX27w03s0n3GIWhsfm/74=; b=I
	NLxCGra9hbCS+gqxSrumDKMHO21KhwCXx/VQJkt7z30b+UUceFrIjGCJsq5bLyU3
	vCOoyyY8Mw0XpJl5H153+mlw3FGqtoLn9web9yNBy0b4U+MOiXd9ruxiEnkusXyv
	wSB8LxL7KHTLIh84Xhj+Mrq1jhvncsbtuy1qIwNZwA=
Received: from lange_tang$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Tue, 25 Aug 2026 16:13:44 +0800
 (CST)
Date: Tue, 25 Aug 2026 16:13:44 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH v2] virtio_net: add rx-alloc-fail counter
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260824112050.02623327@kernel.org>
References: <20260820060929.69576-1-lange_tang@163.com>
 <20260824112050.02623327@kernel.org>
X-NTES-SC: AL_Qu2TBfqfuk4p4iaYYukfmUgRg+c/XsK4svUj24VVOJF8jC/r2DghekBCPHTT4v2hKSq0sRGoVgBV4edDU4lKergrdrroI039T0SXu0yFrclJYw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <60cd1569.6b2c.1a037fb8129.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jygvCgDn_4K5To1qpFE4AA--.4873W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-Rm-7WqNTrmjxwAA3C
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOC0yNSAwMjoyMDo1MCwgIkpha3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIFRodSwgMjAgQXVnIDIwMjYgMTQ6MDk6MjkgKzA4MDAgTG9uZ2p1biBUYW5n
IHdyb3RlOgo+PiBDb3VudCB0aGUgY2FzZXMgd2hlcmUgdGhlIGRyaXZlciBmYWlscyB0byBhbGxv
Y2F0ZSBhIGJ1ZmZlciBvciBhbiBza2IsCj4+IHN1Y2ggYXMgd2hlbiB0cnlfZmlsbF9yZWN2KCkg
ZmFpbHMgd2l0aCBFTk9NRU0sIGFuZCByZXBvcnQgdGhlbSB2aWEgdGhlCj4+IHJ4LWFsbG9jLWZh
aWwgcXN0YXQuCj4+IAo+PiBQbHVtYiBhbGxvYy1mYWlsIGludG8gdmlydG5ldF9nZXRfYmFzZV9z
dGF0cygpIHRvIGtlZXAgdGhpcyBuZXcgc3RhdAo+PiByZXBvcnRlZCBjb25zaXN0ZW50bHkgYXQg
Ym90aCBxdWV1ZSBhbmQgZGV2aWNlIHNjb3BlLCBtYXRjaGluZyBob3cKPj4gcGFja2V0cywgYnl0
ZXMsIHN0b3AgYW5kIHdha2UgYXJlIGhhbmRsZWQuCj4KPlRoZSBzdGF0cyBoYW5kbGluZyBpbiB2
aXJ0aW9fbmV0IGlzIHN1cGVyIGNvbnZvbHV0ZWQgYnV0IEFGQUlDVAo+eW91ciBwYXRjaCBpcyBn
b29kLiBVbmZvcnR1bmF0ZWx5LCBuZXQtbmV4dCBpcyBjbG9zZWQgcmlnaHQgbm93Cj4obWVyZ2Ug
d2luZG93KSB0byB5b3Ugd2lsbCBoYXZlIHRvIHJlcG9zdCBuZXh0IHdlZWsuCj4KPk1heWJlIHlv
dSBjYW4gdHJ5IHRvIGNvdmVyIG1vcmUgYWxsb2NhdGlvbiBmYWlsdXJlcyBwZXI6Cj5odHRwczov
L25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0Y2hzZXQvMjAyNjA4MjAwNjA5
MjkuNjk1NzYtMS1sYW5nZV90YW5nQDE2My5jb20KPk9yIGFkZCBhIHNlbnRlbmNlIG9yIHR3byB0
byB0aGUgY29tbWl0IG1lc3NhZ2UgdGhhdCB3ZSBkbyBub3QgaW50ZW5kCj50byBjb3ZlciAxMDAl
IG9mIGNhc2VzIHdoZXJlIHBhY2tldCBpcyBkcm9wcGVkLgoKVGhhbmsgeW91IGZvciB5b3VyIHJl
dmlldyBhbmQgcmVwbHkuCkkgd2lsbCByZXBvc3QgdjMgbmV4dCB3ZWVrIGFuZCBhZGQgc29tZSBk
ZXNjcmlwdGlvbiB0byB0aGUgY29tbWl0IG1lc3NhZ2U6ClRoaXMgY291bnRlciBkb2VzIG5vdCBj
b3ZlciBldmVyeSBhbGxvY2F0aW9uIGZhaWx1cmUgaW4gYWxsIFJYIHBhdGhzLgpJdCBpcyBpbnRl
bnRpb25hbGx5IGxpbWl0ZWQgdG8gdGhlIGNvbW1vbiBza2IgYW5kIFJYIGJ1ZmZlciBhbGxvY2F0
aW9uCnBhdGhzIHRvIGtlZXAgaXRzIG1lYW5pbmcgY2xlYXIuCgp0aGFua3MuCkxvbmdqdW4gVGFu
Zw==
