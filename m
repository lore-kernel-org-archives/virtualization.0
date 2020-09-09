Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A258C433E2
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 08:42:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAFAF207DE
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 08:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhfnWYxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFAF207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62FD287308;
	Wed,  9 Sep 2020 08:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJzkFPqtzOif; Wed,  9 Sep 2020 08:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA77E871F3;
	Wed,  9 Sep 2020 08:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8811DC0052;
	Wed,  9 Sep 2020 08:42:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 600EBC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 52F71872E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lekcjKwlQ7rW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEEA6871F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DtMgeTKjCn17clYv2JEnI3ffDcOPCVRLd/V3CjCE3+4=;
 b=HhfnWYxhpdT5yvSbuWlWoGg+iM3zrdzumz8Ij4gJIhXiweCs5ceaWjFFHJIt6gSpZHsmWM
 0Gg3Al+czx3nG+0BDCsx6Yc6R7IWeizV5MbI6fcf9MprtPSetDdAafr17rCARoQO9Lo0ZF
 cskJE+phvKFhPStLm2Kf4uc3qa5HK6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-_Ya4rfJ9P0yaQlRETl-ZPw-1; Wed, 09 Sep 2020 04:42:06 -0400
X-MC-Unique: _Ya4rfJ9P0yaQlRETl-ZPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D592981F02E;
 Wed,  9 Sep 2020 08:42:03 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6F760C15;
 Wed,  9 Sep 2020 08:41:46 +0000 (UTC)
Subject: Re: [RFC PATCH 00/22] Enhance VHOST to enable SoC-to-SoC communication
To: Cornelia Huck <cohuck@redhat.com>
References: <20200702082143.25259-1-kishon@ti.com>
 <20200702055026-mutt-send-email-mst@kernel.org>
 <603970f5-3289-cd53-82a9-aa62b292c552@redhat.com>
 <14c6cad7-9361-7fa4-e1c6-715ccc7e5f6b@ti.com>
 <59fd6a0b-8566-44b7-3dae-bb52b468219b@redhat.com>
 <ce9eb6a5-cd3a-a390-5684-525827b30f64@ti.com>
 <da2b671c-b05d-a57f-7bdf-8b1043a41240@redhat.com>
 <fee8a0fb-f862-03bd-5ede-8f105b6af529@ti.com>
 <b2178e1d-2f5c-e8a3-72fb-70f2f8d6aa45@redhat.com>
 <45a8a97c-2061-13ee-5da8-9877a4a3b8aa@ti.com>
 <c8739d7f-e12e-f6a2-7018-9eeaf6feb054@redhat.com>
 <20200828123409.4cd2a812.cohuck@redhat.com>
 <ac8f7e4f-9f46-919a-f5c2-89b07794f0ab@ti.com>
 <9cd58cd1-0041-3d98-baf7-6e5bc2e7e317@redhat.com>
 <20200908183701.60b93441.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d6e4be52-78d8-546c-20a4-23bdaea68ba5@redhat.com>
Date: Wed, 9 Sep 2020 16:41:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908183701.60b93441.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Allen Hubbe <allenbh@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Dave Jiang <dave.jiang@intel.com>, kvm@vger.kernel.org,
 linux-ntb@googlegroups.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>, netdev@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
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

Ck9uIDIwMjAvOS85IOS4iuWNiDEyOjM3LCBDb3JuZWxpYSBIdWNrIHdyb3RlOgo+PiBUaGVuIHlv
dSBuZWVkIHNvbWV0aGluZyB0aGF0IGlzIGZ1bmN0aW9uYWwgZXF1aXZhbGVudCB0byB2aXJ0aW8g
UENJCj4+IHdoaWNoIGlzIGFjdHVhbGx5IHRoZSBjb25jZXB0IG9mIHZEUEEgKGUuZyB2RFBBIHBy
b3ZpZGVzIGFsdGVybmF0aXZlcyBpZgo+PiB0aGUgcXVldWVfc2VsIGlzIGhhcmQgaW4gdGhlIEVQ
IGltcGxlbWVudGF0aW9uKS4KPiBJdCBzZWVtcyBJIHJlYWxseSBuZWVkIHRvIHJlYWQgdXAgb24g
dkRQQSBtb3JlLi4uIGRvIHlvdSBoYXZlIGEgcG9pbnRlcgo+IGZvciBkaXZpbmcgaW50byB0aGlz
IGFsdGVybmF0aXZlcyBhc3BlY3Q/CgoKU2VlIHZwZGFfY29uZmlnX29wcyBpbiBpbmNsdWRlL2xp
bnV4L3ZkcGEuaAoKRXNwZWNpYWxseSB0aGlzIHBhcnQ6CgogwqDCoMKgIGludCAoKnNldF92cV9h
ZGRyZXNzKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCiDCoMKgwqAgwqDCoMKgIMKgwqDCoCDC
oMKgwqDCoMKgIHUxNiBpZHgsIHU2NCBkZXNjX2FyZWEsIHU2NCBkcml2ZXJfYXJlYSwKIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoMKgwqAgdTY0IGRldmljZV9hcmVhKTsKClRoaXMgbWVhbnMg
Zm9yIHRoZSBkZXZpY2VzIChlLmcgZW5kcG9pbnQgZGV2aWNlKSB0aGF0IGlzIGhhcmQgdG8gCmlt
cGxlbWVudCB2aXJ0aW8tcGNpIGxheW91dCwgaXQgY2FuIHVzZSBhbnkgb3RoZXIgcmVnaXN0ZXIg
bGF5b3V0IG9yIAp2ZW5kb3Igc3BlY2lmaWMgd2F5IHRvIGNvbmZpZ3VyZSB0aGUgdmlydHF1ZXVl
LgoKCj4KPj4+ICJWaXJ0aW8gT3ZlciBOVEIiIHNob3VsZCBhbnl3YXlzIGJlIGEgbmV3IHRyYW5z
cG9ydC4KPj4+PiBEb2VzIHRoYXQgbWFrZSBhbnkgc2Vuc2U/Cj4+PiB5ZWFoLCBpbiB0aGUgYXBw
cm9hY2ggSSB1c2VkIHRoZSBpbml0aWFsIGZlYXR1cmVzIGFyZSBoYXJkLWNvZGVkIGluCj4+PiB2
aG9zdC1ycG1zZyAoaW5oZXJlbnQgdG8gdGhlIHJwbXNnKSBidXQgd2hlbiB3ZSBoYXZlIHRvIHVz
ZSBhZGFwdGVyCj4+PiBsYXllciAodmhvc3Qgb25seSBmb3IgYWNjZXNzaW5nIHZpcnRpbyByaW5n
IGFuZCB1c2UgdmlydGlvIGRyaXZlcnMgb24KPj4+IGJvdGggZnJvbnQgZW5kIGFuZCBiYWNrZW5k
KSwgYmFzZWQgb24gdGhlIGZ1bmN0aW9uYWxpdHkgKGUuZywgcnBtc2cpLAo+Pj4gdGhlIHZob3N0
IHNob3VsZCBiZSBjb25maWd1cmVkIHdpdGggZmVhdHVyZXMgKHRvIGJlIHByZXNlbnRlZCB0byB0
aGUKPj4+IHZpcnRpbykgYW5kIHRoYXQncyB3aHkgYWRkaXRpb25hbCBsYXllciBvciBBUElzIHdp
bGwgYmUgcmVxdWlyZWQuCj4+IEEgcXVlc3Rpb24gaGVyZSwgaWYgd2UgZ28gd2l0aCB2aG9zdCBi
dXMgYXBwcm9hY2gsIGRvZXMgaXQgbWVhbiB0aGUKPj4gdmlydGlvIGRldmljZSBjYW4gb25seSBi
ZSBpbXBsZW1lbnRlZCBpbiBFUCdzIHVzZXJzcGFjZT8KPiBDYW4gd2UgbWF5YmUgaW1wbGVtZW50
IGFuIGFsdGVybmF0aXZlIGJ1cyBhcyB3ZWxsIHRoYXQgd291bGQgYWxsb3cgdXMKPiB0byBzdXBw
b3J0IGRpZmZlcmVudCB2aXJ0aW8gZGV2aWNlIGltcGxlbWVudGF0aW9ucyAoaW4gYWRkaXRpb24g
dG8gdGhlCj4gdmhvc3QgYnVzICsgdXNlcnNwYWNlIGNvbWJpbmF0aW9uKT8KCgpUaGF0IHNob3Vs
ZCBiZSBmaW5lLCBidXQgSSdtIG5vdCBxdWl0ZSBzdXJlIHRoYXQgaW1wbGVtZW50aW5nIHRoZSBk
ZXZpY2UgCmluIGtlcm5lIChrdGhyZWFkKSBpcyB0aGUgZ29vZCBhcHByb2FjaC4KClRoYW5rcwoK
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
