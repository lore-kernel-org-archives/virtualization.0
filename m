Return-Path: <SRS0=wNjl=IW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DFC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 06:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9AC619C7
	for <virtualization@archiver.kernel.org>; Wed, 24 Mar 2021 06:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AC619C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 943DE60A5E;
	Wed, 24 Mar 2021 06:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCTrq9E_voGd; Wed, 24 Mar 2021 06:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A54608FF;
	Wed, 24 Mar 2021 06:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7DF6C000D;
	Wed, 24 Mar 2021 06:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E7F2C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB38D40582
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WuDZvlZDmiOX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 311DD404FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Mar 2021 06:05:13 +0000 (UTC)
IronPort-SDR: 98zB9F8DDQEIjbqQiR7BBylM0CVgUcWbFcHgiDMH5FoDNv5Redpnk9hxyIlhstRYBr9o/aYhAP
 jsAVzs3RxCEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188324696"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="188324696"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2021 23:05:12 -0700
IronPort-SDR: ffBpDW2qAgf19Id2gs+eF8QreDYeQi7v+GUNT2JBW0osN7x1s0leWgZWgf8wiue88FhrwqVszp
 cHhKK5MjbhMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; d="scan'208";a="442065548"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2021 23:05:07 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <20210324042046.idkctj2t7cxi53jf@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <70908366-c270-848e-0be3-c85fec7958ec@intel.com>
Date: Wed, 24 Mar 2021 14:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324042046.idkctj2t7cxi53jf@vireshk-i7>
Content-Language: en-US
Cc: mst@redhat.com, bjorn.andersson@linaro.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org, wsa@kernel.org,
 andriy.shevchenko@linux.intel.com, yu1.wang@intel.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 virtualization@lists.linux-foundation.org, arnd@arndb.de, stefanha@redhat.com,
 tali.perry1@gmail.com, conghui.chen@intel.com, loic.poulain@linaro.org,
 linux-kernel@vger.kernel.org, Sergey.Semin@baikalelectronics.ru,
 jarkko.nikula@linux.intel.com, shuo.a.liu@intel.com, pbonzini@redhat.com,
 rppt@kernel.org
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

Ck9uIDIwMjEvMy8yNCAxMjoyMCwgVmlyZXNoIEt1bWFyIHdyb3RlOgo+IE9uIDIzLTAzLTIxLCAy
MjoxOSwgSmllIERlbmcgd3JvdGU6Cj4+ICtzdGF0aWMgaW50IHZpcnRpb19pMmNfeGZlcihzdHJ1
Y3QgaTJjX2FkYXB0ZXIgKmFkYXAsIHN0cnVjdCBpMmNfbXNnICptc2dzLCBpbnQgbnVtKQo+PiAr
ewo+PiArCXN0cnVjdCB2aXJ0aW9faTJjICp2aSA9IGkyY19nZXRfYWRhcGRhdGEoYWRhcCk7Cj4+
ICsJc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2aS0+dnE7Cj4+ICsJc3RydWN0IHZpcnRpb19pMmNf
cmVxICpyZXFzOwo+PiArCXVuc2lnbmVkIGxvbmcgdGltZV9sZWZ0Owo+PiArCWludCByZXQsIG5y
Owo+PiArCj4+ICsJcmVxcyA9IGtjYWxsb2MobnVtLCBzaXplb2YoKnJlcXMpLCBHRlBfS0VSTkVM
KTsKPj4gKwlpZiAoIXJlcXMpCj4+ICsJCXJldHVybiAtRU5PTUVNOwo+PiArCj4+ICsJbXV0ZXhf
bG9jaygmdmktPmxvY2spOwo+PiArCj4+ICsJcmV0ID0gdmlydGlvX2kyY19zZW5kX3JlcXModnEs
IHJlcXMsIG1zZ3MsIG51bSk7Cj4+ICsJaWYgKHJldCA9PSAwKQo+PiArCQlnb3RvIGVycl91bmxv
Y2tfZnJlZTsKPj4gKwo+PiArCW5yID0gcmV0Owo+PiArCXJlaW5pdF9jb21wbGV0aW9uKCZ2aS0+
Y29tcGxldGlvbik7Cj4+ICsJdmlydHF1ZXVlX2tpY2sodnEpOwo+IENvbWluZyBiYWNrIHRvIHRo
aXMgYWdhaW4sIHdoYXQgaXMgdGhlIGV4cGVjdGF0aW9uIGZyb20gdGhlIG90aGVyIHNpZGUgZm9y
IHRoaXMKPiA/IEkgbWVhbiB0aGVyZSBpcyBubyBvYnZpb3VzIHJlbGF0aW9uIGJldHdlZW4gdGhl
ICptc2dzKiB3aGljaCB3ZSBhcmUgZ29pbmcgdG8KPiB0cmFuc2ZlciAoZnJvbSB0aGUgb3RoZXIg
c2lkZSdzIG9yIGhvc3QncyBwb2ludCBvZiB2aWV3KS4gV2hlbiBzaG91bGQgdGhlIGhvc3QKPiBP
UyBjYWxsIGl0cyB2aXJ0cXVldWVfa2ljaygpIGNvdW50ZXJwYXJ0ID8KPgo+IExlbW1lIGdpdmUg
YW4gZXhhbXBsZSBmb3IgdGhpcy4gTGV0cyBzYXkgdGhhdCB3ZSBuZWVkIHRvIHRyYW5zZmVyIDMg
bWVzc2FnZXMKPiBoZXJlIGluIHRoaXMgcm91dGluZS4gV2hhdCB3ZSBkaWQgd2FzIHdlIHByZXBh
cmVkIHZpcnRxdWV1ZSBmb3IgYWxsIDMgbWVzc2FnZXMKPiB0b2dldGhlciBhbmQgdGhlbiBjYWxs
ZWQgdmlydHF1ZXVlX2tpY2soKS4KPgo+IE5vdyBpZiB0aGUgb3RoZXIgc2lkZSAoaG9zdCkgcHJv
Y2Vzc2VzIHRoZSBmaXJzdCBtZXNzYWdlIGFuZCBzZW5kcyBpdHMgcmVwbHkKPiAod2l0aCB2aXJ0
cXVldWVfa2ljaygpIGNvdW50ZXJwYXJ0KSBiZWZvcmUgcHJvY2Vzc2luZyB0aGUgb3RoZXIgdHdv
IG1lc3NhZ2VzLAo+IHRoZW4gaXQgd2lsbCBlbmQgdXAgY2FsbGluZyB2aXJ0aW9faTJjX21zZ19k
b25lKCkgaGVyZS4gVGhhdCB3aWxsIG1ha2UgdXMgY2FsbAo+IHZpcnRpb19pMmNfY29tcGxldGVf
cmVxcygpLCB3aGlsZSBvbmx5IHRoZSBmaXJzdCBtZXNzYWdlcyBpcyBwcm9jZXNzZWQgdW50aWwK
PiBub3cgYW5kIHNvIHdlIHdpbGwgZmFpbCBmb3IgdGhlIG90aGVyIHR3byBtZXNzYWdlcyBzdHJh
aWdodCBhd2F5Lgo+Cj4gU2hvdWxkIHdlIHNlbmQgb25seSAxIG1lc3NhZ2UgZnJvbSBpMmMtdmly
dGlvIGxpbnV4IGRyaXZlciBhbmQgdGhlbiB3YWl0IGZvcgo+IHZpcnRpb19pMmNfbXNnX2RvbmUo
KSB0byBiZSBjYWxsZWQsIGJlZm9yZSBzZW5kaW5nIHRoZSBuZXh0IG1lc3NhZ2UgdG8gbWFrZSBz
dXJlCj4gaXQgZG9lc24ndCBicmVhayA/CgoKRm9yIHNpbXBsaWNpdHksIHRoZSBvcmlnaW5hbCBw
YXRjaCBzZW50IG9ubHkgMSBtZXNzYWdlIHRvIHZxIGVhY2ggdGltZSAuIApJIGNoYW5nZWQgdGhl
IHdheSB0byBzZW5kCgphIGJhdGNoIG9mIHJlcXVlc3RzIGluIG9uZSB0aW1lIGluIG9yZGVyIHRv
IGltcHJvdmUgZWZmaWNpZW5jeSBhY2NvcmRpbmcgCnRvIEphc29uJyBzdWdnZXN0aW9uLgoKQXMg
d2UgZGlzY3Vzc2VkIGluIHRoZSBwcmV2aW91cyBlbWFpbHMsIHRoZSBkZXZpY2UgY2FuIHJhaXNl
IGludGVycnVwdCAKd2hlbiBzb21lIHJlcXVlc3RzIGFyZSBzdGlsbCBub3QgY29tcGxldGVkCgp0
aG91Z2ggdGhpcyBpcyBub3QgYSBnb29kIG9wZXJhdGlvbi7CoCBJbiB0aGlzIGNhc2UsIHRoZSBy
ZW1haW5pbmcgCnJlcXVlc3RzIGluIHRoZSB2cSB3aWxsIGJlIGlnbm9yZWQgYW5kCgp0aGUgaTJj
X2FsZ29yaXRobS4gbWFzdGVyX3hmZXIgd2lsbCByZXR1cm4gMSBmb3IgeW91ciBleGFtcGxlLiBJ
IHdpbGwgCmNsYXJpZnkgdGhpcyBpbiB0aGUgc3BlY3MuCgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
