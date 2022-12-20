Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F6C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 07:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CC938146A;
	Tue, 20 Dec 2022 07:37:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CC938146A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nHIVtLA7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDdWy6fmrrdi; Tue, 20 Dec 2022 07:37:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A72B5818C2;
	Tue, 20 Dec 2022 07:37:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A72B5818C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B626C0032;
	Tue, 20 Dec 2022 07:37:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01CB4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB54B400E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:37:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB54B400E2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=nHIVtLA7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JD33a1yu2gK0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3772400D9
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3772400D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 69AD76601810;
 Tue, 20 Dec 2022 07:37:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671521854;
 bh=A7n0VSq8cd0ak7dktr+xYbXSUP6klaKvgvHdAFhnEWQ=;
 h=From:To:Cc:Subject:Date:From;
 b=nHIVtLA7sGGmGpRU+qFlf0MltTc+ydchH+x82IqnCS8C+M3MsZKAfGsNnk6eK0Ct+
 4qJDCU8w/Ows0fwOAO5Inq46XiGY0NXJBsb1Ty3Pyi5w8cIQl9MjZlCtjmd+JS5VpA
 Nyfe078iV4QT+BYI3KU1M4JVqRPQBC6bbmzkNArG2PBrDOsZ5yAqmaQKlm6dV3ExDN
 rqoYpGGwy8K6cIwTKyUIArBsVq73eLdBcBv1MNlSCLK+xr1hC8+ohngqko9ZRIg40h
 sxyRZN5IF7WAgJQ35VvjLnt13qNGTLhibRbKn+Q2o/9QW7ZpV1xM+3OKFgG/3Ufvof
 bLt8jxGxSlW6A==
From: =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To: mst@redhat.com
Subject: [PATCH] virtio: fix virtio_config_ops kerneldocs
Date: Tue, 20 Dec 2022 08:37:09 +0100
Message-Id: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
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
dHlwZSB3YXMgZm9yIHZxX2NhbGxiYWNrX3QoKSBpbnN0ZWFkCgpTaWduZWQtb2ZmLWJ5OiBSaWNh
cmRvIENhw7F1ZWxvIDxyaWNhcmRvLmNhbnVlbG9AY29sbGFib3JhLmNvbT4KLS0tCiBpbmNsdWRl
L2xpbnV4L3ZpcnRpb19jb25maWcuaCB8IDkgKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dmlydGlvX2NvbmZpZy5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKaW5kZXggNGI1
MTc2NDljZmU4Li5mOWEzMzA2MmMwODkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlv
X2NvbmZpZy5oCisrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX2NvbmZpZy5oCkBAIC0xNiw4ICsx
NiwxMCBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewogCXU2NCBsZW47CiB9OwogCit0eXBl
ZGVmIHZvaWQgdnFfY2FsbGJhY2tfdChzdHJ1Y3QgdmlydHF1ZXVlICopOworCiAvKioKLSAqIHZp
cnRpb19jb25maWdfb3BzIC0gb3BlcmF0aW9ucyBmb3IgY29uZmlndXJpbmcgYSB2aXJ0aW8gZGV2
aWNlCisgKiBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMgLSBvcGVyYXRpb25zIGZvciBjb25maWd1
cmluZyBhIHZpcnRpbyBkZXZpY2UKICAqIE5vdGU6IERvIG5vdCBhc3N1bWUgdGhhdCBhIHRyYW5z
cG9ydCBpbXBsZW1lbnRzIGFsbCBvZiB0aGUgb3BlcmF0aW9ucwogICogICAgICAgZ2V0dGluZy9z
ZXR0aW5nIGEgdmFsdWUgYXMgYSBzaW1wbGUgcmVhZC93cml0ZSEgR2VuZXJhbGx5IHNwZWFraW5n
LAogICogICAgICAgYW55IG9mIEBnZXQvQHNldCwgQGdldF9zdGF0dXMvQHNldF9zdGF0dXMsIG9y
IEBnZXRfZmVhdHVyZXMvCkBAIC02OCw4ICs3MCw4IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lv
biB7CiAgKiBAZmluYWxpemVfZmVhdHVyZXM6IGNvbmZpcm0gd2hhdCBkZXZpY2UgZmVhdHVyZXMg
d2UnbGwgYmUgdXNpbmcuCiAgKgl2ZGV2OiB0aGUgdmlydGlvX2RldmljZQogICoJVGhpcyBzZW5k
cyB0aGUgZHJpdmVyIGZlYXR1cmUgYml0cyB0byB0aGUgZGV2aWNlOiBpdCBjYW4gY2hhbmdlCi0g
Kgl0aGUgZGV2LT5mZWF0dXJlIGJpdHMgaWYgaXQgd2FudHMuCi0gKiBOb3RlOiBkZXNwaXRlIHRo
ZSBuYW1lIHRoaXMgY2FuIGJlIGNhbGxlZCBhbnkgbnVtYmVyIG9mIHRpbWVzLgorICoJdGhlIGRl
di0+ZmVhdHVyZSBiaXRzIGlmIGl0IHdhbnRzLiBOb3RlOiBkZXNwaXRlIHRoZSBuYW1lIHRoaXMK
KyAqCWNhbiBiZSBjYWxsZWQgYW55IG51bWJlciBvZiB0aW1lcy4KICAqCVJldHVybnMgMCBvbiBz
dWNjZXNzIG9yIGVycm9yIHN0YXR1cwogICogQGJ1c19uYW1lOiByZXR1cm4gdGhlIGJ1cyBuYW1l
IGFzc29jaWF0ZWQgd2l0aCB0aGUgZGV2aWNlIChvcHRpb25hbCkKICAqCXZkZXY6IHRoZSB2aXJ0
aW9fZGV2aWNlCkBAIC05MSw3ICs5Myw2IEBAIHN0cnVjdCB2aXJ0aW9fc2htX3JlZ2lvbiB7CiAg
KglJZiBkaXNhYmxlX3ZxX2FuZF9yZXNldCBpcyBzZXQsIHRoZW4gZW5hYmxlX3ZxX2FmdGVyX3Jl
c2V0IG11c3QgYWxzbyBiZQogICoJc2V0LgogICovCi10eXBlZGVmIHZvaWQgdnFfY2FsbGJhY2tf
dChzdHJ1Y3QgdmlydHF1ZXVlICopOwogc3RydWN0IHZpcnRpb19jb25maWdfb3BzIHsKIAl2b2lk
ICgqZ2V0KShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAogCQkg
ICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBsZW4pOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
