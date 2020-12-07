Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E1C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6759238A0
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6759238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3D2072E297;
	Mon,  7 Dec 2020 20:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Un4oPU44HUiX; Mon,  7 Dec 2020 20:46:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B59C22E29B;
	Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95EE9C1DA1;
	Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F721C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BEC4878A4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fEPDg7X4tfvL
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D0128789C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:17 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4E9D0305D508; Mon,  7 Dec 2020 22:46:14 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2DB173072785;
 Mon,  7 Dec 2020 22:46:14 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 15/81] KVM: x86: add kvm_x86_ops.msr_write_intercepted()
Date: Mon,  7 Dec 2020 22:45:16 +0200
Message-Id: <20201207204622.15258-16-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgZnVuY3Rp
b24gd2lsbCBiZSB1c2VkIHRvIGNoZWNrIGlmIHRoZSB3cml0ZSBhY2Nlc3MgZm9yIGEgc3BlY2lm
aWMKTVNSIGlzIGFscmVhZHkgaW50ZXJjZXB0ZWQuIFRoZSBpbmZvcm1hdGlvbiB3aWxsIGJlIHVz
ZWQgdG8gcmVzdG9yZSB0aGUKaW50ZXJjZXB0aW9uIHN0YXR1cyB3aGVuIHRoZSBpbnRyb3NwZWN0
aW9uIHRvb2wgaXMgbm8gbG9uZ2VyIGludGVyZXN0ZWQKaW4gdGhhdCBNU1IuCgpTaWduZWQtb2Zm
LWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYv
aW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDEgKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAg
ICAgICB8IDEgKwogYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICB8IDEgKwogMyBmaWxl
cyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCAw
ZTkxNDRlMjNjZTYuLjUyMzYwMDhkMjMxZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20va3ZtX2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0x
MTEyLDYgKzExMTIsNyBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgewogCXZvaWQgKCp1cGRhdGVfZXhj
ZXB0aW9uX2JpdG1hcCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAlpbnQgKCpnZXRfbXNyKShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3JfZGF0YSAqbXNyKTsKIAlpbnQgKCpzZXRf
bXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3JfZGF0YSAqbXNyKTsKKwlib29s
ICgqbXNyX3dyaXRlX2ludGVyY2VwdGVkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHUzMiBtc3Ip
OwogCXU2NCAoKmdldF9zZWdtZW50X2Jhc2UpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IHNl
Zyk7CiAJdm9pZCAoKmdldF9zZWdtZW50KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJCQkgICAg
c3RydWN0IGt2bV9zZWdtZW50ICp2YXIsIGludCBzZWcpOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3N2bS9zdm0uYyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKaW5kZXggODZmMGRjZjlmZWNk
Li40NDc4OTQyZjEwYTUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKKysrIGIv
YXJjaC94ODYva3ZtL3N2bS9zdm0uYwpAQCAtNDMwNCw2ICs0MzA0LDcgQEAgc3RhdGljIHN0cnVj
dCBrdm1feDg2X29wcyBzdm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5nZXRfbXNyX2ZlYXR1
cmUgPSBzdm1fZ2V0X21zcl9mZWF0dXJlLAogCS5nZXRfbXNyID0gc3ZtX2dldF9tc3IsCiAJLnNl
dF9tc3IgPSBzdm1fc2V0X21zciwKKwkubXNyX3dyaXRlX2ludGVyY2VwdGVkID0gbXNyX3dyaXRl
X2ludGVyY2VwdGVkLAogCS5nZXRfc2VnbWVudF9iYXNlID0gc3ZtX2dldF9zZWdtZW50X2Jhc2Us
CiAJLmdldF9zZWdtZW50ID0gc3ZtX2dldF9zZWdtZW50LAogCS5zZXRfc2VnbWVudCA9IHN2bV9z
ZXRfc2VnbWVudCwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jCmluZGV4IDViZDZhNGFkZDI3ZS4uZDQ4MzNkM2JmOTY2IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMK
QEAgLTc2NTgsNiArNzY1OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgdm14X3g4Nl9v
cHMgX19pbml0ZGF0YSA9IHsKIAkuZ2V0X21zcl9mZWF0dXJlID0gdm14X2dldF9tc3JfZmVhdHVy
ZSwKIAkuZ2V0X21zciA9IHZteF9nZXRfbXNyLAogCS5zZXRfbXNyID0gdm14X3NldF9tc3IsCisJ
Lm1zcl93cml0ZV9pbnRlcmNlcHRlZCA9IG1zcl93cml0ZV9pbnRlcmNlcHRlZCwKIAkuZ2V0X3Nl
Z21lbnRfYmFzZSA9IHZteF9nZXRfc2VnbWVudF9iYXNlLAogCS5nZXRfc2VnbWVudCA9IHZteF9n
ZXRfc2VnbWVudCwKIAkuc2V0X3NlZ21lbnQgPSB2bXhfc2V0X3NlZ21lbnQsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
