Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE8C433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:42:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46968216C4
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 08:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46968216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E78A685C20;
	Wed, 30 Dec 2020 08:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8FNTuCwL3OUr; Wed, 30 Dec 2020 08:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A046E85A70;
	Wed, 30 Dec 2020 08:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 715F0C088B;
	Wed, 30 Dec 2020 08:41:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84B84C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 58570203A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rbn+VlPToowC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:41:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3252D20011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609317711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nxql4zOLePCw/DPHwTjONsd++E57uymBDbcJD4zzipA=;
 b=VXQJTb1xO7KcAPCh9G0167TantCPrtbVRn75eFg551nkjueQ2k0S27W4G7YdlyztyJoBKn
 ZJhoBk2Oc+dgPHZaj7UIuJZYGHFlwrLXoeFOZ8ueGb00TGw66T1Ho8ULRlZIT6PJDDX07m
 1A2xzfGhZ8l+H7CNjYE/3Z4iYn2Um6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-zpv0_H9vOcyfBsFlNAK1zg-1; Wed, 30 Dec 2020 03:41:47 -0500
X-MC-Unique: zpv0_H9vOcyfBsFlNAK1zg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8FB180A08A;
 Wed, 30 Dec 2020 08:41:45 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7751E5D6AB;
 Wed, 30 Dec 2020 08:41:32 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
 <0e6faf9c-117a-e23c-8d6d-488d0ec37412@redhat.com>
 <CACycT3uwXBYvRbKDWdN3oCekv+o6_Lc=-KTrxejD=fr-zgibGw@mail.gmail.com>
 <2b24398c-e6d9-14ec-2c0d-c303d528e377@redhat.com>
 <CACycT3uDV43ecScrMh1QVpStuwDETHykJzzY=pkmZjP2Dd2kvg@mail.gmail.com>
 <e77c97c5-6bdc-cdd0-62c0-6ff75f6dbdff@redhat.com>
 <CACycT3soQoX5avZiFBLEGBuJpdni6-UxdhAPGpWHBWVf+dEySg@mail.gmail.com>
 <1356137727.40748805.1609233068675.JavaMail.zimbra@redhat.com>
 <CACycT3sg61yRdupnD+jQEkWKsVEvMWfhkJ=5z_bYZLxCibDiHw@mail.gmail.com>
 <b1aef426-29c7-7244-5fc9-56d52e86abb4@redhat.com>
 <CACycT3vZ7V5WWhCFLBK6FuvVNmPmMj_yc=COOB4cjjC13yHUwg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3fc6a132-9fc2-c4e2-7fb1-b5a8bfb771fa@redhat.com>
Date: Wed, 30 Dec 2020 16:41:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vZ7V5WWhCFLBK6FuvVNmPmMj_yc=COOB4cjjC13yHUwg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjAvMTIvMzAg5LiL5Y2IMzowOSwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBXZWQsIERl
YyAzMCwgMjAyMCBhdCAyOjExIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzI5IOS4i+WNiDY6MjYsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+
PiBPbiBUdWUsIERlYyAyOSwgMjAyMCBhdCA1OjExIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+Cj4+Pj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+
Pj4+PiBPbiBNb24sIERlYyAyOCwgMjAyMCBhdCA0OjQzIFBNIEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gMjAyMC8xMi8yOCDkuIvljYg0OjE0LCBZb25n
amkgWGllIHdyb3RlOgo+Pj4+Pj4+PiBJIHNlZS4gU28gYWxsIHRoZSBhYm92ZSB0d28gcXVlc3Rp
b25zIGFyZSBiZWNhdXNlIFZIT1NUX0lPVExCX0lOVkFMSURBVEUKPj4+Pj4+Pj4gaXMgZXhwZWN0
ZWQgdG8gYmUgc3luY2hyb25vdXMuIFRoaXMgbmVlZCB0byBiZSBzb2x2ZWQgYnkgdHdlYWtpbmcg
dGhlCj4+Pj4+Pj4+IGN1cnJlbnQgVkRVU0UgQVBJIG9yIHdlIGNhbiByZS12aXNpdCB0byBnbyB3
aXRoIGRlc2NyaXB0b3JzIHJlbGF5aW5nCj4+Pj4+Pj4+IGZpcnN0Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+
IEFjdHVhbGx5IGFsbCB2ZHBhIHJlbGF0ZWQgb3BlcmF0aW9ucyBhcmUgc3luY2hyb25vdXMgaW4g
Y3VycmVudAo+Pj4+Pj4+IGltcGxlbWVudGF0aW9uLiBUaGUgb3BzLnNldF9tYXAvZG1hX21hcC9k
bWFfdW5tYXAgc2hvdWxkIG5vdCByZXR1cm4KPj4+Pj4+PiB1bnRpbCB0aGUgVkRVU0VfVVBEQVRF
X0lPVExCL1ZEVVNFX0lOVkFMSURBVEVfSU9UTEIgbWVzc2FnZSBpcyByZXBsaWVkCj4+Pj4+Pj4g
YnkgdXNlcnNwYWNlLiBDb3VsZCBpdCBzb2x2ZSB0aGlzIHByb2JsZW0/Cj4+Pj4+PiAgICAgSSB3
YXMgdGhpbmtpbmcgd2hldGhlciBvciBub3Qgd2UgbmVlZCB0byBnZW5lcmF0ZSBJT1RMQl9JTlZB
TElEQVRFCj4+Pj4+PiBtZXNzYWdlIHRvIFZEVVNFIGR1cmluZyBkbWFfdW5tYXAgKHZkdXNlX2Rl
dl91bm1hcF9wYWdlKS4KPj4+Pj4+Cj4+Pj4+PiBJZiB3ZSBkb24ndCwgd2UncmUgcHJvYmFibHkg
ZmluZS4KPj4+Pj4+Cj4+Pj4+IEl0IHNlZW1zIG5vdCBmZWFzaWJsZS4gVGhpcyBtZXNzYWdlIHdp
bGwgYmUgYWxzbyB1c2VkIGluIHRoZQo+Pj4+PiB2aXJ0aW8tdmRwYSBjYXNlIHRvIG5vdGlmeSB1
c2Vyc3BhY2UgdG8gdW5tYXAgc29tZSBwYWdlcyBkdXJpbmcKPj4+Pj4gY29uc2lzdGVudCBkbWEg
dW5tYXBwaW5nLiBNYXliZSB3ZSBjYW4gZG9jdW1lbnQgaXQgdG8gbWFrZSBzdXJlIHRoZQo+Pj4+
PiB1c2VycyBjYW4gaGFuZGxlIHRoZSBtZXNzYWdlIGNvcnJlY3RseS4KPj4+PiBKdXN0IHRvIG1h
a2Ugc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBwb2ludC4KPj4+Pgo+Pj4+IERvIHlvdSBtZWFuIHlv
dSBwbGFuIHRvIG5vdGlmeSB0aGUgdW5tYXAgb2YgMSkgc3RyZWFtaW5nIERNQSBvciAyKQo+Pj4+
IGNvaGVyZW50IERNQT8KPj4+Pgo+Pj4+IEZvciAxKSB5b3UgcHJvYmFibHkgbmVlZCBhIHdvcmtx
dWV1ZSB0byBkbyB0aGF0IHNpbmNlIGRtYSB1bm1hcCBjYW4KPj4+PiBiZSBkb25lIGluIGlycSBv
ciBiaCBjb250ZXh0LiBBbmQgaWYgdXNyc3BhY2UgZG9lcyd0IGRvIHRoZSB1bm1hcCwgaXQKPj4+
PiBjYW4gc3RpbGwgYWNjZXNzIHRoZSBib3VuY2UgYnVmZmVyIChpZiB5b3UgZG9uJ3QgemFwIHB0
ZSk/Cj4+Pj4KPj4+IEkgcGxhbiB0byBkbyBpdCBpbiB0aGUgY29oZXJlbnQgRE1BIGNhc2UuCj4+
Cj4+IEFueSByZWFzb24gZm9yIHRyZWF0aW5nIGNvaGVyZW50IERNQSBkaWZmZXJlbnRseT8KPj4K
PiBOb3cgdGhlIG1lbW9yeSBvZiB0aGUgYm91bmNlIGJ1ZmZlciBpcyBhbGxvY2F0ZWQgcGFnZSBi
eSBwYWdlIGluIHRoZQo+IHBhZ2UgZmF1bHQgaGFuZGxlci4gU28gaXQgY2FuJ3QgYmUgdXNlZCBp
biBjb2hlcmVudCBETUEgbWFwcGluZyBjYXNlCj4gd2hpY2ggbmVlZHMgc29tZSBtZW1vcnkgd2l0
aCBjb250aWd1b3VzIHZpcnR1YWwgYWRkcmVzc2VzLiBJIGNhbiB1c2UKPiB2bWFsbG9jKCkgdG8g
ZG8gYWxsb2NhdGlvbiBmb3IgdGhlIGJvdW5jZSBidWZmZXIgaW5zdGVhZC4gQnV0IGl0IG1pZ2h0
Cj4gY2F1c2Ugc29tZSBtZW1vcnkgd2FzdGUuIEFueSBzdWdnZXN0aW9uPwoKCkkgbWF5IG1pc3Mg
c29tZXRoaW5nLiBCdXQgSSBkb24ndCBzZWUgYSByZWxhdGlvbnNoaXAgYmV0d2VlbiB0aGUgCklP
VExCX1VOTUFQIGFuZCB2bWFsbG9jKCkuCgoKPgo+Pj4gSXQncyB0cnVlIHRoYXQgdXNlcnNwYWNl
IGNhbgo+Pj4gYWNjZXNzIHRoZSBkbWEgYnVmZmVyIGlmIHVzZXJzcGFjZSBkb2Vzbid0IGRvIHRo
ZSB1bm1hcC4gQnV0IHRoZSBkbWEKPj4+IHBhZ2VzIHdvdWxkIG5vdCBiZSBmcmVlZCBhbmQgcmV1
c2VkIHVubGVzcyB1c2VyIHNwYWNlIGNhbGxlZCBtdW5tYXAoKQo+Pj4gZm9yIHRoZW0uCj4+Cj4+
IEkgd29uZGVyIHdoZXRoZXIgb3Igbm90IHdlIGNvdWxkIHJlY3ljbGUgSU9WQSBpbiB0aGlzIGNh
c2UgdG8gYXZvaWQgdGhlCj4+IElPVExCX1VNQVAgbWVzc2FnZS4KPj4KPiBXZSBjYW4gYWNoaWV2
ZSB0aGF0IGlmIHdlIHVzZSB2bWFsbG9jKCkgdG8gZG8gYWxsb2NhdGlvbiBmb3IgdGhlCj4gYm91
bmNlIGJ1ZmZlciB3aGljaCBjYW4gYmUgdXNlZCBpbiBjb2hlcmVudCBETUEgbWFwcGluZyBjYXNl
LiBCdXQKPiBsb29rcyBsaWtlIHdlIHN0aWxsIGhhdmUgbm8gd2F5IHRvIGF2b2lkIHRoZSBJT1RM
Ql9VTUFQIG1lc3NhZ2UgaW4KPiB2aG9zdC12ZHBhIGNhc2UuCgoKSSB0aGluayB0aGF0J3MgZmlu
ZS4gRm9yIHZpcnRpby12ZHBhLCBmcm9tIFZEVVNFIHVzZXJzcGFjZSBwZXJzcGVjdGl2ZSwgCml0
IHdvcmtzIGxpa2UgYSBkcml2ZXIgdGhhdCBpcyB1c2luZyBTV0lPVExCIGluIHRoaXMgY2FzZS4K
ClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
