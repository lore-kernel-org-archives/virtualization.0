Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEEEC28B2B
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 16:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D9B8414CC;
	Tue, 16 Aug 2022 16:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D9B8414CC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hna68SLW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCN1jF-toX2J; Tue, 16 Aug 2022 16:39:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0378B409E9;
	Tue, 16 Aug 2022 16:39:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0378B409E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A74A9C0032;
	Tue, 16 Aug 2022 16:39:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A17B4C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 16:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C12982C3C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 16:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C12982C3C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hna68SLW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGgHWThF7wcb
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 16:39:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BA7582965
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6BA7582965
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660667943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5W25F/QMFqA5+ykoVyKlx452BdPB+0++1PY7M2UaOeg=;
 b=hna68SLWXLMeQZHWOqHrZMbpzg941yw/n4TBYbjpyXBlTzNYtDoN7tb7XzpCtRzxauWLgj
 R8lTl1x99dbJDWrAHXzZ+WYrOJV6vg3cal7MvHMQM7fysW+S92eXTY8vIkw0axcwFWElaS
 CWiM3sqg83TvJ629jP9I/3zOSNDFaA0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-0uwUwSZGMbS1A6Yi6_7RwA-1; Tue, 16 Aug 2022 12:38:59 -0400
X-MC-Unique: 0uwUwSZGMbS1A6Yi6_7RwA-1
Received: by mail-wm1-f70.google.com with SMTP id
 v64-20020a1cac43000000b003a4bea31b4dso10450363wme.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 09:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=5W25F/QMFqA5+ykoVyKlx452BdPB+0++1PY7M2UaOeg=;
 b=DaFrAWdDMmkKU1dQ6vman0Aj08J7WoOWEaWlwc8b9vgLIMS2Mfk2t4xl8kE/wS4tXS
 s6BeWIha0v5ax6z7M/MnQjhBQeAR8wFoAIrGmZUJw0sYM9WhqnH/zYFweAq1DVcScqAZ
 Tb+jLmo+fkpyRJdiDHoeccfffFqQ1K5bsJnI2wdBdJ0Fip4Z2y5yfkCOINWOa71IxFq6
 RcmyLia/CFQMaMePe+90aO1j0OSeThYnQDE0gJM38LHaojMrUNc7bcujuDFDmDHVvFrS
 +YYiesZ/4O0F86ZfXwaGsK2/Ry5/B4eTfrKMGpHBqm2WY1igz3EMSiuspbKsLoet8pBy
 d0Xg==
X-Gm-Message-State: ACgBeo1Fptpc5TKUB9yvCs3olpUFXJ9ryvVwqXzDv3FoxFo2hhNBZQoI
 f2u6RqEd5ymr3Jud916O0wxZTs7aHl9RaOhOeKh70FyIxBGWV72AuNsEYxt0b9JQ9otHpYKe/VJ
 C19oNNs++G0c+w/Cp1xhn7shw9M1loF8vHWvU1AM8JA==
X-Received: by 2002:a05:600c:b4f:b0:3a5:c31f:b565 with SMTP id
 k15-20020a05600c0b4f00b003a5c31fb565mr14178723wmr.186.1660667938410; 
 Tue, 16 Aug 2022 09:38:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR78DULV09yUMbmw06XL6LVeNPiVFeXQdpUEoOCZceudU2NnrqCdfZ997Mc1y/Aa2XlixtShPg==
X-Received: by 2002:a05:600c:b4f:b0:3a5:c31f:b565 with SMTP id
 k15-20020a05600c0b4f00b003a5c31fb565mr14178697wmr.186.1660667938108; 
 Tue, 16 Aug 2022 09:38:58 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 n127-20020a1c2785000000b003a5c7a942edsm13477447wmn.28.2022.08.16.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 09:38:57 -0700 (PDT)
Date: Tue, 16 Aug 2022 12:38:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Subject: Re: [PATCH 3/6] vsock: add netdev to vhost/virtio vsock
Message-ID: <20220816123701-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <5a93c5aad99d79f028d349cb7e3c128c65d5d7e2.1660362668.git.bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 10:56:06AM -0700, Bobby Eshleman wrote:
> In order to support usage of qdisc on vsock traffic, this commit
> introduces a struct net_device to vhost and virtio vsock.
> 
> Two new devices are created, vhost-vsock for vhost and virtio-vsock
> for virtio. The devices are attached to the respective transports.
> 
> To bypass the usage of the device, the user may "down" the associated
> network interface using common tools. For example, "ip link set dev
> virtio-vsock down" lets vsock bypass the net_device and qdisc entirely,
> simply using the FIFO logic of the prior implementation.

Ugh. That's quite a hack. Mark my words, at some point we will decide to
have down mean "down".  Besides, multiple net devices with link up tend
to confuse userspace. So might want to keep it down at all times
even short term.

> For both hosts and guests, there is one device for all G2H vsock sockets
> and one device for all H2G vsock sockets. This makes sense for guests
> because the driver only supports a single vsock channel (one pair of
> TX/RX virtqueues), so one device and qdisc fits. For hosts, this may not
> seem ideal for some workloads. However, it is possible to use a
> multi-queue qdisc, where a given queue is responsible for a range of
> sockets. This seems to be a better solution than having one device per
> socket, which may yield a very large number of devices and qdiscs, all
> of which are dynamically being created and destroyed. Because of this
> dynamism, it would also require a complex policy management daemon, as
> devices would constantly be spun up and down as sockets were created and
> destroyed. To avoid this, one device and qdisc also applies to all H2G
> sockets.
> 
> Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> ---
>  drivers/vhost/vsock.c                   |  19 +++-
>  include/linux/virtio_vsock.h            |  10 +++
>  net/vmw_vsock/virtio_transport.c        |  19 +++-
>  net/vmw_vsock/virtio_transport_common.c | 112 +++++++++++++++++++++++-
>  4 files changed, 152 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index f8601d93d94d..b20ddec2664b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -927,13 +927,30 @@ static int __init vhost_vsock_init(void)
>  				  VSOCK_TRANSPORT_F_H2G);
>  	if (ret < 0)
>  		return ret;
> -	return misc_register(&vhost_vsock_misc);
> +
> +	ret = virtio_transport_init(&vhost_transport, "vhost-vsock");
> +	if (ret < 0)
> +		goto out_unregister;
> +
> +	ret = misc_register(&vhost_vsock_misc);
> +	if (ret < 0)
> +		goto out_transport_exit;
> +	return ret;
> +
> +out_transport_exit:
> +	virtio_transport_exit(&vhost_transport);
> +
> +out_unregister:
> +	vsock_core_unregister(&vhost_transport.transport);
> +	return ret;
> +
>  };
>  
>  static void __exit vhost_vsock_exit(void)
>  {
>  	misc_deregister(&vhost_vsock_misc);
>  	vsock_core_unregister(&vhost_transport.transport);
> +	virtio_transport_exit(&vhost_transport);
>  };
>  
>  module_init(vhost_vsock_init);
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 9a37eddbb87a..5d7e7fbd75f8 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -91,10 +91,20 @@ struct virtio_transport {
>  	/* This must be the first field */
>  	struct vsock_transport transport;
>  
> +	/* Used almost exclusively for qdisc */
> +	struct net_device *dev;
> +
>  	/* Takes ownership of the packet */
>  	int (*send_pkt)(struct sk_buff *skb);
>  };
>  
> +int
> +virtio_transport_init(struct virtio_transport *t,
> +		      const char *name);
> +
> +void
> +virtio_transport_exit(struct virtio_transport *t);
> +
>  ssize_t
>  virtio_transport_stream_dequeue(struct vsock_sock *vsk,
>  				struct msghdr *msg,
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 3bb293fd8607..c6212eb38d3c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -131,7 +131,9 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>  		 * the vq
>  		 */
>  		if (ret < 0) {
> -			skb_queue_head(&vsock->send_pkt_queue, skb);
> +			spin_lock_bh(&vsock->send_pkt_queue.lock);
> +			__skb_queue_head(&vsock->send_pkt_queue, skb);
> +			spin_unlock_bh(&vsock->send_pkt_queue.lock);
>  			break;
>  		}
>  
> @@ -676,7 +678,9 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>  		kfree_skb(skb);
>  	mutex_unlock(&vsock->tx_lock);
>  
> -	skb_queue_purge(&vsock->send_pkt_queue);
> +	spin_lock_bh(&vsock->send_pkt_queue.lock);
> +	__skb_queue_purge(&vsock->send_pkt_queue);
> +	spin_unlock_bh(&vsock->send_pkt_queue.lock);
>  
>  	/* Delete virtqueues and flush outstanding callbacks if any */
>  	vdev->config->del_vqs(vdev);
> @@ -760,6 +764,8 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
>  	flush_work(&vsock->event_work);
>  	flush_work(&vsock->send_pkt_work);
>  
> +	virtio_transport_exit(&virtio_transport);
> +
>  	mutex_unlock(&the_virtio_vsock_mutex);
>  
>  	kfree(vsock);
> @@ -844,12 +850,18 @@ static int __init virtio_vsock_init(void)
>  	if (ret)
>  		goto out_wq;
>  
> -	ret = register_virtio_driver(&virtio_vsock_driver);
> +	ret = virtio_transport_init(&virtio_transport, "virtio-vsock");
>  	if (ret)
>  		goto out_vci;
>  
> +	ret = register_virtio_driver(&virtio_vsock_driver);
> +	if (ret)
> +		goto out_transport;
> +
>  	return 0;
>  
> +out_transport:
> +	virtio_transport_exit(&virtio_transport);
>  out_vci:
>  	vsock_core_unregister(&virtio_transport.transport);
>  out_wq:
> @@ -861,6 +873,7 @@ static void __exit virtio_vsock_exit(void)
>  {
>  	unregister_virtio_driver(&virtio_vsock_driver);
>  	vsock_core_unregister(&virtio_transport.transport);
> +	virtio_transport_exit(&virtio_transport);
>  	destroy_workqueue(virtio_vsock_workqueue);
>  }
>  
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index d5780599fe93..bdf16fff054f 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -16,6 +16,7 @@
>  
>  #include <net/sock.h>
>  #include <net/af_vsock.h>
> +#include <net/pkt_sched.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/vsock_virtio_transport_common.h>
> @@ -23,6 +24,93 @@
>  /* How long to wait for graceful shutdown of a connection */
>  #define VSOCK_CLOSE_TIMEOUT (8 * HZ)
>  
> +struct virtio_transport_priv {
> +	struct virtio_transport *trans;
> +};
> +
> +static netdev_tx_t virtio_transport_start_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct virtio_transport *t =
> +		((struct virtio_transport_priv *)netdev_priv(dev))->trans;
> +	int ret;
> +
> +	ret = t->send_pkt(skb);
> +	if (unlikely(ret == -ENODEV))
> +		return NETDEV_TX_BUSY;
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +const struct net_device_ops virtio_transport_netdev_ops = {
> +	.ndo_start_xmit = virtio_transport_start_xmit,
> +};
> +
> +static void virtio_transport_setup(struct net_device *dev)
> +{
> +	dev->netdev_ops = &virtio_transport_netdev_ops;
> +	dev->needs_free_netdev = true;
> +	dev->flags = IFF_NOARP;
> +	dev->mtu = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> +	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
> +}
> +
> +static int ifup(struct net_device *dev)
> +{
> +	int ret;
> +
> +	rtnl_lock();
> +	ret = dev_open(dev, NULL) ? -ENOMEM : 0;
> +	rtnl_unlock();
> +
> +	return ret;
> +}
> +
> +/* virtio_transport_init - initialize a virtio vsock transport layer
> + *
> + * @t: ptr to the virtio transport struct to initialize
> + * @name: the name of the net_device to be created.
> + *
> + * Return 0 on success, otherwise negative errno.
> + */
> +int virtio_transport_init(struct virtio_transport *t, const char *name)
> +{
> +	struct virtio_transport_priv *priv;
> +	int ret;
> +
> +	t->dev = alloc_netdev(sizeof(*priv), name, NET_NAME_UNKNOWN, virtio_transport_setup);
> +	if (!t->dev)
> +		return -ENOMEM;
> +
> +	priv = netdev_priv(t->dev);
> +	priv->trans = t;
> +
> +	ret = register_netdev(t->dev);
> +	if (ret < 0)
> +		goto out_free_netdev;
> +
> +	ret = ifup(t->dev);
> +	if (ret < 0)
> +		goto out_unregister_netdev;
> +
> +	return 0;
> +
> +out_unregister_netdev:
> +	unregister_netdev(t->dev);
> +
> +out_free_netdev:
> +	free_netdev(t->dev);
> +
> +	return ret;
> +}
> +
> +void virtio_transport_exit(struct virtio_transport *t)
> +{
> +	if (t->dev) {
> +		unregister_netdev(t->dev);
> +		free_netdev(t->dev);
> +	}
> +}
> +
>  static const struct virtio_transport *
>  virtio_transport_get_ops(struct vsock_sock *vsk)
>  {
> @@ -147,6 +235,24 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  		return VIRTIO_VSOCK_TYPE_SEQPACKET;
>  }
>  
> +/* Return pkt->len on success, otherwise negative errno */
> +static int virtio_transport_send_pkt(const struct virtio_transport *t, struct sk_buff *skb)
> +{
> +	int ret;
> +	int len = skb->len;
> +
> +	if (unlikely(!t->dev || !(t->dev->flags & IFF_UP)))
> +		return t->send_pkt(skb);
> +
> +	skb->dev = t->dev;
> +	ret = dev_queue_xmit(skb);
> +
> +	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN))
> +		return len;
> +
> +	return -ENOMEM;
> +}
> +
>  /* This function can only be used on connecting/connected sockets,
>   * since a socket assigned to a transport is required.
>   *
> @@ -202,9 +308,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  	virtio_transport_inc_tx_pkt(vvs, skb);
>  
> -	err = t_ops->send_pkt(skb);
> -
> -	return err < 0 ? -ENOMEM : err;
> +	return virtio_transport_send_pkt(t_ops, skb);
>  }
>  
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> @@ -834,7 +938,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  		return -ENOTCONN;
>  	}
>  
> -	return t->send_pkt(reply);
> +	return virtio_transport_send_pkt(t, reply);
>  }
>  
>  /* This function should be called with sk_lock held and SOCK_DONE set */
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
