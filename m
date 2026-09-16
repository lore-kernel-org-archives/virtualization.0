Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9619470122;
	Wed, 16 Sep 2026 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546578; cv=none; b=Uydt0L/t/SzXWDfgM1XD05p5xv9T2XnC+i4YgutjTWd6UwJEQU+tbfL2iZSVt3yxd1I/w8Hru91GdtQ9rdCm2LiQ3EonkAh/To+O09vJEnlrhUrn1CCCC9qhjbRyGxN5I9kaBkgEpoc6f9I6BSthnweaSNj5aW0zEAFf41FumkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546578; c=relaxed/simple;
	bh=vAWXRduAxp0wWtGfOedB7op+EeKTyWEO0yX9bqU7PbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IA3BOPsok4k/BnOGSp1JdL+/Xq6o6Z6QO7If/QEg4269KCkJCQXLh7pGXOSl2MyGrGrNURs8fWsbrgJQcYs28aIb/xJwqlKTcYk5ESPfTN7s1iYhN9MdDMkuqVfepk/RRUud5lfSkidOmLJ+NcubTrzwC2Ae1F4rzZHjL5hN6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b8pWtK8I; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b8pWtK8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=vAWXRduAxp0wWtGfOedB7op+EeKTyWEO0yX9bqU7PbE=; b=b
	8pWtK8IxkFFjGVaQ+WCi98ixN0FuQp08HwOhpt8phh7vfWRGc1xkRBQTwlNWddh7
	mlFH4jOMPvCRnPY1FekUZu9RvwGE4ZQn6IB9Qvl5PLhVBl4dB6Sqzg8POoJ9jfEw
	8lcYNLUPqerxhsv7Y+mp6I4GECpk5GUdAyidjs/u1g=
Date: Wed, 16 Sep 2026 16:15:56 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: sashiko-reviews@lists.linux.dev
Cc: "mst@redhat.com" <mst@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"Eugenio Perez" <eperezma@redhat.com>, jasowangio@gmail.com
Subject: Re:Re: [RFC RESEND 3/3] virtio_net: add rx_timeouts per-queue
 statistic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260909092718.D3F471F00A3D@smtp.kernel.org>
References: <20260908092646.108865-1-lange_tang@163.com>
 <20260908092646.108865-4-lange_tang@163.com>
 <20260909092718.D3F471F00A3D@smtp.kernel.org>
X-NTES-SC: AL_Qu2TC/mfuU0u4CiYZOkfmUgRg+c/XsK4svUj24VVOJF8jAzpyBAhV1Z6DWLQ/tCLEy6PoQevXydf1fl1T7tRbqch5YId3ASGf3q4U0pLl9bhlA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <47821357.7140.1a0a9496d89.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:fSgvCgDX30w9UKpqnQpIAA--.25917W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-R1olmqqUD12zwAA3K
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0wOS0wOSAxNzoyNzoxOCwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKPlRo
YW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEg
cG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOgo+LSBbSGlnaF0gQ29uY3VycmVudCB3cml0
ZXJzIHRvIHBlci1xdWV1ZSB1NjRfc3RhdHNfc3luYyBmcm9tIHRpbWVyIGNvbnRleHQgYW5kIE5B
UEkgdmlvbGF0ZSBtdXR1YWwgZXhjbHVzaW9uLgo+LS0KPgo+Y29tbWl0IDJlNWZhMjI5ZmY0Yzhj
NzczODQ4ZDBjMWYzNmIxNGMyZDJmMmVkZjcKPkF1dGhvcjogTG9uZ2p1biBUYW5nIDx0YW5nbG9u
Z2p1bkBreWxpbm9zLmNuPgo+Cj52aXJ0aW9fbmV0OiBhZGQgcnhfdGltZW91dHMgcGVyLXF1ZXVl
IHN0YXRpc3RpYwo+Cj5UaGlzIGNvbW1pdCBhZGRzIGFuIHJ4X3RpbWVvdXRzIGZpZWxkIHRvIHRo
ZSBwZXItcXVldWUgUlggc3RhdGlzdGljcy4KPkl0IGluY3JlbWVudHMgdGhlIGNvdW50ZXIgd2hl
biB0aGUgUlggd2F0Y2hkb2cgZmlyZXMgYW5kIGV4cG9zZXMgaXQKPnZpYSBldGh0b29sIHRvIHRy
YWNrIHBlci1xdWV1ZSBzdGFsbCBldmVudHMuCj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4KPlsg
Li4uIF0KPgo+PiBAQCAtMzA5NCw2ICszMDk3LDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcnhf
d2F0Y2hkb2coc3RydWN0IHRpbWVyX2xpc3QgKnQpCj4+ICAJCQl1bnNpZ25lZCBpbnQgc3RhbGxf
bXMgPQo+PiAgCQkJCWppZmZpZXNfdG9fbXNlY3MoamlmZmllcyAtIHJxLT53YXRjaGRvZ19qaWZm
aWVzKTsKPj4gIAo+PiArCQkJdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmcnEtPnN0YXRzLnN5bmNw
KTsKPj4gKwkJCXU2NF9zdGF0c19pbmMoJnJxLT5zdGF0cy5yeF90aW1lb3V0cyk7Cj4+ICsJCQl1
NjRfc3RhdHNfdXBkYXRlX2VuZCgmcnEtPnN0YXRzLnN5bmNwKTsKPgo+W1NldmVyaXR5OiBIaWdo
XQo+RG9lcyB0aGlzIGludHJvZHVjZSBhIHJhY2UgY29uZGl0aW9uIHdpdGggdGhlIE5BUEkgcG9s
bCBsb29wPwo+Cj5UaGUgdTY0X3N0YXRzX3N5bmMgQVBJIHJlcXVpcmVzIG11dHVhbGx5IGV4Y2x1
c2l2ZSB3cml0ZXJzIHBlciBzeW5jcC4KPlRoaXMgdGltZXIgY2FsbGJhY2sgKHZpcnRuZXRfcnhf
d2F0Y2hkb2cpIGV4ZWN1dGVzIGluIGEgZ2xvYmFsIHRpbWVyIHNvZnRpcnEKPmNvbnRleHQgb24g
YW4gYXJiaXRyYXJ5IENQVSBhbmQgd3JpdGVzIHRvIHJxLT5zdGF0cy5zeW5jcC4KPgo+Q29uY3Vy
cmVudGx5LCBOQVBJIHBvbGxpbmcgZXhlY3V0ZXMgaW4gdGhlIHJlY2VpdmUgcXVldWUncyBib3Vu
ZCBzb2Z0aXJxCj5jb250ZXh0IG9uIGFub3RoZXIgQ1BVIGFuZCBhbHNvIHdyaXRlcyB0byBycS0+
c3RhdHMuc3luY3AuIFNpbmNlCj5yeF90aW1lb3V0cyB3YXMgYWRkZWQgdG8gdmlydG5ldF9ycV9z
dGF0c19kZXNjLCBOQVBJIGR5bmFtaWNhbGx5IGl0ZXJhdGVzCj5vdmVyIGl0IGR1cmluZyB2aXJ0
bmV0X3JlY2VpdmUoKToKPgo+ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOnZpcnRuZXRfcmVjZWl2
ZSgpIHsKPiAgICAuLi4KPiAgICB1NjRfc3RhdHNfYWRkKGl0ZW0sIHU2NF9zdGF0c19yZWFkKHNy
YykpOwo+ICAgIC4uLgo+fQo+Cj5Db25jdXJyZW50IHdyaXRlcnMgY29ycnVwdCB0aGUgc2VxdWVu
Y2UgY291bnRlciBvbiAzMi1iaXQgc3lzdGVtcywgY2F1c2luZwo+cmVhZGVycyAoc3VjaCBhcyBu
ZG9fZ2V0X3N0YXRzNjQgdmlhIGV0aHRvb2wpIHRvIHNwaW4gaW4gYW4gaW5maW5pdGUKPnJldHJ5
IGxvb3AuCgpUaGlzIGlzIGEgcmVhbCBidWcuIHU2NF9zdGF0c19zeW5jIHJlcXVpcmVzIG11dHVh
bGx5IGV4Y2x1c2l2ZSB3cml0ZXJzLCAgYnV0IHRoZSAKd2F0Y2hkb2cgdGltZXIgcnVucyBvbiBh
biBhcmJpdHJhcnkgQ1BVIHdoaWxlIHRoZSBxdWV1ZSdzIE5BUEkgYWdncmVnYXRlcyBycS0+c3Rh
dHMgdW5kZXIgdGhlIHNhbWUgc3luY3AuIAoKSSB3aWxsIGZpeCB0aGlzIGluIHRoZSBuZXh0IHJl
dmlzaW9uIGJ5IG1vdmluZyB0aGUgcnhfdGltZW91dHMgYWNjb3VudGluZyB3cml0ZSBpbnRvIHRo
ZSBOQVBJIHBvbGw7IHRoZSB3YXRjaGRvZyAKd2lsbCBvbmx5IGRldGVjdCB0aGUgc3RhbGwgYW5k
IGNhbGwgbmFwaV9zY2hlZHVsZSgpLgoKSSB3b3VsZCBhcHByZWNpYXRlIGFueSBmZWVkYmFjaywg
ZXNwZWNpYWxseSBvbiB3aGV0aGVyIHRoaXMgZGlyZWN0aW9uIGlzIHdvcnRoIHB1cnN1aW5nLgoK
VGhhbmtzLgpMb25nanVuCj4KPi0tIAo+U2FzaGlrbyBBSSByZXZpZXcgoaQgaHR0cHM6Ly9zYXNo
aWtvLmRldi8jL3BhdGNoc2V0LzIwMjYwOTA4MDkyNjQ2LjEwODg2NS0xLWxhbmdlX3RhbmdAMTYz
LmNvbT9wYXJ0PTMK
