Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED927C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95969611C3
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95969611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B83D4020E;
	Fri, 22 Oct 2021 09:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1gx9IpNkyqD; Fri, 22 Oct 2021 09:30:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD80A40172;
	Fri, 22 Oct 2021 09:30:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92624C001F;
	Fri, 22 Oct 2021 09:30:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A9CC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A926260602
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VkUmGVMSXvLh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:30:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F0A1605F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634895045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exmt4jTkemurDoyQgXRU8PvM8wbQD/c3j+4KTnsT5S0=;
 b=bAt344ysr9WBGR1ZcgaripBh7WSBzaoqSOU8kU9PiTHOg+f13A8zotwszOWRV19cnb7PyB
 2VTolI8jrO9WJD9/yO1ny9UBKC5WEhcUYY7F4iyr+tvYpXEXByMqvpKW2M0YbmfnVTJtYP
 YflQCXelIdeksll81EVEQEOOXSFQNxU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-nBfKNbyfMkmQCuVY-mZlSA-1; Fri, 22 Oct 2021 05:30:44 -0400
X-MC-Unique: nBfKNbyfMkmQCuVY-mZlSA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c5-20020a05600c0ac500b0030dba7cafc9so766579wmr.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Exmt4jTkemurDoyQgXRU8PvM8wbQD/c3j+4KTnsT5S0=;
 b=RE2GCt0U01yaqy/xwxKGixjSVKsDwt2kaOuP1QVYP1uS2VZIQAzOt4//COKYj5PisY
 6TvXhrGeHGIc2jscJ2UNzM9Luu4r/iNz7MLp06XsAKcjDzyKb7H6hkdFBYbZ7Qh9ygxI
 T8poR1Jw44hKMm/vUpal3sXrfdCXXYt06PqnF08xR+O+QdXqaN58nsTbBZVgC0q2Ekso
 UNt8zq1fwo1PJPJnJ5A2hXo/fZxP8mMnH08oQCtxM4dFDlLLuyqNTFqzFZzzICxyRyna
 84ZtVOEamKQ6NMP8Bl2xmwIvx3NHgiq0Xh89hkig3rRvAmCkF54MTFW3JC/zfUuQRKCN
 ifAg==
X-Gm-Message-State: AOAM531Laoju1NQBhlQiXKV7tZYclKDgpTF4yNB8GI9865QZf4qiFNnS
 ZvfcCmQ3XJnTjJI3vuqOLAWQXWNSKpCInmVcnuqXZ0eKuC5jD+S2/UB6bYkOTKTAuROWEeRNbsi
 zroUOlMEGdwLFwjHaCHK0s2zdtQltgkfu5Xk8kVowCQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2694853wrm.181.1634895043222; 
 Fri, 22 Oct 2021 02:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygejYN4wrbg0gCwYPCQWk12aliJB5cOOwmEtPe9Fbvdiu9h0LjGVc51OvnzWH3A2vl4yneaQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr2694835wrm.181.1634895043076; 
 Fri, 22 Oct 2021 02:30:43 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id l5sm7503858wru.24.2021.10.22.02.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:30:42 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:30:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <20211022052950-mutt-send-email-mst@kernel.org>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210902204622.54354-1-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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

On Thu, Sep 02, 2021 at 11:46:22PM +0300, Max Gurtovoy wrote:
> Sometimes a user would like to control the amount of request queues to
> be created for a block device. For example, for limiting the memory
> footprint of virtio-blk devices.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v2:
>  - renamed num_io_queues to num_request_queues (from Stefan)
>  - added Reviewed-by signatures (from Stefan and Christoph)
> 
> changes from v1:
>  - use param_set_uint_minmax (from Christoph)
>  - added "Should > 0" to module description
> 
> Note: This commit apply on top of Jens's branch for-5.15/drivers
> 
> ---
>  drivers/block/virtio_blk.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4b49df2dfd23..aaa2833a4734 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -24,6 +24,23 @@
>  /* The maximum number of sg elements that fit into a virtqueue */
>  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
>  
> +static int virtblk_queue_count_set(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> +}
> +
> +static const struct kernel_param_ops queue_count_ops = {
> +	.set = virtblk_queue_count_set,
> +	.get = param_get_uint,
> +};
> +
> +static unsigned int num_request_queues;
> +module_param_cb(num_request_queues, &queue_count_ops, &num_request_queues,
> +		0644);
> +MODULE_PARM_DESC(num_request_queues,
> +		 "Number of request queues to use for blk device. Should > 0");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>  

I wasn't happy with the message here so I tweaked it.

Please look at it in linux-next and confirm. Thanks!


> @@ -501,7 +518,9 @@ static int init_vq(struct virtio_blk *vblk)
>  	if (err)
>  		num_vqs = 1;
>  
> -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> +	num_vqs = min_t(unsigned int,
> +			min_not_zero(num_request_queues, nr_cpu_ids),
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
