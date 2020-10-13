Return-Path: <SRS0=ZRN8=DU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FD4C433E7
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 07:16:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881D320797
	for <virtualization@archiver.kernel.org>; Tue, 13 Oct 2020 07:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881D320797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1AF0E86D94;
	Tue, 13 Oct 2020 07:16:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIm8Rkogd-aN; Tue, 13 Oct 2020 07:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06A4D86DE0;
	Tue, 13 Oct 2020 07:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92AA5C07FF;
	Tue, 13 Oct 2020 07:16:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38C29C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3129F2E0F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5BCAh0hzlpel
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 63C0F27400
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 07:16:33 +0000 (UTC)
IronPort-SDR: 5knc+DEI/1WDS/yppveh/ftku9dLYEGN/HV+5QVXD0rEph0mJj2A4zlWwubgpGCteYTJAZWgJG
 KnE+zi7q636Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="227505099"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="227505099"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 00:16:31 -0700
IronPort-SDR: 42JeIXsUr+8A4OD+nNXjBXG2Dg7SlndDAQqMdJHZjN9IY1CUFYyYObicjdcuy0yzWiU4qbH5xw
 0MCNBm4kDSeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="346090084"
Received: from unknown (HELO [10.239.154.47]) ([10.239.154.47])
 by orsmga008.jf.intel.com with ESMTP; 13 Oct 2020 00:16:25 -0700
Subject: Re: [PATCH v3] i2c: virtio: add a virtio i2c frontend driver
To: Jason Wang <jasowang@redhat.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1350309657ab0c7b9f97e7a5c71d084f88caa549.1600743079.git.jie.deng@intel.com>
 <958b69c3-0321-d5cb-4c12-702795925583@redhat.com>
 <2dc4bd12-9f23-7caa-b1ec-f3403d36e065@intel.com>
 <83529dac-7b87-aec9-55f0-85face47e7b6@redhat.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b1cad8f9-67c4-dbb7-6edc-66be2f6ba08f@intel.com>
Date: Tue, 13 Oct 2020 15:16:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <83529dac-7b87-aec9-55f0-85face47e7b6@redhat.com>
Content-Language: en-US
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

Ck9uIDIwMjAvMTAvMTIgMTE6NDMsIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiAyMDIwLzEwLzEy
IOS4iuWNiDEwOjQ1LCBKaWUgRGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMC8xMC8xMCAxMTox
NCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2aXJ0
cXVldWVfa2ljayh2cSk7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB0aW1lX2xlZnQgPSB3
YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnZpLT5jb21wbGV0aW9uLCAKPj4+PiBhZGFwLT50
aW1lb3V0KTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCF0aW1lX2xlZnQpIHsKPj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKCZhZGFwLT5kZXYsICJtc2dbJWRdOiBhZGRyPTB4
JXggdGltZW91dC5cbiIsIAo+Pj4+IGksIG1zZ3NbaV0uYWRkcik7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4+Cj4+Pgo+Pj4gWW91
IGRvbid0IHNldCBlcnJvciBudW1iZXIgaGVyZS4gSXMgdGhpcyBpbnRlbmRlZD8KPj4+Cj4+PiBB
bmQgdXNpbmcgYSB0aW1lb3V0IGhlcmUgaXMgbm90IGdvb2QsIGFuZCBpZiB0aGUgcmVxdWVzdCBp
cyBmaW5pc2hlZCAKPj4+IGp1c3QgYWZ0ZXIgdGhlIHRpbWVvdXQsIGluIHRoZSBuZXh0IHhmZXIg
eW91IG1heSBoaXQgdGhlIGZvbGxvd2luZyAKPj4+IGNoZWNrLgo+Pj4KPj4+IEl0J3MgYmV0dGVy
IHRvIHVzZSBlaXRoZXIgaW50ZXJydXB0IGhlcmUuCj4+Pgo+PiBDb3VsZCB5b3UgY2hlY2sgdGhl
IEkyQyBkcml2ZXJzIGluIHRoZSBrZXJuZWwgPyBUaGUgCj4+ICJ3YWl0X2Zvcl9jb21wbGV0aW9u
X3RpbWVvdXQiIG1lY2hhbmlzbQo+PiBpcyBjb21tb25seSB1c2VkIGJ5IEkyQyBidXMgZHJpdmVy
cyBpbiB0aGVpciBpMmNfYWxnb3JpdGhtLm1hc3Rlcl94ZmVyLgo+Cj4KPiBUaGVyZSdzIGEgbWFq
b3IgZGlmZmVyZW5jZSBiZXR3ZWVuIHZpcnRpby1pMmMgYW5kIG90aGVyIGRyaXZlcnMuIEluIAo+
IHRoZSBjYXNlIG9mIHZpcnRpbywgdGhlIGRldmljZSBjb3VsZCBiZSBhIHNvZnR3YXJlIGRldmlj
ZSBlbXVsYXRlZCBieSAKPiBhIHJlbW90ZSBwcm9jZXNzLiBUaGlzIG1lYW5zIHRoZSB0aW1lb3V0
IG1pZ2h0IG5vdCBiZSByYXJlLgo+Cj4gSSBkb24ndCBzZWUgaG93IHRpbWVvdXQgaXMgcHJvcGVy
bHkgaGFuZGxlZCBpbiB0aGlzIHBhdGNoIChlLmcgZGlkIHlvdSAKPiBub3RpY2UgdGhhdCB5b3Ug
ZG9uJ3Qgc2V0IGFueSBlcnJvciB3aGVuIHRpbWVvdXQ/IG9yIGlzIHRoaXMgaW50ZW5kZWQ/KQo+
ClRoZSBiYWNrZW5kIHNvZnR3YXJlIG1heSBvcGVyYXRlIHRoZSBwaHlzaWNhbCBkZXZpY2UuIFRo
ZSB0aW1lb3V0IApkZXBlbmRzIG9uIGhvdyB0aGUgYmFja2VuZCBpcyBkZXNpZ25lZC4KSGVyZSBp
ZiB0aGUgdGltZW91dCBoYXBwZW5zLCBpdCB3aWxsIHJldHVybiB0aGUgYWN0dWFsIG51bWJlciBv
ZiAKbWVzc2FnZXMgc3VjY2Vzc2Z1bGx5IHByb2Nlc3NlZCB0byB0aGUgSTJDIGNvcmUuCkxldCB0
aGUgSTJDIGNvcmUgZGVjaWRlcyBob3cgdG8gZG8gbmV4dC4KClRoYW5rcy4KCj4KPj4KPj4+Cj4+
Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2bXNnID0gKHN0cnVjdCB2aXJ0aW9faTJjX21zZyAq
KXZpcnRxdWV1ZV9nZXRfYnVmKHZxLCAmbGVuKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgLyogdm1z
ZyBzaG91bGQgcG9pbnQgdG8gdGhlIHNhbWUgYWRkcmVzcyB3aXRoICZ2aS0+dm1zZyAqLwo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoKCF2bXNnKSB8fCAodm1zZyAhPSAmdmktPnZtc2cpKSB7Cj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2VycigmYWRhcC0+ZGV2LCAibXNnWyVkXTog
YWRkcj0weCV4IHZpcnRxdWV1ZSAKPj4+PiBlcnJvci5cbiIsCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpLCBtc2dzW2ldLmFkZHIpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJyZWFrOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+Pgo+Pj4KPj4+IFNvIEkgdGhp
bmsgd2UgY2FuIHJlbW92ZSB0aGlzIGNoZWNrLiBDb25zaWRlciBvbmx5IG9uZSBkZXNjcmlwdG9y
IAo+Pj4gd2lsbCBiZSB1c2VkIGF0IG1vc3QsIHVubGVzcyB0aGVyZSdzIGEgYnVnIGluIHRoZSBk
ZXZpY2UgKGFuZCBubyAKPj4+IG90aGVyIGRyaXZlciB0byB0aGUgc2ltaWxhciBjaGVjayksIHdl
IHNob3VsZCBub3QgaGl0IHRoaXMuCj4+Pgo+Pj4gQnR3LCBhcyBJIHJlcGxpZWQgaW4gdGhlIHBy
ZXZpb3VzIHZlcnNpb24sIHRoZSBkZXZpY2Ugc2hvdWxkIGJlIAo+Pj4gY2FjcGFibGUgb2YgZGVh
bGluZyBvZiBhIGJhdGNoIG9mIHJlcXVlc3RzIHRocm91Z2ggdGhlIHZpcnRxdWV1ZSwgCj4+PiBv
dGhlcndpc2UgaXQncyBtZWFuaW5nbGVzcyB0byB1c2UgYSBxdWV1ZSBoZXJlLgo+Pj4KPj4gV2Ug
c2hvdWxkIG5vdCBhc3N1bWUgdGhlcmUgaXMgbm8gYnVnIGluIHRoZSBkZXZpY2UuIEkgZG9uJ3Qg
dGhpbmsgd2UgCj4+IGNhbiByZW1vdmUgdGhpcyBjaGVjayBpZiB3ZSB3YW50IG91ciBjb2RlIHRv
IGJlIHJvYnVzdC4KPgo+Cj4gQ2FuIHlvdSB0ZWxsIHdoZW4gYXQgd2hpY2ggY2FzZSB5b3UgbWF5
IGhpdCAhdm1zZyBvciB2bXNnICE9IHZpLT52bXNnPwo+Ck5vcm1hbGx5LCBpdCB3b24ndCBoaXQg
aGVyZS4gQnV0IHRoZSBBUEkgInZpcnRxdWV1ZV9nZXRfYnVmIiB0ZWxscyBtZQoiSXQgKm1heSAq
cmV0dXJuIE5VTEwgb3IgdGhlICJkYXRhIiB0b2tlbiBoYW5kZWQgdG8gdmlydHF1ZXVlX2FkZF8q
KCkuIgoKIEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIGEgY2FsbGVyLCBJIGp1c3QgZG9uJ3QgY2Fy
ZSB3aGVuIGl0IGhhcHBlbnMuClRvIG1ha2UgdGhlIGNvZGUgcm9idXN0LCB3aGF0IEkgY2FyZSBh
Ym91dCBpcyB3aGF0IEkgc2hvdWxkIGRvIGlmIHRoaXMgCmlzIG5vdCBvdXIgY2FzZQpzaW5jZSB0
aGUgZG9jIHNheXMgaXQqbWF5ICpoYXBwZW4uCgpJZiB5b3UgaW5zaXN0IG9uIHJlbW92aW5nIHRo
aXMgY2hlY2ssIEkgd2lsbCByZW1vdmUgInZtc2cgIT0gdmktPnZtc2ciIAphbmQga2VlcCB0aGUg
Y2hlY2sgZm9yICF2bXNnLgpBcyBEYW4gcmVwb3J0ZWQgaW4gdjIsIHdlIHNob3VsZCBhdCBsZWFz
dCBjaGVjayBoZXJlIGZvciBOVUxMLgoKVGhhbmtzLgoKPgo+Cj4+IEFzIEkgc2FpZCwgY3VycmVu
dGx5LCB3ZSBhcmUgdXNpbmcgdGhlIHZpcnRxdWV1ZSB0byBzZW5kIHRoZSBtc2cgb25lIAo+PiBi
eSBvbmUgdG8gdGhlIGJhY2tlbmQuIFRoZSBtZWNoYW5pc20gaXMgZGVzY3JpYmVkIGluIHRoZSBz
cGVjLiAKPgo+Cj4gV2hpY2ggcGFydCBvZiB0aGUgc3BlYyBkZXNjcmliZXMgc3VjaCAib25lIGJ5
IG9uZSIgbWVjaGFuaXNtPyBJZiB0aGVyZSAKPiBpcyBvbmUsIEknZCBoYXBwaWx5IGdpdmUgYSBO
QUNLIHNpbmNlIGl0IGRvZXNuJ3QgcmVxdWlyZSBhIHF1ZXVlIHRvIAo+IHdvcmsgd2hpY2ggaXMg
Y29uZmxpY3Qgd2l0aCB0aGUgY29uY2VwdCBvZiB0aGUgdmlydHF1ZXVlLgo+Cj4KV2hhdCdzIHRo
ZSBjb25jZXB0IG9mIHRoZSB2aXJ0cXVldWUgP8KgIFdoeSBkbyB5b3Ugd2FudCB0byByZXN0cmlj
dCBob3cgCnVzZXJzIHVzZSB2aXJ0cXVldWUgPwoKSXQncyBsaWtlIHlvdSBwcm92aWRlIGEgd2F0
ZXIgZ2xhc3MgdG8gdXNlci4gVGhlIHVzZXIgY2FuIGZpbGwgYSBmdWxsIApnbGFzcyBvZiB3YXRl
ciBhbmQgZHJpbmtzIG9uY2Ugb3IKZmlsbCBoYWxmIGEgZ2xhc3Mgb2Ygd2F0ZXIgYW5kIGRyaW5r
IHR3aWNlLiBJdCBpcyBhIHVzZXIgYmVoYXZpb3IgYW5kIApzaG91bGQgbm90IGJlIHJlc3RyaWN0
ZWQgYnkKdGhlIGdsYXNzIHByb3ZpZGVyLgoKVGhhbmtzLgoKCj4+IFRoYW5rcy4KPj4KPj4KPj4+
Cj4+Pj4gKwo+Pj4+Cj4+Pj4gKwo+Pj4+ICsjaWZuZGVmIF9VQVBJX0xJTlVYX1ZJUlRJT19JMkNf
SAo+Pj4+ICsjZGVmaW5lIF9VQVBJX0xJTlVYX1ZJUlRJT19JMkNfSAo+Pj4+ICsKPj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L3R5cGVzLmg+Cj4+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9faWRzLmg+
Cj4+Pj4gKyNpbmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4+Pj4gKwo+Pj4+ICsvKioK
Pj4+PiArICogc3RydWN0IHZpcnRpb19pMmNfaGRyIC0gdGhlIHZpcnRpbyBJMkMgbWVzc2FnZSBo
ZWFkZXIgc3RydWN0dXJlCj4+Pj4gKyAqIEBhZGRyOiBpMmNfbXNnIGFkZHIsIHRoZSBzbGF2ZSBh
ZGRyZXNzCj4+Pj4gKyAqIEBmbGFnczogaTJjX21zZyBmbGFncwo+Pj4+ICsgKiBAbGVuOiBpMmNf
bXNnIGxlbgo+Pj4+ICsgKi8KPj4+PiArc3RydWN0IHZpcnRpb19pMmNfaGRyIHsKPj4+PiArwqDC
oMKgIF9fbGUxNiBhZGRyOwo+Pj4+ICvCoMKgwqAgX19sZTE2IGZsYWdzOwo+Pj4+ICvCoMKgwqAg
X19sZTE2IGxlbjsKPj4+PiArfTsKPj4+Cj4+Pgo+Pj4gSSdtIGFmcmFpZCB0aGlzIGlzIG5vdCBj
b21wbGV0ZS4gRS5nIHRoZSBzdGF0dXMgaXMgbWlzc2VkLgo+Pj4KPj4+IEkgc3VzcGVjdCB3aGF0
IHZpcnRpby1zY3NpIHVzZSBpcyBiZXR0ZXIuIFdoaWNoIHNwbGl0IHRoZSBpbiBmcm9tIAo+Pj4g
dGhlIG91dCBpbnN0ZWFkIG9mIHJldXNpbmcgdGhlIHNhbWUgYnVmZmVyLiBBbmQgaXQgY2FuIGVh
c2UgdGhlIHVBUEkgCj4+PiBoZWFkZXIgZXhwb3J0Lgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+Cj4+
Cj4+IEkgdGhpbmsgZm9sbG93aW5nIGRlZmluaXRpb24gaW4gdUFQSSBmb3IgdGhlIHN0YXR1cyBp
cyBlbm91Z2guCj4+IFRoZXJlIGlzIG5vIG5lZWQgdG8gcHJvdmlkZSBhICJ1OCIgc3RhdHVzIGlu
IHRoZSBzdHJ1Y3R1cmUuCj4+Cj4+IC8qIFRoZSBmaW5hbCBzdGF0dXMgd3JpdHRlbiBieSB0aGUg
ZGV2aWNlICovCj4+ICNkZWZpbmUgVklSVElPX0kyQ19NU0dfT0vCoMKgwqAgMAo+PiAjZGVmaW5l
IFZJUlRJT19JMkNfTVNHX0VSUsKgwqDCoCAxCj4+Cj4+IFlvdSBjYW4gc2VlIGFuIGV4YW1wbGUg
aW4gdmlydGlvX2Jsay4KPj4KPj4gSW4gdGhlIHNwZWM6Cj4+Cj4+IHN0cnVjdCB2aXJ0aW9fYmxr
X3JlcSB7Cj4+IGxlMzIgdHlwZTsKPj4gbGUzMiByZXNlcnZlZDsKPj4gbGU2NCBzZWN0b3I7Cj4+
IHU4IGRhdGFbXTsKPj4gdTggc3RhdHVzOwo+PiB9Owo+Pgo+PiBJbiB2aXJ0aW9fYmxrLmgsIHRo
ZXJlIGlzIG9ubHkgZm9sbG93aW5nIGRlZmluaXRpb25zLgo+Pgo+PiAjZGVmaW5lIFZJUlRJT19C
TEtfU19PS8KgwqDCoCDCoMKgwqAgMAo+PiAjZGVmaW5lIFZJUlRJT19CTEtfU19JT0VSUsKgwqDC
oCAxCj4+ICNkZWZpbmUgVklSVElPX0JMS19TX1VOU1VQUMKgwqDCoCAyCj4+Cj4KPiB2aXJ0aW8t
YmxrIGlzIGEgYmFkIGV4YW1wbGUsIGl0J3MganVzdCB0b28gbGF0ZSB0byBmaXguIEZvciBhbnkg
bmV3IAo+IGludHJvZHVjZWQgdUFQSSBpdCBzaG91bGQgYmUgYSBjb21wbGV0ZSBvbmUuCj4KPiBU
aGFua3MKPgpJIGNoZWNrZWQgYSByZWxhdGl2ZWx5IG5ldyBkZXZpY2UgInZpcnRpb19mcyIuCkkg
Zm91bmQgZm9sbG93aW5nIGRlZmluaXRpb24gaW4gc3BlYyBidXQgbm90IGluIHVBUEkgYWxzby4K
CnN0cnVjdCB2aXJ0aW9fZnNfcmVxIHsKLy8gRGV2aWNlIC1yZWFkYWJsZSBwYXJ0CnN0cnVjdCBm
dXNlX2luX2hlYWRlciBpbjsKdTggZGF0YWluW107Ci8vIERldmljZSAtd3JpdGFibGUgcGFydApz
dHJ1Y3QgZnVzZV9vdXRfaGVhZGVyIG91dDsKdTggZGF0YW91dFtdOwp9OwoKU28gaXMgdGhpcyBh
bHNvIGEgYmFkIGV4YW1wbGUgd2hpY2ggaGFzIG5vdCBiZWVuIGZpeGVkIHlldC4KT3Igd2hhdCdz
IHlvdXIgbWVhbiBhYm91dCAiY29tcGxldGUiIGhlcmUgPyBJcyB0aGVyZSBhbnkgZGVmaW5pdGlv
biAKYWJvdXQgImNvbXBsZXRlIHVBUEkiID8KClRoYW5rcy4KCgo+Cj4+IFRoYW5rcy4KPj4KPj4K
Pj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
