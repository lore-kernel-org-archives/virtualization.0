Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F1C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 08:20:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F2764D9A
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 08:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F2764D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18FEE6F5D4
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 08:20:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jl2v75Omhvvf for <virtualization@archiver.kernel.org>;
	Wed, 17 Feb 2021 08:20:39 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id E54DC6F52B; Wed, 17 Feb 2021 08:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47FF36F4D7;
	Wed, 17 Feb 2021 08:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B424C0893;
	Wed, 17 Feb 2021 08:20:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24AD7C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 08:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0ADAC871E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 08:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RelbaN9V8Ry7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 08:20:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2194F8716C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613550034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k0xrNYCR0BWhvnXoy/4bxBpl3MYWqciVP//PEpkTIac=;
 b=h4tnAd7s2yHffQxUUi9yZg11GcdN0qrU+2etfB1gRgVizSd9yJttuBIeLtjII0gmjBDJSu
 nS7hs/ja2QAne7TUpjlASoGvytYczKt+EOM/U64FgryoAEvHvYa2ZYaQ/ezuR5U9y5Pmq/
 /mA6L35ZdL0Pugfyg78/68WlhTEGUFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-suBpF26pNJiXbyAfOyhA8g-1; Wed, 17 Feb 2021 03:20:32 -0500
X-MC-Unique: suBpF26pNJiXbyAfOyhA8g-1
Received: by mail-wr1-f70.google.com with SMTP id h20so16166211wrb.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 00:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k0xrNYCR0BWhvnXoy/4bxBpl3MYWqciVP//PEpkTIac=;
 b=il3Xdu8Mv5qdvOnFLDNE5al0LbuSD585exv/+lzActCkPcCXw5W9519t66K7JJFjY1
 EESEU0IqERwZAP3Wcg07N5OmulCikCIrGgaEjp+AvicqD4jPQwYfT+ebEvdpIqEluftt
 Y6Byktv0j4z/FqdKFYzH1Sf8VqPmILcgfiQ8eFvUnlzT/cxoDshCCac/k3Hu7Udcysxc
 gy2YHdbyr1fW+3cvExz4/dLaWKlh0pvzW30Xr4u3ospsi6epppj46GCf3Pc2Mj5N8ESZ
 ahoUjtttivZUTUzHEkX62kulEF5Ozf59VgIykutNVV73fWRpzMlkZm/pjMaMoZmT0S2d
 7hRA==
X-Gm-Message-State: AOAM532Ffs0O012/gRGh5U4EBCHrmM4f9t0hPCa2dm8bZ41TJLX5V1UM
 TWyTZnL7Wn0gRzn7qqw4IUgU+U5sem8xdRdIGOEDd0q6gN17mLW33EZ4uXkisbvjxbKnV2BRf3b
 MJ3sFDmkhjr7aKeXXGcozj2MJE8yOoPjGz0GD8saR7A==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr6115650wmf.102.1613550031042; 
 Wed, 17 Feb 2021 00:20:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKwiELGnwZ6+W4TohbWsYmTgVZIW1GLms41bk9ZTtd0UxTHXLQozntUN4LjQiHjX3TviPpfA==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr6115630wmf.102.1613550030769; 
 Wed, 17 Feb 2021 00:20:30 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id z2sm1689930wmf.46.2021.02.17.00.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 00:20:30 -0800 (PST)
Date: Wed, 17 Feb 2021 09:20:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v2] vdpa: Fix memory leak in error unwinding
 path
Message-ID: <20210217082028.6dsdydy4wavrl64g@steredhat>
References: <20210217060614.59561-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210217060614.59561-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

On Wed, Feb 17, 2021 at 08:06:14AM +0200, Parav Pandit wrote:
>When device get command fails to find the device or mdev,
>it skips to free the skb during error unwinding path.
>Fix it by freeing in error unwind path.
>While at it, make error unwind path more clear to avoid such errors.
>
>Fixes: a12a2f694ce8 ("vdpa: Enable user to query vdpa device info")
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>---
>changelog:
>v1->v2:
> - Addressed Stefano's comment to make error unwind code more clear
>---
> drivers/vdpa/vdpa.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 3d997b389345..da67f07e24fd 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -538,22 +538,22 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	mutex_lock(&vdpa_dev_mutex);
> 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> 	if (!dev) {
>-		mutex_unlock(&vdpa_dev_mutex);
> 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
>-		return -ENODEV;
>+		err = -ENODEV;
>+		goto err;
> 	}
> 	vdev = container_of(dev, struct vdpa_device, dev);
> 	if (!vdev->mdev) {
>-		mutex_unlock(&vdpa_dev_mutex);
>-		put_device(dev);
>-		return -EINVAL;
>+		err = -EINVAL;
>+		goto mdev_err;
> 	}
> 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> 	if (!err)
> 		err = genlmsg_reply(msg, info);
>+mdev_err:
> 	put_device(dev);
>+err:
> 	mutex_unlock(&vdpa_dev_mutex);
>-
> 	if (err)
> 		nlmsg_free(msg);
> 	return err;
>-- 
>2.26.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
