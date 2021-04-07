Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD76DC433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B266139B
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B266139B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1CBB6062C;
	Wed,  7 Apr 2021 07:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAEVJDbN9YTL; Wed,  7 Apr 2021 07:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7755F605A6;
	Wed,  7 Apr 2021 07:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 524F0C000C;
	Wed,  7 Apr 2021 07:26:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C76C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E18C26062C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:26:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rPyvc20rsAj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:26:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F86E605A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617780369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v61SxEsycAxN77QJptebEM1QhAs/IPdPglfWEfxaV9s=;
 b=ctn8KyyKw5UTi9PsQqdihD5iDDYYCwTHpgAtTCp0QKjnQXf9JCyw/dxeUbu4YxnGklEQQn
 56OvdfiARWhl66kUs3b/F1ModujVT/9RauhfC3HoYQ6TmXmRiM/O3XZv42a0yyXrQuuBqe
 awZHeIZ2nl/nEqO1xnIg6S8sGS9RMYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Aj7YNIIyOtSLnHHhswdvHA-1; Wed, 07 Apr 2021 03:26:07 -0400
X-MC-Unique: Aj7YNIIyOtSLnHHhswdvHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F2981744F;
 Wed,  7 Apr 2021 07:26:06 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F373A7092D;
 Wed,  7 Apr 2021 07:26:00 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 14/14] vdpa/mlx5: Fix wrong use of bit
 numbers
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-15-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7a58f3f8-5ed2-b584-d554-5d6a1e93c00d@redhat.com>
Date: Wed, 7 Apr 2021 15:25:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-15-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGcm9tOiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IFZJUlRJT19GX1ZFUlNJT05fMSBpcyBhIGJpdCBudW1i
ZXIuIFVzZSBCSVRfVUxMKCkgd2l0aCBtYXNrCj4gY29uZGl0aW9uYWxzLgo+Cj4gQWxzbywgaW4g
bWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oKSB1c2UgQklUX1VMTCBmb3IgY29uc2lzdGVuY3kg
d2l0aAo+IHRoZSByZXN0IG9mIHRoZSBjb2RlLgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZk
cGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiBT
aWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDkgKysrKysrKy0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+IGluZGV4IGE2ZTZkNDRiOWNhNS4uM2I3OWI1OTM5YzdjIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC04MjEsNyArODIxLDcgQEAgc3RhdGljIGludCBj
cmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdWUKPiAgIAlNTFg1X1NFVCh2aXJ0aW9fcSwgdnFfY3R4LCBldmVudF9xcG5fb3Jf
bXNpeCwgbXZxLT5md3FwLm1xcC5xcG4pOwo+ICAgCU1MWDVfU0VUKHZpcnRpb19xLCB2cV9jdHgs
IHF1ZXVlX3NpemUsIG12cS0+bnVtX2VudCk7Cj4gICAJTUxYNV9TRVQodmlydGlvX3EsIHZxX2N0
eCwgdmlydGlvX3ZlcnNpb25fMV8wLAo+IC0JCSAhIShuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVy
ZXMgJiBWSVJUSU9fRl9WRVJTSU9OXzEpKTsKPiArCQkgISEobmRldi0+bXZkZXYuYWN0dWFsX2Zl
YXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSk7Cj4gICAJTUxYNV9TRVQ2NCh2
aXJ0aW9fcSwgdnFfY3R4LCBkZXNjX2FkZHIsIG12cS0+ZGVzY19hZGRyKTsKPiAgIAlNTFg1X1NF
VDY0KHZpcnRpb19xLCB2cV9jdHgsIHVzZWRfYWRkciwgbXZxLT5kZXZpY2VfYWRkcik7Cj4gICAJ
TUxYNV9TRVQ2NCh2aXJ0aW9fcSwgdnFfY3R4LCBhdmFpbGFibGVfYWRkciwgbXZxLT5kcml2ZXJf
YWRkcik7Cj4gQEAgLTE1NzgsNyArMTU3OCw3IEBAIHN0YXRpYyB2b2lkIHRlYXJkb3duX3ZpcnRx
dWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICBzdGF0aWMgaW5saW5lIGJvb2wg
bWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+
ICAgewo+ICAgCXJldHVybiB2aXJ0aW9fbGVnYWN5X2lzX2xpdHRsZV9lbmRpYW4oKSB8fAo+IC0J
CShtdmRldi0+YWN0dWFsX2ZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKSk7
Cj4gKwkJKG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX1ZFUlNJT05f
MSkpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgX192aXJ0aW8xNiBjcHVfdG9fbWx4NXZkcGExNihz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHUxNiB2YWwpCj4gQEAgLTE5ODUsNiArMTk4NSw4
IEBAIHN0YXRpYyB2b2lkIHF1ZXJ5X3ZpcnRpb19mZWF0dXJlcyhzdHJ1Y3QgbWx4NV92ZHBhX25l
dCAqbmRldikKPiAgIAlwcmludF9mZWF0dXJlcyhtdmRldiwgbXZkZXYtPm1seF9mZWF0dXJlcywg
ZmFsc2UpOwo+ICAgfQo+ICAgCj4gKyNkZWZpbmUgTUlOX01UVSA2OAo+ICsKPiAgIHN0YXRpYyBp
bnQgcXVlcnlfbXR1KHN0cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2LCB1MTYgKm10dSkKPiAgIHsK
PiAgIAl1MTYgaHdfbXR1Owo+IEBAIC0xOTk1LDYgKzE5OTcsOSBAQCBzdGF0aWMgaW50IHF1ZXJ5
X210dShzdHJ1Y3QgbWx4NV9jb3JlX2RldiAqbWRldiwgdTE2ICptdHUpCj4gICAJCXJldHVybiBl
cnI7Cj4gICAKPiAgIAkqbXR1ID0gaHdfbXR1IC0gTUxYNVZfRVRIX0hBUkRfTVRVOwo+ICsJaWYg
KCptdHUgPCBNSU5fTVRVKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAgIAlyZXR1cm4gMDsK
PiAgIH0KCgpUaGlzIGxvb2tzIGlycmV2YWxhbnQgdG8gd2hhdCBpcyBkZXNjcmliZWQgYnkgdGhl
IGNvbW1pdCBsb2cuCgpUaGFua3MKCgo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
