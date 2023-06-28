Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BF4EB64DA
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 06:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15EA260B0D;
	Wed, 28 Jun 2023 06:51:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15EA260B0D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GXztbNvS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbry60BPL3sL; Wed, 28 Jun 2023 06:51:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DB246061B;
	Wed, 28 Jun 2023 06:51:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DB246061B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17584C007C;
	Wed, 28 Jun 2023 06:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F316AC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7C5360B0D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:51:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7C5360B0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bo-Q4Od7sv_9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:51:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62A3F6061B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62A3F6061B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687935083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
 b=GXztbNvSkL8MSrWimUeb9SUfCZ/NDpb9ioF+3dACdVIJKK8kQbQBNTC0bAcVt4FGdzZGZP
 AA5tjrVaxZYsHb02zi2Ci/dCoOfrpaxx5E8ZANqYqkHU85ixAji5E9a5lPjBdYvlgyn5z2
 fsqG94GuBhf2h9XOY8M3Q/gvtqngRhM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-eAaF0UBqO4abWTl9eT3UlA-1; Wed, 28 Jun 2023 02:51:21 -0400
X-MC-Unique: eAaF0UBqO4abWTl9eT3UlA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb89482cd6so1135092e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 23:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687935080; x=1690527080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su9PvChmWiVRJcH0aNEvF2GH7iXfYZGfbrKz513TiwY=;
 b=HXFTFv3LirurSJoINDwHOl/6kM2qFbgEMXRJbUjK2zPCjq80ItmsUhbt4IJ1v9+1yp
 OKgAT5hnNPzwHMuK88VTQoVwBp1f5POlZ4aOVSSKrxsgZ3MZXLJe5+2YwB89amX9Q9NZ
 7JGFSNTCfTBtyvN6eFX/RiIwUqeXsi9cuydaywk60JJIYoKze4EetP+LZ2ZBAtZHnnZH
 TcpO2+EwoarhkDskpojaaP8evh+/S4Rj7aVxxZ+hObEbFQQYIGGlEdoPkHFNNdjnLtdL
 Cr323ej7hVcvMWLKFgL5sq+BNYcAC79xDOu+lScHiDLWTb5QAFOegHP3eMA02FDJMoJ+
 dSNg==
X-Gm-Message-State: AC+VfDxCcJAo2RT2+5HZzADBlUGnkEM0vb4ueG4lxWYt5wyIxXTQRzSh
 XjCyGDqdyzkiicqC5Aw30EphJHvD1Po2wVP3SJYtBooixsmgKk4JbcKY3b2QntU4lExU/YMhpbO
 gHziDkCvKFtDKryBFo0nM5mgii/9h+TFxJ+31zqJEIvUW7dIMsdfcjTzyYA==
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id
 h24-20020a19ca58000000b004f8b3496938mr12994471lfj.65.1687935080146; 
 Tue, 27 Jun 2023 23:51:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mv/3o+OYScVrxaKdO8aw/adM4SivgvUgQcZTOZQ3rB1LnCfP7sgXl+EWa854Ej82KZ6RtMTKkjSWEuj6scx8=
X-Received: by 2002:a19:ca58:0:b0:4f8:b349:6938 with SMTP id
 h24-20020a19ca58000000b004f8b3496938mr12994457lfj.65.1687935079753; Tue, 27
 Jun 2023 23:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
 <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687932052.6412272-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 14:51:08 +0800
Message-ID: <CACGkMEumhkBShqXXbWXviS+xZA1aYrnZFoU_avdsWZ_9sBAwUQ@mail.gmail.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped
 buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMjowMuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCAyOCBKdW4gMjAyMyAxMjowNzoxMCAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBUdWUs
IEp1biAyNywgMjAyMyBhdCA1OjA14oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgMjcgSnVuIDIwMjMgMTY6MDM6MjYg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+IE9u
IEZyaSwgSnVuIDIsIDIwMjMgYXQgNToyMuKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IElmIHRoZSB2cSBpcyB0aGUg
cHJlbWFwcGVkIG1vZGUsIHVzZSB0aGUgc2dfZG1hX2FkZHJlc3MoKSBkaXJlY3RseS4KPiA+ID4g
PiA+Cj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQo+ID4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPiA+
ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+IGluZGV4IDJhZmRmYjll
M2UzMC4uMTgyMTJjM2UwNTZiIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gPiA+ID4gQEAgLTU5OCw4ICs1OTgsMTIgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1
ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkcjsKPiA+ID4gPiA+Cj4gPiA+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2cs
IERNQV9UT19ERVZJQ0UsICZhZGRyKSkKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYWRkciA9IHNnX2RtYV9hZGRyZXNzKHNnKTsKPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSwgJmFk
ZHIpKQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gdW5tYXBfcmVsZWFzZTsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+
ID4gPgo+ID4gPiA+IEJ0dywgSSB3b25kZXIgd2hldGhlciBvciBub3QgaXQgd291bGQgYmUgc2lt
cGxlIHRvIGltcGxlbWVudCB0aGUKPiA+ID4gPiB2cS0+cHJlbWFwcGVkIGNoZWNrIGluc2lkZSB2
cmluZ19tYXBfb25lX3NnKCkgYXNzdW1pbmcgdGhlCj4gPiA+ID4gIXVzZV9kbWFfYXBpIGlzIGRv
bmUgdGhlcmUgYXMgd2VsbC4KPiA+ID4KPiA+ID4KPiA+ID4gWUVTLAo+ID4gPgo+ID4gPiBUaGF0
IHdpbGwgbW9yZSBzaW1wbGUgZm9yIHRoZSBjYWxsZXIuCj4gPiA+Cj4gPiA+IEJ1dCB3ZSB3aWxs
IGhhdmUgdGhpbmdzIGxpa2U6Cj4gPiA+Cj4gPiA+IGludCBmdW5jKGJvb2wgZG8pCj4gPiA+IHsK
PiA+ID4gaWYgKCFkbykKPiA+ID4gICAgIHJldHVybjsKPiA+ID4gfQo+ID4gPgo+ID4gPiBJIGxp
a2UgdGhpcyB3YXksIGJ1dCB5b3UgZG9uJ3QgbGlrZSBpdCBpbiBsYXN0IHZlcnNpb24uCj4gPgo+
ID4gSSBzZWUgOikKPiA+Cj4gPiBTbyBJIHRoaW5rIGl0IGRlcGVuZHMgb24gdGhlIGVycm9yIGhh
bmRsaW5nIHBhdGgsIHdlIHNob3VsZCBjaG9vc2UgYQo+ID4gd2F5IHRoYXQgY2FuIGxldCB1cyBl
YXNpbHkgZGVhbCB3aXRoIGVycm9ycy4KPiA+Cj4gPiBGb3IgZXhhbXBsZSwgaXQgc2VlbXMgdGhl
IGN1cnJlbnQgYXBwcm9hY2ggaXMgYmV0dGVyIHNpbmNlIGl0IGRvZXNuJ3QKPiA+IG5lZWQgdG8g
Y2hhbmdlIHRoZSB1bm1hcF9yZWxlYXNlLgo+Cj4gTk8sCj4KPiBUaGUgdW5tYXBfcmVsZWFzZSBp
cyBzYW1lIGZvciB0d28gd2F5Lgo+Cj4gVGhhbmtzLgoKT2ssIHNvIGVpdGhlciBpcyBmaW5lIGZv
ciBtZS4KClRoYW5rcwoKPgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcHJldiA9IGk7Cj4gPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3RlIHRoYXQgd2UgdHJ1c3QgaW5kaXJlY3Qg
ZGVzY3JpcHRvcgo+ID4gPiA+ID4gQEAgLTYxNCw4ICs2MTgsMTIgQEAgc3RhdGljIGlubGluZSBp
bnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsK
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRkcjsKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9z
Zyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+ID4gPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodnEtPnByZW1hcHBlZCkgewo+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwo+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfRlJP
TV9ERVZJQ0UsICZhZGRyKSkKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcHJl
diA9IGk7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAvKiBOb3RlIHRoYXQgd2Ug
dHJ1c3QgaW5kaXJlY3QgZGVzY3JpcHRvcgo+ID4gPiA+ID4gQEAgLTY4OSwyMSArNjk3LDIzIEBA
IHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAq
X3ZxLAo+ID4gPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgdW5t
YXBfcmVsZWFzZToKPiA+ID4gPiA+IC0gICAgICAgZXJyX2lkeCA9IGk7Cj4gPiA+ID4gPiArICAg
ICAgIGlmICghdnEtPnByZW1hcHBlZCkgewo+ID4gPiA+Cj4gPiA+ID4gQ2FuIHZxLT5wcmVtYXBw
ZWQgYmUgdHJ1ZSBoZXJlPyBUaGUgbGFiZWwgaXMgbmFtZWQgYXMgInVubWFwX3JlbGFzZSIKPiA+
ID4gPiB3aGljaCBpbXBsaWVzICJtYXAiIGJlZm9yZWhhbmQgd2hpY2ggc2VlbXMgbm90IHRoZSBj
YXNlIGZvcgo+ID4gPiA+IHByZW1hcHBpbmcuCj4gPiA+Cj4gPiA+IEkgc2VlLgo+ID4gPgo+ID4g
PiBSZXRoaW5rIGFib3V0IHRoaXMsIHRoZXJlIGlzIGEgYmV0dGVyIHdheS4KPiA+ID4gSSB3aWxs
IGZpeCBpbiBuZXh0IHZlcnNpb24uCj4gPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+
ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICBlcnJfaWR4ID0gaTsKPiA+ID4gPiA+Cj4gPiA+ID4gPiAtICAgICAgIGlmIChp
bmRpcmVjdCkKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICBpID0gMDsKPiA+ID4gPiA+IC0gICAg
ICAgZWxzZQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgIGkgPSBoZWFkOwo+ID4gPiA+ID4gLQo+
ID4gPiA+ID4gLSAgICAgICBmb3IgKG4gPSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+ID4gPiA+
ID4gLSAgICAgICAgICAgICAgIGlmIChpID09IGVycl9pZHgpCj4gPiA+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICBpZiAoaW5kaXJl
Y3QpIHsKPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9z
cGxpdF9pbmRpcmVjdCh2cSwgJmRlc2NbaV0pOwo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgaSA9IHZpcnRpbzE2X3RvX2NwdShfdnEtPnZkZXYsIGRlc2NbaV0ubmV4dCk7Cj4gPiA+
ID4gPiAtICAgICAgICAgICAgICAgfSBlbHNlCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICBpID0gdnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCBpKTsKPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICBpZiAoaW5kaXJlY3QpCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBp
ID0gMDsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBlbHNlCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpID0gaGVhZDsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAgICAg
ICAgICBmb3IgKG4gPSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+ID4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKGkgPT0gZXJyX2lkeCkKPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoaW5kaXJlY3QpIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmZGVzY1tpXSk7Cj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgPSB2aXJ0aW8xNl90b19jcHUoX3Zx
LT52ZGV2LCBkZXNjW2ldLm5leHQpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
fSBlbHNlCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgPSB2cmlu
Z191bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIH0KPiA+
ID4gPiA+ICAgICAgICAgfQo+ID4gPiA+ID4KPiA+ID4gPiA+ICAgICAgICAgaWYgKGluZGlyZWN0
KQo+ID4gPiA+ID4gLS0KPiA+ID4gPiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPiA+ID4gPiA+Cj4g
PiA+ID4KPiA+ID4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
