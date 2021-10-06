Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C17C47081
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FD661186
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46FD661186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18F4E408FF;
	Wed,  6 Oct 2021 17:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZfUDzTWoUZ9; Wed,  6 Oct 2021 17:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1CCFD40903;
	Wed,  6 Oct 2021 17:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C077C0024;
	Wed,  6 Oct 2021 17:40:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20175C0022
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80F65408CF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JNUxTUHp6WKz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE16408D9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:45 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 9450D305CD21; Wed,  6 Oct 2021 20:30:53 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 7C7E33064495;
 Wed,  6 Oct 2021 20:30:53 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 02/77] KVM: add kvm_vcpu_kick_and_wait()
Date: Wed,  6 Oct 2021 20:29:58 +0300
Message-Id: <20211006173113.26445-3-alazar@bitdefender.com>
In-Reply-To: <20211006173113.26445-1-alazar@bitdefender.com>
References: <20211006173113.26445-1-alazar@bitdefender.com>
MIME-Version: 1.0
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Wanpeng Li <wanpengli@tencent.com>,
 Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>,
 Mathieu Tarral <mathieu.tarral@protonmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>
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

VGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgZm9yIHRoZSBLVk1JX1ZNX1BBVVNFX1ZDUFUgY29tbWFu
ZCwgd2hpY2ggc2V0cwp0aGUgaW50cm9zcGVjdGlvbiByZXF1ZXN0IGZsYWcsIGtpY2tzIHRoZSB2
Q1BVIG91dCBvZiBndWVzdCBhbmQgcmV0dXJucwphIHN1Y2Nlc3MgZXJyb3IgY29kZSAoMCkuIFRo
ZSB2Q1BVIHdpbGwgc2VuZCB0aGUgS1ZNSV9WQ1BVX0VWRU5UX1BBVVNFCmV2ZW50IGFzIHNvb24g
YXMgcG9zc2libGUuIE9uY2UgdGhlIGludHJvc3BlY3Rpb24gdG9vbCByZWNlaXZlcyB0aGUgZXZl
bnQsCml0IGtub3dzIHRoYXQgdGhlIHZDUFUgZG9lc24ndCBydW4gZ3Vlc3QgY29kZSBhbmQgY2Fu
IGhhbmRsZSBpbnRyb3NwZWN0aW9uCmNvbW1hbmRzICh1bnRpbCB0aGUgcmVwbHkgZm9yIHRoZSBw
YXVzZSBldmVudCBpcyBzZW50KS4KClRvIGltcGxlbWVudCB0aGUgInBhdXNlIFZNIiBjb21tYW5k
LCB0aGUgaW50cm9zcGVjdGlvbiB0b29sIHdpbGwgc2VuZAphIEtWTUlfVk1fUEFVU0VfVkNQVSBj
b21tYW5kIGZvciBldmVyeSB2Q1BVLiBUbyBrbm93IHdoZW4gdGhlIFZNIGlzCnBhdXNlZCwgdXNl
cnNwYWNlIGhhcyB0byByZWNlaXZlIGFuZCAicGFyc2UiIGFsbCBldmVudHMuIEZvciBleGFtcGxl
LAp3aXRoIGEgNCB2Q1BVIFZNLCBpZiAicGF1c2UgVk0iIHdhcyBzZW50IGJ5IHVzZXJzcGFjZSB3
aGlsZSBoYW5kbGluZwphbiBldmVudCBmcm9tIHZDUFUwIGFuZCBhdCB0aGUgc2FtZSB0aW1lIGEg
bmV3IHZDUFUgd2FzIGhvdC1wbHVnZ2VkCih3aGljaCBjb3VsZCBzZW5kIGFub3RoZXIgZXZlbnQg
Zm9yIHZDUFU0KSwgdGhlICJwYXVzZSBWTSIgY29tbWFuZCBoYXMKdG8gcmVjZWl2ZSBhbmQgY2hl
Y2sgYWxsIGV2ZW50cyB1bnRpbCBpdCBnZXRzIHRoZSBwYXVzZSBldmVudHMgZm9yIHZDUFUxLAp2
Q1BVMiBhbmQgdkNQVTMgYmVmb3JlIHJldHVybmluZyB0byB0aGUgdXBwZXIgbGF5ZXIuCgpJbiBv
cmRlciB0byBtYWtlIGl0IGVhc2llciBmb3IgdXNlcnNwYWNlIHRvIGltcGxlbWVudCB0aGUgInBh
dXNlIFZNIgpjb21tYW5kLCBLVk1JX1ZNX1BBVVNFX1ZDUFUgaGFzIGFuIG9wdGlvbmFsICd3YWl0
JyBwYXJhbWV0ZXIuIElmIHRoaXMgaXMKc2V0LCBrdm1fdmNwdV9raWNrX2FuZF93YWl0KCkgd2ls
bCBiZSB1c2VkIGluc3RlYWQgb2Yga3ZtX3ZjcHVfa2ljaygpLgpPbmNlIGEgc2VxdWVuY2Ugb2Yg
S1ZNSV9WTV9QQVVTRV9WQ1BVIGNvbW1hbmRzIHdpdGggdGhlICd3YWl0JyBmbGFnIHNldAppcyBo
YW5kbGVkLCB0aGUgaW50cm9zcGVjdGlvbiB0b29sIGNhbiBjb25zaWRlciB0aGUgVk0gcGF1c2Vk
LCB3aXRob3V0CnRoZSBuZWVkIHRvIHdhaXQgYW5kIGNoZWNrIGV2ZW50cy4KClNpZ25lZC1vZmYt
Ynk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBpbmNsdWRl
L2xpbnV4L2t2bV9ob3N0LmggfCAgMSArCiB2aXJ0L2t2bS9rdm1fbWFpbi5jICAgICAgfCAxMCAr
KysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmggYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKaW5k
ZXggNjBhMzVkOWZlMjU5Li42Nzk1ZWE3ZTM1N2QgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
a3ZtX2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L2t2bV9ob3N0LmgKQEAgLTk3MCw2ICs5NzAs
NyBAQCB2b2lkIGt2bV9hcmNoX3ZjcHVfYmxvY2tpbmcoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsK
IHZvaWQga3ZtX2FyY2hfdmNwdV91bmJsb2NraW5nKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiBi
b29sIGt2bV92Y3B1X3dha2VfdXAoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KTsKIHZvaWQga3ZtX3Zj
cHVfa2ljayhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpOwordm9pZCBrdm1fdmNwdV9raWNrX2FuZF93
YWl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSk7CiBpbnQga3ZtX3ZjcHVfeWllbGRfdG8oc3RydWN0
IGt2bV92Y3B1ICp0YXJnZXQpOwogdm9pZCBrdm1fdmNwdV9vbl9zcGluKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSwgYm9vbCB1c2VybW9kZV92Y3B1X25vdF9lbGlnaWJsZSk7CiAKZGlmZiAtLWdpdCBh
L3ZpcnQva3ZtL2t2bV9tYWluLmMgYi92aXJ0L2t2bS9rdm1fbWFpbi5jCmluZGV4IDNmNmQ0NTAz
NTVmMC4uODVmMmRkOGE3OWQxIDEwMDY0NAotLS0gYS92aXJ0L2t2bS9rdm1fbWFpbi5jCisrKyBi
L3ZpcnQva3ZtL2t2bV9tYWluLmMKQEAgLTMzNDMsNiArMzM0MywxNiBAQCB2b2lkIGt2bV92Y3B1
X2tpY2soc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogRVhQT1JUX1NZTUJPTF9HUEwoa3ZtX3ZjcHVf
a2ljayk7CiAjZW5kaWYgLyogIUNPTkZJR19TMzkwICovCiAKK3ZvaWQga3ZtX3ZjcHVfa2lja19h
bmRfd2FpdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCit7CisJaWYgKGt2bV92Y3B1X3dha2VfdXAo
dmNwdSkpCisJCXJldHVybjsKKworCWlmIChrdm1fcmVxdWVzdF9uZWVkc19pcGkodmNwdSwgS1ZN
X1JFUVVFU1RfV0FJVCkpCisJCXNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZSh2Y3B1LT5jcHUsIGFj
a19mbHVzaCwgTlVMTCwgMSk7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChrdm1fdmNwdV9raWNrX2Fu
ZF93YWl0KTsKKwogaW50IGt2bV92Y3B1X3lpZWxkX3RvKHN0cnVjdCBrdm1fdmNwdSAqdGFyZ2V0
KQogewogCXN0cnVjdCBwaWQgKnBpZDsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
