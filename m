Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB654C4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682B821775
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 11:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BehAv66n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682B821775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0399C875DD;
	Fri, 25 Sep 2020 11:42:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nM0rK8-NpZ7I; Fri, 25 Sep 2020 11:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 69CF7875DA;
	Fri, 25 Sep 2020 11:42:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48AEBC0859;
	Fri, 25 Sep 2020 11:42:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7DDEC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A70622E16B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X-TTGjCLU4iz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:41:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id D7B9B2E169
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:41:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601034117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4y1m9JMkkDOJsL4k1JE6OPASJ9H32SGI/WQkPFQ5hvU=;
 b=BehAv66nOqG6+fVz9X/JJ18JBB8nqRlvBbI1jkIqwwuAo6o5JUespK6ltjCjkPoDHY1Ofh
 R4ujNICOJ5TgB3rt0ECTv6P2UJa7uzixSTYIyfRA+pDWfUqjwewI1PxxExwsH3p+DmpZ0t
 NVXeMwkqHDSzPB28yrn1nx0PeYyFvdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-oSmASuxLNzWLqtK_WBmrYA-1; Fri, 25 Sep 2020 07:41:55 -0400
X-MC-Unique: oSmASuxLNzWLqtK_WBmrYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6C8B1007382;
 Fri, 25 Sep 2020 11:41:53 +0000 (UTC)
Received: from [10.72.12.44] (ovpn-12-44.pek2.redhat.com [10.72.12.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5FB527BB7;
 Fri, 25 Sep 2020 11:41:38 +0000 (UTC)
Subject: Re: [RFC PATCH 02/24] vhost-vdpa: fix vqs leak in vhost_vdpa_open()
To: Eli Cohen <elic@nvidia.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-3-jasowang@redhat.com>
 <20200924074816.GC170403@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7237334f-10df-6d5b-dce9-c16b38166ae0@redhat.com>
Date: Fri, 25 Sep 2020 19:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924074816.GC170403@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, mhabets@solarflare.com, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvOS8yNCDkuIvljYgzOjQ4LCBFbGkgQ29oZW4gd3JvdGU6Cj4gT24gVGh1LCBTZXAg
MjQsIDIwMjAgYXQgMTE6MjE6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4gV2UgbmVl
ZCB0byBmcmVlIHZxcyBkdXJpbmcgdGhlIGVyciBwYXRoIGFmdGVyIGl0IGhhcyBiZWVuIGFsbG9j
YXRlZAo+PiBzaW5jZSB2aG9zdCB3b24ndCBkbyB0aGF0IGZvciB1cy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVy
cy92aG9zdC92ZHBhLmMgfCAxMSArKysrKysrKy0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+IGluZGV4IDc5NmZlOTc5Zjk5Ny4u
OWM2NDEyNzRiOWYzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiArKysg
Yi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBAQCAtNzY0LDYgKzc2NCwxMiBAQCBzdGF0aWMgdm9p
ZCB2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+PiAgIAl2LT5k
b21haW4gPSBOVUxMOwo+PiAgIH0KPj4gICAKPj4gK3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfY2xl
YW51cChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gK3sKPj4gKwl2aG9zdF9kZXZfY2xlYW51cCgm
di0+dmRldik7Cj4+ICsJa2ZyZWUodi0+dmRldi52cXMpOwo+PiArfQo+PiArCj4gV291bGRuJ3Qg
aXQgYmUgY2xlYW5lciB0byBjYWxsIGtmcmVlKHZxcykgZXhwbGljaWx0eSBpbnNpZGUKPiB2aG9z
dF92ZHBhX29wZW4oKSBpbiBjYXNlIG9mIGZhaWx1cmUgYW5kIGtlZXAgdGhlIHN5bWV0cnkgb2YK
PiB2aG9zdF9kZXZfaW5pdCgpL3Zob3N0X2Rldl9jbGVhbnVwKCk/CgoKVGhhdCdzIGFsc28gZmlu
ZS4KClNlZSAKaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS92aXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tc2c0MjU1OC5odG1sCgpJIHdpbGwgdXNlIHRoYXQgZm9y
IHRoZSBuZXh0IHZlcnNpb24uCgpUaGFua3MuCgoKPgo+PiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRw
YV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4gICB7Cj4+
ICAgCXN0cnVjdCB2aG9zdF92ZHBhICp2Owo+PiBAQCAtODA5LDcgKzgxNSw3IEBAIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxl
cCkKPj4gICAJcmV0dXJuIDA7Cj4+ICAgCj4+ICAgZXJyX2luaXRfaW90bGI6Cj4+IC0Jdmhvc3Rf
ZGV2X2NsZWFudXAoJnYtPnZkZXYpOwo+PiArCXZob3N0X3ZkcGFfY2xlYW51cCh2KTsKPj4gICBl
cnI6Cj4+ICAgCWF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4+ICAgCXJldHVybiByOwo+PiBAQCAt
ODQwLDggKzg0Niw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlcCkKPj4gICAJdmhvc3RfdmRwYV9mcmVlX2RvbWFp
bih2KTsKPj4gICAJdmhvc3RfdmRwYV9jb25maWdfcHV0KHYpOwo+PiAgIAl2aG9zdF92ZHBhX2Ns
ZWFuX2lycSh2KTsKPj4gLQl2aG9zdF9kZXZfY2xlYW51cCgmdi0+dmRldik7Cj4+IC0Ja2ZyZWUo
di0+dmRldi52cXMpOwo+PiArCXZob3N0X3ZkcGFfY2xlYW51cCh2KTsKPj4gICAJbXV0ZXhfdW5s
b2NrKCZkLT5tdXRleCk7Cj4+ICAgCj4+ICAgCWF0b21pY19kZWMoJnYtPm9wZW5lZCk7Cj4+IC0t
IAo+PiAyLjIwLjEKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
