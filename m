Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2FC07E9B
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 11:29:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8857C61F06
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 11:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8857C61F06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DE858381F;
	Tue,  6 Jul 2021 11:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5di2XTNWftCz; Tue,  6 Jul 2021 11:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C636834CB;
	Tue,  6 Jul 2021 11:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 133B7C0010;
	Tue,  6 Jul 2021 11:29:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FCA8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2F10401B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BBg31O-xnilQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:28:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD44400CD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 11:28:59 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AA2C61DEB;
 Tue,  6 Jul 2021 11:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570938;
 bh=D3kqwDzce5vvFp6UQZfFYga72P7A8DidK38IYwhSQG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mV8CNEkcr8JZH74lH/IECovIRSvGZCmvz5fTCp8oIo3QLBHFY7EodzbNx1vBmrXka
 I0MGLp+lAG61H04XjxKmU8aK134CZ2lRhjziPSqvqBGRSATl09jaWAh1f5YTULjL23
 fnqDaPt4YbVEwu6buKr+vdytLAaeC0ZWjr06GvngTTqroAo5NI8qcpof0Q92UgBeII
 +Bc9AcJWXaH19NyaT2bStG64AGCfYQ3kvGHbsL21tjNK7FacE28jE0SPqDFqnC3oyh
 Vne2L/Wml6xXP6c7M0QfuunUMAW79sRsz5uapE++Zo10N01oxurVTkLeNnz0Dkslj0
 uWotDJxQ1GJbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 08/35] drm/virtio: Fixes a potential NULL pointer
 dereference on probe failure
Date: Tue,  6 Jul 2021 07:28:20 -0400
Message-Id: <20210706112848.2066036-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112848.2066036-1-sashal@kernel.org>
References: <20210706112848.2066036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Xie Yongji <xieyongji@bytedance.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit 17f46f488a5d82c5568e6e786cd760bba1c2ee09 ]

The dev->dev_private might not be allocated if virtio_gpu_pci_quirk()
or virtio_gpu_init() failed. In this case, we should avoid the cleanup
in virtio_gpu_release().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20210517084913.403-1-xieyongji@bytedance.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index ba7855da7c7f..d8b2027730d0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -258,6 +258,9 @@ int virtio_gpu_driver_unload(struct drm_device *dev)
 	flush_work(&vgdev->config_changed_work);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 
+	if (!vgdev)
+		return;
+
 	virtio_gpu_modeset_fini(vgdev);
 	virtio_gpu_ttm_fini(vgdev);
 	virtio_gpu_free_vbufs(vgdev);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
