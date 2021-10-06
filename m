Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EFBC47084
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4DD610FC
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C4DD610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9FCC840B0;
	Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Avp5e6ITEsD0; Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51F1184086;
	Wed,  6 Oct 2021 17:40:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D588EC0031;
	Wed,  6 Oct 2021 17:40:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CE7C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DE3F83F6A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id do-Ck1AOhIrY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB08D83D41
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 31214307CAE6; Wed,  6 Oct 2021 20:30:59 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 157443064495;
 Wed,  6 Oct 2021 20:30:59 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 15/77] KVM: x86: add kvm_x86_ops.control_msr_intercept()
Date: Wed,  6 Oct 2021 20:30:11 +0300
Message-Id: <20211006173113.26445-16-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyBuZWVk
ZWQgZm9yIHRoZSBLVk1JX1ZDUFVfRVZFTlRfTVNSIGV2ZW50LCB3aGljaCBpcyB1c2VkIG5vdGlm
eQp0aGUgaW50cm9zcGVjdGlvbiB0b29sIGFib3V0IGFueSBjaGFuZ2UgbWFkZSB0byBhIE1TUiBv
ZiBpbnRlcmVzdC4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVu
ZGVyLmNvbT4KQ28tZGV2ZWxvcGVkLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xv
dWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5j
b20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCB8ICAxICsKIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggICAgfCAgMiArKwogYXJjaC94ODYva3ZtL3N2bS9z
dm0uYyAgICAgICAgICAgICB8IDExICsrKysrKysrKysrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5j
ICAgICAgICAgICAgIHwgIDcgKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgKaW5kZXggOTBlOTEzNDA4YzZlLi40MjI4
Yjc3NWE0OGUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaApAQCAtMTI4LDYgKzEyOCw3
IEBAIEtWTV9YODZfT1AoZGVzY19jdHJsX3N1cHBvcnRlZCkKIEtWTV9YODZfT1AoY29udHJvbF9k
ZXNjX2ludGVyY2VwdCkKIEtWTV9YODZfT1AoZGVzY19pbnRlcmNlcHRlZCkKIEtWTV9YODZfT1Ao
bXNyX3dyaXRlX2ludGVyY2VwdGVkKQorS1ZNX1g4Nl9PUChjb250cm9sX21zcl9pbnRlcmNlcHQp
CiAKICN1bmRlZiBLVk1fWDg2X09QCiAjdW5kZWYgS1ZNX1g4Nl9PUF9OVUxMCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
a3ZtX2hvc3QuaAppbmRleCA3OWIyZDhhYmZmMzYuLjI5ZjRlOGI2MTllMSAxMDA2NDQKLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oCkBAIC0xMzM1LDYgKzEzMzUsOCBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgewog
CXZvaWQgKCp1cGRhdGVfZXhjZXB0aW9uX2JpdG1hcCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsK
IAlpbnQgKCpnZXRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3JfZGF0YSAq
bXNyKTsKIAlpbnQgKCpzZXRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3Jf
ZGF0YSAqbXNyKTsKKwl2b2lkICgqY29udHJvbF9tc3JfaW50ZXJjZXB0KShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHVuc2lnbmVkIGludCBtc3IsCisJCQkJICAgICAgaW50IHR5cGUsIGJvb2wgZW5h
YmxlKTsKIAlib29sICgqbXNyX3dyaXRlX2ludGVyY2VwdGVkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHUzMiBtc3IpOwogCXU2NCAoKmdldF9zZWdtZW50X2Jhc2UpKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgaW50IHNlZyk7CiAJdm9pZCAoKmdldF9zZWdtZW50KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2
bS9zdm0uYwppbmRleCA5N2Y3NDA2Y2Y3ZDYuLmI3ZWYwNjcxODYzZSAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC03MTIs
NiArNzEyLDE2IEBAIHZvaWQgc2V0X21zcl9pbnRlcmNlcHRpb24oc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCB1MzIgKm1zcnBtLCB1MzIgbXNyLAogCXNldF9tc3JfaW50ZXJjZXB0aW9uX2JpdG1hcCh2
Y3B1LCBtc3JwbSwgbXNyLCB0eXBlLCB2YWx1ZSk7CiB9CiAKK3N0YXRpYyB2b2lkIHN2bV9jb250
cm9sX21zcl9pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBpbnQgbXNy
LAorCQkJCSAgICAgIGludCB0eXBlLCBib29sIGVuYWJsZSkKK3sKKwljb25zdCBzdHJ1Y3QgdmNw
dV9zdm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKwl1MzIgKm1zcnBtID0gaXNfZ3Vlc3RfbW9kZSh2
Y3B1KSA/IHN2bS0+bmVzdGVkLm1zcnBtIDoKKwkJCQkJICAgc3ZtLT5tc3JwbTsKKworCXNldF9t
c3JfaW50ZXJjZXB0aW9uKHZjcHUsIG1zcnBtLCBtc3IsIHR5cGUsIGVuYWJsZSk7Cit9CisKIHUz
MiAqc3ZtX3ZjcHVfYWxsb2NfbXNycG0odm9pZCkKIHsKIAl1bnNpZ25lZCBpbnQgb3JkZXIgPSBn
ZXRfb3JkZXIoTVNSUE1fU0laRSk7CkBAIC00NzE4LDYgKzQ3MjgsNyBAQCBzdGF0aWMgc3RydWN0
IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9tc3JfZmVhdHVy
ZSA9IHN2bV9nZXRfbXNyX2ZlYXR1cmUsCiAJLmdldF9tc3IgPSBzdm1fZ2V0X21zciwKIAkuc2V0
X21zciA9IHN2bV9zZXRfbXNyLAorCS5jb250cm9sX21zcl9pbnRlcmNlcHQgPSBzdm1fY29udHJv
bF9tc3JfaW50ZXJjZXB0LAogCS5tc3Jfd3JpdGVfaW50ZXJjZXB0ZWQgPSBtc3Jfd3JpdGVfaW50
ZXJjZXB0ZWQsCiAJLmdldF9zZWdtZW50X2Jhc2UgPSBzdm1fZ2V0X3NlZ21lbnRfYmFzZSwKIAku
Z2V0X3NlZ21lbnQgPSBzdm1fZ2V0X3NlZ21lbnQsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwppbmRleCBiMDM2YWVkOTY5MTIuLmEx
NDBkNjliMWJkMyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYworKysgYi9hcmNo
L3g4Ni9rdm0vdm14L3ZteC5jCkBAIC0zODU5LDYgKzM4NTksMTIgQEAgdm9pZCB2bXhfZW5hYmxl
X2ludGVyY2VwdF9mb3JfbXNyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIG1zciwgaW50IHR5
cGUpCiAJCXZteF9zZXRfbXNyX2JpdG1hcF93cml0ZShtc3JfYml0bWFwLCBtc3IpOwogfQogCitz
dGF0aWMgdm9pZCB2bXhfY29udHJvbF9tc3JfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgdW5zaWduZWQgaW50IG1zciwKKwkJCQkgICAgICBpbnQgdHlwZSwgYm9vbCBlbmFibGUpCit7
CisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBtc3IsIHR5cGUsIGVuYWJsZSk7Cit9
CisKIHN0YXRpYyB2b2lkIHZteF9yZXNldF94MmFwaWNfbXNycyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHU4IG1vZGUpCiB7CiAJdW5zaWduZWQgbG9uZyAqbXNyX2JpdG1hcCA9IHRvX3ZteCh2Y3B1
KS0+dm1jczAxLm1zcl9iaXRtYXA7CkBAIC03NjM3LDYgKzc2NDMsNyBAQCBzdGF0aWMgc3RydWN0
IGt2bV94ODZfb3BzIHZteF94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9tc3JfZmVhdHVy
ZSA9IHZteF9nZXRfbXNyX2ZlYXR1cmUsCiAJLmdldF9tc3IgPSB2bXhfZ2V0X21zciwKIAkuc2V0
X21zciA9IHZteF9zZXRfbXNyLAorCS5jb250cm9sX21zcl9pbnRlcmNlcHQgPSB2bXhfY29udHJv
bF9tc3JfaW50ZXJjZXB0LAogCS5tc3Jfd3JpdGVfaW50ZXJjZXB0ZWQgPSBtc3Jfd3JpdGVfaW50
ZXJjZXB0ZWQsCiAJLmdldF9zZWdtZW50X2Jhc2UgPSB2bXhfZ2V0X3NlZ21lbnRfYmFzZSwKIAku
Z2V0X3NlZ21lbnQgPSB2bXhfZ2V0X3NlZ21lbnQsCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
