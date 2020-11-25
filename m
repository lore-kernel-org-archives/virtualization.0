Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087EEC8300F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AA720BED
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 09:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AA720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4558286A88;
	Wed, 25 Nov 2020 09:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vJUNuEhDkp6g; Wed, 25 Nov 2020 09:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53C1E86A4F;
	Wed, 25 Nov 2020 09:42:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4888CC1DA0;
	Wed, 25 Nov 2020 09:42:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD06EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A945E8743B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QyyeU0xqN9mJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B539587439
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 09:41:55 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 3B879305D3E9; Wed, 25 Nov 2020 11:35:55 +0200 (EET)
Received: from localhost.localdomain (unknown [91.199.104.27])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 1F6A83072784;
 Wed, 25 Nov 2020 11:35:55 +0200 (EET)
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v10 76/81] KVM: introspection: extend KVMI_GET_VERSION with
 struct kvmi_features
Date: Wed, 25 Nov 2020 11:35:55 +0200
Message-Id: <20201125093600.2766-77-alazar@bitdefender.com>
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

VGhpcyBpcyB1c2VkIGJ5IHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgdG8gY2hlY2sgdGhlIGhhcmR3
YXJlIHN1cHBvcnQKZm9yIHRoZSBzaW5nbGUgc3RlcCBmZWF0dXJlLgoKU2lnbmVkLW9mZi1ieTog
QWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIERvY3VtZW50YXRp
b24vdmlydC9rdm0va3ZtaS5yc3QgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrLS0K
IGFyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3ZtaS5oICAgICAgICAgICAgICAgfCAgNSArKysr
KwogYXJjaC94ODYva3ZtL2t2bWkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1ICsr
KysrCiBpbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oICAgICAgICAgICAgICAgICAgICAgIHwgIDEg
KwogdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL3g4Nl82NC9rdm1pX3Rlc3QuYyB8ICA2ICsr
KysrKwogdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1pX2ludC5oICAgICAgICAgICAgICB8ICAx
ICsKIHZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9tc2cuYyAgICAgICAgICAgICAgfCAgMiAr
KwogNyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdmlydC9rdm0va3ZtaS5yc3QgYi9Eb2N1bWVudGF0aW9u
L3ZpcnQva3ZtL2t2bWkucnN0CmluZGV4IGJkY2M5MDY2YWUyOC4uOTkxOTIyODk3ZjFkIDEwMDY0
NAotLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQva3ZtL2t2bWkucnN0CisrKyBiL0RvY3VtZW50YXRp
b24vdmlydC9rdm0va3ZtaS5yc3QKQEAgLTI0MywxMCArMjQzLDIxIEBAIFRoZSB2Q1BVIGNvbW1h
bmRzIHN0YXJ0IHdpdGg6OgogCXN0cnVjdCBrdm1pX2dldF92ZXJzaW9uX3JlcGx5IHsKIAkJX191
MzIgdmVyc2lvbjsKIAkJX191MzIgbWF4X21zZ19zaXplOworCQlzdHJ1Y3Qga3ZtaV9mZWF0dXJl
cyBmZWF0dXJlczsKIAl9OwogCi1SZXR1cm5zIHRoZSBpbnRyb3NwZWN0aW9uIEFQSSB2ZXJzaW9u
IGFuZCB0aGUgbGFyZ2VzdCBhY2NlcHRlZCBtZXNzYWdlCi1zaXplICh1c2VmdWwgZm9yIHZhcmlh
YmxlIGxlbmd0aCBtZXNzYWdlcykuCitGb3IgeDg2CisKKzo6CisKKwlzdHJ1Y3Qga3ZtaV9mZWF0
dXJlcyB7CisJCV9fdTggc2luZ2xlc3RlcDsKKwkJX191OCBwYWRkaW5nWzddOworCX07CisKK1Jl
dHVybnMgdGhlIGludHJvc3BlY3Rpb24gQVBJIHZlcnNpb24sIHRoZSBsYXJnZXN0IGFjY2VwdGVk
IG1lc3NhZ2Ugc2l6ZQorKHVzZWZ1bCBmb3IgdmFyaWFibGUgbGVuZ3RoIG1lc3NhZ2VzKSBhbmQg
c29tZSBvZiB0aGUgaGFyZHdhcmUgc3VwcG9ydGVkCitmZWF0dXJlcy4KIAogVGhpcyBjb21tYW5k
IGlzIGFsd2F5cyBhbGxvd2VkIGFuZCBzdWNjZXNzZnVsLgogCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bWkuaCBiL2FyY2gveDg2L2luY2x1ZGUvdWFwaS9hc20va3Zt
aS5oCmluZGV4IDcwNWU5MGMyMTM3YS4uNTRkMjFlM2MxOGM0IDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bWkuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkvYXNt
L2t2bWkuaApAQCAtMTU5LDQgKzE1OSw5IEBAIHN0cnVjdCBrdm1pX3ZjcHVfZXZlbnRfbXNyX3Jl
cGx5IHsKIAlfX3U2NCBuZXdfdmFsOwogfTsKIAorc3RydWN0IGt2bWlfZmVhdHVyZXMgeworCV9f
dTggc2luZ2xlc3RlcDsKKwlfX3U4IHBhZGRpbmdbN107Cit9OworCiAjZW5kaWYgLyogX1VBUElf
QVNNX1g4Nl9LVk1JX0ggKi8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9rdm1pLmMgYi9hcmNo
L3g4Ni9rdm0va3ZtaS5jCmluZGV4IGNkNjQ3NjI2NDNkNi4uZTAzMDI4ODNhZWM1IDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rdm0va3ZtaS5jCisrKyBiL2FyY2gveDg2L2t2bS9rdm1pLmMKQEAgLTEw
ODEsMyArMTA4MSw4IEBAIHN0YXRpYyB2b2lkIGt2bWlfdHJhY2tfZmx1c2hfc2xvdChzdHJ1Y3Qg
a3ZtICprdm0sIHN0cnVjdCBrdm1fbWVtb3J5X3Nsb3QgKnNsb3QsCiAKIAlrdm1pX3B1dChrdm0p
OwogfQorCit2b2lkIGt2bWlfYXJjaF9mZWF0dXJlcyhzdHJ1Y3Qga3ZtaV9mZWF0dXJlcyAqZmVh
dCkKK3sKKwlmZWF0LT5zaW5nbGVzdGVwID0gISFrdm1feDg2X29wcy5jb250cm9sX3NpbmdsZXN0
ZXA7Cit9CmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgva3ZtaS5oIGIvaW5jbHVkZS91
YXBpL2xpbnV4L2t2bWkuaAppbmRleCAzYjQzMmIzN2IxN2MuLjQzNjMxZWQyYjA2YyAxMDA2NDQK
LS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bWkuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgv
a3ZtaS5oCkBAIC0xMDMsNiArMTAzLDcgQEAgc3RydWN0IGt2bWlfZXJyb3JfY29kZSB7CiBzdHJ1
Y3Qga3ZtaV9nZXRfdmVyc2lvbl9yZXBseSB7CiAJX191MzIgdmVyc2lvbjsKIAlfX3UzMiBtYXhf
bXNnX3NpemU7CisJc3RydWN0IGt2bWlfZmVhdHVyZXMgZmVhdHVyZXM7CiB9OwogCiBzdHJ1Y3Qg
a3ZtaV92bV9jaGVja19jb21tYW5kIHsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0v
eDg2XzY0L2t2bWlfdGVzdC5jCmluZGV4IGUzNmI1NzRjMjY0ZS4uOTk4NGIwMjQ3YWU5IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0veDg2XzY0L2t2bWlfdGVzdC5jCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS94ODZfNjQva3ZtaV90ZXN0LmMKQEAgLTU5
LDYgKzU5LDggQEAgc3RydWN0IHZjcHVfd29ya2VyX2RhdGEgewogCWJvb2wgcmVzdGFydF9vbl9z
aHV0ZG93bjsKIH07CiAKK3N0YXRpYyBzdHJ1Y3Qga3ZtaV9mZWF0dXJlcyBmZWF0dXJlczsKKwog
dHlwZWRlZiB2b2lkICgqZmN0X3BmX2V2ZW50KShzdHJ1Y3Qga3ZtX3ZtICp2bSwgc3RydWN0IGt2
bWlfbXNnX2hkciAqaGRyLAogCQkJCXN0cnVjdCBwZl9ldiAqZXYsCiAJCQkJc3RydWN0IHZjcHVf
cmVwbHkgKnJwbCk7CkBAIC00NDMsNiArNDQ1LDEwIEBAIHN0YXRpYyB2b2lkIHRlc3RfY21kX2dl
dF92ZXJzaW9uKHZvaWQpCiAKIAlwcl9kZWJ1ZygiS1ZNSSB2ZXJzaW9uOiAldVxuIiwgcnBsLnZl
cnNpb24pOwogCXByX2RlYnVnKCJNYXggbWVzc2FnZSBzaXplOiAldVxuIiwgcnBsLm1heF9tc2df
c2l6ZSk7CisKKwlmZWF0dXJlcyA9IHJwbC5mZWF0dXJlczsKKworCXByX2RlYnVnKCJzaW5nbGVz
dGVwIHN1cHBvcnQ6ICV1XG4iLCBmZWF0dXJlcy5zaW5nbGVzdGVwKTsKIH0KIAogc3RhdGljIHZv
aWQgY21kX3ZtX2NoZWNrX2NvbW1hbmQoX191MTYgaWQsIGludCBleHBlY3RlZF9lcnIpCmRpZmYg
LS1naXQgYS92aXJ0L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWlfaW50LmggYi92aXJ0L2t2bS9pbnRy
b3NwZWN0aW9uL2t2bWlfaW50LmgKaW5kZXggYmY2NTQ1ZTY2NDI1Li5hNTFlN2U0ZWQ1MTEgMTAw
NjQ0Ci0tLSBhL3ZpcnQva3ZtL2ludHJvc3BlY3Rpb24va3ZtaV9pbnQuaAorKysgYi92aXJ0L2t2
bS9pbnRyb3NwZWN0aW9uL2t2bWlfaW50LmgKQEAgLTEyMSw1ICsxMjEsNiBAQCB2b2lkIGt2bWlf
YXJjaF91cGRhdGVfcGFnZV90cmFja2luZyhzdHJ1Y3Qga3ZtICprdm0sCiAJCQkJICAgIHN0cnVj
dCBrdm1pX21lbV9hY2Nlc3MgKm0pOwogdm9pZCBrdm1pX2FyY2hfaG9vayhzdHJ1Y3Qga3ZtICpr
dm0pOwogdm9pZCBrdm1pX2FyY2hfdW5ob29rKHN0cnVjdCBrdm0gKmt2bSk7Cit2b2lkIGt2bWlf
YXJjaF9mZWF0dXJlcyhzdHJ1Y3Qga3ZtaV9mZWF0dXJlcyAqZmVhdCk7CiAKICNlbmRpZgpkaWZm
IC0tZ2l0IGEvdmlydC9rdm0vaW50cm9zcGVjdGlvbi9rdm1pX21zZy5jIGIvdmlydC9rdm0vaW50
cm9zcGVjdGlvbi9rdm1pX21zZy5jCmluZGV4IDI3NmI4OTg5MTJmZC4uZWU4ODdhZGU2MmNiIDEw
MDY0NAotLS0gYS92aXJ0L2t2bS9pbnRyb3NwZWN0aW9uL2t2bWlfbXNnLmMKKysrIGIvdmlydC9r
dm0vaW50cm9zcGVjdGlvbi9rdm1pX21zZy5jCkBAIC0xMzQsNiArMTM0LDggQEAgc3RhdGljIGlu
dCBoYW5kbGVfZ2V0X3ZlcnNpb24oc3RydWN0IGt2bV9pbnRyb3NwZWN0aW9uICprdm1pLAogCXJw
bC52ZXJzaW9uID0ga3ZtaV92ZXJzaW9uKCk7CiAJcnBsLm1heF9tc2dfc2l6ZSA9IEtWTUlfTUFY
X01TR19TSVpFOwogCisJa3ZtaV9hcmNoX2ZlYXR1cmVzKCZycGwuZmVhdHVyZXMpOworCiAJcmV0
dXJuIGt2bWlfbXNnX3ZtX3JlcGx5KGt2bWksIG1zZywgMCwgJnJwbCwgc2l6ZW9mKHJwbCkpOwog
fQogCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
