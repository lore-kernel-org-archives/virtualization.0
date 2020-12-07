Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0FC4361B
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443C02389F
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443C02389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2670E86FFB;
	Mon,  7 Dec 2020 20:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZeG3UeKxqee; Mon,  7 Dec 2020 20:46:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 858A7870BD;
	Mon,  7 Dec 2020 20:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6AFC1834;
	Mon,  7 Dec 2020 20:46:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 982BEC1DA5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8CF48878BE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VIgfiCu9t6O3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 850A0878A7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 115A3305D517; Mon,  7 Dec 2020 22:46:17 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id E3C443072785;
 Mon,  7 Dec 2020 22:46:16 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 31/81] KVM: x86: disable gpa_available optimization for
 fetch and page-walk SPT violations
Date: Mon,  7 Dec 2020 22:45:32 +0200
Message-Id: <20201207204622.15258-32-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Mircea=20C=C3=AErjaliu?= <mcirjaliu@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
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

RnJvbTogTWlyY2VhIEPDrnJqYWxpdSA8bWNpcmphbGl1QGJpdGRlZmVuZGVyLmNvbT4KClRoaXMg
Y2hhbmdlIGlzIG5lZWRlZCBiZWNhdXNlIHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgY2FuIHdyaXRl
LXByb3RlY3QKZ3Vlc3QgcGFnZSB0YWJsZXMgb3IgZXhlYy1wcm90ZWN0IGhlYXAvc3RhY2sgcGFn
ZXMuCgpTaWduZWQtb2ZmLWJ5OiBNaXJjZWEgQ8OucmphbGl1IDxtY2lyamFsaXVAYml0ZGVmZW5k
ZXIuY29tPgpDby1kZXZlbG9wZWQtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVu
ZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5k
ZXIuY29tPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggfCA1ICsrKysrCiBh
cmNoL3g4Ni9rdm0vbW11L21tdS5jICAgICAgICAgIHwgNyArKysrKysrCiBhcmNoL3g4Ni9rdm0v
eDg2LmMgICAgICAgICAgICAgIHwgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20va3Zt
X2hvc3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmgKaW5kZXggMmZmYzExYzVj
NmMwLi5jZmZhYzNlN2E3OGQgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9o
b3N0LmgKKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaApAQCAtMTQ0OCw2ICsx
NDQ4LDEwIEBAIGV4dGVybiB1NjQga3ZtX21jZV9jYXBfc3VwcG9ydGVkOwogICoJCQkgICAgIHJl
dHJ5IG5hdGl2ZSBleGVjdXRpb24gdW5kZXIgY2VydGFpbiBjb25kaXRpb25zLAogICoJCQkgICAg
IENhbiBvbmx5IGJlIHNldCBpbiBjb25qdW5jdGlvbiB3aXRoIEVNVUxUWVBFX1BGLgogICoKKyAq
IEVNVUxUWVBFX0dQQV9BVkFJTEFCTEVfUEYgLSBTZXQgd2hlbiB0aGUgZW11bGF0b3IgY2FuIGF2
b2lkIGEgcGFnZSB3YWxrCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgIHRvIGdldCB0aGUg
R1BBLgorICogICAgICAgICAgICAgICAgICAgICAgICAgICBDYW4gb25seSBiZSBzZXQgaW4gY29u
anVuY3Rpb24gd2l0aCBFTVVMVFlQRV9QRi4KKyAqCiAgKiBFTVVMVFlQRV9UUkFQX1VEX0ZPUkNF
RCAtIFNldCB3aGVuIGVtdWxhdGluZyBhbiBpbnRlcmNlcHRlZCAjVUQgdGhhdCB3YXMKICAqCQkJ
ICAgICB0cmlnZ2VyZWQgYnkgS1ZNJ3MgbWFnaWMgImZvcmNlIGVtdWxhdGlvbiIgcHJlZml4LAog
ICoJCQkgICAgIHdoaWNoIGlzIG9wdCBpbiB2aWEgbW9kdWxlIHBhcmFtIChvZmYgYnkgZGVmYXVs
dCkuCkBAIC0xNDcwLDYgKzE0NzQsNyBAQCBleHRlcm4gdTY0IGt2bV9tY2VfY2FwX3N1cHBvcnRl
ZDsKICNkZWZpbmUgRU1VTFRZUEVfVFJBUF9VRF9GT1JDRUQJICAgICgxIDw8IDQpCiAjZGVmaW5l
IEVNVUxUWVBFX1ZNV0FSRV9HUAkgICAgKDEgPDwgNSkKICNkZWZpbmUgRU1VTFRZUEVfUEYJCSAg
ICAoMSA8PCA2KQorI2RlZmluZSBFTVVMVFlQRV9HUEFfQVZBSUxBQkxFX1BGICAgKDEgPDwgNykK
IAogaW50IGt2bV9lbXVsYXRlX2luc3RydWN0aW9uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgaW50
IGVtdWxhdGlvbl90eXBlKTsKIGludCBrdm1fZW11bGF0ZV9pbnN0cnVjdGlvbl9mcm9tX2J1ZmZl
cihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21t
dS5jIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYwppbmRleCAyM2I3MjUzMmNkMTguLmY3OWNmNThh
MjdkYyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYworKysgYi9hcmNoL3g4Ni9r
dm0vbW11L21tdS5jCkBAIC01MTQ4LDYgKzUxNDgsMTMgQEAgaW50IGt2bV9tbXVfcGFnZV9mYXVs
dChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGNyMl9vcl9ncGEsIHU2NCBlcnJvcl9jb2Rl
LAogCiAJaWYgKFdBUk5fT04oIVZBTElEX1BBR0UodmNwdS0+YXJjaC5tbXUtPnJvb3RfaHBhKSkp
CiAJCXJldHVybiBSRVRfUEZfUkVUUlk7CisJLyoKKwkgKiBXaXRoIHNoYWRvdyBwYWdlIHRhYmxl
cywgZmF1bHRfYWRkcmVzcyBjb250YWlucyBhIEdWQSBvciBuR1BBLgorCSAqIE9uIGEgZmV0Y2gg
ZmF1bHQsIGZhdWx0X2FkZHJlc3MgY29udGFpbnMgdGhlIGluc3RydWN0aW9uIHBvaW50ZXIuCisJ
ICovCisJaWYgKGRpcmVjdCAmJiBsaWtlbHkoIShlcnJvcl9jb2RlICYgUEZFUlJfRkVUQ0hfTUFT
SykpICYmCisJICAgIChlcnJvcl9jb2RlICYgUEZFUlJfR1VFU1RfRklOQUxfTUFTSykpCisJCWVt
dWxhdGlvbl90eXBlIHw9IEVNVUxUWVBFX0dQQV9BVkFJTEFCTEVfUEY7CiAKIAlyID0gUkVUX1BG
X0lOVkFMSUQ7CiAJaWYgKHVubGlrZWx5KGVycm9yX2NvZGUgJiBQRkVSUl9SU1ZEX01BU0spKSB7
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5k
ZXggYTgyZGI2YjMwYWVlLi5kOWIxMDM0NDY1YzggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94
ODYuYworKysgYi9hcmNoL3g4Ni9rdm0veDg2LmMKQEAgLTc0MDYsNyArNzQwNiw3IEBAIGludCB4
ODZfZW11bGF0ZV9pbnN0cnVjdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdwYV90IGNyMl9v
cl9ncGEsCiAJCWN0eHQtPmV4Y2VwdGlvbi5hZGRyZXNzID0gY3IyX29yX2dwYTsKIAogCQkvKiBX
aXRoIHNoYWRvdyBwYWdlIHRhYmxlcywgY3IyIGNvbnRhaW5zIGEgR1ZBIG9yIG5HUEEuICovCi0J
CWlmICh2Y3B1LT5hcmNoLm1tdS0+ZGlyZWN0X21hcCkgeworCQlpZiAoZW11bGF0aW9uX3R5cGUg
JiBFTVVMVFlQRV9HUEFfQVZBSUxBQkxFX1BGKSB7CiAJCQljdHh0LT5ncGFfYXZhaWxhYmxlID0g
dHJ1ZTsKIAkJCWN0eHQtPmdwYV92YWwgPSBjcjJfb3JfZ3BhOwogCQl9Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
