Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD893EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 02:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 18D6F40278;
	Mon, 26 Jun 2023 02:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 18D6F40278
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SQHyj424
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct0yH0ceh2yU; Mon, 26 Jun 2023 02:37:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72C054012D;
	Mon, 26 Jun 2023 02:37:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72C054012D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2727FC0037;
	Mon, 26 Jun 2023 02:37:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE9AC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34D8882008
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34D8882008
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SQHyj424
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V_dqViMrKj-w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70F9F81FF8
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70F9F81FF8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 02:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687747073; x=1719283073;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jaWB7EpF6LvFIBdIz/m7V1+WR3PkrkIAo+fyuIISbuE=;
 b=SQHyj424PbfemwaqSvznIT9BoaA+F2MOVTQljJm2Q0w/xZzxgO1ZGE9D
 +czrmQxmf7EsrIHk7c7XsAltZaKFS4LU4l4aBE8B/Rla8y/AyGiROWRTA
 2eL25BEqwDMoslmlYo3EkWWhcJ1YVSjngnte0nDBji4zkE6PCmLU7CNku
 cMGoKgx5vdFofJ3PI8Ha1s6E2YumO04P2Qis2+2i0hS/NkDpf+AcWA6sV
 FubpZ998/nhpxbqzyt93kNPn6DeMNZWGSOR2oOFRGlmA++fa9RoaeMZY+
 gmUk4Uwyd2LuWuNwnVF3NMj5jUGDStLtXFvMbxJUTxEr8PBBeA47Tpw5s g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="340743026"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="340743026"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 19:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="890133970"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; d="scan'208";a="890133970"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.30.49])
 ([10.255.30.49])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2023 19:37:50 -0700
Message-ID: <43c2e0c9-4195-bbeb-a7ed-0947580cbfe4@intel.com>
Date: Mon, 26 Jun 2023 10:37:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V2 1/3] vDPA/ifcvf: dynamic allocate vq data stores
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
 <20230612151420.1019504-2-lingshan.zhu@intel.com>
 <CACGkMEspGu+N-CpE8J=Ux3m=+zMOByGPJU=My2U-BGW9QOHNhg@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEspGu+N-CpE8J=Ux3m=+zMOByGPJU=My2U-BGW9QOHNhg@mail.gmail.com>
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

CgpPbiA2LzI2LzIwMjMgMTA6MzIgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gTW9uLCBKdW4g
MTIsIDIwMjMgYXQgMzoxNOKAr1BNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4gd3JvdGU6Cj4+IFRoaXMgY29tbWl0IGR5bmFtaWNhbGx5IGFsbG9jYXRlcyB0aGUgZGF0YQo+
PiBzdG9yZXMgZm9yIHRoZSB2aXJ0cXVldWVzIGJhc2VkIG9uCj4+IHZpcnRpb19wY2lfY29tbW9u
X2NmZy5udW1fcXVldWVzLgo+IFdoaWxlIGF0IGl0LCBpdCdzIGJldHRlciB0byBhbGxvY2F0ZSB2
cmluZ19sbV9jZmcgYXMgd2VsbCBhbmQgZHJvcAo+IElGQ1ZGX01BWF9RVUVVRVMuClllcywgdGhp
cyBoYXMgYmVlbiBkb25lIGluIDMvMyBwYXRjaCBpbiB0aGlzIHNlcmllcy4KClRoYW5rcwpaaHUg
TGluZ3NoYW4KPgo+IFRoYW5rcwo+Cj4+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuYyB8IDMgKysrCj4+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDIg
Ky0KPj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMiArKwo+PiAgIDMgZmls
ZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jIGIvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuYwo+PiBpbmRleCAxYjVkYTExZjU0MDMuLmY4NjQ5NWFjZTgyNSAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+PiArKysgYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+IEBAIC0xMzQsNiArMTM0LDkgQEAgaW50IGlmY3Zm
X2luaXRfaHcoc3RydWN0IGlmY3ZmX2h3ICpodywgc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+ICAg
ICAgICAgIH0KPj4KPj4gICAgICAgICAgaHctPm5yX3ZyaW5nID0gdnBfaW9yZWFkMTYoJmh3LT5j
b21tb25fY2ZnLT5udW1fcXVldWVzKTsKPj4gKyAgICAgICBody0+dnJpbmcgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3QgdnJpbmdfaW5mbykgKiBody0+bnJfdnJpbmcsIEdGUF9LRVJORUwpOwo+PiAr
ICAgICAgIGlmICghaHctPnZyaW5nKQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
Cj4+Cj4+ICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBody0+bnJfdnJpbmc7IGkrKykgewo+PiAg
ICAgICAgICAgICAgICAgIHZwX2lvd3JpdGUxNihpLCAmaHctPmNvbW1vbl9jZmctPnF1ZXVlX3Nl
bGVjdCk7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+PiBpbmRleCAzMTEwZmZjNTBjYWYuLmZh
Nzk3MTg0MDU2YiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2Uu
aAo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+IEBAIC03NCw3ICs3
NCw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4+ICAgICAgICAgIHU2NCBkZXZfZmVhdHVyZXM7Cj4+
ICAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgX19pb21lbSAqY29tbW9uX2Nm
ZzsKPj4gICAgICAgICAgdm9pZCBfX2lvbWVtICpkZXZfY2ZnOwo+PiAtICAgICAgIHN0cnVjdCB2
cmluZ19pbmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRVNdOwo+PiArICAgICAgIHN0cnVjdCB2cmlu
Z19pbmZvICp2cmluZzsKPj4gICAgICAgICAgdm9pZCBfX2lvbWVtICogY29uc3QgKmJhc2U7Cj4+
ICAgICAgICAgIGNoYXIgY29uZmlnX21zaXhfbmFtZVsyNTZdOwo+PiAgICAgICAgICBzdHJ1Y3Qg
dmRwYV9jYWxsYmFjayBjb25maWdfY2I7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBpbmRl
eCA2ZTQ3YWMyYzY2OWEuLjJhZjBkZTc3MWI0OSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX21haW4uYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4+IEBAIC04MzAsNiArODMwLDcgQEAgc3RhdGljIGludCBpZmN2Zl9wcm9iZShzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlkKQo+PiAgICAgICAg
ICByZXR1cm4gMDsKPj4KPj4gICBlcnI6Cj4+ICsgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYt
PnZmLnZyaW5nKTsKPj4gICAgICAgICAga2ZyZWUoaWZjdmZfbWdtdF9kZXYpOwo+PiAgICAgICAg
ICByZXR1cm4gcmV0Owo+PiAgIH0KPj4gQEAgLTg0MCw2ICs4NDEsNyBAQCBzdGF0aWMgdm9pZCBp
ZmN2Zl9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+Cj4+ICAgICAgICAgIGlmY3ZmX21n
bXRfZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+PiAgICAgICAgICB2ZHBhX21nbXRkZXZf
dW5yZWdpc3RlcigmaWZjdmZfbWdtdF9kZXYtPm1kZXYpOwo+PiArICAgICAgIGtmcmVlKGlmY3Zm
X21nbXRfZGV2LT52Zi52cmluZyk7Cj4+ICAgICAgICAgIGtmcmVlKGlmY3ZmX21nbXRfZGV2KTsK
Pj4gICB9Cj4+Cj4+IC0tCj4+IDIuMzkuMQo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
