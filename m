Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C7BC4332F
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 06:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1009C404B2;
	Mon, 10 Oct 2022 06:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1009C404B2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZmZsg9+N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Gi00tU-iN_u; Mon, 10 Oct 2022 06:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74840400FE;
	Mon, 10 Oct 2022 06:44:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74840400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39A35C0032;
	Mon, 10 Oct 2022 06:44:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 108B7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 06:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD14A605BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 06:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD14A605BA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=ZmZsg9+N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXnFsQO5uuw0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 06:44:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 636A660073
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 636A660073
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 06:44:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id CFF196602298;
 Mon, 10 Oct 2022 07:44:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1665384258;
 bh=IGSthkjGK+x+uEz78lDRCkbgYZPKC+28kY/8J767G2A=;
 h=From:To:Cc:Subject:Date:From;
 b=ZmZsg9+NVNyJ+6nVXWvZbnb4CjqTaJ32PX7siPxC4HhPZTBxVZcPPZeDpZbaSlkvI
 +Q7mS5oz5JI1Cr1bYPHhHHtYvm35ZoHcFxCczMK+VO+z/Un80JaFBJ4i4gIOaXFd6X
 g3JKRFDBZXw9vtbeEu8wH+z1DU1mPJNUcXHGvTR3PuzXPviyXjPxSOJFfLhwQc8LbW
 s5JSuRJsnvQGNA/K7FrpvDysxxooeh+0akB08Q7jnS4QDTyAC4HSzWUvfM/18hCfYq
 6MPX0xC7f365EAhAm2VlZgFNko1hG5UPdBV8dqS6/T7SnYsfUUNefKHECQ79R2/OrR
 lceqlDPYF2wnw==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [RESEND PATCH v5 0/1] docs: driver-api: virtio: virtio on Linux
Date: Mon, 10 Oct 2022 08:43:58 +0200
Message-Id: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: corbet@lwn.net, mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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
