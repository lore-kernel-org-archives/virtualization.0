Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FBBC77B73
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 03:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BDA760B45;
	Wed, 26 Apr 2023 03:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BDA760B45
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RU5FJUV9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H69N1i8DzeM2; Wed, 26 Apr 2023 03:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF57060A8C;
	Wed, 26 Apr 2023 03:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF57060A8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A37A0C0036;
	Wed, 26 Apr 2023 03:09:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 556DCC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2323B813CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2323B813CA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RU5FJUV9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkjLdkOcTHYx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:09:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D939813BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D939813BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682478552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yC58K9sqZSRjBF39DoGELeoNDDbSNW/7to9J6fPLARI=;
 b=RU5FJUV9fTRCzZrfIXGGaQs+XvmsM5JMIguL3AJsUI++Eh8LVrjCQ8MiwzKGsKAlue+fbL
 7fgZvJ2DF/gzhnxpQKiDgCLzFgqO5R8q8eVWgt6UnYvdffWqeU3ihwXr15JRSXDAc7rxNB
 kKQDLwek/z0KtOXpulXUNx8y3Whob1k=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-tzBj648xMnK7ko9ywR2euQ-1; Tue, 25 Apr 2023 23:09:04 -0400
X-MC-Unique: tzBj648xMnK7ko9ywR2euQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f002e0e590so396381e87.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682478543; x=1685070543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yC58K9sqZSRjBF39DoGELeoNDDbSNW/7to9J6fPLARI=;
 b=TJMzZYHyTN7sOrr+iqfHgDlSC+kzh9bgLMq3IimsFLXEO+uKXwDOnJVafFp4IIYER6
 4FgvvWgxPiR/MmAoUUJhPkY+p5gf5DOeiU196vYOeCVayyi40/qwg9OVM67CDcPdnT20
 VmiqBubOAoh4azjikI5Wig4GgCurnv/DmJgCpMsoIMdN6iEQqD/AX+Hh3CS+Yj7PKdwK
 jBEXmk1U0/kzkCl7SL+wGx5LvF673iEgFYS31HJMvE/7w6ouTSmdQlDVSoI+cIgWVCYF
 +lin8uq7BYISk3/VD8NFpwvpsa9KsSuAXLNmT3mlhwS3r8NiGK95CzPEruy16Hw7lyUe
 s7Sg==
X-Gm-Message-State: AAQBX9diYlXK1YgdO478h/du1YtfDwFfTySsaaFyZ1FAe+hZmv/I2ZLI
 +cAtcqBn56eNuxc3HQuHXsBrOY3+9EVRG6fwrxZjcEynQvpjRG18MB+0JWXlX1mFPU58cbNS5/Q
 XucLix80cIzsyuQS+uJeHuEFkP63avtr4OXk2ixKPftr71n/ckrnU1oCfpg==
X-Received: by 2002:ac2:547b:0:b0:4ea:f6d7:2293 with SMTP id
 e27-20020ac2547b000000b004eaf6d72293mr5058732lfn.55.1682478543474; 
 Tue, 25 Apr 2023 20:09:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YLKXQgMI4TomiMy24A9d3HGABaVrLz6kQAc86xRDvq09NKcWSpfa35XnVK8ze1llkooOmFmnatlEV6y1zF/Y8=
X-Received: by 2002:ac2:547b:0:b0:4ea:f6d7:2293 with SMTP id
 e27-20020ac2547b000000b004eaf6d72293mr5058718lfn.55.1682478543190; Tue, 25
 Apr 2023 20:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-13-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230423105736.56918-13-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Apr 2023 11:08:52 +0800
Message-ID: <CACGkMEtC8WECH054KRs-uPeZiCv_PMUX4++9eUNffrB0Pboycw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 12/15] virtio_net: small: optimize code
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNjo1OOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gQXZvaWQgdGhlIHByb2JsZW0gdGhhdCBzb21lIHZh
cmlhYmxlcyhoZWFkcm9vbSBhbmQgc28gb24pIHdpbGwgcmVwZWF0Cj4gdGhlIGNhbGN1bGF0aW9u
IHdoZW4gcHJvY2VzcyB4ZHAuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVv
QGxpbnV4LmFsaWJhYmEuY29tPgoKTml0OiBJIHRoaW5rIHdlIG5lZWQgdG8gdHdlYWsgdGhlIHRp
dGxlLCBpdCdzIGJldHRlciB0byBzYXkgd2hhdCBpcwpvcHRpbWl6ZWQuIChBbmQgaXQgd291bGQg
YmUgYmV0dGVyIHRvIHR3ZWFrIHRoZSB0aXRsZSBvZiBwYXRjaCAxMSBhcwp3ZWxsKQoKQWNrZWQt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgfCAxMiArKysrKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA1YmMzZGNhMGY2
MGMuLjYwMWMwZTdmYzMyYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTAzMSwxMSArMTAzMSwxMCBA
QCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfc21hbGwoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiAgICAgICAgIHN0cnVjdCBza19idWZmICpza2I7Cj4gICAgICAgICBzdHJ1Y3QgYnBm
X3Byb2cgKnhkcF9wcm9nOwo+ICAgICAgICAgdW5zaWduZWQgaW50IHhkcF9oZWFkcm9vbSA9ICh1
bnNpZ25lZCBsb25nKWN0eDsKPiAtICAgICAgIHVuc2lnbmVkIGludCBoZWFkZXJfb2Zmc2V0ID0g
VklSVE5FVF9SWF9QQUQgKyB4ZHBfaGVhZHJvb207Cj4gLSAgICAgICB1bnNpZ25lZCBpbnQgaGVh
ZHJvb20gPSB2aS0+aGRyX2xlbiArIGhlYWRlcl9vZmZzZXQ7Cj4gLSAgICAgICB1bnNpZ25lZCBp
bnQgYnVmbGVuID0gU0tCX0RBVEFfQUxJR04oR09PRF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsK
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTS0JfREFUQV9BTElHTihzaXplb2Yoc3Ry
dWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+ICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSB2aXJ0
X3RvX2hlYWRfcGFnZShidWYpOwo+ICsgICAgICAgdW5zaWduZWQgaW50IGhlYWRlcl9vZmZzZXQ7
Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgaGVhZHJvb207Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQg
YnVmbGVuOwo+Cj4gICAgICAgICBsZW4gLT0gdmktPmhkcl9sZW47Cj4gICAgICAgICBzdGF0cy0+
Ynl0ZXMgKz0gbGVuOwo+IEBAIC0xMDYzLDYgKzEwNjIsMTEgQEAgc3RhdGljIHN0cnVjdCBza19i
dWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICByY3Vf
cmVhZF91bmxvY2soKTsKPgo+ICBza2lwX3hkcDoKPiArICAgICAgIGhlYWRlcl9vZmZzZXQgPSBW
SVJUTkVUX1JYX1BBRCArIHhkcF9oZWFkcm9vbTsKPiArICAgICAgIGhlYWRyb29tID0gdmktPmhk
cl9sZW4gKyBoZWFkZXJfb2Zmc2V0Owo+ICsgICAgICAgYnVmbGVuID0gU0tCX0RBVEFfQUxJR04o
R09PRF9QQUNLRVRfTEVOICsgaGVhZHJvb20pICsKPiArICAgICAgICAgICAgICAgU0tCX0RBVEFf
QUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiArCj4gICAgICAgICBza2Ig
PSBidWlsZF9za2IoYnVmLCBidWZsZW4pOwo+ICAgICAgICAgaWYgKCFza2IpCj4gICAgICAgICAg
ICAgICAgIGdvdG8gZXJyOwo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
