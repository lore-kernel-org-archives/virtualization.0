Return-Path: <SRS0=/Kss=NV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B39EC432BE
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:48:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5FE60E90
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 21:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B5FE60E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE4B1605AB;
	Mon, 30 Aug 2021 21:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fOWVN7beK-0p; Mon, 30 Aug 2021 21:48:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FADE606B9;
	Mon, 30 Aug 2021 21:48:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19290C0010;
	Mon, 30 Aug 2021 21:48:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D845C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07FC24038F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:48:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ijMV_mxPWB6f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:48:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF34F40198
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 21:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630360118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AmK5AK//VpDNOflKYrie75fU9H15kJEGNG5tiW/9pzA=;
 b=RVODUNDAVOSbrtZemWwsw+8SdJ1FaYLDkXY/+aINyP3f3oeXYTMcphyz5D0JSRwuEn4GCb
 5R3HUrNhSVZgzMUT2sr9FWUc0BnJ6OI4WphZXhu/aToc4NXyY0A3eGcodLOhc6jTqiPM3Q
 dL7Rro/flEF+xsW21kE9oLunBERa3RQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-NqY_sKmPMK6hNhLbhxx2bQ-1; Mon, 30 Aug 2021 17:48:37 -0400
X-MC-Unique: NqY_sKmPMK6hNhLbhxx2bQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 p1-20020adfcc81000000b001576cccf12cso3574810wrj.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AmK5AK//VpDNOflKYrie75fU9H15kJEGNG5tiW/9pzA=;
 b=sniMmjKQ8BXXowejBf+2O+QE9+KjjjGyRDzMfPFwMq3u0c7r1BkQotq7HJ4XNIiMMB
 LNumCVDsu+JUEu7Z1sbw+6CzmTFvv6lOqJzYJaLyqF6IE/SCPjX3evBOZPlelfr/PHDm
 KskLrjPXfRS3K0/K5F3+/TldvdLKkGg0+duyLbug8C3C9IeL5+rtbRK1hkDFqei8iVqR
 I8znSOc04aaSasISTtoLhMyGxbx9EI0f8Q11kThPqR3G5Y4SUtl9KMC+0sEqL89FjYdh
 GjZ7mxT8Qw25xUS26EguziC2ZR8ZiHFiLvEuXlwNWXMEBs0lzWRzNQ6ovuBNKSr6tayT
 yj+Q==
X-Gm-Message-State: AOAM533Fs+9S6KQGLkb7IrYaBdx0dND7U4MpSL0QX1gC9rqC3Ovr1VN9
 KPHShcYDDbOnynf/eu1oom9zS2YBxzZNgIBZMcOsn1y6xeZmirZ2q8hB2ABgkaDM5dcPoBdMV5T
 3R22gB3Xw4NksBV6peLqjw2J8lK2efdyUB3R4HZtvMw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr967737wma.121.1630360115922; 
 Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5fhrlu0kEOzo1cvWkb9o9z8Fn1FmpxfqvNOtZoj6358rRlPDpe9fYiRVrse76ReP25wmvgw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr967723wma.121.1630360115695; 
 Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id v62sm68440wme.21.2021.08.30.14.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 14:48:35 -0700 (PDT)
Date: Mon, 30 Aug 2021 17:48:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210830174345-mutt-send-email-mst@kernel.org>
References: <20210830120023.22202-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210830120023.22202-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, oren@nvidia.com
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

On Mon, Aug 30, 2021 at 03:00:23PM +0300, Max Gurtovoy wrote:
> Sometimes a user would like to control the amount of IO queues to be
> created for a block device. For example, for limiting the memory
> footprint of virtio-blk devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>


Hmm. It's already limited by # of CPUs... Why not just limit
from the hypervisor side? What's the actual use-case here?

> ---
>  drivers/block/virtio_blk.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e574fbf5e6df..77e8468e8593 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -24,6 +24,28 @@
>  /* The maximum number of sg elements that fit into a virtqueue */
>  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
>  
> +static int virtblk_queue_count_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	unsigned int n;
> +	int ret;
> +
> +	ret = kstrtouint(val, 10, &n);
> +	if (ret != 0 || n > nr_cpu_ids)
> +		return -EINVAL;
> +	return param_set_uint(val, kp);
> +}
> +
> +static const struct kernel_param_ops queue_count_ops = {
> +	.set = virtblk_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int num_io_queues;
> +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> +MODULE_PARM_DESC(num_io_queues,
> +		 "Number of IO virt queues to use for blk device.");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  
> @@ -501,7 +523,9 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> +	num_vqs = min_t(unsigned int,
> +			min_not_zero(num_io_queues, nr_cpu_ids),
> +			num_vqs);
>  
>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>  	if (!vblk->vqs)
> -- 
> 2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
