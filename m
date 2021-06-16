Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD5C48BDF
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 02:45:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7576A61369
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 02:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7576A61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C513608E2;
	Wed, 16 Jun 2021 02:45:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktDP7A29VcP8; Wed, 16 Jun 2021 02:45:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBE00608D8;
	Wed, 16 Jun 2021 02:45:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70E78C000D;
	Wed, 16 Jun 2021 02:45:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57828C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31B048343F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8B-Ug4sBgFOW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:45:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77A2183B1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 02:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623811552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cREO+84GhaG5TSQl9UHRbi28vd29E0zqu5N4+PU4txo=;
 b=Hf3zwnkNSqNDexTah4Mjw1p5kM3WoQs5V5IBh5SfqioCHM4/6yGwHiW9hNvlQRdIlbE/+z
 MyKXZ2vQfheRZoBkjeRbsgyt4ps/gDAAbnTTLUvjJ2xRBCb9jgSm2ClkWIN+Dk/zCU0Grh
 PUHjXOr2ncqJ3EgxAwYCCkVV6zz33xA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-Ow0HcNpIMD6xK61mSpHCvg-1; Tue, 15 Jun 2021 22:45:50 -0400
X-MC-Unique: Ow0HcNpIMD6xK61mSpHCvg-1
Received: by mail-pf1-f198.google.com with SMTP id
 p17-20020a056a000b51b02902f9e70d70ecso708897pfo.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 19:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cREO+84GhaG5TSQl9UHRbi28vd29E0zqu5N4+PU4txo=;
 b=LISIl9sykkdvd/6ysnPemAsgH4s7iGTYIovTtrWtK+dD1Cc1XBsYNrEmkx0wgDScJz
 Zwh05fwfJYGuOnfg3AzH+PjkiK05X3HdNKOKfvIC+XahnhmVAXcRhNfKoJYp6KlS/GAt
 XAepdU6cEke6j9PesgcDyWKWqnPFbHmGOTmw3DXKvqomy3eL0MB/hyOqyvt1VfX/CZqE
 8vqtjkpu0wblm3PoHjQ6cJYA3mJ4HkFvAbByFLzbE2E1TxpNp3ENKf84k6EeFqcYI7s+
 /soJOvZx+Vx7PROOyBl5zxERfA8vhAB1C9fNgiIryGr7WSC7bitH6I+aEqkU7+oPLdVA
 BhCQ==
X-Gm-Message-State: AOAM5310UWHB2218m5Gz1+WH4MsWkUcU9OWesulhDEuCd39OwqH6oJ+C
 x4+dWyAuzD/6hGogXTYaEnOW4YF41Pmq2ZhUIniQKIXIVzgWuTQKLxDqIeOXnjbhZYy9t4U0Gvd
 ShJiZxrPBPdeqcoH5khIiJRp0/dejOQXCtBaLqcf3yA==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr1758116pgs.230.1623811549293; 
 Tue, 15 Jun 2021 19:45:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl4zILdzduWVKN6947QbWSl9bXWj464tsCNzVX/0FMV9w3qxQCTNGemvzXREXrtn0nT4bUoQ==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr1758088pgs.230.1623811548826; 
 Tue, 15 Jun 2021 19:45:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id em22sm4056653pjb.27.2021.06.15.19.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 19:45:48 -0700 (PDT)
Subject: Re: [PATCH net-next v5 07/15] virtio-net: standalone
 virtnet_aloc_frag function
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8da41980-e306-c0ae-03e2-83c20e2e84f0@redhat.com>
Date: Wed, 16 Jun 2021 10:45:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-8-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gVGhpcyBsb2dpYyBpcyB1
c2VkIGJ5IHNtYWxsIGFuZCBtZXJnZSB3aGVuIGFkZGluZyBidWYsIGFuZCB0aGUKPiBzdWJzZXF1
ZW50IHBhdGNoIHdpbGwgYWxzbyB1c2UgdGhpcyBsb2dpYywgc28gaXQgaXMgc2VwYXJhdGVkIGFz
IGFuCj4gaW5kZXBlbmRlbnQgZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNp
b3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwg
MjkgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4IGQ3OTE1NDNh
OGRkOC4uM2ZkODdiZjJiMmFkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0yNjQsNiArMjY0LDIyIEBA
IHN0YXRpYyBzdHJ1Y3QgeGRwX2ZyYW1lICpwdHJfdG9feGRwKHZvaWQgKnB0cikKPiAgIAlyZXR1
cm4gKHN0cnVjdCB4ZHBfZnJhbWUgKikoKHVuc2lnbmVkIGxvbmcpcHRyICYgflZJUlRJT19YRFBf
RkxBRyk7Cj4gICB9Cj4gICAKPiArc3RhdGljIGNoYXIgKnZpcnRuZXRfYWxsb2NfZnJhZyhzdHJ1
Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsIHVuc2lnbmVkIGludCBsZW4sCj4gKwkJCQlpbnQgZ2ZwKQo+
ICt7Cj4gKwlzdHJ1Y3QgcGFnZV9mcmFnICphbGxvY19mcmFnID0gJnJxLT5hbGxvY19mcmFnOwo+
ICsJY2hhciAqYnVmOwo+ICsKPiArCWlmICh1bmxpa2VseSghc2tiX3BhZ2VfZnJhZ19yZWZpbGwo
bGVuLCBhbGxvY19mcmFnLCBnZnApKSkKPiArCQlyZXR1cm4gTlVMTDsKPiArCj4gKwlidWYgPSAo
Y2hhciAqKXBhZ2VfYWRkcmVzcyhhbGxvY19mcmFnLT5wYWdlKSArIGFsbG9jX2ZyYWctPm9mZnNl
dDsKPiArCWdldF9wYWdlKGFsbG9jX2ZyYWctPnBhZ2UpOwo+ICsJYWxsb2NfZnJhZy0+b2Zmc2V0
ICs9IGxlbjsKPiArCj4gKwlyZXR1cm4gYnVmOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQgX19m
cmVlX29sZF94bWl0KHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgYm9vbCBpbl9uYXBpLAo+ICAgCQkJ
ICAgIHN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzICpzdGF0cykKPiAgIHsKPiBAQCAtMTE5MCw3ICsx
MjA2LDYgQEAgc3RhdGljIHZvaWQgcmVjZWl2ZV9idWYoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmks
IHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiAgIHN0YXRpYyBpbnQgYWRkX3JlY3ZidWZfc21h
bGwoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiAg
IAkJCSAgICAgZ2ZwX3QgZ2ZwKQo+ICAgewo+IC0Jc3RydWN0IHBhZ2VfZnJhZyAqYWxsb2NfZnJh
ZyA9ICZycS0+YWxsb2NfZnJhZzsKPiAgIAljaGFyICpidWY7Cj4gICAJdW5zaWduZWQgaW50IHhk
cF9oZWFkcm9vbSA9IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHZpKTsKPiAgIAl2b2lkICpjdHggPSAo
dm9pZCAqKSh1bnNpZ25lZCBsb25nKXhkcF9oZWFkcm9vbTsKPiBAQCAtMTE5OSwxMiArMTIxNCwx
MCBAQCBzdGF0aWMgaW50IGFkZF9yZWN2YnVmX3NtYWxsKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZp
LCBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gICAKPiAgIAlsZW4gPSBTS0JfREFUQV9BTElH
TihsZW4pICsKPiAgIAkgICAgICBTS0JfREFUQV9BTElHTihzaXplb2Yoc3RydWN0IHNrYl9zaGFy
ZWRfaW5mbykpOwo+IC0JaWYgKHVubGlrZWx5KCFza2JfcGFnZV9mcmFnX3JlZmlsbChsZW4sIGFs
bG9jX2ZyYWcsIGdmcCkpKQo+ICsJYnVmID0gdmlydG5ldF9hbGxvY19mcmFnKHJxLCBsZW4sIGdm
cCk7Cj4gKwlpZiAodW5saWtlbHkoIWJ1ZikpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4g
LQlidWYgPSAoY2hhciAqKXBhZ2VfYWRkcmVzcyhhbGxvY19mcmFnLT5wYWdlKSArIGFsbG9jX2Zy
YWctPm9mZnNldDsKPiAtCWdldF9wYWdlKGFsbG9jX2ZyYWctPnBhZ2UpOwo+IC0JYWxsb2NfZnJh
Zy0+b2Zmc2V0ICs9IGxlbjsKPiAgIAlzZ19pbml0X29uZShycS0+c2csIGJ1ZiArIFZJUlRORVRf
UlhfUEFEICsgeGRwX2hlYWRyb29tLAo+ICAgCQkgICAgdmktPmhkcl9sZW4gKyBHT09EX1BBQ0tF
VF9MRU4pOwo+ICAgCWVyciA9IHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KHJxLT52cSwgcnEtPnNn
LCAxLCBidWYsIGN0eCwgZ2ZwKTsKPiBAQCAtMTI5NSwxMyArMTMwOCwxMSBAQCBzdGF0aWMgaW50
IGFkZF9yZWN2YnVmX21lcmdlYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAkgKiBk
aXNhYmxlZCBHU08gZm9yIFhEUCwgaXQgd29uJ3QgYmUgYSBiaWcgaXNzdWUuCj4gICAJICovCj4g
ICAJbGVuID0gZ2V0X21lcmdlYWJsZV9idWZfbGVuKHJxLCAmcnEtPm1yZ19hdmdfcGt0X2xlbiwg
cm9vbSk7Cj4gLQlpZiAodW5saWtlbHkoIXNrYl9wYWdlX2ZyYWdfcmVmaWxsKGxlbiArIHJvb20s
IGFsbG9jX2ZyYWcsIGdmcCkpKQo+ICsJYnVmID0gdmlydG5ldF9hbGxvY19mcmFnKHJxLCBsZW4g
KyByb29tLCBnZnApOwo+ICsJaWYgKHVubGlrZWx5KCFidWYpKQo+ICAgCQlyZXR1cm4gLUVOT01F
TTsKPiAgIAo+IC0JYnVmID0gKGNoYXIgKilwYWdlX2FkZHJlc3MoYWxsb2NfZnJhZy0+cGFnZSkg
KyBhbGxvY19mcmFnLT5vZmZzZXQ7Cj4gICAJYnVmICs9IGhlYWRyb29tOyAvKiBhZHZhbmNlIGFk
ZHJlc3MgbGVhdmluZyBob2xlIGF0IGZyb250IG9mIHBrdCAqLwo+IC0JZ2V0X3BhZ2UoYWxsb2Nf
ZnJhZy0+cGFnZSk7Cj4gLQlhbGxvY19mcmFnLT5vZmZzZXQgKz0gbGVuICsgcm9vbTsKPiAgIAlo
b2xlID0gYWxsb2NfZnJhZy0+c2l6ZSAtIGFsbG9jX2ZyYWctPm9mZnNldDsKPiAgIAlpZiAoaG9s
ZSA8IGxlbiArIHJvb20pIHsKPiAgIAkJLyogVG8gYXZvaWQgaW50ZXJuYWwgZnJhZ21lbnRhdGlv
biwgaWYgdGhlcmUgaXMgdmVyeSBsaWtlbHkgbm90CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
