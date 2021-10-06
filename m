Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722ADC4321E
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C37A61151
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C37A61151
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1691B407E5;
	Wed,  6 Oct 2021 17:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dBrX8pKrpWZ1; Wed,  6 Oct 2021 17:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDF8840D91;
	Wed,  6 Oct 2021 17:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDDF0C0030;
	Wed,  6 Oct 2021 17:40:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21E4CC0030
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3350883E2E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBtnNCubz7ye
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEF8583F30
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 62BB1305CD45; Wed,  6 Oct 2021 20:30:57 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 496923064495;
 Wed,  6 Oct 2021 20:30:57 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 11/77] KVM: x86: add kvm_x86_ops.control_desc_intercept()
Date: Wed,  6 Oct 2021 20:30:07 +0300
Message-Id: <20211006173113.26445-12-alazar@bitdefender.com>
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

VGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgdG8gaW50ZXJjZXB0IGRlc2NyaXB0b3ItdGFibGUgcmVn
aXN0ZXJzIGFjY2Vzcy4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJp
dGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oIHwg
IDEgKwogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICB8ICAxICsKIGFyY2gveDg2
L2t2bS9zdm0vc3ZtLmMgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysr
KwogYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysrKyst
LQogNCBmaWxlcyBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oCmluZGV4IDlhOTYyYmQwOThkMC4uZGQwOGYzMTIwZjhm
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgKQEAgLTEyNSw2ICsxMjUsNyBAQCBLVk1f
WDg2X09QKGJwX2ludGVyY2VwdGVkKQogS1ZNX1g4Nl9PUChjb250cm9sX2NyM19pbnRlcmNlcHQp
CiBLVk1fWDg2X09QKGNyM193cml0ZV9pbnRlcmNlcHRlZCkKIEtWTV9YODZfT1AoZGVzY19jdHJs
X3N1cHBvcnRlZCkKK0tWTV9YODZfT1AoY29udHJvbF9kZXNjX2ludGVyY2VwdCkKIAogI3VuZGVm
IEtWTV9YODZfT1AKICN1bmRlZiBLVk1fWDg2X09QX05VTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5o
CmluZGV4IDFhY2FhMjdmZmQ4Zi4uMmU1ZGRiMTg4MDRiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0
LmgKQEAgLTEzNTAsNiArMTM1MCw3IEBAIHN0cnVjdCBrdm1feDg2X29wcyB7CiAJdm9pZCAoKmdl
dF9nZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CiAJdm9p
ZCAoKnNldF9nZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7
CiAJYm9vbCAoKmRlc2NfY3RybF9zdXBwb3J0ZWQpKHZvaWQpOworCXZvaWQgKCpjb250cm9sX2Rl
c2NfaW50ZXJjZXB0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgZW5hYmxlKTsKIAl2b2lk
ICgqc3luY19kaXJ0eV9kZWJ1Z19yZWdzKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCXZvaWQg
KCpzZXRfZHI3KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgdmFsdWUpOwog
CXZvaWQgKCpjYWNoZV9yZWcpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZW51bSBrdm1fcmVnIHJl
Zyk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2
bS9zdm0uYwppbmRleCBlNWNkODgxM2NjYTYuLjBkNDZmNWFhMjBjMyAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0xNzgw
LDYgKzE3ODAsMzEgQEAgc3RhdGljIGJvb2wgc3ZtX2Rlc2NfY3RybF9zdXBwb3J0ZWQodm9pZCkK
IAlyZXR1cm4gdHJ1ZTsKIH0KIAorc3RhdGljIHZvaWQgc3ZtX2NvbnRyb2xfZGVzY19pbnRlcmNl
cHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgdmNwdV9z
dm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKworCWlmIChlbmFibGUpIHsKKwkJc3ZtX3NldF9pbnRl
cmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfSURUUik7CisJCXN2bV9zZXRfaW50ZXJjZXB0KHN2
bSwgSU5URVJDRVBUX1NUT1JFX0dEVFIpOworCQlzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVS
Q0VQVF9TVE9SRV9MRFRSKTsKKwkJc3ZtX3NldF9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RP
UkVfVFIpOworCQlzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9MT0FEX0lEVFIpOwor
CQlzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9MT0FEX0dEVFIpOworCQlzdm1fc2V0
X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9MT0FEX0xEVFIpOworCQlzdm1fc2V0X2ludGVyY2Vw
dChzdm0sIElOVEVSQ0VQVF9MT0FEX1RSKTsKKwl9IGVsc2UgeworCQlzdm1fY2xyX2ludGVyY2Vw
dChzdm0sIElOVEVSQ0VQVF9TVE9SRV9JRFRSKTsKKwkJc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJ
TlRFUkNFUFRfU1RPUkVfR0RUUik7CisJCXN2bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBU
X1NUT1JFX0xEVFIpOworCQlzdm1fY2xyX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9U
Uik7CisJCXN2bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfSURUUik7CisJCXN2
bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfR0RUUik7CisJCXN2bV9jbHJfaW50
ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfTERUUik7CisJCXN2bV9jbHJfaW50ZXJjZXB0KHN2
bSwgSU5URVJDRVBUX0xPQURfVFIpOworCX0KK30KKwogdm9pZCBzdm1fc2V0X2NyMChzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgY3IwKQogewogCXN0cnVjdCB2Y3B1X3N2bSAq
c3ZtID0gdG9fc3ZtKHZjcHUpOwpAQCAtNDY2Niw2ICs0NjkxLDcgQEAgc3RhdGljIHN0cnVjdCBr
dm1feDg2X29wcyBzdm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5nZXRfZ2R0ID0gc3ZtX2dl
dF9nZHQsCiAJLnNldF9nZHQgPSBzdm1fc2V0X2dkdCwKIAkuZGVzY19jdHJsX3N1cHBvcnRlZCA9
IHN2bV9kZXNjX2N0cmxfc3VwcG9ydGVkLAorCS5jb250cm9sX2Rlc2NfaW50ZXJjZXB0ID0gc3Zt
X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQsCiAJLnNldF9kcjcgPSBzdm1fc2V0X2RyNywKIAkuc3lu
Y19kaXJ0eV9kZWJ1Z19yZWdzID0gc3ZtX3N5bmNfZGlydHlfZGVidWdfcmVncywKIAkuY2FjaGVf
cmVnID0gc3ZtX2NhY2hlX3JlZywKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMg
Yi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IDAyNmQ2NzhiODJiOS4uZDBmMDJkNTJiNDAx
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92
bXgvdm14LmMKQEAgLTMxNjAsNiArMzE2MCwxNiBAQCBzdGF0aWMgdm9pZCB2bXhfbG9hZF9tbXVf
cGdkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaHBhX3Qgcm9vdF9ocGEsCiAJCXZtY3Nfd3JpdGVs
KEdVRVNUX0NSMywgZ3Vlc3RfY3IzKTsKIH0KIAorc3RhdGljIHZvaWQgdm14X2NvbnRyb2xfZGVz
Y19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSkKK3sKKwlzdHJ1
Y3QgdmNwdV92bXggKnZteCA9IHRvX3ZteCh2Y3B1KTsKKworCWlmIChlbmFibGUpCisJCXNlY29u
ZGFyeV9leGVjX2NvbnRyb2xzX3NldGJpdCh2bXgsIFNFQ09OREFSWV9FWEVDX0RFU0MpOworCWVs
c2UKKwkJc2Vjb25kYXJ5X2V4ZWNfY29udHJvbHNfY2xlYXJiaXQodm14LCBTRUNPTkRBUllfRVhF
Q19ERVNDKTsKK30KKwogc3RhdGljIGJvb2wgdm14X2lzX3ZhbGlkX2NyNChzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgY3I0KQogewogCS8qCkBAIC0zMTk3LDExICszMjA3LDEx
IEBAIHZvaWQgdm14X3NldF9jcjQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBsb25n
IGNyNCkKIAogCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX1VNSVApICYmIHZteF91bWlw
X2VtdWxhdGVkKCkpIHsKIAkJaWYgKGNyNCAmIFg4Nl9DUjRfVU1JUCkgewotCQkJc2Vjb25kYXJ5
X2V4ZWNfY29udHJvbHNfc2V0Yml0KHZteCwgU0VDT05EQVJZX0VYRUNfREVTQyk7CisJCQl2bXhf
Y29udHJvbF9kZXNjX2ludGVyY2VwdCh2Y3B1LCB0cnVlKTsKIAkJCWh3X2NyNCAmPSB+WDg2X0NS
NF9VTUlQOwogCQl9IGVsc2UgaWYgKCFpc19ndWVzdF9tb2RlKHZjcHUpIHx8CiAJCQkhbmVzdGVk
X2NwdV9oYXMyKGdldF92bWNzMTIodmNwdSksIFNFQ09OREFSWV9FWEVDX0RFU0MpKSB7Ci0JCQlz
ZWNvbmRhcnlfZXhlY19jb250cm9sc19jbGVhcmJpdCh2bXgsIFNFQ09OREFSWV9FWEVDX0RFU0Mp
OworCQkJdm14X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQodmNwdSwgZmFsc2UpOwogCQl9CiAJfQog
CkBAIC03NjM2LDYgKzc2NDYsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHZteF94ODZf
b3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9nZHQgPSB2bXhfZ2V0X2dkdCwKIAkuc2V0X2dkdCA9
IHZteF9zZXRfZ2R0LAogCS5kZXNjX2N0cmxfc3VwcG9ydGVkID0gdm14X2Rlc2NfY3RybF9zdXBw
b3J0ZWQsCisJLmNvbnRyb2xfZGVzY19pbnRlcmNlcHQgPSB2bXhfY29udHJvbF9kZXNjX2ludGVy
Y2VwdCwKIAkuc2V0X2RyNyA9IHZteF9zZXRfZHI3LAogCS5zeW5jX2RpcnR5X2RlYnVnX3JlZ3Mg
PSB2bXhfc3luY19kaXJ0eV9kZWJ1Z19yZWdzLAogCS5jYWNoZV9yZWcgPSB2bXhfY2FjaGVfcmVn
LApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
