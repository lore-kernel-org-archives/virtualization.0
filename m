Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2442C07EBC
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8014B61175
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8014B61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 24C6B40DA9;
	Wed,  6 Oct 2021 17:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5y1yx2rdCO-S; Wed,  6 Oct 2021 17:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1DDB940DB8;
	Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6090BC001D;
	Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1684CC002C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4526183F30
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKrUBVFWajC6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF04083F4A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 64164305CD5F; Wed,  6 Oct 2021 20:31:01 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 475813064495;
 Wed,  6 Oct 2021 20:31:01 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 20/77] KVM: x86: extend kvm_mmu_gva_to_gpa_system() with
 the 'access' parameter
Date: Wed,  6 Oct 2021 20:30:16 +0300
Message-Id: <20211006173113.26445-21-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyBuZWVk
ZWQgZm9yIGt2bWlfdXBkYXRlX2FkX2ZsYWdzKCkgdG8gZW11bGF0ZSBhIGd1ZXN0IHBhZ2UKdGFi
bGUgd2FsayBvbiBTUFQgdmlvbGF0aW9ucyBkdWUgdG8gQS9EIGJpdCB1cGRhdGVzLgoKU2lnbmVk
LW9mZi1ieTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDIgKy0KIGFyY2gveDg2L2t2bS94ODYuYyAgICAg
ICAgICAgICAgfCA2ICsrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3Qu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5kZXggZGZjNTJlNDUxZjliLi40
OTczNGZlYTdjNGYgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTc4OCw3ICsxNzg4LDcg
QEAgZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX2ZldGNoKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
Z3ZhX3QgZ3ZhLAogZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX3dyaXRlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgZ3ZhX3QgZ3ZhLAogCQkJICAgICAgIHN0cnVjdCB4ODZfZXhjZXB0aW9uICpleGNl
cHRpb24pOwogZ3BhX3Qga3ZtX21tdV9ndmFfdG9fZ3BhX3N5c3RlbShzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIGd2YV90IGd2YSwKLQkJCQlzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uKTsK
KwkJCQl1MzIgYWNjZXNzLCBzdHJ1Y3QgeDg2X2V4Y2VwdGlvbiAqZXhjZXB0aW9uKTsKIAogYm9v
bCBrdm1fYXBpY3ZfYWN0aXZhdGVkKHN0cnVjdCBrdm0gKmt2bSk7CiB2b2lkIGt2bV92Y3B1X3Vw
ZGF0ZV9hcGljdihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDlmZTNiNTNmZDFlMy4uZGUwZmMx
NWFiN2NiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3Zt
L3g4Ni5jCkBAIC02MzY3LDkgKzYzNjcsOSBAQCBFWFBPUlRfU1lNQk9MX0dQTChrdm1fbW11X2d2
YV90b19ncGFfd3JpdGUpOwogCiAvKiB1c2VzIHRoaXMgdG8gYWNjZXNzIGFueSBndWVzdCdzIG1h
cHBlZCBtZW1vcnkgd2l0aG91dCBjaGVja2luZyBDUEwgKi8KIGdwYV90IGt2bV9tbXVfZ3ZhX3Rv
X2dwYV9zeXN0ZW0oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBndmFfdCBndmEsCi0JCQkJc3RydWN0
IHg4Nl9leGNlcHRpb24gKmV4Y2VwdGlvbikKKwkJCQl1MzIgYWNjZXNzLCBzdHJ1Y3QgeDg2X2V4
Y2VwdGlvbiAqZXhjZXB0aW9uKQogewotCXJldHVybiB2Y3B1LT5hcmNoLndhbGtfbW11LT5ndmFf
dG9fZ3BhKHZjcHUsIGd2YSwgMCwgZXhjZXB0aW9uKTsKKwlyZXR1cm4gdmNwdS0+YXJjaC53YWxr
X21tdS0+Z3ZhX3RvX2dwYSh2Y3B1LCBndmEsIGFjY2VzcywgZXhjZXB0aW9uKTsKIH0KIAogc3Rh
dGljIGludCBrdm1fcmVhZF9ndWVzdF92aXJ0X2hlbHBlcihndmFfdCBhZGRyLCB2b2lkICp2YWws
IHVuc2lnbmVkIGludCBieXRlcywKQEAgLTEwNTQ0LDcgKzEwNTQ0LDcgQEAgaW50IGt2bV9hcmNo
X3ZjcHVfaW9jdGxfdHJhbnNsYXRlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAl2Y3B1X2xvYWQo
dmNwdSk7CiAKIAlpZHggPSBzcmN1X3JlYWRfbG9jaygmdmNwdS0+a3ZtLT5zcmN1KTsKLQlncGEg
PSBrdm1fbW11X2d2YV90b19ncGFfc3lzdGVtKHZjcHUsIHZhZGRyLCBOVUxMKTsKKwlncGEgPSBr
dm1fbW11X2d2YV90b19ncGFfc3lzdGVtKHZjcHUsIHZhZGRyLCAwLCBOVUxMKTsKIAlzcmN1X3Jl
YWRfdW5sb2NrKCZ2Y3B1LT5rdm0tPnNyY3UsIGlkeCk7CiAJdHItPnBoeXNpY2FsX2FkZHJlc3Mg
PSBncGE7CiAJdHItPnZhbGlkID0gZ3BhICE9IFVOTUFQUEVEX0dWQTsKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
