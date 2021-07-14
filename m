Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C4C07E9C
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 13:46:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DF6613BF
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 13:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DF6613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FD1960733;
	Wed, 14 Jul 2021 13:46:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcJx7cTmXY0w; Wed, 14 Jul 2021 13:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA2D36074D;
	Wed, 14 Jul 2021 13:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67077C0020;
	Wed, 14 Jul 2021 13:46:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C17CC000E;
 Wed, 14 Jul 2021 13:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87B31402EA;
 Wed, 14 Jul 2021 13:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LcH0tR2KllZ6; Wed, 14 Jul 2021 13:46:08 +0000 (UTC)
X-Greylist: delayed 05:50:02 by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtprelay.hostedemail.com (smtprelay0200.hostedemail.com
 [216.40.44.200])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67213402D2;
 Wed, 14 Jul 2021 13:46:08 +0000 (UTC)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 9EC7418282F1F;
 Wed, 14 Jul 2021 04:20:20 +0000 (UTC)
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay07.hostedemail.com (Postfix) with ESMTP id 8829C1844C6AC;
 Wed, 14 Jul 2021 04:20:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf20.hostedemail.com (Postfix) with ESMTPA id A90B018A600; 
 Wed, 14 Jul 2021 04:20:10 +0000 (UTC)
Message-ID: <8aa028a0117ecb51d209861f926a84ce74fe0c46.camel@perches.com>
Subject: Re: [PATCH v9 03/17] vdpa: Fix code indentation
From: Joe Perches <joe@perches.com>
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 jasowang@redhat.com,  stefanha@redhat.com, sgarzare@redhat.com,
 parav@nvidia.com, hch@infradead.org,  christian.brauner@canonical.com,
 rdunlap@infradead.org, willy@infradead.org,  viro@zeniv.linux.org.uk,
 axboe@kernel.dk, bcrl@kvack.org, corbet@lwn.net, 
 mika.penttila@nextfour.com, dan.carpenter@oracle.com, joro@8bytes.org, 
 gregkh@linuxfoundation.org, zhe.he@windriver.com, xiaodong.liu@intel.com
Date: Tue, 13 Jul 2021 21:20:09 -0700
In-Reply-To: <20210713084656.232-4-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-4-xieyongji@bytedance.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A90B018A600
X-Stat-Signature: w8c8skx4hq53kyxkkcs5f64b7rox7x57
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19IxVK6JNPE/co+tp8AToMXmxFv5EZRX50=
X-HE-Tag: 1626236410-955187
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 songmuchun@bytedance.com, linux-fsdevel@vger.kernel.org
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

On Tue, 2021-07-13 at 16:46 +0800, Xie Yongji wrote:
> Use tabs to indent the code instead of spaces.

There are a lot more of these in this file.

$ ./scripts/checkpatch.pl --fix-inplace --strict include/linux/vdpa.h

and a little typing gives:
---
 include/linux/vdpa.h | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 3357ac98878d4..14cd4248e59fd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
  * @last_used_idx: used index
  */
 struct vdpa_vq_state_packed {
-        u16	last_avail_counter:1;
-        u16	last_avail_idx:15;
-        u16	last_used_counter:1;
-        u16	last_used_idx:15;
+	u16	last_avail_counter:1;
+	u16	last_avail_idx:15;
+	u16	last_used_counter:1;
+	u16	last_used_idx:15;
 };
 
 struct vdpa_vq_state {
-     union {
-          struct vdpa_vq_state_split split;
-          struct vdpa_vq_state_packed packed;
-     };
+	union {
+		struct vdpa_vq_state_split split;
+		struct vdpa_vq_state_packed packed;
+	};
 };
 
 struct vdpa_mgmt_dev;
@@ -131,7 +131,7 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@state: pointer to returned state (last_avail_idx)
- * @get_vq_notification: 	Get the notification area for a virtqueue
+ * @get_vq_notification:	Get the notification area for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the notifcation area
@@ -277,13 +277,13 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
 					size_t size, const char *name);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
-			  container_of(__vdpa_alloc_device( \
-				       parent, config, \
-				       sizeof(dev_struct) + \
-				       BUILD_BUG_ON_ZERO(offsetof( \
-				       dev_struct, member)), name), \
-				       dev_struct, member)
+#define vdpa_alloc_device(dev_struct, member, parent, config, name)	\
+	container_of(__vdpa_alloc_device(parent, config,		\
+					 sizeof(dev_struct) +		\
+					 BUILD_BUG_ON_ZERO(offsetof(dev_struct,	\
+								    member)), \
+					 name),				\
+		     dev_struct, member)
 
 int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
 void vdpa_unregister_device(struct vdpa_device *vdev);
@@ -308,8 +308,8 @@ struct vdpa_driver {
 int __vdpa_register_driver(struct vdpa_driver *drv, struct module *owner);
 void vdpa_unregister_driver(struct vdpa_driver *drv);
 
-#define module_vdpa_driver(__vdpa_driver) \
-	module_driver(__vdpa_driver, vdpa_register_driver,	\
+#define module_vdpa_driver(__vdpa_driver)				\
+	module_driver(__vdpa_driver, vdpa_register_driver,		\
 		      vdpa_unregister_driver)
 
 static inline struct vdpa_driver *drv_to_vdpa(struct device_driver *driver)
@@ -339,25 +339,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
 static inline void vdpa_reset(struct vdpa_device *vdev)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
-        ops->set_status(vdev, 0);
+	ops->set_status(vdev, 0);
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = true;
-        return ops->set_features(vdev, features);
+	return ops->set_features(vdev, features);
 }
 
-
-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
+static inline void vdpa_get_config(struct vdpa_device *vdev,
+				   unsigned int offset,
 				   void *buf, unsigned int len)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
