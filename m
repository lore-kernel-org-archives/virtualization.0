Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23689C19F2D
	for <virtualization@archiver.kernel.org>; Thu,  4 Aug 2022 10:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9AAC440A0E;
	Thu,  4 Aug 2022 10:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AAC440A0E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=h6xTURdS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23goVtBfy6q2; Thu,  4 Aug 2022 10:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E14B940278;
	Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E14B940278
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B30F3C0033;
	Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D136C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 081AA8144A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 081AA8144A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=h6xTURdS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kFOjDx28L7tY
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCF05813A8
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCF05813A8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Aug 2022 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4226066017FE;
 Thu,  4 Aug 2022 11:59:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659610771;
 bh=gyorcD6t+hcnTKyxLrLWKuNsPkfd8aiFSo6fHZC/mJc=;
 h=From:To:Cc:Subject:Date:From;
 b=h6xTURdSSyAbpz8OCGp38LJGkEg4CfkR5AO7oHnEPO6qUQjsXb5GnQ6z9u70lHkuV
 cD5QZtjOjBeUwTMscWsktQhAF7ZE0+TFG/gLNr/Aq4op8h5otkgEqhNPsmSoKPtvVX
 IT2pNYSHx1kXb2A7HoUO1PFWU0zpzHLutgYLZMp5ZxJgHgHkC8oZgwswYCeQSt0ev0
 re8CfNXRi0OgHBcRC5vhSJ5nU93oAIDUztQGkxxL+CYBOd9+MjsJrmQ8CUV6Hcb7U8
 pqqUIcS1RjhUTy7HLlOYb2Sw4qA9PiOQQQXlS8RMYDqMfV6i/S2MlfA4Vhm7kBHn8J
 GqFZDHwC8OPDw==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] docs: driver-api: virtio: virtio on Linux
Date: Thu,  4 Aug 2022 12:59:12 +0200
Message-Id: <20220804105914.3707389-1-ricardo.canuelo@collabora.com>
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
dC0yMDIyMDgwMikKCkNoYW5nZXMgaW4gdjI6CiAgLSB2aXJ0aW8gc3BlYyBsaW5rcyB1cGRhdGVk
IHRvIHYxLjIKICAtIHNpbXBsaWZ5IHZpcnRpby5yc3QgYW5kIHJlbW92ZSBtb3N0IGxvdyBsZXZl
bCBwYXJ0cyB0aGF0IGFyZQogICAgYWxyZWFkeSBjb3ZlcmVkIGJ5IHRoZSBzcGVjCiAgLSBzcGxp
dCB0aGUga2VybmVsZG9jcyBmaXhlcyB0byBhIHNlcGFyYXRlIHBhdGNoCiAgLSByZW1vdmUgOmM6
ZnVuYzogcnN0IGZvcm1hdHRpbmcKClJpY2FyZG8gQ2HDsXVlbG8gKDIpOgogIHZpcnRpbzoga2Vy
bmVsZG9jcyBmaXhlcyBhbmQgZW5oYW5jZW1lbnRzCiAgZG9jczogZHJpdmVyLWFwaTogdmlydGlv
OiB2aXJ0aW8gb24gTGludXgKCiBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvaW5kZXgucnN0ICAg
ICAgICAgICAgfCAgIDEgKwogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby9pbmRleC5y
c3QgICAgIHwgIDExICsKIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJz
dCAgICB8IDE1MSArKysrKysrKysrKysrKwogLi4uL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2
ZXJzLnJzdCAgICAgICAgIHwgMTg5ICsrKysrKysrKysrKysrKysrKwogTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsKIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgICAgICAgICAgICAgICAgICB8ICAgOCArCiBpbmNsdWRlL2xpbnV4L3ZpcnRp
by5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKy0KIGluY2x1ZGUvbGludXgvdmlydGlv
X2NvbmZpZy5oICAgICAgICAgICAgICAgICB8ICAgNiArLQogaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19yaW5nLmggICAgICAgICAgICAgIHwgIDE2ICstCiA5IGZpbGVzIGNoYW5nZWQsIDM3OCBp
bnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL2luZGV4LnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vdmlydGlvLnJzdAogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192aXJ0aW9fZHJpdmVy
cy5yc3QKCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
