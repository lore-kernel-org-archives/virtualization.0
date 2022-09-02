Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B4CC54EE9
	for <virtualization@archiver.kernel.org>; Fri,  2 Sep 2022 09:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74AA360DB2;
	Fri,  2 Sep 2022 09:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74AA360DB2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=YZ8U4K6N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73_CcqJnL3zd; Fri,  2 Sep 2022 09:29:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B0AD6076A;
	Fri,  2 Sep 2022 09:29:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B0AD6076A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D26F7C0033;
	Fri,  2 Sep 2022 09:29:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D5DBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Sep 2022 09:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEFC680D1D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Sep 2022 09:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEFC680D1D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=YZ8U4K6N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qOTY8GW8gimn
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Sep 2022 09:29:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1A9580CE6
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1A9580CE6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Sep 2022 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C71C6601F04;
 Fri,  2 Sep 2022 10:29:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1662110991;
 bh=IGSthkjGK+x+uEz78lDRCkbgYZPKC+28kY/8J767G2A=;
 h=From:To:Cc:Subject:Date:From;
 b=YZ8U4K6N+mkeF3Mdc78Vd/xH6iCMIHE67TAFgh6lul3LkUiRaMeflxYBPUvj47lDY
 Xslx1QrczLNMfm2DvLvNGU5MjCndnXqeIumCqGc6sszyDRcA1B6yPyoNSmR62R9om0
 JcfOLq70wcbcZO79QiELWiYJYS9AfZ9iALE581Y2e6VE9tG2Gn+kZfenEI4ZUQZIwQ
 OcDJ76ATLXmOTFoZ2h5Set9PlyMfN/6UlT7GEAr9uQK8mkiHz2qyO8EwnC1LWTS3I1
 5fFItewXSqLLbW8BtT3LHZXLMIo8OAWXHA7BlWzYfIQd0a88oZMeufswDTfV5E6Tg6
 mKG+zltFVptGQ==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v5 0/1] docs: driver-api: virtio: virtio on Linux
Date: Fri,  2 Sep 2022 11:29:28 +0200
Message-Id: <20220902092929.955203-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 kernel@collabora.com, bagasdotme@gmail.com, mst@redhat.com
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

QmFzaWMgZG9jdW1lbnRhdGlvbiBhYm91dCB2aXJ0aW8gaW4gdGhlIGtlcm5lbCBhbmQgYSBzbWFs
bCB0dXRvcmlhbCBmb3IKdmlydGlvIGRyaXZlcnMuCgpUZXN0ZWQgb24ga2VybmVsL2dpdC9tc3Qv
dmhvc3QuZ2l0IChsaW51eC1uZXh0KQoKQ2hhbmdlcyBpbiB2NToKICAtIHJlbW92ZSBhbHJlYWR5
IG1lcmdlZCBwYXRjaAogIC0gZ3JhbW1hciBmaXhlcwogIC0gY2xhcmlmeSBzb21lIEFQSSBkZXRh
aWxzCiAgLSByZXdvcmsgZXhhbXBsZSBjb2RlCgpDaGFuZ2VzIGluIHY0OgogIC0gcmV3b3JkIHRo
ZSBpbnRybyBwYXJhZ3JhcGhzCiAgLSBncmFtbWFyIGZpeGVzCgpDaGFuZ2VzIGluIHYzOgogIC0g
Zml4IGNvbW1pdCBtZXNzYWdlIGluIHBhdGNoIDEKICAtIG1pbm9yIGFkZGl0aW9uYWwgZml4ZXMg
dG8gdmlydGlvIGtlcm5lbGRvY3MKICAtIHVzZSBwcm9wZXIgU3BoaW54IG1hcmt1cCBmb3IgbGlu
a3MgdG8gcmVmZXJlbmNlcwoKQ2hhbmdlcyBpbiB2MjoKICAtIHZpcnRpbyBzcGVjIGxpbmtzIHVw
ZGF0ZWQgdG8gdjEuMgogIC0gc2ltcGxpZnkgdmlydGlvLnJzdCBhbmQgcmVtb3ZlIG1vc3QgbG93
IGxldmVsIHBhcnRzIHRoYXQgYXJlCiAgICBhbHJlYWR5IGNvdmVyZWQgYnkgdGhlIHNwZWMKICAt
IHNwbGl0IHRoZSBrZXJuZWxkb2NzIGZpeGVzIHRvIGEgc2VwYXJhdGUgcGF0Y2gKICAtIHJlbW92
ZSA6YzpmdW5jOiByc3QgZm9ybWF0dGluZwoKUmljYXJkbyBDYcOxdWVsbyAoMSk6CiAgZG9jczog
ZHJpdmVyLWFwaTogdmlydGlvOiB2aXJ0aW8gb24gTGludXgKCiBEb2N1bWVudGF0aW9uL2RyaXZl
ci1hcGkvaW5kZXgucnN0ICAgICAgICAgICAgfCAgIDEgKwogRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL3ZpcnRpby9pbmRleC5yc3QgICAgIHwgIDExICsKIERvY3VtZW50YXRpb24vZHJpdmVyLWFw
aS92aXJ0aW8vdmlydGlvLnJzdCAgICB8IDE0NCArKysrKysrKysrKysrCiAuLi4vdmlydGlvL3dy
aXRpbmdfdmlydGlvX2RyaXZlcnMucnN0ICAgICAgICAgfCAxOTcgKysrKysrKysrKysrKysrKysr
CiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
NSBmaWxlcyBjaGFuZ2VkLCAzNTQgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0CiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0CiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby93cml0aW5nX3ZpcnRpb19k
cml2ZXJzLnJzdAoKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
