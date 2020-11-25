Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31290C5519F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F52206B5
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F52206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 00EFD86AE0;
	Wed, 25 Nov 2020 09:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hTSYP0giEBBH; Wed, 25 Nov 2020 09:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FAAF86B0E;
	Wed, 25 Nov 2020 09:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BBCEC1D9F;
	Wed, 25 Nov 2020 09:52:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F081C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2DA0986ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ryRVy8wrxt58
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D115D86A99
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:56 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 BC901305D504; Wed, 25 Nov 2020 11:35:45 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 9DE753072784;
 Wed, 25 Nov 2020 11:35:45 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 18/81] KVM: x86: vmx: use a symbolic constant when
 checking the exit qualifications
Date: Wed, 25 Nov 2020 11:34:57 +0200
Message-Id: <20201125093600.2766-19-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBzaG91bGQg
bWFrZSB0aGUgY29kZSBtb3JlIHJlYWRhYmxlLgoKU2lnbmVkLW9mZi1ieTogTWloYWkgRG9uyJt1
IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgpTaWduZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3Ig
PGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQogYXJjaC94ODYva3ZtL3ZteC92bXguYyB8IDQg
KystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXgu
YwppbmRleCBjMTQ5N2I4ZTUwNmMuLmE3ZDJiYWIzODIzMyAxMDA2NDQKLS0tIGEvYXJjaC94ODYv
a3ZtL3ZteC92bXguYworKysgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCkBAIC01Mzg2LDggKzUz
ODYsOCBAQCBzdGF0aWMgaW50IGhhbmRsZV9lcHRfdmlvbGF0aW9uKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkKIAkJCUVQVF9WSU9MQVRJT05fRVhFQ1VUQUJMRSkpCiAJCSAgICAgID8gUEZFUlJfUFJF
U0VOVF9NQVNLIDogMDsKIAotCWVycm9yX2NvZGUgfD0gKGV4aXRfcXVhbGlmaWNhdGlvbiAmIDB4
MTAwKSAhPSAwID8KLQkgICAgICAgUEZFUlJfR1VFU1RfRklOQUxfTUFTSyA6IFBGRVJSX0dVRVNU
X1BBR0VfTUFTSzsKKwllcnJvcl9jb2RlIHw9IChleGl0X3F1YWxpZmljYXRpb24gJiBFUFRfVklP
TEFUSU9OX0dWQV9UUkFOU0xBVEVEKQorCQkgICAgICA/IFBGRVJSX0dVRVNUX0ZJTkFMX01BU0sg
OiBQRkVSUl9HVUVTVF9QQUdFX01BU0s7CiAKIAl2Y3B1LT5hcmNoLmV4aXRfcXVhbGlmaWNhdGlv
biA9IGV4aXRfcXVhbGlmaWNhdGlvbjsKIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
