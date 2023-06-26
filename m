Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2990DEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 03:07:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1CEB612E4;
	Mon, 26 Jun 2023 03:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1CEB612E4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Tov8uowS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HkMpaH4_Xnwy; Mon, 26 Jun 2023 03:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 891AE61246;
	Mon, 26 Jun 2023 03:07:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 891AE61246
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44027C0037;
	Mon, 26 Jun 2023 03:07:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81B5EC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 491D98200E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 491D98200E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Tov8uowS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wiy97-7-SctD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:07:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C2008200D
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C2008200D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687748850; x=1719284850;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NECcji0VMQw6teNnEoaB1/WdKWFppjwVFrPD8aqCPIA=;
 b=Tov8uowSjxH8CDkWbBn1JhK20m78PNYM0Gai0vIhWBLKlFnBbVHjNYOn
 +EDrHxhbh7RMoWSkLWpHyu6GeOt/kfYCMVVcHCoIrBwIibtUSaGryC/Cd
 C6i5PEkjjjp1Z/AMFawUE4qPvSGV6ylxiVmvnnYM+dNsUIgcN9m+PCUsN
 MY/rbMDAYr3AuhFShLSnxr+b72Vr60tRMNEmMmSdceTV2xV7hZrKKjLqw
 JTqvTqdsBvSHaTSBWb1+KDjqoLUWfRfWdglYNrBiQNhG68oa14+bRdKmf
 iXqJrP2QNKBit9O0P3PbFgFm0x2nQsQcmadXBDIBsAJ9rXRS4uwJurTXe Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="340747696"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="340747696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 20:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="693311679"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="693311679"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.30.49])
 ([10.255.30.49])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 20:07:26 -0700
Message-ID: <5caf0f89-797d-b56a-71eb-1d16f0673daf@intel.com>
Date: Mon, 26 Jun 2023 11:07:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V2 1/3] vDPA/ifcvf: dynamic allocate vq data stores
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-2-lingshan.zhu@intel.com>
 <CACGkMEspGu+N-CpE8J=Ux3m=+zMOByGPJU=My2U-BGW9QOHNhg@mail.gmail.com>
 <43c2e0c9-4195-bbeb-a7ed-0947580cbfe4@intel.com>
 <CACGkMEvWtPZRWmoSF5oJcLadUufCneqR-4dCn_Yv5B+_pqf3ng@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEvWtPZRWmoSF5oJcLadUufCneqR-4dCn_Yv5B+_pqf3ng@mail.gmail.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

CgpPbiA2LzI2LzIwMjMgMTA6NDkgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gTW9uLCBKdW4g
MjYsIDIwMjMgYXQgMTA6MzjigK9BTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwu
Y29tPiB3cm90ZToKPj4KPj4KPj4gT24gNi8yNi8yMDIzIDEwOjMyIEFNLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4gT24gTW9uLCBKdW4gMTIsIDIwMjMgYXQgMzoxNOKAr1BNIFpodSBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4+Pj4gVGhpcyBjb21taXQgZHluYW1pY2Fs
bHkgYWxsb2NhdGVzIHRoZSBkYXRhCj4+Pj4gc3RvcmVzIGZvciB0aGUgdmlydHF1ZXVlcyBiYXNl
ZCBvbgo+Pj4+IHZpcnRpb19wY2lfY29tbW9uX2NmZy5udW1fcXVldWVzLgo+Pj4gV2hpbGUgYXQg
aXQsIGl0J3MgYmV0dGVyIHRvIGFsbG9jYXRlIHZyaW5nX2xtX2NmZyBhcyB3ZWxsIGFuZCBkcm9w
Cj4+PiBJRkNWRl9NQVhfUVVFVUVTLgo+PiBZZXMsIHRoaXMgaGFzIGJlZW4gZG9uZSBpbiAzLzMg
cGF0Y2ggaW4gdGhpcyBzZXJpZXMuCj4gT2ssIHllcywgYnV0IGl0IHNlZW1zIHBhdGNoIDMgaW1w
bGVtZW50cyBhIGxvdCBvZiBsb2dpYyBzbyBJIHN1Z2dlc3QKPiBtb3ZpbmcgaXQgdG8gcGF0Y2gg
MS4KPgo+IE5vdCBzdXJlIGl0J3MgdG9vIGxhdGUgc2luY2UgSSBzZWUgdGhlIHBhdGNoIGhhcyBi
ZWVuIG1lcmdlZCBieSBNaWNoYWVsLgpJIGFtIG5vdCBzdXJlLCBJIHRoaW5rIHdlIG5lZWQgdHdv
IHBhdGNoZXMgaGFuZGxlIHRoZWlyIHJlc3BlY3RpdmUgCmNoYW5nZXMgYW55d2F5LAphbmQgY2Fu
IG5vdCBkcm9wIElGQ1ZGX01BWF9RVUVVRVMgaW4gdGhlIGZpcnN0IG9uZS4KPgo+IFRoYW5rcwo+
Cj4+IFRoYW5rcwo+PiBaaHUgTGluZ3NoYW4KPj4+IFRoYW5rcwo+Pj4KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4gLS0tCj4+Pj4g
ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDMgKysrCj4+Pj4gICAgZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDIgKy0KPj4+PiAgICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jIHwgMiArKwo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+
PiBpbmRleCAxYjVkYTExZjU0MDMuLmY4NjQ5NWFjZTgyNSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuYwo+Pj4+IEBAIC0xMzQsNiArMTM0LDkgQEAgaW50IGlmY3ZmX2luaXRfaHco
c3RydWN0IGlmY3ZmX2h3ICpodywgc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+Pj4gICAgICAgICAg
IH0KPj4+Pgo+Pj4+ICAgICAgICAgICBody0+bnJfdnJpbmcgPSB2cF9pb3JlYWQxNigmaHctPmNv
bW1vbl9jZmctPm51bV9xdWV1ZXMpOwo+Pj4+ICsgICAgICAgaHctPnZyaW5nID0ga3phbGxvYyhz
aXplb2Yoc3RydWN0IHZyaW5nX2luZm8pICogaHctPm5yX3ZyaW5nLCBHRlBfS0VSTkVMKTsKPj4+
PiArICAgICAgIGlmICghaHctPnZyaW5nKQo+Pj4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVO
T01FTTsKPj4+Pgo+Pj4+ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaHctPm5yX3ZyaW5nOyBp
KyspIHsKPj4+PiAgICAgICAgICAgICAgICAgICB2cF9pb3dyaXRlMTYoaSwgJmh3LT5jb21tb25f
Y2ZnLT5xdWV1ZV9zZWxlY3QpOwo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfYmFzZS5oIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+IGluZGV4
IDMxMTBmZmM1MGNhZi4uZmE3OTcxODQwNTZiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5oCj4+Pj4gQEAgLTc0LDcgKzc0LDcgQEAgc3RydWN0IGlmY3ZmX2h3IHsKPj4+PiAgICAg
ICAgICAgdTY0IGRldl9mZWF0dXJlczsKPj4+PiAgICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lf
Y29tbW9uX2NmZyBfX2lvbWVtICpjb21tb25fY2ZnOwo+Pj4+ICAgICAgICAgICB2b2lkIF9faW9t
ZW0gKmRldl9jZmc7Cj4+Pj4gLSAgICAgICBzdHJ1Y3QgdnJpbmdfaW5mbyB2cmluZ1tJRkNWRl9N
QVhfUVVFVUVTXTsKPj4+PiArICAgICAgIHN0cnVjdCB2cmluZ19pbmZvICp2cmluZzsKPj4+PiAg
ICAgICAgICAgdm9pZCBfX2lvbWVtICogY29uc3QgKmJhc2U7Cj4+Pj4gICAgICAgICAgIGNoYXIg
Y29uZmlnX21zaXhfbmFtZVsyNTZdOwo+Pj4+ICAgICAgICAgICBzdHJ1Y3QgdmRwYV9jYWxsYmFj
ayBjb25maWdfY2I7Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+Pj4gaW5kZXggNmU0N2Fj
MmM2NjlhLi4yYWYwZGU3NzFiNDkgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX21haW4uYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
Pj4+PiBAQCAtODMwLDYgKzgzMCw3IEBAIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPj4+PiAgICAgICAg
ICAgcmV0dXJuIDA7Cj4+Pj4KPj4+PiAgICBlcnI6Cj4+Pj4gKyAgICAgICBrZnJlZShpZmN2Zl9t
Z210X2Rldi0+dmYudnJpbmcpOwo+Pj4+ICAgICAgICAgICBrZnJlZShpZmN2Zl9tZ210X2Rldik7
Cj4+Pj4gICAgICAgICAgIHJldHVybiByZXQ7Cj4+Pj4gICAgfQo+Pj4+IEBAIC04NDAsNiArODQx
LDcgQEAgc3RhdGljIHZvaWQgaWZjdmZfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+Pj4+
Cj4+Pj4gICAgICAgICAgIGlmY3ZmX21nbXRfZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+
Pj4+ICAgICAgICAgICB2ZHBhX21nbXRkZXZfdW5yZWdpc3RlcigmaWZjdmZfbWdtdF9kZXYtPm1k
ZXYpOwo+Pj4+ICsgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYtPnZmLnZyaW5nKTsKPj4+PiAg
ICAgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYpOwo+Pj4+ICAgIH0KPj4+Pgo+Pj4+IC0tCj4+
Pj4gMi4zOS4xCj4+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
