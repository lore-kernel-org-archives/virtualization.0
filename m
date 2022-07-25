Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7261AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 07:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F24C78329E;
	Mon, 25 Jul 2022 07:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F24C78329E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0b/RbMx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Shnkpw10rqHD; Mon, 25 Jul 2022 07:46:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 448948328E;
	Mon, 25 Jul 2022 07:46:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 448948328E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BDABC0033;
	Mon, 25 Jul 2022 07:46:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AD36C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DDC260E13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:46:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DDC260E13
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M0b/RbMx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7B9vOeyKIbF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:46:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF24F60D6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF24F60D6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658735209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMlcbANKfJle3FD3sp54e/O4tglNGsQHuCzPBZAyo74=;
 b=M0b/RbMx7JydJShi0A0c/HF1o0eVs4B401m/mBRe7amfTgcdTrrrctJHzGcOI5TIuuuQzq
 PutUyOTTRZObZVAmLpSRdARoLFmduQ1qkqA0/mtSBVHE7BzbjdFVppEhwIkeKt41uk9bLY
 oSRqq925IXz4Kv4OXfpRzrmap6QOkZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-U7atWNlgMK6eBXQ1YN2hTQ-1; Mon, 25 Jul 2022 03:46:48 -0400
X-MC-Unique: U7atWNlgMK6eBXQ1YN2hTQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 f21-20020a1cc915000000b003a3551598a1so767160wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 00:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=eMlcbANKfJle3FD3sp54e/O4tglNGsQHuCzPBZAyo74=;
 b=mZrT2TCkSMYUHji8jjxXHfjq8OB0P2KYo+jakIUzVrOd5P/veVmlZEjHTDNJ1LhKaz
 sZHjkXm8/noebGwX+ybwzJcmmxWJqQTyyTUcflB+jazMbGAkQRtODHimlMaWhQR/5BWo
 RhxfIhIE3VMHmrPe4vj4EimQRrEkZOrzGNMwd0r1reJN0aUReXsJwfllzB1OYQ1wvmWP
 VT0FqvqETxFYDMtQr+RHXPFeAWnqOpb7zT/jYwiqi82+cHINOiOEqJcjPjYutLgKoXv2
 652vi67Dw6ertSE0V+pVxPwgDvUzAlG6Ydc+QQGx3Lznutlw3ZXHP/0rL/Z1e8qfc6Bv
 KjEg==
X-Gm-Message-State: AJIora8drkIeMHb1wDOE9OPVy9qa/D+UNX+utsFKRD98AJMR/sArJcaC
 eJPK0zJToF3mObzkg3rjgzTFkJXLbtVoEUJtwrrS0Sut4bc/eOorHpov3GlUDFzM5WbMWjug0SH
 AZERWL5zM5+4p50Yg5YbeNVqCBHr+3ST3RVleMMcqgQ==
X-Received: by 2002:a05:6000:2a8:b0:21d:8c81:7eb0 with SMTP id
 l8-20020a05600002a800b0021d8c817eb0mr6637322wry.460.1658735206807; 
 Mon, 25 Jul 2022 00:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uGAeaP6zG5DACZXn3IdfwA62T9sMZ4jbNP6FGASI/iTgfCErmmuIHtpCle49XWZvsGwGlhNA==
X-Received: by 2002:a05:6000:2a8:b0:21d:8c81:7eb0 with SMTP id
 l8-20020a05600002a800b0021d8c817eb0mr6637306wry.460.1658735206495; 
 Mon, 25 Jul 2022 00:46:46 -0700 (PDT)
Received: from redhat.com ([2.55.46.46]) by smtp.gmail.com with ESMTPSA id
 d5-20020adff845000000b0021dd08ad8d7sm11473081wrq.46.2022.07.25.00.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jul 2022 00:46:45 -0700 (PDT)
Date: Mon, 25 Jul 2022 03:46:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6] virtio-net: fix the race between refill work and close
Message-ID: <20220725034545-mutt-send-email-mst@kernel.org>
References: <20220725072159.3577-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220725072159.3577-1-jasowang@redhat.com>
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

On Mon, Jul 25, 2022 at 03:21:59PM +0800, Jason Wang wrote:
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

That's very clean, thanks!

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 356cf8dd4164..ec8e1b3108c3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -242,9 +242,15 @@ struct virtnet_info {
>  	/* Packet virtio header size */
>  	u8 hdr_len;
>  
> -	/* Work struct for refilling if we run low on memory. */
> +	/* Work struct for delayed refilling if we run low on memory. */
>  	struct delayed_work refill;
>  
> +	/* Is delayed refill enabled? */
> +	bool refill_enabled;
> +
> +	/* The lock to synchronize the access to refill_enabled */
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
> +	vi->refill_enabled = true;
> +	spin_unlock_bh(&vi->refill_lock);
> +}
> +
> +static void disable_delayed_refill(struct virtnet_info *vi)
> +{
> +	spin_lock_bh(&vi->refill_lock);
> +	vi->refill_enabled = false;
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
> +			if (vi->refill_enabled)
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
