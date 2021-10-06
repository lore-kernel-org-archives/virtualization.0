Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5F4C10DC2
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368F26113A
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 368F26113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B068840E9;
	Wed,  6 Oct 2021 17:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7mpYtCmg761; Wed,  6 Oct 2021 17:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DDD1840A3;
	Wed,  6 Oct 2021 17:41:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F3DFC002B;
	Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C3D8C0036
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9148408EC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHbrnwEA9o3E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C6CE408E3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 2F4EF30828BF; Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 17E413064495;
 Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 75/77] KVM: introspection: add KVMI_VCPU_TRANSLATE_GVA
Date: Wed,  6 Oct 2021 20:31:11 +0300
Message-Id: <20211006173113.26445-76-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

VGhpcyBoZWxwcyB0aGUgaW50cm9zcGVjdGlvbiB0b29sIHdpdGggdGhlIEdWQSB0byBHUEEgdHJh
bnNsYXRpb25zCndpdGhvdXQgdGhlIG5lZWQgdG8gcmVhZCBvciBtb25pdG9yIHRoZSBndWVzdCBw
YWdlIHRhYmxlcy4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRl
ZmVuZGVyLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0ICAgICAgICAg
ICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYyAg
ICAgICAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysKIGluY2x1ZGUvdWFwaS9saW51eC9r
dm1pLmggICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrKwogLi4uL3Rlc3Rpbmcvc2VsZnRl
c3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0LmMgIHwgMzAgKysrKysrKysrKysrKysrKysKIDQgZmls
ZXMgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
dmlydC9rdm0va3ZtaS5yc3QgYi9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0CmluZGV4
IDg0OTIyZDMyNzI1NS4uMTc3MzVkMDk5YmUyIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL3Zp
cnQva3ZtL2t2bWkucnN0CisrKyBiL0RvY3VtZW50YXRpb24vdmlydC9rdm0va3ZtaS5yc3QKQEAg
LTEwNTUsNiArMTA1NSwzOCBAQCB0byB0aGUgaW50cm9zcGVjdGlvbiB0b29sLgogKiAtS1ZNX0VJ
TlZBTCAtIHRoZSBwYWRkaW5nIGlzIG5vdCB6ZXJvCiAqIC1LVk1fRUFHQUlOIC0gdGhlIHNlbGVj
dGVkIHZDUFUgY2FuJ3QgYmUgaW50cm9zcGVjdGVkIHlldAogCisyNC4gS1ZNSV9WQ1BVX1RSQU5T
TEFURV9HVkEKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQorCis6QXJjaGl0ZWN0dXJlczog
eDg2Cis6VmVyc2lvbnM6ID49IDEKKzpQYXJhbWV0ZXJzOgorCis6OgorCisJc3RydWN0IGt2bWlf
dmNwdV9oZHI7CisJc3RydWN0IGt2bWlfdmNwdV90cmFuc2xhdGVfZ3ZhIHsKKwkJX191NjQgZ3Zh
OworCX07CisKKzpSZXR1cm5zOgorCis6OgorCisJc3RydWN0IGt2bWlfZXJyb3JfY29kZTsKKwlz
dHJ1Y3Qga3ZtaV92Y3B1X3RyYW5zbGF0ZV9ndmFfcmVwbHkgeworCQlfX3U2NCBncGE7CisJfTsK
KworVHJhbnNsYXRlcyBhIGd1ZXN0IHZpcnR1YWwgYWRkcmVzcyAoYGBndmFgYCkgdG8gYSBndWVz
dCBwaHlzaWNhbCBhZGRyZXNzCisoYGBncGFgYCkgb3IgfjAgaWYgdGhlIGFkZHJlc3MgY2Fubm90
IGJlIHRyYW5zbGF0ZWQuCisKKzpFcnJvcnM6CisKKyogLUtWTV9FSU5WQUwgLSB0aGUgc2VsZWN0
ZWQgdkNQVSBpcyBpbnZhbGlkCisqIC1LVk1fRUlOVkFMIC0gdGhlIHBhZGRpbmcgaXMgbm90IHpl
cm8KKyogLUtWTV9FQUdBSU4gLSB0aGUgc2VsZWN0ZWQgdkNQVSBjYW4ndCBiZSBpbnRyb3NwZWN0
ZWQgeWV0CisKIEV2ZW50cwogPT09PT09CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9rdm1p
X21zZy5jIGIvYXJjaC94ODYva3ZtL2t2bWlfbXNnLmMKaW5kZXggZWEzOGViN2NjYjdjLi5jZGQ0
OTdhMzQyYTAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9rdm1pX21zZy5jCisrKyBiL2FyY2gv
eDg2L2t2bS9rdm1pX21zZy5jCkBAIC0zMTIsNiArMzEyLDIwIEBAIHN0YXRpYyBpbnQgaGFuZGxl
X3ZjcHVfY29udHJvbF9zaW5nbGVzdGVwKGNvbnN0IHN0cnVjdCBrdm1pX3ZjcHVfbXNnX2pvYiAq
am9iLAogCXJldHVybiBrdm1pX21zZ192Y3B1X3JlcGx5KGpvYiwgbXNnLCBlYywgTlVMTCwgMCk7
CiB9CiAKK3N0YXRpYyBpbnQgaGFuZGxlX3ZjcHVfdHJhbnNsYXRlX2d2YShjb25zdCBzdHJ1Y3Qg
a3ZtaV92Y3B1X21zZ19qb2IgKmpvYiwKKwkJCQkgICAgIGNvbnN0IHN0cnVjdCBrdm1pX21zZ19o
ZHIgKm1zZywKKwkJCQkgICAgIGNvbnN0IHZvaWQgKl9yZXEpCit7CisJY29uc3Qgc3RydWN0IGt2
bWlfdmNwdV90cmFuc2xhdGVfZ3ZhICpyZXEgPSBfcmVxOworCXN0cnVjdCBrdm1pX3ZjcHVfdHJh
bnNsYXRlX2d2YV9yZXBseSBycGw7CisKKwltZW1zZXQoJnJwbCwgMCwgc2l6ZW9mKHJwbCkpOwor
CisJcnBsLmdwYSA9IGt2bV9tbXVfZ3ZhX3RvX2dwYV9zeXN0ZW0oam9iLT52Y3B1LCByZXEtPmd2
YSwgMCwgTlVMTCk7CisKKwlyZXR1cm4ga3ZtaV9tc2dfdmNwdV9yZXBseShqb2IsIG1zZywgMCwg
JnJwbCwgc2l6ZW9mKHJwbCkpOworfQorCiBzdGF0aWMgY29uc3Qga3ZtaV92Y3B1X21zZ19qb2Jf
ZmN0IG1zZ192Y3B1W10gPSB7CiAJW0tWTUlfVkNQVV9DT05UUk9MX0NSXSAgICAgICAgID0gaGFu
ZGxlX3ZjcHVfY29udHJvbF9jciwKIAlbS1ZNSV9WQ1BVX0NPTlRST0xfTVNSXSAgICAgICAgPSBo
YW5kbGVfdmNwdV9jb250cm9sX21zciwKQEAgLTMyNSw2ICszMzksNyBAQCBzdGF0aWMgY29uc3Qg
a3ZtaV92Y3B1X21zZ19qb2JfZmN0IG1zZ192Y3B1W10gPSB7CiAJW0tWTUlfVkNQVV9JTkpFQ1Rf
RVhDRVBUSU9OXSAgID0gaGFuZGxlX3ZjcHVfaW5qZWN0X2V4Y2VwdGlvbiwKIAlbS1ZNSV9WQ1BV
X1NFVF9SRUdJU1RFUlNdICAgICAgPSBoYW5kbGVfdmNwdV9zZXRfcmVnaXN0ZXJzLAogCVtLVk1J
X1ZDUFVfU0VUX1hTQVZFXSAgICAgICAgICA9IGhhbmRsZV92Y3B1X3NldF94c2F2ZSwKKwlbS1ZN
SV9WQ1BVX1RSQU5TTEFURV9HVkFdICAgICAgPSBoYW5kbGVfdmNwdV90cmFuc2xhdGVfZ3ZhLAog
fTsKIAoga3ZtaV92Y3B1X21zZ19qb2JfZmN0IGt2bWlfYXJjaF92Y3B1X21zZ19oYW5kbGVyKHUx
NiBpZCkKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rdm1pLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgva3ZtaS5oCmluZGV4IDE0OGQxNDVkZGVhMC4uYTFiZmE4NDVmZWQ4IDEwMDY0NAot
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9r
dm1pLmgKQEAgLTUwLDYgKzUwLDcgQEAgZW51bSB7CiAJS1ZNSV9WQ1BVX0dFVF9NVFJSX1RZUEUg
ICAgICA9IEtWTUlfVkNQVV9NRVNTQUdFX0lEKDExKSwKIAlLVk1JX1ZDUFVfQ09OVFJPTF9NU1Ig
ICAgICAgID0gS1ZNSV9WQ1BVX01FU1NBR0VfSUQoMTIpLAogCUtWTUlfVkNQVV9DT05UUk9MX1NJ
TkdMRVNURVAgPSBLVk1JX1ZDUFVfTUVTU0FHRV9JRCgxMyksCisJS1ZNSV9WQ1BVX1RSQU5TTEFU
RV9HVkEgICAgICA9IEtWTUlfVkNQVV9NRVNTQUdFX0lEKDE0KSwKIAogCUtWTUlfTkVYVF9WQ1BV
X01FU1NBR0UKIH07CkBAIC0yMjgsNCArMjI5LDEyIEBAIHN0cnVjdCBrdm1pX3ZjcHVfZXZlbnRf
c2luZ2xlc3RlcCB7CiAJX191OCBwYWRkaW5nWzddOwogfTsKIAorc3RydWN0IGt2bWlfdmNwdV90
cmFuc2xhdGVfZ3ZhIHsKKwlfX3U2NCBndmE7Cit9OworCitzdHJ1Y3Qga3ZtaV92Y3B1X3RyYW5z
bGF0ZV9ndmFfcmVwbHkgeworCV9fdTY0IGdwYTsKK307CisKICNlbmRpZiAvKiBfVUFQSV9fTElO
VVhfS1ZNSV9IICovCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2
XzY0L2t2bWlfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1p
X3Rlc3QuYwppbmRleCBmYWVmOTA4ZWVlZGQuLmZjNTlhOGI5Zjk5YSAxMDA2NDQKLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYworKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCkBAIC0xODk0LDYgKzE4OTQs
MzUgQEAgc3RhdGljIHZvaWQgdGVzdF9jbWRfdmNwdV9jb250cm9sX3NpbmdsZXN0ZXAoc3RydWN0
IGt2bV92bSAqdm0pCiAJCXRlc3RfdW5zdXBwb3J0ZWRfc2luZ2xlc3RlcCh2bSk7CiB9CiAKK3N0
YXRpYyB2b2lkIGNtZF90cmFuc2xhdGVfZ3ZhKHN0cnVjdCBrdm1fdm0gKnZtLCB2bV92YWRkcl90
IGd2YSwKKwkJCSAgICAgIHZtX3BhZGRyX3QgZXhwZWN0ZWRfZ3BhKQoreworCXN0cnVjdCB7CisJ
CXN0cnVjdCBrdm1pX21zZ19oZHIgaGRyOworCQlzdHJ1Y3Qga3ZtaV92Y3B1X2hkciB2Y3B1X2hk
cjsKKwkJc3RydWN0IGt2bWlfdmNwdV90cmFuc2xhdGVfZ3ZhIGNtZDsKKwl9IHJlcSA9IHsgMCB9
OworCXN0cnVjdCBrdm1pX3ZjcHVfdHJhbnNsYXRlX2d2YV9yZXBseSBycGw7CisKKwlyZXEuY21k
Lmd2YSA9IGd2YTsKKworCXRlc3RfdmNwdTBfY29tbWFuZCh2bSwgS1ZNSV9WQ1BVX1RSQU5TTEFU
RV9HVkEsICZyZXEuaGRyLCBzaXplb2YocmVxKSwKKwkJCSAgJnJwbCwgc2l6ZW9mKHJwbCksIDAp
OworCVRFU1RfQVNTRVJUKHJwbC5ncGEgPT0gZXhwZWN0ZWRfZ3BhLAorCQkgICAgIlRyYW5zbGF0
aW9uIGZhaWxlZCBmb3IgZ3ZhIDB4JWx4IC0+IGdwYSAweCVsbHggaW5zdGVhZCBvZiAweCVseFxu
IiwKKwkJICAgIGd2YSwgcnBsLmdwYSwgZXhwZWN0ZWRfZ3BhKTsKK30KKworc3RhdGljIHZvaWQg
dGVzdF9jbWRfdHJhbnNsYXRlX2d2YShzdHJ1Y3Qga3ZtX3ZtICp2bSkKK3sKKwljbWRfdHJhbnNs
YXRlX2d2YSh2bSwgdGVzdF9ndmEsIHRlc3RfZ3BhKTsKKwlwcl9kZWJ1ZygiVGVzdGVkIGd2YSAw
eCVseCB0byBncGEgMHglbHhcbiIsIHRlc3RfZ3ZhLCB0ZXN0X2dwYSk7CisKKwljbWRfdHJhbnNs
YXRlX2d2YSh2bSwgLTEsIH4wKTsKKwlwcl9kZWJ1ZygiVGVzdGVkIGd2YSAweCVseCB0byBncGEg
MHglbHhcbiIsCisJCSAodm1fdmFkZHJfdCktMSwgKHZtX3BhZGRyX3QpLTEpOworfQorCiBzdGF0
aWMgdm9pZCB0ZXN0X2ludHJvc3BlY3Rpb24oc3RydWN0IGt2bV92bSAqdm0pCiB7CiAJc3JhbmRv
bSh0aW1lKDApKTsKQEAgLTE5MjgsNiArMTk1Nyw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfaW50cm9z
cGVjdGlvbihzdHJ1Y3Qga3ZtX3ZtICp2bSkKIAl0ZXN0X2NtZF92bV9zZXRfcGFnZV9hY2Nlc3Mo
dm0pOwogCXRlc3RfZXZlbnRfcGYodm0pOwogCXRlc3RfY21kX3ZjcHVfY29udHJvbF9zaW5nbGVz
dGVwKHZtKTsKKwl0ZXN0X2NtZF90cmFuc2xhdGVfZ3ZhKHZtKTsKIAogCXVuaG9va19pbnRyb3Nw
ZWN0aW9uKHZtKTsKIH0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
