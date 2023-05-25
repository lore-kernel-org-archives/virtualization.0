Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB41C77B7E
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 03:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ECB74257E;
	Thu, 25 May 2023 03:07:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ECB74257E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4XkwJ1p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0YaoIilXcLkG; Thu, 25 May 2023 03:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 112B742586;
	Thu, 25 May 2023 03:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 112B742586
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0CDCC0035;
	Thu, 25 May 2023 03:07:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55442C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A013402DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:07:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A013402DC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4XkwJ1p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9f_uHdWA7wdw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A5854015E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A5854015E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 03:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684984034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eplS35UizwEVFH5/Y4CtMP1M8J4H5EzPIq3B8usn55Y=;
 b=O4XkwJ1pfVI35l+amnRgKftfiUdemCmqfLCDMv2LcoUpMtuP12KGJWwTYYjoGxf0uJ7Ta3
 L9zB48zp25xAAtlgDSE6/mnvzGngbDwJ93LGTv8kzl6RGTZlHNAYk80RuS+7tMKvI6HVRP
 ohHc/b2pzSZjci0RrHHj2EV6XzgX3gI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-JuZbq1orNn-75z6dOFs5ZQ-1; Wed, 24 May 2023 23:07:13 -0400
X-MC-Unique: JuZbq1orNn-75z6dOFs5ZQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af8a985ab2so374031fa.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 20:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684984031; x=1687576031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eplS35UizwEVFH5/Y4CtMP1M8J4H5EzPIq3B8usn55Y=;
 b=i9X8j33Q77Qd8qsSAbduyeLKhtfwKvsxfpgL7hbPfjHxhHT25u/tLezj2wDcL5qcK6
 yAl2KQEXDauDZqcewMPKapoR2WwJF7XEh3kk8Q9jg7j4Js316deB1BRew7FiMj2qzd9g
 eBTt0eiRuF9Wu6RNCtTCP2lhXu6wP6rrTLu7xKht5OxhowEU/LId1RC/S9m4eKzCB3wG
 4bOLYpVEJudAS5+u50z4+TiZtZsxBWjUy/+PrU4HmoS29V4QhLJeC6GiX/c0EI4Inc/l
 I0VQFuh7Sy8rtELc4pM6+UgjEcJSq2F+7nwGdy7EKCrd4yOoVeDD1VcQt8o0zSjE5zuU
 ssCg==
X-Gm-Message-State: AC+VfDwo6VNjPx8H14MMpJ5m6zZ232EYLH8UaLuRDcskdXvU5BpmN6lp
 SkoMzs9rER08UO5/BGe9VGWSB+0c+ahbPPXzu30WkDpcHPwg579yFvmiA1fi1zvujV7wMh2mkYB
 AUYzLqlIxsrAmconjuzhBOBSo3HfcDMkMZmsaWribK5k0PkExoNiQns7o1a700FRGBf7e
X-Received: by 2002:a2e:9910:0:b0:2ac:8090:630e with SMTP id
 v16-20020a2e9910000000b002ac8090630emr491826lji.28.1684984031477; 
 Wed, 24 May 2023 20:07:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qBO3yGHiCXWGioL6zEF8RnlS5cEVtPfIGnc+Fdu9/eUczU9Jolg0qpbEzVyq7PSaJXDdFWYzZQ4qszlIZyRw=
X-Received: by 2002:a2e:9910:0:b0:2ac:8090:630e with SMTP id
 v16-20020a2e9910000000b002ac8090630emr491821lji.28.1684984031030; Wed, 24 May
 2023 20:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
In-Reply-To: <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 May 2023 11:07:00 +0800
Message-ID: <CACGkMEvbhzyN=Xu8wuD-1W9QPwQ8EN3d=gYiDTVzgvpSuwP8Jw@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
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

T24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgNDowM+KAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCA2OjA14oCvUE0gWmh1
IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGlzIGNv
bW1pdCBzeW5jaHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVzCj4gPiBhbmQgY29uZmlnIHNw
YWNlIGluIHRoZSByZXNldCByb3V0aW5lLgo+ID4gVGh1cyBpZmN2Zl9zdG9wX2h3KCkgYW5kIHJl
c2V0KCkgYXJlIHJlZmFjdG9yZWQgYXMgd2VsbC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBaaHUg
TGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0K
PiA+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDEgKwo+ID4gIGRyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA0NiArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9u
cygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5j
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ID4gaW5kZXggNzllMzEzYzVlMTBl
Li4xZjM5MjkwYmFhMzggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5jCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4gPiBAQCAt
MTcwLDEyICsxNzAsOSBAQCB2b2lkIGlmY3ZmX3NldF9zdGF0dXMoc3RydWN0IGlmY3ZmX2h3ICpo
dywgdTggc3RhdHVzKQo+ID4KPiA+ICB2b2lkIGlmY3ZmX3Jlc2V0KHN0cnVjdCBpZmN2Zl9odyAq
aHcpCj4gPiAgewo+ID4gLSAgICAgICBody0+Y29uZmlnX2NiLmNhbGxiYWNrID0gTlVMTDsKPiA+
IC0gICAgICAgaHctPmNvbmZpZ19jYi5wcml2YXRlID0gTlVMTDsKPiA+IC0KPiA+ICAgICAgICAg
aWZjdmZfc2V0X3N0YXR1cyhodywgMCk7Cj4gPiAtICAgICAgIC8qIGZsdXNoIHNldF9zdGF0dXMs
IG1ha2Ugc3VyZSBWRiBpcyBzdG9wcGVkLCByZXNldCAqLwo+ID4gLSAgICAgICBpZmN2Zl9nZXRf
c3RhdHVzKGh3KTsKPiA+ICsgICAgICAgd2hpbGUgKGlmY3ZmX2dldF9zdGF0dXMoaHcpKQo+ID4g
KyAgICAgICAgICAgICAgIG1zbGVlcCgxKTsKPiA+ICB9Cj4gPgo+ID4gIHU2NCBpZmN2Zl9nZXRf
aHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPiA+IEBAIC0zNjgsMjAgKzM2NSw0MiBA
QCB2b2lkIGlmY3ZmX3NldF92cV9yZWFkeShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCBi
b29sIHJlYWR5KQo+ID4gICAgICAgICB2cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2Vu
YWJsZSk7Cj4gPiAgfQo+ID4KPiA+IC1zdGF0aWMgdm9pZCBpZmN2Zl9od19kaXNhYmxlKHN0cnVj
dCBpZmN2Zl9odyAqaHcpCj4gPiArc3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0
IGlmY3ZmX2h3ICpodykKPiA+ICB7Cj4gPiAtICAgICAgIHUzMiBpOwo+ID4gKyAgICAgICB1MTYg
cWlkOwo+ID4gKwo+ID4gKyAgICAgICBmb3IgKHFpZCA9IDA7IHFpZCA8IGh3LT5ucl92cmluZzsg
cWlkKyspIHsKPiA+ICsgICAgICAgICAgICAgICBody0+dnJpbmdbcWlkXS5jYi5jYWxsYmFjayA9
IE5VTEw7Cj4gPiArICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IucHJpdmF0ZSA9IE5V
TEw7Cj4gPiArICAgICAgICAgICAgICAgaWZjdmZfc2V0X3ZxX3ZlY3RvcihodywgcWlkLCBWSVJU
SU9fTVNJX05PX1ZFQ1RPUik7Cj4gPiArICAgICAgIH0KPiA+ICt9Cj4gPgo+ID4gK3N0YXRpYyB2
b2lkIGlmY3ZmX3Jlc2V0X2NvbmZpZ19oYW5kbGVyKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gPiAr
ewo+ID4gKyAgICAgICBody0+Y29uZmlnX2NiLmNhbGxiYWNrID0gTlVMTDsKPiA+ICsgICAgICAg
aHctPmNvbmZpZ19jYi5wcml2YXRlID0gTlVMTDsKPiA+ICAgICAgICAgaWZjdmZfc2V0X2NvbmZp
Z192ZWN0b3IoaHcsIFZJUlRJT19NU0lfTk9fVkVDVE9SKTsKPiA+IC0gICAgICAgZm9yIChpID0g
MDsgaSA8IGh3LT5ucl92cmluZzsgaSsrKSB7Cj4gPiAtICAgICAgICAgICAgICAgaWZjdmZfc2V0
X3ZxX3ZlY3RvcihodywgaSwgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ID4gK30KPiA+ICsKPiA+
ICtzdGF0aWMgdm9pZCBpZmN2Zl9zeW5jaHJvbml6ZV9pcnEoc3RydWN0IGlmY3ZmX2h3ICpodykK
PiA+ICt7Cj4gPiArICAgICAgIHUzMiBudmVjdG9ycyA9IGh3LT5udW1fbXNpeF92ZWN0b3JzOwo+
ID4gKyAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGh3LT5wZGV2Owo+ID4gKyAgICAgICBp
bnQgaSwgaXJxOwo+ID4gKwo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnZlY3RvcnM7IGkr
Kykgewo+ID4gKyAgICAgICAgICAgICAgIGlycSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIGkpOwo+
ID4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkKPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHN5bmNocm9uaXplX2lycShpcnEpOwo+ID4gICAgICAgICB9Cj4gPiAgfQo+ID4KPiA+ICB2
b2lkIGlmY3ZmX3N0b3BfaHcoc3RydWN0IGlmY3ZmX2h3ICpodykKPiA+ICB7Cj4gPiAtICAgICAg
IGlmY3ZmX2h3X2Rpc2FibGUoaHcpOwo+ID4gLSAgICAgICBpZmN2Zl9yZXNldChodyk7Cj4gPiAr
ICAgICAgIGlmY3ZmX3N5bmNocm9uaXplX2lycShodyk7Cj4gPiArICAgICAgIGlmY3ZmX3Jlc2V0
X3ZyaW5nKGh3KTsKPiA+ICsgICAgICAgaWZjdmZfcmVzZXRfY29uZmlnX2hhbmRsZXIoaHcpOwo+
Cj4gTml0Ogo+Cj4gU28gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiBpcyBraW5kIG9mIG1pc2xl
YWRpbmcgc2luY2UgaXJxCj4gc3luY2hyb25pemF0aW9uIGFuZCB2aXJ0cXVldWUvY29uZmlnIGhh
bmRsZXIgYXJlIG5vdCBiZWxvbmcgdG8KPiBoYXJkd2FyZT8KPgo+IE1heWJlIGl0IHdvdWxkIGJl
IGJldHRlciB0byBjYWxsIGl0IGlmY3ZmX3N0b3AoKS4KCkkgdGhpbmsgd2UgY2FuIHR3ZWFrIHRo
aXMgb24gdG9wLiBTbwoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgpUaGFua3MKCj4KPiBUaGFua3MKPgo+ID4gIH0KPiA+Cj4gPiAgdm9pZCBpZmN2Zl9ub3RpZnlf
cXVldWUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuaAo+ID4gaW5kZXggZDM0ZDNiYzBkYmY0Li43NDMwZjgwNzc5YmUgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5oCj4gPiBAQCAtODIsNiArODIsNyBAQCBzdHJ1Y3QgaWZjdmZfaHcg
ewo+ID4gICAgICAgICBpbnQgdnFzX3JldXNlZF9pcnE7Cj4gPiAgICAgICAgIHUxNiBucl92cmlu
ZzsKPiA+ICAgICAgICAgLyogVklSVElPX1BDSV9DQVBfREVWSUNFX0NGRyBzaXplICovCj4gPiAr
ICAgICAgIHUzMiBudW1fbXNpeF92ZWN0b3JzOwo+ID4gICAgICAgICB1MzIgY2FwX2Rldl9jb25m
aWdfc2l6ZTsKPiA+ICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4gPiAgfTsKPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4gaW5kZXggOTY4Njg3MTU5ZTQ0Li4zNDAxYjk5MDFkZDIg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPiBAQCAtMTI1LDYgKzEyNSw3IEBA
IHN0YXRpYyB2b2lkIGlmY3ZmX2ZyZWVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqdmYpCj4gPiAgICAg
ICAgIGlmY3ZmX2ZyZWVfdnFfaXJxKHZmKTsKPiA+ICAgICAgICAgaWZjdmZfZnJlZV9jb25maWdf
aXJxKHZmKTsKPiA+ICAgICAgICAgaWZjdmZfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsKPiA+ICsg
ICAgICAgdmYtPm51bV9tc2l4X3ZlY3RvcnMgPSAwOwo+ID4gIH0KPiA+Cj4gPiAgLyogaWZjdmYg
TVNJWCB2ZWN0b3JzIGFsbG9jYXRvciwgdGhpcyBoZWxwZXIgdHJpZXMgdG8gYWxsb2NhdGUKPiA+
IEBAIC0zNDMsMzYgKzM0NCwxMSBAQCBzdGF0aWMgaW50IGlmY3ZmX3JlcXVlc3RfaXJxKHN0cnVj
dCBpZmN2Zl9odyAqdmYpCj4gPiAgICAgICAgIGlmIChyZXQpCj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIHJldDsKPiA+Cj4gPiAtICAgICAgIHJldHVybiAwOwo+ID4gLX0KPiA+IC0KPiA+IC1z
dGF0aWMgaW50IGlmY3ZmX3N0b3BfZGF0YXBhdGgoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0
ZXIpCj4gPiAtewo+ID4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7
Cj4gPiAtICAgICAgIGludCBpOwo+ID4gLQo+ID4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYt
Pm5yX3ZyaW5nOyBpKyspCj4gPiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmNiLmNhbGxi
YWNrID0gTlVMTDsKPiA+IC0KPiA+IC0gICAgICAgaWZjdmZfc3RvcF9odyh2Zik7Cj4gPiArICAg
ICAgIHZmLT5udW1fbXNpeF92ZWN0b3JzID0gbnZlY3RvcnM7Cj4gPgo+ID4gICAgICAgICByZXR1
cm4gMDsKPiA+ICB9Cj4gPgo+ID4gLXN0YXRpYyB2b2lkIGlmY3ZmX3Jlc2V0X3ZyaW5nKHN0cnVj
dCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+ID4gLXsKPiA+IC0gICAgICAgc3RydWN0IGlmY3Zm
X2h3ICp2ZiA9IGFkYXB0ZXItPnZmOwo+ID4gLSAgICAgICBpbnQgaTsKPiA+IC0KPiA+IC0gICAg
ICAgZm9yIChpID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsrKSB7Cj4gPiAtICAgICAgICAgICAg
ICAgdmYtPnZyaW5nW2ldLmxhc3RfYXZhaWxfaWR4ID0gMDsKPiA+IC0gICAgICAgICAgICAgICB2
Zi0+dnJpbmdbaV0uY2IuY2FsbGJhY2sgPSBOVUxMOwo+ID4gLSAgICAgICAgICAgICAgIHZmLT52
cmluZ1tpXS5jYi5wcml2YXRlID0gTlVMTDsKPiA+IC0gICAgICAgfQo+ID4gLQo+ID4gLSAgICAg
ICBpZmN2Zl9yZXNldCh2Zik7Cj4gPiAtfQo+ID4gLQo+ID4gIHN0YXRpYyBzdHJ1Y3QgaWZjdmZf
YWRhcHRlciAqdmRwYV90b19hZGFwdGVyKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4g
PiAgewo+ID4gICAgICAgICByZXR1cm4gY29udGFpbmVyX29mKHZkcGFfZGV2LCBzdHJ1Y3QgaWZj
dmZfYWRhcHRlciwgdmRwYSk7Cj4gPiBAQCAtNDYyLDIzICs0MzgsMTUgQEAgc3RhdGljIHZvaWQg
aWZjdmZfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHU4IHN0
YXR1cykKPiA+Cj4gPiAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYpCj4gPiAgewo+ID4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAq
YWRhcHRlcjsKPiA+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2ZjsKPiA+IC0gICAgICAgdTgg
c3RhdHVzX29sZDsKPiA+IC0KPiA+IC0gICAgICAgdmYgID0gdmRwYV90b192Zih2ZHBhX2Rldik7
Cj4gPiAtICAgICAgIGFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+ID4gLSAg
ICAgICBzdGF0dXNfb2xkID0gaWZjdmZfZ2V0X3N0YXR1cyh2Zik7Cj4gPiArICAgICAgIHN0cnVj
dCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPiA+ICsgICAgICAgdTggc3Rh
dHVzID0gaWZjdmZfZ2V0X3N0YXR1cyh2Zik7Cj4gPgo+ID4gLSAgICAgICBpZiAoc3RhdHVzX29s
ZCA9PSAwKQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gKyAgICAgICBpZmN2Zl9z
dG9wX2h3KHZmKTsKPiA+Cj4gPiAtICAgICAgIGlmIChzdGF0dXNfb2xkICYgVklSVElPX0NPTkZJ
R19TX0RSSVZFUl9PSykgewo+ID4gLSAgICAgICAgICAgICAgIGlmY3ZmX3N0b3BfZGF0YXBhdGgo
YWRhcHRlcik7Cj4gPiArICAgICAgIGlmIChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVS
X09LKQo+ID4gICAgICAgICAgICAgICAgIGlmY3ZmX2ZyZWVfaXJxKHZmKTsKPiA+IC0gICAgICAg
fQo+ID4KPiA+IC0gICAgICAgaWZjdmZfcmVzZXRfdnJpbmcoYWRhcHRlcik7Cj4gPiArICAgICAg
IGlmY3ZmX3Jlc2V0KHZmKTsKPiA+Cj4gPiAgICAgICAgIHJldHVybiAwOwo+ID4gIH0KPiA+IC0t
Cj4gPiAyLjM5LjEKPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
