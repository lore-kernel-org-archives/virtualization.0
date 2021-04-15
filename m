Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91BC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:23:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E180611AB
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 08:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E180611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5A0994012C;
	Thu, 15 Apr 2021 08:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dwlkmz12VLq; Thu, 15 Apr 2021 08:23:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B9644012B;
	Thu, 15 Apr 2021 08:23:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1790C000C;
	Thu, 15 Apr 2021 08:23:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 079FFC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1F7C60D8B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqV6TCiF74ky
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0ECBA60D88
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:23:18 +0000 (UTC)
IronPort-SDR: sbAmqZvo/jSvEoJpscG6c5iy4Tndb05CabSTMkBRYjKDGCXfWqQ1bnzaRpQiDprg23ZvFoSp5L
 fm6s2iU+I5dQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="215314311"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="215314311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 01:23:18 -0700
IronPort-SDR: NnBSBmKZuiQhFP2kUgCvYOyQb6zgnVVK8MCFIcycmWEoC+F4egS5ZnCn9IeXfWpRVyuaPJxnNj
 7CoPNOG3g9oQ==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418665137"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 01:23:17 -0700
Subject: Re: [PATCH 3/3] vDPA/ifcvf: get_config_size should return dev
 specific config size
To: virtualization@lists.linux-foundation.org
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-4-lingshan.zhu@intel.com>
 <20210415081236.anbssqtsyjnmiaby@steredhat>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <406df891-246e-4eaf-030c-192d49813af0@linux.intel.com>
Date: Thu, 15 Apr 2021 16:23:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415081236.anbssqtsyjnmiaby@steredhat>
Content-Language: en-US
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

CgpPbiA0LzE1LzIwMjEgNDoxMiBQTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9uIFdl
ZCwgQXByIDE0LCAyMDIxIGF0IDA1OjE4OjMyUE0gKzA4MDAsIFpodSBMaW5nc2hhbiB3cm90ZToK
Pj4gZ2V0X2NvbmZpZ19zaXplKCkgc2hvdWxkIHJldHVybiB0aGUgc2l6ZSBiYXNlZCBvbiB0aGUg
ZGVjZWN0ZWQKPj4gZGV2aWNlIHR5cGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hh
biA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+IGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgfCAxMSArKysrKysrKysrLQo+PiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYyAKPj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+
IGluZGV4IDliNmEzOGI3OThmYS4uYjQ4Yjk3ODliNjllIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMKPj4gQEAgLTM0Nyw3ICszNDcsMTYgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dl
dF92cV9hbGlnbihzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4KPj4gc3RhdGlj
IHNpemVfdCBpZmN2Zl92ZHBhX2dldF9jb25maWdfc2l6ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2KQo+PiB7Cj4+IC3CoMKgwqAgcmV0dXJuIHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9j
b25maWcpOwo+PiArwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPj4gK8KgwqDCoCBzaXplX3Qgc2l6ZTsKPj4gKwo+PiArwqDCoMKgIGlmICh2Zi0+ZGV2
X3R5cGUgPT0gVklSVElPX0lEX05FVCkKPj4gK8KgwqDCoMKgwqDCoMKgIHNpemUgPSBzaXplb2Yo
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPj4gKwo+PiArwqDCoMKgIGlmICh2Zi0+ZGV2X3R5
cGUgPT0gVklSVElPX0lEX0JMT0NLKQo+PiArwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgdmlydGlvX2Jsa19jb25maWcpOwo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIHNpemU7Cj4K
PiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdGhlIGlmY3ZmIGRldGFpbHMsIGJ1dCBjYW4gaXQgaGFw
cGVuIHRoYXQgdGhlIAo+IGRldmljZSBpcyBub3QgYmxvY2sgb3IgbmV0Pwo+Cj4gU2hvdWxkIHdl
IHNldCBgc2l6ZWAgdG8gMCBieSBkZWZhdWx0IHRvIGhhbmRsZSB0aGlzIGNhc2Ugb3IgYXJlIHdl
IAo+IHN1cmUgaXQncyBvbmUgb2YgdGhlIHR3bz8KPgo+IE1heWJlIHdlIHNob3VsZCBhZGQgYSBj
b21tZW50IG9yIGEgd2FybmluZyBtZXNzYWdlIGluIHRoaXMgY2FzZSwgdG8gCj4gcHJldmVudCBz
b21lIGFuYWx5c2lzIHRvb2wgb3IgY29tcGlsZXIgZnJvbSB3b3JyeWluZyB0aGF0IGBzaXplYCBt
aWdodCAKPiBiZSB1bmluaXRpYWxpemVkLgo+Cj4gSSB3YXMgdGhpbmtpbmcgc29tZXRoaW5nIGxp
a2UgdGhpczoKPgo+IMKgwqDCoMKgc3dpdGNoKHZmLT5kZXZfdHlwZSkgewo+IMKgwqDCoMKgY2Fz
ZSBWSVJUSU9fSURfTkVUOgo+IMKgwqDCoMKgwqDCoMKgIHNpemUgPSBzaXplb2Yoc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnKTsKPiDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoGNhc2Ug
VklSVElPX0lEX0JMT0NLOgo+IMKgwqDCoMKgwqDCoMKgIHNpemUgPSBzaXplb2Yoc3RydWN0IHZp
cnRpb19ibGtfY29uZmlnKTsKPiDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiDCoMKgwqDCoGRlZmF1
bHQ6Cj4gwqDCoMKgwqDCoMKgwqAgLyogb3IgV0FSTigxLCAiIikgaWYgZGV2X3dhcm4oKSBub3Qg
YXBwbHkgKi8KPiDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybiguLi4gLCAidmlydGlvIElEIFsweCV4
XSBub3Qgc3VwcG9ydGVkXG4iKQo+IMKgwqDCoMKgwqDCoMKgIHNpemUgPSAwOwo+Cj4gwqDCoMKg
wqB9Cj4KPiBUaGFua3MsCj4gU3RlZmFubwphZ3JlZSwgd2lsbCBhZGQgdGhpcyBpbiBWMgoKVGhh
bmtzCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+
IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
