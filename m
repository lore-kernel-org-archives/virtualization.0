Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EFAC00140
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D47B61034;
	Wed, 10 Aug 2022 09:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D47B61034
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gHLcINrw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSQtEB_lgbet; Wed, 10 Aug 2022 09:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 365EB60ACA;
	Wed, 10 Aug 2022 09:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 365EB60ACA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E07CFC0033;
	Wed, 10 Aug 2022 09:40:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5F78C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 849A8823F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 849A8823F6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=gHLcINrw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhZoUQeqnUCV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 852BE823CF
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 852BE823CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id DDBAC6601BAA;
 Wed, 10 Aug 2022 10:40:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1660124427;
 bh=YZX+kiIG4cpbYyR+Bn8w24YD+SYOlAt7Tw6up4li+iw=;
 h=From:To:Cc:Subject:Date:From;
 b=gHLcINrw7JjoyZee1siZFL6E1O6XKFzOIv/AP6JtubcafdMt9Kox07B7qQs+gvYMl
 LlV1F1OWuAEIlEtZ6C+Z5Xaa+kpc4RMCmMpw6YkmslquRyKom66x3tc04yAKVMzmw9
 t1J/F57a0Pef7uJv97PtsJgaqxYd/ViOPm4Sn53egxvUGt/zp2MryI5op23eCBi+Bw
 8s8iiMhI6KYRlzmwMDYo8MmxqrSTQULznIZ+KSJdotEMp9jg3WhHomWCDNlk1MPY+V
 FSL8JN5fx/e6lvWMOfOiQSdwPGMeSvMzQM+S/LjNwzVFuzxd/vg83eXrGi0uzvA0Ru
 QJGPPKsN5TAUg==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v4 0/2] docs: driver-api: virtio: virtio on Linux
Date: Wed, 10 Aug 2022 11:40:02 +0200
Message-Id: <20220810094004.1250-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: mst@redhat.com, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, bagasdotme@gmail.com,
 kernel@collabora.com
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
bCB0dXRvcmlhbCBmb3IKdmlydGlvIGRyaXZlcnMuCgpUZXN0ZWQgb24gbGludXgtbmV4dCAobmV4
dC0yMDIyMDgwMikKCkNoYW5nZXMgaW4gdjQ6CiAgLSByZXdvcmQgdGhlIGludHJvIHBhcmFncmFw
aHMKICAtIGdyYW1tYXIgZml4ZXMKCkNoYW5nZXMgaW4gdjM6CiAgLSBmaXggY29tbWl0IG1lc3Nh
Z2UgaW4gcGF0Y2ggMQogIC0gbWlub3IgYWRkaXRpb25hbCBmaXhlcyB0byB2aXJ0aW8ga2VybmVs
ZG9jcwogIC0gdXNlIHByb3BlciBTcGhpbnggbWFya3VwIGZvciBsaW5rcyB0byByZWZlcmVuY2Vz
CgpDaGFuZ2VzIGluIHYyOgogIC0gdmlydGlvIHNwZWMgbGlua3MgdXBkYXRlZCB0byB2MS4yCiAg
LSBzaW1wbGlmeSB2aXJ0aW8ucnN0IGFuZCByZW1vdmUgbW9zdCBsb3cgbGV2ZWwgcGFydHMgdGhh
dCBhcmUKICAgIGFscmVhZHkgY292ZXJlZCBieSB0aGUgc3BlYwogIC0gc3BsaXQgdGhlIGtlcm5l
bGRvY3MgZml4ZXMgdG8gYSBzZXBhcmF0ZSBwYXRjaAogIC0gcmVtb3ZlIDpjOmZ1bmM6IHJzdCBm
b3JtYXR0aW5nCgpSaWNhcmRvIENhw7F1ZWxvICgyKToKICB2aXJ0aW86IGtlcm5lbGRvY3MgZml4
ZXMgYW5kIGVuaGFuY2VtZW50cwogIGRvY3M6IGRyaXZlci1hcGk6IHZpcnRpbzogdmlydGlvIG9u
IExpbnV4CgogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2luZGV4LnJzdCAgICAgICAgICAgIHwg
ICAxICsKIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0ICAgICB8ICAx
MSArKwogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0ICAgIHwgMTQ0
ICsrKysrKysrKysrKysrCiAuLi4vdmlydGlvL3dyaXRpbmdfdmlydGlvX2RyaXZlcnMucnN0ICAg
ICAgICAgfCAxODYgKysrKysrKysrKysrKysrKysrCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
YyAgICAgICAgICAgICAgICAgIHwgICA4ICsKIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNiArLQogaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgg
ICAgICAgICAgICAgICAgIHwgICA2ICstCiBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3Jpbmcu
aCAgICAgICAgICAgICAgfCAgMTYgKy0KIDkgZmlsZXMgY2hhbmdlZCwgMzY4IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZHJp
dmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kcml2ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0CiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdAoKLS0g
CjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
