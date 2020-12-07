Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4776CC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0082389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0082389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B984F87A2F;
	Mon,  7 Dec 2020 20:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8Tp8TyLigGn; Mon,  7 Dec 2020 20:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A76B87A7E;
	Mon,  7 Dec 2020 20:46:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8FFC0FA7;
	Mon,  7 Dec 2020 20:46:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5918C1834
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BAE67869F7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z_L0b80MnbES
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C9D1286EDF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 50FAD305D501; Mon,  7 Dec 2020 22:46:13 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 3112D3072785;
 Mon,  7 Dec 2020 22:46:13 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 09/81] KVM: x86: add kvm_x86_ops.control_cr3_intercept()
Date: Mon,  7 Dec 2020 22:45:10 +0200
Message-Id: <20201207204622.15258-10-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
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

VGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBLVk1JX1ZDUFVfQ09OVFJPTF9DUiBjb21t
YW5kLCB3aGVuIHRoZQppbnRyb3NwZWN0aW9uIHRvb2wgaGFzIHRvIGludGVyY2VwdCB0aGUgcmVh
ZC93cml0ZSBhY2Nlc3MgdG8gQ1IzLgoKQ28tZGV2ZWxvcGVkLWJ5OiBOaWN1yJlvciBDw67Im3Ug
PG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5p
Y3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXph
ckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8
ICA2ICsrKysrKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICB8IDE0ICsrKysrKysr
KysrKysrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAgICAgIHwgMjYgKysrKysrKysrKysr
KysrKysrKystLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCBlNDZmZWU1OWQ0ZWQuLjBlZWIx
ZDgyOWExZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xMzcsNiArMTM3LDEwIEBAIHN0
YXRpYyBpbmxpbmUgZ2ZuX3QgZ2ZuX3RvX2luZGV4KGdmbl90IGdmbiwgZ2ZuX3QgYmFzZV9nZm4s
IGludCBsZXZlbCkKICNkZWZpbmUgS1ZNX05SX0ZJWEVEX01UUlJfUkVHSU9OIDg4CiAjZGVmaW5l
IEtWTV9OUl9WQVJfTVRSUiA4CiAKKyNkZWZpbmUgQ1JfVFlQRV9SCTEKKyNkZWZpbmUgQ1JfVFlQ
RV9XCTIKKyNkZWZpbmUgQ1JfVFlQRV9SVwkzCisKICNkZWZpbmUgQVNZTkNfUEZfUEVSX1ZDUFUg
NjQKIAogZW51bSBrdm1fcmVnIHsKQEAgLTExMTgsNiArMTEyMiw4IEBAIHN0cnVjdCBrdm1feDg2
X29wcyB7CiAJdm9pZCAoKnNldF9jcjApKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQg
bG9uZyBjcjApOwogCWJvb2wgKCppc192YWxpZF9jcjQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
dW5zaWduZWQgbG9uZyBjcjApOwogCXZvaWQgKCpzZXRfY3I0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHVuc2lnbmVkIGxvbmcgY3I0KTsKKwl2b2lkICgqY29udHJvbF9jcjNfaW50ZXJjZXB0KShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCB0eXBlLAorCQkJCSAgICAgIGJvb2wgZW5hYmxlKTsK
IAlpbnQgKCpzZXRfZWZlcikoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZWZlcik7CiAJdm9p
ZCAoKmdldF9pZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7
CiAJdm9pZCAoKnNldF9pZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRy
ICpkdCk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3Zt
L3N2bS9zdm0uYwppbmRleCA5NWM3MDcyY2RlOGUuLjRmMjhmYTAzNTA0OCAxMDA2NDQKLS0tIGEv
YXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0x
NzA3LDYgKzE3MDcsMTkgQEAgdm9pZCBzdm1fc2V0X2NyNChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHVuc2lnbmVkIGxvbmcgY3I0KQogCQlrdm1fdXBkYXRlX2NwdWlkX3J1bnRpbWUodmNwdSk7CiB9
CiAKK3N0YXRpYyB2b2lkIHN2bV9jb250cm9sX2NyM19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBpbnQgdHlwZSwKKwkJCQkgICAgICBib29sIGVuYWJsZSkKK3sKKwlzdHJ1Y3QgdmNw
dV9zdm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKworCWlmICh0eXBlICYgQ1JfVFlQRV9SKQorCQll
bmFibGUgPyBzdm1fc2V0X2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9DUjNfUkVBRCkgOgorCQkJ
IHN2bV9jbHJfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0NSM19SRUFEKTsKKwlpZiAodHlwZSAm
IENSX1RZUEVfVykKKwkJZW5hYmxlID8gc3ZtX3NldF9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRf
Q1IzX1dSSVRFKSA6CisJCQkgc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfQ1IzX1dS
SVRFKTsKK30KKwogc3RhdGljIHZvaWQgc3ZtX3NldF9zZWdtZW50KHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwKIAkJCSAgICBzdHJ1Y3Qga3ZtX3NlZ21lbnQgKnZhciwgaW50IHNlZykKIHsKQEAgLTQy
MzMsNiArNDI0Niw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgc3ZtX3g4Nl9vcHMgX19p
bml0ZGF0YSA9IHsKIAkuc2V0X2NyMCA9IHN2bV9zZXRfY3IwLAogCS5pc192YWxpZF9jcjQgPSBz
dm1faXNfdmFsaWRfY3I0LAogCS5zZXRfY3I0ID0gc3ZtX3NldF9jcjQsCisJLmNvbnRyb2xfY3Iz
X2ludGVyY2VwdCA9IHN2bV9jb250cm9sX2NyM19pbnRlcmNlcHQsCiAJLnNldF9lZmVyID0gc3Zt
X3NldF9lZmVyLAogCS5nZXRfaWR0ID0gc3ZtX2dldF9pZHQsCiAJLnNldF9pZHQgPSBzdm1fc2V0
X2lkdCwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jCmluZGV4IDkzYTk3YWEzZDg0Ny4uYzVhNTM2NDJkMWMwIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTI5
NzgsMjQgKzI5NzgsMzcgQEAgdm9pZCBlcHRfc2F2ZV9wZHB0cnMoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1KQogCWt2bV9yZWdpc3Rlcl9tYXJrX2RpcnR5KHZjcHUsIFZDUFVfRVhSRUdfUERQVFIpOwog
fQogCitzdGF0aWMgdm9pZCB2bXhfY29udHJvbF9jcjNfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgaW50IHR5cGUsCisJCQkJICAgICAgYm9vbCBlbmFibGUpCit7CisJc3RydWN0IHZj
cHVfdm14ICp2bXggPSB0b192bXgodmNwdSk7CisJdTMyIGNyM19leGVjX2NvbnRyb2wgPSAwOwor
CisJaWYgKHR5cGUgJiBDUl9UWVBFX1IpCisJCWNyM19leGVjX2NvbnRyb2wgfD0gQ1BVX0JBU0VE
X0NSM19TVE9SRV9FWElUSU5HOworCWlmICh0eXBlICYgQ1JfVFlQRV9XKQorCQljcjNfZXhlY19j
b250cm9sIHw9IENQVV9CQVNFRF9DUjNfTE9BRF9FWElUSU5HOworCisJaWYgKGVuYWJsZSkKKwkJ
ZXhlY19jb250cm9sc19zZXRiaXQodm14LCBjcjNfZXhlY19jb250cm9sKTsKKwllbHNlCisJCWV4
ZWNfY29udHJvbHNfY2xlYXJiaXQodm14LCBjcjNfZXhlY19jb250cm9sKTsKK30KKwogc3RhdGlj
IHZvaWQgZXB0X3VwZGF0ZV9wYWdpbmdfbW9kZV9jcjAodW5zaWduZWQgbG9uZyAqaHdfY3IwLAog
CQkJCQl1bnNpZ25lZCBsb25nIGNyMCwKIAkJCQkJc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogewot
CXN0cnVjdCB2Y3B1X3ZteCAqdm14ID0gdG9fdm14KHZjcHUpOwotCiAJaWYgKCFrdm1fcmVnaXN0
ZXJfaXNfYXZhaWxhYmxlKHZjcHUsIFZDUFVfRVhSRUdfQ1IzKSkKIAkJdm14X2NhY2hlX3JlZyh2
Y3B1LCBWQ1BVX0VYUkVHX0NSMyk7CiAJaWYgKCEoY3IwICYgWDg2X0NSMF9QRykpIHsKIAkJLyog
RnJvbSBwYWdpbmcvc3RhcnRpbmcgdG8gbm9ucGFnaW5nICovCi0JCWV4ZWNfY29udHJvbHNfc2V0
Yml0KHZteCwgQ1BVX0JBU0VEX0NSM19MT0FEX0VYSVRJTkcgfAotCQkJCQkgIENQVV9CQVNFRF9D
UjNfU1RPUkVfRVhJVElORyk7CisJCXZteF9jb250cm9sX2NyM19pbnRlcmNlcHQodmNwdSwgQ1Jf
VFlQRV9SVywgdHJ1ZSk7CiAJCXZjcHUtPmFyY2guY3IwID0gY3IwOwogCQl2bXhfc2V0X2NyNCh2
Y3B1LCBrdm1fcmVhZF9jcjQodmNwdSkpOwogCX0gZWxzZSBpZiAoIWlzX3BhZ2luZyh2Y3B1KSkg
ewogCQkvKiBGcm9tIG5vbnBhZ2luZyB0byBwYWdpbmcgKi8KLQkJZXhlY19jb250cm9sc19jbGVh
cmJpdCh2bXgsIENQVV9CQVNFRF9DUjNfTE9BRF9FWElUSU5HIHwKLQkJCQkJICAgIENQVV9CQVNF
RF9DUjNfU1RPUkVfRVhJVElORyk7CisJCXZteF9jb250cm9sX2NyM19pbnRlcmNlcHQodmNwdSwg
Q1JfVFlQRV9SVywgZmFsc2UpOwogCQl2Y3B1LT5hcmNoLmNyMCA9IGNyMDsKIAkJdm14X3NldF9j
cjQodmNwdSwga3ZtX3JlYWRfY3I0KHZjcHUpKTsKIAl9CkBAIC03NjI5LDYgKzc2NDIsNyBAQCBz
dGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHZteF94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLnNl
dF9jcjAgPSB2bXhfc2V0X2NyMCwKIAkuaXNfdmFsaWRfY3I0ID0gdm14X2lzX3ZhbGlkX2NyNCwK
IAkuc2V0X2NyNCA9IHZteF9zZXRfY3I0LAorCS5jb250cm9sX2NyM19pbnRlcmNlcHQgPSB2bXhf
Y29udHJvbF9jcjNfaW50ZXJjZXB0LAogCS5zZXRfZWZlciA9IHZteF9zZXRfZWZlciwKIAkuZ2V0
X2lkdCA9IHZteF9nZXRfaWR0LAogCS5zZXRfaWR0ID0gdm14X3NldF9pZHQsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
