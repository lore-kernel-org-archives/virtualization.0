Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE42C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 08:41:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561D4610EA
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 08:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 561D4610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2724E82EB6;
	Thu, 14 Oct 2021 08:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXVKOZcdgtiQ; Thu, 14 Oct 2021 08:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5B8582F49;
	Thu, 14 Oct 2021 08:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B1ADC0011;
	Thu, 14 Oct 2021 08:41:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34F26C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1354240251
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u3-k5eqVH295
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:41:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 096FF40117
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 08:41:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1338D60F9E;
 Thu, 14 Oct 2021 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1634200875;
 bh=rY9vGtlLDIvkDgY0wX20Oxpih5WsKZMgiPYMwz/VsXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TsvQCRJ72G2+iekhh/WK3vT5lHlv7ZD6YNQNgAj3L2thXFnBxsGvyUNRW7BamuMqV
 1IPExSgJeQI9q0Wym4ATW8HhvO4Aw4CJX4+DsF+KHwMiO6IDjMMu0SjL/bAsfi1hLh
 r4jkVd+UWyWv+rIV5buFUYY+dM3WYR0t5NCyZNCs=
Date: Thu, 14 Oct 2021 10:41:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YWftKQ3fTb8QlM6/@kroah.com>
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
 <YWJ7NuapWOZ4QirJ@kroah.com>
 <4dbeddb9-1068-d282-2758-55d0f788ea61@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dbeddb9-1068-d282-2758-55d0f788ea61@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, jirislaby@kernel.org,
 shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 osandov@fb.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVGh1LCBPY3QgMTQsIDIwMjEgYXQgMDQ6MzQ6NTlQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMS8xMC8xMCDkuIvljYgxOjMzLCBHcmVnIEtIIOWGmemBkzoKPiA+
IE9uIFNhdCwgT2N0IDA5LCAyMDIxIGF0IDExOjQ1OjIzUE0gKzA4MDAsIFhpYW50aW5nIFRpYW4g
d3JvdGU6Cj4gPiA+IOWcqCAyMDIxLzEwLzkg5LiL5Y2INzo1OCwgR3JlZyBLSCDlhpnpgZM6Cj4g
PiA+ID4gRGlkIHlvdSBsb29rIGF0IHRoZSBwbGFjZW1lbnQgdXNpbmcgcGFob2xlIGFzIHRvIGhv
dyB0aGlzIHN0cnVjdHVyZSBub3cKPiA+ID4gPiBsb29rcz8KPiA+ID4gdGhhbmtzIGZvciBhbGwg
eW91ciBjb21tbnRzLiBmb3IgdGhpcyBvbmUsIGRvIHlvdSBtZWFuIEkgbmVlZCB0byByZW1vdmUg
dGhlCj4gPiA+IGJsYW5rIGxpbmU/wqAgdGhhbmtzCj4gPiA+IAo+ID4gTm8sIEkgbWVhbiB0byB1
c2UgdGhlIHRvb2wgJ3BhaG9sZScgdG8gc2VlIHRoZSBzdHJ1Y3R1cmUgbGF5b3V0IHRoYXQgeW91
Cj4gPiBqdXN0IGNyZWF0ZWQgYW5kIGRldGVybWluZSBpZiBpdCByZWFsbHkgaXMgdGhlIGJlc3Qg
d2F5IHRvIGFkZCB0aGVzZSBuZXcKPiA+IGZpZWxkcywgZXNwZWNpYWxseSBhcyB5b3UgYXJlIGFk
ZGluZyBodWdlIGJ1ZmZlcnMgd2l0aCBvZGQgYWxpZ25tZW50Lgo+IAo+IHRoYW5rcywKPiAKPiBC
YXNlZCBvbiB5b3VyIGNvbW1lbnRzLCBJIHJlbW92ZWQgJ2NoYXIgb3V0Y2hhcicswqAgcmVtaWFu
IHRoZSBwb3NpdGlvbiBvZgo+ICdpbnQgb3V0YnVmX3NpemUnIHVuY2hhbmdlZCB0byBrZWVwIG91
dGJ1Zl9zaXplIGFuZCBsb2NrIGluIHRoZSBzYW1lIGNhY2hlCj4gbGluZS7CoCBOb3cgaHZjX3N0
cnVjdCBjaGFuZ2UgYXMgYmVsb3csCj4gCj4gwqBzdHJ1Y3QgaHZjX3N0cnVjdCB7Cj4gwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHR0eV9wb3J0IHBvcnQ7Cj4gwqDCoMKgwqDCoMKgwqAgc3BpbmxvY2tf
dCBsb2NrOwo+IMKgwqDCoMKgwqDCoMKgIGludCBpbmRleDsKPiDCoMKgwqDCoMKgwqDCoCBpbnQg
ZG9fd2FrZXVwOwo+IC3CoMKgwqDCoMKgwqAgY2hhciAqb3V0YnVmOwo+IMKgwqDCoMKgwqDCoMKg
IGludCBvdXRidWZfc2l6ZTsKPiDCoMKgwqDCoMKgwqDCoCBpbnQgbl9vdXRidWY7Cj4gwqDCoMKg
wqDCoMKgwqAgdWludDMyX3QgdnRlcm1ubzsKPiBAQCAtNDgsNiArNTcsMTYgQEAgc3RydWN0IGh2
Y19zdHJ1Y3Qgewo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB3b3JrX3N0cnVjdCB0dHlfcmVzaXpl
Owo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsaXN0X2hlYWQgbmV4dDsKPiDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICsKPiArwqDCoMKgwqDCoMKgIC8qCj4gK8KgwqDCoMKg
wqDCoMKgICogdGhlIGJ1ZiBpcyB1c2VkIGluIGh2YyBjb25zb2xlIGFwaSBmb3IgcHV0dGluZyBj
aGFycywKPiArwqDCoMKgwqDCoMKgwqAgKiBhbmQgYWxzbyB1c2VkIGluIGh2Y19wb2xsX3B1dF9j
aGFyKCkgZm9yIHB1dHRpbmcgc2luZ2xlIGNoYXIuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8Kg
wqDCoMKgwqDCoCBjaGFyIGNvbnNfb3V0YnVmW05fT1VUQlVGXSBfX0FMSUdORURfXzsKPiArwqDC
oMKgwqDCoMKgIHNwaW5sb2NrX3QgY29uc19vdXRidWZfbG9jazsKPiArCj4gK8KgwqDCoMKgwqDC
oCAvKiB0aGUgYnVmIGlzIHVzZWQgZm9yIHB1dHRpbmcgY2hhcnMgdG8gdHR5ICovCj4gK8KgwqDC
oMKgwqDCoCBjaGFyIG91dGJ1ZltdIF9fQUxJR05FRF9fOwo+IMKgfTsKPiAKPiBwYWhvbGUgZm9y
IGFib3ZlIGh2Y19zdHJ1Y3QgYXMgYmVsb3cswqAgaXMgaXQgb2sgZm9yIHlvdT/CoCBkbyB3ZSBu
ZWVkIHRvIHBhY2sKPiB0aGUgaG9sZT8gdGhhbmtzCj4gCj4gc3RydWN0IGh2Y19zdHJ1Y3Qgewo+
IMKgwqDCoCBzdHJ1Y3QgdHR5X3BvcnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBvcnQ7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqDCoCAwIDM1MiAqLwo+IMKgwqDCoCAv
KiAtLS0gY2FjaGVsaW5lIDUgYm91bmRhcnkgKDMyMCBieXRlcykgd2FzIDMyIGJ5dGVzIGFnbyAt
LS0gKi8KPiDCoMKgwqAgc3BpbmxvY2tfdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGxvY2s7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgIDM1MiA0ICovCj4g
wqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW5kZXg7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qwqDCoCAzNTYgNCAqLwo+IMKg
wqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRv
X3dha2V1cDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qwqDCoCAzNjAgNCAqLwo+IMKgwqDCoCBp
bnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG91dGJ1Zl9z
aXplO8KgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqAgMzY0IDQgKi8KPiDCoMKgwqAgaW50wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuX291dGJ1ZjvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgIDM2OCA0ICovCj4gwqDCoMKgIHVpbnQzMl90wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZ0ZXJtbm87wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyrCoMKgIDM3MiA0ICovCj4gwqDCoMKgIGNvbnN0IHN0cnVjdCBodl9vcHPCoCAq
wqDCoMKgwqAgb3BzO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgIDM3
NiA4ICovCj4gwqDCoMKgIC8qIC0tLSBjYWNoZWxpbmUgNiBib3VuZGFyeSAoMzg0IGJ5dGVzKSAt
LS0gKi8KPiDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpcnFfcmVxdWVzdGVkO8KgwqDCoMKgwqDCoMKgIC8qwqDCoCAzODQgNCAqLwo+IMKg
wqDCoCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRh
dGE7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgIDM4OCA0ICovCj4gwqDC
oMKgIHN0cnVjdCB3aW5zaXplwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdzO8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqAgMzkyIDggKi8KPiDCoMKgwqAgc3RydWN0
IHdvcmtfc3RydWN0wqDCoMKgwqDCoMKgwqDCoCB0dHlfcmVzaXplO8KgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qwqDCoCA0MDAgMzIgKi8KPiDCoMKgwqAgc3RydWN0IGxpc3RfaGVhZMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG5leHQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgIDQz
MiAxNiAqLwo+IMKgwqDCoCAvKiAtLS0gY2FjaGVsaW5lIDcgYm91bmRhcnkgKDQ0OCBieXRlcykg
LS0tICovCj4gwqDCoMKgIGxvbmcgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdz
O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKsKgwqAgNDQ4IDggKi8KPiAKPiDCoMKg
wqAgLyogWFhYIDU2IGJ5dGVzIGhvbGUsIHRyeSB0byBwYWNrICovCj4gCj4gwqDCoMKgIC8qIC0t
LSBjYWNoZWxpbmUgOCBib3VuZGFyeSAoNTEyIGJ5dGVzKSAtLS0gKi8KPiDCoMKgwqAgY2hhcsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnNfb3V0YnVmWzE2
XTvCoMKgwqDCoMKgIC8qwqDCoCA1MTIgMTYgKi8KPiDCoMKgwqAgc3BpbmxvY2tfdMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnNfb3V0YnVmX2xvY2s7wqDCoMKgwqAgLyrCoMKg
IDUyOCA0ICovCj4gCj4gwqDCoMKgIC8qIFhYWCA0NCBieXRlcyBob2xlLCB0cnkgdG8gcGFjayAq
LwoKV2h5IG5vdCBtb3ZlIHRoZSBzcGlubG9jayB1cCBhYm92ZSB0aGUgY29uc19vdXRidWY/ICBX
aWxsIHRoYXQgbm90IGJlIGEKYml0IGJldHRlcj8KCkFueXdheSwgdGhpcyBpcyBhbGwgZmluZSwg
YW5kIG11Y2ggYmV0dGVyIHRoYW4gYmVmb3JlLCB0aGFua3MuCgpncmVnIGstaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
