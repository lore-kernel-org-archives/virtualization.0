Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB94C64E7C
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:07:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1B420757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHwm2Q18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B420757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A43B286481;
	Mon, 30 Nov 2020 03:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88sm9zJyBQ-s; Mon, 30 Nov 2020 03:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3532A8629C;
	Mon, 30 Nov 2020 03:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 091E8C1833;
	Mon, 30 Nov 2020 03:07:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A94DC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ECE5986451
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KHvtLaL2sFF6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4F11A8629C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFDCsOHChBGlkg+TMm2o2PNEDmkjytKBWO+agkAw40U=;
 b=DHwm2Q18tY+tHMwmI1FGyk18YK9LmYi+uIM8f+xNMHk6GacK/KpFj1VDp8egfoz83gWz/w
 54yhPTQkidth7LkkAX6W00jdwX2ZmaC4QwLcCnNXAEMGkYlYH4xFPLXMy0KaV51tkY+vXo
 6ql1AeiyP5RNs1xY0A9WkHU5wvDPlBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-T1TZrg1ZNgmpHuHKu6jruQ-1; Sun, 29 Nov 2020 22:07:20 -0500
X-MC-Unique: T1TZrg1ZNgmpHuHKu6jruQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FDC879514;
 Mon, 30 Nov 2020 03:07:18 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 410735C1BB;
 Mon, 30 Nov 2020 03:07:10 +0000 (UTC)
Subject: Re: [PATCH v2 04/17] vdpa_sim: remove the limit of IOTLB entries
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-5-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42989b66-9d53-cc2e-4d8e-5a93aad2efa1@redhat.com>
Date: Mon, 30 Nov 2020 11:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-5-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBU
aGUgc2ltdWxhdGVkIGRldmljZXMgY2FuIHN1cHBvcnQgbXVsdGlwbGUgcXVldWVzLCBzbyB0aGlz
IGxpbWl0Cj4gc2hvdWxkIGJlIGRlZmluZWQgYWNjb3JkaW5nIHRvIHRoZSBudW1iZXIgb2YgcXVl
dWVzIHN1cHBvcnRlZCBieQo+IHRoZSBkZXZpY2UuCj4KPiBTaW5jZSB3ZSBhcmUgaW4gYSBzaW11
bGF0b3IsIGxldCdzIHNpbXBseSByZW1vdmUgdGhhdCBsaW1pdC4KPgo+IFN1Z2dlc3RlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gLS0tCj4gdjI6Cj4gLSBhZGRlZCBWRFBBU0lNX0lPVExC
X0xJTUlUIG1hY3JvIFtKYXNvbl0KCgpTb3JyeSBmb3IgYmVpbmcgdW5jbGVhci4gSSBtZWFudCBh
ZGRpbmcgYSBtYWNybyBsaWtlCgpWSE9TVF9JT1RMQl9VTkxJTUlURUQgMCBpbiB2aG9zdF9pb3Rs
Yi5oLgoKQW5kIHVzZSB0aGF0IGluIHZkcGFfc2ltLgoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5j
Cj4gaW5kZXggYWQ3MmY3YjFhNGViLi40MDY2NGQ4N2YzMDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+IEBAIC00Niw2ICs0Niw3IEBAIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7
Cj4gICAjZGVmaW5lIFZEUEFTSU1fUVVFVUVfTUFYIDI1Ngo+ICAgI2RlZmluZSBWRFBBU0lNX0RF
VklDRV9JRCAweDEKPiAgICNkZWZpbmUgVkRQQVNJTV9WRU5ET1JfSUQgMAo+ICsjZGVmaW5lIFZE
UEFTSU1fSU9UTEJfTElNSVQgMCAvKiB1bmxpbWl0ZWQgKi8KPiAgICNkZWZpbmUgVkRQQVNJTV9W
UV9OVU0gMHgyCj4gICAjZGVmaW5lIFZEUEFTSU1fTkFNRSAidmRwYXNpbS1uZXRkZXYiCj4gICAK
PiBAQCAtMzY1LDcgKzM2Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbV9jcmVh
dGUodm9pZCkKPiAgIAlpZiAoIXZkcGFzaW0tPnZxcykKPiAgIAkJZ290byBlcnJfaW9tbXU7Cj4g
ICAKPiAtCXZkcGFzaW0tPmlvbW11ID0gdmhvc3RfaW90bGJfYWxsb2MoMjA0OCwgMCk7Cj4gKwl2
ZHBhc2ltLT5pb21tdSA9IHZob3N0X2lvdGxiX2FsbG9jKFZEUEFTSU1fSU9UTEJfTElNSVQsIDAp
Owo+ICAgCWlmICghdmRwYXNpbS0+aW9tbXUpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
