Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F4C43217
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FD2610E6
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7FD2610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1182E409AE;
	Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yTSdED1BjxSP; Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8238B40927;
	Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D2D6C0027;
	Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E006CC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC83D40886
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pup2AmuLSzFi
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA55F407DF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 CE2F4307CAE1; Wed,  6 Oct 2021 20:30:57 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id B454A3064495;
 Wed,  6 Oct 2021 20:30:57 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 12/77] KVM: x86: add kvm_x86_ops.desc_intercepted()
Date: Wed,  6 Oct 2021 20:30:08 +0300
Message-Id: <20211006173113.26445-13-alazar@bitdefender.com>
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
b24gd2lsbCBiZSB1c2VkIHRvIHRlc3QgaWYgdGhlIGRlc2NyaXB0b3ItdGFibGUgcmVnaXN0ZXJz
CmFjY2VzcyBpcyBhbHJlYWR5IHRyYWNrZWQgYnkgdXNlcnNwYWNlLgoKU2lnbmVkLW9mZi1ieTog
TmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRh
bGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2luY2x1
ZGUvYXNtL2t2bS14ODYtb3BzLmggfCAgMSArCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9z
dC5oICAgIHwgIDEgKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICAgICB8IDE1ICsr
KysrKysrKysrKysrKwogYXJjaC94ODYva3ZtL3ZteC92bXguYyAgICAgICAgICAgICB8ICA4ICsr
KysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
a3ZtLXg4Ni1vcHMuaAppbmRleCBkZDA4ZjMxMjBmOGYuLjMwZDAxYzllZDMxYiAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9rdm0teDg2LW9wcy5oCkBAIC0xMjYsNiArMTI2LDcgQEAgS1ZNX1g4Nl9PUChjb250
cm9sX2NyM19pbnRlcmNlcHQpCiBLVk1fWDg2X09QKGNyM193cml0ZV9pbnRlcmNlcHRlZCkKIEtW
TV9YODZfT1AoZGVzY19jdHJsX3N1cHBvcnRlZCkKIEtWTV9YODZfT1AoY29udHJvbF9kZXNjX2lu
dGVyY2VwdCkKK0tWTV9YODZfT1AoZGVzY19pbnRlcmNlcHRlZCkKIAogI3VuZGVmIEtWTV9YODZf
T1AKICN1bmRlZiBLVk1fWDg2X09QX05VTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IDJl
NWRkYjE4ODA0Yi4uMTE4MmIwZmJkMjQ1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTEz
NTEsNiArMTM1MSw3IEBAIHN0cnVjdCBrdm1feDg2X29wcyB7CiAJdm9pZCAoKnNldF9nZHQpKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRyICpkdCk7CiAJYm9vbCAoKmRlc2Nf
Y3RybF9zdXBwb3J0ZWQpKHZvaWQpOwogCXZvaWQgKCpjb250cm9sX2Rlc2NfaW50ZXJjZXB0KShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgZW5hYmxlKTsKKwlib29sICgqZGVzY19pbnRlcmNl
cHRlZCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAl2b2lkICgqc3luY19kaXJ0eV9kZWJ1Z19y
ZWdzKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCXZvaWQgKCpzZXRfZHI3KShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgdmFsdWUpOwogCXZvaWQgKCpjYWNoZV9yZWcpKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgZW51bSBrdm1fcmVnIHJlZyk7CmRpZmYgLS1naXQgYS9hcmNo
L3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwppbmRleCAwZDQ2ZjVh
YTIwYzMuLmMxYjFlNWNkZDUwOCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwor
KysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0xODA1LDYgKzE4MDUsMjAgQEAgc3RhdGlj
IHZvaWQgc3ZtX2NvbnRyb2xfZGVzY19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBi
b29sIGVuYWJsZSkKIAl9CiB9CiAKK3N0YXRpYyBib29sIHN2bV9kZXNjX2ludGVyY2VwdGVkKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSkKK3sKKwlzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRvX3N2bSh2
Y3B1KTsKKworCXJldHVybiAoc3ZtX2lzX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9J
RFRSKSB8fAorCQlzdm1faXNfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX1NUT1JFX0dEVFIpIHx8
CisJCXN2bV9pc19pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfTERUUikgfHwKKwkJc3Zt
X2lzX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9TVE9SRV9UUikgfHwKKwkJc3ZtX2lzX2ludGVy
Y2VwdChzdm0sIElOVEVSQ0VQVF9MT0FEX0lEVFIpIHx8CisJCXN2bV9pc19pbnRlcmNlcHQoc3Zt
LCBJTlRFUkNFUFRfTE9BRF9HRFRSKSB8fAorCQlzdm1faXNfaW50ZXJjZXB0KHN2bSwgSU5URVJD
RVBUX0xPQURfTERUUikgfHwKKwkJc3ZtX2lzX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9MT0FE
X1RSKSk7Cit9CisKIHZvaWQgc3ZtX3NldF9jcjAoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNp
Z25lZCBsb25nIGNyMCkKIHsKIAlzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsK
QEAgLTQ2OTIsNiArNDcwNiw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgc3ZtX3g4Nl9v
cHMgX19pbml0ZGF0YSA9IHsKIAkuc2V0X2dkdCA9IHN2bV9zZXRfZ2R0LAogCS5kZXNjX2N0cmxf
c3VwcG9ydGVkID0gc3ZtX2Rlc2NfY3RybF9zdXBwb3J0ZWQsCiAJLmNvbnRyb2xfZGVzY19pbnRl
cmNlcHQgPSBzdm1fY29udHJvbF9kZXNjX2ludGVyY2VwdCwKKwkuZGVzY19pbnRlcmNlcHRlZCA9
IHN2bV9kZXNjX2ludGVyY2VwdGVkLAogCS5zZXRfZHI3ID0gc3ZtX3NldF9kcjcsCiAJLnN5bmNf
ZGlydHlfZGVidWdfcmVncyA9IHN2bV9zeW5jX2RpcnR5X2RlYnVnX3JlZ3MsCiAJLmNhY2hlX3Jl
ZyA9IHN2bV9jYWNoZV9yZWcsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jIGIv
YXJjaC94ODYva3ZtL3ZteC92bXguYwppbmRleCBkMGYwMmQ1MmI0MDEuLjhmMzRiMTk4MjdhMyAx
MDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYworKysgYi9hcmNoL3g4Ni9rdm0vdm14
L3ZteC5jCkBAIC0zNDA1LDYgKzM0MDUsMTMgQEAgc3RhdGljIHZvaWQgdm14X3NldF9nZHQoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19wdHIgKmR0KQogCXZtY3Nfd3JpdGVsKEdV
RVNUX0dEVFJfQkFTRSwgZHQtPmFkZHJlc3MpOwogfQogCitzdGF0aWMgYm9vbCB2bXhfZGVzY19p
bnRlcmNlcHRlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IHZjcHVfdm14ICp2
bXggPSB0b192bXgodmNwdSk7CisKKwlyZXR1cm4gISEoc2Vjb25kYXJ5X2V4ZWNfY29udHJvbHNf
Z2V0KHZteCkgJiBTRUNPTkRBUllfRVhFQ19ERVNDKTsKK30KKwogc3RhdGljIGJvb2wgcm1vZGVf
c2VnbWVudF92YWxpZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBzZWcpCiB7CiAJc3RydWN0
IGt2bV9zZWdtZW50IHZhcjsKQEAgLTc2NDcsNiArNzY1NCw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3Zt
X3g4Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuc2V0X2dkdCA9IHZteF9zZXRf
Z2R0LAogCS5kZXNjX2N0cmxfc3VwcG9ydGVkID0gdm14X2Rlc2NfY3RybF9zdXBwb3J0ZWQsCiAJ
LmNvbnRyb2xfZGVzY19pbnRlcmNlcHQgPSB2bXhfY29udHJvbF9kZXNjX2ludGVyY2VwdCwKKwku
ZGVzY19pbnRlcmNlcHRlZCA9IHZteF9kZXNjX2ludGVyY2VwdGVkLAogCS5zZXRfZHI3ID0gdm14
X3NldF9kcjcsCiAJLnN5bmNfZGlydHlfZGVidWdfcmVncyA9IHZteF9zeW5jX2RpcnR5X2RlYnVn
X3JlZ3MsCiAJLmNhY2hlX3JlZyA9IHZteF9jYWNoZV9yZWcsCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
