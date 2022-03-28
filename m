Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED1C433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 09:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3A16409EA;
	Mon, 28 Mar 2022 09:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nHmsfdawLEtA; Mon, 28 Mar 2022 09:05:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 375C040186;
	Mon, 28 Mar 2022 09:05:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07981C001D;
	Mon, 28 Mar 2022 09:05:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0633C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEAC1409B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:05:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIvKL5AArDiB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:05:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D710840920
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648458317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dazmAAoQFVivnRUQJ98F5Rcg+F0tp/OFcYuPcUPV2Z4=;
 b=D1woTACaPeUFb3U7pxERaCtKp/372WkeBvCgb9AGsYjqi2h1obp0iPPbNn/mwgG9Xhtph0
 318zl3iBqBtj7ES28nc4oOcgK+M00oXs1BlxFUvY6xDmugqd77tXKljl0HzfQXeG4cEj1n
 eTHWu85CEZ1MtQDUl+iRmg91gv1DJdU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-S53MfyhQOm-8QJSFDL-tBA-1; Mon, 28 Mar 2022 05:05:16 -0400
X-MC-Unique: S53MfyhQOm-8QJSFDL-tBA-1
Received: by mail-qt1-f197.google.com with SMTP id
 cb11-20020a05622a1f8b00b002e06f729debso11692682qtb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dazmAAoQFVivnRUQJ98F5Rcg+F0tp/OFcYuPcUPV2Z4=;
 b=6YloBjarUf8HBTz3lZMwXxnN5GO/1QHAT0RPHqHa7miRdPIT6N/l/OhkFShIqR9oMa
 NNfZf/XpZQm4I/3tKbCAn3aI3tz428D9oPCoz2EQoxGEyNKltx5dbcUHV5Opu8CWjTNQ
 i4LXVyRM7OEnuT1lKFWri/M8UsX6DGVQ7D5ZkfQwmKX/AFN2Z7dY6AWqMGJkrHFpeT6J
 Bg/l7+TUFRVXWvU6MunNFuRGFRwCUGgwV3PCGGqZ1OVN6x5SwuQ2Xn1TWLfT5ncPRGQK
 JnXzEqujnK591nvWNun0o6cliA2AYYjRe4EbhbIQqCtAvjDW1Vr/824dY3jAyu4uqcxY
 sumA==
X-Gm-Message-State: AOAM5316MzA5zqu498mokoDS6hNkviiADrv5vGTUKHD8/R6hVvztk2OF
 6Iswh05y0+sQaAF95iBhGnF+pXQ34jlc8c6xuxEKwp1f8jSN/2kY/hrGgbedzSpLS2YAxCedcpa
 tkmh+aOywsG2hwaVEMsvo8PA6eztBcTDth8dXTAqjHA==
X-Received: by 2002:a37:b986:0:b0:680:4b6b:893d with SMTP id
 j128-20020a37b986000000b006804b6b893dmr14824660qkf.98.1648458315732; 
 Mon, 28 Mar 2022 02:05:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp+dxtmyBke0/hVE2RSfvhkWtdTPytf1c5FXG5YXQIuysovYo1EKmn66JOnErH+703DCeLPQ==
X-Received: by 2002:a37:b986:0:b0:680:4b6b:893d with SMTP id
 j128-20020a37b986000000b006804b6b893dmr14824645qkf.98.1648458315455; 
 Mon, 28 Mar 2022 02:05:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-67.retail.telecomitalia.it.
 [79.46.200.67]) by smtp.gmail.com with ESMTPSA id
 o21-20020ac85a55000000b002e16389b501sm12175863qta.96.2022.03.28.02.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 02:05:14 -0700 (PDT)
Date: Mon, 28 Mar 2022 11:05:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq call in vring hot
 path
Message-ID: <20220328090503.wk5idknhwsbunkjs@sgarzare-redhat>
References: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220324073340.632656-1-xianting.tian@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 24, 2022 at 03:33:40PM +0800, Xianting Tian wrote:
>It passes '_vq' to virtqueue_use_indirect(), which still calls
>to_vvq to get 'vq', let's directly pass 'vq'. It can avoid
>unnecessary call of to_vvq in hot path.

It seems reasonable to me.

>
>Other tiny optimization:
>Add unlikely to "if (vq->vq.num_free < descs_used).

Better to do this change in another patch.

Thanks,
Stefano

>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/virtio/virtio_ring.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index 962f1477b1fa..ab6d5f0cb579 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -205,11 +205,9 @@ struct vring_virtqueue {
>
> #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>
>-static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>+static inline bool virtqueue_use_indirect(struct vring_virtqueue *vq,
> 					  unsigned int total_sg)
> {
>-	struct vring_virtqueue *vq = to_vvq(_vq);
>-
> 	/*
> 	 * If the host supports indirect descriptor tables, and we have multiple
> 	 * buffers, then go indirect. FIXME: tune this threshold
>@@ -507,7 +505,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>
> 	head = vq->free_head;
>
>-	if (virtqueue_use_indirect(_vq, total_sg))
>+	if (virtqueue_use_indirect(vq, total_sg))
> 		desc = alloc_indirect_split(_vq, total_sg, gfp);
> 	else {
> 		desc = NULL;
>@@ -527,7 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> 		descs_used = total_sg;
> 	}
>
>-	if (vq->vq.num_free < descs_used) {
>+	if (unlikely(vq->vq.num_free < descs_used)) {
> 		pr_debug("Can't add buf len %i - avail = %i\n",
> 			 descs_used, vq->vq.num_free);
> 		/* FIXME: for historical reasons, we force a notify here if
>@@ -1194,7 +1192,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>
> 	BUG_ON(total_sg == 0);
>
>-	if (virtqueue_use_indirect(_vq, total_sg)) {
>+	if (virtqueue_use_indirect(vq, total_sg)) {
> 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> 						    in_sgs, data, gfp);
> 		if (err != -ENOMEM) {
>-- 
>2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
