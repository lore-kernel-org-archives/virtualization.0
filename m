Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E14C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962B060241
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 05:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B060241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43ADE4ED8E;
	Tue,  2 Mar 2021 05:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jGTTcDpdNnD; Tue,  2 Mar 2021 05:43:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8EE64ED8C;
	Tue,  2 Mar 2021 05:43:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0881C000A;
	Tue,  2 Mar 2021 05:43:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9086EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BE9683C83
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4VtY0YJF9GC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:43:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EC8283C82
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 05:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614663798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1nmciMgkZ+IaIXXkMRC5e7HPFjY7bXKmsBF/n5bymw=;
 b=VviDtDMAGeYYEvw73fuwHT21MhNo8GCVRj6RhIRZlQydXUcZc560z+eyCl+XdEyufhNFdI
 XDR1LxUnqBqOK7Apcqqt3Te+8Q7qwhGmnyO31Khf89PRvsTXyGS47E/v6CJpP9gX26Rh3e
 f2KvGOlzrm02sUrDfucD63bry3WIbi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-JO6z7fOiN0uCDL3B1KZo3A-1; Tue, 02 Mar 2021 00:43:14 -0500
X-MC-Unique: JO6z7fOiN0uCDL3B1KZo3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A3118B613D;
 Tue,  2 Mar 2021 05:43:11 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFD75D71F;
 Tue,  2 Mar 2021 05:42:55 +0000 (UTC)
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>, Jie Deng <jie.deng@intel.com>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <CAK8P3a1ZXbodV07TTErnQunCLWOBnzRiVdLCxBD743fn-6FbXg@mail.gmail.com>
 <20210302040114.rg6bb32g2bsivsgf@vireshk-i7>
 <20210302042233.7ppagwjk3rah3uh3@vireshk-i7>
 <5e66fc1b-81d3-341e-4864-adb021e9ce1e@intel.com>
 <20210302051607.gul2w66xpsffzpnm@vireshk-i7>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2fae0d65-e52d-4275-d106-fd9d9a6703f0@redhat.com>
Date: Tue, 2 Mar 2021 13:42:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210302051607.gul2w66xpsffzpnm@vireshk-i7>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>, yu1.wang@intel.com,
 Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 shuo.a.liu@intel.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, jarkko.nikula@linux.intel.com,
 Linux I2C <linux-i2c@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kblaiech@mellanox.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 conghui.chen@intel.com, Mike Rapoport <rppt@kernel.org>
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

Ck9uIDIwMjEvMy8yIDE6MTYg5LiL5Y2ILCBWaXJlc2ggS3VtYXIgd3JvdGU6Cj4gT24gMDItMDMt
MjEsIDEzOjA2LCBKaWUgRGVuZyB3cm90ZToKPj4gWWVhaC4gQWN0dWFsbHksIHRoZSBiYWNrZW5k
IG9ubHkgbmVlZHMgInN0cnVjdCB2aXJ0aW9faTJjX291dF9oZHIgb3V0X2hkciIKPj4gYW5kICJz
dHJ1Y3QgdmlydGlvX2kyY19pbl9oZHIgaW5faGRyIiBmb3IgY29tbXVuaWNhdGlvbi4gU28gd2Ug
b25seSBuZWVkIHRvCj4+IGtlZXAKPj4gdGhlIGZpcnN0IHR3byBpbiB1YXBpIGFuZCBtb3ZlICJz
dHJ1Y3QgdmlydGlvX2kyY19yZXEiIGludG8gdGhlIGRyaXZlci4KPj4KPj4gQnV0IEphc29uIHdh
bnRlZCB0byBpbmNsdWRlICJzdHJ1Y3QgdmlydGlvX2kyY19yZXEiIGluIHVhcGkuIEhlIGV4cGxh
aW5lZCBpbgo+PiB0aGlzIGxpbmsKPj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L3BpcGVybWFpbC92aXJ0dWFsaXphdGlvbi8yMDIwLU9jdG9iZXIvMDUwMjIyLmh0bWwuCj4+IERv
IHlvdSBhZ3JlZSB3aXRoIHRoYXQgZXhwbGFuYXRpb24gPwo+IEkgYW0gbm90IHN1cmUgSSB1bmRl
cnN0b29kIGhpcyByZWFzb25pbmcgd2VsbCwgYnV0IGl0IGRvZXNuJ3QgbWFrZSBhbnkKPiBzZW5z
ZSB0byBrZWVwIHRoaXMgaW4gdWFwaSBoZWFkZXIgaWYgdGhpcyBpcyBuZXZlciBnb2luZyB0byBn
ZXQKPiB0cmFuc2ZlcnJlZCBvdmVyIHRoZSB3aXJlLgoKCkkgdGhpbmsgSSB3YXMgd3JvbmcuIEl0
IHNob3VsZCBiZSBzdWZmaWNpZW50IGhhdmUgaW5faGRyIGFuZCBvdXRfaGRyIGluIAp1QVBJLgoK
VGhhbmtzCgoKPgo+IE1vcmVvdmVyLCB0aGUgc3RydWN0IHZpcnRpb19pMmNfcmVxIGluIHNwZWMg
aXMgbWlzbGVhZGluZyB0byBtZSBhbmQKPiByYXRoZXIgY3JlYXRlcyB1bm5lY2Vzc2FyeSBjb25m
dXNpb24uIFRoZXJlIGlzIG5vIHN0cnVjdHVyZSBsaWtlIHRoaXMKPiB3aGljaCBldmVyIGdldCBw
YXNzZWQgaGVyZSwgYnV0IHJhdGhlciB0aGVyZSBhcmUgbXVsdGlwbGUgdnEKPiB0cmFuc2FjdGlv
bnMgd2hpY2ggdGFrZSBwbGFjZSwgb25lIHdpdGgganVzdCB0aGUgb3V0IGhlYWRlciwgdGhlbiBv
bmUKPiB3aXRoIGJ1ZmZlciBhbmQgZmluYWxseSBvbmUgd2l0aCBpbiBoZWFkZXIuCj4KPiBJIGFt
IG5vdCBzdXJlIHdoYXQncyB0aGUgcmlnaHQgd2F5IG9mIGRvY3VtZW50aW5nIGl0IG9yIGlmIHRo
aXMgaXMgYQo+IHN0YW5kYXJkIHZpcnRpbyB3b3JsZCBmb2xsb3dzLgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
