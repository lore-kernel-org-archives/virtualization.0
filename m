Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC157C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FFD6113A
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8FFD6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EE4C408F5;
	Wed,  6 Oct 2021 17:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amYXm_XzNNFe; Wed,  6 Oct 2021 17:40:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BB9B408FD;
	Wed,  6 Oct 2021 17:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4EB7C0038;
	Wed,  6 Oct 2021 17:40:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF41C0033
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CF62407E2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P8uWa-K4ZgyZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA04440898
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:44 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 8B96A3086400; Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 73A973064495;
 Wed,  6 Oct 2021 20:31:25 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 76/77] KVM: introspection: emulate a guest page table walk
 on SPT violations due to A/D bit updates
Date: Wed,  6 Oct 2021 20:31:12 +0300
Message-Id: <20211006173113.26445-77-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
 Jim Mattson <jmattson@google.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKT24gU1BUIHBhZ2Ug
ZmF1bHRzIGNhdXNlZCBieSBndWVzdCBwYWdlIHRhYmxlIHdhbGtzLCB1c2UgdGhlIGV4aXN0aW5n
Cmd1ZXN0IHBhZ2UgdGFibGUgd2FsayBjb2RlIHRvIG1ha2UgdGhlIG5lY2Vzc2FyeSBhZGp1c3Rt
ZW50cyB0byB0aGUgQS9ECmJpdHMgYW5kIHJldHVybiB0byBndWVzdC4gVGhpcyBlZmZlY3RpdmVs
eSBieXBhc3NlcyB0aGUgeDg2IGVtdWxhdG9yCndobyB3YXMgbWFraW5nIHRoZSB3cm9uZyBtb2Rp
ZmljYXRpb25zIGxlYWRpbmcgb25lIE9TIChXaW5kb3dzIDguMSB4NjQpCnRvIHRyaXBsZS1mYXVs
dCB2ZXJ5IGVhcmx5IGluIHRoZSBib290IHByb2Nlc3Mgd2l0aCB0aGUgaW50cm9zcGVjdGlvbgpl
bmFibGVkLgoKV2l0aCBpbnRyb3NwZWN0aW9uIGRpc2FibGVkLCB0aGVzZSBmYXVsdHMgYXJlIGhh
bmRsZWQgYnkgc2ltcGx5IHJlbW92aW5nCnRoZSBwcm90ZWN0aW9uIGZyb20gdGhlIGFmZmVjdGVk
IGd1ZXN0IHBhZ2UgYW5kIHJldHVybmluZyB0byBndWVzdC4KClNpZ25lZC1vZmYtYnk6IE1paGFp
IERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQg
TGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2luY2x1ZGUvYXNt
L2t2bWlfaG9zdC5oIHwgIDIgKysKIGFyY2gveDg2L2t2bS9rdm1pLmMgICAgICAgICAgICAgIHwg
MzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9rdm0vbW11L21tdS5j
ICAgICAgICAgICB8IDEyICsrKysrKysrKystLQogaW5jbHVkZS9saW51eC9rdm1pX2hvc3QuaCAg
ICAgICAgfCAgMyArKysKIHZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaS5jICAgIHwgMjYgKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1p
X2hvc3QuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bWlfaG9zdC5oCmluZGV4IDA0NWJjODg1
ZjAwNy4uNWExNzAwZDM2YjY3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1p
X2hvc3QuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1pX2hvc3QuaApAQCAtNzgsNiAr
NzgsNyBAQCBib29sIGt2bWlfZGVzY3JpcHRvcl9ldmVudChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUs
IHU4IGRlc2NyaXB0b3IsIGJvb2wgd3JpdGUpOwogYm9vbCBrdm1pX21zcl9ldmVudChzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUsIHN0cnVjdCBtc3JfZGF0YSAqbXNyKTsKIGJvb2wga3ZtaV9tb25pdG9y
X21zcndfaW50ZXJjZXB0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIG1zciwgYm9vbCBlbmFi
bGUpOwogYm9vbCBrdm1pX21zcndfaW50ZXJjZXB0X29yaWdpbmF0b3Ioc3RydWN0IGt2bV92Y3B1
ICp2Y3B1KTsKK2Jvb2wga3ZtaV91cGRhdGVfYWRfZmxhZ3Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1
KTsKIAogI2Vsc2UgLyogQ09ORklHX0tWTV9JTlRST1NQRUNUSU9OICovCiAKQEAgLTEwMyw2ICsx
MDQsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wga3ZtaV9tb25pdG9yX21zcndfaW50ZXJjZXB0KHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgdTMyIG1zciwKIAkJCQkJICAgICAgIGJvb2wgZW5hYmxlKSB7
IHJldHVybiBmYWxzZTsgfQogc3RhdGljIGlubGluZSBib29sIGt2bWlfbXNyd19pbnRlcmNlcHRf
b3JpZ2luYXRvcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCiAJCQkJeyByZXR1cm4gZmFsc2U7IH0K
K3N0YXRpYyBpbmxpbmUgYm9vbCBrdm1pX3VwZGF0ZV9hZF9mbGFncyhzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpIHsgcmV0dXJuIGZhbHNlOyB9CiAKICNlbmRpZiAvKiBDT05GSUdfS1ZNX0lOVFJPU1BF
Q1RJT04gKi8KIApkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL2t2bWkuYyBiL2FyY2gveDg2L2t2
bS9rdm1pLmMKaW5kZXggNThjMmRlYmQ4ODE1Li5jZTM4N2M4YTEzNjcgMTAwNjQ0Ci0tLSBhL2Fy
Y2gveDg2L2t2bS9rdm1pLmMKKysrIGIvYXJjaC94ODYva3ZtL2t2bWkuYwpAQCAtMTEwMiwzICsx
MTAyLDMzIEBAIHZvaWQga3ZtaV9hcmNoX3N0b3Bfc2luZ2xlc3RlcChzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpCiB7CiAJc3RhdGljX2NhbGwoa3ZtX3g4Nl9jb250cm9sX3NpbmdsZXN0ZXApKHZjcHUs
IGZhbHNlKTsKIH0KKworYm9vbCBrdm1pX3VwZGF0ZV9hZF9mbGFncyhzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpCit7CisJc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9uICprdm1pOworCWJvb2wgcmV0ID0g
ZmFsc2U7CisJZ3ZhX3QgZ3ZhOworCWdwYV90IGdwYTsKKworCWt2bWkgPSBrdm1pX2dldCh2Y3B1
LT5rdm0pOworCWlmICgha3ZtaSkKKwkJcmV0dXJuIGZhbHNlOworCisJZ3ZhID0gc3RhdGljX2Nh
bGwoa3ZtX3g4Nl9mYXVsdF9nbGEpKHZjcHUpOworCWlmIChndmEgPT0gfjB1bGwpCisJCWdvdG8g
b3V0OworCisJZ3BhID0ga3ZtX21tdV9ndmFfdG9fZ3BhX3N5c3RlbSh2Y3B1LCBndmEsIFBGRVJS
X1dSSVRFX01BU0ssIE5VTEwpOworCWlmIChncGEgPT0gVU5NQVBQRURfR1ZBKSB7CisJCXN0cnVj
dCB4ODZfZXhjZXB0aW9uIGV4Y2VwdGlvbiA9IHsgfTsKKworCQlncGEgPSBrdm1fbW11X2d2YV90
b19ncGFfc3lzdGVtKHZjcHUsIGd2YSwgMCwgJmV4Y2VwdGlvbik7CisJfQorCisJcmV0ID0gKGdw
YSAhPSBVTk1BUFBFRF9HVkEpOworCitvdXQ6CisJa3ZtaV9wdXQodmNwdS0+a3ZtKTsKKworCXJl
dHVybiByZXQ7Cit9CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jIGIvYXJjaC94
ODYva3ZtL21tdS9tbXUuYwppbmRleCBjOTA2ODMyODQwOTguLmQwYThhYzg5MWJjMiAxMDA2NDQK
LS0tIGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYworKysgYi9hcmNoL3g4Ni9rdm0vbW11L21tdS5j
CkBAIC00Myw2ICs0Myw3IEBACiAjaW5jbHVkZSA8bGludXgvaGFzaC5oPgogI2luY2x1ZGUgPGxp
bnV4L2tlcm5fbGV2ZWxzLmg+CiAjaW5jbHVkZSA8bGludXgva3RocmVhZC5oPgorI2luY2x1ZGUg
PGxpbnV4L2t2bWlfaG9zdC5oPgogCiAjaW5jbHVkZSA8YXNtL3BhZ2UuaD4KICNpbmNsdWRlIDxh
c20vbWVtdHlwZS5oPgpAQCAtNTMzMyw4ICs1MzM0LDE1IEBAIGludCBrdm1fbW11X3BhZ2VfZmF1
bHQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBncGFfdCBjcjJfb3JfZ3BhLCB1NjQgZXJyb3JfY29k
ZSwKIAkgKi8KIAlpZiAodmNwdS0+YXJjaC5tbXUtPmRpcmVjdF9tYXAgJiYKIAkgICAgKGVycm9y
X2NvZGUgJiBQRkVSUl9ORVNURURfR1VFU1RfUEFHRSkgPT0gUEZFUlJfTkVTVEVEX0dVRVNUX1BB
R0UpIHsKLQkJa3ZtX21tdV91bnByb3RlY3RfcGFnZSh2Y3B1LT5rdm0sIGdwYV90b19nZm4oY3Iy
X29yX2dwYSkpOwotCQlyZXR1cm4gMTsKKwkJZ2ZuX3QgZ2ZuID0gZ3BhX3RvX2dmbihjcjJfb3Jf
Z3BhKTsKKworCQlpZiAoa3ZtaV90cmFja2VkX2dmbih2Y3B1LCBnZm4pKSB7CisJCQlpZiAoa3Zt
aV91cGRhdGVfYWRfZmxhZ3ModmNwdSkpCisJCQkJcmV0dXJuIDE7CisJCX0gZWxzZSB7CisJCQlr
dm1fbW11X3VucHJvdGVjdF9wYWdlKHZjcHUtPmt2bSwgZ2ZuKTsKKwkJCXJldHVybiAxOworCQl9
CiAJfQogCiAJLyoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva3ZtaV9ob3N0LmggYi9pbmNs
dWRlL2xpbnV4L2t2bWlfaG9zdC5oCmluZGV4IGVjMzhlNDM0YzhlOS4uOTA2NDdiYjJhNTcwIDEw
MDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2t2bWlfaG9zdC5oCisrKyBiL2luY2x1ZGUvbGludXgv
a3ZtaV9ob3N0LmgKQEAgLTgzLDYgKzgzLDcgQEAgYm9vbCBrdm1pX2JyZWFrcG9pbnRfZXZlbnQo
c3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQgZ3ZhLCB1OCBpbnNuX2xlbik7CiBib29sIGt2bWlf
dmNwdV9ydW5uaW5nX3NpbmdsZXN0ZXAoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIHZvaWQga3Zt
aV9zaW5nbGVzdGVwX2RvbmUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIHZvaWQga3ZtaV9zaW5n
bGVzdGVwX2ZhaWxlZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOworYm9vbCBrdm1pX3RyYWNrZWRf
Z2ZuKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuKTsKIAogI2Vsc2UKIApAQCAtMTAx
LDYgKzEwMiw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBrdm1pX3ZjcHVfcnVubmluZ19zaW5nbGVz
dGVwKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkKIAkJCXsgcmV0dXJuIGZhbHNlOyB9CiBzdGF0aWMg
aW5saW5lIHZvaWQga3ZtaV9zaW5nbGVzdGVwX2RvbmUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KSB7
IH0KIHN0YXRpYyBpbmxpbmUgdm9pZCBrdm1pX3NpbmdsZXN0ZXBfZmFpbGVkKHN0cnVjdCBrdm1f
dmNwdSAqdmNwdSkgeyB9CitzdGF0aWMgaW5saW5lIGJvb2wga3ZtaV90cmFja2VkX2dmbihzdHJ1
Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbikKKwkJCXsgcmV0dXJuIGZhbHNlOyB9CiAKICNl
bmRpZiAvKiBDT05GSUdfS1ZNX0lOVFJPU1BFQ1RJT04gKi8KIApkaWZmIC0tZ2l0IGEvdmlydC9r
dm0vaW50cm9zcGVjdGlvbi9rdm1pLmMgYi92aXJ0L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWkuYwpp
bmRleCA0ZWQxNDU0MjFkNjkuLjhlZjdiM2E0ZWY1MSAxMDA2NDQKLS0tIGEvdmlydC9rdm0vaW50
cm9zcGVjdGlvbi9rdm1pLmMKKysrIGIvdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1pLmMKQEAg
LTEyMzcsMyArMTIzNywyOSBAQCB2b2lkIGt2bWlfc2luZ2xlc3RlcF9mYWlsZWQoc3RydWN0IGt2
bV92Y3B1ICp2Y3B1KQogCWt2bWlfaGFuZGxlX3NpbmdsZXN0ZXBfZXhpdCh2Y3B1LCBmYWxzZSk7
CiB9CiBFWFBPUlRfU1lNQk9MKGt2bWlfc2luZ2xlc3RlcF9mYWlsZWQpOworCitzdGF0aWMgYm9v
bCBfX2t2bWlfdHJhY2tlZF9nZm4oc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9uICprdm1pLCBnZm5f
dCBnZm4pCit7CisJdTggaWdub3JlZF9hY2Nlc3M7CisKKwlpZiAoa3ZtaV9nZXRfZ2ZuX2FjY2Vz
cyhrdm1pLCBnZm4sICZpZ25vcmVkX2FjY2VzcykpCisJCXJldHVybiBmYWxzZTsKKworCXJldHVy
biB0cnVlOworfQorCitib29sIGt2bWlfdHJhY2tlZF9nZm4oc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LCBnZm5fdCBnZm4pCit7CisJc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9uICprdm1pOworCWJvb2wg
cmV0OworCisJa3ZtaSA9IGt2bWlfZ2V0KHZjcHUtPmt2bSk7CisJaWYgKCFrdm1pKQorCQlyZXR1
cm4gZmFsc2U7CisKKwlyZXQgPSBfX2t2bWlfdHJhY2tlZF9nZm4oa3ZtaSwgZ2ZuKTsKKworCWt2
bWlfcHV0KHZjcHUtPmt2bSk7CisKKwlyZXR1cm4gcmV0OworfQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
