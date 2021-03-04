Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6802CC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6A264F18
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 08:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6A264F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEC794AAEE;
	Thu,  4 Mar 2021 08:35:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtMHo2J7Tu5G; Thu,  4 Mar 2021 08:35:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A7624EBF1;
	Thu,  4 Mar 2021 08:35:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D13B5C000A;
	Thu,  4 Mar 2021 08:35:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07E4AC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D78556F9B9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ndo6Jh4QwL6a
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9CB206F971
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614846904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bXhR7YJ9IaSyeZ7VfID8y95/AMg+XDUasgSyE009NI=;
 b=YfP6WUN7ImCBSGznzRgDAe9KpDYmTsmTckBhCMJjOEN/PO4GNE8VtRQeLuG90yY61pWDVi
 7udEWoHZ0OVKZXs3380pQ3m8/FvQeOPtHA4BimhKHMs7/6KFcCQZOpZLp27clbpj1LC9vX
 ceBgEr2SBFpmFlCYI5Dxkdjowb4LPSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-TEysT5XLPrWNfNrk6byMxQ-1; Thu, 04 Mar 2021 03:35:03 -0500
X-MC-Unique: TEysT5XLPrWNfNrk6byMxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E97ED5A090;
 Thu,  4 Mar 2021 08:35:01 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-64.pek2.redhat.com
 [10.72.12.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1580E5FCC8;
 Thu,  4 Mar 2021 08:34:53 +0000 (UTC)
Subject: Re: [RFC PATCH 01/10] vdpa: add get_config_size callback in
 vdpa_config_ops
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-2-sgarzare@redhat.com>
 <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
 <20210302141516.oxsdb7jogrvu75yc@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a3f39ab-1cee-d0c3-e4d1-dc3ec492a763@redhat.com>
Date: Thu, 4 Mar 2021 16:34:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302141516.oxsdb7jogrvu75yc@steredhat>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMy8yIDEwOjE1IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IFR1ZSwgTWFyIDAyLCAyMDIxIGF0IDEyOjE0OjEzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gVGhpcyBuZXcgY2FsbGJhY2sgaXMgdXNlZCB0byBnZXQgdGhlIHNpemUgb2YgdGhlIGNv
bmZpZ3VyYXRpb24gc3BhY2UKPj4+IG9mIHZEUEEgZGV2aWNlcy4KPj4+Cj4+PiBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+
IMKgaW5jbHVkZS9saW51eC92ZHBhLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDQgKysr
Kwo+Pj4gwqBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jwqDCoCB8IDYgKysrKysrCj4+
PiDCoGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDYgKysrKysrCj4+PiDCoGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jwqAgfCA5ICsrKysrKysrKwo+Pj4gwqA0IGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4gaW5kZXggNGFiNTQ5NDUw
M2E4Li5mZGRmNDJiMTc1NzMgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
Pj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+IEBAIC0xNTAsNiArMTUwLDkgQEAgc3Ry
dWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4+PiDCoCAqIEBzZXRfc3RhdHVzOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgU2V0IHRoZSBkZXZpY2Ugc3RhdHVzCj4+PiDCoCAqwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEB2ZGV2OiB2ZHBhIGRldmljZQo+Pj4gwqAgKsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBAc3RhdHVzOiB2aXJ0aW8gZGV2aWNlIHN0YXR1cwo+Pj4gKyAqIEBnZXRf
Y29uZmlnX3NpemU6wqDCoMKgwqDCoMKgwqAgR2V0IHRoZSBzaXplIG9mIHRoZSBjb25maWd1cmF0
aW9uIHNwYWNlCj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQHZkZXY6IHZk
cGEgZGV2aWNlCj4+PiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmV0dXJucyBz
aXplX3Q6IGNvbmZpZ3VyYXRpb24gc2l6ZQo+Pgo+Pgo+PiBSZXRoaW5rIGFib3V0IHRoaXMsIGhv
dyBtdWNoIHdlIGNvdWxkIGdhaW4gYnkgaW50cm9kdWNpbmcgYSBkZWRpY2F0ZWQgCj4+IG9wcyBo
ZXJlPyBFLmcgd291bGQgaXQgYmUgc2ltcGxlciBpZiB3ZSBzaW1wbHkgaW50cm9kdWNlIGEgCj4+
IG1heF9jb25maWdfc2l6ZSB0byB2ZHBhIGRldmljZT8KPgo+IE1haW5seSBiZWNhdXNlIGluIHRo
aXMgd2F5IHdlIGRvbid0IGhhdmUgdG8gYWRkIG5ldyBwYXJhbWV0ZXJzIHRvIHRoZSAKPiB2ZHBh
X2FsbG9jX2RldmljZSgpIGZ1bmN0aW9uLgo+Cj4gV2UgZG8gdGhlIHNhbWUgZm9yIGV4YW1wbGUg
Zm9yICdnZXRfZGV2aWNlX2lkJywgJ2dldF92ZW5kb3JfaWQnLCAKPiAnZ2V0X3ZxX251bV9tYXgn
LiBBbGwgb2YgdGhlc2UgYXJlIHVzdWFsbHkgc3RhdGljLCBidXQgd2UgaGF2ZSBvcHMuCj4gSSB0
aGluayBiZWNhdXNlIGl0J3MgZWFzaWVyIHRvIGV4dGVuZC4KPgo+IEkgZG9uJ3Qga25vdyBpZiBp
dCdzIHdvcnRoIGFkZGluZyBhIG5ldyBzdHJ1Y3R1cmUgZm9yIHRoZXNlIHN0YXRpYyAKPiB2YWx1
ZXMgYXQgdGhpcyBwb2ludCwgbGlrZSAnc3RydWN0IHZkcGFfY29uZmlnX3BhcmFtcycuCgoKWWVz
LCB0aGF0J3MgdGhlIHBvaW50LiBJIHRoaW5rIGZvciBhbnkgc3RhdGljIHZhbHVlcywgaXQgc2hv
dWxkIGJlIHNldCAKZHVyaW5nIGRldmljZSBhbGxvY2F0aW9uLgoKSSdtIGZpbmUgd2l0aCBib3Ro
LgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
