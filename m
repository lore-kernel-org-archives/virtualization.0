Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D63C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 06:49:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80E760C49
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 06:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D80E760C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9846880D55;
	Tue, 26 Oct 2021 06:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V8T3KrVPx2tq; Tue, 26 Oct 2021 06:49:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3656080DCA;
	Tue, 26 Oct 2021 06:49:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDBCC0012;
	Tue, 26 Oct 2021 06:49:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8E9EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C853180D55
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id boUZBaZjZSt2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:49:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50E8580DCA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:49:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53639603E5;
 Tue, 26 Oct 2021 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1635230985;
 bh=6f1WgNicKHo46BidqiQs8hGNGw8fYd/fygv8pn1WdIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JE2IgUzDQ9FhimLGtgYmJx7gfk7AbNK8FCvuy+1XpMpsYY3/phH8JvRkEQ5yDvHKL
 Fd8XM/W5vYHq+hiyfbvecJa62VcdGpzx0iI7SZIwoQM75oQELC2TAaF5xNQQswVtY3
 5+mM1WbvM6FhxDYvZtnIecqDd7+r/R6ui7u/9GjQ=
Date: Tue, 26 Oct 2021 08:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YXelB/WhWPqcIl/T@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
 <208f7a41-a9fa-630c-cb44-c37c503f3a72@kernel.org>
 <cd195483-93c7-23be-8f4c-9cf7f25a3065@linux.alibaba.com>
 <YXebzdZz8oN6w+T0@kroah.com>
 <8f78c1b8-c736-748d-d08b-3d6121eb5af8@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8f78c1b8-c736-748d-d08b-3d6121eb5af8@linux.alibaba.com>
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

T24gVHVlLCBPY3QgMjYsIDIwMjEgYXQgMDI6MTE6NTFQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMS8xMC8yNiDkuIvljYgyOjEwLCBHcmVnIEtIIOWGmemBkzoKPiA+
IE9uIFR1ZSwgT2N0IDI2LCAyMDIxIGF0IDAyOjAyOjIxUE0gKzA4MDAsIFhpYW50aW5nIFRpYW4g
d3JvdGU6Cj4gPiA+IOWcqCAyMDIxLzEwLzI2IOS4i+WNiDE6MTAsIEppcmkgU2xhYnkg5YaZ6YGT
Ogo+ID4gPiA+IE9uIDE1LiAxMC4gMjEsIDQ6NDYsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPiA+
ID4gPiBAQCAtMTUxLDkgKzE0MiwxMSBAQCBzdGF0aWMgdWludDMyX3QgdnRlcm1ub3NbTUFYX05S
X0hWQ19DT05TT0xFU10gPQo+ID4gPiA+ID4gIMKgIHN0YXRpYyB2b2lkIGh2Y19jb25zb2xlX3By
aW50KHN0cnVjdCBjb25zb2xlICpjbywgY29uc3QgY2hhciAqYiwKPiA+ID4gPiA+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBjb3VudCkKPiA+ID4gPiA+
ICDCoCB7Cj4gPiA+ID4gPiAtwqDCoMKgIGNoYXIgY1tOX09VVEJVRl0gX19BTElHTkVEX187Cj4g
PiA+ID4gPiArwqDCoMKgIGNoYXIgKmM7Cj4gPiA+ID4gPiAgwqDCoMKgwqDCoCB1bnNpZ25lZCBp
ID0gMCwgbiA9IDA7Cj4gPiA+ID4gPiAgwqDCoMKgwqDCoCBpbnQgciwgZG9uZWNyID0gMCwgaW5k
ZXggPSBjby0+aW5kZXg7Cj4gPiA+ID4gPiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4g
PiA+ID4gPiArwqDCoMKgIHN0cnVjdCBodmNfc3RydWN0ICpocDsKPiA+ID4gPiA+ICDCoCDCoMKg
wqDCoMKgIC8qIENvbnNvbGUgYWNjZXNzIGF0dGVtcHQgb3V0c2lkZSBvZiBhY2NlcHRhYmxlIGNv
bnNvbGUKPiA+ID4gPiA+IHJhbmdlLiAqLwo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgaWYgKGluZGV4
ID49IE1BWF9OUl9IVkNfQ09OU09MRVMpCj4gPiA+ID4gPiBAQCAtMTYzLDYgKzE1NiwxMyBAQCBz
dGF0aWMgdm9pZCBodmNfY29uc29sZV9wcmludChzdHJ1Y3QgY29uc29sZQo+ID4gPiA+ID4gKmNv
LCBjb25zdCBjaGFyICpiLAo+ID4gPiA+ID4gIMKgwqDCoMKgwqAgaWYgKHZ0ZXJtbm9zW2luZGV4
XSA9PSAtMSkKPiA+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4gPiA+ID4g
IMKgICvCoMKgwqAgaHAgPSBjb25zX2h2Y3NbaW5kZXhdOwo+ID4gPiA+ID4gK8KgwqDCoCBpZiAo
IWhwKQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJldHVybjsKPiA+ID4gPiBZb3UgZWZmZWN0
aXZlbHkgbWFrZSB0aGUgY29uc29sZSB1bnVzYWJsZSB1bnRpbCBzb21lb25lIGNhbGxzCj4gPiA+
ID4gaHZjX2FsbG9jKCkgZm9yIHRoaXMgZGV2aWNlLCBjb3JyZWN0PyBUaGlzIGRvZXNuJ3QgbG9v
ayByaWdodC4gTmVpdGhlcgo+ID4gPiA+IHlvdSBkZXNjcmliZSB0aGlzIGNoYW5nZSBvZiBiZWhh
dmlvdXIgaW4gdGhlIGNvbW1pdCBsb2cuCj4gPiA+IEkgbWVudGlvbmVkIHN1Y2ggaW5mbyBpbiB0
aGUgY29tbWl0IGxvZzoKPiA+ID4gJ0ludHJvZHVjZSBhbm90aGVyIGFycmF5KGNvbnNfaHZjc1td
KSBmb3IgaHZjIHBvaW50ZXJzIG5leHQgdG8gdGhlCj4gPiA+IGNvbnNfb3BzW10gYW5kIHZ0ZXJt
bm9zW10gYXJyYXlzLiBXaXRoIHRoZSBhcnJheSwgd2UgY2FuIGVhc2lseSBmaW5kCj4gPiA+IGh2
YydzIGNvbnNfb3V0YnVmIGFuZCBpdHMgbG9jay4nCj4gPiA+IAo+ID4gPiBBZnRlciB5b3UgcG9p
bnRlZCBpdCBvdXQsIEkganVzdCBmb3VuZCB3aGF0IHlvdSBzYWlkIG1ha2Ugc2Vuc2UsIEkgY2hl
Y2tlZCB0aGUgY29kZSBodmNfY29uc29sZV9wcmludCgpIGNhbiBzdXBwb3J0IHByaW50IGJlZm9y
ZSBodmNfYWxsb2MoKSBpcyBjYWxsZWQgd2hlbiBzb21lb25lIHVzZSBodmNfaW5zdGFudGlhdGUo
KSBmb3IgYW4gZWFybHkgY29uc29sZSBkaXNjb3ZlcnkgbWV0aG9kLgo+ID4gPiBJIHNlbmQgYSBw
YXRjaCB0byBmaXggdGhlIGlzc3VlPyAgb3IgdGhlc2Ugc2VyaWFsIHBhdGhjaGVzIHJldmVydGVk
IGZpc3J0bHkgdGhlbiBJIHJlc2VuZCBuZXcgdmVyc2lvbiBwYXRjaGVzPyB0aGFua3MKPiA+IExl
dCBtZSByZXZlcnQgdGhlc2Ugbm93IGFuZCB5b3UgY2FuIHNlbmQgYW4gdXBkYXRlZCB2ZXJzaW9u
Lgo+IE9LLCB0aGFua3MuCgpJIGhhdmUgbm93IHJldmVydGVkIHBhdGNoZXMgMi8zIGFuZCAzLzMg
aW4gdGhpcyBzZXJpZXMgZnJvbSBteSB0cmVlLgpUaGUgZmlyc3QgcGF0Y2ggd2FzIGp1c3QgZmlu
ZS4KCnRoYW5rcywKCmdyZWcgay1oCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
