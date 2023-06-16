Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB1BEB64D8
	for <virtualization@archiver.kernel.org>; Fri, 16 Jun 2023 10:26:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4E104205A;
	Fri, 16 Jun 2023 10:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4E104205A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hTcNX5jf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fSlRgsNA_ElK; Fri, 16 Jun 2023 10:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D15F841F61;
	Fri, 16 Jun 2023 10:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D15F841F61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A54FFC0037;
	Fri, 16 Jun 2023 10:26:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAD0EC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jun 2023 10:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6D7341F61
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jun 2023 10:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6D7341F61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mo_VQP8c9ID5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jun 2023 10:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C57D41F5B
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C57D41F5B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Jun 2023 10:26:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 00E1C63570;
 Fri, 16 Jun 2023 10:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64108C433C9;
 Fri, 16 Jun 2023 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686911179;
 bh=/jy0jdXDEhOY3t3DIBzvRMyMooNFsh+AkjgnCmlVeMY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hTcNX5jfdQc9y9NWYht5nmJtzmBkgnwYQZ27VlZ17cXSQ0UHJ0say2s7zlirhqWzv
 r+TAJQrGQW/Fz5lolM3lzMn8yYmgZuHO1JDT7yqcJTlqNuAe5GVM3YL2/ZjPnm5BTj
 kwZPl2KnalKn/UcitheiY3UfxL01jCWjkz6Lk3xtFthQS8FTIInNOA6NTfCgsvOKFL
 8tLS84YGuOpCW3kabnw/YO5I6eWuyDS01scGb2mHazQRjj4X76zeDr/ZoRz3qRPcdw
 yrr+kWDpIIQDigIfIQtoVHNyU2YHoDuCDoCHtYyGTdLOXp8wn6xNPZjRVULTl38o/6
 zlupUoKO8Q2qA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 28/30] tools/virtio: Fix arm64 ringtest
 compilation error
Date: Fri, 16 Jun 2023 06:25:16 -0400
Message-Id: <20230616102521.673087-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102521.673087-1-sashal@kernel.org>
References: <20230616102521.673087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Cc: Sasha Levin <sashal@kernel.org>, xuanzhuo@linux.alibaba.com,
 dave@stgolabs.net, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Rong Tao <rongtao@cestc.cn>
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

RnJvbTogUm9uZyBUYW8gPHJvbmd0YW9AY2VzdGMuY24+CgpbIFVwc3RyZWFtIGNvbW1pdCA1NzM4
MGZkMTI0OWIyMGVmNzcyNTQ5YWYyYzU4ZWY1N2IyMWZhYmE3IF0KCkFkZCBjcHVfcmVsYXgoKSBm
b3IgYXJtNjQgaW5zdGVhZCBvZiBkaXJlY3RseSBhc3NlcnQoKSwgYW5kIGFkZCBhc3NlcnQuaApo
ZWFkZXIgZmlsZS4gQWxzbywgYWRkIHNtcF93bWIgYW5kIHNtcF9tYiBmb3IgYXJtNjQuCgpDb21w
aWxhdGlvbiBlcnJvciBhcyBmb2xsb3dzLCBhdm9pZCBfX2Fsd2F5c19pbmxpbmUgdW5kZWZpbmVk
LgoKICAgICQgbWFrZQogICAgY2MgLVdhbGwgLXB0aHJlYWQgLU8yIC1nZ2RiIC1mbHRvIC1md2hv
bGUtcHJvZ3JhbSAtYyAtbyByaW5nLm8gcmluZy5jCiAgICBJbiBmaWxlIGluY2x1ZGVkIGZyb20g
cmluZy5jOjEwOgogICAgbWFpbi5oOiBJbiBmdW5jdGlvbiDigJhidXN5X3dhaXTigJk6CiAgICBt
YWluLmg6OTk6MjE6IHdhcm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKA
mGFzc2VydOKAmQogICAgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICA5OSB8
ICNkZWZpbmUgY3B1X3JlbGF4KCkgYXNzZXJ0KDApCiAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fgogICAgbWFpbi5oOjEwNzoxNzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
IOKAmGNwdV9yZWxheOKAmQogICAgMTA3IHwgICAgICAgICAgICAgICAgIGNwdV9yZWxheCgpOwog
ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fgogICAgbWFpbi5oOjEyOjE6IG5vdGU6
IOKAmGFzc2VydOKAmSBpcyBkZWZpbmVkIGluIGhlYWRlciDigJg8YXNzZXJ0Lmg+4oCZOyBkaWQg
eW91CiAgICBmb3JnZXQgdG8g4oCYI2luY2x1ZGUgPGFzc2VydC5oPuKAmT8KICAgIDExIHwgI2lu
Y2x1ZGUgPHN0ZGJvb2wuaD4KICAgICsrKyB8KyNpbmNsdWRlIDxhc3NlcnQuaD4KICAgIDEyIHwK
ICAgIG1haW4uaDogQXQgdG9wIGxldmVsOgogICAgbWFpbi5oOjE0MzoyMzogZXJyb3I6IGV4cGVj
dGVkIOKAmDvigJkgYmVmb3JlIOKAmHZvaWTigJkKICAgIDE0MyB8IHN0YXRpYyBfX2Fsd2F5c19p
bmxpbmUKICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICBeCiAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgOwogICAgMTQ0IHwgdm9pZCBfX3JlYWRfb25jZV9zaXplKGNvbnN0IHZv
bGF0aWxlIHZvaWQgKnAsIHZvaWQgKnJlcywgaW50CiAgICBzaXplKQogICAgICAgIHwgfn5+fgog
ICAgbWFpbi5oOjE1ODoyMzogZXJyb3I6IGV4cGVjdGVkIOKAmDvigJkgYmVmb3JlIOKAmHZvaWTi
gJkKICAgIDE1OCB8IHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX3dyaXRlX29uY2Vfc2l6
ZSh2b2xhdGlsZSB2b2lkICpwLAogICAgdm9pZCAqcmVzLCBpbnQgc2l6ZSkKICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fgogICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
IDsKICAgIG1ha2U6ICoqKiBbPGJ1aWx0aW4+OiByaW5nLm9dIEVycm9yIDEKClNpZ25lZC1vZmYt
Ynk6IFJvbmcgVGFvIDxyb25ndGFvQGNlc3RjLmNuPgpNZXNzYWdlLUlkOiA8dGVuY2VudF9GNTNF
MTU5REQ3OTI1MTc0NDQ1RDgzMERBMTlGQUNGNDRCMDdAcXEuY29tPgpTaWduZWQtb2ZmLWJ5OiBN
aWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBM
ZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogdG9vbHMvdmlydGlvL3Jpbmd0ZXN0L21haW4u
aCB8IDExICsrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWluLmggYi90b29scy92aXJ0aW8vcmlu
Z3Rlc3QvbWFpbi5oCmluZGV4IGI2ODkyMGQ1Mjc1MDMuLmQxOGRkMzE3ZTI3ZjkgMTAwNjQ0Ci0t
LSBhL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWluLmgKKysrIGIvdG9vbHMvdmlydGlvL3Jpbmd0
ZXN0L21haW4uaApAQCAtOCw2ICs4LDcgQEAKICNpZm5kZWYgTUFJTl9ICiAjZGVmaW5lIE1BSU5f
SAogCisjaW5jbHVkZSA8YXNzZXJ0Lmg+CiAjaW5jbHVkZSA8c3RkYm9vbC5oPgogCiBleHRlcm4g
aW50IHBhcmFtOwpAQCAtOTUsNiArOTYsOCBAQCBleHRlcm4gdW5zaWduZWQgcmluZ19zaXplOwog
I2RlZmluZSBjcHVfcmVsYXgoKSBhc20gKCJyZXA7IG5vcCIgOjo6ICJtZW1vcnkiKQogI2VsaWYg
ZGVmaW5lZChfX3MzOTB4X18pCiAjZGVmaW5lIGNwdV9yZWxheCgpIGJhcnJpZXIoKQorI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgY3B1X3JlbGF4KCkgYXNtICgieWllbGQiIDo6
OiAibWVtb3J5IikKICNlbHNlCiAjZGVmaW5lIGNwdV9yZWxheCgpIGFzc2VydCgwKQogI2VuZGlm
CkBAIC0xMTIsNiArMTE1LDggQEAgc3RhdGljIGlubGluZSB2b2lkIGJ1c3lfd2FpdCh2b2lkKQog
CiAjaWYgZGVmaW5lZChfX3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9faTM4Nl9fKQogI2RlZmluZSBz
bXBfbWIoKSAgICAgYXNtIHZvbGF0aWxlKCJsb2NrOyBhZGRsICQwLC0xMzIoJSVyc3ApIiA6Ojog
Im1lbW9yeSIsICJjYyIpCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorI2RlZmluZSBzbXBf
bWIoKSAgICAgYXNtIHZvbGF0aWxlKCJkbWIgaXNoIiA6OjogIm1lbW9yeSIpCiAjZWxzZQogLyoK
ICAqIE5vdCB1c2luZyBfX0FUT01JQ19TRVFfQ1NUIHNpbmNlIGdjYyBkb2NzIHNheSB0aGV5IGFy
ZSBvbmx5IHN5bmNocm9uaXplZApAQCAtMTM2LDEwICsxNDEsMTYgQEAgc3RhdGljIGlubGluZSB2
b2lkIGJ1c3lfd2FpdCh2b2lkKQogCiAjaWYgZGVmaW5lZChfX2kzODZfXykgfHwgZGVmaW5lZChf
X3g4Nl82NF9fKSB8fCBkZWZpbmVkKF9fczM5MHhfXykKICNkZWZpbmUgc21wX3dtYigpIGJhcnJp
ZXIoKQorI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyNkZWZpbmUgc21wX3dtYigpIGFzbSB2
b2xhdGlsZSgiZG1iIGlzaHN0IiA6OjogIm1lbW9yeSIpCiAjZWxzZQogI2RlZmluZSBzbXBfd21i
KCkgc21wX3JlbGVhc2UoKQogI2VuZGlmCiAKKyNpZm5kZWYgX19hbHdheXNfaW5saW5lCisjZGVm
aW5lIF9fYWx3YXlzX2lubGluZSBpbmxpbmUgX19hdHRyaWJ1dGVfXygoYWx3YXlzX2lubGluZSkp
CisjZW5kaWYKKwogc3RhdGljIF9fYWx3YXlzX2lubGluZQogdm9pZCBfX3JlYWRfb25jZV9zaXpl
KGNvbnN0IHZvbGF0aWxlIHZvaWQgKnAsIHZvaWQgKnJlcywgaW50IHNpemUpCiB7Ci0tIAoyLjM5
LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
