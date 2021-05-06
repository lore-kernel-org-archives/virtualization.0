Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07EAC433B4
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:20:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3C9613BD
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 03:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3C9613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB44D401E4;
	Thu,  6 May 2021 03:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ngicaewau-vD; Thu,  6 May 2021 03:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4F0B040186;
	Thu,  6 May 2021 03:20:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28807C000E;
	Thu,  6 May 2021 03:20:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1E4FC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:20:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B30F583BC7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:20:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8GLVxpUwIlr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:20:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82DD783BC8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620271247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbydVeY5N5w2QHP37+lnpEX2xyTMiLn/vdBHF5b1sNc=;
 b=hl8skKT7xboezdjAlPQ1QX0Yxu5ELNjBEBhpfj4EnGVjvdeOhAtWGthBtw+G04muIYqWXO
 F76+sLDHs7DBxFwBL+z3vDiFRO/J90OIu+W2IYK1xoTKYiH4p/ukVsmWDRQQfSRpFP/WJd
 JAsMsR4wQKMtcct/i9MRbMmYmgcL/Rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-MouFwKIkOKSXWHLTMzNwpg-1; Wed, 05 May 2021 23:20:44 -0400
X-MC-Unique: MouFwKIkOKSXWHLTMzNwpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 648C38015F4;
 Thu,  6 May 2021 03:20:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-159.pek2.redhat.com
 [10.72.13.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2096D19C46;
 Thu,  6 May 2021 03:20:31 +0000 (UTC)
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To: mst@redhat.com
References: <20210423080942.2997-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
Date: Thu, 6 May 2021 11:20:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210423080942.2997-1-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8yMyDPws7nNDowOSwgSmFzb24gV2FuZyDQtLXAOgo+IEhpOgo+Cj4gU29tZXRp
bWVzLCB0aGUgZHJpdmVyIGRvZXNuJ3QgdHJ1c3QgdGhlIGRldmljZS4gVGhpcyBpcyB1c3VhbGx5
Cj4gaGFwcGVucyBmb3IgdGhlIGVuY3J0cHllZCBWTSBvciBWRFVTRVsxXS4gSW4gYm90aCBjYXNl
cywgdGVjaG5vbG9neQo+IGxpa2Ugc3dpb3RsYiBpcyB1c2VkIHRvIHByZXZlbnQgdGhlIHBva2lu
Zy9tYW5nbGluZyBvZiBtZW1vcnkgZnJvbSB0aGUKPiBkZXZpY2UuIEJ1dCB0aGlzIGlzIG5vdCBz
dWZmaWNpZW50IHNpbmNlIGN1cnJlbnQgdmlydGlvIGRyaXZlciBtYXkKPiB0cnVzdCB3aGF0IGlz
IHN0b3JlZCBpbiB0aGUgZGVzY3JpcHRvciB0YWJsZSAoY29oZXJlbnQgbWFwcGluZykgZm9yCj4g
cGVyZm9ybWluZyB0aGUgRE1BIG9wZXJhdGlvbnMgbGlrZSB1bm1hcCBhbmQgYm91bmNlIHNvIHRo
ZSBkZXZpY2UgbWF5Cj4gY2hvb3NlIHRvIHV0aWxpemUgdGhlIGJlaGF2aW91ciBvZiBzd2lvdGxi
IHRvIHBlcmZvcm0gYXR0YWNrc1syXS4KPgo+IFRvIHByb3RlY3QgZnJvbSBhIG1hbGljb3VzIGRl
dmljZSwgdGhpcyBzZXJpZXMgc3RvcmUgYW5kIHVzZSB0aGUKPiBkZXNjcmlwdG9yIG1ldGFkYXRh
IGluIGFuIGF1eGlsaWF5IHN0cnVjdHVyZSB3aGljaCBjYW4gbm90IGJlIGFjY2Vzc2VkCj4gdmlh
IHN3aW90bGIgaW5zdGVhZCBvZiB0aGUgb25lcyBpbiB0aGUgZGVzY3JpcHRvciB0YWJsZS4gVGhp
cyBtZWFucwo+IHRoZSBkZXNjcmlwdG9yIHRhYmxlIGlzIHdyaXRlLW9ubHkgZnJvbSB0aGUgdmll
dyBvZiB0aGUgZHJpdmVyLgo+Cj4gQWN0dWFsbHksIHdlJ3ZlIGFsbW9zdCBhY2hpZXZlZCB0aGF0
IHRocm91Z2ggcGFja2VkIHZpcnRxdWV1ZSBhbmQgd2UKPiBqdXN0IG5lZWQgdG8gZml4IGEgY29y
bmVyIGNhc2Ugb2YgaGFuZGxpbmcgbWFwcGluZyBlcnJvcnMuIEZvciBzcGxpdAo+IHZpcnRxdWV1
ZSB3ZSBqdXN0IGZvbGxvdyB3aGF0J3MgZG9uZSBpbiB0aGUgcGFja2VkLgo+Cj4gTm90ZSB0aGF0
IHdlIGRvbid0IGR1cGxpY2F0ZSBkZXNjcmlwdG9yIG1lZGF0YSBmb3IgaW5kaXJlY3QKPiBkZXNj
cmlwdG9ycyBzaW5jZSBpdCB1c2VzIHN0cmVhbSBtYXBwaW5nIHdoaWNoIGlzIHJlYWQgb25seSBz
byBpdCdzCj4gc2FmZSBpZiB0aGUgbWV0YWRhdGEgb2Ygbm9uLWluZGlyZWN0IGRlc2NyaXB0b3Jz
IGFyZSBjb3JyZWN0Lgo+Cj4gRm9yIHNwbGl0IHZpcnRxdWV1ZSwgdGhlIGNoYW5nZSBpbmNyZWFz
ZSB0aGUgZm9vdHByaW50IGR1ZSB0aGUgdGhlCj4gYXV4aWxpYXJ5IG1ldGFkYXRhIGJ1dCBpdCdz
IGFsbW9zdCBuZWdsZWN0bGFibGUgaW4gdGhlIHNpbXBsZSB0ZXN0Cj4gbGlrZSBwa3RnZW4gb3Ig
bmV0cGVmLgo+Cj4gU2xpZ2h0bHkgdGVzdGVkIHdpdGggcGFja2VkIG9uL29mZiwgaW9tbXUgb24v
b2YsIHN3aW90bGIgZm9yY2Uvb2ZmIGluCj4gdGhlIGd1ZXN0Lgo+Cj4gUGxlYXNlIHJldmlldy4K
Pgo+IENoYW5nZXMgZnJvbSBWMToKPiAtIEFsd2F5cyB1c2UgYXV4aWxpYXJ5IG1ldGFkYXRhIGZv
ciBzcGxpdCB2aXJ0cXVldWUKPiAtIERvbid0IHJlYWQgZnJvbSBkZXNjcmlwdG8gd2hlbiBkZXRh
Y2hpbmcgaW5kaXJlY3QgZGVzY3JpcHRvcgoKCkhpIE1pY2hhZWw6CgpPdXIgUUUgc2VlIG5vIHJl
Z3Jlc3Npb24gb24gdGhlIHBlcmYgdGVzdCBmb3IgMTBHIGJ1dCBzb21lIHJlZ3Jlc3Npb25zIAoo
NSUtMTAlKSBvbiA0MEcgY2FyZC4KCkkgdGhpbmsgdGhpcyBpcyBleHBlY3RlZCBzaW5jZSB3ZSBp
bmNyZWFzZSB0aGUgZm9vdHByaW50LCBhcmUgeW91IE9LIAp3aXRoIHRoaXMgYW5kIHdlIGNhbiB0
cnkgdG8gb3B0aW1pemUgb24gdG9wIG9yIHlvdSBoYXZlIG90aGVyIGlkZWFzPwoKVGhhbmtzCgoK
Pgo+IFsxXQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi9mYWI2MTVjZS01ZTEzLWEz
YjMtMzcxNS1hNDIwM2I0YWIwMTBAcmVkaGF0LmNvbS9ULwo+IFsyXQo+IGh0dHBzOi8veWhidC5u
ZXQvbG9yZS9hbGwvYzM2MjlhMjctMzU5MC0xZDlmLTIxMWItYzBiN2JlMTUyYjMyQHJlZGhhdC5j
b20vVC8jbWM2YjZlMjM0M2NiZWZmY2E2OGNhN2E5N2UwZjQ3M2FhYTg3MWM5NWIKPgo+IEphc29u
IFdhbmcgKDcpOgo+ICAgIHZpcnRpby1yaW5nOiBtYWludGFpbiBuZXh0IGluIGV4dHJhIHN0YXRl
IGZvciBwYWNrZWQgdmlydHF1ZXVlCj4gICAgdmlydGlvX3Jpbmc6IHJlbmFtZSB2cmluZ19kZXNj
X2V4dHJhX3BhY2tlZAo+ICAgIHZpcnRpby1yaW5nOiBmYWN0b3Igb3V0IGRlc2NfZXh0cmEgYWxs
b2NhdGlvbgo+ICAgIHZpcnRpb19yaW5nOiBzZWN1cmUgaGFuZGxpbmcgb2YgbWFwcGluZyBlcnJv
cnMKPiAgICB2aXJ0aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9kZXNjX2FkZF9zcGxpdCgp
Cj4gICAgdmlydGlvOiB1c2UgZXJyIGxhYmVsIGluIF9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSgpCj4g
ICAgdmlydGlvLXJpbmc6IHN0b3JlIERNQSBtZXRhZGF0YSBpbiBkZXNjX2V4dHJhIGZvciBzcGxp
dCB2aXJ0cXVldWUKPgo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDIwMSArKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE0NCBp
bnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
