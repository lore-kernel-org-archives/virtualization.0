Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C27C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2453C6052B
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2453C6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E470D40885;
	Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LimWwtAgmO5R; Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E938440898;
	Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCB76C0026;
	Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E7DDC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A3996068F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zqqbdxzbVhWQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFCAE60EEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 834E5307CADF; Wed,  6 Oct 2021 20:30:56 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 6A7C23064495;
 Wed,  6 Oct 2021 20:30:56 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 09/77] KVM: x86: add kvm_x86_ops.desc_ctrl_supported()
Date: Wed,  6 Oct 2021 20:30:05 +0300
Message-Id: <20211006173113.26445-10-alazar@bitdefender.com>
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

V2hlbiB0aGUgaW50cm9zcGVjdGlvbiB0b29sIHRyaWVzIHRvIGVuYWJsZSB0aGUgS1ZNSV9WQ1BV
X0VWRU5UX0RFU0NSSVBUT1IKZXZlbnQsIHRoaXMgZnVuY3Rpb24gaXMgdXNlZCB0byBjaGVjayBp
ZiB0aGUgY29udHJvbCBvZiBWTS1leGl0cyBjYXVzZWQKYnkgZGVzY3JpcHRvci10YWJsZSByZWdp
c3RlcnMgYWNjZXNzIGlzIHN1cHBvcnRlZC4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSD
ciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0t
eDg2LW9wcy5oIHwgMSArCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oICAgIHwgMSAr
CiBhcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jICAgICAgICAgICAgIHwgNiArKysrKysKIGFyY2gveDg2
L2t2bS92bXgvY2FwYWJpbGl0aWVzLmggICAgfCA3ICsrKysrKy0KIGFyY2gveDg2L2t2bS92bXgv
dm14LmMgICAgICAgICAgICAgfCAxICsKIDUgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14
ODYtb3BzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oCmluZGV4IDA0YTc3
YTA4NThlZi4uOWE5NjJiZDA5OGQwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
dm0teDg2LW9wcy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgKQEAg
LTEyNCw2ICsxMjQsNyBAQCBLVk1fWDg2X09QX05VTEwoY29tcGxldGVfZW11bGF0ZWRfbXNyKQog
S1ZNX1g4Nl9PUChicF9pbnRlcmNlcHRlZCkKIEtWTV9YODZfT1AoY29udHJvbF9jcjNfaW50ZXJj
ZXB0KQogS1ZNX1g4Nl9PUChjcjNfd3JpdGVfaW50ZXJjZXB0ZWQpCitLVk1fWDg2X09QKGRlc2Nf
Y3RybF9zdXBwb3J0ZWQpCiAKICN1bmRlZiBLVk1fWDg2X09QCiAjdW5kZWYgS1ZNX1g4Nl9PUF9O
VUxMCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCA5YzMxMzMzODAwMjguLjFhY2FhMjdmZmQ4
ZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysgYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xMzQ5LDYgKzEzNDksNyBAQCBzdHJ1Y3Qg
a3ZtX3g4Nl9vcHMgewogCXZvaWQgKCpzZXRfaWR0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0
cnVjdCBkZXNjX3B0ciAqZHQpOwogCXZvaWQgKCpnZXRfZ2R0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHN0cnVjdCBkZXNjX3B0ciAqZHQpOwogCXZvaWQgKCpzZXRfZ2R0KShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIHN0cnVjdCBkZXNjX3B0ciAqZHQpOworCWJvb2wgKCpkZXNjX2N0cmxfc3VwcG9y
dGVkKSh2b2lkKTsKIAl2b2lkICgqc3luY19kaXJ0eV9kZWJ1Z19yZWdzKShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpOwogCXZvaWQgKCpzZXRfZHI3KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2ln
bmVkIGxvbmcgdmFsdWUpOwogCXZvaWQgKCpjYWNoZV9yZWcpKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgZW51bSBrdm1fcmVnIHJlZyk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5j
IGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwppbmRleCA5ZmFjNjljOGUxMzUuLmNlNDVmZTBkMzVi
YyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0v
c3ZtL3N2bS5jCkBAIC0xNzc1LDYgKzE3NzUsMTEgQEAgc3RhdGljIHZvaWQgc3ZtX3NldF9nZHQo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19wdHIgKmR0KQogCXZtY2JfbWFya19k
aXJ0eShzdm0tPnZtY2IsIFZNQ0JfRFQpOwogfQogCitzdGF0aWMgYm9vbCBzdm1fZGVzY19jdHJs
X3N1cHBvcnRlZCh2b2lkKQoreworCXJldHVybiB0cnVlOworfQorCiB2b2lkIHN2bV9zZXRfY3Iw
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyBjcjApCiB7CiAJc3RydWN0IHZj
cHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CkBAIC00NjQ3LDYgKzQ2NTIsNyBAQCBzdGF0aWMg
c3RydWN0IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLnNldF9pZHQg
PSBzdm1fc2V0X2lkdCwKIAkuZ2V0X2dkdCA9IHN2bV9nZXRfZ2R0LAogCS5zZXRfZ2R0ID0gc3Zt
X3NldF9nZHQsCisJLmRlc2NfY3RybF9zdXBwb3J0ZWQgPSBzdm1fZGVzY19jdHJsX3N1cHBvcnRl
ZCwKIAkuc2V0X2RyNyA9IHN2bV9zZXRfZHI3LAogCS5zeW5jX2RpcnR5X2RlYnVnX3JlZ3MgPSBz
dm1fc3luY19kaXJ0eV9kZWJ1Z19yZWdzLAogCS5jYWNoZV9yZWcgPSBzdm1fY2FjaGVfcmVnLApk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC9jYXBhYmlsaXRpZXMuaCBiL2FyY2gveDg2L2t2
bS92bXgvY2FwYWJpbGl0aWVzLmgKaW5kZXggNDcwNWFkNTVhYmI1Li45YTI1YWEwZGQ5YzggMTAw
NjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmgKKysrIGIvYXJjaC94ODYv
a3ZtL3ZteC9jYXBhYmlsaXRpZXMuaApAQCAtMTQzLDEyICsxNDMsMTcgQEAgc3RhdGljIGlubGlu
ZSBib29sIGNwdV9oYXNfdm14X2VwdCh2b2lkKQogCQlTRUNPTkRBUllfRVhFQ19FTkFCTEVfRVBU
OwogfQogCi1zdGF0aWMgaW5saW5lIGJvb2wgdm14X3VtaXBfZW11bGF0ZWQodm9pZCkKK3N0YXRp
YyBpbmxpbmUgYm9vbCB2bXhfZGVzY19jdHJsX3N1cHBvcnRlZCh2b2lkKQogewogCXJldHVybiB2
bWNzX2NvbmZpZy5jcHVfYmFzZWRfMm5kX2V4ZWNfY3RybCAmCiAJCVNFQ09OREFSWV9FWEVDX0RF
U0M7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCB2bXhfdW1pcF9lbXVsYXRlZCh2b2lkKQorewor
CXJldHVybiB2bXhfZGVzY19jdHJsX3N1cHBvcnRlZCgpOworfQorCiBzdGF0aWMgaW5saW5lIGJv
b2wgY3B1X2hhc192bXhfcmR0c2NwKHZvaWQpCiB7CiAJcmV0dXJuIHZtY3NfY29uZmlnLmNwdV9i
YXNlZF8ybmRfZXhlY19jdHJsICYKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMg
Yi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IDNmNTczMTIxM2FjZi4uMDI2ZDY3OGI4MmI5
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92
bXgvdm14LmMKQEAgLTc2MzUsNiArNzYzNSw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMg
dm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuc2V0X2lkdCA9IHZteF9zZXRfaWR0LAogCS5n
ZXRfZ2R0ID0gdm14X2dldF9nZHQsCiAJLnNldF9nZHQgPSB2bXhfc2V0X2dkdCwKKwkuZGVzY19j
dHJsX3N1cHBvcnRlZCA9IHZteF9kZXNjX2N0cmxfc3VwcG9ydGVkLAogCS5zZXRfZHI3ID0gdm14
X3NldF9kcjcsCiAJLnN5bmNfZGlydHlfZGVidWdfcmVncyA9IHZteF9zeW5jX2RpcnR5X2RlYnVn
X3JlZ3MsCiAJLmNhY2hlX3JlZyA9IHZteF9jYWNoZV9yZWcsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
