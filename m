Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07602C433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:13:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A291C22583
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A291C22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C37A2094E;
	Tue,  5 Jan 2021 04:13:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRDL6MFiyUrK; Tue,  5 Jan 2021 04:13:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 07EA820798;
	Tue,  5 Jan 2021 04:13:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC04DC0891;
	Tue,  5 Jan 2021 04:13:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51F07C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33884207A2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:13:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VngR619YDTWf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:13:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id CAEC120798
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609820024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNwfaLROqYRPmfvgvxa6nI7hiNfX/WzqZuvzfVKuUUY=;
 b=PEZIPPH8AxLuMdhckNesi0JgK1gDsbtZF3llUYwLK86ZkIL+4y/6BJw7wOw15BQbaJFf6i
 LEYCh/3K5m5e+oRSzfGIHI4XwXVutQBzKn7ayeyZfc+xSXyJLxFHQDQRLjUKpsY6OK95+1
 bR/Qe/xObuM+nR/CGdBDtrpw5kyzTO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-quVrtjhsOZmNy5g7PEYh9g-1; Mon, 04 Jan 2021 23:13:42 -0500
X-MC-Unique: quVrtjhsOZmNy5g7PEYh9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 380C9107ACE3;
 Tue,  5 Jan 2021 04:13:41 +0000 (UTC)
Received: from [10.72.13.192] (ovpn-13-192.pek2.redhat.com [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E55165D9C6;
 Tue,  5 Jan 2021 04:13:28 +0000 (UTC)
Subject: Re: [PATCH 06/21] vdpa: introduce virtqueue groups
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-7-jasowang@redhat.com>
 <20210104100458.GC342399@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bf7e6f2e-eeb8-38b3-94f0-8b4a3ce9ff9f@redhat.com>
Date: Tue, 5 Jan 2021 12:13:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104100458.GC342399@stefanha-x1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjEvMS80IOS4i+WNiDY6MDQsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToKPiBPbiBXZWQs
IERlYyAxNiwgMjAyMCBhdCAwMjo0ODowM1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBU
aGlzIHBhdGNoIGludHJvZHVjZXMgdmlydHF1ZXVlIGdyb3VwcyB0byB2RFBBIGRldmljZS4gVGhl
IHZpcnRxdWV1ZQo+PiBncm91cCBpcyB0aGUgbWluaW1hbCBzZXQgb2YgdmlydHF1ZXVlcyB0aGF0
IG11c3Qgc2hhcmUgYW4gYWRkcmVzcwo+PiBzcGFjZS4gQW5kIHRoZSBhZGRkcmVzcyBzcGFjZSBp
ZGVudGlmaWVyIGNvdWxkIG9ubHkgYmUgYXR0YWNoZWQgdG8KPj4gYSBzcGVjaWZpYyB2aXJ0cXVl
dWUgZ3JvdXAuCj4+Cj4+IEEgbmV3IG1hbmRhdGVkIGJ1cyBvcGVyYXRpb24gaXMgaW50cm9kdWNl
ZCB0byBnZXQgdGhlIHZpcnRxdWV1ZSBncm91cAo+PiBJRCBmb3IgYSBzcGVjaWZpYyB2aXJ0cXVl
dWUuCj4+Cj4+IEFsbCB0aGUgdkRQQSBkZXZpY2UgZHJpdmVycyB3ZXJlIGNvbnZlcnRlZCB0byBz
aW1wbHkgc3VwcG9ydCBhIHNpbmdsZQo+PiB2aXJ0cXVldWUgZ3JvdXAuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgICB8ICA5ICsrKysrKysrLQo+PiAgIGRyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICA4ICsrKysrKystCj4+ICAgZHJpdmVycy92ZHBh
L3ZkcGEuYyAgICAgICAgICAgICAgIHwgIDQgKysrLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jICB8IDExICsrKysrKysrKystCj4+ICAgaW5jbHVkZS9saW51eC92ZHBhLmgg
ICAgICAgICAgICAgIHwgMTIgKysrKysrKysrLS0tCj4+ICAgNSBmaWxlcyBjaGFuZ2VkLCAzNyBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+IE1heWJlIGNvbnNpZGVyIGNhbGxpbmcgaXQg
aW90bGJfZ3JvdXAgb3IgaW9tbXVfZ3JvdXAgc28gdGhlIHB1cnBvc2Ugb2YKPiB0aGUgZ3JvdXAg
aXMgY2xlYXI/CgoKSSdtIG5vdCBzdXJlLiBUaGUgcmVhc29uIHRoYXQgSSBjaG9vc2UgdmlydHF1
ZXVlIGdyb3VwIGlzIGJlY2F1c2U6CgoxKSBWaXJ0cXVldWUgaXMgdGhlIG9ubHkgZW50aXR5IHRo
YXQgdHJpZXMgdG8gaXNzdWVzIERNQQoyKSBGb3IgSU9NTVUgZ3JvdXAsIGl0IG1heSBjYXVzZSBj
b25mdXNpb24gdG8gdGhlIGV4aXN0aW5nIElPTU1VIGdyb3VwIAp3aG8gZ3JvdXAgZGV2aWNlcwoz
KSBJT1RMQiBpcyB0aGUgY29uY2VwdCBpbiB2aG9zdCwgd2UgZG9uJ3QgaGF2ZSBzdWNoIGRlZmlu
aXRpb24gaW4gdGhlIAp2aXJ0aW8gc3BlYwoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
