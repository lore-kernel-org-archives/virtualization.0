Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CD4E06DD;
	Wed, 16 Sep 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593102; cv=pass; b=SutUZcYIzZAu52gncYmxqFwqmSG2QqhtX+5r6SuPxZzPixxanHRBst0yp5ldlU2Fjz3Qyi8iT8sP6jVEaVpuZMPEqRk/rfoGVQdaBIMdVcjQNPHU6Dc8PswaC6wjO/52cqr6u/rb3Et4Hr/y9GfQ8YceMxF6+4qBd7kTQpq9BuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593102; c=relaxed/simple;
	bh=gf3EQAJ4VfBmxjFUqtfvGealL0LGSZYcwzq8jUweQJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OlQdflQom3zhfm2E4aJnXMkER4WCWXKfZbvTzLiHVpE+zIMMuOrrgy5ZPPSStxT4B8PdVxUBBX5mnJgph7dLmFgzF/3wCJyS54234X6DzDoyevCx3v/OLdoRnPgg0R1leqt9sgwzZVh2LBJmxx2JT5QrQU9SF/Ez7KEMp4p79Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=a4DubfgF; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=UX2aPUx3; arc=pass smtp.client-ip=185.56.87.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="a4DubfgF";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="UX2aPUx3"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; s=arckey; t=1789593079;
	 b=B7327Dmqhl/p9w1xAuP0katemTZ+tWRTD8tpoHs8k6ZdhWceKnDfuYHJfhpHl8bjsoWDwLzwHu
	  q4XzqUcjPvlbd/C6ybs9Vbyfx5c384AQPMpbPNAudu0gIA9anQLP77VrNlbSNXp69cyzJlkO/5
	  X6uP620PADmeoHQqZzLla0exnj3e4SkhKzpo7bFwnGqnhjqwRBNW17hwqCNskW00ItwS+nnRgV
	  gbsZFryK8LfFylOVurKoG9o5JoPU7YHtN/nD9miAk7NStzlzVwJdRRYmdrjDI0nqwU2yK/1UqM
	  OVhJAiF0GX8i5WhJ6AfF13Cfxda5f6+RA7MbhzyJ82nCjg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com; s=arckey; t=1789593079;
	bh=gf3EQAJ4VfBmxjFUqtfvGealL0LGSZYcwzq8jUweQJY=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=KojvhSDfdi+lIGghjL510W/T2kz1dsrvIxUuc0jMXwDXkvX8MbEUpS6+/3nvllTM5wbnVD6JiL
	  hCRnHtjnFdQ+YD1uilGeISS3ZeULWT7NOx1cjgsNe8BLUnyXxLMWH8YLbmw8IAK159MT53D1/f
	  eVqK4jgiDVrzRhNFB0Kj1aSm1hLnLRLJJLRCu4oqqT1XqNVLhDFSBsBAhT3eHwbw5O7Xmxi5we
	  peRW42mkUGNrOrUmKGKXMaAg94lVxdK5zDfv66C28qf2T1CXzsoKqaq6Fp99nMvE2GIZHPZ5LV
	  S8ggEqUdPnOn2oINof2feMxr4y4uW0F3Li2ktM5mXJpcFQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=4v98lwch7T5H/ou+qD354RhYPj13iFINK/7BGkYYthQ=; b=a4DubfgFZnwBQE23nrvaYv89kX
	OY4IvuSZsGoFtJQEpQNcz2AjB/4fBNnzVhbYbJUTWqY/sQei4RcBXOSJ8sWvHjd7SRsI7VrnJKaQ6
	6xM1qHu+/pDRlh3a4/LeX98liV6lu/ls3riUfa6lBqqvSab/xTgd/3DciPtvCSiHNf/E=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuQ-000000066hK-0L56;
	Wed, 16 Sep 2026 21:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=4v98lwch7T5H/ou+qD354RhYPj13iFINK/7BGkYYthQ=; b=UX2aPUx3q6a3d2PqiqvbhB34cD
	pFGpJtQIvSaG8lyEhGEYFH9jVXavg9I1QynXUN8Hyv9l/V9G16u/Z7vn1i9YWxlNfYy29qFL2PT6u
	YK7I9EVRr0FheZTAU97Rgq6ghBm9M2U0K4y3DJQVC+cYBmomxoO8stx84dVqSjJdSL7I=;
Received: from [95.233.221.121] (port=62880 helo=[192.168.178.175])
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x6wuL-0000000058P-08T9;
	Wed, 16 Sep 2026 21:11:09 +0000
From: Francesco Valla <francesco@valla.it>
Date: Wed, 16 Sep 2026 23:10:50 +0200
Subject: [PATCH RFC 05/12] remoteproc: always report VIRTIO_F_VERSION_1
 feature
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=francesco@valla.it;
 h=from:subject:message-id; bh=gf3EQAJ4VfBmxjFUqtfvGealL0LGSZYcwzq8jUweQJY=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFmrWR/vWa6u3bL7gcDtjYayjBmN07c8S/E4NHeLvPJpJ
 12xa08WdZSyMIhxMciKKbKErLtxb89c829pGxgfwcxhZQIZwsDFKQATuXiF4X+Yd+yHlK5n0pk3
 v3/ZdKJo0srTy+MP2Kbbu5jfMky40vmT4b+H2LI6W1nn9IMd3nyP1oeV7d0S2/loR0IJ25zwmWc
 +evMBAA==
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: e55674784afb1dd2297b22e72bf3cc18
X-AntiAbuse: ID - e55674784afb1dd2297b22e72bf3cc18
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x6wuQ-000000066hK-0L56-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4qwp.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

There is currently no way to report the VIRTIO_F_VERSION_1 using the
resource table alone, as the per-vdev feature array is limited to 32
bits.

Considering that the VirtIO 1.0 specification is now ~10 years old,
always report the VIRTIO_F_VERSION_1 feature, as some drivers depend on
it.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/remoteproc/remoteproc_virtio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 74e0da970f1d..cfd66d9d1c9e 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -249,7 +249,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
 
 	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
 
-	return rsc->dfeatures;
+	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
 }
 
 static void rproc_transport_features(struct virtio_device *vdev)
@@ -275,14 +275,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_rproc a chance to accept features. */
 	rproc_transport_features(vdev);
 
-	/* Make sure we don't have any features > 32 bits! */
-	BUG_ON((u32)vdev->features != vdev->features);
+	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
+	if (WARN_ON_ONCE((u32)vdev->features !=
+			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
+		return -1;
 
 	/*
 	 * Remember the finalized features of our vdev, and provide it
 	 * to the remote processor once it is powered on.
 	 */
-	rsc->gfeatures = vdev->features;
+	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
 
 	return 0;
 }

-- 
2.55.0

