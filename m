Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4701C4167B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B57D238E3
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B57D238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 502DC872F2;
	Mon,  7 Dec 2020 20:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnhjd-67rsuh; Mon,  7 Dec 2020 20:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 71B1F872A0;
	Mon,  7 Dec 2020 20:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58E23C163C;
	Mon,  7 Dec 2020 20:56:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AE49C1DA6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 543E1872A0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eOiU2XGybLfj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 99D8387245
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 8269E305D48C; Mon,  7 Dec 2020 22:46:26 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 6419D3072785;
 Mon,  7 Dec 2020 22:46:26 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 81/81] KVM: x86: call the page tracking code on emulation
 failure
Date: Mon,  7 Dec 2020 22:46:22 +0200
Message-Id: <20201207204622.15258-82-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhlIGluZm9ybWF0
aW9uIHdlIGNhbiBwcm92aWRlIHRoaXMgd2F5IGlzIGluY29tcGxldGUsIGJ1dCBjdXJyZW50IHVz
ZXJzCm9mIHRoZSBwYWdlIHRyYWNraW5nIGNvZGUgY2FuIHdvcmsgd2l0aCBpdC4KClNpZ25lZC1v
ZmYtYnk6IE1paGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1i
eTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2
L2t2bS94ODYuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IGQzZjE0NWY5ZTE5Ni4u
ODRlM2NhYTQ1ZGQ5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94
ODYva3ZtL3g4Ni5jCkBAIC03MzI1LDYgKzczMjUsNTEgQEAgc3RhdGljIGJvb2wgaXNfdm13YXJl
X2JhY2tkb29yX29wY29kZShzdHJ1Y3QgeDg2X2VtdWxhdGVfY3R4dCAqY3R4dCkKIAlyZXR1cm4g
ZmFsc2U7CiB9CiAKKy8qCisgKiBXaXRoIGludHJvc3BlY3Rpb24gZW5hYmxlZCwgZW11bGF0aW9u
IGZhaWx1cmVzIHRyYW5zbGF0ZSBpbiBldmVudHMgYmVpbmcKKyAqIG1pc3NlZCBiZWNhdXNlIHRo
ZSByZWFkL3dyaXRlIGNhbGxiYWNrcyBhcmUgbm90IGludm9rZWQuIEFsbCB3ZSBoYXZlIGlzCisg
KiB0aGUgZmV0Y2ggZXZlbnQgKGt2bV9wYWdlX3RyYWNrX3ByZWV4ZWMpLiBCZWxvdyB3ZSB1c2Ug
dGhlIEVQVC9OUFQgVk1FWElUCisgKiBpbmZvcm1hdGlvbiB0byBnZW5lcmF0ZSB0aGUgZXZlbnRz
LCBidXQgd2l0aG91dCBwcm92aWRpbmcgYWNjdXJhdGUKKyAqIGRhdGEgYW5kIHNpemUgKHRoZSBl
bXVsYXRvciB3b3VsZCBoYXZlIGNvbXB1dGVkIHRob3NlKS4gSWYgYW4gaW5zdHJ1Y3Rpb24KKyAq
IHdvdWxkIGhhcHBlbiB0byByZWFkIGFuZCB3cml0ZSBpbiB0aGUgc2FtZSBwYWdlLCB0aGUgc2Vj
b25kIGV2ZW50IHdpbGwKKyAqIGluaXRpYWxseSBiZSBtaXNzZWQgYW5kIHdlIHJlbHkgb24gdGhl
IHBhZ2UgdHJhY2tpbmcgbWVjaGFuaXNtIHRvIGJyaW5nCisgKiB1cyBiYWNrIGhlcmUgdG8gc2Vu
ZCBpdC4KKyAqLworc3RhdGljIGJvb2wga3ZtX3BhZ2VfdHJhY2tfZW11bGF0aW9uX2ZhaWx1cmUo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBncGEpCit7CisJdTY0IGVycm9yX2NvZGUgPSB2
Y3B1LT5hcmNoLmVycm9yX2NvZGU7CisJdTggZGF0YSA9IDA7CisJZ3ZhX3QgZ3ZhOworCWJvb2wg
cmV0OworCisJLyogTU1JTyBlbXVsYXRpb24gZmFpbHVyZXMgc2hvdWxkIGJlIHRyZWF0ZWQgdGhl
IG5vcm1hbCB3YXkgKi8KKwlpZiAodW5saWtlbHkoZXJyb3JfY29kZSAmIFBGRVJSX1JTVkRfTUFT
SykpCisJCXJldHVybiB0cnVlOworCisJLyogRVBUL05UUCBtdXN0IGJlIGVuYWJsZWQgKi8KKwlp
ZiAodW5saWtlbHkoIXZjcHUtPmFyY2gubW11LT5kaXJlY3RfbWFwKSkKKwkJcmV0dXJuIHRydWU7
CisKKwkvKgorCSAqIFRoZSBBL0QgYml0IGVtdWxhdGlvbiBzaG91bGQgbWFrZSB0aGlzIHRlc3Qg
dW5uZWVkZWQsIGJ1dCBqdXN0CisJICogaW4gY2FzZQorCSAqLworCWlmICh1bmxpa2VseSgoZXJy
b3JfY29kZSAmIFBGRVJSX05FU1RFRF9HVUVTVF9QQUdFKSA9PQorCQkgICAgIFBGRVJSX05FU1RF
RF9HVUVTVF9QQUdFKSkKKwkJcmV0dXJuIHRydWU7CisKKwlndmEgPSBrdm1feDg2X29wcy5mYXVs
dF9nbGEodmNwdSk7CisKKwlpZiAoZXJyb3JfY29kZSAmIFBGRVJSX1dSSVRFX01BU0spCisJCXJl
dCA9IGt2bV9wYWdlX3RyYWNrX3ByZXdyaXRlKHZjcHUsIGdwYSwgZ3ZhLCAmZGF0YSwgMCk7CisJ
ZWxzZSBpZiAoZXJyb3JfY29kZSAmIFBGRVJSX1VTRVJfTUFTSykKKwkJcmV0ID0ga3ZtX3BhZ2Vf
dHJhY2tfcHJlcmVhZCh2Y3B1LCBncGEsIGd2YSwgMCk7CisJZWxzZQorCQlyZXQgPSB0cnVlOwor
CisJcmV0dXJuIHJldDsKK30KKwogaW50IHg4Nl9lbXVsYXRlX2luc3RydWN0aW9uKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgZ3BhX3QgY3IyX29yX2dwYSwKIAkJCSAgICBpbnQgZW11bGF0aW9uX3R5
cGUsIHZvaWQgKmluc24sIGludCBpbnNuX2xlbikKIHsKQEAgLTczNzgsNiArNzQyMyw4IEBAIGlu
dCB4ODZfZW11bGF0ZV9pbnN0cnVjdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGNy
Ml9vcl9ncGEsCiAJCQkJa3ZtX3F1ZXVlX2V4Y2VwdGlvbih2Y3B1LCBVRF9WRUNUT1IpOwogCQkJ
CXJldHVybiAxOwogCQkJfQorCQkJaWYgKCFrdm1fcGFnZV90cmFja19lbXVsYXRpb25fZmFpbHVy
ZSh2Y3B1LCBjcjJfb3JfZ3BhKSkKKwkJCQlyZXR1cm4gMTsKIAkJCWlmIChyZWV4ZWN1dGVfaW5z
dHJ1Y3Rpb24odmNwdSwgY3IyX29yX2dwYSwKIAkJCQkJCSAgd3JpdGVfZmF1bHRfdG9fc3B0LAog
CQkJCQkJICBlbXVsYXRpb25fdHlwZSkpCkBAIC03NDQ3LDYgKzc0OTQsOCBAQCBpbnQgeDg2X2Vt
dWxhdGVfaW5zdHJ1Y3Rpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBjcjJfb3JfZ3Bh
LAogCQlyZXR1cm4gMTsKIAogCWlmIChyID09IEVNVUxBVElPTl9GQUlMRUQpIHsKKwkJaWYgKCFr
dm1fcGFnZV90cmFja19lbXVsYXRpb25fZmFpbHVyZSh2Y3B1LCBjcjJfb3JfZ3BhKSkKKwkJCXJl
dHVybiAxOwogCQlpZiAocmVleGVjdXRlX2luc3RydWN0aW9uKHZjcHUsIGNyMl9vcl9ncGEsIHdy
aXRlX2ZhdWx0X3RvX3NwdCwKIAkJCQkJZW11bGF0aW9uX3R5cGUpKQogCQkJcmV0dXJuIDE7Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
