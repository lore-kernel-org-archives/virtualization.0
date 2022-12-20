Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121D5C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7056660670;
	Tue, 20 Dec 2022 10:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7056660670
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=gpq3qspi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c9hcsL6ADpaB; Tue, 20 Dec 2022 10:00:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80CEA60A9E;
	Tue, 20 Dec 2022 10:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80CEA60A9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F055FC0032;
	Tue, 20 Dec 2022 10:00:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF881C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7675C40134
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:00:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7675C40134
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=gpq3qspi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eRLaXBiPCv0f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:00:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C88E400D9
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C88E400D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id D671C660000F;
 Tue, 20 Dec 2022 10:00:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671530447;
 bh=nMaXknuesIFjYA8ox4APV4OBO3+IojYFI34ZeI/Te9k=;
 h=From:To:Cc:Subject:Date:From;
 b=gpq3qspiRzlvoR7mrHFfx/fzREj8XZjEQRe1sEpXGt5XkwytzLQdawm/oFdMGxLMH
 c1Aa/kbRiiMDDm/RrjgoWzasF3NcqaftAPwWIZ/SrhNDXXc/MI21mYqJmXRbEGO0T9
 RCUemlzKedztiBB42EmMyDa0xj9bT90G+Q0IIlbEBjxfX+N6oMhrLxb5L5Up7v+vgU
 ukqZ2fRGKQoLicCivjTjf/N3E/gQ19zPzmaZCGcMheCnKQw4Pi/fjyY3EVlzyP78Jt
 pm5r+83e7jjKbEGP5iPiswfe2K4QzZzveTCS4VOpenMdH/UIuGRHZC4F+CnO1O8B8B
 rljI8RNf3wFvw==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: mst@redhat.com
Subject: [PATCH v2] virtio: fix virtio_config_ops kerneldocs
Date: Tue, 20 Dec 2022 11:00:35 +0100
Message-Id: <20221220100035.2712449-1-ricardo.canuelo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Rml4ZXMgdHdvIHdhcm5pbmcgbWVzc2FnZXMgd2hlbiBidWlsZGluZyBodG1sZG9jczoKCiAgICB3
YXJuaW5nOiBkdXBsaWNhdGUgc2VjdGlvbiBuYW1lICdOb3RlJwogICAgd2FybmluZzogZXhwZWN0
aW5nIHByb3RvdHlwZSBmb3IgdmlydGlvX2NvbmZpZ19vcHMoKS4KICAgICAgICAgICAgIFByb3Rv
dHlwZSB3YXMgZm9yIHZxX2NhbGxiYWNrX3QoKSBpbnN0ZWFkCgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1uZXh0LzIwMjIxMjIwMTA1OTU2LjQ3ODY4NTJkQGNhbmIuYXV1Zy5v
cmcuYXUvClJlcG9ydGVkLWJ5OiBTdGVwaGVuIFJvdGh3ZWxsIDxzZnJAY2FuYi5hdXVnLm9yZy5h
dT4KU2lnbmVkLW9mZi1ieTogUmljYXJkbyBDYcOxdWVsbyA8cmljYXJkby5jYW51ZWxvQGNvbGxh
Ym9yYS5jb20+ClJldmlld2VkLWJ5OiBCYWdhcyBTYW5qYXlhIDxiYWdhc2RvdG1lQGdtYWlsLmNv
bT4gCi0tLQogaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA4ICsrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29u
ZmlnLmgKaW5kZXggNGI1MTc2NDljZmU4Li4yYjM0MzhkZTJjNGQgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCisrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oCkBAIC0xNiw4ICsxNiwxMCBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewogCXU2NCBs
ZW47CiB9OwogCit0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICop
OworCiAvKioKLSAqIHZpcnRpb19jb25maWdfb3BzIC0gb3BlcmF0aW9ucyBmb3IgY29uZmlndXJp
bmcgYSB2aXJ0aW8gZGV2aWNlCisgKiBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgLSBvcGVyYXRp
b25zIGZvciBjb25maWd1cmluZyBhIHZpcnRpbyBkZXZpY2UKICAqIE5vdGU6IERvIG5vdCBhc3N1
bWUgdGhhdCBhIHRyYW5zcG9ydCBpbXBsZW1lbnRzIGFsbCBvZiB0aGUgb3BlcmF0aW9ucwogICog
ICAgICAgZ2V0dGluZy9zZXR0aW5nIGEgdmFsdWUgYXMgYSBzaW1wbGUgcmVhZC93cml0ZSEgR2Vu
ZXJhbGx5IHNwZWFraW5nLAogICogICAgICAgYW55IG9mIEBnZXQvQHNldCwgQGdldF9zdGF0dXMv
QHNldF9zdGF0dXMsIG9yIEBnZXRfZmVhdHVyZXMvCkBAIC02OSw3ICs3MSw4IEBAIHN0cnVjdCB2
aXJ0aW9fc2htX3JlZ2lvbiB7CiAgKgl2ZGV2OiB0aGUgdmlydGlvX2RldmljZQogICoJVGhpcyBz
ZW5kcyB0aGUgZHJpdmVyIGZlYXR1cmUgYml0cyB0byB0aGUgZGV2aWNlOiBpdCBjYW4gY2hhbmdl
CiAgKgl0aGUgZGV2LT5mZWF0dXJlIGJpdHMgaWYgaXQgd2FudHMuCi0gKiBOb3RlOiBkZXNwaXRl
IHRoZSBuYW1lIHRoaXMgY2FuIGJlIGNhbGxlZCBhbnkgbnVtYmVyIG9mIHRpbWVzLgorICoJTm90
ZSB0aGF0IGRlc3BpdGUgdGhlIG5hbWUgdGhpcwljYW4gYmUgY2FsbGVkIGFueSBudW1iZXIgb2YK
KyAqCXRpbWVzLgogICoJUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJyb3Igc3RhdHVzCiAgKiBA
YnVzX25hbWU6IHJldHVybiB0aGUgYnVzIG5hbWUgYXNzb2NpYXRlZCB3aXRoIHRoZSBkZXZpY2Ug
KG9wdGlvbmFsKQogICoJdmRldjogdGhlIHZpcnRpb19kZXZpY2UKQEAgLTkxLDcgKzk0LDYgQEAg
c3RydWN0IHZpcnRpb19zaG1fcmVnaW9uIHsKICAqCUlmIGRpc2FibGVfdnFfYW5kX3Jlc2V0IGlz
IHNldCwgdGhlbiBlbmFibGVfdnFfYWZ0ZXJfcmVzZXQgbXVzdCBhbHNvIGJlCiAgKglzZXQuCiAg
Ki8KLXR5cGVkZWYgdm9pZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0cXVldWUgKik7CiBzdHJ1
Y3QgdmlydGlvX2NvbmZpZ19vcHMgewogCXZvaWQgKCpnZXQpKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCiAJCSAgICB2b2lkICpidWYsIHVuc2lnbmVkIGxlbik7
Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
