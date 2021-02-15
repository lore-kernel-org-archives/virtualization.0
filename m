Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E0C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:46:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B1864E52
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B1864E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39C6385A0E;
	Mon, 15 Feb 2021 11:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_UO-xBg_Nta; Mon, 15 Feb 2021 11:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5B98859CF;
	Mon, 15 Feb 2021 11:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A41C0174;
	Mon, 15 Feb 2021 11:46:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64658C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49A3C6F504
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nfvi9rGAnBWV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:45:59 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 2F6476F499; Mon, 15 Feb 2021 11:45:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57CB76F499
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613389555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/MfL+9JluSWmATPYGCUv/jiGUx5czI1hZYUfC3zkR4=;
 b=Agk8vdaBySlrefcwfpbXZ7ikQTLKMCSnUr8wbGFafOzdObqyknyOBQ1WVmtLn6ThcHvJ24
 VTO78SDwbbxJhlo1OPtkpJAyGCl3eQNCFTqBdxCGVAP95pkLI+E4xpjvOoz7u6kt2JhiMM
 MjP0SGshav74AUgW7iBrrakSyOGU/xc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-JWD_p7fcNMSWeCJCZtj71A-1; Mon, 15 Feb 2021 06:45:52 -0500
X-MC-Unique: JWD_p7fcNMSWeCJCZtj71A-1
Received: by mail-wm1-f70.google.com with SMTP id i4so5735533wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 03:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V/MfL+9JluSWmATPYGCUv/jiGUx5czI1hZYUfC3zkR4=;
 b=b9HoK7gFAsrP3FglF0gE1UIWYRxkZDx7DOk8MDeFqrpsFLarIOstSrBaoYBm/Q8TJ3
 wn/oAPAFrt/zWgvYVN0YYvoiSg7DTk+I4UhzfMZ421gw6o0ucp4f5Uxgn1l84VLelxr4
 8fe7JbuiyaGF4pLPeTBcIbY2IGg34jds+plqpyn5q+TzWwjmAgWAtpBMhcZbt+hkXCyP
 lAGnYsRZNXFz/p0JSDhRFWYdcZfQcnT1nSHIv8B+DWCDJvcc1gdtfGVe+a2WTwDCpIVH
 S+r6tQmUAVMZT81TPsdVwI0i9GvsvGyaT91HcUXaD+TS2ia0L1mMUQF4jUuh6uQJQels
 12kA==
X-Gm-Message-State: AOAM533cAYdj5FEhK71874w+MjqWGkj+0YELjTGNYeJYrv0mAAYDNbOU
 omfk0o0ZfMgVD6IbsibTv7wupGPXONrQ6KreXnyDGggI9B0P6dRZMGyA5uUTaLj9++0fxPYwlCU
 uAH1T/Ha7yoovC4A2iIjHBwQ3SNyVAB0NwB3BfAw5TA==
X-Received: by 2002:a1c:c388:: with SMTP id t130mr12753262wmf.85.1613389551461; 
 Mon, 15 Feb 2021 03:45:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuXidB+7iXYaXQmmS3FhAWVw/GMUH8giz/DfCggLk0UjTuRcBDIEQ/jhs55KRNhYJeulcO2g==
X-Received: by 2002:a1c:c388:: with SMTP id t130mr12753249wmf.85.1613389551226; 
 Mon, 15 Feb 2021 03:45:51 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s13sm5049113wmh.34.2021.02.15.03.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 03:45:50 -0800 (PST)
Date: Mon, 15 Feb 2021 12:45:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH] vdpa: Fix memory leak in error unwinding path
Message-ID: <20210215114548.m4si5f3rz3diwkgw@steredhat>
References: <20210213183919.248254-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210213183919.248254-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

On Sat, Feb 13, 2021 at 08:39:19PM +0200, Parav Pandit wrote:
>When device get command fails to find the device or mdev,
>it skips to free the skb during error unwinding path.
>Fix it by freeing in error unwind path.
>
>Fixes: a12a2f694ce8 ("vdpa: Enable user to query vdpa device info")
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>---
> drivers/vdpa/vdpa.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 3d997b389345..e3f1bfdf8d6f 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -540,20 +540,22 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	if (!dev) {
> 		mutex_unlock(&vdpa_dev_mutex);
> 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>-		return -ENODEV;
>+		err = -ENODEV;
>+		goto err;
> 	}
> 	vdev = container_of(dev, struct vdpa_device, dev);
> 	if (!vdev->mdev) {
> 		mutex_unlock(&vdpa_dev_mutex);
> 		put_device(dev);
>-		return -EINVAL;
>+		err = -EINVAL;
>+		goto err;
> 	}
> 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> 	if (!err)
> 		err = genlmsg_reply(msg, info);
> 	put_device(dev);
> 	mutex_unlock(&vdpa_dev_mutex);
>-
>+err:

If we put this label before mutex_unlock(), we can remove that call in 
the error paths.

Maybe we can also add another label before put_device() and jump to it 
in the "if (!vdev->mdev)" case.

Thanks,
Stefano

> 	if (err)
> 		nlmsg_free(msg);
> 	return err;
>-- 
>2.26.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
