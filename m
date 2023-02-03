Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18B3C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4368140105;
	Fri,  3 Feb 2023 10:04:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4368140105
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=TqjFeV9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id avAzWuffi-qI; Fri,  3 Feb 2023 10:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F72C41170;
	Fri,  3 Feb 2023 10:04:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F72C41170
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7522C0033;
	Fri,  3 Feb 2023 10:04:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59BEEC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28B1642A09
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28B1642A09
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=TqjFeV9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mhukgMSlyZc6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54767429B3
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54767429B3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:35 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id s13so1641937pgc.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvkPNyoI21L1O1ZXqnPivyYsybrN0iSYwKMSsS9iBxY=;
 b=TqjFeV9NPabsrfxavmrb7rr4cepsXNVmar2XDnjWglQ4DpUZOEWO0vbof2f6/PWByH
 TWPQ6ZPNP6HE8OHwVXgsN4cLeRU45MuHFl7+sXcxz/goXguLdPUp5EaQdczVZii0TnRU
 56+g060uaBaRC/sQePmL3oY2BIg34qhXBIIWyRDe2ZJzg3OPQbZuMcuHyZJUj2ri7cf0
 yuNBhzZootgd4cpgTrxv8MnVNn8cRif/DT/a2lN1/C7YIzMTvlQpeAyQHnRCn1WWpJru
 oR0UGu6lSvrN2WUAygdOHInk27VqgNpQPc+kJQyzjoYfNXIN4ID5G5JP2aK3zvTaHo0A
 1yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvkPNyoI21L1O1ZXqnPivyYsybrN0iSYwKMSsS9iBxY=;
 b=d7mBNT1KpwCgUuUG6kpWoWhF126nEOMp4A0PjGZBpKmVFxMwfY/PqOdbDSPUqxiTu9
 2ndWePYTi946QcysDTR9j5CYCVGvzKNpNh2ymqU2Hi7Rp3nGu6Wu9/dceMcs0lI92m/U
 4OkFf8UfFOxCR+qJ18W/pbXnf7cFxxmHmpuZ6J/oMeOk7e2Q4JuDBsJHgowYwjYe+8/F
 tx7zB+CvERaXvgl8TRcvZMAn35idXqir70pz4Kl7iBEpQXUI/0Oo3I9k641+fhiW6ok0
 bAqFjkyJDnx9dMSRYaN5JhsVPT4aO7P38mW1DfWQby/hyFSl6ChBclgDF3jveEDKHj2F
 4HZQ==
X-Gm-Message-State: AO0yUKWJpuUUkRbHHeJjLhnOvHyY3cgTVMOWjztwS4vmBSpyr2arOkKU
 FwxnvVz+z5Ebz9NwMxyuZqbEQw==
X-Google-Smtp-Source: AK7set+mf9v1p9GMNQBqGbUdP6b8/Tyam+p9edVCarZOEBqKLwxUJFvaDV8vt4ESUw73/JkS5RjeOw==
X-Received: by 2002:a05:6a00:23d6:b0:593:d111:a071 with SMTP id
 g22-20020a056a0023d600b00593d111a071mr10889148pfc.9.1675418674729; 
 Fri, 03 Feb 2023 02:04:34 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:04:34 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 2/4] virtio_ring: remove const from vring getter
Date: Fri,  3 Feb 2023 19:04:16 +0900
Message-Id: <20230203100418.2981144-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203100418.2981144-1-mie@igel.co.jp>
References: <20230203100418.2981144-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

There are some method to manage the virto ring in Linux kernel. e.g. vhost
and vringh. Remove const from the getter in order to control vring with
other APIs, such as vringh.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 drivers/virtio/virtio_ring.c | 2 +-
 include/linux/virtio.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2e7689bb933b..aa0c455d402b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2857,7 +2857,7 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
 
 /* Only available for split ring */
-const struct vring *virtqueue_get_vring(struct virtqueue *vq)
+struct vring *virtqueue_get_vring(struct virtqueue *vq)
 {
 	return &to_vvq(vq)->split.vring;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..83530b7bc2e9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -88,7 +88,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
 bool virtqueue_is_broken(struct virtqueue *vq);
 
-const struct vring *virtqueue_get_vring(struct virtqueue *vq);
+struct vring *virtqueue_get_vring(struct virtqueue *vq);
 dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
