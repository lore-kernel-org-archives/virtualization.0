Return-Path: <SRS0=Jxal=KC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A24C433B4
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 22:15:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B0C61377
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 22:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B0C61377
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE9D440FB3;
	Fri,  7 May 2021 22:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VePz28DqvBUP; Fri,  7 May 2021 22:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16DA7405D6;
	Fri,  7 May 2021 22:15:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3916C000E;
	Fri,  7 May 2021 22:15:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D40C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 22:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E6256066E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 22:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RseGmynP4ALN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 22:15:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6553E60666
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620425731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
 b=UKQ1zrEou1KYDeLK2jarqKtDzxfgyWBdxlLippMOghCpO3e9subqswpzwbTxgLVelQMmrl
 +4enX3A5tkxwMgqpLwxss2pH8CkrhcfOMCLRfnR3B1ryz4HCDd9TKT5XsrThJrd96bvjSv
 qq0wzVEmEMUUYZGxlh15Vm+2n8VDVsw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-bA_qPizbOAqD-BQjiis9aQ-1; Fri, 07 May 2021 18:15:30 -0400
X-MC-Unique: bA_qPizbOAqD-BQjiis9aQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 w8-20020a4ae4c80000b02901f88dd1b75dso5341789oov.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 May 2021 15:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jtUv57ArMiro4bTHhEhdlXIGNZ+0agUPq7/A51n97kU=;
 b=s3fWkcHDXX7/U8lZqez0ayuJ1RAsUkX+ERh0NXupw5Z9NZYz7bvm58LtIbEcxOYMzw
 KnSg0UWHgeKWQWEnn40xSGZ2nFJ0hxLa5g8U0kovq3BWQHYQ2xmGa7b+5M749+WxEGOq
 OL1STdY9Rbb/ce14OTTX2kEQTJthspOMdn4KILvq6coT5Tq1Us0gOu8iAkUZn3fGe6tM
 84dYnXrh4laaQn3ct5fZGxdPwOefcI0laOXiLhRzfvMQqjDheWZGvyQE3yk3q3Je3nEv
 /26WMtvc6zEH8RV5Hele15rcBfiO2OzF9ADOyUhAeJeIOXEKLsPh81lStJtZO0JbVwgB
 a6fQ==
X-Gm-Message-State: AOAM5334ip5OsqKmexYhCQAK5hG35ZB+cWfL427q3zjxaYZs3Gv+o5CW
 DqE3afibmMQgguFwgwpwCP/UQ74SuHnDbKLgtyLykiKW+kbi8X4fIf1/ySxXmsQErunKfqbWlwN
 K4/U4wAOY11TUxhOVaIv7+hVGkTgDFeie7eDn2oAXJg==
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825280oig.134.1620425729265; 
 Fri, 07 May 2021 15:15:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOP88BBurGoU0f7ioDsjdxBGt9XwNveg3axEkgvcGkjmkgo5INgRySJeIWZ/JqBdbZtM6hfA==
X-Received: by 2002:aca:db05:: with SMTP id s5mr15825262oig.134.1620425729104; 
 Fri, 07 May 2021 15:15:29 -0700 (PDT)
Received: from redhat.redhat.com (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id n37sm1464589otn.9.2021.05.07.15.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 15:15:28 -0700 (PDT)
From: Connor Kuehl <ckuehl@redhat.com>
To: virtio-fs@redhat.com
Subject: [PATCH] virtiofs: Enable multiple request queues
Date: Fri,  7 May 2021 17:15:27 -0500
Message-Id: <20210507221527.699516-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>
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

Distribute requests across the multiqueue complex automatically based
on the IRQ affinity.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
---
 fs/fuse/virtio_fs.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bcb8a02e2d8b..dcdc8b7b1ad5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -30,6 +30,10 @@
 static DEFINE_MUTEX(virtio_fs_mutex);
 static LIST_HEAD(virtio_fs_instances);
 
+struct virtio_fs_vq;
+
+DEFINE_PER_CPU(struct virtio_fs_vq *, this_cpu_fsvq);
+
 enum {
 	VQ_HIPRIO,
 	VQ_REQUEST
@@ -673,6 +677,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	struct virtqueue **vqs;
 	vq_callback_t **callbacks;
 	const char **names;
+	struct irq_affinity desc = { .pre_vectors = 1, .nr_sets = 1, };
 	unsigned int i;
 	int ret = 0;
 
@@ -681,6 +686,9 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
+	fs->num_request_queues = min_t(unsigned int, nr_cpu_ids,
+				       fs->num_request_queues);
+
 	fs->nvqs = VQ_REQUEST + fs->num_request_queues;
 	fs->vqs = kcalloc(fs->nvqs, sizeof(fs->vqs[VQ_HIPRIO]), GFP_KERNEL);
 	if (!fs->vqs)
@@ -710,12 +718,24 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		names[i] = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, callbacks, names, &desc);
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < fs->nvqs; i++)
+	for (i = 0; i < fs->nvqs; i++) {
+		const struct cpumask *mask;
+		unsigned int cpu;
+
 		fs->vqs[i].vq = vqs[i];
+		if (i == VQ_HIPRIO)
+			continue;
+
+		mask = vdev->config->get_vq_affinity(vdev, i);
+		for_each_cpu(cpu, mask) {
+			struct virtio_fs_vq **cpu_vq = per_cpu_ptr(&this_cpu_fsvq, cpu);
+			*cpu_vq = &fs->vqs[i];
+		}
+	}
 
 	virtio_fs_start_all_queues(fs);
 out:
@@ -877,8 +897,6 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	if (ret < 0)
 		goto out;
 
-	/* TODO vq affinity */
-
 	ret = virtio_fs_setup_dax(vdev, fs);
 	if (ret < 0)
 		goto out_vqs;
@@ -1225,7 +1243,6 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
 __releases(fiq->lock)
 {
-	unsigned int queue_id = VQ_REQUEST; /* TODO multiqueue */
 	struct virtio_fs *fs;
 	struct fuse_req *req;
 	struct virtio_fs_vq *fsvq;
@@ -1245,7 +1262,8 @@ __releases(fiq->lock)
 		 req->in.h.nodeid, req->in.h.len,
 		 fuse_len_args(req->args->out_numargs, req->args->out_args));
 
-	fsvq = &fs->vqs[queue_id];
+	fsvq = this_cpu_read(this_cpu_fsvq);
+
 	ret = virtio_fs_enqueue_req(fsvq, req, false);
 	if (ret < 0) {
 		if (ret == -ENOMEM || ret == -ENOSPC) {
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
