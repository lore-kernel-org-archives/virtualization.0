Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3606C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 24 May 2023 08:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59C3341E13;
	Wed, 24 May 2023 08:04:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59C3341E13
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jbo2uWTh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqkvtkKhhnhL; Wed, 24 May 2023 08:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92CC2402E8;
	Wed, 24 May 2023 08:04:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92CC2402E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D9E3C0035;
	Wed, 24 May 2023 08:04:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29BD8C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1D7040901
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:04:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1D7040901
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jbo2uWTh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EHU1-AmdVC4M
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 96442408F9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96442408F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684915445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=924fElwHvrZJ6A9qwffPKGTRYYHcNsBTeimp8/kNN9I=;
 b=Jbo2uWTh0d5IVpWlHgeEHb1zMhf234fpumWx7rTn6iVe+kEMFNi4r0R50p6OxKH4Hxgd2C
 Jc/oKbxfVQA4PhayhkDSXhxBSPT2X1RurWZ7mbGRPehcF8TJBfspPF1UtKzEFZNoEAnLra
 xT4DtT6wyMFmw9GpyWv9ilpQHMVDhvQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-wvNwHgIwNtaruzd65-RoNA-1; Wed, 24 May 2023 04:04:03 -0400
X-MC-Unique: wvNwHgIwNtaruzd65-RoNA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3bb23174eso276179e87.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 May 2023 01:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684915442; x=1687507442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=924fElwHvrZJ6A9qwffPKGTRYYHcNsBTeimp8/kNN9I=;
 b=ZjlB/xerbijWT9seRD+Q9gR5gUS3/zbB9haZcT6X16EfMf4MbcqTqoMIzUAPumKuu9
 J3uajL9PF+ZPxtgmUH5afHmR8Eiqyp4mIbyDRrFseXkZu2w4MQ7LIuJlEmFhu4t6Oe2d
 16Vqf491RxcJvwkFZ9lRdKlpIIrwcn78hOd7JDwCV3rtaS5qbwORlXed+O68tyjTy7Xk
 5mjjHd/CK0Zx4iaMocsx0qHm45GO5dy87qvs8PBWiDh02k8Vd8zUo2rLa0IjbXtrQnqU
 oPGUkA62g6upnjJdsYJ8ABXnmfeiU+cIXzyKCuaCvyD42a8XxJoEJZsIOtLWroSdUBR5
 TYkA==
X-Gm-Message-State: AC+VfDyrJ+1DVOMf4aMqeH87HkmdDs3zyOcuaSecWg1hG9s2vIwLnPUH
 l/5WTq+Eau0ej+Wo+dUlF/6WiRYfoPFp+ahS45E8QK61fLN3ROkBrJhFPX2eZbLAwpr/+GBZZ1i
 e/KASFPpYTvd65aSM1b7XO6xz41kSmJH7JcvYUxCACwA+mrZTuoOADA5+Vg==
X-Received: by 2002:ac2:54bb:0:b0:4f4:b397:ebda with SMTP id
 w27-20020ac254bb000000b004f4b397ebdamr2254087lfk.56.1684915442476; 
 Wed, 24 May 2023 01:04:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PR/KNiEwxKVz/2obrBLtXHjFhBT/oc8ddxyweOYF8K6zcqgt2F1MO9P8Sk2ZMiFmg0KGOAPjAOT+aA14dfrw=
X-Received: by 2002:ac2:54bb:0:b0:4f4:b397:ebda with SMTP id
 w27-20020ac254bb000000b004f4b397ebdamr2254080lfk.56.1684915442134; Wed, 24
 May 2023 01:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
In-Reply-To: <20230508180512.17371-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 16:03:50 +0800
Message-ID: <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
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

T24gTW9uLCBNYXkgOCwgMjAyMyBhdCA2OjA14oCvUE0gWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56
aHVAaW50ZWwuY29tPiB3cm90ZToKPgo+IFRoaXMgY29tbWl0IHN5bmNocm9uaXplIGlycXMgb2Yg
dGhlIHZpcnRxdWV1ZXMKPiBhbmQgY29uZmlnIHNwYWNlIGluIHRoZSByZXNldCByb3V0aW5lLgo+
IFRodXMgaWZjdmZfc3RvcF9odygpIGFuZCByZXNldCgpIGFyZSByZWZhY3RvcmVkIGFzIHdlbGwu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfCA0MSArKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLQo+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwg
IDEgKwo+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgNDYgKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygr
KSwgNTAgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX2Jhc2UuYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPiBpbmRleCA3OWUz
MTNjNWUxMGUuLjFmMzkyOTBiYWEzOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+IEBA
IC0xNzAsMTIgKzE3MCw5IEBAIHZvaWQgaWZjdmZfc2V0X3N0YXR1cyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3LCB1OCBzdGF0dXMpCj4KPiAgdm9pZCBpZmN2Zl9yZXNldChzdHJ1Y3QgaWZjdmZfaHcgKmh3
KQo+ICB7Cj4gLSAgICAgICBody0+Y29uZmlnX2NiLmNhbGxiYWNrID0gTlVMTDsKPiAtICAgICAg
IGh3LT5jb25maWdfY2IucHJpdmF0ZSA9IE5VTEw7Cj4gLQo+ICAgICAgICAgaWZjdmZfc2V0X3N0
YXR1cyhodywgMCk7Cj4gLSAgICAgICAvKiBmbHVzaCBzZXRfc3RhdHVzLCBtYWtlIHN1cmUgVkYg
aXMgc3RvcHBlZCwgcmVzZXQgKi8KPiAtICAgICAgIGlmY3ZmX2dldF9zdGF0dXMoaHcpOwo+ICsg
ICAgICAgd2hpbGUgKGlmY3ZmX2dldF9zdGF0dXMoaHcpKQo+ICsgICAgICAgICAgICAgICBtc2xl
ZXAoMSk7Cj4gIH0KPgo+ICB1NjQgaWZjdmZfZ2V0X2h3X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9o
dyAqaHcpCj4gQEAgLTM2OCwyMCArMzY1LDQyIEBAIHZvaWQgaWZjdmZfc2V0X3ZxX3JlYWR5KHN0
cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQsIGJvb2wgcmVhZHkpCj4gICAgICAgICB2cF9pb3dy
aXRlMTYocmVhZHksICZjZmctPnF1ZXVlX2VuYWJsZSk7Cj4gIH0KPgo+IC1zdGF0aWMgdm9pZCBp
ZmN2Zl9od19kaXNhYmxlKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3N0YXRpYyB2b2lkIGlmY3Zm
X3Jlc2V0X3ZyaW5nKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gIHsKPiAtICAgICAgIHUzMiBpOwo+
ICsgICAgICAgdTE2IHFpZDsKPiArCj4gKyAgICAgICBmb3IgKHFpZCA9IDA7IHFpZCA8IGh3LT5u
cl92cmluZzsgcWlkKyspIHsKPiArICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IuY2Fs
bGJhY2sgPSBOVUxMOwo+ICsgICAgICAgICAgICAgICBody0+dnJpbmdbcWlkXS5jYi5wcml2YXRl
ID0gTlVMTDsKPiArICAgICAgICAgICAgICAgaWZjdmZfc2V0X3ZxX3ZlY3RvcihodywgcWlkLCBW
SVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4gKyAgICAgICB9Cj4gK30KPgo+ICtzdGF0aWMgdm9pZCBp
ZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICt7Cj4gKyAg
ICAgICBody0+Y29uZmlnX2NiLmNhbGxiYWNrID0gTlVMTDsKPiArICAgICAgIGh3LT5jb25maWdf
Y2IucHJpdmF0ZSA9IE5VTEw7Cj4gICAgICAgICBpZmN2Zl9zZXRfY29uZmlnX3ZlY3Rvcihodywg
VklSVElPX01TSV9OT19WRUNUT1IpOwo+IC0gICAgICAgZm9yIChpID0gMDsgaSA8IGh3LT5ucl92
cmluZzsgaSsrKSB7Cj4gLSAgICAgICAgICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIGks
IFZJUlRJT19NU0lfTk9fVkVDVE9SKTsKPiArfQo+ICsKPiArc3RhdGljIHZvaWQgaWZjdmZfc3lu
Y2hyb25pemVfaXJxKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gK3sKPiArICAgICAgIHUzMiBudmVj
dG9ycyA9IGh3LT5udW1fbXNpeF92ZWN0b3JzOwo+ICsgICAgICAgc3RydWN0IHBjaV9kZXYgKnBk
ZXYgPSBody0+cGRldjsKPiArICAgICAgIGludCBpLCBpcnE7Cj4gKwo+ICsgICAgICAgZm9yIChp
ID0gMDsgaSA8IG52ZWN0b3JzOyBpKyspIHsKPiArICAgICAgICAgICAgICAgaXJxID0gcGNpX2ly
cV92ZWN0b3IocGRldiwgaSk7Cj4gKyAgICAgICAgICAgICAgIGlmIChpcnEgPj0gMCkKPiArICAg
ICAgICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9pcnEoaXJxKTsKPiAgICAgICAgIH0KPiAg
fQo+Cj4gIHZvaWQgaWZjdmZfc3RvcF9odyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ICB7Cj4gLSAg
ICAgICBpZmN2Zl9od19kaXNhYmxlKGh3KTsKPiAtICAgICAgIGlmY3ZmX3Jlc2V0KGh3KTsKPiAr
ICAgICAgIGlmY3ZmX3N5bmNocm9uaXplX2lycShodyk7Cj4gKyAgICAgICBpZmN2Zl9yZXNldF92
cmluZyhodyk7Cj4gKyAgICAgICBpZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihodyk7CgpOaXQ6
CgpTbyB0aGUgbmFtZSBvZiB0aGlzIGZ1bmN0aW9uIGlzIGtpbmQgb2YgbWlzbGVhZGluZyBzaW5j
ZSBpcnEKc3luY2hyb25pemF0aW9uIGFuZCB2aXJ0cXVldWUvY29uZmlnIGhhbmRsZXIgYXJlIG5v
dCBiZWxvbmcgdG8KaGFyZHdhcmU/CgpNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2FsbCBp
dCBpZmN2Zl9zdG9wKCkuCgpUaGFua3MKCj4gIH0KPgo+ICB2b2lkIGlmY3ZmX25vdGlmeV9xdWV1
ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkKQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+
IGluZGV4IGQzNGQzYmMwZGJmNC4uNzQzMGY4MDc3OWJlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5oCj4gQEAgLTgyLDYgKzgyLDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPiAgICAgICAgIGlu
dCB2cXNfcmV1c2VkX2lycTsKPiAgICAgICAgIHUxNiBucl92cmluZzsKPiAgICAgICAgIC8qIFZJ
UlRJT19QQ0lfQ0FQX0RFVklDRV9DRkcgc2l6ZSAqLwo+ICsgICAgICAgdTMyIG51bV9tc2l4X3Zl
Y3RvcnM7Cj4gICAgICAgICB1MzIgY2FwX2Rldl9jb25maWdfc2l6ZTsKPiAgICAgICAgIHN0cnVj
dCBwY2lfZGV2ICpwZGV2Owo+ICB9Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDk2
ODY4NzE1OWU0NC4uMzQwMWI5OTAxZGQyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4g
QEAgLTEyNSw2ICsxMjUsNyBAQCBzdGF0aWMgdm9pZCBpZmN2Zl9mcmVlX2lycShzdHJ1Y3QgaWZj
dmZfaHcgKnZmKQo+ICAgICAgICAgaWZjdmZfZnJlZV92cV9pcnEodmYpOwo+ICAgICAgICAgaWZj
dmZfZnJlZV9jb25maWdfaXJxKHZmKTsKPiAgICAgICAgIGlmY3ZmX2ZyZWVfaXJxX3ZlY3RvcnMo
cGRldik7Cj4gKyAgICAgICB2Zi0+bnVtX21zaXhfdmVjdG9ycyA9IDA7Cj4gIH0KPgo+ICAvKiBp
ZmN2ZiBNU0lYIHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhlbHBlciB0cmllcyB0byBhbGxvY2F0
ZQo+IEBAIC0zNDMsMzYgKzM0NCwxMSBAQCBzdGF0aWMgaW50IGlmY3ZmX3JlcXVlc3RfaXJxKHN0
cnVjdCBpZmN2Zl9odyAqdmYpCj4gICAgICAgICBpZiAocmV0KQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Owo+Cj4gLSAgICAgICByZXR1cm4gMDsKPiAtfQo+IC0KPiAtc3RhdGljIGludCBp
ZmN2Zl9zdG9wX2RhdGFwYXRoKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+IC17Cj4g
LSAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7Cj4gLSAgICAgICBpbnQg
aTsKPiAtCj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspCj4gLSAg
ICAgICAgICAgICAgIHZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4gLQo+IC0gICAg
ICAgaWZjdmZfc3RvcF9odyh2Zik7Cj4gKyAgICAgICB2Zi0+bnVtX21zaXhfdmVjdG9ycyA9IG52
ZWN0b3JzOwo+Cj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLXN0YXRpYyB2b2lkIGlmY3Zm
X3Jlc2V0X3ZyaW5nKHN0cnVjdCBpZmN2Zl9hZGFwdGVyICphZGFwdGVyKQo+IC17Cj4gLSAgICAg
ICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gYWRhcHRlci0+dmY7Cj4gLSAgICAgICBpbnQgaTsKPiAt
Cj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspIHsKPiAtICAgICAg
ICAgICAgICAgdmYtPnZyaW5nW2ldLmxhc3RfYXZhaWxfaWR4ID0gMDsKPiAtICAgICAgICAgICAg
ICAgdmYtPnZyaW5nW2ldLmNiLmNhbGxiYWNrID0gTlVMTDsKPiAtICAgICAgICAgICAgICAgdmYt
PnZyaW5nW2ldLmNiLnByaXZhdGUgPSBOVUxMOwo+IC0gICAgICAgfQo+IC0KPiAtICAgICAgIGlm
Y3ZmX3Jlc2V0KHZmKTsKPiAtfQo+IC0KPiAgc3RhdGljIHN0cnVjdCBpZmN2Zl9hZGFwdGVyICp2
ZHBhX3RvX2FkYXB0ZXIoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgewo+ICAgICAg
ICAgcmV0dXJuIGNvbnRhaW5lcl9vZih2ZHBhX2Rldiwgc3RydWN0IGlmY3ZmX2FkYXB0ZXIsIHZk
cGEpOwo+IEBAIC00NjIsMjMgKzQzOCwxNSBAQCBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3NldF9z
dGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTggc3RhdHVzKQo+Cj4gIHN0YXRp
YyBpbnQgaWZjdmZfdmRwYV9yZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICB7
Cj4gLSAgICAgICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcjsKPiAtICAgICAgIHN0cnVj
dCBpZmN2Zl9odyAqdmY7Cj4gLSAgICAgICB1OCBzdGF0dXNfb2xkOwo+IC0KPiAtICAgICAgIHZm
ICA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+IC0gICAgICAgYWRhcHRlciA9IHZkcGFfdG9fYWRh
cHRlcih2ZHBhX2Rldik7Cj4gLSAgICAgICBzdGF0dXNfb2xkID0gaWZjdmZfZ2V0X3N0YXR1cyh2
Zik7Cj4gKyAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7
Cj4gKyAgICAgICB1OCBzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsKPgo+IC0gICAgICAg
aWYgKHN0YXR1c19vbGQgPT0gMCkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIDA7Cj4gKyAgICAg
ICBpZmN2Zl9zdG9wX2h3KHZmKTsKPgo+IC0gICAgICAgaWYgKHN0YXR1c19vbGQgJiBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKSB7Cj4gLSAgICAgICAgICAgICAgIGlmY3ZmX3N0b3BfZGF0YXBh
dGgoYWRhcHRlcik7Cj4gKyAgICAgICBpZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZF
Ul9PSykKPiAgICAgICAgICAgICAgICAgaWZjdmZfZnJlZV9pcnEodmYpOwo+IC0gICAgICAgfQo+
Cj4gLSAgICAgICBpZmN2Zl9yZXNldF92cmluZyhhZGFwdGVyKTsKPiArICAgICAgIGlmY3ZmX3Jl
c2V0KHZmKTsKPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAtLQo+IDIuMzkuMQo+CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
