Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EEAC46467
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 11:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3CD941849;
	Wed, 11 Jan 2023 11:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3CD941849
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=HKFWNtzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrYFMvchGZu5; Wed, 11 Jan 2023 11:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB38141847;
	Wed, 11 Jan 2023 11:30:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB38141847
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D89EC0032;
	Wed, 11 Jan 2023 11:30:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DB9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 11:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21600404CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 11:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21600404CF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=HKFWNtzf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJqmSwDTaPkl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 11:30:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D499C404B5
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D499C404B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 11:30:45 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7F0A2B819EF;
 Wed, 11 Jan 2023 11:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48ECC433EF;
 Wed, 11 Jan 2023 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1673436642;
 bh=V+8wEdwTeBfWKOuKLnNsrHjcNV02ld2/uoosp2OJQrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HKFWNtzfVuJdXWx1cZMVTAR+crfJ5Iyil/cRG4A5VSH8HeWe7VWFKbpFF7K+F6Dxp
 htolbomAiq5o5/KuTntFmmXFTYPB6W5QHFWR4dWxuBcnqVTo/rlSg0jdc6Co6CvrSy
 K6TS25j4tkxDvqROXKHhjovV2A7CfVhE90m+umTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/16] virtio: move dev_to_virtio() to use
 container_of_const()
Date: Wed, 11 Jan 2023 12:30:13 +0100
Message-Id: <20230111113018.459199-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173;
 i=gregkh@linuxfoundation.org; h=from:subject;
 bh=V+8wEdwTeBfWKOuKLnNsrHjcNV02ld2/uoosp2OJQrw=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p5cYS1/cl7W7Ky0jzmHgkJS152c8fVvqMYRA1NBqUfB
 nY93dcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEjKMZFly4OzXlpOC1ux/2yC74On
 11jpuF9lOG+TF7Fd516j3oK7gR3jPnUXVerZHbXQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

The driver core is changing to pass some pointers as const, so move
dev_to_virtio() to use container_of_const() to handle this change.

dev_to_virtio() now properly keeps the const-ness of the pointer passed
into it, while as before it could be lost.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/virtio.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..2b472514c49b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -127,10 +127,7 @@ struct virtio_device {
 	void *priv;
 };
 
-static inline struct virtio_device *dev_to_virtio(struct device *_dev)
-{
-	return container_of(_dev, struct virtio_device, dev);
-}
+#define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status);
 int register_virtio_device(struct virtio_device *dev);
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
