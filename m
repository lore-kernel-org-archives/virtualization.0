Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D249C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 04:00:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E743222F9
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 04:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E743222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3770D86F41;
	Mon,  7 Dec 2020 04:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AO2qTWcX9mqv; Mon,  7 Dec 2020 04:00:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32AF386EFE;
	Mon,  7 Dec 2020 04:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A16C0FA7;
	Mon,  7 Dec 2020 04:00:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3EEC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6049687331
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVkWU6dTOTp6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BBDA987328
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 04:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607313630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNjTsielO4F3/rlOTAeVEcwEo4ih/pfIX8Fxa5vfASY=;
 b=WUuCyscMV/0uDf1w7m0rjckAcT7G1C7Cc9Eu0v0L9mGmCeWEavnLWeVmstO5+KSyzf10Ex
 k7zjr6PSzTGKzPWuqlXntAKsnqul4pMBexKbioq1bpvvsvuedH5u+olmMIaxyY5cZlcr3C
 pnrNKfjwCRxoKERo+GN03ui6u5imI/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-fGf-jxRoOX-zOv3r-DnZCg-1; Sun, 06 Dec 2020 23:00:29 -0500
X-MC-Unique: fGf-jxRoOX-zOv3r-DnZCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A61581CAF6;
 Mon,  7 Dec 2020 04:00:27 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA2A25C1BB;
 Mon,  7 Dec 2020 04:00:08 +0000 (UTC)
Subject: Re: [PATCH v3 05/19] vdpa_sim: remove the limit of IOTLB entries
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-6-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d7b00b70-9785-db1f-1e42-7b9172b7ad90@redhat.com>
Date: Mon, 7 Dec 2020 12:00:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-6-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Shahaf Shuler <shahafs@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>, Oren Duer <oren@nvidia.com>
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

Ck9uIDIwMjAvMTIvNCDkuIrljYgxOjA0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gVGhl
IHNpbXVsYXRlZCBkZXZpY2VzIGNhbiBzdXBwb3J0IG11bHRpcGxlIHF1ZXVlcywgc28gdGhpcyBs
aW1pdAo+IHNob3VsZCBiZSBkZWZpbmVkIGFjY29yZGluZyB0byB0aGUgbnVtYmVyIG9mIHF1ZXVl
cyBzdXBwb3J0ZWQgYnkKPiB0aGUgZGV2aWNlLgo+Cj4gU2luY2Ugd2UgYXJlIGluIGEgc2ltdWxh
dG9yLCBsZXQncyBzaW1wbHkgcmVtb3ZlIHRoYXQgbGltaXQuCj4KPiBTdWdnZXN0ZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxz
Z2FyemFyZUByZWRoYXQuY29tPgoKClJldGhpbmsgYWJvdXQgdGhpcywgc2luY2Ugc2ltdWxhdG9y
IGNhbiBiZSB1c2VkIGJ5IFZNLCBzbyB0aGUgYWxsb2NhdGlvbiAKaXMgYWN0dWFsbHkgZ3Vlc3Qg
dHJpZ2dlci1hYmxlIHdoZW4gdklPTU1VIGlzIGVuYWJsZWQuCgpUaGlzIG1lYW5zIHdlIG5lZWQg
YSBsaW1pdCBzb21laG93LCAoZS5nIEkgcmVtZW1iZXIgc3dpb3RsYiBpcyBhYm91dCAKNjRNQiBi
eSBkZWZhdWx0KS4gT3IgaGF2aW5nIGEgbW9kdWxlIHBhcmFtZXRlciBmb3IgdGhpcy4KCkJ0dywg
aGF2ZSB5b3UgbWV0IGFueSBpc3N1ZSB3aGVuIHVzaW5nIDIwNDgsIEkgZ3Vlc3MgaXQgY2FuIGhh
cHBlbiB3aGVuIAp3ZSBydW4gc2V2ZXJhbCBwcm9jZXNzZXMgaW4gcGFyYWxsZWw/CgoKPiAtLS0K
PiB2MzoKPiAtIHVzZWQgVkhPU1RfSU9UTEJfVU5MSU1JVEVEIG1hY3JvIFtKYXNvbl0KPiB2MjoK
PiAtIGFkZGVkIFZEUEFTSU1fSU9UTEJfTElNSVQgbWFjcm8gW0phc29uXQo+IC0tLQo+ICAgZHJp
dmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5j
Cj4gaW5kZXggMjk1YTc3MGNhYWMwLi42ODhhY2VhYTY1NDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+IEBAIC0zNjgsNyArMzY4LDcgQEAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2
ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+ICAgCWlmICghdmRwYXNpbS0+dnFzKQo+ICAgCQlnb3RvIGVy
cl9pb21tdTsKPiAgIAo+IC0JdmRwYXNpbS0+aW9tbXUgPSB2aG9zdF9pb3RsYl9hbGxvYygyMDQ4
LCAwKTsKPiArCXZkcGFzaW0tPmlvbW11ID0gdmhvc3RfaW90bGJfYWxsb2MoVkhPU1RfSU9UTEJf
VU5MSU1JVEVELCAwKTsKPiAgIAlpZiAoIXZkcGFzaW0tPmlvbW11KQo+ICAgCQlnb3RvIGVycl9p
b21tdTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
