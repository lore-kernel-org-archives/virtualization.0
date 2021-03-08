Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD7C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 07:30:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5547F64EEF
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 07:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5547F64EEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF83C60712;
	Mon,  8 Mar 2021 07:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFtDVMvOFVIl; Mon,  8 Mar 2021 07:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 693FB606F5;
	Mon,  8 Mar 2021 07:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E8B1C000A;
	Mon,  8 Mar 2021 07:30:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B009C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CA8360712
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwlFrrQbfDvN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:30:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71F53606F5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615188616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSowZP/H/N20kuwWMf0f/E//UBpn+jmFmDmmbPR2a7Q=;
 b=M8MWSESqm6oulwD9raSgTHRhPAGL8v0rQ6B6MwqrqtWi5VSkQB15mxEAtlOdZPZyRrb7IU
 numtjoAKL4n1Gsj05S82LtlJjlGlPWGyLfTd2eBZZLBr5W6Xf5KXRZwK3O5kxeWIexlRHY
 2wD0Yr8tk6QUBhmWgY5IGpHfyxK7+ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-JBdkdyovMXWHaYQ7w05D4w-1; Mon, 08 Mar 2021 02:30:14 -0500
X-MC-Unique: JBdkdyovMXWHaYQ7w05D4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19330101C8CF;
 Mon,  8 Mar 2021 07:30:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-143.pek2.redhat.com
 [10.72.12.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 074B760C17;
 Mon,  8 Mar 2021 07:29:54 +0000 (UTC)
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
 <44c21bf4-874d-24c9-334b-053c54e8422e@redhat.com>
 <CACycT3sZD2DEU=JxM-T+6dHBdsX5gOfAghh=Kg4PVw0PkNzEGw@mail.gmail.com>
 <a3ee164e-4de8-2305-ec4e-6eeef4aced29@redhat.com>
 <CACycT3stSn_ccZcpFd_NgNHB82FDsD3-9feJjMyf-yMOV0tXKw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16eb4c0e-50b1-5c9a-1d01-ea6cd7d09398@redhat.com>
Date: Mon, 8 Mar 2021 15:29:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3stSn_ccZcpFd_NgNHB82FDsD3-9feJjMyf-yMOV0tXKw@mail.gmail.com>
Content-Language: en-GB
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

Ck9uIDIwMjEvMy84IDM6MTYg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIE1vbiwgTWFy
IDgsIDIwMjEgYXQgMzowMiBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8zLzggMTI6NTAg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+Pj4g
T24gTW9uLCBNYXIgOCwgMjAyMSBhdCAxMTowNCBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIxLzMvNSA0OjEyIOS4i+WNiCwgWW9uZ2ppIFhpZSB3
cm90ZToKPj4+Pj4gT24gRnJpLCBNYXIgNSwgMjAyMSBhdCAzOjM3IFBNIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gMjAyMS8zLzUgMzoyNyDkuIvljYgs
IFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4gT24gRnJpLCBNYXIgNSwgMjAyMSBhdCAzOjAxIFBN
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+PiBPbiAyMDIx
LzMvNSAyOjM2IOS4i+WNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+Pj4+Pj4+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMTE6NDIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Pj4+Pj4+Pj4gT24gMjAyMS8zLzUgMTE6MzAg5LiK5Y2ILCBZb25namkgWGllIHdyb3Rl
Ogo+Pj4+Pj4+Pj4+PiBPbiBGcmksIE1hciA1LCAyMDIxIGF0IDExOjA1IEFNIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4gT24gMjAyMS8zLzQgNDo1
OCDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4gT24gVGh1LCBNYXIgNCwg
MjAyMSBhdCAyOjU5IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pj4+Pj4+Pj4+Pj4+PiBPbiAyMDIxLzIvMjMgNzo1MCDkuIvljYgsIFhpZSBZb25namkgd3JvdGU6
Cj4+Pj4+Pj4+Pj4+Pj4+PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSB3b3JrcXVldWUgdG8gc3Vw
cG9ydCBpbmplY3RpbmcKPj4+Pj4+Pj4+Pj4+Pj4+IHZpcnRxdWV1ZSdzIGludGVycnVwdCBhc3lu
Y2hyb25vdXNseS4gVGhpcyBpcyBtYWlubHkKPj4+Pj4+Pj4+Pj4+Pj4+IGZvciBwZXJmb3JtYW5j
ZSBjb25zaWRlcmF0aW9ucyB3aGljaCBtYWtlcyBzdXJlIHRoZSBwdXNoKCkKPj4+Pj4+Pj4+Pj4+
Pj4+IGFuZCBwb3AoKSBmb3IgdXNlZCB2cmluZyBjYW4gYmUgYXN5bmNocm9ub3VzLgo+Pj4+Pj4+
Pj4+Pj4+PiBEbyB5b3UgaGF2ZSBwcmVmIG51bWJlcnMgZm9yIHRoaXMgcGF0Y2g/Cj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gTm8sIEkgY2FuIGRvIHNvbWUgdGVzdHMgZm9yIGl0IGlmIG5l
ZWRlZC4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IEFub3RoZXIgcHJvYmxlbSBpcyB0aGUg
VklSVElPX1JJTkdfRl9FVkVOVF9JRFggZmVhdHVyZSB3aWxsIGJlIHVzZWxlc3MKPj4+Pj4+Pj4+
Pj4+PiBpZiB3ZSBjYWxsIGlycSBjYWxsYmFjayBpbiBpb2N0bCBjb250ZXh0LiBTb21ldGhpbmcg
bGlrZToKPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IHZpcnRxdWV1ZV9wdXNoKCk7Cj4+Pj4+
Pj4+Pj4+Pj4gdmlydGlvX25vdGlmeSgpOwo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgaW9jdGwo
KQo+Pj4+Pj4+Pj4+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICBpcnFfY2IoKQo+Pj4+Pj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZ2V0X2J1ZigpCj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+PiBUaGUgdXNlZCB2cmluZyBpcyBhbHdheXMgZW1wdHkgZWFjaCB0aW1lIHdl
IGNhbGwgdmlydHF1ZXVlX3B1c2goKSBpbgo+Pj4+Pj4+Pj4+Pj4+IHVzZXJzcGFjZS4gTm90IHN1
cmUgaWYgaXQgaXMgd2hhdCB3ZSBleHBlY3RlZC4KPj4+Pj4+Pj4+Pj4+IEknbSBub3Qgc3VyZSBJ
IGdldCB0aGUgaXNzdWUuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gVEhlIHVzZWQgcmluZyBz
aG91bGQgYmUgZmlsbGVkIGJ5IHZpcnRxdWV1ZV9wdXNoKCkgd2hpY2ggaXMgZG9uZSBieQo+Pj4+
Pj4+Pj4+Pj4gdXNlcnNwYWNlIGJlZm9yZT8KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEFmdGVy
IHVzZXJzcGFjZSBjYWxsIHZpcnRxdWV1ZV9wdXNoKCksIGl0IGFsd2F5cyBjYWxsIHZpcnRpb19u
b3RpZnkoKQo+Pj4+Pj4+Pj4+PiBpbW1lZGlhdGVseS4gSW4gdHJhZGl0aW9uYWwgVk0gKHZob3N0
LXZkcGEpIGNhc2VzLCB2aXJ0aW9fbm90aWZ5KCkKPj4+Pj4+Pj4+Pj4gd2lsbCBpbmplY3QgYW4g
aXJxIHRvIFZNIGFuZCByZXR1cm4sIHRoZW4gdmNwdSB0aHJlYWQgd2lsbCBjYWxsCj4+Pj4+Pj4+
Pj4+IGludGVycnVwdCBoYW5kbGVyLiBCdXQgaW4gY29udGFpbmVyICh2aXJ0aW8tdmRwYSkgY2Fz
ZXMsCj4+Pj4+Pj4+Pj4+IHZpcnRpb19ub3RpZnkoKSB3aWxsIGNhbGwgaW50ZXJydXB0IGhhbmRs
ZXIgZGlyZWN0bHkuIFNvIGl0IGxvb2tzIGxpa2UKPj4+Pj4+Pj4+Pj4gd2UgaGF2ZSB0byBvcHRp
bWl6ZSB0aGUgdmlydGlvLXZkcGEgY2FzZXMuIEJ1dCBvbmUgcHJvYmxlbSBpcyB3ZSBkb24ndAo+
Pj4+Pj4+Pj4+PiBrbm93IHdoZXRoZXIgd2UgYXJlIGluIHRoZSBWTSB1c2VyIGNhc2Ugb3IgY29u
dGFpbmVyIHVzZXIgY2FzZS4KPj4+Pj4+Pj4+PiBZZXMsIGJ1dCBJIHN0aWxsIGRvbid0IGdldCB3
aHkgdXNlZCByaW5nIGlzIGVtcHR5IGFmdGVyIHRoZSBpb2N0bCgpPwo+Pj4+Pj4+Pj4+IFVzZWQg
cmluZyBkb2VzIG5vdCB1c2UgYm91bmNlIHBhZ2Ugc28gaXQgc2hvdWxkIGJlIHZpc2libGUgdG8g
dGhlIGtlcm5lbAo+Pj4+Pj4+Pj4+IGRyaXZlci4gV2hhdCBkaWQgSSBtaXNzIDopID8KPj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4gU29ycnksIEknbSBub3Qgc2F5aW5nIHRoZSBrZXJuZWwgY2FuJ3Qgc2Vl
IHRoZSBjb3JyZWN0IHVzZWQgdnJpbmcuIEkKPj4+Pj4+Pj4+IG1lYW4gdGhlIGtlcm5lbCB3aWxs
IGNvbnN1bWUgdGhlIHVzZWQgdnJpbmcgaW4gdGhlIGlvY3RsIGNvbnRleHQKPj4+Pj4+Pj4+IGRp
cmVjdGx5IGluIHRoZSB2aXJ0aW8tdmRwYSBjYXNlLiBJbiB1c2Vyc3BhY2UncyB2aWV3LCB0aGF0
IG1lYW5zCj4+Pj4+Pj4+PiB2aXJ0cXVldWVfcHVzaCgpIGlzIHVzZWQgdnJpbmcncyBwcm9kdWNl
ciBhbmQgdmlydGlvX25vdGlmeSgpIGlzIHVzZWQKPj4+Pj4+Pj4+IHZyaW5nJ3MgY29uc3VtZXIu
IFRoZXkgd2lsbCBiZSBjYWxsZWQgb25lIGJ5IG9uZSBpbiBvbmUgdGhyZWFkIHJhdGhlcgo+Pj4+
Pj4+Pj4gdGhhbiBkaWZmZXJlbnQgdGhyZWFkcywgd2hpY2ggbG9va3Mgb2RkIGFuZCBoYXMgYSBi
YWQgZWZmZWN0IG9uCj4+Pj4+Pj4+PiBwZXJmb3JtYW5jZS4KPj4+Pj4+Pj4gWWVzLCB0aGF0J3Mg
d2h5IHdlIG5lZWQgYSB3b3JrcXVldWUgKFdRX1VOQk9VTkQgeW91IHVzZWQpLiBPciBkbyB5b3UK
Pj4+Pj4+Pj4gd2FudCB0byBzcXVhc2ggdGhpcyBwYXRjaCBpbnRvIHBhdGNoIDg/Cj4+Pj4+Pj4+
Cj4+Pj4+Pj4+IFNvIEkgdGhpbmsgd2UgY2FuIHNlZSBvYnZpb3VzIGRpZmZlcmVuY2Ugd2hlbiB2
aXJ0aW8tdmRwYSBpcyB1c2VkLgo+Pj4+Pj4+Pgo+Pj4+Pj4+IEJ1dCBpdCBsb29rcyBsaWtlIHdl
IGRvbid0IG5lZWQgdGhpcyB3b3JrcXVldWUgaW4gdmhvc3QtdmRwYSBjYXNlcy4KPj4+Pj4+PiBB
bnkgc3VnZ2VzdGlvbnM/Cj4+Pj4+PiBJIGhhdmVuJ3QgaGFkIGEgZGVlcCB0aG91Z2h0LiBCdXQg
SSBmZWVsIHdlIGNhbiBzb2x2ZSB0aGlzIGJ5IHVzaW5nIHRoZQo+Pj4+Pj4gaXJxIGJ5cGFzcyBt
YW5hZ2VyIChvciBzb21ldGhpbmcgc2ltaWxhcikuIFRoZW4gd2UgZG9uJ3QgbmVlZCBpdCB0byBi
ZQo+Pj4+Pj4gcmVsYXllZCB2aWEgd29ya3F1ZXVlIGFuZCB2ZHBhLiBCdXQgSSdtIG5vdCBzdXJl
IGhvdyBoYXJkIGl0IHdpbGwgYmUuCj4+Pj4+Pgo+Pj4+PiAgICAgT3IgbGV0IHZkcGEgYnVzIGRy
aXZlcnMgZ2l2ZSB1cyBzb21lIGluZm9ybWF0aW9uPwo+Pj4+IFRoaXMga2luZCBvZiAndHlwZScg
aXMgcHJvcG9zZWQgaW4gdGhlIGVhcmx5IFJGQyBvZiB2RFBBIHNlcmllcy4gT25lCj4+Pj4gaXNz
dWUgaXMgdGhhdCBhdCBkZXZpY2UgbGV2ZWwsIHdlIHNob3VsZCBub3QgZGlmZmVyIHZpcnRpbyBm
cm9tIHZob3N0LAo+Pj4+IHNvIGlmIHdlIGludHJvZHVjZSB0aGF0LCBpdCBtaWdodCBlbmNvdXJn
ZSBwZW9wbGUgdG8gZGVzaWduIGEgZGV2aWNlCj4+Pj4gdGhhdCBpcyBkZWRpY2F0ZWQgdG8gdmhv
c3Qgb3IgdmlydGlvIHdoaWNoIG1pZ2h0IG5vdCBiZSBnb29kLgo+Pj4+Cj4+Pj4gQnV0IHdlIGNh
biByZS12aXNpdCB0aGlzIHdoZW4gbmVjZXNzYXJ5Lgo+Pj4+Cj4+PiBPSywgSSBzZWUuIEhvdyBh
Ym91dCBhZGRpbmcgc29tZSBpbmZvcm1hdGlvbiBpbiBvcHMuc2V0X3ZxX2NiKCk/Cj4+Cj4+IEkn
bSBub3Qgc3VyZSBJIGdldCB0aGlzLCBtYXliZSB5b3UgY2FuIGV4cGxhaW4gYSBsaXR0bGUgYml0
IG1vcmU/Cj4+Cj4gRm9yIGV4YW1wbGUsIGFkZCBhbiBleHRyYSBwYXJhbWV0ZXIgZm9yIG9wcy5z
ZXRfdnFfY2IoKSB0byBpbmRpY2F0ZQo+IHdoZXRoZXIgdGhpcyBjYWxsYmFjayB3aWxsIHRyaWdn
ZXIgdGhlIGludGVycnVwdCBoYW5kbGVyIGRpcmVjdGx5LgoKClNvdW5kcyBpbnRlcnN0aW5nLiBJ
IHRoaW5rIGl0IG1heSB3b3JrLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
