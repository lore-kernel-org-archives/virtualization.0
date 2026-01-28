Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B7328B7A
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591014; cv=none; b=R+cQuIIF5fUbzioKAkZ/86ZnTgJD7IqDES3R7BlMISftBBFhQNVPooPN1rhAMdiaQPNefH/wc6F1k6qHgeRjiF9W2R0HuEBTOIQoHuIxle3jEx/Z0pTN9CJAUfoX2iwGCIjh4N7YEro2dsWDvotMLL1V81EtmKV4A/SjHDyt8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591014; c=relaxed/simple;
	bh=AMkQcbIq1J8JoY0GCtVDZxj7DuT7nwHVUKcjPUoZ4po=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RoBa26WHheMeT2VapYBl33/X5qp0B1KzXpxgEn0hfLHy0w7rOUUOd2cxGGDiQvvb3D+n9wFwsD0x34VE1JhPMYITDgupJsZ3k07+kzqxmrezJzdJBCOwyphcmCtTmb+BDKEpJWJmVGVPuz5vV6hrTSqEGeW4SDhBm7GgXMEMI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NGHIsZn7; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NGHIsZn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769591013; x=1801127013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AMkQcbIq1J8JoY0GCtVDZxj7DuT7nwHVUKcjPUoZ4po=;
  b=NGHIsZn7zV5Uu1DsbJhBNd71SN7F16rhMJlxu+QjgjrPnlCZj6QNtVBX
   tcOvSc94f8SFGbHnMjB90u4k1bn2rxQ/rkYZ/aa4qu30EqXKKucdXqymK
   iXLIg+LU5XdZhq3C5tae86KfuZcXk5WDEv8ibRk43jH5iDZAJOeG0/plu
   /beRK+J/+vaEprvif48NwGalnR7ToSflpGnue/vUk4wBoTkk506igwo4g
   klR0eE02Taps7WFtsM5in+DNx2NjiHkARCWCHquyc9mAxvao9P89vo1+p
   4s9SQVx9n9aYzSZNPYI+caVB/Yf/Kg0lH09CKyuMxpXqAfUTO70h7cLuc
   A==;
X-CSE-ConnectionGUID: f8kExnEMTVWGEgsv5CVskQ==
X-CSE-MsgGUID: UYxdzdIiTceXI/dL0NlInw==
X-IronPort-AV: E=Sophos;i="6.21,258,1763424000"; 
   d="scan'208";a="11618435"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 09:03:31 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:3165]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.166:2525] with esmtp (Farcaster)
 id aae8fbb9-279b-4495-b4e4-48be241ce1ae; Wed, 28 Jan 2026 09:03:30 +0000 (UTC)
X-Farcaster-Flow-ID: aae8fbb9-279b-4495-b4e4-48be241ce1ae
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 28 Jan 2026 09:03:30 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 28 Jan 2026
 09:03:28 +0000
Message-ID: <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
Date: Wed, 28 Jan 2026 10:03:26 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: silence KCSAN warning in
 virtqueue_get_buf_ctx_split
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20260127152524.200465-1-johannes.thumshirn@wdc.com>
 <20260127152524.200465-2-johannes.thumshirn@wdc.com>
 <184ced70-f3ec-49c0-9b18-96f0ad044a78@amazon.com>
 <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <42d57017-88b6-4ab6-8fa9-10658d268fb6@wdc.com>
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI4LjAxLjI2IDA5OjQ3LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4gT24gMS8yNy8y
NiA1OjMwIFBNLCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPj4gVGhpcyBwYXRjaGVzIHRoZSBzcGxp
dCB2cmluZyBmb3JtYXQsIGJ1dCBkb2VzIG5vdCB0b3VjaCB0aGUgcGFja2VkIG9uZS4KPj4gV2hh
dCBoYXBwZW5zIGlmIHlvdSBydW4gdGhlIHNhbWUgdGVzdCB3aXRoIHRoZSBwYWNrZWQgZm9ybWF0
PyBZb3UgY2FuIGRvCj4+IHNvIGJ5IHBhc3NpbmcgInBhY2tlZD1vbiIgYXMgYXJndW1lbnQgdG8g
eW91ciAtZGV2aWNlIHBhcmFtZXRlci4KPiBUaGlzIG9wZW5lZCB1cCBhIHdob2xlIG5ldyBjYW4g
b2Ygd29ybXMuLi4gOigKCgpUaGF0J3Mgd2hhdCBJIGV4cGVjdGVkIDopLgoKSG93IGRvIG90aGVy
IERNQSBiYXNlZCBkZXZpY2VzIGhhbmRsZSB0aGlzPyBJcyB0aGUgcmVhbCBwcm9ibGVtIHRoYXQg
CnZpcnRpbyBieSBkZWZhdWx0IGRvZXMgbm90IHVzZSB0aGUgRE1BIEFQSSBhbmQgc28gaXQgY29u
ZnVzZXMgZ2VuZXJpYyAKS0NTQU4gbG9naWMgdGhhdCB3b3VsZCBvdGhlcndpc2UgdHJhY2sgRE1B
IHJlZ2lvbnMgYXMgImNhbiBiZSBtb2RpZmllZCAKYnkgRE1BIGF0IGFueSB0aW1lIj8KCklmIHRo
YXQgaXMgdGhlIGNhc2UsIG1heWJlIHdoYXQgd2UgcmVhbGx5IHdhbnQgaXMgdG8gZm9yY2UgZW5h
YmxlIHVzZSBvZiAKdGhlIERNQSBBUEkgd2hlbiBLQ1NBTiBpcyBhY3RpdmUuIERvZXMgc29tZXRo
aW5nIGxpa2UgdGhlICh3aGl0ZXNwYWNlIApicm9rZW4pIHBhdGNoIGJlbG93IHdvcms/CgpBbGV4
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKaW5kZXggZGRhYjY4OTU5NjcxLi5iMWRkNzkwY2U2MjIgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKKysrIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwpAQCAtMjg0LDYgKzI4NCwxMyBAQCBzdGF0aWMgYm9vbCB2cmluZ191c2Vf
bWFwX2FwaShjb25zdCBzdHJ1Y3QgCnZpcnRpb19kZXZpY2UgKnZkZXYpCiDCoCDCoCDCoGlmICh4
ZW5fZG9tYWluKCkpCiDCoCDCoCDCoCDCoCDCoHJldHVybiB0cnVlOwoKK8KgIMKgIC8qCivCoCDC
oCDCoCogS0NTQU4gbmVlZHMgdG8gdHJhY2sgd2hvIGNhbiBtb2RpZnkgbWVtb3J5LiBETUEgQVBJ
IGdldHMKK8KgIMKgIMKgKiB1cyB0aGF0LCBzbyBhbHdheXMgdXNlIGl0LgorwqAgwqAgwqAqLwor
wqAgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0tDU0FOKSkKK8KgIMKgIMKgIMKgIHJldHVybiB0
cnVlOworCiDCoCDCoCDCoHJldHVybiBmYWxzZTsKIMKgfQoKCgoKQW1hem9uIFdlYiBTZXJ2aWNl
cyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAy
NDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBT
dGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhS
QiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=

