Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C18C43219
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A54661151
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A54661151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2685408E7;
	Wed,  6 Oct 2021 17:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8_56d2cXhIux; Wed,  6 Oct 2021 17:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED9A5408F5;
	Wed,  6 Oct 2021 17:40:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E60C0028;
	Wed,  6 Oct 2021 17:40:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF88C0024
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05B7283F35
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R3fUNBPRjmZz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F267683F5B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 692C6307CA9E; Wed,  6 Oct 2021 20:30:54 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 50E9A3064495;
 Wed,  6 Oct 2021 20:30:54 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 04/77] KVM: x86: add kvm_arch_vcpu_set_regs()
Date: Wed,  6 Oct 2021 20:30:00 +0300
Message-Id: <20211006173113.26445-5-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgaXMgbmVl
ZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX1NFVF9SRUdJU1RFUlMgY29tbWFuZCwgd2hpY2ggYWxsb3dz
CmFuIGludHJvc3BlY3Rpb24gdG9vbCB0byBvdmVycmlkZSB0aGUga3ZtX3JlZ3Mgc3RydWN0dXJl
IGZvciBhIHNwZWNpZmljCnZDUFUgd2l0aG91dCBjbGVhcmluZyB0aGUgcGVuZGluZyBleGNlcHRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+
Ci0tLQogYXJjaC94ODYva3ZtL3g4Ni5jICAgICAgIHwgMTMgKysrKysrKysrKy0tLQogaW5jbHVk
ZS9saW51eC9rdm1faG9zdC5oIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9h
cmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggZjdkMDk3NTdiODVmLi5iYmNkMjU2ZGMyZjQgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMKQEAgLTEw
MTA0LDggKzEwMTA0LDE1IEBAIHN0YXRpYyB2b2lkIF9fc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpCiAKIAlrdm1fcmlwX3dyaXRlKHZjcHUsIHJl
Z3MtPnJpcCk7CiAJa3ZtX3NldF9yZmxhZ3ModmNwdSwgcmVncy0+cmZsYWdzIHwgWDg2X0VGTEFH
U19GSVhFRCk7Cit9CisKK3ZvaWQga3ZtX2FyY2hfdmNwdV9zZXRfcmVncyhzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncywKKwkJCSAgICBib29sIGNsZWFyX2V4Y2Vw
dGlvbikKK3sKKwlfX3NldF9yZWdzKHZjcHUsIHJlZ3MpOwogCi0JdmNwdS0+YXJjaC5leGNlcHRp
b24ucGVuZGluZyA9IGZhbHNlOworCWlmIChjbGVhcl9leGNlcHRpb24pCisJCXZjcHUtPmFyY2gu
ZXhjZXB0aW9uLnBlbmRpbmcgPSBmYWxzZTsKIAogCWt2bV9tYWtlX3JlcXVlc3QoS1ZNX1JFUV9F
VkVOVCwgdmNwdSk7CiB9CkBAIC0xMDExMyw3ICsxMDEyMCw3IEBAIHN0YXRpYyB2b2lkIF9fc2V0
X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpCiBpbnQg
a3ZtX2FyY2hfdmNwdV9pb2N0bF9zZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVj
dCBrdm1fcmVncyAqcmVncykKIHsKIAl2Y3B1X2xvYWQodmNwdSk7Ci0JX19zZXRfcmVncyh2Y3B1
LCByZWdzKTsKKwlrdm1fYXJjaF92Y3B1X3NldF9yZWdzKHZjcHUsIHJlZ3MsIHRydWUpOwogCXZj
cHVfcHV0KHZjcHUpOwogCXJldHVybiAwOwogfQpAQCAtMTA2MDEsNyArMTA2MDgsNyBAQCBzdGF0
aWMgdm9pZCBzdG9yZV9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIHN0YXRpYyBpbnQgc3lu
Y19yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIHsKIAlpZiAodmNwdS0+cnVuLT5rdm1fZGly
dHlfcmVncyAmIEtWTV9TWU5DX1g4Nl9SRUdTKSB7Ci0JCV9fc2V0X3JlZ3ModmNwdSwgJnZjcHUt
PnJ1bi0+cy5yZWdzLnJlZ3MpOworCQlrdm1fYXJjaF92Y3B1X3NldF9yZWdzKHZjcHUsICZ2Y3B1
LT5ydW4tPnMucmVncy5yZWdzLCB0cnVlKTsKIAkJdmNwdS0+cnVuLT5rdm1fZGlydHlfcmVncyAm
PSB+S1ZNX1NZTkNfWDg2X1JFR1M7CiAJfQogCWlmICh2Y3B1LT5ydW4tPmt2bV9kaXJ0eV9yZWdz
ICYgS1ZNX1NZTkNfWDg2X1NSRUdTKSB7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2t2bV9o
b3N0LmggYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKaW5kZXggN2JjNDVlMTg3OWRiLi43MTI2
NDJiZTMzMDcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaAorKysgYi9pbmNs
dWRlL2xpbnV4L2t2bV9ob3N0LmgKQEAgLTEwMjgsNiArMTAyOCw4IEBAIGludCBrdm1fYXJjaF92
Y3B1X2lvY3RsX3RyYW5zbGF0ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiBpbnQga3ZtX2FyY2hf
dmNwdV9pb2N0bF9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVn
cyAqcmVncyk7CiB2b2lkIGt2bV9hcmNoX3ZjcHVfZ2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpOwogaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0
X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpOwordm9p
ZCBrdm1fYXJjaF92Y3B1X3NldF9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2
bV9yZWdzICpyZWdzLAorCQkJICAgIGJvb2wgY2xlYXJfZXhjZXB0aW9uKTsKIGludCBrdm1fYXJj
aF92Y3B1X2lvY3RsX2dldF9zcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJCQkJICBzdHJ1
Y3Qga3ZtX3NyZWdzICpzcmVncyk7CiB2b2lkIGt2bV9hcmNoX3ZjcHVfZ2V0X3NyZWdzKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
