Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A77C4167B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B482389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B482389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08D2D870BB;
	Mon,  7 Dec 2020 20:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhBUukvjdZAb; Mon,  7 Dec 2020 20:46:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF88587126;
	Mon,  7 Dec 2020 20:46:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C851BC163C;
	Mon,  7 Dec 2020 20:46:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 780E1C013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 705452E284
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NjmZL0wvJ6n2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id 0A25F2E288
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 1D790305D512; Mon,  7 Dec 2020 22:46:16 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id F284E3072784;
 Mon,  7 Dec 2020 22:46:15 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 26/81] KVM: x86: export kvm_vcpu_ioctl_x86_set_xsave()
Date: Mon,  7 Dec 2020 22:45:27 +0200
Message-Id: <20201207204622.15258-27-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
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

VGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBLVk1JX1ZDUFVfU0VUX1hTQVZFIGNvbW1h
bmQuCgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5j
b20+Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB8IDIgKysKIGFyY2gveDg2
L2t2bS94ODYuYyAgICAgICAgICAgICAgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IGVj
MGUyYTc3NjRhZC4uNjViY2U4YWVlZGU1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTE1
MTYsNiArMTUxNiw4IEBAIGJvb2wga3ZtX3JkcG1jKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiAK
IHZvaWQga3ZtX3ZjcHVfaW9jdGxfeDg2X2dldF94c2F2ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
CiAJCQkJICBzdHJ1Y3Qga3ZtX3hzYXZlICpndWVzdF94c2F2ZSk7CitpbnQga3ZtX3ZjcHVfaW9j
dGxfeDg2X3NldF94c2F2ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCisJCQkJIHN0cnVjdCBrdm1f
eHNhdmUgKmd1ZXN0X3hzYXZlKTsKIAogYm9vbCBrdm1faW5qZWN0X3BlbmRpbmdfZXhjZXB0aW9u
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiB2b2lkIGt2bV9xdWV1ZV9leGNlcHRpb24oc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCB1bnNpZ25lZCBucik7CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0v
eDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggNGZhZGQxYWIyMGFlLi5mNDg2MDNjOGU0
NGQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9hcmNoL3g4Ni9rdm0veDg2
LmMKQEAgLTQ1MTQsOCArNDUxNCw4IEBAIHZvaWQga3ZtX3ZjcHVfaW9jdGxfeDg2X2dldF94c2F2
ZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAKICNkZWZpbmUgWFNBVkVfTVhDU1JfT0ZGU0VUIDI0
CiAKLXN0YXRpYyBpbnQga3ZtX3ZjcHVfaW9jdGxfeDg2X3NldF94c2F2ZShzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsCi0JCQkJCXN0cnVjdCBrdm1feHNhdmUgKmd1ZXN0X3hzYXZlKQoraW50IGt2bV92
Y3B1X2lvY3RsX3g4Nl9zZXRfeHNhdmUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LAorCQkJCSBzdHJ1
Y3Qga3ZtX3hzYXZlICpndWVzdF94c2F2ZSkKIHsKIAl1NjQgeHN0YXRlX2J2ID0KIAkJKih1NjQg
KikmZ3Vlc3RfeHNhdmUtPnJlZ2lvbltYU0FWRV9IRFJfT0ZGU0VUIC8gc2l6ZW9mKHUzMildOwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
