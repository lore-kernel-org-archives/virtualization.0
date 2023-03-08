Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA56C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 05:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8529D81452;
	Wed,  8 Mar 2023 05:20:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8529D81452
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DNAP6pxl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RUbRQC1F44CT; Wed,  8 Mar 2023 05:20:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1587F8143A;
	Wed,  8 Mar 2023 05:20:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1587F8143A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE017C0035;
	Wed,  8 Mar 2023 05:20:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B510CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A08640B87
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A08640B87
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DNAP6pxl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i799mvc9ADxQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A702400B9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A702400B9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 05:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678252828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5GGVFABESW8V/hPXxolD/QL4B7cjVpVheaDk83W/kE=;
 b=DNAP6pxlFIVkx9LC0/K3o7TZrM+gv6LRmNfUDK6v732ljpuzRKh+mAWuHo1tAppNbulO9u
 O8IfPxY4nXw7PHT23s2IEDRZqJSwhoY1sXxUkFYg7h2u+x2JL5j/d+HeniDFsF/daiQzzm
 wd7NsGwS4GmAMD8fgSa5DP6DXT7iWzk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-uVoVUqJYN3K_K0Pod796Wg-1; Wed, 08 Mar 2023 00:20:27 -0500
X-MC-Unique: uVoVUqJYN3K_K0Pod796Wg-1
Received: by mail-oo1-f70.google.com with SMTP id
 c9-20020a4a4f09000000b005178610a793so4786858oob.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 21:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678252827;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5GGVFABESW8V/hPXxolD/QL4B7cjVpVheaDk83W/kE=;
 b=TVlNoJHxheQr+LD9frEMEoZwX9RSNVITi4sG9hpF4NVL875s74Q+HaJ2JHURr4nUoi
 ABXRpjANKlo+RW6wU4AyLniFngWPcMTzgNaOtgPrO11OEvYOj6H3yvXXLlq+u4MAA3xS
 NFbJYojH7AxpaFdc0aN4ZSVKZm+KsiU0xZ2p86Q/aBmMhRy9JaGX60CNpkj+QEHPBGIl
 ntjmAR/63I6F+PBgkZNOmwfTwWBBOWIF3/0UKjvYa8rl7yLXBjttXo0CklVifEwtuOt4
 w6XpCVfKXE2iNEYpJvQbclxRFgEdwiXLEV3S3ogqcC8wAhcUrMO6hBDDHlk8V149SjQD
 dwSQ==
X-Gm-Message-State: AO0yUKWUqRIkxC8kbVZtv0JKS3rExkBBeAahcMpdL+Dv/hvhPVl40//X
 wzj5HNWFh09BGEaK3lupYU7nZXYYmi3ffxWK8b+IGNqlcI7E0AG+HpCvbpmaqrkZsjOiU5hNn5/
 EjvGxdqfQpMPG8yfd9iaEitPhTPNfqT7NZEAlqEoNJeBVS7Hjk5m7rZBiag==
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id
 l2-20020a544102000000b0037fab56ff42mr5661469oic.9.1678252826915; 
 Tue, 07 Mar 2023 21:20:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/WmF3rrnuaCT+mrkYDjoeqmr/WPCyXrpNTYNmxVQ7YSnB5l9thIGvO471/Qfv+ZuKpJRfF0rFXbg/UZX05cmI=
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id
 l2-20020a544102000000b0037fab56ff42mr5661453oic.9.1678252826693; Tue, 07 Mar
 2023 21:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Mar 2023 13:20:15 +0800
Message-ID: <CACGkMEsp+2GhUO9cXHuet4AAhV-CdDrScUJdvbEcAoxacdBLzw@mail.gmail.com>
Subject: Re: [PATCH net, stable v1 1/3] virtio_net: reorder some funcs
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAxMDo0OeKAr0FNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBpcyB0byBmYWNp
bGl0YXRlIHRoZSBzdWJzZXF1ZW50IGFkZGl0aW9uIG9mIG5ldwo+IGZ1bmN0aW9ucyB3aXRob3V0
IGludHJvZHVjaW5nIGEgc2VwYXJhdGUgZGVjbGFyYXRpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKTm90IHN1cmUgc3VjaCByZW9y
ZGVyaW5nIGlzIHN1aXRhYmxlIGZvciAtc3RhYmxlLgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgfCA5MiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA0NiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiBpbmRleCBmYjVlNjhlZDNlYzIuLjhiMzFhMDQwNTJmMiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBAQCAtNTQ1LDYgKzU0NSw1MiBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBh
Z2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAgcmV0dXJuIHNrYjsK
PiAgfQo+Cj4gK3N0YXRpYyB2b2lkIGZyZWVfb2xkX3htaXRfc2ticyhzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EsIGJvb2wgaW5fbmFwaSkKPiArewo+ICsgICAgICAgdW5zaWduZWQgaW50IGxlbjsKPiAr
ICAgICAgIHVuc2lnbmVkIGludCBwYWNrZXRzID0gMDsKPiArICAgICAgIHVuc2lnbmVkIGludCBi
eXRlcyA9IDA7Cj4gKyAgICAgICB2b2lkICpwdHI7Cj4gKwo+ICsgICAgICAgd2hpbGUgKChwdHIg
PSB2aXJ0cXVldWVfZ2V0X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBOVUxMKSB7Cj4gKyAgICAgICAg
ICAgICAgIGlmIChsaWtlbHkoIWlzX3hkcF9mcmFtZShwdHIpKSkgewo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IgPSBwdHI7Cj4gKwo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHByX2RlYnVnKCJTZW50IHNrYiAlcFxuIiwgc2tiKTsKPiArCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgYnl0ZXMgKz0gc2tiLT5sZW47Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgbmFwaV9jb25zdW1lX3NrYihza2IsIGluX25hcGkpOwo+ICsgICAgICAgICAgICAgICB9IGVs
c2Ugewo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB4ZHBfZnJhbWUgKmZyYW1lID0g
cHRyX3RvX3hkcChwdHIpOwo+ICsKPiArICAgICAgICAgICAgICAgICAgICAgICBieXRlcyArPSB4
ZHBfZ2V0X2ZyYW1lX2xlbihmcmFtZSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgeGRwX3Jl
dHVybl9mcmFtZShmcmFtZSk7Cj4gKyAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAg
cGFja2V0cysrOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIC8qIEF2b2lkIG92ZXJoZWFkIHdo
ZW4gbm8gcGFja2V0cyBoYXZlIGJlZW4gcHJvY2Vzc2VkCj4gKyAgICAgICAgKiBoYXBwZW5zIHdo
ZW4gY2FsbGVkIHNwZWN1bGF0aXZlbHkgZnJvbSBzdGFydF94bWl0Lgo+ICsgICAgICAgICovCj4g
KyAgICAgICBpZiAoIXBhY2tldHMpCj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiArCj4gKyAg
ICAgICB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKCZzcS0+c3RhdHMuc3luY3ApOwo+ICsgICAgICAg
c3EtPnN0YXRzLmJ5dGVzICs9IGJ5dGVzOwo+ICsgICAgICAgc3EtPnN0YXRzLnBhY2tldHMgKz0g
cGFja2V0czsKPiArICAgICAgIHU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3luY3Ap
Owo+ICt9Cj4gKwo+ICtzdGF0aWMgYm9vbCBpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZShzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSwgaW50IHEpCj4gK3sKPiArICAgICAgIGlmIChxIDwgKHZpLT5jdXJy
X3F1ZXVlX3BhaXJzIC0gdmktPnhkcF9xdWV1ZV9wYWlycykpCj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsKPiArICAgICAgIGVsc2UgaWYgKHEgPCB2aS0+Y3Vycl9xdWV1ZV9wYWlycykK
PiArICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsKPiArfQo+ICsKPiAgc3RhdGljIGludCBfX3ZpcnRuZXRfeGRw
X3htaXRfb25lKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHNlbmRfcXVldWUgKnNxLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHhkcF9mcmFtZSAqeGRwZikKPiBAQCAtMTcxNCw1MiAr
MTc2MCw2IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZWNlaXZlKHN0cnVjdCByZWNlaXZlX3F1ZXVl
ICpycSwgaW50IGJ1ZGdldCwKPiAgICAgICAgIHJldHVybiBzdGF0cy5wYWNrZXRzOwo+ICB9Cj4K
PiAtc3RhdGljIHZvaWQgZnJlZV9vbGRfeG1pdF9za2JzKHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwg
Ym9vbCBpbl9uYXBpKQo+IC17Cj4gLSAgICAgICB1bnNpZ25lZCBpbnQgbGVuOwo+IC0gICAgICAg
dW5zaWduZWQgaW50IHBhY2tldHMgPSAwOwo+IC0gICAgICAgdW5zaWduZWQgaW50IGJ5dGVzID0g
MDsKPiAtICAgICAgIHZvaWQgKnB0cjsKPiAtCj4gLSAgICAgICB3aGlsZSAoKHB0ciA9IHZpcnRx
dWV1ZV9nZXRfYnVmKHNxLT52cSwgJmxlbikpICE9IE5VTEwpIHsKPiAtICAgICAgICAgICAgICAg
aWYgKGxpa2VseSghaXNfeGRwX2ZyYW1lKHB0cikpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHB0cjsKPiAtCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgcHJfZGVidWcoIlNlbnQgc2tiICVwXG4iLCBza2IpOwo+IC0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBieXRlcyArPSBza2ItPmxlbjsKPiAtICAgICAgICAgICAgICAgICAgICAgICBuYXBp
X2NvbnN1bWVfc2tiKHNrYiwgaW5fbmFwaSk7Cj4gLSAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4g
LSAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHhkcF9mcmFtZSAqZnJhbWUgPSBwdHJfdG9f
eGRwKHB0cik7Cj4gLQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGJ5dGVzICs9IHhkcF9nZXRf
ZnJhbWVfbGVuKGZyYW1lKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2Zy
YW1lKGZyYW1lKTsKPiAtICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBwYWNrZXRz
Kys7Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgLyogQXZvaWQgb3ZlcmhlYWQgd2hlbiBubyBw
YWNrZXRzIGhhdmUgYmVlbiBwcm9jZXNzZWQKPiAtICAgICAgICAqIGhhcHBlbnMgd2hlbiBjYWxs
ZWQgc3BlY3VsYXRpdmVseSBmcm9tIHN0YXJ0X3htaXQuCj4gLSAgICAgICAgKi8KPiAtICAgICAg
IGlmICghcGFja2V0cykKPiAtICAgICAgICAgICAgICAgcmV0dXJuOwo+IC0KPiAtICAgICAgIHU2
NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4gLSAgICAgICBzcS0+c3Rh
dHMuYnl0ZXMgKz0gYnl0ZXM7Cj4gLSAgICAgICBzcS0+c3RhdHMucGFja2V0cyArPSBwYWNrZXRz
Owo+IC0gICAgICAgdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNxLT5zdGF0cy5zeW5jcCk7Cj4gLX0K
PiAtCj4gLXN0YXRpYyBib29sIGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpLCBpbnQgcSkKPiAtewo+IC0gICAgICAgaWYgKHEgPCAodmktPmN1cnJfcXVldWVf
cGFpcnMgLSB2aS0+eGRwX3F1ZXVlX3BhaXJzKSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIGZh
bHNlOwo+IC0gICAgICAgZWxzZSBpZiAocSA8IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+IC0gICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsKPiAtICAgICAgIGVsc2UKPiAtICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOwo+IC19Cj4gLQo+ICBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50
eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEpCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpID0gcnEtPnZxLT52ZGV2LT5wcml2Owo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5
Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
