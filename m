Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06EC64E7D
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E0E206F9
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 81E9987470;
	Wed, 25 Nov 2020 09:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ktSnHyWCZ3E; Wed, 25 Nov 2020 09:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 80C9E8747D;
	Wed, 25 Nov 2020 09:42:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B41C1DA0;
	Wed, 25 Nov 2020 09:42:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA73EC1D9F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DB6FF86A00
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id APGi2p9zp8j7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3FE5B869D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 9B3EB305D503; Wed, 25 Nov 2020 11:35:45 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 78DE63072785;
 Wed, 25 Nov 2020 11:35:45 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 17/81] KVM: x86: add kvm_x86_ops.control_msr_intercept()
Date: Wed, 25 Nov 2020 11:34:56 +0200
Message-Id: <20201125093600.2766-18-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyBuZWVk
ZWQgZm9yIHRoZSBLVk1JX1ZDUFVfRVZFTlRfTVNSIGV2ZW50LCB3aGljaCBpcyB1c2VkIG5vdGlm
eQp0aGUgaW50cm9zcGVjdGlvbiB0b29sIGFib3V0IGFueSBjaGFuZ2UgbWFkZSB0byBhIE1TUiBv
ZiBpbnRlcmVzdC4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVu
ZGVyLmNvbT4KQ28tZGV2ZWxvcGVkLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xv
dWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQu
Y29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5j
b20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8ICAyICsrCiBhcmNoL3g4
Ni9rdm0vc3ZtL3N2bS5jICAgICAgICAgIHwgMTEgKysrKysrKysrKysKIGFyY2gveDg2L2t2bS92
bXgvdm14LmMgICAgICAgICAgfCAgNyArKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCA4NTg2YzlmNGZlYmEuLjAxODUz
NDUzYTY1OSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xMTE2LDYgKzExMTYsOCBAQCBz
dHJ1Y3Qga3ZtX3g4Nl9vcHMgewogCXZvaWQgKCp1cGRhdGVfZXhjZXB0aW9uX2JpdG1hcCkoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAlpbnQgKCpnZXRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHN0cnVjdCBtc3JfZGF0YSAqbXNyKTsKIAlpbnQgKCpzZXRfbXNyKShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBtc3JfZGF0YSAqbXNyKTsKKwl2b2lkICgqY29udHJvbF9tc3JfaW50
ZXJjZXB0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGludCBtc3IsCisJCQkJICAg
ICAgaW50IHR5cGUsIGJvb2wgZW5hYmxlKTsKIAlib29sICgqbXNyX3dyaXRlX2ludGVyY2VwdGVk
KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiBtc3IpOwogCXU2NCAoKmdldF9zZWdtZW50X2Jh
c2UpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IHNlZyk7CiAJdm9pZCAoKmdldF9zZWdtZW50
KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2
bS5jIGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwppbmRleCA4ZDY2MmNjZjViNjIuLjJiZmVmY2Zi
ZGRkNyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9r
dm0vc3ZtL3N2bS5jCkBAIC02NzcsNiArNjc3LDE2IEBAIHN0YXRpYyB2b2lkIHNldF9tc3JfaW50
ZXJjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyICptc3JwbSwgdTMyIG1zciwKIAlz
ZXRfbXNyX2ludGVyY2VwdGlvbl9iaXRtYXAodmNwdSwgbXNycG0sIG1zciwgdHlwZSwgdmFsdWUp
OwogfQogCitzdGF0aWMgdm9pZCBzdm1fY29udHJvbF9tc3JfaW50ZXJjZXB0KHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwgdW5zaWduZWQgaW50IG1zciwKKwkJCQkgICAgICBpbnQgdHlwZSwgYm9vbCBl
bmFibGUpCit7CisJY29uc3Qgc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CisJ
dTMyICptc3JwbSA9IGlzX2d1ZXN0X21vZGUodmNwdSkgPyBzdm0tPm5lc3RlZC5tc3JwbSA6CisJ
CQkJCSAgIHN2bS0+bXNycG07CisKKwlzZXRfbXNyX2ludGVyY2VwdGlvbih2Y3B1LCBtc3JwbSwg
bXNyLCB0eXBlLCBlbmFibGUpOworfQorCiB1MzIgKnN2bV92Y3B1X2FsbG9jX21zcnBtKHZvaWQp
CiB7CiAJc3RydWN0IHBhZ2UgKnBhZ2VzID0gYWxsb2NfcGFnZXMoR0ZQX0tFUk5FTF9BQ0NPVU5U
LCBNU1JQTV9BTExPQ19PUkRFUik7CkBAIC00MzI4LDYgKzQzMzgsNyBAQCBzdGF0aWMgc3RydWN0
IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9tc3JfZmVhdHVy
ZSA9IHN2bV9nZXRfbXNyX2ZlYXR1cmUsCiAJLmdldF9tc3IgPSBzdm1fZ2V0X21zciwKIAkuc2V0
X21zciA9IHN2bV9zZXRfbXNyLAorCS5jb250cm9sX21zcl9pbnRlcmNlcHQgPSBzdm1fY29udHJv
bF9tc3JfaW50ZXJjZXB0LAogCS5tc3Jfd3JpdGVfaW50ZXJjZXB0ZWQgPSBtc3Jfd3JpdGVfaW50
ZXJjZXB0ZWQsCiAJLmdldF9zZWdtZW50X2Jhc2UgPSBzdm1fZ2V0X3NlZ21lbnRfYmFzZSwKIAku
Z2V0X3NlZ21lbnQgPSBzdm1fZ2V0X3NlZ21lbnQsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwppbmRleCBkNDgzM2QzYmY5NjYuLmMx
NDk3YjhlNTA2YyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYworKysgYi9hcmNo
L3g4Ni9rdm0vdm14L3ZteC5jCkBAIC0zODI2LDYgKzM4MjYsMTIgQEAgc3RhdGljIF9fYWx3YXlz
X2lubGluZSB2b2lkIHZteF9zZXRfaW50ZXJjZXB0X2Zvcl9tc3Ioc3RydWN0IGt2bV92Y3B1ICp2
Y3B1LAogCQl2bXhfZGlzYWJsZV9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBtc3IsIHR5cGUpOwog
fQogCitzdGF0aWMgdm9pZCB2bXhfY29udHJvbF9tc3JfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgdW5zaWduZWQgaW50IG1zciwKKwkJCQkgICAgICBpbnQgdHlwZSwgYm9vbCBlbmFi
bGUpCit7CisJdm14X3NldF9pbnRlcmNlcHRfZm9yX21zcih2Y3B1LCBtc3IsIHR5cGUsIGVuYWJs
ZSk7Cit9CisKIHN0YXRpYyB1OCB2bXhfbXNyX2JpdG1hcF9tb2RlKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkKIHsKIAl1OCBtb2RlID0gMDsKQEAgLTc2NTgsNiArNzY2NCw3IEBAIHN0YXRpYyBzdHJ1
Y3Qga3ZtX3g4Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuZ2V0X21zcl9mZWF0
dXJlID0gdm14X2dldF9tc3JfZmVhdHVyZSwKIAkuZ2V0X21zciA9IHZteF9nZXRfbXNyLAogCS5z
ZXRfbXNyID0gdm14X3NldF9tc3IsCisJLmNvbnRyb2xfbXNyX2ludGVyY2VwdCA9IHZteF9jb250
cm9sX21zcl9pbnRlcmNlcHQsCiAJLm1zcl93cml0ZV9pbnRlcmNlcHRlZCA9IG1zcl93cml0ZV9p
bnRlcmNlcHRlZCwKIAkuZ2V0X3NlZ21lbnRfYmFzZSA9IHZteF9nZXRfc2VnbWVudF9iYXNlLAog
CS5nZXRfc2VnbWVudCA9IHZteF9nZXRfc2VnbWVudCwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
