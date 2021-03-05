Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93649C433E6
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:01:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D3A64FD2
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D3A64FD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E72726F569;
	Fri,  5 Mar 2021 07:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzhGT3MJXWHf; Fri,  5 Mar 2021 07:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 765BC6F510;
	Fri,  5 Mar 2021 07:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CF69C000B;
	Fri,  5 Mar 2021 07:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D1DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3760C844D5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:01:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9MtMzvYVPzcc
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:01:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F0808442A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614927714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQk/Exv1XbZRWS+o6Mxm1eVPkotVmEcyq/oY4rVGxAw=;
 b=ETa6PSIBga+CH9POgTaljlotUmxFv1sGzJhjOjQBKDhfqdoJBiKYk2oNWLZbH61bSd6AUc
 HW10rVn0lPMBZWjh4KJKdps2DzP+eROX3Etc73X6xQ11icySaK2JKushrPB7PnSlfaxo7g
 Ys2RlJBixnQVta4LGVeBJpMA1kL+fSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-DC6JDHC-OBeLqxZYzHn40A-1; Fri, 05 Mar 2021 02:01:51 -0500
X-MC-Unique: DC6JDHC-OBeLqxZYzHn40A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 472E41937FDE;
 Fri,  5 Mar 2021 07:01:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-165.pek2.redhat.com
 [10.72.12.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FDEB5C1A1;
 Fri,  5 Mar 2021 07:01:34 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e933ec33-9d47-0ef5-9152-25cedd330ce2@redhat.com>
Date: Fri, 5 Mar 2021 15:01:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uZ2ZPjUwVZqzQPZ4ke=VrHCkfNvYagA-oxggPUEUi0Vg@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMy81IDI6MzYg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMTE6NDIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IE9uIDIwMjEvMy81IDExOjMwIOS4iuWNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+
IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMTE6MDUgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8zLzQgNDo1OCDkuIvljYgsIFlvbmdqaSBYaWUg
d3JvdGU6Cj4+Pj4+IE9uIFRodSwgTWFyIDQsIDIwMjEgYXQgMjo1OSBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIDIwMjEvMi8yMyA3OjUwIOS4i+WN
iCwgWGllIFlvbmdqaSB3cm90ZToKPj4+Pj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSB3b3Jr
cXVldWUgdG8gc3VwcG9ydCBpbmplY3RpbmcKPj4+Pj4+PiB2aXJ0cXVldWUncyBpbnRlcnJ1cHQg
YXN5bmNocm9ub3VzbHkuIFRoaXMgaXMgbWFpbmx5Cj4+Pj4+Pj4gZm9yIHBlcmZvcm1hbmNlIGNv
bnNpZGVyYXRpb25zIHdoaWNoIG1ha2VzIHN1cmUgdGhlIHB1c2goKQo+Pj4+Pj4+IGFuZCBwb3Ao
KSBmb3IgdXNlZCB2cmluZyBjYW4gYmUgYXN5bmNocm9ub3VzLgo+Pj4+Pj4gRG8geW91IGhhdmUg
cHJlZiBudW1iZXJzIGZvciB0aGlzIHBhdGNoPwo+Pj4+Pj4KPj4+Pj4gTm8sIEkgY2FuIGRvIHNv
bWUgdGVzdHMgZm9yIGl0IGlmIG5lZWRlZC4KPj4+Pj4KPj4+Pj4gQW5vdGhlciBwcm9ibGVtIGlz
IHRoZSBWSVJUSU9fUklOR19GX0VWRU5UX0lEWCBmZWF0dXJlIHdpbGwgYmUgdXNlbGVzcwo+Pj4+
PiBpZiB3ZSBjYWxsIGlycSBjYWxsYmFjayBpbiBpb2N0bCBjb250ZXh0LiBTb21ldGhpbmcgbGlr
ZToKPj4+Pj4KPj4+Pj4gdmlydHF1ZXVlX3B1c2goKTsKPj4+Pj4gdmlydGlvX25vdGlmeSgpOwo+
Pj4+PiAgICAgICAgaW9jdGwoKQo+Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4+Pj4+ICAgICAgICAgICAgaXJxX2NiKCkKPj4+Pj4gICAgICAg
ICAgICAgICAgdmlydHF1ZXVlX2dldF9idWYoKQo+Pj4+Pgo+Pj4+PiBUaGUgdXNlZCB2cmluZyBp
cyBhbHdheXMgZW1wdHkgZWFjaCB0aW1lIHdlIGNhbGwgdmlydHF1ZXVlX3B1c2goKSBpbgo+Pj4+
PiB1c2Vyc3BhY2UuIE5vdCBzdXJlIGlmIGl0IGlzIHdoYXQgd2UgZXhwZWN0ZWQuCj4+Pj4gSSdt
IG5vdCBzdXJlIEkgZ2V0IHRoZSBpc3N1ZS4KPj4+Pgo+Pj4+IFRIZSB1c2VkIHJpbmcgc2hvdWxk
IGJlIGZpbGxlZCBieSB2aXJ0cXVldWVfcHVzaCgpIHdoaWNoIGlzIGRvbmUgYnkKPj4+PiB1c2Vy
c3BhY2UgYmVmb3JlPwo+Pj4+Cj4+PiBBZnRlciB1c2Vyc3BhY2UgY2FsbCB2aXJ0cXVldWVfcHVz
aCgpLCBpdCBhbHdheXMgY2FsbCB2aXJ0aW9fbm90aWZ5KCkKPj4+IGltbWVkaWF0ZWx5LiBJbiB0
cmFkaXRpb25hbCBWTSAodmhvc3QtdmRwYSkgY2FzZXMsIHZpcnRpb19ub3RpZnkoKQo+Pj4gd2ls
bCBpbmplY3QgYW4gaXJxIHRvIFZNIGFuZCByZXR1cm4sIHRoZW4gdmNwdSB0aHJlYWQgd2lsbCBj
YWxsCj4+PiBpbnRlcnJ1cHQgaGFuZGxlci4gQnV0IGluIGNvbnRhaW5lciAodmlydGlvLXZkcGEp
IGNhc2VzLAo+Pj4gdmlydGlvX25vdGlmeSgpIHdpbGwgY2FsbCBpbnRlcnJ1cHQgaGFuZGxlciBk
aXJlY3RseS4gU28gaXQgbG9va3MgbGlrZQo+Pj4gd2UgaGF2ZSB0byBvcHRpbWl6ZSB0aGUgdmly
dGlvLXZkcGEgY2FzZXMuIEJ1dCBvbmUgcHJvYmxlbSBpcyB3ZSBkb24ndAo+Pj4ga25vdyB3aGV0
aGVyIHdlIGFyZSBpbiB0aGUgVk0gdXNlciBjYXNlIG9yIGNvbnRhaW5lciB1c2VyIGNhc2UuCj4+
Cj4+IFllcywgYnV0IEkgc3RpbGwgZG9uJ3QgZ2V0IHdoeSB1c2VkIHJpbmcgaXMgZW1wdHkgYWZ0
ZXIgdGhlIGlvY3RsKCk/Cj4+IFVzZWQgcmluZyBkb2VzIG5vdCB1c2UgYm91bmNlIHBhZ2Ugc28g
aXQgc2hvdWxkIGJlIHZpc2libGUgdG8gdGhlIGtlcm5lbAo+PiBkcml2ZXIuIFdoYXQgZGlkIEkg
bWlzcyA6KSA/Cj4+Cj4gU29ycnksIEknbSBub3Qgc2F5aW5nIHRoZSBrZXJuZWwgY2FuJ3Qgc2Vl
IHRoZSBjb3JyZWN0IHVzZWQgdnJpbmcuIEkKPiBtZWFuIHRoZSBrZXJuZWwgd2lsbCBjb25zdW1l
IHRoZSB1c2VkIHZyaW5nIGluIHRoZSBpb2N0bCBjb250ZXh0Cj4gZGlyZWN0bHkgaW4gdGhlIHZp
cnRpby12ZHBhIGNhc2UuIEluIHVzZXJzcGFjZSdzIHZpZXcsIHRoYXQgbWVhbnMKPiB2aXJ0cXVl
dWVfcHVzaCgpIGlzIHVzZWQgdnJpbmcncyBwcm9kdWNlciBhbmQgdmlydGlvX25vdGlmeSgpIGlz
IHVzZWQKPiB2cmluZydzIGNvbnN1bWVyLiBUaGV5IHdpbGwgYmUgY2FsbGVkIG9uZSBieSBvbmUg
aW4gb25lIHRocmVhZCByYXRoZXIKPiB0aGFuIGRpZmZlcmVudCB0aHJlYWRzLCB3aGljaCBsb29r
cyBvZGQgYW5kIGhhcyBhIGJhZCBlZmZlY3Qgb24KPiBwZXJmb3JtYW5jZS4KCgpZZXMsIHRoYXQn
cyB3aHkgd2UgbmVlZCBhIHdvcmtxdWV1ZSAoV1FfVU5CT1VORCB5b3UgdXNlZCkuIE9yIGRvIHlv
dSAKd2FudCB0byBzcXVhc2ggdGhpcyBwYXRjaCBpbnRvIHBhdGNoIDg/CgpTbyBJIHRoaW5rIHdl
IGNhbiBzZWUgb2J2aW91cyBkaWZmZXJlbmNlIHdoZW4gdmlydGlvLXZkcGEgaXMgdXNlZC4KClRo
YW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
