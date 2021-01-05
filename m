Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52548C433E0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:22:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D66E92255F
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66E92255F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9201B8712E;
	Tue,  5 Jan 2021 13:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00eM8E6zQOxC; Tue,  5 Jan 2021 13:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5CE38619F;
	Tue,  5 Jan 2021 13:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95F76C0891;
	Tue,  5 Jan 2021 13:22:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 839CFC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 75F3285D9B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:22:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t_GNgktURUbk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F45785D97
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609852917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGs715adlyQxYzFyzd9WDG/VSmZ2P+2uRgYcIeOEsUA=;
 b=OnWCGfZVlo6I6Mg3c8tiEJixNWb69ulKqqyVGBZTX95SDXtXh8g1qWR0mXysrzRr07MIA3
 fx8FICTlCZzjBg2taucvDnkzibFWJssX66Mmb4k8l7Qt4R3gWn2Z4M5pToh/HXNPAy0gC/
 pZvoaffLD2e6Ca5AUyzo3nc7bXxWfdY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-stv5pZXnP0qkjP0pevhMGA-1; Tue, 05 Jan 2021 08:21:55 -0500
X-MC-Unique: stv5pZXnP0qkjP0pevhMGA-1
Received: by mail-wr1-f71.google.com with SMTP id m20so14252361wrh.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 05:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uGs715adlyQxYzFyzd9WDG/VSmZ2P+2uRgYcIeOEsUA=;
 b=L+d2+2D8Ryi+1NVypx2/XNuw6BLf780B6tPAlgXJaUYzTB+UQYvYPiviqzU4Mq1g61
 kGGOHPB2wSkjuU4niCKwMcbfe7lRIn9vJM/B0p9Y5NZh7vtIGwbfA1DZBp1FJlzpnL3/
 pyeBv0o+G1xxxjQiPG3ApghZMAfHc0bxnl1gu2Erw+ZdLlRpI39yW0B3QELEbND6R+on
 wcGTp+/eXD9MbUo/SDgd0+W/xPTZEWXMUk1OWNPgW+jB1uoRg97FeLohmDXkCHMPZMpo
 1f6iiDDgs076pS6iFo63rHGMHhZvGru99cs7rmQS0JfTuPqjmhwXHZekCoFGLKMaq6H1
 IE1w==
X-Gm-Message-State: AOAM532pogT9JOkOfpnrrQCmnR7FYr5b1H19GSAZ/niC5i0pjVayDUQU
 fQqbOpdLpLvlU2fEP+XAJlvJaMsgg/xPlAVMZBRF+23RVUBi7COce5o/G+6PFmFEpzFc6fPSvGz
 k4cngWju3d9G5aTRQ2SGq1KK5d3HHGxEq5i9zL24hjg==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr85254128wrb.194.1609852914434; 
 Tue, 05 Jan 2021 05:21:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9bbjviE2KotiXpiiygjuSsa2xomSbqp1INxRfaXGCyW2Ra1zoCZ0dTeDUhaoUq23myI/NBg==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr85254089wrb.194.1609852914123; 
 Tue, 05 Jan 2021 05:21:54 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id n17sm4098844wmc.33.2021.01.05.05.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 05:21:52 -0800 (PST)
Date: Tue, 5 Jan 2021 08:21:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH netdev 5/5] virtio-net, xsk: virtio-net support xsk zero
 copy tx
Message-ID: <20210105072746-mutt-send-email-mst@kernel.org>
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
 <65b5d0af6c4ed878cbcfa53c925d9dcbb09ecc55.1609837120.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <65b5d0af6c4ed878cbcfa53c925d9dcbb09ecc55.1609837120.git.xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 open list <linux-kernel@vger.kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
 dust.li@linux.alibaba.com, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP SOCKETS \(AF_XDP\)" <bpf@vger.kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
 tonylu@linux.alibaba.com, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Tue, Jan 05, 2021 at 05:11:43PM +0800, Xuan Zhuo wrote:
> Virtio net support xdp socket.
> 
> We should open the module param "napi_tx" for using this feature.

what does this imply exactly?

> In fact, various virtio implementations have some problems:
> 1. The tx interrupt may be lost
> 2. The tx interrupt may have a relatively large delay
> 
> This brings us to several questions:
> 
> 1. Wakeup wakes up a tx interrupt or directly starts a napi on the
>    current cpu, which will cause a delay in sending packets.
> 2. When the tx ring is full, the tx interrupt may be lost or delayed,
>    resulting in untimely recovery.
> 
> I choose to send part of the data directly during wakeup. If the sending
> has not been completed, I will start a napi to complete the subsequent
> sending work.
> 
> Since the possible delay or loss of tx interrupt occurs when the tx ring
> is full, I added a timer to solve this problem.

A lost interrupt sounds like a bug somewhere.
Why isn't this device already broken then, even without zero copy?
Won't a full ring stall forever? And won't a significantly delayed
tx interrupt block userspace?

How about putting work arounds were in a separate patch for now,
so it's easier to figure out whether anything in the patch itself
is causing issues?

> The performance of udp sending based on virtio net + xsk is 6 times that
> of ordinary kernel udp send.
> 
> * xsk_check_timeout: when the dev full or all xsk.hdr used, start timer
>   to check the xsk.hdr is avail. the unit is us.
> * xsk_num_max: the xsk.hdr max num
> * xsk_num_percent: the max hdr num be the percent of the virtio ring
>   size. The real xsk hdr num will the min of xsk_num_max and the percent
>   of the num of virtio ring
> * xsk_budget: the budget for xsk run
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 437 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 434 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e744dce..76319e7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -22,10 +22,21 @@
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> +#include <net/xdp_sock_drv.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
>  
> +static int xsk_check_timeout = 100;
> +static int xsk_num_max       = 1024;
> +static int xsk_num_percent   = 80;
> +static int xsk_budget        = 128;
> +
> +module_param(xsk_check_timeout, int, 0644);
> +module_param(xsk_num_max,       int, 0644);
> +module_param(xsk_num_percent,   int, 0644);
> +module_param(xsk_budget,        int, 0644);
> +
>  static bool csum = true, gso = true, napi_tx = true;
>  module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
> @@ -110,6 +121,9 @@ struct virtnet_xsk_hdr {
>  	u32 len;
>  };
>  
> +#define VIRTNET_STATE_XSK_WAKEUP BIT(0)
> +#define VIRTNET_STATE_XSK_TIMER BIT(1)
> +
>  #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
>  #define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
>  
> @@ -149,6 +163,32 @@ struct send_queue {
>  	struct virtnet_sq_stats stats;
>  
>  	struct napi_struct napi;
> +
> +	struct {
> +		struct xsk_buff_pool   __rcu *pool;
> +		struct virtnet_xsk_hdr __rcu *hdr;
> +
> +		unsigned long          state;
> +		u64                    hdr_con;
> +		u64                    hdr_pro;
> +		u64                    hdr_n;
> +		struct xdp_desc        last_desc;
> +		bool                   wait_slot;
> +		/* tx interrupt issues
> +		 *   1. that may be lost
> +		 *   2. that too slow, 200/s or delay 10ms

I mean, we call virtqueue_enable_cb_delayed on each start_xmit.
The point is explicitly to reduce the # of tx interrupts,
is this the issue?

> +		 *
> +		 * timer for:
> +		 * 1. recycle the desc.(no check for performance, see below)
> +		 * 2. check the nic ring is avali. when nic ring is full
> +		 *
> +		 * Here, the regular check is performed for dev full. The
> +		 * application layer must ensure that the number of cq is
> +		 * sufficient, otherwise there may be insufficient cq in use.

Can't really parse this.  cq as in control vq?

> +		 *
> +		 */
> +		struct hrtimer          timer;
> +	} xsk;
>  };
>  
>  /* Internal representation of a receive virtqueue */
> @@ -267,6 +307,8 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>  				bool xsk_wakeup,
>  				unsigned int *_packets, unsigned int *_bytes);
>  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi);
> +static int virtnet_xsk_run(struct send_queue *sq,
> +			   struct xsk_buff_pool *pool, int budget);
>  
>  static bool is_xdp_frame(void *ptr)
>  {
> @@ -1439,6 +1481,40 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	return stats.packets;
>  }
>  
> +static void virt_xsk_complete(struct send_queue *sq, u32 num, bool xsk_wakeup)
> +{
> +	struct xsk_buff_pool *pool;
> +	int n;
> +
> +	rcu_read_lock();
> +
> +	WRITE_ONCE(sq->xsk.hdr_pro, sq->xsk.hdr_pro + num);

WRITE_ONCE without READ_ONCE anywhere looks a bit weird.
Add a comment explaining why this is right?

> +
> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (!pool) {
> +		if (sq->xsk.hdr_pro - sq->xsk.hdr_con == sq->xsk.hdr_n) {
> +			kfree(sq->xsk.hdr);
> +			rcu_assign_pointer(sq->xsk.hdr, NULL);
> +		}
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	xsk_tx_completed(pool, num);
> +
> +	rcu_read_unlock();
> +
> +	if (!xsk_wakeup || !sq->xsk.wait_slot)
> +		return;
> +
> +	n = sq->xsk.hdr_pro - sq->xsk.hdr_con;
> +
> +	if (n > sq->xsk.hdr_n / 2) {
> +		sq->xsk.wait_slot = false;
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +	}
> +}
> +
>  static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>  				bool xsk_wakeup,
>  				unsigned int *_packets, unsigned int *_bytes)
> @@ -1446,6 +1522,7 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>  	unsigned int packets = 0;
>  	unsigned int bytes = 0;
>  	unsigned int len;
> +	u64 xsknum = 0;
>  	struct virtnet_xdp_type *xtype;
>  	struct xdp_frame        *frame;
>  	struct virtnet_xsk_hdr  *xskhdr;
> @@ -1466,6 +1543,7 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>  			if (xtype->type == XDP_TYPE_XSK) {
>  				xskhdr = (struct virtnet_xsk_hdr *)xtype;
>  				bytes += xskhdr->len;
> +				xsknum += 1;
>  			} else {
>  				frame = xtype_got_ptr(xtype);
>  				xdp_return_frame(frame);
> @@ -1475,6 +1553,9 @@ static void __free_old_xmit_ptr(struct send_queue *sq, bool in_napi,
>  		packets++;
>  	}
>  
> +	if (xsknum)
> +		virt_xsk_complete(sq, xsknum, xsk_wakeup);
> +
>  	*_packets = packets;
>  	*_bytes = bytes;
>  }
> @@ -1595,6 +1676,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	struct virtnet_info *vi = sq->vq->vdev->priv;
>  	unsigned int index = vq2txq(sq->vq);
>  	struct netdev_queue *txq;
> +	struct xsk_buff_pool *pool;
> +	int work = 0;
>  
>  	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
>  		/* We don't need to enable cb for XDP */
> @@ -1604,15 +1687,26 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
> -	free_old_xmit_skbs(sq, true);
> +
> +	rcu_read_lock();
> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (pool) {
> +		work = virtnet_xsk_run(sq, pool, budget);
> +		rcu_read_unlock();
> +	} else {
> +		rcu_read_unlock();
> +		free_old_xmit_skbs(sq, true);
> +	}
> +
>  	__netif_tx_unlock(txq);
>  
> -	virtqueue_napi_complete(napi, sq->vq, 0);
> +	if (work < budget)
> +		virtqueue_napi_complete(napi, sq->vq, 0);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>  		netif_tx_wake_queue(txq);
>  
> -	return 0;
> +	return work;
>  }
>  
>  static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> @@ -2560,16 +2654,346 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	return err;
>  }
>  
> +static enum hrtimer_restart virtnet_xsk_timeout(struct hrtimer *timer)
> +{
> +	struct send_queue *sq;
> +
> +	sq = container_of(timer, struct send_queue, xsk.timer);
> +
> +	clear_bit(VIRTNET_STATE_XSK_TIMER, &sq->xsk.state);
> +
> +	virtqueue_napi_schedule(&sq->napi, sq->vq);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +static int virtnet_xsk_pool_enable(struct net_device *dev,
> +				   struct xsk_buff_pool *pool,
> +				   u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct send_queue *sq = &vi->sq[qid];
> +	struct virtnet_xsk_hdr *hdr;
> +	int n, ret = 0;
> +
> +	if (qid >= dev->real_num_rx_queues || qid >= dev->real_num_tx_queues)
> +		return -EINVAL;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +
> +	ret = -EBUSY;
> +	if (rcu_dereference(sq->xsk.pool))
> +		goto end;
> +
> +	/* check last xsk wait for hdr been free */
> +	if (rcu_dereference(sq->xsk.hdr))
> +		goto end;
> +
> +	n = virtqueue_get_vring_size(sq->vq);
> +	n = min(xsk_num_max, n * (xsk_num_percent % 100) / 100);
> +
> +	ret = -ENOMEM;
> +	hdr = kcalloc(n, sizeof(struct virtnet_xsk_hdr), GFP_ATOMIC);
> +	if (!hdr)
> +		goto end;
> +
> +	memset(&sq->xsk, 0, sizeof(sq->xsk));
> +
> +	sq->xsk.hdr_pro = n;
> +	sq->xsk.hdr_n   = n;
> +
> +	hrtimer_init(&sq->xsk.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
> +	sq->xsk.timer.function = virtnet_xsk_timeout;
> +
> +	rcu_assign_pointer(sq->xsk.pool, pool);
> +	rcu_assign_pointer(sq->xsk.hdr, hdr);
> +
> +	ret = 0;
> +end:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct send_queue *sq = &vi->sq[qid];
> +
> +	if (qid >= dev->real_num_rx_queues || qid >= dev->real_num_tx_queues)
> +		return -EINVAL;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	rcu_assign_pointer(sq->xsk.pool, NULL);
> +
> +	hrtimer_cancel(&sq->xsk.timer);
> +
> +	synchronize_rcu(); /* Sync with the XSK wakeup and with NAPI. */
> +
> +	if (sq->xsk.hdr_pro - sq->xsk.hdr_con == sq->xsk.hdr_n) {
> +		kfree(sq->xsk.hdr);
> +		rcu_assign_pointer(sq->xsk.hdr, NULL);
> +		synchronize_rcu();
> +	}
> +
> +	return 0;
> +}
> +
>  static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
>  {
>  	switch (xdp->command) {
>  	case XDP_SETUP_PROG:
>  		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
> +	case XDP_SETUP_XSK_POOL:
> +		xdp->xsk.need_dma = false;
> +		if (xdp->xsk.pool)
> +			return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
> +						       xdp->xsk.queue_id);
> +		else
> +			return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> +			    struct xdp_desc *desc)
> +{
> +	struct virtnet_info *vi = sq->vq->vdev->priv;
> +	void *data, *ptr;
> +	struct page *page;
> +	struct virtnet_xsk_hdr *xskhdr;
> +	u32 idx, offset, n, i, copy, copied;
> +	u64 addr;
> +	int err, m;
> +
> +	addr = desc->addr;
> +
> +	data = xsk_buff_raw_get_data(pool, addr);
> +	offset = offset_in_page(data);
> +
> +	/* one for hdr, one for the first page */
> +	n = 2;
> +	m = desc->len - (PAGE_SIZE - offset);
> +	if (m > 0) {
> +		n += m >> PAGE_SHIFT;
> +		if (m & PAGE_MASK)
> +			++n;
> +
> +		n = min_t(u32, n, ARRAY_SIZE(sq->sg));
> +	}
> +
> +	idx = sq->xsk.hdr_con % sq->xsk.hdr_n;
> +	xskhdr = &sq->xsk.hdr[idx];
> +
> +	/* xskhdr->hdr has been memset to zero, so not need to clear again */
> +
> +	sg_init_table(sq->sg, n);
> +	sg_set_buf(sq->sg, &xskhdr->hdr, vi->hdr_len);
> +
> +	copied = 0;
> +	for (i = 1; i < n; ++i) {
> +		copy = min_t(int, desc->len - copied, PAGE_SIZE - offset);
> +
> +		page = xsk_buff_raw_get_page(pool, addr + copied);
> +
> +		sg_set_page(sq->sg + i, page, copy, offset);
> +		copied += copy;
> +		if (offset)
> +			offset = 0;
> +	}
> +
> +	xskhdr->len = desc->len;
> +	ptr = xdp_to_ptr(&xskhdr->type);
> +
> +	err = virtqueue_add_outbuf(sq->vq, sq->sg, n, ptr, GFP_ATOMIC);
> +	if (unlikely(err))
> +		sq->xsk.last_desc = *desc;
> +	else
> +		sq->xsk.hdr_con++;
> +
> +	return err;
> +}
> +
> +static bool virtnet_xsk_dev_is_full(struct send_queue *sq)
> +{
> +	if (sq->vq->num_free < 2 + MAX_SKB_FRAGS)
> +		return true;
> +
> +	if (sq->xsk.hdr_con == sq->xsk.hdr_pro)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int virtnet_xsk_xmit_zc(struct send_queue *sq,
> +			       struct xsk_buff_pool *pool, unsigned int budget)
> +{
> +	struct xdp_desc desc;
> +	int err, packet = 0;
> +	int ret = -EAGAIN;
> +
> +	if (sq->xsk.last_desc.addr) {
> +		err = virtnet_xsk_xmit(sq, pool, &sq->xsk.last_desc);
> +		if (unlikely(err))
> +			return -EBUSY;
> +
> +		++packet;
> +		sq->xsk.last_desc.addr = 0;
> +	}
> +
> +	while (budget-- > 0) {
> +		if (virtnet_xsk_dev_is_full(sq)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		if (!xsk_tx_peek_desc(pool, &desc)) {
> +			/* done */
> +			ret = 0;
> +			break;
> +		}
> +
> +		err = virtnet_xsk_xmit(sq, pool, &desc);
> +		if (unlikely(err)) {
> +			ret = -EBUSY;
> +			break;
> +		}
> +
> +		++packet;
> +	}
> +
> +	if (packet) {
> +		xsk_tx_release(pool);
> +
> +		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> +			u64_stats_update_begin(&sq->stats.syncp);
> +			sq->stats.kicks++;
> +			u64_stats_update_end(&sq->stats.syncp);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int virtnet_xsk_run(struct send_queue *sq,
> +			   struct xsk_buff_pool *pool, int budget)
> +{
> +	int err, ret = 0;
> +	unsigned int _packets = 0;
> +	unsigned int _bytes = 0;
> +
> +	sq->xsk.wait_slot = false;
> +
> +	if (test_and_clear_bit(VIRTNET_STATE_XSK_TIMER, &sq->xsk.state))
> +		hrtimer_try_to_cancel(&sq->xsk.timer);
> +
> +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
> +
> +	err = virtnet_xsk_xmit_zc(sq, pool, xsk_budget);
> +	if (!err) {
> +		struct xdp_desc desc;
> +
> +		clear_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
> +		xsk_set_tx_need_wakeup(pool);
> +
> +		/* Race breaker. If new is coming after last xmit
> +		 * but before flag change
> +		 */


A bit more text explaining the rules for the two bits please.

> +
> +		if (!xsk_tx_peek_desc(pool, &desc))
> +			goto end;
> +
> +		set_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state);
> +		xsk_clear_tx_need_wakeup(pool);
> +
> +		sq->xsk.last_desc = desc;
> +		ret = budget;
> +		goto end;
> +	}
> +
> +	xsk_clear_tx_need_wakeup(pool);
> +
> +	if (err == -EAGAIN) {
> +		ret = budget;
> +		goto end;
> +	}
> +
> +	/* -EBUSY: wait tx ring avali.
> +	 *	by tx interrupt or rx interrupt or start_xmit or timer


can't parse this either ...

> +	 */
> +
> +	__free_old_xmit_ptr(sq, true, false, &_packets, &_bytes);
> +
> +	if (!virtnet_xsk_dev_is_full(sq)) {
> +		ret = budget;
> +		goto end;
> +	}
> +
> +	sq->xsk.wait_slot = true;
> +
> +	if (xsk_check_timeout) {
> +		hrtimer_start(&sq->xsk.timer,
> +			      ns_to_ktime(xsk_check_timeout * 1000),
> +			      HRTIMER_MODE_REL_PINNED);
> +
> +		set_bit(VIRTNET_STATE_XSK_TIMER, &sq->xsk.state);
> +	}
> +
> +	virtnet_sq_stop_check(sq, true);
> +
> +end:
> +	return ret;
> +}
> +
> +static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct send_queue *sq;
> +	struct xsk_buff_pool *pool;
> +	struct netdev_queue *txq;
> +	int work = 0;
> +
> +	if (!netif_running(dev))
> +		return -ENETDOWN;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +
> +	rcu_read_lock();
> +
> +	pool = rcu_dereference(sq->xsk.pool);
> +	if (!pool)
> +		goto end;
> +
> +	if (test_and_set_bit(VIRTNET_STATE_XSK_WAKEUP, &sq->xsk.state))
> +		goto end;
> +
> +	txq = netdev_get_tx_queue(dev, qid);
> +
> +	local_bh_disable();
> +	__netif_tx_lock(txq, raw_smp_processor_id());
> +
> +	work = virtnet_xsk_run(sq, pool, xsk_budget);
> +
> +	__netif_tx_unlock(txq);
> +	local_bh_enable();
> +
> +	if (work == xsk_budget)
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +
> +end:
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
>  static int virtnet_get_phys_port_name(struct net_device *dev, char *buf,
>  				      size_t len)
>  {
> @@ -2624,6 +3048,7 @@ static int virtnet_set_features(struct net_device *dev,
>  	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
>  	.ndo_bpf		= virtnet_xdp,
>  	.ndo_xdp_xmit		= virtnet_xdp_xmit,
> +	.ndo_xsk_wakeup		= virtnet_xsk_wakeup,
>  	.ndo_features_check	= passthru_features_check,
>  	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
>  	.ndo_set_features	= virtnet_set_features,
> @@ -2722,6 +3147,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  static void free_unused_bufs(struct virtnet_info *vi)
>  {
>  	void *buf;
> +	u32 n;
>  	int i;
>  	struct send_queue *sq;
>  
> @@ -2740,6 +3166,11 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  					xdp_return_frame(xtype_got_ptr(xtype));
>  			}
>  		}
> +
> +		n = sq->xsk.hdr_con + sq->xsk.hdr_n;
> +		n -= sq->xsk.hdr_pro;
> +		if (n)
> +			virt_xsk_complete(sq, n, false);
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
