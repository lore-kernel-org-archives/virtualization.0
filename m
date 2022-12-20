Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4983C10F1E
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 11:30:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05C1E408A0;
	Tue, 20 Dec 2022 11:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05C1E408A0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=QdyQgHDT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQrfny5K8iOL; Tue, 20 Dec 2022 11:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0E4BD40305;
	Tue, 20 Dec 2022 11:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E4BD40305
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98384C0032;
	Tue, 20 Dec 2022 11:30:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA02C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 864A5818C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 864A5818C4
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=QdyQgHDT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xcCqMUcNVLNE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:30:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7571081765
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7571081765
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 642A06602C60;
 Tue, 20 Dec 2022 11:30:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671535800;
 bh=LYORg+Xtzpeisr24t7s3wezJiYVuhF+cisQOQWpxxQ4=;
 h=From:To:Cc:Subject:Date:From;
 b=QdyQgHDTxvQzC2Lluc+13pCJW681PHpw4PnPNOCqiwN2pYQRUktcyq2PodBpTu89B
 2eME0Gfg7Y800IlPxdbf7e0i3UkUlTmZORz3WaYnrVCpHwuShGyYlqQ+eb23o+IgkF
 4CcLPLhjcK88fXTr85XhZbMdK1qPVGfKpmSpKT1Cc4lUEWef+YXYa2IQrvwodC6je6
 DvXCrYoum9gs1oMQBdW10zAdYtB6TN5Lx73YaS7Qary51Y8lBcPuqJi/CeS/hPkqTG
 NdHnu/0j0SC7+pHd0kYY2mHaP89g1UxTjaF0UxOUor+x/oVjWHDds2Wyt9HU1dpdgg
 Wj4L9GuhQkNtA==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: mst@redhat.com
Subject: [PATCH v3] virtio: fix virtio_config_ops kerneldocs
Date: Tue, 20 Dec 2022 12:29:43 +0100
Message-Id: <20221220112943.2727137-1-ricardo.canuelo@collabora.com>
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
cmcuYXUvCkZpeGVzOiAzMzM3MjNlOGJjMzkzZCAoImRvY3M6IGRyaXZlci1hcGk6IHZpcnRpbzog
dmlydGlvIG9uIExpbnV4IikKUmVwb3J0ZWQtYnk6IFN0ZXBoZW4gUm90aHdlbGwgPHNmckBjYW5i
LmF1dWcub3JnLmF1PgpTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIENhw7F1ZWxvIDxyaWNhcmRvLmNh
bnVlbG9AY29sbGFib3JhLmNvbT4KUmV2aWV3ZWQtYnk6IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90
bWVAZ21haWwuY29tPiAKLS0tCkNoYW5nZXMgaW4gdjM6CiAgLSBBZGRlZCBhIEZpeGVzIHRhZyBy
ZWZlcmVuY2luZyB0aGUgY29tbWl0IHRoYXQgcmV2ZWFsZWQgdGhlIHdhcm5pbmcKICAgIG1lc3Nh
Z2VzIChzdWdnZXN0ZWQgYnkgQmFnYXMgU2FuamF5YSBhbmQgTWljaGFlbCBTLiBUc2lya2luKQoK
Q2hhbmdlcyBpbiB2MjoKICAtIFJld29yZCB0aGUgIk5vdGUiIGNvbW1lbnQgaW4gdGhlIGtlcm5l
bGRvYyBzbyB0aGF0IGl0IGRvZXNuJ3QgbG9vawogICAgbGlrZSBhIGtlcm5lbGRvYyAiTm90ZSIg
c2VjdGlvbiAoc3VnZ2VzdGVkIGJ5IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsCiAgICBSZWdubykKICAt
IExpbmssIFJlcG9ydGVkLWJ5IGFuZCBSZXZpZXdlZC1ieSB0YWdzIGFkZGVkIChzdWdnZXN0ZWQg
YnkgQmFnYXMKICAgIFNhbmpheWEpCgogaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggfCA4
ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW9fY29uZmlnLmgKaW5kZXggNGI1MTc2NDljZmU4Li4yYjM0MzhkZTJjNGQgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCisrKyBiL2luY2x1ZGUvbGlu
dXgvdmlydGlvX2NvbmZpZy5oCkBAIC0xNiw4ICsxNiwxMCBAQCBzdHJ1Y3QgdmlydGlvX3NobV9y
ZWdpb24gewogCXU2NCBsZW47CiB9OwogCit0eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1
Y3QgdmlydHF1ZXVlICopOworCiAvKioKLSAqIHZpcnRpb19jb25maWdfb3BzIC0gb3BlcmF0aW9u
cyBmb3IgY29uZmlndXJpbmcgYSB2aXJ0aW8gZGV2aWNlCisgKiBzdHJ1Y3QgdmlydGlvX2NvbmZp
Z19vcHMgLSBvcGVyYXRpb25zIGZvciBjb25maWd1cmluZyBhIHZpcnRpbyBkZXZpY2UKICAqIE5v
dGU6IERvIG5vdCBhc3N1bWUgdGhhdCBhIHRyYW5zcG9ydCBpbXBsZW1lbnRzIGFsbCBvZiB0aGUg
b3BlcmF0aW9ucwogICogICAgICAgZ2V0dGluZy9zZXR0aW5nIGEgdmFsdWUgYXMgYSBzaW1wbGUg
cmVhZC93cml0ZSEgR2VuZXJhbGx5IHNwZWFraW5nLAogICogICAgICAgYW55IG9mIEBnZXQvQHNl
dCwgQGdldF9zdGF0dXMvQHNldF9zdGF0dXMsIG9yIEBnZXRfZmVhdHVyZXMvCkBAIC02OSw3ICs3
MSw4IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7CiAgKgl2ZGV2OiB0aGUgdmlydGlvX2Rl
dmljZQogICoJVGhpcyBzZW5kcyB0aGUgZHJpdmVyIGZlYXR1cmUgYml0cyB0byB0aGUgZGV2aWNl
OiBpdCBjYW4gY2hhbmdlCiAgKgl0aGUgZGV2LT5mZWF0dXJlIGJpdHMgaWYgaXQgd2FudHMuCi0g
KiBOb3RlOiBkZXNwaXRlIHRoZSBuYW1lIHRoaXMgY2FuIGJlIGNhbGxlZCBhbnkgbnVtYmVyIG9m
IHRpbWVzLgorICoJTm90ZSB0aGF0IGRlc3BpdGUgdGhlIG5hbWUgdGhpcwljYW4gYmUgY2FsbGVk
IGFueSBudW1iZXIgb2YKKyAqCXRpbWVzLgogICoJUmV0dXJucyAwIG9uIHN1Y2Nlc3Mgb3IgZXJy
b3Igc3RhdHVzCiAgKiBAYnVzX25hbWU6IHJldHVybiB0aGUgYnVzIG5hbWUgYXNzb2NpYXRlZCB3
aXRoIHRoZSBkZXZpY2UgKG9wdGlvbmFsKQogICoJdmRldjogdGhlIHZpcnRpb19kZXZpY2UKQEAg
LTkxLDcgKzk0LDYgQEAgc3RydWN0IHZpcnRpb19zaG1fcmVnaW9uIHsKICAqCUlmIGRpc2FibGVf
dnFfYW5kX3Jlc2V0IGlzIHNldCwgdGhlbiBlbmFibGVfdnFfYWZ0ZXJfcmVzZXQgbXVzdCBhbHNv
IGJlCiAgKglzZXQuCiAgKi8KLXR5cGVkZWYgdm9pZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0
cXVldWUgKik7CiBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgewogCXZvaWQgKCpnZXQpKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCiAJCSAgICB2b2lkICpidWYs
IHVuc2lnbmVkIGxlbik7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
