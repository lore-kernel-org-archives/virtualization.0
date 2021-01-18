Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D5C433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 05:32:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7745C2231F
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 05:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7745C2231F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2652B854E7;
	Mon, 18 Jan 2021 05:32:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSytq2F6g3fh; Mon, 18 Jan 2021 05:32:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9533E8574A;
	Mon, 18 Jan 2021 05:32:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B872C088B;
	Mon, 18 Jan 2021 05:32:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 697ABC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5D87B8574A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8q_8Th1EczaB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:32:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AEFBB854E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 05:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610947966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDPCAVJcJa7C+5eBbyflXnWUh5KwAB1+USyHP1tOpTI=;
 b=PXPlUT44BRUqnNrky6Ov1FHYQz6EwPyw2AKx3H0R8NH3loP/JCp3+U6PyuEDZS3O4A4KF+
 96boLR0ZuSDlYkvN751qRqQnlDmo35/s4UpmMmIdTjG1okmBcVCoDRsW/3CmzOCr7n29jt
 hWR3LuK9XRJ1GKIcazzfWyA5maS/7/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-9KjLBBToNRGaLv5l7aAqmQ-1; Mon, 18 Jan 2021 00:32:39 -0500
X-MC-Unique: 9KjLBBToNRGaLv5l7aAqmQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6CC7107ACF9;
 Mon, 18 Jan 2021 05:32:38 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D16B71CA0;
 Mon, 18 Jan 2021 05:32:32 +0000 (UTC)
Subject: Re: [PATCH V2] mlx5: vdpa: fix possible uninitialized var
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210114070904.9981-1-jasowang@redhat.com>
 <20210117052810-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9184ab89-2d64-7f5f-6e16-2f572cc192bc@redhat.com>
Date: Mon, 18 Jan 2021 13:32:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210117052810-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8xNyDkuIvljYg2OjMwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBKYW4gMTQsIDIwMjEgYXQgMDM6MDk6MDRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gV2hlbiBjb21waWxpbmcgd2l0aCAtV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQsIGdjYyBt
YXkgY29tcGxhaW5zIHRoZQo+PiBwb3NzaWJsZSB1bmluaXRpYWxpemVkIHVtZW0uIFNpbmNlIHRo
ZSBjYWxsZXJzIHdvbid0IHBhc3MgdmFsdWUgb3RoZXIKPj4gdGhhbiAxIHRvIDMsIG1ha2luZyAz
IGFzIGRlZmF1bHQgdG8gZml4IHRoZSBjb21waWxlciB3YXJuaW5nLgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IE9mIGNvdXJzZSBpZiBpdCdz
IGFjdHVhbGx5IHNvbWV0aGluZyBlbHNlIHRoaXMgaXMgbm90IERUUlQgLi4uCgoKSXQgYnJlYWtz
IHNvbWUgZG9udyBzdHJlYW0gYnVpbGQgKHdoaWNoIG1hbmRhdGVzIAotV2Vycm9yPW1heWJlLXVu
aW5pdGlhbGl6ZWQpCgoKPiBBcyBsb25nIGFzIHdlIHdvcnJ5IGFib3V0IHRoaXMgd2FybmluZywg
bGV0J3MgaGF2ZSBkZWZlbmNlIGluIGRlcHRoOgo+ICAgIAljYXNlIDM6Cj4gICAgCQl1bWVtID0g
Jm12cS0+dW1lbTM7Cj4gICAgCQlicmVhazsKPiAgICsJZGVmYXVsdDoKPiAgICsJCXVtZW0gPSBO
VUxMOwo+ICAgKyAgICAgICAgICAgICAgQlVHKCk7Cj4gICArCQlicmVhazsKCgpDaGVja3BhdGNo
IGRvZXNuJ3QgbGlrZSB0aGlzOgoKV0FSTklORzogQXZvaWQgY3Jhc2hpbmcgdGhlIGtlcm5lbCAt
IHRyeSB1c2luZyBXQVJOX09OICYgcmVjb3ZlcnkgY29kZSAKcmF0aGVyIHRoYW4gQlVHKCkgb3Ig
QlVHX09OKCkKIzIwOiBGSUxFOiBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmM6Njk1
OgorwqDCoMKgIMKgwqDCoCBCVUcoKTsKCkJ1dCBpZiB5b3Ugc3RpY2ssIEkgY2FuIGdvIHRoaXMg
d2F5LgoKVGhhbmtzCgoKPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXggZjFkNTQ4MTRk
Yjk3Li4wN2NjYzYxY2Q2ZjYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4g
QEAgLTcwMyw3ICs3MDMsNyBAQCBzdGF0aWMgdm9pZCB1bWVtX2Rlc3Ryb3koc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlCj4+ICAgCWNhc2UgMjoK
Pj4gICAJCXVtZW0gPSAmbXZxLT51bWVtMjsKPj4gICAJCWJyZWFrOwo+PiAtCWNhc2UgMzoKPj4g
KwlkZWZhdWx0Ogo+PiAgIAkJdW1lbSA9ICZtdnEtPnVtZW0zOwo+PiAgIAkJYnJlYWs7Cj4+ICAg
CX0KPj4gLS0gCj4+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
