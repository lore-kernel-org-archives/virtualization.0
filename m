Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC0A217723
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596227; cv=none; b=XvPPDe2HQ6JxZ9HmEToi/0KaSxQVpSEPKUtssAo5sV6pP0JFos36K6Hh/nvAXRdG3LppLss+GKQCoJX1RrJnvL0xCExAyvLtc2opqXCYsViWDhXqehy53dlLhyufw1USYkRFnv0KpcuzwOQkuW7T9kmuk5iZ9PJTMrTk3Bm/3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596227; c=relaxed/simple;
	bh=wttt7dsFp+uKHTLLB0/O0q8qBHGPq1TR9YC2EUTBpgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tks/zb65w3mpKlyRFI+Nd6bQU2YOv7b9IRX9sJrivyIqnhxMH/Bt+zCY6oHSfj8sJXQx1I+x6TF9psaQxPFX9nPorstLuKRePRqBKKN1nf6vhWy+lhQ3IWHwy2ehOrGXcIQKWF16BoxyzaSiDR6iQusBUGC4gBLv5o72QxSTOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nFsuGcDt; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nFsuGcDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769596226; x=1801132226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wttt7dsFp+uKHTLLB0/O0q8qBHGPq1TR9YC2EUTBpgA=;
  b=nFsuGcDtLkr2xTOZYVGTMxA0k3tNSN92bNVwzzBYUX0bQev7JXq7EQ+e
   ewMq1xFTjU1JdFVYn5/ehZl3OYKjwEcyfTdsut4aTygRvTvvOLOmCiABQ
   mawfOrinPlvyhyKgR+1Dwsp+FGS3wwqqVJS6g2nc0RD2Ud9yV6FC6Fq64
   STiAiZ3WiYG2wgHHVPqM0n6N1TWgfoku0lIUnA1ha8iitijvUVP5mtEU4
   A8UXR8/APEUcS1RqQ2E/gjHo1NcWUxNzoKUKKVKgJiucwxiSNBuq6Eg7P
   j6+pUMX1t27LjZTwozQzI1vfJDrwQ/Pddovi4WF1r68GmH51tWeWv3egC
   g==;
X-CSE-ConnectionGUID: zWOzqiFfR42JWq2Ecw1rwQ==
X-CSE-MsgGUID: SpuSGXxXRtWKxx9exie1gg==
X-IronPort-AV: E=Sophos;i="6.21,258,1763424000"; 
   d="scan'208";a="11558921"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 10:30:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:2223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.94:2525] with esmtp (Farcaster)
 id daf1bedf-37d2-4a2b-a023-90bc94a5c3d5; Wed, 28 Jan 2026 10:30:25 +0000 (UTC)
X-Farcaster-Flow-ID: daf1bedf-37d2-4a2b-a023-90bc94a5c3d5
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 28 Jan 2026 10:30:25 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Wed, 28 Jan 2026
 10:30:23 +0000
Message-ID: <87ee6ad5-7c58-4e40-92fe-57305ce2b00a@amazon.com>
Date: Wed, 28 Jan 2026 11:30:20 +0100
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
 <4fde2f6e-d272-4aa8-9701-63bc6b7e7d16@amazon.com>
 <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <9004e3b6-fbd0-42a8-b722-bf6d25833dd7@wdc.com>
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI4LjAxLjI2IDEwOjEzLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4gT24gMS8yOC8y
NiAxMDowMyBBTSwgQWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+IE9uIDI4LjAxLjI2IDA5OjQ3LCBK
b2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4+PiBPbiAxLzI3LzI2IDU6MzAgUE0sIEFsZXhhbmRl
ciBHcmFmIHdyb3RlOgo+Pj4+IFRoaXMgcGF0Y2hlcyB0aGUgc3BsaXQgdnJpbmcgZm9ybWF0LCBi
dXQgZG9lcyBub3QgdG91Y2ggdGhlIHBhY2tlZCBvbmUuCj4+Pj4gV2hhdCBoYXBwZW5zIGlmIHlv
dSBydW4gdGhlIHNhbWUgdGVzdCB3aXRoIHRoZSBwYWNrZWQgZm9ybWF0PyBZb3UgY2FuIGRvCj4+
Pj4gc28gYnkgcGFzc2luZyAicGFja2VkPW9uIiBhcyBhcmd1bWVudCB0byB5b3VyIC1kZXZpY2Ug
cGFyYW1ldGVyLgo+Pj4gVGhpcyBvcGVuZWQgdXAgYSB3aG9sZSBuZXcgY2FuIG9mIHdvcm1zLi4u
IDooCj4+IFRoYXQncyB3aGF0IEkgZXhwZWN0ZWQgOikuCj4+Cj4+IEhvdyBkbyBvdGhlciBETUEg
YmFzZWQgZGV2aWNlcyBoYW5kbGUgdGhpcz8gSXMgdGhlIHJlYWwgcHJvYmxlbSB0aGF0Cj4+IHZp
cnRpbyBieSBkZWZhdWx0IGRvZXMgbm90IHVzZSB0aGUgRE1BIEFQSSBhbmQgc28gaXQgY29uZnVz
ZXMgZ2VuZXJpYwo+PiBLQ1NBTiBsb2dpYyB0aGF0IHdvdWxkIG90aGVyd2lzZSB0cmFjayBETUEg
cmVnaW9ucyBhcyAiY2FuIGJlIG1vZGlmaWVkCj4+IGJ5IERNQSBhdCBhbnkgdGltZSI/Cj4+Cj4+
IElmIHRoYXQgaXMgdGhlIGNhc2UsIG1heWJlIHdoYXQgd2UgcmVhbGx5IHdhbnQgaXMgdG8gZm9y
Y2UgZW5hYmxlIHVzZSBvZgo+PiB0aGUgRE1BIEFQSSB3aGVuIEtDU0FOIGlzIGFjdGl2ZS4gRG9l
cyBzb21ldGhpbmcgbGlrZSB0aGUgKHdoaXRlc3BhY2UKPj4gYnJva2VuKSBwYXRjaCBiZWxvdyB3
b3JrPwo+Pgo+PiBBbGV4Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+PiBpbmRleCBkZGFiNjg5NTk2
NzEuLmIxZGQ3OTBjZTYyMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+IEBAIC0yODQsNiAr
Mjg0LDEzIEBAIHN0YXRpYyBib29sIHZyaW5nX3VzZV9tYXBfYXBpKGNvbnN0IHN0cnVjdAo+PiB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+PiAgICAgICAgIGlmICh4ZW5fZG9tYWluKCkpCj4+ICAgICAg
ICAgICAgIHJldHVybiB0cnVlOwo+Pgo+PiArICAgIC8qCj4+ICsgICAgICogS0NTQU4gbmVlZHMg
dG8gdHJhY2sgd2hvIGNhbiBtb2RpZnkgbWVtb3J5LiBETUEgQVBJIGdldHMKPj4gKyAgICAgKiB1
cyB0aGF0LCBzbyBhbHdheXMgdXNlIGl0Lgo+PiArICAgICAqLwo+PiArICAgIGlmIChJU19FTkFC
TEVEKENPTkZJR19LQ1NBTikpCj4+ICsgICAgICAgIHJldHVybiB0cnVlOwo+PiArCj4+ICAgICAg
ICAgcmV0dXJuIGZhbHNlOwo+PiAgICAgfQo+Cj4gVW5mb3J0dW5hdGVseSB0aGlzIGRvZXNuJ3Qg
Z2V0IHVzIGFueSBmdXJ0aGVyIChJJ2QgbG92ZSB0aG91Z2gsIGl0IGxvb2tzCj4gd2F5IGNsZWFu
ZXIhKQo+Cj4gSSBzdGlsbCBzZWUgdGhlIEtDU0FOIG1lc3NhZ2VzIGV2ZW4gb24gYm9vdC4KCgpB
aCwgbG9va3MgbGlrZSB0aGUgaW1wb3J0YW50IGJpdCBmb3IgS0NTQU4gaXMgbm90IHRoZSBtYXBw
aW5nIG1lY2hhbmlzbSwgCml0J3MgdGhlIGFjdHVhbCBjb21waWxlciBhbm5vdGF0aW9uIGZvciB0
aGUgcmVhZC4gU28gdGhlc2UgdmlydGlvIHJpbmcgCnJlYWRzIHNob3VsZCBhbGwgYmUgYW5ub3Rh
dGVkIGFzIFJFQURfT05DRSgpIHRvIG1ha2Ugc3VyZSBLQ1NBTiBrbm93cyAKdGhlIHJlYWQgaXRz
ZWxmIGlzIGF0b21pYy4KCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNj
aGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRy
YWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0
ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK

