Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC06C76196
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 23:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E5DA616A7;
	Fri,  7 Apr 2023 23:36:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E5DA616A7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=mBwiG5b5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7KVMnAnfMgbz; Fri,  7 Apr 2023 23:36:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94F146168D;
	Fri,  7 Apr 2023 23:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94F146168D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A52FC0036;
	Fri,  7 Apr 2023 23:36:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0138FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD1408469B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:36:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD1408469B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=mBwiG5b5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lax9Jui6PGOc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11B818461A
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11B818461A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 23:36:51 +0000 (UTC)
Received: from [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895] (unknown
 [IPv6:2804:14d:72b4:8284:32a8:8167:f815:2895])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dwlsalmeida)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C54B6603133;
 Sat,  8 Apr 2023 00:36:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1680910610;
 bh=U92h6mBorkK2GfO57Y3hQxwoW1sYUwbwLA36Ut5C1Po=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=mBwiG5b5MVsT1PirCzrJr2STC4IIeHt1bhofLwHTCr/kvUCMvCDpcQGlw1PlvrbH8
 EgBMjRKPPx7+ViGjF2UfdApetygAq2YEiDu8ZmnfAovOS4frAise1umLMZHxwzEiKe
 0GGiAmjfKvzgYmp8Rff3scuTrB3VoNeOZ+S2LN0rabAHOL9kiBtAkSiHCvU3jLEoay
 n6AtxJMhhdeOI9kyswCfbuKsoRgGLcxkwUkR40UDyrL40V9l/Brs3vEGlH3s5CBxsm
 TX3Flg16U0lFFutLi6/JDnhgNwqs/TvWxTP0xbSl2L5tcLuDmcyECEstGM5oIQt3NK
 n+fVGlrwH0FqQ==
Message-ID: <f8b738940f2502e582acb59229d419825c9a1ffb.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] rust: virtio: add virtio support
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Fri, 07 Apr 2023 20:36:35 -0300
In-Reply-To: <CANeycqoh+ePXODJ57UT1UdhHDgzDXr=KoQEo7HiSDJDHha2dsQ@mail.gmail.com>
References: <20230405201416.395840-1-daniel.almeida@collabora.com>
 <20230405201416.395840-3-daniel.almeida@collabora.com>
 <CANeycqoh+ePXODJ57UT1UdhHDgzDXr=KoQEo7HiSDJDHha2dsQ@mail.gmail.com>
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
Cc: ojeda@kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Daniel Almeida via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SGkgV2Vkc29uLCBNYXJ0aW4sCgpGaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3IgdGhlIHJldmlldy4K
Cgo+ID4gK8KgwqDCoCAvLy8gVmlydElPIGRyaXZlciByZW1vdmUuCj4gPiArwqDCoMKgIC8vLwo+
ID4gK8KgwqDCoCAvLy8gQ2FsbGVkIHdoZW4gYSB2aXJ0aW8gZGV2aWNlIGlzIHJlbW92ZWQuCj4g
PiArwqDCoMKgIC8vLyBJbXBsZW1lbnRlcnMgc2hvdWxkIHByZXBhcmUgdGhlIGRldmljZSBmb3Ig
Y29tcGxldGUKPiA+IHJlbW92YWwgaGVyZS4KPiA+ICvCoMKgwqAgLy8vCj4gPiArwqDCoMKgIC8v
LyBJbiBwYXJ0aWN1bGFyLCBpbXBsZW1lbnRlcnMgbXVzdCBlbnN1cmUgbm8gYnVmZmVycyBhcmUK
PiA+IGxlZnQgb3ZlciBpbiB0aGUKPiA+ICvCoMKgwqAgLy8vIHZpcnRxdWV1ZXMgaW4gdXNlIGJ5
IGNhbGxpbmcgW2B2aXJ0cXVldWU6OmdldF9idWYoKWBdCj4gPiB1bnRpbCBgTm9uZWAgaXMKPiA+
ICvCoMKgwqAgLy8vIHJldHVybmVkLgo+IAo+IFdoYXQgaGFwcGVucyBpZiBpbXBsZW1lbnRlcnMg
ZG9uJ3QgZG8gdGhpcz8KPiAKPiBJZiB0aGlzIGlzIGEgc2FmZXR5IHJlcXVpcmVtZW50LCB3ZSBu
ZWVkIHRvIGZpbmQgYSBkaWZmZXJlbnQgd2F5IHRvCj4gZW5mb3JjZSBpdC4KPiAKPiA+IAoKVGhp
cyBpcyB0aGUgd29yc3QgcGFydCBvZiB0aGlzIHBhdGNoIGJ5IGZhciwgdW5mb3J0dW5hdGVseS4g
SWYgb25lCmRvZXNuJ3QgZG8gdGhpcywgdGhlbiBzL2hlIHdpbGwgbGVhayB0aGUgYGRhdGFgIGZp
ZWxkIHBhc3NlZCBpbiB0aHJvdWdoCmludG9fZm9yZWlnbigpIGhlcmU6CgoKCj4gKyAgICAgICAg
Ly8gU0FGRVRZOiBgc2VsZi5wdHJgIGlzIHZhbGlkIGFzIHBlciB0aGUgdHlwZSBpbnZhcmlhbnQu
Cj4gKyAgICAgICAgbGV0IHJlcyA9IHVuc2FmZSB7Cj4gKyAgICAgICAgICAgIGJpbmRpbmdzOjp2
aXJ0cXVldWVfYWRkX3NncygKPiArICAgICAgICAgICAgICAgIHNlbGYucHRyLAo+ICsgICAgICAg
ICAgICAgICAgc2dzLmFzX211dF9wdHIoKSwKPiArICAgICAgICAgICAgICAgIG51bV9vdXQgYXMg
dTMyLAo+ICsgICAgICAgICAgICAgICAgbnVtX2luIGFzIHUzMiwKPiArICAgICAgICAgICAgICAg
IGRhdGEuaW50b19mb3JlaWduKCkgYXMgXywKPiArICAgICAgICAgICAgICAgIGdmcCwKPiArICAg
ICAgICAgICAgKQo+ICsgICAgICAgIH07Cj4gKwoKTm90ZSB0aGUgY29tbWVudCBoZXJlOgoKCj4g
KyAgICAgICAgICAgIC8vIFNBRkVUWTogaWYgdGhlcmUgaXMgYSBidWZmZXIgdG9rZW4sIGl0IGNh
bWUgZnJvbQo+ICsgICAgICAgICAgICAvLyBgaW50b19mb3JlaWduKClgIGFzIGNhbGxlZCBpbiBg
YWRkX3NncygpYC4KPiArICAgICAgICAgICAgPFQ6OlByaXZhdGVEYXRhIGFzIEZvcmVpZ25Pd25h
YmxlPjo6ZnJvbV9mb3JlaWduKGJ1ZikKCgpUbyBiZSBob25lc3QsIEkgdHJpZWQgY29taW5nIHVw
IHdpdGggc29tZXRoaW5nIGNsZXZlciB0byBzb2x2ZSB0aGlzLApidXQgY291bGRuJ3QuIElkZWFs
bHkgdGhpcyBzaG91bGQgaGFwcGVuIHdoZW4gdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQ6Cgo+ICsg
ICAgZXh0ZXJuICJDIiBmbiByZW1vdmVfY2FsbGJhY2sodmlydGlvX2RldmljZTogKm11dApiaW5k
aW5nczo6dmlydGlvX2RldmljZSkgewoKCkJ1dCBJIGRpZCBub3QgZmluZCBhIHdheSB0byBpdGVy
YXRlIG92ZXIgdGhlIHRoZSBgdnFzYCBtZW1iZXIgZnJvbSB0aGUKUnVzdCBzaWRlLCBpLmUuOgoK
YGBgCgpzdHJ1Y3QgdmlydGlvX2RldmljZSB7CglpbnQgaW5kZXg7Cglib29sIGZhaWxlZDsKCWJv
b2wgY29uZmlnX2VuYWJsZWQ7Cglib29sIGNvbmZpZ19jaGFuZ2VfcGVuZGluZzsKCXNwaW5sb2Nr
X3QgY29uZmlnX2xvY2s7CglzcGlubG9ja190IHZxc19saXN0X2xvY2s7IC8qIFByb3RlY3RzIFZR
cyBsaXN0IGFjY2VzcyAqLwoJc3RydWN0IGRldmljZSBkZXY7CglzdHJ1Y3QgdmlydGlvX2Rldmlj
ZV9pZCBpZDsKCWNvbnN0IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyAqY29uZmlnOwoJY29uc3Qg
c3RydWN0IHZyaW5naF9jb25maWdfb3BzICp2cmluZ2hfY29uZmlnOwoJc3RydWN0IGxpc3RfaGVh
ZCB2cXM7IDwtLS0tLS0tLS0tLS0tLS0tLS0KYGBgCgpJcyB0aGVyZSBhbnkgd3JhcHBlcnMgb3Zl
ciBsaXN0X2Zvcl9lYWNoX2VudHJ5KCksIGV0YywgdG8gYmUgdXNlZCBmcm9tClJ1c3Q/IElmIHNv
LCBJIGNvdWxkIG5vdCBmaW5kIHRoZW0uCgpEb2luZyB0aGlzIGNsZWFudXAgZnJvbSBWaXJ0cXVl
dWU6OkRyb3AoKSBpcyBub3QgYW4gb3B0aW9uIGVpdGhlcjoKc2luY2Ugd2Ugd3JhcCBvdmVyIGEg
cG9pbnRlciBvd25lZCBieSB0aGUga2VybmVsLCB0aGVyZSdzIG5vIGd1YXJhbnRlZQp0aGF0IHRo
ZSBhY3R1YWwgdmlydHF1ZXVlIGlzIGdvaW5nIGF3YXkgd2hlbiBkcm9wIGlzIGNhbGxlZCBvbiB0
aGUKd3JhcHBlci4gSW4gZmFjdCwgdGhpcyBpcyBuZXZlciB0aGUgY2FzZSwgYXMgdmlydHF1ZXVl
cyBhcmUgZGVsZXRlZAp0aHJvdWdoIHRoaXMgY2FsbDoKCgo+ICt2b2lkIHJ1c3RfaGVscGVyX3Zp
cnRpb19kZWxfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICt7Cj4gKyAgICAgICB2
ZGV2LT5jb25maWctPmRlbF92cXModmRldik7Cj4gK30KPiArCgoKClN1Z2dlc3Rpb25zIHdlbGNv
bWUsCgotLSBEYW5pZWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
