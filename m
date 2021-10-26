Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB40C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 06:10:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D09E60FD7
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 06:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D09E60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 545EA404CD;
	Tue, 26 Oct 2021 06:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dFpC5Ap0wMRL; Tue, 26 Oct 2021 06:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE9D2404CB;
	Tue, 26 Oct 2021 06:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9C78C0019;
	Tue, 26 Oct 2021 06:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73DC3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45AD3401F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3SOweWlzFbtn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:10:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D5BD4012E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:10:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FB9560FD7;
 Tue, 26 Oct 2021 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1635228626;
 bh=jlo0wSpQEg3b4uT94kNaKHxLqywsLkSxtk+euI6cbGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zcyqYjur+Wxxc9kte4zvlS6ZJNMFVyYmwoGNA2tWWuQPm5Rpral6BUuiR6gYJHb7x
 OhHAfDCqRUe6AC7xKNdI+ZPUTuQ7tYDP+IRQ1PAf70hWggTtmk/8aeAkeqECxqoymn
 AonoQuErZfse6VT2SXBMLjSlaWlq0IKHZZ9zVyZ0=
Date: Tue, 26 Oct 2021 08:10:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YXebzdZz8oN6w+T0@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <208f7a41-a9fa-630c-cb44-c37c503f3a72@kernel.org>
 <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
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

T24gVHVlLCBPY3QgMjYsIDIwMjEgYXQgMDI6MDI6MjFQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiDlnKggMjAyMS8xMC8yNiDkuIvljYgxOjEwLCBKaXJpIFNsYWJ5IOWGmemBkzoKPiA+
IE9uIDE1LiAxMC4gMjEsIDQ6NDYsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPiA+IEBAIC0xNTEs
OSArMTQyLDExIEBAIHN0YXRpYyB1aW50MzJfdCB2dGVybW5vc1tNQVhfTlJfSFZDX0NPTlNPTEVT
XSA9Cj4gPiA+IMKgIHN0YXRpYyB2b2lkIGh2Y19jb25zb2xlX3ByaW50KHN0cnVjdCBjb25zb2xl
ICpjbywgY29uc3QgY2hhciAqYiwKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdW5zaWduZWQgY291bnQpCj4gPiA+IMKgIHsKPiA+ID4gLcKgwqDCoCBjaGFyIGNb
Tl9PVVRCVUZdIF9fQUxJR05FRF9fOwo+ID4gPiArwqDCoMKgIGNoYXIgKmM7Cj4gPiA+IMKgwqDC
oMKgwqAgdW5zaWduZWQgaSA9IDAsIG4gPSAwOwo+ID4gPiDCoMKgwqDCoMKgIGludCByLCBkb25l
Y3IgPSAwLCBpbmRleCA9IGNvLT5pbmRleDsKPiA+ID4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIGZs
YWdzOwo+ID4gPiArwqDCoMKgIHN0cnVjdCBodmNfc3RydWN0ICpocDsKPiA+ID4gwqAgwqDCoMKg
wqDCoCAvKiBDb25zb2xlIGFjY2VzcyBhdHRlbXB0IG91dHNpZGUgb2YgYWNjZXB0YWJsZSBjb25z
b2xlCj4gPiA+IHJhbmdlLiAqLwo+ID4gPiDCoMKgwqDCoMKgIGlmIChpbmRleCA+PSBNQVhfTlJf
SFZDX0NPTlNPTEVTKQo+ID4gPiBAQCAtMTYzLDYgKzE1NiwxMyBAQCBzdGF0aWMgdm9pZCBodmNf
Y29uc29sZV9wcmludChzdHJ1Y3QgY29uc29sZQo+ID4gPiAqY28sIGNvbnN0IGNoYXIgKmIsCj4g
PiA+IMKgwqDCoMKgwqAgaWYgKHZ0ZXJtbm9zW2luZGV4XSA9PSAtMSkKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsKPiA+ID4gwqAgK8KgwqDCoCBocCA9IGNvbnNfaHZjc1tpbmRleF07
Cj4gPiA+ICvCoMKgwqAgaWYgKCFocCkKPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+
IAo+ID4gWW91IGVmZmVjdGl2ZWx5IG1ha2UgdGhlIGNvbnNvbGUgdW51c2FibGUgdW50aWwgc29t
ZW9uZSBjYWxscwo+ID4gaHZjX2FsbG9jKCkgZm9yIHRoaXMgZGV2aWNlLCBjb3JyZWN0PyBUaGlz
IGRvZXNuJ3QgbG9vayByaWdodC4gTmVpdGhlcgo+ID4geW91IGRlc2NyaWJlIHRoaXMgY2hhbmdl
IG9mIGJlaGF2aW91ciBpbiB0aGUgY29tbWl0IGxvZy4KPiAKPiBJIG1lbnRpb25lZCBzdWNoIGlu
Zm8gaW4gdGhlIGNvbW1pdCBsb2c6Cj4gJ0ludHJvZHVjZSBhbm90aGVyIGFycmF5KGNvbnNfaHZj
c1tdKSBmb3IgaHZjIHBvaW50ZXJzIG5leHQgdG8gdGhlCj4gY29uc19vcHNbXSBhbmQgdnRlcm1u
b3NbXSBhcnJheXMuIFdpdGggdGhlIGFycmF5LCB3ZSBjYW4gZWFzaWx5IGZpbmQKPiBodmMncyBj
b25zX291dGJ1ZiBhbmQgaXRzIGxvY2suJwo+IAo+IEFmdGVyIHlvdSBwb2ludGVkIGl0IG91dCwg
SSBqdXN0IGZvdW5kIHdoYXQgeW91IHNhaWQgbWFrZSBzZW5zZSwgSSBjaGVja2VkIHRoZSBjb2Rl
IGh2Y19jb25zb2xlX3ByaW50KCkgY2FuIHN1cHBvcnQgcHJpbnQgYmVmb3JlIGh2Y19hbGxvYygp
IGlzIGNhbGxlZCB3aGVuIHNvbWVvbmUgdXNlIGh2Y19pbnN0YW50aWF0ZSgpIGZvciBhbiBlYXJs
eSBjb25zb2xlIGRpc2NvdmVyeSBtZXRob2QuCj4gSSBzZW5kIGEgcGF0Y2ggdG8gZml4IHRoZSBp
c3N1ZT8gIG9yIHRoZXNlIHNlcmlhbCBwYXRoY2hlcyByZXZlcnRlZCBmaXNydGx5IHRoZW4gSSBy
ZXNlbmQgbmV3IHZlcnNpb24gcGF0Y2hlcz8gdGhhbmtzCgpMZXQgbWUgcmV2ZXJ0IHRoZXNlIG5v
dyBhbmQgeW91IGNhbiBzZW5kIGFuIHVwZGF0ZWQgdmVyc2lvbi4KCnRoYW5rcywKCmdyZWcgay1o
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
