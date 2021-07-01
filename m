Return-Path: <SRS0=M3O5=LZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E96C11F64
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 06:11:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAE761483
	for <virtualization@archiver.kernel.org>; Thu,  1 Jul 2021 06:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAE761483
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3318483AF0;
	Thu,  1 Jul 2021 06:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLkdi0sWTPbU; Thu,  1 Jul 2021 06:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47B6683AE4;
	Thu,  1 Jul 2021 06:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24A51C0010;
	Thu,  1 Jul 2021 06:11:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CFBC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F139400A7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_jK32HeDEj8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:10:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84D6640012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 06:10:55 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="206655749"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; d="scan'208";a="206655749"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2021 23:10:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; d="scan'208";a="420285841"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 23:10:48 -0700
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <cb35472d-f79e-f3f8-405f-35c699d897a1@intel.com>
Date: Thu, 1 Jul 2021 14:10:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
Content-Language: en-US
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com
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

Ck9uIDIwMjEvNy8xIDEyOjA0LCBWaXJlc2ggS3VtYXIgd3JvdGU6Cj4gT24gMDEtMDctMjEsIDEx
OjI0LCBKaWUgRGVuZyB3cm90ZToKPj4gQ2hhbmdlcyB2MTAgLT4gdjExCj4+IAktIFJlbW92ZSB2
aS0+YWRhcC5jbGFzcyA9IEkyQ19DTEFTU19ERVBSRUNBVEVELgo+PiAJLSBVc2UgI2lmZGVmIENP
TkZJR19QTV9TTEVFUCB0byByZXBsYWNlIHRoZSAiX19tYXliZV91bnVzZWQiLgo+PiAJLSBSZW1v
dmUgInN0cnVjdCBtdXRleCBsb2NrIiBpbiAic3RydWN0IHZpcnRpb19pMmMiLgo+PiAJLSBTdXBw
b3J0IHplcm8tbGVuZ3RoIHJlcXVlc3QuCj4+IAktIFJlbW92ZSB1bm5lY2Vzc2FyeSBsb2dzLgo+
PiAJLSBSZW1vdmUgdmktPmFkYXAudGltZW91dCA9IEhaIC8gMTAsIGp1c3QgdXNlIHRoZSBkZWZh
dWx0IHZhbHVlLgo+PiAJLSBVc2UgQklUKDApIHRvIGRlZmluZSBWSVJUSU9fSTJDX0ZMQUdTX0ZB
SUxfTkVYVC4KPj4gCS0gQWRkIHRoZSB2aXJ0aW9fZGV2aWNlIGluZGV4IHRvIGFkYXB0ZXIncyBu
YW1pbmcgbWVjaGFuaXNtLgo+IFRoYW5rcyBKaWUuCj4KPiBJIGhvcGUgeW91IGFyZSBnb2luZyB0
byBzZW5kIGEgZml4IGZvciBzcGVjaWZpY2F0aW9uIGFzIHdlbGwgKGZvciB0aGUKPiB6ZXJvLWxl
bmd0aCByZXF1ZXN0KSA/CgoKWWVzLiBJIHdpbGwgc2VuZCB0aGF0IGZpeCBvbmNlIHRoaXMgcGF0
Y2ggZ2V0IG1lcmdlZC4KCgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LXZpcnRpby5jIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy12aXJ0aW8uYwo+PiArc3RhdGljIGlu
dCB2aXJ0aW9faTJjX3NlbmRfcmVxcyhzdHJ1Y3QgdmlydHF1ZXVlICp2cSwKPj4gKwkJCQlzdHJ1
Y3QgdmlydGlvX2kyY19yZXEgKnJlcXMsCj4+ICsJCQkJc3RydWN0IGkyY19tc2cgKm1zZ3MsIGlu
dCBucikKPj4gK3sKPj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnc1szXSwgb3V0X2hkciwgbXNn
X2J1ZiwgaW5faGRyOwo+PiArCWludCBpLCBvdXRjbnQsIGluY250LCBlcnIgPSAwOwo+PiArCj4+
ICsJZm9yIChpID0gMDsgaSA8IG5yOyBpKyspIHsKPj4gKwkJLyoKPj4gKwkJICogT25seSA3LWJp
dCBtb2RlIHN1cHBvcnRlZCBmb3IgdGhpcyBtb21lbnQuIEZvciB0aGUgYWRkcmVzcyBmb3JtYXQs
Cj4+ICsJCSAqIFBsZWFzZSBjaGVjayB0aGUgVmlydGlvIEkyQyBTcGVjaWZpY2F0aW9uLgo+PiAr
CQkgKi8KPj4gKwkJcmVxc1tpXS5vdXRfaGRyLmFkZHIgPSBjcHVfdG9fbGUxNihtc2dzW2ldLmFk
ZHIgPDwgMSk7Cj4+ICsKPj4gKwkJaWYgKGkgIT0gbnIgLSAxKQo+PiArCQkJcmVxc1tpXS5vdXRf
aGRyLmZsYWdzID0gY3B1X3RvX2xlMzIoVklSVElPX0kyQ19GTEFHU19GQUlMX05FWFQpOwo+PiAr
Cj4+ICsJCW91dGNudCA9IGluY250ID0gMDsKPj4gKwkJc2dfaW5pdF9vbmUoJm91dF9oZHIsICZy
ZXFzW2ldLm91dF9oZHIsIHNpemVvZihyZXFzW2ldLm91dF9oZHIpKTsKPj4gKwkJc2dzW291dGNu
dCsrXSA9ICZvdXRfaGRyOwo+PiArCj4+ICsJCXJlcXNbaV0uYnVmID0gaTJjX2dldF9kbWFfc2Fm
ZV9tc2dfYnVmKCZtc2dzW2ldLCAxKTsKPj4gKwkJaWYgKCFyZXFzW2ldLmJ1ZikKPj4gKwkJCWJy
ZWFrOwo+PiArCj4+ICsJCXNnX2luaXRfb25lKCZtc2dfYnVmLCByZXFzW2ldLmJ1ZiwgbXNnc1tp
XS5sZW4pOwo+IFRoZSBsZW4gY2FuIGJlIHplcm8gaGVyZSBmb3IgemVyby1sZW5ndGggdHJhbnNm
ZXJzLgo+Cj4+ICsKPj4gKwkJaWYgKG1zZ3NbaV0uZmxhZ3MgJiBJMkNfTV9SRCkKPj4gKwkJCXNn
c1tvdXRjbnQgKyBpbmNudCsrXSA9ICZtc2dfYnVmOwo+PiArCQllbHNlCj4+ICsJCQlzZ3Nbb3V0
Y250KytdID0gJm1zZ19idWY7Cj4+ICsKPj4gKwkJc2dfaW5pdF9vbmUoJmluX2hkciwgJnJlcXNb
aV0uaW5faGRyLCBzaXplb2YocmVxc1tpXS5pbl9oZHIpKTsKPj4gKwkJc2dzW291dGNudCArIGlu
Y250KytdID0gJmluX2hkcjsKPiBXaHkgYXJlIHdlIHN0aWxsIHNlbmRpbmcgdGhlIG1zZ19idWYg
aWYgdGhlIGxlbmd0aCBpcyAwPyBTZW5kaW5nIHRoZQo+IGJ1ZmZlciBtYWtlcyBzZW5zZSBpZiB5
b3UgaGF2ZSBzb21lIGRhdGEgdG8gc2VuZCwgYnV0IG90aGVyd2lzZSBpdCBpcwo+IGp1c3QgYW4g
ZXh0cmEgc2cgZWxlbWVudCwgd2hpY2ggaXNuJ3QgcmVxdWlyZWQgdG8gYmUgc2VudC4KCgpJIHRo
aW5rIGEgZml4ZWQgbnVtYmVyIG9mIHNncyB3aWxsIG1ha2UgdGhpbmdzIGVhc2llciB0byBkZXZl
bG9wIGJhY2tlbmQuCgpJZiB5b3UgcHJlZmVyIHRvIHBhcnNlIHRoZSBudW1iZXIgb2YgZGVzY3Jp
cHRvcnMgaW5zdGVhZCBvZiB1c2luZyB0aGUgCm1zZyBsZW5ndGggdG8KCmRpc3Rpbmd1aXNoIHRo
ZSB6ZXJvLWxlbmd0aCByZXF1ZXN0IGZyb20gb3RoZXIgcmVxdWVzdHMsIEknbSBPSyB0byBzZXQg
YSAKbGltaXQuCgppZiAoIW1zZ3NbaV0ubGVuKSB7CiDCoMKgwqAgc2dfaW5pdF9vbmUoJm1zZ19i
dWYsIHJlcXNbaV0uYnVmLCBtc2dzW2ldLmxlbik7CgogwqDCoMKgIGlmIChtc2dzW2ldLmZsYWdz
ICYgSTJDX01fUkQpCiDCoMKgwqAgwqDCoMKgIHNnc1tvdXRjbnQgKyBpbmNudCsrXSA9ICZtc2df
YnVmOwogwqDCoMKgIGVsc2UKIMKgwqDCoCDCoMKgwqAgc2dzW291dGNudCsrXSA9ICZtc2dfYnVm
Owp9CgoKCj4KPj4gKyNpZmRlZiBDT05GSUdfUE1fU0xFRVAKPj4gK3N0YXRpYyBpbnQgdmlydGlv
X2kyY19mcmVlemUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4+ICt7Cj4+ICsJdmlydGlv
X2kyY19kZWxfdnFzKHZkZXYpOwo+PiArCXJldHVybiAwOwo+PiArfQo+PiArCj4+ICtzdGF0aWMg
aW50IHZpcnRpb19pMmNfcmVzdG9yZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4gK3sK
Pj4gKwlyZXR1cm4gdmlydGlvX2kyY19zZXR1cF92cXModmRldi0+cHJpdik7Cj4+ICt9Cj4+ICsj
ZW5kaWYKPj4gKwo+PiArc3RhdGljIHN0cnVjdCB2aXJ0aW9fZHJpdmVyIHZpcnRpb19pMmNfZHJp
dmVyID0gewo+PiArCS5pZF90YWJsZQk9IGlkX3RhYmxlLAo+PiArCS5wcm9iZQkJPSB2aXJ0aW9f
aTJjX3Byb2JlLAo+PiArCS5yZW1vdmUJCT0gdmlydGlvX2kyY19yZW1vdmUsCj4+ICsJLmRyaXZl
cgk9IHsKPj4gKwkJLm5hbWUJPSAiaTJjX3ZpcnRpbyIsCj4+ICsJfSwKPj4gKyNpZmRlZiBDT05G
SUdfUE1fU0xFRVAKPiBZb3UgY291bGQgYXZvaWQgdGhpcyBwYWlyIG9mIGlmZGVmIGJ5IGNyZWF0
aW5nIGR1bW15IHZlcnNpb25zIG9mIGJlbG93Cj4gcm91dGluZXMgZm9yICFDT05GSUdfUE1fU0xF
RVAgY2FzZS4gVXAgdG8geW91LgoKClRoYW5rIHlvdS4gSSdkIGxpa2UgdG8ga2VlcCB0aGUgc2Ft
ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
