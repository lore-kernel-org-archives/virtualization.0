Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01681C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C767061186
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C767061186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A7E540DA9;
	Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8iIrmsSBoTg; Wed,  6 Oct 2021 17:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E376B40A32;
	Wed,  6 Oct 2021 17:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFE86C002D;
	Wed,  6 Oct 2021 17:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90EEFC0027
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F41340684
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gzt2ocLjqkMG
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAAFF40637
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4BCC4307CAE2; Wed,  6 Oct 2021 20:30:58 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 30D7A3064495;
 Wed,  6 Oct 2021 20:30:58 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 13/77] KVM: x86: add kvm_x86_ops.msr_write_intercepted()
Date: Wed,  6 Oct 2021 20:30:09 +0300
Message-Id: <20211006173113.26445-14-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgZnVuY3Rp
b24gd2lsbCBiZSB1c2VkIHRvIGNoZWNrIGlmIHRoZSB3cml0ZSBhY2Nlc3MgZm9yIGEgc3BlY2lm
aWMKTVNSIGlzIGFscmVhZHkgaW50ZXJjZXB0ZWQuIFRoZSBpbmZvcm1hdGlvbiB3aWxsIGJlIHVz
ZWQgdG8gcmVzdG9yZSB0aGUKaW50ZXJjZXB0aW9uIHN0YXR1cyB3aGVuIHRoZSBpbnRyb3NwZWN0
aW9uIHRvb2wgaXMgbm8gbG9uZ2VyIGludGVyZXN0ZWQKaW4gdGhhdCBNU1IuCgpTaWduZWQtb2Zm
LWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYv
aW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCB8IDEgKwogYXJjaC94ODYvaW5jbHVkZS9hc20va3Zt
X2hvc3QuaCAgICB8IDEgKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICAgICB8IDEg
KwogYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgICB8IDEgKwogNCBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
dm0teDg2LW9wcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaAppbmRleCAz
MGQwMWM5ZWQzMWIuLjkwZTkxMzQwOGM2ZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9h
c20va3ZtLXg4Ni1vcHMuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5o
CkBAIC0xMjcsNiArMTI3LDcgQEAgS1ZNX1g4Nl9PUChjcjNfd3JpdGVfaW50ZXJjZXB0ZWQpCiBL
Vk1fWDg2X09QKGRlc2NfY3RybF9zdXBwb3J0ZWQpCiBLVk1fWDg2X09QKGNvbnRyb2xfZGVzY19p
bnRlcmNlcHQpCiBLVk1fWDg2X09QKGRlc2NfaW50ZXJjZXB0ZWQpCitLVk1fWDg2X09QKG1zcl93
cml0ZV9pbnRlcmNlcHRlZCkKIAogI3VuZGVmIEtWTV9YODZfT1AKICN1bmRlZiBLVk1fWDg2X09Q
X05VTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IDExODJiMGZiZDI0NS4uMWU3N2NiODI1
ZWM0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTEzMzEsNiArMTMzMSw3IEBAIHN0cnVj
dCBrdm1feDg2X29wcyB7CiAJdm9pZCAoKnVwZGF0ZV9leGNlcHRpb25fYml0bWFwKShzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpOwogCWludCAoKmdldF9tc3IpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
c3RydWN0IG1zcl9kYXRhICptc3IpOwogCWludCAoKnNldF9tc3IpKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgc3RydWN0IG1zcl9kYXRhICptc3IpOworCWJvb2wgKCptc3Jfd3JpdGVfaW50ZXJjZXB0
ZWQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIG1zcik7CiAJdTY0ICgqZ2V0X3NlZ21lbnRf
YmFzZSkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgc2VnKTsKIAl2b2lkICgqZ2V0X3NlZ21l
bnQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAkJCSAgICBzdHJ1Y3Qga3ZtX3NlZ21lbnQgKnZh
ciwgaW50IHNlZyk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94
ODYva3ZtL3N2bS9zdm0uYwppbmRleCBjMWIxZTVjZGQ1MDguLjMxMTA5OTYxMTgzZSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5j
CkBAIC00Njg5LDYgKzQ2ODksNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHN2bV94ODZf
b3BzIF9faW5pdGRhdGEgPSB7CiAJLmdldF9tc3JfZmVhdHVyZSA9IHN2bV9nZXRfbXNyX2ZlYXR1
cmUsCiAJLmdldF9tc3IgPSBzdm1fZ2V0X21zciwKIAkuc2V0X21zciA9IHN2bV9zZXRfbXNyLAor
CS5tc3Jfd3JpdGVfaW50ZXJjZXB0ZWQgPSBtc3Jfd3JpdGVfaW50ZXJjZXB0ZWQsCiAJLmdldF9z
ZWdtZW50X2Jhc2UgPSBzdm1fZ2V0X3NlZ21lbnRfYmFzZSwKIAkuZ2V0X3NlZ21lbnQgPSBzdm1f
Z2V0X3NlZ21lbnQsCiAJLnNldF9zZWdtZW50ID0gc3ZtX3NldF9zZWdtZW50LApkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKaW5kZXgg
OGYzNGIxOTgyN2EzLi5iMDM2YWVkOTY5MTIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgv
dm14LmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwpAQCAtNzYzNyw2ICs3NjM3LDcgQEAg
c3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyB2bXhfeDg2X29wcyBfX2luaXRkYXRhID0gewogCS5n
ZXRfbXNyX2ZlYXR1cmUgPSB2bXhfZ2V0X21zcl9mZWF0dXJlLAogCS5nZXRfbXNyID0gdm14X2dl
dF9tc3IsCiAJLnNldF9tc3IgPSB2bXhfc2V0X21zciwKKwkubXNyX3dyaXRlX2ludGVyY2VwdGVk
ID0gbXNyX3dyaXRlX2ludGVyY2VwdGVkLAogCS5nZXRfc2VnbWVudF9iYXNlID0gdm14X2dldF9z
ZWdtZW50X2Jhc2UsCiAJLmdldF9zZWdtZW50ID0gdm14X2dldF9zZWdtZW50LAogCS5zZXRfc2Vn
bWVudCA9IHZteF9zZXRfc2VnbWVudCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
