Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5116661184
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5116661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21BEC40907;
	Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZSHShuysKDBk; Wed,  6 Oct 2021 17:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 84174408FB;
	Wed,  6 Oct 2021 17:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51BC2C0024;
	Wed,  6 Oct 2021 17:55:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27F3FC0023
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BB8360EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BHw8oPAzlIGY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBCEA60EF5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4E48F307CAEA; Wed,  6 Oct 2021 20:31:02 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2AF00305FFA0;
 Wed,  6 Oct 2021 20:31:02 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 22/77] KVM: x86: export kvm_vcpu_ioctl_x86_get_xsave()
Date: Wed,  6 Oct 2021 20:30:18 +0300
Message-Id: <20211006173113.26445-23-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX0dFVF9YU0FWRSBjb21tYW5kLgoKU2lnbmVk
LW9mZi1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAzICsrKwogYXJjaC94ODYva3ZtL3g4Ni5jICAg
ICAgICAgICAgICB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3Qu
aCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5kZXggNjgxZTI3YzIwNjVkLi4x
ZDNhNjI1MzZhOTMgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTc0MCw2ICsxNzQwLDkg
QEAgdW5zaWduZWQgbG9uZyBrdm1fZ2V0X3JmbGFncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwog
dm9pZCBrdm1fc2V0X3JmbGFncyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcg
cmZsYWdzKTsKIGludCBrdm1fZW11bGF0ZV9yZHBtYyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwog
Cit2b2lkIGt2bV92Y3B1X2lvY3RsX3g4Nl9nZXRfeHNhdmUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LAorCQkJCSAgc3RydWN0IGt2bV94c2F2ZSAqZ3Vlc3RfeHNhdmUpOworCiBib29sIGt2bV9pbmpl
Y3RfcGVuZGluZ19leGNlcHRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIHZvaWQga3ZtX3F1
ZXVlX2V4Y2VwdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIG5yKTsKIHZvaWQg
a3ZtX3F1ZXVlX2V4Y2VwdGlvbl9lKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbnIs
IHUzMiBlcnJvcl9jb2RlKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gv
eDg2L2t2bS94ODYuYwppbmRleCAwY2QzMjk2MjJlMWUuLjBiODhlMDVlOTRmNyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYva3ZtL3g4Ni5jCisrKyBiL2FyY2gveDg2L2t2bS94ODYuYwpAQCAtNDc5MSw4
ICs0NzkxLDggQEAgc3RhdGljIHZvaWQgbG9hZF94c2F2ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHU4ICpzcmMpCiAJfQogfQogCi1zdGF0aWMgdm9pZCBrdm1fdmNwdV9pb2N0bF94ODZfZ2V0X3hz
YXZlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKLQkJCQkJIHN0cnVjdCBrdm1feHNhdmUgKmd1ZXN0
X3hzYXZlKQordm9pZCBrdm1fdmNwdV9pb2N0bF94ODZfZ2V0X3hzYXZlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwKKwkJCQkgIHN0cnVjdCBrdm1feHNhdmUgKmd1ZXN0X3hzYXZlKQogewogCWlmICgh
dmNwdS0+YXJjaC5ndWVzdF9mcHUpCiAJCXJldHVybjsKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
