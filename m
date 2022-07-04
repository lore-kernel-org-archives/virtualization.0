Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF75C43334
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 08:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5027060C1A;
	Mon,  4 Jul 2022 08:53:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5027060C1A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PqW3lJ6B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Rutp13iwFYs; Mon,  4 Jul 2022 08:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE14F606ED;
	Mon,  4 Jul 2022 08:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE14F606ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858BDC0032;
	Mon,  4 Jul 2022 08:53:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAD28C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 08:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B28B360D6E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 08:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B28B360D6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MCisMdhec9kf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 08:53:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C9E9606ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C9E9606ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 08:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656924784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbVXSgisY5AaoNPEQrLMmraosP7prZp3JNPIrzB+8Vg=;
 b=PqW3lJ6BEN+5G0Cdy+0aG1romgilbrWT/sf7gafYoDXZHgcTP2NCuU3rZfDcZQJ3RunY+R
 IEqf97rsMh9zmM/yHOtQPB96PvqoUEEusfhvSlnbFRfXPW1z0ekAFdpRFPE+i3/zknOMA5
 3FrIHzBZi9PT0fhf2LqTBdd1FLxi13M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-We0pfqdCOOaZBds6DDPyGg-1; Mon, 04 Jul 2022 04:53:03 -0400
X-MC-Unique: We0pfqdCOOaZBds6DDPyGg-1
Received: by mail-ed1-f72.google.com with SMTP id
 f13-20020a0564021e8d00b00437a2acb543so6755955edf.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qbVXSgisY5AaoNPEQrLMmraosP7prZp3JNPIrzB+8Vg=;
 b=JoGUm7EMxCssm1y1KssHK7gIkxm/n5BilQ5d7CtwBwzuTjgLyBU3WERJWAmdVM0JMa
 5ue5KfiolTpT1ug3/j7hhVT/kWlcurh1/RMnZ1yP9K0x52b6mRRMQXasDJWCJBqb0QbP
 xfizx1qjvvAwh8NkqYDryuUWJnAYZpwKx8HzrORuHGCE6WXuFXT6/zepvscMVgCtIo9s
 VYWVbdtWILkcoN2mhesPD6bG1Jwl6T5oUXkKkv8xGImx2eqE8lVZdylpVsQQth3tRK+r
 8mD22rkeeU7mrsKK4NtAu31CR0HZAYa+YnYPX3pZ0WRHtaW080C9Aua4rA37RpBguN9t
 P4JQ==
X-Gm-Message-State: AJIora+b+cjbmFFjoYYPzOXoQ9O20UR3BN8mqmZKtBj48/fk84ATDx6A
 c3jE9dnLu3AIFGjUJFRQKt1MDnVcFg5++25eVCdqIBl1HWV9bF0CcVH+HPmNCQFE+VHJRdY4gNG
 MdkfdR9CTjHu6wIWjcbawWFfqpawx4Lyd1ca9Jwjr8A==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id
 s26-20020a056402015a00b0043171b986f3mr36401036edu.249.1656924780924; 
 Mon, 04 Jul 2022 01:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vTidClko4q95fUuzrkACeMQxysRX5CdJQRf4uacqDZMo8xNc83r+hqmdeB0EHH8h0+Vw5QKw==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id
 s26-20020a056402015a00b0043171b986f3mr36401009edu.249.1656924780667; 
 Mon, 04 Jul 2022 01:53:00 -0700 (PDT)
Received: from redhat.com ([2.55.35.209]) by smtp.gmail.com with ESMTPSA id
 fg8-20020a056402548800b0043a3f52418asm2252759edb.18.2022.07.04.01.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 01:53:00 -0700 (PDT)
Date: Mon, 4 Jul 2022 04:52:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net V5] virtio-net: fix the race between refill work and
 close
Message-ID: <20220704045034-mutt-send-email-mst@kernel.org>
References: <20220704074859.16912-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220704074859.16912-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Mon, Jul 04, 2022 at 03:48:59PM +0800, Jason Wang wrote:
> We try using cancel_delayed_work_sync() to prevent the work from
> enabling NAPI. This is insufficient since we don't disable the source
> of the refill work scheduling. This means an NAPI poll callback after
> cancel_delayed_work_sync() can schedule the refill work then can
> re-enable the NAPI that leads to use-after-free [1].
> 
> Since the work can enable NAPI, we can't simply disable NAPI before
> calling cancel_delayed_work_sync(). So fix this by introducing a
> dedicated boolean to control whether or not the work could be
> scheduled from NAPI.
> 
> [1]
> ==================================================================
> BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> 
> CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: events refill_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x34/0x44
>  print_report.cold+0xbb/0x6ac
>  ? _printk+0xad/0xde
>  ? refill_work+0x43/0xd4
>  kasan_report+0xa8/0x130
>  ? refill_work+0x43/0xd4
>  refill_work+0x43/0xd4
>  process_one_work+0x43d/0x780
>  worker_thread+0x2a0/0x6f0
>  ? process_one_work+0x780/0x780
>  kthread+0x167/0x1a0
>  ? kthread_exit+0x50/0x50
>  ret_from_fork+0x22/0x30
>  </TASK>
> ...
> 
> Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes since V4:
> - Tweak the variable name (using delayed_refill)
> Changes since V3:
> - rebase to -net
> Changes since V2:
> - use spin_unlock()/lock_bh() in open/stop to synchronize with bh
> Changes since V1:
> - Tweak the changelog
> ---
>  drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 356cf8dd4164..b9ac4431becb 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -245,6 +245,12 @@ struct virtnet_info {
>  	/* Work struct for refilling if we run low on memory. */

let's update this comment to "for delayed refilling" for consistency

>  	struct delayed_work refill;
>  
> +	/* Is delayed refill enabled? */
> +	bool delayed_refill_enabled;


I would keep the name refill_enabled, refill refers to the field "refill"
above.

> +
> +	/* The lock to synchronize the access to delayed_refill_enabled */

add:

... and to refill

> +	spinlock_t refill_lock;
> +
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>  
> @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void enable_delayed_refill(struct virtnet_info *vi)
> +{
> +	spin_lock_bh(&vi->refill_lock);
> +	vi->delayed_refill_enabled = true;
> +	spin_unlock_bh(&vi->refill_lock);
> +}
> +
> +static void disable_delayed_refill(struct virtnet_info *vi)
> +{
> +	spin_lock_bh(&vi->refill_lock);
> +	vi->delayed_refill_enabled = false;
> +	spin_unlock_bh(&vi->refill_lock);
> +}
> +
>  static void virtqueue_napi_schedule(struct napi_struct *napi,
>  				    struct virtqueue *vq)
>  {
> @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	}
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> -			schedule_delayed_work(&vi->refill, 0);
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> +			spin_lock(&vi->refill_lock);
> +			if (vi->delayed_refill_enabled)
> +				schedule_delayed_work(&vi->refill, 0);
> +			spin_unlock(&vi->refill_lock);
> +		}
>  	}
>  
>  	u64_stats_update_begin(&rq->stats.syncp);
> @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
>  
> +	enable_delayed_refill(vi);
> +
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
>  			/* Make sure we have some buffers: if oom use wq. */
> @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> +	/* Make sure NAPI doesn't schedule refill work */
> +	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> @@ -2792,6 +2820,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	enable_delayed_refill(vi);
> +
>  	if (netif_running(vi->dev)) {
>  		err = virtnet_open(vi->dev);
>  		if (err)
> @@ -3535,6 +3565,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	spin_lock_init(&vi->refill_lock);
>  
>  	/* If we can receive ANY GSO packets, we must allocate large ones. */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
