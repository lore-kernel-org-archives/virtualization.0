Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B711C43461
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:23:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0652F611AB
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 07:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0652F611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C416860B5B;
	Thu, 15 Apr 2021 07:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJDu31rBV1TQ; Thu, 15 Apr 2021 07:23:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 453BD6075D;
	Thu, 15 Apr 2021 07:23:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FD5C000B;
	Thu, 15 Apr 2021 07:23:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3A7CC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 921CC40213
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3nhm7uSCIiud
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE7E440208
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:23:07 +0000 (UTC)
IronPort-SDR: wj42f7I3F5Np1BuWmKDN33TxvTTLIQWaDbd2390mITpIfAWxkXOLfLxH0xL9Y53NchwXTkj5A9
 2N61Id8hZVwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="256121338"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="256121338"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 00:23:06 -0700
IronPort-SDR: 1q08mUOndKXeFVGEi7/bOhotozuY47EgUD72MhZuLu5RDOeGhDdtBhcxSMZ9fWE5Vm7NIwhUH8
 i5dM4tQLKOcA==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418647778"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 00:23:03 -0700
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
 <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
 <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
 <ffd2861d-2395-de51-a227-f1ef33f74322@redhat.com>
 <92ef6264-4462-cbd4-5db8-6ce6b68762e0@linux.intel.com>
 <d3c7ea9f-1849-f890-f647-6caf764a7542@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <e2e5de78-9b6f-32cf-5955-ed930365d79f@linux.intel.com>
Date: Thu, 15 Apr 2021 15:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d3c7ea9f-1849-f890-f647-6caf764a7542@redhat.com>
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

CgpPbiA0LzE1LzIwMjEgMzoxNiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIxLzQv
MTUg5LiL5Y2IMjozNiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4KPj4KPj4gT24gNC8xNS8yMDIx
IDI6MzAgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pgo+Pj4g5ZyoIDIwMjEvNC8xNSDkuIvljYgx
OjUyLCBaaHUgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4+Cj4+Pj4KPj4+PiBPbiA0LzE1LzIwMjEgMTE6
MzAgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Cj4+Pj4+IOWcqCAyMDIxLzQvMTQg5LiL5Y2I
NToxOCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Pj4+IFRoaXMgY29tbWl0IGRlZHVjZXMgVklS
VElPIGRldmljZSBJRCBhcyBkZXZpY2UgdHlwZSB3aGVuIHByb2JlLAo+Pj4+Pj4gdGhlbiBpZmN2
Zl92ZHBhX2dldF9kZXZpY2VfaWQoKSBjYW4gc2ltcGx5IHJldHVybiB0aGUgSUQuCj4+Pj4+PiBp
ZmN2Zl92ZHBhX2dldF9mZWF0dXJlcygpIGFuZCBpZmN2Zl92ZHBhX2dldF9jb25maWdfc2l6ZSgp
Cj4+Pj4+PiBjYW4gd29yayBwcm9wZXJseSBiYXNlZCBvbiB0aGUgZGV2aWNlIElELgo+Pj4+Pj4K
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4KPj4+Pj4+IC0tLQo+Pj4+Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8
wqAgMSArCj4+Pj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMjIgKysr
KysrKysrKy0tLS0tLS0tLS0tLQo+Pj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4+Pj4+Cj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCAKPj4+Pj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX2Jhc2UuaAo+Pj4+Pj4gaW5kZXggYjJlZWIxNmI5YzJjLi4xYzA0Y2QyNTZmYTcgMTAwNjQ0
Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+Pj4+PiArKysg
Yi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+Pj4+PiBAQCAtODQsNiArODQsNyBA
QCBzdHJ1Y3QgaWZjdmZfaHcgewo+Pj4+Pj4gwqDCoMKgwqDCoCB1MzIgbm90aWZ5X29mZl9tdWx0
aXBsaWVyOwo+Pj4+Pj4gwqDCoMKgwqDCoCB1NjQgcmVxX2ZlYXR1cmVzOwo+Pj4+Pj4gwqDCoMKg
wqDCoCB1NjQgaHdfZmVhdHVyZXM7Cj4+Pj4+PiArwqDCoMKgIHUzMiBkZXZfdHlwZTsKPj4+Pj4+
IMKgwqDCoMKgwqAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjb21tb25f
Y2ZnOwo+Pj4+Pj4gwqDCoMKgwqDCoCB2b2lkIF9faW9tZW0gKm5ldF9jZmc7Cj4+Pj4+PiDCoMKg
wqDCoMKgIHN0cnVjdCB2cmluZ19pbmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDJd
Owo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+
Pj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4+IGluZGV4IDQ0ZDc1
ODYwMTlkYS4uOTliMGE2YjRjMjI3IDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21h
aW4uYwo+Pj4+Pj4gQEAgLTMyMywxOSArMzIzLDkgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dl
dF9nZW5lcmF0aW9uKHN0cnVjdCAKPj4+Pj4+IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+Pj4+
IMKgIMKgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNlX2lkKHN0cnVjdCB2ZHBhX2Rl
dmljZSAKPj4+Pj4+ICp2ZHBhX2RldikKPj4+Pj4+IMKgIHsKPj4+Pj4+IC3CoMKgwqAgc3RydWN0
IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+Pj4+
Pj4gLcKgwqDCoCBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4+Pj4+PiAt
wqDCoMKgIHUzMiByZXQgPSAtRU5PREVWOwo+Pj4+Pj4gLQo+Pj4+Pj4gLcKgwqDCoCBpZiAocGRl
di0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYtPmRldmljZSA+IDB4MTA3ZikKPj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+Pj4gLQo+Pj4+Pj4gLcKgwqDCoCBpZiAocGRldi0+
ZGV2aWNlIDwgMHgxMDQwKQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9wqAgcGRldi0+c3Vi
c3lzdGVtX2RldmljZTsKPj4+Pj4+IC3CoMKgwqAgZWxzZQo+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKg
IHJldCA9wqAgcGRldi0+ZGV2aWNlLTB4MTA0MDsKPj4+Pj4+ICvCoMKgwqAgc3RydWN0IGlmY3Zm
X2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+Pj4+Pj4gwqAgLcKgwqDCoCByZXR1cm4g
cmV0Owo+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gdmYtPmRldl90eXBlOwo+Pj4+Pj4gwqAgfQo+Pj4+
Pj4gwqAgwqAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF92ZW5kb3JfaWQoc3RydWN0IHZkcGFf
ZGV2aWNlIAo+Pj4+Pj4gKnZkcGFfZGV2KQo+Pj4+Pj4gQEAgLTQ2Niw2ICs0NTYsMTQgQEAgc3Rh
dGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgCj4+Pj4+PiBjb25zdCBz
dHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4+Pj4+PiDCoMKgwqDCoMKgIHBjaV9zZXRfZHJ2ZGF0
YShwZGV2LCBhZGFwdGVyKTsKPj4+Pj4+IMKgIMKgwqDCoMKgwqAgdmYgPSAmYWRhcHRlci0+dmY7
Cj4+Pj4+PiArwqDCoMKgIGlmIChwZGV2LT5kZXZpY2UgPCAweDEwMDAgfHwgcGRldi0+ZGV2aWNl
ID4gMHgxMDdmKQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsKPj4+
Pj4+ICsKPj4+Pj4+ICvCoMKgwqAgaWYgKHBkZXYtPmRldmljZSA8IDB4MTA0MCkKPj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCB2Zi0+ZGV2X3R5cGUgPcKgIHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4+
Pj4+PiArwqDCoMKgIGVsc2UKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB2Zi0+ZGV2X3R5cGUgPcKg
IHBkZXYtPmRldmljZSAtIDB4MTA0MDsKPj4+Pj4KPj4+Pj4KPj4+Pj4gU28gYSBxdWVzdGlvbiBo
ZXJlLCBpcyB0aGUgZGV2aWNlIGEgdHJhbnN0aW9uYWwgZGV2aWNlIG9yIG1vZGVybiBvbmU/Cj4+
Pj4+Cj4+Pj4+IElmIGl0J3MgYSB0cmFuc2l0b25hbCBvbmUsIGNhbiBpdCBzd3RpY2ggZW5kaWFu
ZXNzIGF1dG9tYXRpY2FsbHkgCj4+Pj4+IG9yIG5vdD8KPj4+Pj4KPj4+Pj4gVGhhbmtzCj4+Pj4g
SGkgSmFzb24sCj4+Pj4KPj4+PiBUaGlzIGRyaXZlciBzaG91bGQgZHJpdmUgYm90aCBtb2Rlcm4g
YW5kIHRyYW5zaXRpb25hbCBkZXZpY2VzIGFzIHdlIAo+Pj4+IGRpc2N1c3NlZCBiZWZvcmUuCj4+
Pj4gSWYgaXQncyBhIHRyYW5zaXRpb25hbCBvbmUsIGl0IHdpbGwgYWN0IGFzIGEgbW9kZXJuIGRl
dmljZSBieSAKPj4+PiBkZWZhdWx0LCBsZWdhY3kgbW9kZSBpcyBhIGZhaWwtb3ZlciBwYXRoLgo+
Pj4KPj4+Cj4+PiBOb3RlIHRoYXQgbGVnYWN5IGRyaXZlciB1c2UgbmF0aXZlIGVuZGlhbiwgc3Vw
cG9ydCBsZWdhY3kgZHJpdmVyIAo+Pj4gcmVxdWlyZXMgdGhlIGRldmljZSB0byBrbm93IG5hdGl2
ZSBlbmRpYW4gd2hpY2ggSSdtIG5vdCBzdXJlIHlvdXIgCj4+PiBkZXZpY2UgY2FuIGRvIHRoYXQu
Cj4+Pgo+Pj4gVGhhbmtzCj4+IFllcywgbGVnYWN5IHJlcXVpcmVzIGd1ZXN0IG5hdGl2ZSBlbmRp
YW5lc3MsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byAKPj4gd29ycnkgYWJvdXQgdGhpcyBiZWNh
dXNlIG91ciB0cmFuc2l0aW9uYWwgZGV2aWNlIHNob3VsZCB3b3JrIGluIAo+PiBtb2Rlcm4gbW9k
ZSBieQo+PiBkZWZhdWx0KGxlZ2FjeSBtb2RlIGlzIHRoZSBmYWlsb3ZlciBwYXRoIHdlIHdpbGwg
bmV2ZXIgcmVhY2gsIAo+PiBnZXRfZmVhdHVyZXMgd2lsbCBmYWlsIGlmIG5vIEFDQ0VTU19QTEFU
Rk9STSksIHdlIGRvbid0IHN1cHBvcnQgCj4+IGxlZ2FjeSBkZXZpY2UgaW4gdkRQQS4KPj4KPj4g
VGhhbmtzCj4KPgo+IE9rLCBzbyBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGFkZCBhIGNvbW1lbnQg
aGVyZS4Kc3VyZSwgd2lsbCBhZGQgYSBjb21tZW50IGluIFYyCgpUaGFua3MKPgo+IFRoYW5rcwo+
Cj4KPj4+Cj4+Pgo+Pj4+IEZvciB2RFBBLCBpdCBoYXMgdG8gc3VwcG9ydCBWSVJUSU9fMSBhbmQg
QUNDRVNTX1BMQVRGT1JNLCBzbyBpdCAKPj4+PiBtdXN0IGluIG1vZGVybiBtb2RlLgo+Pj4+IEkg
dGhpbmsgd2UgZG9uJ3QgbmVlZCB0byB3b3JyeSBhYm91dCBlbmRpYW5lc3MgZm9yIGxlZ2FjeSBt
b2RlLgo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4gWmh1IExpbmdzaGFuCj4+Pj4+Cj4+Pj4+Cj4+Pj4+
PiArCj4+Pj4+PiDCoMKgwqDCoMKgIHZmLT5iYXNlID0gcGNpbV9pb21hcF90YWJsZShwZGV2KTsK
Pj4+Pj4+IMKgIMKgwqDCoMKgwqAgYWRhcHRlci0+cGRldiA9IHBkZXY7Cj4+Pj4+Cj4+Pj4KPj4+
Cj4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
