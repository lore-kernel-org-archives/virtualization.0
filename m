Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93B2F60B2
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596740; cv=none; b=O9Zp0wt9taZPPpP3FNnzY+GfuZ+5F64n+uz1LexM1K6bjlaTEWfyNpHOujDeBMgKQU5NbrUM4522QhRX8iVXP3JDX1kBYeQXUeek5joMjbpHILsJnQyFIDI3VFhgb+3hL7hHn4qffCbaczqhutlQabpAsTkJMR7dXAmIlIdDZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596740; c=relaxed/simple;
	bh=28w5Fg3rU8UOXEduQdJAYbj+5sHgUd0T+BTmDuWB96o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ia6rggmRsERwaqAnoHUI0+NpZuktTf39t9ouFKXRNCRGzeHkdq2byONt4RXBa9rD4A5F9CEZM7jhuWP56bMyt2MBkk3kiF8onRoYGN1SD+MwEuLwVHtCvyy2IZ++QVdKze50EaWOkDoBj00Iejt+sOJx3P9bvnvD1IsxQ4SmcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g2APEjcd; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g2APEjcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769596738; x=1801132738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=28w5Fg3rU8UOXEduQdJAYbj+5sHgUd0T+BTmDuWB96o=;
  b=g2APEjcd+CkaCHXiJlcZOf/nTdp0TVTHIVoy0203Kc4BgBS+dQJEc/qW
   Xg1O2QpvSrBH6VkNSFp0Yti676mKEVeVchlqMGYmyY3oI5J/t++C5xwDD
   jgaZd5M+fJc56vE/rgFNN/TKXDngZOvrURxoXx/0kznE61vul/ZltqcfF
   b45H/L5/sxlXX+EWOHSnDIewbZCPi4BzPgOkoa7ltaIKeJrDoQN50i+W3
   nh1ykGOKq5obu4sDusc9rhjCdwTooIxVhTLT0Wx6I290PmZ/piRmQvkXA
   LClY9DdTncmsyDndHcjMJayoWtTV9VUk9UCw40ep6zXvM85jMAXN5yunR
   Q==;
X-CSE-ConnectionGUID: uQQ6UZuyRiye3osaBcrUvg==
X-CSE-MsgGUID: CU9OJ8MuQ3CuSjSOfRYb8Q==
X-IronPort-AV: E=Sophos;i="6.21,258,1763424000"; 
   d="scan'208";a="11748335"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:38:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:8420]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.166:2525] with esmtp (Farcaster)
 id cb3417e6-030c-440c-9a11-a061deb092e2; Wed, 28 Jan 2026 10:38:53 +0000 (UTC)
X-Farcaster-Flow-ID: cb3417e6-030c-440c-9a11-a061deb092e2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 28 Jan 2026 10:38:52 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 28 Jan 2026
 10:38:50 +0000
Message-ID: <d80b0dd5-1db2-4796-bb88-37212f6a4d24@amazon.com>
Date: Wed, 28 Jan 2026 11:38:48 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Jason Wang
	<jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
 <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
 <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
 <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
 <87ee6ad5-7c58-4e40-92fe-57305ce2b00a@amazon.com>
 <20260128053356-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260128053356-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI4LjAxLjI2IDExOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gV2VkLCBK
YW4gMjgsIDIwMjYgYXQgMTE6MzA6MjBBTSArMDEwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+
IE9uIDI4LjAxLjI2IDEwOjEzLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4+PiBPbiAxLzI4
LzI2IDEwOjAzIEFNLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPj4+PiBPbiAyOC4wMS4yNiAwOTo0
NywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+Pj4+PiBPbiAxLzI3LzI2IDU6MzAgUE0sIEFs
ZXhhbmRlciBHcmFmIHdyb3RlOgo+Pj4+Pj4gVGhpcyBwYXRjaGVzIHRoZSBzcGxpdCB2cmluZyBm
b3JtYXQsIGJ1dCBkb2VzIG5vdCB0b3VjaCB0aGUgcGFja2VkIG9uZS4KPj4+Pj4+IFdoYXQgaGFw
cGVucyBpZiB5b3UgcnVuIHRoZSBzYW1lIHRlc3Qgd2l0aCB0aGUgcGFja2VkIGZvcm1hdD8gWW91
IGNhbiBkbwo+Pj4+Pj4gc28gYnkgcGFzc2luZyAicGFja2VkPW9uIiBhcyBhcmd1bWVudCB0byB5
b3VyIC1kZXZpY2UgcGFyYW1ldGVyLgo+Pj4+PiBUaGlzIG9wZW5lZCB1cCBhIHdob2xlIG5ldyBj
YW4gb2Ygd29ybXMuLi4gOigKPj4+PiBUaGF0J3Mgd2hhdCBJIGV4cGVjdGVkIDopLgo+Pj4+Cj4+
Pj4gSG93IGRvIG90aGVyIERNQSBiYXNlZCBkZXZpY2VzIGhhbmRsZSB0aGlzPyBJcyB0aGUgcmVh
bCBwcm9ibGVtIHRoYXQKPj4+PiB2aXJ0aW8gYnkgZGVmYXVsdCBkb2VzIG5vdCB1c2UgdGhlIERN
QSBBUEkgYW5kIHNvIGl0IGNvbmZ1c2VzIGdlbmVyaWMKPj4+PiBLQ1NBTiBsb2dpYyB0aGF0IHdv
dWxkIG90aGVyd2lzZSB0cmFjayBETUEgcmVnaW9ucyBhcyAiY2FuIGJlIG1vZGlmaWVkCj4+Pj4g
YnkgRE1BIGF0IGFueSB0aW1lIj8KPj4+Pgo+Pj4+IElmIHRoYXQgaXMgdGhlIGNhc2UsIG1heWJl
IHdoYXQgd2UgcmVhbGx5IHdhbnQgaXMgdG8gZm9yY2UgZW5hYmxlIHVzZSBvZgo+Pj4+IHRoZSBE
TUEgQVBJIHdoZW4gS0NTQU4gaXMgYWN0aXZlLiBEb2VzIHNvbWV0aGluZyBsaWtlIHRoZSAod2hp
dGVzcGFjZQo+Pj4+IGJyb2tlbikgcGF0Y2ggYmVsb3cgd29yaz8KPj4+Pgo+Pj4+IEFsZXgKPj4+
Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4+IGluZGV4IGRkYWI2ODk1OTY3MS4uYjFkZDc5MGNl
NjIyIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+PiAr
KysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+Pj4gQEAgLTI4NCw2ICsyODQsMTMg
QEAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX21hcF9hcGkoY29uc3Qgc3RydWN0Cj4+Pj4gdmlydGlv
X2RldmljZSAqdmRldikKPj4+PiAgICAgICAgICBpZiAoeGVuX2RvbWFpbigpKQo+Pj4+ICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsKPj4+Pgo+Pj4+ICsgICAgLyoKPj4+PiArICAgICAqIEtDU0FO
IG5lZWRzIHRvIHRyYWNrIHdobyBjYW4gbW9kaWZ5IG1lbW9yeS4gRE1BIEFQSSBnZXRzCj4+Pj4g
KyAgICAgKiB1cyB0aGF0LCBzbyBhbHdheXMgdXNlIGl0Lgo+Pj4+ICsgICAgICovCj4+Pj4gKyAg
ICBpZiAoSVNfRU5BQkxFRChDT05GSUdfS0NTQU4pKQo+Pj4+ICsgICAgICAgIHJldHVybiB0cnVl
Owo+Pj4+ICsKPj4+PiAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+Pj4gICAgICB9Cj4+PiBVbmZv
cnR1bmF0ZWx5IHRoaXMgZG9lc24ndCBnZXQgdXMgYW55IGZ1cnRoZXIgKEknZCBsb3ZlIHRob3Vn
aCwgaXQgbG9va3MKPj4+IHdheSBjbGVhbmVyISkKPj4+Cj4+PiBJIHN0aWxsIHNlZSB0aGUgS0NT
QU4gbWVzc2FnZXMgZXZlbiBvbiBib290Lgo+Pgo+PiBBaCwgbG9va3MgbGlrZSB0aGUgaW1wb3J0
YW50IGJpdCBmb3IgS0NTQU4gaXMgbm90IHRoZSBtYXBwaW5nIG1lY2hhbmlzbSwKPj4gaXQncyB0
aGUgYWN0dWFsIGNvbXBpbGVyIGFubm90YXRpb24gZm9yIHRoZSByZWFkLiBTbyB0aGVzZSB2aXJ0
aW8gcmluZyByZWFkcwo+PiBzaG91bGQgYWxsIGJlIGFubm90YXRlZCBhcyBSRUFEX09OQ0UoKSB0
byBtYWtlIHN1cmUgS0NTQU4ga25vd3MgdGhlIHJlYWQKPj4gaXRzZWxmIGlzIGF0b21pYy4KPj4K
Pj4gQWxleAo+Pgo+IHNvIHRoZW46Cj4KPiAgICAgICAgIHJldHVybiB2cS0+bGFzdF91c2VkX2lk
eCAhPSB2aXJ0aW8xNl90b19jcHUodnEtPnZxLnZkZXYsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgUkVBRF9PTkNFKHZxLT5zcGxpdC52cmluZy51c2VkLT5pZHgpKTsKCgpZZXMsIHdoaWNoIGlz
IG9uIHRoZSB2ZXJnZSBvZiBnZXR0aW5nIHVucmVhZGFibGUuIEknbGwgd29yayB3aXRoIApKb2hh
bm5lcyBvbiB2My4gV2UnbGwgcGxheSB3aXRoIHdheXMgdG8gbWFrZSBpdCBhIGJpdCBtb3JlIG1h
aW50YWluYWJsZS4gClBsZWFzZSBkaXNjYXJkIHRoZSBjdXJyZW50IHBhdGNoZXMgZm9yIG5vdy4K
CgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55
IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDM2NSA1MzggNTk3Cg==

