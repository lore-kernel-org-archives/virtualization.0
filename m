Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF104C10DAA
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 09:02:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B462145D
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQwbwBbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B462145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F1CE6870D7;
	Wed,  9 Sep 2020 09:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tT-6nS+tWYYC; Wed,  9 Sep 2020 09:02:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 48E6D870BB;
	Wed,  9 Sep 2020 09:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37FDEC0859;
	Wed,  9 Sep 2020 09:02:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F3CC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 732532E150
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0z1YR4Ckz2cl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 77BD52E13F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599642148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwK/UCn7nj/bDtxyg3u6KBsLtSFGCtiaPO7yxlcqvrQ=;
 b=LQwbwBbDQTK1dJWqheR46LeuwQe+scys0zvUqDtk2SGjwlMMkXUvadMgC2ANOtf4aEzLv8
 +SVcyhiB1rysBlmjig9cs3Xr5VO4CMYt1vdtZJwDoqjBXNCxSmQOQffoIQYcfHZJwRqJ71
 0VWcNvVMTPEaZ66RggbTB6sGCP1lHkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-mdNZZnLJOlelVXruIZe3Xg-1; Wed, 09 Sep 2020 05:02:24 -0400
X-MC-Unique: mdNZZnLJOlelVXruIZe3Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C0BC801AE5;
 Wed,  9 Sep 2020 09:02:21 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAC560C87;
 Wed,  9 Sep 2020 09:02:09 +0000 (UTC)
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <acf0e13d-3080-81e8-9cb1-82af6935d402@redhat.com>
Date: Wed, 9 Sep 2020 17:02:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
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

Ck9uIDIwMjAvOS8zIOS4i+WNiDE6MzQsIEppZSBEZW5nIHdyb3RlOgo+IC0tLSBhL2RyaXZlcnMv
aTJjL2J1c3Nlcy9NYWtlZmlsZQo+ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9NYWtlZmlsZQo+
IEBAIC02LDYgKzYsOSBAQAo+ICAgIyBBQ1BJIGRyaXZlcnMKPiAgIG9iai0kKENPTkZJR19JMkNf
U0NNSSkJCSs9IGkyYy1zY21pLm8KPiAgIAo+ICsjIFZJUlRJTyBJMkMgaG9zdCBjb250cm9sbGVy
IGRyaXZlcgo+ICtvYmotJChDT05GSUdfSTJDX1ZJUlRJTykJKz0gaTJjLXZpcnRpby5vCj4gKwo+
ICAgIyBQQyBTTUJ1cyBob3N0IGNvbnRyb2xsZXIgZHJpdmVycwo+ICAgb2JqLSQoQ09ORklHX0ky
Q19BTEkxNTM1KQkrPSBpMmMtYWxpMTUzNS5vCj4gICBvYmotJChDT05GSUdfSTJDX0FMSTE1NjMp
CSs9IGkyYy1hbGkxNTYzLm8KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12
aXJ0aW8uYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtdmlydGlvLmMKPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NAo+IGluZGV4IDAwMDAwMDAuLjQ3ZjlmZDEKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12aXJ0aW8uYwo+IEBAIC0wLDAgKzEsMjc2IEBACj4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIFZp
cnRpbyBJMkMgQnVzIERyaXZlcgo+ICsgKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjAgSW50ZWwg
Q29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUg
PGxpbnV4L2FjcGkuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2NvbXBsZXRpb24uaD4KPiArI2luY2x1
ZGUgPGxpbnV4L2Vyci5oPgo+ICsjaW5jbHVkZSA8bGludXgvaTJjLmg+Cj4gKyNpbmNsdWRlIDxs
aW51eC9pby5oPgo+ICsjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPgo+ICsjaW5jbHVkZSA8bGlu
dXgva2VybmVsLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KPiArI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPgo+ICsjaW5jbHVkZSA8bGludXgvd2FpdC5oPgo+ICsKPiAr
I2luY2x1ZGUgPGxpbnV4L3ZpcnRpby5oPgo+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2lkcy5o
Pgo+ICsjaW5jbHVkZSA8bGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICsKPiArI2RlZmluZSBWSVJU
SU9fSTJDX01TR19PSwkwCj4gKyNkZWZpbmUgVklSVElPX0kyQ19NU0dfRVJSCTEKPiArCj4gKy8q
Kgo+ICsgKiBzdHJ1Y3QgdmlydGlvX2kyY19oZHIgLSB0aGUgdmlydGlvIEkyQyBtZXNzYWdlIGhl
YWRlciBzdHJ1Y3R1cmUKPiArICogQGFkZHI6IGkyY19tc2cgYWRkciwgdGhlIHNsYXZlIGFkZHJl
c3MKPiArICogQGZsYWdzOiBpMmNfbXNnIGZsYWdzCj4gKyAqIEBsZW46IGkyY19tc2cgbGVuCj4g
KyAqLwo+ICtzdHJ1Y3QgdmlydGlvX2kyY19oZHIgewo+ICsJX192aXJ0aW8xNiBhZGRyOwo+ICsJ
X192aXJ0aW8xNiBmbGFnczsKPiArCV9fdmlydGlvMTYgbGVuOwo+ICt9IF9fcGFja2VkOwoKCkJ0
dywgdGhpcyBwYXJ0IHNob3VsZCBiZWxvbmcgdG8gdUFQSSwgYW5kIHlvdSBuZWVkIHRvIGRlZmlu
ZSB0aGUgc3RhdHVzIAppbiB1QVBJLgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
