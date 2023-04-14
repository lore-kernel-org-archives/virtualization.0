Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D12C77B6E
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 05:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C379040025;
	Fri, 14 Apr 2023 05:09:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C379040025
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hAWnbmFQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiiraUgRAptS; Fri, 14 Apr 2023 05:09:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26F55400FC;
	Fri, 14 Apr 2023 05:09:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26F55400FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 008C0C0037;
	Fri, 14 Apr 2023 05:09:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57B23C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C5CC60F4C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C5CC60F4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hAWnbmFQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ChDsHiWiByVh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:09:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4C8260F30
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4C8260F30
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681448988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rvMN6BRDbvRwSL10kciJszDIBa0dJCTVfq84Gv1b+Y=;
 b=hAWnbmFQACwj5bLRTmTJFdKUZByG45pDGL+C9SGp4LSeVM7s0Mf+GvxeJckypGL6vgYZWH
 myPy9yImJDxgXXdQpJwJn5QPEM7Guq41fnlwjFOMRTxUNxnhfSeSIb5lorEAnooIuv9Dav
 ZrIjoFtMwQC8ungRo5bmEnOZcJnmigg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-fEKlQ0feP3CfIk8IuytgGg-1; Fri, 14 Apr 2023 01:09:47 -0400
X-MC-Unique: fEKlQ0feP3CfIk8IuytgGg-1
Received: by mail-oo1-f72.google.com with SMTP id
 z142-20020a4a4994000000b005422e2170e7so1028121ooa.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 22:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681448987; x=1684040987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rvMN6BRDbvRwSL10kciJszDIBa0dJCTVfq84Gv1b+Y=;
 b=hzMpO1tUVhGpy9nzFBX7oW+RRik+5T6aBdG6YRd+ibTMaMWtAcVK1PFMsKazI+nX1L
 8pRxjNfjU+TYV6xxDwT3rIk3nuBl1v6EAdHe5LNgOSr2atL5+F30Hd1qdWc+PVASVJq8
 YsNENcSVvfHnjs3bNN7NDNFTJrm8Atk8YCcMPE1//HaXrT24GTWZ4JslQidIJ/Cv7RXP
 6d5gBG7bM/3t0UMfpDvzv7iwbGkKObBEd1sFXCasi4hcwS3uejLTHosfLGuWbhWj2t4A
 dfq99Jamiut2KINVEph5S7378mjAO4F09erdHViXrFXjLZJkfOo4pXs4LCM5CG8zY9/x
 m4PQ==
X-Gm-Message-State: AAQBX9cy8xbB0vRT7EpiSoLVhI9L0KKpM3IzfIe10mhVRIvkc9Ft7I+b
 cHTTL0AyzXZzNUktx0MhZBQ8Oa+dY9E9Z1kkxJO8A3grHYLVNmiWOF8NuDVVF+ovO/TmmzJMyMh
 ouChHLldBKWJRidIBFdz0lwuQKGzdU8s0CprtmEI6tUbNiHSrII1sMHcYrA==
X-Received: by 2002:a05:6870:a115:b0:184:502f:e79d with SMTP id
 m21-20020a056870a11500b00184502fe79dmr2049621oae.9.1681448986790; 
 Thu, 13 Apr 2023 22:09:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bsd7OBzzvfzTFbs2fVYsp7BQ1rLlRd8PA6YT7r6rA0syTXkc5b9ZbxhDpwEtYcJXENL6V+LGjZ2FFaZUTAIV4=
X-Received: by 2002:a05:6870:a115:b0:184:502f:e79d with SMTP id
 m21-20020a056870a11500b00184502fe79dmr2049615oae.9.1681448986551; Thu, 13 Apr
 2023 22:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230413064027.13267-1-jasowang@redhat.com>
 <20230413064027.13267-3-jasowang@redhat.com>
 <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681370820.0675354-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 13:09:35 +0800
Message-ID: <CACGkMEuJuZKGMhVwFmD0ZMa7V7TdGu6qaXF24Gg67TzMbs8ANA@mail.gmail.com>
Subject: Re: [PATCH net-next V2 2/2] virtio-net: sleep instead of busy waiting
 for cvq command
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, david.marchand@redhat.com, davem@davemloft.net
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMzozMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCAxMyBBcHIgMjAyMyAxNDo0MDoyNyAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBXZSB1c2Vk
IHRvIGJ1c3kgd2FpdGluZyBvbiB0aGUgY3ZxIGNvbW1hbmQgdGhpcyB0ZW5kcyB0byBiZQo+ID4g
cHJvYmxlbWF0aWMgc2luY2UgdGhlcmUgbm8gd2F5IGZvciB0byBzY2hlZHVsZSBhbm90aGVyIHBy
b2Nlc3Mgd2hpY2gKPiA+IG1heSBzZXJ2ZSBmb3IgdGhlIGNvbnRyb2wgdmlydHF1ZXVlLiBUaGlz
IG1pZ2h0IGJlIHRoZSBjYXNlIHdoZW4gdGhlCj4gPiBjb250cm9sIHZpcnRxdWV1ZSBpcyBlbXVs
YXRlZCBieSBzb2Z0d2FyZS4gVGhpcyBwYXRjaCBzd2l0Y2hlcyB0byB1c2UKPiA+IGNvbXBsZXRp
b24gdG8gYWxsb3cgdGhlIENQVSB0byBzbGVlcCBpbnN0ZWFkIG9mIGJ1c3kgd2FpdGluZyBmb3Ig
dGhlCj4gPiBjdnEgY29tbWFuZC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIHNpbmNlIFYxOgo+ID4gLSB1
c2UgY29tcGxldGlvbiBmb3Igc2ltcGxpY2l0eQo+ID4gLSBkb24ndCB0cnkgdG8gaGFyZGVuIHRo
ZSBDVlEgY29tbWFuZCB3aGljaCByZXF1aXJlcyBtb3JlIHRob3VnaHQKPiA+IENoYW5nZXMgc2lu
Y2UgUkZDOgo+ID4gLSBicmVhayB0aGUgZGV2aWNlIHdoZW4gdGltZW91dAo+ID4gLSBnZXQgYnVm
ZmVyIG1hbnVhbGx5IHNpbmNlIHRoZSB2aXJ0aW8gY29yZSBjaGVjayBtb3JlX3VzZWQoKSBpbnN0
ZWFkCj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMSArKysrKysrKysr
KysrKy0tLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCAyZTU2YmJmODY4OTQuLmQzZWI4ZmQ2
YzlkYyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtMTksNiArMTksNyBAQAo+ID4gICNpbmNs
dWRlIDxsaW51eC9hdmVyYWdlLmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2ZpbHRlci5oPgo+ID4g
ICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvY29tcGxldGlv
bi5oPgo+ID4gICNpbmNsdWRlIDxuZXQvcm91dGUuaD4KPiA+ICAjaW5jbHVkZSA8bmV0L3hkcC5o
Pgo+ID4gICNpbmNsdWRlIDxuZXQvbmV0X2ZhaWxvdmVyLmg+Cj4gPiBAQCAtMjk1LDYgKzI5Niw4
IEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4KPiA+ICAgICAgIC8qIGZhaWxvdmVyIHdoZW4g
U1RBTkRCWSBmZWF0dXJlIGVuYWJsZWQgKi8KPiA+ICAgICAgIHN0cnVjdCBmYWlsb3ZlciAqZmFp
bG92ZXI7Cj4gPiArCj4gPiArICAgICBzdHJ1Y3QgY29tcGxldGlvbiBjb21wbGV0aW9uOwo+ID4g
IH07Cj4gPgo+ID4gIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+ID4gQEAgLTE3MDksNiArMTcx
MiwxMyBAQCBzdGF0aWMgYm9vbCB0cnlfZmlsbF9yZWN2KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gPiAgICAgICByZXR1cm4gIW9vbTsKPiA+ICB9
Cj4gPgo+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfY3ZxX2RvbmUoc3RydWN0IHZpcnRxdWV1ZSAq
Y3ZxKQo+ID4gK3sKPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gY3ZxLT52ZGV2
LT5wcml2Owo+ID4gKwo+ID4gKyAgICAgY29tcGxldGUoJnZpLT5jb21wbGV0aW9uKTsKPiA+ICt9
Cj4gPiArCj4gPiAgc3RhdGljIHZvaWQgc2tiX3JlY3ZfZG9uZShzdHJ1Y3QgdmlydHF1ZXVlICpy
dnEpCj4gPiAgewo+ID4gICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBydnEtPnZkZXYt
PnByaXY7Cj4gPiBAQCAtMjE2OSwxMiArMjE3OSw4IEBAIHN0YXRpYyBib29sIHZpcnRuZXRfc2Vu
ZF9jb21tYW5kKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCB1OCBjbGFzcywgdTggY21kLAo+ID4g
ICAgICAgaWYgKHVubGlrZWx5KCF2aXJ0cXVldWVfa2ljayh2aS0+Y3ZxKSkpCj4gPiAgICAgICAg
ICAgICAgIHJldHVybiB2aS0+Y3RybC0+c3RhdHVzID09IFZJUlRJT19ORVRfT0s7Cj4gPgo+ID4g
LSAgICAgLyogU3BpbiBmb3IgYSByZXNwb25zZSwgdGhlIGtpY2sgY2F1c2VzIGFuIGlvcG9ydCB3
cml0ZSwgdHJhcHBpbmcKPiA+IC0gICAgICAqIGludG8gdGhlIGh5cGVydmlzb3IsIHNvIHRoZSBy
ZXF1ZXN0IHNob3VsZCBiZSBoYW5kbGVkIGltbWVkaWF0ZWx5Lgo+ID4gLSAgICAgICovCj4gPiAt
ICAgICB3aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVmKHZpLT5jdnEsICZ0bXApICYmCj4gPiAtICAg
ICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpCj4gPiAtICAgICAgICAgICAg
IGNwdV9yZWxheCgpOwo+ID4gKyAgICAgd2FpdF9mb3JfY29tcGxldGlvbigmdmktPmNvbXBsZXRp
b24pOwo+ID4gKyAgICAgdmlydHF1ZXVlX2dldF9idWYodmktPmN2cSwgJnRtcCk7Cj4gPgo+ID4g
ICAgICAgcmV0dXJuIHZpLT5jdHJsLT5zdGF0dXMgPT0gVklSVElPX05FVF9PSzsKPiA+ICB9Cj4g
PiBAQCAtMzY3Miw3ICszNjc4LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X2ZpbmRfdnFzKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpKQo+ID4KPiA+ICAgICAgIC8qIFBhcmFtZXRlcnMgZm9yIGNvbnRy
b2wgdmlydHF1ZXVlLCBpZiBhbnkgKi8KPiA+ICAgICAgIGlmICh2aS0+aGFzX2N2cSkgewo+ID4g
LSAgICAgICAgICAgICBjYWxsYmFja3NbdG90YWxfdnFzIC0gMV0gPSBOVUxMOwo+ID4gKyAgICAg
ICAgICAgICBjYWxsYmFja3NbdG90YWxfdnFzIC0gMV0gPSB2aXJ0bmV0X2N2cV9kb25lOwo+Cj4g
VGhpcyBkZXBlbmRzIHRoZSBpbnRlcnJ1cHQsIHJpZ2h0PwoKTm90IG5lY2Vzc2FyaWx5LCB3ZSBo
YXZlIElTUiBmb3IgYXQgbGFzdCBQQ0k6CgpzdGF0aWMgaXJxcmV0dXJuX3QgdnBfaW50ZXJydXB0
KGludCBpcnEsIHZvaWQgKm9wYXF1ZSkKewogICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2Rldmlj
ZSAqdnBfZGV2ID0gb3BhcXVlOwogICAgICAgIHU4IGlzcjsKCiAgICAgICAgLyogcmVhZGluZyB0
aGUgSVNSIGhhcyB0aGUgZWZmZWN0IG9mIGFsc28gY2xlYXJpbmcgaXQgc28gaXQncyB2ZXJ5CiAg
ICAgICAgICogaW1wb3J0YW50IHRvIHNhdmUgb2ZmIHRoZSB2YWx1ZS4gKi8KICAgICAgICBpc3Ig
PSBpb3JlYWQ4KHZwX2Rldi0+aXNyKTsKLi4uCn0KCj4KPiBJIHdvcnJ5IHRoYXQgdGhlcmUgbWF5
IGJlIHNvbWUgZGV2aWNlcyB0aGF0IG1heSBub3Qgc3VwcG9ydCBpbnRlcnJ1cHRpb24gb24gY3Zx
LgoKSXMgdGhlIGRldmljZSB1c2luZyBJTlRYIG9yIE1TSS1YPwoKPiBBbHRob3VnaCB0aGlzIG1h
eSBub3QgYmUgaW4gbGluZSB3aXRoIFNQRUMsIGl0IG1heSBjYXVzZSBwcm9ibGVtIG9uIHRoZSBk
ZXZpY2VzCj4gdGhhdCBjYW4gd29yayBub3JtYWxseSBhdCBwcmVzZW50LgoKVGhlbiB0aGUgaW1w
bGVtZW50YXRpb24gaXMgYnVnZ3ksIGl0IG1pZ2h0IG5vdCB3b3JrIGZvciBkcml2ZXJzIG90aGVy
CnRoYW4gTGludXguIFdvcmtpbmcgYXJvdW5kIHN1Y2ggYnVnZ3kgaW1wbGVtZW50YXRpb24gaXMg
c3Vib3B0aW1hbC4KClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+Cj4gPiAgICAgICAgICAgICAgIG5h
bWVzW3RvdGFsX3ZxcyAtIDFdID0gImNvbnRyb2wiOwo+ID4gICAgICAgfQo+ID4KPiA+IEBAIC00
MTIyLDYgKzQxMjgsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpCj4gPiAgICAgICBpZiAodmktPmhhc19yc3MgfHwgdmktPmhhc19yc3NfaGFz
aF9yZXBvcnQpCj4gPiAgICAgICAgICAgICAgIHZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2aSk7
Cj4gPgo+ID4gKyAgICAgaW5pdF9jb21wbGV0aW9uKCZ2aS0+Y29tcGxldGlvbik7Cj4gPiAgICAg
ICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+Cj4gPiAgICAgICAvKiBzZXJpYWxpemUgbmV0
ZGV2IHJlZ2lzdGVyICsgdmlydGlvX2RldmljZV9yZWFkeSgpIHdpdGggbmRvX29wZW4oKSAqLwo+
ID4gLS0KPiA+IDIuMjUuMQo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
