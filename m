Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D66C4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB0B2389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0B2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 133AB87A47;
	Mon,  7 Dec 2020 20:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pq7RadUVhTYH; Mon,  7 Dec 2020 20:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EA7A087938;
	Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD868C013B;
	Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64DA2C163C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 61F92869F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YBlJcVaY-qa7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A9E7E86E22
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 C860F305D4FE; Mon,  7 Dec 2020 22:46:12 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id A6EE43072784;
 Mon,  7 Dec 2020 22:46:12 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 06/81] KVM: x86: add kvm_arch_vcpu_set_regs()
Date: Mon,  7 Dec 2020 22:45:07 +0200
Message-Id: <20201207204622.15258-7-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgaXMgbmVl
ZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX1NFVF9SRUdJU1RFUlMgY29tbWFuZCwgd2hpY2ggYWxsb3dz
CmFuIGludHJvc3BlY3Rpb24gdG9vbCB0byBvdmVycmlkZSB0aGUga3ZtX3JlZ3Mgc3RydWN0dXJl
IGZvciBhIHNwZWNpZmljCnZDUFUgd2l0aG91dCBjbGVhcmluZyB0aGUgcGVuZGluZyBleGNlcHRp
b24uIEluIG1vc3QgY2FzZXMgdGhpcyBpcyB1c2VkCnRvIGluY3JlbWVudCB0aGUgcHJvZ3JhbSBj
b3VudGVyLgoKU2lnbmVkLW9mZi1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3Vk
LmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIu
Y29tPgotLS0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAgICB8IDIxICsrKysrKysrKysrKysrLS0t
LS0tLQogaW5jbHVkZS9saW51eC9rdm1faG9zdC5oIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwg
MTYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
dm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggNTQwZTQyMzQxNDM1Li41OTUxNDU4
NDA4ZmIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNoL3g4Ni9rdm0v
eDg2LmMKQEAgLTk0MDYsMTYgKzk0MDYsMjMgQEAgc3RhdGljIHZvaWQgX19zZXRfcmVncyhzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncykKIAogCWt2bV9yaXBfd3Jp
dGUodmNwdSwgcmVncy0+cmlwKTsKIAlrdm1fc2V0X3JmbGFncyh2Y3B1LCByZWdzLT5yZmxhZ3Mg
fCBYODZfRUZMQUdTX0ZJWEVEKTsKLQotCXZjcHUtPmFyY2guZXhjZXB0aW9uLnBlbmRpbmcgPSBm
YWxzZTsKLQotCWt2bV9tYWtlX3JlcXVlc3QoS1ZNX1JFUV9FVkVOVCwgdmNwdSk7CiB9CiAKLWlu
dCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3Ry
dWN0IGt2bV9yZWdzICpyZWdzKQordm9pZCBrdm1fYXJjaF92Y3B1X3NldF9yZWdzKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2bV9yZWdzICpyZWdzLAorCQkJICAgIGJvb2wgY2xlYXJf
ZXhjZXB0aW9uKQogewotCXZjcHVfbG9hZCh2Y3B1KTsKIAlfX3NldF9yZWdzKHZjcHUsIHJlZ3Mp
OworCisJaWYgKGNsZWFyX2V4Y2VwdGlvbikKKwkJdmNwdS0+YXJjaC5leGNlcHRpb24ucGVuZGlu
ZyA9IGZhbHNlOworCisJa3ZtX21ha2VfcmVxdWVzdChLVk1fUkVRX0VWRU5ULCB2Y3B1KTsKK30K
KworaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpCit7CisJdmNwdV9sb2FkKHZjcHUpOworCWt2bV9hcmNo
X3ZjcHVfc2V0X3JlZ3ModmNwdSwgcmVncywgdHJ1ZSk7CiAJdmNwdV9wdXQodmNwdSk7CiAJcmV0
dXJuIDA7CiB9CkBAIC05ODE2LDcgKzk4MjMsNyBAQCBzdGF0aWMgaW50IHN5bmNfcmVncyhzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJCXJldHVybiAtRUlOVkFMOwogCiAJaWYgKHZjcHUtPnJ1bi0+
a3ZtX2RpcnR5X3JlZ3MgJiBLVk1fU1lOQ19YODZfUkVHUykgewotCQlfX3NldF9yZWdzKHZjcHUs
ICZ2Y3B1LT5ydW4tPnMucmVncy5yZWdzKTsKKwkJa3ZtX2FyY2hfdmNwdV9zZXRfcmVncyh2Y3B1
LCAmdmNwdS0+cnVuLT5zLnJlZ3MucmVncywgdHJ1ZSk7CiAJCXZjcHUtPnJ1bi0+a3ZtX2RpcnR5
X3JlZ3MgJj0gfktWTV9TWU5DX1g4Nl9SRUdTOwogCX0KIAlpZiAodmNwdS0+cnVuLT5rdm1fZGly
dHlfcmVncyAmIEtWTV9TWU5DX1g4Nl9TUkVHUykgewpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51
eC9rdm1faG9zdC5oIGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCmluZGV4IDEzYzZiODA2NDc3
Yi4uNmQ2MjJkOGJkMzM5IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKKysr
IGIvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCkBAIC05MDQsNiArOTA0LDggQEAgaW50IGt2bV9h
cmNoX3ZjcHVfaW9jdGxfdHJhbnNsYXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIGludCBrdm1f
YXJjaF92Y3B1X2lvY3RsX2dldF9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGt2
bV9yZWdzICpyZWdzKTsKIHZvaWQga3ZtX2FyY2hfdmNwdV9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncyk7CiBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0
bF9zZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncyk7
Cit2b2lkIGt2bV9hcmNoX3ZjcHVfc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1
Y3Qga3ZtX3JlZ3MgKnJlZ3MsCisJCQkgICAgYm9vbCBjbGVhcl9leGNlcHRpb24pOwogaW50IGt2
bV9hcmNoX3ZjcHVfaW9jdGxfZ2V0X3NyZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAkJCQkg
IHN0cnVjdCBrdm1fc3JlZ3MgKnNyZWdzKTsKIHZvaWQga3ZtX2FyY2hfdmNwdV9nZXRfc3JlZ3Mo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
