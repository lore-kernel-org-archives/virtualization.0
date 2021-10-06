Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2899DC4321E
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F3C61151
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8F3C61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 798CC60F04;
	Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9A1-jSJqRwy; Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E0E5460EFC;
	Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5AC5C002A;
	Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2113AC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D6D460EE9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qts_uMvtl7ZN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82C676068F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 07AA1307C930; Wed,  6 Oct 2021 20:30:54 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id DF7FD3064495;
 Wed,  6 Oct 2021 20:30:53 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 03/77] KVM: x86: add kvm_arch_vcpu_get_regs() and
 kvm_arch_vcpu_get_sregs()
Date: Wed,  6 Oct 2021 20:29:59 +0300
Message-Id: <20211006173113.26445-4-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 Jim Mattson <jmattson@google.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhlc2UgZnVuY3Rp
b25zIGFyZSB1c2VkIGJ5IHRoZSBWTSBpbnRyb3NwZWN0aW9uIGNvZGUKKGZvciB0aGUgS1ZNSV9W
Q1BVX0dFVF9SRUdJU1RFUlMgY29tbWFuZCBhbmQgYWxsIGV2ZW50cyBzZW5kaW5nIHRoZSB2Q1BV
CnJlZ2lzdGVycyB0byB0aGUgaW50cm9zcGVjdGlvbiB0b29sKS4KClNpZ25lZC1vZmYtYnk6IE1p
aGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJl
cnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2t2bS94ODYu
YyAgICAgICB8IDEwICsrKysrKysrKysKIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCB8ICAzICsr
KwogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IGRiN2ZhMTM5OGYwZC4uZjdk
MDk3NTdiODVmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYv
a3ZtL3g4Ni5jCkBAIC0xMDA3Myw2ICsxMDA3MywxMSBAQCBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0
bF9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncykK
IAlyZXR1cm4gMDsKIH0KIAordm9pZCBrdm1fYXJjaF92Y3B1X2dldF9yZWdzKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwgc3RydWN0IGt2bV9yZWdzICpyZWdzKQoreworCV9fZ2V0X3JlZ3ModmNwdSwg
cmVncyk7Cit9CisKIHN0YXRpYyB2b2lkIF9fc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpCiB7CiAJdmNwdS0+YXJjaC5lbXVsYXRlX3JlZ3NfbmVl
ZF9zeW5jX2Zyb21fdmNwdSA9IHRydWU7CkBAIC0xMDE5NSw2ICsxMDIwMCwxMSBAQCBpbnQga3Zt
X2FyY2hfdmNwdV9pb2N0bF9nZXRfc3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCXJldHVy
biAwOwogfQogCit2b2lkIGt2bV9hcmNoX3ZjcHVfZ2V0X3NyZWdzKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgc3RydWN0IGt2bV9zcmVncyAqc3JlZ3MpCit7CisJX19nZXRfc3JlZ3ModmNwdSwgc3Jl
Z3MpOworfQorCiBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0bF9nZXRfbXBzdGF0ZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsCiAJCQkJICAgIHN0cnVjdCBrdm1fbXBfc3RhdGUgKm1wX3N0YXRlKQogewpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oIGIvaW5jbHVkZS9saW51eC9rdm1f
aG9zdC5oCmluZGV4IDY3OTVlYTdlMzU3ZC4uN2JjNDVlMTg3OWRiIDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L2t2bV9ob3N0LmgKKysrIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCkBAIC0x
MDI2LDkgKzEwMjYsMTIgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfdHJhbnNsYXRlKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwKIAkJCQkgICAgc3RydWN0IGt2bV90cmFuc2xhdGlvbiAqdHIpOwog
CiBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0bF9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHN0cnVjdCBrdm1fcmVncyAqcmVncyk7Cit2b2lkIGt2bV9hcmNoX3ZjcHVfZ2V0X3JlZ3Moc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpOwogaW50IGt2bV9hcmNo
X3ZjcHVfaW9jdGxfc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3Jl
Z3MgKnJlZ3MpOwogaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfZ2V0X3NyZWdzKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwKIAkJCQkgIHN0cnVjdCBrdm1fc3JlZ3MgKnNyZWdzKTsKK3ZvaWQga3ZtX2Fy
Y2hfdmNwdV9nZXRfc3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQkJCSAgc3RydWN0IGt2
bV9zcmVncyAqc3JlZ3MpOwogaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0X3NyZWdzKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwKIAkJCQkgIHN0cnVjdCBrdm1fc3JlZ3MgKnNyZWdzKTsKIGludCBr
dm1fYXJjaF92Y3B1X2lvY3RsX2dldF9tcHN0YXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
