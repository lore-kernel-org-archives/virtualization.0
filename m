Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00A2FE582
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531425; cv=none; b=KjGuSoCWs3jnIaM86wRzyvEP0UVDJ8CgBQtDKg/JK3jcpCfnI+Cn2XPF8oZSTdMSdcDnPydGoHg8+Aio321Y97YQC/uZf1XAWbRAs75sZp+QDu1c7PtvHAhYKutUWczttDvWwQDUvnT/z3Pv3SjLxc5PbBJizyKRyUPChW/yR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531425; c=relaxed/simple;
	bh=J79QeSqXanWU6QNBr971ClAuWG9HKxmGgPVjhp8GzH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e6O7J0kOSD0ywDLld0kpJqQLL4IoWU6zzDQiYllsF/KF6/3ZbNDbpd8d4hUD8pEnIQNbVkE7JvMTl0P1of2IQhh6nCwXtBAKnTNqzwiqqnosuW554YL3kkE8yONzyYHlrLGS7Cl5b4G/1DyT8aManXOU3Q1bPpJzYBYh0ktw/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OqVKLYcR; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OqVKLYcR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769531424; x=1801067424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J79QeSqXanWU6QNBr971ClAuWG9HKxmGgPVjhp8GzH8=;
  b=OqVKLYcRyjdSs/NAoqeQaSXzGTDvrIJGUSZrRMEtyg6LD+Kx7in0KV5Q
   Il2c5sE+uYrvfDDXp5rJTFInVEhEuLCxhtB74aZut6WHLxiNtxhjUX8V/
   9epkNUFCJRhuAMsrZFBeXuK55fdLoCnS06RtUo50BbhpNWdI9a3SnTPZb
   MXgnWhNziqdjSwmVkE1uIzOPa19DusyCeAnF4OsIDn3JWkrnwk21Jizre
   9GEiUhwsMdAGvjksU2pVeoiYpRqPVbDmVdnX6Jm6Q+ZzzR3in5rsAotyB
   EGiow+vnsgTGW2CnJMNjcy6YoCjirpIG1Wr3RYduc1IY5hMVbcHifwIvB
   w==;
X-CSE-ConnectionGUID: 6fMGG6I9RYax4+iPE+thoQ==
X-CSE-MsgGUID: kBiMxcjxT7SYiG1T4GEAtg==
X-IronPort-AV: E=Sophos;i="6.21,257,1763424000"; 
   d="scan'208";a="11686597"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 16:30:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:19116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.46:2525] with esmtp (Farcaster)
 id 4afaa9e1-48c8-4184-b200-e016b37a71cc; Tue, 27 Jan 2026 16:30:21 +0000 (UTC)
X-Farcaster-Flow-ID: 4afaa9e1-48c8-4184-b200-e016b37a71cc
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 16:30:21 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 27 Jan 2026
 16:30:19 +0000
Message-ID: <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
Date: Tue, 27 Jan 2026 17:30:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	<virtualization@lists.linux.dev>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260127152524.200465-2-johannes.thumshirn@wdc.com>
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI3LjAxLjI2IDE2OjI1LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4gV2hlbiBib290
aW5nIGEgUWVtdSBWTSB3aXRoIHZpcnRpby1ibGsgYW5kIEtDU0FOIGVuYWJsZWQsIEtDU0FOIGVt
aXRzCj4gdGhlIGZvbGxvd2luZyB3YXJuaW5nIGFib3V0IGEgZGF0YS1yYWNlIGluIHZpcnRxdWV1
ZV9nZXRfYnVmX2N0eF9zcGxpdCgpLgo+Cj4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAgIEJVRzogS0NTQU46IGRh
dGEtcmFjZSBpbiB2aXJ0cXVldWVfZ2V0X2J1Zl9jdHhfc3BsaXQrMHg2ZS8weDI2MAo+Cj4gICBy
YWNlIGF0IHVua25vd24gb3JpZ2luLCB3aXRoIHJlYWQgdG8gMHhmZmZmODg4MTAyMGYxOTQyIG9m
IDIgYnl0ZXMgYnkgdGFzayAxIG9uIGNwdSA3Ogo+ICAgIHZpcnRxdWV1ZV9nZXRfYnVmX2N0eF9z
cGxpdCsweDZlLzB4MjYwCj4gICAgdmlydHF1ZXVlX2dldF9idWYrMHg0Yi8weDYwCj4gICAgX19z
ZW5kX3RvX3BvcnQrMHgxNTYvMHgxNzAKPiAgICBwdXRfY2hhcnMrMHhjYi8weDExMAo+ICAgIGh2
Y19jb25zb2xlX3ByaW50KzB4MWQ2LzB4MmEwCj4gICAgY29uc29sZV9mbHVzaF9vbmVfcmVjb3Jk
KzB4M2RkLzB4NTEwCj4gICAgY29uc29sZV91bmxvY2srMHg4Yy8weDE2MAo+ICAgIHZwcmludGtf
ZW1pdCsweDJmZS8weDM4MAo+ICAgIHZwcmludGtfZGVmYXVsdCsweDFkLzB4MzAKPiAgICB2cHJp
bnRrKzB4ZS8weDIwCj4gICAgX3ByaW50aysweDRjLzB4NjAKPiAgICBidHJmc190ZXN0X3JhaWRf
c3RyaXBlX3RyZWUrMHgyNS8weDkwCj4gICAgYnRyZnNfcnVuX3Nhbml0eV90ZXN0cy5jb2xkKzB4
ZjEvMHgxM2IKPiAgICBpbml0X2J0cmZzX2ZzKzB4NzMvMHgxMTAKPiAgICBkb19vbmVfaW5pdGNh
bGwrMHg1Yi8weDJkMAo+ICAgIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MmEyLzB4MzQwCj4gICAg
a2VybmVsX2luaXQrMHgxZS8weDFiMAo+ICAgIHJldF9mcm9tX2ZvcmsrMHgxMzcvMHgxYjAKPiAg
ICByZXRfZnJvbV9mb3JrX2FzbSsweDFhLzB4MzAKPgo+ICAgdmFsdWUgY2hhbmdlZDogMHgwMTYw
IC0+IDB4MDE2MQo+Cj4gICBSZXBvcnRlZCBieSBLZXJuZWwgQ29uY3VycmVuY3kgU2FuaXRpemVy
IG9uOgo+ICAgQ1BVOiA3IFVJRDogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVk
IDYuMTkuMC1yYzcrICMyMTkgUFJFRU1QVChub25lKQo+ICAgSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNy4wLTkuZmM0MyAwNi8x
MC8yMDI1Cj4gICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KPgo+IFRoaXMgd2FybmluZyBpcyBsaWtlbHkgYSBmYWxzZSBw
b3NpdGl2ZSBhcyB0aGUgY2hhbmdlIGhhcHBlbnMgb24gdGhlCj4gdmlydGlvIHZyaW5nLgo+Cj4g
QW5ub3RhdGUgdGhlIHJldHVybiBvZiBtb3JlX3VzZWRfc3BsaXQoKSB3aXRoIGRhdGFfcmFjZSgp
IHRvIHNpbGVuY2UKPiB0aGUgd2FybmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggZGRhYjY4
OTU5NjcxLi4xZGIyN2VlMmQ4OWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtODA4LDgg
KzgwOCw4IEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZSAqdnEsIHVuc2lnbmVkIGludCBoZWFkLAo+Cj4gICBzdGF0aWMgYm9vbCBtb3JlX3VzZWRf
c3BsaXQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCgoKVGhpcyBwYXRjaGVzIHRo
ZSBzcGxpdCB2cmluZyBmb3JtYXQsIGJ1dCBkb2VzIG5vdCB0b3VjaCB0aGUgcGFja2VkIG9uZS4g
CldoYXQgaGFwcGVucyBpZiB5b3UgcnVuIHRoZSBzYW1lIHRlc3Qgd2l0aCB0aGUgcGFja2VkIGZv
cm1hdD8gWW91IGNhbiBkbyAKc28gYnkgcGFzc2luZyAicGFja2VkPW9uIiBhcyBhcmd1bWVudCB0
byB5b3VyIC1kZXZpY2UgcGFyYW1ldGVyLgoKCkFsZXgKCgoKCgpBbWF6b24gV2ViIFNlcnZpY2Vz
IERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKVGFtYXJhLURhbnotU3RyLiAxMwoxMDI0
MyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RvZiBIZWxsbWlzLCBBbmRyZWFzIFN0
aWVnZXIKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==

