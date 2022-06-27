Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365A9C433EF
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 13:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8A6F83F37;
	Mon, 27 Jun 2022 13:00:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8A6F83F37
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TbcnuE/m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M3nBLGNpFRiW; Mon, 27 Jun 2022 13:00:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AA2683EDC;
	Mon, 27 Jun 2022 13:00:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AA2683EDC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0845C0032;
	Mon, 27 Jun 2022 13:00:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80CCFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5286240181
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5286240181
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TbcnuE/m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3No9qfYMsty
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:59:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72DC04013F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 72DC04013F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656334797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4z4+u6l8RM+f5xT0Nol3aJ6atxf8zDUCJYjlwIN4J+U=;
 b=TbcnuE/m5Zyjd/KEh787VhcchdubHd1sgpDQcwxsP6PLHDDOHJ+4kuK3VeVavUUbiiFtBM
 fSEnJABoVZupVcqooAy8pyod80isLog8NzOi0M9Y/HNhDjrbo0jV+NN07k56iL2zWXQixA
 KkJ19UMrjD5vQT15DidenN8esHF/ciU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-tFMuPM-bPtOcHvyfh9R9jg-1; Mon, 27 Jun 2022 08:59:56 -0400
X-MC-Unique: tFMuPM-bPtOcHvyfh9R9jg-1
Received: by mail-wm1-f71.google.com with SMTP id
 k32-20020a05600c1ca000b0039c4cf75023so7272931wms.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4z4+u6l8RM+f5xT0Nol3aJ6atxf8zDUCJYjlwIN4J+U=;
 b=7X/OVOjQ1dxPw3GfzLOC7FRHokQd84OOm5Y2VKXIvgkW6KA5fYQxufHzk4AGjKhOkn
 A1Kzl6Pn0Ctc2zVxi+jqppEjh+YQjR387wf5QB3mmshuEVWt0gDNV3coETAh2I5iwMDB
 A2JaqYwqFwK0XMkElqCl/RL2UtlYcA+am+dgtoTaDzQGAKnC0+mg+GRp0Xq87t9FE8+j
 PsAvqDZ33MeTD+hCMi7T0Zn21yYZTHWa/VCk8K9H6M+OGNaRsAH06kjfhHchZdrLGR+h
 YPxN3aXdl0el/sY1GvGQ9vRA/G3HzOzZKD5gnWGO4/e1MJYT7Da80KvN3uV5ig8c7L4D
 UTgA==
X-Gm-Message-State: AJIora84nwQVmvyqcSq21KS2uaOFxCvs8hkC9CWlRPLB3cdNVOAupwaI
 k9RBhRxOlKbEUmjx3ERDCw0thgX4SVvPTyH8QCdLR8kI/8lfVkbZRsNDTB8wVXkZL6UjcmemUB8
 pSFItW5u4hQolKRUyr/LPEDXbeBBMTL5zmhICAL9Rzg==
X-Received: by 2002:adf:e801:0:b0:21b:873f:ed62 with SMTP id
 o1-20020adfe801000000b0021b873fed62mr12160816wrm.17.1656334795069; 
 Mon, 27 Jun 2022 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXFxO0sEwkc+5NtkEPfxEFPBlTqwgUpUXpWj9PWBu2TdukCMiQ0cpnMZcqOlExV1HFBRbNEw==
X-Received: by 2002:adf:e801:0:b0:21b:873f:ed62 with SMTP id
 o1-20020adfe801000000b0021b873fed62mr12160794wrm.17.1656334794837; 
 Mon, 27 Jun 2022 05:59:54 -0700 (PDT)
Received: from redhat.com ([2.54.45.90]) by smtp.gmail.com with ESMTPSA id
 p6-20020a5d48c6000000b00212a83b93f3sm10459381wrs.88.2022.06.27.05.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 05:59:54 -0700 (PDT)
Date: Mon, 27 Jun 2022 08:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: alexander.atanasov@virtuozzo.com
Subject: Re: [PATCH 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220627085838-mutt-send-email-mst@kernel.org>
References: <20220627122038.1921522-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20220627122038.1921522-1-alexander.atanasov@virtuozzo.com>
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

On Mon, Jun 27, 2022 at 12:20:38PM +0000, alexander.atanasov@virtuozzo.com wrote:
> From: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> 
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 91 +++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..a32a52c28a1f 100644
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
> @@ -731,6 +732,91 @@ static void report_free_page_func(struct work_struct *work)
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
> +	seq_printf(f, "%-22s:", "capabilities");

why aren't features in sysfs sufficient for this? pretty printing
can be done in userspace ...

> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST))
> +		seq_puts(f, " tell_host");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_STATS_VQ))
> +		seq_puts(f, " stats");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		seq_puts(f, " deflate_on_oom");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		seq_puts(f, " free_page_hint");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> +		seq_puts(f, " page_poison");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_REPORTING))
> +		seq_puts(f, " reporting");
> +
> +	seq_puts(f, "\n");
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);
> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/* Memory returned to host or amount we can inflate if possible */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages", i.totalram);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages", i.totalram-num_pages);

spaces around -

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
> @@ -1019,6 +1105,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1154,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
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
