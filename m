Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B3C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:41:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB656113D
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB656113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A04A6846CD;
	Thu, 15 Apr 2021 06:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mAWFsdeBVDlt; Thu, 15 Apr 2021 06:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41C00846CC;
	Thu, 15 Apr 2021 06:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B89AC000C;
	Thu, 15 Apr 2021 06:41:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD481C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAAEE40FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ynZjdl9zFjuh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:41:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9ED540FAA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:41:48 +0000 (UTC)
IronPort-SDR: 1P3x89e1c7CA5uX4/nmoRJROfwzbadLj2adjLcUitmrvgWr5s0SgjFgwh7DmJJsWv/hb/Uy2/T
 oJAGFpPYnwTw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174902060"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="174902060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:41:45 -0700
IronPort-SDR: NmglVgA4Adr2QDeg3s4xO+XgQmaUvm1Hw97Vg3b5rW2Gfc7EWPrje5ylCe4jjs43IrZV3lOYMU
 D+87RHKml5WA==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418635470"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:41:43 -0700
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
 <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
 <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
 <c90a923f-7c8d-9a32-ce14-2370f85f1ba4@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <10700088-3358-739b-5770-612ab761598c@linux.intel.com>
Date: Thu, 15 Apr 2021 14:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c90a923f-7c8d-9a32-ce14-2370f85f1ba4@redhat.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CgpPbiA0LzE1LzIwMjEgMjozMSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIxLzQv
MTUg5LiL5Y2IMTo1NSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4KPj4KPj4gT24gNC8xNS8yMDIx
IDExOjM0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IOWcqCAyMDIxLzQvMTQg5LiL5Y2I
NToxOCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+PiBUaGlzIGNvbW1pdCBlbmFibGVkIEludGVs
IEZQR0EgU21hcnROSUMgQzUwMDBYLVBMIHZpcnRpby1ibG9jawo+Pj4+IGZvciB2RFBBLgo+Pj4+
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
Pgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAxNyAr
KysrKysrKysrKysrKysrLQo+Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
fCAxMCArKysrKysrKystCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmggCj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+
Pj4gaW5kZXggMWMwNGNkMjU2ZmE3Li44YjQwMzUyMmJmMDYgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmgKPj4+PiBAQCAtMTUsNiArMTUsNyBAQAo+Pj4+IMKgICNpbmNsdWRlIDxs
aW51eC9wY2lfcmVncy5oPgo+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4+Pj4gwqAg
I2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX25ldC5oPgo+Pj4+ICsjaW5jbHVkZSA8dWFwaS9s
aW51eC92aXJ0aW9fYmxrLmg+Cj4+Pj4gwqAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Nv
bmZpZy5oPgo+Pj4+IMKgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19wY2kuaD4KPj4+PiDC
oCBAQCAtMjgsNyArMjksMTIgQEAKPj4+PiDCoCAjZGVmaW5lIEM1MDAwWF9QTF9TVUJTWVNfVkVO
RE9SX0lEwqDCoMKgIDB4ODA4Ngo+Pj4+IMKgICNkZWZpbmUgQzUwMDBYX1BMX1NVQlNZU19ERVZJ
Q0VfSUTCoMKgwqAgMHgwMDAxCj4+Pj4gwqAgLSNkZWZpbmUgSUZDVkZfU1VQUE9SVEVEX0ZFQVRV
UkVTIFwKPj4+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1ZFTkRPUl9JRMKgwqDCoMKgwqDCoMKg
IDB4MUFGNAo+Pj4+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfREVWSUNFX0lEwqDCoMKgwqDCoMKg
wqAgMHgxMDAxCj4+Pj4gKyNkZWZpbmUgQzUwMDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lEwqDC
oMKgIDB4ODA4Ngo+Pj4+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfU1VCU1lTX0RFVklDRV9JRMKg
wqDCoCAweDAwMDIKPj4+PiArCj4+Pj4gKyNkZWZpbmUgSUZDVkZfTkVUX1NVUFBPUlRFRF9GRUFU
VVJFUyBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICgoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfTUFD
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFV
TEwgPDwgVklSVElPX0ZfQU5ZX0xBWU9VVCkgfCBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+
Pj4gQEAgLTM3LDYgKzQzLDE1IEBACj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwg
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSB8IFwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAo
MVVMTCA8PCBWSVJUSU9fTkVUX0ZfTVJHX1JYQlVGKSkKPj4+PiDCoCArI2RlZmluZSBJRkNWRl9C
TEtfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPj4+PiArwqDCoMKgwqDCoMKgwqAgKCgxVUxMIDw8IFZJ
UlRJT19CTEtfRl9TSVpFX01BWCnCoMKgwqDCoMKgwqDCoCB8IFwKPj4+PiArwqDCoMKgwqDCoMKg
wqDCoCAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0VHX01BWCkgfCBcCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqAgKDFVTEwgPDwgVklSVElPX0JMS19GX0JMS19TSVpFKcKgwqDCoMKgwqDCoMKgIHwgXAo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19CTEtfRl9UT1BPTE9HWSnCoMKg
wqDCoMKgwqDCoCB8IFwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fQkxL
X0ZfTVEpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFwKPj4+PiArwqDCoMKgwqDCoMKgwqDCoCAo
MVVMTCA8PCBWSVJUSU9fRl9WRVJTSU9OXzEpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFwKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKQo+
Pj4KPj4+Cj4+PiBJIHRoaW5rIHdlJ3ZlIGRpc2N1c3NlZCB0aGlzIHNvbWV0aW1lIGluIHRoZSBw
YXN0IGJ1dCB3aGF0J3MgdGhlIAo+Pj4gcmVhc29uIGZvciBzdWNoIHdoaXRlbGlzdCBjb25zaWRl
ciB0aGVyZSdzIGFscmVhZHkgYSBnZXRfZmVhdHVyZXMoKSAKPj4+IGltcGxlbWVudGlvbj8KPj4+
Cj4+PiBFLmcgQW55IHJlYXNvbiB0byBibG9jayBWSVJUSU9fQkxLX0ZfV1JJVEVfWkVST1Mgb3Ig
Cj4+PiBWSVJUSU9fRl9SSU5HX1BBQ0tFRD8KPj4+Cj4+PiBUaGFua3MKPj4gVGhlIHJlYXNvbiBp
cyBzb21lIGZlYXR1cmUgYml0cyBhcmUgc3VwcG9ydGVkIGluIHRoZSBkZXZpY2UgYnV0IG5vdCAK
Pj4gc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIsIGUuZywgZm9yIHZpcnRpby1uZXQsIG1xICYgY3Eg
aW1wbGVtZW50YXRpb24gCj4+IGlzIG5vdCByZWFkeSBpbiB0aGUgZHJpdmVyLgo+Cj4KPiBJIHVu
ZGVyc3RhbmQgdGhlIGNhc2Ugb2YgdmlydGlvLW5ldCBidXQgSSB3b25kZXIgd2h5IHdlIG5lZWQg
dGhpcyBmb3IgCj4gYmxvY2sgd2hlcmUgd2UgZG9uJ3QgdnEgY3ZxLgo+Cj4gVGhhbmtzClRoaXMg
aXMgc3RpbGwgYSBzdWJzZXQgb2YgdGhlIGZlYXR1cmUgYml0cyByZWFkIGZyb20gaGFyZHdhcmUs
IEkgbGVhdmUgCml0IGhlcmUgdG8gY29kZSBjb25zaXN0ZW50bHksIGFuZCBpbmRpY2F0ZSB3aGF0
IHdlIHN1cHBvcnQgY2xlYXJseS4KQXJlIHlvdSBzdWdnZXN0aW5nIHJlbW92ZSB0aGlzIGZlYXR1
cmUgYml0cyBsaXN0IGFuZCBqdXN0IHVzZSB3aGF0IHdlIApyZWFkIGZyb20gaGFyZHdhcmU/CgpU
aGFuc2sKPgo+Cj4+Cj4+IFRoYW5rcyEKPj4KPj4+Cj4+Pgo+Pj4+ICsKPj4+PiDCoCAvKiBPbmx5
IG9uZSBxdWV1ZSBwYWlyIGZvciBub3cuICovCj4+Pj4gwqAgI2RlZmluZSBJRkNWRl9NQVhfUVVF
VUVfUEFJUlPCoMKgwqAgMQo+Pj4+IMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jIAo+Pj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+
IGluZGV4IDk5YjBhNmI0YzIyNy4uOWI2YTM4Yjc5OGZhIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4+Pj4gQEAgLTE3MSw3ICsxNzEsMTEgQEAgc3RhdGljIHU2NCBpZmN2Zl92
ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgCj4+Pj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+Pj4+
IMKgwqDCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+
Pj4+IMKgwqDCoMKgwqAgdTY0IGZlYXR1cmVzOwo+Pj4+IMKgIC3CoMKgwqAgZmVhdHVyZXMgPSBp
ZmN2Zl9nZXRfZmVhdHVyZXModmYpICYgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+Pj4+ICvC
oMKgwqAgaWYgKHZmLT5kZXZfdHlwZSA9PSBWSVJUSU9fSURfTkVUKQo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBmZWF0dXJlcyA9IGlmY3ZmX2dldF9mZWF0dXJlcyh2ZikgJiAKPj4+PiBJRkNWRl9ORVRf
U1VQUE9SVEVEX0ZFQVRVUkVTOwo+Pj4+ICsKPj4+PiArwqDCoMKgIGlmICh2Zi0+ZGV2X3R5cGUg
PT0gVklSVElPX0lEX0JMT0NLKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBmZWF0dXJlcyA9IGlmY3Zm
X2dldF9mZWF0dXJlcyh2ZikgJiAKPj4+PiBJRkNWRl9CTEtfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+
Pj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIGZlYXR1cmVzOwo+Pj4+IMKgIH0KPj4+PiBAQCAtNTA5
LDYgKzUxMywxMCBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXZpY2VfaWQgaWZjdmZfcGNpX2lkc1td
ID0gewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQzUwMDBYX1BMX0RFVklDRV9J
RCwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9TVUJTWVNfVkVO
RE9SX0lELAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQzUwMDBYX1BMX1NVQlNZ
U19ERVZJQ0VfSUQpIH0sCj4+Pj4gK8KgwqDCoCB7IFBDSV9ERVZJQ0VfU1VCKEM1MDAwWF9QTF9C
TEtfVkVORE9SX0lELAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQzUwMDBYX1BMX0JM
S19ERVZJQ0VfSUQsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhfUExfQkxL
X1NVQlNZU19WRU5ET1JfSUQsCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhf
UExfQkxLX1NVQlNZU19ERVZJQ0VfSUQpIH0sCj4+Pj4gwqAgwqDCoMKgwqDCoCB7IDAgfSwKPj4+
PiDCoCB9Owo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
