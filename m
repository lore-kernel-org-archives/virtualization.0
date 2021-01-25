Return-Path: <SRS0=TROJ=G4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F344DC433E0
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 10:21:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C19206CA
	for <virtualization@archiver.kernel.org>; Mon, 25 Jan 2021 10:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C19206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B76DE20519;
	Mon, 25 Jan 2021 10:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mN4Zk4RQKjl; Mon, 25 Jan 2021 10:21:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8222F204F5;
	Mon, 25 Jan 2021 10:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5531AC08A1;
	Mon, 25 Jan 2021 10:21:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43577C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 18F4420519
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:21:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJ6IF51NADvR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:21:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C9249204F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 10:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611570103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=neC9gRrB4GfD4ikmR6bOJWjEMRDiBCVqaviG/V2Kj6M=;
 b=OsO2Vbyml8W9bImhgkFqVQ8lWsnipi2DrYBFHqH63Uu5brSKw4qmSoJlsb4v+I5IkVWYSA
 bRjm12z8cZ8/AU/8pJ16e5lEP60tEf9w/6VskrZXYL+IEaR8Q3gl/xqWyKENo/DS59lJqD
 PDkep7DriDX2xnMn3ZdGTFnFpNkVhLU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-r0FPjU4ZPge8nJRfdZUx8Q-1; Mon, 25 Jan 2021 05:21:40 -0500
X-MC-Unique: r0FPjU4ZPge8nJRfdZUx8Q-1
Received: by mail-wr1-f72.google.com with SMTP id u3so7121873wri.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 02:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=neC9gRrB4GfD4ikmR6bOJWjEMRDiBCVqaviG/V2Kj6M=;
 b=SOtqQf50ckXyp71eMdTgSsw7XokIUzQMcyjaDIygi+3+AJACb9LkUKagPJSUE5dXRD
 EeeB5iOM4D0jmMLhge2XxsBRS1bG7MWAS77TEEOuJ2iCXJ2jAMPpz4hBxs/mZn35H0T7
 IDPQkmW1VwSkesm0we9KfGsI0PeBK8yBNoeXAzBJb0D9l0Vkx2nZMfCaU0PGJ6xDkPDN
 0bh/o+hDlBBOCgb5KKYz2QTKELGHaUITpOP4IOEjYxdFwLTpFNatoiI8R95slmOvwOei
 tuVGWUG8jrPTs8qRr45isu58/z67NmQ0qkzrq9hFwE6dcPck7LAzPo6H8n0sIBzbi0t1
 dLug==
X-Gm-Message-State: AOAM530sGQT+O5H7tMwlFeOBWXafn9Gwi6eZ+DgZgVawg2YyQqeoBQ8z
 Bn+pLgmbK2ADP5s1DzdjL34qTIznOE+AyFn9zatACySC55C4BnxZ/Cfv6xIKt7CNWA9HvhI5Xn9
 XVgGobqdKC7FPuN7H7b/UHBvzaEjHD416AWJj5GWDcQ==
X-Received: by 2002:a05:6000:108b:: with SMTP id
 y11mr47289wrw.379.1611570099629; 
 Mon, 25 Jan 2021 02:21:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzo8xB0nNvfVQNlZFuiUUrKX4YBDOVPnzKGovmFB65m63nYV0NQGp/FRjcrGa9UOHgLHWoAig==
X-Received: by 2002:a05:6000:108b:: with SMTP id
 y11mr47272wrw.379.1611570099455; 
 Mon, 25 Jan 2021 02:21:39 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id z130sm20270523wmb.33.2021.01.25.02.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 02:21:38 -0800 (PST)
Date: Mon, 25 Jan 2021 11:21:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Colin King <colin.king@canonical.com>
Subject: Re: [PATCH][next] vpda: Fix memory leaks of msg on error return paths
Message-ID: <20210125102136.6e7dye5ucoe5qiw2@steredhat>
References: <20210122145235.209121-1-colin.king@canonical.com>
MIME-Version: 1.0
In-Reply-To: <20210122145235.209121-1-colin.king@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S . Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>
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

On Fri, Jan 22, 2021 at 02:52:35PM +0000, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>There are two error return paths that neglect to free the allocated
>object msg that lead to memory leaks. Fix this by adding an error
>exit path that frees msg.
>
>Addresses-Coverity: ("Resource leak")
>Fixes: 39502d042a70 ("vdpa: Enable user to query vdpa device info")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/vdpa/vdpa.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>index 9700a0adcca0..eb1f5a514103 100644
>--- a/drivers/vdpa/vdpa.c
>+++ b/drivers/vdpa/vdpa.c
>@@ -540,13 +540,15 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
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
>@@ -554,6 +556,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	put_device(dev);
> 	mutex_unlock(&vdpa_dev_mutex);
>
>+err:
> 	if (err)
> 		nlmsg_free(msg);
> 	return err;

The patch looks okay, but reviewing it I figure out that if 
genlmsg_reply() returns an error, it also frees the sk_buff passed, so 
IIUC calling nlmsg_free() when genlmsg_reply() fails should cause a 
double free.

Maybe we should do something like this (not tested):

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9700a0adcca0..920afcb4aa75 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -538,24 +538,29 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
         mutex_lock(&vdpa_dev_mutex);
         dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
         if (!dev) {
-               mutex_unlock(&vdpa_dev_mutex);
                 NL_SET_ERR_MSG_MOD(info->extack, "device not found");
-               return -ENODEV;
+               err= -ENODEV;
+               goto err_msg;
         }
         vdev = container_of(dev, struct vdpa_device, dev);
         if (!vdev->mdev) {
-               mutex_unlock(&vdpa_dev_mutex);
-               put_device(dev);
-               return -EINVAL;
+               err = -EINVAL;
+               goto err_dev;
         }
         err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
-       if (!err)
-               err = genlmsg_reply(msg, info);
+       if (err)
+               goto err_dev;
+
         put_device(dev);
         mutex_unlock(&vdpa_dev_mutex);
  
-       if (err)
-               nlmsg_free(msg);
+       return genlmsg_reply(msg, info);
+
+err_dev:
+       put_device(dev);
+err_msg:
+       mutex_unlock(&vdpa_dev_mutex);
+       nlmsg_free(msg);
         return err;
  }
  

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
