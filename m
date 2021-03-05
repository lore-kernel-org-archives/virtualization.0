Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1273FC433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:12:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E5364F4A
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5364F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52D23844E0;
	Fri,  5 Mar 2021 08:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc8N0ixN7O3o; Fri,  5 Mar 2021 08:12:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0CB8844CE;
	Fri,  5 Mar 2021 08:12:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95B9EC000A;
	Fri,  5 Mar 2021 08:12:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F75C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4256F844E0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h31PTipp6-dv
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FB09844CE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:12:52 +0000 (UTC)
IronPort-SDR: HHpQ0y5eBQP5VfAPbjOQ7CdP1VUjvFgnRHHJwdn5uNt1cX2TKUOsAVKjVpn9UDsli4Q3MdSoGP
 ceGD/1PWg9dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="248990417"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="248990417"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2021 00:12:51 -0800
IronPort-SDR: gOM/RV1MGFF6djhiCzZwd71anEmVTMnJCG2twRD5Am2DSoCo9aEygW3cGFIEUahEX4KzpyYu8z
 HmXiSROUba8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; d="scan'208";a="597700002"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2021 00:12:45 -0800
Subject: Re: [PATCH v6] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <9a2086f37c0a62069b67c39a3f75941b78a0039c.1614749417.git.jie.deng@intel.com>
 <43b0842b-8b0f-1979-ed07-d6124e3a6b79@redhat.com>
 <76554717-fc77-1c63-58d2-58aa04f7af9b@intel.com>
 <7aa23b71-01eb-5824-b1db-892ede690fce@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b1b66c2a-beec-c864-77a0-3bd0c6842e2e@intel.com>
Date: Fri, 5 Mar 2021 16:12:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <7aa23b71-01eb-5824-b1db-892ede690fce@redhat.com>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 viresh.kumar@linaro.org, shuo.a.liu@intel.com, tali.perry1@gmail.com,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, pbonzini@redhat.com,
 jarkko.nikula@linux.intel.com, stefanha@redhat.com,
 u.kleine-koenig@pengutronix.de, kblaiech@mellanox.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, rppt@kernel.org
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

T24gMjAyMS8zLzUgMTU6MjMsIEphc29uIFdhbmcgd3JvdGU6Cgo+Cj4+Pj4gK8KgwqDCoCB2aXJ0
cXVldWVfa2ljayh2cSk7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgdGltZV9sZWZ0ID0gd2FpdF9mb3Jf
Y29tcGxldGlvbl90aW1lb3V0KCZ2aS0+Y29tcGxldGlvbiwgCj4+Pj4gYWRhcC0+dGltZW91dCk7
Cj4+Pj4gK8KgwqDCoCBpZiAoIXRpbWVfbGVmdCkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZf
ZXJyKCZhZGFwLT5kZXYsICJ2aXJ0aW8gaTJjIGJhY2tlbmQgdGltZW91dC5cbiIpOwo+Pj4+ICvC
oMKgwqDCoMKgwqDCoCByZXQgPSAtRVRJTUVET1VUOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3Rv
IGVycl91bmxvY2tfZnJlZTsKPj4+Cj4+Pgo+Pj4gU28gaWYgdGhlIHJlcXVlc3QgaXMgZmluaXNo
ZWQgYWZ0ZXIgdGhlIHRpbWVyb3V0LCBhbGwgdGhlIGZvbGxvd2luZyAKPj4+IHJlcXVlc3Qgd2ls
bCBmYWlsLCBpcyB0aGlzIGV4cGVjdGVkPwo+Pj4KPj4+Cj4+IFRoaXMgaXMgYW4gZXhwZWN0ZWQg
YmVoYXZpb3IuIElmIHRpbWVvdXQgaGFwcGVucywgd2UgZG9uJ3QgbmVlZCB0byAKPj4gY2FyZSBh
Ym91dCB0aGUgcmVxdWVzdHMgd2hldGhlcgo+PiByZWFsbHkgY29tcGxldGVkIGJ5ICJIVyIgb3Ig
bm90LiBKdXN0IHJldHVybiBlcnJvciBhbmQgbGV0IHRoZSBpMmMgCj4+IGNvcmUgdG8gZGVjaWRl
IHdoZXRoZXIgdG8gcmVzZW5kLgo+Cj4KPiBTbyB5b3UgbmVlZCBhdCBsZWFzdCByZWluaXQgdGhl
IGNvbXBsZXRpb24gYXQgbGVhc3Q/Cj4KClJpZ2h0LiBXaWxsIGZpeCBpdC4gVGhhbmsgeW91LgoK
Cj4KPj4+PiArwqDCoMKgIH0KPj4+PiArCj4+Pj4gK8KgwqDCoCByZXQgPSB2aXJ0aW9faTJjX2Nv
bXBsZXRlX3JlcXModnEsIHJlcXMsIG1zZ3MsIG5yKTsKPj4+Cj4+Pgo+Pj4gU28gY29uc2lkZXIg
ZHJpdmVyIHF1ZXVlIE4gcmVxdWVzdHMsIGNhbiBkZXZpY2UgcmFpc2UgaW50ZXJydXB0IGlmIAo+
Pj4gaXQgY29tcGxldGVzIHRoZSBmaXJzdCByZXF1ZXN0PyBJZiB5ZXMsIHRoZSBjb2RlIGJyZWFr
LCBpZiBub3QgaXQgCj4+PiBuZWVkIHRvIGJlIGNsYXJpZmllZCBpbiB0aGUgc3BlYy4KPj4gVGhl
IGRldmljZSBjYW4gcmFpc2UgaW50ZXJydXB0IHdoZW4gc29tZSByZXF1ZXN0cyBhcmUgc3RpbGwg
bm90IAo+PiBjb21wbGV0ZWQgdGhvdWdoIHRoaXMgaXMgbm90IGEgZ29vZCBvcGVyYXRpb24uCj4K
Pgo+IFRoZW4geW91IG5lZWQgZm9yYmlkIHRoaXMgaW4gdGhlIHNwZWMuCj4KClllYWgsIGJ1dCBJ
IHRoaW5rIHdlIGNhbiBhZGQgc29tZSBkZXNjcmlwdGlvbiB0byBleHBsYWluIHRoaXMgY2xlYXJs
eSAKaW5zdGVhZCBvZiBmb3JiaWQgaXQgZGlyZWN0bHkuCgoKPgo+PiBJbiB0aGlzIGNhc2UsIHRo
ZSByZW1haW5pbmcgcmVxdWVzdHMgaW4gdGhlIHZxIHdpbGwgYmUgaWdub3JlZCBhbmQgCj4+IHRo
ZSBpMmNfYWxnb3JpdGhtLiBtYXN0ZXJfeGZlciB3aWxsIHJldHVybiAxIGZvcgo+PiB5b3VyIGV4
YW1wbGUuIEFuZCBsZXQgdGhlIGkyYyBjb3JlIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHJlc2VuZC4K
Pj4+Cj4+PiBBY2F1bHRseSBJIHJlbWVtYmVyIHRoZXJlJ3Mgbm8gVklSVElPX0kyQ19GTEFHU19G
QUlMX05FWFQgaW4gCj4+PiBwcmV2aW91cyB2ZXJzaW9ucywgYW5kIGFmdGVyIHJlYWRpbmcgdGhl
IHNwZWMgSSBzdGlsbCBkb24ndCBnZXQgdGhlIAo+Pj4gbW90aXZhdGlvbiBmb3IgdGhhdCAoaXQg
bWF5IGNvbXBsaWNhdGVzIGJvdGggZHJpdmVyIGFuZCBkZXZpY2UgCj4+PiBhY3R1YWxseSkuCj4+
Pgo+PiBUaGlzIGZsYWcgaXMgaW50cm9kdWNlZCBieSBTdGVmYW4uIFBsZWFzZSBjaGVjayBmb2xs
b3dpbmcgbGluayBmb3IgCj4+IHRoZSBkZXRhaWxzCj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Bl
bi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMDEyL21zZzAwMDc1Lmh0bWwuIAo+Pgo+
Cj4KPiA+IFdlIGp1c3QgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCBvbmNlIHRoZSBkcml2ZXIgYWRk
cyBzb21lIHJlcXVlc3RzIHRvIAo+IHRoZQo+ID4gdmlydHF1ZXVlLAo+ID4gaXQgc2hvdWxkIGNv
bXBsZXRlIHRoZW0gKGVpdGhlciBzdWNjZXNzIG9yIGZhaWwpIGJlZm9yZSBhZGRpbmcgbmV3IAo+
IHJlcXVlc3RzLgo+ID4gSSB0aGluayB0aGlzCj4gPiBpcyBhIGJlaGF2aW9yIG9mIHBoeXNpY2Fs
IEkyQyBhZGFwdGVyIGRyaXZlcnMgYW5kIHdlIGNhbiBmb2xsb3cuCj4KPgo+IElzIHRoaXMgYSBk
cml2ZXIgcmVxdWlyZW1lbnQgb3IgZGV2aWNlPyBJZiBpdCdzIHRoZSBkcml2ZXIsIHRoZSBjb2Rl
IAo+IGhhdmUgYWxyZWFkeSBkaWQgc29tZXRoaW5nIGxpa2UgdGhpcy4gRS5nIHlvdSB3YWl0IGZv
ciB0aGUgY29tcGxldGlvbiAKPiBvZiB0aGUgcmVxdWVzdCBhbmQgZm9yYmlkIG5ldyByZXF1ZXN0
IHZpYSBpMmNfbG9jay4KPgo+IFRoYW5rcwo+CgpUaGUgZHJpdmVyLsKgIFZJUlRJT19JMkNfRkxB
R1NfRkFJTF9ORVhUIGRvZXNuJ3QgaGVscCBpbiBMaW51eCBkcml2ZXIuIApCdXQgSSBhZ3JlZSB3
aXRoIFN0ZWZhbiB0aGF0ClZJUlRJTyBpcyBub3Qgc3BlY2lmaWMgdG8gTGludXggc28gdGhlIHNw
ZWNzIGRlc2lnbiBzaG91bGQgYXZvaWQgdGhlIApsaW1pdGF0aW9ucyBvZiB0aGUgY3VycmVudApM
aW51eCBkcml2ZXIgYmVoYXZpb3IuCgoKPgo+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
