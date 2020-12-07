Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84DAC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CEF238A0
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CEF238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F455879A4;
	Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtO+N622l7pW; Mon,  7 Dec 2020 20:46:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9D98879D6;
	Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73031C0FA7;
	Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54BE7C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3DC3B86F1F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6MEtQhc4sv9o
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A2AE6869F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 A16CF305D4FD; Mon,  7 Dec 2020 22:46:12 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 7DEB73072785;
 Mon,  7 Dec 2020 22:46:12 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 05/81] KVM: x86: add kvm_arch_vcpu_get_regs() and
 kvm_arch_vcpu_get_sregs()
Date: Mon,  7 Dec 2020 22:45:06 +0200
Message-Id: <20201207204622.15258-6-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhlc2UgZnVuY3Rp
b25zIGFyZSB1c2VkIGJ5IHRoZSBWTSBpbnRyb3NwZWN0aW9uIGNvZGUKKGZvciB0aGUgS1ZNSV9W
Q1BVX0dFVF9SRUdJU1RFUlMgY29tbWFuZCBhbmQgYWxsIGV2ZW50cyBzZW5kaW5nIHRoZSB2Q1BV
CnJlZ2lzdGVycyB0byB0aGUgaW50cm9zcGVjdGlvbiB0b29sKS4KClNpZ25lZC1vZmYtYnk6IE1p
aGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJl
cnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2t2bS94ODYu
YyAgICAgICB8IDEwICsrKysrKysrKysKIGluY2x1ZGUvbGludXgva3ZtX2hvc3QuaCB8ICAzICsr
KwogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IGEzZmRjMTZjZmQ2Zi4uNTQw
ZTQyMzQxNDM1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYv
a3ZtL3g4Ni5jCkBAIC05Mzc1LDYgKzkzNzUsMTEgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxf
Z2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpCiAJ
cmV0dXJuIDA7CiB9CiAKK3ZvaWQga3ZtX2FyY2hfdmNwdV9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBrdm1fcmVncyAqcmVncykKK3sKKwlfX2dldF9yZWdzKHZjcHUsIHJl
Z3MpOworfQorCiBzdGF0aWMgdm9pZCBfX3NldF9yZWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
c3RydWN0IGt2bV9yZWdzICpyZWdzKQogewogCXZjcHUtPmFyY2guZW11bGF0ZV9yZWdzX25lZWRf
c3luY19mcm9tX3ZjcHUgPSB0cnVlOwpAQCAtOTQ3MCw2ICs5NDc1LDExIEBAIGludCBrdm1fYXJj
aF92Y3B1X2lvY3RsX2dldF9zcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJcmV0dXJuIDA7
CiB9CiAKK3ZvaWQga3ZtX2FyY2hfdmNwdV9nZXRfc3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBzdHJ1Y3Qga3ZtX3NyZWdzICpzcmVncykKK3sKKwlfX2dldF9zcmVncyh2Y3B1LCBzcmVncyk7
Cit9CisKIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX2dldF9tcHN0YXRlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwKIAkJCQkgICAgc3RydWN0IGt2bV9tcF9zdGF0ZSAqbXBfc3RhdGUpCiB7CmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0
LmgKaW5kZXggY2Q2YWMzYTQzYzlhLi4xM2M2YjgwNjQ3N2IgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
bGludXgva3ZtX2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKQEAgLTkwMiw5
ICs5MDIsMTIgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfdHJhbnNsYXRlKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwKIAkJCQkgICAgc3RydWN0IGt2bV90cmFuc2xhdGlvbiAqdHIpOwogCiBpbnQg
a3ZtX2FyY2hfdmNwdV9pb2N0bF9nZXRfcmVncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVj
dCBrdm1fcmVncyAqcmVncyk7Cit2b2lkIGt2bV9hcmNoX3ZjcHVfZ2V0X3JlZ3Moc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJlZ3MpOwogaW50IGt2bV9hcmNoX3ZjcHVf
aW9jdGxfc2V0X3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3Qga3ZtX3JlZ3MgKnJl
Z3MpOwogaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfZ2V0X3NyZWdzKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwKIAkJCQkgIHN0cnVjdCBrdm1fc3JlZ3MgKnNyZWdzKTsKK3ZvaWQga3ZtX2FyY2hfdmNw
dV9nZXRfc3JlZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQkJCSAgc3RydWN0IGt2bV9zcmVn
cyAqc3JlZ3MpOwogaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0X3NyZWdzKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwKIAkJCQkgIHN0cnVjdCBrdm1fc3JlZ3MgKnNyZWdzKTsKIGludCBrdm1fYXJj
aF92Y3B1X2lvY3RsX2dldF9tcHN0YXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
