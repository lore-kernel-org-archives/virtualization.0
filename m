Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23833C55178
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C20021D43
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 09:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kaemmelot.de header.i=@kaemmelot.de header.b="iFcSluT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C20021D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaemmelot.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A484204D5;
	Fri, 23 Oct 2020 09:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RiS3E2c-4ddk; Fri, 23 Oct 2020 09:01:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 77F8E2036D;
	Fri, 23 Oct 2020 09:01:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6237FC088B;
	Fri, 23 Oct 2020 09:01:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE595C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B9D2886842
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fUtVpTQy-J2I
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 069CA867BB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 09:01:04 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:105:465:1:1:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CHdW06q6WzQlWP;
 Fri, 23 Oct 2020 11:01:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaemmelot.de;
 s=MBO0001; t=1603443659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OlMEH0NvEnXxnTruitfKNNAO+3J0q+uQpeoqS8Vv18=;
 b=iFcSluT8XYIrwCkR3ZzKqlyXoJNEz4a0at/B/gPmdvRZ+OTsjx4MOWeyKsP/3BLC15GbrT
 fr2I/+AVvWZRwY1kcIl8tixiFc1z9wg0lV+Cr2iFrHAG427hGq2Qx/Iut/RQ1D1+JpXql1
 PaBo9e1KatCzqtfy2dGP2it03IXtuIpu29tuVOpdC8+jQKY/h1aQV2nE6ZVFxltGfm/4BA
 qL0o188Q0iOaWbKussDLsyn60k/vOszsVtrFGfRghOjKLfrSUWt0aA2DiirhSxbgNtcoLR
 G7SWRAjwsdX4xdfcIWNYR5W/hkgj5fELw+j16KxcfDc4QDiqFkxKnc4T86BuuA==
Received: from smtp1.mailbox.org ([80.241.60.240])
 by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de
 [80.241.56.117]) (amavisd-new, port 10030)
 with ESMTP id sINjbdp6fDBc; Fri, 23 Oct 2020 11:00:55 +0200 (CEST)
Date: Fri, 23 Oct 2020 11:00:54 +0200 (CEST)
From: Sebastian Hofmann <sebastian@kaemmelot.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1419750420.56704.1603443654667@office.mailbox.org>
In-Reply-To: <20201022073716-mutt-send-email-mst@kernel.org>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.10 / 15.00 / 15.00
X-Rspamd-Queue-Id: EE44917DC
X-Rspamd-UID: 2d696f
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

PiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiBoYXQgYW0gMjIuMTAuMjAyMCAx
MzozOSBnZXNjaHJpZWJlbjoKPiAKPiAgCj4gT24gV2VkLCBPY3QgMjEsIDIwMjAgYXQgMDU6MTQ6
MjVQTSArMDIwMCwgU2ViYXN0aWFuIEhvZm1hbm4gd3JvdGU6Cj4gPiB2aXJ0aW9fcmluZyBkb2Vz
IG5vdCB3b3JrIHdpdGggYWN0aXZlIG1lbW9yeSBlbmNyeXB0aW9uIGJlY2F1c2UgdGhlIGhvc3Qg
Y2Fubm90IHJlYWQgaXQuIEZpeCB0aGlzIGJ5IGVuZm9yY2luZyB0aGUgdXNlIG9mIERNQSB3aGlj
aCB1c2VzIHNoYXJlZCAodW5lbmNyeXB0ZWQpIG1lbW9yeSBwYWdlcy4KPiA+IAo+ID4gU2lnbmVk
LW9mZi1ieTogU2ViYXN0aWFuIEhvZm1hbm4gPHNlYmFzdGlhbkBrYWVtbWVsb3QuZGU+Cj4gCj4g
Cj4gU29ycnksIG5vLgo+IGhvc3Qgd2hpY2ggY2FuIG5vdCBhY2Nlc3MgYWxsIG9mIGRyaXZlciBt
ZW1vcnkgbXVzdCBzZXQgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNLgo+IAo+IE5vdCB3b3J0aCBp
dCB0byB3b3JrIGFyb3VuZCBicm9rZW4gaG9zdHMuCj4gCj4gWGVuIGlzIGFuIGV4Y2VwdGlvbiB3
ZSBjYXJyeSBhcm91bmQgc2luY2UgaXQgcHJlZGF0ZXMgdGhlCj4gaW50cm9kdWN0aW9uIG9mIFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STS4KPiAKPiAKClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSB3aGljaCBJIHdhcyBub3QgYXdhcmUgb2YuIE1heWJlIHRo
YXQgcGF0Y2ggd2FzIGEgYml0IG5hw692ZS4KCkJhc2ljYWxseSBJJ20gbG9va2luZyBmb3IgYSB3
YXkgdG8gdXNlIHZzb2NrIHdpdGggcWVtdSBvbiBBTUQgU0VWLiBXaGVuIEkgdHJ5IHRvIHVzZSBJ
T01NVSBmb3IgdnNvY2sgSSBnZXQgYW4gRU9QTk9UU1VQUCBvdXQgb2Ygdmhvc3RfdnNvY2tfc2V0
X2ZlYXR1cmVzLgoKSXMgdGhlcmUgYSByZWFzb24gd2h5IHZob3N0X3Zzb2NrX3NldF9mZWF0dXJl
cyBkb2Vzbid0IHVzZSB2aG9zdF9pbml0X2RldmljZV9pb3RsYiBhcyBkb25lIGluIHRoZSBuZXQg
ZGV2aWNlPyBCZWNhdXNlIHRoYXQgd291bGQgaGF2ZSBiZWVuIG15IG5leHQgYXR0ZW1wdC4KSSB3
b3VsZCBhcHByZWNpYXRlIGEgc2hvcnQgY29tbWVudCBvbiB0aGlzIGlkZWEgb3IgYSByZWNvbW1l
bmRhdGlvbiBmb3IgYW5vdGhlciBzb2x1dGlvbiB0aGF0IGlzIGJldHRlciB0aGFuIHRoZSBwYXRj
aCBiZWxvdy4KCj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNSAr
KysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiBpbmRleCBiZWNjNzc2OTc5NjAuLjhjNjhjNDc1ZWMyMSAxMDA2NDQKPiA+
IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBAIC0xMiw2ICsxMiw3IEBACj4gPiAgI2luY2x1ZGUgPGxp
bnV4L2hydGltZXIuaD4KPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KPiA+ICAj
aW5jbHVkZSA8eGVuL3hlbi5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9tZW1fZW5jcnlwdC5oPgo+
ID4gIAo+ID4gICNpZmRlZiBERUJVRwo+ID4gIC8qIEZvciBkZXZlbG9wbWVudCwgd2Ugd2FudCB0
byBjcmFzaCB3aGVuZXZlciB0aGUgcmluZyBpcyBzY3Jld2VkLiAqLwo+ID4gQEAgLTI1NSw2ICsy
NTYsMTAgQEAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9hcGkoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpCj4gPiAgCWlmICh4ZW5fZG9tYWluKCkpCj4gPiAgCQlyZXR1cm4gdHJ1ZTsKPiA+
ICAKPiA+ICsJLyogTWVtb3J5IGVuY3J5cHRpb24gcmVxdWlyZXMgRE1BICovCj4gPiArCWlmICht
ZW1fZW5jcnlwdF9hY3RpdmUoKSkKPiA+ICsJCXJldHVybiB0cnVlOwo+ID4gKwo+ID4gIAlyZXR1
cm4gZmFsc2U7Cj4gPiAgfQo+ID4gIAo+ID4gLS0gCj4gPiAyLjI1LjEKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
