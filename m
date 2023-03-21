Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A498C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54424418A4;
	Tue, 21 Mar 2023 15:42:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54424418A4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=efQwvRn0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QD_PXabeHWxK; Tue, 21 Mar 2023 15:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8348841897;
	Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8348841897
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 554AEC0071;
	Tue, 21 Mar 2023 15:42:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DD0CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5918040992
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5918040992
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=efQwvRn0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eh3LGc6k-TWl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FE3540140
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FE3540140
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
 b=efQwvRn0B7ulOHNiZab7za2HchoEQsAatRcZfk/c82/FePajha9OXxlyPy0Ro5N5ki1Jek
 /gv1SdqH0bB7BGP/h5AwUqs0Z0lKaqrH73613BETlWQIb3Ugr+1hHaEMS2BOHSQPtKwlnD
 ROGT4zbgdbtjTrevoFjJ3X0YWA/UIJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ZMecGG1ZMhGrqf6Am4obwg-1; Tue, 21 Mar 2023 11:42:35 -0400
X-MC-Unique: ZMecGG1ZMhGrqf6Am4obwg-1
Received: by mail-wm1-f72.google.com with SMTP id
 i8-20020a05600c354800b003ed59bae33bso6071151wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
 b=B8xguLKnuT9LR/AhfMi4o/+wE9+MkAjIqO+ZzCY7Swndin80Bb8iKPKuZ3yWhn4SB2
 waEl4uu7T98zP56nvhDtEAN+HYnKTJY0Mhgu0eN4FJ/CpV9Tdt4/YhUiaGDuPq8n4GxZ
 HHD8MNuX7rhzduTXarpJJtY+ksI6cRLBKU0jtw1fSX4zn4Rb2janKskjSEpqxd1spUDx
 qqpXOgOskBDonB3TV5ErQGtYkiGjJtA+HdWZvmbnN/O6enzmvDH1EwfiB58tQy4HZ2o0
 1VGcOzHJa8GorUqvmq6sCM7Newhx6h42/bOeE8EErqVgXJabrRjkU8CVA3rbeoWf1ZRr
 Garg==
X-Gm-Message-State: AO0yUKXr/99U77+hEyubhqOkvhSQgrrR5/8hrIBaR1ACVppOzLlaxRG+
 E1s7rB+V95UU4usHuK8Ln67QwSeWEUKcLyEq2+7vDkhQ1Lkc2Kg1V1Rl4NLi9v4Q5PlxOxzPaqz
 1qrQP7pG+ubJCBrB8F1pzSMCO3i5exKQpynW5Bm2SrDrUd01M9co6NAQX53XYhS7YDzZqt+tmAu
 B4ffhh4xL6NCwTh7A03RECFSnfGA==
X-Received: by 2002:adf:f343:0:b0:2d3:3cda:b3c6 with SMTP id
 e3-20020adff343000000b002d33cdab3c6mr2888099wrp.40.1679413353655; 
 Tue, 21 Mar 2023 08:42:33 -0700 (PDT)
X-Google-Smtp-Source: AK7set/b5KVmlfqlN07+fuoNrjHLEJpuKDzvXT/LPPT4E9RDWaTxlJ4Sk2OLx1GqH6fn/8z1bNY5hQ==
X-Received: by 2002:adf:f343:0:b0:2d3:3cda:b3c6 with SMTP id
 e3-20020adff343000000b002d33cdab3c6mr2888071wrp.40.1679413353350; 
 Tue, 21 Mar 2023 08:42:33 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 n2-20020adffe02000000b002cfeffb442bsm11582490wrr.57.2023.03.21.08.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:42:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/8] vdpa: add bind_mm/unbind_mm callbacks
Date: Tue, 21 Mar 2023 16:42:21 +0100
Message-Id: <20230321154228.182769-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154228.182769-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
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

These new optional callbacks is used to bind/unbind the device to
a specific address space so the vDPA framework can use VA when
these callbacks are implemented.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - removed `struct task_struct *owner` param (unused for now, maybe
      useful to support cgroups) [Jason]
    - add unbind_mm callback [Jason]

 include/linux/vdpa.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 43f59ef10cc9..369c21394284 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -290,6 +290,14 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns pointer to structure device or error (NULL)
+ * @bind_mm:			Bind the device to a specific address space
+ *				so the vDPA framework can use VA when this
+ *				callback is implemented. (optional)
+ *				@vdev: vdpa device
+ *				@mm: address space to bind
+ * @unbind_mm:			Unbind the device from the address space
+ *				bound using the bind_mm callback. (optional)
+ *				@vdev: vdpa device
  * @free:			Free resources that belongs to vDPA (optional)
  *				@vdev: vdpa device
  */
@@ -351,6 +359,8 @@ struct vdpa_config_ops {
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
 	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
+	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
+	void (*unbind_mm)(struct vdpa_device *vdev);
 
 	/* Free device resources */
 	void (*free)(struct vdpa_device *vdev);
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
