Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F6C64E8A
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2035620B1F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2035620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6686586D6D;
	Wed, 25 Nov 2020 09:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gbw4Gw32Lqc3; Wed, 25 Nov 2020 09:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 12DBB86D86;
	Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1886C1DA0;
	Wed, 25 Nov 2020 09:41:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 610F8C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4EC13234AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBlvbbIDG672
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id 98905203F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:51 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 E19A5305D4FD; Wed, 25 Nov 2020 11:35:44 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id C141D3072784;
 Wed, 25 Nov 2020 11:35:44 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 12/81] KVM: svm: add support for descriptor-table VM-exits
Date: Wed, 25 Nov 2020 11:34:51 +0200
Message-Id: <20201125093600.2766-13-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGZvciB0aGUgS1ZNSV9WQ1BVX0VWRU5UX0RFU0NSSVBUT1IgZXZlbnQuCgpT
aWduZWQtb2ZmLWJ5OiBOaWN1yJlvciBDw67Im3UgPG5pY3UuY2l0dUBpY2xvdWQuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQog
YXJjaC94ODYva3ZtL3N2bS9zdm0uYyB8IDE1ICsrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDE1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5j
IGIvYXJjaC94ODYva3ZtL3N2bS9zdm0uYwppbmRleCBmM2VlNmJhZDBkYjUuLjAwYmRhNzk0NjA5
YyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3N2bS9zdm0uYworKysgYi9hcmNoL3g4Ni9rdm0v
c3ZtL3N2bS5jCkBAIC0yMzM1LDYgKzIzMzUsMTMgQEAgc3RhdGljIGludCByc21faW50ZXJjZXB0
aW9uKHN0cnVjdCB2Y3B1X3N2bSAqc3ZtKQogCXJldHVybiBrdm1fZW11bGF0ZV9pbnN0cnVjdGlv
bl9mcm9tX2J1ZmZlcigmc3ZtLT52Y3B1LCByc21faW5zX2J5dGVzLCAyKTsKIH0KIAorc3RhdGlj
IGludCBkZXNjcmlwdG9yX2FjY2Vzc19pbnRlcmNlcHRpb24oc3RydWN0IHZjcHVfc3ZtICpzdm0p
Cit7CisJc3RydWN0IGt2bV92Y3B1ICp2Y3B1ID0gJnN2bS0+dmNwdTsKKworCXJldHVybiBrdm1f
ZW11bGF0ZV9pbnN0cnVjdGlvbih2Y3B1LCAwKTsKK30KKwogc3RhdGljIGludCByZHBtY19pbnRl
cmNlcHRpb24oc3RydWN0IHZjcHVfc3ZtICpzdm0pCiB7CiAJaW50IGVycjsKQEAgLTI5NTksNiAr
Mjk2NiwxNCBAQCBzdGF0aWMgaW50ICgqY29uc3Qgc3ZtX2V4aXRfaGFuZGxlcnNbXSkoc3RydWN0
IHZjcHVfc3ZtICpzdm0pID0gewogCVtTVk1fRVhJVF9SU01dICAgICAgICAgICAgICAgICAgICAg
ICAgICA9IHJzbV9pbnRlcmNlcHRpb24sCiAJW1NWTV9FWElUX0FWSUNfSU5DT01QTEVURV9JUEld
CQk9IGF2aWNfaW5jb21wbGV0ZV9pcGlfaW50ZXJjZXB0aW9uLAogCVtTVk1fRVhJVF9BVklDX1VO
QUNDRUxFUkFURURfQUNDRVNTXQk9IGF2aWNfdW5hY2NlbGVyYXRlZF9hY2Nlc3NfaW50ZXJjZXB0
aW9uLAorCVtTVk1fRVhJVF9JRFRSX1JFQURdCQkJPSBkZXNjcmlwdG9yX2FjY2Vzc19pbnRlcmNl
cHRpb24sCisJW1NWTV9FWElUX0dEVFJfUkVBRF0JCQk9IGRlc2NyaXB0b3JfYWNjZXNzX2ludGVy
Y2VwdGlvbiwKKwlbU1ZNX0VYSVRfTERUUl9SRUFEXQkJCT0gZGVzY3JpcHRvcl9hY2Nlc3NfaW50
ZXJjZXB0aW9uLAorCVtTVk1fRVhJVF9UUl9SRUFEXQkJCT0gZGVzY3JpcHRvcl9hY2Nlc3NfaW50
ZXJjZXB0aW9uLAorCVtTVk1fRVhJVF9JRFRSX1dSSVRFXQkJCT0gZGVzY3JpcHRvcl9hY2Nlc3Nf
aW50ZXJjZXB0aW9uLAorCVtTVk1fRVhJVF9HRFRSX1dSSVRFXQkJCT0gZGVzY3JpcHRvcl9hY2Nl
c3NfaW50ZXJjZXB0aW9uLAorCVtTVk1fRVhJVF9MRFRSX1dSSVRFXQkJCT0gZGVzY3JpcHRvcl9h
Y2Nlc3NfaW50ZXJjZXB0aW9uLAorCVtTVk1fRVhJVF9UUl9XUklURV0JCQk9IGRlc2NyaXB0b3Jf
YWNjZXNzX2ludGVyY2VwdGlvbiwKIH07CiAKIHN0YXRpYyB2b2lkIGR1bXBfdm1jYihzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
