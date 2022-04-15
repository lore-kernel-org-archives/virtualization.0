Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371B9C433FE
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 05:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABD1D840CB;
	Fri, 15 Apr 2022 05:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4oCK88TRTn1i; Fri, 15 Apr 2022 05:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 464DF82CDE;
	Fri, 15 Apr 2022 05:51:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A126C002F;
	Fri, 15 Apr 2022 05:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B509C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 05:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 694386101A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 05:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 039ffTo3YmYa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 05:51:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7387760B71
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 05:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650001891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvg7qjjzcKhlXPuJQVCJWvizFmo4t6XFmtZYkK1Ck7I=;
 b=h6SGCZBOmuGbgQNIwHPbClLXpOlxJbsEY/PzFrwYh7HZlwI0LdJgmeK4SASpredtKdD4Kc
 PKgyj+g6NUHdGtOoC/OMyKb9HkjtD+yz1T7txBeKzyC5lYiyqLKL9yOqAPvgHELXcvLrDT
 rCEsP2waLNeZEQ03+laqBHboYi+sUXM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-mWXPKyzuOjKoNmSESHKE3A-1; Fri, 15 Apr 2022 01:51:29 -0400
X-MC-Unique: mWXPKyzuOjKoNmSESHKE3A-1
Received: by mail-lf1-f70.google.com with SMTP id
 v13-20020a056512096d00b004487e1503d0so3180032lft.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 22:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kvg7qjjzcKhlXPuJQVCJWvizFmo4t6XFmtZYkK1Ck7I=;
 b=OXguCq8c8epdbYiOvv52j0VrcBEWaOV4v0CiArlPJi8Q4NTdXBJAUgAoHqQgtU/EOh
 zvv3fI19wDbyd3e/SKIEEfP1BIKaDltcxUeAAoA/a6DXr++vy4KlztL1818vnO8UecBa
 zlcti2E/+8/W0R0hImCIigDbiOOxJBbtN6G9aWdLCKoxBnrXnEXY9zkHSj8w0/m7kTrT
 WdHxWgLY9mNknegj7bz/eZ1sToUnszsvtFlKR3vVHn+U1qg9v404O+Ffk7Ekw9II4FQz
 sl2P2mCIyzqtNhCPk2ImtobreWaz1yxa1hYAi1BMVLhXjRgUAdkBOBGfivNACdI12njr
 L7hQ==
X-Gm-Message-State: AOAM530e+efqxoMowor4NdMEu6/NKbZAKue0vBO2KHHvudzsbfLCx6oO
 seUS0VDKKsAamkZaaGh8mGsl1fvdSjoC5/FJJR13l7K+D7dxWYs1V6IUBiHIZgCziARmSrhphUG
 9C+2/ZO6UXxtuCvZIUBfQuZJTZjsBGXT4fO7KbfYnnAxVSVlqSZo+Ft0nsg==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr4045059lfh.471.1650001887931; 
 Thu, 14 Apr 2022 22:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyS9hHKM21VRW0UY8Ve1Cbt+BdOhiCFLW4MX1/5XpMUr29jtbfQMNmVD64dtIZ4cj74T8I09XLXvQC8wZy8ZJ4=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr4045051lfh.471.1650001887708; Thu, 14
 Apr 2022 22:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220408121013.54709-1-lingshan.zhu@intel.com>
 <f3f60d6e-a506-bd58-d763-848beb0e4c26@redhat.com>
 <09a3613f-514b-c769-b8a0-25899b3d3159@intel.com>
In-Reply-To: <09a3613f-514b-c769-b8a0-25899b3d3159@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Apr 2022 13:51:16 +0800
Message-ID: <CACGkMEuLW_PypyiPVcNz-B5FWNpkzLWwzC0eaZsCih+PbNt3Cg@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: assign nr_vring to the MSI vector of
 config_intr by default
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, mst <mst@redhat.com>
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

T24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgNToxNiBQTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA0LzEzLzIwMjIgNDoxNCBQTSwgSmFzb24g
V2FuZyB3cm90ZToKPiA+Cj4gPiDlnKggMjAyMi80Lzgg5LiL5Y2IODoxMCwgWmh1IExpbmdzaGFu
IOWGmemBkzoKPiA+PiBUaGlzIGNvbW1pdCBhc3NpZ24gc3RydWN0IGlmY3ZmX2h3Lm5yX3ZyaW5n
IHRvIHRoZSBNU0lYIHZlY3RvciBvZiB0aGUKPiA+PiBjb25maWcgaW50ZXJydXB0IGJ5IGRlZmF1
bHQgaW4gaWZjdmZfcmVxdWVzdF9jb25maWdfaXJxKCkuCj4gPj4gaWZjdmZfaHcubnJfdnJpbmcg
aXMgdGhlIG1vc3QgbGlrZWx5IGFuZCB0aGUgaWRlYWwgY2FzZSBmb3IKPiA+PiB0aGUgZGV2aWNl
IGNvbmZpZyBpbnRlcnJ1cHQgaGFuZGxpbmcsIG1lYW5zIGV2ZXJ5IHZpcnRxdWV1ZSBoYXMKPiA+
PiBhbiBpbmRpdmlkdWFsIE1TSVggdmVjdG9yKDAgfiBucl92cmluZyAtIDEpLCBhbmQgdGhlIGNv
bmZpZyBpbnRlcnJ1cHQKPiA+PiBoYXMKPiA+PiBpdHMgb3duIE1TSVggdmVjdG9yKG51bWJlciBu
cl92cmluZykuCj4gPj4KPiA+PiBUaGlzIGNoYW5nZSBjYW4gYWxzbyBtYWtlIEdDQyBXID0gMiBo
YXBweSwgc2lsZW5jZSB0aGUKPiA+PiAidW5pbml0aWFsaXplZCIgd2FybmluZy4KPiA+Pgo+ID4+
IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+
PiBSZXZpZXdlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+
ID4+IC0tLQo+ID4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDggKysrKy0t
LS0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+
ID4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4+IGluZGV4IDQzNjYzMjBm
YjY4ZC4uYjUwMGZiOTQxZGFiIDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
Pj4gQEAgLTI5MCwxMyArMjkwLDEzIEBAIHN0YXRpYyBpbnQgaWZjdmZfcmVxdWVzdF9jb25maWdf
aXJxKHN0cnVjdAo+ID4+IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIpCj4gPj4gICAgICAgc3RydWN0
IGlmY3ZmX2h3ICp2ZiA9ICZhZGFwdGVyLT52ZjsKPiA+PiAgICAgICBpbnQgY29uZmlnX3ZlY3Rv
ciwgcmV0Owo+ID4+ICAgKyAgICAvKiB2ZWN0b3IgMCB+IHZmLT5ucl92cmluZyBmb3IgdnFzLCBu
dW0gdmYtPm5yX3ZyaW5nIHZlY3Rvcgo+ID4+IGZvciBjb25maWcgaW50ZXJydXB0ICovCj4gPgo+
ID4KPiA+IFRoZSBjb21tZW50IGlzIHJpZ2h0IGJlZm9yZSB0aGlzIHBhdGNoLCBidXQgcHJvYmFi
bHkgd3JvbmcgZm9yCj4gPiBNU0lYX1ZFQ1RPUl9ERVZfU0hBUkVELgo+IFRoaXMgY29tbWVudCBp
cyBmb3IgdGhlIGNhc2Ugd2hlbiBldmVyeSB2cSBhbmQgY29uZmlnIGludGVycnVwdCBoYXMgaXRz
Cj4gb3duIHZlY3RvciwgaG93Cj4gYWJvdXQgYSBiZXR0ZXIgY29tbWVudCAiVGhlIGlkZWFsIHRo
ZSBkZWZhdWx0IGNhc2UsIHZlY3RvciAwIH4KPiB2Zi0+bnJfdnJpbmcgZm9yIHZxcywgbnVtIHZm
LT5ucl92cmluZyB2ZWN0b3IgZm9yIGNvbmZpZyBpbnRlcnJ1cHQiCgpBY3R1YWxseSwgSSBzdWdn
ZXN0IHRvIHJlbW92ZSB0aGUgY29tbWVudCBzaW5jZSB0aGUgY29kZSBjYW4gZXhwbGFpbiBpdHNl
bGYuCgo+ID4KPiA+Cj4gPj4gKyAgICBjb25maWdfdmVjdG9yID0gdmYtPm5yX3ZyaW5nOwo+ID4+
ICsKPiA+PiArICAgIC8qIHJlLXVzZSB0aGUgdnFzIHZlY3RvciAqLwo+ID4+ICAgICAgIGlmICh2
Zi0+bXNpeF92ZWN0b3Jfc3RhdHVzID09IE1TSVhfVkVDVE9SX0RFVl9TSEFSRUQpCj4gPj4gICAg
ICAgICAgIHJldHVybiAwOwo+ID4+ICAgLSAgICBpZiAodmYtPm1zaXhfdmVjdG9yX3N0YXR1cyA9
PSBNU0lYX1ZFQ1RPUl9QRVJfVlFfQU5EX0NPTkZJRykKPiA+PiAtICAgICAgICAvKiB2ZWN0b3Ig
MCB+IHZmLT5ucl92cmluZyBmb3IgdnFzLCBudW0gdmYtPm5yX3ZyaW5nIHZlY3Rvcgo+ID4+IGZv
ciBjb25maWcgaW50ZXJydXB0ICovCj4gPj4gLSAgICAgICAgY29uZmlnX3ZlY3RvciA9IHZmLT5u
cl92cmluZzsKPiA+PiAtCj4gPj4gICAgICAgaWYgKHZmLT5tc2l4X3ZlY3Rvcl9zdGF0dXMgPT0g
TVNJWF9WRUNUT1JfU0hBUkVEX1ZRX0FORF9DT05GSUcpCj4gPj4gICAgICAgICAgIC8qIHZlY3Rv
ciAwIGZvciB2cXMgYW5kIDEgZm9yIGNvbmZpZyBpbnRlcnJ1cHQgKi8KPiA+PiAgICAgICAgICAg
Y29uZmlnX3ZlY3RvciA9IDE7Cj4gPgo+ID4KPiA+IEFjdHVhbGx5LCBJIHByZWZlciB0byB1c2Ug
aWYgLi4uIGVsc2UgLi4uIGhlcmUuCj4gSU1ITywgaWYgZWxzZSBtYXkgbGVhZCB0byBtaXN0YWtl
cy4KPgo+IFRoZSBjb2RlOgo+ICAgICAgICAgIC8qIFRoZSBpZGVhbCB0aGUgZGVmYXVsdCBjYXNl
LCB2ZWN0b3IgMCB+IHZmLT5ucl92cmluZyBmb3IgdnFzLAo+IG51bSB2Zi0+bnJfdnJpbmcgdmVj
dG9yIGZvciBjb25maWcgaW50ZXJydXB0ICovCj4gICAgICAgICAgY29uZmlnX3ZlY3RvciA9IHZm
LT5ucl92cmluZzsKPgo+ICAgICAgICAgIC8qIHJlLXVzZSB0aGUgdnFzIHZlY3RvciAqLwo+ICAg
ICAgICAgIGlmICh2Zi0+bXNpeF92ZWN0b3Jfc3RhdHVzID09IE1TSVhfVkVDVE9SX0RFVl9TSEFS
RUQpCj4gICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPgo+ICAgICAgICAgIGlmICh2Zi0+bXNp
eF92ZWN0b3Jfc3RhdHVzID09IE1TSVhfVkVDVE9SX1NIQVJFRF9WUV9BTkRfQ09ORklHKQo+ICAg
ICAgICAgICAgICAgICAgLyogdmVjdG9yIDAgZm9yIHZxcyBhbmQgMSBmb3IgY29uZmlnIGludGVy
cnVwdCAqLwo+ICAgICAgICAgICAgICAgICAgY29uZmlnX3ZlY3RvciA9IDE7Cj4KPgo+IGhlcmUg
YnkgZGVmYXVsdCBjb25maWdfdmVjdG9yID0gdmYtPm5yX3ZyaW5nOwo+IElmIG1zaXhfdmVjdG9y
X3N0YXR1cyA9PSBNU0lYX1ZFQ1RPUl9ERVZfU0hBUkVELCBpdCB3aWxsIHJldXNlIHRoZSBkZXYK
PiBzaGFyZWQgdmVjdG9yLCBtZWFucyB1c2luZyB0aGUgdmVjdG9yKHZhbHVlIDApIGZvciBkYXRh
LXZxcy4KPiBJZiBtc2l4X3ZlY3Rvcl9zdGF0dXMgPT0gTVNJWF9WRUNUT1JfU0hBUkVEX1ZRX0FO
RF9DT05GSUcsIGl0IHdpbGwgdXNlCj4gdmVjdG9yPTEodmVjdG9yIDAgZm9yIGRhdGEtdnFzKS4K
Pgo+IElmIHdlIHVzZSBpZi4uLmVsc2UsIGl0IHdpbGwgYmU6Cj4KPiAgICAgICAgICAvKiByZS11
c2UgdGhlIHZxcyB2ZWN0b3IgKi8KPiAgICAgICAgICBpZiAodmYtPm1zaXhfdmVjdG9yX3N0YXR1
cyA9PSBNU0lYX1ZFQ1RPUl9ERVZfU0hBUkVEKQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7
Cj4gICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICAgY29uZmlnX3ZlY3RvciA9IDE7Cj4K
PiBUaGlzIGxvb2tzIGxpa2UgY29uZmlnX3ZlY3RvciBjYW4gb25seSBiZSAwKHJlLXVzZWQgdmVj
dG9yIGZvciB0aGUKPiBkYXRhLXZxcywgd2hpY2ggaXMgMCkgb3IgMS4gSXQgc2hhZG93cyB0aGUg
aWRlYWwgYW5kIGRlZmF1bHQgY2FzZQo+IGNvbmZpZ192ZWN0b3IgPSB2Zi0+bnJfdnJpbmcKCkkg
bWVhbnQgc29tZXRoaW5nIGxpa2UKCmlmIChERVZfU0hBUkVEKQogICAgcmV0dXJuIDA7CmVsc2Ug
aWYgIChTSEFSRURfVlFfQU5EX0NPTkZJRykKICAgIGNvbmZpZ192ZWN0b3IgPSAxCmVsc2UgaWYg
KFBFUl9WUV9BTkRfQ09ORklHKQogICAgY29uZmlnX3ZlY3RvciA9IHZmLT5ucl92cmluZwplbHNl
CiAgICByZXR1cm4gLUVJTlZBTDsKCm9yIHVzaW5nIGEgc3dpdGNoIGhlcmUuCgooV2UgZ2V0IHRo
ZSB3YXJuaW5nIGJlY2F1c2UgdGhlcmUncyBubyB3YXkgZm9yIHRoZSBjaGVja2VyIHRvIGtub3cK
dGhhdCBtc2l4X3ZlY3Rvcl9zdGF0dXMgbXVzdCBiZSBERVZfU0hBUkVELCBTSEFSRURfVlFfQU5E
X0NPTkZJRyBhbmQKUEVSX1ZRX0FORF9DT05GSUcpLgoKVGhhbmtzCgo+Cj4gVGhhbmtzLAo+IFpo
dSBMaW5nc2hhbgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
