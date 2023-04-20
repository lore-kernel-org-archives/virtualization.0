Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD85CC77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 06:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 83BCA40220;
	Thu, 20 Apr 2023 06:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83BCA40220
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVDOUdpO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTD9hHKKktC4; Thu, 20 Apr 2023 06:10:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AD69400D1;
	Thu, 20 Apr 2023 06:10:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AD69400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54F68C0036;
	Thu, 20 Apr 2023 06:10:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D826C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1442E42128
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:10:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1442E42128
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aVDOUdpO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8bI5caboi0DW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:10:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18B714210A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18B714210A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 06:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681971031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+2TPu1Dli86e40Ba+uWSkUDT3RNHQ6yyjC59DejTew=;
 b=aVDOUdpOlWoRujqKJrAow0B2gqXjMc1If5Fqwp74/Qf0hgkj6EkL5KFRyQswGBfL90IO0d
 H8RzANZio/JfH1zTE8MGxdn8R0cK+VfjEpkxMyt/okF9u89E7nD0cUg2FjCsXyLo+6q8h1
 o1lEAqXqxQT2ROgfieMorkdFIf5oKf4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-ZhXCOsggN1asynVGy_saJA-1; Thu, 20 Apr 2023 02:10:30 -0400
X-MC-Unique: ZhXCOsggN1asynVGy_saJA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5469ab1632eso411999eaf.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 23:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681971029; x=1684563029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+2TPu1Dli86e40Ba+uWSkUDT3RNHQ6yyjC59DejTew=;
 b=PUqEoo42z9AFzoH7X6iPQGOMFUVh/jtG3UmPldj8HTsIB2ssyJyrgYQ3ffc2d3uNPA
 hUrqiWTwV/Y1yStO3heNKLjAGkv9ZZcwtQo+x2NyYSCecv34K4itgJ+ZtrdtjWIulu4j
 9v9sfmPFYdUB9zKYbBfD+C5vYqK+wYdzZHpPkqqKpyd2rVGpFa66DfgHDPI+6e2SMdPG
 0wu2uEfqIugY8+GPqWQ/SE7B2ssGxMfnjQ9AacI67aQT0mifdfgyx57qDhQCIYUawX0C
 +iWnz7zvCvG+i8D7aaMVRMwgTKaio+obSG3Qc2zWbwHI5c1hGkzOhMfnLM1IsVYaX6pA
 FxKA==
X-Gm-Message-State: AAQBX9e5r+uqHAgAOh08eripHLMjruOQlF/gnBIb2ZbKjjJLbG6QcxUT
 zZDSgy/yDsHHEaPSPnoYPo4aKsdN0T5O7GtKNnEpmkb2VQyqBo+tAsv7XxKf8RiTo3GOBtaTr8f
 aDncFgmtNXdOUXXz8uS4K+o5s4dQXWXe48LBiMwO1OFTBfDHhlHVDBLZWIA==
X-Received: by 2002:a05:6808:1307:b0:38e:352:62ac with SMTP id
 y7-20020a056808130700b0038e035262acmr432127oiv.51.1681971029619; 
 Wed, 19 Apr 2023 23:10:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZwwHZJhTnLekIJiCmfK6gCgbWRui/f1zAK1Ry561QhXGh9aTx1YVBYdwmTm4x9sm99V1pd9d3YW5eXefxeacw=
X-Received: by 2002:a05:6808:1307:b0:38e:352:62ac with SMTP id
 y7-20020a056808130700b0038e035262acmr432115oiv.51.1681971029449; Wed, 19 Apr
 2023 23:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Apr 2023 14:10:18 +0800
Message-ID: <CACGkMEuQ9dW6SjTJ6R_zDz7e4JTwb9TKrO5YN51=J9b4PWOAfg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/14] virtio_net: merge: remove skip_xdp
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

T24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gTm93LCB0aGUgbG9naWMgb2YgbWVyZ2UgeGRwIHBy
b2Nlc3MgaXMgc2ltcGxlLCB3ZSBjYW4gcmVtb3ZlIHRoZQo+IHNraXBfeGRwLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyMyArKysrKysrKysrLS0tLS0tLS0tLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gaW5kZXggNDJlOTkyN2UzMTZiLi5hNGJiMjVmMzlmMTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAg
LTEzOTAsNyArMTM5MCw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFi
bGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0g
dmlydF90b19oZWFkX3BhZ2UoYnVmKTsKPiAgICAgICAgIGludCBvZmZzZXQgPSBidWYgLSBwYWdl
X2FkZHJlc3MocGFnZSk7Cj4gICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqaGVhZF9za2IsICpjdXJy
X3NrYjsKPiAtICAgICAgIHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2c7Cj4gICAgICAgICB1bnNp
Z25lZCBpbnQgdHJ1ZXNpemUgPSBtZXJnZWFibGVfY3R4X3RvX3RydWVzaXplKGN0eCk7Cj4gICAg
ICAgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20gPSBtZXJnZWFibGVfY3R4X3RvX2hlYWRyb29tKGN0
eCk7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgdGFpbHJvb20gPSBoZWFkcm9vbSA/IHNpemVvZihz
dHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSA6IDA7Cj4gQEAgLTE0MDYsMjIgKzE0MDUsMjAgQEAgc3Rh
dGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9za2I7Cj4gICAgICAgICB9Cj4KPiAtICAg
ICAgIGlmIChsaWtlbHkoIXZpLT54ZHBfZW5hYmxlZCkpIHsKPiAtICAgICAgICAgICAgICAgeGRw
X3Byb2cgPSBOVUxMOwo+IC0gICAgICAgICAgICAgICBnb3RvIHNraXBfeGRwOwo+IC0gICAgICAg
fQo+ICsgICAgICAgaWYgKHVubGlrZWx5KHZpLT54ZHBfZW5hYmxlZCkpIHsKPiArICAgICAgICAg
ICAgICAgc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPgo+IC0gICAgICAgcmN1X3JlYWRfbG9j
aygpOwo+IC0gICAgICAgeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhkcF9wcm9nKTsK
PiAtICAgICAgIGlmICh4ZHBfcHJvZykgewo+IC0gICAgICAgICAgICAgICBoZWFkX3NrYiA9IHJl
Y2VpdmVfbWVyZ2VhYmxlX3hkcChkZXYsIHZpLCBycSwgeGRwX3Byb2csIGJ1ZiwgY3R4LAo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsZW4sIHhkcF94
bWl0LCBzdGF0cyk7Cj4gKyAgICAgICAgICAgICAgIHJjdV9yZWFkX2xvY2soKTsKPiArICAgICAg
ICAgICAgICAgeGRwX3Byb2cgPSByY3VfZGVyZWZlcmVuY2UocnEtPnhkcF9wcm9nKTsKPiArICAg
ICAgICAgICAgICAgaWYgKHhkcF9wcm9nKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaGVh
ZF9za2IgPSByZWNlaXZlX21lcmdlYWJsZV94ZHAoZGV2LCB2aSwgcnEsIHhkcF9wcm9nLCBidWYs
IGN0eCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBsZW4sIHhkcF94bWl0LCBzdGF0cyk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
cmN1X3JlYWRfdW5sb2NrKCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGhlYWRf
c2tiOwo+ICsgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9j
aygpOwo+IC0gICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gICAgICAgICB9Cj4gLSAg
ICAgICByY3VfcmVhZF91bmxvY2soKTsKPgo+IC1za2lwX3hkcDoKPiAgICAgICAgIGhlYWRfc2ti
ID0gcGFnZV90b19za2IodmksIHJxLCBwYWdlLCBvZmZzZXQsIGxlbiwgdHJ1ZXNpemUsIGhlYWRy
b29tKTsKPiAgICAgICAgIGN1cnJfc2tiID0gaGVhZF9za2I7Cj4KPiAtLQo+IDIuMzIuMC4zLmcw
MTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
