Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD6C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B082389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B082389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53AF086F72;
	Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IW2Cyq_H93b; Mon,  7 Dec 2020 20:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B936586F3C;
	Mon,  7 Dec 2020 20:46:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFA4DC0FA7;
	Mon,  7 Dec 2020 20:46:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F09FBC163C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CFE6386E22
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqWmY2S3atYs
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E430186F06
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:15 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 27FEB305D507; Mon,  7 Dec 2020 22:46:14 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 0AD473072784;
 Mon,  7 Dec 2020 22:46:14 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 14/81] KVM: x86: add kvm_x86_ops.desc_intercepted()
Date: Mon,  7 Dec 2020 22:45:15 +0200
Message-Id: <20201207204622.15258-15-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KClRoaXMgZnVuY3Rp
b24gd2lsbCBiZSB1c2VkIHRvIHRlc3QgaWYgdGhlIGRlc2NyaXB0b3ItdGFibGUgcmVnaXN0ZXJz
CmFjY2VzcyBpcyBhbHJlYWR5IHRyYWNrZWQgYnkgdXNlcnNwYWNlLgoKU2lnbmVkLW9mZi1ieTog
TmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRh
bGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2luY2x1
ZGUvYXNtL2t2bV9ob3N0LmggfCAgMSArCiBhcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jICAgICAgICAg
IHwgMTUgKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAgICAgIHwg
IDggKysrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oCmluZGV4IDczMDQyOWNkMmUzZC4uMGU5MTQ0ZTIzY2U2IDEwMDY0NAotLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2t2bV9ob3N0LmgKQEAgLTExMzIsNiArMTEzMiw3IEBAIHN0cnVjdCBrdm1feDg2X29wcyB7
CiAJdm9pZCAoKnNldF9nZHQpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgc3RydWN0IGRlc2NfcHRy
ICpkdCk7CiAJYm9vbCAoKmRlc2NfY3RybF9zdXBwb3J0ZWQpKHZvaWQpOwogCXZvaWQgKCpjb250
cm9sX2Rlc2NfaW50ZXJjZXB0KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgZW5hYmxlKTsK
Kwlib29sICgqZGVzY19pbnRlcmNlcHRlZCkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAl2b2lk
ICgqc3luY19kaXJ0eV9kZWJ1Z19yZWdzKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogCXZvaWQg
KCpzZXRfZHI3KShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIGxvbmcgdmFsdWUpOwog
CXZvaWQgKCpjYWNoZV9yZWcpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZW51bSBrdm1fcmVnIHJl
Zyk7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2
bS9zdm0uYwppbmRleCBjOGU1NmFkOWNiYjEuLjg2ZjBkY2Y5ZmVjZCAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0xNjYw
LDYgKzE2NjAsMjAgQEAgc3RhdGljIHZvaWQgc3ZtX2NvbnRyb2xfZGVzY19pbnRlcmNlcHQoc3Ry
dWN0IGt2bV92Y3B1ICp2Y3B1LCBib29sIGVuYWJsZSkKIAl9CiB9CiAKK3N0YXRpYyBpbmxpbmUg
Ym9vbCBzdm1fZGVzY19pbnRlcmNlcHRlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3Ry
dWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CisKKwlyZXR1cm4gKHN2bV9pc19pbnRl
cmNlcHQoc3ZtLCBJTlRFUkNFUFRfU1RPUkVfSURUUikgfHwKKwkJc3ZtX2lzX2ludGVyY2VwdChz
dm0sIElOVEVSQ0VQVF9TVE9SRV9HRFRSKSB8fAorCQlzdm1faXNfaW50ZXJjZXB0KHN2bSwgSU5U
RVJDRVBUX1NUT1JFX0xEVFIpIHx8CisJCXN2bV9pc19pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRf
U1RPUkVfVFIpIHx8CisJCXN2bV9pc19pbnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfTE9BRF9JRFRS
KSB8fAorCQlzdm1faXNfaW50ZXJjZXB0KHN2bSwgSU5URVJDRVBUX0xPQURfR0RUUikgfHwKKwkJ
c3ZtX2lzX2ludGVyY2VwdChzdm0sIElOVEVSQ0VQVF9MT0FEX0xEVFIpIHx8CisJCXN2bV9pc19p
bnRlcmNlcHQoc3ZtLCBJTlRFUkNFUFRfTE9BRF9UUikpOworfQorCiBzdGF0aWMgdm9pZCB1cGRh
dGVfY3IwX2ludGVyY2VwdChzdHJ1Y3QgdmNwdV9zdm0gKnN2bSkKIHsKIAl1bG9uZyBnY3IwID0g
c3ZtLT52Y3B1LmFyY2guY3IwOwpAQCAtNDMwNyw2ICs0MzIxLDcgQEAgc3RhdGljIHN0cnVjdCBr
dm1feDg2X29wcyBzdm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5zZXRfZ2R0ID0gc3ZtX3Nl
dF9nZHQsCiAJLmRlc2NfY3RybF9zdXBwb3J0ZWQgPSBzdm1fZGVzY19jdHJsX3N1cHBvcnRlZCwK
IAkuY29udHJvbF9kZXNjX2ludGVyY2VwdCA9IHN2bV9jb250cm9sX2Rlc2NfaW50ZXJjZXB0LAor
CS5kZXNjX2ludGVyY2VwdGVkID0gc3ZtX2Rlc2NfaW50ZXJjZXB0ZWQsCiAJLnNldF9kcjcgPSBz
dm1fc2V0X2RyNywKIAkuc3luY19kaXJ0eV9kZWJ1Z19yZWdzID0gc3ZtX3N5bmNfZGlydHlfZGVi
dWdfcmVncywKIAkuY2FjaGVfcmVnID0gc3ZtX2NhY2hlX3JlZywKZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IDIwMzUxZTAy
Nzg5OC4uNWJkNmE0YWRkMjdlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisr
KyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTMzNjEsNiArMzM2MSwxMyBAQCBzdGF0aWMg
dm9pZCB2bXhfc2V0X2dkdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBkZXNjX3B0ciAq
ZHQpCiAJdm1jc193cml0ZWwoR1VFU1RfR0RUUl9CQVNFLCBkdC0+YWRkcmVzcyk7CiB9CiAKK3N0
YXRpYyBib29sIHZteF9kZXNjX2ludGVyY2VwdGVkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKK3sK
KwlzdHJ1Y3QgdmNwdV92bXggKnZteCA9IHRvX3ZteCh2Y3B1KTsKKworCXJldHVybiAhIShzZWNv
bmRhcnlfZXhlY19jb250cm9sc19nZXQodm14KSAmIFNFQ09OREFSWV9FWEVDX0RFU0MpOworfQor
CiBzdGF0aWMgYm9vbCBybW9kZV9zZWdtZW50X3ZhbGlkKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwg
aW50IHNlZykKIHsKIAlzdHJ1Y3Qga3ZtX3NlZ21lbnQgdmFyOwpAQCAtNzY2OCw2ICs3Njc1LDcg
QEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyB2bXhfeDg2X29wcyBfX2luaXRkYXRhID0gewog
CS5zZXRfZ2R0ID0gdm14X3NldF9nZHQsCiAJLmRlc2NfY3RybF9zdXBwb3J0ZWQgPSB2bXhfZGVz
Y19jdHJsX3N1cHBvcnRlZCwKIAkuY29udHJvbF9kZXNjX2ludGVyY2VwdCA9IHZteF9jb250cm9s
X2Rlc2NfaW50ZXJjZXB0LAorCS5kZXNjX2ludGVyY2VwdGVkID0gdm14X2Rlc2NfaW50ZXJjZXB0
ZWQsCiAJLnNldF9kcjcgPSB2bXhfc2V0X2RyNywKIAkuc3luY19kaXJ0eV9kZWJ1Z19yZWdzID0g
dm14X3N5bmNfZGlydHlfZGVidWdfcmVncywKIAkuY2FjaGVfcmVnID0gdm14X2NhY2hlX3JlZywK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
