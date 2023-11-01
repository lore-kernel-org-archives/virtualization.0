Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A2FC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 00:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85B758445F;
	Wed,  1 Nov 2023 00:38:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85B758445F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy3wRz9O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 99PFqRybEa5n; Wed,  1 Nov 2023 00:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AA408445A;
	Wed,  1 Nov 2023 00:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AA408445A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE40EC0039;
	Wed,  1 Nov 2023 00:38:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0307C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C383485E1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C383485E1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cy3wRz9O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRfyLvpd2qGI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:38:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09E2C485C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 00:38:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09E2C485C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698799099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cVmhpIbbAED27w6cogZcQtjsKWbHbF+MiZXcAMDs3b8=;
 b=Cy3wRz9O+TL06/VFIHLQsJjd8hT7jhrzdbbKQ6mdfW5iXTfQ/U1x6onnHOPXn6+eEo5+2W
 Dk3VzwjvfbOWIeSTmHIFIljx5VZzqzhrCDNPn5W2TlJ5/7y7vuNoMRcgeyVh5Bgfz6jSwa
 u1ceEIjerdotHpq/+6P3yFUeW1iPjg0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-0CKmb2X4MiiGoddTbF2L6g-1; Tue, 31 Oct 2023 20:38:18 -0400
X-MC-Unique: 0CKmb2X4MiiGoddTbF2L6g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507cee14477so7608644e87.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 17:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698799097; x=1699403897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVmhpIbbAED27w6cogZcQtjsKWbHbF+MiZXcAMDs3b8=;
 b=AQV4RgfcMuhkmj4XjoxVLU46UymSY3yvStgK2odmD/T1/SW3tO/UeX1NBfy72nCrwY
 qpj2cqaE+2F3Gol9q+QJvpT3r4MM2nQJJoqcbd6LanYgwnWFuUAmA2/t0blG9RkOxJgm
 n4K+kxPvDzosED2V1cuqM5pRmWw6/Jjjw44xbbmSen8pl4Gh8aoOc6Ffac6tYmNaACC5
 j9hFAv80H3xvljjmY4vHVU7IkWzyp+CimpLv+pyQ/u3Tf9dp12NIejiL/Zx/j/QOIpZY
 yERvnDoSZjr7OekA77XhztQ0I0RPp0zQ8Q/MthNaJdhcVeTg/0BJbCZN4erZ5qNIcIsT
 nCiQ==
X-Gm-Message-State: AOJu0YzYyaifh7CAHdKpHf9XOvfzCzBratcR+/QPCpnuiqn6z8VP+6eC
 Dr3UI+228hA7BoEWSW8kRtgG0VNk47z0t8Ft524qCQ5vHAdjINQXdim6qVqHcQ4mKTtrlHw7irA
 qpkEguXDNdXGI6xRlEfAms39l8CrFmxlXxrTVShWJ2QPfLUKFIDRiVyI8JQ==
X-Received: by 2002:ac2:5d31:0:b0:508:1227:5a10 with SMTP id
 i17-20020ac25d31000000b0050812275a10mr8510926lfb.23.1698799096728; 
 Tue, 31 Oct 2023 17:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELnbiKGw2gzG8mmlQVxm+S0ABUPG3MLsIsFSN626UDcnC/raa4pedrJ5yX266tK9gGw2tsUAPI3qr4SXA4FRg=
X-Received: by 2002:ac2:5d31:0:b0:508:1227:5a10 with SMTP id
 i17-20020ac25d31000000b0050812275a10mr8510914lfb.23.1698799096383; Tue, 31
 Oct 2023 17:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
In-Reply-To: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Nov 2023 08:38:05 +0800
Message-ID: <CACGkMEt0OV=y+MRvSVQcLJqOSfrqQNR=aMWfcFgFbZ9QODzeTQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: move structure to a header
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCAxMjoyMOKAr0FNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhlc2UgYXJlIGd1ZXN0L2hvc3QgaW50ZXJmYWNlcyBz
byBiZWxvbmcgaW4gdGhlIGhlYWRlcgo+IHdoZXJlIGUuZy4gcWVtdSB3aWxsIGtub3cgdG8gZmlu
ZCB0aGVtLgo+IE5vdGU6IHdlIGFkZGVkIGEgbmV3IHN0cnVjdHVyZSBhcyBvcHBvc2VkIHRvIGV4
dGVuZGluZyBleGlzdGluZyBvbmUKPiBiZWNhdXNlIHNvbWVvbmUgbWlnaHQgYmUgcmVseWluZyBv
biB0aGUgc2l6ZSBvZiB0aGUgZXhpc3Rpbmcgc3RydWN0dXJlCj4gc3RheWluZyB1bmNoYW5nZWQu
ICBBZGQgYSB3YXJuaW5nIHRvIGF2b2lkIHVzaW5nIHNpemVvZi4KPgo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAgNyArKysrLS0tCj4gIGluY2x1ZGUvbGludXgvdmly
dGlvX3BjaV9tb2Rlcm4uaCAgICAgIHwgIDcgLS0tLS0tLQo+ICBpbmNsdWRlL3VhcGkvbGludXgv
dmlydGlvX3BjaS5oICAgICAgICB8IDExICsrKysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybl9kZXYuYwo+IGluZGV4IGUyYTFmZTdiYjY2Yy4uN2RlOGIxZWJhYmFjIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMKPiBAQCAtMjk0LDkgKzI5NCwx
MCBAQCBpbnQgdnBfbW9kZXJuX3Byb2JlKHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9kZXZpY2Ug
Km1kZXYpCj4KPiAgICAgICAgIGVyciA9IC1FSU5WQUw7Cj4gICAgICAgICBtZGV2LT5jb21tb24g
PSB2cF9tb2Rlcm5fbWFwX2NhcGFiaWxpdHkobWRldiwgY29tbW9uLAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9j
ZmcpLCA0LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgc2l6ZW9m
KHN0cnVjdCB2aXJ0aW9fcGNpX21vZGVybl9jb21tb25fY2ZnKSwKPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZtZGV2LT5jb21tb25fbGVuLCBOVUxMKTsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2Nm
ZyksIDQsIDAsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2ZlbmQoc3Ry
dWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcXVldWVfcmVzZXQpLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZtZGV2LT5jb21tb25fbGVuLCBOVUxMKTsKPiAgICAgICAgIGlmICghbWRldi0+
Y29tbW9uKQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9tYXBfY29tbW9uOwo+ICAgICAgICAg
bWRldi0+aXNyID0gdnBfbW9kZXJuX21hcF9jYXBhYmlsaXR5KG1kZXYsIGlzciwgc2l6ZW9mKHU4
KSwgMSwKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oIGIv
aW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gaW5kZXggZDBmMjc5NzQyMGY3Li5h
MDllMTNhNTc3YTkgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVy
bi5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21vZGVybi5oCj4gQEAgLTUsMTMg
KzUsNiBAQAo+ICAjaW5jbHVkZSA8bGludXgvcGNpLmg+Cj4gICNpbmNsdWRlIDxsaW51eC92aXJ0
aW9fcGNpLmg+Cj4KPiAtc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2NvbW1vbl9jZmcgewo+IC0g
ICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBjZmc7Cj4gLQo+IC0gICAgICAgX19s
ZTE2IHF1ZXVlX25vdGlmeV9kYXRhOyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gLSAgICAgICBf
X2xlMTYgcXVldWVfcmVzZXQ7ICAgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiAtfTsKPiAt
Cj4gIC8qKgo+ICAgKiBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlIC0gaW5mbyBmb3Ig
bW9kZXJuIFBDSSB2aXJ0aW8KPiAgICogQHBjaV9kZXY6ICAgICAgIFB0ciB0byB0aGUgUENJIGRl
dmljZSBzdHJ1Y3QKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2ku
aCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiBpbmRleCBmNzAzYWZjN2FkMzEu
LjQ0ZjRkZDJhZGQxOCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Bj
aS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+IEBAIC0xNjYsNiAr
MTY2LDE3IEBAIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ICAgICAgICAgX19sZTMy
IHF1ZXVlX3VzZWRfaGk7ICAgICAgICAgICAvKiByZWFkLXdyaXRlICovCj4gIH07Cj4KPiArLyoK
PiArICogV2FybmluZzogZG8gbm90IHVzZSBzaXplb2Ygb24gdGhpczogdXNlIG9mZnNldG9mZW5k
IGZvcgo+ICsgKiBzcGVjaWZpYyBmaWVsZHMgeW91IG5lZWQuCj4gKyAqLwo+ICtzdHJ1Y3Qgdmly
dGlvX3BjaV9tb2Rlcm5fY29tbW9uX2NmZyB7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9j
b21tb25fY2ZnIGNmZzsKPiArCj4gKyAgICAgICBfX2xlMTYgcXVldWVfbm90aWZ5X2RhdGE7ICAg
ICAgIC8qIHJlYWQtd3JpdGUgKi8KPiArICAgICAgIF9fbGUxNiBxdWV1ZV9yZXNldDsgICAgICAg
ICAgICAgLyogcmVhZC13cml0ZSAqLwo+ICt9Owo+ICsKPiAgLyogRmllbGRzIGluIFZJUlRJT19Q
Q0lfQ0FQX1BDSV9DRkc6ICovCj4gIHN0cnVjdCB2aXJ0aW9fcGNpX2NmZ19jYXAgewo+ICAgICAg
ICAgc3RydWN0IHZpcnRpb19wY2lfY2FwIGNhcDsKPiAtLQo+IE1TVAo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
