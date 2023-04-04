Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3124C761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 13:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7421F81285;
	Tue,  4 Apr 2023 13:13:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7421F81285
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZi5rZ2i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozdcO8o3AaGy; Tue,  4 Apr 2023 13:13:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17856812D2;
	Tue,  4 Apr 2023 13:13:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17856812D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01771C0036;
	Tue,  4 Apr 2023 13:13:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37C6CC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03E4A404F7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03E4A404F7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZi5rZ2i
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Q1fjNIs8Xld
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1A6D404E9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1A6D404E9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680614016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
 b=TZi5rZ2itZzC/gF8EBJ3sSWvRdWonCuX4D4d/MHPntsfMcFN0G4mHY1TfakEIvqVkjLJUj
 dgdWkzYHfH8NB9AN4C6w5NNCC/XYtSwrwKvbDBc63zzZIsW9nroCBh6ua2vrqY1ztJ0EZe
 T9Nr3hbot0nlaY98QhqnYu4VoH5pCsM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-dh41FW1eMCyG09jMvtPR_w-1; Tue, 04 Apr 2023 09:13:34 -0400
X-MC-Unique: dh41FW1eMCyG09jMvtPR_w-1
Received: by mail-qt1-f200.google.com with SMTP id
 t15-20020a05622a180f00b003e37dd114e3so22043967qtc.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 06:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680614014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
 b=nhvpsUVWYefvXwtHeXh5KCErpsMWDe4FrBc3DMya8OBgXzWynFH0vIwlOIIs0Ac7eh
 54zGNNgFSi8mt+4dFpDBqlJ9/yzPKTNEwCWQMDKRvGy2Q+ZbcMFKIgrzSLfMV9CaDsJO
 T+iZL/7njbGyzsZtA98VZua5224E02G0OcX85AHZNz1Ht0nbAcl8CKKK3hqA5O9WhqeD
 vBVIg/Rca20RPFZ+K1JbaOKY+oRQMpJraV/h/3N+jfEaSF7hHkaoXgc0+8SzVW837gH1
 zSrQWN1tmexV7PMXPkDxszNCr/RK6TBfrO55Dnl/AFTWENueXNjSRSGxTWF1lZlMJZEz
 JkjQ==
X-Gm-Message-State: AAQBX9deSRWiM/wReawA7Y+91c9450s6QN0TxY2vBhUcZQmBsJ30zlQV
 aWh2OEezchYJzk6ceORlknpChkSnHcfcOnZ544iW/OjvLSFQR4PR0BHz6s1WZmsWa9VnZjj6Sy4
 WVE7Re7L87eKxF0k+MXDzt1BBYvgG8A2knnxuO89xTueD6w1VxeaeeLm+qt66KJA+SILYps6mJL
 X316nDkZsjg2VqrZteT4F/1OSEvA==
X-Received: by 2002:a05:6214:240d:b0:5e0:63ec:5d7a with SMTP id
 fv13-20020a056214240d00b005e063ec5d7amr3896852qvb.46.1680614013990; 
 Tue, 04 Apr 2023 06:13:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350aKm0amVIapEM6Osx9+Rfg1SXxy+vCHEeGfHbCKzQgTZk0x83W/PRr71qSe/u0h5R9nDk3onw==
X-Received: by 2002:a05:6214:240d:b0:5e0:63ec:5d7a with SMTP id
 fv13-20020a056214240d00b005e063ec5d7amr3896807qvb.46.1680614013667; 
 Tue, 04 Apr 2023 06:13:33 -0700 (PDT)
Received: from step1.redhat.com (host-82-53-134-157.retail.telecomitalia.it.
 [82.53.134.157]) by smtp.gmail.com with ESMTPSA id
 mk14-20020a056214580e00b005dd8b9345e8sm3367788qvb.128.2023.04.04.06.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 06:13:32 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v5 1/9] vdpa: add bind_mm/unbind_mm callbacks
Date: Tue,  4 Apr 2023 15:13:18 +0200
Message-Id: <20230404131326.44403-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404131326.44403-1-sgarzare@redhat.com>
References: <20230404131326.44403-1-sgarzare@redhat.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
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
