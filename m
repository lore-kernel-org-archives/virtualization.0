Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B19FC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 17:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 37CF2421F0;
	Thu,  9 Dec 2021 17:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZxa7d5FduOf; Thu,  9 Dec 2021 17:50:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F3C54011C;
	Thu,  9 Dec 2021 17:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 399E6C001E;
	Thu,  9 Dec 2021 17:50:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26A68C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14DE561B10
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RHrzgBoFnkLe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:50:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21D4B60A76
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639072228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cReUUZLQNrboD+IZcjBNbt6Kq531IoiXK2tkShuHR78=;
 b=D/blPJdY9HpuoKmm3h+4cnbmf9200EL8WviSC/eF9JDt9qCFbFLKf7XOkE4UEUnl4ujeh2
 sG1uwfeGC2qCEtWddCO9hmMIotI9i2vyQuaur1JgHF9VdvnZcRUXEESMrtGEln8iQWN1BW
 JcFEVycKvhDrYEhGCwYgbkcHYJYZT34=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-nWziQelfOUO_MaU1stUsfA-1; Thu, 09 Dec 2021 12:50:26 -0500
X-MC-Unique: nWziQelfOUO_MaU1stUsfA-1
Received: by mail-wm1-f72.google.com with SMTP id
 m14-20020a05600c3b0e00b0033308dcc933so2760924wms.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 09:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cReUUZLQNrboD+IZcjBNbt6Kq531IoiXK2tkShuHR78=;
 b=yQftktY2e2jIzuY4V3a2uqyCh462XU9q1BpvQ0ngKTUyIfM0EIZc3enr4SYmJ/f309
 C1MkEvPmRiMJUt2RYwcAJpY34Om8FGDPhRD0KqMondLay6Xw7FVLHXDUFhcXVdRdwR8z
 wqFEQ2uau6h9LQkbM+GQz7ucwHZ1F6cTeXme0mDoZTtcXLmjocFzm/+0X+VWCXpBYqaW
 N/tjvan5hHQfeQwhFiawFrA4PX8LbDDUGK/UmkXw+cA4EP5Z4NsCn0hCZuCRjrcau6Xm
 x/2tb/iz2m1W/8DetTXI2UhjnJFMAgK7Nb3linL6GedFBulh90SvP5HNi1Gv6+59nEPW
 4CiA==
X-Gm-Message-State: AOAM531UU8DSuh4MkVEhBBXOO7zBaj3DUziOmxvZQxVzMN2dliHUATkp
 uUIrfLsQyDVD2DfvZmNoZSlcAZ5oiQd+DDB6Ydv2Xy1NzhAclQue2vkX6wKZnr3z10gg8IZcsky
 Diyv9UJou95Juv0FlXPf9MpqrPltnq2qXGcvjzmgiZQ==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr9287658wmk.91.1639072225687; 
 Thu, 09 Dec 2021 09:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1Q1ta3quvHK6VV8iOM3qPpFpOU9+4sLknPpYdPHvNEssS7b1tD5wHRrpRQoopsdw+QzPdhA==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr9287632wmk.91.1639072225451; 
 Thu, 09 Dec 2021 09:50:25 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id b6sm9934160wmq.45.2021.12.09.09.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 09:50:24 -0800 (PST)
Date: Thu, 9 Dec 2021 12:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] virtio: make sure legacy pci device gain 32bit-pfn vq
Message-ID: <20211209124542-mutt-send-email-mst@kernel.org>
References: <b50fff4d-9f05-76b3-eba7-91241c351751@linux.alibaba.com>
 <20211207031217-mutt-send-email-mst@kernel.org>
 <8bbfd029-d969-4632-cb8e-482481d65a2f@linux.alibaba.com>
 <20211208021947-mutt-send-email-mst@kernel.org>
 <dfb712d7-1186-1496-9fcc-a72e23c3409b@linux.alibaba.com>
 <20211208060115-mutt-send-email-mst@kernel.org>
 <a5b62e3c-5c24-dc8f-f7a3-027a67ef3bb2@linux.alibaba.com>
 <20211209013833-mutt-send-email-mst@kernel.org>
 <22c1f3f1-beab-83cb-c7ce-d61a970d0f0e@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <22c1f3f1-beab-83cb-c7ce-d61a970d0f0e@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>
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

T24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDQ6MjY6NDdQTSArMDgwMCwg546L6LSHIHdyb3RlOgo+
IAo+IAo+IOWcqCAyMDIxLzEyLzkg5LiL5Y2IMjo0MCwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPiBbc25pcF0KPiA+ID4gPiA+IEJlc2lkZXMsIEkndmUgY2hlY2tlZCB0aGF0IHBhdGNoIGJ1
dCBpdCBjYW4ndCBhZGRyZXNzIG91ciBpc3N1ZSwgd2UgYWN0dWFsbHkKPiA+ID4gPiA+IGhhdmUg
dGhpcyBsZWdhY3kgcGNpIGRldmljZSBvbiBhcm0gcGxhdGZvcm0sIGFuZCB0aGUgbWVtb3J5IGxh
eW91dCBpcwo+ID4gPiA+ID4gdW5mcmllbmRseSBzaW5jZSBhbGxvY2F0aW9uIHJhcmVseSBwcm92
aWRpbmcgcGFnZS1hZGRyZXNzIGJlbG93IDQ0Yml0LCB3ZQo+ID4gPiA+ID4gdW5kZXJzdGFuZCB0
aGUgdmlydGlvLWlvbW11IGNhc2Ugc2hvdWxkIG5vdCBkbyBmb3JjZSBkbWEsIHdoaWxlIHdlIGRv
bid0Cj4gPiA+ID4gPiBoYXZlIHRoYXQgc28gaXQncyBqdXN0IHdvcmtpbmcgZmluZS4KPiA+ID4g
PiA+IAo+ID4gPiA+ID4gUmVnYXJkcywKPiA+ID4gPiA+IE1pY2hhZWwgV2FuZwo+ID4gPiA+IAo+
ID4gPiA+IEhtbSB3YWl0IGEgc2VjIGlzIGl0IGEgcGh5c2ljYWwgZGV2aWNlIG9yIGEgaHlwZXJ2
aXNvcj8KPiA+ID4gPiBJZiBhIHBoeXNpY2FsIG9uZSB0aGVuIGRvZXNuJ3QgaXQgbmVlZCBWSVJU
SU9fRl9PUkRFUl9QTEFURk9STQo+ID4gPiA+IG9uIEFSTT8KPiA+ID4gCj4gPiA+IFRoZSBQQ0kg
ZGV2aWNlIGlzIHZpcnR1YWwsIEkgY2FuJ3Qgc2VlIGhvdyBWSVJUSU9fRl9PUkRFUl9QTEFURk9S
TSBoZWxwCj4gPiA+IGFkZHJlc3MgdGhpcyBpc3N1ZSwgbGVnYWN5IHBjaSBjb25maWcgaXMgMzJi
aXQgYnV0IGl0J3MgMzYsIHNlZW1zIGxpa2Ugd2lsbAo+ID4gPiBuZXZlciBiZSBpbmNsdWRlZD8K
PiA+ID4gCj4gPiA+IFJlZ2FyZHMsCj4gPiA+IE1pY2hhZWwgV2FuZwo+ID4gCj4gPiBPaCwgaWYg
dGhlIGRldmljZSBpcyB2aXJ0dWFsIHRoZW4gSSB0aGluayB5b3Ugc2hvdWxkIGp1c3QgdXBkYXRl
IGl0IHBsZWFzZS4KPiA+IHZpcnRpbyAwLlggaXMgYXJjaGl0ZWN0dXJhbGx5IGxpbWl0ZWQgdG8g
c21hbGwgVk1zLAo+ID4gaWYgeW91ciBoeXBlcnZpc29yIHN1cHBvcnRzIG1vcmUgaXQgc2hvdWxk
IGVtdWxhdGUgdmlydGlvIDEuMC4KPiAKPiBJIHNlZSwgbmljZSB0byBjb25maXJtIHRoZSBwcm9w
ZXIgYXBwcm9hY2gsIGFsdGhvdWdoIHdlIGRvbid0IGhhdmUgdGhhdAo+IG9wdGlvbiBvbiB0aGUg
ZGVzayA6LVAKCkRvbid0IHNlZSB3aHksIGEgc3Ryb25nZXIganVzdGlmaWNhdGlvbiB3aWxsIGJl
IG5lZWRlZCBiZWZvcmUgZXZlcnlvbmUKdGFrZXMgb24gdGhlIG1haW50YWluYW5jZSBidXJkZW4g
b2YgbWFpbnRhaW5pbmcgaGFja3MgbGlrZSB0aGlzLiAgSWYgd2UKbWFrZSBhbiBleGNlcHRpb24g
aGVyZSB0aGlzIG9wZW5zIGZsb29kZ2F0ZXMgZm9yIGV2ZXJ5b25lIHRvbyBsYXp5IHRvCmFkZCB2
aXJ0aW8gMSBzdXBwb3J0IHRvIGluc3RlYWQgcHVzaCBoYWNrcyBhdCB0aGUgbGludXggbGV2ZWwu
CgoKPiBTbyBhcyBsb25nIGFzIHdlIGRvbid0IGhhdmUgYW55IGlvbW11IGVuYWJsZWQsIHRoZSBm
b3JjZSBkbWEgYXBwcm9hY2ggY291bGQKPiBiZSBzYWZlLCBpcyB0aGlzIGNvcnJlY3Q/Cj4gCj4g
UmVnYXJkcywKPiBNaWNoYWVsIFdhbmcKCk5vdCB1bmxlc3MgdGhlcmUncyBhbiBBUEkgYXQgdGhl
IERNQSBBUEkgbGV2ZWwgdGhhdCBndWFyYW50ZWVzIERNQQphZGRyZXNzZXMgYXJlIHBoeXNpY2Fs
IGFkZHJlc3Nlcy4KCj4gPiAKPiA+IAo+ID4gCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gCj4g
PiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4g
PiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xl
Z2FjeS5jIHwgMTAgKysrKysrKysrKwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgICAgICAgfCAgMyArKysKPiA+ID4gPiA+ID4gPiA+ID4gICAgICBp
bmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgICAgIHwgIDEgKwo+ID4gPiA+ID4gPiA+ID4g
PiAgICAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+ID4gPiA+ID4gPiA+ID4g
PiAKPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbGVnYWN5LmMKPiA+ID4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2xlZ2FjeS5jCj4gPiA+ID4gPiA+ID4gPiA+IGluZGV4IGQ2MmU5ODMuLjExZjJlYmYgMTAwNjQ0
Cj4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5
LmMKPiA+ID4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdh
Y3kuYwo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtMjYzLDYgKzI2MywxNiBAQCBpbnQgdmlydGlvX3Bj
aV9sZWdhY3lfcHJvYmUoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlCj4gPiA+ID4gPiA+ID4gPiA+
ICp2cF9kZXYpCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgCXZwX2Rldi0+c2V0dXBfdnEgPSBzZXR1
cF92cTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJdnBfZGV2LT5kZWxfdnEgPSBkZWxfdnE7Cj4g
PiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiArCS8qCj4gPiA+ID4gPiA+ID4gPiA+
ICsJICogVGhlIGxlZ2FjeSBwY2kgZGV2aWNlIHJlcXVyZSAzMmJpdC1wZm4gdnEsCj4gPiA+ID4g
PiA+ID4gPiA+ICsJICogb3Igc2V0dXBfdnEoKSB3aWxsIGZhaWxlZC4KPiA+ID4gPiA+ID4gPiA+
ID4gKwkgKgo+ID4gPiA+ID4gPiA+ID4gPiArCSAqIFRodXMgd2UgbWFrZSBzdXJlIHZyaW5nX3Vz
ZV9kbWFfYXBpKCkgd2lsbAo+ID4gPiA+ID4gPiA+ID4gPiArCSAqIHJldHVybiB0cnVlIGR1cmlu
ZyB0aGUgYWxsb2NhdGlvbiBieSBtYXJraW5nCj4gPiA+ID4gPiA+ID4gPiA+ICsJICogZm9yY2Vf
ZG1hIGhlcmUuCj4gPiA+ID4gPiA+ID4gPiA+ICsJICovCj4gPiA+ID4gPiA+ID4gPiA+ICsJdnBf
ZGV2LT52ZGV2LmZvcmNlX2RtYSA9IHRydWU7Cj4gPiA+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAJcmV0dXJuIDA7Cj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+
ID4gPiAgICAgIGVycl9pb21hcDoKPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
PiA+ID4gPiA+ID4gPiA+IGluZGV4IDMwMzViYjYuLjY1NjJlMDEgMTAwNjQ0Cj4gPiA+ID4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+ID4gPiA+ID4gPiA+
ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiA+ID4gPiA+ID4gPiBA
QCAtMjQ1LDYgKzI0NSw5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2aXJ0cXVldWVfdXNlX2luZGly
ZWN0KHN0cnVjdAo+ID4gPiA+ID4gPiA+ID4gPiB2aXJ0cXVldWUgKl92cSwKPiA+ID4gPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgc3RhdGljIGJvb2wgdnJpbmdfdXNlX2RtYV9h
cGkoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgewo+
ID4gPiA+ID4gPiA+ID4gPiArCWlmICh2ZGV2LT5mb3JjZV9kbWEpCj4gPiA+ID4gPiA+ID4gPiA+
ICsJCXJldHVybiB0cnVlOwo+ID4gPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgCWlmICghdmlydGlvX2hhc19kbWFfcXVpcmsodmRldikpCj4gPiA+ID4gPiA+ID4gPiA+ICAg
ICAgCQlyZXR1cm4gdHJ1ZTsKPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8u
aAo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA0MWVkYmMwLi5hNGViMjlkIDEwMDY0NAo+ID4gPiA+
ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gPiA+ID4gPiA+ID4gPiA+
ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPiA+ID4gPiA+ID4gPiA+ID4gQEAgLTEwOSw2
ICsxMDksNyBAQCBzdHJ1Y3QgdmlydGlvX2RldmljZSB7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgICAg
CWJvb2wgZmFpbGVkOwo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIAlib29sIGNvbmZpZ19lbmFibGVk
Owo+ID4gPiA+ID4gPiA+ID4gPiAgICAgIAlib29sIGNvbmZpZ19jaGFuZ2VfcGVuZGluZzsKPiA+
ID4gPiA+ID4gPiA+ID4gKwlib29sIGZvcmNlX2RtYTsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJ
c3BpbmxvY2tfdCBjb25maWdfbG9jazsKPiA+ID4gPiA+ID4gPiA+ID4gICAgICAJc3BpbmxvY2tf
dCB2cXNfbGlzdF9sb2NrOyAvKiBQcm90ZWN0cyBWUXMgbGlzdCBhY2Nlc3MgKi8KPiA+ID4gPiA+
ID4gPiA+ID4gICAgICAJc3RydWN0IGRldmljZSBkZXY7Cj4gPiA+ID4gPiA+ID4gPiA+IC0tIAo+
ID4gPiA+ID4gPiA+ID4gPiAxLjguMy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
