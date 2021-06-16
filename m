Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2ADC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 07:33:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733B760FF1
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 07:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733B760FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 311F7606E0;
	Wed, 16 Jun 2021 07:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isIAo2jxLN6K; Wed, 16 Jun 2021 07:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC1B660624;
	Wed, 16 Jun 2021 07:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C07DC000D;
	Wed, 16 Jun 2021 07:33:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1349C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5ED28400E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BviCO9IdbQMC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DB6240327
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 07:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623828801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrgvDAnzVX2X+p3GDVnqhUL+PO1Rl1aPuqwOMhTlNvY=;
 b=U87XjYRdcdVC7WuD1dHsLKayMp8uZaUsRk1QxgBmsnJDicBT72HJBXS+iTWOMI0QnVjshW
 G3DFhiRB1jGKvV4PEJB40bcHM2VtS7J4YBaWTnHEA69OVz8WZag4y5TmV8OMnLTRS5fmF+
 4RaTDLOjr+TTh+dJ/ENuy0TkZuT77ag=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-l6B-6FahNFWNZE1EaHpUFw-1; Wed, 16 Jun 2021 03:33:18 -0400
X-MC-Unique: l6B-6FahNFWNZE1EaHpUFw-1
Received: by mail-pg1-f200.google.com with SMTP id
 k5-20020a63ba050000b029021ab84617c0so958892pgf.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 00:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hrgvDAnzVX2X+p3GDVnqhUL+PO1Rl1aPuqwOMhTlNvY=;
 b=hqxVBUib13osnIHb9Hr3zE9bDHZPuSmy1oLdKMoPGrNovgGOFNKHNv/60dlUczj3FL
 /79BWJLXt4lZ1QgwDDmtnTQOBJIiE5og0QRr0obKpiVaKSnhBQ6P55cvTvTCApO+vHUN
 l89Gz9NQ0lNoNwhM2qM4F8Ir3tXeI1kPefaW7YiP29KP7N+tC7MoyxPV2BsCPy/Cs6w+
 emNPaIP3UgdObuyXiFB3vxBgm3893Gy/hTKHPgYr1iRWXuTDBGxdIUDZgLm0Wl/n/ZDh
 4Xh5PwCSgIFou+zREtXnPDUfyT2dEdwPqOfUYos+Ne1HHeL4+VIcWbU5nqm0dCu3cMHt
 D4Ew==
X-Gm-Message-State: AOAM533tn3JP1948qaeHStygNTxzO+dD7e2wDLJIVSinoErPPXdAXoJ6
 H26e5+bQbCwyGs+mQA35254pF0qXJHwZsxaI8xGx6P2qmSLmTDQwC2s9hMbC2Sx/65jpZCHEKW1
 gCMBLpvntbit+aStgnHdIfgZx6DtRfpKNQ1qByElcEA==
X-Received: by 2002:a63:6982:: with SMTP id e124mr3578994pgc.439.1623828797132; 
 Wed, 16 Jun 2021 00:33:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUIq7Lz8HKOFEufm/jp52GRliBWs0Lz4CE/qd3l1hSi1Xms0UsuSTNWK3gwkAMa0A5d6uFvw==
X-Received: by 2002:a63:6982:: with SMTP id e124mr3578973pgc.439.1623828796837; 
 Wed, 16 Jun 2021 00:33:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id y7sm1229445pfy.153.2021.06.16.00.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 00:33:16 -0700 (PDT)
Subject: Re: [PATCH net-next v5 08/15] virtio-net: split the receive_mergeable
 function
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210610082209.91487-1-xuanzhuo@linux.alibaba.com>
 <20210610082209.91487-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <52720442-a3e6-69f9-72f5-246dab2c8e5f@redhat.com>
Date: Wed, 16 Jun 2021 15:33:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610082209.91487-9-xuanzhuo@linux.alibaba.com>
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

CtTaIDIwMjEvNi8xMCDPws7nNDoyMiwgWHVhbiBaaHVvINC0tcA6Cj4gcmVjZWl2ZV9tZXJnZWFi
bGUoKSBpcyB0b28gY29tcGxpY2F0ZWQsIHNvIHRoaXMgZnVuY3Rpb24gaXMgc3BsaXQgaGVyZS4K
PiBPbmUgaXMgdG8gbWFrZSB0aGUgZnVuY3Rpb24gbW9yZSByZWFkYWJsZS4gT24gdGhlIG90aGVy
IGhhbmQsIHRoZSB0d28KPiBpbmRlcGVuZGVudCBmdW5jdGlvbnMgd2lsbCBiZSBjYWxsZWQgc2Vw
YXJhdGVseSBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIHwgMTgxICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDExMSBpbnNlcnRpb25zKCspLCA3MCBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCAzZmQ4N2JmMmIyYWQuLjk4OWFiYTYwMGU2MyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtNzMzLDYgKzczMywxMDkgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp4ZHBfbGluZWFy
aXplX3BhZ2Uoc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+ICAgCXJldHVybiBOVUxMOwo+ICAg
fQo+ICAgCj4gK3N0YXRpYyB2b2lkIG1lcmdlX2Ryb3BfZm9sbG93X2J1ZnMoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiArCQkJCSAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiArCQkJCSAg
IHUxNiBudW1fYnVmLAo+ICsJCQkJICAgc3RydWN0IHZpcnRuZXRfcnFfc3RhdHMgKnN0YXRzKQoK
ClBhdGNoIGxvb2tzIGdvb2QuIE5pdCBoZXJlLCBJIGd1ZXNzIHdlIG5lZWQgYSBiZXR0ZXIgbmFt
ZSwgaG93IGFib3V0IAoibWVyZ2VfYnVmZmVycygpIiBmb3IgdGhpcyBhbmQgImRyb3BfYnVmZmVy
cygpIiBmb3IgdGhlIG5leHQgZnVuY3Rpb24/CgpUaGFua3MKCgo+ICt7Cj4gKwlzdHJ1Y3QgcGFn
ZSAqcGFnZTsKPiArCXVuc2lnbmVkIGludCBsZW47Cj4gKwl2b2lkICpidWY7Cj4gKwo+ICsJd2hp
bGUgKG51bV9idWYtLSA+IDEpIHsKPiArCQlidWYgPSB2aXJ0cXVldWVfZ2V0X2J1ZihycS0+dnEs
ICZsZW4pOwo+ICsJCWlmICh1bmxpa2VseSghYnVmKSkgewo+ICsJCQlwcl9kZWJ1ZygiJXM6IHJ4
IGVycm9yOiAlZCBidWZmZXJzIG1pc3NpbmdcbiIsCj4gKwkJCQkgZGV2LT5uYW1lLCBudW1fYnVm
KTsKPiArCQkJZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gKwkJCWJyZWFrOwo+ICsJ
CX0KPiArCQlzdGF0cy0+Ynl0ZXMgKz0gbGVuOwo+ICsJCXBhZ2UgPSB2aXJ0X3RvX2hlYWRfcGFn
ZShidWYpOwo+ICsJCXB1dF9wYWdlKHBhZ2UpOwo+ICsJfQo+ICt9Cj4gKwo+ICtzdGF0aWMgc3Ry
dWN0IHNrX2J1ZmYgKm1lcmdlX3JlY2VpdmVfZm9sbG93X2J1ZnMoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwKPiArCQkJCQkJIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkJCQkgc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLAo+ICsJCQkJCQkgc3RydWN0IHNrX2J1ZmYgKmhlYWRfc2tiLAo+
ICsJCQkJCQkgdTE2IG51bV9idWYsCj4gKwkJCQkJCSBzdHJ1Y3QgdmlydG5ldF9ycV9zdGF0cyAq
c3RhdHMpCj4gK3sKPiArCXN0cnVjdCBza19idWZmICpjdXJyX3NrYjsKPiArCXVuc2lnbmVkIGlu
dCB0cnVlc2l6ZTsKPiArCXVuc2lnbmVkIGludCBsZW4sIG51bTsKPiArCXN0cnVjdCBwYWdlICpw
YWdlOwo+ICsJdm9pZCAqYnVmLCAqY3R4Owo+ICsJaW50IG9mZnNldDsKPiArCj4gKwljdXJyX3Nr
YiA9IGhlYWRfc2tiOwo+ICsJbnVtID0gbnVtX2J1ZjsKPiArCj4gKwl3aGlsZSAoLS1udW1fYnVm
KSB7Cj4gKwkJaW50IG51bV9za2JfZnJhZ3M7Cj4gKwo+ICsJCWJ1ZiA9IHZpcnRxdWV1ZV9nZXRf
YnVmX2N0eChycS0+dnEsICZsZW4sICZjdHgpOwo+ICsJCWlmICh1bmxpa2VseSghYnVmKSkgewo+
ICsJCQlwcl9kZWJ1ZygiJXM6IHJ4IGVycm9yOiAlZCBidWZmZXJzIG91dCBvZiAlZCBtaXNzaW5n
XG4iLAo+ICsJCQkJIGRldi0+bmFtZSwgbnVtX2J1ZiwgbnVtKTsKPiArCQkJZGV2LT5zdGF0cy5y
eF9sZW5ndGhfZXJyb3JzKys7Cj4gKwkJCWdvdG8gZXJyX2J1ZjsKPiArCQl9Cj4gKwo+ICsJCXN0
YXRzLT5ieXRlcyArPSBsZW47Cj4gKwkJcGFnZSA9IHZpcnRfdG9faGVhZF9wYWdlKGJ1Zik7Cj4g
Kwo+ICsJCXRydWVzaXplID0gbWVyZ2VhYmxlX2N0eF90b190cnVlc2l6ZShjdHgpOwo+ICsJCWlm
ICh1bmxpa2VseShsZW4gPiB0cnVlc2l6ZSkpIHsKPiArCQkJcHJfZGVidWcoIiVzOiByeCBlcnJv
cjogbGVuICV1IGV4Y2VlZHMgdHJ1ZXNpemUgJWx1XG4iLAo+ICsJCQkJIGRldi0+bmFtZSwgbGVu
LCAodW5zaWduZWQgbG9uZyljdHgpOwo+ICsJCQlkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMr
KzsKPiArCQkJZ290byBlcnJfc2tiOwo+ICsJCX0KPiArCj4gKwkJbnVtX3NrYl9mcmFncyA9IHNr
Yl9zaGluZm8oY3Vycl9za2IpLT5ucl9mcmFnczsKPiArCQlpZiAodW5saWtlbHkobnVtX3NrYl9m
cmFncyA9PSBNQVhfU0tCX0ZSQUdTKSkgewo+ICsJCQlzdHJ1Y3Qgc2tfYnVmZiAqbnNrYiA9IGFs
bG9jX3NrYigwLCBHRlBfQVRPTUlDKTsKPiArCj4gKwkJCWlmICh1bmxpa2VseSghbnNrYikpCj4g
KwkJCQlnb3RvIGVycl9za2I7Cj4gKwkJCWlmIChjdXJyX3NrYiA9PSBoZWFkX3NrYikKPiArCQkJ
CXNrYl9zaGluZm8oY3Vycl9za2IpLT5mcmFnX2xpc3QgPSBuc2tiOwo+ICsJCQllbHNlCj4gKwkJ
CQljdXJyX3NrYi0+bmV4dCA9IG5za2I7Cj4gKwkJCWN1cnJfc2tiID0gbnNrYjsKPiArCQkJaGVh
ZF9za2ItPnRydWVzaXplICs9IG5za2ItPnRydWVzaXplOwo+ICsJCQludW1fc2tiX2ZyYWdzID0g
MDsKPiArCQl9Cj4gKwkJaWYgKGN1cnJfc2tiICE9IGhlYWRfc2tiKSB7Cj4gKwkJCWhlYWRfc2ti
LT5kYXRhX2xlbiArPSBsZW47Cj4gKwkJCWhlYWRfc2tiLT5sZW4gKz0gbGVuOwo+ICsJCQloZWFk
X3NrYi0+dHJ1ZXNpemUgKz0gdHJ1ZXNpemU7Cj4gKwkJfQo+ICsJCW9mZnNldCA9IGJ1ZiAtIHBh
Z2VfYWRkcmVzcyhwYWdlKTsKPiArCQlpZiAoc2tiX2Nhbl9jb2FsZXNjZShjdXJyX3NrYiwgbnVt
X3NrYl9mcmFncywgcGFnZSwgb2Zmc2V0KSkgewo+ICsJCQlwdXRfcGFnZShwYWdlKTsKPiArCQkJ
c2tiX2NvYWxlc2NlX3J4X2ZyYWcoY3Vycl9za2IsIG51bV9za2JfZnJhZ3MgLSAxLAo+ICsJCQkJ
CSAgICAgbGVuLCB0cnVlc2l6ZSk7Cj4gKwkJfSBlbHNlIHsKPiArCQkJc2tiX2FkZF9yeF9mcmFn
KGN1cnJfc2tiLCBudW1fc2tiX2ZyYWdzLCBwYWdlLAo+ICsJCQkJCW9mZnNldCwgbGVuLCB0cnVl
c2l6ZSk7Cj4gKwkJfQo+ICsJfQo+ICsKPiArCXJldHVybiBoZWFkX3NrYjsKPiArCj4gK2Vycl9z
a2I6Cj4gKwlwdXRfcGFnZShwYWdlKTsKPiArCW1lcmdlX2Ryb3BfZm9sbG93X2J1ZnMoZGV2LCBy
cSwgbnVtX2J1Ziwgc3RhdHMpOwo+ICtlcnJfYnVmOgo+ICsJc3RhdHMtPmRyb3BzKys7Cj4gKwlk
ZXZfa2ZyZWVfc2tiKGhlYWRfc2tiKTsKPiArCXJldHVybiBOVUxMOwo+ICt9Cj4gKwo+ICAgc3Rh
dGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX3NtYWxsKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
Cj4gICAJCQkJICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAkJCQkgICAgIHN0cnVj
dCByZWNlaXZlX3F1ZXVlICpycSwKPiBAQCAtOTA5LDcgKzEwMTIsNyBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJ
dTE2IG51bV9idWYgPSB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsIGhkci0+bnVtX2J1ZmZlcnMp
Owo+ICAgCXN0cnVjdCBwYWdlICpwYWdlID0gdmlydF90b19oZWFkX3BhZ2UoYnVmKTsKPiAgIAlp
bnQgb2Zmc2V0ID0gYnVmIC0gcGFnZV9hZGRyZXNzKHBhZ2UpOwo+IC0Jc3RydWN0IHNrX2J1ZmYg
KmhlYWRfc2tiLCAqY3Vycl9za2I7Cj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqaGVhZF9za2I7Cj4gICAJ
c3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPiAgIAl1bnNpZ25lZCBpbnQgdHJ1ZXNpemUgPSBt
ZXJnZWFibGVfY3R4X3RvX3RydWVzaXplKGN0eCk7Cj4gICAJdW5zaWduZWQgaW50IGhlYWRyb29t
ID0gbWVyZ2VhYmxlX2N0eF90b19oZWFkcm9vbShjdHgpOwo+IEBAIC0xMDU0LDY1ICsxMTU3LDE1
IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9k
ZXZpY2UgKmRldiwKPiAgIAo+ICAgCWhlYWRfc2tiID0gcGFnZV90b19za2IodmksIHJxLCBwYWdl
LCBvZmZzZXQsIGxlbiwgdHJ1ZXNpemUsICF4ZHBfcHJvZywKPiAgIAkJCSAgICAgICBtZXRhc2l6
ZSwgISFoZWFkcm9vbSk7Cj4gLQljdXJyX3NrYiA9IGhlYWRfc2tiOwo+IC0KPiAtCWlmICh1bmxp
a2VseSghY3Vycl9za2IpKQo+ICsJaWYgKHVubGlrZWx5KCFoZWFkX3NrYikpCj4gICAJCWdvdG8g
ZXJyX3NrYjsKPiAtCXdoaWxlICgtLW51bV9idWYpIHsKPiAtCQlpbnQgbnVtX3NrYl9mcmFnczsK
PiAgIAo+IC0JCWJ1ZiA9IHZpcnRxdWV1ZV9nZXRfYnVmX2N0eChycS0+dnEsICZsZW4sICZjdHgp
Owo+IC0JCWlmICh1bmxpa2VseSghYnVmKSkgewo+IC0JCQlwcl9kZWJ1ZygiJXM6IHJ4IGVycm9y
OiAlZCBidWZmZXJzIG91dCBvZiAlZCBtaXNzaW5nXG4iLAo+IC0JCQkJIGRldi0+bmFtZSwgbnVt
X2J1ZiwKPiAtCQkJCSB2aXJ0aW8xNl90b19jcHUodmktPnZkZXYsCj4gLQkJCQkJCSBoZHItPm51
bV9idWZmZXJzKSk7Cj4gLQkJCWRldi0+c3RhdHMucnhfbGVuZ3RoX2Vycm9ycysrOwo+IC0JCQln
b3RvIGVycl9idWY7Cj4gLQkJfQo+IC0KPiAtCQlzdGF0cy0+Ynl0ZXMgKz0gbGVuOwo+IC0JCXBh
Z2UgPSB2aXJ0X3RvX2hlYWRfcGFnZShidWYpOwo+IC0KPiAtCQl0cnVlc2l6ZSA9IG1lcmdlYWJs
ZV9jdHhfdG9fdHJ1ZXNpemUoY3R4KTsKPiAtCQlpZiAodW5saWtlbHkobGVuID4gdHJ1ZXNpemUp
KSB7Cj4gLQkJCXByX2RlYnVnKCIlczogcnggZXJyb3I6IGxlbiAldSBleGNlZWRzIHRydWVzaXpl
ICVsdVxuIiwKPiAtCQkJCSBkZXYtPm5hbWUsIGxlbiwgKHVuc2lnbmVkIGxvbmcpY3R4KTsKPiAt
CQkJZGV2LT5zdGF0cy5yeF9sZW5ndGhfZXJyb3JzKys7Cj4gLQkJCWdvdG8gZXJyX3NrYjsKPiAt
CQl9Cj4gLQo+IC0JCW51bV9za2JfZnJhZ3MgPSBza2Jfc2hpbmZvKGN1cnJfc2tiKS0+bnJfZnJh
Z3M7Cj4gLQkJaWYgKHVubGlrZWx5KG51bV9za2JfZnJhZ3MgPT0gTUFYX1NLQl9GUkFHUykpIHsK
PiAtCQkJc3RydWN0IHNrX2J1ZmYgKm5za2IgPSBhbGxvY19za2IoMCwgR0ZQX0FUT01JQyk7Cj4g
LQo+IC0JCQlpZiAodW5saWtlbHkoIW5za2IpKQo+IC0JCQkJZ290byBlcnJfc2tiOwo+IC0JCQlp
ZiAoY3Vycl9za2IgPT0gaGVhZF9za2IpCj4gLQkJCQlza2Jfc2hpbmZvKGN1cnJfc2tiKS0+ZnJh
Z19saXN0ID0gbnNrYjsKPiAtCQkJZWxzZQo+IC0JCQkJY3Vycl9za2ItPm5leHQgPSBuc2tiOwo+
IC0JCQljdXJyX3NrYiA9IG5za2I7Cj4gLQkJCWhlYWRfc2tiLT50cnVlc2l6ZSArPSBuc2tiLT50
cnVlc2l6ZTsKPiAtCQkJbnVtX3NrYl9mcmFncyA9IDA7Cj4gLQkJfQo+IC0JCWlmIChjdXJyX3Nr
YiAhPSBoZWFkX3NrYikgewo+IC0JCQloZWFkX3NrYi0+ZGF0YV9sZW4gKz0gbGVuOwo+IC0JCQlo
ZWFkX3NrYi0+bGVuICs9IGxlbjsKPiAtCQkJaGVhZF9za2ItPnRydWVzaXplICs9IHRydWVzaXpl
Owo+IC0JCX0KPiAtCQlvZmZzZXQgPSBidWYgLSBwYWdlX2FkZHJlc3MocGFnZSk7Cj4gLQkJaWYg
KHNrYl9jYW5fY29hbGVzY2UoY3Vycl9za2IsIG51bV9za2JfZnJhZ3MsIHBhZ2UsIG9mZnNldCkp
IHsKPiAtCQkJcHV0X3BhZ2UocGFnZSk7Cj4gLQkJCXNrYl9jb2FsZXNjZV9yeF9mcmFnKGN1cnJf
c2tiLCBudW1fc2tiX2ZyYWdzIC0gMSwKPiAtCQkJCQkgICAgIGxlbiwgdHJ1ZXNpemUpOwo+IC0J
CX0gZWxzZSB7Cj4gLQkJCXNrYl9hZGRfcnhfZnJhZyhjdXJyX3NrYiwgbnVtX3NrYl9mcmFncywg
cGFnZSwKPiAtCQkJCQlvZmZzZXQsIGxlbiwgdHJ1ZXNpemUpOwo+IC0JCX0KPiAtCX0KPiArCWlm
IChudW1fYnVmID4gMSkKPiArCQloZWFkX3NrYiA9IG1lcmdlX3JlY2VpdmVfZm9sbG93X2J1ZnMo
ZGV2LCB2aSwgcnEsIGhlYWRfc2tiLAo+ICsJCQkJCQkgICAgIG51bV9idWYsIHN0YXRzKTsKPiAr
CWlmIChoZWFkX3NrYikKPiArCQlld21hX3BrdF9sZW5fYWRkKCZycS0+bXJnX2F2Z19wa3RfbGVu
LCBoZWFkX3NrYi0+bGVuKTsKPiAgIAo+IC0JZXdtYV9wa3RfbGVuX2FkZCgmcnEtPm1yZ19hdmdf
cGt0X2xlbiwgaGVhZF9za2ItPmxlbik7Cj4gICAJcmV0dXJuIGhlYWRfc2tiOwo+ICAgCj4gICBl
cnJfeGRwOgo+IEBAIC0xMTIwLDE5ICsxMTczLDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpy
ZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCXN0YXRzLT54ZHBf
ZHJvcHMrKzsKPiAgIGVycl9za2I6Cj4gICAJcHV0X3BhZ2UocGFnZSk7Cj4gLQl3aGlsZSAobnVt
X2J1Zi0tID4gMSkgewo+IC0JCWJ1ZiA9IHZpcnRxdWV1ZV9nZXRfYnVmKHJxLT52cSwgJmxlbik7
Cj4gLQkJaWYgKHVubGlrZWx5KCFidWYpKSB7Cj4gLQkJCXByX2RlYnVnKCIlczogcnggZXJyb3I6
ICVkIGJ1ZmZlcnMgbWlzc2luZ1xuIiwKPiAtCQkJCSBkZXYtPm5hbWUsIG51bV9idWYpOwo+IC0J
CQlkZXYtPnN0YXRzLnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiAtCQkJYnJlYWs7Cj4gLQkJfQo+IC0J
CXN0YXRzLT5ieXRlcyArPSBsZW47Cj4gLQkJcGFnZSA9IHZpcnRfdG9faGVhZF9wYWdlKGJ1Zik7
Cj4gLQkJcHV0X3BhZ2UocGFnZSk7Cj4gLQl9Cj4gLWVycl9idWY6Cj4gKwltZXJnZV9kcm9wX2Zv
bGxvd19idWZzKGRldiwgcnEsIG51bV9idWYsIHN0YXRzKTsKPiAgIAlzdGF0cy0+ZHJvcHMrKzsK
PiAgIAlkZXZfa2ZyZWVfc2tiKGhlYWRfc2tiKTsKPiAgIHhkcF94bWl0OgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
