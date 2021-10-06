Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277EC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0458611AE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0458611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C654407EB;
	Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4N_EnU86mOr5; Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A6780407DF;
	Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 766AEC0011;
	Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48EFFC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29D004068E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n09KhwhUyiab
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B24D40544
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 17C14307CADE; Wed,  6 Oct 2021 20:30:56 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id F31153064495;
 Wed,  6 Oct 2021 20:30:55 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 08/77] KVM: x86: add kvm_x86_ops.cr3_write_intercepted()
Date: Wed,  6 Oct 2021 20:30:04 +0300
Message-Id: <20211006173113.26445-9-alazar@bitdefender.com>
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
b24gd2lsbCBiZSB1c2VkIHRvIGFsbG93IHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgdG8gZGlzYWJs
ZSB0aGUKQ1IzLXdyaXRlIGludGVyY2VwdGlvbiB3aGVuIGl0IGlzIG5vIGxvbmdlciBpbnRlcmVz
dGVkIGluIHRoZXNlIGV2ZW50cywKYnV0IG9ubHkgaWYgbm90aGluZyBlbHNlIGRlcGVuZHMgb24g
dGhlc2UgVk0tZXhpdHMuCgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0
dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRk
ZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCB8IDEg
KwogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICB8IDEgKwogYXJjaC94ODYva3Zt
L3N2bS9zdm0uYyAgICAgICAgICAgICB8IDggKysrKysrKysKIGFyY2gveDg2L2t2bS92bXgvdm14
LmMgICAgICAgICAgICAgfCA4ICsrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaAppbmRleCBlMWY2M2QzNmVmYjcuLjA0
YTc3YTA4NThlZiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMu
aAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oCkBAIC0xMjMsNiArMTIz
LDcgQEAgS1ZNX1g4Nl9PUChtc3JfZmlsdGVyX2NoYW5nZWQpCiBLVk1fWDg2X09QX05VTEwoY29t
cGxldGVfZW11bGF0ZWRfbXNyKQogS1ZNX1g4Nl9PUChicF9pbnRlcmNlcHRlZCkKIEtWTV9YODZf
T1AoY29udHJvbF9jcjNfaW50ZXJjZXB0KQorS1ZNX1g4Nl9PUChjcjNfd3JpdGVfaW50ZXJjZXB0
ZWQpCiAKICN1bmRlZiBLVk1fWDg2X09QCiAjdW5kZWYgS1ZNX1g4Nl9PUF9OVUxMCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20va3ZtX2hvc3QuaAppbmRleCA4OWQ1M2U1NWUxZjkuLjljMzEzMzM4MDAyOCAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9rdm1faG9zdC5oCkBAIC0xMzQzLDYgKzEzNDMsNyBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMg
ewogCXZvaWQgKCpzZXRfY3I0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcg
Y3I0KTsKIAl2b2lkICgqY29udHJvbF9jcjNfaW50ZXJjZXB0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIGludCB0eXBlLAogCQkJCSAgICAgIGJvb2wgZW5hYmxlKTsKKwlib29sICgqY3IzX3dyaXRl
X2ludGVyY2VwdGVkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCWludCAoKnNldF9lZmVyKShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCBlZmVyKTsKIAl2b2lkICgqZ2V0X2lkdCkoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19wdHIgKmR0KTsKIAl2b2lkICgqc2V0X2lkdCko
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19wdHIgKmR0KTsKZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IDVh
MDUxZmExOWM3ZS4uOWZhYzY5YzhlMTM1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2
bS5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKQEAgLTE4NjMsNiArMTg2MywxMyBAQCBz
dGF0aWMgdm9pZCBzdm1fY29udHJvbF9jcjNfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgaW50IHR5cGUsCiAJCQkgc3ZtX2Nscl9pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfQ1IzX1dS
SVRFKTsKIH0KIAorc3RhdGljIGJvb2wgc3ZtX2NyM193cml0ZV9pbnRlcmNlcHRlZChzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7
CisKKwlyZXR1cm4gc3ZtX2lzX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9DUjNfV1JJVEUpOwor
fQorCiBzdGF0aWMgdm9pZCBzdm1fc2V0X3NlZ21lbnQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAog
CQkJICAgIHN0cnVjdCBrdm1fc2VnbWVudCAqdmFyLCBpbnQgc2VnKQogewpAQCAtNDYzNCw2ICs0
NjQxLDcgQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBzdm1feDg2X29wcyBfX2luaXRkYXRh
ID0gewogCS5pc192YWxpZF9jcjQgPSBzdm1faXNfdmFsaWRfY3I0LAogCS5zZXRfY3I0ID0gc3Zt
X3NldF9jcjQsCiAJLmNvbnRyb2xfY3IzX2ludGVyY2VwdCA9IHN2bV9jb250cm9sX2NyM19pbnRl
cmNlcHQsCisJLmNyM193cml0ZV9pbnRlcmNlcHRlZCA9IHN2bV9jcjNfd3JpdGVfaW50ZXJjZXB0
ZWQsCiAJLnNldF9lZmVyID0gc3ZtX3NldF9lZmVyLAogCS5nZXRfaWR0ID0gc3ZtX2dldF9pZHQs
CiAJLnNldF9pZHQgPSBzdm1fc2V0X2lkdCwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgv
dm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IGM4ZjViYzM3MWYzOC4uM2Y1NzMx
MjEzYWNmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2
L2t2bS92bXgvdm14LmMKQEAgLTMwMjEsNiArMzAyMSwxMyBAQCBzdGF0aWMgdm9pZCB2bXhfY29u
dHJvbF9jcjNfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IHR5cGUsCiAJCWV4
ZWNfY29udHJvbHNfY2xlYXJiaXQodm14LCBjcjNfZXhlY19jb250cm9sKTsKIH0KIAorc3RhdGlj
IGJvb2wgdm14X2NyM193cml0ZV9pbnRlcmNlcHRlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7
CisJc3RydWN0IHZjcHVfdm14ICp2bXggPSB0b192bXgodmNwdSk7CisKKwlyZXR1cm4gISEoZXhl
Y19jb250cm9sc19nZXQodm14KSAmIENQVV9CQVNFRF9DUjNfTE9BRF9FWElUSU5HKTsKK30KKwog
dm9pZCB2bXhfc2V0X2NyMChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgY3Iw
KQogewogCXN0cnVjdCB2Y3B1X3ZteCAqdm14ID0gdG9fdm14KHZjcHUpOwpAQCAtNzYyMiw2ICs3
NjI5LDcgQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyB2bXhfeDg2X29wcyBfX2luaXRkYXRh
ID0gewogCS5pc192YWxpZF9jcjQgPSB2bXhfaXNfdmFsaWRfY3I0LAogCS5zZXRfY3I0ID0gdm14
X3NldF9jcjQsCiAJLmNvbnRyb2xfY3IzX2ludGVyY2VwdCA9IHZteF9jb250cm9sX2NyM19pbnRl
cmNlcHQsCisJLmNyM193cml0ZV9pbnRlcmNlcHRlZCA9IHZteF9jcjNfd3JpdGVfaW50ZXJjZXB0
ZWQsCiAJLnNldF9lZmVyID0gdm14X3NldF9lZmVyLAogCS5nZXRfaWR0ID0gdm14X2dldF9pZHQs
CiAJLnNldF9pZHQgPSB2bXhfc2V0X2lkdCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
