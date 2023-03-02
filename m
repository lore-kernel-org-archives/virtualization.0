Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF462C7EE30
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FD2A40A8B;
	Thu,  2 Mar 2023 11:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FD2A40A8B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIvN11Ns
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MAX4vA81oIp4; Thu,  2 Mar 2023 11:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDB7D40AA2;
	Thu,  2 Mar 2023 11:34:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDB7D40AA2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C793DC008A;
	Thu,  2 Mar 2023 11:34:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 380AEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 130F361000
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 130F361000
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIvN11Ns
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2-8V0xwghYB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04B0660EC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04B0660EC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
 b=UIvN11Ns22g5CpmCXCopvLIfTIHki5skBTzNKwCn0b+E43dB54GmFEjI0kFqDSdOh8RQqA
 Tl3B590TWp7qD0zdXY+fXNSIw3DyIgMKGMSaLH6X8TJE0s5SwqDoopL0d9cGO6fUNE5W9D
 I85+VhplYfLO+LQoeGTPJGvIuLr1Ojo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-Uv8s5iTENSSFqemR2yDlNA-1; Thu, 02 Mar 2023 06:34:33 -0500
X-MC-Unique: Uv8s5iTENSSFqemR2yDlNA-1
Received: by mail-qt1-f197.google.com with SMTP id
 z22-20020ac86b96000000b003bfc3f97097so8272867qts.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zd9PLJS6vpKJ6CPmR9YHtESYhzkUvkwsWDxsXaqlwQ8=;
 b=r2QLoOZEd8UihA+tVASWIOUFBmhEqdQVVo3LC4DNalx8fiBMCZZevwmDx+AOOW4hSo
 QR7TMHS2JKAtV+4dFG3JzS5qsIn0ewkR4UcSPqnqhVAEK1xdy1WrlHIUexPXg73O6kjH
 uZyYjq6d0DD7uDC7eT+W6u3qmJlmSUUIdhL8KOLViH3olMGzPj7BpZ/FXjB0awglidRK
 MwPhEXuoQBsxoorPQcTwKkbOoq7pUDyEniAR9lz8/SaVacqir81XokqK4J4x1nYr42yg
 GPPEtzzcNE9K7iSE/ljsJVvEc2OZ/PEiO4taYAlxONeAZUCWTlUX8Zhabsyz2cZl/CWk
 xrEA==
X-Gm-Message-State: AO0yUKXaBMZ1cV8kv3gesmUCGQ6Z39nw7vOqRC6XjHv1x1BOzqVFZBjz
 IWx8KJhWUMc4T0mqkDj1/V/9FKK315i/Rb5Fz8coNnRVoVLHca0rC6xMDRhWGStjKS3iP1SUrvK
 5z6jnrwu10t4PgSPhMGpQfDInC69csFTEWaIU97TbN0M1EOdQSAPZSvUZ0vqvfbUDMKp2x5EZDW
 mVuO8wVkVrhvYbG934R8z6UJ4=
X-Received: by 2002:a05:622a:14a:b0:3bf:d0b1:433d with SMTP id
 v10-20020a05622a014a00b003bfd0b1433dmr17172924qtw.60.1677756871656; 
 Thu, 02 Mar 2023 03:34:31 -0800 (PST)
X-Google-Smtp-Source: AK7set+LNHqJ8iSXkQnBxJNED/Dd+UhTVPKK7gC7ULHZoFWAiCyFuYmT1oYs5XX8i5qwnVYajblszQ==
X-Received: by 2002:a05:622a:14a:b0:3bf:d0b1:433d with SMTP id
 v10-20020a05622a014a00b003bfd0b1433dmr17172896qtw.60.1677756871371; 
 Thu, 02 Mar 2023 03:34:31 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 o12-20020ac8698c000000b003ba19e53e43sm10084156qtq.25.2023.03.02.03.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:34:30 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/8] vdpa: add bind_mm/unbind_mm callbacks
Date: Thu,  2 Mar 2023 12:34:14 +0100
Message-Id: <20230302113421.174582-2-sgarzare@redhat.com>
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
