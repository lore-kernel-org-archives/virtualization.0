Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523914;
	b=gsAbPClZYSSim/Ts0bbcEo9I5LABKaajDb8bQVAZJlHuhFfw6qS8ZN4KP7h5SQ5zxVmx
	 ll5hyzGA2bfBg65N+g84CGUVodF5LW/Maa26pJC9YISCk4+HJj2qr1adf3qog+LjbeDX8
	 AUAXqxiLKaEPG03kbU6OFtqaFrfpI6lSI672KbXpEx9F+43gVHaA/r+J5b5yUuyhPczUn
	 LDJdXyyzjKMD0MK8U8nX3nspKA8CbMBSViEtT5F/GAhQ+dHtFDDHbrPG7NAmt9zB2n1K9
	 tAmRC86wcZBjHUlHWm7fpTPCHwVNbvXm4XncONxsrZz80Q+ANb6EuSnI/9ZSc+0FjTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523914;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
	b=E5I9HGEroo/TSQLi2U8/nP+DqO+TZ2ky2f6SJQWLqiFRWpCo2sNHTtb+4KkFgmAwN+xi
	 WimgPpwpk+CVQZN4WRRjzOge8rg1Y7NapqYr2EGscsN8cKY3OQcbsbG+aD/MRlj3jFbFi
	 T8Z9uxUDlmDEm8yoklPVbyWSWnTkncrTnqEom7cCp7x5DnSPu4kaTJ4AtzapYvcz8F04G
	 FouZQ5uW7cK9xCKN0O6pkpHxyDaeNnLVPL2m8qZfFdCEO+AyAK3hJoQoU6V6CdijOlGfY
	 e3/3gRONyz4PJkMJSeeI50MXXVYiWG79faImxzFE2pbSR0dt7WE2086tOKqcRAlG1pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dVDBjz9Z;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC62D606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 22:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC62D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dVDBjz9Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
	b=dVDBjz9ZRXtPGQtxG+nZMI3L16c8A8egV2kb0VNkO9lD5TQvpxEvEygO6VHXcR/D04lqJy
	B9YO6E8X/rt06J2r9ra8uzKqPX32hsD8qaJ8oWjMT5s3fmGAEbF2+GHcyGo0659hci4mxO
	8IM11w+ivO4wD0EhRB+5+75wLfarQxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-RUK97Nq7PcuFSNQTaT6nhw-1; Thu, 12 Nov 2026 17:51:51 -0500
X-MC-Unique: RUK97Nq7PcuFSNQTaT6nhw-1
X-Mimecast-MFC-AGG-ID: RUK97Nq7PcuFSNQTaT6nhw_1794523910
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so1413485e9.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523910; x=1795128710;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co334PnVZfKPspzdaUWaBSnFnvG+s4uoTlNQvW8yi/4=;
        b=r1pJrgKf812qBAjxjnVA9DNB+F273ezEpVKq5okFpIzit5c99pW70Sdy9dQuQbZX9v
         kW/EZ7JnRO8E9oL+SgP5VChSNi3HBO2e4PXIy1ix051Y+E9EUJtzk+JPUoTARHeAQcG4
         WtgSJTQ3qCMOyDKFXWAxwpP3JvF9xZKnXt9R5heUHy3bQyjTgRJDYgPUlXQjMnhTJoag
         NcmStmSJcH31X4lxW9D3/7Jy4u1nxruDNdpH9nMwkuMObdy761CFed4RcmlohUtf6AL9
         kyxKxkJ7ZN8jK1j3LIyOvWNSa0GmTywWsAUdi7AIIqPKH+FtdyghSMYy9hyNW+x/s8Xq
         gcuw==
X-Forwarded-Encrypted: i=1; AL+hErH9Di7g7eJlMJKbyiKpQE4ea7/jEZBk7rjE/2Hlszins/6xzlv0Qu40XQPRFjUUz8MZqFAJNRSRaTb3X3I77A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/R6SuZIhpV381+zPT9xeOG8u6SxG/vgGolHsSheIM4QhVxF/ix
	K3Iuc5L3wVpbc1pMFdvAKiCMzqASbx8sQ/24L/bP2h5/Fm0XhY9+MFDA+0oTw/pqdgufnclf7oN
	8s4CXfV2wsEAE9VLAVcMyqjlrlVfuI+zDjo3ZIzxPSj9VLB8+91vHOS1etCk//SOdlQDYTYesBC
	7Y
X-Gm-Gg: AYBFou31PNtNejWY3n4oP0UTIAhUI6vBKWxnEtxZexbcvjwgThAvlqdNoysOHzlq4Ds
	/w3kfQAvMUforwrti6U91lm67q5aFA5aZ6avdZULkUOVA4qQH/1VoG0JFqcb+C8Cc+NxQVaYwx6
	8HoqkWcvTRbKmm1oIjfry1FUdlVuaHdFBIl0wxVSzVyKhKHEIm5V/psMPhDMMuQETf8AsA8NJC4
	zIvpIRSE1aJlsGM4QSJh05QRvYJmz5YProOwYsStI3iOeP7Y9oY6YrHGAoLbCfJk9iODV7EvEsK
	4Q+lQr4pb4STwDSvcAjJMlPjRdJVyegpxQ67pzaYGqXV0VGYuqc64Uln0hefb0sHsnaGnjnfbyB
	LKLEuD7XduA0NAQuW3llfzPYn1PqNcNiFO1cLQpQ8zg==
X-Received: by 2002:a05:600c:16d4:b0:4b7:6942:39be with SMTP id 5b1f17b1804b1-4bb55a6626dmr10367665e9.24.1794523910247;
        Thu, 12 Nov 2026 14:51:50 -0800 (PST)
X-Received: by 2002:a05:600c:16d4:b0:4b7:6942:39be with SMTP id 5b1f17b1804b1-4bb55a6626dmr10367365e9.24.1794523909636;
        Thu, 12 Nov 2026 14:51:49 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2a9bsm13836835e9.14.2026.11.12.14.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:51:48 -0800 (PST)
Date: Thu, 12 Nov 2026 17:51:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 2/3] virtio_net: introduce an RX queue watchdog for stuck
 detection
Message-ID: <20261112175123-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-3-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261109094310.103979-3-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZPro3S0ZRs2pc6q4bWm5AKEUN5QbZ_3Xsm-wrOcTOqA_1794523910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 05:43:09PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> The backend raises an interrupt after adding buffers to the used ring,
> and the hypervisor injects it. If one is lost (e.g., a transient KVM
> failure), NAPI will not be scheduled and the driver stops consuming
> buffers. The ring eventually fills up, the backend stops notifying, and
> the queue is left permanently stuck.
> 
> Add a per-device watchdog that scans the RX queues once per second and
> detects a queue that has a non-zero backlog while making no consumption
> progress and receiving no new interrupt for rx_watchdog_timeo seconds
> (default 5, 0 disables it). On detection, reschedule NAPI.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
> ---
>  drivers/net/virtio_net.c | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..ec7c248080c5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -36,6 +36,10 @@ module_param(csum, bool, 0444);
>  module_param(gso, bool, 0444);
>  module_param(napi_tx, bool, 0644);
>  
> +/* RX queue stall timeout in seconds; 0 disables the watchdog. */
> +static unsigned int rx_watchdog_timeo = 5;
> +module_param(rx_watchdog_timeo, uint, 0644);
> +
>  #define VIRTIO_OFFLOAD_MAP_MIN	46
>  #define VIRTIO_OFFLOAD_MAP_MAX	47
>  #define VIRTIO_FEATURES_MAP_MIN	65

No module params pls. This is not a sane UAPI.

> @@ -318,6 +322,13 @@ struct send_queue {
>  	dma_addr_t xsk_hdr_dma_addr;
>  };
>  
> +struct virtnet_rq_watchdog {
> +	u16 last_used;
> +	u16 calls;
> +	unsigned long jiffies;
> +	bool stalled;
> +};
> +
>  /* Internal representation of a receive virtqueue */
>  struct receive_queue {
>  	/* Virtqueue associated with this receive_queue */
> @@ -332,6 +343,9 @@ struct receive_queue {
>  	/* The number of rx notifications */
>  	u16 calls;
>  
> +	/* RX watchdog state. */
> +	struct virtnet_rq_watchdog watchdog;
> +
>  	/* Is dynamic interrupt moderation enabled? */
>  	bool dim_enabled;
>  
> @@ -443,6 +457,9 @@ struct virtnet_info {
>  	/* Work struct for setting rx mode */
>  	struct work_struct rx_mode_work;
>  
> +	/* RX watchdog timer for stuck detection */
> +	struct timer_list rx_watchdog;
> +
>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> @@ -3067,6 +3084,80 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  	return received;
>  }
>  
> +/*
> + * An RX queue is stalled if it has a backlog but makes no progress and
> + * gets no new interrupt for rx_watchdog_timeo seconds, usually because
> + * an interrupt was lost.  Mark it stalled and reschedule NAPI to drain
> + * the ring, refill the buffers.
> + */
> +static void virtnet_rx_watchdog(struct timer_list *t)
> +{
> +	struct virtnet_info *vi = timer_container_of(vi, t, rx_watchdog);
> +	unsigned long timeout = rx_watchdog_timeo * HZ;
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;
> +
> +	for (i = 0; i < vi->curr_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +		u16 last_used = virtqueue_get_last_used_idx(rq->vq);
> +		u16 calls = rq->calls;
> +		bool backlog = virtqueue_poll(rq->vq, last_used);
> +		bool progress = last_used != rq->watchdog.last_used;
> +
> +		if (!backlog || progress || calls != rq->watchdog.calls) {
> +			rq->watchdog.last_used = last_used;
> +			rq->watchdog.calls = calls;
> +			rq->watchdog.jiffies = jiffies;
> +			continue;
> +		}
> +
> +		if (time_after(jiffies, rq->watchdog.jiffies + timeout)) {
> +			unsigned int stall_ms =
> +				jiffies_to_msecs(jiffies - rq->watchdog.jiffies);
> +
> +			netdev_warn(vi->dev,
> +				    "RX queue %u stalled for %u ms, rescheduling NAPI\n",
> +				    i, stall_ms);
> +
> +			rq->watchdog.stalled = true;
> +			virtqueue_napi_schedule(&rq->napi, rq->vq);
> +
> +			/* Rate-limit to one event per timeout. */
> +			rq->watchdog.jiffies = jiffies;
> +		}
> +	}
> +
> +	mod_timer(&vi->rx_watchdog, jiffies + HZ);
> +}
> +
> +static void virtnet_rx_watchdog_init_queue(struct receive_queue *rq)
> +{
> +	rq->watchdog.last_used = virtqueue_get_last_used_idx(rq->vq);
> +	rq->watchdog.calls = rq->calls;
> +	rq->watchdog.jiffies = jiffies;
> +	rq->watchdog.stalled = false;
> +}
> +
> +static void virtnet_rx_watchdog_start(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	if (!rx_watchdog_timeo)
> +		return;
> +
> +	for (i = 0; i < vi->curr_queue_pairs; i++)
> +		virtnet_rx_watchdog_init_queue(&vi->rq[i]);
> +
> +	mod_timer(&vi->rx_watchdog, jiffies + HZ);
> +}
> +
> +static void virtnet_rx_watchdog_stop(struct virtnet_info *vi)
> +{
> +	timer_delete_sync(&vi->rx_watchdog);
> +}
> +
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>  {
>  	virtnet_napi_tx_disable(&vi->sq[qp_index]);
> @@ -3230,6 +3321,8 @@ static int virtnet_open(struct net_device *dev)
>  		netif_carrier_on(dev);
>  	}
>  
> +	virtnet_rx_watchdog_start(vi);
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3759,6 +3852,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	struct virtio_net_rss_config_trailer old_rss_trailer;
>  	struct net_device *dev = vi->dev;
>  	struct scatterlist sg;
> +	u16 old_queue_pairs = vi->curr_queue_pairs;
>  
>  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>  		return 0;
> @@ -3816,7 +3910,14 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  	if (vi->has_rss)
>  		vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
>  succ:
> +	if (dev->flags & IFF_UP) {
> +		/* Init new queues */
> +		for (int i = old_queue_pairs; i < queue_pairs; i++)
> +			virtnet_rx_watchdog_init_queue(&vi->rq[i]);
> +	}
> +
>  	vi->curr_queue_pairs = queue_pairs;
> +
>  	if (dev->flags & IFF_UP) {
>  		local_bh_disable();
>  		for (int i = 0; i < vi->curr_queue_pairs; ++i)
> @@ -3832,6 +3933,8 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> +	virtnet_rx_watchdog_stop(vi);
> +
>  	/* Prevent the config change callback from changing carrier
>  	 * after close
>  	 */
> @@ -6900,6 +7003,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	disable_work(&vi->rx_mode_work);
> +	timer_setup(&vi->rx_watchdog, virtnet_rx_watchdog, 0);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> -- 
> 2.51.0

