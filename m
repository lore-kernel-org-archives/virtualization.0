Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB7C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:10:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4628E20757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM5aHxVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4628E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC66F87317;
	Mon, 30 Nov 2020 03:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N7kayGCEDS1W; Mon, 30 Nov 2020 03:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A6338731B;
	Mon, 30 Nov 2020 03:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D1FCC0859;
	Mon, 30 Nov 2020 03:10:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE2FC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0BD4487312
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YYgbBa-cKdC6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:10:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2BA2887317
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KewpQpJ2xxc8QiHxV7xo3WlelLLRPqTYNLbo5LfcAc=;
 b=iM5aHxVAZeKpqyselW42JE6zd622d9SgK7tWc9SJ9zp0mZPDcF31pdnMpgW7UPAY0nwCf9
 uTEBzSU4gO/V6PyBXLH2BiBo9j0hRXhGfMFmO2InGLMPb81bCSNwR4C7tYUH2nSU2JuAoK
 oCKYDrNWeb+HgjBThcalpetE+FhggkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-C6Wd65HPOQ-cARkVP5vysw-1; Sun, 29 Nov 2020 22:10:51 -0500
X-MC-Unique: C6Wd65HPOQ-cARkVP5vysw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BFD957202;
 Mon, 30 Nov 2020 03:10:50 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D2E727C26;
 Mon, 30 Nov 2020 03:10:39 +0000 (UTC)
Subject: Re: [PATCH v2 07/17] vdpa_sim: add device id field in vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-8-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fb8b4be-4287-6bff-e430-3c9e8aae0daa@redhat.com>
Date: Mon, 30 Nov 2020 11:10:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-8-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBS
ZW1vdmUgVkRQQVNJTV9ERVZJQ0VfSUQgbWFjcm8gYW5kIGFkZCAnaWQnIGZpZWxkIGluIHZkcGFz
aW1fZGV2X2F0dHIsCj4gdGhhdCB3aWxsIGJlIHJldHVybmVkIGJ5IHZkcGFzaW1fZ2V0X2Rldmlj
ZV9pZCgpLgo+Cj4gVXNlIFZJUlRJT19JRF9ORVQgZm9yIHZEUEEtbmV0IHNpbXVsYXRvciBkZXZp
Y2UgaWQuCj4KPiBDby1kZXZlbG9wZWQtYnk6IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRp
YS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyB8IDcgKysrKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCgpB
Y2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPiBpbmRleCBmOTgyNjJhZGQwZTEuLjM5M2I1NGE5ZjBlNCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+ICsrKyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAgLTQ0LDcgKzQ0LDYgQEAgc3RydWN0IHZkcGFz
aW1fdmlydHF1ZXVlIHsKPiAgIAo+ICAgI2RlZmluZSBWRFBBU0lNX1FVRVVFX0FMSUdOIFBBR0Vf
U0laRQo+ICAgI2RlZmluZSBWRFBBU0lNX1FVRVVFX01BWCAyNTYKPiAtI2RlZmluZSBWRFBBU0lN
X0RFVklDRV9JRCAweDEKPiAgICNkZWZpbmUgVkRQQVNJTV9WRU5ET1JfSUQgMAo+ICAgI2RlZmlu
ZSBWRFBBU0lNX0lPVExCX0xJTUlUIDAgLyogdW5saW1pdGVkICovCj4gICAjZGVmaW5lIFZEUEFT
SU1fVlFfTlVNIDB4Mgo+IEBAIC01Nyw2ICs1Niw3IEBAIHN0YXRpYyB1NjQgdmRwYXNpbV9mZWF0
dXJlcyA9ICgxVUxMIDw8IFZJUlRJT19GX0FOWV9MQVlPVVQpIHwKPiAgIAo+ICAgc3RydWN0IHZk
cGFzaW1fZGV2X2F0dHIgewo+ICAgCWludCBudnFzOwo+ICsJdTMyIGlkOwo+ICAgfTsKPiAgIAo+
ICAgLyogU3RhdGUgb2YgZWFjaCB2ZHBhc2ltIGRldmljZSAqLwo+IEBAIC01MzYsNyArNTM2LDkg
QEAgc3RhdGljIHUxNiB2ZHBhc2ltX2dldF92cV9udW1fbWF4KHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSkKPiAgIAo+ICAgc3RhdGljIHUzMiB2ZHBhc2ltX2dldF9kZXZpY2VfaWQoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhKQo+ICAgewo+IC0JcmV0dXJuIFZEUEFTSU1fREVWSUNFX0lEOwo+ICsJ
c3RydWN0IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPiArCj4gKwlyZXR1
cm4gdmRwYXNpbS0+ZGV2X2F0dHIuaWQ7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB1MzIgdmRwYXNp
bV9nZXRfdmVuZG9yX2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiBAQCAtNzE5LDYgKzcy
MSw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHZkcGFzaW1fZGV2X2luaXQodm9pZCkKPiAgIHsKPiAg
IAlzdHJ1Y3QgdmRwYXNpbV9kZXZfYXR0ciBkZXZfYXR0ciA9IHt9Owo+ICAgCj4gKwlkZXZfYXR0
ci5pZCA9IFZJUlRJT19JRF9ORVQ7Cj4gICAJZGV2X2F0dHIubnZxcyA9IFZEUEFTSU1fVlFfTlVN
Owo+ICAgCj4gICAJdmRwYXNpbV9kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
