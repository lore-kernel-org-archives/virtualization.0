Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628FEC43461
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 08:55:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC30621919
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 08:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8S75w7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC30621919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2AD7286FAD;
	Wed,  9 Sep 2020 08:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXTqkBJyUmF2; Wed,  9 Sep 2020 08:54:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8ED0986F97;
	Wed,  9 Sep 2020 08:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70875C0052;
	Wed,  9 Sep 2020 08:54:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40AF5C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F431870C4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2xFeOYPVjAFv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:54:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 83123870B8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 08:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599641694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v1J7anzfs0x90xPTUoNfpAZn+NVUcNxeloajMKaQs88=;
 b=O8S75w7e/l9dGcV062rKMhJjxXK6zsR8IbqBolTp5t2EllNWZyHFafGHyz9/ywnig4TR68
 ZefSSNB3Xx3pfvG2Bta6K8dxUPOu09OeeSZA+EgXTvovBz9SN47zxKqxstuS7jf7wLLPmO
 9DTiLIziHfTmq4hxenEiB+uBQBUqv/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-V9dOtQlONK2TiuIUhnEkEQ-1; Wed, 09 Sep 2020 04:54:50 -0400
X-MC-Unique: V9dOtQlONK2TiuIUhnEkEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A29B1091061;
 Wed,  9 Sep 2020 08:54:48 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1AFB60C87;
 Wed,  9 Sep 2020 08:54:37 +0000 (UTC)
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <18828d17-c3ac-31bd-2dcf-ecdbd4ad844e@redhat.com>
 <e63a96bf-65d2-ed03-dadc-42d1d8808c9d@intel.com>
 <3dc0d61c-9345-2b61-828c-89ca96555e5e@redhat.com>
 <c9be298b-c51b-f7f3-994b-b7bd9ae53b99@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f89142e6-a92d-b417-5e1c-bbe813636023@redhat.com>
Date: Wed, 9 Sep 2020 16:54:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9be298b-c51b-f7f3-994b-b7bd9ae53b99@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvOS84IOS4iuWNiDk6NDAsIEppZSBEZW5nIHdyb3RlOgo+Cj4KPiBPbiAyMDIwLzkv
NyAxMzo0MCwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+ICtz
dHJ1Y3QgdmlydGlvX2kyY19tc2cgewo+Pj4+PiArwqDCoMKgIHN0cnVjdCB2aXJ0aW9faTJjX2hk
ciBoZHI7Cj4+Pj4+ICvCoMKgwqAgY2hhciAqYnVmOwo+Pj4+PiArwqDCoMKgIHU4IHN0YXR1czsK
Pj4+Pgo+Pj4+Cj4+Pj4gQW55IHJlYXNvbiBmb3Igc2VwYXJhdGluZyBzdGF0dXMgb3V0IG9mIHZp
cnRpb19pMmNfaGRyPwo+Pj4+Cj4+PiBUaGUgc3RhdHVzIGlzIG5vdCBmcm9tIGkyY19tc2cuIAo+
Pgo+Pgo+PiBZb3UgbWVhbnQgaWMyX2hkcj8gWW91IGVtYmVkIHN0YXR1cyBpbiB2aXJ0aW9faTJj
X21zZyBhbnl3YXkuCj4+Cj4+Cj4gVGhlICJpMmNfbXNnIiBzdHJ1Y3R1cmUgZGVmaW5lZCBpbiBp
MmMuaC4KPgo+Pj4gU28gSSBwdXQgaXQgb3V0IG9mIHZpcnRpb19pMmNfaGRyLgo+Pgo+Pgo+PiBT
b21ldGhpbmcgbGlrZSBzdGF0dXMgb3IgcmVzcG9uc2UgaXMgcHJldHR5IGNvbW1vbiBpbiB2aXJ0
aW8gcmVxdWVzdCAKPj4gKGUuZyBuZXQgb3Igc2NzaSksIGlmIG5vIHNwZWNpYWwgcmVhc29uLCBp
dCdzIGJldHRlciB0byBrZWVwIGl0IGluIAo+PiB0aGUgaGRyLgo+Pgo+IE1haW5seSBiYXNlZCBv
biBJTiBvciBPVVQuCj4KPiBUaGUgYWRkciwgZmxhZ3MgYW5kIGxlbiBhcmUgZnJvbSAiaTJjX21z
ZyIuIFRoZXkgYXJlIHB1dCBpbiBvbmUgCj4gc3RydWN0dXJlIGFzIGFuIE9VVCoqc2NhdHRlcmxp
c3QuCj4gVGhlIGJ1ZiBjYW4gYmUgYW4gT1VUKipvciBhbiBJTiBzY2F0dGVybGlzdCBkZXBlbmRp
bmcgb24gd3JpdGUgb3IgcmVhZC4KPiBUaGUgc3RhdHVzIGlzIGEgcmVzdWx0IGZyb20gdGhlIGJh
Y2tlbmTCoCB3aGljaCBpcyBkZWZpbmVkIGFzIGFuIElOIAo+IHNjYXR0ZXJsaXMuIAoKCk9rLiBJ
IGdldCB0aGlzLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
