Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B0C43460
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 05:56:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B9961418
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 05:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B9961418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 814EE40F9F;
	Thu, 15 Apr 2021 05:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqjTANXIb9Ki; Thu, 15 Apr 2021 05:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCB1F40F81;
	Thu, 15 Apr 2021 05:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAF9DC000B;
	Thu, 15 Apr 2021 05:56:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E73BC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74A8640F9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J9bG3C60i0dm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:55:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AAC440F81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 05:55:59 +0000 (UTC)
IronPort-SDR: zorcAcGgjnLf5nk/pWwtoJwHqHTg9QkWvDWanz3OIPvT7D6PRAGTL6LSQEa6BE0mD4ZW8nep1z
 yVSLqPcXhP1A==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174898121"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="174898121"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 22:55:58 -0700
IronPort-SDR: cupJIMBQBcEDdz4unJTmXundCH3xLbBbjyxeTiXtI0cMSCP0hiMQChYi/IeWnTMzi8uKBrO4wB
 18ECuXEGsY4A==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418622476"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 22:55:56 -0700
Subject: Re: [PATCH 2/3] vDPA/ifcvf: enable Intel C5000X-PL virtio-block for
 vDPA
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-3-lingshan.zhu@intel.com>
 <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <1a1f9f50-dc92-ced3-759d-e600abca3138@linux.intel.com>
Date: Thu, 15 Apr 2021 13:55:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <54839b05-78d2-8edf-317c-372f0ecda024@redhat.com>
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

CgpPbiA0LzE1LzIwMjEgMTE6MzQgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiDlnKggMjAyMS80
LzE0IOS4i+WNiDU6MTgsIFpodSBMaW5nc2hhbiDlhpnpgZM6Cj4+IFRoaXMgY29tbWl0IGVuYWJs
ZWQgSW50ZWwgRlBHQSBTbWFydE5JQyBDNTAwMFgtUEwgdmlydGlvLWJsb2NrCj4+IGZvciB2RFBB
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5j
b20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgMTcgKysr
KysrKysrKysrKysrKy0KPj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDEw
ICsrKysrKysrKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuaCAKPj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+IGluZGV4IDFjMDRj
ZDI1NmZhNy4uOGI0MDM1MjJiZjA2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4g
QEAgLTE1LDYgKzE1LDcgQEAKPj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BjaV9yZWdzLmg+Cj4+IMKg
ICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4+IMKgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRp
b19uZXQuaD4KPj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19ibGsuaD4KPj4gwqAgI2lu
Y2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+PiDCoCAjaW5jbHVkZSA8dWFwaS9s
aW51eC92aXJ0aW9fcGNpLmg+Cj4+IMKgIEBAIC0yOCw3ICsyOSwxMiBAQAo+PiDCoCAjZGVmaW5l
IEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lEwqDCoMKgIDB4ODA4Ngo+PiDCoCAjZGVmaW5lIEM1
MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEwqDCoMKgIDB4MDAwMQo+PiDCoCAtI2RlZmluZSBJRkNW
Rl9TVVBQT1JURURfRkVBVFVSRVMgXAo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1ZFTkRPUl9J
RMKgwqDCoMKgwqDCoMKgIDB4MUFGNAo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX0RFVklDRV9J
RMKgwqDCoMKgwqDCoMKgIDB4MTAwMQo+PiArI2RlZmluZSBDNTAwMFhfUExfQkxLX1NVQlNZU19W
RU5ET1JfSUTCoMKgwqAgMHg4MDg2Cj4+ICsjZGVmaW5lIEM1MDAwWF9QTF9CTEtfU1VCU1lTX0RF
VklDRV9JRMKgwqDCoCAweDAwMDIKPj4gKwo+PiArI2RlZmluZSBJRkNWRl9ORVRfU1VQUE9SVEVE
X0ZFQVRVUkVTIFwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgICgoMVVMTCA8PCBWSVJUSU9fTkVUX0Zf
TUFDKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgx
VUxMIDw8IFZJUlRJT19GX0FOWV9MQVlPVVQpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IFwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgVklSVElPX0ZfVkVSU0lPTl8xKcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCBcCj4+IEBAIC0zNyw2ICs0MywxNSBAQAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pwqDCoMKgwqDCoMKgwqAg
fCBcCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19ORVRfRl9NUkdfUlhC
VUYpKQo+PiDCoCArI2RlZmluZSBJRkNWRl9CTEtfU1VQUE9SVEVEX0ZFQVRVUkVTIFwKPj4gK8Kg
wqDCoMKgwqDCoMKgICgoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfU0laRV9NQVgpwqDCoMKgwqDCoMKg
wqAgfCBcCj4+ICvCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19CTEtfRl9TRUdfTUFY
KcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+ICvCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8
IFZJUlRJT19CTEtfRl9CTEtfU0laRSnCoMKgwqDCoMKgwqDCoCB8IFwKPj4gK8KgwqDCoMKgwqDC
oMKgwqAgKDFVTEwgPDwgVklSVElPX0JMS19GX1RPUE9MT0dZKcKgwqDCoMKgwqDCoMKgIHwgXAo+
PiArwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfTVEpwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IFwKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgVklSVElPX0ZfVkVS
U0lPTl8xKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCBcCj4+ICvCoMKgwqDCoMKgwqDCoMKgICgx
VUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpCj4KPgo+IEkgdGhpbmsgd2UndmUgZGlz
Y3Vzc2VkIHRoaXMgc29tZXRpbWUgaW4gdGhlIHBhc3QgYnV0IHdoYXQncyB0aGUgCj4gcmVhc29u
IGZvciBzdWNoIHdoaXRlbGlzdCBjb25zaWRlciB0aGVyZSdzIGFscmVhZHkgYSBnZXRfZmVhdHVy
ZXMoKSAKPiBpbXBsZW1lbnRpb24/Cj4KPiBFLmcgQW55IHJlYXNvbiB0byBibG9jayBWSVJUSU9f
QkxLX0ZfV1JJVEVfWkVST1Mgb3IgVklSVElPX0ZfUklOR19QQUNLRUQ/Cj4KPiBUaGFua3MKVGhl
IHJlYXNvbiBpcyBzb21lIGZlYXR1cmUgYml0cyBhcmUgc3VwcG9ydGVkIGluIHRoZSBkZXZpY2Ug
YnV0IG5vdCAKc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIsIGUuZywgZm9yIHZpcnRpby1uZXQsIG1x
ICYgY3EgaW1wbGVtZW50YXRpb24gaXMgCm5vdCByZWFkeSBpbiB0aGUgZHJpdmVyLgoKVGhhbmtz
IQoKPgo+Cj4+ICsKPj4gwqAgLyogT25seSBvbmUgcXVldWUgcGFpciBmb3Igbm93LiAqLwo+PiDC
oCAjZGVmaW5lIElGQ1ZGX01BWF9RVUVVRV9QQUlSU8KgwqDCoCAxCj4+IMKgIGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIAo+PiBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPj4gaW5kZXggOTliMGE2YjRjMjI3Li45YjZhMzhiNzk4ZmEgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gKysrIGIvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBAQCAtMTcxLDcgKzE3MSwxMSBAQCBzdGF0aWMg
dTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4gdmRwYV9kZXZpY2UgKnZkcGFf
ZGV2KQo+PiDCoMKgwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPj4gwqDCoMKgwqDCoCB1NjQgZmVhdHVyZXM7Cj4+IMKgIC3CoMKgwqAgZmVhdHVyZXMg
PSBpZmN2Zl9nZXRfZmVhdHVyZXModmYpICYgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTOwo+PiAr
wqDCoMKgIGlmICh2Zi0+ZGV2X3R5cGUgPT0gVklSVElPX0lEX05FVCkKPj4gK8KgwqDCoMKgwqDC
oMKgIGZlYXR1cmVzID0gaWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKSAmIAo+PiBJRkNWRl9ORVRfU1VQ
UE9SVEVEX0ZFQVRVUkVTOwo+PiArCj4+ICvCoMKgwqAgaWYgKHZmLT5kZXZfdHlwZSA9PSBWSVJU
SU9fSURfQkxPQ0spCj4+ICvCoMKgwqDCoMKgwqDCoCBmZWF0dXJlcyA9IGlmY3ZmX2dldF9mZWF0
dXJlcyh2ZikgJiAKPj4gSUZDVkZfQkxLX1NVUFBPUlRFRF9GRUFUVVJFUzsKPj4gwqAgwqDCoMKg
wqDCoCByZXR1cm4gZmVhdHVyZXM7Cj4+IMKgIH0KPj4gQEAgLTUwOSw2ICs1MTMsMTAgQEAgc3Rh
dGljIHN0cnVjdCBwY2lfZGV2aWNlX2lkIGlmY3ZmX3BjaV9pZHNbXSA9IHsKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBDNTAwMFhfUExfREVWSUNFX0lELAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9TVUJTWVNfVkVORE9SX0lELAo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9TVUJTWVNfREVWSUNFX0lEKSB9LAo+PiArwqDC
oMKgIHsgUENJX0RFVklDRV9TVUIoQzUwMDBYX1BMX0JMS19WRU5ET1JfSUQsCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgQzUwMDBYX1BMX0JMS19ERVZJQ0VfSUQsCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQzUwMDBYX1BMX0JMS19TVUJTWVNfVkVORE9SX0lELAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEM1MDAwWF9QTF9CTEtfU1VCU1lTX0RFVklDRV9JRCkgfSwKPj4g
wqAgwqDCoMKgwqDCoCB7IDAgfSwKPj4gwqAgfTsKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
