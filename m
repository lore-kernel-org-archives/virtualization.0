Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D27C56201
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C8C2083E
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C8C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E977F86ACF;
	Wed, 25 Nov 2020 09:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7H3KdbPqjOZZ; Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3822B86A9D;
	Wed, 25 Nov 2020 09:51:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E32FAC1D9F;
	Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A020C1D9F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0497A2743A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2m9yuHbqf0el
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id 9C3EF274AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:54 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 79672305D509; Wed, 25 Nov 2020 11:35:46 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 5B6183072785;
 Wed, 25 Nov 2020 11:35:46 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 23/81] KVM: x86: extend kvm_mmu_gva_to_gpa_system() with
 the 'access' parameter
Date: Wed, 25 Nov 2020 11:35:02 +0200
Message-Id: <20201125093600.2766-24-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyBuZWVk
ZWQgZm9yIGt2bWlfdXBkYXRlX2FkX2ZsYWdzKCkgdG8gZW11bGF0ZSBhIGd1ZXN0IHBhZ2UKdGFi
bGUgd2FsayBvbiBTUFQgdmlvbGF0aW9ucyBkdWUgdG8gQS9EIGJpdCB1cGRhdGVzLgoKU2lnbmVk
LW9mZi1ieTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDIgKy0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAg
ICAgICAgICAgfCA2ICsrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3Qu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5kZXggYzJkYTVjMjRlODI1Li4z
YTA2YTc3OTk1NzEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTU2OCw3ICsxNTY4LDcg
QEAgZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX2ZldGNoKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
Z3ZhX3QgZ3ZhLAogZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX3dyaXRlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgZ3ZhX3QgZ3ZhLAogCQkJICAgICAgIHN0cnVjdCB4ODZfZXhjZXB0aW9uICpleGNl
cHRpb24pOwogZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX3N5c3RlbShzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIGd2YV90IGd2YSwKLQkJCQlzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uKTsK
KwkJCQl1MzIgYWNjZXNzLCBzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uKTsKIAogYm9v
bCBrdm1fYXBpY3ZfYWN0aXZhdGVkKHN0cnVjdCBrdm0gKmt2bSk7CiB2b2lkIGt2bV9hcGljdl9p
bml0KHN0cnVjdCBrdm0gKmt2bSwgYm9vbCBlbmFibGUpOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDAwYWI3NjM2Njg2OC4uOGVkYTVj
M2JkMjQ0IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3Zt
L3g4Ni5jCkBAIC01ODkwLDkgKzU4OTAsOSBAQCBncGFfdCBrdm1fbW11X2d2YV90b19ncGFfd3Jp
dGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBndmFfdCBndmEsCiAKIC8qIHVzZXMgdGhpcyB0byBh
Y2Nlc3MgYW55IGd1ZXN0J3MgbWFwcGVkIG1lbW9yeSB3aXRob3V0IGNoZWNraW5nIENQTCAqLwog
Z3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX3N5c3RlbShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGd2
YV90IGd2YSwKLQkJCQlzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uKQorCQkJCXUzMiBh
Y2Nlc3MsIHN0cnVjdCB4ODZfZXhjZXB0aW9uICpleGNlcHRpb24pCiB7Ci0JcmV0dXJuIHZjcHUt
PmFyY2gud2Fsa19tbXUtPmd2YV90b19ncGEodmNwdSwgZ3ZhLCAwLCBleGNlcHRpb24pOworCXJl
dHVybiB2Y3B1LT5hcmNoLndhbGtfbW11LT5ndmFfdG9fZ3BhKHZjcHUsIGd2YSwgYWNjZXNzLCBl
eGNlcHRpb24pOwogfQogCiBzdGF0aWMgaW50IGt2bV9yZWFkX2d1ZXN0X3ZpcnRfaGVscGVyKGd2
YV90IGFkZHIsIHZvaWQgKnZhbCwgdW5zaWduZWQgaW50IGJ5dGVzLApAQCAtOTc2Miw3ICs5NzYy
LDcgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfdHJhbnNsYXRlKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwKIAl2Y3B1X2xvYWQodmNwdSk7CiAKIAlpZHggPSBzcmN1X3JlYWRfbG9jaygmdmNwdS0+
a3ZtLT5zcmN1KTsKLQlncGEgPSBrdm1fbW11X2d2YV90b19ncGFfc3lzdGVtKHZjcHUsIHZhZGRy
LCBOVUxMKTsKKwlncGEgPSBrdm1fbW11X2d2YV90b19ncGFfc3lzdGVtKHZjcHUsIHZhZGRyLCAw
LCBOVUxMKTsKIAlzcmN1X3JlYWRfdW5sb2NrKCZ2Y3B1LT5rdm0tPnNyY3UsIGlkeCk7CiAJdHIt
PnBoeXNpY2FsX2FkZHJlc3MgPSBncGE7CiAJdHItPnZhbGlkID0gZ3BhICE9IFVOTUFQUEVEX0dW
QTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
