Return-Path: <SRS0=JO0H=FL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B863C0018C
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7567238A0
	for <virtualization@archiver.kernel.org>; Mon,  7 Dec 2020 20:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7567238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9A6492E282;
	Mon,  7 Dec 2020 20:46:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7rmCSo+P8BiO; Mon,  7 Dec 2020 20:46:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DBB0D2E284;
	Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C47E0C0FA7;
	Mon,  7 Dec 2020 20:46:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E24BEC013B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB17487899
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EPVWkg7Uarmb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C612B8789A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 20:46:13 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4B7FA305D4FB; Mon,  7 Dec 2020 22:46:12 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 26D253072785;
 Mon,  7 Dec 2020 22:46:12 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v11 03/81] KVM: add kvm_get_max_gfn()
Date: Mon,  7 Dec 2020 22:45:04 +0200
Message-Id: <20201207204622.15258-4-alazar@bitdefender.com>
In-Reply-To: <20201207204622.15258-1-alazar@bitdefender.com>
References: <20201207204622.15258-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>,
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

RnJvbTogyJh0ZWZhbiDImGljbGVydSA8c3NpY2xlcnVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBm
dW5jdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBLVk1JX1ZNX0dFVF9NQVhfR0ZOIGNvbW1hbmQuCgpT
aWduZWQtb2ZmLWJ5OiDImHRlZmFuIMiYaWNsZXJ1IDxzc2ljbGVydUBiaXRkZWZlbmRlci5jb20+
ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4K
LS0tCiBpbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggfCAgMSArCiB2aXJ0L2t2bS9rdm1fbWFpbi5j
ICAgICAgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggYi9p
bmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKaW5kZXggMWJiYjA3Yjg3ZDFhLi5jZDZhYzNhNDNjOWEg
MTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgva3ZtX2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4
L2t2bV9ob3N0LmgKQEAgLTgwNyw2ICs4MDcsNyBAQCBib29sIGt2bV92Y3B1X2lzX3Zpc2libGVf
Z2ZuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuKTsKIHVuc2lnbmVkIGxvbmcga3Zt
X2hvc3RfcGFnZV9zaXplKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuKTsKIHZvaWQg
bWFya19wYWdlX2RpcnR5X2luX3Nsb3Qoc3RydWN0IGt2bSAqa3ZtLCBzdHJ1Y3Qga3ZtX21lbW9y
eV9zbG90ICptZW1zbG90LCBnZm5fdCBnZm4pOwogdm9pZCBtYXJrX3BhZ2VfZGlydHkoc3RydWN0
IGt2bSAqa3ZtLCBnZm5fdCBnZm4pOworZ2ZuX3Qga3ZtX2dldF9tYXhfZ2ZuKHN0cnVjdCBrdm0g
Kmt2bSk7CiAKIHN0cnVjdCBrdm1fbWVtc2xvdHMgKmt2bV92Y3B1X21lbXNsb3RzKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSk7CiBzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICprdm1fdmNwdV9nZm5fdG9f
bWVtc2xvdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbik7CmRpZmYgLS1naXQgYS92
aXJ0L2t2bS9rdm1fbWFpbi5jIGIvdmlydC9rdm0va3ZtX21haW4uYwppbmRleCAwNjk2NjhiOGFm
YzIuLmUxOWRkNmY5MjcwOSAxMDA2NDQKLS0tIGEvdmlydC9rdm0va3ZtX21haW4uYworKysgYi92
aXJ0L2t2bS9rdm1fbWFpbi5jCkBAIC0xNDEwLDYgKzE0MTAsMzEgQEAgc3RhdGljIGludCBrdm1f
dm1faW9jdGxfc2V0X21lbW9yeV9yZWdpb24oc3RydWN0IGt2bSAqa3ZtLAogCXJldHVybiBrdm1f
c2V0X21lbW9yeV9yZWdpb24oa3ZtLCBtZW0pOwogfQogCitnZm5fdCBrdm1fZ2V0X21heF9nZm4o
c3RydWN0IGt2bSAqa3ZtKQoreworCXUzMiBza2lwX21hc2sgPSBLVk1fTUVNX1JFQURPTkxZIHwg
S1ZNX01FTVNMT1RfSU5WQUxJRDsKKwlzdHJ1Y3Qga3ZtX21lbW9yeV9zbG90ICptZW1zbG90Owor
CXN0cnVjdCBrdm1fbWVtc2xvdHMgKnNsb3RzOworCWdmbl90IG1heF9nZm4gPSAwOworCWludCBp
ZHg7CisKKwlpZHggPSBzcmN1X3JlYWRfbG9jaygma3ZtLT5zcmN1KTsKKwlzcGluX2xvY2soJmt2
bS0+bW11X2xvY2spOworCisJc2xvdHMgPSBrdm1fbWVtc2xvdHMoa3ZtKTsKKwlrdm1fZm9yX2Vh
Y2hfbWVtc2xvdChtZW1zbG90LCBzbG90cykKKwkJaWYgKG1lbXNsb3QtPmlkIDwgS1ZNX1VTRVJf
TUVNX1NMT1RTICYmCisJCSAgIChtZW1zbG90LT5mbGFncyAmIHNraXBfbWFzaykgPT0gMCAmJgor
CQkgICBtZW1zbG90LT5ucGFnZXMpCisJCQltYXhfZ2ZuID0gbWF4KG1heF9nZm4sIG1lbXNsb3Qt
PmJhc2VfZ2ZuCisJCQkJCQkrIG1lbXNsb3QtPm5wYWdlcyk7CisKKwlzcGluX3VubG9jaygma3Zt
LT5tbXVfbG9jayk7CisJc3JjdV9yZWFkX3VubG9jaygma3ZtLT5zcmN1LCBpZHgpOworCisJcmV0
dXJuIG1heF9nZm47Cit9CisKICNpZm5kZWYgQ09ORklHX0tWTV9HRU5FUklDX0RJUlRZTE9HX1JF
QURfUFJPVEVDVAogLyoqCiAgKiBrdm1fZ2V0X2RpcnR5X2xvZyAtIGdldCBhIHNuYXBzaG90IG9m
IGRpcnR5IHBhZ2VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
