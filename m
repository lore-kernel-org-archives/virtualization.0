Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A18C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42676611AE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42676611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A6B83AEB;
	Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKwtcu_Mt_-R; Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6401383B37;
	Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8404C0024;
	Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AF09C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40B8183B00
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5m9FJXKMJ49
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CCB183AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 15313307CAE8; Wed,  6 Oct 2021 20:31:00 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id EF3C73064495;
 Wed,  6 Oct 2021 20:30:59 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 17/77] KVM: x86: add kvm_x86_ops.fault_gla()
Date: Wed,  6 Oct 2021 20:30:13 +0300
Message-Id: <20211006173113.26445-18-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 Jim Mattson <jmattson@google.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBmdW5jdGlv
biBpcyBuZWVkZWQgZm9yIGt2bWlfdXBkYXRlX2FkX2ZsYWdzKCkKYW5kIGt2bV9wYWdlX3RyYWNr
X2VtdWxhdGlvbl9mYWlsdXJlKCkuCgprdm1pX3VwZGF0ZV9hZF9mbGFncygpIHVzZXMgdGhlIGV4
aXN0aW5nIGd1ZXN0IHBhZ2UgdGFibGUgd2FsayBjb2RlIHRvCnVwZGF0ZSB0aGUgQS9EIGJpdHMg
YW5kIHJldHVybiB0byBndWVzdCAod2hlbiB0aGUgaW50cm9zcGVjdGlvbiB0b29sCndyaXRlLXBy
b3RlY3RzIHRoZSBndWVzdCBwYWdlIHRhYmxlcykuCgprdm1fcGFnZV90cmFja19lbXVsYXRpb25f
ZmFpbHVyZSgpIGNhbGxzIHRoZSBwYWdlIHRyYWNraW5nIGNvZGUsIHRoYXQKY2FuIHRyaWdnZXIg
YW4gZXZlbnQgZm9yIHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgKHdoaWNoIG1pZ2h0IG5lZWQgdGhl
CkdWQSBpbiBhZGRpdGlvbiB0byB0aGUgR1BBKS4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERvbsib
dSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KQ28tZGV2ZWxvcGVkLWJ5OiBOaWN1yJlvciBDw67I
m3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3Ug
PG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFs
YXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1v
cHMuaCB8IDEgKwogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCAgICB8IDIgKysKIGFy
Y2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oICAgICAgICAgfCAyICsrCiBhcmNoL3g4Ni9rdm0vc3Zt
L3N2bS5jICAgICAgICAgICAgIHwgOSArKysrKysrKysKIGFyY2gveDg2L2t2bS92bXgvdm14LmMg
ICAgICAgICAgICAgfCA5ICsrKysrKysrKwogNSBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgKaW5kZXggNDIyOGI3NzVhNDhlLi5hZDZj
MTlkOWJlZjUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14ODYtb3BzLmgK
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaApAQCAtMTI5LDYgKzEyOSw3
IEBAIEtWTV9YODZfT1AoY29udHJvbF9kZXNjX2ludGVyY2VwdCkKIEtWTV9YODZfT1AoZGVzY19p
bnRlcmNlcHRlZCkKIEtWTV9YODZfT1AobXNyX3dyaXRlX2ludGVyY2VwdGVkKQogS1ZNX1g4Nl9P
UChjb250cm9sX21zcl9pbnRlcmNlcHQpCitLVk1fWDg2X09QKGZhdWx0X2dsYSkKIAogI3VuZGVm
IEtWTV9YODZfT1AKICN1bmRlZiBLVk1fWDg2X09QX05VTEwKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5o
CmluZGV4IGRiODhkMzhlNDg1ZC4uOTYwNThhOGExZTVlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0
LmgKQEAgLTE1MDksNiArMTUwOSw4IEBAIHN0cnVjdCBrdm1feDg2X29wcyB7CiAJaW50ICgqY29t
cGxldGVfZW11bGF0ZWRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBlcnIpOwogCiAJ
dm9pZCAoKnZjcHVfZGVsaXZlcl9zaXBpX3ZlY3Rvcikoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1
OCB2ZWN0b3IpOworCisJdTY0ICgqZmF1bHRfZ2xhKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwog
fTsKIAogc3RydWN0IGt2bV94ODZfbmVzdGVkX29wcyB7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS92bXguaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oCmluZGV4IDBmZmFh
MzE1NmE0ZS4uNWNlZjNiOTZlMjlhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92
bXguaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaApAQCAtNTQ2LDYgKzU0Niw3IEBA
IGVudW0gdm1fZW50cnlfZmFpbHVyZV9jb2RlIHsKICNkZWZpbmUgRVBUX1ZJT0xBVElPTl9SRUFE
QUJMRV9CSVQJMwogI2RlZmluZSBFUFRfVklPTEFUSU9OX1dSSVRBQkxFX0JJVAk0CiAjZGVmaW5l
IEVQVF9WSU9MQVRJT05fRVhFQ1VUQUJMRV9CSVQJNQorI2RlZmluZSBFUFRfVklPTEFUSU9OX0dM
QV9WQUxJRF9CSVQJNwogI2RlZmluZSBFUFRfVklPTEFUSU9OX0dWQV9UUkFOU0xBVEVEX0JJVCA4
CiAjZGVmaW5lIEVQVF9WSU9MQVRJT05fQUNDX1JFQUQJCSgxIDw8IEVQVF9WSU9MQVRJT05fQUND
X1JFQURfQklUKQogI2RlZmluZSBFUFRfVklPTEFUSU9OX0FDQ19XUklURQkJKDEgPDwgRVBUX1ZJ
T0xBVElPTl9BQ0NfV1JJVEVfQklUKQpAQCAtNTUzLDYgKzU1NCw3IEBAIGVudW0gdm1fZW50cnlf
ZmFpbHVyZV9jb2RlIHsKICNkZWZpbmUgRVBUX1ZJT0xBVElPTl9SRUFEQUJMRQkJKDEgPDwgRVBU
X1ZJT0xBVElPTl9SRUFEQUJMRV9CSVQpCiAjZGVmaW5lIEVQVF9WSU9MQVRJT05fV1JJVEFCTEUJ
CSgxIDw8IEVQVF9WSU9MQVRJT05fV1JJVEFCTEVfQklUKQogI2RlZmluZSBFUFRfVklPTEFUSU9O
X0VYRUNVVEFCTEUJKDEgPDwgRVBUX1ZJT0xBVElPTl9FWEVDVVRBQkxFX0JJVCkKKyNkZWZpbmUg
RVBUX1ZJT0xBVElPTl9HTEFfVkFMSUQJCSgxIDw8IEVQVF9WSU9MQVRJT05fR0xBX1ZBTElEX0JJ
VCkKICNkZWZpbmUgRVBUX1ZJT0xBVElPTl9HVkFfVFJBTlNMQVRFRAkoMSA8PCBFUFRfVklPTEFU
SU9OX0dWQV9UUkFOU0xBVEVEX0JJVCkKIAogLyoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9z
dm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IGRlNmNiNTlhMzMyZC4uNTQw
OTQzODc2NmVlIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gv
eDg2L2t2bS9zdm0vc3ZtLmMKQEAgLTQ3MDQsNiArNDcwNCwxMyBAQCBzdGF0aWMgaW50IHN2bV92
bV9pbml0KHN0cnVjdCBrdm0gKmt2bSkKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHU2NCBzdm1f
ZmF1bHRfZ2xhKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKK3sKKwljb25zdCBzdHJ1Y3QgdmNwdV9z
dm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKworCXJldHVybiBzdm0tPnZjcHUuYXJjaC5jcjIgPyBz
dm0tPnZjcHUuYXJjaC5jcjIgOiB+MHVsbDsKK30KKwogc3RhdGljIHN0cnVjdCBrdm1feDg2X29w
cyBzdm1feDg2X29wcyBfX2luaXRkYXRhID0gewogCS5oYXJkd2FyZV91bnNldHVwID0gc3ZtX2hh
cmR3YXJlX3RlYXJkb3duLAogCS5oYXJkd2FyZV9lbmFibGUgPSBzdm1faGFyZHdhcmVfZW5hYmxl
LApAQCAtNDgzOSw2ICs0ODQ2LDggQEAgc3RhdGljIHN0cnVjdCBrdm1feDg2X29wcyBzdm1feDg2
X29wcyBfX2luaXRkYXRhID0gewogCS5jb21wbGV0ZV9lbXVsYXRlZF9tc3IgPSBzdm1fY29tcGxl
dGVfZW11bGF0ZWRfbXNyLAogCiAJLnZjcHVfZGVsaXZlcl9zaXBpX3ZlY3RvciA9IHN2bV92Y3B1
X2RlbGl2ZXJfc2lwaV92ZWN0b3IsCisKKwkuZmF1bHRfZ2xhID0gc3ZtX2ZhdWx0X2dsYSwKIH07
CiAKIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9pbml0X29wcyBzdm1faW5pdF9vcHMgX19pbml0ZGF0
YSA9IHsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jCmluZGV4IGNlYmEyZTExMmUyNi4uZjNlODgwZWYyMmM4IDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKQEAgLTc2
MjAsNiArNzYyMCwxMyBAQCBzdGF0aWMgYm9vbCB2bXhfY2hlY2tfYXBpY3ZfaW5oaWJpdF9yZWFz
b25zKHVsb25nIGJpdCkKIAlyZXR1cm4gc3VwcG9ydGVkICYgQklUKGJpdCk7CiB9CiAKK3N0YXRp
YyB1NjQgdm14X2ZhdWx0X2dsYShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKHZjcHUt
PmFyY2guZXhpdF9xdWFsaWZpY2F0aW9uICYgRVBUX1ZJT0xBVElPTl9HTEFfVkFMSUQpCisJCXJl
dHVybiB2bWNzX3JlYWRsKEdVRVNUX0xJTkVBUl9BRERSRVNTKTsKKwlyZXR1cm4gfjB1bGw7Cit9
CisKIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsK
IAkuaGFyZHdhcmVfdW5zZXR1cCA9IGhhcmR3YXJlX3Vuc2V0dXAsCiAKQEAgLTc3NjIsNiArNzc2
OSw4IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9
IHsKIAkuY29tcGxldGVfZW11bGF0ZWRfbXNyID0ga3ZtX2NvbXBsZXRlX2luc25fZ3AsCiAKIAku
dmNwdV9kZWxpdmVyX3NpcGlfdmVjdG9yID0ga3ZtX3ZjcHVfZGVsaXZlcl9zaXBpX3ZlY3RvciwK
KworCS5mYXVsdF9nbGEgPSB2bXhfZmF1bHRfZ2xhLAogfTsKIAogc3RhdGljIF9faW5pdCB2b2lk
IHZteF9zZXR1cF91c2VyX3JldHVybl9tc3JzKHZvaWQpCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
