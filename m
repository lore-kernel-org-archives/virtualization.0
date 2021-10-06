Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5EC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C5B61183
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5C5B61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 84AC740DAA;
	Wed,  6 Oct 2021 17:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ytLhCTvX8dK4; Wed,  6 Oct 2021 17:55:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 881C440D92;
	Wed,  6 Oct 2021 17:55:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7D3C0011;
	Wed,  6 Oct 2021 17:55:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2D7C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 603C360E95
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UELQqNsX0f5i
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C8EC60EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 47257307CAFB; Wed,  6 Oct 2021 20:31:10 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2DDC0305FFA0;
 Wed,  6 Oct 2021 20:31:10 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 40/77] KVM: introspection: add vCPU related data
Date: Wed,  6 Oct 2021 20:30:36 +0300
Message-Id: <20211006173113.26445-41-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 =?UTF-8?q?Mircea=20C=C3=AErjaliu?= <mcirjaliu@bitdefender.com>,
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

RnJvbTogTWlyY2VhIEPDrnJqYWxpdSA8bWNpcmphbGl1QGJpdGRlZmVuZGVyLmNvbT4KCkFkZCBh
biBpbnRyb3NwZWN0aW9uIHN0cnVjdHVyZSB0byBhbGwgdkNQVXMgd2hlbiB0aGUgVk0gaXMgaG9v
a2VkLgoKU2lnbmVkLW9mZi1ieTogTWlyY2VhIEPDrnJqYWxpdSA8bWNpcmphbGl1QGJpdGRlZmVu
ZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5k
ZXIuY29tPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oIHwgIDMgKysKIGlu
Y2x1ZGUvbGludXgva3ZtX2hvc3QuaCAgICAgICAgIHwgIDIgKysKIGluY2x1ZGUvbGludXgva3Zt
aV9ob3N0LmggICAgICAgIHwgIDYgKysrKwogdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1pLmMg
ICAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdmlydC9rdm0va3ZtX21h
aW4uYyAgICAgICAgICAgICAgfCAgMiArKwogNSBmaWxlcyBjaGFuZ2VkLCA2NCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtaV9ob3N0LmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rdm1pX2hvc3QuaAppbmRleCAzOGMzOTgyNjI5MTMuLjM2MGE1N2Rk
OTAxOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtaV9ob3N0LmgKKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtaV9ob3N0LmgKQEAgLTIsNiArMiw5IEBACiAjaWZuZGVm
IF9BU01fWDg2X0tWTUlfSE9TVF9ICiAjZGVmaW5lIF9BU01fWDg2X0tWTUlfSE9TVF9ICiAKK3N0
cnVjdCBrdm1fdmNwdV9hcmNoX2ludHJvc3BlY3Rpb24geworfTsKKwogc3RydWN0IGt2bV9hcmNo
X2ludHJvc3BlY3Rpb24gewogfTsKIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdm1faG9z
dC5oIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCmluZGV4IGY5ZjVjNjYxYzA1Ni4uMzBiZjEy
MjdjNGE3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKKysrIGIvaW5jbHVk
ZS9saW51eC9rdm1faG9zdC5oCkBAIC0zNjAsNiArMzYwLDggQEAgc3RydWN0IGt2bV92Y3B1IHsK
IAkgKiBpdCBpcyBhIHZhbGlkIHNsb3QuCiAJICovCiAJaW50IGxhc3RfdXNlZF9zbG90OworCisJ
c3RydWN0IGt2bV92Y3B1X2ludHJvc3BlY3Rpb24gKmt2bWk7CiB9OwogCiAvKiBtdXN0IGJlIGNh
bGxlZCB3aXRoIGlycXMgZGlzYWJsZWQgKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva3Zt
aV9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L2t2bWlfaG9zdC5oCmluZGV4IGE1OTMwN2RhYzZiZi4u
OWIwMDA4YzY2MzIxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2t2bWlfaG9zdC5oCisrKyBi
L2luY2x1ZGUvbGludXgva3ZtaV9ob3N0LmgKQEAgLTYsNiArNiwxMCBAQAogCiAjaW5jbHVkZSA8
YXNtL2t2bWlfaG9zdC5oPgogCitzdHJ1Y3Qga3ZtX3ZjcHVfaW50cm9zcGVjdGlvbiB7CisJc3Ry
dWN0IGt2bV92Y3B1X2FyY2hfaW50cm9zcGVjdGlvbiBhcmNoOworfTsKKwogc3RydWN0IGt2bV9p
bnRyb3NwZWN0aW9uIHsKIAlzdHJ1Y3Qga3ZtX2FyY2hfaW50cm9zcGVjdGlvbiBhcmNoOwogCXN0
cnVjdCBrdm0gKmt2bTsKQEAgLTI4LDYgKzMyLDcgQEAgaW50IGt2bWlfaW5pdCh2b2lkKTsKIHZv
aWQga3ZtaV91bmluaXQodm9pZCk7CiB2b2lkIGt2bWlfY3JlYXRlX3ZtKHN0cnVjdCBrdm0gKmt2
bSk7CiB2b2lkIGt2bWlfZGVzdHJveV92bShzdHJ1Y3Qga3ZtICprdm0pOwordm9pZCBrdm1pX3Zj
cHVfdW5pbml0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiAKIGludCBrdm1pX2lvY3RsX2hvb2so
c3RydWN0IGt2bSAqa3ZtLAogCQkgICAgY29uc3Qgc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9uX2hv
b2sgKmhvb2spOwpAQCAtNDUsNiArNTAsNyBAQCBzdGF0aWMgaW5saW5lIGludCBrdm1pX2luaXQo
dm9pZCkgeyByZXR1cm4gMDsgfQogc3RhdGljIGlubGluZSB2b2lkIGt2bWlfdW5pbml0KHZvaWQp
IHsgfQogc3RhdGljIGlubGluZSB2b2lkIGt2bWlfY3JlYXRlX3ZtKHN0cnVjdCBrdm0gKmt2bSkg
eyB9CiBzdGF0aWMgaW5saW5lIHZvaWQga3ZtaV9kZXN0cm95X3ZtKHN0cnVjdCBrdm0gKmt2bSkg
eyB9CitzdGF0aWMgaW5saW5lIHZvaWQga3ZtaV92Y3B1X3VuaW5pdChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpIHsgfQogCiAjZW5kaWYgLyogQ09ORklHX0tWTV9JTlRST1NQRUNUSU9OICovCiAKZGlm
ZiAtLWdpdCBhL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaS5jIGIvdmlydC9rdm0vaW50cm9z
cGVjdGlvbi9rdm1pLmMKaW5kZXggMjA3ZGFiYjhiMDQwLi40OTJhMjk5ODc5NjUgMTAwNjQ0Ci0t
LSBhL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaS5jCisrKyBiL3ZpcnQva3ZtL2ludHJvc3Bl
Y3Rpb24va3ZtaS5jCkBAIC0xMTgsOCArMTE4LDQxIEBAIHZvaWQga3ZtaV91bmluaXQodm9pZCkK
IAlrdm1pX2NhY2hlX2Rlc3Ryb3koKTsKIH0KIAorc3RhdGljIGJvb2wga3ZtaV9hbGxvY192Y3B1
aShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IGt2bV92Y3B1X2ludHJvc3BlY3Rp
b24gKnZjcHVpOworCisJdmNwdWkgPSBremFsbG9jKHNpemVvZigqdmNwdWkpLCBHRlBfS0VSTkVM
KTsKKwlpZiAoIXZjcHVpKQorCQlyZXR1cm4gZmFsc2U7CisKKwl2Y3B1LT5rdm1pID0gdmNwdWk7
CisKKwlyZXR1cm4gdHJ1ZTsKK30KKworc3RhdGljIGludCBrdm1pX2NyZWF0ZV92Y3B1aShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKCFrdm1pX2FsbG9jX3ZjcHVpKHZjcHUpKQorCQly
ZXR1cm4gLUVOT01FTTsKKworCXJldHVybiAwOworfQorCitzdGF0aWMgdm9pZCBrdm1pX2ZyZWVf
dmNwdWkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQoreworCWtmcmVlKHZjcHUtPmt2bWkpOworCXZj
cHUtPmt2bWkgPSBOVUxMOworfQorCiBzdGF0aWMgdm9pZCBrdm1pX2ZyZWUoc3RydWN0IGt2bSAq
a3ZtKQogeworCXN0cnVjdCBrdm1fdmNwdSAqdmNwdTsKKwlpbnQgaTsKKworCWt2bV9mb3JfZWFj
aF92Y3B1KGksIHZjcHUsIGt2bSkKKwkJa3ZtaV9mcmVlX3ZjcHVpKHZjcHUpOworCiAJYml0bWFw
X2ZyZWUoa3ZtLT5rdm1pLT5jbWRfYWxsb3dfbWFzayk7CiAJYml0bWFwX2ZyZWUoa3ZtLT5rdm1p
LT5ldmVudF9hbGxvd19tYXNrKTsKIAliaXRtYXBfZnJlZShrdm0tPmt2bWktPnZtX2V2ZW50X2Vu
YWJsZV9tYXNrKTsKQEAgLTEyOCwxMCArMTYxLDE5IEBAIHN0YXRpYyB2b2lkIGt2bWlfZnJlZShz
dHJ1Y3Qga3ZtICprdm0pCiAJa3ZtLT5rdm1pID0gTlVMTDsKIH0KIAordm9pZCBrdm1pX3ZjcHVf
dW5pbml0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKK3sKKwltdXRleF9sb2NrKCZ2Y3B1LT5rdm0t
Pmt2bWlfbG9jayk7CisJa3ZtaV9mcmVlX3ZjcHVpKHZjcHUpOworCW11dGV4X3VubG9jaygmdmNw
dS0+a3ZtLT5rdm1pX2xvY2spOworfQorCiBzdGF0aWMgc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9u
ICoKIGt2bWlfYWxsb2Moc3RydWN0IGt2bSAqa3ZtLCBjb25zdCBzdHJ1Y3Qga3ZtX2ludHJvc3Bl
Y3Rpb25faG9vayAqaG9vaykKIHsKIAlzdHJ1Y3Qga3ZtX2ludHJvc3BlY3Rpb24gKmt2bWk7CisJ
c3RydWN0IGt2bV92Y3B1ICp2Y3B1OworCWludCBpOwogCiAJa3ZtaSA9IGt6YWxsb2Moc2l6ZW9m
KCprdm1pKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFrdm1pKQpAQCAtMTU3LDYgKzE5OSwxNSBAQCBr
dm1pX2FsbG9jKHN0cnVjdCBrdm0gKmt2bSwgY29uc3Qgc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9u
X2hvb2sgKmhvb2spCiAKIAlhdG9taWNfc2V0KCZrdm1pLT5ldl9zZXEsIDApOwogCisJa3ZtX2Zv
cl9lYWNoX3ZjcHUoaSwgdmNwdSwga3ZtKSB7CisJCWludCBlcnIgPSBrdm1pX2NyZWF0ZV92Y3B1
aSh2Y3B1KTsKKworCQlpZiAoZXJyKSB7CisJCQlrdm1pX2ZyZWUoa3ZtKTsKKwkJCXJldHVybiBO
VUxMOworCQl9CisJfQorCiAJa3ZtaS0+a3ZtID0ga3ZtOwogCiAJcmV0dXJuIGt2bWk7CmRpZmYg
LS1naXQgYS92aXJ0L2t2bS9rdm1fbWFpbi5jIGIvdmlydC9rdm0va3ZtX21haW4uYwppbmRleCBi
MGEyM2ZjYjkzNWMuLmQ3MGVjMTEwNjk2ZiAxMDA2NDQKLS0tIGEvdmlydC9rdm0va3ZtX21haW4u
YworKysgYi92aXJ0L2t2bS9rdm1fbWFpbi5jCkBAIC00NDEsNiArNDQxLDcgQEAgc3RhdGljIHZv
aWQga3ZtX3ZjcHVfaW5pdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm0gKmt2bSwg
dW5zaWduZWQgaWQpCiAKIHZvaWQga3ZtX3ZjcHVfZGVzdHJveShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUpCiB7CisJa3ZtaV92Y3B1X3VuaW5pdCh2Y3B1KTsKIAlrdm1fZGlydHlfcmluZ19mcmVlKCZ2
Y3B1LT5kaXJ0eV9yaW5nKTsKIAlrdm1fYXJjaF92Y3B1X2Rlc3Ryb3kodmNwdSk7CiAKQEAgLTM2
OTQsNiArMzY5NSw3IEBAIHN0YXRpYyBpbnQga3ZtX3ZtX2lvY3RsX2NyZWF0ZV92Y3B1KHN0cnVj
dCBrdm0gKmt2bSwgdTMyIGlkKQogCiB1bmxvY2tfdmNwdV9kZXN0cm95OgogCW11dGV4X3VubG9j
aygma3ZtLT5sb2NrKTsKKwlrdm1pX3ZjcHVfdW5pbml0KHZjcHUpOwogCWt2bV9kaXJ0eV9yaW5n
X2ZyZWUoJnZjcHUtPmRpcnR5X3JpbmcpOwogYXJjaF92Y3B1X2Rlc3Ryb3k6CiAJa3ZtX2FyY2hf
dmNwdV9kZXN0cm95KHZjcHUpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
