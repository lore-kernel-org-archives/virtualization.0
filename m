Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E93AC433ED
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:43:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B236101B
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B236101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC0440194;
	Fri, 16 Apr 2021 02:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUU8mjSIdWsU; Fri, 16 Apr 2021 02:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D6C540E5E;
	Fri, 16 Apr 2021 02:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2FB7C000C;
	Fri, 16 Apr 2021 02:43:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2DDAC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE65C60DB7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OUij7JZp2cMv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:43:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A139C60DB3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:43:43 +0000 (UTC)
IronPort-SDR: h37NsS8hT371IhF4gZvZ18t91WJuz/hOsydrWDF+MTmau4X2fxB0BP7N32AAFM/PZCLdGXYzVY
 aFTk8ZTOVesQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="195007158"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="195007158"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:43:41 -0700
IronPort-SDR: 6GxEtXwgEAtpkepcSiuf1DxP30dHWpucxPN9l9actHwMAx6xuF7bzbP6NBM3SE61sW2hLHjwcr
 cxbAVprL5Hqw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; d="scan'208";a="418971669"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.208.190])
 ([10.254.208.190])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:43:39 -0700
Subject: Re: [PATCH V2 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block
 for vDPA
To: Stefano Garzarella <sgarzare@redhat.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210415095336.4792-1-lingshan.zhu@intel.com>
 <20210415095336.4792-3-lingshan.zhu@intel.com>
 <20210415134148.q53glknhktbjwtzz@steredhat>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <27f143ba-72dc-9bcb-c537-277bb382996d@linux.intel.com>
Date: Fri, 16 Apr 2021 10:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210415134148.q53glknhktbjwtzz@steredhat>
Content-Language: en-US
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CgpPbiA0LzE1LzIwMjEgOTo0MSBQTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9uIFRo
dSwgQXByIDE1LCAyMDIxIGF0IDA1OjUzOjM1UE0gKzA4MDAsIFpodSBMaW5nc2hhbiB3cm90ZToK
Pj4gVGhpcyBjb21taXQgZW5hYmxlZCBJbnRlbCBGUEdBIFNtYXJ0TklDIEM1MDAwWC1QTCB2aXJ0
aW8tYmxvY2sKPj4gZm9yIHZEUEEuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+IGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmggfMKgIDggKysrKysrKy0KPj4gZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
YyB8IDEwICsrKysrKysrKy0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaCAKPj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+IGluZGV4IDFj
MDRjZDI1NmZhNy4uMDExMWJmZGViMzQyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgK
Pj4gQEAgLTE1LDYgKzE1LDcgQEAKPj4gI2luY2x1ZGUgPGxpbnV4L3BjaV9yZWdzLmg+Cj4+ICNp
bmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4+ICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19uZXQu
aD4KPj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19ibGsuaD4KPj4gI2luY2x1ZGUgPHVh
cGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+PiAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9f
cGNpLmg+Cj4+Cj4+IEBAIC0yOCw3ICsyOSwxMiBAQAo+PiAjZGVmaW5lIEM1MDAwWF9QTF9TVUJT
WVNfVkVORE9SX0lEwqDCoMKgIDB4ODA4Ngo+PiAjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfREVW
SUNFX0lEwqDCoMKgIDB4MDAwMQo+Pgo+PiAtI2RlZmluZSBJRkNWRl9TVVBQT1JURURfRkVBVFVS
RVMgXAo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKgIDB4
MUFGNAo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX0RFVklDRV9JRMKgwqDCoMKgwqDCoMKgIDB4
MTAwMQo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1NVQlNZU19WRU5ET1JfSUTCoMKgwqAgMHg4
MDg2Cj4+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfU1VCU1lTX0RFVklDRV9JRMKgwqDCoCAweDAw
MDIKPj4gKwo+PiArI2RlZmluZSBJRkNWRl9ORVRfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPj4gwqDC
oMKgwqDCoMKgwqAgKCgxVUxMIDw8IFZJUlRJT19ORVRfRl9NQUMpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IFwKPj4gwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fRl9BTllfTEFZT1VU
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+IMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwg
VklSVElPX0ZfVkVSU0lPTl8xKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+PiBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPj4gaW5kZXggNDY5YTliNTczN2I3Li5jZWExMzEzYjFhM2YgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gKysrIGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBAQCAtMTcxLDcgKzE3MSwxMSBAQCBzdGF0
aWMgdTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4gdmRwYV9kZXZpY2UgKnZk
cGFfZGV2KQo+PiDCoMKgwqDCoHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPj4gwqDCoMKgwqB1NjQgZmVhdHVyZXM7Cj4+Cj4+IC3CoMKgwqAgZmVhdHVyZXMgPSBp
ZmN2Zl9nZXRfZmVhdHVyZXModmYpICYgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+PiArwqDC
oMKgIGlmICh2Zi0+ZGV2X3R5cGUgPT0gVklSVElPX0lEX05FVCkKPj4gK8KgwqDCoMKgwqDCoMKg
IGZlYXR1cmVzID0gaWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKSAmIAo+PiBJRkNWRl9ORVRfU1VQUE9S
VEVEX0ZFQVRVUkVTOwo+PiArCj4+ICvCoMKgwqAgaWYgKHZmLT5kZXZfdHlwZSA9PSBWSVJUSU9f
SURfQkxPQ0spCj4+ICvCoMKgwqDCoMKgwqDCoCBmZWF0dXJlcyA9IGlmY3ZmX2dldF9mZWF0dXJl
cyh2Zik7Cj4+Cj4KPiBTaG91bGQgd2UgcHV0IGEgd2FybmluZyBoZXJlIHRvbyBvdGhlcndpc2Ug
ZmVhdHVyZSBjb3VsZCBiZSBzZWVuIAo+IHVuYXNzaWduZWQ/ClRoYW5rcywgaXQgd2lsbCBiZSBh
IHN3aXRjaCBjb2RlIGJsb2NrIHRvby4KPgo+IFRoYW5rcywKPiBTdGVmYW5vCj4KPj4gwqDCoMKg
wqByZXR1cm4gZmVhdHVyZXM7Cj4+IH0KPj4gQEAgLTUxNyw2ICs1MjEsMTAgQEAgc3RhdGljIHN0
cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9IHsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEM1MDAwWF9QTF9ERVZJQ0VfSUQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBDNTAwMFhfUExfU1VCU1lTX1ZFTkRPUl9JRCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+PiArwqDCoMKgIHsgUENJX0RFVklDRV9T
VUIoQzUwMDBYX1BMX0JMS19WRU5ET1JfSUQsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
QzUwMDBYX1BMX0JMS19ERVZJQ0VfSUQsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQzUw
MDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lELAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IEM1MDAwWF9QTF9CTEtfU1VCU1lTX0RFVklDRV9JRCkgfSwKPj4KPj4gwqDCoMKgwqB7IDAgfSwK
Pj4gfTsKPj4gLS0gCj4+IDIuMjcuMAo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
