Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAB33985A
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704765; cv=none; b=naZnCEk8WsYgHJGpgtQw5Tzjvg+YYNyDYsztfBOiVadFYfXB8KKeHFVDFJNuyBMRRD6CSBi9zVVZKB/WRtkBegvxW2W5s07EzbCX4qSyoi9ynAgAoc5hJc6FTb13K3EBdjHUoAv+a9BXYWwlRgw0UVBy1UgFMHVgcEj3VRRrjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704765; c=relaxed/simple;
	bh=Fc/cgxlRFDNreo7V/sGH4YF+Ny5qj9VmO/oiDU3g1yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PnyteyZb+AbhG4Vz9hhDFG7EMrjOiLNjv0ErADTo5XYlB5m0kzI79JR3nHOKHrI/T0wetGP8uVyJz6Vok3H5pu3vulFh1gUWQ7WIzZlCP4xBctb1Ksw6IYc/SlDVuYUa+ZBxoUPTxmtp5yqeQZLYS8n1oK5pduozjoWe5uI0u3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JxPuN3zI; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JxPuN3zI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1769704764; x=1801240764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fc/cgxlRFDNreo7V/sGH4YF+Ny5qj9VmO/oiDU3g1yc=;
  b=JxPuN3zIeQwqzvbumke6gDP+KnQnc/IpVGWXvWrZJ3GnkVAbBoyekWj6
   UWxnPDE0O/S8gCKz8Wl/3SyqKWE/zMTGFFmEHKUWII32sI5ANWtDpEJgc
   q73bOPInNNDyJSWwWL+aDCtIZIoZTQ5Oeg3L//6zkPYIcX9865PaMBD54
   krdSE92esWmLm3IXRw96IiUGI1KFlCtE9LpH+Abl8VyEuI0o/LOv+Dc4j
   qGJgcMj6RKDAk0XnwwKqymm92RSUBOEgTX93cmLn2+9lVna0wer+kZSEW
   +uK6on8DMRB5cMG1sa4K5hbMfANcVwdpOPXiEMXdJ5dsefjcRd/zwvwxP
   g==;
X-CSE-ConnectionGUID: 7H9g9UeMSIi8+Q9d7g1J6A==
X-CSE-MsgGUID: Scqj9ktcQ969WVJL3JnWBQ==
X-IronPort-AV: E=Sophos;i="6.21,261,1763424000"; 
   d="scan'208";a="11853402"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 16:39:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:6028]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.168:2525] with esmtp (Farcaster)
 id 49177a38-027e-4937-ac71-a0e3cb355b67; Thu, 29 Jan 2026 16:39:21 +0000 (UTC)
X-Farcaster-Flow-ID: 49177a38-027e-4937-ac71-a0e3cb355b67
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 29 Jan 2026 16:39:21 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Thu, 29 Jan 2026
 16:39:19 +0000
Message-ID: <3df69121-b4ac-48ce-a26c-5dd3035a3b78@amazon.com>
Date: Thu, 29 Jan 2026 17:39:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, "open list:VIRTIO CORE"
	<virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
References: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDI5LjAxLjI2IDEzOjE1LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6Cj4gRnJvbTogQWxl
eGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KPgo+IEtDU0FOIHJlcG9ydHMgZGF0YSByYWNl
cyB3aGVuIGFjY2Vzc2luZyB2aXJ0aW8gcmluZyBmaWVsZHMgdGhhdCBhcmUKPiBjb25jdXJyZW50
bHkgd3JpdHRlbiBieSB0aGUgZGV2aWNlIChob3N0KS4gVGhlc2UgYXJlIGxlZ2l0aW1hdGUKPiBj
b25jdXJyZW50IGFjY2Vzc2VzIHdoZXJlIHRoZSBDUFUgcmVhZHMgZmllbGRzIHRoYXQgdGhlIGRl
dmljZSB1cGRhdGVzCj4gdmlhIERNQS1saWtlIG1lY2hhbmlzbXMuCj4KPiBBZGQgYWNjZXNzb3Ig
ZnVuY3Rpb25zIHRoYXQgdXNlIFJFQURfT05DRSgpIHRvIHByb3Blcmx5IGFubm90YXRlIHRoZXNl
Cj4gZGV2aWNlLXdyaXRhYmxlIGZpZWxkcyBhbmQgcHJldmVudCBjb21waWxlciBvcHRpbWl6YXRp
b25zIHRoYXQgY291bGQgaW4KPiB0aGVvcnkgYnJlYWsgdGhlIGNvZGUuIFRoaXMgYWxzbyBzZXJ2
ZXMgYXMgZG9jdW1lbnRhdGlvbiBzaG93aW5nIHdoaWNoCj4gZmllbGRzIGFyZSBzaGFyZWQgd2l0
aCB0aGUgZGV2aWNlLgo+Cj4gVGhlIGFmZmVjdGVkIGZpZWxkcyBhcmU6Cj4gLSBTcGxpdCByaW5n
OiB1c2VkLT5pZHgsIHVzZWQtPnJpbmdbXS5pZCwgdXNlZC0+cmluZ1tdLmxlbgo+IC0gUGFja2Vk
IHJpbmc6IGRlc2NbXS5mbGFncywgZGVzY1tdLmlkLCBkZXNjW10ubGVuCgoKUGxlYXNlIGFkZCAi
VGhpcyBwYXRjaCB3YXMgcGFydGlhbGx5IHdyaXR0ZW4gdXNpbmcgdGhlIGhlbHAgb2YgS2lybywg
YW4gCkFJIGNvZGluZyBhc3Npc3RlbnQsIHRvIGF1dG9tYXRlIHRoZSBtZWNoYW5pY2FsIHdvcmsg
b2YgZ2VuZXJhdGluZyB0aGUgCmlubGluZSBmdW5jdGlvbiBkZWZpbml0aW9uLiIKCgpPdGhlcndp
c2UgTEdUTSEKClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgoK
CkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkg
R21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6
IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRzZ2Vy
aWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1J
RDogREUgMzY1IDUzOCA1OTcK

