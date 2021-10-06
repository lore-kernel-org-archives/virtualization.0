Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6994EC4332F
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3638661186
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3638661186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3069B84087;
	Wed,  6 Oct 2021 17:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4kIvqNo_wigf; Wed,  6 Oct 2021 17:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ABF8E83FBD;
	Wed,  6 Oct 2021 17:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF702C0029;
	Wed,  6 Oct 2021 17:55:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CAEEC0023
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2A00407EB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aa33OaHVuqAI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A5AD407D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 483D0307CABF; Wed,  6 Oct 2021 20:30:55 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 2E6543064495;
 Wed,  6 Oct 2021 20:30:55 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 06/77] KVM: x86: add kvm_x86_ops.bp_intercepted()
Date: Wed,  6 Oct 2021 20:30:02 +0300
Message-Id: <20211006173113.26445-7-alazar@bitdefender.com>
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

RnJvbTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KCkJvdGgsIHRoZSBp
bnRyb3NwZWN0aW9uIHRvb2wgYW5kIHRoZSBkZXZpY2UgbWFuYWdlciBjYW4gcmVxdWVzdCAjQlAK
aW50ZXJjZXB0aW9uLiBUaGlzIGZ1bmN0aW9uIHdpbGwgYmUgdXNlZCB0byBjaGVjayBpZiB0aGlz
IGludGVyY2VwdGlvbgppcyBhbHJlYWR5IGVuYWJsZWQgYnkgZWl0aGVyIHNpZGUuCgpTaWduZWQt
b2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94
ODYvaW5jbHVkZS9hc20va3ZtLXg4Ni1vcHMuaCB8IDEgKwogYXJjaC94ODYvaW5jbHVkZS9hc20v
a3ZtX2hvc3QuaCAgICB8IDEgKwogYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICAgICAgICB8
IDggKysrKysrKysKIGFyY2gveDg2L2t2bS9zdm0vc3ZtLmggICAgICAgICAgICAgfCA4ICsrKysr
KysrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAgICAgICAgIHwgNiArKysrKysKIDUgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2t2bS14ODYtb3BzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm0teDg2LW9wcy5o
CmluZGV4IGNlZmUxZDgxZTJlOC4uMzFhZjI1MWM1NjIyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm0teDg2LW9wcy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bS14
ODYtb3BzLmgKQEAgLTEyMSw2ICsxMjEsNyBAQCBLVk1fWDg2X09QX05VTEwoZW5hYmxlX2RpcmVj
dF90bGJmbHVzaCkKIEtWTV9YODZfT1BfTlVMTChtaWdyYXRlX3RpbWVycykKIEtWTV9YODZfT1Ao
bXNyX2ZpbHRlcl9jaGFuZ2VkKQogS1ZNX1g4Nl9PUF9OVUxMKGNvbXBsZXRlX2VtdWxhdGVkX21z
cikKK0tWTV9YODZfT1AoYnBfaW50ZXJjZXB0ZWQpCiAKICN1bmRlZiBLVk1fWDg2X09QCiAjdW5k
ZWYgS1ZNX1g4Nl9PUF9OVUxMCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
aG9zdC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAppbmRleCA1MjcxZmNlNmNk
NjUuLjI2YTUyNTIwYjhiZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hv
c3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xMzIzLDYgKzEz
MjMsNyBAQCBzdHJ1Y3Qga3ZtX3g4Nl9vcHMgewogCXZvaWQgKCp2Y3B1X2xvYWQpKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgaW50IGNwdSk7CiAJdm9pZCAoKnZjcHVfcHV0KShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUpOwogCisJYm9vbCAoKmJwX2ludGVyY2VwdGVkKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUpOwogCXZvaWQgKCp1cGRhdGVfZXhjZXB0aW9uX2JpdG1hcCkoc3RydWN0IGt2bV92Y3B1ICp2
Y3B1KTsKIAlpbnQgKCpnZXRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3Jf
ZGF0YSAqbXNyKTsKIAlpbnQgKCpzZXRfbXNyKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHN0cnVj
dCBtc3JfZGF0YSAqbXNyKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMgYi9h
cmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCmluZGV4IDg5MDc3MTYwZDQ2My4uYWJlY2MxMjM0MTYxIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0v
c3ZtLmMKQEAgLTE4ODEsNiArMTg4MSwxMyBAQCBzdGF0aWMgdm9pZCBzdm1fc2V0X3NlZ21lbnQo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LAogCXZtY2JfbWFya19kaXJ0eShzdm0tPnZtY2IsIFZNQ0Jf
U0VHKTsKIH0KIAorc3RhdGljIGJvb2wgc3ZtX2JwX2ludGVyY2VwdGVkKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSkKK3sKKwlzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRvX3N2bSh2Y3B1KTsKKworCXJl
dHVybiBnZXRfZXhjZXB0aW9uX2ludGVyY2VwdChzdm0sIEJQX1ZFQ1RPUik7Cit9CisKIHN0YXRp
YyB2b2lkIHN2bV91cGRhdGVfZXhjZXB0aW9uX2JpdG1hcChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUp
CiB7CiAJc3RydWN0IHZjcHVfc3ZtICpzdm0gPSB0b19zdm0odmNwdSk7CkBAIC00NjAwLDYgKzQ2
MDcsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV94ODZfb3BzIHN2bV94ODZfb3BzIF9faW5pdGRhdGEg
PSB7CiAJLnZjcHVfYmxvY2tpbmcgPSBzdm1fdmNwdV9ibG9ja2luZywKIAkudmNwdV91bmJsb2Nr
aW5nID0gc3ZtX3ZjcHVfdW5ibG9ja2luZywKIAorCS5icF9pbnRlcmNlcHRlZCA9IHN2bV9icF9p
bnRlcmNlcHRlZCwKIAkudXBkYXRlX2V4Y2VwdGlvbl9iaXRtYXAgPSBzdm1fdXBkYXRlX2V4Y2Vw
dGlvbl9iaXRtYXAsCiAJLmdldF9tc3JfZmVhdHVyZSA9IHN2bV9nZXRfbXNyX2ZlYXR1cmUsCiAJ
LmdldF9tc3IgPSBzdm1fZ2V0X21zciwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vc3Zt
LmggYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5oCmluZGV4IDBkN2JiZTU0OGFjMy4uMzJjMmQ2ZDM0
MjRiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5oCisrKyBiL2FyY2gveDg2L2t2
bS9zdm0vc3ZtLmgKQEAgLTM1OSw2ICszNTksMTQgQEAgc3RhdGljIGlubGluZSB2b2lkIGNscl9l
eGNlcHRpb25faW50ZXJjZXB0KHN0cnVjdCB2Y3B1X3N2bSAqc3ZtLCB1MzIgYml0KQogCXJlY2Fs
Y19pbnRlcmNlcHRzKHN2bSk7CiB9CiAKK3N0YXRpYyBpbmxpbmUgYm9vbCBnZXRfZXhjZXB0aW9u
X2ludGVyY2VwdChzdHJ1Y3QgdmNwdV9zdm0gKnN2bSwgaW50IGJpdCkKK3sKKwlzdHJ1Y3Qgdm1j
YiAqdm1jYiA9IHN2bS0+dm1jYjAxLnB0cjsKKworCVdBUk5fT05fT05DRShiaXQgPj0gMzIpOwor
CXJldHVybiB2bWNiX2lzX2ludGVyY2VwdCgmdm1jYi0+Y29udHJvbCwgSU5URVJDRVBUX0VYQ0VQ
VElPTl9PRkZTRVQgKyBiaXQpOworfQorCiBzdGF0aWMgaW5saW5lIHZvaWQgc3ZtX3NldF9pbnRl
cmNlcHQoc3RydWN0IHZjcHVfc3ZtICpzdm0sIGludCBiaXQpCiB7CiAJc3RydWN0IHZtY2IgKnZt
Y2IgPSBzdm0tPnZtY2IwMS5wdHI7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5j
IGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwppbmRleCAxYzhiMmI2ZTdlZDkuLjZmZGMzZDEwYjJi
NCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYworKysgYi9hcmNoL3g4Ni9rdm0v
dm14L3ZteC5jCkBAIC03MTUsNiArNzE1LDExIEBAIHN0YXRpYyB1MzIgdm14X3JlYWRfZ3Vlc3Rf
c2VnX2FyKHN0cnVjdCB2Y3B1X3ZteCAqdm14LCB1bnNpZ25lZCBzZWcpCiAJcmV0dXJuICpwOwog
fQogCitzdGF0aWMgYm9vbCB2bXhfYnBfaW50ZXJjZXB0ZWQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KQoreworCXJldHVybiAodm1jc19yZWFkMzIoRVhDRVBUSU9OX0JJVE1BUCkgJiAoMXUgPDwgQlBf
VkVDVE9SKSk7Cit9CisKIHZvaWQgdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSkKIHsKIAl1MzIgZWI7CkBAIC03NTg2LDYgKzc1OTEsNyBAQCBzdGF0aWMg
c3RydWN0IGt2bV94ODZfb3BzIHZteF94ODZfb3BzIF9faW5pdGRhdGEgPSB7CiAJLnZjcHVfbG9h
ZCA9IHZteF92Y3B1X2xvYWQsCiAJLnZjcHVfcHV0ID0gdm14X3ZjcHVfcHV0LAogCisJLmJwX2lu
dGVyY2VwdGVkID0gdm14X2JwX2ludGVyY2VwdGVkLAogCS51cGRhdGVfZXhjZXB0aW9uX2JpdG1h
cCA9IHZteF91cGRhdGVfZXhjZXB0aW9uX2JpdG1hcCwKIAkuZ2V0X21zcl9mZWF0dXJlID0gdm14
X2dldF9tc3JfZmVhdHVyZSwKIAkuZ2V0X21zciA9IHZteF9nZXRfbXNyLApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
