Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F02EC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:04:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35046514A
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35046514A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AFAA4DC17;
	Mon,  8 Mar 2021 03:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LDuxH47B5dTS; Mon,  8 Mar 2021 03:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5AD04A254;
	Mon,  8 Mar 2021 03:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A40B6C000B;
	Mon,  8 Mar 2021 03:04:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E091C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68E078271A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sneaQz7EipIR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77CFE81D4F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615172690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQ70pDj5dEOXIb2t5wCoSU7jEwsufzOZ8z9pXIzIxMM=;
 b=ZRJlDWcuKsnzYq34ccZtOt+wcGn002rPXF9rZfg9QjsEC7Inu/U+R1pB2z0o7oHZOqPXoo
 3MTRwUtfrrptFpsZhJG32TV02GWcbbPmw2U5MO+0Wblxrn3k/mk1vIiV25Yxm9wUni11qu
 +HMtIenYDJfq8fPcLaaDQ8VoB+5Cf44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-uCwZu4jqOIGomMe_kzQ61Q-1; Sun, 07 Mar 2021 22:04:48 -0500
X-MC-Unique: uCwZu4jqOIGomMe_kzQ61Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB6AF5223;
 Mon,  8 Mar 2021 03:04:45 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99C8B5D9D0;
 Mon,  8 Mar 2021 03:04:33 +0000 (UTC)
Subject: Re: [RFC v4 10/11] vduse: Introduce a workqueue for irq injection
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-11-xieyongji@bytedance.com>
 <d63e4cfd-4992-8493-32b0-18e0478f6e1a@redhat.com>
 <CACycT3tqM=ALOG1r0Ve6UTGmwJ7Wg7fQpLZypjZsJF1mJ+adMA@mail.gmail.com>
 <2d3418d9-856c-37ee-7614-af5b721becd7@redhat.com>
 <CACycT3u0+LTbtFMS75grKGZ2mnXzHnKug+HGWbf+nqVybqwkZQ@mail.gmail.com>
 <b3faa4a6-a65b-faf7-985a-b2771533c8bb@redhat.com>
 <CACycT3uZ2ZPjUwVZqzQPZ4ke=VrHCkfNvYagA-oxggPUEUi0Vg@mail.gmail.com>
 <e933ec33-9d47-0ef5-9152-25cedd330ce2@redhat.com>
 <CACycT3ug30sQptdoSP8XzRJVN7Yb2DPLBtfG-RNbus3BOhdONA@mail.gmail.com>
 <b01d9ee7-b038-cef2-8996-cd6401003267@redhat.com>
 <CACycT3vSRvRUbqbPNjAPQ-TeXnbqtrQO+gD1M0qDRRqX1zovVA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <44c21bf4-874d-24c9-334b-053c54e8422e@redhat.com>
Date: Mon, 8 Mar 2021 11:04:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vSRvRUbqbPNjAPQ-TeXnbqtrQO+gD1M0qDRRqX1zovVA@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMy81IDQ6MTIg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMzozNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8zLzUgMzoyNyDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+PiBP
biBGcmksIE1hciA1LCAyMDIxIGF0IDM6MDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8zLzUgMjozNiDkuIvljYgsIFlvbmdqaSBYaWUgd3Jv
dGU6Cj4+Pj4+IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMTE6NDIgQU0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiAyMDIxLzMvNSAxMTozMCDkuIrljYgs
IFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4gT24gRnJpLCBNYXIgNSwgMjAyMSBhdCAxMTowNSBB
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4gT24gMjAy
MS8zLzQgNDo1OCDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBUaHUsIE1h
ciA0LCAyMDIxIGF0IDI6NTkgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Pj4+Pj4+Pj4gT24gMjAyMS8yLzIzIDc6NTAg5LiL5Y2ILCBYaWUgWW9uZ2ppIHdyb3Rl
Ogo+Pj4+Pj4+Pj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSB3b3JrcXVldWUgdG8gc3VwcG9y
dCBpbmplY3RpbmcKPj4+Pj4+Pj4+Pj4gdmlydHF1ZXVlJ3MgaW50ZXJydXB0IGFzeW5jaHJvbm91
c2x5LiBUaGlzIGlzIG1haW5seQo+Pj4+Pj4+Pj4+PiBmb3IgcGVyZm9ybWFuY2UgY29uc2lkZXJh
dGlvbnMgd2hpY2ggbWFrZXMgc3VyZSB0aGUgcHVzaCgpCj4+Pj4+Pj4+Pj4+IGFuZCBwb3AoKSBm
b3IgdXNlZCB2cmluZyBjYW4gYmUgYXN5bmNocm9ub3VzLgo+Pj4+Pj4+Pj4+IERvIHlvdSBoYXZl
IHByZWYgbnVtYmVycyBmb3IgdGhpcyBwYXRjaD8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gTm8sIEkg
Y2FuIGRvIHNvbWUgdGVzdHMgZm9yIGl0IGlmIG5lZWRlZC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBB
bm90aGVyIHByb2JsZW0gaXMgdGhlIFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYIGZlYXR1cmUgd2ls
bCBiZSB1c2VsZXNzCj4+Pj4+Pj4+PiBpZiB3ZSBjYWxsIGlycSBjYWxsYmFjayBpbiBpb2N0bCBj
b250ZXh0LiBTb21ldGhpbmcgbGlrZToKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiB2aXJ0cXVldWVfcHVz
aCgpOwo+Pj4+Pj4+Pj4gdmlydGlvX25vdGlmeSgpOwo+Pj4+Pj4+Pj4gICAgICAgICAgaW9jdGwo
KQo+Pj4+Pj4+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgIGlycV9jYigpCj4+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAgIHZpcnRxdWV1ZV9nZXRfYnVmKCkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGUgdXNlZCB2
cmluZyBpcyBhbHdheXMgZW1wdHkgZWFjaCB0aW1lIHdlIGNhbGwgdmlydHF1ZXVlX3B1c2goKSBp
bgo+Pj4+Pj4+Pj4gdXNlcnNwYWNlLiBOb3Qgc3VyZSBpZiBpdCBpcyB3aGF0IHdlIGV4cGVjdGVk
Lgo+Pj4+Pj4+PiBJJ20gbm90IHN1cmUgSSBnZXQgdGhlIGlzc3VlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiBUSGUgdXNlZCByaW5nIHNob3VsZCBiZSBmaWxsZWQgYnkgdmlydHF1ZXVlX3B1c2goKSB3aGlj
aCBpcyBkb25lIGJ5Cj4+Pj4+Pj4+IHVzZXJzcGFjZSBiZWZvcmU/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4g
QWZ0ZXIgdXNlcnNwYWNlIGNhbGwgdmlydHF1ZXVlX3B1c2goKSwgaXQgYWx3YXlzIGNhbGwgdmly
dGlvX25vdGlmeSgpCj4+Pj4+Pj4gaW1tZWRpYXRlbHkuIEluIHRyYWRpdGlvbmFsIFZNICh2aG9z
dC12ZHBhKSBjYXNlcywgdmlydGlvX25vdGlmeSgpCj4+Pj4+Pj4gd2lsbCBpbmplY3QgYW4gaXJx
IHRvIFZNIGFuZCByZXR1cm4sIHRoZW4gdmNwdSB0aHJlYWQgd2lsbCBjYWxsCj4+Pj4+Pj4gaW50
ZXJydXB0IGhhbmRsZXIuIEJ1dCBpbiBjb250YWluZXIgKHZpcnRpby12ZHBhKSBjYXNlcywKPj4+
Pj4+PiB2aXJ0aW9fbm90aWZ5KCkgd2lsbCBjYWxsIGludGVycnVwdCBoYW5kbGVyIGRpcmVjdGx5
LiBTbyBpdCBsb29rcyBsaWtlCj4+Pj4+Pj4gd2UgaGF2ZSB0byBvcHRpbWl6ZSB0aGUgdmlydGlv
LXZkcGEgY2FzZXMuIEJ1dCBvbmUgcHJvYmxlbSBpcyB3ZSBkb24ndAo+Pj4+Pj4+IGtub3cgd2hl
dGhlciB3ZSBhcmUgaW4gdGhlIFZNIHVzZXIgY2FzZSBvciBjb250YWluZXIgdXNlciBjYXNlLgo+
Pj4+Pj4gWWVzLCBidXQgSSBzdGlsbCBkb24ndCBnZXQgd2h5IHVzZWQgcmluZyBpcyBlbXB0eSBh
ZnRlciB0aGUgaW9jdGwoKT8KPj4+Pj4+IFVzZWQgcmluZyBkb2VzIG5vdCB1c2UgYm91bmNlIHBh
Z2Ugc28gaXQgc2hvdWxkIGJlIHZpc2libGUgdG8gdGhlIGtlcm5lbAo+Pj4+Pj4gZHJpdmVyLiBX
aGF0IGRpZCBJIG1pc3MgOikgPwo+Pj4+Pj4KPj4+Pj4gU29ycnksIEknbSBub3Qgc2F5aW5nIHRo
ZSBrZXJuZWwgY2FuJ3Qgc2VlIHRoZSBjb3JyZWN0IHVzZWQgdnJpbmcuIEkKPj4+Pj4gbWVhbiB0
aGUga2VybmVsIHdpbGwgY29uc3VtZSB0aGUgdXNlZCB2cmluZyBpbiB0aGUgaW9jdGwgY29udGV4
dAo+Pj4+PiBkaXJlY3RseSBpbiB0aGUgdmlydGlvLXZkcGEgY2FzZS4gSW4gdXNlcnNwYWNlJ3Mg
dmlldywgdGhhdCBtZWFucwo+Pj4+PiB2aXJ0cXVldWVfcHVzaCgpIGlzIHVzZWQgdnJpbmcncyBw
cm9kdWNlciBhbmQgdmlydGlvX25vdGlmeSgpIGlzIHVzZWQKPj4+Pj4gdnJpbmcncyBjb25zdW1l
ci4gVGhleSB3aWxsIGJlIGNhbGxlZCBvbmUgYnkgb25lIGluIG9uZSB0aHJlYWQgcmF0aGVyCj4+
Pj4+IHRoYW4gZGlmZmVyZW50IHRocmVhZHMsIHdoaWNoIGxvb2tzIG9kZCBhbmQgaGFzIGEgYmFk
IGVmZmVjdCBvbgo+Pj4+PiBwZXJmb3JtYW5jZS4KPj4+PiBZZXMsIHRoYXQncyB3aHkgd2UgbmVl
ZCBhIHdvcmtxdWV1ZSAoV1FfVU5CT1VORCB5b3UgdXNlZCkuIE9yIGRvIHlvdQo+Pj4+IHdhbnQg
dG8gc3F1YXNoIHRoaXMgcGF0Y2ggaW50byBwYXRjaCA4Pwo+Pj4+Cj4+Pj4gU28gSSB0aGluayB3
ZSBjYW4gc2VlIG9idmlvdXMgZGlmZmVyZW5jZSB3aGVuIHZpcnRpby12ZHBhIGlzIHVzZWQuCj4+
Pj4KPj4+IEJ1dCBpdCBsb29rcyBsaWtlIHdlIGRvbid0IG5lZWQgdGhpcyB3b3JrcXVldWUgaW4g
dmhvc3QtdmRwYSBjYXNlcy4KPj4+IEFueSBzdWdnZXN0aW9ucz8KPj4KPj4gSSBoYXZlbid0IGhh
ZCBhIGRlZXAgdGhvdWdodC4gQnV0IEkgZmVlbCB3ZSBjYW4gc29sdmUgdGhpcyBieSB1c2luZyB0
aGUKPj4gaXJxIGJ5cGFzcyBtYW5hZ2VyIChvciBzb21ldGhpbmcgc2ltaWxhcikuIFRoZW4gd2Ug
ZG9uJ3QgbmVlZCBpdCB0byBiZQo+PiByZWxheWVkIHZpYSB3b3JrcXVldWUgYW5kIHZkcGEuIEJ1
dCBJJ20gbm90IHN1cmUgaG93IGhhcmQgaXQgd2lsbCBiZS4KPj4KPiAgIE9yIGxldCB2ZHBhIGJ1
cyBkcml2ZXJzIGdpdmUgdXMgc29tZSBpbmZvcm1hdGlvbj8KCgpUaGlzIGtpbmQgb2YgJ3R5cGUn
IGlzIHByb3Bvc2VkIGluIHRoZSBlYXJseSBSRkMgb2YgdkRQQSBzZXJpZXMuIE9uZSAKaXNzdWUg
aXMgdGhhdCBhdCBkZXZpY2UgbGV2ZWwsIHdlIHNob3VsZCBub3QgZGlmZmVyIHZpcnRpbyBmcm9t
IHZob3N0LCAKc28gaWYgd2UgaW50cm9kdWNlIHRoYXQsIGl0IG1pZ2h0IGVuY291cmdlIHBlb3Bs
ZSB0byBkZXNpZ24gYSBkZXZpY2UgCnRoYXQgaXMgZGVkaWNhdGVkIHRvIHZob3N0IG9yIHZpcnRp
byB3aGljaCBtaWdodCBub3QgYmUgZ29vZC4KCkJ1dCB3ZSBjYW4gcmUtdmlzaXQgdGhpcyB3aGVu
IG5lY2Vzc2FyeS4KClRoYW5rcwoKCj4KPj4gRG8geW91IHNlZSBhbnkgb2J2aW91cyBwZXJmb3Jt
YW5jZSByZWdyZXNzaW9uIGJ5IHVzaW5nIHRoZSB3b3JrcXVldWU/IE9yCj4+IHdlIGNhbiBvcHRp
bWl6ZSBpdCBpbiB0aGUgZnV0dXJlLgo+Pgo+IEFncmVlLgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
