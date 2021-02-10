Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB6C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 08:09:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57605601FF
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 08:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57605601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1693E86706;
	Wed, 10 Feb 2021 08:09:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zn7m8xACkK2T; Wed, 10 Feb 2021 08:09:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32D82860A3;
	Wed, 10 Feb 2021 08:09:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19B9AC0891;
	Wed, 10 Feb 2021 08:09:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B027C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0C24B8713B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:09:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CcFnIPhBw76o
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:09:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 22DB187136
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612944594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQF1nvM4WzcF6b0r2/8bKOmWIMtX32r3vBelIGsxbzc=;
 b=gSlnaaTkzLm3df25zsqcyFSTQf6OdBY8S+wfLXf0FZmgExY4+/cA5ZUOnN7KGNvjdHLhSx
 oDQPmmPC10ArGt6Tq2V5sebFW5xyinl1qTQHVHvbS6gcEjW6t752Cg+fRJZiF2jHXSXXo8
 Z8SzZoQW2ltNLJle2ERZJVJhfm2Asks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-fxTGGyKxMs6dGfNlV7pjSA-1; Wed, 10 Feb 2021 03:09:52 -0500
X-MC-Unique: fxTGGyKxMs6dGfNlV7pjSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B96B192CC44;
 Wed, 10 Feb 2021 08:09:51 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6512E5D9C0;
 Wed, 10 Feb 2021 08:09:45 +0000 (UTC)
Subject: Re: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
To: Tang Bin <tangbin@cmss.chinamobile.com>, mst@redhat.com
References: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
Date: Wed, 10 Feb 2021 16:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xMCDkuIrljYgxMTowNCwgVGFuZyBCaW4gd3JvdGU6Cj4gVGhlIGZpbGUgdmly
dGlvX21taW8uYyBoYXMgZGVmaW5lZCB0aGUgZnVuY3Rpb24gdG9fdmlydGlvX21taW9fZGV2aWNl
LAo+IHNvIHVzZSBpdCBpbnN0ZWFkIG9mIGNvbnRhaW5lcl9vZigpIHRvIHNpbXBseSBjb2RlLiBB
bmQgcmVtb3ZlCj4gc3VwZXJmbHVvdXMgYmxhbmsgbGluZXMgaW4gdGhpcyBmaWxlLgo+Cj4gU2ln
bmVkLW9mZi1ieTogVGFuZyBCaW4gPHRhbmdiaW5AY21zcy5jaGluYW1vYmlsZS5jb20+Cj4gLS0t
Cj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jIHwgMTYgKy0tLS0tLS0tLS0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxNSBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX21taW8uYwo+IGluZGV4IDYyN2FjMDQ4Ny4uNDQ5ZDBmMjA5IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fbW1pby5jCj4gQEAgLTY5LDE0ICs2OSwxMCBAQAo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgv
dmlydGlvX21taW8uaD4KPiAgICNpbmNsdWRlIDxsaW51eC92aXJ0aW9fcmluZy5oPgo+ICAgCj4g
LQo+IC0KCgpJdCdzIGJldHRlciBub3QgbWl4IHRoZSBwYXRjaCB3aXRoIHN0eWxlIGNoYW5nZXMu
CgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoKPiAgIC8qIFRoZSBhbGlnbm1lbnQgdG8gdXNl
IGJldHdlZW4gY29uc3VtZXIgYW5kIHByb2R1Y2VyIHBhcnRzIG9mIHZyaW5nLgo+ICAgICogQ3Vy
cmVudGx5IGhhcmRjb2RlZCB0byB0aGUgcGFnZSBzaXplLiAqLwo+ICAgI2RlZmluZSBWSVJUSU9f
TU1JT19WUklOR19BTElHTgkJUEFHRV9TSVpFCj4gICAKPiAtCj4gLQo+ICAgI2RlZmluZSB0b192
aXJ0aW9fbW1pb19kZXZpY2UoX3BsYXRfZGV2KSBcCj4gICAJY29udGFpbmVyX29mKF9wbGF0X2Rl
diwgc3RydWN0IHZpcnRpb19tbWlvX2RldmljZSwgdmRldikKPiAgIAo+IEBAIC0xMDAsOCArOTYs
NiBAQCBzdHJ1Y3QgdmlydGlvX21taW9fdnFfaW5mbyB7Cj4gICAJc3RydWN0IGxpc3RfaGVhZCBu
b2RlOwo+ICAgfTsKPiAgIAo+IC0KPiAtCj4gICAvKiBDb25maWd1cmF0aW9uIGludGVyZmFjZSAq
Lwo+ICAgCj4gICBzdGF0aWMgdTY0IHZtX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmlydGlvX2Rldmlj
ZSAqdmRldikKPiBAQCAtMjY0LDggKzI1OCw2IEBAIHN0YXRpYyB2b2lkIHZtX3Jlc2V0KHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCXdyaXRlbCgwLCB2bV9kZXYtPmJhc2UgKyBWSVJU
SU9fTU1JT19TVEFUVVMpOwo+ICAgfQo+ICAgCj4gLQo+IC0KPiAgIC8qIFRyYW5zcG9ydCBpbnRl
cmZhY2UgKi8KPiAgIAo+ICAgLyogdGhlIG5vdGlmeSBmdW5jdGlvbiB1c2VkIHdoZW4gY3JlYXRp
bmcgYSB2aXJ0IHF1ZXVlICovCj4gQEAgLTMwNyw4ICsyOTksNiBAQCBzdGF0aWMgaXJxcmV0dXJu
X3Qgdm1faW50ZXJydXB0KGludCBpcnEsIHZvaWQgKm9wYXF1ZSkKPiAgIAlyZXR1cm4gcmV0Owo+
ICAgfQo+ICAgCj4gLQo+IC0KPiAgIHN0YXRpYyB2b2lkIHZtX2RlbF92cShzdHJ1Y3QgdmlydHF1
ZXVlICp2cSkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmlydGlvX21taW9fZGV2aWNlICp2bV9kZXYgPSB0
b192aXJ0aW9fbW1pb19kZXZpY2UodnEtPnZkZXYpOwo+IEBAIC01MTIsMTMgKzUwMiwxMSBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHZpcnRpb19tbWlvX2NvbmZpZ19v
cHMgPSB7Cj4gICAJLmJ1c19uYW1lCT0gdm1fYnVzX25hbWUsCj4gICB9Owo+ICAgCj4gLQo+ICAg
c3RhdGljIHZvaWQgdmlydGlvX21taW9fcmVsZWFzZV9kZXYoc3RydWN0IGRldmljZSAqX2QpCj4g
ICB7Cj4gICAJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPQo+ICAgCQkJY29udGFpbmVyX29m
KF9kLCBzdHJ1Y3QgdmlydGlvX2RldmljZSwgZGV2KTsKPiAtCXN0cnVjdCB2aXJ0aW9fbW1pb19k
ZXZpY2UgKnZtX2RldiA9Cj4gLQkJCWNvbnRhaW5lcl9vZih2ZGV2LCBzdHJ1Y3QgdmlydGlvX21t
aW9fZGV2aWNlLCB2ZGV2KTsKPiArCXN0cnVjdCB2aXJ0aW9fbW1pb19kZXZpY2UgKnZtX2RldiA9
IHRvX3ZpcnRpb19tbWlvX2RldmljZSh2ZGV2KTsKPiAgIAlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2ID0gdm1fZGV2LT5wZGV2Owo+ICAgCj4gICAJZGV2bV9rZnJlZSgmcGRldi0+ZGV2LCB2
bV9kZXYpOwo+IEBAIC02MDgsOCArNTk2LDYgQEAgc3RhdGljIGludCB2aXJ0aW9fbW1pb19yZW1v
dmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAg
IAo+IC0KPiAtCj4gICAvKiBEZXZpY2VzIGxpc3QgcGFyYW1ldGVyICovCj4gICAKPiAgICNpZiBk
ZWZpbmVkKENPTkZJR19WSVJUSU9fTU1JT19DTURMSU5FX0RFVklDRVMpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
