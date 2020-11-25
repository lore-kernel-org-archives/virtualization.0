Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD7C56201
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3250F2083E
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3250F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8D7086B24;
	Wed, 25 Nov 2020 09:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8Jfq6EQGArS; Wed, 25 Nov 2020 09:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3EC986A84;
	Wed, 25 Nov 2020 09:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4080C1DA0;
	Wed, 25 Nov 2020 09:52:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E305C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F1E5027516
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ReWU2J0Qf-wx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id 0C09A27A5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 BF6DB30462D2; Wed, 25 Nov 2020 11:35:53 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 9CB353072785;
 Wed, 25 Nov 2020 11:35:53 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 67/81] KVM: introspection: add KVMI_VCPU_GET_XSAVE
Date: Wed, 25 Nov 2020 11:35:46 +0200
Message-Id: <20201125093600.2766-68-alazar@bitdefender.com>
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
dC9rdm0va3ZtaS5yc3QKaW5kZXggMDA4YzdjNzNhNDZmLi5jMWFjNDdkZWY0ZTkgMTAwNjQ0Ci0t
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
ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmgKaW5kZXggNWNhNjE5MGQ4NWVjLi4wZDM2OTZjNTJk
ODggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oCkBAIC0xMTEsNCArMTExLDggQEAgc3RydWN0
IGt2bWlfdmNwdV9nZXRfeGNyX3JlcGx5IHsKIAl1NjQgdmFsdWU7CiB9OwogCitzdHJ1Y3Qga3Zt
aV92Y3B1X2dldF94c2F2ZV9yZXBseSB7CisJc3RydWN0IGt2bV94c2F2ZSB4c2F2ZTsKK307CisK
ICNlbmRpZiAvKiBfVUFQSV9BU01fWDg2X0tWTUlfSCAqLwpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a3ZtL2t2bWlfbXNnLmMgYi9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYwppbmRleCA1OTZmNjA3Mjk2
YjUuLjc3Yzc1M2NkOTcwNSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL2t2bWlfbXNnLmMKKysr
IGIvYXJjaC94ODYva3ZtL2t2bWlfbXNnLmMKQEAgLTE5NCwxMiArMTk0LDMyIEBAIHN0YXRpYyBp
bnQgaGFuZGxlX3ZjcHVfZ2V0X3hjcihjb25zdCBzdHJ1Y3Qga3ZtaV92Y3B1X21zZ19qb2IgKmpv
YiwKIAlyZXR1cm4ga3ZtaV9tc2dfdmNwdV9yZXBseShqb2IsIG1zZywgZWMsICZycGwsIHNpemVv
ZihycGwpKTsKIH0KIAorc3RhdGljIGludCBoYW5kbGVfdmNwdV9nZXRfeHNhdmUoY29uc3Qgc3Ry
dWN0IGt2bWlfdmNwdV9tc2dfam9iICpqb2IsCisJCQkJIGNvbnN0IHN0cnVjdCBrdm1pX21zZ19o
ZHIgKm1zZywKKwkJCQkgY29uc3Qgdm9pZCAqcmVxKQoreworCXN0cnVjdCBrdm1pX3ZjcHVfZ2V0
X3hzYXZlX3JlcGx5ICpycGw7CisJaW50IGVyciwgZWMgPSAwOworCisJcnBsID0ga3ZtaV9tc2df
YWxsb2MoKTsKKwlpZiAoIXJwbCkKKwkJZWMgPSAtS1ZNX0VOT01FTTsKKwllbHNlCisJCWt2bV92
Y3B1X2lvY3RsX3g4Nl9nZXRfeHNhdmUoam9iLT52Y3B1LCAmcnBsLT54c2F2ZSk7CisKKwllcnIg
PSBrdm1pX21zZ192Y3B1X3JlcGx5KGpvYiwgbXNnLCAwLCBycGwsIHNpemVvZigqcnBsKSk7CisK
Kwlrdm1pX21zZ19mcmVlKHJwbCk7CisJcmV0dXJuIGVycjsKK30KKwogc3RhdGljIGt2bWlfdmNw
dV9tc2dfam9iX2ZjdCBjb25zdCBtc2dfdmNwdVtdID0gewogCVtLVk1JX1ZDUFVfQ09OVFJPTF9D
Ul0gICAgICAgPSBoYW5kbGVfdmNwdV9jb250cm9sX2NyLAogCVtLVk1JX1ZDUFVfR0VUX0NQVUlE
XSAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfY3B1aWQsCiAJW0tWTUlfVkNQVV9HRVRfSU5GT10g
ICAgICAgICA9IGhhbmRsZV92Y3B1X2dldF9pbmZvLAogCVtLVk1JX1ZDUFVfR0VUX1JFR0lTVEVS
U10gICAgPSBoYW5kbGVfdmNwdV9nZXRfcmVnaXN0ZXJzLAogCVtLVk1JX1ZDUFVfR0VUX1hDUl0g
ICAgICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeGNyLAorCVtLVk1JX1ZDUFVfR0VUX1hTQVZFXSAg
ICAgICAgPSBoYW5kbGVfdmNwdV9nZXRfeHNhdmUsCiAJW0tWTUlfVkNQVV9JTkpFQ1RfRVhDRVBU
SU9OXSA9IGhhbmRsZV92Y3B1X2luamVjdF9leGNlcHRpb24sCiAJW0tWTUlfVkNQVV9TRVRfUkVH
SVNURVJTXSAgICA9IGhhbmRsZV92Y3B1X3NldF9yZWdpc3RlcnMsCiB9OwpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm1pLmgKaW5k
ZXggMDdiNmQzODM2NDFhLi5lNDdjNGNlMGY4ZWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC9rdm1pLmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaApAQCAtNDUsNiArNDUs
NyBAQCBlbnVtIHsKIAlLVk1JX1ZDUFVfQ09OVFJPTF9DUiAgICAgICA9IEtWTUlfVkNQVV9NRVNT
QUdFX0lEKDYpLAogCUtWTUlfVkNQVV9JTkpFQ1RfRVhDRVBUSU9OID0gS1ZNSV9WQ1BVX01FU1NB
R0VfSUQoNyksCiAJS1ZNSV9WQ1BVX0dFVF9YQ1IgICAgICAgICAgPSBLVk1JX1ZDUFVfTUVTU0FH
RV9JRCg4KSwKKwlLVk1JX1ZDUFVfR0VUX1hTQVZFICAgICAgICA9IEtWTUlfVkNQVV9NRVNTQUdF
X0lEKDkpLAogCiAJS1ZNSV9ORVhUX1ZDUFVfTUVTU0FHRQogfTsKZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0LmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCmluZGV4IGRhOTBjNmE4ZDUzNS4uMjc3
YjEwNjE0MTBiIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0
L2t2bWlfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3Zt
aV90ZXN0LmMKQEAgLTE0NDgsNiArMTQ0OCwzMSBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NtZF92Y3B1
X2dldF94Y3Ioc3RydWN0IGt2bV92bSAqdm0pCiAJY21kX3ZjcHVfZ2V0X3hjcih2bSwgeGNyMSwg
JnZhbHVlLCAtS1ZNX0VJTlZBTCk7CiB9CiAKK3N0YXRpYyB2b2lkIGNtZF92Y3B1X2dldF94c2F2
ZShzdHJ1Y3Qga3ZtX3ZtICp2bSkKK3sKKwlzdHJ1Y3QgeworCQlzdHJ1Y3Qga3ZtaV9tc2dfaGRy
IGhkcjsKKwkJc3RydWN0IGt2bWlfdmNwdV9oZHIgdmNwdV9oZHI7CisJfSByZXEgPSB7fTsKKwlz
dHJ1Y3Qga3ZtX3hzYXZlIHJwbDsKKworCXRlc3RfdmNwdTBfY29tbWFuZCh2bSwgS1ZNSV9WQ1BV
X0dFVF9YU0FWRSwgJnJlcS5oZHIsIHNpemVvZihyZXEpLAorCQkJICAgJnJwbCwgc2l6ZW9mKHJw
bCksIDApOworfQorCitzdGF0aWMgdm9pZCB0ZXN0X2NtZF92Y3B1X2dldF94c2F2ZShzdHJ1Y3Qg
a3ZtX3ZtICp2bSkKK3sKKwlzdHJ1Y3Qga3ZtX2NwdWlkX2VudHJ5MiAqZW50cnk7CisKKwllbnRy
eSA9IGt2bV9nZXRfc3VwcG9ydGVkX2NwdWlkX2VudHJ5KDEpOworCWlmICghKGVudHJ5LT5lY3gg
JiBYODZfRkVBVFVSRV9YU0FWRSkpIHsKKwkJcHJpbnRfc2tpcCgiWFNBVkUgbm90IHN1cHBvcnRl
ZCwgZWN4IDB4JXgiLCBlbnRyeS0+ZWN4KTsKKwkJcmV0dXJuOworCX0KKworCWNtZF92Y3B1X2dl
dF94c2F2ZSh2bSk7Cit9CisKIHN0YXRpYyB2b2lkIHRlc3RfaW50cm9zcGVjdGlvbihzdHJ1Y3Qg
a3ZtX3ZtICp2bSkKIHsKIAlzcmFuZG9tKHRpbWUoMCkpOwpAQCAtMTQ3Niw2ICsxNTAxLDcgQEAg
c3RhdGljIHZvaWQgdGVzdF9pbnRyb3NwZWN0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQogCXRlc3Rf
Y21kX3ZtX2dldF9tYXhfZ2ZuKCk7CiAJdGVzdF9ldmVudF94c2V0YnYodm0pOwogCXRlc3RfY21k
X3ZjcHVfZ2V0X3hjcih2bSk7CisJdGVzdF9jbWRfdmNwdV9nZXRfeHNhdmUodm0pOwogCiAJdW5o
b29rX2ludHJvc3BlY3Rpb24odm0pOwogfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
