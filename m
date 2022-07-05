Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3015DC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 08:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF6F260EFB;
	Tue,  5 Jul 2022 08:59:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF6F260EFB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3fJbUOi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PxALjON2Uv11; Tue,  5 Jul 2022 08:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F5B960EEC;
	Tue,  5 Jul 2022 08:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F5B960EEC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC52FC0032;
	Tue,  5 Jul 2022 08:59:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E86FEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 08:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1ED940502
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 08:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1ED940502
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G3fJbUOi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tVCEjLh7BmEb
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 08:59:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9721C400EF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9721C400EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 08:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657011589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+UC/vpAZ24B41yJaSERUjpzXj/4P7BrqzPeTPZNYUSk=;
 b=G3fJbUOiMCS8QXvoYVdzzkPgJbm5Ql1H3ZWQBbW4oNAjaaYzQBvqrUU7EvC0gsfnJmSZOO
 nSSPjZlVRrhM4QeS2bVufvM2UwVJ8puJMrvN0i6ju13MoeBoYiTuYJQQyw/l0RhqvG7JFa
 KlWE9dY1U0VmlVtX880BhbXUQORqJro=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-f5fGhfRRNb2om5pNduiRzg-1; Tue, 05 Jul 2022 04:59:47 -0400
X-MC-Unique: f5fGhfRRNb2om5pNduiRzg-1
Received: by mail-ed1-f70.google.com with SMTP id
 i9-20020a05640242c900b004373cd1c4d5so8818223edc.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 01:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+UC/vpAZ24B41yJaSERUjpzXj/4P7BrqzPeTPZNYUSk=;
 b=ZqbdZJl1DVFVg8W5GOWgOzmJTb4FdLWYntpQoTPRbNtWHjq8WCW5Gkh0YSXU39ZX/E
 o0iWaK8/l8CrFmWPw9mSGNExWc49BdSynkRSNyGffXFjVfuiilWhoVuwPzFQYPffBHs9
 ZxpfdL0CDPyp2jpq49LyREed5UFIiIjyy1YVAxmh7FvvxmUy8S4hY15D6isgZf5AFrcQ
 0cp9ffRhCtlJNMdcy2sN1As+8v0+fbON0RzpuMPkLUpnYapEJCNtLhDkp41yoPjC76Wb
 +sLxIe8pKE1H+UZLMzrFVQ7OsX++/gE8lD1zr/GZYFU6YuZB/V8iEthR4UDkpIuLCrfr
 yiOw==
X-Gm-Message-State: AJIora9LXIvI034pzADqwqU7Jp46m+Y3rieGNPsaPedngIir/QNEOHJF
 PoPNznZRhBdV2QICow5xwmKw4MmdX6hrzJ1xJD2IuHcAyZp6U/enaQOmjgPYvYf7S1MmRR0QEkT
 QrPe0qm+nVPfM1CfLnnOGfXARKTbyM2qs/NlCKU0rwg==
X-Received: by 2002:a17:907:6d1d:b0:726:363e:cca3 with SMTP id
 sa29-20020a1709076d1d00b00726363ecca3mr32657356ejc.713.1657011586767; 
 Tue, 05 Jul 2022 01:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8yxRBy3xDLi7w7e5LNzTm1PgIo8eoKRWrZOilTxJAHABYZhdkwvgHvAIzrmk1L4W21Ao6Wg==
X-Received: by 2002:a17:907:6d1d:b0:726:363e:cca3 with SMTP id
 sa29-20020a1709076d1d00b00726363ecca3mr32657342ejc.713.1657011586452; 
 Tue, 05 Jul 2022 01:59:46 -0700 (PDT)
Received: from redhat.com ([2.54.184.191]) by smtp.gmail.com with ESMTPSA id
 uz12-20020a170907118c00b00711aed17047sm15357907ejb.28.2022.07.05.01.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 01:59:45 -0700 (PDT)
Date: Tue, 5 Jul 2022 04:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220705045912-mutt-send-email-mst@kernel.org>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
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

On Tue, Jul 05, 2022 at 08:36:37AM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 78 insertions(+)
> 
> V2:
>  - fixed coding style
>  - removed pretty print
> V3:
>  - removed dublicate of features
>  - comment about balooned_pages more clear
>  - convert host pages to balloon pages
> V4:
>  - added a define for BALLOON_PAGE_SIZE to make things clear
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..dc4ad584b947 100644
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
> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
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
> +	struct virtio_balloon *b = f->private;
> +	u32 num_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/*
> +	 * Pages allocated by host from the guest memory.
> +	 * Host inflates the balloon to get more memory.
> +	 * Guest needs to deflate the balloon to get more memory.
> +	 */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
> +			guest_to_balloon_pages(i.totalram));
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages",
> +			guest_to_balloon_pages(i.totalram) - num_pages);
> +
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
> @@ -1019,6 +1091,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1140,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> +	virtio_balloon_debugfs_exit(vb);
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..f3ff7c4e5884 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -40,6 +40,7 @@
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1

Did you run checkpatch on this?

> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
