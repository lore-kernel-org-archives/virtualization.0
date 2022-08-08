Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E61C3F6B0
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BCDF4032D;
	Mon,  8 Aug 2022 13:28:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BCDF4032D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HEV9qkGw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jNHfsnderGWT; Mon,  8 Aug 2022 13:28:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9617940306;
	Mon,  8 Aug 2022 13:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9617940306
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B6EAC0035;
	Mon,  8 Aug 2022 13:28:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8071C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A68578195D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A68578195D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=HEV9qkGw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTrGZjkDtRVg
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:28:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDCC681911
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDCC681911
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.152.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 436066601BCE;
 Mon,  8 Aug 2022 14:28:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1659965313;
 bh=SUDX6NTSdXKGMATBKcPwI5q+gjVM5I5rKpwTz8OwyOg=;
 h=From:To:Cc:Subject:Date:From;
 b=HEV9qkGwrfG/sRNqPOrhq0BD/jv+YQoIHytgEP/ORtiCZKxIgylKzmrvBS2umyOdS
 KfLIZVlwb1isK3OO87Kj0MTNSNtHnKm6lp3xxGkdF9ZvwL24d9/56b3c013bIRlmJn
 LlFJNr55MtC9VQLogMQnLKqfL4EOAUm9evfEQhVAsLIvbTQDObO7obf/i0tnLLjWo1
 EFfddoi24Vw7KdUuxFrWnSqUeicM65L2/tq5SryyNJh6elFEezfl9PcgPzC9mIoAgn
 7V/8BaqOJUe6fYnbP2oZEHqPvBt5uAlitEVEj2Qv8uxrvUgNgTGMAh7JUoEdllOx1a
 57X4mQhFVdQeA==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: linux-doc@vger.kernel.org
Subject: [PATCH v3 0/2] docs: driver-api: virtio: virtio on Linux
Date: Mon,  8 Aug 2022 15:27:35 +0200
Message-Id: <20220808132737.4070709-1-ricardo.canuelo@collabora.com>
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
dC0yMDIyMDgwMikKCkNoYW5nZXMgaW4gdjM6CiAgLSBmaXggY29tbWl0IG1lc3NhZ2UgaW4gcGF0
Y2ggMQogIC0gbWlub3IgYWRkaXRpb25hbCBmaXhlcyB0byB2aXJ0aW8ga2VybmVsZG9jcwogIC0g
dXNlIHByb3BlciBTcGhpbnggbWFya3VwIGZvciBsaW5rcyB0byByZWZlcmVuY2VzCgpDaGFuZ2Vz
IGluIHYyOgogIC0gdmlydGlvIHNwZWMgbGlua3MgdXBkYXRlZCB0byB2MS4yCiAgLSBzaW1wbGlm
eSB2aXJ0aW8ucnN0IGFuZCByZW1vdmUgbW9zdCBsb3cgbGV2ZWwgcGFydHMgdGhhdCBhcmUKICAg
IGFscmVhZHkgY292ZXJlZCBieSB0aGUgc3BlYwogIC0gc3BsaXQgdGhlIGtlcm5lbGRvY3MgZml4
ZXMgdG8gYSBzZXBhcmF0ZSBwYXRjaAogIC0gcmVtb3ZlIDpjOmZ1bmM6IHJzdCBmb3JtYXR0aW5n
CgpSaWNhcmRvIENhw7F1ZWxvICgyKToKICB2aXJ0aW86IGtlcm5lbGRvY3MgZml4ZXMgYW5kIGVu
aGFuY2VtZW50cwogIGRvY3M6IGRyaXZlci1hcGk6IHZpcnRpbzogdmlydGlvIG9uIExpbnV4Cgog
RG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2luZGV4LnJzdCAgICAgICAgICAgIHwgICAxICsKIERv
Y3VtZW50YXRpb24vZHJpdmVyLWFwaS92aXJ0aW8vaW5kZXgucnN0ICAgICB8ICAxMSArCiBEb2N1
bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QgICAgfCAxNTEgKysrKysrKysr
KysrKysKIC4uLi92aXJ0aW8vd3JpdGluZ192aXJ0aW9fZHJpdmVycy5yc3QgICAgICAgICB8IDE4
OSArKysrKysrKysrKysrKysrKysKIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArCiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jICAgICAgICAg
ICAgICAgICAgfCAgIDggKwogaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA2ICstCiBpbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaCAgICAgICAgICAg
ICAgICAgfCAgIDYgKy0KIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcmluZy5oICAgICAgICAg
ICAgICB8ICAxNiArLQogOSBmaWxlcyBjaGFuZ2VkLCAzNzggaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3Zp
cnRpby9pbmRleC5yc3QKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RyaXZlci1h
cGkvdmlydGlvL3ZpcnRpby5yc3QKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvdmlydGlvL3dyaXRpbmdfdmlydGlvX2RyaXZlcnMucnN0CgotLSAKMi4yNS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
