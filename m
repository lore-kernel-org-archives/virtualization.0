Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137ABECAAD5
	for <virtualization@archiver.kernel.org>; Thu,  8 Sep 2022 11:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C25C83F17;
	Thu,  8 Sep 2022 11:05:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C25C83F17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FkR3LY1O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufdNQzwstA7o; Thu,  8 Sep 2022 11:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D25A184016;
	Thu,  8 Sep 2022 11:05:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D25A184016
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89C31C0032;
	Thu,  8 Sep 2022 11:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EE63C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 11:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44DB041B40
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 11:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44DB041B40
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=FkR3LY1O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZVnKRNoQ6orV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 11:05:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B4DB41A62
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B4DB41A62
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Sep 2022 11:05:14 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 v2-20020a056830090200b006397457afecso12081555ott.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Sep 2022 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=iQ9amRmmVnRxpXcE5umaGoOgZh5PL9H2v0qg5K1KUpw=;
 b=FkR3LY1OY2JlwgbK6I/79qBwFZ73IHRrFlPC3Iffg8LBfgJI+AqFA8VCbA9YE08PrM
 INNJheZf5j3f73H1vhNLXMuDn70X9fPyBDD+jCAnobS0TZSBROZVNzWOwqOmrgPiR4X3
 5P7VcB5k9mDpdICWiiDFuC5zPWrB6/u8xAf8+sncmS8kb7Bla+CKu8u5p4fm/+T+x7+m
 dVz1nz6q8dgK0oHfSgFXiMdXIxuSj2U0NLURb/c2Xdq8uxAGwp277ar3dM0xycpTJOf/
 3tpo4502HhrG7LSDWMES8UIi0wMv9BZgOCaIN64EAIxm68OLr/LWLrGVsUeoP4n+T6rZ
 L/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=iQ9amRmmVnRxpXcE5umaGoOgZh5PL9H2v0qg5K1KUpw=;
 b=ikJhqY6ryqVgmS05yKnLko2cT+ioja9iSMJhigjRl+ikjuKm1CdupmseCiPS29bhUC
 mNLGInJSfWlxYjIHsReMu1/UN4OolfWW2K3LzorWaUaa5N01XuVNHi0FABFlV8FR6kAj
 h04BPQfZMGuanOvzPn/T+ZSme1K9/U6WSmDxQcHQEW52x1BwRFRAXexNBXuAcve3PkVz
 GjlD1dpTPqmNb2mIDSKdiZsJpt3HZXWq/bevxsP08qCasQhpY6SKUi0/Czwz+q/BWPbb
 EqSuGV3MQyrTmXIoJW4kTa5eKKIpr/QBXPeBpgyotTqhRYBdqRvObAG+hLtqHV7QDqBB
 xlmA==
X-Gm-Message-State: ACgBeo3q2zl5WF20nnGD/WBh4ydSgn3MRfIimqyRpc1dL8Y8+WER8fqE
 8F3WfPMHDPnjEynBcisbZ6ztbQFAyX8Cr9s8RDI=
X-Google-Smtp-Source: AA6agR6oPYe4JrZ5gu/uerMql5gyw17AaKYCYrvVsF0ZW3UpTBIJiNqJdevV3y7ZXiQ0z0Vsm5Xr0IU+z9DCnUfOgxg=
X-Received: by 2002:a9d:809:0:b0:637:80b:3a3e with SMTP id
 9-20020a9d0809000000b00637080b3a3emr3135706oty.328.1662635112371; 
 Thu, 08 Sep 2022 04:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220815095423.11131-1-dmitry.osipenko@collabora.com>
 <8230a356-be38-f228-4a8e-95124e8e8db6@amd.com>
 <YxenK8xZHC6Q4Eu4@phenom.ffwll.local>
In-Reply-To: <YxenK8xZHC6Q4Eu4@phenom.ffwll.local>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 8 Sep 2022 04:04:56 -0700
Message-ID: <CAF6AEGupz-2Kg9NtDB-agHXaWHT+RV3YAvDnxN0-5N+BLakbgg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ttm: Refcount allocated tail pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, 
 Huang Rui <ray.huang@amd.com>, Trigger Huang <Trigger.Huang@gmail.com>, 
 Gert Wollny <gert.wollny@collabora.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 kvm@vger.kernel.org, 
 kernel@collabora.com, virtualization@lists.linux-foundation.org
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

T24gVHVlLCBTZXAgNiwgMjAyMiBhdCAxOjAxIFBNIERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4gd3JvdGU6Cj4KPiBPbiBNb24sIEF1ZyAxNSwgMjAyMiBhdCAxMjowNToxOVBNICswMjAw
LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4gQW0gMTUuMDguMjIgdW0gMTE6NTQgc2Nocmll
YiBEbWl0cnkgT3NpcGVua286Cj4gPiA+IEhpZ2hlciBvcmRlciBwYWdlcyBhbGxvY2F0ZWQgdXNp
bmcgYWxsb2NfcGFnZXMoKSBhcmVuJ3QgcmVmY291bnRlZCBhbmQgdGhleQo+ID4gPiBuZWVkIHRv
IGJlIHJlZmNvdW50ZWQsIG90aGVyd2lzZSBpdCdzIGltcG9zc2libGUgdG8gbWFwIHRoZW0gYnkg
S1ZNLiBUaGlzCj4gPiA+IHBhdGNoIHNldHMgdGhlIHJlZmNvdW50IG9mIHRoZSB0YWlsIHBhZ2Vz
IGFuZCBmaXhlcyB0aGUgS1ZNIG1lbW9yeSBtYXBwaW5nCj4gPiA+IGZhdWx0cy4KPiA+ID4KPiA+
ID4gV2l0aG91dCB0aGlzIGNoYW5nZSBndWVzdCB2aXJnbCBkcml2ZXIgY2FuJ3QgbWFwIGhvc3Qg
YnVmZmVycyBpbnRvIGd1ZXN0Cj4gPiA+IGFuZCBjYW4ndCBwcm92aWRlIE9wZW5HTCA0LjUgcHJv
ZmlsZSBzdXBwb3J0IHRvIHRoZSBndWVzdC4gVGhlIGhvc3QKPiA+ID4gbWFwcGluZ3MgYXJlIGFs
c28gbmVlZGVkIGZvciBlbmFibGluZyB0aGUgVmVudXMgZHJpdmVyIHVzaW5nIGhvc3QgR1BVCj4g
PiA+IGRyaXZlcnMgdGhhdCBhcmUgdXRpbGl6aW5nIFRUTS4KPiA+ID4KPiA+ID4gQmFzZWQgb24g
YSBwYXRjaCBwcm9wb3NlZCBieSBUcmlnZ2VyIEh1YW5nLgo+ID4KPiA+IFdlbGwgSSBjYW4ndCBj
b3VudCBob3cgb2Z0ZW4gSSBoYXZlIHJlcGVhdGVkIHRoaXM6IFRoaXMgaXMgYW4gYWJzb2x1dGVs
eQo+ID4gY2xlYXIgTkFLIQo+ID4KPiA+IFRUTSBwYWdlcyBhcmUgbm90IHJlZmVyZW5jZSBjb3Vu
dGVkIGluIHRoZSBmaXJzdCBwbGFjZSBhbmQgYmVjYXVzZSBvZiB0aGlzCj4gPiBnaXZpbmcgdGhl
bSB0byB2aXJnbCBpcyBpbGxlZ2FsLgo+ID4KPiA+IFBsZWFzZSBpbW1lZGlhdGVseSBzdG9wIHRo
aXMgY29tcGxldGVseSBicm9rZW4gYXBwcm9hY2guIFdlIGhhdmUgZGlzY3Vzc2VkCj4gPiB0aGlz
IG11bHRpcGxlIHRpbWVzIG5vdy4KPgo+IFllYWggd2UgbmVlZCB0byBnZXQgdGhpcyBzdHVmZiBj
bG9zZWQgZm9yIHJlYWwgYnkgdGFnZ2luZyB0aGVtIGFsbCB3aXRoCj4gVk1fSU8gb3IgVk1fUEZO
TUFQIGFzYXAuCj4KPiBJdCBzZWVtcyBvdCBiZSBhIHJlY3VycmluZyBhbW91bnQgb2YgZnVuIHRo
YXQgcGVvcGxlIHRyeSB0byBtbWFwIGRtYS1idWYKPiBhbmQgdGhlbiBjYWxsIGdldF91c2VyX3Bh
Z2VzIG9uIHRoZW0uCj4KPiBXaGljaCBqdXN0IGRvZXNuJ3Qgd29yay4gSSBndWVzcyB0aGlzIGlz
IGFsc28gd2h5IFJvYiBDbGFyayBzZW5kIG91dCB0aGF0Cj4gZG1hLWJ1ZiBwYXRjaCB0byBleHBv
cyBtYXBwaW5nIGluZm9ybWF0aW9uIChpLmUuIHdjIHZzIHdiIHZzIHVuY2FjaGVkKS4KCk5vLCBu
b3QgcmVhbGx5Li4gbXkgcGF0Y2ggd2FzIHNpbXBseSBzbyB0aGF0IHRoZSBWTU0gc2lkZSBvZiB2
aXJ0Z3B1CmNvdWxkIHNlbmQgdGhlIGNvcnJlY3QgY2FjaGUgbW9kZSB0byB0aGUgZ3Vlc3Qgd2hl
biBoYW5kZWQgYSBkbWEtYnVmCjstKQoKQlIsCi1SCgo+Cj4gVGhlcmUgc2VlbXMgdG8gYmUgc29t
ZSBzZXJpb3VzIGJvbmdoaXRzIGdvaW5nIG9uIDotLwo+IC1EYW5pZWwKPgo+ID4KPiA+IFJlZ2Fy
ZHMsCj4gPiBDaHJpc3RpYW4uCj4gPgo+ID4gPgo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZwo+ID4gPiBDYzogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BnbWFpbC5jb20+Cj4g
PiA+IExpbms6IGh0dHBzOi8vd3d3LmNvbGxhYm9yYS5jb20vbmV3cy1hbmQtYmxvZy9ibG9nLzIw
MjEvMTEvMjYvdmVudXMtb24tcWVtdS1lbmFibGluZy1uZXctdmlydHVhbC12dWxrYW4tZHJpdmVy
LyNxY29tMTM0Mwo+ID4gPiBUZXN0ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBl
bmtvQGNvbGxhYm9yYS5jb20+ICMgQU1ER1BVIChRZW11IGFuZCBjcm9zdm0pCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+
Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuYyB8IDI1ICsr
KysrKysrKysrKysrKysrKysrKysrKy0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3R0bS90dG1fcG9vbC5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcG9vbC5jCj4g
PiA+IGluZGV4IDIxYjYxNjMxZjczYS4uMTFlOTJiYjE0OWM5IDEwMDY0NAo+ID4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9wb29sLmMKPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3R0bS90dG1fcG9vbC5jCj4gPiA+IEBAIC04MSw2ICs4MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFn
ZSAqdHRtX3Bvb2xfYWxsb2NfcGFnZShzdHJ1Y3QgdHRtX3Bvb2wgKnBvb2wsIGdmcF90IGdmcF9m
bGFncywKPiA+ID4gICAgIHVuc2lnbmVkIGxvbmcgYXR0ciA9IERNQV9BVFRSX0ZPUkNFX0NPTlRJ
R1VPVVM7Cj4gPiA+ICAgICBzdHJ1Y3QgdHRtX3Bvb2xfZG1hICpkbWE7Cj4gPiA+ICAgICBzdHJ1
Y3QgcGFnZSAqcDsKPiA+ID4gKyAgIHVuc2lnbmVkIGludCBpOwo+ID4gPiAgICAgdm9pZCAqdmFk
ZHI7Cj4gPiA+ICAgICAvKiBEb24ndCBzZXQgdGhlIF9fR0ZQX0NPTVAgZmxhZyBmb3IgaGlnaGVy
IG9yZGVyIGFsbG9jYXRpb25zLgo+ID4gPiBAQCAtOTMsOCArOTQsMTAgQEAgc3RhdGljIHN0cnVj
dCBwYWdlICp0dG1fcG9vbF9hbGxvY19wYWdlKHN0cnVjdCB0dG1fcG9vbCAqcG9vbCwgZ2ZwX3Qg
Z2ZwX2ZsYWdzLAo+ID4gPiAgICAgaWYgKCFwb29sLT51c2VfZG1hX2FsbG9jKSB7Cj4gPiA+ICAg
ICAgICAgICAgIHAgPSBhbGxvY19wYWdlcyhnZnBfZmxhZ3MsIG9yZGVyKTsKPiA+ID4gLSAgICAg
ICAgICAgaWYgKHApCj4gPiA+ICsgICAgICAgICAgIGlmIChwKSB7Cj4gPiA+ICAgICAgICAgICAg
ICAgICAgICAgcC0+cHJpdmF0ZSA9IG9yZGVyOwo+ID4gPiArICAgICAgICAgICAgICAgICAgIGdv
dG8gcmVmX3RhaWxfcGFnZXM7Cj4gPiA+ICsgICAgICAgICAgIH0KPiA+ID4gICAgICAgICAgICAg
cmV0dXJuIHA7Cj4gPiA+ICAgICB9Cj4gPiA+IEBAIC0xMjAsNiArMTIzLDIzIEBAIHN0YXRpYyBz
dHJ1Y3QgcGFnZSAqdHRtX3Bvb2xfYWxsb2NfcGFnZShzdHJ1Y3QgdHRtX3Bvb2wgKnBvb2wsIGdm
cF90IGdmcF9mbGFncywKPiA+ID4gICAgIGRtYS0+dmFkZHIgPSAodW5zaWduZWQgbG9uZyl2YWRk
ciB8IG9yZGVyOwo+ID4gPiAgICAgcC0+cHJpdmF0ZSA9ICh1bnNpZ25lZCBsb25nKWRtYTsKPiA+
ID4gKwo+ID4gPiArcmVmX3RhaWxfcGFnZXM6Cj4gPiA+ICsgICAvKgo+ID4gPiArICAgICogS1ZN
IHJlcXVpcmVzIG1hcHBlZCB0YWlsIHBhZ2VzIHRvIGJlIHJlZmNvdW50ZWQgYmVjYXVzZSBwdXRf
cGFnZSgpCj4gPiA+ICsgICAgKiBpcyBpbnZva2VkIG9uIHRoZW0gaW4gdGhlIGVuZCBvZiB0aGUg
cGFnZSBmYXVsdCBoYW5kbGluZywgYW5kIHRodXMsCj4gPiA+ICsgICAgKiB0YWlsIHBhZ2VzIG5l
ZWQgdG8gYmUgcHJvdGVjdGVkIGZyb20gdGhlIHByZW1hdHVyZSByZWxlYXNpbmcuCj4gPiA+ICsg
ICAgKiBJbiBmYWN0LCBLVk0gcGFnZSBmYXVsdCBoYW5kbGVyIHJlZnVzZXMgdG8gbWFwIHRhaWwg
cGFnZXMgdG8gZ3Vlc3QKPiA+ID4gKyAgICAqIGlmIHRoZXkgYXJlbid0IHJlZmNvdW50ZWQgYmVj
YXVzZSBodmFfdG9fcGZuX3JlbWFwcGVkKCkgY2hlY2tzIHRoZQo+ID4gPiArICAgICogcmVmY291
bnQgc3BlY2lmaWNhbGx5IGZvciB0aGlzIGNhc2UuCj4gPiA+ICsgICAgKgo+ID4gPiArICAgICog
SW4gcGFydGljdWxhciwgdW5yZWZlcmVuY2VkIHRhaWwgcGFnZXMgcmVzdWx0IGluIGEgS1ZNICJC
YWQgYWRkcmVzcyIKPiA+ID4gKyAgICAqIGZhaWx1cmUgZm9yIFZNTXMgdGhhdCB1c2UgVmlydElP
LUdQVSB3aGVuIGd1ZXN0J3MgTWVzYSBWaXJHTCBkcml2ZXIKPiA+ID4gKyAgICAqIGFjY2Vzc2Vz
IG1hcHBlZCBob3N0IFRUTSBidWZmZXIgdGhhdCBjb250YWlucyB0YWlsIHBhZ2VzLgo+ID4gPiAr
ICAgICovCj4gPiA+ICsgICBmb3IgKGkgPSAxOyBpIDwgMSA8PCBvcmRlcjsgaSsrKQo+ID4gPiAr
ICAgICAgICAgICBwYWdlX3JlZl9pbmMocCArIGkpOwo+ID4gPiArCj4gPiA+ICAgICByZXR1cm4g
cDsKPiA+ID4gICBlcnJvcl9mcmVlOgo+ID4gPiBAQCAtMTMzLDYgKzE1Myw3IEBAIHN0YXRpYyB2
b2lkIHR0bV9wb29sX2ZyZWVfcGFnZShzdHJ1Y3QgdHRtX3Bvb2wgKnBvb2wsIGVudW0gdHRtX2Nh
Y2hpbmcgY2FjaGluZywKPiA+ID4gICB7Cj4gPiA+ICAgICB1bnNpZ25lZCBsb25nIGF0dHIgPSBE
TUFfQVRUUl9GT1JDRV9DT05USUdVT1VTOwo+ID4gPiAgICAgc3RydWN0IHR0bV9wb29sX2RtYSAq
ZG1hOwo+ID4gPiArICAgdW5zaWduZWQgaW50IGk7Cj4gPiA+ICAgICB2b2lkICp2YWRkcjsKPiA+
ID4gICAjaWZkZWYgQ09ORklHX1g4Ngo+ID4gPiBAQCAtMTQyLDYgKzE2Myw4IEBAIHN0YXRpYyB2
b2lkIHR0bV9wb29sX2ZyZWVfcGFnZShzdHJ1Y3QgdHRtX3Bvb2wgKnBvb2wsIGVudW0gdHRtX2Nh
Y2hpbmcgY2FjaGluZywKPiA+ID4gICAgIGlmIChjYWNoaW5nICE9IHR0bV9jYWNoZWQgJiYgIVBh
Z2VIaWdoTWVtKHApKQo+ID4gPiAgICAgICAgICAgICBzZXRfcGFnZXNfd2IocCwgMSA8PCBvcmRl
cik7Cj4gPiA+ICAgI2VuZGlmCj4gPiA+ICsgICBmb3IgKGkgPSAxOyBpIDwgMSA8PCBvcmRlcjsg
aSsrKQo+ID4gPiArICAgICAgICAgICBwYWdlX3JlZl9kZWMocCArIGkpOwo+ID4gPiAgICAgaWYg
KCFwb29sIHx8ICFwb29sLT51c2VfZG1hX2FsbG9jKSB7Cj4gPiA+ICAgICAgICAgICAgIF9fZnJl
ZV9wYWdlcyhwLCBvcmRlcik7Cj4gPgo+Cj4gLS0KPiBEYW5pZWwgVmV0dGVyCj4gU29mdHdhcmUg
RW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCj4gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
