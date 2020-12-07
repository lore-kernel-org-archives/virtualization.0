Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC9DC1B0D9
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C112389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C112389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9316B878F2;
	Mon,  7 Dec 2020 20:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PFiBfVpXf4Ui; Mon,  7 Dec 2020 20:46:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8727387912;
	Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 713E4C163C;
	Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8286FC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D93D2E2B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEgP-0XQpFBV
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by silver.osuosl.org (Postfix) with ESMTPS id C6A802E287
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:17 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 57731305D50D; Mon,  7 Dec 2020 22:46:15 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 397003072785;
 Mon,  7 Dec 2020 22:46:15 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 21/81] KVM: x86: add kvm_x86_ops.control_singlestep()
Date: Mon,  7 Dec 2020 22:45:22 +0200
Message-Id: <20201207204622.15258-22-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
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
b24gaXMgbmVlZGVkIGZvciBLVk1JX1ZDUFVfQ09OVFJPTF9TSU5HTEVTVEVQLgoKU2lnbmVkLW9m
Zi1ieTogTmljdciZb3IgQ8OuyJt1IDxuaWN1LmNpdHVAaWNsb3VkLmNvbT4KU2lnbmVkLW9mZi1i
eTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCAgMSArCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAg
ICAgICAgIHwgMTEgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCmluZGV4IDQ1YzcyYWYwNWZhMi4uYzJkYTVjMjRlODI1
IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKQEAgLTEzMDUsNiArMTMwNSw3IEBAIHN0cnVjdCBr
dm1feDg2X29wcyB7CiAJdm9pZCAoKm1zcl9maWx0ZXJfY2hhbmdlZCkoc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KTsKIAogCXU2NCAoKmZhdWx0X2dsYSkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKKwl2
b2lkICgqY29udHJvbF9zaW5nbGVzdGVwKShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGJvb2wgZW5h
YmxlKTsKIH07CiAKIHN0cnVjdCBrdm1feDg2X25lc3RlZF9vcHMgewpkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMKaW5kZXggNDFlYTFl
ZTlkNDE5Li4xYzhmYmQ2MjA5Y2UgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMK
KysrIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYwpAQCAtNzY0OCw2ICs3NjQ4LDE2IEBAIHN0YXRp
YyB1NjQgdm14X2ZhdWx0X2dsYShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJcmV0dXJuIH4wdWxs
OwogfQogCitzdGF0aWMgdm9pZCB2bXhfY29udHJvbF9zaW5nbGVzdGVwKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgYm9vbCBlbmFibGUpCit7CisJaWYgKGVuYWJsZSkKKwkJZXhlY19jb250cm9sc19z
ZXRiaXQodG9fdm14KHZjcHUpLAorCQkJICAgICAgQ1BVX0JBU0VEX01PTklUT1JfVFJBUF9GTEFH
KTsKKwllbHNlCisJCWV4ZWNfY29udHJvbHNfY2xlYXJiaXQodG9fdm14KHZjcHUpLAorCQkJCUNQ
VV9CQVNFRF9NT05JVE9SX1RSQVBfRkxBRyk7Cit9CisKIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4Nl9v
cHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuaGFyZHdhcmVfdW5zZXR1cCA9IGhhcmR3
YXJlX3Vuc2V0dXAsCiAKQEAgLTc3ODgsNiArNzc5OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qga3ZtX3g4
Nl9vcHMgdm14X3g4Nl9vcHMgX19pbml0ZGF0YSA9IHsKIAkuY3B1X2RpcnR5X2xvZ19zaXplID0g
dm14X2NwdV9kaXJ0eV9sb2dfc2l6ZSwKIAogCS5mYXVsdF9nbGEgPSB2bXhfZmF1bHRfZ2xhLAor
CS5jb250cm9sX3NpbmdsZXN0ZXAgPSB2bXhfY29udHJvbF9zaW5nbGVzdGVwLAogfTsKIAogc3Rh
dGljIF9faW5pdCBpbnQgaGFyZHdhcmVfc2V0dXAodm9pZCkKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
