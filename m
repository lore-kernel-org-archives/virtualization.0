Return-Path: <SRS0=XXFA=D7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF7C2D0A3
	for <virtualization@archiver.kernel.org>; Sat, 24 Oct 2020 10:19:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE0B2226B
	for <virtualization@archiver.kernel.org>; Sat, 24 Oct 2020 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kaemmelot.de header.i=@kaemmelot.de header.b="zFVbRcS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE0B2226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaemmelot.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 691F0873FC;
	Sat, 24 Oct 2020 10:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q+7b+uPLPSbh; Sat, 24 Oct 2020 10:19:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A2C9A875FB;
	Sat, 24 Oct 2020 10:19:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61849C088B;
	Sat, 24 Oct 2020 10:19:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 777A1C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 10:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6212B86913
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 10:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vmsy+s4T0g7e
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 10:19:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CB15A86951
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 10:19:47 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CJHCN55BhzQjgg;
 Sat, 24 Oct 2020 12:19:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaemmelot.de;
 s=MBO0001; t=1603534782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKWx+wLniVAIaNCmkh1y1nhXy0dRNCvWfQdlge8InaI=;
 b=zFVbRcS8B4DIG8+hm2VIJBL0GbVepClsPypOa+ADYFkUZ7PavppuFfVmSEpoWESZNo4Lgx
 8ec9jSepSPlvGtggoGu/EdfKtifwu47cw8LsnoxUFJIEoIFUrTQYjsd1z7qmUSwBdlEqhX
 uA1kjdFmBXECG6gEMMy2rHUVHzob+sDdqSvx/mPSow4ak9ZUIH4/ieJK0xPE01QLL0vb33
 JkkJr+2SgrFKQU8yEow4HkUsKAc1s7sMb0zlgp0K5XXvk0LbOM0HyuiL4mLW22q52R+ZbT
 W9tRtmeqsHoaSkru5E2bkjznYf5Oo6s1plczIfmbLiLNqjKqx9xyzYi4ghazvA==
Received: from smtp2.mailbox.org ([80.241.60.241])
 by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173])
 (amavisd-new, port 10030)
 with ESMTP id pVX8kkf02hR3; Sat, 24 Oct 2020 12:19:41 +0200 (CEST)
Date: Sat, 24 Oct 2020 12:19:40 +0200 (CEST)
From: Sebastian Hofmann <sebastian@kaemmelot.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <101970867.58284.1603534780574@office.mailbox.org>
In-Reply-To: <20201023114903-mutt-send-email-mst@kernel.org>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
 <1419750420.56704.1603443654667@office.mailbox.org>
 <20201023114903-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.42 / 15.00 / 15.00
X-Rspamd-Queue-Id: A6E7516FD
X-Rspamd-UID: aa51a9
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

PiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiBoYXQgYW0gMjMuMTAuMjAyMCAx
Nzo0OSBnZXNjaHJpZWJlbjoKPiAKPiAgCj4gT24gRnJpLCBPY3QgMjMsIDIwMjAgYXQgMTE6MDA6
NTRBTSArMDIwMCwgU2ViYXN0aWFuIEhvZm1hbm4gd3JvdGU6Cj4gPiA+IE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+IGhhdCBhbSAyMi4xMC4yMDIwIDEzOjM5IGdlc2NocmllYmVu
Ogo+ID4gPiAKPiA+ID4gIAo+ID4gPiBPbiBXZWQsIE9jdCAyMSwgMjAyMCBhdCAwNToxNDoyNVBN
ICswMjAwLCBTZWJhc3RpYW4gSG9mbWFubiB3cm90ZToKPiA+ID4gPiB2aXJ0aW9fcmluZyBkb2Vz
IG5vdCB3b3JrIHdpdGggYWN0aXZlIG1lbW9yeSBlbmNyeXB0aW9uIGJlY2F1c2UgdGhlIGhvc3Qg
Y2Fubm90IHJlYWQgaXQuIEZpeCB0aGlzIGJ5IGVuZm9yY2luZyB0aGUgdXNlIG9mIERNQSB3aGlj
aCB1c2VzIHNoYXJlZCAodW5lbmNyeXB0ZWQpIG1lbW9yeSBwYWdlcy4KPiA+ID4gPiAKPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gSG9mbWFubiA8c2ViYXN0aWFuQGthZW1tZWxvdC5k
ZT4KPiA+ID4gCj4gPiA+IAo+ID4gPiBTb3JyeSwgbm8uCj4gPiA+IGhvc3Qgd2hpY2ggY2FuIG5v
dCBhY2Nlc3MgYWxsIG9mIGRyaXZlciBtZW1vcnkgbXVzdCBzZXQgVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNLgo+ID4gPiAKPiA+ID4gTm90IHdvcnRoIGl0IHRvIHdvcmsgYXJvdW5kIGJyb2tlbiBo
b3N0cy4KPiA+ID4gCj4gPiA+IFhlbiBpcyBhbiBleGNlcHRpb24gd2UgY2FycnkgYXJvdW5kIHNp
bmNlIGl0IHByZWRhdGVzIHRoZQo+ID4gPiBpbnRyb2R1Y3Rpb24gb2YgVklSVElPX0ZfQUNDRVNT
X1BMQVRGT1JNLgo+ID4gPiAKPiA+ID4gCj4gPiAKPiA+IFRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSB3aGljaCBJIHdhcyBub3QgYXdhcmUgb2YuIE1heWJl
IHRoYXQgcGF0Y2ggd2FzIGEgYml0IG5hw4PCr3ZlLgo+ID4gCj4gPiBCYXNpY2FsbHkgSSdtIGxv
b2tpbmcgZm9yIGEgd2F5IHRvIHVzZSB2c29jayB3aXRoIHFlbXUgb24gQU1EIFNFVi4gV2hlbiBJ
IHRyeSB0byB1c2UgSU9NTVUgZm9yIHZzb2NrIEkgZ2V0IGFuIEVPUE5PVFNVUFAgb3V0IG9mIHZo
b3N0X3Zzb2NrX3NldF9mZWF0dXJlcy4KPiA+IAo+ID4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHZo
b3N0X3Zzb2NrX3NldF9mZWF0dXJlcyBkb2Vzbid0IHVzZSB2aG9zdF9pbml0X2RldmljZV9pb3Rs
YiBhcyBkb25lIGluIHRoZSBuZXQgZGV2aWNlPyBCZWNhdXNlIHRoYXQgd291bGQgaGF2ZSBiZWVu
IG15IG5leHQgYXR0ZW1wdC4KPiA+IEkgd291bGQgYXBwcmVjaWF0ZSBhIHNob3J0IGNvbW1lbnQg
b24gdGhpcyBpZGVhIG9yIGEgcmVjb21tZW5kYXRpb24gZm9yIGFub3RoZXIgc29sdXRpb24gdGhh
dCBpcyBiZXR0ZXIgdGhhbiB0aGUgcGF0Y2ggYmVsb3cuCj4gCj4gTm90IHN1cmUgSSB1bmRlcnN0
YW5kIHRoZSBwcm9ibGVtLiBBcmUgeW91IHVzaW5nIHFlbXU/IElmIHNvIGp1c3QgYWRkCj4gaW9t
bXVfcGxhdGZvcm09b24gYW5kIHlvdSBhcmUgZG9uZS4KPiAKClRoYXQgd291bGQgYmUgbmljZSwg
YnV0IG9uY2UgSSBzZXQgaW9tbXVfcGxhdGZvcm09b24gKHVzaW5nIExpbnV4IDUuNCBhcyBob3N0
IGFuZCBndWVzdCwgcWVtdSA1LjEuMCk6CnFlbXUtc3lzdGVtLXg4Nl82NCAtZW5hYmxlLWt2bSAt
Y3B1IGhvc3QgLW1hY2hpbmUgcTM1IC1ub2dyYXBoaWMgLW5vLXVzZXItY29uZmlnIC1ub2RlZmF1
bHRzIC1zZXJpYWwgc3RkaW8gXAotZ2xvYmFsIHZpcnRpby1tbWlvLmZvcmNlLWxlZ2FjeT1vZmYg
XAotZGV2aWNlIHZob3N0LXZzb2NrLXBjaSxndWVzdC1jaWQ9MyxkaXNhYmxlLWxlZ2FjeT1vbixp
b21tdV9wbGF0Zm9ybT1vbiBcCi1vYmplY3Qgc2V2LWd1ZXN0LGlkPXNldjAsY2JpdHBvcz00Nyxy
ZWR1Y2VkLXBoeXMtYml0cz01IFwKLW1hY2hpbmUgZHVtcC1ndWVzdC1jb3JlPW9mZixtZW1vcnkt
ZW5jcnlwdGlvbj1zZXYwIFwKW3NvbWUgbW9yZSBhcmd1bWVudHMuLi5dCgouLi4KcWVtdS1zeXN0
ZW0teDg2XzY0OiB2aG9zdF9zZXRfZmVhdHVyZXMgZmFpbGVkOiBPcGVyYXRpb24gbm90IHN1cHBv
cnRlZCAoOTUpCnFlbXUtc3lzdGVtLXg4Nl82NDogRXJyb3Igc3RhcnRpbmcgdmhvc3Q6IDk1Ci4u
LgoKVGhlcmVmb3JlIG15IHF1ZXN0aW9uIGlmIGl0IHdvdWxkIGJlIGVub3VnaCB0byB1c2Ugdmhv
c3RfaW5pdF9kZXZpY2VfaW90bGIgaW5zdGVhZCBvZiByZXR1cm5pbmcgRU9QTk9UU1VQUCBpbiB2
aG9zdF92c29ja19zZXRfZmVhdHVyZXMgd2hlbiBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gaXMg
cGFzc2VkLiBFcXVpdmFsZW50IHRvIHdoYXQgSSBzZWUgaW4gdmhvc3RfbmV0X3NldF9mZWF0dXJl
cy4KT3IgbWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGltcG9ydGFudD8KCj4gPiA+ID4gLS0t
Cj4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA1ICsrKysrCj4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPiA+ID4gPiBpbmRleCBiZWNjNzc2OTc5NjAuLjhjNjhjNDc1ZWMyMSAxMDA2NDQK
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ID4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+IEBAIC0xMiw2ICsxMiw3IEBACj4g
PiA+ID4gICNpbmNsdWRlIDxsaW51eC9ocnRpbWVyLmg+Cj4gPiA+ID4gICNpbmNsdWRlIDxsaW51
eC9kbWEtbWFwcGluZy5oPgo+ID4gPiA+ICAjaW5jbHVkZSA8eGVuL3hlbi5oPgo+ID4gPiA+ICsj
aW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4KPiA+ID4gPiAgCj4gPiA+ID4gICNpZmRlZiBE
RUJVRwo+ID4gPiA+ICAvKiBGb3IgZGV2ZWxvcG1lbnQsIHdlIHdhbnQgdG8gY3Jhc2ggd2hlbmV2
ZXIgdGhlIHJpbmcgaXMgc2NyZXdlZC4gKi8KPiA+ID4gPiBAQCAtMjU1LDYgKzI1NiwxMCBAQCBz
dGF0aWMgYm9vbCB2cmluZ191c2VfZG1hX2FwaShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
PiA+ID4gPiAgCWlmICh4ZW5fZG9tYWluKCkpCj4gPiA+ID4gIAkJcmV0dXJuIHRydWU7Cj4gPiA+
ID4gIAo+ID4gPiA+ICsJLyogTWVtb3J5IGVuY3J5cHRpb24gcmVxdWlyZXMgRE1BICovCj4gPiA+
ID4gKwlpZiAobWVtX2VuY3J5cHRfYWN0aXZlKCkpCj4gPiA+ID4gKwkJcmV0dXJuIHRydWU7Cj4g
PiA+ID4gKwo+ID4gPiA+ICAJcmV0dXJuIGZhbHNlOwo+ID4gPiA+ICB9Cj4gPiA+ID4gIAo+ID4g
PiA+IC0tIAo+ID4gPiA+IDIuMjUuMQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
