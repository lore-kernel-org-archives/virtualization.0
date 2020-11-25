Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD4FC83010
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D532145D
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AB80D8749E;
	Wed, 25 Nov 2020 09:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZUOB7ZBU8fL1; Wed, 25 Nov 2020 09:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B91E87459;
	Wed, 25 Nov 2020 09:42:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14C5BC1DA0;
	Wed, 25 Nov 2020 09:42:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94881C1836
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84A1F87356
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id exrcwJMUVby1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0326387434
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 581E7305D508; Wed, 25 Nov 2020 11:35:46 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 3AC2C3072784;
 Wed, 25 Nov 2020 11:35:46 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 22/81] KVM: x86: export kvm_arch_vcpu_set_guest_debug()
Date: Wed, 25 Nov 2020 11:35:01 +0200
Message-Id: <20201125093600.2766-23-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGluIG9yZGVyIHRvIG5vdGlmeSB0aGUgaW50cm9zcGVjdGlvbiB0b29sCnRo
cm91Z2ggS1ZNSV9WQ1BVX0VWRU5UX0JQIGV2ZW50cyBvbiBndWVzdCBicmVha3BvaW50cy4KClNp
Z25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBh
cmNoL3g4Ni9rdm0veDg2LmMgICAgICAgfCAxOCArKysrKysrKysrKysrLS0tLS0KIGluY2x1ZGUv
bGludXgva3ZtX2hvc3QuaCB8ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJj
aC94ODYva3ZtL3g4Ni5jCmluZGV4IDgxNjgwMWQ2Yzk1ZC4uMDBhYjc2MzY2ODY4IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCkBAIC05Njg0
LDE0ICs5Njg0LDEyIEBAIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9zcmVncyhzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsCiAJcmV0dXJuIHJldDsKIH0KIAotaW50IGt2bV9hcmNoX3ZjcHVfaW9j
dGxfc2V0X2d1ZXN0X2RlYnVnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKLQkJCQkJc3RydWN0IGt2
bV9ndWVzdF9kZWJ1ZyAqZGJnKQoraW50IGt2bV9hcmNoX3ZjcHVfc2V0X2d1ZXN0X2RlYnVnKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwKKwkJCQkgIHN0cnVjdCBrdm1fZ3Vlc3RfZGVidWcgKmRiZykK
IHsKIAl1bnNpZ25lZCBsb25nIHJmbGFnczsKIAlpbnQgaSwgcjsKIAotCXZjcHVfbG9hZCh2Y3B1
KTsKLQogCWlmIChkYmctPmNvbnRyb2wgJiAoS1ZNX0dVRVNUREJHX0lOSkVDVF9EQiB8IEtWTV9H
VUVTVERCR19JTkpFQ1RfQlApKSB7CiAJCXIgPSAtRUJVU1k7CiAJCWlmICh2Y3B1LT5hcmNoLmV4
Y2VwdGlvbi5wZW5kaW5nKQpAQCAtOTczNywxMCArOTczNSwyMCBAQCBpbnQga3ZtX2FyY2hfdmNw
dV9pb2N0bF9zZXRfZ3Vlc3RfZGVidWcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCXIgPSAwOwog
CiBvdXQ6Ci0JdmNwdV9wdXQodmNwdSk7CiAJcmV0dXJuIHI7CiB9CiAKK2ludCBrdm1fYXJjaF92
Y3B1X2lvY3RsX3NldF9ndWVzdF9kZWJ1ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCisJCQkJCXN0
cnVjdCBrdm1fZ3Vlc3RfZGVidWcgKmRiZykKK3sKKwlpbnQgcmV0OworCisJdmNwdV9sb2FkKHZj
cHUpOworCXJldCA9IGt2bV9hcmNoX3ZjcHVfc2V0X2d1ZXN0X2RlYnVnKHZjcHUsIGRiZyk7CisJ
dmNwdV9wdXQodmNwdSk7CisJcmV0dXJuIHJldDsKK30KKwogLyoKICAqIFRyYW5zbGF0ZSBhIGd1
ZXN0IHZpcnR1YWwgYWRkcmVzcyB0byBhIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3MuCiAgKi8KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaCBiL2luY2x1ZGUvbGludXgva3ZtX2hv
c3QuaAppbmRleCA2ZDYyMmQ4YmQzMzkuLjJjNjQwZWE5ZDdiYSAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9rdm1faG9zdC5oCisrKyBiL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaApAQCAtOTE5
LDYgKzkxOSw4IEBAIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9tcHN0YXRlKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwKIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9ndWVzdF9kZWJ1Zyhz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJCQkJCXN0cnVjdCBrdm1fZ3Vlc3RfZGVidWcgKmRiZyk7
CiBpbnQga3ZtX2FyY2hfdmNwdV9pb2N0bF9ydW4oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKK2lu
dCBrdm1fYXJjaF92Y3B1X3NldF9ndWVzdF9kZWJ1ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCisJ
CQkJICBzdHJ1Y3Qga3ZtX2d1ZXN0X2RlYnVnICpkYmcpOwogCiBpbnQga3ZtX2FyY2hfaW5pdCh2
b2lkICpvcGFxdWUpOwogdm9pZCBrdm1fYXJjaF9leGl0KHZvaWQpOwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
