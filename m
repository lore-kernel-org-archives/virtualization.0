Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8929AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 07:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00BE082C04;
	Wed, 29 Jun 2022 07:29:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00BE082C04
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEnDPJV9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TektVpXPchtb; Wed, 29 Jun 2022 07:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4871082883;
	Wed, 29 Jun 2022 07:29:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4871082883
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B77FC0039;
	Wed, 29 Jun 2022 07:29:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C453C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FEDF40423
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:29:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1FEDF40423
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEnDPJV9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VS74Hb-iM9AO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:29:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD14F400A6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD14F400A6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656487741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xiRibrSvAoM6W9wAB2ExJi4FE4mfhgvmaHhoHqyyRbM=;
 b=CEnDPJV9nKAnpMhSr6zMz8l2RD84Dp1/bf/Dt3aK8bOrlhuXSliWDyaOOIz4qH0J9Xm0tp
 RqrEhbgJcUapHWO7sVDvBF3V/N3SVPoj6xGvkKMedQnlqKnIGRFdCGDoPWv/EZ/Pix9sH+
 nalfn3piBJWLn2p360n6kVys+IWRgzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-F-xbaZ8IONyT5MpmpAefcw-1; Wed, 29 Jun 2022 03:29:00 -0400
X-MC-Unique: F-xbaZ8IONyT5MpmpAefcw-1
Received: by mail-wm1-f70.google.com with SMTP id
 c185-20020a1c35c2000000b0039db3e56c39so10117118wma.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xiRibrSvAoM6W9wAB2ExJi4FE4mfhgvmaHhoHqyyRbM=;
 b=MDoXQmtISL0ZL7wlakRqCE2udacbCE2FZN3g/b3HKRkLK9pqzuBMcL/0DtoepmlzZL
 RS+PXJJj4sIhydFHc7p/uJGH8YKGg7sljdk85NZvKvGHcA5+beT/Riy+2WLKCmhrigK6
 w7UUAD8YUXi0gg+j57AiK4FonsJrB9J+WjPBQjIOl4evppxz7hPDBsRTNeUKI5qoBdAt
 CANbMGZYGQtbF4MJEiDui7qsQ4Id/V+4jeTbKgVD+hbPX20whODpObpPJGAAzDRRjgxn
 U7Pc3QalwJ5DSq3aOUNEGUEedUI931hNalsx++brWdiaZfXsoilyaCbe6I00Ujf2sMSO
 yu7w==
X-Gm-Message-State: AJIora+1xyiGTceOhpXhjA2pabT1Ti9NRd1V8SH3NORpy8d7clzvoaQO
 uzjaVxqY4YO2SyBCSRzYNxsOs1KsnwL/M/wu51gnmhqaGWFLft5EnRBX1hGwhgw5O1yHFB0t5d/
 wOF62ARb9ztVKjP3SOym0pPB/w56elar+SVCCYtYmdQ==
X-Received: by 2002:a7b:cf18:0:b0:3a0:54b3:d848 with SMTP id
 l24-20020a7bcf18000000b003a054b3d848mr2058475wmg.3.1656487738711; 
 Wed, 29 Jun 2022 00:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfysaLsrnPck1jxZb3L9c6KAMx3q01zMPf4AMhC3h7kyffbacEWnGaGpxGMi+HZGbpOMCBGQ==
X-Received: by 2002:a7b:cf18:0:b0:3a0:54b3:d848 with SMTP id
 l24-20020a7bcf18000000b003a054b3d848mr2058448wmg.3.1656487738440; 
 Wed, 29 Jun 2022 00:28:58 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 u3-20020a05600c210300b003a044fe7fe7sm2075973wml.9.2022.06.29.00.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jun 2022 00:28:57 -0700 (PDT)
Date: Wed, 29 Jun 2022 03:28:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: fix the race between refill work and close
Message-ID: <20220629032106-mutt-send-email-mst@kernel.org>
References: <20220628090324.62219-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220628090324.62219-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Tue, Jun 28, 2022 at 05:03:24PM +0800, Jason Wang wrote:
> We try using cancel_delayed_work_sync() to prevent the work from
> enabling NAPI. This is insufficient since we don't disable the the
> source the scheduling

can't parse this sentence

> of the refill work. This means an NAPI

what do you mean "an NAPI"? a NAPI poll callback?

> after
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
> ---
>  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..21bf1e5c81ef 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -251,6 +251,12 @@ struct virtnet_info {
>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> +	/* Is refill work enabled? */
> +	bool refill_work_enabled;
> +
> +	/* The lock to synchronize the access to refill_work_enabled */
> +	spinlock_t refill_lock;
> +
>  	/* CPU hotplug instances for online & dead */
>  	struct hlist_node node;
>  	struct hlist_node node_dead;
> @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void enable_refill_work(struct virtnet_info *vi)
> +{
> +	spin_lock(&vi->refill_lock);
> +	vi->refill_work_enabled = true;
> +	spin_unlock(&vi->refill_lock);
> +}
> +
> +static void disable_refill_work(struct virtnet_info *vi)
> +{
> +	spin_lock(&vi->refill_lock);
> +	vi->refill_work_enabled = false;
> +	spin_unlock(&vi->refill_lock);
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
> +			if (vi->refill_work_enabled)
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
> +	enable_refill_work(vi);
> +
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
>  			/* Make sure we have some buffers: if oom use wq. */
> @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> +	/* Make sure NAPI doesn't schedule refill work */
> +	disable_refill_work(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +	/* Make sure NAPI doesn't schedule refill work */
> +	disable_refill_work(vi);
> +	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	if (netif_running(vi->dev)) {
> @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	enable_refill_work(vi);
> +
>  	if (netif_running(vi->dev)) {
>  		for (i = 0; i < vi->curr_queue_pairs; i++)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	spin_lock_init(&vi->refill_lock);
>  
>  	/* If we can receive ANY GSO packets, we must allocate large ones. */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||


Can't say I love all the extra state but oh well.

> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
