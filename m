Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8FEC43219
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F5C6117A
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87F5C6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6C57440D8D;
	Wed,  6 Oct 2021 17:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bFHJI-blWVa; Wed,  6 Oct 2021 17:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D04C401BB;
	Wed,  6 Oct 2021 17:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 999B2C0029;
	Wed,  6 Oct 2021 17:50:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A82D0C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91E95407EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vb7Nvm70JYbp
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DBD3401BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:50:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 15FA430827B0; Wed,  6 Oct 2021 20:31:20 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id F0BC4300F73A;
 Wed,  6 Oct 2021 20:31:19 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 62/77] KVM: introspection: add KVMI_VCPU_GET_XCR
Date: Wed,  6 Oct 2021 20:30:58 +0300
Message-Id: <20211006173113.26445-63-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
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

VGhpcyBjYW4gYmUgdXNlZCBieSB0aGUgaW50cm9zcGVjdGlvbiB0b29sIHRvIGVtdWxhdGUgU1NF
IGluc3RydWN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJp
dGRlZmVuZGVyLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0ICAgICAg
ICAgICAgICAgfCAzMyArKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9pbmNsdWRlL3VhcGkv
YXNtL2t2bWkuaCAgICAgICAgICAgICAgfCAgOSArKysrKwogYXJjaC94ODYva3ZtL2t2bWlfbXNn
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrCiBpbmNsdWRlL3VhcGkv
bGludXgva3ZtaS5oICAgICAgICAgICAgICAgICAgICAgfCAgMSArCiAuLi4vdGVzdGluZy9zZWxm
dGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYyAgfCAzMyArKysrKysrKysrKysrKysrKysrCiA1
IGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL3ZpcnQva3ZtL2t2bWkucnN0IGIvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9rdm1pLnJzdApp
bmRleCBkM2EwYmVhNjRlMDIuLjM4OWQ2OWUzZmQ3ZSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlv
bi92aXJ0L2t2bS9rdm1pLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0
CkBAIC03NzgsNiArNzc4LDM5IEBAIGV4Y2VwdGlvbi4KICogLUtWTV9FQlVTWSAtIGFub3RoZXIg
KktWTUlfVkNQVV9JTkpFQ1RfRVhDRVBUSU9OKi0qS1ZNSV9WQ1BVX0VWRU5UX1RSQVAqCiAgICAg
ICAgICAgICAgICBwYWlyIGlzIGluIHByb2dyZXNzCiAKKzE3LiBLVk1JX1ZDUFVfR0VUX1hDUgor
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKKzpBcmNoaXRlY3R1cmVzOiB4ODYKKzpWZXJzaW9uczog
Pj0gMQorOlBhcmFtZXRlcnM6CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV92Y3B1X2hkcjsKKwlzdHJ1
Y3Qga3ZtaV92Y3B1X2dldF94Y3IgeworCQlfX3U4IHhjcjsKKwkJX191OCBwYWRkaW5nWzddOwor
CX07CisKKzpSZXR1cm5zOgorCis6OgorCisJc3RydWN0IGt2bWlfZXJyb3JfY29kZTsKKwlzdHJ1
Y3Qga3ZtaV92Y3B1X2dldF94Y3JfcmVwbHkgeworCQlfX3U2NCB2YWx1ZTsKKwl9OworCitSZXR1
cm5zIHRoZSB2YWx1ZSBvZiBhbiBleHRlbmRlZCBjb250cm9sIHJlZ2lzdGVyIFhDUi4KKworOkVy
cm9yczoKKworKiAtS1ZNX0VJTlZBTCAtIHRoZSBzZWxlY3RlZCB2Q1BVIGlzIGludmFsaWQKKyog
LUtWTV9FSU5WQUwgLSB0aGUgc3BlY2lmaWVkIGNvbnRyb2wgcmVnaXN0ZXIgaXMgbm90IFhDUjAK
KyogLUtWTV9FSU5WQUwgLSB0aGUgcGFkZGluZyBpcyBub3QgemVybworKiAtS1ZNX0VBR0FJTiAt
IHRoZSBzZWxlY3RlZCB2Q1BVIGNhbid0IGJlIGludHJvc3BlY3RlZCB5ZXQKKwogRXZlbnRzCiA9
PT09PT0KIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmggYi9h
cmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bWkuaAppbmRleCA2MDRhOGIzZDRhYzIuLmMwYTcz
MDUxZDY2NyAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmgKKysr
IGIvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm1pLmgKQEAgLTEwMiw0ICsxMDIsMTMgQEAg
c3RydWN0IGt2bWlfdmNwdV9ldmVudF94c2V0YnYgewogCV9fdTY0IG5ld192YWx1ZTsKIH07CiAK
K3N0cnVjdCBrdm1pX3ZjcHVfZ2V0X3hjciB7CisJX191OCB4Y3I7CisJX191OCBwYWRkaW5nWzdd
OworfTsKKworc3RydWN0IGt2bWlfdmNwdV9nZXRfeGNyX3JlcGx5IHsKKwlfX3U2NCB2YWx1ZTsK
K307CisKICNlbmRpZiAvKiBfVUFQSV9BU01fWDg2X0tWTUlfSCAqLwpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL2t2bWlfbXNnLmMgYi9hcmNoL3g4Ni9rdm0va3ZtaV9tc2cuYwppbmRleCBjNzY3
Yjk2OWRmNTMuLjIxNjI0NTY4ZTMyOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL2t2bWlfbXNn
LmMKKysrIGIvYXJjaC94ODYva3ZtL2t2bWlfbXNnLmMKQEAgLTE3NCwxMSArMTc0LDMyIEBAIHN0
YXRpYyBpbnQgaGFuZGxlX3ZjcHVfaW5qZWN0X2V4Y2VwdGlvbihjb25zdCBzdHJ1Y3Qga3ZtaV92
Y3B1X21zZ19qb2IgKmpvYiwKIAlyZXR1cm4ga3ZtaV9tc2dfdmNwdV9yZXBseShqb2IsIG1zZywg
ZWMsIE5VTEwsIDApOwogfQogCitzdGF0aWMgaW50IGhhbmRsZV92Y3B1X2dldF94Y3IoY29uc3Qg
c3RydWN0IGt2bWlfdmNwdV9tc2dfam9iICpqb2IsCisJCQkgICAgICAgY29uc3Qgc3RydWN0IGt2
bWlfbXNnX2hkciAqbXNnLAorCQkJICAgICAgIGNvbnN0IHZvaWQgKl9yZXEpCit7CisJY29uc3Qg
c3RydWN0IGt2bWlfdmNwdV9nZXRfeGNyICpyZXEgPSBfcmVxOworCXN0cnVjdCBrdm1pX3ZjcHVf
Z2V0X3hjcl9yZXBseSBycGw7CisJaW50IGVjID0gMDsKKworCW1lbXNldCgmcnBsLCAwLCBzaXpl
b2YocnBsKSk7CisKKwlpZiAobm9uX3plcm9fcGFkZGluZyhyZXEtPnBhZGRpbmcsIEFSUkFZX1NJ
WkUocmVxLT5wYWRkaW5nKSkpCisJCWVjID0gLUtWTV9FSU5WQUw7CisJZWxzZSBpZiAocmVxLT54
Y3IgIT0gMCkKKwkJZWMgPSAtS1ZNX0VJTlZBTDsKKwllbHNlCisJCXJwbC52YWx1ZSA9IGpvYi0+
dmNwdS0+YXJjaC54Y3IwOworCisJcmV0dXJuIGt2bWlfbXNnX3ZjcHVfcmVwbHkoam9iLCBtc2cs
IGVjLCAmcnBsLCBzaXplb2YocnBsKSk7Cit9CisKIHN0YXRpYyBjb25zdCBrdm1pX3ZjcHVfbXNn
X2pvYl9mY3QgbXNnX3ZjcHVbXSA9IHsKIAlbS1ZNSV9WQ1BVX0NPTlRST0xfQ1JdICAgICAgID0g
aGFuZGxlX3ZjcHVfY29udHJvbF9jciwKIAlbS1ZNSV9WQ1BVX0dFVF9DUFVJRF0gICAgICAgID0g
aGFuZGxlX3ZjcHVfZ2V0X2NwdWlkLAogCVtLVk1JX1ZDUFVfR0VUX0lORk9dICAgICAgICAgPSBo
YW5kbGVfdmNwdV9nZXRfaW5mbywKIAlbS1ZNSV9WQ1BVX0dFVF9SRUdJU1RFUlNdICAgID0gaGFu
ZGxlX3ZjcHVfZ2V0X3JlZ2lzdGVycywKKwlbS1ZNSV9WQ1BVX0dFVF9YQ1JdICAgICAgICAgID0g
aGFuZGxlX3ZjcHVfZ2V0X3hjciwKIAlbS1ZNSV9WQ1BVX0lOSkVDVF9FWENFUFRJT05dID0gaGFu
ZGxlX3ZjcHVfaW5qZWN0X2V4Y2VwdGlvbiwKIAlbS1ZNSV9WQ1BVX1NFVF9SRUdJU1RFUlNdICAg
ID0gaGFuZGxlX3ZjcHVfc2V0X3JlZ2lzdGVycywKIH07CmRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgva3ZtaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAppbmRleCA0YjcxYzZi
MGIxNmMuLmFjMjM3NTQ2MjdmZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWku
aAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oCkBAIC00Myw2ICs0Myw3IEBAIGVudW0g
ewogCUtWTUlfVkNQVV9HRVRfQ1BVSUQgICAgICAgID0gS1ZNSV9WQ1BVX01FU1NBR0VfSUQoNSks
CiAJS1ZNSV9WQ1BVX0NPTlRST0xfQ1IgICAgICAgPSBLVk1JX1ZDUFVfTUVTU0FHRV9JRCg2KSwK
IAlLVk1JX1ZDUFVfSU5KRUNUX0VYQ0VQVElPTiA9IEtWTUlfVkNQVV9NRVNTQUdFX0lEKDcpLAor
CUtWTUlfVkNQVV9HRVRfWENSICAgICAgICAgID0gS1ZNSV9WQ1BVX01FU1NBR0VfSUQoOCksCiAK
IAlLVk1JX05FWFRfVkNQVV9NRVNTQUdFCiB9OwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2t2bS94ODZfNjQva3ZtaV90ZXN0LmMKaW5kZXggMzgwYWEzZDJkOGYzLi5kOTQ5NzcyN2U4NTkg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0
LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYwpA
QCAtMTQwNSw2ICsxNDA1LDM4IEBAIHN0YXRpYyB2b2lkIHRlc3RfZXZlbnRfeHNldGJ2KHN0cnVj
dCBrdm1fdm0gKnZtKQogCWRpc2FibGVfdmNwdV9ldmVudCh2bSwgZXZlbnRfaWQpOwogfQogCitz
dGF0aWMgdm9pZCBjbWRfdmNwdV9nZXRfeGNyKHN0cnVjdCBrdm1fdm0gKnZtLCB1OCB4Y3IsIHU2
NCAqdmFsdWUsCisJCQkgICAgIGludCBleHBlY3RlZF9lcnIpCit7CisJc3RydWN0IHsKKwkJc3Ry
dWN0IGt2bWlfbXNnX2hkciBoZHI7CisJCXN0cnVjdCBrdm1pX3ZjcHVfaGRyIHZjcHVfaGRyOwor
CQlzdHJ1Y3Qga3ZtaV92Y3B1X2dldF94Y3IgY21kOworCX0gcmVxID0geyAwIH07CisJc3RydWN0
IGt2bWlfdmNwdV9nZXRfeGNyX3JlcGx5IHJwbCA9IHsgMCB9OworCWludCByOworCisJcmVxLmNt
ZC54Y3IgPSB4Y3I7CisKKwlyID0gZG9fdmNwdTBfY29tbWFuZCh2bSwgS1ZNSV9WQ1BVX0dFVF9Y
Q1IsICZyZXEuaGRyLCBzaXplb2YocmVxKSwKKwkJCSAgICAgJnJwbCwgc2l6ZW9mKHJwbCkpOwor
CVRFU1RfQVNTRVJUKHIgPT0gZXhwZWN0ZWRfZXJyLAorCQkiS1ZNSV9WQ1BVX0dFVF9YQ1IgZmFp
bGVkLCBlcnJvciAlZCAoJXMpLCBleHBlY3RlZCAlZFxuIiwKKwkJLXIsIGt2bV9zdHJlcnJvcigt
ciksIGV4cGVjdGVkX2Vycik7CisKKwkqdmFsdWUgPSByID09IDAgPyBycGwudmFsdWUgOiAwOwor
fQorCitzdGF0aWMgdm9pZCB0ZXN0X2NtZF92Y3B1X2dldF94Y3Ioc3RydWN0IGt2bV92bSAqdm0p
Cit7CisJdTggeGNyMCA9IDAsIHhjcjEgPSAxOworCXU2NCB2YWx1ZTsKKworCWNtZF92Y3B1X2dl
dF94Y3Iodm0sIHhjcjAsICZ2YWx1ZSwgMCk7CisJcHJfZGVidWcoIlhDUjAgMHglbHhcbiIsIHZh
bHVlKTsKKwljbWRfdmNwdV9nZXRfeGNyKHZtLCB4Y3IxLCAmdmFsdWUsIC1LVk1fRUlOVkFMKTsK
K30KKwogc3RhdGljIHZvaWQgdGVzdF9pbnRyb3NwZWN0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQog
ewogCXNyYW5kb20odGltZSgwKSk7CkBAIC0xNDMxLDYgKzE0NjMsNyBAQCBzdGF0aWMgdm9pZCB0
ZXN0X2ludHJvc3BlY3Rpb24oc3RydWN0IGt2bV92bSAqdm0pCiAJdGVzdF9jbWRfdmNwdV9jb250
cm9sX2NyKHZtKTsKIAl0ZXN0X2NtZF92Y3B1X2luamVjdF9leGNlcHRpb24odm0pOwogCXRlc3Rf
ZXZlbnRfeHNldGJ2KHZtKTsKKwl0ZXN0X2NtZF92Y3B1X2dldF94Y3Iodm0pOwogCiAJdW5ob29r
X2ludHJvc3BlY3Rpb24odm0pOwogfQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
