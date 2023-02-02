Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF48EC64EC3
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 09:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8656B40BF9;
	Thu,  2 Feb 2023 09:10:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8656B40BF9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=GH6KARO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8XFzSuCce1M; Thu,  2 Feb 2023 09:10:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F27E740C0A;
	Thu,  2 Feb 2023 09:10:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F27E740C0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4576C0082;
	Thu,  2 Feb 2023 09:10:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8ECC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 050FF81EC0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:10:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 050FF81EC0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=GH6KARO7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3bE94Xss1sV9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54C7A81EA5
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54C7A81EA5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 09:09:59 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 cq16-20020a17090af99000b0022c9791ac39so4933132pjb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 01:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcO0uxyztK7wrPRESDhnWawV9bJajYCn05I6EVJHO1Q=;
 b=GH6KARO7thcAXAecHFCRqv2AThKvwRpSynFUPRyr/OZKPlK2yL0fvDQhRTEuxWPbag
 soLM3KjFH60hrsUUukVibYDKMQm0sViyKG5mYZqPbfML2bae+Go5bIdqdw9B901M7ibu
 wNT7zORKjzFmfIR2oCiVQM3HJyrFKC2BPqVxmkD7X27/Tbuv0DsrL5dChFH+9/NwvzIQ
 EUYkhc2ftdhCYgF8ACeakDBIlsNguRxNJ82koXMxpahyWP6KNfGH647dLQIQkSf08b9Y
 Kg9/9k7MncrjLlOlQrFvpRobgAOYtK7H68cuL5RxgyxNu+F+hxjmjIGD1BbGwHe4fB3M
 210w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcO0uxyztK7wrPRESDhnWawV9bJajYCn05I6EVJHO1Q=;
 b=hr0ev+YGAuqK8IupSSRiDhc+2xjJIMVTohYtnez0oZ7uviibfV/s7TIxL+Xtq5GeBT
 fdtpjxME8EqQOCv4y2pBbSvI2XBcV45a6LqarXavcoXeI8n97Q9VMqO06TJgW4UJu7Xr
 xOSGraPjRidG7GwRyffW0roTtDL4kY60MtKFSE9omagDlH/AwPayjhpd1MdBXKOBxvB2
 ex+LNOElV0krPr1RuhfBwoOklx7c9wKpskopT6V6ofDY6l2SrfN8P3YNlvj5aW8azqMX
 J8fKcMBPNOQPyUC3iRuJJVtNZO1oKSgemvfcMdulR1X/VByTXZitJDdDD90z8J0qmdMO
 WhCg==
X-Gm-Message-State: AO0yUKWJpnxb93GSl8f7rrLrUYC5RwniUSu9iD2PVdGP6giHh8Adh7kD
 3u8xhAaVAn4+KDTZN8l6/9U/8w==
X-Google-Smtp-Source: AK7set/fXvDEmBQhH8c6B3dTk3eGn1u6YNr6DVl3bDrXS4EUzT2lgnlUWdYhoNLU3kNmqiqzSmYyqg==
X-Received: by 2002:a17:903:2303:b0:195:f06f:84fc with SMTP id
 d3-20020a170903230300b00195f06f84fcmr7368514plh.40.1675328998631; 
 Thu, 02 Feb 2023 01:09:58 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 ik12-20020a170902ab0c00b001929827731esm13145968plb.201.2023.02.02.01.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 01:09:58 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH v2 7/7] vringh: IOMEM support
Date: Thu,  2 Feb 2023 18:09:34 +0900
Message-Id: <20230202090934.549556-8-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202090934.549556-1-mie@igel.co.jp>
References: <20230202090934.549556-1-mie@igel.co.jp>
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Shunsuke Mie <mie@igel.co.jp>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

This patch introduces the new memory accessor for vringh. It is able to
use vringh to virtio rings located on iomemory region.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/vhost/Kconfig  |  6 ++++
 drivers/vhost/vringh.c | 76 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/vringh.h |  8 +++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..a79a4efbc817 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -6,6 +6,12 @@ config VHOST_IOTLB
 	  This option is selected by any driver which needs to support
 	  an IOMMU in software.
 
+config VHOST_IOMEM
+	tristate
+	select VHOST_RING
+	help
+	  Generic IOMEM implementation for vhost and vringh.
+
 config VHOST_RING
 	tristate
 	select VHOST_IOTLB
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 46fb315483ed..e3d9c7281ad0 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -18,6 +18,9 @@
 #include <linux/highmem.h>
 #include <linux/vhost_iotlb.h>
 #endif
+#if IS_REACHABLE(CONFIG_VHOST_IOMEM)
+#include <linux/io.h>
+#endif
 #include <uapi/linux/virtio_config.h>
 
 static __printf(1,2) __cold void vringh_bad(const char *fmt, ...)
@@ -1165,4 +1168,77 @@ EXPORT_SYMBOL(vringh_set_iotlb);
 
 #endif
 
+#if IS_REACHABLE(CONFIG_VHOST_IOMEM)
+
+/* io-memory space access helpers. */
+static int getu16_iomem(const struct vringh *vrh, u16 *val, const __virtio16 *p)
+{
+	*val = vringh16_to_cpu(vrh, ioread16(p));
+	return 0;
+}
+
+static int putu16_iomem(const struct vringh *vrh, __virtio16 *p, u16 val)
+{
+	iowrite16(cpu_to_vringh16(vrh, val), p);
+	return 0;
+}
+
+static int copydesc_iomem(const struct vringh *vrh, void *dst, const void *src,
+			  size_t len)
+{
+	memcpy_fromio(dst, src, len);
+	return 0;
+}
+
+static int putused_iomem(const struct vringh *vrh, struct vring_used_elem *dst,
+			 const struct vring_used_elem *src, unsigned int num)
+{
+	memcpy_toio(dst, src, num * sizeof(*dst));
+	return 0;
+}
+
+static int xfer_from_iomem(const struct vringh *vrh, void *src, void *dst,
+			   size_t len)
+{
+	memcpy_fromio(dst, src, len);
+	return 0;
+}
+
+static int xfer_to_iomem(const struct vringh *vrh, void *dst, void *src,
+			 size_t len)
+{
+	memcpy_toio(dst, src, len);
+	return 0;
+}
+
+static struct vringh_ops iomem_vringh_ops = {
+	.getu16 = getu16_iomem,
+	.putu16 = putu16_iomem,
+	.xfer_from = xfer_from_iomem,
+	.xfer_to = xfer_to_iomem,
+	.putused = putused_iomem,
+	.copydesc = copydesc_iomem,
+	.range_check = no_range_check,
+	.getrange = NULL,
+};
+
+int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
+		      bool weak_barriers, gfp_t gfp, struct vring_desc *desc,
+		      struct vring_avail *avail, struct vring_used *used)
+{
+	int err;
+
+	err = __vringh_init(vrh, features, num, weak_barriers, gfp, desc, avail,
+			    used);
+	if (err)
+		return err;
+
+	memcpy(&vrh->ops, &iomem_vringh_ops, sizeof(iomem_vringh_ops));
+
+	return 0;
+}
+EXPORT_SYMBOL(vringh_init_iomem);
+
+#endif
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 89c73605c85f..420c2d0ed398 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -265,4 +265,12 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 
 #endif /* CONFIG_VHOST_IOTLB */
 
+#if IS_REACHABLE(CONFIG_VHOST_IOMEM)
+
+int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
+		      bool weak_barriers, gfp_t gfp, struct vring_desc *desc,
+		      struct vring_avail *avail, struct vring_used *used);
+
+#endif /* CONFIG_VHOST_IOMEM */
+
 #endif /* _LINUX_VRINGH_H */
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
