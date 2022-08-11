Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB06C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53CE54182C;
	Thu, 11 Aug 2022 13:47:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53CE54182C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U0WTKCTH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QZpYYVeOBbZ; Thu, 11 Aug 2022 13:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FDDB417BB;
	Thu, 11 Aug 2022 13:47:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FDDB417BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AAEAC0032;
	Thu, 11 Aug 2022 13:47:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBBBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0B9E417BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0B9E417BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HeJLFBf-b9WQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D435F417BB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D435F417BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660225616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnYbZn3d/ZVf9YlldbRuOvAvqpY0e39cFa9Me7K6+LI=;
 b=U0WTKCTHAAj7dqvAd8yuGx2U3TMcV/P1laDy4sL3S1phoYbmQKho6JLJwwp+TzdvuwhdPQ
 8xNh0eJxxsBJnznNDngWCrQ8VUrdr2vh66g2Y8IUTEMQRwKQWz5Ef/bCj9zyf0wXIY4rgN
 DVsL/dRjpRNBpIOlstofkqb7TB75uQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-9_1xxhzHMm-uNSyY4kamkA-1; Thu, 11 Aug 2022 09:46:49 -0400
X-MC-Unique: 9_1xxhzHMm-uNSyY4kamkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10FCC18E0BF9;
 Thu, 11 Aug 2022 13:46:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8032C15BA6;
 Thu, 11 Aug 2022 13:46:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <20220810094004.1250-3-ricardo.canuelo@collabora.com>
Organization: Red Hat GmbH
References: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
 <20220810094004.1250-3-ricardo.canuelo@collabora.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Thu, 11 Aug 2022 15:46:46 +0200
Message-ID: <87czd6dha1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: mst@redhat.com, kernel@collabora.com, bagasdotme@gmail.com,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBBdWcgMTAgMjAyMiwgUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNv
bGxhYm9yYS5jb20+IHdyb3RlOgoKPiBCYXNpYyBkb2MgYWJvdXQgVmlydGlvIG9uIExpbnV4IGFu
ZCBhIHNob3J0IHR1dG9yaWFsIG9uIFZpcnRpbyBkcml2ZXJzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
UmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNvbGxhYm9yYS5jb20+Cj4gLS0tCj4g
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9pbmRleC5yc3QgICAgICAgICAgICB8ICAgMSArCj4g
IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0ICAgICB8ICAxMSArKwo+
ICBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QgICAgfCAxNDQgKysr
KysrKysrKysrKysKPiAgLi4uL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdCAgICAg
ICAgIHwgMTg2ICsrKysrKysrKysrKysrKysrKwo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICA1IGZpbGVzIGNoYW5nZWQsIDM0MyBpbnNl
cnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkv
dmlydGlvL2luZGV4LnJzdAo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RyaXZlci1hcGkvdmlydGlvL3dyaXRpbmdfdmlydGlvX2RyaXZlcnMucnN0Cj4KCiguLi4p
Cgo+ICsuLiBydWJyaWM6OiBGb290bm90ZXMKPiArCj4gKy4uIFsjZjFdIHRoYXQncyB3aHkgdGhl
eSBtYXkgYmUgYWxzbyByZWZlcnJlZCBhcyB2aXJ0cmluZ3MuCgoicmVmZXJyZWQgdG8iCgooLi4u
KQoKPiArVGhlIGBgcHJvYmVgYCBtZXRob2QgZG9lcyB0aGUgbWluaW11bSBkcml2ZXIgc2V0dXAg
aW4gdGhpcyBjYXNlCj4gKyhtZW1vcnkgYWxsb2NhdGlvbiBmb3IgdGhlIGRldmljZSBkYXRhKSBh
bmQgaW5pdGlhbGl6ZXMgdGhlCj4gK3ZpcnRxdWV1ZS4gVGhlIHZpcnRxdWV1ZXMgYXJlIGF1dG9t
YXRpY2FsbHkgZW5hYmxlZCBhZnRlciBgYHByb2JlYGAKPiArcmV0dXJucywgc2VuZGluZyB0aGUg
YXBwcm9wcmlhdGUgIkRSSVZFUl9PSyIgc3RhdHVzIHNpZ25hbCB0byB0aGUKPiArZGV2aWNlLiBJ
ZiB0aGUgdmlydHF1ZXVlcyBuZWVkIHRvIGJlIGVuYWJsZWQgYmVmb3JlIGBgcHJvYmVgYCBlbmRz
LCB0aGV5Cj4gK2NhbiBiZSBtYW51YWxseSBlbmFibGVkIGJ5IGNhbGxpbmcgdmlydGlvX2Rldmlj
ZV9yZWFkeSgpOgo+ICsKPiArLi4ga2VybmVsLWRvYzo6IGluY2x1ZGUvbGludXgvdmlydGlvX2Nv
bmZpZy5oCj4gKyAgICA6aWRlbnRpZmllcnM6IHZpcnRpb19kZXZpY2VfcmVhZHkKCkhtLCBub3Qg
cXVpdGUgc3VyZSB3aGF0IHRoZSBhY3R1YWwgZXhwZWN0YXRpb25zIGFyZSBoZXJlOiBTaG91bGQg
dGhlCmRyaXZlciBzZXQgRFJJVkVSX09LIGluIGl0cyBwcm9iZSBmdW5jdGlvbiwgYW5kIHRoZSBj
b3JlIG9ubHkgc2V0IGl0IGFzCmEgZmFsbGJhY2s/IE1pY2hhZWwsIEphc29uPwoKKC4uLikKCkxH
VE0gaW4gZ2VuZXJhbC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
