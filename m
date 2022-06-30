Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A34CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 02:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D59C58405B;
	Thu, 30 Jun 2022 02:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D59C58405B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jaOqfVwOGgj9; Thu, 30 Jun 2022 02:22:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A9EA8403F;
	Thu, 30 Jun 2022 02:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A9EA8403F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DB7C002D;
	Thu, 30 Jun 2022 02:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 301C1C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F05B96117A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:21:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F05B96117A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUJey-2MANlr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D7BC60EAC
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D7BC60EAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 02:21:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VHpiy7b_1656555711; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHpiy7b_1656555711) by smtp.aliyun-inc.com;
 Thu, 30 Jun 2022 10:21:52 +0800
Message-ID: <1656555045.7370687-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V2] virtio-net: fix the race between refill work and close
Date: Thu, 30 Jun 2022 10:10:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220630020805.74658-1-jasowang@redhat.com>
In-Reply-To: <20220630020805.74658-1-jasowang@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 davem@davemloft.net
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 30 Jun 2022 10:08:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> We try using cancel_delayed_work_sync() to prevent the work from
> enabling NAPI. This is insufficient since we don't disable the source
> of the refill work scheduling. This means an NAPI poll callback after
> cancel_delayed_work_sync() can schedule the refill work then can
> re-enable the NAPI that leads to use-after-free [1].


Can you explain in more detail how this happened?

napi_disable() is normally called after cancel_delayed_work_sync(). This ensures
that all napi callbacks will end, and the new napi_disable() will wait.
There will be no re-enable napi.

So I guess the use-after-free is caused by refill_work being called after
dev/vi/napi is released. In this way, we can just call
cancel_delayed_work_sync() after napi_disalbe().

Thanks.

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
> --
> 2.25.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
