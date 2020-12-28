Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBBC433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 07:43:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B65206F6
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 07:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B65206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 85F3586A8E;
	Mon, 28 Dec 2020 07:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAeYozWNG1LW; Mon, 28 Dec 2020 07:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8AB9686A7A;
	Mon, 28 Dec 2020 07:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64A79C0893;
	Mon, 28 Dec 2020 07:43:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39A94C0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 07:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C37F86A7C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 07:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Ba5CMGv1PUB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 07:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EFA7286A7A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 07:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609141404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUqT+VEpmHhWLOUn9+3++KLEXvtfbXB6JHxQWM389zk=;
 b=Mf3skb855UcWMBxlbI+XUXdQD2yA8N+9ZQ1+DmnKdPP76L1sTCCcNBsApgSBWoJLGIRzZf
 on3fGEmmAlKG21ZeSrg04tyowkL6uvWi9JVUZ/zA5wrixAZ1epvLg8gIRj4K4FOUAhQP8J
 NL1ibJ/Nnuw8hh46d7jzPPJjL+2k7y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-inycoFP9NTmopTKJEXh3dg-1; Mon, 28 Dec 2020 02:43:20 -0500
X-MC-Unique: inycoFP9NTmopTKJEXh3dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88979800D53;
 Mon, 28 Dec 2020 07:43:17 +0000 (UTC)
Received: from [10.72.13.159] (ovpn-13-159.pek2.redhat.com [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E52E60CC4;
 Mon, 28 Dec 2020 07:43:04 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <20201222145221.711-10-xieyongji@bytedance.com>
 <6818a214-d587-4f0b-7de6-13c4e7e94ab6@redhat.com>
 <CACycT3vVU9vg6R6UujSnSdk8cwxWPVgeJJs0JaBH_Zg4xC-epQ@mail.gmail.com>
 <595fe7d6-7876-26e4-0b7c-1d63ca6d7a97@redhat.com>
 <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
 <0e6faf9c-117a-e23c-8d6d-488d0ec37412@redhat.com>
 <CACycT3uwXBYvRbKDWdN3oCekv+o6_Lc=-KTrxejD=fr-zgibGw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b24398c-e6d9-14ec-2c0d-c303d528e377@redhat.com>
Date: Mon, 28 Dec 2020 15:43:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3uwXBYvRbKDWdN3oCekv+o6_Lc=-KTrxejD=fr-zgibGw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjUg5LiL5Y2INjozMSwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBGcmksIERl
YyAyNSwgMjAyMCBhdCAyOjU4IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzI0IOS4i+WNiDM6MzcsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+
PiBPbiBUaHUsIERlYyAyNCwgMjAyMCBhdCAxMDo0MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIwLzEyLzIzIOS4i+WNiDg6MTQsIFlvbmdqaSBY
aWUgd3JvdGU6Cj4+Pj4+IE9uIFdlZCwgRGVjIDIzLCAyMDIwIGF0IDU6MDUgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiAyMDIwLzEyLzIyIOS4i+WN
iDEwOjUyLCBYaWUgWW9uZ2ppIHdyb3RlOgo+Pj4+Pj4+IFRvIHN1cHBvcnQgdmhvc3QtdmRwYSBi
dXMgZHJpdmVyLCB3ZSBuZWVkIGEgd2F5IHRvIHNoYXJlIHRoZQo+Pj4+Pj4+IHZob3N0LXZkcGEg
YmFja2VuZCBwcm9jZXNzJ3MgbWVtb3J5IHdpdGggdGhlIHVzZXJzcGFjZSBWRFVTRSBwcm9jZXNz
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhpcyBwYXRjaCB0cmllcyB0byBtYWtlIHVzZSBvZiB0aGUgdmhv
c3QgaW90bGIgbWVzc2FnZSB0byBhY2hpZXZlCj4+Pj4+Pj4gdGhhdC4gV2Ugd2lsbCBnZXQgdGhl
IHNobSBmaWxlIGZyb20gdGhlIGlvdGxiIG1lc3NhZ2UgYW5kIHBhc3MgaXQKPj4+Pj4+PiB0byB0
aGUgdXNlcnNwYWNlIFZEVVNFIHByb2Nlc3MuCj4+Pj4+Pj4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPj4+Pj4+PiAtLS0KPj4+Pj4+
PiAgICAgIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92ZHVzZS5yc3QgfCAgMTUgKysrLQo+Pj4+
Pj4+ICAgICAgZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDE0NyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+Pj4+Pj4gICAgICBpbmNsdWRlL3VhcGkv
bGludXgvdmR1c2UuaCAgICAgICAgIHwgIDExICsrKwo+Pj4+Pj4+ICAgICAgMyBmaWxlcyBjaGFu
Z2VkLCAxNzEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmR1c2UucnN0IGIvRG9jdW1lbnRh
dGlvbi9kcml2ZXItYXBpL3ZkdXNlLnJzdAo+Pj4+Pj4+IGluZGV4IDYyM2Y3YjA0MGNjZi4uNDhl
NGIxYmEzNTNmIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92
ZHVzZS5yc3QKPj4+Pj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmR1c2UucnN0
Cj4+Pj4+Pj4gQEAgLTQ2LDEzICs0NiwyNiBAQCBUaGUgZm9sbG93aW5nIHR5cGVzIG9mIG1lc3Nh
Z2VzIGFyZSBwcm92aWRlZCBieSB0aGUgVkRVU0UgZnJhbWV3b3JrIG5vdzoKPj4+Pj4+Pgo+Pj4+
Pj4+ICAgICAgLSBWRFVTRV9HRVRfQ09ORklHOiBSZWFkIGZyb20gZGV2aWNlIHNwZWNpZmljIGNv
bmZpZ3VyYXRpb24gc3BhY2UKPj4+Pj4+Pgo+Pj4+Pj4+ICstIFZEVVNFX1VQREFURV9JT1RMQjog
VXBkYXRlIHRoZSBtZW1vcnkgbWFwcGluZyBpbiBkZXZpY2UgSU9UTEIKPj4+Pj4+PiArCj4+Pj4+
Pj4gKy0gVkRVU0VfSU5WQUxJREFURV9JT1RMQjogSW52YWxpZGF0ZSB0aGUgbWVtb3J5IG1hcHBp
bmcgaW4gZGV2aWNlIElPVExCCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICAgICAgUGxlYXNlIHNlZSBpbmNs
dWRlL2xpbnV4L3ZkcGEuaCBmb3IgZGV0YWlscy4KPj4+Pj4+Pgo+Pj4+Pj4+IC1JbiB0aGUgZGF0
YSBwYXRoLCBWRFVTRSBmcmFtZXdvcmsgaW1wbGVtZW50cyBhIE1NVS1iYXNlZCBvbi1jaGlwIElP
TU1VCj4+Pj4+Pj4gK1RoZSBkYXRhIHBhdGggb2YgdXNlcnNwYWNlIHZEUEEgZGV2aWNlIGlzIGlt
cGxlbWVudGVkIGluIGRpZmZlcmVudCB3YXlzCj4+Pj4+Pj4gK2RlcGVuZGluZyBvbiB0aGUgdmRw
YSBidXMgdG8gd2hpY2ggaXQgaXMgYXR0YWNoZWQuCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICtJbiB2aXJ0
aW8tdmRwYSBjYXNlLCBWRFVTRSBmcmFtZXdvcmsgaW1wbGVtZW50cyBhIE1NVS1iYXNlZCBvbi1j
aGlwIElPTU1VCj4+Pj4+Pj4gICAgICBkcml2ZXIgd2hpY2ggc3VwcG9ydHMgbWFwcGluZyB0aGUg
a2VybmVsIGRtYSBidWZmZXIgdG8gYSB1c2Vyc3BhY2UgaW92YQo+Pj4+Pj4+ICAgICAgcmVnaW9u
IGR5bmFtaWNhbGx5LiBUaGUgdXNlcnNwYWNlIGlvdmEgcmVnaW9uIGNhbiBiZSBjcmVhdGVkIGJ5
IHBhc3NpbmcKPj4+Pj4+PiAgICAgIHRoZSB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UgZmQgdG8gbW1h
cCgyKS4KPj4+Pj4+Pgo+Pj4+Pj4+ICtJbiB2aG9zdC12ZHBhIGNhc2UsIHRoZSBkbWEgYnVmZmVy
IGlzIHJlc2lkZSBpbiBhIHVzZXJzcGFjZSBtZW1vcnkgcmVnaW9uCj4+Pj4+Pj4gK3doaWNoIHdp
bGwgYmUgc2hhcmVkIHRvIHRoZSBWRFVTRSB1c2Vyc3BhY2UgcHJvY2Vzc3MgdmlhIHRoZSBmaWxl
Cj4+Pj4+Pj4gK2Rlc2NyaXB0b3IgaW4gVkRVU0VfVVBEQVRFX0lPVExCIG1lc3NhZ2UuIEFuZCB0
aGUgY29ycmVzcG9uZGluZyBhZGRyZXNzCj4+Pj4+Pj4gK21hcHBpbmcgKElPVkEgb2YgZG1hIGJ1
ZmZlciA8LT4gVkEgb2YgdGhlIG1lbW9yeSByZWdpb24pIGlzIGFsc28gaW5jbHVkZWQKPj4+Pj4+
PiAraW4gdGhpcyBtZXNzYWdlLgo+Pj4+Pj4+ICsKPj4+Pj4+PiAgICAgIEJlc2lkZXMsIHRoZSBl
dmVudGZkIG1lY2hhbmlzbSBpcyB1c2VkIHRvIHRyaWdnZXIgaW50ZXJydXB0IGNhbGxiYWNrcyBh
bmQKPj4+Pj4+PiAgICAgIHJlY2VpdmUgdmlydHF1ZXVlIGtpY2tzIGluIHVzZXJzcGFjZS4gVGhl
IGZvbGxvd2luZyBpb2N0bHMgb24gdGhlIHVzZXJzcGFjZQo+Pj4+Pj4+ICAgICAgdkRQQSBkZXZp
Y2UgZmQgYXJlIHByb3ZpZGVkIHRvIHN1cHBvcnQgdGhhdDoKPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3Vz
ZXIvdmR1c2VfZGV2LmMKPj4+Pj4+PiBpbmRleCBiOTc0MzMzZWQ0ZTkuLmQyNGFhYWNiNjAwOCAx
MDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+
Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+Pj4+Pj4+IEBA
IC0zNCw2ICszNCw3IEBACj4+Pj4+Pj4KPj4+Pj4+PiAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNn
IHsKPj4+Pj4+PiAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X3JlcXVlc3QgcmVxOwo+Pj4+Pj4+
ICsgICAgIHN0cnVjdCBmaWxlICppb3RsYl9maWxlOwo+Pj4+Pj4+ICAgICAgICAgIHN0cnVjdCB2
ZHVzZV9kZXZfcmVzcG9uc2UgcmVzcDsKPj4+Pj4+PiAgICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFk
IGxpc3Q7Cj4+Pj4+Pj4gICAgICAgICAgd2FpdF9xdWV1ZV9oZWFkX3Qgd2FpdHE7Cj4+Pj4+Pj4g
QEAgLTMyNSwxMiArMzI2LDgwIEBAIHN0YXRpYyBpbnQgdmR1c2VfZGV2X3NldF92cV9zdGF0ZShz
dHJ1Y3QgdmR1c2VfZGV2ICpkZXYsCj4+Pj4+Pj4gICAgICAgICAgcmV0dXJuIHJldDsKPj4+Pj4+
PiAgICAgIH0KPj4+Pj4+Pgo+Pj4+Pj4+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl91cGRhdGVfaW90
bGIoc3RydWN0IHZkdXNlX2RldiAqZGV2LCBzdHJ1Y3QgZmlsZSAqZmlsZSwKPj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgb2Zmc2V0LCB1NjQgaW92YSwgdTY0IHNpemUs
IHU4IHBlcm0pCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyAq
bXNnOwo+Pj4+Pj4+ICsgICAgIGludCByZXQ7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsgICAgIGlmICgh
c2l6ZSkKPj4+Pj4+PiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4+Pj4+ICsKPj4+
Pj4+PiArICAgICBtc2cgPSB2ZHVzZV9kZXZfbmV3X21zZyhkZXYsIFZEVVNFX1VQREFURV9JT1RM
Qik7Cj4+Pj4+Pj4gKyAgICAgbXNnLT5yZXEuc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmR1c2VfaW90
bGIpOwo+Pj4+Pj4+ICsgICAgIG1zZy0+cmVxLmlvdGxiLm9mZnNldCA9IG9mZnNldDsKPj4+Pj4+
PiArICAgICBtc2ctPnJlcS5pb3RsYi5pb3ZhID0gaW92YTsKPj4+Pj4+PiArICAgICBtc2ctPnJl
cS5pb3RsYi5zaXplID0gc2l6ZTsKPj4+Pj4+PiArICAgICBtc2ctPnJlcS5pb3RsYi5wZXJtID0g
cGVybTsKPj4+Pj4+PiArICAgICBtc2ctPnJlcS5pb3RsYi5mZCA9IC0xOwo+Pj4+Pj4+ICsgICAg
IG1zZy0+aW90bGJfZmlsZSA9IGdldF9maWxlKGZpbGUpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAg
ICByZXQgPSB2ZHVzZV9kZXZfbXNnX3N5bmMoZGV2LCBtc2cpOwo+Pj4+Pj4gTXkgZmVlbGluZyBp
cyB0aGF0IHdlIHNob3VsZCBwcm92aWRlIGNvbnNpc3RlbnQgQVBJIGZvciB0aGUgdXNlcnNwYWNl
Cj4+Pj4+PiBkZXZpY2UgdG8gdXNlLgo+Pj4+Pj4KPj4+Pj4+IEUuZyB3ZSdkIGJldHRlciBjYXJy
eSB0aGUgSU9UTEIgbWVzc2FnZSBmb3IgYm90aCB2aXJ0aW8vdmhvc3QgZHJpdmVycy4KPj4+Pj4+
Cj4+Pj4+PiBJdCBsb29rcyB0byBtZSBmb3IgdmlydGlvIGRyaXZlcnMgd2UgY2FuIHN0aWxsIHVz
ZSBVUERBVF9JT1RMQiBtZXNzYWdlCj4+Pj4+PiBieSB1c2luZyBWRFVTRSBmaWxlIGFzIG1zZy0+
aW90bGJfZmlsZSBoZXJlLgo+Pj4+Pj4KPj4+Pj4gSXQncyBPSyBmb3IgbWUuIE9uZSBwcm9ibGVt
IGlzIHdoZW4gdG8gdHJhbnNmZXIgdGhlIFVQREFURV9JT1RMQgo+Pj4+PiBtZXNzYWdlIGluIHZp
cnRpbyBjYXNlcy4KPj4+PiBJbnN0ZWFkIG9mIGdlbmVyYXRpbmcgSU9UTEIgbWVzc2FnZXMgZm9y
IHVzZXJzcGFjZS4KPj4+Pgo+Pj4+IEhvdyBhYm91dCByZWNvcmQgdGhlIG1hcHBpbmdzICh3aGlj
aCBpcyBhIGNvbW1vbiBjYXNlIGZvciBkZXZpY2UgaGF2ZQo+Pj4+IG9uLWNoaXAgSU9NTVUgZS5n
IG1seDVlIGFuZCB2ZHBhIHNpbWxhdG9yKSwgdGhlbiB3ZSBjYW4gaW50cm9kdWNlIGlvY3RsCj4+
Pj4gZm9yIHVzZXJzcGFjZSB0byBxdWVyeT8KPj4+Pgo+Pj4gSWYgc28sIHRoZSBJT1RMQiBVUERB
VEUgaXMgYWN0dWFsbHkgdHJpZ2dlcmVkIGJ5IGlvY3RsLCBidXQKPj4+IElPVExCX0lOVkFMSURB
VEUgaXMgdHJpZ2dlcmVkIGJ5IHRoZSBtZXNzYWdlLiBJcyBpdCBhIGxpdHRsZSBvZGQ/Cj4+Cj4+
IEdvb2QgcG9pbnQuCj4+Cj4+IFNvbWUgcXVlc3Rpb25zIGhlcmU6Cj4+Cj4+IDEpIFVzZXJzcGFj
ZSB0aGluayB0aGUgSU9UTEIgd2FzIGZsdXNoZWQgYWZ0ZXIgSU9UTEJfSU5WQUxJREFURSBzeXNj
YWxsCj4+IGlzIHJldHVybmVkLiBCdXQgdGhpcyBwYXRjaCBkb2Vzbid0IGhhdmUgdGhpcyBndWFy
YW50ZWUuIENhbiB0aGlzIGxlYWQKPj4gc29tZSBpc3N1ZXM/Cj4gSSdtIG5vdCBzdXJlLiBCdXQg
c2hvdWxkIGl0IGJlIGd1YXJhbnRlZWQgaW4gVkRVU0UgdXNlcnNwYWNlPyBKdXN0Cj4gbGlrZSB3
aGF0IHZob3N0LXVzZXIgYmFja2VuZCBwcm9jZXNzIGRvZXMuCgoKSSB0aGluayBzby4gVGhpcyBp
cyBiZWNhdXNlIHRoZSB1c2Vyc3BhY2UgZGV2aWNlIG5lZWRzIGEgd2F5IHRvIApzeW5jaHJvbml6
ZSBpbnZhbGlkYXRpb24gd2l0aCBpdHMgZGF0YXBhdGguIE90aGVyd2lzZSwgZ3Vlc3QgbWF5IHRo
aW5nIAp0aGUgYnVmZmVyIGlzIGZyZWVkIHRvIGJlIHVzZWQgYnkgb3RoZXIgcGFydHMgYnV0IHRo
ZSBpdCBhY3R1YWxseSBjYW4gYmUgCnVzZWQgYnkgdGhlIFZEVVNFIGRldmljZS4gVGhlIG1heSBj
YXVzZSBzZWN1cml0eSBpc3N1ZXMuCgoKPgo+PiAyKSBJIHRoaW5rIGFmdGVyIFZEVVNFIHVzZXJz
cGFjZSByZWNlaXZlcyBJT1RMQl9JTlZBTElEQVRFLCBpdCBuZWVkcyB0bwo+PiBpc3N1ZSBhIG11
bm1hcCgpLiBXaGF0IGlmIGl0IGRvZXNuJ3QgZG8gdGhhdD8KPj4KPiBZZXMsIHRoZSBtdW5tYXAo
KSBpcyBuZWVkZWQuIElmIGl0IGRvZXNuJ3QgZG8gdGhhdCwgVkRVU0UgdXNlcnNwYWNlCj4gY291
bGQgc3RpbGwgYWNjZXNzIHRoZSBjb3JyZXNwb25kaW5nIGd1ZXN0IG1lbW9yeSByZWdpb24uCgoK
SSBzZWUuIFNvIGFsbCB0aGUgYWJvdmUgdHdvIHF1ZXN0aW9ucyBhcmUgYmVjYXVzZSBWSE9TVF9J
T1RMQl9JTlZBTElEQVRFIAppcyBleHBlY3RlZCB0byBiZSBzeW5jaHJvbm91cy4gVGhpcyBuZWVk
IHRvIGJlIHNvbHZlZCBieSB0d2Vha2luZyB0aGUgCmN1cnJlbnQgVkRVU0UgQVBJIG9yIHdlIGNh
biByZS12aXNpdCB0byBnbyB3aXRoIGRlc2NyaXB0b3JzIHJlbGF5aW5nIGZpcnN0LgoKVGhhbmtz
CgoKPgo+IFRoYW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
