Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90319C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 10:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16A8A40586;
	Tue,  9 Aug 2022 10:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16A8A40586
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BVa7KMsr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q4iITMd6be3W; Tue,  9 Aug 2022 10:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77B45400A6;
	Tue,  9 Aug 2022 10:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77B45400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4BDC0032;
	Tue,  9 Aug 2022 10:44:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68B25C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35EE840522
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35EE840522
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4XMif_EtBfPu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:44:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11553400A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11553400A6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660041867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K0UDauW7jcnLQtitx4t4jJiAK2t9J+LTjI2mmV8bkCg=;
 b=BVa7KMsrDYTvvWeTLvGsiV818HdzX4B4GPQJK0YZXAKMfG1YATOR43YRr2r6mwICw7SQo3
 0AoBbBzf1Ntq7xl5AkyGJmObRJdWb0IiocurhAWiEZHvzLWutPOUFZ6kXe75DuW+JN1vRc
 UdP1j874e9vYzTWt73pVWKiiuFjBZXU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-eMpmOyKlMzmhcehp489kCw-1; Tue, 09 Aug 2022 06:44:27 -0400
X-MC-Unique: eMpmOyKlMzmhcehp489kCw-1
Received: by mail-ed1-f69.google.com with SMTP id
 w17-20020a056402269100b0043da2189b71so6919996edd.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 03:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=K0UDauW7jcnLQtitx4t4jJiAK2t9J+LTjI2mmV8bkCg=;
 b=JsqPIGOUvED2gjF072KAefkXN/6nR9m5N33gresJUlC57QIs/tu5dqTTgDBCsYWGKY
 tfv967mStFIklUQXafg1P9YOzx+UmtjkcQQO6glldI1nqkPQ4KCM8q7fIf9fmyNQ7ZAY
 PLy+KwX88OyIkh+wz8d2JWTaN8sM+T33d35pA9dxrsAQq/YfZgnsugvAT9zejSWJfNjR
 Qq3yIDbhXJhifmZZuQPjOj7uKcaUTC+d9AA5Scjcg83IWqetHZ6faUhDDE94JP5Itb0S
 A5EcqVfSTWBRaPMlZ+A6YpxbvkZEojoyvq30/WYvFEr6Djh2RoGPgmE6dN9WY+RsOoHY
 UI+g==
X-Gm-Message-State: ACgBeo18LVepc8fpWmuTCVAJ1eRhgf/tMtoBLRT5VUEQiWVByKBT66VO
 j83OOJO+VODddhE8CFOMEUn/kP2xV0Shf2pYlxfArPXzx+3UhJxPI9WaR4AimdLHSJ2r/uTaJJx
 m+kdhWfSArhtc6QaWFWMfkcz+nPlbUpGk6rSEj1AF9w==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id
 s26-20020a056402015a00b0043171b986f3mr21328925edu.249.1660041865810; 
 Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UrYjETSBNDh179gY/Os++gHkuwZKCKYdlFGMoNu727HdgqYnD540bhW1EJZwjeBs/5VRWPw==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id
 s26-20020a056402015a00b0043171b986f3mr21328907edu.249.1660041865601; 
 Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 2-20020a170906218200b0073156e6cd5csm1000743eju.3.2022.08.09.03.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
Date: Tue, 9 Aug 2022 06:44:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220809064252-mutt-send-email-mst@kernel.org>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel@openvz.org,
 linux-kernel@vger.kernel.org
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

On Tue, Jul 26, 2022 at 02:08:27PM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host
> and how that memory is accounted.
> 
> It is useful when debugging out of memory conditions,
> as well for userspace processes that monitor the memory pressure
> and for nested virtualization.

Hmm. debugging is ok. monitoring/nested use-cases probably
call for sysfs/procfs.


> Depending on the deflate on oom flag memory is accounted in two ways.
> If the flag is set the inflated pages are accounted as used memory.
> If the flag is not set the inflated pages are substracted from totalram.
> To make clear how are inflated pages accounted sign prefix the value.
> Where negative means substracted from totalram and positive means
> they are accounted as used.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> V2:
>   - fixed coding style
>   - removed pretty print
> V3:
>   - removed dublicate of features
>   - comment about balooned_pages more clear
>   - convert host pages to balloon pages
> V4:
>   - added a define for BALLOON_PAGE_SIZE to make things clear
> V5:
>   - Made the calculatons work properly for both ways of memory accounting
>     with or without deflate_on_oom
>   - dropped comment
> V6:
>   - reduced the file to minimum
>   - unify accounting
> 
> I didn't understand if you agree to change the accounting to be the same
> so following part 2 is about it.
> 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f4c34a2a6b8e..97d3b29cb9f1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -10,6 +10,7 @@
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -731,6 +732,59 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +
> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *vb = f->private;
> +	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
> +
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		num_pages = -num_pages;
> +
> +	seq_printf(f, "inflated: %lld kB\n", num_pages);
> +
> +	return 0;
> +}

Can't we just have two attributes, without hacks like this one?

> +
> +DEFINE_SHOW_ATTRIBUTE(virtio_balloon_debug);
> +
> +static void  virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +	debugfs_create_file("virtio-balloon", 0444, NULL, b,
> +			    &virtio_balloon_debug_fops);
> +}
> +
> +static void  virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +	debugfs_remove(debugfs_lookup("virtio-balloon", NULL));
> +}
> +
> +#else
> +
> +static inline void virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +}
> +
> +static inline void virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +}
> +
> +#endif	/* CONFIG_DEBUG_FS */
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  /*
>   * virtballoon_migratepage - perform the balloon page migration on behalf of
> @@ -1019,6 +1073,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1122,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> +	virtio_balloon_debugfs_exit(vb);
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -- 
> 2.25.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
