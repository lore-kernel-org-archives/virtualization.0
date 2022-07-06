Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6539CCA473
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 15:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D9564171E;
	Wed,  6 Jul 2022 15:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D9564171E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E2Td0r0L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hYFu3CcbNyBO; Wed,  6 Jul 2022 15:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72A3F415CB;
	Wed,  6 Jul 2022 15:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72A3F415CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36B2AC0035;
	Wed,  6 Jul 2022 15:32:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63B43C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 15:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D2FA605E8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 15:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D2FA605E8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=E2Td0r0L
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M3rm8S6KrEG2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 15:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60A7C605D5
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60A7C605D5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 15:32:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6A15461FF0;
 Wed,  6 Jul 2022 15:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B260C3411C;
 Wed,  6 Jul 2022 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657121524;
 bh=y6aJHwCIQHyCu5/Fc4D/l0yJ7hgPW18XIm1lCNu9rnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E2Td0r0LFkLPZIsdjvYAmMookNHwCeThctur9B1khBtajvzCTXHoHbUPdDRmnbUXw
 2Z4HShYtAY4szK7BCGlni8FMaEksfjEYIhKZiN+fSCpO3xhM5vUPsoAXIqP2pZEm+c
 nkdCTvfWPb52RhCsfWN0XHODcIOzJTauiiYLeutreCFvN6QQpAT8L6BhuRYM/UOCw4
 ok/wYSEcO8j0/mdCg45kggrGDtExsvj+k+D54M472gIrCH5tNcGX/zINV98+2hUZgX
 1QKs6v6xhZQkOITdZFL6YRXzGCKCqIF80NP8yFyirGxHatp77BhFFVVz6Aw4nRLSbz
 6Ll1EaygV57cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/18] vdpa/mlx5: Initialize CVQ vringh only once
Date: Wed,  6 Jul 2022 11:31:38 -0400
Message-Id: <20220706153153.1598076-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706153153.1598076-1-sashal@kernel.org>
References: <20220706153153.1598076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>
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

RnJvbTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgpbIFVwc3RyZWFtIGNvbW1pdCBhY2U5
MjUyNDQ2ZWM2MTVjZDc5YTVmNzdkOTBlZGIyNWMwYjlkMDI0IF0KCkN1cnJlbnRseSwgQ1ZRIHZy
aW5naCBpcyBpbml0aWFsaXplZCBpbnNpZGUgc2V0dXBfdmlydHF1ZXVlcygpIHdoaWNoIGlzCmNh
bGxlZCBldmVyeSB0aW1lIGEgbWVtb3J5IHVwZGF0ZSBpcyBkb25lLiBUaGlzIGlzIHVuZGVzaXJh
YmxlIHNpbmNlIGl0CnJlc2V0cyBhbGwgdGhlIGNvbnRleHQgb2YgdGhlIHZyaW5nLCBpbmNsdWRp
bmcgdGhlIGF2YWlsYWJsZSBhbmQgdXNlZAppbmRpY2VzLgoKTW92ZSB0aGUgaW5pdGlhbGl6YXRp
b24gdG8gbWx4NV92ZHBhX3NldF9zdGF0dXMoKSB3aGVuClZJUlRJT19DT05GSUdfU19EUklWRVJf
T0sgaXMgc2V0LgoKU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Ck1l
c3NhZ2UtSWQ6IDwyMDIyMDYxMzA3NTk1OC41MTEwNjQtMi1lbGljQG52aWRpYS5jb20+ClNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CkFja2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpBY2tlZC1ieTogRXVnZW5pbyBQw6lyZXog
PGVwZXJlem1hQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxA
a2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAzMSAr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCmluZGV4
IGU0MjU4ZjQwZGNkNy4uMjZiZDViYmEwZDg5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
CkBAIC0xODk2LDcgKzE4OTYsNiBAQCBzdGF0aWMgaW50IHZlcmlmeV9kcml2ZXJfZmVhdHVyZXMo
c3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1NjQgZmVhdHVyZXMpCiBzdGF0aWMgaW50IHNl
dHVwX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogewogCXN0cnVjdCBt
bHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwotCXN0cnVjdCBt
bHg1X2NvbnRyb2xfdnEgKmN2cSA9ICZtdmRldi0+Y3ZxOwogCWludCBlcnI7CiAJaW50IGk7CiAK
QEAgLTE5MDYsMTYgKzE5MDUsNiBAQCBzdGF0aWMgaW50IHNldHVwX3ZpcnRxdWV1ZXMoc3RydWN0
IG1seDVfdmRwYV9kZXYgKm12ZGV2KQogCQkJZ290byBlcnJfdnE7CiAJfQogCi0JaWYgKG12ZGV2
LT5hY3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkgewotCQll
cnIgPSB2cmluZ2hfaW5pdF9pb3RsYigmY3ZxLT52cmluZywgbXZkZXYtPmFjdHVhbF9mZWF0dXJl
cywKLQkJCQkJTUxYNV9DVlFfTUFYX0VOVCwgZmFsc2UsCi0JCQkJCShzdHJ1Y3QgdnJpbmdfZGVz
YyAqKSh1aW50cHRyX3QpY3ZxLT5kZXNjX2FkZHIsCi0JCQkJCShzdHJ1Y3QgdnJpbmdfYXZhaWwg
KikodWludHB0cl90KWN2cS0+ZHJpdmVyX2FkZHIsCi0JCQkJCShzdHJ1Y3QgdnJpbmdfdXNlZCAq
KSh1aW50cHRyX3QpY3ZxLT5kZXZpY2VfYWRkcik7Ci0JCWlmIChlcnIpCi0JCQlnb3RvIGVycl92
cTsKLQl9Ci0KIAlyZXR1cm4gMDsKIAogZXJyX3ZxOgpAQCAtMjE4Miw2ICsyMTcxLDIxIEBAIHN0
YXRpYyB2b2lkIGNsZWFyX3Zxc19yZWFkeShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKIAlu
ZGV2LT5tdmRldi5jdnEucmVhZHkgPSBmYWxzZTsKIH0KIAorc3RhdGljIGludCBzZXR1cF9jdnFf
dnJpbmcoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQoreworCXN0cnVjdCBtbHg1X2NvbnRy
b2xfdnEgKmN2cSA9ICZtdmRldi0+Y3ZxOworCWludCBlcnIgPSAwOworCisJaWYgKG12ZGV2LT5h
Y3R1YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkKKwkJZXJyID0g
dnJpbmdoX2luaXRfaW90bGIoJmN2cS0+dnJpbmcsIG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMsCisJ
CQkJCU1MWDVfQ1ZRX01BWF9FTlQsIGZhbHNlLAorCQkJCQkoc3RydWN0IHZyaW5nX2Rlc2MgKiko
dWludHB0cl90KWN2cS0+ZGVzY19hZGRyLAorCQkJCQkoc3RydWN0IHZyaW5nX2F2YWlsICopKHVp
bnRwdHJfdCljdnEtPmRyaXZlcl9hZGRyLAorCQkJCQkoc3RydWN0IHZyaW5nX3VzZWQgKikodWlu
dHB0cl90KWN2cS0+ZGV2aWNlX2FkZHIpOworCisJcmV0dXJuIGVycjsKK30KKwogc3RhdGljIHZv
aWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0
dXMpCiB7CiAJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7CkBA
IC0yMTkyLDYgKzIxOTYsMTEgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCiAKIAlpZiAoKHN0YXR1cyBeIG5kZXYt
Pm12ZGV2LnN0YXR1cykgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7CiAJCWlmIChzdGF0
dXMgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7CisJCQllcnIgPSBzZXR1cF9jdnFfdnJp
bmcobXZkZXYpOworCQkJaWYgKGVycikgeworCQkJCW1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFp
bGVkIHRvIHNldHVwIGNvbnRyb2wgVlEgdnJpbmdcbiIpOworCQkJCWdvdG8gZXJyX3NldHVwOwor
CQkJfQogCQkJZXJyID0gc2V0dXBfZHJpdmVyKG12ZGV2KTsKIAkJCWlmIChlcnIpIHsKIAkJCQlt
bHg1X3ZkcGFfd2FybihtdmRldiwgImZhaWxlZCB0byBzZXR1cCBkcml2ZXJcbiIpOwotLSAKMi4z
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
