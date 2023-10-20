Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185ADCDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8A8D4C51B;
	Fri, 20 Oct 2023 06:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8A8D4C51B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JRN2TZg9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1-Q9Ad9F4mK; Fri, 20 Oct 2023 06:57:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED2864833A;
	Fri, 20 Oct 2023 06:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED2864833A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA35CC0071;
	Fri, 20 Oct 2023 06:57:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FF4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0EC74C51B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0EC74C51B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqvLQ8Zx8sLX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0887F4833A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0887F4833A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XjUPv+gwBCrWbYikhfmwGaSYOiZ3DKUgBx2xSYV9XY=;
 b=JRN2TZg9VsvWhzyWl6WmdyRKY66yNeWBnjNB0la1K6VSBkKUwhgwnBHWTE2LIAeudTLKd1
 QETxOSoFDo5QKof4VYtQiFv9yb7baLvvn/oTw0X118d517V0s/OwHHvs7c071ILZIMWd1F
 0OZ8P0vyGUMIVaD6g/hH/8oJF/6+Ha8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-lSunSQ-MNteY_NyLmXp_8w-1; Fri, 20 Oct 2023 02:57:18 -0400
X-MC-Unique: lSunSQ-MNteY_NyLmXp_8w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507ceeff451so442861e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697785037; x=1698389837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XjUPv+gwBCrWbYikhfmwGaSYOiZ3DKUgBx2xSYV9XY=;
 b=rAfWTyicPQSF3UTwrbG9nELde164A5QSCVq4NvuRNVTdaD91Oe/Jo6oBwtMN6MYbqt
 W2ZFEu6tOOZe7+GOmWmlRxGJR8u+jlMxvvPNd+NMbTsLkdXp2Rub00Sl1rR+jk4HTi9P
 c5fw0PL48+8nELjSKoAN3vapuYb9rmIEvIT/YX+QO5QvSW7HruOEFMFTkEwARGghcJ3Q
 PopYcukcAwn4eKQ5byw/5zo5w2HS/RacOXfnRL7MDWbkVmt3EbH7ynfJeHsHR0a+X5l6
 C0IxHPKLCeUCPgfBFvx7zphcnYz0UDdCQOOyCw77fi7UjpoAkHTmlBR/ioPHkwSIClk2
 BtzA==
X-Gm-Message-State: AOJu0Ywqnk8GOq2a+TNyIRRt+KFapkoH7++2PT6opjm/xOAAyKJ5Rz9v
 XOUjDEGwIbpzdgbROJnHzo/ZB395ITF7P3N4hfUqS+ih2qX0ES3GC1kZ1FsxjRS7vcGhkIgGTIk
 zzR0i5ksz+gEpWiYQyhEzVL8cKkIUurCPvVKZY4uuGadgROFs1M6Tu3NfAA==
X-Received: by 2002:a19:6745:0:b0:507:9fc1:ca7e with SMTP id
 e5-20020a196745000000b005079fc1ca7emr540176lfj.51.1697785037271; 
 Thu, 19 Oct 2023 23:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV1/zgHPOTgu23Bkc2CBQtcjSLoGh5tyCKjckYB47DrXeqaiq30vHzI68llkAEUgYVS1CNzdCc88SavQfdUwY=
X-Received: by 2002:a19:6745:0:b0:507:9fc1:ca7e with SMTP id
 e5-20020a196745000000b005079fc1ca7emr540162lfj.51.1697785036851; Thu, 19 Oct
 2023 23:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-17-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:57:06 +0800
Message-ID: <CACGkMEtvVBXupsiE8=Mt4CWJqckS5tF-w_ZdG2qs-AoYBWptWA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 16/19] virtio_net: xsk: rx: introduce
 receive_xsk() to recv xsk buffer
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSW1wbGVtZW50aW5nIHRoZSBsb2dpYyBvZiB4c2sg
cnguIElmIHRoaXMgcGFja2V0IGlzIG5vdCBmb3IgWFNLCj4gZGV0ZXJtaW5lZCBpbiBYRFAsIHRo
ZW4gd2UgbmVlZCB0byBjb3B5IG9uY2UgdG8gZ2VuZXJhdGUgYSBTS0IuCj4gSWYgaXQgaXMgZm9y
IFhTSywgaXQgaXMgYSB6ZXJvY29weSByZWNlaXZlIHBhY2tldCBwcm9jZXNzLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAg
ZHJpdmVycy9uZXQvdmlydGlvL21haW4uYyAgICAgICB8ICAxNCArKy0tCj4gIGRyaXZlcnMvbmV0
L3ZpcnRpby92aXJ0aW9fbmV0LmggfCAgIDQgKysKPiAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5j
ICAgICAgICB8IDEyMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJz
L25ldC92aXJ0aW8veHNrLmggICAgICAgIHwgICA0ICsrCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTM3
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvdmlydGlvL21haW4uYyBiL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiBpbmRleCAwZTc0
MDQ0N2IxNDIuLjAwM2RkNjdhYjcwNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8v
bWFpbi5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+IEBAIC04MjIsMTAgKzgy
MiwxMCBAQCBzdGF0aWMgdm9pZCBwdXRfeGRwX2ZyYWdzKHN0cnVjdCB4ZHBfYnVmZiAqeGRwKQo+
ICAgICAgICAgfQo+ICB9Cj4KPiAtc3RhdGljIGludCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0cnVj
dCBicGZfcHJvZyAqeGRwX3Byb2csIHN0cnVjdCB4ZHBfYnVmZiAqeGRwLAo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKnhkcF94bWl0LAo+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydG5ldF9ycV9zdGF0cyAqc3RhdHMpCj4gK2lu
dCB2aXJ0bmV0X3hkcF9oYW5kbGVyKHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csIHN0cnVjdCB4
ZHBfYnVmZiAqeGRwLAo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50ICp4ZHBfeG1pdCwK
PiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydG5ldF9ycV9zdGF0cyAqc3RhdHMp
Cj4gIHsKPiAgICAgICAgIHN0cnVjdCB4ZHBfZnJhbWUgKnhkcGY7Cj4gICAgICAgICBpbnQgZXJy
Owo+IEBAIC0xNTg5LDEzICsxNTg5LDE3IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9ycSAqcnEsCj4gICAgICAgICAgICAg
ICAgIHJldHVybjsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgaWYgKHZpLT5tZXJnZWFibGVfcnhf
YnVmcykKPiArICAgICAgIHJjdV9yZWFkX2xvY2soKTsKPiArICAgICAgIGlmIChyY3VfZGVyZWZl
cmVuY2UocnEtPnhzay5wb29sKSkKPiArICAgICAgICAgICAgICAgc2tiID0gdmlydG5ldF9yZWNl
aXZlX3hzayhkZXYsIHZpLCBycSwgYnVmLCBsZW4sIHhkcF94bWl0LCBzdGF0cyk7Cj4gKyAgICAg
ICBlbHNlIGlmICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpCj4gICAgICAgICAgICAgICAgIHNrYiA9
IHJlY2VpdmVfbWVyZ2VhYmxlKGRldiwgdmksIHJxLCBidWYsIGN0eCwgbGVuLCB4ZHBfeG1pdCwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHMpOwo+ICAgICAg
ICAgZWxzZSBpZiAodmktPmJpZ19wYWNrZXRzKQo+ICAgICAgICAgICAgICAgICBza2IgPSByZWNl
aXZlX2JpZyhkZXYsIHZpLCBycSwgYnVmLCBsZW4sIHN0YXRzKTsKPiAgICAgICAgIGVsc2UKPiAg
ICAgICAgICAgICAgICAgc2tiID0gcmVjZWl2ZV9zbWFsbChkZXYsIHZpLCBycSwgYnVmLCBjdHgs
IGxlbiwgeGRwX3htaXQsIHN0YXRzKTsKPiArICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+Cj4g
ICAgICAgICBpZiAodW5saWtlbHkoIXNrYikpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaCBiL2RyaXZlcnMvbmV0
L3ZpcnRpby92aXJ0aW9fbmV0LmgKPiBpbmRleCA2ZTcxNjIyZmNhNDUuLmZkN2YzNDcwM2M5YiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oCj4gKysrIGIvZHJp
dmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+IEBAIC0zNDYsNiArMzQ2LDEwIEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCB2aXJ0bmV0X2lzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLCBpbnQKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+ICB9Cj4K
PiAraW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3Ry
dWN0IHhkcF9idWZmICp4ZHAsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKnhkcF94
bWl0LAo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3JxX3N0YXRzICpz
dGF0cyk7Cj4gIHZvaWQgdmlydG5ldF9yeF9wYXVzZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwg
c3RydWN0IHZpcnRuZXRfcnEgKnJxKTsKPiAgdm9pZCB2aXJ0bmV0X3J4X3Jlc3VtZShzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJxKTsKPiAgdm9pZCB2aXJ0bmV0
X3R4X3BhdXNlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9zcSAqc3Ep
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgYi9kcml2ZXJzL25ldC92
aXJ0aW8veHNrLmMKPiBpbmRleCA4NDFmYjA3ODg4MmEuLmYxYzY0NDE0ZmFjOSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8v
eHNrLmMKPiBAQCAtMTMsNiArMTMsMTggQEAgc3RhdGljIHZvaWQgc2dfZmlsbF9kbWEoc3RydWN0
IHNjYXR0ZXJsaXN0ICpzZywgZG1hX2FkZHJfdCBhZGRyLCB1MzIgbGVuKQo+ICAgICAgICAgc2ct
Pmxlbmd0aCA9IGxlbjsKPiAgfQo+Cj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgdmlydG5ldF9yZWNl
aXZlX2J1Zl9udW0oc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIGNoYXIgKmJ1ZikKPiArewo+ICsg
ICAgICAgc3RydWN0IHZpcnRpb19uZXRfaGRyX21yZ19yeGJ1ZiAqaGRyOwo+ICsKPiArICAgICAg
IGlmICh2aS0+bWVyZ2VhYmxlX3J4X2J1ZnMpIHsKPiArICAgICAgICAgICAgICAgaGRyID0gKHN0
cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKilidWY7Cj4gKyAgICAgICAgICAgICAgIHJl
dHVybiB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsIGhkci0+bnVtX2J1ZmZlcnMpOwo+ICsgICAg
ICAgfQo+ICsKPiArICAgICAgIHJldHVybiAxOwo+ICt9Cj4gKwo+ICBzdGF0aWMgdm9pZCB2aXJ0
bmV0X3hza19jaGVja19xdWV1ZShzdHJ1Y3QgdmlydG5ldF9zcSAqc3EpCj4gIHsKPiAgICAgICAg
IHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gc3EtPnZxLT52ZGV2LT5wcml2Owo+IEBAIC0zNyw2
ICs0OSwxMTQgQEAgc3RhdGljIHZvaWQgdmlydG5ldF94c2tfY2hlY2tfcXVldWUoc3RydWN0IHZp
cnRuZXRfc3EgKnNxKQo+ICAgICAgICAgICAgICAgICBuZXRpZl9zdG9wX3N1YnF1ZXVlKGRldiwg
cW51bSk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBtZXJnZV9kcm9wX2ZvbGxvd194ZHAoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZpcnRuZXRfcnEgKnJxLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
MzIgbnVtX2J1ZiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZp
cnRuZXRfcnFfc3RhdHMgKnN0YXRzKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgeGRwX2J1ZmYgKnhk
cDsKPiArICAgICAgIHUzMiBsZW47Cj4gKwo+ICsgICAgICAgd2hpbGUgKG51bV9idWYtLSA+IDEp
IHsKPiArICAgICAgICAgICAgICAgeGRwID0gdmlydHF1ZXVlX2dldF9idWYocnEtPnZxLCAmbGVu
KTsKPiArICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCF4ZHApKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcHJfZGVidWcoIiVzOiByeCBlcnJvcjogJWQgYnVmZmVycyBtaXNzaW5nXG4i
LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+bmFtZSwgbnVtX2J1Zik7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAgICAgICAgICAgIH0KPiAr
ICAgICAgICAgICAgICAgc3RhdHMtPmJ5dGVzICs9IGxlbjsKPiArICAgICAgICAgICAgICAgeHNr
X2J1ZmZfZnJlZSh4ZHApOwo+ICsgICAgICAgfQo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHNr
X2J1ZmYgKmNvbnN0cnVjdF9za2Ioc3RydWN0IHZpcnRuZXRfcnEgKnJxLAo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkKPiArewo+ICsg
ICAgICAgdW5zaWduZWQgaW50IG1ldGFzaXplID0geGRwLT5kYXRhIC0geGRwLT5kYXRhX21ldGE7
Cj4gKyAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwo+ICsgICAgICAgdW5zaWduZWQgaW50IHNp
emU7Cj4gKwo+ICsgICAgICAgc2l6ZSA9IHhkcC0+ZGF0YV9lbmQgLSB4ZHAtPmRhdGFfaGFyZF9z
dGFydDsKPiArICAgICAgIHNrYiA9IG5hcGlfYWxsb2Nfc2tiKCZycS0+bmFwaSwgc2l6ZSk7Cj4g
KyAgICAgICBpZiAodW5saWtlbHkoIXNrYikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxM
Owo+ICsKPiArICAgICAgIHNrYl9yZXNlcnZlKHNrYiwgeGRwLT5kYXRhX21ldGEgLSB4ZHAtPmRh
dGFfaGFyZF9zdGFydCk7Cj4gKwo+ICsgICAgICAgc2l6ZSA9IHhkcC0+ZGF0YV9lbmQgLSB4ZHAt
PmRhdGFfbWV0YTsKPiArICAgICAgIG1lbWNweShfX3NrYl9wdXQoc2tiLCBzaXplKSwgeGRwLT5k
YXRhX21ldGEsIHNpemUpOwo+ICsKPiArICAgICAgIGlmIChtZXRhc2l6ZSkgewo+ICsgICAgICAg
ICAgICAgICBfX3NrYl9wdWxsKHNrYiwgbWV0YXNpemUpOwo+ICsgICAgICAgICAgICAgICBza2Jf
bWV0YWRhdGFfc2V0KHNrYiwgbWV0YXNpemUpOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHJl
dHVybiBza2I7Cj4gK30KPiArCj4gK3N0cnVjdCBza19idWZmICp2aXJ0bmV0X3JlY2VpdmVfeHNr
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3JxICpycSwgdm9p
ZCAqYnVmLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCBsZW4sIHVuc2lnbmVkIGludCAqeGRwX3htaXQsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHZpcnRuZXRfcnFfc3RhdHMgKnN0YXRzKQo+ICt7CgpJIHdvbmRl
ciBpZiBhbnl0aGluZyBibG9ja3MgdXMgZnJvbSByZXVzaW5nIHRoZSBleGlzdGluZyBYRFAgbG9n
aWM/CkFyZSB0aGVyZSBzb21lIHN1YnRsZSBkaWZmZXJlbmNlcz8KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
