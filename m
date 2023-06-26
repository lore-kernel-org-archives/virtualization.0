Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E096BEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 598F540964;
	Mon, 26 Jun 2023 02:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 598F540964
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MF27DNFR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LF94n8bGlG3L; Mon, 26 Jun 2023 02:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 842D3408A8;
	Mon, 26 Jun 2023 02:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 842D3408A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE1FC0037;
	Mon, 26 Jun 2023 02:33:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B441C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 647B8408A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 647B8408A8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YzdzvxUGkAGf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:33:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 457D4408A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 457D4408A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687746810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgV5sWJAB4w8Qo0IVDE5KWugA4cPbrdjatLr1BWoaJ4=;
 b=MF27DNFRzgJxbQ7aKIa71/WWn850mKCWqboCnmELAwerRgMQvbPfMuUNUziCI51yadD+3B
 QIIfdRpflGsfbBWiQLCCvW9ii86CJn/YyiYbqyh4PTAEKWVuFWIn7uMv6K66jysL7wVEQ+
 rjFa5FiAok/IVPcu/t+wa80DlTKfTxI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-sEUbzdGrPsGAkXcgmPSp3A-1; Sun, 25 Jun 2023 22:33:28 -0400
X-MC-Unique: sEUbzdGrPsGAkXcgmPSp3A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f84a8b00e3so1803760e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jun 2023 19:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687746807; x=1690338807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgV5sWJAB4w8Qo0IVDE5KWugA4cPbrdjatLr1BWoaJ4=;
 b=StmAt4GNizaSnzNF/Cg0dgoA+gaIFNWZ73k0IbopAq7f6CmNUMf+Uv/TZOylcHUkvq
 +Pf3u9M5dJYkE6VTB/t+txtVcFUoSDgYNOe9CTHCbsZEO8n3mCtOsNath6xVS3ykyyio
 teOi58xkWDOLB58eEvTr6TrvaWymMGp5ku9/K+yyjrMfwregvbLbBs3ePVJUeGWLDBuG
 A+y/qZ7Grpx++0idfBorxAqAStg1aJHc+z8C3NaP77ZtxApEpybsnA9ZyfSsEdri5Tj7
 zxDbgOJP6gcrVNl8BkOM93iwqTuZrfw3o1sBguS0DpWByhO8rxCD9s7Tafmrg5KPvjx3
 10bA==
X-Gm-Message-State: AC+VfDwpv0AnIsj9BdimRqAULjiBFjNqS965Lfg0LUKZejpwEZHDFmCw
 JR9+9QCZVDB0CnGYKY/WCDNzl+vCcTu/wEes/5tckjSVCZ5PhY/NzbUaY6IEnrZ4vDTGoELJqyE
 rxcuU0jrfPxa3Yr5/s52Uj6nXRp57RWYEOR6VVNeP8GPfY9MR5OS5RuROZA==
X-Received: by 2002:a19:6503:0:b0:4f8:7960:f72 with SMTP id
 z3-20020a196503000000b004f879600f72mr9939672lfb.44.1687746807062; 
 Sun, 25 Jun 2023 19:33:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aXe6AlkpH8wipX3TLO+KlOzEWSNBDcMrJJbDFON1Q3LKibF6t4am3kiHEon83dzvWSUAF16xf7fg1kSwFVt0=
X-Received: by 2002:a19:6503:0:b0:4f8:7960:f72 with SMTP id
 z3-20020a196503000000b004f879600f72mr9939664lfb.44.1687746806662; Sun, 25 Jun
 2023 19:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-3-lingshan.zhu@intel.com>
In-Reply-To: <20230612151420.1019504-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 10:33:15 +0800
Message-ID: <CACGkMEug3TBbG+PaP2G1zbCObqA5x9yHX5BbB1d1Q_+Aj65OvA@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] vDPA/ifcvf: detect and report max allowed vq size
To: Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMzoxNOKAr1BNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4gd3JvdGU6Cj4KPiBSYXRoZXIgdGhhbiBhIGhhcmRjb2RlLCB0aGlzIGNv
bW1pdCBkZXRlY3RzCj4gYW5kIHJlcG9ydHMgdGhlIG1heCB2YWx1ZSBvZiBhbGxvd2VkIHNpemUK
PiBvZiB0aGUgdmlydHF1ZXVlcwo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMg
fCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmggfCAgMiArLQo+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5j
IHwgIDQgKysrLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyBi
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiBpbmRleCBmODY0OTVhY2U4MjUuLmY0
ZDdkOTZjNGM4NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5j
Cj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+IEBAIC02OSw2ICs2OSwz
NyBAQCBzdGF0aWMgaW50IGlmY3ZmX3JlYWRfY29uZmlnX3JhbmdlKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gK3N0YXRpYyB1MTYgaWZjdmZfZ2V0X3Zx
X3NpemUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPiArewo+ICsgICAgICAgdTE2IHF1
ZXVlX3NpemU7Cj4gKwo+ICsgICAgICAgdnBfaW93cml0ZTE2KHFpZCwgJmh3LT5jb21tb25fY2Zn
LT5xdWV1ZV9zZWxlY3QpOwo+ICsgICAgICAgcXVldWVfc2l6ZSA9IHZwX2lvcmVhZDE2KCZody0+
Y29tbW9uX2NmZy0+cXVldWVfc2l6ZSk7Cj4gKwo+ICsgICAgICAgcmV0dXJuIHF1ZXVlX3NpemU7
Cj4gK30KPiArCj4gKy8qIFRoaXMgZnVuY3Rpb24gcmV0dXJucyB0aGUgbWF4IGFsbG93ZWQgc2Fm
ZSBzaXplIGZvcgo+ICsgKiBhbGwgdmlydHF1ZXVlcy4gSXQgaXMgdGhlIG1pbmltYWwgc2l6ZSB0
aGF0IGNhbiBiZQo+ICsgKiBzdXBwcHJ0ZWQgYnkgYWxsIHZpcnRxdWV1ZXMuCj4gKyAqLwo+ICt1
MTYgaWZjdmZfZ2V0X21heF92cV9zaXplKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3sKPiArICAg
ICAgIHUxNiBxdWV1ZV9zaXplLCBtYXhfc2l6ZSwgcWlkOwo+ICsKPiArICAgICAgIG1heF9zaXpl
ID0gaWZjdmZfZ2V0X3ZxX3NpemUoaHcsIDApOwo+ICsgICAgICAgZm9yIChxaWQgPSAxOyBxaWQg
PCBody0+bnJfdnJpbmc7IHFpZCsrKSB7Cj4gKyAgICAgICAgICAgICAgIHF1ZXVlX3NpemUgPSBp
ZmN2Zl9nZXRfdnFfc2l6ZShodywgcWlkKTsKPiArICAgICAgICAgICAgICAgLyogMCBtZWFucyB0
aGUgcXVldWUgaXMgdW5hdmFpbGFibGUgKi8KPiArICAgICAgICAgICAgICAgaWYgKCFxdWV1ZV9z
aXplKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ICsKPiArICAgICAgICAg
ICAgICAgbWF4X3NpemUgPSBtaW4ocXVldWVfc2l6ZSwgbWF4X3NpemUpOwo+ICsgICAgICAgfQo+
ICsKPiArICAgICAgIHJldHVybiBtYXhfc2l6ZTsKPiArfQo+ICsKPiAgaW50IGlmY3ZmX2luaXRf
aHcoc3RydWN0IGlmY3ZmX2h3ICpodywgc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4gIHsKPiAgICAg
ICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NhcCBjYXA7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4g
aW5kZXggZmE3OTcxODQwNTZiLi4zMDkzNWE5NWI2NzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmgKPiBAQCAtMjgsNyArMjgsNiBAQAo+ICAjZGVmaW5lIElGQ1ZGX01BWF9RVUVVRVMgICAg
ICAgMTcKPgo+ICAjZGVmaW5lIElGQ1ZGX1FVRVVFX0FMSUdOTUVOVCAgUEFHRV9TSVpFCj4gLSNk
ZWZpbmUgSUZDVkZfUVVFVUVfTUFYICAgICAgICAgICAgICAgIDMyNzY4Cj4gICNkZWZpbmUgSUZD
VkZfUENJX01BWF9SRVNPVVJDRSA2Cj4KPiAgI2RlZmluZSBJRkNWRl9MTV9DRkdfU0laRSAgICAg
ICAgICAgICAgMHg0MAo+IEBAIC0xMzgsNCArMTM3LDUgQEAgYm9vbCBpZmN2Zl9nZXRfdnFfcmVh
ZHkoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCk7Cj4gIHZvaWQgaWZjdmZfc2V0X3ZxX3Jl
YWR5KHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQsIGJvb2wgcmVhZHkpOwo+ICB2b2lkIGlm
Y3ZmX3NldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IGZlYXR1cmVz
KTsKPiAgdTY0IGlmY3ZmX2dldF9kcml2ZXJfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodyk7
Cj4gK3UxNiBpZmN2Zl9nZXRfbWF4X3ZxX3NpemUoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4gICNl
bmRpZiAvKiBfSUZDVkZfSF8gKi8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCAyYWYw
ZGU3NzFiNDkuLmMzZWNlMzk1Y2FmNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBA
IC00NTEsNyArNDUxLDkgQEAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYV9kZXYpCj4KPiAgc3RhdGljIHUxNiBpZmN2Zl92ZHBhX2dldF92cV9udW1f
bWF4KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gIHsKPiAtICAgICAgIHJldHVybiBJ
RkNWRl9RVUVVRV9NQVg7Cj4gKyAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192
Zih2ZHBhX2Rldik7Cj4gKwo+ICsgICAgICAgcmV0dXJuIGlmY3ZmX2dldF9tYXhfdnFfc2l6ZSh2
Zik7Cj4gIH0KPgo+ICBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBxaWQsCj4gLS0KPiAyLjM5LjEKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
