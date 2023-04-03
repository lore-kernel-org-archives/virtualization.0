Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1B2C76196
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 02:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EC6F40471;
	Mon,  3 Apr 2023 02:44:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EC6F40471
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfHQjt4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvbTknLZfIyA; Mon,  3 Apr 2023 02:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 168ED403F8;
	Mon,  3 Apr 2023 02:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 168ED403F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8102C0037;
	Mon,  3 Apr 2023 02:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A165BC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B2A281E05
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B2A281E05
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WfHQjt4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EVg8gwp8J3cy
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:44:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E6F78141E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2E6F78141E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 02:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680489861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4d82zEx4OoGYJZ5IgbT3LPSSEyoH17uMTnlYcS8X6gQ=;
 b=WfHQjt4FWNYe8UJWG7flFrpch3kgBEJa3deQUz4cK/N5tLMFsVtfAhVUQB/UPjPhBe4jPC
 0ok2zFiROKGLv0H2i5Ik93kyB2s5k/jjU+erLiC5jVJoUrPNGVj1cNO5GCfTytCi2fXhQs
 d+qUx6bFV8LyMwt/6PmZNghSA3uUU44=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-bffDLeaUNFa6rb93TuJkEQ-1; Sun, 02 Apr 2023 22:44:17 -0400
X-MC-Unique: bffDLeaUNFa6rb93TuJkEQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 f14-20020a9d5f0e000000b0069d8d0ff799so10317848oti.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Apr 2023 19:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680489857; x=1683081857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4d82zEx4OoGYJZ5IgbT3LPSSEyoH17uMTnlYcS8X6gQ=;
 b=q7T4x5JITSVtwvel2R0170QNCGTxeKqRFtwtvXjGBWZQ3bAwoRa0/7Eh9j5tn+wCuQ
 JDOa2i+wjJzfwRi7PHeBQvgM92dQ7aJMFMeroWdabTYnDxlmtbQRrDXs7ojWauM27eiy
 KXU5nJuQMjrUj0x/R2Vx2xZxrbycXXSfjdaSrvxg4TdPU5I3olEHBijRxHB5b7vQaRtY
 /yPtiBjWcXBEcJU32ZQDGkGoWi5Ujhw8wsPY2scCjJoKpftbttA7SymHM4ZGZeGXSxl5
 xZ5S1DJcvJLMoPGPezpG4NeZO6UC5kPVEHMYE1XoiDXQUZeXM+Fd0VRJt0gCv8VJZgjf
 muDw==
X-Gm-Message-State: AAQBX9fGZAloS/q1HBHHYCjdxmfywU6T8rd5oJl32Fa54nFI8hq8get8
 xsvkxJ97VJVJrV95r/ejGHmeATyIV2W4YPjMzJlDtQo4vCFyjhHnM8tk6KuOPM12iwrqehUFhRW
 /MkgQtiZpOjfwkkO5sRYgEmc6VQTbdjyeaglj4MVDfTn7vWPZP5LamLTYbA==
X-Received: by 2002:a9d:60d1:0:b0:694:3b4e:d8d7 with SMTP id
 b17-20020a9d60d1000000b006943b4ed8d7mr6690126otk.0.1680489857288; 
 Sun, 02 Apr 2023 19:44:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350aG3SqJ3tAJaPAN6kmGpZJmi0WlfB9MsHdiIUSihP4G1Zc6hDQsqReofmN/xPuHOQbkb3ufvr+FcLUmpCOXAks=
X-Received: by 2002:a9d:60d1:0:b0:694:3b4e:d8d7 with SMTP id
 b17-20020a9d60d1000000b006943b4ed8d7mr6690122otk.0.1680489857074; Sun, 02 Apr
 2023 19:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230328120412.110114-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Apr 2023 10:44:05 +0800
Message-ID: <CACGkMEv+dG0B82Mc+V+A_K1A97M0LLfbF5pwrW6v_M3hp1vDiQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] virtio_net: separate the logic of freeing
 xdp shinfo
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

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgODowNOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2UgYSBuZXcgZnVu
Y3Rpb24gdGhhdCByZWxlYXNlcyB0aGUKPiB4ZHAgc2hpbmZvLiBUaGUgc3Vic2VxdWVudCBwYXRj
aCB3aWxsIHJldXNlIHRoaXMgZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDI3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggNzJiOWQ2
ZWU0MDI0Li4wOWFlZDYwZTJmNTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTc5OCw2ICs3OTgsMjEg
QEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4g
ICAgICAgICByZXR1cm4gcmV0Owo+ICB9Cj4KPiArc3RhdGljIHZvaWQgcHV0X3hkcF9mcmFncyhz
dHJ1Y3QgeGRwX2J1ZmYgKnhkcCkKPiArewo+ICsgICAgICAgc3RydWN0IHNrYl9zaGFyZWRfaW5m
byAqc2hpbmZvOwo+ICsgICAgICAgc3RydWN0IHBhZ2UgKnhkcF9wYWdlOwo+ICsgICAgICAgaW50
IGk7Cj4gKwo+ICsgICAgICAgaWYgKHhkcF9idWZmX2hhc19mcmFncyh4ZHApKSB7Cj4gKyAgICAg
ICAgICAgICAgIHNoaW5mbyA9IHhkcF9nZXRfc2hhcmVkX2luZm9fZnJvbV9idWZmKHhkcCk7Cj4g
KyAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaGluZm8tPm5yX2ZyYWdzOyBpKyspIHsK
PiArICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcGFnZSA9IHNrYl9mcmFnX3BhZ2UoJnNoaW5m
by0+ZnJhZ3NbaV0pOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHhkcF9wYWdl
KTsKPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgfQo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50
IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhk
cF9idWZmICp4ZHAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCAqeGRwX3htaXQsCj4gQEAgLTEzMTIsMTIgKzEzMjcsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICB4
ZHBfcHJvZyA9IHJjdV9kZXJlZmVyZW5jZShycS0+eGRwX3Byb2cpOwo+ICAgICAgICAgaWYgKHhk
cF9wcm9nKSB7Cj4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCB4ZHBfZnJhZ3NfdHJ1ZXN6
ID0gMDsKPiAtICAgICAgICAgICAgICAgc3RydWN0IHNrYl9zaGFyZWRfaW5mbyAqc2hpbmZvOwo+
IC0gICAgICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqeGRwX3BhZ2U7Cj4gICAgICAgICAgICAgICAg
IHN0cnVjdCB4ZHBfYnVmZiB4ZHA7Cj4gICAgICAgICAgICAgICAgIHZvaWQgKmRhdGE7Cj4gICAg
ICAgICAgICAgICAgIHUzMiBhY3Q7Cj4gLSAgICAgICAgICAgICAgIGludCBpOwo+Cj4gICAgICAg
ICAgICAgICAgIGRhdGEgPSBtZXJnZWFibGVfeGRwX3ByZXBhcmUodmksIHJxLCB4ZHBfcHJvZywg
Y3R4LCAmZnJhbWVfc3osICZudW1fYnVmLCAmcGFnZSwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQsICZsZW4sIGhkcik7Cj4gQEAgLTEzNDgsMTQg
KzEzNjAsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRw
X2ZyYWdzOwo+ICAgICAgICAgICAgICAgICB9Cj4gIGVycl94ZHBfZnJhZ3M6Cj4gLSAgICAgICAg
ICAgICAgIGlmICh4ZHBfYnVmZl9oYXNfZnJhZ3MoJnhkcCkpIHsKPiAtICAgICAgICAgICAgICAg
ICAgICAgICBzaGluZm8gPSB4ZHBfZ2V0X3NoYXJlZF9pbmZvX2Zyb21fYnVmZigmeGRwKTsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgc2hpbmZvLT5ucl9mcmFnczsg
aSsrKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcGFnZSA9IHNrYl9m
cmFnX3BhZ2UoJnNoaW5mby0+ZnJhZ3NbaV0pOwo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcHV0X3BhZ2UoeGRwX3BhZ2UpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0KPiAt
ICAgICAgICAgICAgICAgfQo+IC0KPiArICAgICAgICAgICAgICAgcHV0X3hkcF9mcmFncygmeGRw
KTsKPiAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwOwo+ICAgICAgICAgfQo+ICAgICAgICAg
cmN1X3JlYWRfdW5sb2NrKCk7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
