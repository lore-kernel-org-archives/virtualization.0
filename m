Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90845C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D565F64FC4
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 04:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D565F64FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FFCD4300B;
	Thu, 11 Mar 2021 04:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4d8mJ2OLTib6; Thu, 11 Mar 2021 04:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E560400C3;
	Thu, 11 Mar 2021 04:16:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECBE1C000A;
	Thu, 11 Mar 2021 04:16:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E28C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA6864C51B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZmc-Y_ZS2cP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D74334BA7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 04:16:30 +0000 (UTC)
IronPort-SDR: Wfhnb+P3ApPwBbnmJLtzO/SdvxjDrK4WPrd3fjeBvvdS1qrGDFJO/TzeQfLS48YFd4BsxAwJjP
 DLfh9Fb27Deg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="175716437"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="175716437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:16:29 -0800
IronPort-SDR: BdrwlhMDlrN0/JTKh33VYUlZNtT8ch+GwWcC94g1RfHk0/ut4vkZ08Z/PEcXc+XqZ1d4y7z0gp
 1yGs3oxHkwMA==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; d="scan'208";a="410467022"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.249.170.224])
 ([10.249.170.224])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2021 20:16:27 -0800
Subject: Re: [PATCH V3 6/6] vDPA/ifcvf: verify mandatory feature bits for vDPA
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-7-lingshan.zhu@intel.com>
 <3e53a5c9-c531-48ee-c9a7-907dfdacc9d1@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <9c2fb3d0-2d69-20b9-589d-cc5ffc830f38@linux.intel.com>
Date: Thu, 11 Mar 2021 12:16:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3e53a5c9-c531-48ee-c9a7-907dfdacc9d1@redhat.com>
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

CgpPbiAzLzExLzIwMjEgMTE6MjAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiBPbiAyMDIxLzMv
MTAgNTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4gdkRQQSByZXF1cmVzIFZJUlRJ
T19GX0FDQ0VTU19QTEFURk9STSBhcyBhIG11c3QsIHRoaXMgY29tbWl0Cj4+IGV4YW1pbmVzIHRo
aXMgd2hlbiBzZXQgZmVhdHVyZXMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmMgfCA4ICsrKysrKysrCj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmggfCAxICsKPj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDUgKysr
KysKPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIAo+PiBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMKPj4gaW5kZXggZWE2YTc4NzkxYzliLi41OGY0N2ZkY2UzODUgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4gKysrIGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+PiBAQCAtMjI0LDYgKzIyNCwxNCBAQCB1NjQg
aWZjdmZfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+IMKgwqDCoMKgwqAgcmV0
dXJuIGh3LT5od19mZWF0dXJlczsKPj4gwqAgfQo+PiDCoCAraW50IGlmY3ZmX3ZlcmlmeV9taW5f
ZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpodykKPj4gK3sKPj4gK8KgwqDCoCBpZiAoIShody0+
aHdfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+PiArwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gMDsKPj4g
K30KPj4gKwo+PiDCoCB2b2lkIGlmY3ZmX3JlYWRfbmV0X2NvbmZpZyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3LCB1NjQgb2Zmc2V0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lk
ICpkc3QsIGludCBsZW5ndGgpCj4+IMKgIHsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmggCj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+
PiBpbmRleCBkYmI4YzEwYWEzYjEuLjkxYzU3MzVkNGRjOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5oCj4+IEBAIC0xMjMsNiArMTIzLDcgQEAgdm9pZCBpb193cml0ZTY0X3R3b3BhcnQo
dTY0IHZhbCwgdTMyICpsbywgdTMyICpoaSk7Cj4+IMKgIHZvaWQgaWZjdmZfcmVzZXQoc3RydWN0
IGlmY3ZmX2h3ICpodyk7Cj4+IMKgIHU2NCBpZmN2Zl9nZXRfZmVhdHVyZXMoc3RydWN0IGlmY3Zm
X2h3ICpodyk7Cj4+IMKgIHU2NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3
ICpodyk7Cj4+ICtpbnQgaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KTsKPj4gwqAgdTE2IGlmY3ZmX2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1
MTYgcWlkKTsKPj4gwqAgaW50IGlmY3ZmX3NldF92cV9zdGF0ZShzdHJ1Y3QgaWZjdmZfaHcgKmh3
LCB1MTYgcWlkLCB1MTYgbnVtKTsKPj4gwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZmX3RvX2Fk
YXB0ZXIoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfbWFpbi5jIAo+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
Pj4gaW5kZXggMjVmYjlkZmUyM2YwLi5mNjI0ZjIwMjQ0N2QgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYwo+PiBAQCAtMTc5LDYgKzE3OSwxMSBAQCBzdGF0aWMgdTY0IGlmY3ZmX3ZkcGFf
Z2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+PiDCoCBzdGF0
aWMgaW50IGlmY3ZmX3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYsIAo+PiB1NjQgZmVhdHVyZXMpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaWZjdmZf
aHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4+ICvCoMKgwqAgaW50IHJldDsKPj4gKwo+
PiArwqDCoMKgIHJldCA9IGlmY3ZmX3ZlcmlmeV9taW5fZmVhdHVyZXModmYpOwo+Cj4KPiBTbyB0
aGlzIHZhbGlkYXRlIGRldmljZSBmZWF0dXJlcyBpbnN0ZWFkIG9mIGRyaXZlciB3aGljaCBpcyB0
aGUgb25lIHdlIAo+IHJlYWxseSB3YW50IHRvIGNoZWNrPwo+Cj4gVGhhbmtzCgpIaSBKYXNvbiwK
CkhlcmUgd2UgY2hlY2sgZGV2aWNlIGZlYXR1cmUgYml0cyB0byBtYWtlIHN1cmUgdGhlIGRldmlj
ZSBzdXBwb3J0IApBQ0NFU1NfUExBVEZPUk0uIEluIGdldF9mZWF0dXJlcygpLAppdCB3aWxsIHJl
dHVybiBhIGludGVyc2VjdGlvbiBvZiBkZXZpY2UgZmVhdHVyZXMgYml0IGFuZCBkcml2ZXIgCnN1
cHBvcnRlZCBmZWF0dXJlcyBiaXRzKHdoaWNoIGluY2x1ZGVzIEFDQ0VTU19QTEFURk9STSkuCk90
aGVyIGNvbXBvbmVudHMgbGlrZSBRRU1VIHNob3VsZCBub3Qgc2V0IGZlYXR1cmVzIGJpdHMgbW9y
ZSB0aGFuIHRoaXMgCmludGVyc2VjdGlvbiBvZiBiaXRzLiBzbyB3ZSBjYW4gbWFrZSBzdXJlIGlm
IHRoaXMKaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcygpIHBhc3NlZCwgYm90aCBkZXZpY2UgYW5k
IGRyaXZlciBzdXBwb3J0IApBQ0NFU1NfUExBVEZPUk0uCgpBcmUgeW91IHN1Z2dlc3RpbmcgY2hl
Y2sgZHJpdmVyIGZlYXR1cmUgYml0cyBpbiAKaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcygpIGlu
IHRoZSBtZWFudGltZSBhcyB3ZWxsPwoKVGhhbmtz77yBCj4KPgo+PiArwqDCoMKgIGlmIChyZXQp
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCDCoMKgwqDCoMKgIHZmLT5yZXFf
ZmVhdHVyZXMgPSBmZWF0dXJlczsKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
