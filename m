Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB303C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:27:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB3420717
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/WhS1SE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB3420717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CCDFB86DDA;
	Fri, 25 Sep 2020 11:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MwWRRhWYCmrs; Fri, 25 Sep 2020 11:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F012C86DD7;
	Fri, 25 Sep 2020 11:27:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF8C6C0859;
	Fri, 25 Sep 2020 11:27:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE6B0C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DE03986DD9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WtREzvZoA6QW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:27:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 77CAF86DD7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:27:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601033256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIYjG/eOf0A02Qd+6Up4W+Jt7X/3F3zVaDbUU4OQaQY=;
 b=O/WhS1SEB7dd6XjJKRiEeNJujnCiLweBn9Hf4gPr6c/wmKeSuj3oHRXFS5X/FK7laMtRgu
 d4QYepDj5gyLXR/PpOheMcNJdkx6Q1j7vLByKHWixOXvO0/ltMmUHhsUQoz/77PfcGCCRI
 pJtV5Pgze3E2S70giWRApa8QNM2mEyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-z4Vu6R3RNealyVJDGYbeXg-1; Fri, 25 Sep 2020 07:27:33 -0400
X-MC-Unique: z4Vu6R3RNealyVJDGYbeXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD02A88EF0E;
 Fri, 25 Sep 2020 11:27:31 +0000 (UTC)
Received: from [10.72.12.44] (ovpn-12-44.pek2.redhat.com [10.72.12.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 930765D9F7;
 Fri, 25 Sep 2020 11:27:15 +0000 (UTC)
Subject: Re: [RFC PATCH 02/24] vhost-vdpa: fix vqs leak in vhost_vdpa_open()
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-3-jasowang@redhat.com>
 <20200924053119-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2f3c4a3-604f-ad27-d34d-a829446a3c7e@redhat.com>
Date: Fri, 25 Sep 2020 19:27:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924053119-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: lulu@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, stefanha@redhat.com, eli@mellanox.com,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOS8yNCDkuIvljYg1OjMxLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBTZXAgMjQsIDIwMjAgYXQgMTE6MjE6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gV2UgbmVlZCB0byBmcmVlIHZxcyBkdXJpbmcgdGhlIGVyciBwYXRoIGFmdGVyIGl0IGhhcyBi
ZWVuIGFsbG9jYXRlZAo+PiBzaW5jZSB2aG9zdCB3b24ndCBkbyB0aGF0IGZvciB1cy4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBUaGlzIGlz
IGEgYnVnZml4IHRvbyByaWdodD8gSSBkb24ndCBzZWUgaXQgcG9zdGVkIHNlcGFyYXRlbHkgLi4u
CgoKQSBwYXRjaCB0aGF0IGlzIGZ1bmN0aW9uYWwgZXF1aXZhbGVudCBpcyBwb3N0ZWQgaGVyZToK
Cmh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcvbXNnNDI1NTguaHRtbAoKSSdtIGEgbGl0dGxlIGJpdCBsYXp5IHRvIHVz
ZSB0aGF0IG9uZSBzaW5jZSB0aGlzIHBhdGNoIGlzIHByb2JhYmx5IHdyb3RlIApiZWZvcmUgdGhh
dCBvbmUuCgpUaGFua3MKCgo+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTEg
KysrKysrKystLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+PiBpbmRleCA3OTZmZTk3OWY5OTcuLjljNjQxMjc0YjlmMyAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBh
LmMKPj4gQEAgLTc2NCw2ICs3NjQsMTIgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9mcmVlX2Rv
bWFpbihzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gICAJdi0+ZG9tYWluID0gTlVMTDsKPj4gICB9
Cj4+ICAgCj4+ICtzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2NsZWFudXAoc3RydWN0IHZob3N0X3Zk
cGEgKnYpCj4+ICt7Cj4+ICsJdmhvc3RfZGV2X2NsZWFudXAoJnYtPnZkZXYpOwo+PiArCWtmcmVl
KHYtPnZkZXYudnFzKTsKPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9vcGVu
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4gICB7Cj4+ICAgCXN0
cnVjdCB2aG9zdF92ZHBhICp2Owo+PiBAQCAtODA5LDcgKzgxNSw3IEBAIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4g
ICAJcmV0dXJuIDA7Cj4+ICAgCj4+ICAgZXJyX2luaXRfaW90bGI6Cj4+IC0Jdmhvc3RfZGV2X2Ns
ZWFudXAoJnYtPnZkZXYpOwo+PiArCXZob3N0X3ZkcGFfY2xlYW51cCh2KTsKPj4gICBlcnI6Cj4+
ICAgCWF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4+ICAgCXJldHVybiByOwo+PiBAQCAtODQwLDgg
Kzg0Niw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4gICAJdmhvc3RfdmRwYV9mcmVlX2RvbWFpbih2KTsK
Pj4gICAJdmhvc3RfdmRwYV9jb25maWdfcHV0KHYpOwo+PiAgIAl2aG9zdF92ZHBhX2NsZWFuX2ly
cSh2KTsKPj4gLQl2aG9zdF9kZXZfY2xlYW51cCgmdi0+dmRldik7Cj4+IC0Ja2ZyZWUodi0+dmRl
di52cXMpOwo+PiArCXZob3N0X3ZkcGFfY2xlYW51cCh2KTsKPj4gICAJbXV0ZXhfdW5sb2NrKCZk
LT5tdXRleCk7Cj4+ICAgCj4+ICAgCWF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4+IC0tIAo+PiAy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
