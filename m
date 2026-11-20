Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158942;
	b=pzHsIVA8JhC/1MVOZi55o4ICTU43DacXuhge2BqWAUQcC2R17vLVW5SJ2KLdVkrYHSpE
	 HLZd904DX+uv/9CkJeaMWPfIXDi0Yku3D7enMZbSCDW6Ad4Oz4R/0WIZefmXGg+RODW5L
	 pF7eEWrOJyazdJSygDfQWjbyeb1bVKvpMdx5Y8L76r5celWzcIlC4lN0vTBT3rJiAOoEY
	 vXURl+ieQnLoT1DqSYNlGVNHbIzg1M3QND8gFNPkGNp08wghYaGf4nz4yx7mi2Dmt0oYU
	 pl19/k4PqoDsgJTCr/4iu4I5iO76jJeFi2LruMkhkAmk9GVSRUAaxzLQMEIDZh3rQtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158942;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=NtpWopRcN0wJjmDls+K0Ca4Cj+AbA7EcSijbuS4eMWk=;
	b=xgaGQM+PAqle4ep7vX2TQNUxd+pejmYYg058EdGQYwgKyVJ6B7EFI8XrW/uMRkVfM0+M
	 xVPhTlVpuS68D2i48uR67aqSwhCKblSckalU/QOrWr4wwN3fL93GSAN/EzveeY09ZNRyb
	 QCLlwpRgq1oouzRYzNbJvU+1+SgceCTgKn0mbGes25CrkoRw3KYmUhSxYVhpdyLJRFcnQ
	 IBsyfuotfZ1NRT0dVKZWkA2WHkwxjG6A6njClf7aMpU1Axn+O5hMaNojljfkuJWDInfXI
	 7NyaTyYGhtmwO5QWPELwlUrz4wDh9VmRHZgvYbEcx5Dc7rmkIH48PrDWKYv4CSX9kbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=f3F9vVd6;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B5606A32C
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 897B5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=f3F9vVd6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=NtpWopRcN0wJjmDls+K0Ca4Cj+AbA7EcSijbuS4eMWk=; b=f
	3F9vVd6OuwJEJLpwKwWlXbT7z61hw/jdNN7jyNa8VLliLIKKbl3ehRzP3Hvs68o7
	7dmwbPlmSTA20sANoJ6kRe3FkK8xn3jS2TCqaouwUgSmIdd4eZJG1UAZ/Z6y4Fue
	EV0AnHrxKpCgXa1InEineXR6RA7V5EoAi975RVysPM=
Date: Fri, 20 Nov 2026 15:15:29 +0800 (CST)
From: "Lange Tang" <lange_tang@163.com>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>,
	"Eugenio Perez" <eperezma@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tang Longjun" <tanglongjun@kylinos.cn>
Subject: Re:Re: [PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20261112175235-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-4-lange_tang@163.com>
 <20261112175235-mutt-send-email-mst@kernel.org>
X-NTES-SC: AL_Qu2SB/2et0Ep7yKdY+kfmUgRg+c/XsK4svUj24VVOJF8jCDp+SEJYHZTFGvuwfi3ASqsmSO8ahFRxdZ2Wohybrgl90XuSiVc46IAOGDVhhdbrw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-ID: <f2f9771.5acd.1a1f7cf6f72.Coremail.lange_tang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aigvCgDXv8WR8_9qk35yAA--.338W
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-RG76Wr-85F9RQAA3x
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNi0xMS0xMyAwNjo1Mjo1MywgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQu
Y29tPiB3cm90ZToKPk9uIE1vbiwgTm92IDA5LCAyMDI2IGF0IDA1OjQzOjEwUE0gKzA4MDAsIExv
bmdqdW4gVGFuZyB3cm90ZToKPj4gRnJvbTogTG9uZ2p1biBUYW5nIDx0YW5nbG9uZ2p1bkBreWxp
bm9zLmNuPgo+PiAKPj4gQWRkIGFuIHJ4X3RpbWVvdXRzIGZpZWxkIHRvIHRoZSBwZXItcXVldWUg
Ulggc3RhdGlzdGljcyBhbmQgZXhwb3NlIGl0Cj4+IHZpYSBldGh0b29sLiBXaGVuZXZlciBhbiBS
WCBxdWV1ZSBnZXRzIHN0dWNrLCB0aGUgTkFQSSBwb2xsIGluY3JlbWVudHMKPj4gcnhfdGltZW91
dHMsIHNvIGl0IGNvdW50cyBSWCBxdWV1ZSBzdHVjayBldmVudHMuCj4+IAo+PiBTaWduZWQtb2Zm
LWJ5OiBMb25nanVuIFRhbmcgPHRhbmdsb25nanVuQGt5bGlub3MuY24+Cj4+IC0tLQo+PiAgZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIHwgOCArKysrKysrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiBpbmRleCBlYzdjMjQ4MDgwYzUuLmZlYjZi
ZmJiMWM1YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+ICsrKyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiBAQCAtMTM1LDYgKzEzNSw3IEBAIHN0cnVjdCB2
aXJ0bmV0X3JxX3N0YXRzIHsKPj4gIAl1NjRfc3RhdHNfdCB4ZHBfcmVkaXJlY3RzOwo+PiAgCXU2
NF9zdGF0c190IHhkcF9kcm9wczsKPj4gIAl1NjRfc3RhdHNfdCBraWNrczsKPj4gKwl1NjRfc3Rh
dHNfdCByeF90aW1lb3V0czsKPj4gIH07Cj4+ICAKPj4gICNkZWZpbmUgVklSVE5FVF9TUV9TVEFU
KG5hbWUsIG0pIHtuYW1lLCBvZmZzZXRvZihzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0cywgbSksIC0x
fQo+PiBAQCAtMTY4LDYgKzE2OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmlydG5ldF9zdGF0
X2Rlc2MgdmlydG5ldF9ycV9zdGF0c19kZXNjW10gPSB7Cj4+ICAJVklSVE5FVF9SUV9TVEFUKCJ4
ZHBfcmVkaXJlY3RzIiwgeGRwX3JlZGlyZWN0cyksCj4+ICAJVklSVE5FVF9SUV9TVEFUKCJ4ZHBf
ZHJvcHMiLCAgICAgeGRwX2Ryb3BzKSwKPj4gIAlWSVJUTkVUX1JRX1NUQVQoImtpY2tzIiwgICAg
ICAgICBraWNrcyksCj4+ICsJVklSVE5FVF9SUV9TVEFUKCJyeF90aW1lb3V0cyIsICAgcnhfdGlt
ZW91dHMpLAo+PiAgfTsKPj4KPgo+SXMgdGhpcyBjb25zaXN0ZW50IHdpdGggYW55IG90aGVyIGhh
cmR3YXJlPwoKUmVuYW1lZCB0byBzdGFsbHMgaW4gdjIuIE5vIG90aGVyIEhXIGV4cG9zZXMgdGhp
cyBleGFjdCBjb3VudGVyOyBpdCBjb3VudHMgZHJpdmVyLWRldGVjdGVkClJYIHN0YWxscy4KPiAg
Cj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHZpcnRuZXRfc3RhdF9kZXNjIHZpcnRuZXRfc3Ffc3Rh
dHNfZGVzY19xc3RhdFtdID0gewo+PiBAQCAtMjk4Myw2ICsyOTg1LDEyIEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9yZWNlaXZlKHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwgaW50IGJ1ZGdldCwKPj4g
IAkJdTY0X3N0YXRzX2FkZChpdGVtLCB1NjRfc3RhdHNfcmVhZChzcmMpKTsKPj4gIAl9Cj4+ICAK
Pj4gKwkvKiBDb3VudCBhIHN0YWxsIHJlY292ZXJlZCBieSB0aGlzIHBvbGwuICovCj4+ICsJaWYg
KHJxLT53YXRjaGRvZy5zdGFsbGVkKSB7Cj4+ICsJCXU2NF9zdGF0c19pbmMoJnJxLT5zdGF0cy5y
eF90aW1lb3V0cyk7Cj4+ICsJCXJxLT53YXRjaGRvZy5zdGFsbGVkID0gZmFsc2U7Cj4+ICsJfQo+
PiArCj4+ICAJdTY0X3N0YXRzX2FkZCgmcnEtPnN0YXRzLnBhY2tldHMsIHU2NF9zdGF0c19yZWFk
KCZzdGF0cy5wYWNrZXRzKSk7Cj4+ICAJdTY0X3N0YXRzX2FkZCgmcnEtPnN0YXRzLmJ5dGVzLCB1
NjRfc3RhdHNfcmVhZCgmc3RhdHMuYnl0ZXMpKTsKPj4gIAl1NjRfc3RhdHNfYWRkKCZycS0+c3Rh
dHMuYWxsb2NfZmFpbCwgdTY0X3N0YXRzX3JlYWQoJnN0YXRzLmFsbG9jX2ZhaWwpKTsKPj4gLS0g
Cj4+IDIuNTEuMAo=
