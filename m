Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB575C63777
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52002206B5
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52002206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F2DF4874A4;
	Wed, 25 Nov 2020 09:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1UcyN3F8czB6; Wed, 25 Nov 2020 09:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B6C0874EB;
	Wed, 25 Nov 2020 09:52:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7A16C163C;
	Wed, 25 Nov 2020 09:52:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C23C1DA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E146986B19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ea07cD4cEIyL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A247F86A90
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:51:58 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 4D698305D3E2; Wed, 25 Nov 2020 11:35:53 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 296423072784;
 Wed, 25 Nov 2020 11:35:53 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 64/81] KVM: introspection: add KVMI_VM_GET_MAX_GFN
Date: Wed, 25 Nov 2020 11:35:43 +0200
Message-Id: <20201125093600.2766-65-alazar@bitdefender.com>
In-Reply-To: <20201125093600.2766-1-alazar@bitdefender.com>
References: <20201125093600.2766-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Nicu=C8=99or=20C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>,
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

RnJvbTogyJh0ZWZhbiDImGljbGVydSA8c3NpY2xlcnVAYml0ZGVmZW5kZXIuY29tPgoKVGhlIGlu
dHJvc3BlY3Rpb24gdG9vbCB3aWxsIHVzZSB0aGlzIGNvbW1hbmQgdG8gZ2V0IHRoZSBtZW1vcnkg
YWRkcmVzcwpyYW5nZSBmb3Igd2hpY2ggaXQgY2FuIHNldCBhY2Nlc3MgcmVzdHJpY3Rpb25zLgoK
U2lnbmVkLW9mZi1ieTogyJh0ZWZhbiDImGljbGVydSA8c3NpY2xlcnVAYml0ZGVmZW5kZXIuY29t
PgpDby1kZXZlbG9wZWQtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+
ClNpZ25lZC1vZmYtYnk6IE5pY3XImW9yIEPDrsibdSA8bmljdS5jaXR1QGljbG91ZC5jb20+ClNp
Z25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0t
CiBEb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0ICAgICAgICAgICAgICAgfCAxOSArKysr
KysrKysrKysrKysrKysrCiBpbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oICAgICAgICAgICAgICAg
ICAgICAgfCAgNSArKysrKwogLi4uL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90
ZXN0LmMgIHwgMTIgKysrKysrKysrKysrCiB2aXJ0L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWlfbXNn
LmMgICAgICAgICAgICAgfCAxMyArKysrKysrKysrKysrCiA0IGZpbGVzIGNoYW5nZWQsIDQ5IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0
IGIvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9rdm1pLnJzdAppbmRleCBlNjg4YWMzODdmYWYuLmVj
ZjQyMDdiNDJkMCAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi92aXJ0L2t2bS9rdm1pLnJzdAor
KysgYi9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0CkBAIC03NzcsNiArNzc3LDI1IEBA
IGV4Y2VwdGlvbi4KICogLUtWTV9FQlVTWSAtIGFub3RoZXIgKktWTUlfVkNQVV9JTkpFQ1RfRVhD
RVBUSU9OKi0qS1ZNSV9WQ1BVX0VWRU5UX1RSQVAqCiAgICAgICAgICAgICAgICBwYWlyIGlzIGlu
IHByb2dyZXNzCiAKKzE3LiBLVk1JX1ZNX0dFVF9NQVhfR0ZOCistLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQorCis6QXJjaGl0ZWN0dXJlczogYWxsCis6VmVyc2lvbnM6ID49IDEKKzpQYXJhbWV0ZXJz
OiBub25lCis6UmV0dXJuczoKKworOjoKKworICAgICAgICBzdHJ1Y3Qga3ZtaV9lcnJvcl9jb2Rl
OworICAgICAgICBzdHJ1Y3Qga3ZtaV92bV9nZXRfbWF4X2dmbl9yZXBseSB7CisgICAgICAgICAg
ICAgICAgX191NjQgZ2ZuOworICAgICAgICB9OworCitQcm92aWRlcyB0aGUgbWF4aW11bSBHRk4g
YWxsb2NhdGVkIHRvIHRoZSBWTSBieSB3YWxraW5nIHRocm91Z2ggYWxsCittZW1vcnkgc2xvdHMu
IFN0cmljbHkgc3BlYWtpbmcsIHRoZSByZXR1cm5lZCB2YWx1ZSByZWZlcnMgdG8gdGhlIGZpcnN0
CitpbmFjY2Vzc2libGUgR0ZOLCBuZXh0IHRvIHRoZSBtYXhpbXVtIGFjY2Vzc2libGUgR0ZOLgor
CiBFdmVudHMKID09PT09PQogCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtaS5o
IGIvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAppbmRleCAyNjNkOThhNTkwM2UuLmQwZTA2MzYz
YzQwNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAorKysgYi9pbmNsdWRl
L3VhcGkvbGludXgva3ZtaS5oCkBAIC0yOSw2ICsyOSw3IEBAIGVudW0gewogCUtWTUlfVk1fV1JJ
VEVfUEhZU0lDQUwgID0gS1ZNSV9WTV9NRVNTQUdFX0lEKDcpLAogCUtWTUlfVk1fUEFVU0VfVkNQ
VSAgICAgID0gS1ZNSV9WTV9NRVNTQUdFX0lEKDgpLAogCUtWTUlfVk1fQ09OVFJPTF9DTEVBTlVQ
ID0gS1ZNSV9WTV9NRVNTQUdFX0lEKDkpLAorCUtWTUlfVk1fR0VUX01BWF9HRk4gICAgID0gS1ZN
SV9WTV9NRVNTQUdFX0lEKDEwKSwKIAogCUtWTUlfTkVYVF9WTV9NRVNTQUdFCiB9OwpAQCAtMTc3
LDQgKzE3OCw4IEBAIHN0cnVjdCBrdm1pX3ZtX2NvbnRyb2xfY2xlYW51cCB7CiAJX191OCBwYWRk
aW5nWzddOwogfTsKIAorc3RydWN0IGt2bWlfdm1fZ2V0X21heF9nZm5fcmVwbHkgeworCV9fdTY0
IGdmbjsKK307CisKICNlbmRpZiAvKiBfVUFQSV9fTElOVVhfS1ZNSV9IICovCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYwppbmRleCBkYzlmMmYwZDk5
ZTguLmI0NTY1ODAyZGIyMiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3Zt
L3g4Nl82NC9rdm1pX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2
XzY0L2t2bWlfdGVzdC5jCkBAIC0xMzIyLDYgKzEzMjIsMTcgQEAgc3RhdGljIHZvaWQgdGVzdF9j
bWRfdmNwdV9pbmplY3RfZXhjZXB0aW9uKHN0cnVjdCBrdm1fdm0gKnZtKQogCWRpc2FibGVfdmNw
dV9ldmVudCh2bSwgS1ZNSV9WQ1BVX0VWRU5UX0JSRUFLUE9JTlQpOwogfQogCitzdGF0aWMgdm9p
ZCB0ZXN0X2NtZF92bV9nZXRfbWF4X2dmbih2b2lkKQoreworCXN0cnVjdCBrdm1pX3ZtX2dldF9t
YXhfZ2ZuX3JlcGx5IHJwbDsKKwlzdHJ1Y3Qga3ZtaV9tc2dfaGRyIHJlcTsKKworCXRlc3Rfdm1f
Y29tbWFuZChLVk1JX1ZNX0dFVF9NQVhfR0ZOLCAmcmVxLCBzaXplb2YocmVxKSwKKwkJCSZycGws
IHNpemVvZihycGwpLCAwKTsKKworCXByX2RlYnVnKCJtYXhfZ2ZuOiAweCVsbHhcbiIsIHJwbC5n
Zm4pOworfQorCiBzdGF0aWMgdm9pZCB0ZXN0X2ludHJvc3BlY3Rpb24oc3RydWN0IGt2bV92bSAq
dm0pCiB7CiAJc3JhbmRvbSh0aW1lKDApKTsKQEAgLTEzNDcsNiArMTM1OCw3IEBAIHN0YXRpYyB2
b2lkIHRlc3RfaW50cm9zcGVjdGlvbihzdHJ1Y3Qga3ZtX3ZtICp2bSkKIAl0ZXN0X2NtZF92bV9j
b250cm9sX2NsZWFudXAodm0pOwogCXRlc3RfY21kX3ZjcHVfY29udHJvbF9jcih2bSk7CiAJdGVz
dF9jbWRfdmNwdV9pbmplY3RfZXhjZXB0aW9uKHZtKTsKKwl0ZXN0X2NtZF92bV9nZXRfbWF4X2dm
bigpOwogCiAJdW5ob29rX2ludHJvc3BlY3Rpb24odm0pOwogfQpkaWZmIC0tZ2l0IGEvdmlydC9r
dm0vaW50cm9zcGVjdGlvbi9rdm1pX21zZy5jIGIvdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1p
X21zZy5jCmluZGV4IDc2MmZiNTIyN2RkOS4uNDJkMDY2ZTkyYmEyIDEwMDY0NAotLS0gYS92aXJ0
L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWlfbXNnLmMKKysrIGIvdmlydC9rdm0vaW50cm9zcGVjdGlv
bi9rdm1pX21zZy5jCkBAIC0yOTAsNiArMjkwLDE4IEBAIHN0YXRpYyBpbnQgaGFuZGxlX3ZtX2Nv
bnRyb2xfY2xlYW51cChzdHJ1Y3Qga3ZtX2ludHJvc3BlY3Rpb24gKmt2bWksCiAJcmV0dXJuIGt2
bWlfbXNnX3ZtX3JlcGx5KGt2bWksIG1zZywgZWMsIE5VTEwsIDApOwogfQogCitzdGF0aWMgaW50
IGhhbmRsZV92bV9nZXRfbWF4X2dmbihzdHJ1Y3Qga3ZtX2ludHJvc3BlY3Rpb24gKmt2bWksCisJ
CQkJIGNvbnN0IHN0cnVjdCBrdm1pX21zZ19oZHIgKm1zZywKKwkJCQkgY29uc3Qgdm9pZCAqcmVx
KQoreworCXN0cnVjdCBrdm1pX3ZtX2dldF9tYXhfZ2ZuX3JlcGx5IHJwbDsKKworCW1lbXNldCgm
cnBsLCAwLCBzaXplb2YocnBsKSk7CisJcnBsLmdmbiA9IGt2bV9nZXRfbWF4X2dmbihrdm1pLT5r
dm0pOworCisJcmV0dXJuIGt2bWlfbXNnX3ZtX3JlcGx5KGt2bWksIG1zZywgMCwgJnJwbCwgc2l6
ZW9mKHJwbCkpOworfQorCiAvKgogICogVGhlc2UgY29tbWFuZHMgYXJlIGV4ZWN1dGVkIGJ5IHRo
ZSByZWNlaXZpbmcgdGhyZWFkLgogICovCkBAIC0zMDAsNiArMzEyLDcgQEAgc3RhdGljIGt2bWlf
dm1fbXNnX2ZjdCBjb25zdCBtc2dfdm1bXSA9IHsKIAlbS1ZNSV9WTV9DT05UUk9MX0NMRUFOVVBd
ID0gaGFuZGxlX3ZtX2NvbnRyb2xfY2xlYW51cCwKIAlbS1ZNSV9WTV9DT05UUk9MX0VWRU5UU10g
ID0gaGFuZGxlX3ZtX2NvbnRyb2xfZXZlbnRzLAogCVtLVk1JX1ZNX0dFVF9JTkZPXSAgICAgICAg
PSBoYW5kbGVfdm1fZ2V0X2luZm8sCisJW0tWTUlfVk1fR0VUX01BWF9HRk5dICAgICA9IGhhbmRs
ZV92bV9nZXRfbWF4X2dmbiwKIAlbS1ZNSV9WTV9QQVVTRV9WQ1BVXSAgICAgID0gaGFuZGxlX3Zt
X3BhdXNlX3ZjcHUsCiAJW0tWTUlfVk1fUkVBRF9QSFlTSUNBTF0gICA9IGhhbmRsZV92bV9yZWFk
X3BoeXNpY2FsLAogCVtLVk1JX1ZNX1dSSVRFX1BIWVNJQ0FMXSAgPSBoYW5kbGVfdm1fd3JpdGVf
cGh5c2ljYWwsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
