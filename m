Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE5EB64D7
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 04:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FB7360B03;
	Wed, 28 Jun 2023 04:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FB7360B03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y0veKSNM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cPJrKYKkomwf; Wed, 28 Jun 2023 04:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC70060B15;
	Wed, 28 Jun 2023 04:07:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC70060B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3094C007C;
	Wed, 28 Jun 2023 04:07:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1528CC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 04:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC0B060B15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 04:07:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC0B060B15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g14lp6GfKbb2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 04:07:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A543560B03
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A543560B03
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 04:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687925245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
 b=Y0veKSNMpdvnJuWzTVBd+tdwS60n2oK6waymPT7LH0Z4vvtYVXnZKHNGGcRl9oGvSet7Bq
 pj63UbJ4ZpwX8ROdAVxYR9QYAJkjBkiHfkXAH3U+T8kikCsk4GsyE/o1L2/Kr/NCECKH9F
 96dtzj1mS94mPCW7UDQjPYSuin1Hcm4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-gtfLCTdEN2WlhOcEgCMlhg-1; Wed, 28 Jun 2023 00:07:23 -0400
X-MC-Unique: gtfLCTdEN2WlhOcEgCMlhg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb911b4ffeso276811e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 21:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687925242; x=1690517242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZpZ6PoVWfkpUfuNjOlXwmJuKqxjPMv+yOZvIpQzOso=;
 b=VXZLT9g7bs9kiweSDSLxvbHfwJgpp/a26j8BOnG8inJBoP6FJdCaqjdDndSrdcGWnz
 ayejiqK0C6AjF9g+M2Tdo6FKJuXIk++fz09QTGQyFJUClXkQM3lGWIeCxccZPRxezoXk
 e9VNQDx5RHOeep0yN5mBhA3UGwNg3QHmwINiZaHoQ0XiosU5SFT3SvlOaGVpttYUTh63
 2fcs0037HBIOdndB11kctrfZroqhLQ4CrowyLFbcFiHXdJkCw4Lfyv+hlDtXI+vRg0Vd
 FyRK7rIOaAvf2E7joPhR++xOgW6Ac/n02GeJoiQws+TNX9UM5aInWqAFgpR1fVE3ojaT
 TjjA==
X-Gm-Message-State: AC+VfDw2D/nqC7k/8ZxBB1RgzmeFR7k9HOOER/XhteqPNx+SLNyXSIw6
 v43cFNBvX0ALVJKpGsSBZYue5zj3LRAsCvaeTdobuEf+ltkRGNa15gpubv6oDPYVJB/zNMrAgOi
 CqdgvOv5V9QUiyh3bOSj23X7nSzMWVMIr2MJ8Q339LD9OxKuaIbjIE/qB0w==
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id
 p8-20020a056512234800b004fb7592cc7amr6364679lfu.20.1687925242176; 
 Tue, 27 Jun 2023 21:07:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hCTKWRmXZEpVs0DYgKad/Ul/B5vDH3+80UITOMrtYNREd0vSuAqCm4CbSBg4eNiR8SAwsYOxO/FVXJYEWXm8=
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id
 p8-20020a056512234800b004fb7592cc7amr6364664lfu.20.1687925241866; Tue, 27 Jun
 2023 21:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
 <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 12:07:10 +0800
Message-ID: <CACGkMEsmxax+kOdQA=e4D_xT0WkTPRcooxRHNvsi6xpaV+8ahQ@mail.gmail.com>
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgNTowNeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCAyNyBKdW4gMjAyMyAxNjowMzoyNiAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiBPbiBGcmks
IEp1biAyLCAyMDIzIGF0IDU6MjLigK9QTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJh
YmEuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gSWYgdGhlIHZxIGlzIHRoZSBwcmVtYXBwZWQgbW9k
ZSwgdXNlIHRoZSBzZ19kbWFfYWRkcmVzcygpIGRpcmVjdGx5Lgo+ID4gPgo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gPiAtLS0K
PiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA0NiArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25z
KCspLCAxOCBkZWxldGlvbnMoLSkKPiA+ID4KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+IGlu
ZGV4IDJhZmRmYjllM2UzMC4uMTgyMTJjM2UwNTZiIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiA+ID4gQEAgLTU5OCw4ICs1OTgsMTIgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1
ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gPiA+ICAgICAgICAgICAgICAg
ICBmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFkZHI7Cj4gPiA+Cj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSwg
JmFkZHIpKQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBf
cmVsZWFzZTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQp
IHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2Fk
ZHJlc3Moc2cpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBz
ZywgRE1BX1RPX0RFVklDRSwgJmFkZHIpKQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICB9Cj4gPgo+ID4gQnR3LCBJIHdvbmRlciB3aGV0aGVyIG9yIG5vdCBpdCB3b3VsZCBi
ZSBzaW1wbGUgdG8gaW1wbGVtZW50IHRoZQo+ID4gdnEtPnByZW1hcHBlZCBjaGVjayBpbnNpZGUg
dnJpbmdfbWFwX29uZV9zZygpIGFzc3VtaW5nIHRoZQo+ID4gIXVzZV9kbWFfYXBpIGlzIGRvbmUg
dGhlcmUgYXMgd2VsbC4KPgo+Cj4gWUVTLAo+Cj4gVGhhdCB3aWxsIG1vcmUgc2ltcGxlIGZvciB0
aGUgY2FsbGVyLgo+Cj4gQnV0IHdlIHdpbGwgaGF2ZSB0aGluZ3MgbGlrZToKPgo+IGludCBmdW5j
KGJvb2wgZG8pCj4gewo+IGlmICghZG8pCj4gICAgIHJldHVybjsKPiB9Cj4KPiBJIGxpa2UgdGhp
cyB3YXksIGJ1dCB5b3UgZG9uJ3QgbGlrZSBpdCBpbiBsYXN0IHZlcnNpb24uCgpJIHNlZSA6KQoK
U28gSSB0aGluayBpdCBkZXBlbmRzIG9uIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoLCB3ZSBzaG91
bGQgY2hvb3NlIGEKd2F5IHRoYXQgY2FuIGxldCB1cyBlYXNpbHkgZGVhbCB3aXRoIGVycm9ycy4K
CkZvciBleGFtcGxlLCBpdCBzZWVtcyB0aGUgY3VycmVudCBhcHByb2FjaCBpcyBiZXR0ZXIgc2lu
Y2UgaXQgZG9lc24ndApuZWVkIHRvIGNoYW5nZSB0aGUgdW5tYXBfcmVsZWFzZS4KClRoYW5rcwoK
Pgo+ID4KPiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcHJldiA9IGk7Cj4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE5vdGUgdGhhdCB3ZSB0cnVzdCBpbmRpcmVjdCBk
ZXNjcmlwdG9yCj4gPiA+IEBAIC02MTQsOCArNjE4LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHZp
cnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gPiAgICAgICAgICAg
ICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+ID4gPgo+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RF
VklDRSwgJmFkZHIpKQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
dW5tYXBfcmVsZWFzZTsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVt
YXBwZWQpIHsKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2df
ZG1hX2FkZHJlc3Moc2cpOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3Nn
KHZxLCBzZywgRE1BX0ZST01fREVWSUNFLCAmYWRkcikpCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH0KPiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcHJl
diA9IGk7Cj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE5vdGUgdGhhdCB3ZSB0cnVz
dCBpbmRpcmVjdCBkZXNjcmlwdG9yCj4gPiA+IEBAIC02ODksMjEgKzY5NywyMyBAQCBzdGF0aWMg
aW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+
ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4KPiA+ID4gIHVubWFwX3JlbGVhc2U6Cj4gPiA+IC0g
ICAgICAgZXJyX2lkeCA9IGk7Cj4gPiA+ICsgICAgICAgaWYgKCF2cS0+cHJlbWFwcGVkKSB7Cj4g
Pgo+ID4gQ2FuIHZxLT5wcmVtYXBwZWQgYmUgdHJ1ZSBoZXJlPyBUaGUgbGFiZWwgaXMgbmFtZWQg
YXMgInVubWFwX3JlbGFzZSIKPiA+IHdoaWNoIGltcGxpZXMgIm1hcCIgYmVmb3JlaGFuZCB3aGlj
aCBzZWVtcyBub3QgdGhlIGNhc2UgZm9yCj4gPiBwcmVtYXBwaW5nLgo+Cj4gSSBzZWUuCj4KPiBS
ZXRoaW5rIGFib3V0IHRoaXMsIHRoZXJlIGlzIGEgYmV0dGVyIHdheS4KPiBJIHdpbGwgZml4IGlu
IG5leHQgdmVyc2lvbi4KPgo+Cj4gVGhhbmtzLgo+Cj4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPgo+
ID4gPiArICAgICAgICAgICAgICAgZXJyX2lkeCA9IGk7Cj4gPiA+Cj4gPiA+IC0gICAgICAgaWYg
KGluZGlyZWN0KQo+ID4gPiAtICAgICAgICAgICAgICAgaSA9IDA7Cj4gPiA+IC0gICAgICAgZWxz
ZQo+ID4gPiAtICAgICAgICAgICAgICAgaSA9IGhlYWQ7Cj4gPiA+IC0KPiA+ID4gLSAgICAgICBm
b3IgKG4gPSAwOyBuIDwgdG90YWxfc2c7IG4rKykgewo+ID4gPiAtICAgICAgICAgICAgICAgaWYg
KGkgPT0gZXJyX2lkeCkKPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gPiA+
IC0gICAgICAgICAgICAgICBpZiAoaW5kaXJlY3QpIHsKPiA+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmZGVzY1tpXSk7Cj4gPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIGkgPSB2aXJ0aW8xNl90b19jcHUoX3ZxLT52ZGV2LCBk
ZXNjW2ldLm5leHQpOwo+ID4gPiAtICAgICAgICAgICAgICAgfSBlbHNlCj4gPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGkgPSB2cmluZ191bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgKGluZGlyZWN0KQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpID0gMDsKPiA+ID4gKyAgICAgICAgICAgICAgIGVsc2UKPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaSA9IGhlYWQ7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICAgICAgICAgIGZvciAobiA9
IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
IChpID09IGVycl9pZHgpCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJl
YWs7Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChpbmRpcmVjdCkgewo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRp
cmVjdCh2cSwgJmRlc2NbaV0pOwo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGkgPSB2aXJ0aW8xNl90b19jcHUoX3ZxLT52ZGV2LCBkZXNjW2ldLm5leHQpOwo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICB9IGVsc2UKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpID0gdnJpbmdfdW5tYXBfb25lX3NwbGl0KHZxLCBpKTsKPiA+ID4gKyAgICAgICAg
ICAgICAgIH0KPiA+ID4gICAgICAgICB9Cj4gPiA+Cj4gPiA+ICAgICAgICAgaWYgKGluZGlyZWN0
KQo+ID4gPiAtLQo+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPiA+Cj4gPgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
