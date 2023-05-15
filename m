Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D33C77B75
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 11:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A22E683BFE;
	Mon, 15 May 2023 11:51:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A22E683BFE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=igkrhFkh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJBaVujqvLa0; Mon, 15 May 2023 11:51:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BCEC83B97;
	Mon, 15 May 2023 11:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BCEC83B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14ACAC0036;
	Mon, 15 May 2023 11:51:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B64EEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8420E60E38
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8420E60E38
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=igkrhFkh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PZU_7TKJoGh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6235560D90
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6235560D90
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:07 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30639daee76so8165338f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684151465; x=1686743465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMyHC9pQClYTJqDoQAfkFzjBLC/t080M5U1EcEdPfZY=;
 b=igkrhFkh08x2YsMCeAvMMAe0SFfzztydrm3ZJjc2Mir8dj7yMFyFTFg3oGbORQH+Qs
 JUKLv3zrjMCxwbDxx+NDJPNTBzwiu+z890zD/yMw6MQzXOGLkwHSYKs+41zjQof3YiNn
 QueCkn46tIwyGN2YGjwmu7M5/MRFntdka8h0+bXa07wqnuDRadWjhKK7ZtVDBz33SRvK
 KK4/WYRVH6gHqvTf05MB+ikI7G8G7sS87fvyGCDNykmZxWauJTYeXA5suig9NrtAkV+9
 C1IrScTCKRZDuJqja2J8wsjPRVLPslxB5vhJIpBrIQ0p+c18sgoLkJGud7iX++L5kRME
 cAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684151465; x=1686743465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMyHC9pQClYTJqDoQAfkFzjBLC/t080M5U1EcEdPfZY=;
 b=TAc7EHiHuVRxZ9M0YmgZR6YKpQb1kCbeVdKkKArRWyTdg0yNwpHHf7/qZ/ywGoPamG
 t7cA4D/nLpTD/kNEwa/7PW2/r9wvFAOB38+xhmTwTDsOutAzPFbk7J6+n6o+7YaoLyWO
 fMTY4tzPFCWhtFJBytCYh5blNMz15dym3ZPBj+l9kPc23NKTrRTZGpS8mmQEIEGRE9vF
 f1CmZafy8xeQILB3iT8dzgZv9ByhcVtWkZ4sOTUXkFGqiy8Svhbao4qEatWIeCv3pw7e
 P1J2vh5ET/esb8XCKtNxJq0oToY3o01sNAqLmk+y/roEQtdjwfA437ot+9uTeXzabd6Y
 4eTQ==
X-Gm-Message-State: AC+VfDzjHINRIBVKErEUFUtn3jjjf1QzbIvsOoRLHe5FTprN0aXDsFxU
 3YTIgS6bN3BI9pqPVBOtnYLftQ==
X-Google-Smtp-Source: ACHHUZ5SZl/PE5+AtEId5xzehL1k3Eb4OG0FMa0JvJvuJtb/eeHROEXuFz/QNLebunUadXO3qsHKlQ==
X-Received: by 2002:adf:fc46:0:b0:2f4:9f46:6865 with SMTP id
 e6-20020adffc46000000b002f49f466865mr24451854wrs.30.1684151465528; 
 Mon, 15 May 2023 04:51:05 -0700 (PDT)
Received: from localhost.localdomain (5750a5b3.skybroadband.com.
 [87.80.165.179]) by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b003090cb7a9e6sm7555395wru.31.2023.05.15.04.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 04:51:05 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 1/2] iommu/virtio: Detach domain on endpoint release
Date: Mon, 15 May 2023 12:39:48 +0100
Message-Id: <20230515113946.1017624-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230515113946.1017624-1-jean-philippe@linaro.org>
References: <20230515113946.1017624-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, akihiko.odaki@daynix.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux.dev, robin.murphy@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

When an endpoint is released, for example a PCIe VF being destroyed or a
function hot-unplugged, it should be detached from its domain. Send a
DETACH request.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
v1: https://lore.kernel.org/linux-iommu/20230414150744.562456-1-jean-philippe@linaro.org/
v2: fixed nr_endpoints count reported by Eric
---
 drivers/iommu/virtio-iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5b..fd316a37d7562 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,6 +788,29 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void viommu_detach_dev(struct viommu_endpoint *vdev)
+{
+	int i;
+	struct virtio_iommu_req_detach req;
+	struct viommu_domain *vdomain = vdev->vdomain;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
+
+	if (!vdomain)
+		return;
+
+	req = (struct virtio_iommu_req_detach) {
+		.head.type	= VIRTIO_IOMMU_T_DETACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
+	}
+	vdomain->nr_endpoints--;
+	vdev->vdomain = NULL;
+}
+
 static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -990,6 +1013,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
