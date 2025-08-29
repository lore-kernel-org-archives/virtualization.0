Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908D2135CE
	for <virtualization@lists.linux.dev>; Fri, 29 Aug 2025 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480224; cv=none; b=Dvn7km2uC2r1fBj4mQjEoiQBLDIwQ/Eh2+nMzpjjWMj6jnKn3KLHiFg2w6zBAHyz9E6OK7VYiLkMdtjAY2VHBZMaUtHStJkd+6Idt5x/fd6F/1R/CTT8uNjHky8srpCMgku/Y1cO88l3AoE0RYRkPfxhK7ygA1QTi7Uo0IdAWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480224; c=relaxed/simple;
	bh=qsV/u9Nwr0h7M/C3VeO1oeIS2ynCNx5VPqSz8xyvcZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbW0Yv2CaKlUE0Ck6dlaGLIW6vxoAPOBZuxc4HxfhBHXa7n72eLIDJgUhRvfSh3gOl54ov9Nz8U9fOVbfedtxxRN85qCnQOe6NhM7xHouMEGMZWsiuE/0gh4pUZ8HupOmbXSL9rTlys0GTGogYLVlTrEo63hUwTVimRfa7GJHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=OvGqZzsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WansO7sm; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="OvGqZzsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WansO7sm"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CD171D001E7;
	Fri, 29 Aug 2025 11:10:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 29 Aug 2025 11:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1756480218; x=1756566618; bh=5O3s3cpJyL9ApAILIp2T0
	tGI4d5H31t5BPcHpcF2ayA=; b=OvGqZzsx/FzdATbJoy0unXrm8eWlKJfc0OMiG
	MWVXwBK5LHIDIwz3bfF7R0bvL9wFqFaA/NZsfoVRs7jwC94cdVfNR85Yz0xNznrc
	owpw+EILrx5OnfhGsxCnxHu0wFjryXOc076zRQv/JTztKO0yI4hrp8xbqH1cqXHk
	mOOcP+a3BztT2oyZgCw2P8BUgzfqqE6nrK/R2vn8vsouDKOIfINU19qtuiNN379i
	7Ws5LUKl0YAjndvXcvSy6SCOiMHzRqDW14JVZPnhR0V2uMejhb1LDOqpZtqGMqMG
	YCQk/dckKvO/MuPyJYsIoma4Bjr1l9NiHqw2KiV8BivuFqF9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756480218; x=1756566618; bh=5O3s3cpJyL9ApAILIp2T0tGI4d5H31t5BPc
	HpcF2ayA=; b=WansO7smqDH58YZ0VWJCiw5PO+2UgGn4QVRtzvzn2NB5r4qUS7x
	sRPhndFcfDK3ZODb8xeRwYF4ikHC3XxgIEWup2eH2vWW1HK6eOhKOnx8gUpOai7C
	UQkqVIhzMPzZrWB3Vm2VMNicRLOtFbd74wq8+/+capo3YcSWZFiRKOypUKcehZd4
	vQKPAfo1zEN5y+GdLnKT6OiFIWQ3ytaR6B7ZUa4d9Hz3dGWDa1V/tjLal/JKA3d7
	7W/KqIDZMU2AXO10sJ1zmyv/rIZQCEEeIQYFtbXXmrhLDr8Yo163Y4y+crbIj8Ts
	NgfvJsQ6txQMdnksP4xtQA/EkcHHrpoD7kQ==
X-ME-Sender: <xms:2cKxaAo1SJNO-WANuasZO9muLaUaloYliqhstWgcUU26k0SSpGg-ew>
    <xme:2cKxaOAHpjTPnlh7wxiMOMOarNdIY2dK3Gyu6l8qKK6xlfvSr1BWmm00SLa_7VcaZ
    qbfbQBfsqyiOxvtmw>
X-ME-Received: <xmr:2cKxaKyeEhdwMvf0AmSxBk86cnWmPj45vNt40sLuOa2bmd6sxKXxl1BvWTbwi4tX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepueefiedvhe
    ffveegieejjeevgfejjeduveekffeiveeuvedvtedvhfelieeutdfgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepgihurghniihhuhhosehlihhnuhigrdgrlh
    hisggrsggrrdgtohhmpdhrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrth
    drtghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2cKxaD3zT-coK3j3igEonjeljXp6s9kRXB9_fW6k9fHkeMRs-zAC9A>
    <xmx:2cKxaCzNfgIsP4CEb7mMXbiV-m62ySFXkI2FoHoQNEk7rs5Wm9bvmg>
    <xmx:2cKxaCG4l5BRGTm6j2HHdOw2FhATmLM4f6mmb_0kUjCBk15tclmqgw>
    <xmx:2cKxaNZrwI6yRoNAzADiZOCjcDNpuPRTNrzRdAtyxqIRB2xTs-tNgw>
    <xmx:2sKxaKJVO60jLd2B0zYj9y0sFHnTjPxtpXdoex2wIOtroviN2_3Je6jd>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:10:17 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 214EE14F3423; Fri, 29 Aug 2025 17:10:06 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_config: clarify output parameters
Date: Fri, 29 Aug 2025 17:09:44 +0200
Message-ID: <20250829150944.233505-1-hi@alyssa.is>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was ambiguous enough for a broken patch (206cc44588f7 ("virtio:
reject shm region if length is zero")) to make it into the kernel, so
make it clearer.

Link: https://lore.kernel.org/r/20250816071600-mutt-send-email-mst@kernel.org/
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 include/linux/virtio_config.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8bf156dde554..7427b79d6f3d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -193,14 +193,15 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 }
 
 static inline void virtio_get_features(struct virtio_device *vdev,
-				       u64 *features)
+				       u64 *features_out)
 {
 	if (vdev->config->get_extended_features) {
-		vdev->config->get_extended_features(vdev, features);
+		vdev->config->get_extended_features(vdev, features_out);
 		return;
 	}
 
-	virtio_features_from_u64(features, vdev->config->get_features(vdev));
+	virtio_features_from_u64(features_out,
+		vdev->config->get_features(vdev));
 }
 
 /**
@@ -326,11 +327,11 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 
 static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
-			   struct virtio_shm_region *region, u8 id)
+			   struct virtio_shm_region *region_out, u8 id)
 {
 	if (!vdev->config->get_shm_region)
 		return false;
-	return vdev->config->get_shm_region(vdev, region, id);
+	return vdev->config->get_shm_region(vdev, region_out, id);
 }
 
 static inline bool virtio_is_little_endian(struct virtio_device *vdev)

base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
-- 
2.50.1

