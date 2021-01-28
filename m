Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D1C433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 06:15:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680B26146D
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 06:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680B26146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF66B86427;
	Thu, 28 Jan 2021 06:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7PXoFR2sasLo; Thu, 28 Jan 2021 06:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B969686398;
	Thu, 28 Jan 2021 06:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B5C0C08A1;
	Thu, 28 Jan 2021 06:15:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94FF4C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 06:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6E3FD2036B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 06:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-Ise0K7CWxo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 06:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 77E812033D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 06:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611814496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgRtHFrCUHDBzGNeWEeT3eYxAFV/0uXWAeAeQDDdkrU=;
 b=QaJgmygeng5OWwu/U3JfH0lnF/0GosFiGh4BzK0n5tpfgdYe6H8AEczvCHKAyQzxJCgKGY
 chf6YJgknkeaIi633R89ANf4wJruOVK6TIrNLZuOHgd77JqsHvOJQhCZ7eJ8ZkDscaxEJZ
 I4oViVSslOULgbcBLbbV3mxym7PzIlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-jJnOhnlyMCSfZeCJe8mhcw-1; Thu, 28 Jan 2021 01:14:52 -0500
X-MC-Unique: jJnOhnlyMCSfZeCJe8mhcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDA6C9CC00;
 Thu, 28 Jan 2021 06:14:49 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CB0560C13;
 Thu, 28 Jan 2021 06:14:34 +0000 (UTC)
Subject: Re: [RFC v3 08/11] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
 <20210119050756.600-1-xieyongji@bytedance.com>
 <20210119050756.600-2-xieyongji@bytedance.com>
 <1bb3af07-0ec2-109c-d6d1-83d4d1f410c3@redhat.com>
 <CACycT3uJtKqEp7CHBKhvmSL41gTrCcMrt_-tacGCbX1nabuG6w@mail.gmail.com>
 <ea170064-6fcf-133b-f3bd-d1f1862d4143@redhat.com>
 <CACycT3upvTrkm5Cd6KzphSk=FYDjAVCbFJ0CLmha5sP_h=5KGg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bdb57829-d4a4-eaca-d43b-70d39df96bf6@redhat.com>
Date: Thu, 28 Jan 2021 14:14:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3upvTrkm5Cd6KzphSk=FYDjAVCbFJ0CLmha5sP_h=5KGg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-aio@kvack.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgyOjAzLCBZb25namkgWGllIHdyb3RlOgo+Pj4+PiArCj4+Pj4+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyB2ZHVzZV9kb21haW5fZm9wcyA9
IHsKPj4+Pj4gKyAgICAgLm1tYXAgPSB2ZHVzZV9kb21haW5fbW1hcCwKPj4+Pj4gKyAgICAgLnJl
bGVhc2UgPSB2ZHVzZV9kb21haW5fcmVsZWFzZSwKPj4+Pj4gK307Cj4+Pj4gSXQncyBiZXR0ZXIg
dG8gZXhwbGFpbiB0aGUgcmVhc29uIGZvciBpbnRyb2R1Y2luZyBhIGRlZGljYXRlZCBmaWxlIGZv
cgo+Pj4+IG1tYXAoKSBoZXJlLgo+Pj4+Cj4+PiBUbyBtYWtlIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiBpb3ZhX2RvbWFpbiBpbmRlcGVuZGVudCB3aXRoIHZkdXNlX2Rldi4KPj4gTXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0LCB0aGUgb25seSB1c2FnZSBmb3IgdGhpcyBpcyB0bzoKPj4KPj4gMSkgc3Vw
cG9ydCBkaWZmZXJlbnQgdHlwZSBvZiBpb3ZhIG1hcHBpbmdzCj4+IDIpIG9yIHN3aXRjaCBiZXR3
ZWVuIGlvdmEgZG9tYWluIG1hcHBpbmdzCj4+Cj4+IEJ1dCBJIGNhbid0IHRoaW5rIG9mIGEgbmVl
ZCBmb3IgdGhpcy4KPj4KPiBGb3IgZXhhbXBsZSwgc2hhcmUgb25lIGlvdmFfZG9tYWluIGJldHdl
ZW4gc2V2ZXJhbCB2ZHVzZSBkZXZpY2VzLgoKCkludGVyZXN0aW5nLgoKCj4KPiBBbmQgaXQgd2ls
bCBiZSBoZWxwZnVsIGlmIHdlIHdhbnQgdG8gc3BsaXQgdGhpcyBwYXRjaCBpbnRvIGlvdmEgZG9t
YWluCj4gcGFydCBhbmQgdmR1c2UgZGV2aWNlIHBhcnQuIEJlY2F1c2UgdGhlIHBhZ2UgZmF1bHQg
aGFuZGxlciBzaG91bGQgYmUKPiBwYWlyZWQgd2l0aCBkbWFfbWFwL2RtYV91bm1hcC4KCgpPay4K
ClsuLi5dCgoKPgo+Pj4+IFRoaXMgbG9va3Mgbm90IHNhZmUsIGxldCdzIHVzZSBpZHIgaGVyZS4K
Pj4+Pgo+Pj4gQ291bGQgeW91IGdpdmUgbW9yZSBkZXRhaWxzPyBMb29rcyBsaWtlIGlkciBzaG91
bGQgbm90IHVzZWQgaW4gdGhpcwo+Pj4gY2FzZSB3aGljaCBjYW4gbm90IHRvbGVyYXRlIGZhaWx1
cmUuIEFuZCB1c2luZyBhIGxpc3QgdG8gc3RvcmUgdGhlIG1zZwo+Pj4gaXMgYmV0dGVyIHRoYW4g
dXNpbmcgaWRyIHdoZW4gdGhlIG1zZyBuZWVkcyB0byBiZSByZS1pbnNlcnRlZCBpbiBzb21lCj4+
PiBjYXNlcy4KPj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGUgInVuaXF1ZSIgKHByb2JhYmx5IG5l
ZWQgYSBiZXR0ZXIgbmFtZSkgaXMgYQo+PiB0b2tlbiB0aGF0IGlzIHVzZWQgdG8gdW5pcXVlbHkg
aWRlbnRpZnkgYSBtZXNzYWdlLiBUaGUgcmVwbHkgZnJvbQo+PiB1c2Vyc3BhY2UgaXMgcmVxdWly
ZWQgdG8gd3JpdGUgd2l0aCBleGFjdCB0aGUgc2FtZSB0b2tlbih1bmlxdWUpLiBJRFIKPj4gc2Vl
bXMgYmV0dGVyIGJ1dCBjb25zaWRlciB3ZSBjYW4gaGFyZGx5IGhpdCA2NGJpdCBvdmVyZmxvdywg
YXRvbWljIG1pZ2h0Cj4+IGJlIE9LIGFzIHdlbGwuCj4+Cj4+IEJ0dywgdW5kZXIgd2hhdCBjYXNl
IGRvIHdlIG5lZWQgdG8gZG8gInJlLWluc2VydGVkIj8KPj4KPiBXaGVuIHVzZXJzcGFjZSBkYWVt
b24gcmVjZWl2ZSB0aGUgbWVzc2FnZSBidXQgZG9lc24ndCByZXBseSBpdCBiZWZvcmUgY3Jhc2gu
CgoKRG8gd2UgaGF2ZSBjb2RlIHRvIGRvIHRoaXM/CgpbLi4uXQoKCj4KPj4+PiBTbyB3ZSBoYWQg
bXVsdGlwbGUgdHlwZXMgb2YgcmVxdWVzdHMvcmVzcG9uc2VzLCBpcyB0aGlzIGJldHRlciB0bwo+
Pj4+IGludHJvZHVjZSBhIHF1ZXVlIGJhc2VkIGFkbWluIGludGVyZmFjZSBvdGhlciB0aGFuIGlv
Y3RsPwo+Pj4+Cj4+PiBTb3JyeSwgSSBkaWRuJ3QgZ2V0IHlvdXIgcG9pbnQuIFdoYXQgZG8geW91
IG1lYW4gYnkgcXVldWUtYmFzZWQgYWRtaW4KPj4+IGludGVyZmFjZT8gVmlydHF1ZXVlLWJhc2Vk
Pwo+PiBZZXMsIGEgcXVldWUodmlydHF1ZXVlKS4gVGhlIGNvbW1hbmRzIGNvdWxkIGJlIHBhc3Nl
ZCB0aHJvdWdoIHRoZSBxdWV1ZS4KPj4gKEp1c3QgYW4gaWRlYSwgbm90IHN1cmUgaXQncyB3b3J0
aCkKPj4KPiBJIGNvbnNpZGVyZWQgaXQgYmVmb3JlLiBCdXQgSSBmb3VuZCBpdCBzdGlsbCBuZWVk
cyBzb21lIGV4dHJhIHdvcmtzCj4gKHNldHVwIGV2ZW50ZmQsIHNldCB2cmluZyBiYXNlIGFuZCBz
byBvbikgdG8gc2V0dXAgdGhlIGFkbWluIHZpcnRxdWV1ZQo+IGJlZm9yZSB1c2luZyBpdCBmb3Ig
Y29tbXVuaWNhdGlvbi4gU28gSSB0dXJuIHRvIHVzZSB0aGlzIHNpbXBsZSB3YXkuCgoKWWVzLiBX
ZSBtaWdodCBjb25zaWRlciBpdCBpbiB0aGUgZnV0dXJlLgoKWy4uLl0KCgo+Cj4+Pj4gQW55IHJl
YXNvbiBmb3Igc3VjaCBJT1RMQiBpbnZhbGlkYXRpb24gaGVyZT8KPj4+Pgo+Pj4gQXMgSSBtZW50
aW9uZWQgYmVmb3JlLCB0aGlzIGlzIHVzZWQgdG8gbm90aWZ5IHVzZXJzcGFjZSB0byB1cGRhdGUg
dGhlCj4+PiBJT1RMQi4gTWFpbmx5IGZvciB2aXJ0aW8tdmRwYSBjYXNlLgo+PiBTbyB0aGUgcXVl
c3Rpb24gaXMsIHVzdWFsbHksIHRoZXJlIGNvdWxkIGJlIHNldmVyYWwgdGltZXMgb2Ygc3RhdHVz
Cj4+IHNldHRpbmcgZHVyaW5nIGRyaXZlciBpbml0aWFsaXphdGlvbi4gRG8gd2UgcmVhbGx5IG5l
ZWQgdG8gdXBkYXRlIElPVExCCj4+IGV2ZXJ5IHRpbWU/Cj4+Cj4gSSB0aGluayB3ZSBjYW4gY2hl
Y2sgd2hldGhlciB0aGVyZSBhcmUgc29tZSBjaGFuZ2VzIGFmdGVyIHRoZSBsYXN0Cj4gSU9UTEIg
dXBkYXRpbmcgaGVyZS4KCgpTbyB0aGUgcXVlc3Rpb24gc3RpbGwsIGV4Y2VwdCByZXNldCAod3Jp
dGUgMCksIGFueSBvdGhlciBzdGF0dXMgdGhhdCBjYW4gCmFmZmVjdCBJT1RMQj8KClsuLi5dCgo+
Cj4+IFNvbWV0aGluZyBsaWtlIHN3aW90bGIgZGVmYXVsdCB2YWx1ZSAoNjRNKT8KPj4KPiBEbyB3
ZSBuZWVkIGEgbW9kdWxlIHBhcmFtZXRlciB0byBjaGFuZ2UgaXQ/CgoKV2UgY2FuLgoKWy4uLl0K
Cj4KPj4+Pj4gKyAgICAgdW5pb24gewo+Pj4+PiArICAgICAgICAgICAgIHN0cnVjdCB2ZHVzZV92
cV9udW0gdnFfbnVtOyAvKiB2aXJ0cXVldWUgbnVtICovCj4+Pj4+ICsgICAgICAgICAgICAgc3Ry
dWN0IHZkdXNlX3ZxX2FkZHIgdnFfYWRkcjsgLyogdmlydHF1ZXVlIGFkZHJlc3MgKi8KPj4+Pj4g
KyAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfdnFfcmVhZHkgdnFfcmVhZHk7IC8qIHZpcnRxdWV1
ZSByZWFkeSBzdGF0dXMgKi8KPj4+Pj4gKyAgICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfdnFfc3Rh
dGUgdnFfc3RhdGU7IC8qIHZpcnRxdWV1ZSBzdGF0ZSAqLwo+Pj4+PiArICAgICAgICAgICAgIHN0
cnVjdCB2ZHVzZV9kZXZfY29uZmlnX2RhdGEgY29uZmlnOyAvKiB2aXJ0aW8gZGV2aWNlIGNvbmZp
ZyBzcGFjZSAqLwo+Pj4+PiArICAgICAgICAgICAgIHN0cnVjdCB2ZHVzZV9pb3ZhX3JhbmdlIGlv
dmE7IC8qIGlvdmEgcmFuZ2UgZm9yIHVwZGF0aW5nICovCj4+Pj4+ICsgICAgICAgICAgICAgX191
NjQgZmVhdHVyZXM7IC8qIHZpcnRpbyBmZWF0dXJlcyAqLwo+Pj4+PiArICAgICAgICAgICAgIF9f
dTggc3RhdHVzOyAvKiBkZXZpY2Ugc3RhdHVzICovCj4+Pj4gTGV0J3MgYWRkIHNvbWUgcGFkZGlu
ZyBmb3IgZnV0dXJlIGV4dGVuc2lvbnMuCj4+Pj4KPj4+IElzIHNpemVvZih2ZHVzZV9kZXZfY29u
ZmlnX2RhdGEpIG9rPyBPciBjaGFyWzEwMjRdPwo+PiAxMDI0IHNlZW1zIHRvbyBsYXJnZSwgMTI4
IG9yIDI1NiBsb29rcyBiZXR0ZXIuCj4+Cj4gSWYgc28sIHNpemVvZih2ZHVzZV9kZXZfY29uZmln
X2RhdGEpIGlzIGVub3VnaC4KCgpPayBpZiB3ZSBkb24ndCBuZWVkIGEgbWVzc2FnZSBtb3JlIHRo
YW4gdGhhdCBpbiB0aGUgZnV0dXJlLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
