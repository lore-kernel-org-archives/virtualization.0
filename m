Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5367C64E75
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBA12083E
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBA12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DDADA86ABB;
	Wed, 25 Nov 2020 09:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJ85sncRUr5B; Wed, 25 Nov 2020 09:52:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8755E86AB1;
	Wed, 25 Nov 2020 09:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D265C0052;
	Wed, 25 Nov 2020 09:52:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF2E7C163C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9EF01874A7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OX0cYoQYtiCF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BA31F8747B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:54 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 A055C305D4FB; Wed, 25 Nov 2020 11:35:44 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 8076C3072784;
 Wed, 25 Nov 2020 11:35:44 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 10/81] KVM: x86: add kvm_x86_ops.cr3_write_intercepted()
Date: Wed, 25 Nov 2020 11:34:49 +0200
Message-Id: <20201125093600.2766-11-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgZnVuY3Rp
b24gd2lsbCBiZSB1c2VkIHRvIGFsbG93IHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgdG8gZGlzYWJs
ZSB0aGUKQ1IzLXdyaXRlIGludGVyY2VwdGlvbiB3aGVuIGl0IGlzIG5vIGxvbmdlciBpbnRlcmVz
dGVkIGluIHRoZXNlIGV2ZW50cywKYnV0IG9ubHkgaWYgbm90aGluZyBlbHNlIGRlcGVuZHMgb24g
dGhlc2UgVk0tZXhpdHMuCgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0
dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRk
ZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDEgKwog
YXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICB8IDggKysrKysrKysKIGFyY2gveDg2L2t2
bS92bXgvdm14LmMgICAgICAgICAgfCA4ICsrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5o
IGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCAwZWViMWQ4MjlhMWQuLmE0
MDIzODRhOTMyNiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xMTI0LDYgKzExMjQsNyBA
QCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgewogCXZvaWQgKCpzZXRfY3I0KShzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUsIHVuc2lnbmVkIGxvbmcgY3I0KTsKIAl2b2lkICgqY29udHJvbF9jcjNfaW50ZXJjZXB0
KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCB0eXBlLAogCQkJCSAgICAgIGJvb2wgZW5hYmxl
KTsKKwlib29sICgqY3IzX3dyaXRlX2ludGVyY2VwdGVkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUp
OwogCWludCAoKnNldF9lZmVyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCBlZmVyKTsKIAl2
b2lkICgqZ2V0X2lkdCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19wdHIgKmR0
KTsKIAl2b2lkICgqc2V0X2lkdCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1Y3QgZGVzY19w
dHIgKmR0KTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMgYi9hcmNoL3g4Ni9r
dm0vc3ZtL3N2bS5jCmluZGV4IDRmMjhmYTAzNTA0OC4uNTAwMGVlMjU1NDViIDEwMDY0NAotLS0g
YS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKQEAg
LTE3MjAsNiArMTcyMCwxMyBAQCBzdGF0aWMgdm9pZCBzdm1fY29udHJvbF9jcjNfaW50ZXJjZXB0
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50IHR5cGUsCiAJCQkgc3ZtX2Nscl9pbnRlcmNlcHQo
c3ZtLCBJTlRFUkNFUFRfQ1IzX1dSSVRFKTsKIH0KIAorc3RhdGljIGJvb2wgc3ZtX2NyM193cml0
ZV9pbnRlcmNlcHRlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IHZjcHVfc3Zt
ICpzdm0gPSB0b19zdm0odmNwdSk7CisKKwlyZXR1cm4gc3ZtX2lzX2ludGVyY2VwdChzdm0sIElO
VEVSQ0VQVF9DUjNfV1JJVEUpOworfQorCiBzdGF0aWMgdm9pZCBzdm1fc2V0X3NlZ21lbnQoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LAogCQkJICAgIHN0cnVjdCBrdm1fc2VnbWVudCAqdmFyLCBpbnQg
c2VnKQogewpAQCAtNDI0Nyw2ICs0MjU0LDcgQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBz
dm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5pc192YWxpZF9jcjQgPSBzdm1faXNfdmFsaWRf
Y3I0LAogCS5zZXRfY3I0ID0gc3ZtX3NldF9jcjQsCiAJLmNvbnRyb2xfY3IzX2ludGVyY2VwdCA9
IHN2bV9jb250cm9sX2NyM19pbnRlcmNlcHQsCisJLmNyM193cml0ZV9pbnRlcmNlcHRlZCA9IHN2
bV9jcjNfd3JpdGVfaW50ZXJjZXB0ZWQsCiAJLnNldF9lZmVyID0gc3ZtX3NldF9lZmVyLAogCS5n
ZXRfaWR0ID0gc3ZtX2dldF9pZHQsCiAJLnNldF9pZHQgPSBzdm1fc2V0X2lkdCwKZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4
IGM1YTUzNjQyZDFjMC4uN2IyYTYwY2Q3YTc2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14
L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTI5OTUsNiArMjk5NSwxMyBA
QCBzdGF0aWMgdm9pZCB2bXhfY29udHJvbF9jcjNfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgaW50IHR5cGUsCiAJCWV4ZWNfY29udHJvbHNfY2xlYXJiaXQodm14LCBjcjNfZXhlY19j
b250cm9sKTsKIH0KIAorc3RhdGljIGJvb2wgdm14X2NyM193cml0ZV9pbnRlcmNlcHRlZChzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IHZjcHVfdm14ICp2bXggPSB0b192bXgodmNw
dSk7CisKKwlyZXR1cm4gISEoZXhlY19jb250cm9sc19nZXQodm14KSAmIENQVV9CQVNFRF9DUjNf
TE9BRF9FWElUSU5HKTsKK30KKwogc3RhdGljIHZvaWQgZXB0X3VwZGF0ZV9wYWdpbmdfbW9kZV9j
cjAodW5zaWduZWQgbG9uZyAqaHdfY3IwLAogCQkJCQl1bnNpZ25lZCBsb25nIGNyMCwKIAkJCQkJ
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KQpAQCAtNzY0Myw2ICs3NjUwLDcgQEAgc3RhdGljIHN0cnVj
dCBrdm1feDg2X29wcyB2bXhfeDg2X29wcyBfX2luaXRkYXRhID0gewogCS5pc192YWxpZF9jcjQg
PSB2bXhfaXNfdmFsaWRfY3I0LAogCS5zZXRfY3I0ID0gdm14X3NldF9jcjQsCiAJLmNvbnRyb2xf
Y3IzX2ludGVyY2VwdCA9IHZteF9jb250cm9sX2NyM19pbnRlcmNlcHQsCisJLmNyM193cml0ZV9p
bnRlcmNlcHRlZCA9IHZteF9jcjNfd3JpdGVfaW50ZXJjZXB0ZWQsCiAJLnNldF9lZmVyID0gdm14
X3NldF9lZmVyLAogCS5nZXRfaWR0ID0gdm14X2dldF9pZHQsCiAJLnNldF9pZHQgPSB2bXhfc2V0
X2lkdCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
