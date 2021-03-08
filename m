Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9A7C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:52:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227964E31
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227964E31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E50DC4EB7C;
	Mon,  8 Mar 2021 03:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kx-zMsLpMDmY; Mon,  8 Mar 2021 03:52:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F6044E818;
	Mon,  8 Mar 2021 03:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C62E1C000B;
	Mon,  8 Mar 2021 03:52:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15154C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F14FC839E6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMudgsAVh4c2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:52:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFB15839D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615175556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OP4kccBNuIaQsN5I0VY9ytv90sErY1jOtk/EQYsNhVw=;
 b=b5OOPBzyN8p7odKe6mxwr3hjl7SZpUB/mUl77ZfmQGD5QDTaUSOmSB4zd9HtCgYmtO4Pm+
 7L/SY5QFvIbate9Es8X+fK5580Y7hprMy/oKjpeH5MPJRYmCf7+Wpb640Pi4MF5wk9WuCO
 YMSoe99ygYV5HBhbhMaZKIslaWBmfwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-LG240a0FP0C59yQxi0CucA-1; Sun, 07 Mar 2021 22:52:34 -0500
X-MC-Unique: LG240a0FP0C59yQxi0CucA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E7A781431C;
 Mon,  8 Mar 2021 03:52:32 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18D5260BF1;
 Mon,  8 Mar 2021 03:52:19 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0b671aef-f2b2-6162-f407-7ca5178dbebb@redhat.com>
Date: Mon, 8 Mar 2021 11:52:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uA5y=jcKPwu6rZ83Lqf1ytuPhnxWLCeMpDYrvRodHFVg@mail.gmail.com>
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

Ck9uIDIwMjEvMy84IDExOjQ1IOS4iuWNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBNb24sIE1h
ciA4LCAyMDIxIGF0IDExOjE3IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIxLzMvNSAzOjU5IOS4i+WNiCwgWW9uZ2ppIFhpZSB3cm90ZToKPj4+
IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgMzoyNyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIxLzMvNSAzOjEzIOS4i+WNiCwgWW9uZ2ppIFhpZSB3
cm90ZToKPj4+Pj4gT24gRnJpLCBNYXIgNSwgMjAyMSBhdCAyOjUyIFBNIEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gMjAyMS8zLzUgMjoxNSDkuIvljYgs
IFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gU29ycnkgaWYgSSd2ZSBhc2tlZCB0aGlz
IGJlZm9yZS4KPj4+Pj4+Cj4+Pj4+PiBCdXQgd2hhdCdzIHRoZSByZWFzb24gZm9yIG1haW50YWlu
ZyBhIGRlZGljYXRlZCBJT1RMQiBoZXJlPyBJIHRoaW5rIHdlCj4+Pj4+PiBjb3VsZCByZXVzZSB2
ZHVzZV9kZXYtPmlvbW11IHNpbmNlIHRoZSBkZXZpY2UgY2FuIG5vdCBiZSB1c2VkIGJ5IGJvdGgK
Pj4+Pj4+IHZpcnRpbyBhbmQgdmhvc3QgaW4gdGhlIHNhbWUgdGltZSBvciB1c2UgdmR1c2VfaW92
YV9kb21haW4tPmlvdGxiIGZvcgo+Pj4+Pj4gc2V0X21hcCgpLgo+Pj4+Pj4KPj4+Pj4+IFRoZSBt
YWluIGRpZmZlcmVuY2UgYmV0d2VlbiBkb21haW4tPmlvdGxiIGFuZCBkZXYtPmlvdGxiIGlzIHRo
ZSB3YXkgdG8KPj4+Pj4+IGRlYWwgd2l0aCBib3VuY2UgYnVmZmVyLiBJbiB0aGUgZG9tYWluLT5p
b3RsYiBjYXNlLCBib3VuY2UgYnVmZmVyCj4+Pj4+PiBuZWVkcyB0byBiZSBtYXBwZWQgZWFjaCBE
TUEgdHJhbnNmZXIgYmVjYXVzZSB3ZSBuZWVkIHRvIGdldCB0aGUgYm91bmNlCj4+Pj4+PiBwYWdl
cyBieSBhbiBJT1ZBIGR1cmluZyBETUEgdW5tYXBwaW5nLiBJbiB0aGUgZGV2LT5pb3RsYiBjYXNl
LCBib3VuY2UKPj4+Pj4+IGJ1ZmZlciBvbmx5IG5lZWRzIHRvIGJlIG1hcHBlZCBvbmNlIGR1cmlu
ZyBpbml0aWFsaXphdGlvbiwgd2hpY2ggd2lsbAo+Pj4+Pj4gYmUgdXNlZCB0byB0ZWxsIHVzZXJz
cGFjZSBob3cgdG8gZG8gbW1hcCgpLgo+Pj4+Pj4KPj4+Pj4+IEFsc28sIHNpbmNlIHZob3N0IElP
VExCIHN1cHBvcnQgcGVyIG1hcHBpbmcgdG9rZW4gKG9wYXVxZSksIGNhbiB3ZSB1c2UKPj4+Pj4+
IHRoYXQgaW5zdGVhZCBvZiB0aGUgYm91bmNlX3BhZ2VzICo/Cj4+Pj4+Pgo+Pj4+Pj4gU29ycnks
IEkgZGlkbid0IGdldCB5b3UgaGVyZS4gV2hpY2ggdmFsdWUgZG8geW91IG1lYW4gdG8gc3RvcmUg
aW4gdGhlCj4+Pj4+PiBvcGFxdWUgcG9pbnRlcu+8nwo+Pj4+Pj4KPj4+Pj4+IFNvIEkgd291bGQg
bGlrZSB0byBoYXZlIGEgd2F5IHRvIHVzZSBhIHNpbmdsZSBJT1RMQiBmb3IgbWFuYWdlIGFsbCBr
aW5kcwo+Pj4+Pj4gb2YgbWFwcGluZ3MuIFR3byBwb3NzaWJsZSBpZGVhczoKPj4+Pj4+Cj4+Pj4+
PiAxKSBtYXAgYm91bmNlIHBhZ2Ugb25lIGJ5IG9uZSBpbiB2ZHVzZV9kZXZfbWFwX3BhZ2UoKSwg
aW4KPj4+Pj4+IFZEVVNFX0lPVExCX0dFVF9GRCwgdHJ5IHRvIG1lcmdlIHRoZSByZXN1bHQgaWYg
d2UgaGFkIHRoZSBzYW1lIGZkLiBUaGVuCj4+Pj4+PiBmb3IgYm91bmNlIHBhZ2VzLCB1c2Vyc3Bh
Y2Ugc3RpbGwgb25seSBuZWVkIHRvIG1hcCBpdCBvbmNlIGFuZCB3ZSBjYW4KPj4+Pj4+IG1haW50
YWluIHRoZSBhY3R1YWwgbWFwcGluZyBieSBzdG9yaW5nIHRoZSBwYWdlIG9yIHBhIGluIHRoZSBv
cGFxdWUKPj4+Pj4+IGZpZWxkIG9mIElPVExCIGVudHJ5Lgo+Pj4+Pj4KPj4+Pj4+IExvb2tzIGxp
a2UgdXNlcnNwYWNlIHN0aWxsIG5lZWRzIHRvIHVubWFwIHRoZSBvbGQgcmVnaW9uIGFuZCBtYXAg
YSBuZXcKPj4+Pj4+IHJlZ2lvbiAoc2l6ZSBpcyBjaGFuZ2VkKSB3aXRoIHRoZSBmZCBpbiBlYWNo
IFZEVVNFX0lPVExCX0dFVF9GRCBpb2N0bC4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gSSBkb24ndCBn
ZXQgaGVyZS4gQ2FuIHlvdSBnaXZlIGFuIGV4YW1wbGU/Cj4+Pj4+Pgo+Pj4+PiBGb3IgZXhhbXBs
ZSwgdXNlcnNwYWNlIG5lZWRzIHRvIHByb2Nlc3MgdHdvIEkvTyByZXF1ZXN0cyAob25lIHBhZ2Ug
cGVyCj4+Pj4+IHJlcXVlc3QpLiBUbyBwcm9jZXNzIHRoZSBmaXJzdCByZXF1ZXN0LCB1c2Vyc3Bh
Y2UgdXNlcwo+Pj4+PiBWRFVTRV9JT1RMQl9HRVRfRkQgaW9jdGwgdG8gcXVlcnkgdGhlIGlvdmEg
cmVnaW9uICgwIH4gNDA5NikgYW5kIG1tYXAKPj4+Pj4gaXQuCj4+Pj4gSSB0aGluayBpbiB0aGlz
IGNhc2Ugd2Ugc2hvdWxkIGxldCBWRFVTRV9JT1RMQl9HRVRfRkQgcmV0dXJuIHRoZSBtYXhpbXVt
Cj4+Pj4gcmFuZ2UgYXMgZmFyIGFzIHRoZXkgYXJlIGJhY2tlZCBieSB0aGUgc2FtZSBmZC4KPj4+
Pgo+Pj4gQnV0IG5vdyB0aGUgYm91bmNlIHBhZ2UgaXMgbWFwcGVkIG9uZSBieSBvbmUuIFRoZSBz
ZWNvbmQgcGFnZSAoNDA5NiB+Cj4+PiA4MTkyKSBtaWdodCBub3QgYmUgbWFwcGVkIHdoZW4gdXNl
cnNwYWNlIGlzIHByb2Nlc3NpbmcgdGhlIGZpcnN0Cj4+PiByZXF1ZXN0LiBTbyB0aGUgbWF4aW11
bSByYW5nZSBpcyAwIH4gNDA5NiBhdCB0aGF0IHRpbWUuCj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gWW9u
Z2ppCj4+Cj4+IEEgcXVlc3Rpb24sIGlmIEkgcmVhZCB0aGUgY29kZSBjb3JyZWN0bHksIFZEVVNF
X0lPVExCX0dFVF9GRCB3aWxsIHJldHVybgo+PiB0aGUgd2hvbGUgYm91bmNlIG1hcCByYW5nZSB3
aGljaCBpcyBzZXR1cCBpbiB2ZHVzZV9kZXZfbWFwX3BhZ2UoKT8gU28gbXkKPj4gdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IHVzZXJzYXBjZSBtYXkgY2hvb3NlIHRvIG1hcCBhbGwgaXRzIHJhbmdlIHZp
YSBtbWFwKCkuCj4+Cj4gWWVzLgo+Cj4+IFNvIGlmIHdlICdtYXAnIGJvdW5jZSBwYWdlIG9uZSBi
eSBvbmUgaW4gdmR1c2VfZGV2X21hcF9wYWdlKCkuIChIZXJlCj4+ICdtYXAnIG1lYW5zIHVzaW5n
IG11bHRpcGxlIGl0cmVlIGVudHJpZXMgaW5zdGVhZCBvZiBhIHNpbmdsZSBvbmUpLiBUaGVuCj4+
IGluIHRoZSBWRFVTRV9JT1RMQl9HRVRfRkQgd2UgY2FuIGtlZXAgdHJhdmVyc2luZyBpdHJlZSAo
ZGV2LT5pb21tdSkKPj4gdW50aWwgdGhlIHJhbmdlIGlzIGJhY2tlZCBieSBhIGRpZmZlcmVudCBm
aWxlLgo+Pgo+PiBXaXRoIHRoaXMsIHRoZXJlJ3Mgbm8gdXNlcnNwYWNlIHZpc2libGUgY2hhbmdl
cyBhbmQgdGhlcmUncyBubyBuZWVkIGZvcgo+PiB0aGUgZG9tYWluLT5pb3RsYj8KPj4KPiBJbiB0
aGlzIGNhc2UsIEkgd29uZGVyIHdoYXQgcmFuZ2UgY2FuIGJlIG9idGFpbmVkIGlmIHVzZXJzcGFj
ZSBjYWxscwo+IFZEVVNFX0lPVExCX0dFVF9GRCB3aGVuIHRoZSBmaXJzdCBJL08gKGUuZy4gNEsp
IG9jY3Vycy4gWzAsIDRLXSBvciBbMCwKPiA2NE1dPyBJbiBjdXJyZW50IGltcGxlbWVudGF0aW9u
LCB1c2Vyc3BhY2Ugd2lsbCBtYXAgWzAsIDY0TV0uCgoKSXQgc2hvdWxkIHN0aWxsIGJlIFswLCA2
NE0pLiBEbyB5b3Ugc2VlIGFueSBpc3N1ZT8KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2pp
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
