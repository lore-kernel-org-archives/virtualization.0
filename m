Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC03806C1
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140861; cv=none; b=AQYuiD3uNzaS9XNSKXvI2DIjrS6jxer/Dwv6iW3kiWciZsyxYCGSy/KLVbzuBCpnPes3RzUEjQsTIt1VVxeh8q6fsAZbtIWpA+ecLSaAd0wzm0gG3QEYW/spp7th2aRFdbbpmJDfg7dbvmWadpUyWAcnIxSk43QlgOoh/Mhhn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140861; c=relaxed/simple;
	bh=pLArxNf9/4MXpQ5+ElSNDUiKKfXBjfNaMPEiUl84KKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CbJFCzQkLvY/Vyl2njKw7Rnb8BKumlVRdp737/KTV2zUhk2fgV8kyyH0AUFMIO5LDdF4XjZg5Z+kTHvWX1Y/F/RDBVYLiLGXhkFFLa6WaY2VYc3OvABTDDfFK+Ycx0tS9hWfeGcM6qu7Swwk2Xq4MSfS9B71fDHIYMxGgrX7aJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eRXd1+ST; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eRXd1+ST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773140860; x=1804676860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pLArxNf9/4MXpQ5+ElSNDUiKKfXBjfNaMPEiUl84KKI=;
  b=eRXd1+STZ5k59cLB5o1+Dc951TJy0yePX6dzQnY/XI2BCcezKm12auGf
   AIOGqkvN241D3y5ghpjruWLLqp7zX16kAnpYnGHQJXLjy+NntBb3+N+JI
   L6m/GoagDnZNkH0m27+2QKg0YyR/vs+ha3izVhCT2N/SRlDKrm1owk9e1
   w/n/oudxAEfghBPV8CCRgIngz/HZxPcVZIbk0XzD9hByFHbGrNmL8M7gb
   s7FZ6wVRrODkKwuEgWUwpe5B/vHYuWZuMHRLFbxL/9MhcvfZrh3trPkMf
   jM9ixbWC+fB0p/X7NRvhq9WYEVG5Vdsm5ddnmDHrQtCSsWsg75U06EIht
   w==;
X-CSE-ConnectionGUID: FqRddif1QKWeHiPdIPpCnQ==
X-CSE-MsgGUID: oMiUQHQCQaeLSvv9w3uicQ==
X-IronPort-AV: E=Sophos;i="6.23,112,1770595200"; 
   d="scan'208";a="14700786"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:07:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2123]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.3:2525] with esmtp (Farcaster)
 id 9969de31-71d8-490a-bcac-5948bb110c2c; Tue, 10 Mar 2026 11:07:37 +0000 (UTC)
X-Farcaster-Flow-ID: 9969de31-71d8-490a-bcac-5948bb110c2c
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 11:07:37 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 10 Mar 2026
 11:07:32 +0000
Message-ID: <79351c96-3b8c-4ebb-82c7-7f18ac88bd68@amazon.com>
Date: Tue, 10 Mar 2026 12:07:30 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v4] vsock: add G2H fallback for CIDs not owned by H2G
 transport
To: Paolo Abeni <pabeni@redhat.com>
CC: <vishnu.dasa@broadcom.com>, <stefanha@redhat.com>,
	<virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>, <arnd@arndb.de>,
	<netdev@vger.kernel.org>, <eperezma@redhat.com>,
	<gregkh@linuxfoundation.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<corbet@lwn.net>, <nh-open-source@amazon.com>, <bryan-bt.tan@broadcom.com>,
	<syzbot@syzkaller.appspotmail.com>, <sgarzare@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20260304230027.59857-1-graf@amazon.com>
 <20260310091843.101237-1-pabeni@redhat.com>
 <ef3435b1-5d86-4137-903f-bddeca3deb91@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <ef3435b1-5d86-4137-903f-bddeca3deb91@redhat.com>
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDEwLjAzLjI2IDEwOjI2LCBQYW9sbyBBYmVuaSB3cm90ZToKPiBIaSwKPgo+IE9uIDMvMTAv
MjYgMTA6MTggQU0sIFBhb2xvIEFiZW5pIHdyb3RlOgo+PiBUaGlzIGlzIGFuIEFJLWdlbmVyYXRl
ZCByZXZpZXcgb2YgeW91ciBwYXRjaC4gVGhlIGh1bWFuIHNlbmRpbmcgdGhpcwo+PiBlbWFpbCBo
YXMgY29uc2lkZXJlZCB0aGUgQUkgcmV2aWV3IHZhbGlkLCBvciBhdCBsZWFzdCBwbGF1c2libGUu
Cj4+Cj4+IEZvciBsb2NhbCByZXByb2R1Y3Rpb24gc3RlcHMgc2VlIGh0dHBzOi8vbmV0ZGV2LWFp
LmJvdHMubGludXguZGV2L2FpLWxvY2FsLmh0bWwKPj4gLS0tCj4+PiBAQCAtNTgxLDExICs1ODUs
MjEgQEAgaW50IHZzb2NrX2Fzc2lnbl90cmFuc3BvcnQoc3RydWN0IHZzb2NrX3NvY2sgKnZzaywg
c3RydWN0IHZzb2NrX3NvY2sgKnBzaykKPj4+ICAgICAgIGNhc2UgU09DS19TRVFQQUNLRVQ6Cj4+
PiAgICAgICAgICAgICAgIGlmICh2c29ja191c2VfbG9jYWxfdHJhbnNwb3J0KHJlbW90ZV9jaWQp
KQo+Pj4gICAgICAgICAgICAgICAgICAgICAgIG5ld190cmFuc3BvcnQgPSB0cmFuc3BvcnRfbG9j
YWw7Cj4+PiAtICAgICAgICAgICAgZWxzZSBpZiAocmVtb3RlX2NpZCA8PSBWTUFERFJfQ0lEX0hP
U1QgfHwgIXRyYW5zcG9ydF9oMmcgfHwKPj4+ICsgICAgICAgICAgICBlbHNlIGlmIChyZW1vdGVf
Y2lkIDw9IFZNQUREUl9DSURfSE9TVCB8fAo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAocmVt
b3RlX2ZsYWdzICYgVk1BRERSX0ZMQUdfVE9fSE9TVCkpCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgbmV3X3RyYW5zcG9ydCA9IHRyYW5zcG9ydF9nMmg7Cj4+PiAtICAgICAgICAgICAgZWxzZQo+
Pj4gKyAgICAgICAgICAgIGVsc2UgaWYgKHRyYW5zcG9ydF9oMmcgJiYKPj4+ICsgICAgICAgICAg
ICAgICAgICAgICAoIXRyYW5zcG9ydF9oMmctPmhhc19yZW1vdGVfY2lkIHx8Cj4+PiArICAgICAg
ICAgICAgICAgICAgICAgIHRyYW5zcG9ydF9oMmctPmhhc19yZW1vdGVfY2lkKHZzaywgcmVtb3Rl
X2NpZCkpKQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgbmV3X3RyYW5zcG9ydCA9IHRyYW5zcG9y
dF9oMmc7Cj4+PiArICAgICAgICAgICAgZWxzZSBpZiAoc29ja19uZXQoc2spLT52c29jay5nMmhf
ZmFsbGJhY2sgJiYKPj4+ICsgICAgICAgICAgICAgICAgICAgICB0cmFuc3BvcnRfZzJoICYmIHRy
YW5zcG9ydF9nMmgtPmhhc19yZW1vdGVfY2lkICYmCj4+PiArICAgICAgICAgICAgICAgICAgICAg
dHJhbnNwb3J0X2cyaC0+aGFzX3JlbW90ZV9jaWQodnNrLCByZW1vdGVfY2lkKSkgewo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgdnNrLT5yZW1vdGVfYWRkci5zdm1fZmxhZ3MgfD0gVk1BRERSX0ZM
QUdfVE9fSE9TVDsKPj4+ICsgICAgICAgICAgICAgICAgICAgIG5ld190cmFuc3BvcnQgPSB0cmFu
c3BvcnRfZzJoOwo+Pj4gKyAgICAgICAgICAgIH0gZWxzZSB7Cj4+PiAgICAgICAgICAgICAgICAg
ICAgICAgbmV3X3RyYW5zcG9ydCA9IHRyYW5zcG9ydF9oMmc7Cj4+PiArICAgICAgICAgICAgfQo+
Pj4gICAgICAgICAgICAgICBicmVhazsKPj4gVGhlIG9sZCBjb2RlIGhhZCBgIXRyYW5zcG9ydF9o
MmdgIGluIHRoZSBzZWNvbmQgZWxzZS1pZiBjb25kaXRpb24gYXQgbGluZQo+PiAtNTgzLCB3aGlj
aCByb3V0ZWQgYWxsIENJRCA+IFZNQUREUl9DSURfSE9TVCB0cmFmZmljIHRvIHRyYW5zcG9ydF9n
Mmggd2hlbgo+PiBubyBIMkcgdHJhbnNwb3J0IHdhcyBsb2FkZWQuIFRoZSBuZXcgY29kZSByZW1v
dmVzIHRoaXMgY2hlY2suCj4+Cj4+IFdoZW4gdHJhbnNwb3J0X2gyZyBpcyBOVUxMIChubyBIMkcg
dHJhbnNwb3J0IGxvYWRlZCkgYW5kIHRoZSBHMkggdHJhbnNwb3J0Cj4+IGRvZXMgbm90IGltcGxl
bWVudCBoYXNfcmVtb3RlX2NpZCAoYXMgaXMgdGhlIGNhc2UgZm9yIFZNQ0kgYW5kIEh5cGVyLVYK
Pj4gdHJhbnNwb3J0cyksIHdoYXQgaGFwcGVucz8KPj4KPj4gVGhlIEcySCBmYWxsYmFjayBicmFu
Y2ggYXQgbGluZSArNTk2IHJlcXVpcmVzCj4+IGB0cmFuc3BvcnRfZzJoLT5oYXNfcmVtb3RlX2Np
ZGAgdG8gYmUgbm9uLU5VTEwuIElmIGl0J3MgTlVMTCwgdGhlCj4+IHNob3J0LWNpcmN1aXQgZXZh
bHVhdGlvbiBza2lwcyB0aGlzIGJyYW5jaCBhbmQgZXhlY3V0ZXMgdGhlIGZpbmFsIGVsc2UgYXQK
Pj4gbGluZSArNjAxLCBzZXR0aW5nIGBuZXdfdHJhbnNwb3J0ID0gdHJhbnNwb3J0X2gyZ2AgKHdo
aWNoIGlzIE5VTEwpLAo+PiB1bHRpbWF0ZWx5IHJldHVybmluZyAtRU5PREVWLgo+Pgo+PiBUaGUg
Y29tbWl0IG1lc3NhZ2UgZXhwbGljaXRseSBzdGF0ZXMgdGhlIGludGVudCB0byBwcmVzZXJ2ZSB0
aGUgZXhpc3RpbmcKPj4gbm8tSDJHIGZhbGxiYWNrIGJlaGF2aW9yLiBEb2VzIHRoaXMgaW1wbGVt
ZW50YXRpb24gYnJlYWsgaXQgZm9yIEcySAo+PiB0cmFuc3BvcnRzIHRoYXQgZG8gbm90IGltcGxl
bWVudCB0aGUgbmV3IG9wdGlvbmFsIGhhc19yZW1vdGVfY2lkIGNhbGxiYWNrPwo+Pgo+PiBUaGlz
IGFmZmVjdHMgVk1DSSBhbmQgSHlwZXItViBlbnZpcm9ubWVudHM6IHdoZW4gbm8gSDJHIHRyYW5z
cG9ydCBpcwo+PiBsb2FkZWQsIENJRCA+IDIgY29ubmVjdGlvbnMgdGhhdCBwcmV2aW91c2x5IGZl
bGwgYmFjayB0byBHMkggbm93IGdldAo+PiBFTk9ERVYuCj4gT3RoZXIgY29tbWVudHMgZnJvbSBB
SSBsb29rZWQgbGlrZSBuaXQgcGlja2luZyB0byBtZSwgYnV0IHRoZSBhYm92ZSBvbmUKPiBsb29r
cyByZWxldmFudC4gSSBmb3J3YXJkZWQgdmVyYmF0aW0gYWxsIHRoZSBmZWVkYmFjayBmb3IgY29t
cGxldGVuZXNzLgoKClllcywgdGhpcyBpcyBvbiBwdXJwb3NlLiBJbnN0ZWFkIG9mIGhhdmluZyBi
aS1tb2RhbGl0eSBiYXNlZCBvbiB3aGV0aGVyIAp0aGUgdmhvc3RfdnNvY2sga2VybmVsIG1vZHVs
ZSBpcyBsb2FkZWQsIHdlIG5vdyBjbGVhcmx5IGRlZmluZSB0aGF0IHdpdGggCnRoZSBzeXNjdGwg
b2ZmLCB5b3UgZ2V0IHRoZSBzYW1lIG1vZGUgdGhhdCAidmhvc3RfdnNvY2sgaXMgbG9hZGVkIiBn
YXZlIAp5b3UgYmVmb3JlLiBUaGUgb2RkYmFsbCBjYXNlIG9mICJ2aG9zdF92c29jayBpcyBub3Qg
bG9hZGVkIiB0aGF0IG1lYW50IApldmVyeXRoaW5nIGdvZXMgdG8gdGhlIEcySCB0cmFuc3BvcnQg
YW5kIGNvbmZ1c2VkIHVzZXJzIGlzIHJlYWxseSBub3QgCndvcnRoIGtlZXBpbmcgSU1ITy4gSXQn
cyByZXBsYWNlZCBieSB0aGUgYXV0by1mYWxsYmFjayBsb2dpYy4KCkJyb2FkY29tIGFsc28gbWVu
dGlvbmVkIHRoYXQgRzJIIGZvciBDSUQgPiAyIGRvZXMgbm90IGV4aXN0LiBJSVVDIApIeXBlci1W
IGFsc28gZG9lcyBub3Qgc3VwcG9ydCBDSUQgPiAyLgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2Vy
dmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEz
CjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJl
YXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRl
ciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUzOCA1OTcK

