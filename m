Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ABC4332F
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42173610FC
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42173610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40AB2840D7;
	Wed,  6 Oct 2021 17:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQk5X5JFwJr8; Wed,  6 Oct 2021 17:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DB05E840B1;
	Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0802C0029;
	Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B3BBC0023
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67AF9405CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NY-7DlDrVCIh
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C2D1408E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 A5A60307CADD; Wed,  6 Oct 2021 20:30:55 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 8C1FB3064495;
 Wed,  6 Oct 2021 20:30:55 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 07/77] KVM: x86: add kvm_x86_ops.control_cr3_intercept()
Date: Wed,  6 Oct 2021 20:30:03 +0300
Message-Id: <20211006173113.26445-8-alazar@bitdefender.com>
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

VGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBLVk1JX1ZDUFVfQ09OVFJPTF9DUiBjb21t
YW5kLCB3aGVuIHRoZQppbnRyb3NwZWN0aW9uIHRvb2wgaGFzIHRvIGludGVyY2VwdCB0aGUgcmVh
ZC93cml0ZSBhY2Nlc3MgdG8gQ1IzLgoKQ28tZGV2ZWxvcGVkLWJ5OiBOaWN1yJlvciBDw67Im3Ug
PG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5p
Y3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXph
ckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMu
aCB8ICAxICsKIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggICAgfCAgNiArKysrKysK
IGFyY2gveDg2L2t2bS9zdm0vc3ZtLmMgICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysrKwog
YXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysr
KwogNCBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14
ODYtb3BzLmgKaW5kZXggMzFhZjI1MWM1NjIyLi5lMWY2M2QzNmVmYjcgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20va3ZtLXg4Ni1vcHMuaApAQCAtMTIyLDYgKzEyMiw3IEBAIEtWTV9YODZfT1BfTlVMTChtaWdy
YXRlX3RpbWVycykKIEtWTV9YODZfT1AobXNyX2ZpbHRlcl9jaGFuZ2VkKQogS1ZNX1g4Nl9PUF9O
VUxMKGNvbXBsZXRlX2VtdWxhdGVkX21zcikKIEtWTV9YODZfT1AoYnBfaW50ZXJjZXB0ZWQpCitL
Vk1fWDg2X09QKGNvbnRyb2xfY3IzX2ludGVyY2VwdCkKIAogI3VuZGVmIEtWTV9YODZfT1AKICN1
bmRlZiBLVk1fWDg2X09QX05VTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IDI2YTUyNTIw
YjhiZC4uODlkNTNlNTVlMWY5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTE0Niw2ICsx
NDYsMTAgQEAKICNkZWZpbmUgS1ZNX05SX0ZJWEVEX01UUlJfUkVHSU9OIDg4CiAjZGVmaW5lIEtW
TV9OUl9WQVJfTVRSUiA4CiAKKyNkZWZpbmUgQ1JfVFlQRV9SCTEKKyNkZWZpbmUgQ1JfVFlQRV9X
CTIKKyNkZWZpbmUgQ1JfVFlQRV9SVwkzCisKICNkZWZpbmUgQVNZTkNfUEZfUEVSX1ZDUFUgNjQK
IAogZW51bSBrdm1fcmVnIHsKQEAgLTEzMzcsNiArMTM0MSw4IEBAIHN0cnVjdCBrdm1feDg2X29w
cyB7CiAJdm9pZCAoKnNldF9jcjApKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9u
ZyBjcjApOwogCWJvb2wgKCppc192YWxpZF9jcjQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5z
aWduZWQgbG9uZyBjcjApOwogCXZvaWQgKCpzZXRfY3I0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHVuc2lnbmVkIGxvbmcgY3I0KTsKKwl2b2lkICgqY29udHJvbF9jcjNfaW50ZXJjZXB0KShzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCB0eXBlLAorCQkJCSAgICAgIGJvb2wgZW5hYmxlKTsKIAlp
bnQgKCpzZXRfZWZlcikoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZWZlcik7CiAJdm9pZCAo
KmdldF9pZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CiAJ
dm9pZCAoKnNldF9pZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpk
dCk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2
bS9zdm0uYwppbmRleCBhYmVjYzEyMzQxNjEuLjVhMDUxZmExOWM3ZSAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0xODUw
LDYgKzE4NTAsMTkgQEAgdm9pZCBzdm1fc2V0X2NyNChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVu
c2lnbmVkIGxvbmcgY3I0KQogCQlrdm1fdXBkYXRlX2NwdWlkX3J1bnRpbWUodmNwdSk7CiB9CiAK
K3N0YXRpYyB2b2lkIHN2bV9jb250cm9sX2NyM19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCBpbnQgdHlwZSwKKwkJCQkgICAgICBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgdmNwdV9z
dm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKworCWlmICh0eXBlICYgQ1JfVFlQRV9SKQorCQllbmFi
bGUgPyBzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9DUjNfUkVBRCkgOgorCQkJIHN2
bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0NSM19SRUFEKTsKKwlpZiAodHlwZSAmIENS
X1RZUEVfVykKKwkJZW5hYmxlID8gc3ZtX3NldF9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfQ1Iz
X1dSSVRFKSA6CisJCQkgc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfQ1IzX1dSSVRF
KTsKK30KKwogc3RhdGljIHZvaWQgc3ZtX3NldF9zZWdtZW50KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwKIAkJCSAgICBzdHJ1Y3Qga3ZtX3NlZ21lbnQgKnZhciwgaW50IHNlZykKIHsKQEAgLTQ2MjAs
NiArNDYzMyw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgc3ZtX3g4Nl9vcHMgX19pbml0
ZGF0YSA9IHsKIAkuc2V0X2NyMCA9IHN2bV9zZXRfY3IwLAogCS5pc192YWxpZF9jcjQgPSBzdm1f
aXNfdmFsaWRfY3I0LAogCS5zZXRfY3I0ID0gc3ZtX3NldF9jcjQsCisJLmNvbnRyb2xfY3IzX2lu
dGVyY2VwdCA9IHN2bV9jb250cm9sX2NyM19pbnRlcmNlcHQsCiAJLnNldF9lZmVyID0gc3ZtX3Nl
dF9lZmVyLAogCS5nZXRfaWR0ID0gc3ZtX2dldF9pZHQsCiAJLnNldF9pZHQgPSBzdm1fc2V0X2lk
dCwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14
L3ZteC5jCmluZGV4IDZmZGMzZDEwYjJiNC4uYzhmNWJjMzcxZjM4IDEwMDY0NAotLS0gYS9hcmNo
L3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTMwMDQs
NiArMzAwNCwyMyBAQCB2b2lkIGVwdF9zYXZlX3BkcHRycyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUp
CiAjZGVmaW5lIENSM19FWElUSU5HX0JJVFMgKENQVV9CQVNFRF9DUjNfTE9BRF9FWElUSU5HIHwg
XAogCQkJICBDUFVfQkFTRURfQ1IzX1NUT1JFX0VYSVRJTkcpCiAKK3N0YXRpYyB2b2lkIHZteF9j
b250cm9sX2NyM19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgdHlwZSwKKwkJ
CQkgICAgICBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgdmNwdV92bXggKnZteCA9IHRvX3ZteCh2
Y3B1KTsKKwl1MzIgY3IzX2V4ZWNfY29udHJvbCA9IDA7CisKKwlpZiAodHlwZSAmIENSX1RZUEVf
UikKKwkJY3IzX2V4ZWNfY29udHJvbCB8PSBDUFVfQkFTRURfQ1IzX1NUT1JFX0VYSVRJTkc7CisJ
aWYgKHR5cGUgJiBDUl9UWVBFX1cpCisJCWNyM19leGVjX2NvbnRyb2wgfD0gQ1BVX0JBU0VEX0NS
M19MT0FEX0VYSVRJTkc7CisKKwlpZiAoZW5hYmxlKQorCQlleGVjX2NvbnRyb2xzX3NldGJpdCh2
bXgsIGNyM19leGVjX2NvbnRyb2wpOworCWVsc2UKKwkJZXhlY19jb250cm9sc19jbGVhcmJpdCh2
bXgsIGNyM19leGVjX2NvbnRyb2wpOworfQorCiB2b2lkIHZteF9zZXRfY3IwKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyBjcjApCiB7CiAJc3RydWN0IHZjcHVfdm14ICp2bXgg
PSB0b192bXgodmNwdSk7CkBAIC03NjA0LDYgKzc2MjEsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94
ODZfb3BzIHZteF94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLnNldF9jcjAgPSB2bXhfc2V0X2Ny
MCwKIAkuaXNfdmFsaWRfY3I0ID0gdm14X2lzX3ZhbGlkX2NyNCwKIAkuc2V0X2NyNCA9IHZteF9z
ZXRfY3I0LAorCS5jb250cm9sX2NyM19pbnRlcmNlcHQgPSB2bXhfY29udHJvbF9jcjNfaW50ZXJj
ZXB0LAogCS5zZXRfZWZlciA9IHZteF9zZXRfZWZlciwKIAkuZ2V0X2lkdCA9IHZteF9nZXRfaWR0
LAogCS5zZXRfaWR0ID0gdm14X3NldF9pZHQsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
