Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2379C77B7C
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 05:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26C024287C;
	Fri, 26 May 2023 05:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26C024287C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VPbnTaL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Cgtst9k3Gxk; Fri, 26 May 2023 05:30:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E00004281F;
	Fri, 26 May 2023 05:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E00004281F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2D39C0036;
	Fri, 26 May 2023 05:30:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3B1DC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 777C860DED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 777C860DED
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VPbnTaL0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0QFbjjOdnuR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:30:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 50A5B60D9D
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50A5B60D9D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685079033; x=1716615033;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=44PV08ts9MjOtP9Wlm7XuVcO87b48qY1Au2tygmYObs=;
 b=VPbnTaL0IdjNihX5ZqRXjxaZ46O16GX7W3TBJLQCSSMQ0dI64fnvgZRF
 iZp4PUqnxqcmuE9KyKTY84NPVBswEi4j6at6ciREeUOLeN87x1Akowf33
 3SJreqUe/zNow6GO/z+D97psDsmQzIg2XcauH/0/a9rvxej2UVwiF0jRT
 l8tHNwZx4XLoljEMSmeaTTnYYJhnxSqaBsHjxs3KIa0KSzWADT4P4Q49i
 lygyNIXirLDqqjDIUjd+pqZxPFC3QuI77mAZXFCkWC3srZgImUhF1sozD
 x7xVMaCnOlGguyirxtF07MdrnKhS85Jb/6UjCxEY++po+6+JpcI15tyEL g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="419878667"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="419878667"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 22:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682608093"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="682608093"
Received: from lliu93-mobl1.ccr.corp.intel.com (HELO [10.255.29.112])
 ([10.255.29.112])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 22:30:31 -0700
Message-ID: <1ffe2d2b-e28b-11e3-e411-a875de1b3cc2@intel.com>
Date: Fri, 26 May 2023 13:30:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
 <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
 <CACGkMEtmSBhaMrVCLO6TLJ40_fY5pwa2p+jC6=Q0D09zUJRcOg@mail.gmail.com>
 <7e355ae0-158a-e308-1e26-7c562a78c9d9@intel.com>
In-Reply-To: <7e355ae0-158a-e308-1e26-7c562a78c9d9@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

CgpPbiA1LzI2LzIwMjMgMTE6MzYgQU0sIFpodSwgTGluZ3NoYW4gd3JvdGU6Cj4KPgo+IE9uIDUv
MjYvMjAyMyA5OjM0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiBUaHUsIE1heSAyNSwgMjAy
MyBhdCA1OjM44oCvUE0gWmh1LCBMaW5nc2hhbiAKPj4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+
IHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiA1LzI0LzIwMjMgNDowMyBQTSwgSmFzb24gV2FuZyB3cm90
ZToKPj4+PiBPbiBNb24sIE1heSA4LCAyMDIzIGF0IDY6MDXigK9QTSBaaHUgTGluZ3NoYW4gCj4+
Pj4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Pj4+PiBUaGlzIGNvbW1pdCBzeW5j
aHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVzCj4+Pj4+IGFuZCBjb25maWcgc3BhY2UgaW4g
dGhlIHJlc2V0IHJvdXRpbmUuCj4+Pj4+IFRodXMgaWZjdmZfc3RvcF9odygpIGFuZCByZXNldCgp
IGFyZSByZWZhY3RvcmVkIGFzIHdlbGwuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpodSBM
aW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgwqAgZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tCj4+Pj4+IMKgwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8wqAgMSAr
Cj4+Pj4+IMKgwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQ2IAo+Pj4+PiAr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+Pj4gwqDCoCAzIGZpbGVzIGNoYW5n
ZWQsIDM4IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyAKPj4+Pj4gYi9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+Pj4+IGluZGV4IDc5ZTMxM2M1ZTEwZS4uMWYzOTI5MGJh
YTM4IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+
Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+Pj4gQEAgLTE3MCwx
MiArMTcwLDkgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHU4
IAo+Pj4+PiBzdGF0dXMpCj4+Pj4+Cj4+Pj4+IMKgwqAgdm9pZCBpZmN2Zl9yZXNldChzdHJ1Y3Qg
aWZjdmZfaHcgKmh3KQo+Pj4+PiDCoMKgIHsKPj4+Pj4gLcKgwqDCoMKgwqDCoCBody0+Y29uZmln
X2NiLmNhbGxiYWNrID0gTlVMTDsKPj4+Pj4gLcKgwqDCoMKgwqDCoCBody0+Y29uZmlnX2NiLnBy
aXZhdGUgPSBOVUxMOwo+Pj4+PiAtCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZmN2Zl9zZXRf
c3RhdHVzKGh3LCAwKTsKPj4+Pj4gLcKgwqDCoMKgwqDCoCAvKiBmbHVzaCBzZXRfc3RhdHVzLCBt
YWtlIHN1cmUgVkYgaXMgc3RvcHBlZCwgcmVzZXQgKi8KPj4+Pj4gLcKgwqDCoMKgwqDCoCBpZmN2
Zl9nZXRfc3RhdHVzKGh3KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoCB3aGlsZSAoaWZjdmZfZ2V0X3N0
YXR1cyhodykpCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zbGVlcCgxKTsK
Pj4+Pj4gwqDCoCB9Cj4+Pj4+Cj4+Pj4+IMKgwqAgdTY0IGlmY3ZmX2dldF9od19mZWF0dXJlcyhz
dHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+PiBAQCAtMzY4LDIwICszNjUsNDIgQEAgdm9pZCBpZmN2
Zl9zZXRfdnFfcmVhZHkoc3RydWN0IGlmY3ZmX2h3ICpodywgCj4+Pj4+IHUxNiBxaWQsIGJvb2wg
cmVhZHkpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2cF9pb3dyaXRlMTYocmVhZHksICZjZmct
PnF1ZXVlX2VuYWJsZSk7Cj4+Pj4+IMKgwqAgfQo+Pj4+Pgo+Pj4+PiAtc3RhdGljIHZvaWQgaWZj
dmZfaHdfZGlzYWJsZShzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+PiArc3RhdGljIHZvaWQgaWZj
dmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2h3ICpodykKPj4+Pj4gwqDCoCB7Cj4+Pj4+IC3C
oMKgwqDCoMKgwqAgdTMyIGk7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgdTE2IHFpZDsKPj4+Pj4gKwo+
Pj4+PiArwqDCoMKgwqDCoMKgIGZvciAocWlkID0gMDsgcWlkIDwgaHctPm5yX3ZyaW5nOyBxaWQr
Kykgewo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBody0+dnJpbmdbcWlkXS5j
Yi5jYWxsYmFjayA9IE5VTEw7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3
LT52cmluZ1txaWRdLmNiLnByaXZhdGUgPSBOVUxMOwo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZmN2Zl9zZXRfdnFfdmVjdG9yKGh3LCBxaWQsIFZJUlRJT19NU0lfTk9fVkVD
VE9SKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoCB9Cj4+Pj4+ICt9Cj4+Pj4+Cj4+Pj4+ICtzdGF0aWMg
dm9pZCBpZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+
PiArewo+Pj4+PiArwqDCoMKgwqDCoMKgIGh3LT5jb25maWdfY2IuY2FsbGJhY2sgPSBOVUxMOwo+
Pj4+PiArwqDCoMKgwqDCoMKgIGh3LT5jb25maWdfY2IucHJpdmF0ZSA9IE5VTEw7Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBpZmN2Zl9zZXRfY29uZmlnX3ZlY3RvcihodywgVklSVElPX01TSV9O
T19WRUNUT1IpOwo+Pj4+PiAtwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBody0+bnJfdnJp
bmc7IGkrKykgewo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZmN2Zl9zZXRf
dnFfdmVjdG9yKGh3LCBpLCBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4+Pj4+ICt9Cj4+Pj4+ICsK
Pj4+Pj4gK3N0YXRpYyB2b2lkIGlmY3ZmX3N5bmNocm9uaXplX2lycShzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KQo+Pj4+PiArewo+Pj4+PiArwqDCoMKgwqDCoMKgIHUzMiBudmVjdG9ycyA9IGh3LT5udW1f
bXNpeF92ZWN0b3JzOwo+Pj4+PiArwqDCoMKgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpwZGV2ID0g
aHctPnBkZXY7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgaW50IGksIGlycTsKPj4+Pj4gKwo+Pj4+PiAr
wqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBudmVjdG9yczsgaSsrKSB7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlycSA9IHBjaV9pcnFfdmVjdG9yKHBkZXYsIGkpOwo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoaXJxID49IDApCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzeW5jaHJvbml6ZV9p
cnEoaXJxKTsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+Pj4gwqDCoCB9Cj4+Pj4+Cj4+
Pj4+IMKgwqAgdm9pZCBpZmN2Zl9zdG9wX2h3KHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+Pj4+IMKg
wqAgewo+Pj4+PiAtwqDCoMKgwqDCoMKgIGlmY3ZmX2h3X2Rpc2FibGUoaHcpOwo+Pj4+PiAtwqDC
oMKgwqDCoMKgIGlmY3ZmX3Jlc2V0KGh3KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoCBpZmN2Zl9zeW5j
aHJvbml6ZV9pcnEoaHcpOwo+Pj4+PiArwqDCoMKgwqDCoMKgIGlmY3ZmX3Jlc2V0X3ZyaW5nKGh3
KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoCBpZmN2Zl9yZXNldF9jb25maWdfaGFuZGxlcihodyk7Cj4+
Pj4gTml0Ogo+Pj4+Cj4+Pj4gU28gdGhlIG5hbWUgb2YgdGhpcyBmdW5jdGlvbiBpcyBraW5kIG9m
IG1pc2xlYWRpbmcgc2luY2UgaXJxCj4+Pj4gc3luY2hyb25pemF0aW9uIGFuZCB2aXJ0cXVldWUv
Y29uZmlnIGhhbmRsZXIgYXJlIG5vdCBiZWxvbmcgdG8KPj4+PiBoYXJkd2FyZT8KPj4+Pgo+Pj4+
IE1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBjYWxsIGl0IGlmY3ZmX3N0b3AoKS4KPj4+IFN1
cmUsIEkgd2lsbCBzZW5kIGEgVjMgd2l0aCB0aGlzIHJlbmFtaW5nLAo+Pj4gZG8geW91IGFjayBw
YXRjaCAxLzU/Cj4+IFllcywgSSB0aGluayBJJ3ZlIGFja2VkIHRvIHRoYXQgcGF0Y2guCj4gSSB3
aWxsIHNlbmQgYSBWMyB3aXRoIHRoaXMgcmVuYW1pbmcgYW5kIHlvdXIgYWNrIGZvciBwYXRjaCAx
LzUKQnkgdGhlIHdheSwgZG8geW91IGFjayB0aGlzIG9uZSBhZnRlciB0aGlzIGZ1bmN0aW9uIHJl
bmFtaW5nPwpJZiBzbywgSSB3aWxsIGFsc28gaW5jbHVkZSB5b3VyIGFjayBpbiBWMywgc28gd2Ug
ZG9uJ3QgbmVlZCBhbm90aGVyCnJldmlldyBwcm9jZXNzLCBJIHdpbGwgcGluZyBNaWNoYWVsIGZv
ciBhIG1lcmdlLgo+Pgo+PiBUaGFua3MKPj4KPj4+IFRoYW5rcwo+Pj4gWmh1IExpbmdzaGFuCj4+
Pj4gVGhhbmtzCj4+Pj4KPj4+Pj4gwqDCoCB9Cj4+Pj4+Cj4+Pj4+IMKgwqAgdm9pZCBpZmN2Zl9u
b3RpZnlfcXVldWUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggCj4+Pj4+IGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+PiBpbmRleCBkMzRkM2JjMGRiZjQuLjc0MzBmODA3Nzli
ZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+Pj4+IEBAIC04Miw2ICs4
Miw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdnFz
X3JldXNlZF9pcnE7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB1MTYgbnJfdnJpbmc7Cj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBWSVJUSU9fUENJX0NBUF9ERVZJQ0VfQ0ZHIHNpemUgKi8K
Pj4+Pj4gK8KgwqDCoMKgwqDCoCB1MzIgbnVtX21zaXhfdmVjdG9yczsKPj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHUzMiBjYXBfZGV2X2NvbmZpZ19zaXplOwo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4+Pj4+IMKgwqAgfTsKPj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+Pj4+IGIvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiBpbmRleCA5Njg2ODcxNTllNDQuLjM0MDFiOTkwMWRkMiAx
MDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+Pj4+IEBAIC0xMjUsNiArMTI1
LDcgQEAgc3RhdGljIHZvaWQgaWZjdmZfZnJlZV9pcnEoc3RydWN0IGlmY3ZmX2h3ICp2ZikKPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmY3ZmX2ZyZWVfdnFfaXJxKHZmKTsKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlmY3ZmX2ZyZWVfY29uZmlnX2lycSh2Zik7Cj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBpZmN2Zl9mcmVlX2lycV92ZWN0b3JzKHBkZXYpOwo+Pj4+PiArwqDCoMKgwqDCoMKg
IHZmLT5udW1fbXNpeF92ZWN0b3JzID0gMDsKPj4+Pj4gwqDCoCB9Cj4+Pj4+Cj4+Pj4+IMKgwqAg
LyogaWZjdmYgTVNJWCB2ZWN0b3JzIGFsbG9jYXRvciwgdGhpcyBoZWxwZXIgdHJpZXMgdG8gYWxs
b2NhdGUKPj4+Pj4gQEAgLTM0MywzNiArMzQ0LDExIEBAIHN0YXRpYyBpbnQgaWZjdmZfcmVxdWVz
dF9pcnEoc3RydWN0IGlmY3ZmX2h3IAo+Pj4+PiAqdmYpCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAocmV0KQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByZXQ7Cj4+Pj4+Cj4+Pj4+IC3CoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+IC19Cj4+Pj4+
IC0KPj4+Pj4gLXN0YXRpYyBpbnQgaWZjdmZfc3RvcF9kYXRhcGF0aChzdHJ1Y3QgaWZjdmZfYWRh
cHRlciAqYWRhcHRlcikKPj4+Pj4gLXsKPj4+Pj4gLcKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWZjdmZf
aHcgKnZmID0gYWRhcHRlci0+dmY7Cj4+Pj4+IC3CoMKgwqDCoMKgwqAgaW50IGk7Cj4+Pj4+IC0K
Pj4+Pj4gLcKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgdmYtPm5yX3ZyaW5nOyBpKyspCj4+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZmLT52cmluZ1tpXS5jYi5jYWxsYmFj
ayA9IE5VTEw7Cj4+Pj4+IC0KPj4+Pj4gLcKgwqDCoMKgwqDCoCBpZmN2Zl9zdG9wX2h3KHZmKTsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoCB2Zi0+bnVtX21zaXhfdmVjdG9ycyA9IG52ZWN0b3JzOwo+Pj4+
Pgo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+IMKgwqAgfQo+Pj4+Pgo+
Pj4+PiAtc3RhdGljIHZvaWQgaWZjdmZfcmVzZXRfdnJpbmcoc3RydWN0IGlmY3ZmX2FkYXB0ZXIg
KmFkYXB0ZXIpCj4+Pj4+IC17Cj4+Pj4+IC3CoMKgwqDCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2
ZiA9IGFkYXB0ZXItPnZmOwo+Pj4+PiAtwqDCoMKgwqDCoMKgIGludCBpOwo+Pj4+PiAtCj4+Pj4+
IC3CoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsrKSB7Cj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZmLT52cmluZ1tpXS5sYXN0X2F2YWlsX2lk
eCA9IDA7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZmLT52cmluZ1tpXS5j
Yi5jYWxsYmFjayA9IE5VTEw7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZm
LT52cmluZ1tpXS5jYi5wcml2YXRlID0gTlVMTDsKPj4+Pj4gLcKgwqDCoMKgwqDCoCB9Cj4+Pj4+
IC0KPj4+Pj4gLcKgwqDCoMKgwqDCoCBpZmN2Zl9yZXNldCh2Zik7Cj4+Pj4+IC19Cj4+Pj4+IC0K
Pj4+Pj4gwqDCoCBzdGF0aWMgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZkcGFfdG9fYWRhcHRlcihz
dHJ1Y3QgdmRwYV9kZXZpY2UgCj4+Pj4+ICp2ZHBhX2RldikKPj4+Pj4gwqDCoCB7Cj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY29udGFpbmVyX29mKHZkcGFfZGV2LCBzdHJ1Y3QgaWZj
dmZfYWRhcHRlciwgdmRwYSk7Cj4+Pj4+IEBAIC00NjIsMjMgKzQzOCwxNSBAQCBzdGF0aWMgdm9p
ZCBpZmN2Zl92ZHBhX3NldF9zdGF0dXMoc3RydWN0IAo+Pj4+PiB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYsIHU4IHN0YXR1cykKPj4+Pj4KPj4+Pj4gwqDCoCBzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfcmVz
ZXQoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+Pj4gwqDCoCB7Cj4+Pj4+IC3CoMKg
wqDCoMKgwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXI7Cj4+Pj4+IC3CoMKgwqDCoMKg
wqAgc3RydWN0IGlmY3ZmX2h3ICp2ZjsKPj4+Pj4gLcKgwqDCoMKgwqDCoCB1OCBzdGF0dXNfb2xk
Owo+Pj4+PiAtCj4+Pj4+IC3CoMKgwqDCoMKgwqAgdmbCoCA9IHZkcGFfdG9fdmYodmRwYV9kZXYp
Owo+Pj4+PiAtwqDCoMKgwqDCoMKgIGFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYp
Owo+Pj4+PiAtwqDCoMKgwqDCoMKgIHN0YXR1c19vbGQgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsK
Pj4+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBh
X2Rldik7Cj4+Pj4+ICvCoMKgwqDCoMKgwqAgdTggc3RhdHVzID0gaWZjdmZfZ2V0X3N0YXR1cyh2
Zik7Cj4+Pj4+Cj4+Pj4+IC3CoMKgwqDCoMKgwqAgaWYgKHN0YXR1c19vbGQgPT0gMCkKPj4+Pj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4+ICvCoMKgwqDCoMKg
wqAgaWZjdmZfc3RvcF9odyh2Zik7Cj4+Pj4+Cj4+Pj4+IC3CoMKgwqDCoMKgwqAgaWYgKHN0YXR1
c19vbGQgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7Cj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGlmY3ZmX3N0b3BfZGF0YXBhdGgoYWRhcHRlcik7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqAgaWYgKHN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0spCj4+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWZjdmZfZnJlZV9pcnEodmYpOwo+Pj4+
PiAtwqDCoMKgwqDCoMKgIH0KPj4+Pj4KPj4+Pj4gLcKgwqDCoMKgwqDCoCBpZmN2Zl9yZXNldF92
cmluZyhhZGFwdGVyKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoCBpZmN2Zl9yZXNldCh2Zik7Cj4+Pj4+
Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4gwqDCoCB9Cj4+Pj4+IC0t
IAo+Pj4+PiAyLjM5LjEKPj4+Pj4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
