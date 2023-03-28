Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73FCC76195
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6279C40CA5;
	Tue, 28 Mar 2023 06:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6279C40CA5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jAla0jMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQesklGDS_3i; Tue, 28 Mar 2023 06:16:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BC8F24011C;
	Tue, 28 Mar 2023 06:16:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC8F24011C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 978F6C0036;
	Tue, 28 Mar 2023 06:16:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F218BC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA1D082152
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA1D082152
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jAla0jMA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mt3_IOhD8ESr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF7DC820EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF7DC820EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV9uJu2KI3hD8CYjUN/MQ/Xwbu81pu1qL65QXCWepDU=;
 b=jAla0jMACWdyf2P9avS17Z3LviA7t/yqT5MdknL/43yKyLwW2I4aMeS5g4mM7//dPxTR4G
 8F+LOoPtASXCEv89HfW4nDB9ZOKaal58u1Pue8QC6uj0NLPtkvUWLOYODbwmWztYhSo/JI
 0w9c7eTh9utzI7vbONesFWg3iYPCIho=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-1wTyb8ZfOb6e5jvrzwCHug-1; Tue, 28 Mar 2023 02:16:43 -0400
X-MC-Unique: 1wTyb8ZfOb6e5jvrzwCHug-1
Received: by mail-pj1-f70.google.com with SMTP id
 b8-20020a17090a488800b0023d1bf65c7eso2972282pjh.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VV9uJu2KI3hD8CYjUN/MQ/Xwbu81pu1qL65QXCWepDU=;
 b=pAN7k8m9eTpOGPogUIeHit5q3tFaT4iV99I13ADJcxBWRzuIsT3oeNJp4jGB9Vu+5+
 MP1Ghl2CZLqPKYjUs3gQUG2AXhboxZ61IgrjZpXqZipeioQ8qG8JX5HUeLabwPQZ8r+T
 t20Sa0UMerJxHqr6zcqFytD2WWBx30EwRddgNrpGDUOISXNeg++hFBPC1AA/2/BMNZYN
 gP4Omt0dj633htKUBu4XmZXY4/CInu6g662Jh5NKAIMwLugGEjR3qB9BWInOFUqcyHW7
 MVa5q/FY0JozXk7nWpShypRMEjtLG3OvMEzOpO42AgUdrHlqVDtRT+2at3+RZBmpf6l4
 SMgA==
X-Gm-Message-State: AO0yUKVr8YW+El6Ib8U17Yd640Tj33HbAmIApHRpuRrrAq5r/qahTMWp
 UVc9qv9yXRbZ0q4YwVCyyFCSiNsMfB/WdBTxprEFIHgG33tlfkwWFI9GlDfbRaduBy81InIrbfa
 gYiGqFQrDAsfRDh1faT1OkKz+5IEXeRDzZN71nkYu4w==
X-Received: by 2002:a05:6a20:1e4d:b0:da:f525:e629 with SMTP id
 cy13-20020a056a201e4d00b000daf525e629mr12863213pzb.53.1679984202045; 
 Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set/efblHnzPk4S+gdRl49tiuIAxoct8gxx5y8dUbFOdmQzmBPiWT7BlXrrzv0YYYKFpZSQHLpg==
X-Received: by 2002:a05:6a20:1e4d:b0:da:f525:e629 with SMTP id
 cy13-20020a056a201e4d00b000daf525e629mr12863199pzb.53.1679984201770; 
 Mon, 27 Mar 2023 23:16:41 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d6-20020aa78146000000b0062d945e416esm1369900pfn.160.2023.03.27.23.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:16:41 -0700 (PDT)
Message-ID: <d3ad99a2-1e0a-5953-5303-37be0f2f02b6@redhat.com>
Date: Tue, 28 Mar 2023 14:16:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 07/11] vduse: Add sysfs interface for irq callback
 affinity
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-8-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-8-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzMvMjMgMTM6MzAsIFhpZSBZb25namkg5YaZ6YGTOgo+IEFkZCBzeXNmcyBpbnRl
cmZhY2UgZm9yIGVhY2ggdmR1c2UgdmlydHF1ZXVlIHRvCj4gZ2V0L3NldCB0aGUgYWZmaW5pdHkg
Zm9yIGlycSBjYWxsYmFjay4gVGhpcyBtaWdodAo+IGJlIHVzZWZ1bCBmb3IgcGVyZm9ybWFuY2Ug
dHVuaW5nIHdoZW4gdGhlIGlycSBjYWxsYmFjawo+IGFmZmluaXR5IG1hc2sgY29udGFpbnMgbW9y
ZSB0aGFuIG9uZSBDUFUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlA
Ynl0ZWRhbmNlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5j
IHwgMTI0ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTEzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jCj4gaW5kZXggY2VmYWJkMGRhYjljLi43N2RhMzY4NTU2OGEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtNjEsNiArNjEsNyBAQCBzdHJ1Y3QgdmR1c2Vf
dmlydHF1ZXVlIHsKPiAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3Qga2ljazsKPiAgIAlpbnQgaXJxX2Vm
ZmVjdGl2ZV9jcHU7Cj4gICAJc3RydWN0IGNwdW1hc2sgaXJxX2FmZmluaXR5Owo+ICsJc3RydWN0
IGtvYmplY3Qga29iajsKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCB2ZHVzZV9kZXY7Cj4gQEAgLTEz
ODcsNiArMTM4OCw5NiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB2ZHVz
ZV9kZXZfZm9wcyA9IHsKPiAgIAkubGxzZWVrCQk9IG5vb3BfbGxzZWVrLAo+ICAgfTsKPiAgIAo+
ICtzdGF0aWMgc3NpemVfdCBpcnFfY2JfYWZmaW5pdHlfc2hvdyhzdHJ1Y3QgdmR1c2VfdmlydHF1
ZXVlICp2cSwgY2hhciAqYnVmKQo+ICt7Cj4gKwlyZXR1cm4gc3ByaW50ZihidWYsICIlKnBiXG4i
LCBjcHVtYXNrX3ByX2FyZ3MoJnZxLT5pcnFfYWZmaW5pdHkpKTsKPiArfQo+ICsKPiArc3RhdGlj
IHNzaXplX3QgaXJxX2NiX2FmZmluaXR5X3N0b3JlKHN0cnVjdCB2ZHVzZV92aXJ0cXVldWUgKnZx
LAo+ICsJCQkJICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKPiArewo+ICsJY3B1
bWFza192YXJfdCBuZXdfdmFsdWU7Cj4gKwlpbnQgcmV0Owo+ICsKPiArCWlmICghemFsbG9jX2Nw
dW1hc2tfdmFyKCZuZXdfdmFsdWUsIEdGUF9LRVJORUwpKQo+ICsJCXJldHVybiAtRU5PTUVNOwo+
ICsKPiArCXJldCA9IGNwdW1hc2tfcGFyc2UoYnVmLCBuZXdfdmFsdWUpOwo+ICsJaWYgKHJldCkK
PiArCQlnb3RvIGZyZWVfbWFzazsKPiArCj4gKwlyZXQgPSAtRUlOVkFMOwo+ICsJaWYgKCFjcHVt
YXNrX2ludGVyc2VjdHMobmV3X3ZhbHVlLCBjcHVfb25saW5lX21hc2spKQo+ICsJCWdvdG8gZnJl
ZV9tYXNrOwo+ICsKPiArCWNwdW1hc2tfY29weSgmdnEtPmlycV9hZmZpbml0eSwgbmV3X3ZhbHVl
KTsKPiArCXJldCA9IGNvdW50Owo+ICtmcmVlX21hc2s6Cj4gKwlmcmVlX2NwdW1hc2tfdmFyKG5l
d192YWx1ZSk7Cj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICtzdHJ1Y3QgdnFfc3lzZnNfZW50
cnkgewo+ICsJc3RydWN0IGF0dHJpYnV0ZSBhdHRyOwo+ICsJc3NpemVfdCAoKnNob3cpKHN0cnVj
dCB2ZHVzZV92aXJ0cXVldWUgKnZxLCBjaGFyICpidWYpOwo+ICsJc3NpemVfdCAoKnN0b3JlKShz
dHJ1Y3QgdmR1c2VfdmlydHF1ZXVlICp2cSwgY29uc3QgY2hhciAqYnVmLAo+ICsJCQkgc2l6ZV90
IGNvdW50KTsKPiArfTsKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdnFfc3lzZnNfZW50cnkgaXJxX2Ni
X2FmZmluaXR5X2F0dHIgPSBfX0FUVFJfUlcoaXJxX2NiX2FmZmluaXR5KTsKPiArCj4gK3N0YXRp
YyBzdHJ1Y3QgYXR0cmlidXRlICp2cV9hdHRyc1tdID0gewo+ICsJJmlycV9jYl9hZmZpbml0eV9h
dHRyLmF0dHIsCj4gKwlOVUxMLAo+ICt9Owo+ICtBVFRSSUJVVEVfR1JPVVBTKHZxKTsKPiArCj4g
K3N0YXRpYyBzc2l6ZV90IHZxX2F0dHJfc2hvdyhzdHJ1Y3Qga29iamVjdCAqa29iaiwgc3RydWN0
IGF0dHJpYnV0ZSAqYXR0ciwKPiArCQkJICAgIGNoYXIgKmJ1ZikKPiArewo+ICsJc3RydWN0IHZk
dXNlX3ZpcnRxdWV1ZSAqdnEgPSBjb250YWluZXJfb2Yoa29iaiwKPiArCQkJCQlzdHJ1Y3QgdmR1
c2VfdmlydHF1ZXVlLCBrb2JqKTsKPiArCXN0cnVjdCB2cV9zeXNmc19lbnRyeSAqZW50cnkgPSBj
b250YWluZXJfb2YoYXR0ciwKPiArCQkJCQlzdHJ1Y3QgdnFfc3lzZnNfZW50cnksIGF0dHIpOwo+
ICsKPiArCWlmICghZW50cnktPnNob3cpCj4gKwkJcmV0dXJuIC1FSU87Cj4gKwo+ICsJcmV0dXJu
IGVudHJ5LT5zaG93KHZxLCBidWYpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3NpemVfdCB2cV9hdHRy
X3N0b3JlKHN0cnVjdCBrb2JqZWN0ICprb2JqLCBzdHJ1Y3QgYXR0cmlidXRlICphdHRyLAo+ICsJ
CQkgICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQo+ICt7Cj4gKwlzdHJ1Y3QgdmR1
c2VfdmlydHF1ZXVlICp2cSA9IGNvbnRhaW5lcl9vZihrb2JqLAo+ICsJCQkJCXN0cnVjdCB2ZHVz
ZV92aXJ0cXVldWUsIGtvYmopOwo+ICsJc3RydWN0IHZxX3N5c2ZzX2VudHJ5ICplbnRyeSA9IGNv
bnRhaW5lcl9vZihhdHRyLAo+ICsJCQkJCXN0cnVjdCB2cV9zeXNmc19lbnRyeSwgYXR0cik7Cj4g
Kwo+ICsJaWYgKCFlbnRyeS0+c3RvcmUpCj4gKwkJcmV0dXJuIC1FSU87Cj4gKwo+ICsJcmV0dXJu
IGVudHJ5LT5zdG9yZSh2cSwgYnVmLCBjb3VudCk7Cj4gK30KPiArCj4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3Qgc3lzZnNfb3BzIHZxX3N5c2ZzX29wcyA9IHsKPiArCS5zaG93ID0gdnFfYXR0cl9zaG93
LAo+ICsJLnN0b3JlID0gdnFfYXR0cl9zdG9yZSwKPiArfTsKPiArCj4gK3N0YXRpYyB2b2lkIHZx
X3JlbGVhc2Uoc3RydWN0IGtvYmplY3QgKmtvYmopCj4gK3sKPiArCXN0cnVjdCB2ZHVzZV92aXJ0
cXVldWUgKnZxID0gY29udGFpbmVyX29mKGtvYmosCj4gKwkJCQkJc3RydWN0IHZkdXNlX3ZpcnRx
dWV1ZSwga29iaik7Cj4gKwlrZnJlZSh2cSk7Cj4gK30KPiArCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3Qga29ial90eXBlIHZxX3R5cGUgPSB7Cj4gKwkucmVsZWFzZQk9IHZxX3JlbGVhc2UsCj4gKwku
c3lzZnNfb3BzCT0gJnZxX3N5c2ZzX29wcywKPiArCS5kZWZhdWx0X2dyb3Vwcwk9IHZxX2dyb3Vw
cywKPiArfTsKPiArCj4gICBzdGF0aWMgdm9pZCB2ZHVzZV9kZXZfZGVpbml0X3ZxcyhzdHJ1Y3Qg
dmR1c2VfZGV2ICpkZXYpCj4gICB7Cj4gICAJaW50IGk7Cj4gQEAgLTEzOTUsMTMgKzE0ODYsMTMg
QEAgc3RhdGljIHZvaWQgdmR1c2VfZGV2X2RlaW5pdF92cXMoc3RydWN0IHZkdXNlX2RldiAqZGV2
KQo+ICAgCQlyZXR1cm47Cj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwgZGV2LT52cV9udW07IGkr
KykKPiAtCQlrZnJlZShkZXYtPnZxc1tpXSk7Cj4gKwkJa29iamVjdF9wdXQoJmRldi0+dnFzW2ld
LT5rb2JqKTsKPiAgIAlrZnJlZShkZXYtPnZxcyk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQg
dmR1c2VfZGV2X2luaXRfdnFzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwgdTMyIHZxX2FsaWduLCB1
MzIgdnFfbnVtKQo+ICAgewo+IC0JaW50IGk7Cj4gKwlpbnQgcmV0LCBpOwo+ICAgCj4gICAJZGV2
LT52cV9hbGlnbiA9IHZxX2FsaWduOwo+ICAgCWRldi0+dnFfbnVtID0gdnFfbnVtOwo+IEBAIC0x
NDExLDggKzE1MDIsMTAgQEAgc3RhdGljIGludCB2ZHVzZV9kZXZfaW5pdF92cXMoc3RydWN0IHZk
dXNlX2RldiAqZGV2LCB1MzIgdnFfYWxpZ24sIHUzMiB2cV9udW0pCj4gICAKPiAgIAlmb3IgKGkg
PSAwOyBpIDwgdnFfbnVtOyBpKyspIHsKPiAgIAkJZGV2LT52cXNbaV0gPSBremFsbG9jKHNpemVv
ZigqZGV2LT52cXNbaV0pLCBHRlBfS0VSTkVMKTsKPiAtCQlpZiAoIWRldi0+dnFzW2ldKQo+ICsJ
CWlmICghZGV2LT52cXNbaV0pIHsKPiArCQkJcmV0ID0gLUVOT01FTTsKPiAgIAkJCWdvdG8gZXJy
Owo+ICsJCX0KPiAgIAo+ICAgCQlkZXYtPnZxc1tpXS0+aW5kZXggPSBpOwo+ICAgCQlkZXYtPnZx
c1tpXS0+aXJxX2VmZmVjdGl2ZV9jcHUgPSBJUlFfVU5CT1VORDsKPiBAQCAtMTQyMSwxNSArMTUx
NCwyMyBAQCBzdGF0aWMgaW50IHZkdXNlX2Rldl9pbml0X3ZxcyhzdHJ1Y3QgdmR1c2VfZGV2ICpk
ZXYsIHUzMiB2cV9hbGlnbiwgdTMyIHZxX251bSkKPiAgIAkJc3Bpbl9sb2NrX2luaXQoJmRldi0+
dnFzW2ldLT5raWNrX2xvY2spOwo+ICAgCQlzcGluX2xvY2tfaW5pdCgmZGV2LT52cXNbaV0tPmly
cV9sb2NrKTsKPiAgIAkJY3B1bWFza19zZXRhbGwoJmRldi0+dnFzW2ldLT5pcnFfYWZmaW5pdHkp
Owo+ICsKPiArCQlrb2JqZWN0X2luaXQoJmRldi0+dnFzW2ldLT5rb2JqLCAmdnFfdHlwZSk7Cj4g
KwkJcmV0ID0ga29iamVjdF9hZGQoJmRldi0+dnFzW2ldLT5rb2JqLAo+ICsJCQkJICAmZGV2LT5k
ZXYtPmtvYmosICJ2cSVkIiwgaSk7Cj4gKwkJaWYgKHJldCkgewo+ICsJCQlrZnJlZShkZXYtPnZx
c1tpXSk7Cj4gKwkJCWdvdG8gZXJyOwo+ICsJCX0KPiAgIAl9Cj4gICAKPiAgIAlyZXR1cm4gMDsK
PiAgIGVycjoKPiAgIAl3aGlsZSAoaS0tKQo+IC0JCWtmcmVlKGRldi0+dnFzW2ldKTsKPiArCQlr
b2JqZWN0X3B1dCgmZGV2LT52cXNbaV0tPmtvYmopOwo+ICAgCWtmcmVlKGRldi0+dnFzKTsKPiAg
IAlkZXYtPnZxcyA9IE5VTEw7Cj4gLQlyZXR1cm4gLUVOT01FTTsKPiArCXJldHVybiByZXQ7Cj4g
ICB9Cj4gICAKPiAgIHN0YXRpYyBzdHJ1Y3QgdmR1c2VfZGV2ICp2ZHVzZV9kZXZfY3JlYXRlKHZv
aWQpCj4gQEAgLTE2MDcsMTAgKzE3MDgsNiBAQCBzdGF0aWMgaW50IHZkdXNlX2NyZWF0ZV9kZXYo
c3RydWN0IHZkdXNlX2Rldl9jb25maWcgKmNvbmZpZywKPiAgIAlkZXYtPmNvbmZpZyA9IGNvbmZp
Z19idWY7Cj4gICAJZGV2LT5jb25maWdfc2l6ZSA9IGNvbmZpZy0+Y29uZmlnX3NpemU7Cj4gICAK
PiAtCXJldCA9IHZkdXNlX2Rldl9pbml0X3ZxcyhkZXYsIGNvbmZpZy0+dnFfYWxpZ24sIGNvbmZp
Zy0+dnFfbnVtKTsKPiAtCWlmIChyZXQpCj4gLQkJZ290byBlcnJfdnFzOwo+IC0KPiAgIAlyZXQg
PSBpZHJfYWxsb2MoJnZkdXNlX2lkciwgZGV2LCAxLCBWRFVTRV9ERVZfTUFYLCBHRlBfS0VSTkVM
KTsKPiAgIAlpZiAocmV0IDwgMCkKPiAgIAkJZ290byBlcnJfaWRyOwo+IEBAIC0xNjI0LDE0ICsx
NzIxLDE5IEBAIHN0YXRpYyBpbnQgdmR1c2VfY3JlYXRlX2RldihzdHJ1Y3QgdmR1c2VfZGV2X2Nv
bmZpZyAqY29uZmlnLAo+ICAgCQlyZXQgPSBQVFJfRVJSKGRldi0+ZGV2KTsKPiAgIAkJZ290byBl
cnJfZGV2Owo+ICAgCX0KPiArCj4gKwlyZXQgPSB2ZHVzZV9kZXZfaW5pdF92cXMoZGV2LCBjb25m
aWctPnZxX2FsaWduLCBjb25maWctPnZxX251bSk7Cj4gKwlpZiAocmV0KQo+ICsJCWdvdG8gZXJy
X3ZxczsKPiArCj4gICAJX19tb2R1bGVfZ2V0KFRISVNfTU9EVUxFKTsKPiAgIAo+ICAgCXJldHVy
biAwOwo+ICtlcnJfdnFzOgo+ICsJZGV2aWNlX2Rlc3Ryb3kodmR1c2VfY2xhc3MsIE1LREVWKE1B
Sk9SKHZkdXNlX21ham9yKSwgZGV2LT5taW5vcikpOwo+ICAgZXJyX2RldjoKPiAgIAlpZHJfcmVt
b3ZlKCZ2ZHVzZV9pZHIsIGRldi0+bWlub3IpOwo+ICAgZXJyX2lkcjoKPiAtCXZkdXNlX2Rldl9k
ZWluaXRfdnFzKGRldik7Cj4gLWVycl92cXM6Cj4gICAJdmR1c2VfZG9tYWluX2Rlc3Ryb3koZGV2
LT5kb21haW4pOwo+ICAgZXJyX2RvbWFpbjoKPiAgIAlrZnJlZShkZXYtPm5hbWUpOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
