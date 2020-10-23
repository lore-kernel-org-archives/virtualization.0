Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DDC388F9
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 10:56:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768ED20FC3
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kaemmelot.de header.i=@kaemmelot.de header.b="lFPlVHQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768ED20FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaemmelot.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 005D087815;
	Fri, 23 Oct 2020 10:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mh2tWbKOUfRt; Fri, 23 Oct 2020 10:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C4A887848;
	Fri, 23 Oct 2020 10:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2890FC0893;
	Fri, 23 Oct 2020 10:56:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC83FC0052
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 10:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9FF662078B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 10:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aWgNP7Jdhy4m
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 10:56:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by silver.osuosl.org (Postfix) with ESMTPS id CD7FD2045B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 10:56:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:1:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CHh3j2CFdzQjgh;
 Fri, 23 Oct 2020 12:56:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaemmelot.de;
 s=MBO0001; t=1603450559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48Q9/QWyr0ITmMt2VCnokJZOTiqKmCjQi/PpW0ganxc=;
 b=lFPlVHQ0LB/jTF8y1jnP6TB6m7uwYeIOnAuU8K+A+cH9UFBl6SuZKxU7B0DPvecD/PRDkT
 M7ZGUMUgcR0vefcYBhWs5mq/BsNXukOnSiWXq8VqtcJL/qSmOPKZXZOc4Iu8SHqTuyFoCY
 32h8q/LM33+9OrcOIJxQxSLCTUXbZ/Rv3kBmMwEuTsdVacEi3ZW0o2FTRD0ZXljfKEylys
 iIROxKIrbeGOMaRhr4UAyVr36HgiSNItWXc/oCGk2uud9sJLxrUGhY4j/QLJaFSqy1Hg7B
 FvnuDDleqCTdq1KU+KTap2/x5NltRn585Q6ll4bdDd+jMwQIXWXBW5uAyDDA9A==
Received: from smtp1.mailbox.org ([80.241.60.240])
 by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
 (amavisd-new, port 10030)
 with ESMTP id QKWbqfwVgQPv; Fri, 23 Oct 2020 12:55:58 +0200 (CEST)
Date: Fri, 23 Oct 2020 12:55:57 +0200 (CEST)
From: Sebastian Hofmann <sebastian@kaemmelot.de>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1556371108.50676.1603450557595@office.mailbox.org>
In-Reply-To: <ea4d2c99-1c67-797d-29dc-d122e4856d24@redhat.com>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
 <1419750420.56704.1603443654667@office.mailbox.org>
 <ea4d2c99-1c67-797d-29dc-d122e4856d24@redhat.com>
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.75 / 15.00 / 15.00
X-Rspamd-Queue-Id: 46DE21837
X-Rspamd-UID: c8e330
Cc: virtualization@lists.linux-foundation.org
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

Cj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gaGF0IGFtIDIzLjEwLjIwMjAgMTE6
MTAgZ2VzY2hyaWViZW46Cj4gCj4gIAo+IE9uIDIwMjAvMTAvMjMg5LiL5Y2INTowMCwgU2ViYXN0
aWFuIEhvZm1hbm4gd3JvdGU6Cj4gPj4gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNv
bT4gaGF0IGFtIDIyLjEwLjIwMjAgMTM6MzkgZ2VzY2hyaWViZW46Cj4gPj4KPiA+PiAgIAo+ID4+
IE9uIFdlZCwgT2N0IDIxLCAyMDIwIGF0IDA1OjE0OjI1UE0gKzAyMDAsIFNlYmFzdGlhbiBIb2Zt
YW5uIHdyb3RlOgo+ID4+PiB2aXJ0aW9fcmluZyBkb2VzIG5vdCB3b3JrIHdpdGggYWN0aXZlIG1l
bW9yeSBlbmNyeXB0aW9uIGJlY2F1c2UgdGhlIGhvc3QgY2Fubm90IHJlYWQgaXQuIEZpeCB0aGlz
IGJ5IGVuZm9yY2luZyB0aGUgdXNlIG9mIERNQSB3aGljaCB1c2VzIHNoYXJlZCAodW5lbmNyeXB0
ZWQpIG1lbW9yeSBwYWdlcy4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIEhv
Zm1hbm4gPHNlYmFzdGlhbkBrYWVtbWVsb3QuZGU+Cj4gPj4KPiA+PiBTb3JyeSwgbm8uCj4gPj4g
aG9zdCB3aGljaCBjYW4gbm90IGFjY2VzcyBhbGwgb2YgZHJpdmVyIG1lbW9yeSBtdXN0IHNldCBW
SVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0uCj4gPj4KPiA+PiBOb3Qgd29ydGggaXQgdG8gd29yayBh
cm91bmQgYnJva2VuIGhvc3RzLgo+ID4+Cj4gPj4gWGVuIGlzIGFuIGV4Y2VwdGlvbiB3ZSBjYXJy
eSBhcm91bmQgc2luY2UgaXQgcHJlZGF0ZXMgdGhlCj4gPj4gaW50cm9kdWN0aW9uIG9mIFZJUlRJ
T19GX0FDQ0VTU19QTEFURk9STS4KPiA+Pgo+ID4+Cj4gPiBUaGFua3MgZm9yIHBvaW50aW5nIG91
dCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggSSB3YXMgbm90IGF3YXJlIG9mLiBNYXli
ZSB0aGF0IHBhdGNoIHdhcyBhIGJpdCBuYcOvdmUuCj4gPgo+ID4gQmFzaWNhbGx5IEknbSBsb29r
aW5nIGZvciBhIHdheSB0byB1c2UgdnNvY2sgd2l0aCBxZW11IG9uIEFNRCBTRVYuIFdoZW4gSSB0
cnkgdG8gdXNlIElPTU1VIGZvciB2c29jayBJIGdldCBhbiBFT1BOT1RTVVBQIG91dCBvZiB2aG9z
dF92c29ja19zZXRfZmVhdHVyZXMuCj4gPgo+ID4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHZob3N0
X3Zzb2NrX3NldF9mZWF0dXJlcyBkb2Vzbid0IHVzZSB2aG9zdF9pbml0X2RldmljZV9pb3RsYiBh
cyBkb25lIGluIHRoZSBuZXQgZGV2aWNlPwo+IAo+IAo+IEl0J3MganVzdCBiZWNhdXNlIGl0IGhh
cyBiZWVuIGltcGxlbWVudGVkLiBJbiBhZGRpdGlvbiB0byBpbXBsZW1lbnQgCj4gSU9UTEIsIHRo
ZSB2aXJ0aW8tdnNvY2stcGNpIG11c3QgYWR2ZXJ0aXNlIEFUUyBjYXBhYmlsaXR5IGFzIHdlbGwu
Cj4gCj4gCj4gPiBCZWNhdXNlIHRoYXQgd291bGQgaGF2ZSBiZWVuIG15IG5leHQgYXR0ZW1wdC4K
PiA+IEkgd291bGQgYXBwcmVjaWF0ZSBhIHNob3J0IGNvbW1lbnQgb24gdGhpcyBpZGVhIG9yIGEg
cmVjb21tZW5kYXRpb24gZm9yIGFub3RoZXIgc29sdXRpb24gdGhhdCBpcyBiZXR0ZXIgdGhhbiB0
aGUgcGF0Y2ggYmVsb3cuCj4gCj4gCj4gQSBxdWVzdGlvbiwgaXMgdklPTU1VIGEgbXVzdCBmb3Ig
bWFraW5nIFNFViB3b3JrPwoKQmFzZWQgb24gdGhlIGRlbW8gY29kZSBmcm9tIEFNRCB3aGVyZSB0
aGV5IGp1c3QgdXNlICItZGV2aWNlIHZpcnRpby1zY3NpLXBjaSxpZD1zY3NpLGRpc2FibGUtbGVn
YWN5PW9uLGlvbW11X3BsYXRmb3JtPXRydWUiIGFuZCBteSB1bmRlcnN0YW5kaW5nIG9mIElPTU1V
OiBubywgSSBkb24ndCB0aGluayBzby4KClRoZSBBVFMgY2FwYWJpbGl0eSBpcyBvbmx5IHJlcXVp
cmVkIGZvciB2SU9NTVUsIHJpZ2h0PwoKPiAKPiBUaGFua3MKPiAKPiAKPiA+Cj4gPj4+IC0tLQo+
ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1ICsrKysrCj4gPj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiA+Pj4gaW5kZXggYmVjYzc3Njk3OTYwLi44YzY4YzQ3NWVjMjEgMTAwNjQ0Cj4gPj4+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ID4+PiBAQCAtMTIsNiArMTIsNyBAQAo+ID4+PiAgICNpbmNsdWRlIDxs
aW51eC9ocnRpbWVyLmg+Cj4gPj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4g
Pj4+ICAgI2luY2x1ZGUgPHhlbi94ZW4uaD4KPiA+Pj4gKyNpbmNsdWRlIDxsaW51eC9tZW1fZW5j
cnlwdC5oPgo+ID4+PiAgIAo+ID4+PiAgICNpZmRlZiBERUJVRwo+ID4+PiAgIC8qIEZvciBkZXZl
bG9wbWVudCwgd2Ugd2FudCB0byBjcmFzaCB3aGVuZXZlciB0aGUgcmluZyBpcyBzY3Jld2VkLiAq
Lwo+ID4+PiBAQCAtMjU1LDYgKzI1NiwxMCBAQCBzdGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2Fw
aShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+Pj4gICAJaWYgKHhlbl9kb21haW4oKSkK
PiA+Pj4gICAJCXJldHVybiB0cnVlOwo+ID4+PiAgIAo+ID4+PiArCS8qIE1lbW9yeSBlbmNyeXB0
aW9uIHJlcXVpcmVzIERNQSAqLwo+ID4+PiArCWlmIChtZW1fZW5jcnlwdF9hY3RpdmUoKSkKPiA+
Pj4gKwkJcmV0dXJuIHRydWU7Cj4gPj4+ICsKPiA+Pj4gICAJcmV0dXJuIGZhbHNlOwo+ID4+PiAg
IH0KPiA+Pj4gICAKPiA+Pj4gLS0gCj4gPj4+IDIuMjUuMQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
