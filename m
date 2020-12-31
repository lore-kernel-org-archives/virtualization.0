Return-Path: <SRS0=UCi2=GD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BDFC433DB
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 05:50:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718AC2222D
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 05:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718AC2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 192708732F;
	Thu, 31 Dec 2020 05:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nA0nlFAiTZNH; Thu, 31 Dec 2020 05:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 383338732D;
	Thu, 31 Dec 2020 05:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2485BC0174;
	Thu, 31 Dec 2020 05:50:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1586FC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 05:50:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03BE387330
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 05:50:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lg1C700sVCBK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 05:50:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 22DCB8732D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 05:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609393822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=58HwBb3M7PAiscWQmllnEdkUdFZgFa03LEx+BxIEido=;
 b=LQsSSdDYux53O83ctXgwwCNdwy//UfRNBy1bj9rU+uR3X0EFF3wIE+fam2F04nA3G8HFNF
 Pu8P6FaLu0EjEi0jWqwfDYM7irCyRReYwnZxOK6MJOIeQaKOO8bBT2G2wZHpVnhiDrBPwD
 jnRlQPj/3MpFDmU0tTqVWgJWYqwAeSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-cVm3mfXEO0u76e2pupugXw-1; Thu, 31 Dec 2020 00:50:18 -0500
X-MC-Unique: cVm3mfXEO0u76e2pupugXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EF05180A097;
 Thu, 31 Dec 2020 05:50:16 +0000 (UTC)
Received: from [10.72.12.236] (ovpn-12-236.pek2.redhat.com [10.72.12.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0DC46F7F4;
 Thu, 31 Dec 2020 05:50:00 +0000 (UTC)
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
 <3fc6a132-9fc2-c4e2-7fb1-b5a8bfb771fa@redhat.com>
 <CACycT3tD3zyvV6Zy5NT4x=02hBgrRGq35xeTsRXXx-_wPGJXpQ@mail.gmail.com>
 <e0e693c3-1871-a410-c3d5-964518ec939a@redhat.com>
 <CACycT3vwMU5R7N8dZFBYX4-bxe2YT7EfK_M_jEkH8wzfH_GkBw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0885385c-ae46-158d-eabf-433ef8ecf27f@redhat.com>
Date: Thu, 31 Dec 2020 13:49:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3vwMU5R7N8dZFBYX4-bxe2YT7EfK_M_jEkH8wzfH_GkBw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvMTIvMzEg5LiL5Y2IMToxNSwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUaHUsIERl
YyAzMSwgMjAyMCBhdCAxMDo0OSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3
cm90ZToKPj4KPj4gT24gMjAyMC8xMi8zMCDkuIvljYg2OjEyLCBZb25namkgWGllIHdyb3RlOgo+
Pj4gT24gV2VkLCBEZWMgMzAsIDIwMjAgYXQgNDo0MSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIwLzEyLzMwIOS4i+WNiDM6MDksIFlvbmdqaSBY
aWUgd3JvdGU6Cj4+Pj4+IE9uIFdlZCwgRGVjIDMwLCAyMDIwIGF0IDI6MTEgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiAyMDIwLzEyLzI5IOS4i+WN
iDY6MjYsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4gT24gVHVlLCBEZWMgMjksIDIwMjAgYXQg
NToxMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4g
LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+Pj4+Pj4+Pj4gT24gTW9uLCBEZWMgMjgsIDIw
MjAgYXQgNDo0MyBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+
Pj4+Pj4+PiBPbiAyMDIwLzEyLzI4IOS4i+WNiDQ6MTQsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+
Pj4+Pj4+PiBJIHNlZS4gU28gYWxsIHRoZSBhYm92ZSB0d28gcXVlc3Rpb25zIGFyZSBiZWNhdXNl
IFZIT1NUX0lPVExCX0lOVkFMSURBVEUKPj4+Pj4+Pj4+Pj4+IGlzIGV4cGVjdGVkIHRvIGJlIHN5
bmNocm9ub3VzLiBUaGlzIG5lZWQgdG8gYmUgc29sdmVkIGJ5IHR3ZWFraW5nIHRoZQo+Pj4+Pj4+
Pj4+Pj4gY3VycmVudCBWRFVTRSBBUEkgb3Igd2UgY2FuIHJlLXZpc2l0IHRvIGdvIHdpdGggZGVz
Y3JpcHRvcnMgcmVsYXlpbmcKPj4+Pj4+Pj4+Pj4+IGZpcnN0Lgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gQWN0dWFsbHkgYWxsIHZkcGEgcmVsYXRlZCBvcGVyYXRpb25zIGFyZSBzeW5jaHJvbm91
cyBpbiBjdXJyZW50Cj4+Pj4+Pj4+Pj4+IGltcGxlbWVudGF0aW9uLiBUaGUgb3BzLnNldF9tYXAv
ZG1hX21hcC9kbWFfdW5tYXAgc2hvdWxkIG5vdCByZXR1cm4KPj4+Pj4+Pj4+Pj4gdW50aWwgdGhl
IFZEVVNFX1VQREFURV9JT1RMQi9WRFVTRV9JTlZBTElEQVRFX0lPVExCIG1lc3NhZ2UgaXMgcmVw
bGllZAo+Pj4+Pj4+Pj4+PiBieSB1c2Vyc3BhY2UuIENvdWxkIGl0IHNvbHZlIHRoaXMgcHJvYmxl
bT8KPj4+Pj4+Pj4+PiAgICAgICBJIHdhcyB0aGlua2luZyB3aGV0aGVyIG9yIG5vdCB3ZSBuZWVk
IHRvIGdlbmVyYXRlIElPVExCX0lOVkFMSURBVEUKPj4+Pj4+Pj4+PiBtZXNzYWdlIHRvIFZEVVNF
IGR1cmluZyBkbWFfdW5tYXAgKHZkdXNlX2Rldl91bm1hcF9wYWdlKS4KPj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+IElmIHdlIGRvbid0LCB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+PiBJdCBzZWVtcyBub3QgZmVhc2libGUuIFRoaXMgbWVzc2FnZSB3aWxsIGJlIGFsc28gdXNl
ZCBpbiB0aGUKPj4+Pj4+Pj4+IHZpcnRpby12ZHBhIGNhc2UgdG8gbm90aWZ5IHVzZXJzcGFjZSB0
byB1bm1hcCBzb21lIHBhZ2VzIGR1cmluZwo+Pj4+Pj4+Pj4gY29uc2lzdGVudCBkbWEgdW5tYXBw
aW5nLiBNYXliZSB3ZSBjYW4gZG9jdW1lbnQgaXQgdG8gbWFrZSBzdXJlIHRoZQo+Pj4+Pj4+Pj4g
dXNlcnMgY2FuIGhhbmRsZSB0aGUgbWVzc2FnZSBjb3JyZWN0bHkuCj4+Pj4+Pj4+IEp1c3QgdG8g
bWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBEbyB5
b3UgbWVhbiB5b3UgcGxhbiB0byBub3RpZnkgdGhlIHVubWFwIG9mIDEpIHN0cmVhbWluZyBETUEg
b3IgMikKPj4+Pj4+Pj4gY29oZXJlbnQgRE1BPwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBGb3IgMSkgeW91
IHByb2JhYmx5IG5lZWQgYSB3b3JrcXVldWUgdG8gZG8gdGhhdCBzaW5jZSBkbWEgdW5tYXAgY2Fu
Cj4+Pj4+Pj4+IGJlIGRvbmUgaW4gaXJxIG9yIGJoIGNvbnRleHQuIEFuZCBpZiB1c3JzcGFjZSBk
b2VzJ3QgZG8gdGhlIHVubWFwLCBpdAo+Pj4+Pj4+PiBjYW4gc3RpbGwgYWNjZXNzIHRoZSBib3Vu
Y2UgYnVmZmVyIChpZiB5b3UgZG9uJ3QgemFwIHB0ZSk/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4gSSBwbGFu
IHRvIGRvIGl0IGluIHRoZSBjb2hlcmVudCBETUEgY2FzZS4KPj4+Pj4+IEFueSByZWFzb24gZm9y
IHRyZWF0aW5nIGNvaGVyZW50IERNQSBkaWZmZXJlbnRseT8KPj4+Pj4+Cj4+Pj4+IE5vdyB0aGUg
bWVtb3J5IG9mIHRoZSBib3VuY2UgYnVmZmVyIGlzIGFsbG9jYXRlZCBwYWdlIGJ5IHBhZ2UgaW4g
dGhlCj4+Pj4+IHBhZ2UgZmF1bHQgaGFuZGxlci4gU28gaXQgY2FuJ3QgYmUgdXNlZCBpbiBjb2hl
cmVudCBETUEgbWFwcGluZyBjYXNlCj4+Pj4+IHdoaWNoIG5lZWRzIHNvbWUgbWVtb3J5IHdpdGgg
Y29udGlndW91cyB2aXJ0dWFsIGFkZHJlc3Nlcy4gSSBjYW4gdXNlCj4+Pj4+IHZtYWxsb2MoKSB0
byBkbyBhbGxvY2F0aW9uIGZvciB0aGUgYm91bmNlIGJ1ZmZlciBpbnN0ZWFkLiBCdXQgaXQgbWln
aHQKPj4+Pj4gY2F1c2Ugc29tZSBtZW1vcnkgd2FzdGUuIEFueSBzdWdnZXN0aW9uPwo+Pj4+IEkg
bWF5IG1pc3Mgc29tZXRoaW5nLiBCdXQgSSBkb24ndCBzZWUgYSByZWxhdGlvbnNoaXAgYmV0d2Vl
biB0aGUKPj4+PiBJT1RMQl9VTk1BUCBhbmQgdm1hbGxvYygpLgo+Pj4+Cj4+PiBJbiB0aGUgdm1h
bGxvYygpIGNhc2UsIHRoZSBjb2hlcmVudCBETUEgcGFnZSB3aWxsIGJlIHRha2VuIGZyb20gdGhl
Cj4+PiBtZW1vcnkgYWxsb2NhdGVkIGJ5IHZtYWxsb2MoKS4gU28gSU9UTEJfVU5NQVAgaXMgbm90
IG5lZWRlZCBhbnltb3JlCj4+PiBkdXJpbmcgY29oZXJlbnQgRE1BIHVubWFwcGluZyBiZWNhdXNl
IHRob3NlIHZtYWxsb2MnZWQgbWVtb3J5IHdoaWNoCj4+PiBoYXMgYmVlbiBtYXBwZWQgaW50byB1
c2Vyc3BhY2UgYWRkcmVzcyBzcGFjZSBkdXJpbmcgaW5pdGlhbGl6YXRpb24gY2FuCj4+PiBiZSBy
ZXVzZWQuIEFuZCB1c2Vyc3BhY2Ugc2hvdWxkIG5vdCB1bm1hcCB0aGUgcmVnaW9uIHVudGlsIHdl
IGRlc3Ryb3kKPj4+IHRoZSBkZXZpY2UuCj4+Cj4+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJz
dGFuZC4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IElPVExCX1VOTUFQIGlzCj4+IG9ubHkgbmVl
ZGVkIHdoZW4gdGhlcmUncyBhIGNoYW5nZSB0aGUgbWFwcGluZyBmcm9tIElPVkEgdG8gcGFnZS4K
Pj4KPiBZZXMsIHRoYXQncyB0cnVlLgo+Cj4+IFNvIGlmIHdlIHN0aWNrIHRvIHRoZSBtYXBwaW5n
LCBlLmcgZHVyaW5nIGRtYV91bm1hcCwgd2UganVzdCBwdXQgSU9WQSB0bwo+PiBmcmVlIGxpc3Qg
dG8gYmUgdXNlZCBieSB0aGUgbmV4dCBJT1ZBIGFsbG9jYXRpbmcuIElPVExCX1VOTUFQIGNvdWxk
IGJlCj4+IGF2b2lkZWQuCj4+Cj4+IFNvIHdlIGFyZSBub3QgbGltaXRlZCBieSBob3cgdGhlIHBh
Z2VzIGFyZSBhY3R1YWxseSBhbGxvY2F0ZWQ/Cj4+Cj4gSW4gY29oZXJlbnQgRE1BIGNhc2VzLCB3
ZSBuZWVkIHRvIHJldHVybiBzb21lIG1lbW9yeSB3aXRoIGNvbnRpZ3VvdXMKPiBrZXJuZWwgdmly
dHVhbCBhZGRyZXNzZXMuIFRoYXQgaXMgdGhlIHJlYXNvbiB3aHkgd2UgbmVlZCB2bWFsbG9jKCkK
PiBoZXJlLiBJZiB3ZSBhbGxvY2F0ZSB0aGUgbWVtb3J5IHBhZ2UgYnkgcGFnZSwgdGhlIGNvcnJl
c3BvbmRpbmcga2VybmVsCj4gdmlydHVhbCBhZGRyZXNzZXMgaW4gYSBjb250aWd1b3VzIElPVkEg
cmFuZ2UgbWlnaHQgbm90IGJlIGNvbnRpZ3VvdXMuCgoKWWVzLCBidXQgd2UgY2FuIGRvIHRoYXQg
YXMgd2hhdCBoYXMgYmVlbiBkb25lIGluIHRoZSBzZXJpZXMgCihhbGxvY19wYWdlc19leGFjdCgp
KS4gT3IgZG8geW91IG1lYW4gaXQgd291bGQgYmUgYSBsaXR0bGUgYml0IGhhcmQgdG8gCnJlY3lj
bGUgSU9WQS9wYWdlcyBoZXJlPwoKVGhhbmtzCgoKPiBBbmQgaW4gc3RyZWFtaW5nIERNQSBjYXNl
cywgdGhlcmUgaXMgbm8gbGltaXQuIFNvIGFub3RoZXIgY2hvaWNlIGlzCj4gdXNpbmcgdm1hbGxv
YydlZCBtZW1vcnkgb25seSBmb3IgY29oZXJlbnQgRE1BIGNhc2VzLgo+Cj4gTm90IHN1cmUgaWYg
dGhpcyBpcyBjbGVhciBmb3IgeW91Lgo+Cj4gVGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=
