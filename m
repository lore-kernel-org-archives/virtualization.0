Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D11C433FE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288BF6113E
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 288BF6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 614B583F35;
	Wed,  6 Oct 2021 17:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ntnmrm90Sjtm; Wed,  6 Oct 2021 17:50:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDFBF83E48;
	Wed,  6 Oct 2021 17:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D731C0023;
	Wed,  6 Oct 2021 17:50:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C5AC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 249E060EBB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cnKhBv_9LIrX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2442660629
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 222AD307CAF7; Wed,  6 Oct 2021 20:31:08 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 09454305FFA0;
 Wed,  6 Oct 2021 20:31:08 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 35/77] KVM: introspection: add KVMI_VM_GET_INFO
Date: Wed,  6 Oct 2021 20:30:31 +0300
Message-Id: <20211006173113.26445-36-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBjb21tYW5k
IHJldHVybnMgdGhlIG51bWJlciBvZiBvbmxpbmUgdkNQVXMuCgpUaGUgaW50cm9zcGVjdGlvbiB0
b29sIHVzZXMgdGhlIHZDUFUgaW5kZXggdG8gc3BlY2lmeSB0byB3aGljaCB2Q1BVCnRoZSBpbnRy
b3NwZWN0aW9uIGNvbW1hbmQgYXBwbGllcyB0by4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERvbsib
dSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINy
IDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIERvY3VtZW50YXRpb24vdmlydC9rdm0va3Zt
aS5yc3QgICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysKIGluY2x1ZGUvdWFwaS9saW51eC9r
dm1pLmggICAgICAgICAgICAgICAgICAgICB8ICA2ICsrKysKIC4uLi90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jICB8IDM1ICsrKysrKysrKysrKysrKysrLS0KIHZpcnQv
a3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9tc2cuYyAgICAgICAgICAgICB8IDEzICsrKysrKysKIDQg
ZmlsZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0
L2t2bS9rdm1pLnJzdAppbmRleCAxMzE2OTU3NWY3NWYuLjZmODU4M2Q0YWViMiAxMDA2NDQKLS0t
IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9rdm1pLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL3Zp
cnQva3ZtL2t2bWkucnN0CkBAIC0zMTIsMyArMzEyLDIxIEBAIFRoaXMgY29tbWFuZCBpcyBhbHdh
eXMgYWxsb3dlZC4KICogLUtWTV9FTk9FTlQgLSB0aGUgZXZlbnQgc3BlY2lmaWVkIGJ5IGBgaWRg
YCBpcyB1bnN1cHBvcnRlZAogKiAtS1ZNX0VQRVJNIC0gdGhlIGV2ZW50IHNwZWNpZmllZCBieSBg
YGlkYGAgaXMgZGlzYWxsb3dlZAogKiAtS1ZNX0VJTlZBTCAtIHRoZSBwYWRkaW5nIGlzIG5vdCB6
ZXJvCisKKzQuIEtWTUlfVk1fR0VUX0lORk8KKy0tLS0tLS0tLS0tLS0tLS0tLS0KKworOkFyY2hp
dGVjdHVyZXM6IGFsbAorOlZlcnNpb25zOiA+PSAxCis6UGFyYW1ldGVyczogbm9uZQorOlJldHVy
bnM6CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV9lcnJvcl9jb2RlOworCXN0cnVjdCBrdm1pX3ZtX2dl
dF9pbmZvX3JlcGx5IHsKKwkJX191MzIgdmNwdV9jb3VudDsKKwkJX191MzIgcGFkZGluZ1szXTsK
Kwl9OworCitSZXR1cm5zIHRoZSBudW1iZXIgb2Ygb25saW5lIHZDUFVzLgpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm1pLmgKaW5k
ZXggMGMyZDBjZWRkZTZmLi5lMDZhN2I4MGQ0ZDkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC9rdm1pLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaApAQCAtMjAsNiArMjAs
NyBAQCBlbnVtIHsKIAlLVk1JX0dFVF9WRVJTSU9OICAgICAgPSBLVk1JX1ZNX01FU1NBR0VfSUQo
MSksCiAJS1ZNSV9WTV9DSEVDS19DT01NQU5EID0gS1ZNSV9WTV9NRVNTQUdFX0lEKDIpLAogCUtW
TUlfVk1fQ0hFQ0tfRVZFTlQgICA9IEtWTUlfVk1fTUVTU0FHRV9JRCgzKSwKKwlLVk1JX1ZNX0dF
VF9JTkZPICAgICAgPSBLVk1JX1ZNX01FU1NBR0VfSUQoNCksCiAKIAlLVk1JX05FWFRfVk1fTUVT
U0FHRQogfTsKQEAgLTY3LDQgKzY4LDkgQEAgc3RydWN0IGt2bWlfdm1fY2hlY2tfZXZlbnQgewog
CV9fdTMyIHBhZGRpbmcyOwogfTsKIAorc3RydWN0IGt2bWlfdm1fZ2V0X2luZm9fcmVwbHkgewor
CV9fdTMyIHZjcHVfY291bnQ7CisJX191MzIgcGFkZGluZ1szXTsKK307CisKICNlbmRpZiAvKiBf
VUFQSV9fTElOVVhfS1ZNSV9IICovCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4
Nl82NC9rdm1pX3Rlc3QuYwppbmRleCA1N2Y2OGZmNjBlYjkuLjJhZGEzZDliYzIzMCAxMDA2NDQK
LS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYworKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCkBAIC04MCw2
ICs4MCwxNiBAQCBzdGF0aWMgdm9pZCBzZXRfY29tbWFuZF9wZXJtKHN0cnVjdCBrdm1fdm0gKnZt
LCBfX3MzMiBpZCwgX191MzIgYWxsb3csCiAJCSAiS1ZNX0lOVFJPU1BFQ1RJT05fQ09NTUFORCIp
OwogfQogCitzdGF0aWMgdm9pZCBkaXNhbGxvd19jb21tYW5kKHN0cnVjdCBrdm1fdm0gKnZtLCBf
X3MzMiBpZCkKK3sKKwlzZXRfY29tbWFuZF9wZXJtKHZtLCBpZCwgMCwgMCk7Cit9CisKK3N0YXRp
YyB2b2lkIGFsbG93X2NvbW1hbmQoc3RydWN0IGt2bV92bSAqdm0sIF9fczMyIGlkKQoreworCXNl
dF9jb21tYW5kX3Blcm0odm0sIGlkLCAxLCAwKTsKK30KKwogc3RhdGljIHZvaWQgaG9va19pbnRy
b3NwZWN0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQogewogCV9fdTMyIGFsbG93ID0gMSwgZGlzYWxs
b3cgPSAwLCBhbGxvd19pbnZhbCA9IDI7CkBAIC0yNjMsMTIgKzI3MywxNiBAQCBzdGF0aWMgdm9p
ZCBjbWRfdm1fY2hlY2tfY29tbWFuZChfX3UxNiBpZCwgaW50IGV4cGVjdGVkX2VycikKIAkJCWV4
cGVjdGVkX2Vycik7CiB9CiAKLXN0YXRpYyB2b2lkIHRlc3RfY21kX3ZtX2NoZWNrX2NvbW1hbmQo
dm9pZCkKK3N0YXRpYyB2b2lkIHRlc3RfY21kX3ZtX2NoZWNrX2NvbW1hbmQoc3RydWN0IGt2bV92
bSAqdm0pCiB7Ci0JX191MTYgdmFsaWRfaWQgPSBLVk1JX0dFVF9WRVJTSU9OLCBpbnZhbGlkX2lk
ID0gMHhmZmZmOworCV9fdTE2IHZhbGlkX2lkID0gS1ZNSV9WTV9HRVRfSU5GTywgaW52YWxpZF9p
ZCA9IDB4ZmZmZjsKIAogCWNtZF92bV9jaGVja19jb21tYW5kKHZhbGlkX2lkLCAwKTsKIAljbWRf
dm1fY2hlY2tfY29tbWFuZChpbnZhbGlkX2lkLCAtS1ZNX0VOT0VOVCk7CisKKwlkaXNhbGxvd19j
b21tYW5kKHZtLCB2YWxpZF9pZCk7CisJY21kX3ZtX2NoZWNrX2NvbW1hbmQodmFsaWRfaWQsIC1L
Vk1fRVBFUk0pOworCWFsbG93X2NvbW1hbmQodm0sIHZhbGlkX2lkKTsKIH0KIAogc3RhdGljIHZv
aWQgY21kX3ZtX2NoZWNrX2V2ZW50KF9fdTE2IGlkLCBpbnQgZXhwZWN0ZWRfZXJyKQpAQCAtMjkx
LDYgKzMwNSwyMCBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NtZF92bV9jaGVja19ldmVudCh2b2lkKQog
CWNtZF92bV9jaGVja19ldmVudChpbnZhbGlkX2lkLCAtS1ZNX0VOT0VOVCk7CiB9CiAKK3N0YXRp
YyB2b2lkIHRlc3RfY21kX3ZtX2dldF9pbmZvKHZvaWQpCit7CisJc3RydWN0IGt2bWlfdm1fZ2V0
X2luZm9fcmVwbHkgcnBsOworCXN0cnVjdCBrdm1pX21zZ19oZHIgcmVxOworCisJdGVzdF92bV9j
b21tYW5kKEtWTUlfVk1fR0VUX0lORk8sICZyZXEsIHNpemVvZihyZXEpLCAmcnBsLAorCQkJc2l6
ZW9mKHJwbCksIDApOworCVRFU1RfQVNTRVJUKHJwbC52Y3B1X2NvdW50ID09IDEsCisJCSAgICAi
VW5leHBlY3RlZCBudW1iZXIgb2YgdkNQVSBjb3VudCAldVxuIiwKKwkJICAgIHJwbC52Y3B1X2Nv
dW50KTsKKworCXByX2RlYnVnKCJ2Y3B1IGNvdW50OiAldVxuIiwgcnBsLnZjcHVfY291bnQpOwor
fQorCiBzdGF0aWMgdm9pZCB0ZXN0X2ludHJvc3BlY3Rpb24oc3RydWN0IGt2bV92bSAqdm0pCiB7
CiAJc2V0dXBfc29ja2V0KCk7CkBAIC0yOTgsOCArMzI2LDkgQEAgc3RhdGljIHZvaWQgdGVzdF9p
bnRyb3NwZWN0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQogCiAJdGVzdF9jbWRfaW52YWxpZCgpOwog
CXRlc3RfY21kX2dldF92ZXJzaW9uKCk7Ci0JdGVzdF9jbWRfdm1fY2hlY2tfY29tbWFuZCgpOwor
CXRlc3RfY21kX3ZtX2NoZWNrX2NvbW1hbmQodm0pOwogCXRlc3RfY21kX3ZtX2NoZWNrX2V2ZW50
KCk7CisJdGVzdF9jbWRfdm1fZ2V0X2luZm8oKTsKIAogCXVuaG9va19pbnRyb3NwZWN0aW9uKHZt
KTsKIH0KZGlmZiAtLWdpdCBhL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9tc2cuYyBiL3Zp
cnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9tc2cuYwppbmRleCAxNmRkYTM0ZDFhY2QuLjc5NTQ5
NTM0MGRjMCAxMDA2NDQKLS0tIGEvdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1pX21zZy5jCisr
KyBiL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9tc2cuYwpAQCAtMTUwLDYgKzE1MCwxOCBA
QCBzdGF0aWMgaW50IGhhbmRsZV92bV9jaGVja19ldmVudChzdHJ1Y3Qga3ZtX2ludHJvc3BlY3Rp
b24gKmt2bWksCiAJcmV0dXJuIGt2bWlfbXNnX3ZtX3JlcGx5KGt2bWksIG1zZywgZWMsIE5VTEws
IDApOwogfQogCitzdGF0aWMgaW50IGhhbmRsZV92bV9nZXRfaW5mbyhzdHJ1Y3Qga3ZtX2ludHJv
c3BlY3Rpb24gKmt2bWksCisJCQkgICAgICBjb25zdCBzdHJ1Y3Qga3ZtaV9tc2dfaGRyICptc2cs
CisJCQkgICAgICBjb25zdCB2b2lkICpyZXEpCit7CisJc3RydWN0IGt2bWlfdm1fZ2V0X2luZm9f
cmVwbHkgcnBsOworCisJbWVtc2V0KCZycGwsIDAsIHNpemVvZihycGwpKTsKKwlycGwudmNwdV9j
b3VudCA9IGF0b21pY19yZWFkKCZrdm1pLT5rdm0tPm9ubGluZV92Y3B1cyk7CisKKwlyZXR1cm4g
a3ZtaV9tc2dfdm1fcmVwbHkoa3ZtaSwgbXNnLCAwLCAmcnBsLCBzaXplb2YocnBsKSk7Cit9CisK
IC8qCiAgKiBUaGVzZSBjb21tYW5kcyBhcmUgZXhlY3V0ZWQgYnkgdGhlIHJlY2VpdmluZyB0aHJl
YWQuCiAgKi8KQEAgLTE1Nyw2ICsxNjksNyBAQCBzdGF0aWMgY29uc3Qga3ZtaV92bV9tc2dfZmN0
IG1zZ192bVtdID0gewogCVtLVk1JX0dFVF9WRVJTSU9OXSAgICAgID0gaGFuZGxlX2dldF92ZXJz
aW9uLAogCVtLVk1JX1ZNX0NIRUNLX0NPTU1BTkRdID0gaGFuZGxlX3ZtX2NoZWNrX2NvbW1hbmQs
CiAJW0tWTUlfVk1fQ0hFQ0tfRVZFTlRdICAgPSBoYW5kbGVfdm1fY2hlY2tfZXZlbnQsCisJW0tW
TUlfVk1fR0VUX0lORk9dICAgICAgPSBoYW5kbGVfdm1fZ2V0X2luZm8sCiB9OwogCiBzdGF0aWMg
a3ZtaV92bV9tc2dfZmN0IGdldF92bV9tc2dfaGFuZGxlcih1MTYgaWQpCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
