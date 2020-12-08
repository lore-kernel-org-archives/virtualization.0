Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76496C4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:30:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FA523998
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FA523998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 947B587B08;
	Tue,  8 Dec 2020 02:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Seln9RNdOBVI; Tue,  8 Dec 2020 02:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCCFE87A88;
	Tue,  8 Dec 2020 02:30:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7654C0FA7;
	Tue,  8 Dec 2020 02:30:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 855C2C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6BBAD87A88
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rValiI0mRjpB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0807087A81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607394628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHQXQXwhB48erNU0sC3fLYCg0ds4gNDB64PnsF6D+IY=;
 b=WOLq6V32lHXztTpNF2LDerkqQR/nVKrChcbMhyevF3hUH4Fb1T3SM5R0AhfQyqvzA5JalE
 sVWZ0dH0DuuV+dEGq0nNrXsrNAN3Lojlz4ILmVpu9+M94Om3lEzWjfIQQZhIKFZQ8xOpUv
 qaZSgQLZDHzE/CHn9R6gTqt0SfJqovg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-nXvSqz8JPxShKW9Dp0bjIw-1; Mon, 07 Dec 2020 21:30:26 -0500
X-MC-Unique: nXvSqz8JPxShKW9Dp0bjIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98143AFA80;
 Tue,  8 Dec 2020 02:30:25 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F20F360636;
 Tue,  8 Dec 2020 02:30:15 +0000 (UTC)
Subject: Re: [RFC PATCH 5/8] vhost: allow userspace to bind vqs to CPUs
To: Mike Christie <michael.christie@oracle.com>, sgarzare@redhat.com,
 stefanha@redhat.com, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
 <1607068593-16932-6-git-send-email-michael.christie@oracle.com>
 <4546ef72-da7c-df9e-53be-c937a5437436@redhat.com>
 <30746f1c-ed8c-d2ae-9513-54fca8f52739@oracle.com>
 <ea5fa99c-7d8f-b7de-42f1-691dc26dc3d2@redhat.com>
 <9974de14-194c-95e9-b26b-315f31130051@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0beb8747-57b2-4f6a-2877-c44164810e50@redhat.com>
Date: Tue, 8 Dec 2020 10:30:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9974de14-194c-95e9-b26b-315f31130051@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvMTIvOCDkuIrljYgyOjMxLCBNaWtlIENocmlzdGllIHdyb3RlOgo+IE9uIDEyLzYv
MjAgMTA6MjcgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvMTIvNSDkuIrljYgx
MjozMiwgTWlrZSBDaHJpc3RpZSB3cm90ZToKPj4+IE9uIDEyLzQvMjAgMjowOSBBTSwgSmFzb24g
V2FuZyB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIwMjAvMTIvNCDkuIvljYgzOjU2LCBNaWtlIENocmlz
dGllIHdyb3RlOgo+Pj4+PiArc3RhdGljIGxvbmcgdmhvc3RfdnJpbmdfc2V0X2NwdShzdHJ1Y3Qg
dmhvc3RfZGV2ICpkLCBzdHJ1Y3QgCj4+Pj4+IHZob3N0X3ZpcnRxdWV1ZSAqdnEsCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCBfX3VzZXIgKmFyZ3ApCj4+Pj4+ICt7
Cj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZob3N0X3ZyaW5nX3N0YXRlIHM7Cj4+Pj4+ICvCoMKgwqAg
aW50IHJldCA9IDA7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDCoCBpZiAodnEtPnByaXZhdGVfZGF0YSkK
Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDC
oCBpZiAoY29weV9mcm9tX3VzZXIoJnMsIGFyZ3AsIHNpemVvZiBzKSkKPj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUZBVUxUOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKHMubnVtID09
IC0xKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2cS0+Y3B1ID0gcy5udW07Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+ICsKPj4+Pj4gK8KgwqDC
oCBpZiAocy5udW0gPj0gbnJfY3B1X2lkcykKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgaWYgKCFkLT5vcHMgfHwgIWQtPm9wcy0+Z2V0
X3dvcmtxdWV1ZSkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiAr
Cj4+Pj4+ICvCoMKgwqAgaWYgKCFkLT53cSkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGQtPndxID0g
ZC0+b3BzLT5nZXRfd29ya3F1ZXVlKCk7Cj4+Pj4+ICvCoMKgwqAgaWYgKCFkLT53cSkKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgdnEt
PmNwdSA9IHMubnVtOwo+Pj4+PiArwqDCoMKgIHJldHVybiByZXQ7Cj4+Pj4+ICt9Cj4+Pj4KPj4+
Pgo+Pj4+IFNvIG9uZSBxdWVzdGlvbiBoZXJlLiBXaG8gaXMgaW4gY2hhcmdlIG9mIGRvaW5nIHRo
aXMgc2V0X2NwdT8gTm90ZSAKPj4+PiB0aGF0wqBzY2hlZF9zZXRhZmZpbml0eSgyKSByZXF1aXJl
cyBDQVBfU1lTX05JQ0UgdG8gd29yaywgc28gSSAKPj4+PiB3b25kZXIgd2hldGhlciBvciBub3Qg
aXQncyBsZWdhbCBmb3IgdW5wcml2aWxlZ2VkIFFlbXUgdG8gZG8gdGhpcy4KPj4+Cj4+Pgo+Pj4g
SSB3YXMgaGF2aW5nIHFlbXUgZG8gaXQgd2hlbiBpdCdzIHNldHRpbmcgdXAgdGhlIHZxcyBzaW5j
ZSBpdCBoYWQgCj4+PiB0aGUgaW5mbyB0aGVyZSBhbHJlYWR5Lgo+Pj4KPj4+IElzIGl0IG5vcm1h
bGx5IHRoZSB0b29sIHRoYXQgbWFrZXMgY2FsbHMgaW50byBxZW11IHRoYXQgZG9lcyB0aGUgCj4+
PiBvcGVyYXRpb25zIHRoYXQgcmVxdWlyZSBDQVBfU1lTX05JQ0U/IAo+Pgo+Pgo+PiBNeSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgaXQgb25seSBtYXR0ZXIgc2NoZWR1bGluZy4gQW5kIHRoaXMgcGF0
Y2ggCj4+IHdhbnRzIHRvIGNoYW5nZSB0aGUgYWZmaW5pdHkgd2hpY2ggc2hvdWxkIGNoZWNrIHRo
YXQgY2FwYWJpbGl0eS4KPj4KPj4KPj4+IElmIHNvLCB0aGVuIEkgc2VlIHRoZSBpbnRlcmZhY2Ug
bmVlZHMgdG8gYmUgY2hhbmdlZC4KPj4KPj4KPj4gQWN0dWFsbHksIGlmIEkgcmVhZCB0aGlzIHBh
dGNoIGNvcnJlY3RseSBpdCByZXF1aXJlcyBlLmcgcWVtdSB0byBtYWtlIAo+PiB0aGUgZGVjaXNp
b24gaW5zdGVhZCBvZiB0aGUgbWFuYWdlbWVudCBsYXllci4gVGhpcyBtYXkgYnJpbmcgc29tZSAK
Pj4gdHJvdWJsZXMgdG8gZm9yIGUuZyB0aGUgbGlidmlydCBlbXVsYXRvcnBpblsxXSBpbXBsZW1l
bnRhdGlvbi4KPj4KPgo+IExldCBtZSBtYWtlIHN1cmUgSSB1bmRlcnN0b29kIHlvdS4KPgo+IEkg
dGhvdWdodCBxZW11IHdvdWxkIGp1c3QgaGF2ZSBhIG5ldyBwcm9wZXJ0eSwgYW5kIHVzZXJzIHdv
dWxkIHBhc3MgCj4gdGhhdCBpbiBsaWtlIHRoZXkgZG8gZm9yIHRoZSBudW1iZXIgb2YgcXVldWVz
IHNldHRpbmcuIFRoZW4gcWVtdSB3b3VsZCAKPiBwYXNzIHRoYXQgdG8gdGhlIGtlcm5lbC4gVGhl
IHByaW1hcnkgdXNlciBJIGhhdmUgdG8gc3VwcG9ydCBhdCB3b3JrIAo+IGRvZXMgbm90IHVzZSBs
aWJ2aXJ0IGJhc2VkIHRvb2xzIHNvIEkgdGhvdWdodCB0aGF0IHdhcyBhIGNvbW1vbiBwb2ludCAK
PiB0aGF0IHdvdWxkIHdvcmsgZm9yIGV2ZXJ5b25lLgoKCkkgdGhpbmsgd2UgbmVlZCB0YWxrIHdp
dGggbGlidmlydCBndXlzIHRvIHNlZSBpZiBpdCB3b3JrcyBmb3IgdGhlbS4gTXkgCnVuZGVyc3Rh
bmRpbmcgaXMgdGhlIHNjaGVkdWxpbmcgc2hvdWxkIGJlIHRoZSBjaGFyZ2Ugb2YgdGhlbSBub3Qg
cWVtdS4KCgo+Cj4gRm9yIG15IHdvcmsgdXNlIHJlcXVpcmVtZW50LCB5b3VyIGVtdWxhdG9ycGlu
IGFuZCBDQVBfU1lTX05JQ0UgY29tbWVudCAKPiB0aGVuIHRoYXQgbWVhbnMgd2Ugd2FudCBhbiBp
bnRlcmZhY2UgdGhhdCBzb21ldGhpbmcgb3RoZXIgdGhhbiBxZW11IAo+IGNhbiB1c2UgcmlnaHQ/
IFNvIHRoZSB0b29scyB3b3VsZCBjYWxsIGRpcmVjdGx5IGludG8gdGhlIGtlcm5lbCBhbmQgCj4g
bm90IGdvIHRocm91Z2ggcWVtdSByaWdodD8KCgpZZXMsIHVzdWFsbHkgcWVtdSBydW5zIHdpdGhv
dXQgYW55IHByaXZpbGVnZS4gU28gY291bGQgaXQgYmUgZS5nIGEgc3lzZnMgCmludGVyZmFjZSBv
ciBvdGhlcj8KClRoYW5rcwoKCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
