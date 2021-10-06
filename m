Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87430C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C756113E
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51C756113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0551F840CA;
	Wed,  6 Oct 2021 17:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQ-d3d6lQqfb; Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5FB68407F;
	Wed,  6 Oct 2021 17:40:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB22C0045;
	Wed,  6 Oct 2021 17:40:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11BA2C001D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 204A460EE9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZMBYyG6_1cV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 128F46068F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 69B35305D36A; Wed,  6 Oct 2021 20:31:17 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 521793064495;
 Wed,  6 Oct 2021 20:31:17 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 56/77] KVM: introspection: restore the state of #BP
 interception on unhook
Date: Wed,  6 Oct 2021 20:30:52 +0300
Message-Id: <20211006173113.26445-57-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgY29tbWl0
IGFsc28gZW5zdXJlcyB0aGF0IG9ubHkgdGhlIHVzZXJzcGFjZSBvciB0aGUgaW50cm9zcGVjdGlv
bgp0b29sIGNhbiBjb250cm9sIHRoZSAjQlAgaW50ZXJjZXB0aW9uIGV4Y2x1c2l2ZWx5IGF0IG9u
ZSB0aW1lLgoKU2lnbmVkLW9mZi1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3Vk
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIu
Y29tPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oIHwgMTggKysrKysrKysr
KwogYXJjaC94ODYva3ZtL2t2bWkuYyAgICAgICAgICAgICAgfCA2MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgICAgICAgICAgfCAgNSAr
KysKIDMgZmlsZXMgY2hhbmdlZCwgODMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtaV9o
b3N0LmgKaW5kZXggYjc3NmJlNGJiNDlmLi5lMDA4NjYyZjkxYTUgMTAwNjQ0Ci0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2
bWlfaG9zdC5oCkBAIC00LDggKzQsMTUgQEAKIAogI2luY2x1ZGUgPGFzbS9rdm1pLmg+CiAKK3N0
cnVjdCBrdm1pX21vbml0b3JfaW50ZXJjZXB0aW9uIHsKKwlib29sIGt2bWlfaW50ZXJjZXB0ZWQ7
CisJYm9vbCBrdm1faW50ZXJjZXB0ZWQ7CisJYm9vbCAoKm1vbml0b3JfZmN0KShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGJvb2wgZW5hYmxlKTsKK307CisKIHN0cnVjdCBrdm1pX2ludGVyY2VwdGlv
biB7CiAJYm9vbCByZXN0b3JlX2ludGVyY2VwdGlvbjsKKwlzdHJ1Y3Qga3ZtaV9tb25pdG9yX2lu
dGVyY2VwdGlvbiBicmVha3BvaW50OwogfTsKIAogc3RydWN0IGt2bV92Y3B1X2FyY2hfaW50cm9z
cGVjdGlvbiB7CkBAIC0xNiw0ICsyMywxNSBAQCBzdHJ1Y3Qga3ZtX3ZjcHVfYXJjaF9pbnRyb3Nw
ZWN0aW9uIHsKIHN0cnVjdCBrdm1fYXJjaF9pbnRyb3NwZWN0aW9uIHsKIH07CiAKKyNpZmRlZiBD
T05GSUdfS1ZNX0lOVFJPU1BFQ1RJT04KKworYm9vbCBrdm1pX21vbml0b3JfYnBfaW50ZXJjZXB0
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIGRiZyk7CisKKyNlbHNlIC8qIENPTkZJR19LVk1f
SU5UUk9TUEVDVElPTiAqLworCitzdGF0aWMgaW5saW5lIGJvb2wga3ZtaV9tb25pdG9yX2JwX2lu
dGVyY2VwdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiBkYmcpCisJeyByZXR1cm4gZmFsc2U7
IH0KKworI2VuZGlmIC8qIENPTkZJR19LVk1fSU5UUk9TUEVDVElPTiAqLworCiAjZW5kaWYgLyog
X0FTTV9YODZfS1ZNSV9IT1NUX0ggKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9rdm1pLmMg
Yi9hcmNoL3g4Ni9rdm0va3ZtaS5jCmluZGV4IDZhN2ZjODA1OWYyMy4uMmJiZWFkYjlkYWJhIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0va3ZtaS5jCisrKyBiL2FyY2gveDg2L2t2bS9rdm1pLmMK
QEAgLTE2MiwxOSArMTYyLDcyIEBAIGJvb2wga3ZtaV9hcmNoX2lzX2FnZW50X2h5cGVyY2FsbChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJCSYmIHN1YmZ1bmMyID09IDApOwogfQogCisvKgorICog
UmV0dXJucyB0cnVlIGlmIG9uZSBzaWRlIChrdm0gb3Iga3ZtaSkgdHJpZXMgdG8gZW5hYmxlL2Rp
c2FibGUgdGhlIGJyZWFrcG9pbnQKKyAqIGludGVyY2VwdGlvbiB3aGlsZSB0aGUgb3RoZXIgc2lk
ZSBpcyBzdGlsbCB0cmFja2luZyBpdC4KKyAqLworYm9vbCBrdm1pX21vbml0b3JfYnBfaW50ZXJj
ZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIGRiZykKK3sKKwlzdHJ1Y3Qga3ZtaV9pbnRl
cmNlcHRpb24gKmFyY2hfdmNwdWkgPSBSRUFEX09OQ0UodmNwdS0+YXJjaC5rdm1pKTsKKwl1MzIg
YnBfbWFzayA9IEtWTV9HVUVTVERCR19FTkFCTEUgfCBLVk1fR1VFU1REQkdfVVNFX1NXX0JQOwor
CWJvb2wgZW5hYmxlID0gZmFsc2U7CisKKwlpZiAoKGRiZyAmIGJwX21hc2spID09IGJwX21hc2sp
CisJCWVuYWJsZSA9IHRydWU7CisKKwlyZXR1cm4gKGFyY2hfdmNwdWkgJiYgYXJjaF92Y3B1aS0+
YnJlYWtwb2ludC5tb25pdG9yX2ZjdCh2Y3B1LCBlbmFibGUpKTsKK30KK0VYUE9SVF9TWU1CT0wo
a3ZtaV9tb25pdG9yX2JwX2ludGVyY2VwdCk7CisKK3N0YXRpYyBib29sIG1vbml0b3JfYnBfZmN0
X2t2bWkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSkKK3sKKwlpZiAoZW5hYmxl
KSB7CisJCWlmIChzdGF0aWNfY2FsbChrdm1feDg2X2JwX2ludGVyY2VwdGVkKSh2Y3B1KSkKKwkJ
CXJldHVybiB0cnVlOworCX0gZWxzZSBpZiAoIXZjcHUtPmFyY2gua3ZtaS0+YnJlYWtwb2ludC5r
dm1pX2ludGVyY2VwdGVkKQorCQlyZXR1cm4gdHJ1ZTsKKworCXZjcHUtPmFyY2gua3ZtaS0+YnJl
YWtwb2ludC5rdm1pX2ludGVyY2VwdGVkID0gZW5hYmxlOworCisJcmV0dXJuIGZhbHNlOworfQor
CitzdGF0aWMgYm9vbCBtb25pdG9yX2JwX2ZjdF9rdm0oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBi
b29sIGVuYWJsZSkKK3sKKwlpZiAoZW5hYmxlKSB7CisJCWlmIChzdGF0aWNfY2FsbChrdm1feDg2
X2JwX2ludGVyY2VwdGVkKSh2Y3B1KSkKKwkJCXJldHVybiB0cnVlOworCX0gZWxzZSBpZiAoIXZj
cHUtPmFyY2gua3ZtaS0+YnJlYWtwb2ludC5rdm1faW50ZXJjZXB0ZWQpCisJCXJldHVybiB0cnVl
OworCisJdmNwdS0+YXJjaC5rdm1pLT5icmVha3BvaW50Lmt2bV9pbnRlcmNlcHRlZCA9IGVuYWJs
ZTsKKworCXJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGludCBrdm1pX2NvbnRyb2xfYnBfaW50
ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBlbmFibGUpCiB7CiAJc3RydWN0IGt2
bV9ndWVzdF9kZWJ1ZyBkYmcgPSB7fTsKIAlpbnQgZXJyID0gMDsKIAorCXZjcHUtPmFyY2gua3Zt
aS0+YnJlYWtwb2ludC5tb25pdG9yX2ZjdCA9IG1vbml0b3JfYnBfZmN0X2t2bWk7CiAJaWYgKGVu
YWJsZSkKIAkJZGJnLmNvbnRyb2wgPSBLVk1fR1VFU1REQkdfRU5BQkxFIHwgS1ZNX0dVRVNUREJH
X1VTRV9TV19CUDsKIAogCWVyciA9IGt2bV9hcmNoX3ZjcHVfc2V0X2d1ZXN0X2RlYnVnKHZjcHUs
ICZkYmcpOworCXZjcHUtPmFyY2gua3ZtaS0+YnJlYWtwb2ludC5tb25pdG9yX2ZjdCA9IG1vbml0
b3JfYnBfZmN0X2t2bTsKIAogCXJldHVybiBlcnI7CiB9CiAKK3N0YXRpYyB2b2lkIGt2bWlfYXJj
aF9kaXNhYmxlX2JwX2ludGVyY2VwdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJa3ZtaV9j
b250cm9sX2JwX2ludGVyY2VwdCh2Y3B1LCBmYWxzZSk7CisKKwl2Y3B1LT5hcmNoLmt2bWktPmJy
ZWFrcG9pbnQua3ZtaV9pbnRlcmNlcHRlZCA9IGZhbHNlOworCXZjcHUtPmFyY2gua3ZtaS0+YnJl
YWtwb2ludC5rdm1faW50ZXJjZXB0ZWQgPSBmYWxzZTsKK30KKwogaW50IGt2bWlfYXJjaF9jbWRf
Y29udHJvbF9pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCQkJCSAgICB1bnNpZ25l
ZCBpbnQgZXZlbnRfaWQsIGJvb2wgZW5hYmxlKQogewpAQCAtMjEzLDYgKzI2Niw3IEBAIHZvaWQg
a3ZtaV9hcmNoX2JyZWFrcG9pbnRfZXZlbnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZ3Zh
LCB1OCBpbnNuX2xlbikKIAogc3RhdGljIHZvaWQga3ZtaV9hcmNoX3Jlc3RvcmVfaW50ZXJjZXB0
aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIHsKKwlrdm1pX2FyY2hfZGlzYWJsZV9icF9pbnRl
cmNlcHQodmNwdSk7CiB9CiAKIGJvb2wga3ZtaV9hcmNoX2NsZWFuX3VwX2ludGVyY2VwdGlvbihz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCkBAIC0yMzgsNiArMjkyLDEyIEBAIGJvb2wga3ZtaV9hcmNo
X3ZjcHVfYWxsb2NfaW50ZXJjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAlpZiAoIWFy
Y2hfdmNwdWkpCiAJCXJldHVybiBmYWxzZTsKIAorCWFyY2hfdmNwdWktPmJyZWFrcG9pbnQubW9u
aXRvcl9mY3QgPSBtb25pdG9yX2JwX2ZjdF9rdm07CisKKwkvKiBwYWlyIHdpdGgga3ZtaV9tb25p
dG9yX2JwX2ludGVyY2VwdCgpICovCisJc21wX3dtYigpOworCVdSSVRFX09OQ0UodmNwdS0+YXJj
aC5rdm1pLCBhcmNoX3ZjcHVpKTsKKwogCXJldHVybiB0cnVlOwogfQogCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggNDE1OTM0NjI0YWZi
Li5mMTkyYzcxM2I3NDAgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNo
L3g4Ni9rdm0veDg2LmMKQEAgLTEwNTMzLDYgKzEwNTMzLDExIEBAIGludCBrdm1fYXJjaF92Y3B1
X3NldF9ndWVzdF9kZWJ1ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJCQlrdm1fcXVldWVfZXhj
ZXB0aW9uKHZjcHUsIEJQX1ZFQ1RPUik7CiAJfQogCisJaWYgKGt2bWlfbW9uaXRvcl9icF9pbnRl
cmNlcHQodmNwdSwgZGJnLT5jb250cm9sKSkgeworCQlyID0gLUVCVVNZOworCQlnb3RvIG91dDsK
Kwl9CisKIAkvKgogCSAqIFJlYWQgcmZsYWdzIGFzIGxvbmcgYXMgcG90ZW50aWFsbHkgaW5qZWN0
ZWQgdHJhY2UgZmxhZ3MgYXJlIHN0aWxsCiAJICogZmlsdGVyZWQgb3V0LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
