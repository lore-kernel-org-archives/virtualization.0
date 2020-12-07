Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D48C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:56:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A586238E3
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A586238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B03D870DC;
	Mon,  7 Dec 2020 20:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6r5FrECpyE5; Mon,  7 Dec 2020 20:56:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5412B8710C;
	Mon,  7 Dec 2020 20:56:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB7AC1834;
	Mon,  7 Dec 2020 20:56:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 530DDC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4F49587A67
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p5owlGxbwoD8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EAA9887A69
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:56:53 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 CD9AF305D472; Mon,  7 Dec 2020 22:46:20 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id AB5133072785;
 Mon,  7 Dec 2020 22:46:20 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 51/81] KVM: introspection: add the crash action handling
 on the event reply
Date: Mon,  7 Dec 2020 22:45:52 +0200
Message-Id: <20201207204622.15258-52-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBhY3Rpb24g
aXMgdXNlZCBpbiBleHRyZW1lIGNhc2VzIHN1Y2ggYXMgYmxvY2tpbmcgdGhlIHNwcmVhZCBvZgpt
YWx3YXJlIGFzIGZhc3QgYXMgcG9zc2libGUuCgpTaWduZWQtb2ZmLWJ5OiBNaWhhaSBEb27Im3Ug
PG1kb250dUBiaXRkZWZlbmRlci5jb20+ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8
YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiB2aXJ0L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWku
YyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaS5jIGIvdmlydC9rdm0vaW50cm9zcGVjdGlvbi9r
dm1pLmMKaW5kZXggZGVkNzkxZTk3ZGUxLi42OTlkMGRiMDk1MzcgMTAwNjQ0Ci0tLSBhL3ZpcnQv
a3ZtL2ludHJvc3BlY3Rpb24va3ZtaS5jCisrKyBiL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3Zt
aS5jCkBAIC03NTIsNiArNzUyLDEwIEBAIHZvaWQga3ZtaV9oYW5kbGVfY29tbW9uX2V2ZW50X2Fj
dGlvbnMoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1MzIgYWN0aW9uKQogCXN0cnVjdCBrdm0gKmt2
bSA9IHZjcHUtPmt2bTsKIAogCXN3aXRjaCAoYWN0aW9uKSB7CisJY2FzZSBLVk1JX0VWRU5UX0FD
VElPTl9DUkFTSDoKKwkJdmNwdS0+cnVuLT5leGl0X3JlYXNvbiA9IEtWTV9FWElUX1NIVVRET1dO
OworCQlicmVhazsKKwogCWRlZmF1bHQ6CiAJCWt2bWlfaGFuZGxlX3Vuc3VwcG9ydGVkX2V2ZW50
X2FjdGlvbihrdm0pOwogCX0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
