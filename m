Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB70C43219
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34EF6052B
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C34EF6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AFA2408DA;
	Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1oZe0MccSDfJ; Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 458B7408CF;
	Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 824BDC0023;
	Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4099C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8960860EEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caBO0J2m_8zH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8AA7A60EE9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 ED858307CAE4; Wed,  6 Oct 2021 20:31:00 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id D22903064495;
 Wed,  6 Oct 2021 20:31:00 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 19/77] KVM: x86: export kvm_arch_vcpu_set_guest_debug()
Date: Wed,  6 Oct 2021 20:30:15 +0300
Message-Id: <20211006173113.26445-20-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGluIG9yZGVyIHRvIG5vdGlmeSB0aGUgaW50cm9zcGVjdGlvbiB0b29sCnRo
cm91Z2ggS1ZNSV9WQ1BVX0VWRU5UX0JQIGV2ZW50cyBvbiBndWVzdCBicmVha3BvaW50cy4KClNp
Z25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBh
cmNoL3g4Ni9rdm0veDg2LmMgICAgICAgfCAyNCArKysrKysrKysrKysrKysrLS0tLS0tLS0KIGlu
Y2x1ZGUvbGludXgva3ZtX2hvc3QuaCB8ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5j
IGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDJiNWMzYzIyYzQ4ZS4uOWZlM2I1M2ZkMWUzIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCkBA
IC0xMDQ2NCwxNyArMTA0NjQsMTIgQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0X3NyZWdz
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAlyZXR1cm4gcmV0OwogfQogCi1pbnQga3ZtX2FyY2hf
dmNwdV9pb2N0bF9zZXRfZ3Vlc3RfZGVidWcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAotCQkJCQlz
dHJ1Y3Qga3ZtX2d1ZXN0X2RlYnVnICpkYmcpCitpbnQga3ZtX2FyY2hfdmNwdV9zZXRfZ3Vlc3Rf
ZGVidWcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQkJCSAgc3RydWN0IGt2bV9ndWVzdF9kZWJ1
ZyAqZGJnKQogewogCXVuc2lnbmVkIGxvbmcgcmZsYWdzOwogCWludCBpLCByOwogCi0JaWYgKHZj
cHUtPmFyY2guZ3Vlc3Rfc3RhdGVfcHJvdGVjdGVkKQotCQlyZXR1cm4gLUVJTlZBTDsKLQotCXZj
cHVfbG9hZCh2Y3B1KTsKLQogCWlmIChkYmctPmNvbnRyb2wgJiAoS1ZNX0dVRVNUREJHX0lOSkVD
VF9EQiB8IEtWTV9HVUVTVERCR19JTkpFQ1RfQlApKSB7CiAJCXIgPSAtRUJVU1k7CiAJCWlmICh2
Y3B1LT5hcmNoLmV4Y2VwdGlvbi5wZW5kaW5nKQpAQCAtMTA1MTksMTAgKzEwNTE0LDIzIEBAIGlu
dCBrdm1fYXJjaF92Y3B1X2lvY3RsX3NldF9ndWVzdF9kZWJ1ZyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsCiAJciA9IDA7CiAKIG91dDoKLQl2Y3B1X3B1dCh2Y3B1KTsKIAlyZXR1cm4gcjsKIH0KIAor
aW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxfc2V0X2d1ZXN0X2RlYnVnKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwKKwkJCQkJc3RydWN0IGt2bV9ndWVzdF9kZWJ1ZyAqZGJnKQoreworCWludCByZXQ7CisK
KwlpZiAodmNwdS0+YXJjaC5ndWVzdF9zdGF0ZV9wcm90ZWN0ZWQpCisJCXJldHVybiAtRUlOVkFM
OworCisJdmNwdV9sb2FkKHZjcHUpOworCXJldCA9IGt2bV9hcmNoX3ZjcHVfc2V0X2d1ZXN0X2Rl
YnVnKHZjcHUsIGRiZyk7CisJdmNwdV9wdXQodmNwdSk7CisJcmV0dXJuIHJldDsKK30KKwogLyoK
ICAqIFRyYW5zbGF0ZSBhIGd1ZXN0IHZpcnR1YWwgYWRkcmVzcyB0byBhIGd1ZXN0IHBoeXNpY2Fs
IGFkZHJlc3MuCiAgKi8KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaCBiL2lu
Y2x1ZGUvbGludXgva3ZtX2hvc3QuaAppbmRleCA3MTI2NDJiZTMzMDcuLjJlNDMwMGJmOTM2ZiAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9rdm1faG9zdC5oCisrKyBiL2luY2x1ZGUvbGludXgv
a3ZtX2hvc3QuaApAQCAtMTA0Myw2ICsxMDQzLDggQEAgaW50IGt2bV9hcmNoX3ZjcHVfaW9jdGxf
c2V0X21wc3RhdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogaW50IGt2bV9hcmNoX3ZjcHVfaW9j
dGxfc2V0X2d1ZXN0X2RlYnVnKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAkJCQkJc3RydWN0IGt2
bV9ndWVzdF9kZWJ1ZyAqZGJnKTsKIGludCBrdm1fYXJjaF92Y3B1X2lvY3RsX3J1bihzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpOworaW50IGt2bV9hcmNoX3ZjcHVfc2V0X2d1ZXN0X2RlYnVnKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwKKwkJCQkgIHN0cnVjdCBrdm1fZ3Vlc3RfZGVidWcgKmRiZyk7CiAK
IGludCBrdm1fYXJjaF9pbml0KHZvaWQgKm9wYXF1ZSk7CiB2b2lkIGt2bV9hcmNoX2V4aXQodm9p
ZCk7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
