Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EF4C6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6049340AB7;
	Thu,  2 Mar 2023 11:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6049340AB7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LzZhADpv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BH4H6T-RZevc; Thu,  2 Mar 2023 11:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AAA05400F6;
	Thu,  2 Mar 2023 11:35:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAA05400F6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 843C0C0035;
	Thu,  2 Mar 2023 11:35:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4ED03C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29A2C8202E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29A2C8202E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LzZhADpv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5HcJADP2o2XQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4010582028
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4010582028
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ei7n2l78e4NFmvUi+bOVTMUuSnDAXEzTgyerL27l10=;
 b=LzZhADpvoB/tvemacZK9HdDicNid1TvTdtBKXBL5uBjds33iVeA6aopALj2rEjwryKkqRB
 tLm+st2edDvXPisEQ32SjXokNHJ9fAZlYRgk2iv5sn2cRMZVj49Bb6w6kc0qUzGr/JsVwE
 DEcT07E51cfEFkkXGCFeI9P1ci/5lSo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-ugcjta0SMwah7ZVgaZPmAw-1; Thu, 02 Mar 2023 06:35:45 -0500
X-MC-Unique: ugcjta0SMwah7ZVgaZPmAw-1
Received: by mail-qv1-f71.google.com with SMTP id
 s18-20020a0cf792000000b00572c04240f1so8655324qvn.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ei7n2l78e4NFmvUi+bOVTMUuSnDAXEzTgyerL27l10=;
 b=QlbfhmDihTm9Afsm1BI/xeGyDNUpJlfj54uDtDbHvVVKJBLkgiBlpTlvFM5Ka4Y6NL
 laUAaHn2jB2puJydLGLgxV6HTuR6scH9uiCyLhjM54+IgxnEgNK4ppMEea2Bd6i2t2b/
 I5xr2SeWBh7WhLZDqtMjQZCTXtKzIdQks18h4nv7j/UcEPCUkHNHmGCwTq2VYgT+gLE0
 WGHz/019QafxR/8tN8GB/rTI7f2BJAG0YyXVFGyTCvwqEykukp7uxl/8cjHbnGqAkoUT
 s3Of9B7FVqQM77H2IX28ACHMF1lyFP0HZD3EGkW3ASyOCONY7cc8auDRi4KzepkR0yDU
 2Z6A==
X-Gm-Message-State: AO0yUKVIUS9WJ+AhaAWmJ1fGYVNfItLxEZuXoHQCxqYeXK8LlXNhk4V1
 M2onHQHkdH4tlMby2ae0OhMuBzArQsszZHXy5+8G0Y26DeaE0CanpAOTyCq11bUTH33735bugeA
 voj2GWlFPoc/Msl2qzRXP4DSnMmy46JMelxXvf/fmTlq+4ve33HDcNVpg8VFqjpBum0AIoqtJhN
 OUp0sXM9e7BDlruziHUOiKzSQ=
X-Received: by 2002:a05:6214:23cc:b0:56f:796e:c3a5 with SMTP id
 hr12-20020a05621423cc00b0056f796ec3a5mr15695886qvb.4.1677756944646; 
 Thu, 02 Mar 2023 03:35:44 -0800 (PST)
X-Google-Smtp-Source: AK7set8Ak8Ucf6C6K7kn5+/O12tTcTPMHjMyg5Hg/gChXMJzzgv24g/Sgnux1N4dFSCrO8nMsW3JDg==
X-Received: by 2002:a05:6214:23cc:b0:56f:796e:c3a5 with SMTP id
 hr12-20020a05621423cc00b0056f796ec3a5mr15695849qvb.4.1677756944236; 
 Thu, 02 Mar 2023 03:35:44 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 m26-20020ae9e01a000000b00741d87eb5d1sm10630925qkk.105.2023.03.02.03.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:35:43 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 8/8] vdpa_sim: add support for user VA
Date: Thu,  2 Mar 2023 12:34:21 +0100
Message-Id: <20230302113421.174582-9-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

The new "use_va" module parameter (default: false) is used in
vdpa_alloc_device() to inform the vDPA framework that the device
supports VA.

vringh is initialized to use VA only when "use_va" is true and the
user's mm has been bound. So, only when the bus supports user VA
(e.g. vhost-vdpa).

vdpasim_mm_work_fn work is used to attach the kthread to the user
address space when the .bind_mm callback is invoked, and to detach
it when the .unbind_mm callback is invoked.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - `use_va` set to true by default [Eugenio]
    - supported the new unbind_mm callback [Jason]
    - removed the unbind_mm call in vdpasim_do_reset() [Jason]
    - avoided to release the lock while call kthread_flush_work() since we
      are now using a mutex to protect the device state

 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 98 +++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 4774292fba8c..3a42887d05d9 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -59,6 +59,7 @@ struct vdpasim {
 	struct vdpasim_virtqueue *vqs;
 	struct kthread_worker *worker;
 	struct kthread_work work;
+	struct mm_struct *mm_bound;
 	struct vdpasim_dev_attr dev_attr;
 	/* mutex to synchronize virtqueue state */
 	struct mutex mutex;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index a28103a67ae7..eda26bc33df5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -35,10 +35,77 @@ module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 		 "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
 
+static bool use_va = true;
+module_param(use_va, bool, 0444);
+MODULE_PARM_DESC(use_va, "Enable/disable the device's ability to use VA");
+
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
 
+struct vdpasim_mm_work {
+	struct kthread_work work;
+	struct mm_struct *mm;
+	bool bind;
+	int ret;
+};
+
+static void vdpasim_mm_work_fn(struct kthread_work *work)
+{
+	struct vdpasim_mm_work *mm_work =
+		container_of(work, struct vdpasim_mm_work, work);
+
+	mm_work->ret = 0;
+
+	if (mm_work->bind) {
+		kthread_use_mm(mm_work->mm);
+		//TODO: should we attach the cgroup of the mm owner?
+	} else {
+		kthread_unuse_mm(mm_work->mm);
+	}
+}
+
+static void vdpasim_worker_queue_mm(struct vdpasim *vdpasim,
+				    struct vdpasim_mm_work *mm_work)
+{
+	struct kthread_work *work = &mm_work->work;
+
+	kthread_init_work(work, vdpasim_mm_work_fn);
+	kthread_queue_work(vdpasim->worker, work);
+
+	kthread_flush_work(work);
+}
+
+static int vdpasim_worker_bind_mm(struct vdpasim *vdpasim,
+				  struct mm_struct *new_mm)
+{
+	struct vdpasim_mm_work mm_work;
+
+	mm_work.mm = new_mm;
+	mm_work.bind = true;
+
+	vdpasim_worker_queue_mm(vdpasim, &mm_work);
+
+	if (!mm_work.ret)
+		vdpasim->mm_bound = new_mm;
+
+	return mm_work.ret;
+}
+
+static void vdpasim_worker_unbind_mm(struct vdpasim *vdpasim)
+{
+	struct vdpasim_mm_work mm_work;
+
+	if (!vdpasim->mm_bound)
+		return;
+
+	mm_work.mm = vdpasim->mm_bound;
+	mm_work.bind = false;
+
+	vdpasim_worker_queue_mm(vdpasim, &mm_work);
+
+	vdpasim->mm_bound = NULL;
+}
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
 	return container_of(vdpa, struct vdpasim, vdpa);
@@ -59,8 +126,10 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	uint16_t last_avail_idx = vq->vring.last_avail_idx;
+	bool va_enabled = use_va && vdpasim->mm_bound;
 
-	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true, false,
+	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true,
+			  va_enabled,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
 			  (uintptr_t)vq->driver_addr,
@@ -151,7 +220,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	vdpa = __vdpa_alloc_device(NULL, ops,
 				   dev_attr->ngroups, dev_attr->nas,
 				   dev_attr->alloc_size,
-				   dev_attr->name, false);
+				   dev_attr->name, use_va);
 	if (IS_ERR(vdpa)) {
 		ret = PTR_ERR(vdpa);
 		goto err_alloc;
@@ -571,6 +640,27 @@ static int vdpasim_set_map(struct vdpa_device *vdpa, unsigned int asid,
 	return ret;
 }
 
+static int vdpasim_bind_mm(struct vdpa_device *vdpa, struct mm_struct *mm)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+	int ret;
+
+	mutex_lock(&vdpasim->mutex);
+	ret = vdpasim_worker_bind_mm(vdpasim, mm);
+	mutex_unlock(&vdpasim->mutex);
+
+	return ret;
+}
+
+static void vdpasim_unbind_mm(struct vdpa_device *vdpa)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	mutex_lock(&vdpasim->mutex);
+	vdpasim_worker_unbind_mm(vdpasim);
+	mutex_unlock(&vdpasim->mutex);
+}
+
 static int vdpasim_dma_map(struct vdpa_device *vdpa, unsigned int asid,
 			   u64 iova, u64 size,
 			   u64 pa, u32 perm, void *opaque)
@@ -667,6 +757,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_group_asid         = vdpasim_set_group_asid,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
+	.bind_mm		= vdpasim_bind_mm,
+	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
 };
 
@@ -701,6 +793,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
 	.set_map                = vdpasim_set_map,
+	.bind_mm		= vdpasim_bind_mm,
+	.unbind_mm		= vdpasim_unbind_mm,
 	.free                   = vdpasim_free,
 };
 
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
