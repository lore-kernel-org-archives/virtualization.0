Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC490C43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:05:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6D122363
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF0uSzGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6D122363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A78A2034C;
	Mon, 19 Oct 2020 15:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GIOM9rQd0mEw; Mon, 19 Oct 2020 15:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 280E1204A9;
	Mon, 19 Oct 2020 15:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03EDAC088B;
	Mon, 19 Oct 2020 15:05:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A298C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5DEA4204A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpIAF6E8KCNL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 23A182034C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603119914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=enxheWw2McIocYr80cymg5IkoOYMMC2QNkvFOJ2MElw=;
 b=MF0uSzGhc0y575g1wlE+DURhHq0Fvex4lhBgp+SrWUpbbB3e7PDNLcWqyXmKlcrSX8LlIv
 6ZDuJuC95cxSzHtOPTZXUIiUM7R9yEcKT6Aq7KqEAdiFf9QpqdzhFNMShKJeGC0m3gC+eI
 xJ9lWz0gE+iPvEetWsTVYlByNXWxlys=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-dCrFdvT1NDOwUSqtl-owGQ-1; Mon, 19 Oct 2020 11:05:12 -0400
X-MC-Unique: dCrFdvT1NDOwUSqtl-owGQ-1
Received: by mail-wm1-f71.google.com with SMTP id y83so40490wmc.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=enxheWw2McIocYr80cymg5IkoOYMMC2QNkvFOJ2MElw=;
 b=TlTE9xeEaqgzenmHt4v2abUTsnfcQJmP73UDUWUYQNfhMPcY5xr4ZQYoKtNySGAsVM
 MgkQl+yJ8gJ0kzpmp/XJw4qRgu3Z+yIKgcnBXAX4G+Yth+zLLl/jvy5KsXWc9ARwiwa9
 oIQM54arAqTmtUcgL2zts7Sm+T8zTDhIS8wI7KQc6UDmHSOc9DFP7w93/0kC+bN7XUh1
 j77n9pDk0FuN5yN5LZkXYh/b4HY/JHQUEg6AxSOBRWV5S6iO+w0dum7D3i2aUfoQrW4R
 cyAMz1UueaZbtrv6Arpa7TVkCo4qluHg6VzeikLn/9Et06clqfsFwg6dRi40eou9DAE5
 7VLQ==
X-Gm-Message-State: AOAM530fdlzzZPtqMs/NsBIz7Palnp94Q+Hbr1a0qPXKySC5jLm7o0gF
 EJGRNd8TM0MTzpbPAqf1Mm093ArD8vurE2ohbtDK7BvQbHonCJDnipiTZ5qVvajTHwlG3SyOgxd
 i+T2XKJD3VKrCT/9v8ydMZ0d7++S6OfzlRzIi1+nnIQ==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr3382557wmc.188.1603119911197; 
 Mon, 19 Oct 2020 08:05:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3S3i/HQ0OG5rt1LRdaMyszGX8TmDnqPMqyYCkULMyQOpS5GSU0GakFsswV+fZc56ZoUQOsw==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr3382540wmc.188.1603119910955; 
 Mon, 19 Oct 2020 08:05:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p9sm359354wma.12.2020.10.19.08.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:05:10 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:05:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC 3/4] vduse: grab the module's references until there is no
 vduse device
Message-ID: <20201019110359-mutt-send-email-mst@kernel.org>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019145623.671-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20201019145623.671-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Oct 19, 2020 at 10:56:22PM +0800, Xie Yongji wrote:
> The module should not be unloaded if any vduse device exists.
> So increase the module's reference count when creating vduse
> device. And the reference count is kept until the device is
> destroyed.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6787ba66725c..f04aa02de8c1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -887,6 +887,7 @@ static int vduse_destroy_dev(u32 id)
>  	kfree(dev->vqs);
>  	vduse_iova_domain_destroy(dev->domain);
>  	vduse_dev_destroy(dev);
> +	module_put(THIS_MODULE);
>  
>  	return 0;
>  }
> @@ -931,6 +932,7 @@ static int vduse_create_dev(struct vduse_dev_config *config)
>  
>  	dev->connected = true;
>  	list_add(&dev->list, &vduse_devs);
> +	__module_get(THIS_MODULE);
>  
>  	return fd;
>  err_fd:

This kind of thing is usually an indicator of a bug. E.g.
if the refcount drops to 0 on module_put(THIS_MODULE) it
will be unloaded and the following return will not run.



> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
