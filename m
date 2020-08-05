Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBE9C433E0
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:21:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA935207FC
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 06:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvFZTCso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA935207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 88C1F204C6;
	Wed,  5 Aug 2020 06:21:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjHRlioSc4nY; Wed,  5 Aug 2020 06:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3923220495;
	Wed,  5 Aug 2020 06:21:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166F1C0050;
	Wed,  5 Aug 2020 06:21:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B90F4C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9B7A187E3F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7HI0VPStVdmd
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:21:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 54CD387D5D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 06:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596608476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=belqyvq/y73E8TA37BzoqGoO5Bb5fOGujdzWpp6M1Xo=;
 b=BvFZTCsogtnrC41GwbCIA0+sMkewXO4cis/4y389q0RYzaIQTMduAe567PdYiNUcvtmfqh
 onJlkBg/akxts0HSC+WNFjlQphAy7K19Qs4FGhQg2XoOg7Kh/1m1R8Eor26+05IJVUP3GD
 MD/KU/KqSZiuEVnts8XlXczCMrxNk/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-8zfC7ViYM7mmt57hsniy8A-1; Wed, 05 Aug 2020 02:21:14 -0400
X-MC-Unique: 8zfC7ViYM7mmt57hsniy8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E1D079EC3;
 Wed,  5 Aug 2020 06:21:13 +0000 (UTC)
Received: from [10.72.12.225] (ovpn-12-225.pek2.redhat.com [10.72.12.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC7245F21A;
 Wed,  5 Aug 2020 06:21:08 +0000 (UTC)
Subject: Re: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-23-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
Date: Wed, 5 Aug 2020 14:21:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-23-mst@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvOC80IOS4iuWNiDU6MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBWRFBB
IHNpbSBhY2Nlc3NlcyBjb25maWcgc3BhY2UgYXMgbmF0aXZlIGVuZGlhbiAtIHRoaXMgaXMKPiB3
cm9uZyBzaW5jZSBpdCdzIGEgbW9kZXJuIGRldmljZSBhbmQgYWN0dWFsbHkgdXNlcyBMRS4KPgo+
IEl0IG9ubHkgc3VwcG9ydHMgbW9kZXJuIGd1ZXN0cyBzbyB3ZSBjb3VsZCBwdW50IGFuZAo+IGp1
c3QgZm9yY2UgTEUsIGJ1dCBsZXQncyB1c2UgdGhlIGZ1bGwgdmlydGlvIEFQSXMgc2luY2UgcGVv
cGxlCj4gdGVuZCB0byBjb3B5L3Bhc3RlIGNvZGUsIGFuZCB0aGlzIGlzIG5vdCBkYXRhIHBhdGgg
YW55d2F5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMzEgKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGlu
ZGV4IGE5YmM1ZTBmYjM1My4uZmEwNWUwNjVmZjY5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltLmMKPiBAQCAtMjQsNiArMjQsNyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNl
Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdnJpbmdoLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvdmRw
YS5oPgo+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2J5dGVvcmRlci5oPgo+ICAgI2luY2x1ZGUg
PGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fY29u
ZmlnLmg+Cj4gICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4gQEAgLTcyLDYg
KzczLDIzIEBAIHN0cnVjdCB2ZHBhc2ltIHsKPiAgIAl1NjQgZmVhdHVyZXM7Cj4gICB9Owo+ICAg
Cj4gKy8qIFRPRE86IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCB2ZHBhc2ltX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0pCj4gK3sK
PiArCXJldHVybiB2aXJ0aW9fbGVnYWN5X2lzX2xpdHRsZV9lbmRpYW4oKSB8fAo+ICsJCSh2ZHBh
c2ltLT5mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkpOwo+ICt9Cj4gKwo+
ICtzdGF0aWMgaW5saW5lIHUxNiB2ZHBhc2ltMTZfdG9fY3B1KHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltLCBfX3ZpcnRpbzE2IHZhbCkKPiArewo+ICsJcmV0dXJuIF9fdmlydGlvMTZfdG9fY3B1KHZk
cGFzaW1faXNfbGl0dGxlX2VuZGlhbih2ZHBhc2ltKSwgdmFsKTsKPiArfQo+ICsKPiArc3RhdGlj
IGlubGluZSBfX3ZpcnRpbzE2IGNwdV90b192ZHBhc2ltMTYoc3RydWN0IHZkcGFzaW0gKnZkcGFz
aW0sIHUxNiB2YWwpCj4gK3sKPiArCXJldHVybiBfX2NwdV90b192aXJ0aW8xNih2ZHBhc2ltX2lz
X2xpdHRsZV9lbmRpYW4odmRwYXNpbSksIHZhbCk7Cj4gK30KPiArCj4gICBzdGF0aWMgc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW1fZGV2Owo+ICAgCj4gICBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZk
cGFfdG9fc2ltKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiBAQCAtMzA2LDcgKzMyNCw2IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fbmV0X2NvbmZpZ19v
cHM7Cj4gICAKPiAgIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9jcmVhdGUodm9pZCkK
PiAgIHsKPiAtCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAqY29uZmlnOwo+ICAgCXN0cnVjdCB2
ZHBhc2ltICp2ZHBhc2ltOwo+ICAgCXN0cnVjdCBkZXZpY2UgKmRldjsKPiAgIAlpbnQgcmV0ID0g
LUVOT01FTTsKPiBAQCAtMzMxLDEwICszNDgsNyBAQCBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZk
cGFzaW1fY3JlYXRlKHZvaWQpCj4gICAJaWYgKCF2ZHBhc2ltLT5idWZmZXIpCj4gICAJCWdvdG8g
ZXJyX2lvbW11Owo+ICAgCj4gLQljb25maWcgPSAmdmRwYXNpbS0+Y29uZmlnOwo+IC0JY29uZmln
LT5tdHUgPSAxNTAwOwo+IC0JY29uZmlnLT5zdGF0dXMgPSBWSVJUSU9fTkVUX1NfTElOS19VUDsK
PiAtCWV0aF9yYW5kb21fYWRkcihjb25maWctPm1hYyk7Cj4gKwlldGhfcmFuZG9tX2FkZHIodmRw
YXNpbS0+Y29uZmlnLm1hYyk7Cj4gICAKPiAgIAl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2ltLT52
cXNbMF0udnJpbmcsIHZkcGFzaW0tPmlvbW11KTsKPiAgIAl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBh
c2ltLT52cXNbMV0udnJpbmcsIHZkcGFzaW0tPmlvbW11KTsKPiBAQCAtNDQ4LDYgKzQ2Miw3IEBA
IHN0YXRpYyB1NjQgdmRwYXNpbV9nZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
KQo+ICAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHU2NCBmZWF0dXJlcykKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9
IHZkcGFfdG9fc2ltKHZkcGEpOwo+ICsJc3RydWN0IHZpcnRpb19uZXRfY29uZmlnICpjb25maWcg
PSAmdmRwYXNpbS0+Y29uZmlnOwo+ICAgCj4gICAJLyogRE1BIG1hcHBpbmcgbXVzdCBiZSBkb25l
IGJ5IGRyaXZlciAqLwo+ICAgCWlmICghKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfQUND
RVNTX1BMQVRGT1JNKSkpCj4gQEAgLTQ1NSw2ICs0NzAsMTIgQEAgc3RhdGljIGludCB2ZHBhc2lt
X3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHU2NCBmZWF0dXJlcykKPiAg
IAo+ICAgCXZkcGFzaW0tPmZlYXR1cmVzID0gZmVhdHVyZXMgJiB2ZHBhc2ltX2ZlYXR1cmVzOwo+
ICAgCj4gKwkvKiBXZSBvbmx5IGtub3cgd2hldGhlciBndWVzdCBpcyB1c2luZyB0aGUgbGVnYWN5
IGludGVyZmFjZSBoZXJlLCBzbwo+ICsJICogdGhhdCdzIHRoZSBlYXJsaWVzdCB3ZSBjYW4gc2V0
IGNvbmZpZyBmaWVsZHMuCj4gKwkgKi8KCgpXZSBjaGVjayB3aGV0aGVyIG9yIG5vdCBBQ0NFU1Nf
UExBVEZPUk0gaXMgc2V0IGJlZm9yZSB3aGljaCBpcyBwcm9iYWJseSAKYSBoaW50IHRoYXQgb25s
eSBtb2Rlcm4gZGV2aWNlIGlzIHN1cHBvcnRlZC4gU28gSSB3b25kZXIganVzdCBmb3JjZSBMRSAK
YW5kIGZhaWwgaWYgVkVSU0lPTl8xIGlzIG5vdCBzZXQgaXMgYmV0dGVyPwoKVGhhbmtzCgoKPiAr
Cj4gKwljb25maWctPm10dSA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgMTUwMCk7Cj4gKwlj
b25maWctPnN0YXR1cyA9IGNwdV90b192ZHBhc2ltMTYodmRwYXNpbSwgVklSVElPX05FVF9TX0xJ
TktfVVApOwo+ICAgCXJldHVybiAwOwo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
