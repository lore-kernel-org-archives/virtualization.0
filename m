Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF02FC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:27:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A17464EC9
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 07:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A17464EC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84DF04ECD3;
	Fri,  5 Mar 2021 07:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLjxEn8f6RY8; Fri,  5 Mar 2021 07:27:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C68684ECCE;
	Fri,  5 Mar 2021 07:27:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0108C000A;
	Fri,  5 Mar 2021 07:27:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDB7C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EE5D844FE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zwBl27TQF-ia
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:27:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E89E844DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 07:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614929255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LvHmj7I5tVS6ZWOqyKUXrImPH08lo+bLYq1nqRXxbs=;
 b=MUO/fBWHtJm7hZ6OgrPhTWkjXf5EHuP/Rs51r336QaA3jwP5rjmV68pLzU63uXOwSgaXRf
 qtkEtbwVseb5JEpeAVFAMIZf7L9MI5TMbvkuWnUl8NzzkHRoU4V0fiNHwaJzZ5LUXu1xIf
 w92PTh9KEfeivDFBF7PRTwULdfBk2H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-R71zD7spPoikVopChlDsgA-1; Fri, 05 Mar 2021 02:27:33 -0500
X-MC-Unique: R71zD7spPoikVopChlDsgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 640EF804330;
 Fri,  5 Mar 2021 07:27:31 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-165.pek2.redhat.com
 [10.72.12.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FF105C1A1;
 Fri,  5 Mar 2021 07:27:13 +0000 (UTC)
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2652f696-faf7-26eb-a8b2-c4cfe3aaed15@redhat.com>
Date: Fri, 5 Mar 2021 15:27:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CACycT3sUJNmi2BdLsi3W72+qTKQaCo_nQYu-fdxg9y4pAvBMow@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMy81IDM6MTMg5LiL5Y2ILCBZb25namkgWGllIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDUsIDIwMjEgYXQgMjo1MiBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPj4KPj4gT24gMjAyMS8zLzUgMjoxNSDkuIvljYgsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Cj4+
IFNvcnJ5IGlmIEkndmUgYXNrZWQgdGhpcyBiZWZvcmUuCj4+Cj4+IEJ1dCB3aGF0J3MgdGhlIHJl
YXNvbiBmb3IgbWFpbnRhaW5nIGEgZGVkaWNhdGVkIElPVExCIGhlcmU/IEkgdGhpbmsgd2UKPj4g
Y291bGQgcmV1c2UgdmR1c2VfZGV2LT5pb21tdSBzaW5jZSB0aGUgZGV2aWNlIGNhbiBub3QgYmUg
dXNlZCBieSBib3RoCj4+IHZpcnRpbyBhbmQgdmhvc3QgaW4gdGhlIHNhbWUgdGltZSBvciB1c2Ug
dmR1c2VfaW92YV9kb21haW4tPmlvdGxiIGZvcgo+PiBzZXRfbWFwKCkuCj4+Cj4+IFRoZSBtYWlu
IGRpZmZlcmVuY2UgYmV0d2VlbiBkb21haW4tPmlvdGxiIGFuZCBkZXYtPmlvdGxiIGlzIHRoZSB3
YXkgdG8KPj4gZGVhbCB3aXRoIGJvdW5jZSBidWZmZXIuIEluIHRoZSBkb21haW4tPmlvdGxiIGNh
c2UsIGJvdW5jZSBidWZmZXIKPj4gbmVlZHMgdG8gYmUgbWFwcGVkIGVhY2ggRE1BIHRyYW5zZmVy
IGJlY2F1c2Ugd2UgbmVlZCB0byBnZXQgdGhlIGJvdW5jZQo+PiBwYWdlcyBieSBhbiBJT1ZBIGR1
cmluZyBETUEgdW5tYXBwaW5nLiBJbiB0aGUgZGV2LT5pb3RsYiBjYXNlLCBib3VuY2UKPj4gYnVm
ZmVyIG9ubHkgbmVlZHMgdG8gYmUgbWFwcGVkIG9uY2UgZHVyaW5nIGluaXRpYWxpemF0aW9uLCB3
aGljaCB3aWxsCj4+IGJlIHVzZWQgdG8gdGVsbCB1c2Vyc3BhY2UgaG93IHRvIGRvIG1tYXAoKS4K
Pj4KPj4gQWxzbywgc2luY2Ugdmhvc3QgSU9UTEIgc3VwcG9ydCBwZXIgbWFwcGluZyB0b2tlbiAo
b3BhdXFlKSwgY2FuIHdlIHVzZQo+PiB0aGF0IGluc3RlYWQgb2YgdGhlIGJvdW5jZV9wYWdlcyAq
Pwo+Pgo+PiBTb3JyeSwgSSBkaWRuJ3QgZ2V0IHlvdSBoZXJlLiBXaGljaCB2YWx1ZSBkbyB5b3Ug
bWVhbiB0byBzdG9yZSBpbiB0aGUKPj4gb3BhcXVlIHBvaW50ZXLvvJ8KPj4KPj4gU28gSSB3b3Vs
ZCBsaWtlIHRvIGhhdmUgYSB3YXkgdG8gdXNlIGEgc2luZ2xlIElPVExCIGZvciBtYW5hZ2UgYWxs
IGtpbmRzCj4+IG9mIG1hcHBpbmdzLiBUd28gcG9zc2libGUgaWRlYXM6Cj4+Cj4+IDEpIG1hcCBi
b3VuY2UgcGFnZSBvbmUgYnkgb25lIGluIHZkdXNlX2Rldl9tYXBfcGFnZSgpLCBpbgo+PiBWRFVT
RV9JT1RMQl9HRVRfRkQsIHRyeSB0byBtZXJnZSB0aGUgcmVzdWx0IGlmIHdlIGhhZCB0aGUgc2Ft
ZSBmZC4gVGhlbgo+PiBmb3IgYm91bmNlIHBhZ2VzLCB1c2Vyc3BhY2Ugc3RpbGwgb25seSBuZWVk
IHRvIG1hcCBpdCBvbmNlIGFuZCB3ZSBjYW4KPj4gbWFpbnRhaW4gdGhlIGFjdHVhbCBtYXBwaW5n
IGJ5IHN0b3JpbmcgdGhlIHBhZ2Ugb3IgcGEgaW4gdGhlIG9wYXF1ZQo+PiBmaWVsZCBvZiBJT1RM
QiBlbnRyeS4KPj4KPj4gTG9va3MgbGlrZSB1c2Vyc3BhY2Ugc3RpbGwgbmVlZHMgdG8gdW5tYXAg
dGhlIG9sZCByZWdpb24gYW5kIG1hcCBhIG5ldwo+PiByZWdpb24gKHNpemUgaXMgY2hhbmdlZCkg
d2l0aCB0aGUgZmQgaW4gZWFjaCBWRFVTRV9JT1RMQl9HRVRfRkQgaW9jdGwuCj4+Cj4+Cj4+IEkg
ZG9uJ3QgZ2V0IGhlcmUuIENhbiB5b3UgZ2l2ZSBhbiBleGFtcGxlPwo+Pgo+IEZvciBleGFtcGxl
LCB1c2Vyc3BhY2UgbmVlZHMgdG8gcHJvY2VzcyB0d28gSS9PIHJlcXVlc3RzIChvbmUgcGFnZSBw
ZXIKPiByZXF1ZXN0KS4gVG8gcHJvY2VzcyB0aGUgZmlyc3QgcmVxdWVzdCwgdXNlcnNwYWNlIHVz
ZXMKPiBWRFVTRV9JT1RMQl9HRVRfRkQgaW9jdGwgdG8gcXVlcnkgdGhlIGlvdmEgcmVnaW9uICgw
IH4gNDA5NikgYW5kIG1tYXAKPiBpdC4KCgpJIHRoaW5rIGluIHRoaXMgY2FzZSB3ZSBzaG91bGQg
bGV0IFZEVVNFX0lPVExCX0dFVF9GRCByZXR1cm4gdGhlIG1heGltdW0gCnJhbmdlIGFzIGZhciBh
cyB0aGV5IGFyZSBiYWNrZWQgYnkgdGhlIHNhbWUgZmQuCgpJbiB0aGUgY2FzZSBvZiBib3VuY2Ug
cGFnZSwgaXQncyBiYXNjaWFsbHkgdGhlIHdob2xlIHJhbmdlIG9mIGJvdW5jZSBidWZmZXI/CgpU
aGFua3MKCgo+IFRvIHByb2Nlc3MgdGhlIHNlY29uZCByZXF1ZXN0LCB1c2Vyc3BhY2UgdXNlcyBW
RFVTRV9JT1RMQl9HRVRfRkQKPiBpb2N0bCB0byBxdWVyeSB0aGUgbmV3IGlvdmEgcmVnaW9uIGFu
ZCBtYXAgYSBuZXcgcmVnaW9uICgwIH4gODE5MikuCj4gVGhlbiB1c2Vyc3BhY2UgbmVlZHMgdG8g
dHJhdmVyc2UgdGhlIGxpc3Qgb2YgaW92YSByZWdpb25zIGFuZCB1bm1hcAo+IHRoZSBvbGQgcmVn
aW9uICgwIH4gNDA5NikuIExvb2tzIGxpa2UgdGhpcyBpcyBhIGxpdHRsZSBjb21wbGV4Lgo+Cj4g
VGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
