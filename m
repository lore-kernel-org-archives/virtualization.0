Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874BFC7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FA5E84339;
	Fri, 26 May 2023 06:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FA5E84339
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WAIiPe+J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xmp0nAdxba-u; Fri, 26 May 2023 06:09:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B38A83B7F;
	Fri, 26 May 2023 06:09:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B38A83B7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D6B3C0035;
	Fri, 26 May 2023 06:09:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CA46C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E49542807
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:09:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5E49542807
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WAIiPe+J
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DEqug1jkv6x
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:09:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DE85427F6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DE85427F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685081369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CZ37w54/UcEaODQ2MKxhWW4wZXlOWNUslt0oe8bFKE=;
 b=WAIiPe+Jn7QVNN2RGIAIwmFSXU3sCHJhFiRnXiEzediYJxO0M80mBTohBEp65rtKeEnxMT
 701IDa/Xs/h8H8kglClwdaMLZTZ1Im/0UVLjueCJCGrkO7O6NME4i5mKWrO2eLKrtn5xqm
 5/ZP2chzby0XIuPh9YwxOODsQ9pkbW8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-8z7AjFy5NsesvP1F8J-g8Q-1; Fri, 26 May 2023 02:09:26 -0400
X-MC-Unique: 8z7AjFy5NsesvP1F8J-g8Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f3bb23174eso167048e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 23:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685081365; x=1687673365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CZ37w54/UcEaODQ2MKxhWW4wZXlOWNUslt0oe8bFKE=;
 b=dF8Onr09iJOi6u3zYEKMW82Lam0Yh4QG5BFnQIfIYtj6q/ZZPe3kGF7fF/6AMq+NNQ
 G4fgDfVcut3wIFgTgyl+7KD+X+aRz8/4PI8ZYvo3Hu8fLzjmO4ansh1VJLbPXFP7BtEY
 ABUPkVCiRx2IbYucHeEhGG3nqiKhBE51fT5tQVU1/jt0lD2qZDR+xOSiwcVOgy7wa68H
 5FbMlk0l7BLAcz/bfdOjCmtECoI2EFPyqr4Vkg8WZ8Rk5tY+P1R874RmnXKaoJB7SUfw
 RiDc1WqartPAilm1CfKmGIFburBLH51IS7m4koU7jhe+fnv4a6fETJhR5ecBu3F6nxvH
 GC4Q==
X-Gm-Message-State: AC+VfDx71K/Hl4zX/9QTZ5/4UWp1y/TIUX57BxiiAY2tZGEN33LQhBhH
 kqZkalR8a47sY5c4oBqGXcsFJ13siw7owEtOSn89u6av/ihVCWEVV0iAnKwHuOoVZj/M4JxDMVv
 gFG0iHEpl4X5j32y+qMegLNbVm63IaUtDAQEsGzXEVvgvkOHmVlm0Z0kqOA==
X-Received: by 2002:ac2:5637:0:b0:4f3:89ca:246d with SMTP id
 b23-20020ac25637000000b004f389ca246dmr172182lff.41.1685081365104; 
 Thu, 25 May 2023 23:09:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79bpLx7HZlJ/WfmPr5qkBqkCzDFueSM1JH0QXggUvd9FuxvHmaPCr2hhKntPUm34OarjEPvUysCCfqxxlqj9U=
X-Received: by 2002:ac2:5637:0:b0:4f3:89ca:246d with SMTP id
 b23-20020ac25637000000b004f389ca246dmr172176lff.41.1685081364769; Thu, 25 May
 2023 23:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
 <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
 <CACGkMEtmSBhaMrVCLO6TLJ40_fY5pwa2p+jC6=Q0D09zUJRcOg@mail.gmail.com>
 <7e355ae0-158a-e308-1e26-7c562a78c9d9@intel.com>
 <1ffe2d2b-e28b-11e3-e411-a875de1b3cc2@intel.com>
In-Reply-To: <1ffe2d2b-e28b-11e3-e411-a875de1b3cc2@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 14:09:13 +0800
Message-ID: <CACGkMEu37S6FXku3HYw5rRpmDn4mkYOq+bHNqmpD=gxie7VBUw@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBNYXkgMjYsIDIwMjMgYXQgMTozMOKAr1BNIFpodSwgTGluZ3NoYW4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDUvMjYvMjAyMyAxMTozNiBBTSwgWmh1
LCBMaW5nc2hhbiB3cm90ZToKPiA+Cj4gPgo+ID4gT24gNS8yNi8yMDIzIDk6MzQgQU0sIEphc29u
IFdhbmcgd3JvdGU6Cj4gPj4gT24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgNTozOOKAr1BNIFpodSwg
TGluZ3NoYW4KPiA+PiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPj4+Cj4gPj4+
Cj4gPj4+IE9uIDUvMjQvMjAyMyA0OjAzIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+Pj4gT24g
TW9uLCBNYXkgOCwgMjAyMyBhdCA2OjA14oCvUE0gWmh1IExpbmdzaGFuCj4gPj4+PiA8bGluZ3No
YW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4gPj4+Pj4gVGhpcyBjb21taXQgc3luY2hyb25pemUg
aXJxcyBvZiB0aGUgdmlydHF1ZXVlcwo+ID4+Pj4+IGFuZCBjb25maWcgc3BhY2UgaW4gdGhlIHJl
c2V0IHJvdXRpbmUuCj4gPj4+Pj4gVGh1cyBpZmN2Zl9zdG9wX2h3KCkgYW5kIHJlc2V0KCkgYXJl
IHJlZmFjdG9yZWQgYXMgd2VsbC4KPiA+Pj4+Pgo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBM
aW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiA+Pj4+PiAtLS0KPiA+Pj4+PiAgICBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0KPiA+Pj4+PiAgICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDEg
Kwo+ID4+Pj4+ICAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA0Ngo+ID4+Pj4+
ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4+Pj4+ICAgIDMgZmlsZXMgY2hh
bmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgNTAgZGVsZXRpb25zKC0pCj4gPj4+Pj4KPiA+Pj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ID4+Pj4+IGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ID4+Pj4+IGluZGV4IDc5ZTMxM2M1ZTEwZS4u
MWYzOTI5MGJhYTM4IDEwMDY0NAo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmMKPiA+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4g
Pj4+Pj4gQEAgLTE3MCwxMiArMTcwLDkgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBp
ZmN2Zl9odyAqaHcsIHU4Cj4gPj4+Pj4gc3RhdHVzKQo+ID4+Pj4+Cj4gPj4+Pj4gICAgdm9pZCBp
ZmN2Zl9yZXNldChzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ID4+Pj4+ICAgIHsKPiA+Pj4+PiAtICAg
ICAgIGh3LT5jb25maWdfY2IuY2FsbGJhY2sgPSBOVUxMOwo+ID4+Pj4+IC0gICAgICAgaHctPmNv
bmZpZ19jYi5wcml2YXRlID0gTlVMTDsKPiA+Pj4+PiAtCj4gPj4+Pj4gICAgICAgICAgIGlmY3Zm
X3NldF9zdGF0dXMoaHcsIDApOwo+ID4+Pj4+IC0gICAgICAgLyogZmx1c2ggc2V0X3N0YXR1cywg
bWFrZSBzdXJlIFZGIGlzIHN0b3BwZWQsIHJlc2V0ICovCj4gPj4+Pj4gLSAgICAgICBpZmN2Zl9n
ZXRfc3RhdHVzKGh3KTsKPiA+Pj4+PiArICAgICAgIHdoaWxlIChpZmN2Zl9nZXRfc3RhdHVzKGh3
KSkKPiA+Pj4+PiArICAgICAgICAgICAgICAgbXNsZWVwKDEpOwo+ID4+Pj4+ICAgIH0KPiA+Pj4+
Pgo+ID4+Pj4+ICAgIHU2NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpo
dykKPiA+Pj4+PiBAQCAtMzY4LDIwICszNjUsNDIgQEAgdm9pZCBpZmN2Zl9zZXRfdnFfcmVhZHko
c3RydWN0IGlmY3ZmX2h3ICpodywKPiA+Pj4+PiB1MTYgcWlkLCBib29sIHJlYWR5KQo+ID4+Pj4+
ICAgICAgICAgICB2cF9pb3dyaXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJsZSk7Cj4gPj4+
Pj4gICAgfQo+ID4+Pj4+Cj4gPj4+Pj4gLXN0YXRpYyB2b2lkIGlmY3ZmX2h3X2Rpc2FibGUoc3Ry
dWN0IGlmY3ZmX2h3ICpodykKPiA+Pj4+PiArc3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmco
c3RydWN0IGlmY3ZmX2h3ICpodykKPiA+Pj4+PiAgICB7Cj4gPj4+Pj4gLSAgICAgICB1MzIgaTsK
PiA+Pj4+PiArICAgICAgIHUxNiBxaWQ7Cj4gPj4+Pj4gKwo+ID4+Pj4+ICsgICAgICAgZm9yIChx
aWQgPSAwOyBxaWQgPCBody0+bnJfdnJpbmc7IHFpZCsrKSB7Cj4gPj4+Pj4gKyAgICAgICAgICAg
ICAgIGh3LT52cmluZ1txaWRdLmNiLmNhbGxiYWNrID0gTlVMTDsKPiA+Pj4+PiArICAgICAgICAg
ICAgICAgaHctPnZyaW5nW3FpZF0uY2IucHJpdmF0ZSA9IE5VTEw7Cj4gPj4+Pj4gKyAgICAgICAg
ICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIHFpZCwgVklSVElPX01TSV9OT19WRUNUT1Ip
Owo+ID4+Pj4+ICsgICAgICAgfQo+ID4+Pj4+ICt9Cj4gPj4+Pj4KPiA+Pj4+PiArc3RhdGljIHZv
aWQgaWZjdmZfcmVzZXRfY29uZmlnX2hhbmRsZXIoc3RydWN0IGlmY3ZmX2h3ICpodykKPiA+Pj4+
PiArewo+ID4+Pj4+ICsgICAgICAgaHctPmNvbmZpZ19jYi5jYWxsYmFjayA9IE5VTEw7Cj4gPj4+
Pj4gKyAgICAgICBody0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxMOwo+ID4+Pj4+ICAgICAgICAg
ICBpZmN2Zl9zZXRfY29uZmlnX3ZlY3RvcihodywgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ID4+
Pj4+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IGh3LT5ucl92cmluZzsgaSsrKSB7Cj4gPj4+Pj4g
LSAgICAgICAgICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIGksIFZJUlRJT19NU0lfTk9f
VkVDVE9SKTsKPiA+Pj4+PiArfQo+ID4+Pj4+ICsKPiA+Pj4+PiArc3RhdGljIHZvaWQgaWZjdmZf
c3luY2hyb25pemVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gPj4+Pj4gK3sKPiA+Pj4+PiAr
ICAgICAgIHUzMiBudmVjdG9ycyA9IGh3LT5udW1fbXNpeF92ZWN0b3JzOwo+ID4+Pj4+ICsgICAg
ICAgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBody0+cGRldjsKPiA+Pj4+PiArICAgICAgIGludCBp
LCBpcnE7Cj4gPj4+Pj4gKwo+ID4+Pj4+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IG52ZWN0b3Jz
OyBpKyspIHsKPiA+Pj4+PiArICAgICAgICAgICAgICAgaXJxID0gcGNpX2lycV92ZWN0b3IocGRl
diwgaSk7Cj4gPj4+Pj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkKPiA+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9pcnEoaXJxKTsKPiA+Pj4+PiAgICAgICAg
ICAgfQo+ID4+Pj4+ICAgIH0KPiA+Pj4+Pgo+ID4+Pj4+ICAgIHZvaWQgaWZjdmZfc3RvcF9odyhz
dHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ID4+Pj4+ICAgIHsKPiA+Pj4+PiAtICAgICAgIGlmY3ZmX2h3
X2Rpc2FibGUoaHcpOwo+ID4+Pj4+IC0gICAgICAgaWZjdmZfcmVzZXQoaHcpOwo+ID4+Pj4+ICsg
ICAgICAgaWZjdmZfc3luY2hyb25pemVfaXJxKGh3KTsKPiA+Pj4+PiArICAgICAgIGlmY3ZmX3Jl
c2V0X3ZyaW5nKGh3KTsKPiA+Pj4+PiArICAgICAgIGlmY3ZmX3Jlc2V0X2NvbmZpZ19oYW5kbGVy
KGh3KTsKPiA+Pj4+IE5pdDoKPiA+Pj4+Cj4gPj4+PiBTbyB0aGUgbmFtZSBvZiB0aGlzIGZ1bmN0
aW9uIGlzIGtpbmQgb2YgbWlzbGVhZGluZyBzaW5jZSBpcnEKPiA+Pj4+IHN5bmNocm9uaXphdGlv
biBhbmQgdmlydHF1ZXVlL2NvbmZpZyBoYW5kbGVyIGFyZSBub3QgYmVsb25nIHRvCj4gPj4+PiBo
YXJkd2FyZT8KPiA+Pj4+Cj4gPj4+PiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2FsbCBp
dCBpZmN2Zl9zdG9wKCkuCj4gPj4+IFN1cmUsIEkgd2lsbCBzZW5kIGEgVjMgd2l0aCB0aGlzIHJl
bmFtaW5nLAo+ID4+PiBkbyB5b3UgYWNrIHBhdGNoIDEvNT8KPiA+PiBZZXMsIEkgdGhpbmsgSSd2
ZSBhY2tlZCB0byB0aGF0IHBhdGNoLgo+ID4gSSB3aWxsIHNlbmQgYSBWMyB3aXRoIHRoaXMgcmVu
YW1pbmcgYW5kIHlvdXIgYWNrIGZvciBwYXRjaCAxLzUKPiBCeSB0aGUgd2F5LCBkbyB5b3UgYWNr
IHRoaXMgb25lIGFmdGVyIHRoaXMgZnVuY3Rpb24gcmVuYW1pbmc/Cj4gSWYgc28sIEkgd2lsbCBh
bHNvIGluY2x1ZGUgeW91ciBhY2sgaW4gVjMsIHNvIHdlIGRvbid0IG5lZWQgYW5vdGhlcgo+IHJl
dmlldyBwcm9jZXNzLCBJIHdpbGwgcGluZyBNaWNoYWVsIGZvciBhIG1lcmdlLgoKSGF2ZSB5b3Ug
c2VlbiB0aGUgYWNrIGhlcmU/CgpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvcGlw
ZXJtYWlsL3ZpcnR1YWxpemF0aW9uLzIwMjMtTWF5LzA2Njg5MC5odG1sCgpUaGFua3MKCj4gPj4K
PiA+PiBUaGFua3MKPiA+Pgo+ID4+PiBUaGFua3MKPiA+Pj4gWmh1IExpbmdzaGFuCj4gPj4+PiBU
aGFua3MKPiA+Pj4+Cj4gPj4+Pj4gICAgfQo+ID4+Pj4+Cj4gPj4+Pj4gICAgdm9pZCBpZmN2Zl9u
b3RpZnlfcXVldWUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPiA+Pj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ID4+Pj4+IGIvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ID4+Pj4+IGluZGV4IGQzNGQzYmMwZGJmNC4uNzQzMGY4
MDc3OWJlIDEwMDY0NAo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNl
LmgKPiA+Pj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gPj4+Pj4g
QEAgLTgyLDYgKzgyLDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPiA+Pj4+PiAgICAgICAgICAgaW50
IHZxc19yZXVzZWRfaXJxOwo+ID4+Pj4+ICAgICAgICAgICB1MTYgbnJfdnJpbmc7Cj4gPj4+Pj4g
ICAgICAgICAgIC8qIFZJUlRJT19QQ0lfQ0FQX0RFVklDRV9DRkcgc2l6ZSAqLwo+ID4+Pj4+ICsg
ICAgICAgdTMyIG51bV9tc2l4X3ZlY3RvcnM7Cj4gPj4+Pj4gICAgICAgICAgIHUzMiBjYXBfZGV2
X2NvbmZpZ19zaXplOwo+ID4+Pj4+ICAgICAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldjsKPiA+
Pj4+PiAgICB9Owo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
bWFpbi5jCj4gPj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gPj4+Pj4g
aW5kZXggOTY4Njg3MTU5ZTQ0Li4zNDAxYjk5MDFkZDIgMTAwNjQ0Cj4gPj4+Pj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPiA+Pj4+PiBAQCAtMTI1LDYgKzEyNSw3IEBAIHN0YXRpYyB2b2lk
IGlmY3ZmX2ZyZWVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqdmYpCj4gPj4+Pj4gICAgICAgICAgIGlm
Y3ZmX2ZyZWVfdnFfaXJxKHZmKTsKPiA+Pj4+PiAgICAgICAgICAgaWZjdmZfZnJlZV9jb25maWdf
aXJxKHZmKTsKPiA+Pj4+PiAgICAgICAgICAgaWZjdmZfZnJlZV9pcnFfdmVjdG9ycyhwZGV2KTsK
PiA+Pj4+PiArICAgICAgIHZmLT5udW1fbXNpeF92ZWN0b3JzID0gMDsKPiA+Pj4+PiAgICB9Cj4g
Pj4+Pj4KPiA+Pj4+PiAgICAvKiBpZmN2ZiBNU0lYIHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhl
bHBlciB0cmllcyB0byBhbGxvY2F0ZQo+ID4+Pj4+IEBAIC0zNDMsMzYgKzM0NCwxMSBAQCBzdGF0
aWMgaW50IGlmY3ZmX3JlcXVlc3RfaXJxKHN0cnVjdCBpZmN2Zl9odwo+ID4+Pj4+ICp2ZikKPiA+
Pj4+PiAgICAgICAgICAgaWYgKHJldCkKPiA+Pj4+PiAgICAgICAgICAgICAgICAgICByZXR1cm4g
cmV0Owo+ID4+Pj4+Cj4gPj4+Pj4gLSAgICAgICByZXR1cm4gMDsKPiA+Pj4+PiAtfQo+ID4+Pj4+
IC0KPiA+Pj4+PiAtc3RhdGljIGludCBpZmN2Zl9zdG9wX2RhdGFwYXRoKHN0cnVjdCBpZmN2Zl9h
ZGFwdGVyICphZGFwdGVyKQo+ID4+Pj4+IC17Cj4gPj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZf
aHcgKnZmID0gYWRhcHRlci0+dmY7Cj4gPj4+Pj4gLSAgICAgICBpbnQgaTsKPiA+Pj4+PiAtCj4g
Pj4+Pj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspCj4gPj4+Pj4g
LSAgICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4gPj4+Pj4g
LQo+ID4+Pj4+IC0gICAgICAgaWZjdmZfc3RvcF9odyh2Zik7Cj4gPj4+Pj4gKyAgICAgICB2Zi0+
bnVtX21zaXhfdmVjdG9ycyA9IG52ZWN0b3JzOwo+ID4+Pj4+Cj4gPj4+Pj4gICAgICAgICAgIHJl
dHVybiAwOwo+ID4+Pj4+ICAgIH0KPiA+Pj4+Pgo+ID4+Pj4+IC1zdGF0aWMgdm9pZCBpZmN2Zl9y
ZXNldF92cmluZyhzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcikKPiA+Pj4+PiAtewo+ID4+
Pj4+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IGFkYXB0ZXItPnZmOwo+ID4+Pj4+IC0g
ICAgICAgaW50IGk7Cj4gPj4+Pj4gLQo+ID4+Pj4+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IHZm
LT5ucl92cmluZzsgaSsrKSB7Cj4gPj4+Pj4gLSAgICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5s
YXN0X2F2YWlsX2lkeCA9IDA7Cj4gPj4+Pj4gLSAgICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5j
Yi5jYWxsYmFjayA9IE5VTEw7Cj4gPj4+Pj4gLSAgICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5j
Yi5wcml2YXRlID0gTlVMTDsKPiA+Pj4+PiAtICAgICAgIH0KPiA+Pj4+PiAtCj4gPj4+Pj4gLSAg
ICAgICBpZmN2Zl9yZXNldCh2Zik7Cj4gPj4+Pj4gLX0KPiA+Pj4+PiAtCj4gPj4+Pj4gICAgc3Rh
dGljIHN0cnVjdCBpZmN2Zl9hZGFwdGVyICp2ZHBhX3RvX2FkYXB0ZXIoc3RydWN0IHZkcGFfZGV2
aWNlCj4gPj4+Pj4gKnZkcGFfZGV2KQo+ID4+Pj4+ICAgIHsKPiA+Pj4+PiAgICAgICAgICAgcmV0
dXJuIGNvbnRhaW5lcl9vZih2ZHBhX2Rldiwgc3RydWN0IGlmY3ZmX2FkYXB0ZXIsIHZkcGEpOwo+
ID4+Pj4+IEBAIC00NjIsMjMgKzQzOCwxNSBAQCBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF9z
dGF0dXMoc3RydWN0Cj4gPj4+Pj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBzdGF0dXMpCj4g
Pj4+Pj4KPiA+Pj4+PiAgICBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhX2RldikKPiA+Pj4+PiAgICB7Cj4gPj4+Pj4gLSAgICAgICBzdHJ1Y3QgaWZj
dmZfYWRhcHRlciAqYWRhcHRlcjsKPiA+Pj4+PiAtICAgICAgIHN0cnVjdCBpZmN2Zl9odyAqdmY7
Cj4gPj4+Pj4gLSAgICAgICB1OCBzdGF0dXNfb2xkOwo+ID4+Pj4+IC0KPiA+Pj4+PiAtICAgICAg
IHZmICA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+ID4+Pj4+IC0gICAgICAgYWRhcHRlciA9IHZk
cGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4gPj4+Pj4gLSAgICAgICBzdGF0dXNfb2xkID0gaWZj
dmZfZ2V0X3N0YXR1cyh2Zik7Cj4gPj4+Pj4gKyAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0g
dmRwYV90b192Zih2ZHBhX2Rldik7Cj4gPj4+Pj4gKyAgICAgICB1OCBzdGF0dXMgPSBpZmN2Zl9n
ZXRfc3RhdHVzKHZmKTsKPiA+Pj4+Pgo+ID4+Pj4+IC0gICAgICAgaWYgKHN0YXR1c19vbGQgPT0g
MCkKPiA+Pj4+PiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gPj4+Pj4gKyAgICAgICBpZmN2
Zl9zdG9wX2h3KHZmKTsKPiA+Pj4+Pgo+ID4+Pj4+IC0gICAgICAgaWYgKHN0YXR1c19vbGQgJiBW
SVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7Cj4gPj4+Pj4gLSAgICAgICAgICAgICAgIGlmY3Zm
X3N0b3BfZGF0YXBhdGgoYWRhcHRlcik7Cj4gPj4+Pj4gKyAgICAgICBpZiAoc3RhdHVzICYgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSykKPiA+Pj4+PiAgICAgICAgICAgICAgICAgICBpZmN2Zl9m
cmVlX2lycSh2Zik7Cj4gPj4+Pj4gLSAgICAgICB9Cj4gPj4+Pj4KPiA+Pj4+PiAtICAgICAgIGlm
Y3ZmX3Jlc2V0X3ZyaW5nKGFkYXB0ZXIpOwo+ID4+Pj4+ICsgICAgICAgaWZjdmZfcmVzZXQodmYp
Owo+ID4+Pj4+Cj4gPj4+Pj4gICAgICAgICAgIHJldHVybiAwOwo+ID4+Pj4+ICAgIH0KPiA+Pj4+
PiAtLQo+ID4+Pj4+IDIuMzkuMQo+ID4+Pj4+Cj4gPgo+ID4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dAo+ID4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiA+IGh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9uCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
