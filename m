Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02562745C
	for <virtualization@lists.linux.dev>; Tue, 27 Jan 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769503673; cv=none; b=e6NlUpGR0k7y5We4/7NpUyhTQ6+7KKndLW2pDfgTe4agnbPrw+12HtIGFYZuQKF4AyAIKmp0BBWTvyHSC0tQTtXCVTYhAMzLAovdwnga10ZgXSg4JYddS+TJBS0dvJH7EnpyCjsdE29NxbEJ99qlN/XLg9IdIPSwCFx8f4r5EC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769503673; c=relaxed/simple;
	bh=nY4XcP3Pyle7mXB/jfIKDXI1KnACXN1OeL+7wkvZRCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iWJSbzLZjHZhMrFsxPa2D46pQ+8QEOjLIfIv4h1ebrgBmslFP+sTT+mhPu+wuDjNhJuY448L6/PG2DCn68sQHV1W3DvKOvA3gHmKaAFRHzoIV3fja95HTp7z0SRVn2fiBebTsRwGnVe/+kkRzVK1qi7fKiVZTRpeSUGc4wvDf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i8c5YMeZ; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i8c5YMeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769503671; x=1801039671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nY4XcP3Pyle7mXB/jfIKDXI1KnACXN1OeL+7wkvZRCY=;
  b=i8c5YMeZ2haw0QhG5LQP2j8+OYDRXSWy1TrDKbQ3rc7iOzGorsD0pg2y
   S6M60W5iPo2U5WSxFP9yUNQ4vNyZozuRlH1lPKB+zyGmc+qevG+wgZjyE
   QU1ftwOA4Ye/cQyv7SzGEbo2VcrMn5TATyEzYErRUgwei02m2cFPtel6W
   UEb7wd96ygT4ZBmN8Phvj6l5qjGJPsCMJpFfWsNiGqI77WyE6mYr397PB
   MYK6ZjeWH+CThgiaAtyBeQfwW7mInF9t50IzpVEkjRK7v8SHSMu0E9Z9l
   VrhIyohgPP6oqImpaiiLLxrn7RKbPhQqGzBSs/dZsfxAyjY+NHpQ2mc/P
   A==;
X-CSE-ConnectionGUID: lfWOblo4QCOJSLNyJyx2wA==
X-CSE-MsgGUID: KoHUvIoITkaj9B6H9C5n+A==
X-IronPort-AV: E=Sophos;i="6.21,256,1763424000"; 
   d="scan'208";a="11669962"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:47:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:17856]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.141:2525] with esmtp (Farcaster)
 id 4aa833c6-e639-4d95-b62a-c7f9bb7eacb2; Tue, 27 Jan 2026 08:47:49 +0000 (UTC)
X-Farcaster-Flow-ID: 4aa833c6-e639-4d95-b62a-c7f9bb7eacb2
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Tue, 27 Jan 2026 08:47:48 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Tue, 27 Jan 2026
 08:47:46 +0000
Message-ID: <fed4ce78-37c5-4bb5-86de-6d60f053dbf3@amazon.com>
Date: Tue, 27 Jan 2026 09:47:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] virtio: silence KCSAN warnings
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	<virtualization@lists.linux.dev>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260127083926.865555-1-johannes.thumshirn@wdc.com>
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI3LjAxLjI2IDA5OjM5LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4gV2hlbiBib290
aW5nIGEgUWVtdSBWTSB3aGl0aCBLQ1NBTiB0byBkZWJ1ZyBmaWxlc3lzdGVtIHJhY2VzIEkKPiBl
bmNvdW50ZXJlZCBhIGJ1bmNoIG9mIEtDU0FOIHNwbGF0cyBpbiB2aXJ0aW8uCj4KPiBJIHN1c3Bl
Y3QgdGhlbSB0byBiZSBmYWxzZSBwb3NpdGl2ZXMuCj4KPiBJIGRlY2lkZWQgdG8gc2VuZCB0aGlz
IGFzIGFuIFJGQyBwYXRjaHNldCwgYXMgSSBoYXZlIG5vIHByaW9yIGtub3dsZWRnZQo+IG9mIHZp
cnRpby4KCgpBbGwgb2YgdGhlc2UgbG9va3MgbGlrZSBLQ1NBTiB3YXMganVzdCBkZXRlY3Rpbmcg
dGhlIGh5cGVydmlzb3Igd3JpdGluZyAKZGF0YS4gSXMgdGhlcmUgYSBtb3JlIGdlbmVyaWMgd2F5
IHdlIGNhbiBjYXB0dXJlIHRoYXQgaW4gdGhlIHZpcnRpbyAKaGVscGVycz8gU28gaW5zdGVhZCBv
ZiBwYXRjaGluZyB0aGUgY29uc3VtZXJzIG9mIGZ1bmN0aW9ucyBzdWNoIGFzIAp2cmluZ19pbnRl
cnJ1cHQoKSwgY2FuIHdlIGFubm90YXRlIHRoZSB3aG9sZSB2cmluZyBzdHJ1Y3QgYXMgImlnbm9y
ZSBmb3IgCktDU0FOIj8KCgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVu
dCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdl
c2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdl
dHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpT
aXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=

