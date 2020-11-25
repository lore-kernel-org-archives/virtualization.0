Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E9C64E75
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0B32083E
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0B32083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6259F86A63;
	Wed, 25 Nov 2020 09:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srd7xPmCv5q8; Wed, 25 Nov 2020 09:42:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3AFC2869D0;
	Wed, 25 Nov 2020 09:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21F39C1836;
	Wed, 25 Nov 2020 09:41:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 256BFC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 176C986D65
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Olb9u+2sDLL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA2F986D67
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:53 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 5DBC5305D4F9; Wed, 25 Nov 2020 11:35:44 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 3A6183072784;
 Wed, 25 Nov 2020 11:35:44 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 08/81] KVM: x86: add kvm_x86_ops.bp_intercepted()
Date: Wed, 25 Nov 2020 11:34:47 +0200
Message-Id: <20201125093600.2766-9-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KCkJvdGgsIHRoZSBp
bnRyb3NwZWN0aW9uIHRvb2wgYW5kIHRoZSBkZXZpY2UgbWFuYWdlciBjYW4gcmVxdWVzdCAjQlAK
aW50ZXJjZXB0aW9uLiBUaGlzIGZ1bmN0aW9uIHdpbGwgYmUgdXNlZCB0byBjaGVjayBpZiB0aGlz
IGludGVyY2VwdGlvbgppcyBhbHJlYWR5IGVuYWJsZWQgYnkgZWl0aGVyIHNpZGUuCgpTaWduZWQt
b2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDEgKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAg
ICAgICAgICB8IDggKysrKysrKysKIGFyY2gveDg2L2t2bS9zdm0vc3ZtLmggICAgICAgICAgfCA3
ICsrKysrKysKIGFyY2gveDg2L2t2bS92bXgvdm14LmMgICAgICAgICAgfCA2ICsrKysrKwogNCBm
aWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20va3ZtX2hvc3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5k
ZXggZjAwMmNkYjEzYTBiLi5lNDZmZWU1OWQ0ZWQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2t2bV9ob3N0LmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApA
QCAtMTEwNCw2ICsxMTA0LDcgQEAgc3RydWN0IGt2bV94ODZfb3BzIHsKIAl2b2lkICgqdmNwdV9s
b2FkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBjcHUpOwogCXZvaWQgKCp2Y3B1X3B1dCko
c3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAorCWJvb2wgKCpicF9pbnRlcmNlcHRlZCkoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KTsKIAl2b2lkICgqdXBkYXRlX2V4Y2VwdGlvbl9iaXRtYXApKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSk7CiAJaW50ICgqZ2V0X21zcikoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBzdHJ1Y3QgbXNyX2RhdGEgKm1zcik7CiAJaW50ICgqc2V0X21zcikoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCBzdHJ1Y3QgbXNyX2RhdGEgKm1zcik7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
c3ZtL3N2bS5jIGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwppbmRleCA2ZGMzMzdiOWMyMzEuLjk1
YzcwNzJjZGU4ZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNo
L3g4Ni9rdm0vc3ZtL3N2bS5jCkBAIC0xNzM4LDYgKzE3MzgsMTMgQEAgc3RhdGljIHZvaWQgc3Zt
X3NldF9zZWdtZW50KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwKIAl2bWNiX21hcmtfZGlydHkoc3Zt
LT52bWNiLCBWTUNCX1NFRyk7CiB9CiAKK3N0YXRpYyBib29sIHN2bV9icF9pbnRlcmNlcHRlZChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0o
dmNwdSk7CisKKwlyZXR1cm4gZ2V0X2V4Y2VwdGlvbl9pbnRlcmNlcHQoc3ZtLCBCUF9WRUNUT1Ip
OworfQorCiBzdGF0aWMgdm9pZCB1cGRhdGVfZXhjZXB0aW9uX2JpdG1hcChzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpCiB7CiAJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CkBAIC00
MjEzLDYgKzQyMjAsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9f
aW5pdGRhdGEgPSB7CiAJLnZjcHVfYmxvY2tpbmcgPSBzdm1fdmNwdV9ibG9ja2luZywKIAkudmNw
dV91bmJsb2NraW5nID0gc3ZtX3ZjcHVfdW5ibG9ja2luZywKIAorCS5icF9pbnRlcmNlcHRlZCA9
IHN2bV9icF9pbnRlcmNlcHRlZCwKIAkudXBkYXRlX2V4Y2VwdGlvbl9iaXRtYXAgPSB1cGRhdGVf
ZXhjZXB0aW9uX2JpdG1hcCwKIAkuZ2V0X21zcl9mZWF0dXJlID0gc3ZtX2dldF9tc3JfZmVhdHVy
ZSwKIAkuZ2V0X21zciA9IHN2bV9nZXRfbXNyLApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3N2
bS9zdm0uaCBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmgKaW5kZXggZmRmZjc2ZWI2Y2ViLi5kY2Ey
ZGZlMmUzMGQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmgKKysrIGIvYXJjaC94
ODYva3ZtL3N2bS9zdm0uaApAQCAtMjk0LDYgKzI5NCwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
Y2xyX2V4Y2VwdGlvbl9pbnRlcmNlcHQoc3RydWN0IHZjcHVfc3ZtICpzdm0sIHUzMiBiaXQpCiAJ
cmVjYWxjX2ludGVyY2VwdHMoc3ZtKTsKIH0KIAorc3RhdGljIGlubGluZSBib29sIGdldF9leGNl
cHRpb25faW50ZXJjZXB0KHN0cnVjdCB2Y3B1X3N2bSAqc3ZtLCBpbnQgYml0KQoreworCXN0cnVj
dCB2bWNiICp2bWNiID0gZ2V0X2hvc3Rfdm1jYihzdm0pOworCisJcmV0dXJuIHZtY2JfaXNfaW50
ZXJjZXB0KCZ2bWNiLT5jb250cm9sLCBJTlRFUkNFUFRfRVhDRVBUSU9OX09GRlNFVCArIGJpdCk7
Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBzdm1fc2V0X2ludGVyY2VwdChzdHJ1Y3QgdmNwdV9z
dm0gKnN2bSwgaW50IGJpdCkKIHsKIAlzdHJ1Y3Qgdm1jYiAqdm1jYiA9IGdldF9ob3N0X3ZtY2Io
c3ZtKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jCmluZGV4IGMzNDQxZTdlNWE4Ny4uOTNhOTdhYTNkODQ3IDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTgw
Nyw2ICs4MDcsMTEgQEAgc3RhdGljIHUzMiB2bXhfcmVhZF9ndWVzdF9zZWdfYXIoc3RydWN0IHZj
cHVfdm14ICp2bXgsIHVuc2lnbmVkIHNlZykKIAlyZXR1cm4gKnA7CiB9CiAKK3N0YXRpYyBib29s
IHZteF9icF9pbnRlcmNlcHRlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJcmV0dXJuICh2
bWNzX3JlYWQzMihFWENFUFRJT05fQklUTUFQKSAmICgxdSA8PCBCUF9WRUNUT1IpKTsKK30KKwog
dm9pZCB1cGRhdGVfZXhjZXB0aW9uX2JpdG1hcChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiB7CiAJ
dTMyIGViOwpAQCAtNzYxMSw2ICs3NjE2LDcgQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyB2
bXhfeDg2X29wcyBfX2luaXRkYXRhID0gewogCS52Y3B1X2xvYWQgPSB2bXhfdmNwdV9sb2FkLAog
CS52Y3B1X3B1dCA9IHZteF92Y3B1X3B1dCwKIAorCS5icF9pbnRlcmNlcHRlZCA9IHZteF9icF9p
bnRlcmNlcHRlZCwKIAkudXBkYXRlX2V4Y2VwdGlvbl9iaXRtYXAgPSB1cGRhdGVfZXhjZXB0aW9u
X2JpdG1hcCwKIAkuZ2V0X21zcl9mZWF0dXJlID0gdm14X2dldF9tc3JfZmVhdHVyZSwKIAkuZ2V0
X21zciA9IHZteF9nZXRfbXNyLApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
