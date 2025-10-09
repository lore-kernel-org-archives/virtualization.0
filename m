Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4792DFA38
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009063; cv=none; b=CtKOJoYngUIoC0VEm1MxSRu+DCC5MSoPfV3BFM1Xt334dzttzhOkE2qKmWEtoIeIcLwluT1TcEYqDIifqcNt3xyzw7XNrcgQK5tWdiBqPvlehTkK0w9rLhEF8V17GOWg7Xn1xX96g6l6re919trhyaVCyhBm0oeLEs+l555aZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009063; c=relaxed/simple;
	bh=79q/stfmKaMpC4fkL/3uhckYgC59HswnU0O9ncOSM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fwvaQdFdbidCjdnsvf4HCBjv4VInifQpCaGY7D4WQJhJPUvGsAp1H3G/HNv/OYamnJEmoAw7d5bm1fMd1Cu4KPpjNVG/ulaFukXljuU8G6wIx1Y+OQkuXrZNO8cIUdt/i5cW3ROpP+ULbBpCQpCeOr/kfZLn1B0HHnri5mxshz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFOi4XSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFOi4XSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760009060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kmAH8BxjdJp2Pz1OPEFZHQJ5FGdMMYsLliyoe1z8SzI=;
	b=gFOi4XSJ4NBY42UpRUlh/QQUSPfUwJRvKUATECmm0X8NJGmfqg10tuGdLav25OoSDXoh5K
	++w3LYccM50weVOq22E0BN+ACOX4mpcnuTzSTmhaAhpq6IW/LbBZdmuQwD2L1TqCBtBFjR
	P+T1XYOAFs8dVdSeBcrSG+fURuRiZHE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-D2s3FbxsM9izqdsl7PN5hA-1; Thu, 09 Oct 2025 07:24:17 -0400
X-MC-Unique: D2s3FbxsM9izqdsl7PN5hA-1
X-Mimecast-MFC-AGG-ID: D2s3FbxsM9izqdsl7PN5hA_1760009057
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d77ae03937so32680591cf.3
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 04:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760009057; x=1760613857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmAH8BxjdJp2Pz1OPEFZHQJ5FGdMMYsLliyoe1z8SzI=;
        b=cj1Bv3xTUIiP8dnh1/HLJr8VqzwYc3BA7NDjnoB+APJhAYs1FjmAH1KCaG+nG07fGB
         fXGrRP+AUbgxAlsTDsG9XVlt8s+j+uPzIsG1xw1DoPnmqcWS+01hCzqH5s6J2TPyo2jp
         V3n7Czb6Yido2KVmyei5O2Ow6/LwntBIZX6HGhhIdCPR/BM+FBcOeNb1l4KQ+BCP732B
         mrdjjGCyvPFGB8RtfgVRG4jqyyM6vimKe/fLpzNlw21xtedioP5QjjhoD0mfNQTLPcI8
         zbl/U6rSQVbhPfqXA0F3GdEVAfG5YwkIl3Qw5NYDWwnzoaVGrQNkxXCvVVSKTxcnSHye
         9XAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxwvDUh/0OjPCEOvsQ8hUfq+jvh/LlKBhXTPUsb0bgnyVkBB4HJ+BFaGMkO+xD8NLf3TeKNFooGuyD8gbPUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkodTzj+F/P9aTqZbovKP4p2lNaE3xj9i1xqDY5uevKknZdXAq
	lUYmO7tdr+1tGOUyXdxnarR4fVIoym7Bl/qfgbDSfWGfPw0xi8b3/3vtaOXEtL/J8ra3UgkkWYI
	acZJpqgyZjoAwYha1eBhvFL40k6biCtNjNwJHPhmEidq2T21uzFSUEO5zCopO+MLnWzis
X-Gm-Gg: ASbGnctHhRMMC6DVtXYvLNbNdViXol3BYS+cIpmtXhSOmx9vqKmTwrcnkVVDhiscnLg
	9dJitq5YjUzYzCpVnAii+VK5PSneVanTRtDENB2yaU58+z3BlfpAliadXEGm1YZfakttAzZMMPi
	ofzPlImfyM53+qD05lRfeAy1NDBRdsipsk//PX4s2ov3tXCJJ6afHBibKYaDLzACY8Tm1wGUaTz
	/ip4uzn0V/Gi3SshOzxO8fSWJa7G3uRCsFzntaohKnL3HZTu4t4MH1/6BAPMAlN+z2AbJNooFS5
	PeSDrNZlgeLhasiXkeiPxD7NcTpxHDu1oZU=
X-Received: by 2002:ac8:5712:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4e6ead147abmr98992231cf.27.1760009056620;
        Thu, 09 Oct 2025 04:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1nScydZf2w9Y/RF1KZ/toaL4XHDC73RNqYYmsC+Y4XlTLrKctFUYrWVrZX9qDmWKcvcV1Q==
X-Received: by 2002:ac8:5712:0:b0:4b7:9ddb:abbd with SMTP id d75a77b69052e-4e6ead147abmr98991861cf.27.1760009056130;
        Thu, 09 Oct 2025 04:24:16 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cfd4334sm184991021cf.38.2025.10.09.04.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:24:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 07:24:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 2/3] virtio: words->dwords
Message-ID: <46f0fa4570b01988f9fe79b690cbeb93dcd52736.1760008798.git.mst@redhat.com>
References: <cover.1760008797.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1760008797.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2SOoqCcpWWHSfs3PPy0tzKjKuapRugfnbj7MJxXuTZE_1760009057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A "word" is 16 bit. 32 bit integers like virtio pci uses are not words,
they are actually dwords. Fix up the macro name accordingly.

Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
Cc: "Paolo Abeni" <pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 6 +++---
 include/linux/virtio_features.h        | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 9e503b7a58d8..4b619cc91bc7 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -401,7 +401,7 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->device_feature_select);
@@ -427,7 +427,7 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
 	int i;
 
 	virtio_features_zero(features);
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u64 cur;
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
@@ -448,7 +448,7 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	int i;
 
-	for (i = 0; i < VIRTIO_FEATURES_WORDS; i++) {
+	for (i = 0; i < VIRTIO_FEATURES_DWORDS; i++) {
 		u32 cur = features[i >> 1] >> (32 * (i & 1));
 
 		vp_iowrite32(i, &cfg->guest_feature_select);
diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
index bf41d8ec50ef..f41acb035af9 100644
--- a/include/linux/virtio_features.h
+++ b/include/linux/virtio_features.h
@@ -6,7 +6,7 @@
 
 #define VIRTIO_FEATURES_QWORDS	2
 #define VIRTIO_FEATURES_MAX	(VIRTIO_FEATURES_QWORDS * 64)
-#define VIRTIO_FEATURES_WORDS	(VIRTIO_FEATURES_QWORDS * 2)
+#define VIRTIO_FEATURES_DWORDS	(VIRTIO_FEATURES_QWORDS * 2)
 #define VIRTIO_BIT(b)		BIT_ULL((b) & 0x3f)
 #define VIRTIO_QWORD(b)		((b) >> 6)
 #define VIRTIO_DECLARE_FEATURES(name)			\
-- 
MST

