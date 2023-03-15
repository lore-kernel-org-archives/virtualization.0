Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7081C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 07:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 129118146E;
	Wed, 15 Mar 2023 07:05:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 129118146E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUpIC741
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKCPJIWqYr40; Wed, 15 Mar 2023 07:05:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BFBE8144E;
	Wed, 15 Mar 2023 07:05:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BFBE8144E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C22CC0035;
	Wed, 15 Mar 2023 07:05:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 674F7C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CF5F40502
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:05:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CF5F40502
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AUpIC741
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7BxpMGPIqFq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:05:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DA41404F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DA41404F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 07:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678863933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1m9Bi27NroDgBkjwUUojDp5AK+Y/4RdJw5Soguqxzu8=;
 b=AUpIC741azukIXa5atojtibU0vnqO+80OHvb8BMI+cfvJPpI4ECh+YMQRWS5rnhJsgZGE1
 zU27hjOuCOu54jfJ448Kdnog0XG1VXunQY7EXlA9JxyJ68Hv6QwsyvLoWj7XaA0Q31sIYH
 WbNV6A7cA8KY6zK9s8d3W88wM6m3DaA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-I3oTJKvPMAmBonHBj5AFwQ-1; Wed, 15 Mar 2023 03:05:27 -0400
X-MC-Unique: I3oTJKvPMAmBonHBj5AFwQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 bj22-20020a056808199600b003869dd33f19so1216696oib.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 00:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678863926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1m9Bi27NroDgBkjwUUojDp5AK+Y/4RdJw5Soguqxzu8=;
 b=ZisNYHDuDRtiMWFSmuqOcbdRfCkgE5oYbfCSXWYPwJ3ymd78p68qjhP0pSK7NRIFWi
 CrfFF8DfKSkgKYluixaoPHTO1V6B7xnf1r7VMdXbsHC4MzwPCg3ABT0GWuFMbotnpW33
 3SvkR12QOVIrbFAywXNP1bw3edrpSSpsav6AJzoI2yu5kUKHCDfEsqOoG+z6IUAHJi8s
 MImvE/axZBm/B6pFc5JoJxbz1niEiVo8kmxdkV5d2/wX8zE0SjfDkFy0+9Ygh3LZN1EQ
 w0un0i4hQzNDZEICh8jL8nbuSp0gayFtSKK92n/iO/wz1WNrsLpFdi73OxZRovJZQ+tX
 0mkw==
X-Gm-Message-State: AO0yUKVGf2mqFKApAvpM5RaCqfACD2FTRrAGCJz+KMBLocTL9qoMsC4T
 OlwiswWbTco+KFY/f+yRy9Drg5yGQXomNZlo+NVBCTh2RWi6yV81maMtwNEtTXLCjwu1JIx1Woi
 gRHanvHBTcYny+Vew+Sx/FVzLoDow5PET/f4DG+MB+fdyJoG16xIF30oLHQ==
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id
 dq5-20020a056808428500b00383fad30d19mr548725oib.9.1678863926521; 
 Wed, 15 Mar 2023 00:05:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set/+rtGN0NeCS6hFSgOvllN0pfn+47+KEH4ofAgh/jjdRSoFwHB3Ounur3W0hk1J5lNoU4CBWNZ6kSN2nMR4WZc=
X-Received: by 2002:a05:6808:4285:b0:383:fad3:d19 with SMTP id
 dq5-20020a056808428500b00383fad30d19mr548714oib.9.1678863926277; Wed, 15 Mar
 2023 00:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230309013046.23523-1-shannon.nelson@amd.com>
 <20230309013046.23523-3-shannon.nelson@amd.com>
In-Reply-To: <20230309013046.23523-3-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Mar 2023 15:05:14 +0800
Message-ID: <CACGkMEumJLysw4Grd19fVF-LuUb+r201XWMaeCkT=kDqN41ZTg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 virtio 2/7] pds_vdpa: get vdpa management info
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgOSwgMjAyMyBhdCA5OjMx4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gRmluZCB0aGUgdkRQQSBtYW5hZ2VtZW50IGluZm9y
bWF0aW9uIGZyb20gdGhlIERTQyBpbiBvcmRlciB0bwo+IGFkdmVydGlzZSBpdCB0byB0aGUgdmRw
YSBzdWJzeXN0ZW0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5u
ZWxzb25AYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92ZHBhL3Bkcy9NYWtlZmlsZSAgICB8ICAg
MyArLQo+ICBkcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuYyAgIHwgIDEzICsrKysKPiAgZHJpdmVy
cy92ZHBhL3Bkcy9hdXhfZHJ2LmggICB8ICAgNyArKysKPiAgZHJpdmVycy92ZHBhL3Bkcy9kZWJ1
Z2ZzLmMgICB8ICAgMyArCj4gIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuYyAgfCAxMTMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgZHJpdmVycy92ZHBhL3Bkcy92ZHBh
X2Rldi5oICB8ICAxNSArKysrKwo+ICBpbmNsdWRlL2xpbnV4L3Bkcy9wZHNfdmRwYS5oIHwgIDky
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgNyBmaWxlcyBjaGFuZ2VkLCAyNDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92
ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3ZkcGEvcGRz
L3ZkcGFfZGV2LmgKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL01ha2VmaWxlIGIv
ZHJpdmVycy92ZHBhL3Bkcy9NYWtlZmlsZQo+IGluZGV4IGE5Y2QyZjQ1MGFlMS4uMTNiNTAzOTRl
YzY0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvTWFrZWZpbGUKPiArKysgYi9kcml2
ZXJzL3ZkcGEvcGRzL01ha2VmaWxlCj4gQEAgLTMsNiArMyw3IEBACj4KPiAgb2JqLSQoQ09ORklH
X1BEU19WRFBBKSA6PSBwZHNfdmRwYS5vCj4KPiAtcGRzX3ZkcGEteSA6PSBhdXhfZHJ2Lm8KPiAr
cGRzX3ZkcGEteSA6PSBhdXhfZHJ2Lm8gXAo+ICsgICAgICAgICAgICAgdmRwYV9kZXYubwo+Cj4g
IHBkc192ZHBhLSQoQ09ORklHX0RFQlVHX0ZTKSArPSBkZWJ1Z2ZzLm8KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMgYi9kcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuYwo+
IGluZGV4IGIzZjM2MTcwMjUzYy4uNjNlNDBhZTY4MjExIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS9wZHMvYXV4X2Rydi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMKPiBA
QCAtMiw2ICsyLDggQEAKPiAgLyogQ29weXJpZ2h0KGMpIDIwMjMgQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jICovCj4KPiAgI2luY2x1ZGUgPGxpbnV4L2F1eGlsaWFyeV9idXMuaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3BjaS5oPgo+ICsjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+Cj4gICNpbmNs
dWRlIDxsaW51eC9wZHMvcGRzX2NvcmUuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3Bkcy9wZHNfYXV4
YnVzLmg+Cj4gQEAgLTksNiArMTEsNyBAQAo+Cj4gICNpbmNsdWRlICJhdXhfZHJ2LmgiCj4gICNp
bmNsdWRlICJkZWJ1Z2ZzLmgiCj4gKyNpbmNsdWRlICJ2ZHBhX2Rldi5oIgo+Cj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZV9pZCBwZHNfdmRwYV9pZF90YWJsZVtdID0gewo+
ICAgICAgICAgeyAubmFtZSA9IFBEU19WRFBBX0RFVl9OQU1FLCB9LAo+IEBAIC0zMCw2ICszMyw3
IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmF1
eF9kZXYsCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+Cj4gICAgICAgICB2ZHBh
X2F1eC0+cGFkZXYgPSBwYWRldjsKPiArICAgICAgIHZkcGFfYXV4LT52Zl9pZCA9IHBjaV9pb3Zf
dmZfaWQocGFkZXYtPnZmLT5wZGV2KTsKPiAgICAgICAgIGF1eGlsaWFyeV9zZXRfZHJ2ZGF0YShh
dXhfZGV2LCB2ZHBhX2F1eCk7Cj4KPiAgICAgICAgIC8qIFJlZ2lzdGVyIG91ciBQRFMgY2xpZW50
IHdpdGggdGhlIHBkc19jb3JlICovCj4gQEAgLTQwLDggKzQ0LDE1IEBAIHN0YXRpYyBpbnQgcGRz
X3ZkcGFfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmF1eF9kZXYsCj4gICAgICAgICAg
ICAgICAgIGdvdG8gZXJyX2ZyZWVfbWVtOwo+ICAgICAgICAgfQo+Cj4gKyAgICAgICAvKiBHZXQg
ZGV2aWNlIGlkZW50IGluZm8gYW5kIHNldCB1cCB0aGUgdmRwYV9tZ210X2RldiAqLwo+ICsgICAg
ICAgZXJyID0gcGRzX3ZkcGFfZ2V0X21nbXRfaW5mbyh2ZHBhX2F1eCk7Cj4gKyAgICAgICBpZiAo
ZXJyKQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9hdXhfdW5yZWc7Cj4gKwo+ICAgICAgICAg
cmV0dXJuIDA7Cj4KPiArZXJyX2F1eF91bnJlZzoKPiArICAgICAgIHBhZGV2LT5vcHMtPnVucmVn
aXN0ZXJfY2xpZW50KHBhZGV2KTsKPiAgZXJyX2ZyZWVfbWVtOgo+ICAgICAgICAga2ZyZWUodmRw
YV9hdXgpOwo+ICAgICAgICAgYXV4aWxpYXJ5X3NldF9kcnZkYXRhKGF1eF9kZXYsIE5VTEwpOwo+
IEBAIC01NCw2ICs2NSw4IEBAIHN0YXRpYyB2b2lkIHBkc192ZHBhX3JlbW92ZShzdHJ1Y3QgYXV4
aWxpYXJ5X2RldmljZSAqYXV4X2RldikKPiAgICAgICAgIHN0cnVjdCBwZHNfdmRwYV9hdXggKnZk
cGFfYXV4ID0gYXV4aWxpYXJ5X2dldF9kcnZkYXRhKGF1eF9kZXYpOwo+ICAgICAgICAgc3RydWN0
IGRldmljZSAqZGV2ID0gJmF1eF9kZXYtPmRldjsKPgo+ICsgICAgICAgcGNpX2ZyZWVfaXJxX3Zl
Y3RvcnModmRwYV9hdXgtPnBhZGV2LT52Zi0+cGRldik7Cj4gKwo+ICAgICAgICAgdmRwYV9hdXgt
PnBhZGV2LT5vcHMtPnVucmVnaXN0ZXJfY2xpZW50KHZkcGFfYXV4LT5wYWRldik7Cj4KPiAgICAg
ICAgIGtmcmVlKHZkcGFfYXV4KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy9hdXhf
ZHJ2LmggYi9kcml2ZXJzL3ZkcGEvcGRzL2F1eF9kcnYuaAo+IGluZGV4IDE0ZTQ2NTk0NGRmZC4u
OTRiYTdhYmNhYTQzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5oCj4g
KysrIGIvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmgKPiBAQCAtMTAsNiArMTAsMTMgQEAKPiAg
c3RydWN0IHBkc192ZHBhX2F1eCB7Cj4gICAgICAgICBzdHJ1Y3QgcGRzX2F1eGlsaWFyeV9kZXYg
KnBhZGV2Owo+Cj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9tZ210X2RldiB2ZHBhX21kZXY7Cj4gKwo+
ICsgICAgICAgc3RydWN0IHBkc192ZHBhX2lkZW50IGlkZW50Owo+ICsKPiArICAgICAgIGludCB2
Zl9pZDsKPiAgICAgICAgIHN0cnVjdCBkZW50cnkgKmRlbnRyeTsKPiArCj4gKyAgICAgICBpbnQg
bmludHJzOwo+ICB9Owo+ICAjZW5kaWYgLyogX0FVWF9EUlZfSF8gKi8KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3Bkcy9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL3ZkcGEvcGRzL2RlYnVnZnMuYwo+
IGluZGV4IDNjMTYzZGM3YjY2Zi4uN2I3ZTkwZmQ2NTc4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS9wZHMvZGVidWdmcy5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy9kZWJ1Z2ZzLmMKPiBA
QCAtMSw3ICsxLDEwIEBACj4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkKPiAgLyogQ29weXJpZ2h0KGMpIDIwMjMgQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jICov
Cj4KPiArI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPiArCj4gICNpbmNsdWRlIDxsaW51eC9wZHMv
cGRzX2NvcmUuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3Bkcy9wZHNfdmRwYS5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvcGRzL3Bkc19hdXhidXMuaD4KPgo+ICAjaW5jbHVkZSAiYXV4X2Rydi5oIgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvcGRz
L3ZkcGFfZGV2LmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
YmQ4NDA2ODg1MDNjCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMvdmRw
YV9kZXYuYwo+IEBAIC0wLDAgKzEsMTEzIEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9ubHkKPiArLyogQ29weXJpZ2h0KGMpIDIwMjMgQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jICovCj4gKwo+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+Cj4gKyNpbmNsdWRlIDxs
aW51eC92ZHBhLmg+Cj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZkcGEuaD4KPiArCj4gKyNpbmNs
dWRlIDxsaW51eC9wZHMvcGRzX2NvcmUuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3Bkcy9wZHNfYWRt
aW5xLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9wZHMvcGRzX2F1eGJ1cy5oPgo+ICsjaW5jbHVkZSA8
bGludXgvcGRzL3Bkc192ZHBhLmg+Cj4gKwo+ICsjaW5jbHVkZSAidmRwYV9kZXYuaCIKPiArI2lu
Y2x1ZGUgImF1eF9kcnYuaCIKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdmlydGlvX2RldmljZV9pZCBw
ZHNfdmRwYV9pZF90YWJsZVtdID0gewo+ICsgICAgICAge1ZJUlRJT19JRF9ORVQsIFZJUlRJT19E
RVZfQU5ZX0lEfSwKPiArICAgICAgIHswfSwKPiArfTsKPiArCj4gK3N0YXRpYyBpbnQgcGRzX3Zk
cGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfZGV2X3NldF9j
b25maWcgKmFkZF9jb25maWcpCj4gK3sKPiArICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPiAr
fQo+ICsKPiArc3RhdGljIHZvaWQgcGRzX3ZkcGFfZGV2X2RlbChzdHJ1Y3QgdmRwYV9tZ210X2Rl
diAqbWRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYV9kZXYpCj4gK3sKPiArfQo+ICsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX21n
bXRkZXZfb3BzIHBkc192ZHBhX21nbXRfZGV2X29wcyA9IHsKPiArICAgICAgIC5kZXZfYWRkID0g
cGRzX3ZkcGFfZGV2X2FkZCwKPiArICAgICAgIC5kZXZfZGVsID0gcGRzX3ZkcGFfZGV2X2RlbAo+
ICt9Owo+ICsKPiAraW50IHBkc192ZHBhX2dldF9tZ210X2luZm8oc3RydWN0IHBkc192ZHBhX2F1
eCAqdmRwYV9hdXgpCj4gK3sKPiArICAgICAgIHN0cnVjdCBwZHNfdmRwYV9pZGVudF9jbWQgaWRl
bnRfY21kID0gewo+ICsgICAgICAgICAgICAgICAub3Bjb2RlID0gUERTX1ZEUEFfQ01EX0lERU5U
LAo+ICsgICAgICAgICAgICAgICAudmZfaWQgPSBjcHVfdG9fbGUxNih2ZHBhX2F1eC0+dmZfaWQp
LAo+ICsgICAgICAgfTsKPiArICAgICAgIHN0cnVjdCBwZHNfdmRwYV9jb21wIGlkZW50X2NvbXAg
PSB7MH07Cj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWdtdDsKPiArICAgICAgIHN0
cnVjdCBkZXZpY2UgKnBmX2RldjsKPiArICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Owo+ICsg
ICAgICAgZG1hX2FkZHJfdCBpZGVudF9wYTsKPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsK
PiArICAgICAgIHUxNiBtYXhfdnFzOwo+ICsgICAgICAgaW50IGVycjsKPiArCj4gKyAgICAgICBk
ZXYgPSAmdmRwYV9hdXgtPnBhZGV2LT5hdXhfZGV2LmRldjsKPiArICAgICAgIHBkZXYgPSB2ZHBh
X2F1eC0+cGFkZXYtPnZmLT5wZGV2Owo+ICsgICAgICAgbWdtdCA9ICZ2ZHBhX2F1eC0+dmRwYV9t
ZGV2Owo+ICsKPiArICAgICAgIC8qIEdldCByZXNvdXJjZSBpbmZvIHRocm91Z2ggdGhlIFBGJ3Mg
YWRtaW5xLiAgSXQgaXMgYSBibG9jayBvZiBpbmZvLAo+ICsgICAgICAgICogc28gd2UgbmVlZCB0
byBtYXAgc29tZSBtZW1vcnkgZm9yIFBGIHRvIG1ha2UgYXZhaWxhYmxlIHRvIHRoZQo+ICsgICAg
ICAgICogZmlybXdhcmUgZm9yIHdyaXRpbmcgdGhlIGRhdGEuCj4gKyAgICAgICAgKi8KCkl0IGxv
b2tzIHRvIG1lIHBkc192ZHBhX2lkZW50IGlzIG5vdCB2ZXJ5IGxhcmdlOgoKc3RydWN0IHBkc192
ZHBhX2lkZW50IHsKICAgICAgICBfX2xlNjQgaHdfZmVhdHVyZXM7CiAgICAgICAgX19sZTE2IG1h
eF92cXM7CiAgICAgICAgX19sZTE2IG1heF9xbGVuOwogICAgICAgIF9fbGUxNiBtaW5fcWxlbjsK
fTsKCkFueSByZWFzb24gaXQgaXMgbm90IHBhY2tlZCBpbnRvIHNvbWUgdHlwZSBvZiB0aGUgY29t
cCBzdHJ1Y3R1cmUgb2YgYWRtaW5xPwoKT3RoZXJzIGxvb2sgZ29vZC4KClRoYW5rcwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
