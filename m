Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5738C4707F
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961876113A
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 961876113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24EED840BC;
	Wed,  6 Oct 2021 17:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gQaSNcCtvLC; Wed,  6 Oct 2021 17:40:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 24030840AD;
	Wed,  6 Oct 2021 17:40:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA98C002D;
	Wed,  6 Oct 2021 17:40:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F27BC0037
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E2AA60EEB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VJmlSQFXL1C6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx01.bbu.dsd.mx.bitdefender.com
 (mx01.bbu.dsd.mx.bitdefender.com [91.199.104.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9514660EBA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 17:40:46 +0000 (UTC)
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 99A96307CAE7; Wed,  6 Oct 2021 20:30:59 +0300 (EEST)
Received: from localhost (unknown [91.199.104.28])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 800553064495;
 Wed,  6 Oct 2021 20:30:59 +0300 (EEST)
X-Is-Junk-Enabled: fGZTSsP0qEJE2AIKtlSuFiRRwg9xyHmJ
From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To: kvm@vger.kernel.org
Subject: [PATCH v12 16/77] KVM: x86: save the error code during EPT/NPF exits
 handling
Date: Wed,  6 Oct 2021 20:30:12 +0300
Message-Id: <20211006173113.26445-17-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBpcyBuZWVk
ZWQgZm9yIGt2bV9wYWdlX3RyYWNrX2VtdWxhdGlvbl9mYWlsdXJlKCkuCgpXaGVuIHRoZSBpbnRy
b3NwZWN0aW9uIHRvb2wge3JlYWQsd3JpdGUsZXhlY30tcHJvdGVjdCBhIGd1ZXN0IG1lbW9yeQpw
YWdlLCBpdCBpcyBub3RpZmllZCBmcm9tIHRoZSByZWFkL3dyaXRlL2ZldGNoIGNhbGxiYWNrcyB1
c2VkIGJ5CnRoZSBLVk0gZW11bGF0b3IuIElmIHRoZSBlbXVsYXRpb24gZmFpbHMgaXQgaXMgcG9z
c2libGUgdGhhdCB0aGUKcmVhZC93cml0ZSBjYWxsYmFja3Mgd2VyZSBub3QgdXNlZC4gSW4gc3Vj
aCBjYXNlcywgdGhlIGVtdWxhdG9yIHdpbGwKY2FsbCBrdm1fcGFnZV90cmFja19lbXVsYXRpb25f
ZmFpbHVyZSgpIHRvIGVuc3VyZSB0aGF0IHRoZSBpbnRyb3NwZWN0aW9uCnRvb2wgaXMgbm90aWZp
ZWQgb2YgdGhlIHJlYWQvd3JpdGUgI1BGIChiYXNlZCBvbiB0aGlzIHNhdmVkIGVycm9yIGNvZGUp
LAp3aGljaCBpbiB0dXJuIGNhbiBlbXVsYXRlIHRoZSBpbnN0cnVjdGlvbiBvciB1bnByb3RlY3Qg
dGhlIG1lbW9yeSBwYWdlCihhbmQgbGV0IHRoZSBndWVzdCBleGVjdXRlIHRoZSBpbnN0cnVjdGlv
bikuCgpTaWduZWQtb2ZmLWJ5OiBNaWhhaSBEb27Im3UgPG1kb250dUBiaXRkZWZlbmRlci5jb20+
ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4K
LS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oIHwgMyArKysKIGFyY2gveDg2L2t2
bS9zdm0vc3ZtLmMgICAgICAgICAgfCAyICsrCiBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jICAgICAg
ICAgIHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2t2bV9ob3N0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9r
dm1faG9zdC5oCmluZGV4IDI5ZjRlOGI2MTllMS4uZGI4OGQzOGU0ODVkIDEwMDY0NAotLS0gYS9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9rdm1faG9zdC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2t2bV9ob3N0LmgKQEAgLTkxNiw2ICs5MTYsOSBAQCBzdHJ1Y3Qga3ZtX3ZjcHVfYXJjaCB7CiAj
aWYgSVNfRU5BQkxFRChDT05GSUdfSFlQRVJWKQogCWhwYV90IGh2X3Jvb3RfdGRwOwogI2VuZGlm
CisKKwkvKiAjUEYgdHJhbnNsYXRlZCBlcnJvciBjb2RlIGZyb20gRVBUL05QVCBleGl0IHJlYXNv
biAqLworCXU2NCBlcnJvcl9jb2RlOwogfTsKIAogc3RydWN0IGt2bV9scGFnZV9pbmZvIHsKZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMgYi9hcmNoL3g4Ni9rdm0vc3ZtL3N2bS5j
CmluZGV4IGI3ZWYwNjcxODYzZS4uZGU2Y2I1OWEzMzJkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9r
dm0vc3ZtL3N2bS5jCisrKyBiL2FyY2gveDg2L2t2bS9zdm0vc3ZtLmMKQEAgLTIwNzcsNiArMjA3
Nyw4IEBAIHN0YXRpYyBpbnQgbnBmX2ludGVyY2VwdGlvbihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUp
CiAJdTY0IGZhdWx0X2FkZHJlc3MgPSBzdm0tPnZtY2ItPmNvbnRyb2wuZXhpdF9pbmZvXzI7CiAJ
dTY0IGVycm9yX2NvZGUgPSBzdm0tPnZtY2ItPmNvbnRyb2wuZXhpdF9pbmZvXzE7CiAKKwlzdm0t
PnZjcHUuYXJjaC5lcnJvcl9jb2RlID0gZXJyb3JfY29kZTsKKwogCXRyYWNlX2t2bV9wYWdlX2Zh
dWx0KGZhdWx0X2FkZHJlc3MsIGVycm9yX2NvZGUpOwogCXJldHVybiBrdm1fbW11X3BhZ2VfZmF1
bHQodmNwdSwgZmF1bHRfYWRkcmVzcywgZXJyb3JfY29kZSwKIAkJCXN0YXRpY19jcHVfaGFzKFg4
Nl9GRUFUVVJFX0RFQ09ERUFTU0lTVFMpID8KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgv
dm14LmMgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCmluZGV4IGExNDBkNjliMWJkMy4uY2ViYTJl
MTEyZTI2IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2
L2t2bS92bXgvdm14LmMKQEAgLTUzODksNiArNTM4OSw3IEBAIHN0YXRpYyBpbnQgaGFuZGxlX2Vw
dF92aW9sYXRpb24oc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQogCSAgICAgICBQRkVSUl9HVUVTVF9G
SU5BTF9NQVNLIDogUEZFUlJfR1VFU1RfUEFHRV9NQVNLOwogCiAJdmNwdS0+YXJjaC5leGl0X3F1
YWxpZmljYXRpb24gPSBleGl0X3F1YWxpZmljYXRpb247CisJdmNwdS0+YXJjaC5lcnJvcl9jb2Rl
ID0gZXJyb3JfY29kZTsKIAogCS8qCiAJICogQ2hlY2sgdGhhdCB0aGUgR1BBIGRvZXNuJ3QgZXhj
ZWVkIHBoeXNpY2FsIG1lbW9yeSBsaW1pdHMsIGFzIHRoYXQgaXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
