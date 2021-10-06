Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CF9C43217
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0E8610A1
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE0E8610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73E07407F6;
	Wed,  6 Oct 2021 17:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TuVtAGo_n_0x; Wed,  6 Oct 2021 17:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2F51407DF;
	Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 799CAC0026;
	Wed,  6 Oct 2021 17:55:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF61CC0026
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68BB540544
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id STh-40LpxpMe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B789940684
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:55:40 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 A010F307CAED; Wed,  6 Oct 2021 20:31:03 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 845EC305FFA0;
 Wed,  6 Oct 2021 20:31:03 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 25/77] KVM: x86: page track: add track_create_slot()
 callback
Date: Wed,  6 Oct 2021 20:30:21 +0300
Message-Id: <20211006173113.26445-26-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyB1c2Vk
IHRvIGFkZCBwYWdlIGFjY2VzcyBub3RpZmljYXRpb25zIGFzIHNvb24gYXMgYSBzbG90IGFwcGVh
cnMKb3Igd2hlbiBhIHNsb3QgaXMgbW92ZWQuCgpTaWduZWQtb2ZmLWJ5OiBNaWhhaSBEb27Im3Ug
PG1kb250dUBiaXRkZWZlbmRlci5jb20+ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8
YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFn
ZV90cmFjay5oIHwgMTEgKysrKysrKysrKysKIGFyY2gveDg2L2t2bS9tbXUvcGFnZV90cmFjay5j
ICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9wYWdlX3RyYWNr
LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFnZV90cmFjay5oCmluZGV4IGY5ODFiNjM2
MGRlNS4uZGY2ZTU2NzRlYTVjIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1f
cGFnZV90cmFjay5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9wYWdlX3RyYWNrLmgK
QEAgLTM2LDYgKzM2LDE3IEBAIHN0cnVjdCBrdm1fcGFnZV90cmFja19ub3RpZmllcl9ub2RlIHsK
IAl2b2lkICgqdHJhY2tfd3JpdGUpKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3BhX3QgZ3BhLCBn
dmFfdCBndmEsCiAJCQkgICAgY29uc3QgdTggKm5ldywgaW50IGJ5dGVzLAogCQkJICAgIHN0cnVj
dCBrdm1fcGFnZV90cmFja19ub3RpZmllcl9ub2RlICpub2RlKTsKKwkvKgorCSAqIEl0IGlzIGNh
bGxlZCB3aGVuIG1lbW9yeSBzbG90IGlzIGJlaW5nIGNyZWF0ZWQKKwkgKgorCSAqIEBrdm06IHRo
ZSBrdm0gd2hlcmUgbWVtb3J5IHNsb3QgYmVpbmcgbW92ZWQgb3IgcmVtb3ZlZAorCSAqIEBzbG90
OiB0aGUgbWVtb3J5IHNsb3QgYmVpbmcgbW92ZWQgb3IgcmVtb3ZlZAorCSAqIEBucGFnZXM6IHRo
ZSBudW1iZXIgb2YgcGFnZXMKKwkgKiBAbm9kZTogdGhpcyBub2RlCisJICovCisJdm9pZCAoKnRy
YWNrX2NyZWF0ZV9zbG90KShzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3Qg
KnNsb3QsCisJCQkJICB1bnNpZ25lZCBsb25nIG5wYWdlcywKKwkJCQkgIHN0cnVjdCBrdm1fcGFn
ZV90cmFja19ub3RpZmllcl9ub2RlICpub2RlKTsKIAkvKgogCSAqIEl0IGlzIGNhbGxlZCB3aGVu
IG1lbW9yeSBzbG90IGlzIGJlaW5nIG1vdmVkIG9yIHJlbW92ZWQKIAkgKiB1c2VycyBjYW4gZHJv
cCB3cml0ZS1wcm90ZWN0aW9uIGZvciB0aGUgcGFnZXMgaW4gdGhhdCBtZW1vcnkgc2xvdApkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9wYWdlX3RyYWNrLmMgYi9hcmNoL3g4Ni9rdm0vbW11
L3BhZ2VfdHJhY2suYwppbmRleCBlMGIxY2RkMzAxM2UuLmYxOGJlMTdiNTZhMyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYva3ZtL21tdS9wYWdlX3RyYWNrLmMKKysrIGIvYXJjaC94ODYva3ZtL21tdS9w
YWdlX3RyYWNrLmMKQEAgLTQzLDYgKzQzLDkgQEAgaW50IGt2bV9wYWdlX3RyYWNrX2NyZWF0ZV9t
ZW1zbG90KHN0cnVjdCBrdm0gKmt2bSwKIAkJCQkgIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKnNs
b3QsCiAJCQkJICB1bnNpZ25lZCBsb25nIG5wYWdlcykKIHsKKwlzdHJ1Y3Qga3ZtX3BhZ2VfdHJh
Y2tfbm90aWZpZXJfaGVhZCAqaGVhZDsKKwlzdHJ1Y3Qga3ZtX3BhZ2VfdHJhY2tfbm90aWZpZXJf
bm9kZSAqbjsKKwlpbnQgaWR4OwogCWludCBpOwogCiAJZm9yIChpID0gMDsgaSA8IEtWTV9QQUdF
X1RSQUNLX01BWDsgaSsrKSB7CkBAIC01Niw2ICs1OSwxOCBAQCBpbnQga3ZtX3BhZ2VfdHJhY2tf
Y3JlYXRlX21lbXNsb3Qoc3RydWN0IGt2bSAqa3ZtLAogCQkJZ290byB0cmFja19mcmVlOwogCX0K
IAorCWhlYWQgPSAma3ZtLT5hcmNoLnRyYWNrX25vdGlmaWVyX2hlYWQ7CisKKwlpZiAoaGxpc3Rf
ZW1wdHkoJmhlYWQtPnRyYWNrX25vdGlmaWVyX2xpc3QpKQorCQlyZXR1cm4gMDsKKworCWlkeCA9
IHNyY3VfcmVhZF9sb2NrKCZoZWFkLT50cmFja19zcmN1KTsKKwlobGlzdF9mb3JfZWFjaF9lbnRy
eV9zcmN1KG4sICZoZWFkLT50cmFja19ub3RpZmllcl9saXN0LCBub2RlLAorCQkJCXNyY3VfcmVh
ZF9sb2NrX2hlbGQoJmhlYWQtPnRyYWNrX3NyY3UpKQorCQlpZiAobi0+dHJhY2tfY3JlYXRlX3Ns
b3QpCisJCQluLT50cmFja19jcmVhdGVfc2xvdChrdm0sIHNsb3QsIG5wYWdlcywgbik7CisJc3Jj
dV9yZWFkX3VubG9jaygmaGVhZC0+dHJhY2tfc3JjdSwgaWR4KTsKKwogCXJldHVybiAwOwogCiB0
cmFja19mcmVlOgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
