Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF30C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 07:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EA82818BE;
	Tue, 25 Apr 2023 07:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EA82818BE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SeMaYg5S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMXVdsUin2Fu; Tue, 25 Apr 2023 07:41:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8730C81501;
	Tue, 25 Apr 2023 07:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8730C81501
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B586C0037;
	Tue, 25 Apr 2023 07:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03FB5C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5D5781757
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:41:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5D5781757
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eSHZaeaS7Poi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A05DB81501
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A05DB81501
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682408505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgtdiCdfMaL2IrJBuUV1QXhdAi7SKOJBtJL5aY2h2cc=;
 b=SeMaYg5S1GyC/l4sSRXk58U8UxRBqDT1y9DwBi6hIwKIQ+g3ZIgyXFl+2c0w5SYdXJ4uNE
 SgDwhoyUJI4L+kskEOhoEA4IpQATPxaG6ekH+LUEMEIL0Dj/1sry9FbTZtx9XEUT6EbWBR
 CofIwcvaanLkZbEgVKd8K7nOxxrss8s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-MLib0-LsNV-m9TKuLWXg-A-1; Tue, 25 Apr 2023 03:41:42 -0400
X-MC-Unique: MLib0-LsNV-m9TKuLWXg-A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edd5a7cddeso5444726e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 00:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682408500; x=1685000500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgtdiCdfMaL2IrJBuUV1QXhdAi7SKOJBtJL5aY2h2cc=;
 b=KPThkGMWywIzMaoFriJJF05++gcK7g4QwX5e/dMbBl0mB5QsfYoG7/0016jpSKoYyt
 mlU/QQMuMMx8Ke9Fa0dE4fwAxWayw+omoT0pUfYtRJziVT1JM7evDK2cCnp+FQI6TKz0
 KVH4ezhXOjQfuwVdJ4Lsb0Ut7mcUrqXrd8pXLprXdN00P8CXKHYkAg75EACZQNRFTvg2
 akRas3NV8S+NMDxl4u6ohW9i4yWbIaBtwONHR1qsZ8frIx89KdxDqnQf9TLUqB2MZyfl
 ng3b4Fuy5bsRO+UEDEiZDgtyF4gjesbTO9l/z6EVk0ACo2uhVS8ZKZmnzgpCUOnTXJr4
 wddg==
X-Gm-Message-State: AAQBX9c3cIx1L/RTU1uUtIQBMl0dXX7f1kaKHSl/sWwvXl9ct8zqmTns
 SRAUBzkUXfE1ri1Rer1p5N9JuWDHeX5bC+O88tmXFwqx4lqapeRLC9KMnjuQO6LvAsvAQyD2hfF
 lI+34T3LibW9ng4uzumuvWbOkJOn8X/EdPv64kltH7D/r8U9O7BtK7Q/B3w==
X-Received: by 2002:a2e:b545:0:b0:2a7:6bcd:d8ba with SMTP id
 a5-20020a2eb545000000b002a76bcdd8bamr3586484ljn.3.1682408500560; 
 Tue, 25 Apr 2023 00:41:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350YtbsDQ78FOkCn5PwXZvtQ47STnF7zTV74XDSGcUXlb0/2BkgSi60VfkPJBn54CRLDkO8ajP3e/Op9gmlv53QU=
X-Received: by 2002:a2e:b545:0:b0:2a7:6bcd:d8ba with SMTP id
 a5-20020a2eb545000000b002a76bcdd8bamr3586468ljn.3.1682408500213; Tue, 25 Apr
 2023 00:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230423105736.56918-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Apr 2023 15:41:28 +0800
Message-ID: <CACGkMEsNLa9ETksZBi-fkni3c0FzpdNFr-y87Gt48-QKuLDPtg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/15] virtio_net: auto release xdp shinfo
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNjo1N+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoKSBh
bmQgdmlydG5ldF94ZHBfaGFuZGxlcigpIGF1dG8KPiByZWxlYXNlIHhkcCBzaGluZm8gdGhlbiB0
aGUgY2FsbGVyIG5vIG5lZWQgdG8gY2FyZWZ1bCB0aGUgeGRwIHNoaW5mby4KClRoaW5raW5nIG9m
IHRoaXMsIEkgdGhpbmsgcmVsZWFzaW5nIGZyYWdzIGluCnZpcnRuZXRfYnVpbGRfeGRwX2J1ZmZf
bXJnKCkgaXMgZmluZS4gQnV0IGZvciB2aXJ0bmV0X3hkcF9oYW5kbGVyKCksCml0J3MgYmV0dGVy
IHRvIGJlIGRvbmUgYnkgdGhlIGNhbGxlciwgc2luY2UgdGhlIGZyYWdzIHdlcmUgcHJlcGFyZWQg
YnkKdGhlIGNhbGxlciBhbnlob3cuCgpUaGFua3MKCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCAyOSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5k
ZXggNWYzN2ExY2VmNjFlLi5jNmJmNDI1ZTg4NDQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTgyNSw3
ICs4MjUsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9n
ICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gICAgICAgICAgICAgICAgIHhkcGYg
PSB4ZHBfY29udmVydF9idWZmX3RvX2ZyYW1lKHhkcCk7Cj4gICAgICAgICAgICAgICAgIGlmICh1
bmxpa2VseSgheGRwZikpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZGJnKGRl
diwgImNvbnZlcnQgYnVmZiB0byBmcmFtZSBmYWlsZWQgZm9yIHhkcFxuIik7Cj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIFhEUF9EUk9QOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGdvdG8gZHJvcDsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgIGVyciA9
IHZpcnRuZXRfeGRwX3htaXQoZGV2LCAxLCAmeGRwZiwgMCk7Cj4gQEAgLTgzMyw3ICs4MzMsNyBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJv
Zywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgeGRwX3Jl
dHVybl9mcmFtZV9yeF9uYXBpKHhkcGYpOwo+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHVu
bGlrZWx5KGVyciA8IDApKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdHJhY2VfeGRwX2V4
Y2VwdGlvbihkZXYsIHhkcF9wcm9nLCBhY3QpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBYRFBfRFJPUDsKPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRyb3A7Cj4gICAg
ICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgKnhkcF94bWl0IHw9IFZJUlRJT19YRFBf
VFg7Cj4gICAgICAgICAgICAgICAgIHJldHVybiBhY3Q7Cj4gQEAgLTg0Miw3ICs4NDIsNyBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywg
c3RydWN0IHhkcF9idWZmICp4ZHAsCj4gICAgICAgICAgICAgICAgIHN0YXRzLT54ZHBfcmVkaXJl
Y3RzKys7Cj4gICAgICAgICAgICAgICAgIGVyciA9IHhkcF9kb19yZWRpcmVjdChkZXYsIHhkcCwg
eGRwX3Byb2cpOwo+ICAgICAgICAgICAgICAgICBpZiAoZXJyKQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBYRFBfRFJPUDsKPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRy
b3A7Cj4KPiAgICAgICAgICAgICAgICAgKnhkcF94bWl0IHw9IFZJUlRJT19YRFBfUkVESVI7Cj4g
ICAgICAgICAgICAgICAgIHJldHVybiBhY3Q7Cj4gQEAgLTg1NCw4ICs4NTQsMTIgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csIHN0cnVj
dCB4ZHBfYnVmZiAqeGRwLAo+ICAgICAgICAgICAgICAgICB0cmFjZV94ZHBfZXhjZXB0aW9uKGRl
diwgeGRwX3Byb2csIGFjdCk7Cj4gICAgICAgICAgICAgICAgIGZhbGx0aHJvdWdoOwo+ICAgICAg
ICAgY2FzZSBYRFBfRFJPUDoKPiAtICAgICAgICAgICAgICAgcmV0dXJuIFhEUF9EUk9QOwo+ICsg
ICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPiArCj4gK2Ryb3A6Cj4gKyAgICAgICBw
dXRfeGRwX2ZyYWdzKHhkcCk7Cj4gKyAgICAgICByZXR1cm4gWERQX0RST1A7Cj4gIH0KPgo+ICBz
dGF0aWMgdW5zaWduZWQgaW50IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpKQo+IEBAIC0xMTkwLDcgKzExOTQsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVpbGRf
eGRwX2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZGV2LT5uYW1lLCAqbnVtX2J1ZiwKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsIGhkci0+bnVtX2J1ZmZlcnMp
KTsKPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMr
KzsKPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAg
ICAgICAgIHN0YXRzLT5ieXRlcyArPSBsZW47Cj4gQEAgLTEyMDksNyArMTIxMyw3IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiAgICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiBsZW4gJXUg
ZXhjZWVkcyB0cnVlc2l6ZSAlbHVcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGV2LT5uYW1lLCBsZW4sICh1bnNpZ25lZCBsb25nKSh0cnVlc2l6ZSAtIHJvb20pKTsKPiAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycjsKPiAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAg
IGZyYWcgPSAmc2hpbmZvLT5mcmFnc1tzaGluZm8tPm5yX2ZyYWdzKytdOwo+IEBAIC0xMjI0LDYg
KzEyMjgsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LAo+Cj4gICAgICAgICAqeGRwX2ZyYWdzX3RydWVzaXplID0geGRwX2Zy
YWdzX3RydWVzejsKPiAgICAgICAgIHJldHVybiAwOwo+ICsKPiArZXJyOgo+ICsgICAgICAgcHV0
X3hkcF9mcmFncyh4ZHApOwo+ICsgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gIH0KPgo+ICBzdGF0
aWMgdm9pZCAqbWVyZ2VhYmxlX3hkcF9nZXRfYnVmKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+
IEBAIC0xMzUzLDcgKzEzNjEsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVy
Z2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBsZW4sIGZy
YW1lX3N6LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmbnVtX2J1ZiwgJnhkcF9mcmFnc190cnVlc3osIHN0YXRzKTsKPiAgICAgICAgICAgICAgICAg
aWYgKHVubGlrZWx5KGVycikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRw
X2ZyYWdzOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPgo+ICAgICAg
ICAgICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9wcm9nLCAmeGRwLCBkZXYs
IHhkcF94bWl0LCBzdGF0cyk7Cj4KPiBAQCAtMTM2MSw3ICsxMzY5LDcgQEAgc3RhdGljIHN0cnVj
dCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAg
ICAgICAgICAgICAgICBjYXNlIFhEUF9QQVNTOgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGhl
YWRfc2tiID0gYnVpbGRfc2tiX2Zyb21feGRwX2J1ZmYoZGV2LCB2aSwgJnhkcCwgeGRwX2ZyYWdz
X3RydWVzeik7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFoZWFkX3Nr
YikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHA7Cj4KPiAgICAg
ICAgICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gQEAgLTEzNzAsMTEgKzEzNzgsOCBAQCBzdGF0aWMg
c3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byB4ZHBfeG1pdDsKPiAgICAgICAgICAgICAgICAgZGVmYXVsdDoK
PiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGVycl94ZHA7Cj4gICAgICAgICAgICAgICAgIH0KPiAtZXJyX3hkcF9mcmFnczoKPiAt
ICAgICAgICAgICAgICAgcHV0X3hkcF9mcmFncygmeGRwKTsKPiAtICAgICAgICAgICAgICAgZ290
byBlcnJfeGRwOwo+ICAgICAgICAgfQo+ICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4KPiAt
LQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
