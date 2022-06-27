Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB38C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 20:43:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3FC060E31;
	Mon, 27 Jun 2022 20:43:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3FC060E31
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CfmvMVuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0QNziyQFrQt; Mon, 27 Jun 2022 20:43:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0167760C0A;
	Mon, 27 Jun 2022 20:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0167760C0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBCE2C0032;
	Mon, 27 Jun 2022 20:43:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C4CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 20:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9609640289
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 20:43:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9609640289
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CfmvMVuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfJZFiG3-dvf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 20:43:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B161A400E5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B161A400E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656362586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdFpjlfe7+cJrMqoUp1W/ykiOEhVBVxyL8rdJnP53N4=;
 b=CfmvMVuT8ht2KN9lIw7SEs0pTqBQ1WjGKLvhT6/duFMV6Er+L39yzfyjVkdHxP8YUW0Mmb
 PURtKGXv0qpRdw/R0y86zWvo9lPKxrLdiwPPPxelTLknwtqwMzXsuRQzGvA4i1xM7s0lbQ
 LUOtcJPb+VltqsCdU8etrC09p0zwKv0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-TVCKJTAOMemGCP7W4Tu3yA-1; Mon, 27 Jun 2022 16:43:03 -0400
X-MC-Unique: TVCKJTAOMemGCP7W4Tu3yA-1
Received: by mail-ej1-f72.google.com with SMTP id
 l2-20020a170906078200b006fed42bfeacso2863595ejc.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FdFpjlfe7+cJrMqoUp1W/ykiOEhVBVxyL8rdJnP53N4=;
 b=whDzDKQ9GUqpmNoOGg7nWUHBB+PK5tSSEPignVl/s4TpX+C8o7BIKLb26b1nl/cgFK
 3AoIL99N4b+GmG4tdIoOTJId5IX3fh38WEn5LoRNnW8aw+bYzj+wfK9yTu1/xDMdZyTq
 fZEjf5p/yq0QlrFRsAtH2eRZozQDS+Pp4uHM++0XaufKNjB5EuIQSFJM200D58Xv6Fdo
 ux9VR8eldvlXtS0tWE9KvC8TdBGWSbbLbYXHtWJu6RaR8H6cRS3cHiBjcVJQPWcQj+B/
 wKlUslGeWauQ9UinNf1ldhxOpdbF/c9Fnj3CuiigT9JHf1fS1G/KE2Ozo1OQyx05sEOE
 74MA==
X-Gm-Message-State: AJIora/UZwQfH53gUmQVA8dHHh7+Q0afEDpiW0zEh3GMFoUx0rkr9Ovy
 J+MbMJrBq6NJ1ZRcHA9oFHfti9WzypzJcU+kkZ7wx/wZCdXm14HHUZyAK1gB9EPS4VgFMcqW1LC
 hpyxHDgMq/YIVwo0N7J5tdzU45aVDngpQ2uQs71zsMg==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id
 m13-20020a17090672cd00b00722d84b30e3mr14587590ejl.726.1656362582143; 
 Mon, 27 Jun 2022 13:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0yWLqQdqcWsKIFcdF09hybrWah5p/9e091idZ1EyzP3waUwLnryCBkPyygZ9zPVtt/4AJsw==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id
 m13-20020a17090672cd00b00722d84b30e3mr14587578ejl.726.1656362581922; 
 Mon, 27 Jun 2022 13:43:01 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 bl24-20020a170906c25800b00704757b1debsm5410981ejb.9.2022.06.27.13.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 13:43:01 -0700 (PDT)
Date: Mon, 27 Jun 2022 16:42:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220627163714-mutt-send-email-mst@kernel.org>
References: <20220627085838-mutt-send-email-mst@kernel.org>
 <20220627191910.22734-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220627191910.22734-1-alexander.atanasov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Mon, Jun 27, 2022 at 07:19:09PM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> No pretty printing and fixed as per coding style.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 71 +++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> - Leave pretty print to userspace
> - Fixed coding style
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..1bb6a6d0e37b 100644
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
> @@ -731,6 +732,71 @@ static void report_free_page_func(struct work_struct *work)
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
> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *b = f->private;
> +	u32 num_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %llx\n", "capabilities", b->vdev->features);

why do we need this in debugfs? Isn't this available in sysfs already?

> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);

I suspect this function doesn't work properly when page size is not 4K.

> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/* Memory returned to host or amount we can inflate if possible */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);

I don't really get the comment here.

> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages", i.totalram);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages", i.totalram - num_pages);

Are you sure these are in units of 4Kbyte pages?

> +	return 0;
> +}
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
> @@ -1019,6 +1085,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1134,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
