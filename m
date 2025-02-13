Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A83288C2B
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463514; cv=none; b=kTTM9rTe8s1gTqqhQlO4rEwkW8co2JljUh+bWPrjKl+Fe5X6zDlp88smEBuqFdT6u53+H9DtmWebT9lR1BElZjtDEC6zPSQ7EyqMQQaVGMazvOl05WvfF85wesQsKcyjsqLbU+zbU0viXv8lsyi6HifCe4FzeHlObJm4e5RRGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463514; c=relaxed/simple;
	bh=Vrn/4vwdmsdokkCuLMXfyT1nZ/jStbBCx0QhOmJ6E80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=gxB/j/4Igc5umgWbU1jTVuEGaoFt3w1Ftfc3n24FXMQQ0+vFlUoTfk5bUCMjGrSN2jL1nP7AOOViF/dvn00fQ9ciYF5mNpU4WwS9UZnpopISkh7CJ3vltqRdnMdcjThF+rz+KNkQgpjZOy/rlPChd8wGL1TTpuNQP005LtJG3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUqOtsiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUqOtsiR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739463511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKzjBSUkdHDLfZzf4JfzRiz+zb6GftCtkHoeHOHlZwU=;
	b=JUqOtsiR+ODQNkafGefj2w0b50pdy6/eaUZ5DLluWK5OxQq8jt4t3FMRDos5dvJS7BTxKt
	7tbfdTP7tRIRIfAiI1Gsm4w85V1lZXETqYFqjEnK80bSo4+KA7FY53flJ8jDxW/+rUzAa2
	8aCDSA6y3YTWXbliUHYnHWCeQgrkprI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-pe-QVOTZNaS_OUp4bYiEOQ-1; Thu, 13 Feb 2025 11:18:30 -0500
X-MC-Unique: pe-QVOTZNaS_OUp4bYiEOQ-1
X-Mimecast-MFC-AGG-ID: pe-QVOTZNaS_OUp4bYiEOQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4395b5d6f8fso5839815e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 08:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463509; x=1740068309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKzjBSUkdHDLfZzf4JfzRiz+zb6GftCtkHoeHOHlZwU=;
        b=bfNUv/8Qlp2ABDMJHjHm1Wb4wIm2eY5G960xKtgbtZ70NiDlvMf4QEtqi3MJQMuZj3
         +foNzE9h4JrtEGdP/t5Dd+FDQAvZ1uo7NiXR3u4sPtVU34+J+XjygK/j8+Q/wpGiJ/mj
         eqzMylOJYoPracWtufaGjc2N9n88+/TPnwY73Wyoi3rcHCqq14XDO9RG1nj2g7SK9XdK
         DI+9CQbrvcXVRYgu00WsT90XqDEUEJi9dEcvEHJRSXxsFZweI9UoUebnfnbcBQSbgTYz
         ppzrLjjhcRL79LsLrbvwooCSfpHdboRs/iRitpsu4CcszXuRHV6NCxsTvC0zujgB6taF
         ZdJQ==
X-Gm-Message-State: AOJu0YzKXJ/E/xXygWPuHqHgFqDLFGboJk/9UKyJ2o5b6BqzD+4Hdwsn
	3L+2pXpnSSoIzQPSe/QR7zfWZqkc7ceCGeJCXHwzVomrt7+nIjKy3ptTqZ4ba+71UTTSMSI9tP6
	eri2+MZkMUHfhu+QndmpkXYltza4QQD7E7KY6OOgi3Hol63cYS2XMzfJJXEbUpwzrtWnUCzZooN
	Cv9nkN7OHAwb0/4IM2/wo+naxMmZYHQHey8+BN4rAASqmrYMm1
X-Gm-Gg: ASbGncsn0iHlYjCEG5tx/+sGD3cuOtl4j22v32Qjaj/vdQMfGP9fxlhodN2QTSptMjW
	n8d3roebf5xNxHly+ECdccck+tPATw5SVk4WP0Xsj3bBnP7yjXGoqEz7vEZ8Gy7+h0jcwZh+0Lc
	EQ+heGtUmPqMjZeljn/2fcokzjrHtZnftViD18iJRuHZygP/SBQ2aF2ERI4FTxThAiUo3AxNwM3
	9lj35M6D0graKsxEMpgq1r+klNnfI4RWtVN2LJOkoPU81H2b42n2NMmGfC+VhsbsBDEuGobIvU+
	OXpaPZLxkhfRU48r/XK3+Cet9hCDSEkAJTWDhuA73bqtoQ2zHAVLi7g=
X-Received: by 2002:a05:600c:698d:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-43960179b7amr57710735e9.7.1739463509243;
        Thu, 13 Feb 2025 08:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu6y21w757rvE76+QUOv51wsc6Q/8KLtoBTuUd9R2tuHYuDtc916mYTl90tlTU0umnS7sdnA==
X-Received: by 2002:a05:600c:698d:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-43960179b7amr57709765e9.7.1739463508492;
        Thu, 13 Feb 2025 08:18:28 -0800 (PST)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d237sm52922715e9.21.2025.02.13.08.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:18:27 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	linux-sound@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS
Date: Thu, 13 Feb 2025 17:18:25 +0100
Message-ID: <20250213161825.139952-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mYET__EDMSVOvfVBnsL6FnOW3YhsX6aix33PcaYDOAI_1739463510
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

As defined in the specification, the `controls` field in the configuration
space is only valid/present if VIRTIO_SND_F_CTLS is negotiated.

  From https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html:

  5.14.4 Device Configuration Layout
    ...
    controls
       (driver-read-only) indicates a total number of all available control
       elements if VIRTIO_SND_F_CTLS has been negotiated.

Let's use the same style used in virtio_blk.h to clarify this and to avoid
confusion as happened in QEMU (see link).

Link: https://gitlab.com/qemu-project/qemu/-/issues/2805
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/virtio_snd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index 5f4100c2cf04..a4cfb9f6561a 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -25,7 +25,7 @@ struct virtio_snd_config {
 	__le32 streams;
 	/* # of available channel maps */
 	__le32 chmaps;
-	/* # of available control elements */
+	/* # of available control elements (if VIRTIO_SND_F_CTLS) */
 	__le32 controls;
 };
 
-- 
2.48.1

