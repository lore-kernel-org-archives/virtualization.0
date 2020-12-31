Return-Path: <SRS0=UCi2=GD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C47CC433E6
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 07:12:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D297C22288
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 07:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297C22288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8420385EB8;
	Thu, 31 Dec 2020 07:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMUYC4yZ8MLj; Thu, 31 Dec 2020 07:12:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FFF885EAA;
	Thu, 31 Dec 2020 07:12:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8052CC0174;
	Thu, 31 Dec 2020 07:12:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96306C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 07:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8933386D0F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 07:12:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KFAyyJADYupU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 07:12:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3B9EF86D01
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 07:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609398724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAcrvLM32Ywi1/Zvr81ALgzIuiKyK3fudx4Woo1wUAI=;
 b=am28qsOl9ZOPN/S6JxTBZukNTy7LpDrelYi87qdrosx9PzpfOubOhmxeN0JR2QHbU/2cNS
 YaUqkYJUFVRkqPifaVzRTrN5FdptEHsfm0PUKzlSydK5qHa305QwvsXwsugvMU6FHL5Tx1
 Aoh0eu0L0aY8/W94b7xq41j6NsXWuhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-T8AMp5lvMtiib-hqImZizQ-1; Thu, 31 Dec 2020 02:12:03 -0500
X-MC-Unique: T8AMp5lvMtiib-hqImZizQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A339A801AC2;
 Thu, 31 Dec 2020 07:12:00 +0000 (UTC)
Received: from [10.72.12.236] (ovpn-12-236.pek2.redhat.com [10.72.12.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B32C10021B3;
 Thu, 31 Dec 2020 07:11:48 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
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
 <0885385c-ae46-158d-eabf-433ef8ecf27f@redhat.com>
 <CACycT3tc2P63k6J9ZkWTpPvHk_H8zUq0_Q6WOqYX_dSigUAnzA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <79741d5d-0c35-ad1c-951a-41d8ab3b36a0@redhat.com>
Date: Thu, 31 Dec 2020 15:11:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tc2P63k6J9ZkWTpPvHk_H8zUq0_Q6WOqYX_dSigUAnzA@mail.gmail.com>
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

Ck9uIDIwMjAvMTIvMzEg5LiL5Y2IMjo1MiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBUaHUsIERl
YyAzMSwgMjAyMCBhdCAxOjUwIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzMxIOS4i+WNiDE6MTUsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+
PiBPbiBUaHUsIERlYyAzMSwgMjAyMCBhdCAxMDo0OSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4+PiBPbiAyMDIwLzEyLzMwIOS4i+WNiDY6MTIsIFlvbmdqaSBY
aWUgd3JvdGU6Cj4+Pj4+IE9uIFdlZCwgRGVjIDMwLCAyMDIwIGF0IDQ6NDEgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBPbiAyMDIwLzEyLzMwIOS4i+WN
iDM6MDksIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4gT24gV2VkLCBEZWMgMzAsIDIwMjAgYXQg
MjoxMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4g
T24gMjAyMC8xMi8yOSDkuIvljYg2OjI2LCBZb25namkgWGllIHdyb3RlOgo+Pj4+Pj4+Pj4gT24g
VHVlLCBEZWMgMjksIDIwMjAgYXQgNToxMSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPj4+Pj4+Pj4+PiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4+Pj4+
Pj4+Pj4+IE9uIE1vbiwgRGVjIDI4LCAyMDIwIGF0IDQ6NDMgUE0gSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+PiBPbiAyMDIwLzEyLzI4IOS4i+WNiDQ6
MTQsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4+IEkgc2VlLiBTbyBhbGwgdGhlIGFi
b3ZlIHR3byBxdWVzdGlvbnMgYXJlIGJlY2F1c2UgVkhPU1RfSU9UTEJfSU5WQUxJREFURQo+Pj4+
Pj4+Pj4+Pj4+PiBpcyBleHBlY3RlZCB0byBiZSBzeW5jaHJvbm91cy4gVGhpcyBuZWVkIHRvIGJl
IHNvbHZlZCBieSB0d2Vha2luZyB0aGUKPj4+Pj4+Pj4+Pj4+Pj4gY3VycmVudCBWRFVTRSBBUEkg
b3Igd2UgY2FuIHJlLXZpc2l0IHRvIGdvIHdpdGggZGVzY3JpcHRvcnMgcmVsYXlpbmcKPj4+Pj4+
Pj4+Pj4+Pj4gZmlyc3QuCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQWN0dWFsbHkgYWxs
IHZkcGEgcmVsYXRlZCBvcGVyYXRpb25zIGFyZSBzeW5jaHJvbm91cyBpbiBjdXJyZW50Cj4+Pj4+
Pj4+Pj4+Pj4gaW1wbGVtZW50YXRpb24uIFRoZSBvcHMuc2V0X21hcC9kbWFfbWFwL2RtYV91bm1h
cCBzaG91bGQgbm90IHJldHVybgo+Pj4+Pj4+Pj4+Pj4+IHVudGlsIHRoZSBWRFVTRV9VUERBVEVf
SU9UTEIvVkRVU0VfSU5WQUxJREFURV9JT1RMQiBtZXNzYWdlIGlzIHJlcGxpZWQKPj4+Pj4+Pj4+
Pj4+PiBieSB1c2Vyc3BhY2UuIENvdWxkIGl0IHNvbHZlIHRoaXMgcHJvYmxlbT8KPj4+Pj4+Pj4+
Pj4+ICAgICAgICBJIHdhcyB0aGlua2luZyB3aGV0aGVyIG9yIG5vdCB3ZSBuZWVkIHRvIGdlbmVy
YXRlIElPVExCX0lOVkFMSURBVEUKPj4+Pj4+Pj4+Pj4+IG1lc3NhZ2UgdG8gVkRVU0UgZHVyaW5n
IGRtYV91bm1hcCAodmR1c2VfZGV2X3VubWFwX3BhZ2UpLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+IElmIHdlIGRvbid0LCB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gSXQgc2VlbXMgbm90IGZlYXNpYmxlLiBUaGlzIG1lc3NhZ2Ugd2lsbCBiZSBhbHNvIHVz
ZWQgaW4gdGhlCj4+Pj4+Pj4+Pj4+IHZpcnRpby12ZHBhIGNhc2UgdG8gbm90aWZ5IHVzZXJzcGFj
ZSB0byB1bm1hcCBzb21lIHBhZ2VzIGR1cmluZwo+Pj4+Pj4+Pj4+PiBjb25zaXN0ZW50IGRtYSB1
bm1hcHBpbmcuIE1heWJlIHdlIGNhbiBkb2N1bWVudCBpdCB0byBtYWtlIHN1cmUgdGhlCj4+Pj4+
Pj4+Pj4+IHVzZXJzIGNhbiBoYW5kbGUgdGhlIG1lc3NhZ2UgY29ycmVjdGx5Lgo+Pj4+Pj4+Pj4+
IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50Lgo+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4gRG8geW91IG1lYW4geW91IHBsYW4gdG8gbm90aWZ5IHRoZSB1bm1hcCBvZiAxKSBz
dHJlYW1pbmcgRE1BIG9yIDIpCj4+Pj4+Pj4+Pj4gY29oZXJlbnQgRE1BPwo+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4gRm9yIDEpIHlvdSBwcm9iYWJseSBuZWVkIGEgd29ya3F1ZXVlIHRvIGRvIHRoYXQg
c2luY2UgZG1hIHVubWFwIGNhbgo+Pj4+Pj4+Pj4+IGJlIGRvbmUgaW4gaXJxIG9yIGJoIGNvbnRl
eHQuIEFuZCBpZiB1c3JzcGFjZSBkb2VzJ3QgZG8gdGhlIHVubWFwLCBpdAo+Pj4+Pj4+Pj4+IGNh
biBzdGlsbCBhY2Nlc3MgdGhlIGJvdW5jZSBidWZmZXIgKGlmIHlvdSBkb24ndCB6YXAgcHRlKT8K
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSSBwbGFuIHRvIGRvIGl0IGluIHRoZSBjb2hlcmVudCBETUEg
Y2FzZS4KPj4+Pj4+Pj4gQW55IHJlYXNvbiBmb3IgdHJlYXRpbmcgY29oZXJlbnQgRE1BIGRpZmZl
cmVudGx5Pwo+Pj4+Pj4+Pgo+Pj4+Pj4+IE5vdyB0aGUgbWVtb3J5IG9mIHRoZSBib3VuY2UgYnVm
ZmVyIGlzIGFsbG9jYXRlZCBwYWdlIGJ5IHBhZ2UgaW4gdGhlCj4+Pj4+Pj4gcGFnZSBmYXVsdCBo
YW5kbGVyLiBTbyBpdCBjYW4ndCBiZSB1c2VkIGluIGNvaGVyZW50IERNQSBtYXBwaW5nIGNhc2UK
Pj4+Pj4+PiB3aGljaCBuZWVkcyBzb21lIG1lbW9yeSB3aXRoIGNvbnRpZ3VvdXMgdmlydHVhbCBh
ZGRyZXNzZXMuIEkgY2FuIHVzZQo+Pj4+Pj4+IHZtYWxsb2MoKSB0byBkbyBhbGxvY2F0aW9uIGZv
ciB0aGUgYm91bmNlIGJ1ZmZlciBpbnN0ZWFkLiBCdXQgaXQgbWlnaHQKPj4+Pj4+PiBjYXVzZSBz
b21lIG1lbW9yeSB3YXN0ZS4gQW55IHN1Z2dlc3Rpb24/Cj4+Pj4+PiBJIG1heSBtaXNzIHNvbWV0
aGluZy4gQnV0IEkgZG9uJ3Qgc2VlIGEgcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlCj4+Pj4+PiBJ
T1RMQl9VTk1BUCBhbmQgdm1hbGxvYygpLgo+Pj4+Pj4KPj4+Pj4gSW4gdGhlIHZtYWxsb2MoKSBj
YXNlLCB0aGUgY29oZXJlbnQgRE1BIHBhZ2Ugd2lsbCBiZSB0YWtlbiBmcm9tIHRoZQo+Pj4+PiBt
ZW1vcnkgYWxsb2NhdGVkIGJ5IHZtYWxsb2MoKS4gU28gSU9UTEJfVU5NQVAgaXMgbm90IG5lZWRl
ZCBhbnltb3JlCj4+Pj4+IGR1cmluZyBjb2hlcmVudCBETUEgdW5tYXBwaW5nIGJlY2F1c2UgdGhv
c2Ugdm1hbGxvYydlZCBtZW1vcnkgd2hpY2gKPj4+Pj4gaGFzIGJlZW4gbWFwcGVkIGludG8gdXNl
cnNwYWNlIGFkZHJlc3Mgc3BhY2UgZHVyaW5nIGluaXRpYWxpemF0aW9uIGNhbgo+Pj4+PiBiZSBy
ZXVzZWQuIEFuZCB1c2Vyc3BhY2Ugc2hvdWxkIG5vdCB1bm1hcCB0aGUgcmVnaW9uIHVudGlsIHdl
IGRlc3Ryb3kKPj4+Pj4gdGhlIGRldmljZS4KPj4+PiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVy
c3RhbmQuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBJT1RMQl9VTk1BUCBpcwo+Pj4+IG9ubHkg
bmVlZGVkIHdoZW4gdGhlcmUncyBhIGNoYW5nZSB0aGUgbWFwcGluZyBmcm9tIElPVkEgdG8gcGFn
ZS4KPj4+Pgo+Pj4gWWVzLCB0aGF0J3MgdHJ1ZS4KPj4+Cj4+Pj4gU28gaWYgd2Ugc3RpY2sgdG8g
dGhlIG1hcHBpbmcsIGUuZyBkdXJpbmcgZG1hX3VubWFwLCB3ZSBqdXN0IHB1dCBJT1ZBIHRvCj4+
Pj4gZnJlZSBsaXN0IHRvIGJlIHVzZWQgYnkgdGhlIG5leHQgSU9WQSBhbGxvY2F0aW5nLiBJT1RM
Ql9VTk1BUCBjb3VsZCBiZQo+Pj4+IGF2b2lkZWQuCj4+Pj4KPj4+PiBTbyB3ZSBhcmUgbm90IGxp
bWl0ZWQgYnkgaG93IHRoZSBwYWdlcyBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkPwo+Pj4+Cj4+PiBJ
biBjb2hlcmVudCBETUEgY2FzZXMsIHdlIG5lZWQgdG8gcmV0dXJuIHNvbWUgbWVtb3J5IHdpdGgg
Y29udGlndW91cwo+Pj4ga2VybmVsIHZpcnR1YWwgYWRkcmVzc2VzLiBUaGF0IGlzIHRoZSByZWFz
b24gd2h5IHdlIG5lZWQgdm1hbGxvYygpCj4+PiBoZXJlLiBJZiB3ZSBhbGxvY2F0ZSB0aGUgbWVt
b3J5IHBhZ2UgYnkgcGFnZSwgdGhlIGNvcnJlc3BvbmRpbmcga2VybmVsCj4+PiB2aXJ0dWFsIGFk
ZHJlc3NlcyBpbiBhIGNvbnRpZ3VvdXMgSU9WQSByYW5nZSBtaWdodCBub3QgYmUgY29udGlndW91
cy4KPj4KPj4gWWVzLCBidXQgd2UgY2FuIGRvIHRoYXQgYXMgd2hhdCBoYXMgYmVlbiBkb25lIGlu
IHRoZSBzZXJpZXMKPj4gKGFsbG9jX3BhZ2VzX2V4YWN0KCkpLiBPciBkbyB5b3UgbWVhbiBpdCB3
b3VsZCBiZSBhIGxpdHRsZSBiaXQgaGFyZCB0bwo+PiByZWN5Y2xlIElPVkEvcGFnZXMgaGVyZT8K
Pj4KPiBZZXMsIGl0IG1pZ2h0IGJlIGhhcmQgdG8gcmV1c2UgdGhlIG1lbW9yeS4gRm9yIGV4YW1w
bGUsIHdlIGZpcnN0bHkKPiBhbGxvY2F0ZSAxIElPVkEvcGFnZSBkdXJpbmcgZG1hX21hcCwgdGhl
biB0aGUgSU9WQSBpcyBmcmVlZCBkdXJpbmcKPiBkbWFfdW5tYXAuIEFjdHVhbGx5IHdlIGNhbid0
IHJldXNlIHRoaXMgc2luZ2xlIHBhZ2UgaWYgd2UgbmVlZCBhCj4gdHdvLXBhZ2VzIGFyZWEgaW4g
dGhlIG5leHQgSU9WQSBhbGxvY2F0aW5nLiBTbyB0aGUgYmVzdCB3YXkgaXMgdXNpbmcKPiBJT1RM
Ql9VTk1BUCB0byBmcmVlIHRoaXMgc2luZ2xlIHBhZ2UgZHVyaW5nIGRtYV91bm1hcCB0b28uCj4K
PiBUaGFua3MsCj4gWW9uZ2ppCgoKSSBnZXQgeW91IG5vdy4gVGhlbiBJIGFncmVlIHRoYXQgbGV0
J3MgZ28gd2l0aCBJT1RMQl9VTk1BUC4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
