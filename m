Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8162AC4338F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:28:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279FE60E09
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 279FE60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6A47402A2;
	Mon, 26 Jul 2021 09:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qi6cYC6RX9kl; Mon, 26 Jul 2021 09:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8435C4010E;
	Mon, 26 Jul 2021 09:28:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FA44C001A;
	Mon, 26 Jul 2021 09:28:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A493C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05B61401C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tZrlvpzG7Wg3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14E694010E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627291700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqmtXjR23l4x2rUuqXYQINAtvK/goiI836gDq6BQI34=;
 b=asI7Fim5x8GuEO8/P5QADAH+VwWVtuL+NjrrC/8qZKyN//Ah7Ss9YO/NDhkbjjRBY7toH2
 rtfoIwRBPEdUqWhE5vfAuL9mYjzaDwdaciZvhBOTWLmBHTMH20uEbYisrQQhP4cGEI1Wpx
 5KsWp1u0jgxxi2yp7OmW69GdOWBpFgs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-fWq72EK8MeSqcbcpDS_Glw-1; Mon, 26 Jul 2021 05:28:19 -0400
X-MC-Unique: fWq72EK8MeSqcbcpDS_Glw-1
Received: by mail-ed1-f71.google.com with SMTP id
 d12-20020a50fe8c0000b02903a4b519b413so4408074edt.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yqmtXjR23l4x2rUuqXYQINAtvK/goiI836gDq6BQI34=;
 b=gogRNMpcAgQsvbdKV0+/CokXDVx2W/nPqF7IYICklmozpXaYMppTkWNASJbglVR3DF
 h2hb+bXgMxqdqTa8d2OQIQVc4CgfgoS9xxAYz+sMspusy+TvbYyv+1G/xMPfavVv5XK7
 5KgYTWtpNlpzRT/CIL3i4I4IWB0GhCD8X7gMoQFEl95sJeu0q/CP40JuLbdOZCQjdUM9
 dtcl58wDMZkTE24Zh5rtOcUI6gvbOXaW+rjfangAunh5FTdj0WsfZYFaMbSMEn8J4gBo
 ke7SjE7HCRtN0dDfW3xg/9T+mC323GpwuTfblCbGSd3eifTMOInDb2h8RguHIbUsJbHI
 LsYw==
X-Gm-Message-State: AOAM533PICqGwxchX09WvhfJJtgxnxoM4jTG0/f5yuilAEswkvGail4F
 8HE/iv6eUiN0U33u6c3/2vzW4DvOrNbxSFj4ayoab6ZZ2kvzr2ShaNs/yuyf3FzlYATFZZ/s5Fd
 lp9WjeQr3y2rFyPmoBU/StQfL8j0K2M+l/fXSLzEHwQ==
X-Received: by 2002:a17:906:2547:: with SMTP id
 j7mr2792652ejb.491.1627291697846; 
 Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDjPQEOSbUwrd7RuKpfzjmfg9QK7jBxQRsM4T4gkOmvXljzMIWlFzbVuMfo9+mPG8MdZHaOw==
X-Received: by 2002:a17:906:2547:: with SMTP id
 j7mr2792640ejb.491.1627291697720; 
 Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id bd24sm4357947edb.56.2021.07.26.02.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
Date: Mon, 26 Jul 2021 11:28:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 1/4] vdpa_sim: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092815.hyesvf44lq6jtxuo@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 dan.carpenter@oracle.com, mst@redhat.com
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

On Thu, Jul 15, 2021 at 04:00:23PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 14e024de5cbf..c621cf7feec0 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -251,8 +251,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>
> 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> 				    dev_attr->name);
>-	if (!vdpasim)
>+	if (IS_ERR(vdpasim)) {
>+		ret = PTR_ERR(vdpasim);
> 		goto err_alloc;
>+	}
>
> 	vdpasim->dev_attr = *dev_attr;
> 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
