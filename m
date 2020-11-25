Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C1EC71155
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E336120BED
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E336120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE56386A6F;
	Wed, 25 Nov 2020 09:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O92AQnNx_s1A; Wed, 25 Nov 2020 09:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C92DA869F8;
	Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2D31C1DA0;
	Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0094AC1DA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D9FDA86D6D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjByOEi-b7q2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C413686D65
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:53 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 5F8FC30462CD; Wed, 25 Nov 2020 11:35:43 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 43FF93072785;
 Wed, 25 Nov 2020 11:35:43 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 01/81] KVM: UAPI: add error codes used by the VM
 introspection code
Date: Wed, 25 Nov 2020 11:34:40 +0200
Message-Id: <20201125093600.2766-2-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
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

VGhlc2UgbmV3IGVycm9yIGNvZGVzIGhlbHAgdGhlIGludHJvc3BlY3Rpb24gdG9vbCB0byBpZGVu
dGlmeSB0aGUgY2F1c2UKb2YgdGhlIGludHJvc3BlY3Rpb24gY29tbWFuZCBmYWlsdXJlIGFuZCB0
byByZWNvdmVyIGZyb20gc29tZSBlcnJvcgpjYXNlcyBvciB0byBnaXZlIG1vcmUgaW5mb3JtYXRp
b24gdG8gdGhlIHVzZXIuCgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBi
aXRkZWZlbmRlci5jb20+Ci0tLQogaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmggfCA0ICsr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgva3ZtX3BhcmEuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9rdm1fcGFyYS5oCmlu
ZGV4IDhiODY2MDk4NDliOS4uM2NlMzg4MjQ5NjgyIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkv
bGludXgva3ZtX3BhcmEuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgva3ZtX3BhcmEuaApAQCAt
MTcsNiArMTcsMTAgQEAKICNkZWZpbmUgS1ZNX0UyQklHCQlFMkJJRwogI2RlZmluZSBLVk1fRVBF
Uk0JCUVQRVJNCiAjZGVmaW5lIEtWTV9FT1BOT1RTVVBQCQk5NQorI2RlZmluZSBLVk1fRUFHQUlO
CQkxMQorI2RlZmluZSBLVk1fRU5PRU5UCQlFTk9FTlQKKyNkZWZpbmUgS1ZNX0VOT01FTQkJRU5P
TUVNCisjZGVmaW5lIEtWTV9FQlVTWQkJRUJVU1kKIAogI2RlZmluZSBLVk1fSENfVkFQSUNfUE9M
TF9JUlEJCTEKICNkZWZpbmUgS1ZNX0hDX01NVV9PUAkJCTIKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
