Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BFFC433F5
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 07:46:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D960560F9D
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 07:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D960560F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9026F814B1;
	Sun,  5 Sep 2021 07:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id herXu3-QoX5M; Sun,  5 Sep 2021 07:46:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 224098101C;
	Sun,  5 Sep 2021 07:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02707C001A;
	Sun,  5 Sep 2021 07:46:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7364DC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 07:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FECF81020
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 07:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HE52eYt1PamV
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 07:46:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9E7A8101C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 07:46:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C849360555;
 Sun,  5 Sep 2021 07:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630827996;
 bh=O/ZxP3FhOz37k0frdZmwLZpa5oBRB8mmxRGdut1wTDs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l/n5ExtJ0lN140PPLg37CRQXuH3DT+TA3Oki8D+6E8+aoYkaeS3r68Rucy5CGcKbI
 mpp9ne8wEbkSqnLUxI2hGXfIdxTvYXYkEmfEUzPMGn3FYHzNmjmCkMLagls1eJqpRh
 wWVoCqII96pbG56Tt6e9mjtgw9QcVdTbs3hU5lGdOBJEibeq9n/uNR3xnormFYb1f9
 9c2tNLosDtsYTePJ6Y/c+SXGfD/3uJd+SGXSS4LXw8O74bNXXqWleV9E7f79nzkw0C
 WCTE+4WdfdKFbLhkQFWG9TChM2kWIJXtPjkuCvV0gopzPjDXiG8Uqj5ItTWHdAr+Af
 THLmYI/iz//nA==
Date: Sun, 5 Sep 2021 10:46:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: add num_request_queues module parameter
Message-ID: <YTR12AHOGs1nhfz1@unreal>
References: <20210902204622.54354-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210902204622.54354-1-mgurtovoy@nvidia.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
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

Won't it limit all virtio block devices to the same limit?

It is very common to see multiple virtio-blk devices on the same system
and they probably need different limits.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
