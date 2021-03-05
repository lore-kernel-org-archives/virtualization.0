Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F37BC433E6
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:37:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07AE64FE6
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07AE64FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 641904314A;
	Fri,  5 Mar 2021 07:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9L-Y_vYeovEx; Fri,  5 Mar 2021 07:37:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0EF6943095;
	Fri,  5 Mar 2021 07:37:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1A78C000A;
	Fri,  5 Mar 2021 07:37:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF75FC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C66116F510
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHSgwmHpuLaf
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:37:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD4AF6F506
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614929833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zckMKEYr1zLlnl+M28V4/wViPEezLVE4dC4UmG7LvNs=;
 b=XB3BO+jB+c5QPprp3Gq0zNpOTnyzAXrMkiQq3w9fKX2fBJja+QTRK1xZwYsTPjniZvOnuH
 fn9sLPTsY4pUtQ+p3HIanGB7y1tnuXFxwtOqzeUR5aabwUGdas5oNPie+qsa/4oIAjZrJg
 +2koXaUA1o5BCrv3Ses70wpviWAWNUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-asz0IBm8PGe-BoaTg01i8Q-1; Fri, 05 Mar 2021 02:37:12 -0500
X-MC-Unique: asz0IBm8PGe-BoaTg01i8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C63108BD07;
 Fri,  5 Mar 2021 07:37:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-165.pek2.redhat.com
 [10.72.12.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A17E1F413;
 Fri,  5 Mar 2021 07:36:53 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b01d9ee7-b038-cef2-8996-cd6401003267@redhat.com>
Date: Fri, 5 Mar 2021 15:36:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3ug30sQptdoSP8XzRJVN7Yb2DPLBtfG-RNbus3BOhdONA@mail.gmail.com>
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

Ck9uIDIwMjEvMy81IDM6Mjcg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMzowMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8zLzUgMjozNiDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+PiBP
biBGcmksIE1hciA1LCAyMDIxIGF0IDExOjQyIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjEvMy81IDExOjMwIOS4iuWNiCwgWW9uZ2ppIFhpZSB3
cm90ZToKPj4+Pj4gT24gRnJpLCBNYXIgNSwgMjAyMSBhdCAxMTowNSBBTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIDIwMjEvMy80IDQ6NTgg5LiL5Y2I
LCBZb25namkgWGllIHdyb3RlOgo+Pj4+Pj4+IE9uIFRodSwgTWFyIDQsIDIwMjEgYXQgMjo1OSBQ
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4gT24gMjAy
MS8yLzIzIDc6NTAg5LiL5Y2ILCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4+Pj4+Pj4gVGhpcyBwYXRj
aCBpbnRyb2R1Y2VzIGEgd29ya3F1ZXVlIHRvIHN1cHBvcnQgaW5qZWN0aW5nCj4+Pj4+Pj4+PiB2
aXJ0cXVldWUncyBpbnRlcnJ1cHQgYXN5bmNocm9ub3VzbHkuIFRoaXMgaXMgbWFpbmx5Cj4+Pj4+
Pj4+PiBmb3IgcGVyZm9ybWFuY2UgY29uc2lkZXJhdGlvbnMgd2hpY2ggbWFrZXMgc3VyZSB0aGUg
cHVzaCgpCj4+Pj4+Pj4+PiBhbmQgcG9wKCkgZm9yIHVzZWQgdnJpbmcgY2FuIGJlIGFzeW5jaHJv
bm91cy4KPj4+Pj4+Pj4gRG8geW91IGhhdmUgcHJlZiBudW1iZXJzIGZvciB0aGlzIHBhdGNoPwo+
Pj4+Pj4+Pgo+Pj4+Pj4+IE5vLCBJIGNhbiBkbyBzb21lIHRlc3RzIGZvciBpdCBpZiBuZWVkZWQu
Cj4+Pj4+Pj4KPj4+Pj4+PiBBbm90aGVyIHByb2JsZW0gaXMgdGhlIFZJUlRJT19SSU5HX0ZfRVZF
TlRfSURYIGZlYXR1cmUgd2lsbCBiZSB1c2VsZXNzCj4+Pj4+Pj4gaWYgd2UgY2FsbCBpcnEgY2Fs
bGJhY2sgaW4gaW9jdGwgY29udGV4dC4gU29tZXRoaW5nIGxpa2U6Cj4+Pj4+Pj4KPj4+Pj4+PiB2
aXJ0cXVldWVfcHVzaCgpOwo+Pj4+Pj4+IHZpcnRpb19ub3RpZnkoKTsKPj4+Pj4+PiAgICAgICAg
IGlvY3RsKCkKPj4+Pj4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4+Pj4+Pj4gICAgICAgICAgICAgaXJxX2NiKCkKPj4+Pj4+PiAgICAgICAgICAg
ICAgICAgdmlydHF1ZXVlX2dldF9idWYoKQo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhlIHVzZWQgdnJpbmcg
aXMgYWx3YXlzIGVtcHR5IGVhY2ggdGltZSB3ZSBjYWxsIHZpcnRxdWV1ZV9wdXNoKCkgaW4KPj4+
Pj4+PiB1c2Vyc3BhY2UuIE5vdCBzdXJlIGlmIGl0IGlzIHdoYXQgd2UgZXhwZWN0ZWQuCj4+Pj4+
PiBJJ20gbm90IHN1cmUgSSBnZXQgdGhlIGlzc3VlLgo+Pj4+Pj4KPj4+Pj4+IFRIZSB1c2VkIHJp
bmcgc2hvdWxkIGJlIGZpbGxlZCBieSB2aXJ0cXVldWVfcHVzaCgpIHdoaWNoIGlzIGRvbmUgYnkK
Pj4+Pj4+IHVzZXJzcGFjZSBiZWZvcmU/Cj4+Pj4+Pgo+Pj4+PiBBZnRlciB1c2Vyc3BhY2UgY2Fs
bCB2aXJ0cXVldWVfcHVzaCgpLCBpdCBhbHdheXMgY2FsbCB2aXJ0aW9fbm90aWZ5KCkKPj4+Pj4g
aW1tZWRpYXRlbHkuIEluIHRyYWRpdGlvbmFsIFZNICh2aG9zdC12ZHBhKSBjYXNlcywgdmlydGlv
X25vdGlmeSgpCj4+Pj4+IHdpbGwgaW5qZWN0IGFuIGlycSB0byBWTSBhbmQgcmV0dXJuLCB0aGVu
IHZjcHUgdGhyZWFkIHdpbGwgY2FsbAo+Pj4+PiBpbnRlcnJ1cHQgaGFuZGxlci4gQnV0IGluIGNv
bnRhaW5lciAodmlydGlvLXZkcGEpIGNhc2VzLAo+Pj4+PiB2aXJ0aW9fbm90aWZ5KCkgd2lsbCBj
YWxsIGludGVycnVwdCBoYW5kbGVyIGRpcmVjdGx5LiBTbyBpdCBsb29rcyBsaWtlCj4+Pj4+IHdl
IGhhdmUgdG8gb3B0aW1pemUgdGhlIHZpcnRpby12ZHBhIGNhc2VzLiBCdXQgb25lIHByb2JsZW0g
aXMgd2UgZG9uJ3QKPj4+Pj4ga25vdyB3aGV0aGVyIHdlIGFyZSBpbiB0aGUgVk0gdXNlciBjYXNl
IG9yIGNvbnRhaW5lciB1c2VyIGNhc2UuCj4+Pj4gWWVzLCBidXQgSSBzdGlsbCBkb24ndCBnZXQg
d2h5IHVzZWQgcmluZyBpcyBlbXB0eSBhZnRlciB0aGUgaW9jdGwoKT8KPj4+PiBVc2VkIHJpbmcg
ZG9lcyBub3QgdXNlIGJvdW5jZSBwYWdlIHNvIGl0IHNob3VsZCBiZSB2aXNpYmxlIHRvIHRoZSBr
ZXJuZWwKPj4+PiBkcml2ZXIuIFdoYXQgZGlkIEkgbWlzcyA6KSA/Cj4+Pj4KPj4+IFNvcnJ5LCBJ
J20gbm90IHNheWluZyB0aGUga2VybmVsIGNhbid0IHNlZSB0aGUgY29ycmVjdCB1c2VkIHZyaW5n
LiBJCj4+PiBtZWFuIHRoZSBrZXJuZWwgd2lsbCBjb25zdW1lIHRoZSB1c2VkIHZyaW5nIGluIHRo
ZSBpb2N0bCBjb250ZXh0Cj4+PiBkaXJlY3RseSBpbiB0aGUgdmlydGlvLXZkcGEgY2FzZS4gSW4g
dXNlcnNwYWNlJ3MgdmlldywgdGhhdCBtZWFucwo+Pj4gdmlydHF1ZXVlX3B1c2goKSBpcyB1c2Vk
IHZyaW5nJ3MgcHJvZHVjZXIgYW5kIHZpcnRpb19ub3RpZnkoKSBpcyB1c2VkCj4+PiB2cmluZydz
IGNvbnN1bWVyLiBUaGV5IHdpbGwgYmUgY2FsbGVkIG9uZSBieSBvbmUgaW4gb25lIHRocmVhZCBy
YXRoZXIKPj4+IHRoYW4gZGlmZmVyZW50IHRocmVhZHMsIHdoaWNoIGxvb2tzIG9kZCBhbmQgaGFz
IGEgYmFkIGVmZmVjdCBvbgo+Pj4gcGVyZm9ybWFuY2UuCj4+Cj4+IFllcywgdGhhdCdzIHdoeSB3
ZSBuZWVkIGEgd29ya3F1ZXVlIChXUV9VTkJPVU5EIHlvdSB1c2VkKS4gT3IgZG8geW91Cj4+IHdh
bnQgdG8gc3F1YXNoIHRoaXMgcGF0Y2ggaW50byBwYXRjaCA4Pwo+Pgo+PiBTbyBJIHRoaW5rIHdl
IGNhbiBzZWUgb2J2aW91cyBkaWZmZXJlbmNlIHdoZW4gdmlydGlvLXZkcGEgaXMgdXNlZC4KPj4K
PiBCdXQgaXQgbG9va3MgbGlrZSB3ZSBkb24ndCBuZWVkIHRoaXMgd29ya3F1ZXVlIGluIHZob3N0
LXZkcGEgY2FzZXMuCj4gQW55IHN1Z2dlc3Rpb25zPwoKCkkgaGF2ZW4ndCBoYWQgYSBkZWVwIHRo
b3VnaHQuIEJ1dCBJIGZlZWwgd2UgY2FuIHNvbHZlIHRoaXMgYnkgdXNpbmcgdGhlIAppcnEgYnlw
YXNzIG1hbmFnZXIgKG9yIHNvbWV0aGluZyBzaW1pbGFyKS4gVGhlbiB3ZSBkb24ndCBuZWVkIGl0
IHRvIGJlIApyZWxheWVkIHZpYSB3b3JrcXVldWUgYW5kIHZkcGEuIEJ1dCBJJ20gbm90IHN1cmUg
aG93IGhhcmQgaXQgd2lsbCBiZS4KCkRvIHlvdSBzZWUgYW55IG9idmlvdXMgcGVyZm9ybWFuY2Ug
cmVncmVzc2lvbiBieSB1c2luZyB0aGUgd29ya3F1ZXVlPyBPciAKd2UgY2FuIG9wdGltaXplIGl0
IGluIHRoZSBmdXR1cmUuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
