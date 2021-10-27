Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47582C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:02:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC41F60EFF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 20:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC41F60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9524040583;
	Wed, 27 Oct 2021 20:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwtcHBysrsho; Wed, 27 Oct 2021 20:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 38D9A40581;
	Wed, 27 Oct 2021 20:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D0A2C0012;
	Wed, 27 Oct 2021 20:02:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D98C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98DCB40423
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6F2h9iOFWmeL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C53DC400FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 20:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635364933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKmmGD1nx7i4kqTzjfQkUa6PYfuzA04HlQL71OLcyPY=;
 b=JrdUJ8VpNYx8C4/R6EsRzRdu924e1cv96AV3lt8pvdpcjSTC22XUXSyOwY+3013Zzig2Nt
 EQNcn0x1hY3On+XEkl4hRy6UEPtSlTyX66OPcyNFHCyYZePwBEjA9ukAH2xMXN4s1v6jal
 GAto4Z13XoCHhoIUoPBCqRz5uPEgA/U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-UL0ExdXKPCiq_tN6UHojOA-1; Wed, 27 Oct 2021 16:02:12 -0400
X-MC-Unique: UL0ExdXKPCiq_tN6UHojOA-1
Received: by mail-ed1-f70.google.com with SMTP id
 s18-20020a056402521200b003dd5902f4f3so3325650edd.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 13:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eKmmGD1nx7i4kqTzjfQkUa6PYfuzA04HlQL71OLcyPY=;
 b=m9et5obucNjLlnnXyi7qpy29XCe/fxoLXzIqBgNN8nLCu72cgVXIk8CMEoHlLhnRqI
 /DHcAROrOfNp6OZms6EswheZbmxgzOGarXBhieb0qQEpW7Dk4JLA3g5YsLcqbSRVIwVi
 y0vIXAf1LpiCWWvzsihdf2GE0rU4rcytFfLxF8Rcd/Hv7p1r98NAZoXSOxesc1BjNXKg
 LNDNvnBJWX27VP4S3OxNnZWha7T0Gmc9m7FKQQBxjPhj9KIhc17uwdHxzdQEDZqMR/4m
 aUN6FwUBsu2qY1eqi/J+F0VwDow4it74k3Q7SuBM55R9t4kZCslCjH0r4nzqMJMrKrM0
 I8sg==
X-Gm-Message-State: AOAM533wRoG4qgFDYqB8CHubfHzWh2Y4+AcAlHkKhLzAw9bgpw5ZX+Ib
 4PAjFKnxq9Baofo/Hg89mAx/KRAscbfO/fMsU1Vvx4v+ViA7ZOjL4GNc/CEy/6LnkA1M11zWI/J
 8dWAmy84TfUOl25oFu/WSvT0Oty3gF8835E4Ts/doGQ==
X-Received: by 2002:a50:d4c9:: with SMTP id e9mr47956052edj.12.1635364931126; 
 Wed, 27 Oct 2021 13:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrbQM+YpSGU4dsYU7jyrTt7pf6zqbcGk70m2QTsfqcvWmFs6yg5FyLDWycPtgyIove9NTZ6w==
X-Received: by 2002:a50:d4c9:: with SMTP id e9mr47956020edj.12.1635364930922; 
 Wed, 27 Oct 2021 13:02:10 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
 by smtp.gmail.com with ESMTPSA id ne2sm420373ejc.44.2021.10.27.13.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 13:02:10 -0700 (PDT)
Date: Wed, 27 Oct 2021 16:02:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH] vhost: Make use of the helper macro kthread_run()
Message-ID: <20211027160010-mutt-send-email-mst@kernel.org>
References: <20211021084406.2660-1-caihuoqing@baidu.com>
MIME-Version: 1.0
In-Reply-To: <20211021084406.2660-1-caihuoqing@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, Oct 21, 2021 at 04:44:06PM +0800, Cai Huoqing wrote:
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Pls check how this interacts with Mike Christie's patches.
Pls fix up the typo in the commit log.

> ---
>  drivers/vhost/vhost.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..e67bd5603b5f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -595,15 +595,15 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	dev->kcov_handle = kcov_common_handle();
>  	if (dev->use_worker) {
> -		worker = kthread_create(vhost_worker, dev,
> -					"vhost-%d", current->pid);
> +		/* avoid contributing to loadavg */

doesn't this comment have any value anymore?

> +		worker = kthread_run(vhost_worker, dev,
> +				     "vhost-%d", current->pid);
>  		if (IS_ERR(worker)) {
>  			err = PTR_ERR(worker);
>  			goto err_worker;
>  		}
>  
>  		dev->worker = worker;
> -		wake_up_process(worker); /* avoid contributing to loadavg */
>  
>  		err = vhost_attach_cgroups(dev);
>  		if (err)
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
