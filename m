Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877DC4167B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1642389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1642389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 83EFC87ACE;
	Mon,  7 Dec 2020 20:46:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v3acp8N87K8c; Mon,  7 Dec 2020 20:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05EE387943;
	Mon,  7 Dec 2020 20:46:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2046C1834;
	Mon,  7 Dec 2020 20:46:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39654C163C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2EE7F87899
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LwCifJrbNjUO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1564987895
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 7402F305D514; Mon,  7 Dec 2020 22:46:16 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 51D233072784;
 Mon,  7 Dec 2020 22:46:16 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 28/81] KVM: x86: page track: add track_create_slot()
 callback
Date: Mon,  7 Dec 2020 22:45:29 +0200
Message-Id: <20201207204622.15258-29-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyB1c2Vk
IHRvIGFkZCBwYWdlIGFjY2VzcyBub3RpZmljYXRpb25zIGFzIHNvb24gYXMgYSBzbG90IGFwcGVh
cnMKb3Igd2hlbiBhIHNsb3QgaXMgbW92ZWQuCgpTaWduZWQtb2ZmLWJ5OiBNaWhhaSBEb27Im3Ug
PG1kb250dUBiaXRkZWZlbmRlci5jb20+ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8
YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFn
ZV90cmFjay5oIHwgMTMgKysrKysrKysrKysrLQogYXJjaC94ODYva3ZtL21tdS9wYWdlX3RyYWNr
LmMgICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKystCiBhcmNoL3g4Ni9rdm0veDg2LmMgICAg
ICAgICAgICAgICAgICAgIHwgIDcgKysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2t2bV9wYWdlX3RyYWNrLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1fcGFnZV90cmFjay5o
CmluZGV4IDlhMjYxZTQ2M2ViMy4uMDBhNjZjNGQ0ZDNjIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9rdm1fcGFnZV90cmFjay5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2
bV9wYWdlX3RyYWNrLmgKQEAgLTM2LDYgKzM2LDE3IEBAIHN0cnVjdCBrdm1fcGFnZV90cmFja19u
b3RpZmllcl9ub2RlIHsKIAl2b2lkICgqdHJhY2tfd3JpdGUpKHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwgZ3BhX3QgZ3BhLCBndmFfdCBndmEsCiAJCQkgICAgY29uc3QgdTggKm5ldywgaW50IGJ5dGVz
LAogCQkJICAgIHN0cnVjdCBrdm1fcGFnZV90cmFja19ub3RpZmllcl9ub2RlICpub2RlKTsKKwkv
KgorCSAqIEl0IGlzIGNhbGxlZCB3aGVuIG1lbW9yeSBzbG90IGlzIGJlaW5nIGNyZWF0ZWQKKwkg
KgorCSAqIEBrdm06IHRoZSBrdm0gd2hlcmUgbWVtb3J5IHNsb3QgYmVpbmcgbW92ZWQgb3IgcmVt
b3ZlZAorCSAqIEBzbG90OiB0aGUgbWVtb3J5IHNsb3QgYmVpbmcgbW92ZWQgb3IgcmVtb3ZlZAor
CSAqIEBucGFnZXM6IHRoZSBudW1iZXIgb2YgcGFnZXMKKwkgKiBAbm9kZTogdGhpcyBub2RlCisJ
ICovCisJdm9pZCAoKnRyYWNrX2NyZWF0ZV9zbG90KShzdHJ1Y3Qga3ZtICprdm0sIHN0cnVjdCBr
dm1fbWVtb3J5X3Nsb3QgKnNsb3QsCisJCQkJICB1bnNpZ25lZCBsb25nIG5wYWdlcywKKwkJCQkg
IHN0cnVjdCBrdm1fcGFnZV90cmFja19ub3RpZmllcl9ub2RlICpub2RlKTsKIAkvKgogCSAqIEl0
IGlzIGNhbGxlZCB3aGVuIG1lbW9yeSBzbG90IGlzIGJlaW5nIG1vdmVkIG9yIHJlbW92ZWQKIAkg
KiB1c2VycyBjYW4gZHJvcCB3cml0ZS1wcm90ZWN0aW9uIGZvciB0aGUgcGFnZXMgaW4gdGhhdCBt
ZW1vcnkgc2xvdApAQCAtNTIsNyArNjMsNyBAQCB2b2lkIGt2bV9wYWdlX3RyYWNrX2luaXQoc3Ry
dWN0IGt2bSAqa3ZtKTsKIHZvaWQga3ZtX3BhZ2VfdHJhY2tfY2xlYW51cChzdHJ1Y3Qga3ZtICpr
dm0pOwogCiB2b2lkIGt2bV9wYWdlX3RyYWNrX2ZyZWVfbWVtc2xvdChzdHJ1Y3Qga3ZtX21lbW9y
eV9zbG90ICpzbG90KTsKLWludCBrdm1fcGFnZV90cmFja19jcmVhdGVfbWVtc2xvdChzdHJ1Y3Qg
a3ZtX21lbW9yeV9zbG90ICpzbG90LAoraW50IGt2bV9wYWdlX3RyYWNrX2NyZWF0ZV9tZW1zbG90
KHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwKIAkJCQkgIHVu
c2lnbmVkIGxvbmcgbnBhZ2VzKTsKIAogdm9pZCBrdm1fc2xvdF9wYWdlX3RyYWNrX2FkZF9wYWdl
KHN0cnVjdCBrdm0gKmt2bSwKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUvcGFnZV90cmFj
ay5jIGIvYXJjaC94ODYva3ZtL21tdS9wYWdlX3RyYWNrLmMKaW5kZXggZDdhNTkxYTg1YWY4Li4y
N2E4ZDFhMDJlODQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS9tbXUvcGFnZV90cmFjay5jCisr
KyBiL2FyY2gveDg2L2t2bS9tbXUvcGFnZV90cmFjay5jCkBAIC0yOCw5ICsyOCwxMiBAQCB2b2lk
IGt2bV9wYWdlX3RyYWNrX2ZyZWVfbWVtc2xvdChzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICpzbG90
KQogCX0KIH0KIAotaW50IGt2bV9wYWdlX3RyYWNrX2NyZWF0ZV9tZW1zbG90KHN0cnVjdCBrdm1f
bWVtb3J5X3Nsb3QgKnNsb3QsCitpbnQga3ZtX3BhZ2VfdHJhY2tfY3JlYXRlX21lbXNsb3Qoc3Ry
dWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICpzbG90LAogCQkJCSAgdW5zaWdu
ZWQgbG9uZyBucGFnZXMpCiB7CisJc3RydWN0IGt2bV9wYWdlX3RyYWNrX25vdGlmaWVyX2hlYWQg
KmhlYWQ7CisJc3RydWN0IGt2bV9wYWdlX3RyYWNrX25vdGlmaWVyX25vZGUgKm47CisJaW50IGlk
eDsKIAlpbnQgIGk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgS1ZNX1BBR0VfVFJBQ0tfTUFYOyBpKysp
IHsKQEAgLTQxLDYgKzQ0LDE4IEBAIGludCBrdm1fcGFnZV90cmFja19jcmVhdGVfbWVtc2xvdChz
dHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICpzbG90LAogCQkJZ290byB0cmFja19mcmVlOwogCX0KIAor
CWhlYWQgPSAma3ZtLT5hcmNoLnRyYWNrX25vdGlmaWVyX2hlYWQ7CisKKwlpZiAoaGxpc3RfZW1w
dHkoJmhlYWQtPnRyYWNrX25vdGlmaWVyX2xpc3QpKQorCQlyZXR1cm4gMDsKKworCWlkeCA9IHNy
Y3VfcmVhZF9sb2NrKCZoZWFkLT50cmFja19zcmN1KTsKKwlobGlzdF9mb3JfZWFjaF9lbnRyeV9z
cmN1KG4sICZoZWFkLT50cmFja19ub3RpZmllcl9saXN0LCBub2RlLAorCQkJCXNyY3VfcmVhZF9s
b2NrX2hlbGQoJmhlYWQtPnRyYWNrX3NyY3UpKQorCQlpZiAobi0+dHJhY2tfY3JlYXRlX3Nsb3Qp
CisJCQluLT50cmFja19jcmVhdGVfc2xvdChrdm0sIHNsb3QsIG5wYWdlcywgbik7CisJc3JjdV9y
ZWFkX3VubG9jaygmaGVhZC0+dHJhY2tfc3JjdSwgaWR4KTsKKwogCXJldHVybiAwOwogCiB0cmFj
a19mcmVlOgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4
Ni5jCmluZGV4IGMyZjEzYTI3NTQ0OC4uNGQxOWRhMDE2YzEyIDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jCkBAIC0xMDUyNCw3ICsxMDUyNCw4
IEBAIHZvaWQga3ZtX2FyY2hfZnJlZV9tZW1zbG90KHN0cnVjdCBrdm0gKmt2bSwgc3RydWN0IGt2
bV9tZW1vcnlfc2xvdCAqc2xvdCkKIAlrdm1fcGFnZV90cmFja19mcmVlX21lbXNsb3Qoc2xvdCk7
CiB9CiAKLXN0YXRpYyBpbnQga3ZtX2FsbG9jX21lbXNsb3RfbWV0YWRhdGEoc3RydWN0IGt2bV9t
ZW1vcnlfc2xvdCAqc2xvdCwKK3N0YXRpYyBpbnQga3ZtX2FsbG9jX21lbXNsb3RfbWV0YWRhdGEo
c3RydWN0IGt2bSAqa3ZtLAorCQkJCSAgICAgIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKnNsb3Qs
CiAJCQkJICAgICAgdW5zaWduZWQgbG9uZyBucGFnZXMpCiB7CiAJaW50IGk7CkBAIC0xMDU3Niw3
ICsxMDU3Nyw3IEBAIHN0YXRpYyBpbnQga3ZtX2FsbG9jX21lbXNsb3RfbWV0YWRhdGEoc3RydWN0
IGt2bV9tZW1vcnlfc2xvdCAqc2xvdCwKIAkJfQogCX0KIAotCWlmIChrdm1fcGFnZV90cmFja19j
cmVhdGVfbWVtc2xvdChzbG90LCBucGFnZXMpKQorCWlmIChrdm1fcGFnZV90cmFja19jcmVhdGVf
bWVtc2xvdChrdm0sIHNsb3QsIG5wYWdlcykpCiAJCWdvdG8gb3V0X2ZyZWU7CiAKIAlyZXR1cm4g
MDsKQEAgLTEwNjE2LDcgKzEwNjE3LDcgQEAgaW50IGt2bV9hcmNoX3ByZXBhcmVfbWVtb3J5X3Jl
Z2lvbihzdHJ1Y3Qga3ZtICprdm0sCiAJCQkJZW51bSBrdm1fbXJfY2hhbmdlIGNoYW5nZSkKIHsK
IAlpZiAoY2hhbmdlID09IEtWTV9NUl9DUkVBVEUgfHwgY2hhbmdlID09IEtWTV9NUl9NT1ZFKQot
CQlyZXR1cm4ga3ZtX2FsbG9jX21lbXNsb3RfbWV0YWRhdGEobWVtc2xvdCwKKwkJcmV0dXJuIGt2
bV9hbGxvY19tZW1zbG90X21ldGFkYXRhKGt2bSwgbWVtc2xvdCwKIAkJCQkJCSAgbWVtLT5tZW1v
cnlfc2l6ZSA+PiBQQUdFX1NISUZUKTsKIAlyZXR1cm4gMDsKIH0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
