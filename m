Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88561C433FE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404B76052B
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 404B76052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 814DF60EEE;
	Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJtBTA0kl2BP; Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04CFB60EF0;
	Wed,  6 Oct 2021 17:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0B6CC0027;
	Wed,  6 Oct 2021 17:40:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5BE0C001D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8470683B17
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cQsDxpFKuNB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8222983ABC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 ED5D63086402; Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id D6787305FFA0;
 Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 77/77] KVM: x86: call the page tracking code on emulation
 failure
Date: Wed,  6 Oct 2021 20:31:13 +0300
Message-Id: <20211006173113.26445-78-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhlIGluZm9ybWF0
aW9uIHdlIGNhbiBwcm92aWRlIHRoaXMgd2F5IGlzIGluY29tcGxldGUsIGJ1dCBjdXJyZW50IHVz
ZXJzCm9mIHRoZSBwYWdlIHRyYWNraW5nIGNvZGUgY2FuIHdvcmsgd2l0aCBpdC4KClNpZ25lZC1v
ZmYtYnk6IE1paGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1i
eTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2
L2t2bS94ODYuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDlhM2ZhYzliMzBiYS4u
YTljYWFjZWEwMjA3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94
ODYva3ZtL3g4Ni5jCkBAIC03ODcyLDYgKzc4NzIsNTEgQEAgaW50IHg4Nl9kZWNvZGVfZW11bGF0
ZWRfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBpbnQgZW11bGF0aW9uX3R5cGUs
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTCh4ODZfZGVjb2RlX2VtdWxhdGVkX2luc3RydWN0aW9uKTsK
IAorLyoKKyAqIFdpdGggaW50cm9zcGVjdGlvbiBlbmFibGVkLCBlbXVsYXRpb24gZmFpbHVyZXMg
dHJhbnNsYXRlIGluIGV2ZW50cyBiZWluZworICogbWlzc2VkIGJlY2F1c2UgdGhlIHJlYWQvd3Jp
dGUgY2FsbGJhY2tzIGFyZSBub3QgaW52b2tlZC4gQWxsIHdlIGhhdmUgaXMKKyAqIHRoZSBmZXRj
aCBldmVudCAoa3ZtX3BhZ2VfdHJhY2tfcHJlZXhlYykuIEJlbG93IHdlIHVzZSB0aGUgRVBUL05Q
VCBWTUVYSVQKKyAqIGluZm9ybWF0aW9uIHRvIGdlbmVyYXRlIHRoZSBldmVudHMsIGJ1dCB3aXRo
b3V0IHByb3ZpZGluZyBhY2N1cmF0ZQorICogZGF0YSBhbmQgc2l6ZSAodGhlIGVtdWxhdG9yIHdv
dWxkIGhhdmUgY29tcHV0ZWQgdGhvc2UpLiBJZiBhbiBpbnN0cnVjdGlvbgorICogd291bGQgaGFw
cGVuIHRvIHJlYWQgYW5kIHdyaXRlIGluIHRoZSBzYW1lIHBhZ2UsIHRoZSBzZWNvbmQgZXZlbnQg
d2lsbAorICogaW5pdGlhbGx5IGJlIG1pc3NlZCBhbmQgd2UgcmVseSBvbiB0aGUgcGFnZSB0cmFj
a2luZyBtZWNoYW5pc20gdG8gYnJpbmcKKyAqIHVzIGJhY2sgaGVyZSB0byBzZW5kIGl0LgorICov
CitzdGF0aWMgYm9vbCBrdm1fcGFnZV90cmFja19lbXVsYXRpb25fZmFpbHVyZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGdwYV90IGdwYSkKK3sKKwl1NjQgZXJyb3JfY29kZSA9IHZjcHUtPmFyY2gu
ZXJyb3JfY29kZTsKKwl1OCBkYXRhID0gMDsKKwlndmFfdCBndmE7CisJYm9vbCByZXQ7CisKKwkv
KiBNTUlPIGVtdWxhdGlvbiBmYWlsdXJlcyBzaG91bGQgYmUgdHJlYXRlZCB0aGUgbm9ybWFsIHdh
eSAqLworCWlmICh1bmxpa2VseShlcnJvcl9jb2RlICYgUEZFUlJfUlNWRF9NQVNLKSkKKwkJcmV0
dXJuIHRydWU7CisKKwkvKiBFUFQvTlRQIG11c3QgYmUgZW5hYmxlZCAqLworCWlmICh1bmxpa2Vs
eSghdmNwdS0+YXJjaC5tbXUtPmRpcmVjdF9tYXApKQorCQlyZXR1cm4gdHJ1ZTsKKworCS8qCisJ
ICogVGhlIEEvRCBiaXQgZW11bGF0aW9uIHNob3VsZCBtYWtlIHRoaXMgdGVzdCB1bm5lZWRlZCwg
YnV0IGp1c3QKKwkgKiBpbiBjYXNlCisJICovCisJaWYgKHVubGlrZWx5KChlcnJvcl9jb2RlICYg
UEZFUlJfTkVTVEVEX0dVRVNUX1BBR0UpID09CisJCSAgICAgUEZFUlJfTkVTVEVEX0dVRVNUX1BB
R0UpKQorCQlyZXR1cm4gdHJ1ZTsKKworCWd2YSA9IHN0YXRpY19jYWxsKGt2bV94ODZfZmF1bHRf
Z2xhKSh2Y3B1KTsKKworCWlmIChlcnJvcl9jb2RlICYgUEZFUlJfV1JJVEVfTUFTSykKKwkJcmV0
ID0ga3ZtX3BhZ2VfdHJhY2tfcHJld3JpdGUodmNwdSwgZ3BhLCBndmEsICZkYXRhLCAwKTsKKwll
bHNlIGlmIChlcnJvcl9jb2RlICYgUEZFUlJfVVNFUl9NQVNLKQorCQlyZXQgPSBrdm1fcGFnZV90
cmFja19wcmVyZWFkKHZjcHUsIGdwYSwgZ3ZhLCAwKTsKKwllbHNlCisJCXJldCA9IHRydWU7CisK
KwlyZXR1cm4gcmV0OworfQorCiBpbnQgeDg2X2VtdWxhdGVfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2
bV92Y3B1ICp2Y3B1LCBncGFfdCBjcjJfb3JfZ3BhLAogCQkJICAgIGludCBlbXVsYXRpb25fdHlw
ZSwgdm9pZCAqaW5zbiwgaW50IGluc25fbGVuKQogewpAQCAtNzkwNSw2ICs3OTUwLDggQEAgaW50
IHg4Nl9lbXVsYXRlX2luc3RydWN0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3BhX3QgY3Iy
X29yX2dwYSwKIAkJCQlrdm1fcXVldWVfZXhjZXB0aW9uKHZjcHUsIFVEX1ZFQ1RPUik7CiAJCQkJ
cmV0dXJuIDE7CiAJCQl9CisJCQlpZiAoIWt2bV9wYWdlX3RyYWNrX2VtdWxhdGlvbl9mYWlsdXJl
KHZjcHUsIGNyMl9vcl9ncGEpKQorCQkJCXJldHVybiAxOwogCQkJaWYgKHJlZXhlY3V0ZV9pbnN0
cnVjdGlvbih2Y3B1LCBjcjJfb3JfZ3BhLAogCQkJCQkJICB3cml0ZV9mYXVsdF90b19zcHQsCiAJ
CQkJCQkgIGVtdWxhdGlvbl90eXBlKSkKQEAgLTc5NzQsNiArODAyMSw4IEBAIGludCB4ODZfZW11
bGF0ZV9pbnN0cnVjdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGNyMl9vcl9ncGEs
CiAJCXJldHVybiAxOwogCiAJaWYgKHIgPT0gRU1VTEFUSU9OX0ZBSUxFRCkgeworCQlpZiAoIWt2
bV9wYWdlX3RyYWNrX2VtdWxhdGlvbl9mYWlsdXJlKHZjcHUsIGNyMl9vcl9ncGEpKQorCQkJcmV0
dXJuIDE7CiAJCWlmIChyZWV4ZWN1dGVfaW5zdHJ1Y3Rpb24odmNwdSwgY3IyX29yX2dwYSwgd3Jp
dGVfZmF1bHRfdG9fc3B0LAogCQkJCQllbXVsYXRpb25fdHlwZSkpCiAJCQlyZXR1cm4gMTsKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
