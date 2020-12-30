Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8868C433DB
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:11:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DA52085B
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 06:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DA52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F36386AB1;
	Wed, 30 Dec 2020 06:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vlsDATps5NF4; Wed, 30 Dec 2020 06:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 268F286AA3;
	Wed, 30 Dec 2020 06:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F19A0C0893;
	Wed, 30 Dec 2020 06:11:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37E51C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2C01686AAB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M6i0KlTn+Bmu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 16EC986AA3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609308677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HR5VQjVbyjmspTne1yUEQIA+lboTKLXwct9mHhTRH6o=;
 b=dofCJCujd7Tkp3pmlZnZGWI15VNpitsHFXfk8+SCXpgshvv5cSxCAwi28tUmXTgHsnx6fa
 uhFnfUwT8U83a63gBQjRHbU19KMp3LKlSeguHdPk8ZSrQIIFWQl5Nhg6Pd07l/MoMcFEq1
 p+X6gY0F5J98z3iE0VJC6gXWJxjFVFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-7O4wQ_a9MSKDf-vq6j4Bxw-1; Wed, 30 Dec 2020 01:11:13 -0500
X-MC-Unique: 7O4wQ_a9MSKDf-vq6j4Bxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07BFE760;
 Wed, 30 Dec 2020 06:11:10 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2DA31007617;
 Wed, 30 Dec 2020 06:10:58 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1aef426-29c7-7244-5fc9-56d52e86abb4@redhat.com>
Date: Wed, 30 Dec 2020 14:10:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sg61yRdupnD+jQEkWKsVEvMWfhkJ=5z_bYZLxCibDiHw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2INjoyNiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUdWUsIERl
YyAyOSwgMjAyMCBhdCA1OjExIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+Pgo+PiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4+PiBPbiBNb24sIERl
YyAyOCwgMjAyMCBhdCA0OjQzIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMC8xMi8yOCDkuIvljYg0OjE0LCBZb25namkgWGllIHdyb3Rl
Ogo+Pj4+Pj4gSSBzZWUuIFNvIGFsbCB0aGUgYWJvdmUgdHdvIHF1ZXN0aW9ucyBhcmUgYmVjYXVz
ZSBWSE9TVF9JT1RMQl9JTlZBTElEQVRFCj4+Pj4+PiBpcyBleHBlY3RlZCB0byBiZSBzeW5jaHJv
bm91cy4gVGhpcyBuZWVkIHRvIGJlIHNvbHZlZCBieSB0d2Vha2luZyB0aGUKPj4+Pj4+IGN1cnJl
bnQgVkRVU0UgQVBJIG9yIHdlIGNhbiByZS12aXNpdCB0byBnbyB3aXRoIGRlc2NyaXB0b3JzIHJl
bGF5aW5nCj4+Pj4+PiBmaXJzdC4KPj4+Pj4+Cj4+Pj4+IEFjdHVhbGx5IGFsbCB2ZHBhIHJlbGF0
ZWQgb3BlcmF0aW9ucyBhcmUgc3luY2hyb25vdXMgaW4gY3VycmVudAo+Pj4+PiBpbXBsZW1lbnRh
dGlvbi4gVGhlIG9wcy5zZXRfbWFwL2RtYV9tYXAvZG1hX3VubWFwIHNob3VsZCBub3QgcmV0dXJu
Cj4+Pj4+IHVudGlsIHRoZSBWRFVTRV9VUERBVEVfSU9UTEIvVkRVU0VfSU5WQUxJREFURV9JT1RM
QiBtZXNzYWdlIGlzIHJlcGxpZWQKPj4+Pj4gYnkgdXNlcnNwYWNlLiBDb3VsZCBpdCBzb2x2ZSB0
aGlzIHByb2JsZW0/Cj4+Pj4KPj4+PiAgICBJIHdhcyB0aGlua2luZyB3aGV0aGVyIG9yIG5vdCB3
ZSBuZWVkIHRvIGdlbmVyYXRlIElPVExCX0lOVkFMSURBVEUKPj4+PiBtZXNzYWdlIHRvIFZEVVNF
IGR1cmluZyBkbWFfdW5tYXAgKHZkdXNlX2Rldl91bm1hcF9wYWdlKS4KPj4+Pgo+Pj4+IElmIHdl
IGRvbid0LCB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+Pj4+Cj4+PiBJdCBzZWVtcyBub3QgZmVhc2li
bGUuIFRoaXMgbWVzc2FnZSB3aWxsIGJlIGFsc28gdXNlZCBpbiB0aGUKPj4+IHZpcnRpby12ZHBh
IGNhc2UgdG8gbm90aWZ5IHVzZXJzcGFjZSB0byB1bm1hcCBzb21lIHBhZ2VzIGR1cmluZwo+Pj4g
Y29uc2lzdGVudCBkbWEgdW5tYXBwaW5nLiBNYXliZSB3ZSBjYW4gZG9jdW1lbnQgaXQgdG8gbWFr
ZSBzdXJlIHRoZQo+Pj4gdXNlcnMgY2FuIGhhbmRsZSB0aGUgbWVzc2FnZSBjb3JyZWN0bHkuCj4+
IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50Lgo+Pgo+PiBEbyB5b3Ug
bWVhbiB5b3UgcGxhbiB0byBub3RpZnkgdGhlIHVubWFwIG9mIDEpIHN0cmVhbWluZyBETUEgb3Ig
MikKPj4gY29oZXJlbnQgRE1BPwo+Pgo+PiBGb3IgMSkgeW91IHByb2JhYmx5IG5lZWQgYSB3b3Jr
cXVldWUgdG8gZG8gdGhhdCBzaW5jZSBkbWEgdW5tYXAgY2FuCj4+IGJlIGRvbmUgaW4gaXJxIG9y
IGJoIGNvbnRleHQuIEFuZCBpZiB1c3JzcGFjZSBkb2VzJ3QgZG8gdGhlIHVubWFwLCBpdAo+PiBj
YW4gc3RpbGwgYWNjZXNzIHRoZSBib3VuY2UgYnVmZmVyIChpZiB5b3UgZG9uJ3QgemFwIHB0ZSk/
Cj4+Cj4gSSBwbGFuIHRvIGRvIGl0IGluIHRoZSBjb2hlcmVudCBETUEgY2FzZS4KCgpBbnkgcmVh
c29uIGZvciB0cmVhdGluZyBjb2hlcmVudCBETUEgZGlmZmVyZW50bHk/CgoKPiBJdCdzIHRydWUg
dGhhdCB1c2Vyc3BhY2UgY2FuCj4gYWNjZXNzIHRoZSBkbWEgYnVmZmVyIGlmIHVzZXJzcGFjZSBk
b2Vzbid0IGRvIHRoZSB1bm1hcC4gQnV0IHRoZSBkbWEKPiBwYWdlcyB3b3VsZCBub3QgYmUgZnJl
ZWQgYW5kIHJldXNlZCB1bmxlc3MgdXNlciBzcGFjZSBjYWxsZWQgbXVubWFwKCkKPiBmb3IgdGhl
bS4KCgpJIHdvbmRlciB3aGV0aGVyIG9yIG5vdCB3ZSBjb3VsZCByZWN5Y2xlIElPVkEgaW4gdGhp
cyBjYXNlIHRvIGF2b2lkIHRoZSAKSU9UTEJfVU1BUCBtZXNzYWdlLgoKVGhhbmtzCgoKPgo+IFRo
YW5rcywKPiBZb25namkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
