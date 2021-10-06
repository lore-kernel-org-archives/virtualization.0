Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87687C43219
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573C2610FC
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 573C2610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1969440D90;
	Wed,  6 Oct 2021 17:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZhbmQHdq17w; Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C552407D0;
	Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C64FC0036;
	Wed,  6 Oct 2021 17:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C0FC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EBE72408D9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RMpzCgmrnbjR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B752405CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 06D0130828B1; Wed,  6 Oct 2021 20:31:22 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id E23E73064495;
 Wed,  6 Oct 2021 20:31:21 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 67/77] KVM: introspection: restore the state of
 descriptor-table register interception on unhook
Date: Wed,  6 Oct 2021 20:31:03 +0300
Message-Id: <20211006173113.26445-68-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgY29tbWl0
IGFsc28gZW5zdXJlcyB0aGF0IHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgYW5kIHRoZSB1c2Vyc3Bh
Y2UKZG8gbm90IGRpc2FibGUgZWFjaCBvdGhlciB0aGUgZGVzY3JpcHRvci10YWJsZSBhY2Nlc3Mg
Vk0tZXhpdC4KClNpZ25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91
ZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVy
LmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1pX2hvc3QuaCB8ICA0ICsrKwogYXJj
aC94ODYva3ZtL2t2bWkuYyAgICAgICAgICAgICAgfCA0NSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICAgfCAgMyArKysKIGFy
Y2gveDg2L2t2bS92bXgvdm14LmMgICAgICAgICAgIHwgIDMgKysrCiA0IGZpbGVzIGNoYW5nZWQs
IDU1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1p
X2hvc3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oCmluZGV4IGEyNGJhODcw
MzZmNy4uYTg3MjI3N2ViYTY3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1p
X2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1pX2hvc3QuaApAQCAtMTcsNiAr
MTcsNyBAQCBzdHJ1Y3Qga3ZtaV9pbnRlcmNlcHRpb24gewogCWJvb2wgcmVzdG9yZV9pbnRlcmNl
cHRpb247CiAJc3RydWN0IGt2bWlfbW9uaXRvcl9pbnRlcmNlcHRpb24gYnJlYWtwb2ludDsKIAlz
dHJ1Y3Qga3ZtaV9tb25pdG9yX2ludGVyY2VwdGlvbiBjcjN3OworCXN0cnVjdCBrdm1pX21vbml0
b3JfaW50ZXJjZXB0aW9uIGRlc2NyaXB0b3I7CiB9OwogCiBzdHJ1Y3Qga3ZtX3ZjcHVfYXJjaF9p
bnRyb3NwZWN0aW9uIHsKQEAgLTQ4LDYgKzQ5LDcgQEAgYm9vbCBrdm1pX21vbml0b3JfY3Izd19p
bnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSk7CiB2b2lkIGt2bWlf
ZW50ZXJfZ3Vlc3Qoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIHZvaWQga3ZtaV94c2V0YnZfZXZl
bnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1OCB4Y3IsCiAJCSAgICAgICB1NjQgb2xkX3ZhbHVl
LCB1NjQgbmV3X3ZhbHVlKTsKK2Jvb2wga3ZtaV9tb25pdG9yX2Rlc2NfaW50ZXJjZXB0KHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBlbmFibGUpOwogYm9vbCBrdm1pX2Rlc2NyaXB0b3JfZXZl
bnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1OCBkZXNjcmlwdG9yLCBib29sIHdyaXRlKTsKIAog
I2Vsc2UgLyogQ09ORklHX0tWTV9JTlRST1NQRUNUSU9OICovCkBAIC02NCw2ICs2Niw4IEBAIHN0
YXRpYyBpbmxpbmUgYm9vbCBrdm1pX21vbml0b3JfY3Izd19pbnRlcmNlcHQoc3RydWN0IGt2bV92
Y3B1ICp2Y3B1LAogc3RhdGljIGlubGluZSB2b2lkIGt2bWlfZW50ZXJfZ3Vlc3Qoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1KSB7IH0KIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1pX3hzZXRidl9ldmVudChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU4IHhjciwKIAkJCQkJdTY0IG9sZF92YWx1ZSwgdTY0IG5l
d192YWx1ZSkgeyB9CitzdGF0aWMgaW5saW5lIGJvb2wga3ZtaV9tb25pdG9yX2Rlc2NfaW50ZXJj
ZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKKwkJCQkJICAgICAgIGJvb2wgZW5hYmxlKSB7IHJl
dHVybiBmYWxzZTsgfQogc3RhdGljIGlubGluZSBib29sIGt2bWlfZGVzY3JpcHRvcl9ldmVudChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU4IGRlc2NyaXB0b3IsCiAJCQkJCSBib29sIHdyaXRlKSB7
IHJldHVybiB0cnVlOyB9CiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9rdm1pLmMgYi9hcmNo
L3g4Ni9rdm0va3ZtaS5jCmluZGV4IGNmNzE2NzM2NjIxNC4uYzBjMzhlNjQ3OGNiIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rdm0va3ZtaS5jCisrKyBiL2FyY2gveDg2L2t2bS9rdm1pLmMKQEAgLTI4
NiwxMiArMjg2LDUyIEBAIHN0YXRpYyB2b2lkIGt2bWlfYXJjaF9kaXNhYmxlX2NyM3dfaW50ZXJj
ZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAl2Y3B1LT5hcmNoLmt2bWktPmNyM3cua3ZtX2lu
dGVyY2VwdGVkID0gZmFsc2U7CiB9CiAKKy8qCisgKiBSZXR1cm5zIHRydWUgaWYgb25lIHNpZGUg
KGt2bSBvciBrdm1pKSB0cmllcyB0byBkaXNhYmxlIHRoZSBkZXNjcmlwdG9yCisgKiBpbnRlcmNl
cHRpb24gd2hpbGUgdGhlIG90aGVyIHNpZGUgaXMgc3RpbGwgdHJhY2tpbmcgaXQuCisgKi8KK2Jv
b2wga3ZtaV9tb25pdG9yX2Rlc2NfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9v
bCBlbmFibGUpCit7CisJc3RydWN0IGt2bWlfaW50ZXJjZXB0aW9uICphcmNoX3ZjcHVpID0gUkVB
RF9PTkNFKHZjcHUtPmFyY2gua3ZtaSk7CisKKwlyZXR1cm4gKGFyY2hfdmNwdWkgJiYgYXJjaF92
Y3B1aS0+ZGVzY3JpcHRvci5tb25pdG9yX2ZjdCh2Y3B1LCBlbmFibGUpKTsKK30KK0VYUE9SVF9T
WU1CT0woa3ZtaV9tb25pdG9yX2Rlc2NfaW50ZXJjZXB0KTsKKworc3RhdGljIGJvb2wgbW9uaXRv
cl9kZXNjX2ZjdF9rdm1pKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBlbmFibGUpCit7CisJ
dmNwdS0+YXJjaC5rdm1pLT5kZXNjcmlwdG9yLmt2bWlfaW50ZXJjZXB0ZWQgPSBlbmFibGU7CisK
KwlpZiAoZW5hYmxlKQorCQl2Y3B1LT5hcmNoLmt2bWktPmRlc2NyaXB0b3Iua3ZtX2ludGVyY2Vw
dGVkID0KKwkJCXN0YXRpY19jYWxsKGt2bV94ODZfZGVzY19pbnRlcmNlcHRlZCkodmNwdSk7CisJ
ZWxzZSBpZiAodmNwdS0+YXJjaC5rdm1pLT5kZXNjcmlwdG9yLmt2bV9pbnRlcmNlcHRlZCkKKwkJ
cmV0dXJuIHRydWU7CisKKwlyZXR1cm4gZmFsc2U7Cit9CisKK3N0YXRpYyBib29sIG1vbml0b3Jf
ZGVzY19mY3Rfa3ZtKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBlbmFibGUpCit7CisJaWYg
KCF2Y3B1LT5hcmNoLmt2bWktPmRlc2NyaXB0b3Iua3ZtaV9pbnRlcmNlcHRlZCkKKwkJcmV0dXJu
IGZhbHNlOworCisJdmNwdS0+YXJjaC5rdm1pLT5kZXNjcmlwdG9yLmt2bV9pbnRlcmNlcHRlZCA9
IGVuYWJsZTsKKworCWlmICghZW5hYmxlKQorCQlyZXR1cm4gdHJ1ZTsKKworCXJldHVybiBmYWxz
ZTsKK30KKwogc3RhdGljIGludCBrdm1pX2NvbnRyb2xfZGVzY19pbnRlcmNlcHQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSkKIHsKIAlpZiAoIXN0YXRpY19jYWxsKGt2bV94ODZf
ZGVzY19jdHJsX3N1cHBvcnRlZCkoKSkKIAkJcmV0dXJuIC1LVk1fRU9QTk9UU1VQUDsKIAorCXZj
cHUtPmFyY2gua3ZtaS0+ZGVzY3JpcHRvci5tb25pdG9yX2ZjdCA9IG1vbml0b3JfZGVzY19mY3Rf
a3ZtaTsKIAlzdGF0aWNfY2FsbChrdm1feDg2X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQpKHZjcHUs
IGVuYWJsZSk7CisJdmNwdS0+YXJjaC5rdm1pLT5kZXNjcmlwdG9yLm1vbml0b3JfZmN0ID0gbW9u
aXRvcl9kZXNjX2ZjdF9rdm07CiAKIAlyZXR1cm4gMDsKIH0KQEAgLTI5OSw2ICszMzksOSBAQCBz
dGF0aWMgaW50IGt2bWlfY29udHJvbF9kZXNjX2ludGVyY2VwdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIGJvb2wgZW5hYmxlKQogc3RhdGljIHZvaWQga3ZtaV9hcmNoX2Rpc2FibGVfZGVzY19pbnRl
cmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogewogCWt2bWlfY29udHJvbF9kZXNjX2ludGVy
Y2VwdCh2Y3B1LCBmYWxzZSk7CisKKwl2Y3B1LT5hcmNoLmt2bWktPmRlc2NyaXB0b3Iua3ZtaV9p
bnRlcmNlcHRlZCA9IGZhbHNlOworCXZjcHUtPmFyY2gua3ZtaS0+ZGVzY3JpcHRvci5rdm1faW50
ZXJjZXB0ZWQgPSBmYWxzZTsKIH0KIAogaW50IGt2bWlfYXJjaF9jbWRfY29udHJvbF9pbnRlcmNl
cHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LApAQCAtMzcwLDExICs0MTMsMTMgQEAgYm9vbCBrdm1p
X2FyY2hfdmNwdV9hbGxvY19pbnRlcmNlcHRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogCiAJ
YXJjaF92Y3B1aS0+YnJlYWtwb2ludC5tb25pdG9yX2ZjdCA9IG1vbml0b3JfYnBfZmN0X2t2bTsK
IAlhcmNoX3ZjcHVpLT5jcjN3Lm1vbml0b3JfZmN0ID0gbW9uaXRvcl9jcjN3X2ZjdF9rdm07CisJ
YXJjaF92Y3B1aS0+ZGVzY3JpcHRvci5tb25pdG9yX2ZjdCA9IG1vbml0b3JfZGVzY19mY3Rfa3Zt
OwogCiAJLyoKIAkgKiBwYWlyZWQgd2l0aDoKIAkgKiAgLSBrdm1pX21vbml0b3JfYnBfaW50ZXJj
ZXB0KCkKIAkgKiAgLSBrdm1pX21vbml0b3JfY3Izd19pbnRlcmNlcHQoKQorCSAqICAtIGt2bWlf
bW9uaXRvcl9kZXNjX2ludGVyY2VwdCgpCiAJICovCiAJc21wX3dtYigpOwogCVdSSVRFX09OQ0Uo
dmNwdS0+YXJjaC5rdm1pLCBhcmNoX3ZjcHVpKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9z
dm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IDk4YjQ5MDkyNTRhMC4uZDNk
MDYxNjE1NTM2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gv
eDg2L2t2bS9zdm0vc3ZtLmMKQEAgLTE4MjAsNiArMTgyMCw5IEBAIHN0YXRpYyB2b2lkIHN2bV9j
b250cm9sX2Rlc2NfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCBlbmFibGUp
CiB7CiAJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CiAKKwlpZiAoa3ZtaV9t
b25pdG9yX2Rlc2NfaW50ZXJjZXB0KHZjcHUsIGVuYWJsZSkpCisJCXJldHVybjsKKwogCWlmIChl
bmFibGUpIHsKIAkJc3ZtX3NldF9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfSURUUik7
CiAJCXN2bV9zZXRfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX1NUT1JFX0dEVFIpOwpkaWZmIC0t
Z2l0IGEvYXJjaC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKaW5k
ZXggNThhNzUzYjFiYTQxLi45NjQ4NDA0MzA1MzcgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92
bXgvdm14LmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwpAQCAtMzE3MCw2ICszMTcwLDkg
QEAgc3RhdGljIHZvaWQgdm14X2NvbnRyb2xfZGVzY19pbnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBib29sIGVuYWJsZSkKIHsKIAlzdHJ1Y3QgdmNwdV92bXggKnZteCA9IHRvX3ZteCh2
Y3B1KTsKIAorCWlmIChrdm1pX21vbml0b3JfZGVzY19pbnRlcmNlcHQodmNwdSwgZW5hYmxlKSkK
KwkJcmV0dXJuOworCiAJaWYgKGVuYWJsZSkKIAkJc2Vjb25kYXJ5X2V4ZWNfY29udHJvbHNfc2V0
Yml0KHZteCwgU0VDT05EQVJZX0VYRUNfREVTQyk7CiAJZWxzZQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
