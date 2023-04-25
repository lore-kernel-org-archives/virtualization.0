Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F49C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 10:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9358404ED;
	Tue, 25 Apr 2023 10:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9358404ED
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256 header.s=20221208 header.b=fBjkFbUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9eX6Ku2NGDb; Tue, 25 Apr 2023 10:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1658C40489;
	Tue, 25 Apr 2023 10:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1658C40489
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDF1BC0036;
	Tue, 25 Apr 2023 10:23:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E97C7C0036
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 10:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1DC581DEB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 10:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D1DC581DEB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20221208.gappssmtp.com
 header.i=@igel-co-jp.20221208.gappssmtp.com header.a=rsa-sha256
 header.s=20221208 header.b=fBjkFbUr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4rNl3mglVxM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 10:22:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EEEE81BF4
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EEEE81BF4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 10:22:57 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1a686260adcso60587895ad.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20221208.gappssmtp.com; s=20221208; t=1682418176; x=1685010176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=65grNDAGbRwlyUHQpd0EqrZwm0CjizZXzog/WSwNZzg=;
 b=fBjkFbUrX9C7gMis+wxz4/gdT/CBktqndDpokeR5ZWpldmL4HqcRpC7O0Is+VZQND/
 pU1WWp8yy8sQeV9myQou3vjh53hQCxCc66mK7pszFWjiGd08G6WkXpx6bNIx46hGCCv8
 l1KiMaSYPcV3IGs3BJ2A8v4cmi1458b1U8IMoeLel0RWmTEdim39WKr/xuq129YjgZLM
 VxKKEu3DTmJGSgJDHpE1aH+UDqsyckv+m+KKxUFtbPE9wj4KpEz1rqOFQEfajLuxZb80
 0eh2fTBsPUDXG25Lfpu8NDNcNMMNojJ+Jtn0m/KdqxMi8tuwUvh8CAcOh3snU4qZbGZD
 cS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682418176; x=1685010176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65grNDAGbRwlyUHQpd0EqrZwm0CjizZXzog/WSwNZzg=;
 b=PfxJV0TxPLbTu5RM4zZkv6O4W2Tu9pgTG3NMI75kIvQZ8I8LFqqXBBh3wH6aFetJc3
 ftvurp0OOuU76nSY53rv5kvANQfAUik0/li7Wsk0lgtmQGONEY0O5ws25/WqWAv8teKC
 x782MVak/4IUWz9By9MynZ72SEYWKzO+vwxS+7brUkBYyYq0YUtPAt7wqaLJhYk+YHq0
 bkRObEIqL/4Ig0dDMZtAKEeEaOD2738MzW9E2FcV6OugQTwSvP14+foJji2Gg18cG4HD
 u9Yq0xkQr8agEAfmyprwzfmFxd7NzFtLTIoD7JuhIC1u3TFdXq9bRMnLHpSRMD24ho56
 38QA==
X-Gm-Message-State: AAQBX9fvOKLwvn12TvSlh5cU6xIibO5sCd4SkFkJrMoniWRfrrkEoM7e
 nAJjcffhkNGDkyQlrlC/6D5X7w==
X-Google-Smtp-Source: AKy350Zc37ESnPYxkBRq9Lwmk1WaZWPXmmPjx7nitckKNJn9o3DAxtxKsaNdu3oXR+SMGIt8Ro2aVw==
X-Received: by 2002:a17:902:fa46:b0:1a1:bff4:49e9 with SMTP id
 lb6-20020a170902fa4600b001a1bff449e9mr16284161plb.23.1682418176463; 
 Tue, 25 Apr 2023 03:22:56 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 iz17-20020a170902ef9100b001a6b42fd5fbsm7945953plb.183.2023.04.25.03.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 03:22:55 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH v3] vringh: IOMEM support
Date: Tue, 25 Apr 2023 19:22:50 +0900
Message-Id: <20230425102250.3847395-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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

Introduce a new memory accessor for vringh. It is able to use vringh to
virtio rings located on io-memory region.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---

Changes from v2: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/
- Focus on an adding io memory APIs
Remove vringh API unification and some fixes.
- Rebase on next-20230414

 drivers/vhost/Kconfig  |   6 ++
 drivers/vhost/vringh.c | 129 +++++++++++++++++++++++++++++++++++++++++
 include/linux/vringh.h |  33 +++++++++++
 3 files changed, 168 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..4b0dbb4a8ab3 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -6,6 +6,12 @@ config VHOST_IOTLB
 	  This option is selected by any driver which needs to support
 	  an IOMMU in software.
 
+config VHOST_RING_IOMEM
+	tristate
+	select VHOST_IOMEM
+	help
+	  This option enables vringh APIs to supports io memory space.
+
 config VHOST_RING
 	tristate
 	select VHOST_IOTLB
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 955d938eb663..ce5a88eecc05 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1604,4 +1604,133 @@ EXPORT_SYMBOL(vringh_need_notify_iotlb);
 
 #endif
 
+#if IS_REACHABLE(CONFIG_VHOST_RING_IOMEM)
+
+static inline int getu16_iomem(const struct vringh *vrh, u16 *val,
+			       const __virtio16 *p)
+{
+	*val = vringh16_to_cpu(vrh, ioread16(p));
+	return 0;
+}
+
+static inline int putu16_iomem(const struct vringh *vrh, __virtio16 *p, u16 val)
+{
+	iowrite16(cpu_to_vringh16(vrh, val), p);
+	return 0;
+}
+
+static inline int copydesc_iomem(const struct vringh *vrh, void *dst,
+				 const void *src, size_t len)
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
+static inline int xfer_from_iomem(const struct vringh *vrh, void *src,
+				  void *dst, size_t len)
+{
+	memcpy_fromio(dst, src, len);
+	return 0;
+}
+
+static inline int xfer_to_iomem(const struct vringh *vrh, void *dst, void *src,
+				size_t len)
+{
+	memcpy_toio(dst, src, len);
+	return 0;
+}
+
+int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
+		      bool weak_barriers, struct vring_desc *desc,
+		      struct vring_avail *avail, struct vring_used *used)
+{
+	return vringh_init_kern(vrh, features, num, weak_barriers, desc, avail,
+				used);
+}
+EXPORT_SYMBOL(vringh_init_iomem);
+
+int vringh_getdesc_iomem(struct vringh *vrh, struct vringh_kiov *riov,
+			 struct vringh_kiov *wiov, u16 *head, gfp_t gfp)
+{
+	int err;
+
+	err = __vringh_get_head(vrh, getu16_iomem, &vrh->last_avail_idx);
+	if (err < 0)
+		return err;
+
+	/* Empty... */
+	if (err == vrh->vring.num)
+		return 0;
+
+	*head = err;
+	err = __vringh_iov(vrh, *head, riov, wiov, no_range_check, NULL, gfp,
+			   copydesc_iomem);
+	if (err)
+		return err;
+
+	return 1;
+}
+EXPORT_SYMBOL(vringh_getdesc_iomem);
+
+ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
+			      void *dst, size_t len)
+{
+	return vringh_iov_xfer(vrh, riov, dst, len, xfer_from_iomem);
+}
+EXPORT_SYMBOL(vringh_iov_pull_iomem);
+
+ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
+			      const void *src, size_t len)
+{
+	return vringh_iov_xfer(vrh, wiov, (void *)src, len, xfer_to_iomem);
+}
+EXPORT_SYMBOL(vringh_iov_push_iomem);
+
+void vringh_abandon_iomem(struct vringh *vrh, unsigned int num)
+{
+	/* We only update vring_avail_event(vr) when we want to be notified,
+	 * so we haven't changed that yet.
+	 */
+	vrh->last_avail_idx -= num;
+}
+EXPORT_SYMBOL(vringh_abandon_iomem);
+
+int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len)
+{
+	struct vring_used_elem used;
+
+	used.id = cpu_to_vringh32(vrh, head);
+	used.len = cpu_to_vringh32(vrh, len);
+
+	return __vringh_complete(vrh, &used, 1, putu16_iomem, putused_iomem);
+}
+EXPORT_SYMBOL(vringh_complete_iomem);
+
+bool vringh_notify_enable_iomem(struct vringh *vrh)
+{
+	return __vringh_notify_enable(vrh, getu16_iomem, putu16_iomem);
+}
+EXPORT_SYMBOL(vringh_notify_enable_iomem);
+
+void vringh_notify_disable_iomem(struct vringh *vrh)
+{
+	__vringh_notify_disable(vrh, putu16_iomem);
+}
+EXPORT_SYMBOL(vringh_notify_disable_iomem);
+
+int vringh_need_notify_iomem(struct vringh *vrh)
+{
+	return __vringh_need_notify(vrh, getu16_iomem);
+}
+EXPORT_SYMBOL(vringh_need_notify_iomem);
+
+#endif /* CONFIG_VHOST_RING_IOMEM */
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index c3a8117dabe8..c03d045f7f3f 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -330,4 +330,37 @@ int vringh_need_notify_iotlb(struct vringh *vrh);
 
 #endif /* CONFIG_VHOST_IOTLB */
 
+#if IS_REACHABLE(CONFIG_VHOST_RING_IOMEM)
+
+int vringh_init_iomem(struct vringh *vrh, u64 features,
+		      unsigned int num, bool weak_barriers,
+		      struct vring_desc *desc,
+		      struct vring_avail *avail,
+		      struct vring_used *used);
+
+
+int vringh_getdesc_iomem(struct vringh *vrh,
+			 struct vringh_kiov *riov,
+			 struct vringh_kiov *wiov,
+			 u16 *head,
+			 gfp_t gfp);
+
+ssize_t vringh_iov_pull_iomem(struct vringh *vrh,
+			      struct vringh_kiov *riov,
+			      void *dst, size_t len);
+ssize_t vringh_iov_push_iomem(struct vringh *vrh,
+			      struct vringh_kiov *wiov,
+			      const void *src, size_t len);
+
+void vringh_abandon_iomem(struct vringh *vrh, unsigned int num);
+
+int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len);
+
+bool vringh_notify_enable_iomem(struct vringh *vrh);
+void vringh_notify_disable_iomem(struct vringh *vrh);
+
+int vringh_need_notify_iomem(struct vringh *vrh);
+
+#endif /* CONFIG_VHOST_RING_IOMEM */
+
 #endif /* _LINUX_VRINGH_H */

base-commit: d3f2cd24819158bb70701c3549e586f9df9cee67
prerequisite-patch-id: 760abbe8c981c52ccc421b8139e8999ab71619aa
prerequisite-patch-id: 99d8679ab4569545c8af401e84142c66312e953e
prerequisite-patch-id: aca81516aba75b58c8422d37c2dc7db2f61ffe92
prerequisite-patch-id: 3d76136200c4e55ba2c41681325f242859dd6dbd
prerequisite-patch-id: 47a994feb68d95412d81b0fd1fa27bc7ba05ae18
prerequisite-patch-id: a2f7fc3f35358f70b6dad4c919ce293b10295c4f
prerequisite-patch-id: 70e2ee32b945be96a0388f0ff564651ac9335220
prerequisite-patch-id: 2023690f9c47017b56d7f036332a5ca3ece6bde8
prerequisite-patch-id: 211e113fec6c450d13fbdb437ecfad67dec0a157
prerequisite-patch-id: f2bcd3168933886e4cd4c39e47446d1bd7cb2691
prerequisite-patch-id: 37b131560808733a0b8878e85a3d2a46d6ab02ca
prerequisite-patch-id: 79b0219a715cb5ace227d55666d62fdb2dcc6ffe
prerequisite-patch-id: 30f1740cd48a19aa1c3c93e625c740cae2845478
prerequisite-patch-id: 31989e4a521f2fc6f68c4ccdb6960035e87666a7
prerequisite-patch-id: 3948bb3e0c045e2ffff06a714d17bab16c94775d
prerequisite-patch-id: cf28e0115b9111bcb77aa9c710d98b2be93c7e89
prerequisite-patch-id: ebf2349c0ae1296663854eee2da0b43fe8972f9b
prerequisite-patch-id: fc570921d885a2a6000800b4022321e63f1650a5
prerequisite-patch-id: 1fd5219fef17c2bf2d76000207b25aae58c368f3
prerequisite-patch-id: 34e5f078202762fe69df471e97b51b1341cbdfa9
prerequisite-patch-id: 7fa5151b9e0488b48c2b9d1219152cfb047d6586
prerequisite-patch-id: 33cca272767af04ae9abe7af2f6cbb9972cc0b77
prerequisite-patch-id: bb1a6befc899dd97bcd946c2d76ce73675a1fa45
prerequisite-patch-id: 10be04dd92fa451d13676e91d9094b63cd7fbcf8
prerequisite-patch-id: 87b86eb4ce9501bba9c04ec81094ac9202392431
prerequisite-patch-id: a5ced28762bf6bd6419dae0e4413d02ccafd72c2
prerequisite-patch-id: 2db4c9603e00d69bb0184dabcc319e7f74f30305
prerequisite-patch-id: 41933f9d53e5e9e02efd6157b68ee7d92b10cfa2
prerequisite-patch-id: df3295b4cdde3a45eaf4c40047179698a4224d05
prerequisite-patch-id: 9e2fca9ab0ba2b935daa96f1745ff4c909792231
prerequisite-patch-id: 8948378099ba4d61e10a87e617d69ed2fc4104ae
prerequisite-patch-id: 5e7466f3f0d74880d1a574a1bd91b12091dcf3f5
prerequisite-patch-id: 902899e1cd53b7fcc7971f630aed103830fc3e3d
prerequisite-patch-id: 42126b180500f9ff123db78748972c6ece18ac57
prerequisite-patch-id: 5236a03ef574074f3c1009a52612051862b31eff
prerequisite-patch-id: adae1aa80df65bd02a9e3f4db490cf801c1c6119
prerequisite-patch-id: 22806fcabb973ee5f04ee6212db6161aab5bcbfc
prerequisite-patch-id: 6eb14cfdc2cf31e90556f6afe7361427a332e8dc
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
