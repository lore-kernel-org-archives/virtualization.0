Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFE4C64E7C
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA45721527
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA45721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 794AF8744C;
	Wed, 25 Nov 2020 09:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDu0-crjf6Qk; Wed, 25 Nov 2020 09:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FC9287467;
	Wed, 25 Nov 2020 09:42:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B63C1DA0;
	Wed, 25 Nov 2020 09:42:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24F39C163C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14E2E869EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3l7ZixrcVLe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EAB97869BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:55 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 9CEF0305D50A; Wed, 25 Nov 2020 11:35:46 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 7D9813072784;
 Wed, 25 Nov 2020 11:35:46 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 24/81] KVM: x86: export kvm_inject_pending_exception()
Date: Wed, 25 Nov 2020 11:35:03 +0200
Message-Id: <20201125093600.2766-25-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX0lOSkVDVF9FWENFUFRJT04gY29tbWFuZC4K
ClNpZ25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0t
CiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIHwgIDEgKwogYXJjaC94ODYva3ZtL3g4
Ni5jICAgICAgICAgICAgICB8IDUyICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQog
MiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20va3ZtX2hvc3QuaAppbmRleCAzYTA2YTc3OTk1NzEuLjdkYzFlYmFjOGQ5MSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9rdm1faG9zdC5oCkBAIC0xNTE0LDYgKzE1MTQsNyBAQCB1bnNpZ25lZCBsb25nIGt2
bV9nZXRfcmZsYWdzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2bV9zZXRfcmZsYWdz
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdW5zaWduZWQgbG9uZyByZmxhZ3MpOwogYm9vbCBrdm1f
cmRwbWMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIAorYm9vbCBrdm1faW5qZWN0X3BlbmRpbmdf
ZXhjZXB0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2bV9xdWV1ZV9leGNlcHRp
b24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBucik7CiB2b2lkIGt2bV9xdWV1ZV9l
eGNlcHRpb25fZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHVuc2lnbmVkIG5yLCB1MzIgZXJyb3Jf
Y29kZSk7CiB2b2lkIGt2bV9xdWV1ZV9leGNlcHRpb25fcChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHVuc2lnbmVkIG5yLCB1bnNpZ25lZCBsb25nIHBheWxvYWQpOwpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jCmluZGV4IDhlZGE1YzNiZDI0NC4uNzQx
NTA1ZjQwNWIxIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMKKysrIGIvYXJjaC94ODYv
a3ZtL3g4Ni5jCkBAIC04MjAwLDYgKzgyMDAsMzUgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2NyOF9p
bnRlcmNlcHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogCWt2bV94ODZfb3BzLnVwZGF0ZV9jcjhf
aW50ZXJjZXB0KHZjcHUsIHRwciwgbWF4X2lycik7CiB9CiAKK2Jvb2wga3ZtX2luamVjdF9wZW5k
aW5nX2V4Y2VwdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKHZjcHUtPmFyY2gu
ZXhjZXB0aW9uLnBlbmRpbmcpIHsKKwkJdHJhY2Vfa3ZtX2lual9leGNlcHRpb24odmNwdS0+YXJj
aC5leGNlcHRpb24ubnIsCisJCQkJCXZjcHUtPmFyY2guZXhjZXB0aW9uLmhhc19lcnJvcl9jb2Rl
LAorCQkJCQl2Y3B1LT5hcmNoLmV4Y2VwdGlvbi5lcnJvcl9jb2RlKTsKKworCQl2Y3B1LT5hcmNo
LmV4Y2VwdGlvbi5wZW5kaW5nID0gZmFsc2U7CisJCXZjcHUtPmFyY2guZXhjZXB0aW9uLmluamVj
dGVkID0gdHJ1ZTsKKworCQlpZiAoZXhjZXB0aW9uX3R5cGUodmNwdS0+YXJjaC5leGNlcHRpb24u
bnIpID09IEVYQ1BUX0ZBVUxUKQorCQkJX19rdm1fc2V0X3JmbGFncyh2Y3B1LCBrdm1fZ2V0X3Jm
bGFncyh2Y3B1KSB8CisJCQkJCSAgICAgWDg2X0VGTEFHU19SRik7CisKKwkJaWYgKHZjcHUtPmFy
Y2guZXhjZXB0aW9uLm5yID09IERCX1ZFQ1RPUikgeworCQkJa3ZtX2RlbGl2ZXJfZXhjZXB0aW9u
X3BheWxvYWQodmNwdSk7CisJCQlpZiAodmNwdS0+YXJjaC5kcjcgJiBEUjdfR0QpIHsKKwkJCQl2
Y3B1LT5hcmNoLmRyNyAmPSB+RFI3X0dEOworCQkJCWt2bV91cGRhdGVfZHI3KHZjcHUpOworCQkJ
fQorCQl9CisKKwkJa3ZtX3g4Nl9vcHMucXVldWVfZXhjZXB0aW9uKHZjcHUpOworCQlyZXR1cm4g
dHJ1ZTsKKwl9CisKKwlyZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyB2b2lkIGluamVjdF9wZW5k
aW5nX2V2ZW50KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCAqcmVxX2ltbWVkaWF0ZV9leGl0
KQogewogCWludCByOwpAQCAtODI1MSwyOSArODI4MCw4IEBAIHN0YXRpYyB2b2lkIGluamVjdF9w
ZW5kaW5nX2V2ZW50KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgYm9vbCAqcmVxX2ltbWVkaWF0ZV9l
eGl0CiAJfQogCiAJLyogdHJ5IHRvIGluamVjdCBuZXcgZXZlbnQgaWYgcGVuZGluZyAqLwotCWlm
ICh2Y3B1LT5hcmNoLmV4Y2VwdGlvbi5wZW5kaW5nKSB7Ci0JCXRyYWNlX2t2bV9pbmpfZXhjZXB0
aW9uKHZjcHUtPmFyY2guZXhjZXB0aW9uLm5yLAotCQkJCQl2Y3B1LT5hcmNoLmV4Y2VwdGlvbi5o
YXNfZXJyb3JfY29kZSwKLQkJCQkJdmNwdS0+YXJjaC5leGNlcHRpb24uZXJyb3JfY29kZSk7Ci0K
LQkJdmNwdS0+YXJjaC5leGNlcHRpb24ucGVuZGluZyA9IGZhbHNlOwotCQl2Y3B1LT5hcmNoLmV4
Y2VwdGlvbi5pbmplY3RlZCA9IHRydWU7Ci0KLQkJaWYgKGV4Y2VwdGlvbl90eXBlKHZjcHUtPmFy
Y2guZXhjZXB0aW9uLm5yKSA9PSBFWENQVF9GQVVMVCkKLQkJCV9fa3ZtX3NldF9yZmxhZ3ModmNw
dSwga3ZtX2dldF9yZmxhZ3ModmNwdSkgfAotCQkJCQkgICAgIFg4Nl9FRkxBR1NfUkYpOwotCi0J
CWlmICh2Y3B1LT5hcmNoLmV4Y2VwdGlvbi5uciA9PSBEQl9WRUNUT1IpIHsKLQkJCWt2bV9kZWxp
dmVyX2V4Y2VwdGlvbl9wYXlsb2FkKHZjcHUpOwotCQkJaWYgKHZjcHUtPmFyY2guZHI3ICYgRFI3
X0dEKSB7Ci0JCQkJdmNwdS0+YXJjaC5kcjcgJj0gfkRSN19HRDsKLQkJCQlrdm1fdXBkYXRlX2Ry
Nyh2Y3B1KTsKLQkJCX0KLQkJfQotCi0JCWt2bV94ODZfb3BzLnF1ZXVlX2V4Y2VwdGlvbih2Y3B1
KTsKKwlpZiAoa3ZtX2luamVjdF9wZW5kaW5nX2V4Y2VwdGlvbih2Y3B1KSkKIAkJY2FuX2luamVj
dCA9IGZhbHNlOwotCX0KIAogCS8qCiAJICogRmluYWxseSwgaW5qZWN0IGludGVycnVwdCBldmVu
dHMuICBJZiBhbiBldmVudCBjYW5ub3QgYmUgaW5qZWN0ZWQKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
