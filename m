Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601DC0018C
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65302389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65302389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9EAD687156;
	Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bcu34iexkypO; Mon,  7 Dec 2020 20:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB712870CD;
	Mon,  7 Dec 2020 20:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B73CDC1834;
	Mon,  7 Dec 2020 20:46:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60080C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 38A442E29E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cTpwUlriDfN9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id EFD0C2E273
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 06920305D505; Mon,  7 Dec 2020 22:46:14 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id DA35C3072785;
 Mon,  7 Dec 2020 22:46:13 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 13/81] KVM: x86: add kvm_x86_ops.control_desc_intercept()
Date: Mon,  7 Dec 2020 22:45:14 +0200
Message-Id: <20201207204622.15258-14-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
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
dGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIHwgIDEg
KwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAgICAgIHwgMTUgKysrKysrKysr
KysrKy0tCiAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5kZXggMWU5Y2I1MjEzMjRlLi43MzA0MjljZDJlM2Qg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTEzMSw2ICsxMTMxLDcgQEAgc3RydWN0IGt2
bV94ODZfb3BzIHsKIAl2b2lkICgqZ2V0X2dkdCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1
Y3QgZGVzY19wdHIgKmR0KTsKIAl2b2lkICgqc2V0X2dkdCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBzdHJ1Y3QgZGVzY19wdHIgKmR0KTsKIAlib29sICgqZGVzY19jdHJsX3N1cHBvcnRlZCkodm9p
ZCk7CisJdm9pZCAoKmNvbnRyb2xfZGVzY19pbnRlcmNlcHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgYm9vbCBlbmFibGUpOwogCXZvaWQgKCpzeW5jX2RpcnR5X2RlYnVnX3JlZ3MpKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSk7CiAJdm9pZCAoKnNldF9kcjcpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
dW5zaWduZWQgbG9uZyB2YWx1ZSk7CiAJdm9pZCAoKmNhY2hlX3JlZykoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBlbnVtIGt2bV9yZWcgcmVnKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0v
c3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IDAwYmRhNzk0NjA5Yy4uYzhlNTZh
ZDljYmIxIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gveDg2
L2t2bS9zdm0vc3ZtLmMKQEAgLTE2MzUsNiArMTYzNSwzMSBAQCBzdGF0aWMgYm9vbCBzdm1fZGVz
Y19jdHJsX3N1cHBvcnRlZCh2b2lkKQogCXJldHVybiB0cnVlOwogfQogCitzdGF0aWMgdm9pZCBz
dm1fY29udHJvbF9kZXNjX2ludGVyY2VwdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgZW5h
YmxlKQoreworCXN0cnVjdCB2Y3B1X3N2bSAqc3ZtID0gdG9fc3ZtKHZjcHUpOworCisJaWYgKGVu
YWJsZSkgeworCQlzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9JRFRSKTsK
KwkJc3ZtX3NldF9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfR0RUUik7CisJCXN2bV9z
ZXRfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX1NUT1JFX0xEVFIpOworCQlzdm1fc2V0X2ludGVy
Y2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9UUik7CisJCXN2bV9zZXRfaW50ZXJjZXB0KHN2bSwg
SU5URVJDRVBUX0xPQURfSURUUik7CisJCXN2bV9zZXRfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBU
X0xPQURfR0RUUik7CisJCXN2bV9zZXRfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfTERU
Uik7CisJCXN2bV9zZXRfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfVFIpOworCX0gZWxz
ZSB7CisJCXN2bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX1NUT1JFX0lEVFIpOworCQlz
dm1fY2xyX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9HRFRSKTsKKwkJc3ZtX2Nscl9p
bnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfTERUUik7CisJCXN2bV9jbHJfaW50ZXJjZXB0
KHN2bSwgSU5URVJDRVBUX1NUT1JFX1RSKTsKKwkJc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRF
UkNFUFRfTE9BRF9JRFRSKTsKKwkJc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfTE9B
RF9HRFRSKTsKKwkJc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfTE9BRF9MRFRSKTsK
KwkJc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfTE9BRF9UUik7CisJfQorfQorCiBz
dGF0aWMgdm9pZCB1cGRhdGVfY3IwX2ludGVyY2VwdChzdHJ1Y3QgdmNwdV9zdm0gKnN2bSkKIHsK
IAl1bG9uZyBnY3IwID0gc3ZtLT52Y3B1LmFyY2guY3IwOwpAQCAtNDI4MSw2ICs0MzA2LDcgQEAg
c3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBzdm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5n
ZXRfZ2R0ID0gc3ZtX2dldF9nZHQsCiAJLnNldF9nZHQgPSBzdm1fc2V0X2dkdCwKIAkuZGVzY19j
dHJsX3N1cHBvcnRlZCA9IHN2bV9kZXNjX2N0cmxfc3VwcG9ydGVkLAorCS5jb250cm9sX2Rlc2Nf
aW50ZXJjZXB0ID0gc3ZtX2NvbnRyb2xfZGVzY19pbnRlcmNlcHQsCiAJLnNldF9kcjcgPSBzdm1f
c2V0X2RyNywKIAkuc3luY19kaXJ0eV9kZWJ1Z19yZWdzID0gc3ZtX3N5bmNfZGlydHlfZGVidWdf
cmVncywKIAkuY2FjaGVfcmVnID0gc3ZtX2NhY2hlX3JlZywKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IGE1ZTFmNjFkMjYy
Mi4uMjAzNTFlMDI3ODk4IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBi
L2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTMxMjAsNiArMzEyMCwxNiBAQCBzdGF0aWMgdm9p
ZCB2bXhfbG9hZF9tbXVfcGdkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyBw
Z2QsCiAJCXZtY3Nfd3JpdGVsKEdVRVNUX0NSMywgZ3Vlc3RfY3IzKTsKIH0KIAorc3RhdGljIHZv
aWQgdm14X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29s
IGVuYWJsZSkKK3sKKwlzdHJ1Y3QgdmNwdV92bXggKnZteCA9IHRvX3ZteCh2Y3B1KTsKKworCWlm
IChlbmFibGUpCisJCXNlY29uZGFyeV9leGVjX2NvbnRyb2xzX3NldGJpdCh2bXgsIFNFQ09OREFS
WV9FWEVDX0RFU0MpOworCWVsc2UKKwkJc2Vjb25kYXJ5X2V4ZWNfY29udHJvbHNfY2xlYXJiaXQo
dm14LCBTRUNPTkRBUllfRVhFQ19ERVNDKTsKK30KKwogc3RhdGljIGJvb2wgdm14X2lzX3ZhbGlk
X2NyNChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgY3I0KQogewogCS8qCkBA
IC0zMTU3LDExICszMTY3LDExIEBAIHZvaWQgdm14X3NldF9jcjQoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LCB1bnNpZ25lZCBsb25nIGNyNCkKIAogCWlmICghYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJF
X1VNSVApICYmIHZteF91bWlwX2VtdWxhdGVkKCkpIHsKIAkJaWYgKGNyNCAmIFg4Nl9DUjRfVU1J
UCkgewotCQkJc2Vjb25kYXJ5X2V4ZWNfY29udHJvbHNfc2V0Yml0KHZteCwgU0VDT05EQVJZX0VY
RUNfREVTQyk7CisJCQl2bXhfY29udHJvbF9kZXNjX2ludGVyY2VwdCh2Y3B1LCB0cnVlKTsKIAkJ
CWh3X2NyNCAmPSB+WDg2X0NSNF9VTUlQOwogCQl9IGVsc2UgaWYgKCFpc19ndWVzdF9tb2RlKHZj
cHUpIHx8CiAJCQkhbmVzdGVkX2NwdV9oYXMyKGdldF92bWNzMTIodmNwdSksIFNFQ09OREFSWV9F
WEVDX0RFU0MpKSB7Ci0JCQlzZWNvbmRhcnlfZXhlY19jb250cm9sc19jbGVhcmJpdCh2bXgsIFNF
Q09OREFSWV9FWEVDX0RFU0MpOworCQkJdm14X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQodmNwdSwg
ZmFsc2UpOwogCQl9CiAJfQogCkBAIC03NjU3LDYgKzc2NjcsNyBAQCBzdGF0aWMgc3RydWN0IGt2
bV94ODZfb3BzIHZteF94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9nZHQgPSB2bXhfZ2V0
X2dkdCwKIAkuc2V0X2dkdCA9IHZteF9zZXRfZ2R0LAogCS5kZXNjX2N0cmxfc3VwcG9ydGVkID0g
dm14X2Rlc2NfY3RybF9zdXBwb3J0ZWQsCisJLmNvbnRyb2xfZGVzY19pbnRlcmNlcHQgPSB2bXhf
Y29udHJvbF9kZXNjX2ludGVyY2VwdCwKIAkuc2V0X2RyNyA9IHZteF9zZXRfZHI3LAogCS5zeW5j
X2RpcnR5X2RlYnVnX3JlZ3MgPSB2bXhfc3luY19kaXJ0eV9kZWJ1Z19yZWdzLAogCS5jYWNoZV9y
ZWcgPSB2bXhfY2FjaGVfcmVnLApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
