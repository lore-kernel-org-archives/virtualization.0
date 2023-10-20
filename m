Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A2CDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64539847A9;
	Fri, 20 Oct 2023 06:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64539847A9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwpIieMj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nXaL2Fdh5yd0; Fri, 20 Oct 2023 06:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B231E84467;
	Fri, 20 Oct 2023 06:57:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B231E84467
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 974C7C0071;
	Fri, 20 Oct 2023 06:57:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5B34C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74A55610EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74A55610EE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwpIieMj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OgXE16Szar-S
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B8B660ED7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B8B660ED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697785027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nuA0GPocUhVBXyHIV4VhNfFkda7gJjp7f9qx99UuIo=;
 b=TwpIieMjWUlJ+mc2hJMnke+vPs2w8pCfzh41YIi4GO2t+kAqhMOtctcnrkdcg6EQGYOpgl
 BGCat/plyQS6Ff5Q4rqU53dMta6XKcucE4ZadI7kueQSZDPnplIoeL5iDuY32939hirEyg
 silqWvy1aPzEPwhoWzRo8Qk0t/+lvEg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-M7qCBZrkOkap0eblE0wyXg-1; Fri, 20 Oct 2023 02:57:04 -0400
X-MC-Unique: M7qCBZrkOkap0eblE0wyXg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c4fe286a5dso4018751fa.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697785022; x=1698389822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nuA0GPocUhVBXyHIV4VhNfFkda7gJjp7f9qx99UuIo=;
 b=ig7jo18R8IT3U5xbXaKWnVYmeIS1hid6EQ++2eA+zWZYEPt9T3+B60KJJ/+SEggbkh
 oJnN5wUygBnhyDRHnq5kLTVCojrHkEXcjrPEIQ/xV5uZDqHpkxSNOTKRxElD9nt70anS
 e0pe1MB4dckGX3+m9qr4LL8rNDSqXDiPAW/j8NFOVZrCmxxhl0MCBj79o10YqwF8LSvI
 PcBtOtlKB5dTsrtQ7MRCLsvIztDgTiEcbueJfPt2h04QGkHtAdeXLFoqjViR5gyc+mBV
 867ZiHZYC+0QbnsU4tlhtLWKKfcBb5OUkBm4iSyuop51wXrhSEVixh9Ls/+wlLiVLx6o
 moeQ==
X-Gm-Message-State: AOJu0Yx+A33WUswIa/wTw9HtDJMxEfis1NnqpBrPftAHwa9KGPXMoNrr
 CYh97PoZSh01JjWY8Km2fhIDoeKFCRlzgZJhDzQFVgOBIyZQI3HV/rg2y3WJu3KoT/2XWCuICdZ
 r295dd5KQShba/CUYWj/lCTWZvJgv3jDX89c/5Z1qKgzOVjJuLTzO4EYcXA==
X-Received: by 2002:a05:651c:503:b0:2b9:f13b:6139 with SMTP id
 o3-20020a05651c050300b002b9f13b6139mr933649ljp.20.1697785022613; 
 Thu, 19 Oct 2023 23:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiS9CtJpivNcN/BC7UP8A2JRRyUTtrbDm5S2vFHS4NRmSoZ9el8dfhVRFAkG3XMCzSSNmBlUmLSOyOvq7pQQ=
X-Received: by 2002:a05:651c:503:b0:2b9:f13b:6139 with SMTP id
 o3-20020a05651c050300b002b9f13b6139mr933628ljp.20.1697785022253; Thu, 19 Oct
 2023 23:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-16-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-16-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:56:51 +0800
Message-ID: <CACGkMEvmtUp4NxqiDVD3w5eDi5T4UYgnwYkGty+nfQS9h-bsuA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 15/19] virtio_net: xsk: rx: introduce
 add_recvbuf_xsk()
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
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSW1wbGVtZW50IHRoZSBsb2dpYyBvZiBmaWxsaW5n
IHZxIHdpdGggWFNLIGJ1ZmZlci4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMg
ICAgICAgfCAxMyArKysrKysrCj4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmggfCAg
NSArKysKPiAgZHJpdmVycy9uZXQvdmlydGlvL3hzay5jICAgICAgICB8IDY2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAg
IHwgIDIgKwo+ICA0IGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvL21haW4uYwo+IGluZGV4IDU4YmIzOGY5YjQ1My4uMGU3NDA0NDdiMTQyIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW8vbWFpbi5jCj4gQEAgLTE3ODcsOSArMTc4NywyMCBAQCBzdGF0aWMgaW50IGFkZF9yZWN2
YnVmX21lcmdlYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgc3RhdGljIGJvb2wgdHJ5
X2ZpbGxfcmVjdihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJx
LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2ZwX3QgZ2ZwKQo+ICB7Cj4gKyAgICAgICBz
dHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbDsKPiAgICAgICAgIGludCBlcnI7Cj4gICAgICAgICBi
b29sIG9vbTsKPgo+ICsgICAgICAgcmN1X3JlYWRfbG9jaygpOwoKQSBxdWVzdGlvbiBoZXJlOiBz
aG91bGQgd2Ugc3luYyB3aXRoIHJlZmlsbCB3b3JrIGR1cmluZyByeF9wYXVzZT8KCj4gKyAgICAg
ICBwb29sID0gcmN1X2RlcmVmZXJlbmNlKHJxLT54c2sucG9vbCk7Cj4gKyAgICAgICBpZiAocG9v
bCkgewo+ICsgICAgICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X2FkZF9yZWN2YnVmX3hzayh2aSwg
cnEsIHBvb2wsIGdmcCk7Cj4gKyAgICAgICAgICAgICAgIG9vbSA9IGVyciA9PSAtRU5PTUVNOwo+
ICsgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiArICAgICAgICAgICAgICAgZ290
byBraWNrOwo+ICsgICAgICAgfQo+ICsgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7CgpBbmQgaWYg
d2Ugc3luY2hyb25pemUgd2l0aCB0aGF0IHRoZXJlJ3MgcHJvYmFibHkgbm8gbmVlZCBmb3IgdGhl
IHJjdQphbmQgd2UgY2FuIG1lcmdlIHRoZSBsb2dpYyB3aXRoIHRoZSBmb2xsb3dpbmcgb25lcz8K
ClRoYW5rcwoKCj4gKwo+ICAgICAgICAgZG8gewo+ICAgICAgICAgICAgICAgICBpZiAodmktPm1l
cmdlYWJsZV9yeF9idWZzKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVyciA9IGFkZF9yZWN2
YnVmX21lcmdlYWJsZSh2aSwgcnEsIGdmcCk7Cj4gQEAgLTE4MDIsNiArMTgxMyw4IEBAIHN0YXRp
YyBib29sIHRyeV9maWxsX3JlY3Yoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCB2aXJ0
bmV0X3JxICpycSwKPiAgICAgICAgICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsKPiAgICAgICAgIH0gd2hpbGUgKHJxLT52cS0+bnVtX2ZyZWUpOwo+ICsK
PiAra2ljazoKPiAgICAgICAgIGlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHJxLT52cSkgJiYg
dmlydHF1ZXVlX25vdGlmeShycS0+dnEpKSB7Cj4gICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgZmxhZ3M7Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQu
aCBiL2RyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmgKPiBpbmRleCBkNGU2MjBhMDg0ZjQu
LjZlNzE2MjJmY2E0NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25l
dC5oCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+IEBAIC0xNTYsNiAr
MTU2LDExIEBAIHN0cnVjdCB2aXJ0bmV0X3JxIHsKPgo+ICAgICAgICAgICAgICAgICAvKiB4ZHAg
cnhxIHVzZWQgYnkgeHNrICovCj4gICAgICAgICAgICAgICAgIHN0cnVjdCB4ZHBfcnhxX2luZm8g
eGRwX3J4cTsKPiArCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB4ZHBfYnVmZiAqKnhza19idWZm
czsKPiArICAgICAgICAgICAgICAgdTMyIG54dF9pZHg7Cj4gKyAgICAgICAgICAgICAgIHUzMiBu
dW07Cj4gKyAgICAgICAgICAgICAgIHUzMiBzaXplOwo+ICAgICAgICAgfSB4c2s7Cj4gIH07Cj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jIGIvZHJpdmVycy9uZXQvdmly
dGlvL3hzay5jCj4gaW5kZXggOTczZTc4MzI2MGMzLi44NDFmYjA3ODg4MmEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvL3hz
ay5jCj4gQEAgLTM3LDYgKzM3LDU4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfeHNrX2NoZWNrX3F1
ZXVlKHN0cnVjdCB2aXJ0bmV0X3NxICpzcSkKPiAgICAgICAgICAgICAgICAgbmV0aWZfc3RvcF9z
dWJxdWV1ZShkZXYsIHFudW0pOwo+ICB9Cj4KPiArc3RhdGljIGludCB2aXJ0bmV0X2FkZF9yZWN2
YnVmX2JhdGNoKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9ycSAqcnEs
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB4c2tfYnVmZl9w
b29sICpwb29sLCBnZnBfdCBnZnApCj4gK3sKPiArICAgICAgIHN0cnVjdCB4ZHBfYnVmZiAqKnhz
a19idWZmczsKPiArICAgICAgIGRtYV9hZGRyX3QgYWRkcjsKPiArICAgICAgIHUzMiBsZW4sIGk7
Cj4gKyAgICAgICBpbnQgZXJyID0gMDsKPiArCj4gKyAgICAgICB4c2tfYnVmZnMgPSBycS0+eHNr
Lnhza19idWZmczsKPiArCj4gKyAgICAgICBpZiAocnEtPnhzay5ueHRfaWR4ID49IHJxLT54c2su
bnVtKSB7Cj4gKyAgICAgICAgICAgICAgIHJxLT54c2subnVtID0geHNrX2J1ZmZfYWxsb2NfYmF0
Y2gocG9vbCwgeHNrX2J1ZmZzLCBycS0+eHNrLnNpemUpOwo+ICsgICAgICAgICAgICAgICBpZiAo
IXJxLT54c2subnVtKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+
ICsgICAgICAgICAgICAgICBycS0+eHNrLm54dF9pZHggPSAwOwo+ICsgICAgICAgfQo+ICsKPiAr
ICAgICAgIHdoaWxlIChycS0+eHNrLm54dF9pZHggPCBycS0+eHNrLm51bSkgewo+ICsgICAgICAg
ICAgICAgICBpID0gcnEtPnhzay5ueHRfaWR4Owo+ICsKPiArICAgICAgICAgICAgICAgLyogdXNl
IHRoZSBwYXJ0IG9mIFhEUF9QQUNLRVRfSEVBRFJPT00gYXMgdGhlIHZpcnRuZXQgaGRyIHNwYWNl
ICovCj4gKyAgICAgICAgICAgICAgIGFkZHIgPSB4c2tfYnVmZl94ZHBfZ2V0X2RtYSh4c2tfYnVm
ZnNbaV0pIC0gdmktPmhkcl9sZW47Cj4gKyAgICAgICAgICAgICAgIGxlbiA9IHhza19wb29sX2dl
dF9yeF9mcmFtZV9zaXplKHBvb2wpICsgdmktPmhkcl9sZW47Cj4gKwo+ICsgICAgICAgICAgICAg
ICBzZ19pbml0X3RhYmxlKHJxLT5zZywgMSk7Cj4gKyAgICAgICAgICAgICAgIHNnX2ZpbGxfZG1h
KHJxLT5zZywgYWRkciwgbGVuKTsKPiArCj4gKyAgICAgICAgICAgICAgIGVyciA9IHZpcnRxdWV1
ZV9hZGRfaW5idWYocnEtPnZxLCBycS0+c2csIDEsIHhza19idWZmc1tpXSwgZ2ZwKTsKPiArICAg
ICAgICAgICAgICAgaWYgKGVycikKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJy
Owo+ICsKPiArICAgICAgICAgICAgICAgcnEtPnhzay5ueHRfaWR4Kys7Cj4gKyAgICAgICB9Cj4g
Kwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gK2ludCB2aXJ0bmV0X2FkZF9yZWN2YnVm
X3hzayhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgc3RydWN0IHZpcnRuZXRfcnEgKnJxLAo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwgZ2Zw
X3QgZ2ZwKQo+ICt7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsKPiArICAgICAgIGRvIHsKPiArICAg
ICAgICAgICAgICAgZXJyID0gdmlydG5ldF9hZGRfcmVjdmJ1Zl9iYXRjaCh2aSwgcnEsIHBvb2ws
IGdmcCk7Cj4gKyAgICAgICAgICAgICAgIGlmIChlcnIpCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsKPiArCj4gKyAgICAgICB9IHdoaWxlIChycS0+dnEtPm51bV9mcmVlKTsK
PiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQo+ICsKPiAgc3RhdGljIGludCB2aXJ0bmV0X3hz
a194bWl0X29uZShzdHJ1Y3QgdmlydG5ldF9zcSAqc3EsCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCB4ZHBfZGVzYyAqZGVzYykKPiBAQCAtMjQ0LDcgKzI5Niw3
IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94c2tfcG9vbF9lbmFibGUoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxICpzcTsKPiAgICAgICAgIHN0cnVjdCBk
ZXZpY2UgKmRtYV9kZXY7Cj4gICAgICAgICBkbWFfYWRkcl90IGhkcl9kbWE7Cj4gLSAgICAgICBp
bnQgZXJyOwo+ICsgICAgICAgaW50IGVyciwgc2l6ZTsKPgo+ICAgICAgICAgLyogSW4gYmlnX3Bh
Y2tldHMgbW9kZSwgeGRwIGNhbm5vdCB3b3JrLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvCj4gICAg
ICAgICAgKiBpbml0aWFsaXplIHhzayBvZiBycS4KPiBAQCAtMjc2LDYgKzMyOCwxNiBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfeHNrX3Bvb2xfZW5hYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4g
ICAgICAgICBpZiAoIWRtYV9kZXYpCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRVBFUk07Cj4K
PiArICAgICAgIHNpemUgPSB2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUocnEtPnZxKTsKPiArCj4g
KyAgICAgICBycS0+eHNrLnhza19idWZmcyA9IGtjYWxsb2Moc2l6ZSwgc2l6ZW9mKCpycS0+eHNr
Lnhza19idWZmcyksIEdGUF9LRVJORUwpOwo+ICsgICAgICAgaWYgKCFycS0+eHNrLnhza19idWZm
cykKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gKwo+ICsgICAgICAgcnEtPnhz
ay5zaXplID0gc2l6ZTsKPiArICAgICAgIHJxLT54c2subnh0X2lkeCA9IDA7Cj4gKyAgICAgICBy
cS0+eHNrLm51bSA9IDA7Cj4gKwo+ICAgICAgICAgaGRyX2RtYSA9IGRtYV9tYXBfc2luZ2xlKGRt
YV9kZXYsICZ4c2tfaGRyLCB2aS0+aGRyX2xlbiwgRE1BX1RPX0RFVklDRSk7Cj4gICAgICAgICBp
ZiAoZG1hX21hcHBpbmdfZXJyb3IoZG1hX2RldiwgaGRyX2RtYSkpCj4gICAgICAgICAgICAgICAg
IHJldHVybiAtRU5PTUVNOwo+IEBAIC0zMzgsNiArNDAwLDggQEAgc3RhdGljIGludCB2aXJ0bmV0
X3hza19wb29sX2Rpc2FibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTE2IHFpZCkKPiAgICAg
ICAgIGVycjEgPSB2aXJ0bmV0X3NxX2JpbmRfeHNrX3Bvb2wodmksIHNxLCBOVUxMKTsKPiAgICAg
ICAgIGVycjIgPSB2aXJ0bmV0X3JxX2JpbmRfeHNrX3Bvb2wodmksIHJxLCBOVUxMKTsKPgo+ICsg
ICAgICAga2ZyZWUocnEtPnhzay54c2tfYnVmZnMpOwo+ICsKPiAgICAgICAgIHJldHVybiBlcnIx
IHwgZXJyMjsKPiAgfQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaCBi
L2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+IGluZGV4IDdlYmM5YmRhN2FlZS4uYmVmNDFhM2Y5
NTRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpby94c2suaAo+IEBAIC0yMyw0ICsyMyw2IEBAIGludCB2aXJ0bmV0X3hza19w
b29sX3NldHVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBuZXRkZXZfYnBmICp4ZHAp
Owo+ICBib29sIHZpcnRuZXRfeHNrX3htaXQoc3RydWN0IHZpcnRuZXRfc3EgKnNxLCBzdHJ1Y3Qg
eHNrX2J1ZmZfcG9vbCAqcG9vbCwKPiAgICAgICAgICAgICAgICAgICAgICAgaW50IGJ1ZGdldCk7
Cj4gIGludCB2aXJ0bmV0X3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgdTMyIHFp
ZCwgdTMyIGZsYWcpOwo+ICtpbnQgdmlydG5ldF9hZGRfcmVjdmJ1Zl94c2soc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksIHN0cnVjdCB2aXJ0bmV0X3JxICpycSwKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsIGdmcF90IGdmcCk7Cj4gICNlbmRp
Zgo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
