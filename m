Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C353C433FE
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 06:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94CF940612;
	Thu,  7 Apr 2022 06:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E6oMUwxt9DR5; Thu,  7 Apr 2022 06:38:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1144640133;
	Thu,  7 Apr 2022 06:38:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5007C002C;
	Thu,  7 Apr 2022 06:38:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2F12C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB07E80C07
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 69gUmThjJjB4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7789080BFD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649313522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTfYg7LEaBj5/S/22hrPYrBqzaTarRrfht4+k3OtluQ=;
 b=SHTFr7nYs3Xa/X/OqhKj34gbK9Xw1waZIsWfWqG/VDoaZClTXfpL8DTBVGOUv1robADqj9
 3vIRqekiwvdyPH8H2jJCXKq+HMeYT00lwH3SDaGbYDzhbPVNCkN/+dHnGZTtpG+/vh5fBg
 W/2wABPwWpxSoj1mmwh//ga8cuecM7c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-h29-pHwRPdWg1g3tNyI6kw-1; Thu, 07 Apr 2022 02:38:41 -0400
X-MC-Unique: h29-pHwRPdWg1g3tNyI6kw-1
Received: by mail-pg1-f200.google.com with SMTP id
 z132-20020a63338a000000b003844e317066so2654188pgz.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 23:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=jTfYg7LEaBj5/S/22hrPYrBqzaTarRrfht4+k3OtluQ=;
 b=dfJ5WaRYMqpix5TXJfVT6DSzX4alPgwIesrwrbz5i9gTsjK+yTHKcqgnjRGMiJT2cH
 +NYpUlG4yS/w639BwzNjjMz20UdfgtikXPGfPVLgM1LQIsXagH7Ve+HLeNzQ9vN5SOtz
 rlrrLqqa7NKsoc1siob0RRolKskEMid4Hl8idtImgaBoVJMV9mzcq1dv3LJooOpYuouK
 L1P63WpZvfgI4rLdEXGTBlk/S0DZldwxkjA73eT8smMr5wrHpO8PGj3lhFoIVLIQmMQB
 Uh6DovP+xKN6aB/JS2UFGtyKKLufVSHnrDciaxYij7C/srnUd+VQV7ZAR2T1N9KPYSO7
 2dgg==
X-Gm-Message-State: AOAM532BK+lciE1YK6zqMNAAhi8+WqsfgGe57jGZ9Y/zZPCOukz4pTb+
 hRw9ZD2oiL9+s8NWbRNSk7Dw7xOoUe3Cf7PBjRrbj6CWzVpZWxVEABgxA6StnoGu3ItDIxVYYU/
 6JJ+xR17GIuK9cIGXvkO0+6uBmhAalcaqqOVf7Ib/5w==
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id
 n17-20020a639711000000b003985cf220bcmr10087299pge.480.1649313519911; 
 Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyybYdCM1oR5OU+iW4g0AIFWnE/HZaYWWpa91mlmNGr0JeNBLBQ2wKoCRb9OSR1VOXXK+2DZQ==
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id
 n17-20020a639711000000b003985cf220bcmr10087277pge.480.1649313519510; 
 Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
Received: from [10.72.13.105] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 p34-20020a056a000a2200b004cd49fc15e5sm22753099pfh.59.2022.04.06.23.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Apr 2022 23:38:39 -0700 (PDT)
Message-ID: <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
Date: Thu, 7 Apr 2022 14:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406112858-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 tglx@linutronix.de
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

CuWcqCAyMDIyLzQvNiDkuIvljYgxMTozMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBXZWQsIEFwciAwNiwgMjAyMiBhdCAwMzowNDozMlBNICswMjAwLCBDb3JuZWxpYSBIdWNrIHdy
b3RlOgo+PiBPbiBXZWQsIEFwciAwNiAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pgo+Pj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMDQ6MzU6MzdQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBUaGlzIHBhdGNoIGltcGxlbWVudHMgUENJ
IHZlcnNpb24gb2Ygc3luY2hyb25pemVfdnFzKCkuCj4+Pj4KPj4+PiBDYzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4+Pj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4KPj4+PiBDYzogIlBhdWwgRS4gTWNLZW5uZXkiIDxwYXVsbWNrQGtlcm5l
bC5vcmc+Cj4+Pj4gQ2M6IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+IFBsZWFzZSBhZGQg
aW1wbGVtZW50YXRpb25zIGF0IGxlYXN0IGZvciBjY3cgYW5kIG1taW8uCj4+IEknbSBub3Qgc3Vy
ZSB3aGF0IChpZiBhbnl0aGluZykgY2FuL3Nob3VsZCBiZSBkb25lIGZvciBjY3cuLi4KPj4KPj4+
PiAtLS0KPj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMgfCAxNCArKysr
KysrKysrKysrKwo+Pj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCB8ICAy
ICsrCj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDEgKwo+Pj4+
ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyB8ICAyICsrCj4+Pj4gICA0IGZp
bGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9jb21tb24uYwo+Pj4+IGluZGV4IGQ3MjRmNjc2NjA4Yi4uYjc4YzhiYzkzYTk3IDEwMDY0NAo+
Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+PiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4gQEAgLTM3LDYgKzM3LDIwIEBA
IHZvaWQgdnBfc3luY2hyb25pemVfdmVjdG9ycyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
Pj4+PiAgIAkJc3luY2hyb25pemVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2Rldiwg
aSkpOwo+Pj4+ICAgfQo+Pj4+ICAgCj4+Pj4gK3ZvaWQgdnBfc3luY2hyb25pemVfdnFzKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+ICt7Cj4+Pj4gKwlzdHJ1Y3QgdmlydGlvX3BjaV9k
ZXZpY2UgKnZwX2RldiA9IHRvX3ZwX2RldmljZSh2ZGV2KTsKPj4+PiArCWludCBpOwo+Pj4+ICsK
Pj4+PiArCWlmICh2cF9kZXYtPmludHhfZW5hYmxlZCkgewo+Pj4+ICsJCXN5bmNocm9uaXplX2ly
cSh2cF9kZXYtPnBjaV9kZXYtPmlycSk7Cj4+Pj4gKwkJcmV0dXJuOwo+Pj4+ICsJfQo+Pj4+ICsK
Pj4+PiArCWZvciAoaSA9IDA7IGkgPCB2cF9kZXYtPm1zaXhfdmVjdG9yczsgKytpKQo+Pj4+ICsJ
CXN5bmNocm9uaXplX2lycShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIGkpKTsKPj4+
PiArfQo+Pj4+ICsKPj4gLi4uZ2l2ZW4gdGhhdCB0aGlzIHNlZW1zIHRvIHN5bmNocm9uaXplIHRo
cmVhZGVkIGludGVycnVwdCBoYW5kbGVycz8KPiBObywgYW55IGhhbmRsZXJzIGF0IGFsbC4gVGhl
IHBvaW50IGlzIHRvIG1ha2Ugc3VyZSBhbnkgbWVtb3J5IGNoYW5nZXMKPiBtYWRlIHByaW9yIHRv
IHRoaXMgb3AgYXJlIHZpc2libGUgdG8gY2FsbGJhY2tzLgo+Cj4gSmFzb24sIG1heWJlIGFkZCB0
aGF0IHRvIHRoZSBkb2N1bWVudGF0aW9uPwoKClN1cmUuCgoKPgo+PiBIYWxpbCwgZG8geW91IHRo
aW5rIGNjdyBuZWVkcyB0byBkbyBhbnl0aGluZz8gKEFGQUlDUywgd2Ugb25seSBoYXZlIG9uZQo+
PiAnaXJxJyBmb3IgY2hhbm5lbCBkZXZpY2VzIGFueXdheSwgYW5kIHRoZSBoYW5kbGVyIGp1c3Qg
Y2FsbHMgdGhlCj4+IHJlbGV2YW50IGNhbGxiYWNrcyBkaXJlY3RseS4pCj4gVGhlbiB5b3UgbmVl
ZCB0byBzeW5jaHJvbml6ZSB3aXRoIHRoYXQuCgoKSGF2ZSBhIHF1aWNrIGdsYW5jZSBhdCB0aGUg
Y29kZXMsIGl0IGxvb2tzIHRvIG1lIHdlIGNhbiBzeW5jaHJvbml6ZSB3aXRoIAp0aGUgSU9fSU5U
RVJSVVBULiAoQXNzdW1pbmcgYWxsIGNhbGxiYWNrcyBhcmUgdHJpZ2dlcmVkIHZpYSAKY2N3X2Rl
dmljZV9pcnEoKSkuCgpUaGFua3MKCgo+Cj4+Pj4gICAvKiB0aGUgbm90aWZ5IGZ1bmN0aW9uIHVz
ZWQgd2hlbiBjcmVhdGluZyBhIHZpcnQgcXVldWUgKi8KPj4+PiAgIGJvb2wgdnBfbm90aWZ5KHN0
cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4+ICAgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
