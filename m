Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B18C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6704B238EC
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6704B238EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3CA8587A69;
	Mon,  7 Dec 2020 20:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cc135DOU1L6C; Mon,  7 Dec 2020 20:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDD9487ABA;
	Mon,  7 Dec 2020 20:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D55B4C0FA7;
	Mon,  7 Dec 2020 20:57:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA8DC0FA7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BE5F12E4F0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+vgFR54pWMb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:57:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id 18A9D2E296
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 5AB2930462E8; Mon,  7 Dec 2020 22:46:24 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 306F33072785;
 Mon,  7 Dec 2020 22:46:24 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 69/81] KVM: introspection: add KVMI_VCPU_GET_MTRR_TYPE
Date: Mon,  7 Dec 2020 22:46:10 +0200
Message-Id: <20201207204622.15258-70-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
 virtualization@lists.linux-foundation.org
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBjb21tYW5k
IHJldHVybnMgdGhlIG1lbW9yeSB0eXBlIGZvciBhIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3MuCgpT
aWduZWQtb2ZmLWJ5OiBNaWhhaSBEb27Im3UgPG1kb250dUBiaXRkZWZlbmRlci5jb20+CkNvLWRl
dmVsb3BlZC1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVk
LW9mZi1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIERvY3Vt
ZW50YXRpb24vdmlydC9rdm0va3ZtaS5yc3QgICAgICAgICAgICAgICB8IDMyICsrKysrKysrKysr
KysrKysrKysKIGFyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oICAgICAgICAgICAgICB8
ICA5ICsrKysrKwogYXJjaC94ODYva3ZtL2t2bWlfbXNnLmMgICAgICAgICAgICAgICAgICAgICAg
IHwgMTcgKysrKysrKysrKwogaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaCAgICAgICAgICAgICAg
ICAgICAgIHwgIDEgKwogLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0
LmMgIHwgMTggKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydC9rdm0va3ZtaS5yc3QgYi9Eb2N1bWVudGF0
aW9uL3ZpcnQva3ZtL2t2bWkucnN0CmluZGV4IDcwZDFmOTZiYzRmMC4uYjM1MjdkMTBhNDRlIDEw
MDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0CisrKyBiL0RvY3VtZW50
YXRpb24vdmlydC9rdm0va3ZtaS5yc3QKQEAgLTg4Nyw2ICs4ODcsMzggQEAgTW9kaWZpZXMgdGhl
IFhTQVZFIGFyZWEuCiAqIC1LVk1fRUlOVkFMIC0gdGhlIHBhZGRpbmcgaXMgbm90IHplcm8KICog
LUtWTV9FQUdBSU4gLSB0aGUgc2VsZWN0ZWQgdkNQVSBjYW4ndCBiZSBpbnRyb3NwZWN0ZWQgeWV0
CiAKKzIxLiBLVk1JX1ZDUFVfR0VUX01UUlJfVFlQRQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCisKKzpBcmNoaXRlY3R1cmVzOiB4ODYKKzpWZXJzaW9uczogPj0gMQorOlBhcmFtZXRlcnM6
CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV92Y3B1X2hkcjsKKwlzdHJ1Y3Qga3ZtaV92Y3B1X2dldF9t
dHJyX3R5cGUgeworCQlfX3U2NCBncGE7CisJfTsKKworOlJldHVybnM6CisKKzo6CisKKwlzdHJ1
Y3Qga3ZtaV9lcnJvcl9jb2RlOworCXN0cnVjdCBrdm1pX3ZjcHVfZ2V0X210cnJfdHlwZV9yZXBs
eSB7CisJCV9fdTggdHlwZTsKKwkJX191OCBwYWRkaW5nWzddOworCX07CisKK1JldHVybnMgdGhl
IGd1ZXN0IG1lbW9yeSB0eXBlIGZvciBhIHNwZWNpZmljIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3Mg
KGBgZ3BhYGApLgorCis6RXJyb3JzOgorCisqIC1LVk1fRUlOVkFMIC0gdGhlIHNlbGVjdGVkIHZD
UFUgaXMgaW52YWxpZAorKiAtS1ZNX0VJTlZBTCAtIHRoZSBwYWRkaW5nIGlzIG5vdCB6ZXJvCisq
IC1LVk1fRUFHQUlOIC0gdGhlIHNlbGVjdGVkIHZDUFUgY2FuJ3QgYmUgaW50cm9zcGVjdGVkIHll
dAorCiBFdmVudHMKID09PT09PQogCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkv
YXNtL2t2bWkuaCBiL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oCmluZGV4IDg5ZjNk
YzkyNjljMS4uN2I5MzQ1MGQwZDYyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkv
YXNtL2t2bWkuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bWkuaApAQCAtMTE5
LDQgKzExOSwxMyBAQCBzdHJ1Y3Qga3ZtaV92Y3B1X3NldF94c2F2ZSB7CiAJc3RydWN0IGt2bV94
c2F2ZSB4c2F2ZTsKIH07CiAKK3N0cnVjdCBrdm1pX3ZjcHVfZ2V0X210cnJfdHlwZSB7CisJX191
NjQgZ3BhOworfTsKKworc3RydWN0IGt2bWlfdmNwdV9nZXRfbXRycl90eXBlX3JlcGx5IHsKKwlf
X3U4IHR5cGU7CisJX191OCBwYWRkaW5nWzddOworfTsKKwogI2VuZGlmIC8qIF9VQVBJX0FTTV9Y
ODZfS1ZNSV9IICovCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYyBiL2FyY2gv
eDg2L2t2bS9rdm1pX21zZy5jCmluZGV4IDdkZjcxYjVjZDUwYS4uMjYxN2FkYTNhNjkyIDEwMDY0
NAotLS0gYS9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYworKysgYi9hcmNoL3g4Ni9rdm0va3ZtaV9t
c2cuYwpAQCAtMjMyLDEwICsyMzIsMjcgQEAgc3RhdGljIGludCBoYW5kbGVfdmNwdV9zZXRfeHNh
dmUoY29uc3Qgc3RydWN0IGt2bWlfdmNwdV9tc2dfam9iICpqb2IsCiAJcmV0dXJuIGt2bWlfbXNn
X3ZjcHVfcmVwbHkoam9iLCBtc2csIGVjLCBOVUxMLCAwKTsKIH0KIAorc3RhdGljIGludCBoYW5k
bGVfdmNwdV9nZXRfbXRycl90eXBlKGNvbnN0IHN0cnVjdCBrdm1pX3ZjcHVfbXNnX2pvYiAqam9i
LAorCQkJCSAgICAgY29uc3Qgc3RydWN0IGt2bWlfbXNnX2hkciAqbXNnLAorCQkJCSAgICAgY29u
c3Qgdm9pZCAqX3JlcSkKK3sKKwljb25zdCBzdHJ1Y3Qga3ZtaV92Y3B1X2dldF9tdHJyX3R5cGUg
KnJlcSA9IF9yZXE7CisJc3RydWN0IGt2bWlfdmNwdV9nZXRfbXRycl90eXBlX3JlcGx5IHJwbDsK
KwlnZm5fdCBnZm47CisKKwlnZm4gPSBncGFfdG9fZ2ZuKHJlcS0+Z3BhKTsKKworCW1lbXNldCgm
cnBsLCAwLCBzaXplb2YocnBsKSk7CisJcnBsLnR5cGUgPSBrdm1fbXRycl9nZXRfZ3Vlc3RfbWVt
b3J5X3R5cGUoam9iLT52Y3B1LCBnZm4pOworCisJcmV0dXJuIGt2bWlfbXNnX3ZjcHVfcmVwbHko
am9iLCBtc2csIDAsICZycGwsIHNpemVvZihycGwpKTsKK30KKwogc3RhdGljIGt2bWlfdmNwdV9t
c2dfam9iX2ZjdCBjb25zdCBtc2dfdmNwdVtdID0gewogCVtLVk1JX1ZDUFVfQ09OVFJPTF9DUl0g
ICAgICAgPSBoYW5kbGVfdmNwdV9jb250cm9sX2NyLAogCVtLVk1JX1ZDUFVfR0VUX0NQVUlEXSAg
ICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfY3B1aWQsCiAJW0tWTUlfVkNQVV9HRVRfSU5GT10gICAg
ICAgICA9IGhhbmRsZV92Y3B1X2dldF9pbmZvLAorCVtLVk1JX1ZDUFVfR0VUX01UUlJfVFlQRV0g
ICAgPSBoYW5kbGVfdmNwdV9nZXRfbXRycl90eXBlLAogCVtLVk1JX1ZDUFVfR0VUX1JFR0lTVEVS
U10gICAgPSBoYW5kbGVfdmNwdV9nZXRfcmVnaXN0ZXJzLAogCVtLVk1JX1ZDUFVfR0VUX1hDUl0g
ICAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeGNyLAogCVtLVk1JX1ZDUFVfR0VUX1hTQVZFXSAg
ICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeHNhdmUsCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkv
bGludXgva3ZtaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAppbmRleCAzYmFmNWM3ODQy
YmIuLjhkN2M2MDI3ZjEyYyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAor
KysgYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oCkBAIC00Nyw2ICs0Nyw3IEBAIGVudW0gewog
CUtWTUlfVkNQVV9HRVRfWENSICAgICAgICAgID0gS1ZNSV9WQ1BVX01FU1NBR0VfSUQoOCksCiAJ
S1ZNSV9WQ1BVX0dFVF9YU0FWRSAgICAgICAgPSBLVk1JX1ZDUFVfTUVTU0FHRV9JRCg5KSwKIAlL
Vk1JX1ZDUFVfU0VUX1hTQVZFICAgICAgICA9IEtWTUlfVkNQVV9NRVNTQUdFX0lEKDEwKSwKKwlL
Vk1JX1ZDUFVfR0VUX01UUlJfVFlQRSAgICA9IEtWTUlfVkNQVV9NRVNTQUdFX0lEKDExKSwKIAog
CUtWTUlfTkVYVF9WQ1BVX01FU1NBR0UKIH07CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
a3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYwppbmRleCA0NWMxZjMxMzJhM2MuLmIwOTA2YzdmYjk1NCAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3Qu
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCkBA
IC0xNDg4LDYgKzE0ODgsMjMgQEAgc3RhdGljIHZvaWQgdGVzdF9jbWRfdmNwdV94c2F2ZShzdHJ1
Y3Qga3ZtX3ZtICp2bSkKIAljbWRfdmNwdV9zZXRfeHNhdmUodm0sICZ4c2F2ZSk7CiB9CiAKK3N0
YXRpYyB2b2lkIHRlc3RfY21kX3ZjcHVfZ2V0X210cnJfdHlwZShzdHJ1Y3Qga3ZtX3ZtICp2bSkK
K3sKKwlzdHJ1Y3QgeworCQlzdHJ1Y3Qga3ZtaV9tc2dfaGRyIGhkcjsKKwkJc3RydWN0IGt2bWlf
dmNwdV9oZHIgdmNwdV9oZHI7CisJCXN0cnVjdCBrdm1pX3ZjcHVfZ2V0X210cnJfdHlwZSBjbWQ7
CisJfSByZXEgPSB7fTsKKwlzdHJ1Y3Qga3ZtaV92Y3B1X2dldF9tdHJyX3R5cGVfcmVwbHkgcnBs
OworCisJcmVxLmNtZC5ncGEgPSB0ZXN0X2dwYTsKKworCXRlc3RfdmNwdTBfY29tbWFuZCh2bSwg
S1ZNSV9WQ1BVX0dFVF9NVFJSX1RZUEUsCisJCQkgICAmcmVxLmhkciwgc2l6ZW9mKHJlcSksICZy
cGwsIHNpemVvZihycGwpLCAwKTsKKworCXByX2RlYnVnKCJtdHJyX3R5cGU6IGdwYSAweCVseCB0
eXBlIDB4JXhcbiIsIHRlc3RfZ3BhLCBycGwudHlwZSk7Cit9CisKIHN0YXRpYyB2b2lkIHRlc3Rf
aW50cm9zcGVjdGlvbihzdHJ1Y3Qga3ZtX3ZtICp2bSkKIHsKIAlzcmFuZG9tKHRpbWUoMCkpOwpA
QCAtMTUxNyw2ICsxNTM0LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9pbnRyb3NwZWN0aW9uKHN0cnVj
dCBrdm1fdm0gKnZtKQogCXRlc3RfZXZlbnRfeHNldGJ2KHZtKTsKIAl0ZXN0X2NtZF92Y3B1X2dl
dF94Y3Iodm0pOwogCXRlc3RfY21kX3ZjcHVfeHNhdmUodm0pOworCXRlc3RfY21kX3ZjcHVfZ2V0
X210cnJfdHlwZSh2bSk7CiAKIAl1bmhvb2tfaW50cm9zcGVjdGlvbih2bSk7CiB9Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
