Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398EC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BECE741E24;
	Fri, 24 Mar 2023 15:36:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BECE741E24
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TLjxFI4T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xq1lFUij0J64; Fri, 24 Mar 2023 15:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 504F340148;
	Fri, 24 Mar 2023 15:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 504F340148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BB40C0035;
	Fri, 24 Mar 2023 15:36:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60264C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2BDCD41B6E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BDCD41B6E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TLjxFI4T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jw0T_808tbUY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BF8F41B42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BF8F41B42
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
 b=TLjxFI4Tkbt3AKgLy9sSXJaM7NSDmP3THQEkk8UB/wlLfkv5Ut2xns5T6KGp6m5ORgKTi8
 dGMZ/18W5Ys6OEIbHpDAoGp98QodtlmxOKkPKJsEPI6wWtUD5F0iL0iHU+GvoU+XxxNBs1
 n70GY/kw+/ZlQQAVCimQjbAfjN8mm5s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-TgR9dW1WN8WXRFpGRz_eKg-1; Fri, 24 Mar 2023 11:36:21 -0400
X-MC-Unique: TgR9dW1WN8WXRFpGRz_eKg-1
Received: by mail-ed1-f70.google.com with SMTP id
 p36-20020a056402502400b004bb926a3d54so3746882eda.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmE27wy0MmMLRHR3IF88SSg1j96JW0EiZjlHTqsz8dM=;
 b=OvrrMg2b/ufO930R2jWPN0Tib5tQcWDbtXO+Z/si249zR+DqLuG4fA8R4BmBtChklK
 q318P4czltUlt0+kYlqDg2w4iHm/IrkLgv6J1woYqqgSO+WuguRud8i5qFaB8DwIoas2
 6YKZo7UpFL2fbIVIgddzmUA5ktgeU1famLVV9Vg+SvqeXxUidieFH9UIAz1U06CwcbOj
 FizLd+hmoC1Y3lu0EY+4+dGnMG8dedis7gzQAagUaartpzV/OKwphuXw+xEY4uybK4Bp
 zoCg2AoPmVX3iI82GxpFnkhoFiavZs3ec+gkpGjQolHh20MaESTi1Mj+X/Gi6SeO4yKm
 RhvQ==
X-Gm-Message-State: AAQBX9fKpDnsA7g8fOZ9yQcYcMz3B5GvCX/o20NW1K78Kdu2CsALA+RG
 /7t+hCGoQp695X2zzDusDtglME0M0U26A4jc2q8knmwSPrmPDFkNoeAFDLhfwtTpRmC40DJYX1s
 nYR3z+NrY2L9klsjD8XiGHNg2dC1h992BirzXrFEtSanYlXxv/lbVMzyCP+QUsbY7VHDfdCsw5D
 2J5VoNmnlR+Bgdj/yl9sZO0tNBRw==
X-Received: by 2002:a17:906:fa0b:b0:8b8:c06e:52d8 with SMTP id
 lo11-20020a170906fa0b00b008b8c06e52d8mr2946644ejb.36.1679672179853; 
 Fri, 24 Mar 2023 08:36:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZuirhl8xx4rByPSqoq6QKJPGj09MFOoO+Qf6ZIruLZfjDXz0VEK/mx0/0gVcgfYuVnqttLg==
X-Received: by 2002:a17:906:fa0b:b0:8b8:c06e:52d8 with SMTP id
 lo11-20020a170906fa0b00b008b8c06e52d8mr2946615ejb.36.1679672179513; 
 Fri, 24 Mar 2023 08:36:19 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a509b5b000000b00501dd53dbfbsm5468613edj.75.2023.03.24.08.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:36:18 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 1/9] vdpa: add bind_mm/unbind_mm callbacks
Date: Fri, 24 Mar 2023 16:35:59 +0100
Message-Id: <20230324153607.46836-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
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
