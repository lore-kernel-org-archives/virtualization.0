Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1461C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 07:04:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0118A64F96
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 07:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0118A64F96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EBEA430EF;
	Mon,  8 Mar 2021 07:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CY5TGOlPxc8u; Mon,  8 Mar 2021 07:04:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D824242FB5;
	Mon,  8 Mar 2021 07:04:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1D3EC000B;
	Mon,  8 Mar 2021 07:04:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C716C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3601E42FB5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id neWQEjJy6SMM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:04:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 412C2430ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 07:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615187069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nzo0gBDIUBxwZAv4o+4kKioscWKKFK2cbaFDxgnEqKA=;
 b=PVrEYVSvKaIBZxRl7v/asRlHqWAyCjUr740WnudKmQ60J843F07wyIulK1kRBsIAwNWff6
 Bk9jCEv9sbqEifZznrl6OV4AUup46kuM3cKPjaSrjJVHEE362QFucPAXt2xY1pwVJl9vne
 MVCglbcanIfaXi9u5YHNk/1BLWVSow4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-SHYYpOAEPryJIiwRYOEROw-1; Mon, 08 Mar 2021 02:04:24 -0500
X-MC-Unique: SHYYpOAEPryJIiwRYOEROw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A06980432E;
 Mon,  8 Mar 2021 07:04:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 133C01971C;
 Mon,  8 Mar 2021 07:04:06 +0000 (UTC)
Subject: Re: [RFC v4 06/11] vduse: Implement an MMU-based IOMMU driver
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-7-xieyongji@bytedance.com>
 <573ab913-55ce-045a-478f-1200bd78cf7b@redhat.com>
 <CACycT3sVhDKKu4zGbt1Lw-uWfKDAWs=O=C7kXXcuSnePohmBdQ@mail.gmail.com>
 <c173b7ec-8c90-d0e3-7272-a56aa8935e64@redhat.com>
 <CACycT3vb=WyrMpiOOdVDGEh8cEDb-xaj1esQx2UEQpJnOOWhmw@mail.gmail.com>
 <4db35f8c-ee3a-90fb-8d14-5d6014b4f6fa@redhat.com>
 <CACycT3sUJNmi2BdLsi3W72+qTKQaCo_nQYu-fdxg9y4pAvBMow@mail.gmail.com>
 <2652f696-faf7-26eb-a8b2-c4cfe3aaed15@redhat.com>
 <CACycT3uMV9wg5yVKmEJpbZrs3x0b4+b9eNcUTh3+CjxsG7x2LA@mail.gmail.com>
 <d4681614-bd1e-8fe7-3b03-72eb2011c3c2@redhat.com>
 <CACycT3uA5y=jcKPwu6rZ83Lqf1ytuPhnxWLCeMpDYrvRodHFVg@mail.gmail.com>
 <0b671aef-f2b2-6162-f407-7ca5178dbebb@redhat.com>
 <CACycT3tnd0SziHVpH=yUZFYpeG3c0V+vcGRNT19cp0q9b1GH2Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <48d0a363-4f55-bf99-3653-315458643317@redhat.com>
Date: Mon, 8 Mar 2021 15:04:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tnd0SziHVpH=yUZFYpeG3c0V+vcGRNT19cp0q9b1GH2Q@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Ck9uIDIwMjEvMy84IDE6MDUg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIE1vbiwgTWFy
IDgsIDIwMjEgYXQgMTE6NTIgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+Cj4+IE9uIDIwMjEvMy84IDExOjQ1IOS4iuWNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+
IE9uIE1vbiwgTWFyIDgsIDIwMjEgYXQgMTE6MTcgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8zLzUgMzo1OSDkuIvljYgsIFlvbmdqaSBYaWUg
d3JvdGU6Cj4+Pj4+IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMzoyNyBQTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIDIwMjEvMy81IDM6MTMg5LiL5Y2I
LCBZb25namkgWGllIHdyb3RlOgo+Pj4+Pj4+IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMjo1MiBQ
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4gT24gMjAy
MS8zLzUgMjoxNSDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFNv
cnJ5IGlmIEkndmUgYXNrZWQgdGhpcyBiZWZvcmUuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEJ1dCB3aGF0
J3MgdGhlIHJlYXNvbiBmb3IgbWFpbnRhaW5nIGEgZGVkaWNhdGVkIElPVExCIGhlcmU/IEkgdGhp
bmsgd2UKPj4+Pj4+Pj4gY291bGQgcmV1c2UgdmR1c2VfZGV2LT5pb21tdSBzaW5jZSB0aGUgZGV2
aWNlIGNhbiBub3QgYmUgdXNlZCBieSBib3RoCj4+Pj4+Pj4+IHZpcnRpbyBhbmQgdmhvc3QgaW4g
dGhlIHNhbWUgdGltZSBvciB1c2UgdmR1c2VfaW92YV9kb21haW4tPmlvdGxiIGZvcgo+Pj4+Pj4+
PiBzZXRfbWFwKCkuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFRoZSBtYWluIGRpZmZlcmVuY2UgYmV0d2Vl
biBkb21haW4tPmlvdGxiIGFuZCBkZXYtPmlvdGxiIGlzIHRoZSB3YXkgdG8KPj4+Pj4+Pj4gZGVh
bCB3aXRoIGJvdW5jZSBidWZmZXIuIEluIHRoZSBkb21haW4tPmlvdGxiIGNhc2UsIGJvdW5jZSBi
dWZmZXIKPj4+Pj4+Pj4gbmVlZHMgdG8gYmUgbWFwcGVkIGVhY2ggRE1BIHRyYW5zZmVyIGJlY2F1
c2Ugd2UgbmVlZCB0byBnZXQgdGhlIGJvdW5jZQo+Pj4+Pj4+PiBwYWdlcyBieSBhbiBJT1ZBIGR1
cmluZyBETUEgdW5tYXBwaW5nLiBJbiB0aGUgZGV2LT5pb3RsYiBjYXNlLCBib3VuY2UKPj4+Pj4+
Pj4gYnVmZmVyIG9ubHkgbmVlZHMgdG8gYmUgbWFwcGVkIG9uY2UgZHVyaW5nIGluaXRpYWxpemF0
aW9uLCB3aGljaCB3aWxsCj4+Pj4+Pj4+IGJlIHVzZWQgdG8gdGVsbCB1c2Vyc3BhY2UgaG93IHRv
IGRvIG1tYXAoKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQWxzbywgc2luY2Ugdmhvc3QgSU9UTEIgc3Vw
cG9ydCBwZXIgbWFwcGluZyB0b2tlbiAob3BhdXFlKSwgY2FuIHdlIHVzZQo+Pj4+Pj4+PiB0aGF0
IGluc3RlYWQgb2YgdGhlIGJvdW5jZV9wYWdlcyAqPwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTb3JyeSwg
SSBkaWRuJ3QgZ2V0IHlvdSBoZXJlLiBXaGljaCB2YWx1ZSBkbyB5b3UgbWVhbiB0byBzdG9yZSBp
biB0aGUKPj4+Pj4+Pj4gb3BhcXVlIHBvaW50ZXLvvJ8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gU28gSSB3
b3VsZCBsaWtlIHRvIGhhdmUgYSB3YXkgdG8gdXNlIGEgc2luZ2xlIElPVExCIGZvciBtYW5hZ2Ug
YWxsIGtpbmRzCj4+Pj4+Pj4+IG9mIG1hcHBpbmdzLiBUd28gcG9zc2libGUgaWRlYXM6Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IDEpIG1hcCBib3VuY2UgcGFnZSBvbmUgYnkgb25lIGluIHZkdXNlX2Rldl9t
YXBfcGFnZSgpLCBpbgo+Pj4+Pj4+PiBWRFVTRV9JT1RMQl9HRVRfRkQsIHRyeSB0byBtZXJnZSB0
aGUgcmVzdWx0IGlmIHdlIGhhZCB0aGUgc2FtZSBmZC4gVGhlbgo+Pj4+Pj4+PiBmb3IgYm91bmNl
IHBhZ2VzLCB1c2Vyc3BhY2Ugc3RpbGwgb25seSBuZWVkIHRvIG1hcCBpdCBvbmNlIGFuZCB3ZSBj
YW4KPj4+Pj4+Pj4gbWFpbnRhaW4gdGhlIGFjdHVhbCBtYXBwaW5nIGJ5IHN0b3JpbmcgdGhlIHBh
Z2Ugb3IgcGEgaW4gdGhlIG9wYXF1ZQo+Pj4+Pj4+PiBmaWVsZCBvZiBJT1RMQiBlbnRyeS4KPj4+
Pj4+Pj4KPj4+Pj4+Pj4gTG9va3MgbGlrZSB1c2Vyc3BhY2Ugc3RpbGwgbmVlZHMgdG8gdW5tYXAg
dGhlIG9sZCByZWdpb24gYW5kIG1hcCBhIG5ldwo+Pj4+Pj4+PiByZWdpb24gKHNpemUgaXMgY2hh
bmdlZCkgd2l0aCB0aGUgZmQgaW4gZWFjaCBWRFVTRV9JT1RMQl9HRVRfRkQgaW9jdGwuCj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEkgZG9uJ3QgZ2V0IGhlcmUuIENhbiB5b3UgZ2l2ZSBhbiBl
eGFtcGxlPwo+Pj4+Pj4+Pgo+Pj4+Pj4+IEZvciBleGFtcGxlLCB1c2Vyc3BhY2UgbmVlZHMgdG8g
cHJvY2VzcyB0d28gSS9PIHJlcXVlc3RzIChvbmUgcGFnZSBwZXIKPj4+Pj4+PiByZXF1ZXN0KS4g
VG8gcHJvY2VzcyB0aGUgZmlyc3QgcmVxdWVzdCwgdXNlcnNwYWNlIHVzZXMKPj4+Pj4+PiBWRFVT
RV9JT1RMQl9HRVRfRkQgaW9jdGwgdG8gcXVlcnkgdGhlIGlvdmEgcmVnaW9uICgwIH4gNDA5Nikg
YW5kIG1tYXAKPj4+Pj4+PiBpdC4KPj4+Pj4+IEkgdGhpbmsgaW4gdGhpcyBjYXNlIHdlIHNob3Vs
ZCBsZXQgVkRVU0VfSU9UTEJfR0VUX0ZEIHJldHVybiB0aGUgbWF4aW11bQo+Pj4+Pj4gcmFuZ2Ug
YXMgZmFyIGFzIHRoZXkgYXJlIGJhY2tlZCBieSB0aGUgc2FtZSBmZC4KPj4+Pj4+Cj4+Pj4+IEJ1
dCBub3cgdGhlIGJvdW5jZSBwYWdlIGlzIG1hcHBlZCBvbmUgYnkgb25lLiBUaGUgc2Vjb25kIHBh
Z2UgKDQwOTYgfgo+Pj4+PiA4MTkyKSBtaWdodCBub3QgYmUgbWFwcGVkIHdoZW4gdXNlcnNwYWNl
IGlzIHByb2Nlc3NpbmcgdGhlIGZpcnN0Cj4+Pj4+IHJlcXVlc3QuIFNvIHRoZSBtYXhpbXVtIHJh
bmdlIGlzIDAgfiA0MDk2IGF0IHRoYXQgdGltZS4KPj4+Pj4KPj4+Pj4gVGhhbmtzLAo+Pj4+PiBZ
b25namkKPj4+PiBBIHF1ZXN0aW9uLCBpZiBJIHJlYWQgdGhlIGNvZGUgY29ycmVjdGx5LCBWRFVT
RV9JT1RMQl9HRVRfRkQgd2lsbCByZXR1cm4KPj4+PiB0aGUgd2hvbGUgYm91bmNlIG1hcCByYW5n
ZSB3aGljaCBpcyBzZXR1cCBpbiB2ZHVzZV9kZXZfbWFwX3BhZ2UoKT8gU28gbXkKPj4+PiB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgdXNlcnNhcGNlIG1heSBjaG9vc2UgdG8gbWFwIGFsbCBpdHMgcmFu
Z2UgdmlhIG1tYXAoKS4KPj4+Pgo+Pj4gWWVzLgo+Pj4KPj4+PiBTbyBpZiB3ZSAnbWFwJyBib3Vu
Y2UgcGFnZSBvbmUgYnkgb25lIGluIHZkdXNlX2Rldl9tYXBfcGFnZSgpLiAoSGVyZQo+Pj4+ICdt
YXAnIG1lYW5zIHVzaW5nIG11bHRpcGxlIGl0cmVlIGVudHJpZXMgaW5zdGVhZCBvZiBhIHNpbmds
ZSBvbmUpLiBUaGVuCj4+Pj4gaW4gdGhlIFZEVVNFX0lPVExCX0dFVF9GRCB3ZSBjYW4ga2VlcCB0
cmF2ZXJzaW5nIGl0cmVlIChkZXYtPmlvbW11KQo+Pj4+IHVudGlsIHRoZSByYW5nZSBpcyBiYWNr
ZWQgYnkgYSBkaWZmZXJlbnQgZmlsZS4KPj4+Pgo+Pj4+IFdpdGggdGhpcywgdGhlcmUncyBubyB1
c2Vyc3BhY2UgdmlzaWJsZSBjaGFuZ2VzIGFuZCB0aGVyZSdzIG5vIG5lZWQgZm9yCj4+Pj4gdGhl
IGRvbWFpbi0+aW90bGI/Cj4+Pj4KPj4+IEluIHRoaXMgY2FzZSwgSSB3b25kZXIgd2hhdCByYW5n
ZSBjYW4gYmUgb2J0YWluZWQgaWYgdXNlcnNwYWNlIGNhbGxzCj4+PiBWRFVTRV9JT1RMQl9HRVRf
RkQgd2hlbiB0aGUgZmlyc3QgSS9PIChlLmcuIDRLKSBvY2N1cnMuIFswLCA0S10gb3IgWzAsCj4+
PiA2NE1dPyBJbiBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB1c2Vyc3BhY2Ugd2lsbCBtYXAgWzAs
IDY0TV0uCj4+Cj4+IEl0IHNob3VsZCBzdGlsbCBiZSBbMCwgNjRNKS4gRG8geW91IHNlZSBhbnkg
aXNzdWU/Cj4+Cj4gRG9lcyBpdCBtZWFuIHdlIHN0aWxsIG5lZWQgdG8gbWFwIHRoZSB3aG9sZSBi
b3VuY2UgYnVmZmVyIGludG8gaXRyZWUKPiAoZGV2LT5pb21tdSkgYXQgaW5pdGlhbGl6YXRpb24/
CgoKSXQncyB5b3VyIGNob2ljZSBJIHRoaW5rLCB0aGUgcG9pbnQgaXMgdG8gdXNlIGEgc2luZ2xl
IElPVExCIGZvciAKbWFpbnRhaW5pbmcgbWFwcGluZ3Mgb2YgYWxsIHR5cGVzIG9mIHBhZ2VzIChi
b3VuY2UsIGNvaGVyZW50LCBvciBzaGFyZWQpLgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25n
amkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
