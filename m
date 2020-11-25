Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93CC64E75
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CB6206B7
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CB6206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DD838751C;
	Wed, 25 Nov 2020 09:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Z2D9F8akNGG; Wed, 25 Nov 2020 09:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1702087517;
	Wed, 25 Nov 2020 09:52:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C0FC1836;
	Wed, 25 Nov 2020 09:52:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61CE9C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46AEB86DE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7+UrOQxN+mfl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DA0A786DA9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 BDCA0305D4FC; Wed, 25 Nov 2020 11:35:44 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id A39703072785;
 Wed, 25 Nov 2020 11:35:44 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 11/81] KVM: x86: add kvm_x86_ops.desc_ctrl_supported()
Date: Wed, 25 Nov 2020 11:34:50 +0200
Message-Id: <20201125093600.2766-12-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
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
ciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oIHwgMSArCiBhcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jICAgICAgICAgIHwgNiArKysrKysK
IGFyY2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmggfCA3ICsrKysrKy0KIGFyY2gveDg2L2t2
bS92bXgvdm14LmMgICAgICAgICAgfCAxICsKIDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2
bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IGE0MDIzODRh
OTMyNi4uMWU5Y2I1MjEzMjRlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTExMzAsNiAr
MTEzMCw3IEBAIHN0cnVjdCBrdm1feDg2X29wcyB7CiAJdm9pZCAoKnNldF9pZHQpKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CiAJdm9pZCAoKmdldF9nZHQpKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CiAJdm9pZCAoKnNldF9n
ZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CisJYm9vbCAo
KmRlc2NfY3RybF9zdXBwb3J0ZWQpKHZvaWQpOwogCXZvaWQgKCpzeW5jX2RpcnR5X2RlYnVnX3Jl
Z3MpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiAJdm9pZCAoKnNldF9kcjcpKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyB2YWx1ZSk7CiAJdm9pZCAoKmNhY2hlX3JlZykoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBlbnVtIGt2bV9yZWcgcmVnKTsKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS9zdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IDUwMDBlZTI1
NTQ1Yi4uZjNlZTZiYWQwZGI1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisr
KyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKQEAgLTE2MzAsNiArMTYzMCwxMSBAQCBzdGF0aWMg
dm9pZCBzdm1fc2V0X2dkdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBkZXNjX3B0ciAq
ZHQpCiAJdm1jYl9tYXJrX2RpcnR5KHN2bS0+dm1jYiwgVk1DQl9EVCk7CiB9CiAKK3N0YXRpYyBi
b29sIHN2bV9kZXNjX2N0cmxfc3VwcG9ydGVkKHZvaWQpCit7CisJcmV0dXJuIHRydWU7Cit9CisK
IHN0YXRpYyB2b2lkIHVwZGF0ZV9jcjBfaW50ZXJjZXB0KHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQog
ewogCXVsb25nIGdjcjAgPSBzdm0tPnZjcHUuYXJjaC5jcjA7CkBAIC00MjYwLDYgKzQyNjUsNyBA
QCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJ
LnNldF9pZHQgPSBzdm1fc2V0X2lkdCwKIAkuZ2V0X2dkdCA9IHN2bV9nZXRfZ2R0LAogCS5zZXRf
Z2R0ID0gc3ZtX3NldF9nZHQsCisJLmRlc2NfY3RybF9zdXBwb3J0ZWQgPSBzdm1fZGVzY19jdHJs
X3N1cHBvcnRlZCwKIAkuc2V0X2RyNyA9IHN2bV9zZXRfZHI3LAogCS5zeW5jX2RpcnR5X2RlYnVn
X3JlZ3MgPSBzdm1fc3luY19kaXJ0eV9kZWJ1Z19yZWdzLAogCS5jYWNoZV9yZWcgPSBzdm1fY2Fj
aGVfcmVnLApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC9jYXBhYmlsaXRpZXMuaCBiL2Fy
Y2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmgKaW5kZXggM2ExODYxNDAzZDczLi42Njk1YjA2
MWJhZTQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvY2FwYWJpbGl0aWVzLmgKKysrIGIv
YXJjaC94ODYva3ZtL3ZteC9jYXBhYmlsaXRpZXMuaApAQCAtMTQyLDEyICsxNDIsMTcgQEAgc3Rh
dGljIGlubGluZSBib29sIGNwdV9oYXNfdm14X2VwdCh2b2lkKQogCQlTRUNPTkRBUllfRVhFQ19F
TkFCTEVfRVBUOwogfQogCi1zdGF0aWMgaW5saW5lIGJvb2wgdm14X3VtaXBfZW11bGF0ZWQodm9p
ZCkKK3N0YXRpYyBpbmxpbmUgYm9vbCB2bXhfZGVzY19jdHJsX3N1cHBvcnRlZCh2b2lkKQogewog
CXJldHVybiB2bWNzX2NvbmZpZy5jcHVfYmFzZWRfMm5kX2V4ZWNfY3RybCAmCiAJCVNFQ09OREFS
WV9FWEVDX0RFU0M7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCB2bXhfdW1pcF9lbXVsYXRlZCh2
b2lkKQoreworCXJldHVybiB2bXhfZGVzY19jdHJsX3N1cHBvcnRlZCgpOworfQorCiBzdGF0aWMg
aW5saW5lIGJvb2wgY3B1X2hhc192bXhfcmR0c2NwKHZvaWQpCiB7CiAJcmV0dXJuIHZtY3NfY29u
ZmlnLmNwdV9iYXNlZF8ybmRfZXhlY19jdHJsICYKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92
bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IDdiMmE2MGNkN2E3Ni4uYTVl
MWY2MWQyNjIyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gv
eDg2L2t2bS92bXgvdm14LmMKQEAgLTc2NTYsNiArNzY1Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3Zt
X3g4Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuc2V0X2lkdCA9IHZteF9zZXRf
aWR0LAogCS5nZXRfZ2R0ID0gdm14X2dldF9nZHQsCiAJLnNldF9nZHQgPSB2bXhfc2V0X2dkdCwK
KwkuZGVzY19jdHJsX3N1cHBvcnRlZCA9IHZteF9kZXNjX2N0cmxfc3VwcG9ydGVkLAogCS5zZXRf
ZHI3ID0gdm14X3NldF9kcjcsCiAJLnN5bmNfZGlydHlfZGVidWdfcmVncyA9IHZteF9zeW5jX2Rp
cnR5X2RlYnVnX3JlZ3MsCiAJLmNhY2hlX3JlZyA9IHZteF9jYWNoZV9yZWcsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
