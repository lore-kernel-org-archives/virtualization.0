Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AEFC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 21:11:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B44207B6
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 21:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B44207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C5A4877C3;
	Mon,  7 Dec 2020 21:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_GVWkTYOpCm; Mon,  7 Dec 2020 21:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2ADE186DDD;
	Mon,  7 Dec 2020 21:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 106F9C0FA7;
	Mon,  7 Dec 2020 21:11:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 578DCC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 21:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4ADBD87A7E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 21:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CPeF-x9P0kB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 21:11:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BB7EF8738F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 21:11:51 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 F3CF630462E3; Mon,  7 Dec 2020 22:46:23 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id CB3223072785;
 Mon,  7 Dec 2020 22:46:23 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 67/81] KVM: introspection: add KVMI_VCPU_GET_XSAVE
Date: Mon,  7 Dec 2020 22:46:08 +0200
Message-Id: <20201207204622.15258-68-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyB2Q1BVIGNv
bW1hbmQgaXMgdXNlZCB0byBnZXQgdGhlIFhTQVZFIGFyZWEuCgpTaWduZWQtb2ZmLWJ5OiBNaWhh
aSBEb27Im3UgPG1kb250dUBiaXRkZWZlbmRlci5jb20+CkNvLWRldmVsb3BlZC1ieTogQWRhbGJl
cnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVy
dCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi92aXJ0
L2t2bS9rdm1pLnJzdCAgICAgICAgICAgICAgIHwgMjkgKysrKysrKysrKysrKysrKysrKwogYXJj
aC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmggICAgICAgICAgICAgIHwgIDQgKysrCiBhcmNo
L3g4Ni9rdm0va3ZtaV9tc2cuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyMCArKysrKysrKysr
KysrCiBpbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oICAgICAgICAgICAgICAgICAgICAgfCAgMSAr
CiAuLi4vdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYyAgfCAyNiArKysr
KysrKysrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9rdm1pLnJzdCBiL0RvY3VtZW50YXRpb24vdmly
dC9rdm0va3ZtaS5yc3QKaW5kZXggMzg0NmZlYzcyZjE0Li4zYjdhNjhjYzhmYWYgMTAwNjQ0Ci0t
LSBhL0RvY3VtZW50YXRpb24vdmlydC9rdm0va3ZtaS5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi92
aXJ0L2t2bS9rdm1pLnJzdApAQCAtODMwLDYgKzgzMCwzNSBAQCBSZXR1cm5zIHRoZSB2YWx1ZSBv
ZiBhbiBleHRlbmRlZCBjb250cm9sIHJlZ2lzdGVyIFhDUi4KICogLUtWTV9FSU5WQUwgLSB0aGUg
cGFkZGluZyBpcyBub3QgemVybwogKiAtS1ZNX0VBR0FJTiAtIHRoZSBzZWxlY3RlZCB2Q1BVIGNh
bid0IGJlIGludHJvc3BlY3RlZCB5ZXQKIAorMTkuIEtWTUlfVkNQVV9HRVRfWFNBVkUKKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCisKKzpBcmNoaXRlY3R1cmVzOiB4ODYKKzpWZXJzaW9uczogPj0g
MQorOlBhcmFtZXRlcnM6CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV92Y3B1X2hkcjsKKworOlJldHVy
bnM6CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV9lcnJvcl9jb2RlOworCXN0cnVjdCBrdm1pX3ZjcHVf
Z2V0X3hzYXZlX3JlcGx5IHsKKwkJc3RydWN0IGt2bV94c2F2ZSB4c2F2ZTsKKwl9OworCitSZXR1
cm5zIGEgYnVmZmVyIGNvbnRhaW5pbmcgdGhlIFhTQVZFIGFyZWEuCisKKzpFcnJvcnM6CisKKyog
LUtWTV9FSU5WQUwgLSB0aGUgc2VsZWN0ZWQgdkNQVSBpcyBpbnZhbGlkCisqIC1LVk1fRUlOVkFM
IC0gdGhlIHBhZGRpbmcgaXMgbm90IHplcm8KKyogLUtWTV9FQUdBSU4gLSB0aGUgc2VsZWN0ZWQg
dkNQVSBjYW4ndCBiZSBpbnRyb3NwZWN0ZWQgeWV0CisqIC1LVk1fRU5PTUVNIC0gdGhlcmUgaXMg
bm90IGVub3VnaCBtZW1vcnkgdG8gYWxsb2NhdGUgdGhlIHJlcGx5CisKIEV2ZW50cwogPT09PT09
CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oIGIvYXJjaC94
ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmgKaW5kZXggYzBhNzMwNTFkNjY3Li5jNmE0NjI1MmE2
ODQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oCkBAIC0xMTEsNCArMTExLDggQEAgc3RydWN0
IGt2bWlfdmNwdV9nZXRfeGNyX3JlcGx5IHsKIAlfX3U2NCB2YWx1ZTsKIH07CiAKK3N0cnVjdCBr
dm1pX3ZjcHVfZ2V0X3hzYXZlX3JlcGx5IHsKKwlzdHJ1Y3Qga3ZtX3hzYXZlIHhzYXZlOworfTsK
KwogI2VuZGlmIC8qIF9VQVBJX0FTTV9YODZfS1ZNSV9IICovCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rdm0va3ZtaV9tc2cuYyBiL2FyY2gveDg2L2t2bS9rdm1pX21zZy5jCmluZGV4IDhiYWRlZjcw
MDNmZC4uYmVmYjFjMjg4MDQ1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYwor
KysgYi9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYwpAQCAtMTk0LDEyICsxOTQsMzIgQEAgc3RhdGlj
IGludCBoYW5kbGVfdmNwdV9nZXRfeGNyKGNvbnN0IHN0cnVjdCBrdm1pX3ZjcHVfbXNnX2pvYiAq
am9iLAogCXJldHVybiBrdm1pX21zZ192Y3B1X3JlcGx5KGpvYiwgbXNnLCBlYywgJnJwbCwgc2l6
ZW9mKHJwbCkpOwogfQogCitzdGF0aWMgaW50IGhhbmRsZV92Y3B1X2dldF94c2F2ZShjb25zdCBz
dHJ1Y3Qga3ZtaV92Y3B1X21zZ19qb2IgKmpvYiwKKwkJCQkgY29uc3Qgc3RydWN0IGt2bWlfbXNn
X2hkciAqbXNnLAorCQkJCSBjb25zdCB2b2lkICpyZXEpCit7CisJc3RydWN0IGt2bWlfdmNwdV9n
ZXRfeHNhdmVfcmVwbHkgKnJwbDsKKwlpbnQgZXJyLCBlYyA9IDA7CisKKwlycGwgPSBrdm1pX21z
Z19hbGxvYygpOworCWlmICghcnBsKQorCQllYyA9IC1LVk1fRU5PTUVNOworCWVsc2UKKwkJa3Zt
X3ZjcHVfaW9jdGxfeDg2X2dldF94c2F2ZShqb2ItPnZjcHUsICZycGwtPnhzYXZlKTsKKworCWVy
ciA9IGt2bWlfbXNnX3ZjcHVfcmVwbHkoam9iLCBtc2csIGVjLCBycGwsIHNpemVvZigqcnBsKSk7
CisKKwlrdm1pX21zZ19mcmVlKHJwbCk7CisJcmV0dXJuIGVycjsKK30KKwogc3RhdGljIGt2bWlf
dmNwdV9tc2dfam9iX2ZjdCBjb25zdCBtc2dfdmNwdVtdID0gewogCVtLVk1JX1ZDUFVfQ09OVFJP
TF9DUl0gICAgICAgPSBoYW5kbGVfdmNwdV9jb250cm9sX2NyLAogCVtLVk1JX1ZDUFVfR0VUX0NQ
VUlEXSAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfY3B1aWQsCiAJW0tWTUlfVkNQVV9HRVRfSU5G
T10gICAgICAgICA9IGhhbmRsZV92Y3B1X2dldF9pbmZvLAogCVtLVk1JX1ZDUFVfR0VUX1JFR0lT
VEVSU10gICAgPSBoYW5kbGVfdmNwdV9nZXRfcmVnaXN0ZXJzLAogCVtLVk1JX1ZDUFVfR0VUX1hD
Ul0gICAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeGNyLAorCVtLVk1JX1ZDUFVfR0VUX1hTQVZF
XSAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeHNhdmUsCiAJW0tWTUlfVkNQVV9JTkpFQ1RfRVhD
RVBUSU9OXSA9IGhhbmRsZV92Y3B1X2luamVjdF9leGNlcHRpb24sCiAJW0tWTUlfVkNQVV9TRVRf
UkVHSVNURVJTXSAgICA9IGhhbmRsZV92Y3B1X3NldF9yZWdpc3RlcnMsCiB9OwpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm1pLmgK
aW5kZXggMDdiNmQzODM2NDFhLi5lNDdjNGNlMGY4ZWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9rdm1pLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaApAQCAtNDUsNiAr
NDUsNyBAQCBlbnVtIHsKIAlLVk1JX1ZDUFVfQ09OVFJPTF9DUiAgICAgICA9IEtWTUlfVkNQVV9N
RVNTQUdFX0lEKDYpLAogCUtWTUlfVkNQVV9JTkpFQ1RfRVhDRVBUSU9OID0gS1ZNSV9WQ1BVX01F
U1NBR0VfSUQoNyksCiAJS1ZNSV9WQ1BVX0dFVF9YQ1IgICAgICAgICAgPSBLVk1JX1ZDUFVfTUVT
U0FHRV9JRCg4KSwKKwlLVk1JX1ZDUFVfR0VUX1hTQVZFICAgICAgICA9IEtWTUlfVkNQVV9NRVNT
QUdFX0lEKDkpLAogCiAJS1ZNSV9ORVhUX1ZDUFVfTUVTU0FHRQogfTsKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0LmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCmluZGV4IGRhOTBjNmE4ZDUzNS4u
Mjc3YjEwNjE0MTBiIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2
XzY0L2t2bWlfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQv
a3ZtaV90ZXN0LmMKQEAgLTE0NDgsNiArMTQ0OCwzMSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NtZF92
Y3B1X2dldF94Y3Ioc3RydWN0IGt2bV92bSAqdm0pCiAJY21kX3ZjcHVfZ2V0X3hjcih2bSwgeGNy
MSwgJnZhbHVlLCAtS1ZNX0VJTlZBTCk7CiB9CiAKK3N0YXRpYyB2b2lkIGNtZF92Y3B1X2dldF94
c2F2ZShzdHJ1Y3Qga3ZtX3ZtICp2bSkKK3sKKwlzdHJ1Y3QgeworCQlzdHJ1Y3Qga3ZtaV9tc2df
aGRyIGhkcjsKKwkJc3RydWN0IGt2bWlfdmNwdV9oZHIgdmNwdV9oZHI7CisJfSByZXEgPSB7fTsK
KwlzdHJ1Y3Qga3ZtX3hzYXZlIHJwbDsKKworCXRlc3RfdmNwdTBfY29tbWFuZCh2bSwgS1ZNSV9W
Q1BVX0dFVF9YU0FWRSwgJnJlcS5oZHIsIHNpemVvZihyZXEpLAorCQkJICAgJnJwbCwgc2l6ZW9m
KHJwbCksIDApOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X2NtZF92Y3B1X2dldF94c2F2ZShzdHJ1
Y3Qga3ZtX3ZtICp2bSkKK3sKKwlzdHJ1Y3Qga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnk7CisKKwll
bnRyeSA9IGt2bV9nZXRfc3VwcG9ydGVkX2NwdWlkX2VudHJ5KDEpOworCWlmICghKGVudHJ5LT5l
Y3ggJiBYODZfRkVBVFVSRV9YU0FWRSkpIHsKKwkJcHJpbnRfc2tpcCgiWFNBVkUgbm90IHN1cHBv
cnRlZCwgZWN4IDB4JXgiLCBlbnRyeS0+ZWN4KTsKKwkJcmV0dXJuOworCX0KKworCWNtZF92Y3B1
X2dldF94c2F2ZSh2bSk7Cit9CisKIHN0YXRpYyB2b2lkIHRlc3RfaW50cm9zcGVjdGlvbihzdHJ1
Y3Qga3ZtX3ZtICp2bSkKIHsKIAlzcmFuZG9tKHRpbWUoMCkpOwpAQCAtMTQ3Niw2ICsxNTAxLDcg
QEAgc3RhdGljIHZvaWQgdGVzdF9pbnRyb3NwZWN0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQogCXRl
c3RfY21kX3ZtX2dldF9tYXhfZ2ZuKCk7CiAJdGVzdF9ldmVudF94c2V0YnYodm0pOwogCXRlc3Rf
Y21kX3ZjcHVfZ2V0X3hjcih2bSk7CisJdGVzdF9jbWRfdmNwdV9nZXRfeHNhdmUodm0pOwogCiAJ
dW5ob29rX2ludHJvc3BlY3Rpb24odm0pOwogfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
