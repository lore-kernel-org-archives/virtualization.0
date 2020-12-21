Return-Path: <SRS0=paXq=FZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2CEC433DB
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 03:17:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC0422CF8
	for <virtualization@archiver.kernel.org>; Mon, 21 Dec 2020 03:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0422CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 90E652E3CC;
	Mon, 21 Dec 2020 03:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKFsxc2GSMkI; Mon, 21 Dec 2020 03:17:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1363F20768;
	Mon, 21 Dec 2020 03:17:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF112C1787;
	Mon, 21 Dec 2020 03:17:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAACEC0893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 03:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9DABA8789C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 03:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wR9+f+KV6qUg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 03:17:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4329C87895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Dec 2020 03:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608520631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsblJmOtG9tZ7kKpi056Ey60jmaFEOA9x9uDqAciUmU=;
 b=TC9qqpOtE6v3d5pM/mKcGB3OUWaYaJTOy4N69lOmlB25p19gs2S0WWJYDuQAhVKAvMdLh5
 khPmSmDa0GWjef9juzWwIKjFfx5YNOlfc/JgX/MiRaFVcq0fHQWhBkBk0KUBICUAssviaJ
 nxOHgPPbZ3SOfT5fYv4Sp3p2vjcwrLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-Sm0RUi0JMFO9BXgQjLPUpA-1; Sun, 20 Dec 2020 22:17:07 -0500
X-MC-Unique: Sm0RUi0JMFO9BXgQjLPUpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56008800D55;
 Mon, 21 Dec 2020 03:17:06 +0000 (UTC)
Received: from [10.72.12.173] (ovpn-12-173.pek2.redhat.com [10.72.12.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E75575D9CA;
 Mon, 21 Dec 2020 03:16:55 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
Date: Mon, 21 Dec 2020 11:16:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218113816.zcyeyqipux4ao4cp@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvMTIvMTgg5LiL5Y2INzozOCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IE1vbiwgTm92IDE2LCAyMDIwIGF0IDExOjM3OjQ4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gVGhhbmtzIHRvIE1heCB0aGF0IHN0YXJ0ZWQgdGhpcyB3b3JrIQo+Pj4gSSB0b29rIGhp
cyBwYXRjaGVzLCBhbmQgZXh0ZW5kZWQgdGhlIGJsb2NrIHNpbXVsYXRvciBhIGJpdC4KPj4+Cj4+
PiBUaGlzIHNlcmllcyBtb3ZlcyB0aGUgbmV0d29yayBkZXZpY2Ugc2ltdWxhdG9yIGluIGEgbmV3
IG1vZHVsZQo+Pj4gKHZkcGFfc2ltX25ldCkgYW5kIGxlYXZlcyB0aGUgZ2VuZXJpYyBmdW5jdGlv
bnMgaW4gdGhlIHZkcGFfc2ltIGNvcmUKPj4+IG1vZHVsZSwgYWxsb3dpbmcgdGhlIHBvc3NpYmls
aXR5IHRvIGFkZCBuZXcgdkRQQSBkZXZpY2Ugc2ltdWxhdG9ycy4KPj4+IFRoZW4gd2UgYWRkZWQg
YSBuZXcgdmRwYV9zaW1fYmxrIG1vZHVsZSB0byBzaW11bGF0ZSBhIGJsb2NrIGRldmljZS4KPj4+
Cj4+PiBJJ20gbm90IHN1cmUgYWJvdXQgcGF0Y2ggMTEgKCJ2cmluZ2g6IGFsbG93IHZyaW5naF9p
b3ZfeGZlcigpIHRvIHNraXAKPj4+IGJ5dGVzIHdoZW4gcHRyIGlzIE5VTEwiKSwgbWF5YmUgd2Ug
Y2FuIGFkZCBhIG5ldyBmdW5jdGlvbnMgaW5zdGVhZCBvZgo+Pj4gbW9kaWZ5IHZyaW5naF9pb3Zf
eGZlcigpLgo+Pj4KPj4+IEFzIE1heCByZXBvcnRlZCwgSSdtIGFsc28gc2VlaW5nIGVycm9ycyB3
aXRoIHZkcGFfc2ltX2JsayByZWxhdGVkIHRvCj4+PiBpb3RsYiBhbmQgdnJpbmdoIHdoZW4gdGhl
cmUgaXMgaGlnaCBsb2FkLCB0aGVzZSBhcmUgc29tZSBvZiB0aGUgZXJyb3IKPj4+IG1lc3NhZ2Vz
IEkgY2FuIHNlZSByYW5kb21seToKPj4+Cj4+PiDCoCB2cmluZ2g6IEZhaWxlZCB0byBhY2Nlc3Mg
YXZhaWwgaWR4IGF0IDAwMDAwMDAwZThkZWIyY2MKPj4+IMKgIHZyaW5naDogRmFpbGVkIHRvIHJl
YWQgaGVhZDogaWR4IDYyODkgYWRkcmVzcyAwMDAwMDAwMGUxYWQxZDUwCj4+PiDCoCB2cmluZ2g6
IEZhaWxlZCB0byBnZXQgZmxhZ3MgYXQgMDAwMDAwMDA2NjM1ZDdhMwo+Pj4KPj4+IMKgIHZpcnRp
b192ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDog
wqAgCj4+PiAweDI4NDAwMDAgbGVuOiAweDIwMDAwCj4+PiDCoCB2aXJ0aW9fdmRwYSB2ZHBhMDog
dnJpbmdoX2lvdl9wdWxsX2lvdGxiKCkgZXJyb3I6IC0xNCBvZmZzZXQ6IMKgIAo+Pj4gMHg1OGVl
MDAwIGxlbjogMHgzMDAwCj4+Pgo+Pj4gVGhlc2UgZXJyb3JzIHNob3VsZCBhbGwgYmUgcmVsYXRl
ZCB0byB0aGUgZmFjdCB0aGF0IGlvdGxiX3RyYW5zbGF0ZSgpCj4+PiBmYWlscyB3aXRoIC1FSU5W
QUwsIHNvIGl0IHNlZW1zIHRoYXQgd2UgbWlzcyBzb21lIG1hcHBpbmcuCj4+Cj4+Cj4+IElzIHRo
aXMgb25seSByZXByb2R1Y2libGUgd2hlbiB0aGVyZSdzIG11bHRpcGxlIGNvLWN1cnJlbnQgYWNj
ZXNzaW5nIAo+PiBvZiBJT1RMQj8gSWYgeWVzLCBpdCdzIHByb2JhYmx5IGEgaGludCB0aGF0IHNv
bWUga2luZCBvZiAKPj4gc3luY2hyb25pemF0aW9uIGlzIHN0aWxsIG1pc3NlZCBzb21ld2hlcmUu
Cj4+Cj4+IEl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cgdGhlIGRtYV9tYXAvdW5tcCBpbiBib3Ro
IHZpcnRpb19yaW5nIGFuZCAKPj4gdnJpbmdoIHRvIHNlZSB3aG8gaXMgbWlzc2luZyB0aGUgbWFw
Lgo+Pgo+Cj4gSnVzdCBhbiB1cGRhdGUgYWJvdXQgdGhlc2UgaXNzdWVzIHdpdGggdmRwYS1zaW0t
YmxrLgo+IEkndmUgYmVlbiBmb2N1c2luZyBhIGxpdHRsZSBiaXQgb24gdGhlc2UgZmFpbHVyZXMg
b3ZlciB0aGUgbGFzdCBmZXcgCj4gZGF5cyBhbmQgaGF2ZSBmb3VuZCB0d28gaXNzdWVzIHJlbGF0
ZWQgdG8gdGhlIElPVExCL0lPTU1VOgo+Cj4gMS4gU29tZSByZXF1ZXN0cyBjb21pbmcgZnJvbSB0
aGUgYmxvY2sgbGF5ZXIgZmlsbHMgdGhlIFNHIGxpc3Qgd2l0aCAKPiBtdWx0aXBsZSBidWZmZXJz
IHRoYXQgaGFkIHRoZSBzYW1lIHBoeXNpY2FsIGFkZHJlc3MuIFRoaXMgaGFwcGVucyBmb3IgCj4g
ZXhhbXBsZSB3aGlsZSB1c2luZyAnbWtmcycsIGF0IHNvbWUgcG9pbnRzIG11bHRpcGxlIHNlY3Rv
cnMgYXJlIHplcm9lZCAKPiBzbyBtdWx0aXBsZSBTRyBlbGVtZW50cyBwb2ludCB0byB0aGUgc2Ft
ZSBwaHlzaWNhbCBwYWdlIHRoYXQgaXMgemVyb2VkLgo+IFNpbmNlIHdlIGFyZSB1c2luZyB2aG9z
dF9pb3RsYl9kZWxfcmFuZ2UoKSBpbiB0aGUgCj4gdmRwYXNpbV91bm1hcF9wYWdlKCksIHRoaXMg
cmVtb3ZlcyBhbGwgdGhlIG92ZXJsYXBwZWQgcmFuZ2VzLiBJIGZpeGVkIAo+IHJlbW92aW5nIGEg
c2luZ2xlIG1hcCBpbiB2ZHBhc2ltX3VubWFwX3BhZ2UoKSwgYnV0IGhhcyBhbiBhbHRlcm5hdGl2
ZSAKPiB3ZSBjYW4gaW1wbGVtZW50IHNvbWUga2luZCBvZiByZWZlcmVuY2UgY291bnRzLgoKCkkg
dGhpbmsgd2UgbmVlZCB0byBkbyB3aGF0IGhhcmR3YXJlIGRvLiBTbyB1c2luZyByZWZjb3VudCBp
cyBwcm9iYWJseSAKbm90IGEgZ29vZCBpZGEuCgoKPgo+IDIuIFRoZXJlIHdhcyBhIHJhY2UgYmV0
d2VlbiBkbWFfbWFwL3VubWFwIGFuZCB0aGUgd29ya2VyIHRocmVhZCwgc2luY2UgCj4gYm90aCBh
cmUgYWNjZXNzaW5nIHRoZSBJT01NVS4gVGFraW5nIHRoZSBpb21tdV9sb2NrIHdoaWxlIHVzaW5n
IAo+IHZob3N0X2lvdGxiXyogQVBJIGluIHRoZSB3b3JrZXIgdGhyZWFkIGZpeGVzIHRoZSAidnJp
bmdoOiBGYWlsZWQgdG8gKiIgCj4gaXNzdWVzLgo+Cj4gV2hpdCB0aGVzZSBpc3N1ZXMgZml4ZWQg
dGhlIHZkcGEtYmxrIHNpbXVsYXRvciBzZWVtcyB0byB3b3JrIHdlbGwuCj4gSSdsbCBzZW5kIHRo
ZSBwYXRjaGVzIG5leHQgd2VlayBvciBhZnRlciB0aGUgYnJlYWsuCgoKR29vZCB0byBrbm93IHRo
aXMuCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
