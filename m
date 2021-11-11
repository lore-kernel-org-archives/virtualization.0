Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEB1C433FE
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E517161284
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E517161284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA0F08198D;
	Thu, 11 Nov 2021 16:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m3RJga5HHNHB; Thu, 11 Nov 2021 16:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39511819D5;
	Thu, 11 Nov 2021 16:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F787C001F;
	Thu, 11 Nov 2021 16:57:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD0FEC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4C6C40514
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqoPcQsugrMF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7E7E40513
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636649858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nnuPe2lK5wahIQd1KXZIXGUVFrD/7Ht6SqdOl/REkM=;
 b=bWXyNueY5iSgIihPm9Yyzun7t4nYazHRnALUZ/49Ey9W8JZxgjGWs0WxtpHn28lgsNfe+o
 9n5BPfqqnkRMfaqXGxVnx6QPtTPln9QohDVReVfXF2oTwn4E0OrGLZkhdnyTYTtpyozziw
 Y6hfZgwc39D9vl/SLfoYNm+45tRZI+g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-kqrAI0_sMHm0aKbxLpsB0A-1; Thu, 11 Nov 2021 11:57:37 -0500
X-MC-Unique: kqrAI0_sMHm0aKbxLpsB0A-1
Received: by mail-ed1-f71.google.com with SMTP id
 z21-20020a05640240d500b003e3340a215aso5904369edb.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 08:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4nnuPe2lK5wahIQd1KXZIXGUVFrD/7Ht6SqdOl/REkM=;
 b=UPj1PcnXb32YdaMEkauLSFG5jGoXmWWHME7QZTBDoyXylTHfFhDKR9riC6B1tSlBrr
 AOdeoPi6e17F+cPRtxsLaUj44wo+HvhIN2Y9eG1eHr5DPuX38WisUpecyNFTGLpwR3jX
 7cGbkEaayR4SMqj0Xw49km4Dm0doDtUp+YXsUSsaYPpl2rJq5lc4hlGCwnE6KUsPdbQE
 jJcF2hFirPYiy/sTjVxKCxNUo5JNlX02AIUA8fODD54+XWBlD973cJSyeqsty/KyOOAF
 Pd5bkMnVB3QAN6sqeb+nLzmgMGGM2k9COKX0jfQ1deV9zb3otJyrCeO0zXjsk635gavm
 jQXg==
X-Gm-Message-State: AOAM532Dc/iSimPyj9w4qMlk5cfnqOVe5DrOPh9vYW4HwOnx85IUBfCM
 CBRp1NlE5425JshDteMZmQ5Uqst4JPSPJyaAo2bZRyvb+jC+qa4Nd5UjdPW9Wem1fH6pRBG56ys
 1Q+EMak0DYarBu19AijLzuL/Z9PeZNnFvOnK7sjK9qA==
X-Received: by 2002:a05:6402:28e:: with SMTP id
 l14mr11582152edv.162.1636649855624; 
 Thu, 11 Nov 2021 08:57:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7ECgB9KZKxo539pDYD4hDXKyd4DrqxPiQKOXusMT5WUd1v2H70mZt+EG9F2Disk7HjImsLg==
X-Received: by 2002:a05:6402:28e:: with SMTP id
 l14mr11582109edv.162.1636649855310; 
 Thu, 11 Nov 2021 08:57:35 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
 by smtp.gmail.com with ESMTPSA id gt18sm1669994ejc.46.2021.11.11.08.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Nov 2021 08:57:34 -0800 (PST)
Date: Thu, 11 Nov 2021 11:57:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 2/2] i2c: virtio: fix completion handling
Message-ID: <20211111114630-mutt-send-email-mst@kernel.org>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20211111160412.11980-3-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org, kernel@axis.com,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On Thu, Nov 11, 2021 at 05:04:12PM +0100, Vincent Whitchurch wrote:
> The driver currently assumes that the notify callback is only received
> when the device is done with all the queued buffers.
> 
> However, this is not true, since the notify callback could be called
> without any of the queued buffers being completed (for example, with
> virtio-pci and shared interrupts) or with only some of the buffers being
> completed (since the driver makes them available to the device in
> multiple separate virtqueue_add_sgs() calls).
> 
> This can lead to incorrect data on the I2C bus or memory corruption in
> the guest if the device operates on buffers which are have been freed by
> the driver.  (The WARN_ON in the driver is also triggered.)
> 
>  BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
>  First byte 0x0 instead of 0x6b
>  Allocated in i2cdev_ioctl_rdwr+0x9d/0x1de age=243 cpu=0 pid=28
>  	memdup_user+0x2e/0xbd
>  	i2cdev_ioctl_rdwr+0x9d/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
>  Freed in i2cdev_ioctl_rdwr+0x1bb/0x1de age=68 cpu=0 pid=28
>  	kfree+0x1bd/0x1cc
>  	i2cdev_ioctl_rdwr+0x1bb/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
> 
> Fix this by calling virtio_get_buf() from the notify handler like other
> virtio drivers and by actually waiting for all the buffers to be
> completed.
> 
> Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 34 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 7b2474e6876f..2d3ae8e238ec 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -22,24 +22,24 @@
>  /**
>   * struct virtio_i2c - virtio I2C data
>   * @vdev: virtio device for this controller
> - * @completion: completion of virtio I2C message
>   * @adap: I2C adapter for this controller
>   * @vq: the virtio virtqueue for communication
>   */
>  struct virtio_i2c {
>  	struct virtio_device *vdev;
> -	struct completion completion;
>  	struct i2c_adapter adap;
>  	struct virtqueue *vq;
>  };
>  
>  /**
>   * struct virtio_i2c_req - the virtio I2C request structure
> + * @completion: completion of virtio I2C message
>   * @out_hdr: the OUT header of the virtio I2C message
>   * @buf: the buffer into which data is read, or from which it's written
>   * @in_hdr: the IN header of the virtio I2C message
>   */
>  struct virtio_i2c_req {
> +	struct completion completion;
>  	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
>  	uint8_t *buf				____cacheline_aligned;
>  	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
> @@ -47,9 +47,11 @@ struct virtio_i2c_req {
>  
>  static void virtio_i2c_msg_done(struct virtqueue *vq)
>  {
> -	struct virtio_i2c *vi = vq->vdev->priv;
> +	struct virtio_i2c_req *req;
> +	unsigned int len;
>  
> -	complete(&vi->completion);
> +	while ((req = virtqueue_get_buf(vq, &len)))
> +		complete(&req->completion);
>  }
>  
>  static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> @@ -69,6 +71,8 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  		if (!msgs[i].len)
>  			break;
>  
> +		init_completion(&reqs[i].completion);
> +
>  		/*
>  		 * Only 7-bit mode supported for this moment. For the address
>  		 * format, Please check the Virtio I2C Specification.
> @@ -108,21 +112,13 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  				    struct virtio_i2c_req *reqs,
>  				    struct i2c_msg *msgs, int num)
>  {
> -	struct virtio_i2c_req *req;
>  	bool failed = false;
> -	unsigned int len;
>  	int i, j = 0;
>  
>  	for (i = 0; i < num; i++) {
> -		/* Detach the ith request from the vq */
> -		req = virtqueue_get_buf(vq, &len);
> +		struct virtio_i2c_req *req = &reqs[i];
>  
> -		/*
> -		 * Condition req == &reqs[i] should always meet since we have
> -		 * total num requests in the vq. reqs[i] can never be NULL here.
> -		 */
> -		if (!failed && (WARN_ON(req != &reqs[i]) ||
> -				req->in_hdr.status != VIRTIO_I2C_MSG_OK))
> +		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
>  			failed = true;
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> @@ -158,11 +154,13 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 * remote here to clear the virtqueue, so we can try another set of
>  	 * messages later on.
>  	 */
> -
> -	reinit_completion(&vi->completion);
>  	virtqueue_kick(vq);
>  
> -	wait_for_completion(&vi->completion);
> +	/*
> +	 * We only need to wait for the last one since the device is required
> +	 * to complete requests in order.
> +	 */

Hmm the spec only says:

    A device MUST guarantee the requests in the virtqueue being processed in order
    if multiple requests are received at a time.

it does not seem to require using the buffers in order.
In any case, just waiting for all of them in a loop
seems cleaner and likely won't take longer ...


> +	wait_for_completion(&reqs[count - 1].completion);
>  
>  	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
>  
> @@ -211,8 +209,6 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  	vi->vdev = vdev;
>  
> -	init_completion(&vi->completion);
> -
>  	ret = virtio_i2c_setup_vqs(vi);
>  	if (ret)
>  		return ret;
> -- 
> 2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
