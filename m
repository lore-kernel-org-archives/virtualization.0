Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23FC433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 12:56:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6772312E
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 12:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6772312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B899E22F05;
	Tue, 22 Dec 2020 12:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vSMSdDBWp-ou; Tue, 22 Dec 2020 12:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B24182047D;
	Tue, 22 Dec 2020 12:56:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9982AC1825;
	Tue, 22 Dec 2020 12:56:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B475CC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AFBB5869A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rddm8BDGgKrW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:56:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ADAFB867FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608641800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ogZRhqVu5q9mojvGMAotSvNvS5JdueUvVG0eDaDK5jw=;
 b=M0k3CJ9dacN9yhB9OxmDh3UQhVyKYrFPJf/3QvNOqP+HU1BjjXnfooNT/SL68uBNSOoMWY
 cX1m0eUkXuwl8qo3NadvOpNt/mQwx4InUhkmg+14MArRnYv1uNwBNGZE9PvV0UIh9gCvvO
 rJ69jM+vgXZRtB1rsSLV1ZSpJAr1m4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-J9s2d9tfOFmaagKMummreA-1; Tue, 22 Dec 2020 07:56:35 -0500
X-MC-Unique: J9s2d9tfOFmaagKMummreA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10EF61005504;
 Tue, 22 Dec 2020 12:56:34 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B5039A62;
 Tue, 22 Dec 2020 12:56:23 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
From: Jason Wang <jasowang@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
 <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
 <20201222105733.4f6oou7lshi35qvc@steredhat>
 <cc913954-135d-da5a-1acd-38c3ecb77dfa@redhat.com>
Message-ID: <0a3c1304-6ed3-d68d-848c-1c9871f8dd53@redhat.com>
Date: Tue, 22 Dec 2020 20:56:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cc913954-135d-da5a-1acd-38c3ecb77dfa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTIvMjIg5LiL5Y2IODoyOSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IE9uIDIwMjAv
MTIvMjIg5LiL5Y2INjo1NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+PiBPbiBUdWUsIERl
YyAyMiwgMjAyMCBhdCAxMDo0NDo0OEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+
IE9uIDIwMjAvMTIvMjEg5LiL5Y2INzoxNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4+
IE9uIE1vbiwgRGVjIDIxLCAyMDIwIGF0IDExOjE2OjU0QU0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjAvMTIvMTgg5LiL5Y2INzozOCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6NDhBTSArMDgw
MCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pgo+Pj4+Pj4+IE9uIDIwMjAvMTEvMTMg5LiL5Y2I
OTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4+Pj4+PiBUaGFua3MgdG8gTWF4IHRo
YXQgc3RhcnRlZCB0aGlzIHdvcmshCj4+Pj4+Pj4+IEkgdG9vayBoaXMgcGF0Y2hlcywgYW5kIGV4
dGVuZGVkIHRoZSBibG9jayBzaW11bGF0b3IgYSBiaXQuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFRoaXMg
c2VyaWVzIG1vdmVzIHRoZSBuZXR3b3JrIGRldmljZSBzaW11bGF0b3IgaW4gYSBuZXcgbW9kdWxl
Cj4+Pj4+Pj4+ICh2ZHBhX3NpbV9uZXQpIGFuZCBsZWF2ZXMgdGhlIGdlbmVyaWMgZnVuY3Rpb25z
IGluIHRoZSB2ZHBhX3NpbSAKPj4+Pj4+Pj4gY29yZQo+Pj4+Pj4+PiBtb2R1bGUsIGFsbG93aW5n
IHRoZSBwb3NzaWJpbGl0eSB0byBhZGQgbmV3IHZEUEEgZGV2aWNlIAo+Pj4+Pj4+PiBzaW11bGF0
b3JzLgo+Pj4+Pj4+PiBUaGVuIHdlIGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBtb2R1bGUgdG8g
c2ltdWxhdGUgYSBibG9jayAKPj4+Pj4+Pj4gZGV2aWNlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJJ20g
bm90IHN1cmUgYWJvdXQgcGF0Y2ggMTEgKCJ2cmluZ2g6IGFsbG93IHZyaW5naF9pb3ZfeGZlcigp
IAo+Pj4+Pj4+PiB0byBza2lwCj4+Pj4+Pj4+IGJ5dGVzIHdoZW4gcHRyIGlzIE5VTEwiKSwgbWF5
YmUgd2UgY2FuIGFkZCBhIG5ldyBmdW5jdGlvbnMgCj4+Pj4+Pj4+IGluc3RlYWQgb2YKPj4+Pj4+
Pj4gbW9kaWZ5IHZyaW5naF9pb3ZfeGZlcigpLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBcyBNYXggcmVw
b3J0ZWQsIEknbSBhbHNvIHNlZWluZyBlcnJvcnMgd2l0aCB2ZHBhX3NpbV9ibGsgCj4+Pj4+Pj4+
IHJlbGF0ZWQgdG8KPj4+Pj4+Pj4gaW90bGIgYW5kIHZyaW5naCB3aGVuIHRoZXJlIGlzIGhpZ2gg
bG9hZCwgdGhlc2UgYXJlIHNvbWUgb2YgdGhlIAo+Pj4+Pj4+PiBlcnJvcgo+Pj4+Pj4+PiBtZXNz
YWdlcyBJIGNhbiBzZWUgcmFuZG9tbHk6Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IMKgIHZyaW5naDogRmFp
bGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgMDAwMDAwMDBlOGRlYjJjYwo+Pj4+Pj4+PiDCoCB2
cmluZ2g6IEZhaWxlZCB0byByZWFkIGhlYWQ6IGlkeCA2Mjg5IGFkZHJlc3MgMDAwMDAwMDBlMWFk
MWQ1MAo+Pj4+Pj4+PiDCoCB2cmluZ2g6IEZhaWxlZCB0byBnZXQgZmxhZ3MgYXQgMDAwMDAwMDA2
NjM1ZDdhMwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiDCoCB2aXJ0aW9fdmRwYSB2ZHBhMDogdnJpbmdoX2lv
dl9wdXNoX2lvdGxiKCkgZXJyb3I6IC0xNCBvZmZzZXQ6IAo+Pj4+Pj4+PiDCoCAweDI4NDAwMDAg
bGVuOiAweDIwMDAwCj4+Pj4+Pj4+IMKgIHZpcnRpb192ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1
bGxfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogCj4+Pj4+Pj4+IMKgIDB4NThlZTAwMCBsZW46
IDB4MzAwMAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGVzZSBlcnJvcnMgc2hvdWxkIGFsbCBiZSByZWxh
dGVkIHRvIHRoZSBmYWN0IHRoYXQgCj4+Pj4+Pj4+IGlvdGxiX3RyYW5zbGF0ZSgpCj4+Pj4+Pj4+
IGZhaWxzIHdpdGggLUVJTlZBTCwgc28gaXQgc2VlbXMgdGhhdCB3ZSBtaXNzIHNvbWUgbWFwcGlu
Zy4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gSXMgdGhpcyBvbmx5IHJlcHJvZHVjaWJsZSB3aGVu
IHRoZXJlJ3MgbXVsdGlwbGUgY28tY3VycmVudCAKPj4+Pj4+PiBhY2Nlc3Npbmcgb2YgSU9UTEI/
IElmIHllcywgaXQncyBwcm9iYWJseSBhIGhpbnQgdGhhdCBzb21lIGtpbmQgCj4+Pj4+Pj4gb2Yg
c3luY2hyb25pemF0aW9uIGlzIHN0aWxsIG1pc3NlZCBzb21ld2hlcmUuCj4+Pj4+Pj4KPj4+Pj4+
PiBJdCBtaWdodCBiZSB1c2VmdWwgdG8gbG9nIHRoZSBkbWFfbWFwL3VubXAgaW4gYm90aCB2aXJ0
aW9fcmluZyAKPj4+Pj4+PiBhbmQgdnJpbmdoIHRvIHNlZSB3aG8gaXMgbWlzc2luZyB0aGUgbWFw
Lgo+Pj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gSnVzdCBhbiB1cGRhdGUgYWJvdXQgdGhlc2UgaXNzdWVz
IHdpdGggdmRwYS1zaW0tYmxrLgo+Pj4+Pj4gSSd2ZSBiZWVuIGZvY3VzaW5nIGEgbGl0dGxlIGJp
dCBvbiB0aGVzZSBmYWlsdXJlcyBvdmVyIHRoZSBsYXN0IAo+Pj4+Pj4gZmV3IGRheXMgYW5kIGhh
dmUgZm91bmQgdHdvIGlzc3VlcyByZWxhdGVkIHRvIHRoZSBJT1RMQi9JT01NVToKPj4+Pj4+Cj4+
Pj4+PiAxLiBTb21lIHJlcXVlc3RzIGNvbWluZyBmcm9tIHRoZSBibG9jayBsYXllciBmaWxscyB0
aGUgU0cgbGlzdCAKPj4+Pj4+IHdpdGggbXVsdGlwbGUgYnVmZmVycyB0aGF0IGhhZCB0aGUgc2Ft
ZSBwaHlzaWNhbCBhZGRyZXNzLiBUaGlzIAo+Pj4+Pj4gaGFwcGVucyBmb3IgZXhhbXBsZSB3aGls
ZSB1c2luZyAnbWtmcycsIGF0IHNvbWUgcG9pbnRzIG11bHRpcGxlIAo+Pj4+Pj4gc2VjdG9ycyBh
cmUgemVyb2VkIHNvIG11bHRpcGxlIFNHIGVsZW1lbnRzIHBvaW50IHRvIHRoZSBzYW1lIAo+Pj4+
Pj4gcGh5c2ljYWwgcGFnZSB0aGF0IGlzIHplcm9lZC4KPj4+Pj4+IFNpbmNlIHdlIGFyZSB1c2lu
ZyB2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoKSBpbiB0aGUgCj4+Pj4+PiB2ZHBhc2ltX3VubWFwX3Bh
Z2UoKSwgdGhpcyByZW1vdmVzIGFsbCB0aGUgb3ZlcmxhcHBlZCByYW5nZXMuIEkgCj4+Pj4+PiBm
aXhlZCByZW1vdmluZyBhIHNpbmdsZSBtYXAgaW4gdmRwYXNpbV91bm1hcF9wYWdlKCksIGJ1dCBo
YXMgYW4gCj4+Pj4+PiBhbHRlcm5hdGl2ZSB3ZSBjYW4gaW1wbGVtZW50IHNvbWUga2luZCBvZiBy
ZWZlcmVuY2UgY291bnRzLgo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBJIHRoaW5rIHdlIG5lZWQgdG8gZG8g
d2hhdCBoYXJkd2FyZSBkby4gU28gdXNpbmcgcmVmY291bnQgaXMgCj4+Pj4+IHByb2JhYmx5IG5v
dCBhIGdvb2QgaWRhLgo+Pj4+Cj4+Pj4gT2theSwgc28gc2luY2Ugd2UgYXJlIHVzaW5nIGZvciBz
aW1wbGljaXR5IGFuIGlkZW50aWNhbCBtYXBwaW5nLCB3ZSAKPj4+PiBhcmUgYXNzaWduaW5nIHRo
ZSBzYW1lIGRtYV9hZGRyIHRvIG11bHRpcGxlIHBhZ2VzLgo+Pj4KPj4+Cj4+PiBJIHRoaW5rIEkg
Z2V0IHlvdSBub3cuIFRoYXQncyB0aGUgcm9vdCBjYXVzZSBmb3IgdGhlIGZhaWx1cmUuCj4+Cj4+
IFllcywgc29ycnksIEkgZGlkbid0IGV4cGxhaW4gd2VsbCBwcmV2aW91c2x5Lgo+Pgo+Pj4KPj4+
IFRoZW4gSSB0aGluayB3ZSBuZWVkIGFuIHNpbXBsZSBpb3ZhIGFsbG9jYXRvciBmb3IgdmRwYSBz
aW11bGF0b3IsIAo+Pj4gYW5kIGl0IG1pZ2h0IGJlIHVzZWZ1bCBmb3IgVkRVU0UgYXMgd2VsbC4K
Pj4KPj4gT2theSwgSSdsbCB3b3JrIG9uIGl0Lgo+PiBJZiB5b3UgaGF2ZSBhbiBleGFtcGxlIHRv
IGZvbGxvdyBvciBzb21lIHBvaW50ZXJzLCB0aGV5IGFyZSB3ZWxjb21lIDotKQo+Cj4KPiBLZXJu
ZWwgaGFkIGltcGxlbWVudGVkIG9uZSBpbiBpb3ZhLmMgYnV0IEknbSBub3Qgc3VyZSB3ZSBuZWVk
IHRoZSAKPiBjb21wbGV4aXR5IGxpa2UgdGhhdC4gT3Igd2UgY2FuIGp1c3QgdXNlIHJidHJlZSBv
ciBpZHIgdG8gaW1wbGVtZW50IGEgCj4gc2ltcGxlciBvbmUuCgoKVkRVU0VbMV0gaW1wbGVtZW50
cyBhbm90aGVyIGFsbG9jYXRvciwgYnV0IGl0J3Mgc3RpbGwgY29tcGxpY2F0ZWQgc2luY2UgCml0
IG5lZWRzIHRvIHRyYWNrIGJvdW5jZSBwYWdlcy4gSSBmZWVsIGxpa2Ugd2UnZCBiZXR0ZXIgc3Rh
cnQgZnJvbSBhIApzaW1wbGUgb25lLgoKVGhhbmtzCgpbMV0gaHR0cHM6Ly93d3cuc3Bpbmljcy5u
ZXQvbGlzdHMvbGludXgtbW0vbXNnMjMxNTc2Lmh0bWwKCj4KPiBUaGFua3MKPgo+Cj4+Cj4+IFRo
YW5rcywKPj4gU3RlZmFubwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
