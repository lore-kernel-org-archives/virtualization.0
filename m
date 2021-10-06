Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE14AC433FE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B2661184
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95B2661184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69DBA60F04;
	Wed,  6 Oct 2021 17:55:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCnthgroCPe8; Wed,  6 Oct 2021 17:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAFD360F06;
	Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9294EC0027;
	Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7074AC0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D9F760EFC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63-gdb2LQ4Ka
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7583C60EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 DA19F307CAE9; Wed,  6 Oct 2021 20:31:01 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id B62C93064495;
 Wed,  6 Oct 2021 20:31:01 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 21/77] KVM: x86: export kvm_inject_pending_exception()
Date: Wed,  6 Oct 2021 20:30:17 +0300
Message-Id: <20211006173113.26445-22-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX0lOSkVDVF9FWENFUFRJT04gY29tbWFuZC4K
ClNpZ25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0t
CiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIHwgIDEgKwogYXJjaC94ODYva3ZtL3g4
Ni5jICAgICAgICAgICAgICB8IDUyICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQog
MiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20va3ZtX2hvc3QuaAppbmRleCA0OTczNGZlYTdjNGYuLjY4MWUyN2MyMDY1ZCAxMDA2NDQK
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xNzQwLDYgKzE3NDAsNyBAQCB1bnNpZ25lZCBsb25nIGt2
bV9nZXRfcmZsYWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2bV9zZXRfcmZsYWdz
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyByZmxhZ3MpOwogaW50IGt2bV9l
bXVsYXRlX3JkcG1jKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiAKK2Jvb2wga3ZtX2luamVjdF9w
ZW5kaW5nX2V4Y2VwdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwogdm9pZCBrdm1fcXVldWVf
ZXhjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbnIpOwogdm9pZCBrdm1f
cXVldWVfZXhjZXB0aW9uX2Uoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBuciwgdTMy
IGVycm9yX2NvZGUpOwogdm9pZCBrdm1fcXVldWVfZXhjZXB0aW9uX3Aoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1LCB1bnNpZ25lZCBuciwgdW5zaWduZWQgbG9uZyBwYXlsb2FkKTsKZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYwppbmRleCBkZTBmYzE1YWI3
Y2IuLjBjZDMyOTYyMmUxZSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jCisrKyBiL2Fy
Y2gveDg2L2t2bS94ODYuYwpAQCAtODgzMSw2ICs4ODMxLDM1IEBAIHN0YXRpYyB2b2lkIGt2bV9p
bmplY3RfZXhjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAlzdGF0aWNfY2FsbChrdm1f
eDg2X3F1ZXVlX2V4Y2VwdGlvbikodmNwdSk7CiB9CiAKK2Jvb2wga3ZtX2luamVjdF9wZW5kaW5n
X2V4Y2VwdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKHZjcHUtPmFyY2guZXhj
ZXB0aW9uLnBlbmRpbmcpIHsKKwkJdHJhY2Vfa3ZtX2lual9leGNlcHRpb24odmNwdS0+YXJjaC5l
eGNlcHRpb24ubnIsCisJCQkJCXZjcHUtPmFyY2guZXhjZXB0aW9uLmhhc19lcnJvcl9jb2RlLAor
CQkJCQl2Y3B1LT5hcmNoLmV4Y2VwdGlvbi5lcnJvcl9jb2RlKTsKKworCQl2Y3B1LT5hcmNoLmV4
Y2VwdGlvbi5wZW5kaW5nID0gZmFsc2U7CisJCXZjcHUtPmFyY2guZXhjZXB0aW9uLmluamVjdGVk
ID0gdHJ1ZTsKKworCQlpZiAoZXhjZXB0aW9uX3R5cGUodmNwdS0+YXJjaC5leGNlcHRpb24ubnIp
ID09IEVYQ1BUX0ZBVUxUKQorCQkJX19rdm1fc2V0X3JmbGFncyh2Y3B1LCBrdm1fZ2V0X3JmbGFn
cyh2Y3B1KSB8CisJCQkJCSAgICAgWDg2X0VGTEFHU19SRik7CisKKwkJaWYgKHZjcHUtPmFyY2gu
ZXhjZXB0aW9uLm5yID09IERCX1ZFQ1RPUikgeworCQkJa3ZtX2RlbGl2ZXJfZXhjZXB0aW9uX3Bh
eWxvYWQodmNwdSk7CisJCQlpZiAodmNwdS0+YXJjaC5kcjcgJiBEUjdfR0QpIHsKKwkJCQl2Y3B1
LT5hcmNoLmRyNyAmPSB+RFI3X0dEOworCQkJCWt2bV91cGRhdGVfZHI3KHZjcHUpOworCQkJfQor
CQl9CisKKwkJa3ZtX2luamVjdF9leGNlcHRpb24odmNwdSk7CisJCXJldHVybiB0cnVlOworCX0K
KworCXJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGludCBpbmplY3RfcGVuZGluZ19ldmVudChz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgKnJlcV9pbW1lZGlhdGVfZXhpdCkKIHsKIAlpbnQg
cjsKQEAgLTg4ODIsMjkgKzg5MTEsOCBAQCBzdGF0aWMgaW50IGluamVjdF9wZW5kaW5nX2V2ZW50
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCAqcmVxX2ltbWVkaWF0ZV9leGl0KQogCX0KIAog
CS8qIHRyeSB0byBpbmplY3QgbmV3IGV2ZW50IGlmIHBlbmRpbmcgKi8KLQlpZiAodmNwdS0+YXJj
aC5leGNlcHRpb24ucGVuZGluZykgewotCQl0cmFjZV9rdm1faW5qX2V4Y2VwdGlvbih2Y3B1LT5h
cmNoLmV4Y2VwdGlvbi5uciwKLQkJCQkJdmNwdS0+YXJjaC5leGNlcHRpb24uaGFzX2Vycm9yX2Nv
ZGUsCi0JCQkJCXZjcHUtPmFyY2guZXhjZXB0aW9uLmVycm9yX2NvZGUpOwotCi0JCXZjcHUtPmFy
Y2guZXhjZXB0aW9uLnBlbmRpbmcgPSBmYWxzZTsKLQkJdmNwdS0+YXJjaC5leGNlcHRpb24uaW5q
ZWN0ZWQgPSB0cnVlOwotCi0JCWlmIChleGNlcHRpb25fdHlwZSh2Y3B1LT5hcmNoLmV4Y2VwdGlv
bi5ucikgPT0gRVhDUFRfRkFVTFQpCi0JCQlfX2t2bV9zZXRfcmZsYWdzKHZjcHUsIGt2bV9nZXRf
cmZsYWdzKHZjcHUpIHwKLQkJCQkJICAgICBYODZfRUZMQUdTX1JGKTsKLQotCQlpZiAodmNwdS0+
YXJjaC5leGNlcHRpb24ubnIgPT0gREJfVkVDVE9SKSB7Ci0JCQlrdm1fZGVsaXZlcl9leGNlcHRp
b25fcGF5bG9hZCh2Y3B1KTsKLQkJCWlmICh2Y3B1LT5hcmNoLmRyNyAmIERSN19HRCkgewotCQkJ
CXZjcHUtPmFyY2guZHI3ICY9IH5EUjdfR0Q7Ci0JCQkJa3ZtX3VwZGF0ZV9kcjcodmNwdSk7Ci0J
CQl9Ci0JCX0KLQotCQlrdm1faW5qZWN0X2V4Y2VwdGlvbih2Y3B1KTsKKwlpZiAoa3ZtX2luamVj
dF9wZW5kaW5nX2V4Y2VwdGlvbih2Y3B1KSkKIAkJY2FuX2luamVjdCA9IGZhbHNlOwotCX0KIAog
CS8qIERvbid0IGluamVjdCBpbnRlcnJ1cHRzIGlmIHRoZSB1c2VyIGFza2VkIHRvIGF2b2lkIGRv
aW5nIHNvICovCiAJaWYgKHZjcHUtPmd1ZXN0X2RlYnVnICYgS1ZNX0dVRVNUREJHX0JMT0NLSVJR
KQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
