Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635CC433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:36:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18DC61139
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 06:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18DC61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EB7C40F81;
	Thu, 15 Apr 2021 06:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rk5KFZQvt56T; Thu, 15 Apr 2021 06:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2B4140F8C;
	Thu, 15 Apr 2021 06:36:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A248EC000C;
	Thu, 15 Apr 2021 06:36:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A230AC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79E4C60AFC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:36:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDStPvmt0NGU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42B416066C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 06:36:24 +0000 (UTC)
IronPort-SDR: CYYwrV++cCkb4bGQ8uGIYRpTQ5YAR4qhZt+GZNTosqXZLqEs8ClB+bsLM3YNILfWvvJIarIAZE
 6XKSxEFTheSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181920985"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="181920985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:36:23 -0700
IronPort-SDR: cUCFkyBP4F1zQegbRNZjRuBuYb5nTtdKHouuUdwf2fWvM3jzUJyz9Cj13j5a0BE66KmUWrq6s2
 +sqekD9u+NdQ==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; d="scan'208";a="418634557"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.254.209.173])
 ([10.254.209.173])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2021 23:36:19 -0700
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Jason Wang <jasowang@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst@redhat.com, lulu@redhat.com, leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
 <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
 <ccf7001b-27f0-27ea-40d2-52ca3cc2386b@linux.intel.com>
 <ffd2861d-2395-de51-a227-f1ef33f74322@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <92ef6264-4462-cbd4-5db8-6ce6b68762e0@linux.intel.com>
Date: Thu, 15 Apr 2021 14:36:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <ffd2861d-2395-de51-a227-f1ef33f74322@redhat.com>
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

CgpPbiA0LzE1LzIwMjEgMjozMCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPgo+IOWcqCAyMDIxLzQv
MTUg5LiL5Y2IMTo1MiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4KPj4KPj4gT24gNC8xNS8yMDIx
IDExOjMwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IOWcqCAyMDIxLzQvMTQg5LiL5Y2I
NToxOCwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+PiBUaGlzIGNvbW1pdCBkZWR1Y2VzIFZJUlRJ
TyBkZXZpY2UgSUQgYXMgZGV2aWNlIHR5cGUgd2hlbiBwcm9iZSwKPj4+PiB0aGVuIGlmY3ZmX3Zk
cGFfZ2V0X2RldmljZV9pZCgpIGNhbiBzaW1wbHkgcmV0dXJuIHRoZSBJRC4KPj4+PiBpZmN2Zl92
ZHBhX2dldF9mZWF0dXJlcygpIGFuZCBpZmN2Zl92ZHBhX2dldF9jb25maWdfc2l6ZSgpCj4+Pj4g
Y2FuIHdvcmsgcHJvcGVybHkgYmFzZWQgb24gdGhlIGRldmljZSBJRC4KPj4+Pgo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+PiAtLS0K
Pj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHzCoCAxICsKPj4+PiDCoCBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMjIgKysrKysrKysrKy0tLS0tLS0tLS0t
LQo+Pj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
aCAKPj4+PiBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+PiBpbmRleCBiMmVl
YjE2YjljMmMuLjFjMDRjZDI1NmZhNyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5oCj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
aAo+Pj4+IEBAIC04NCw2ICs4NCw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4+Pj4gwqDCoMKgwqDC
oCB1MzIgbm90aWZ5X29mZl9tdWx0aXBsaWVyOwo+Pj4+IMKgwqDCoMKgwqAgdTY0IHJlcV9mZWF0
dXJlczsKPj4+PiDCoMKgwqDCoMKgIHU2NCBod19mZWF0dXJlczsKPj4+PiArwqDCoMKgIHUzMiBk
ZXZfdHlwZTsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19p
b21lbSAqY29tbW9uX2NmZzsKPj4+PiDCoMKgwqDCoMKgIHZvaWQgX19pb21lbSAqbmV0X2NmZzsK
Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCB2cmluZ19pbmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRV9Q
QUlSUyAqIDJdOwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jIAo+Pj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+IGluZGV4IDQ0
ZDc1ODYwMTlkYS4uOTliMGE2YjRjMjI3IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4+Pj4gQEAgLTMyMywxOSArMzIzLDkgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF9n
ZW5lcmF0aW9uKHN0cnVjdCAKPj4+PiB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Pj4gwqAgwqAg
c3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF9kZXZpY2VfaWQoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhX2RldikKPj4+PiDCoCB7Cj4+Pj4gLcKgwqDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRh
cHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4+Pj4gLcKgwqDCoCBzdHJ1Y3QgcGNp
X2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4+Pj4gLcKgwqDCoCB1MzIgcmV0ID0gLUVOT0RF
VjsKPj4+PiAtCj4+Pj4gLcKgwqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYt
PmRldmljZSA+IDB4MTA3ZikKPj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+PiAt
Cj4+Pj4gLcKgwqDCoCBpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+Pj4+IC3CoMKgwqDCoMKg
wqDCoCByZXQgPcKgIHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4+Pj4gLcKgwqDCoCBlbHNlCj4+
Pj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9wqAgcGRldi0+ZGV2aWNlIC0weDEwNDA7Cj4+Pj4gK8Kg
wqDCoCBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4+Pj4gwqAg
LcKgwqDCoCByZXR1cm4gcmV0Owo+Pj4+ICvCoMKgwqAgcmV0dXJuIHZmLT5kZXZfdHlwZTsKPj4+
PiDCoCB9Cj4+Pj4gwqAgwqAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF92ZW5kb3JfaWQoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+PiBAQCAtNDY2LDYgKzQ1NiwxNCBAQCBzdGF0
aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCAKPj4+PiBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4+Pj4gwqDCoMKgwqDCoCBwY2lfc2V0X2RydmRhdGEocGRl
diwgYWRhcHRlcik7Cj4+Pj4gwqAgwqDCoMKgwqDCoCB2ZiA9ICZhZGFwdGVyLT52ZjsKPj4+PiAr
wqDCoMKgIGlmIChwZGV2LT5kZXZpY2UgPCAweDEwMDAgfHwgcGRldi0+ZGV2aWNlID4gMHgxMDdm
KQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVPUE5PVFNVUFA7Cj4+Pj4gKwo+Pj4+ICvC
oMKgwqAgaWYgKHBkZXYtPmRldmljZSA8IDB4MTA0MCkKPj4+PiArwqDCoMKgwqDCoMKgwqAgdmYt
PmRldl90eXBlID3CoCBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+Pj4+ICvCoMKgwqAgZWxzZQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCB2Zi0+ZGV2X3R5cGUgPcKgIHBkZXYtPmRldmljZSAtIDB4MTA0
MDsKPj4+Cj4+Pgo+Pj4gU28gYSBxdWVzdGlvbiBoZXJlLCBpcyB0aGUgZGV2aWNlIGEgdHJhbnN0
aW9uYWwgZGV2aWNlIG9yIG1vZGVybiBvbmU/Cj4+Pgo+Pj4gSWYgaXQncyBhIHRyYW5zaXRvbmFs
IG9uZSwgY2FuIGl0IHN3dGljaCBlbmRpYW5lc3MgYXV0b21hdGljYWxseSBvciAKPj4+IG5vdD8K
Pj4+Cj4+PiBUaGFua3MKPj4gSGkgSmFzb24sCj4+Cj4+IFRoaXMgZHJpdmVyIHNob3VsZCBkcml2
ZSBib3RoIG1vZGVybiBhbmQgdHJhbnNpdGlvbmFsIGRldmljZXMgYXMgd2UgCj4+IGRpc2N1c3Nl
ZCBiZWZvcmUuCj4+IElmIGl0J3MgYSB0cmFuc2l0aW9uYWwgb25lLCBpdCB3aWxsIGFjdCBhcyBh
IG1vZGVybiBkZXZpY2UgYnkgCj4+IGRlZmF1bHQsIGxlZ2FjeSBtb2RlIGlzIGEgZmFpbC1vdmVy
IHBhdGguCj4KPgo+IE5vdGUgdGhhdCBsZWdhY3kgZHJpdmVyIHVzZSBuYXRpdmUgZW5kaWFuLCBz
dXBwb3J0IGxlZ2FjeSBkcml2ZXIgCj4gcmVxdWlyZXMgdGhlIGRldmljZSB0byBrbm93IG5hdGl2
ZSBlbmRpYW4gd2hpY2ggSSdtIG5vdCBzdXJlIHlvdXIgCj4gZGV2aWNlIGNhbiBkbyB0aGF0Lgo+
Cj4gVGhhbmtzClllcywgbGVnYWN5IHJlcXVpcmVzIGd1ZXN0IG5hdGl2ZSBlbmRpYW5lc3MsIEkg
dGhpbmsgd2UgZG9uJ3QgbmVlZCB0byAKd29ycnkgYWJvdXQgdGhpcyBiZWNhdXNlIG91ciB0cmFu
c2l0aW9uYWwgZGV2aWNlIHNob3VsZCB3b3JrIGluIG1vZGVybiAKbW9kZSBieQpkZWZhdWx0KGxl
Z2FjeSBtb2RlIGlzIHRoZSBmYWlsb3ZlciBwYXRoIHdlIHdpbGwgbmV2ZXIgcmVhY2gsIApnZXRf
ZmVhdHVyZXMgd2lsbCBmYWlsIGlmIG5vIEFDQ0VTU19QTEFURk9STSksIHdlIGRvbid0IHN1cHBv
cnQgbGVnYWN5IApkZXZpY2UgaW4gdkRQQS4KClRoYW5rcwo+Cj4KPj4gRm9yIHZEUEEsIGl0IGhh
cyB0byBzdXBwb3J0IFZJUlRJT18xIGFuZCBBQ0NFU1NfUExBVEZPUk0sIHNvIGl0IG11c3QgCj4+
IGluIG1vZGVybiBtb2RlLgo+PiBJIHRoaW5rIHdlIGRvbid0IG5lZWQgdG8gd29ycnkgYWJvdXQg
ZW5kaWFuZXNzIGZvciBsZWdhY3kgbW9kZS4KPj4KPj4gVGhhbmtzCj4+IFpodSBMaW5nc2hhbgo+
Pj4KPj4+Cj4+Pj4gKwo+Pj4+IMKgwqDCoMKgwqAgdmYtPmJhc2UgPSBwY2ltX2lvbWFwX3RhYmxl
KHBkZXYpOwo+Pj4+IMKgIMKgwqDCoMKgwqAgYWRhcHRlci0+cGRldiA9IHBkZXY7Cj4+Pgo+Pgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
