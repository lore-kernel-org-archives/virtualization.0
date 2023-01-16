Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87ADC46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 13:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D84C40198;
	Mon, 16 Jan 2023 13:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D84C40198
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LrtyNmXO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXTPHTd5dop5; Mon, 16 Jan 2023 13:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 50016401E9;
	Mon, 16 Jan 2023 13:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50016401E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C590C0033;
	Mon, 16 Jan 2023 13:41:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D83F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 13:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1867401E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 13:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1867401E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mvBQLBZe8-Ud
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 13:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6450340198
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6450340198
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673876506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dy1VK4lCS2RdiiWOjQOjdjHQSzkWQSXFlBq6wGn15DM=;
 b=LrtyNmXOYov8ewAKviOXrSbStdjvV8E6xhdz0x/Vk2BfxisEhtn/FYqRjjEsRAq8KAyv/v
 o81f8JC4YQTtCPUGWd1SiqUIVELNmRXav2x7uL0PWv/gR+qcHIX3dfiei5UKD/rMxCTBdi
 ANHjhz4o5RZp2LjZeQ6kx8jot8X9xmw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-4qzBUn8JOM6dgg510AdrRw-1; Mon, 16 Jan 2023 08:41:45 -0500
X-MC-Unique: 4qzBUn8JOM6dgg510AdrRw-1
Received: by mail-vk1-f197.google.com with SMTP id
 v195-20020a1faccc000000b003dae5f6477bso5194380vke.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 05:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dy1VK4lCS2RdiiWOjQOjdjHQSzkWQSXFlBq6wGn15DM=;
 b=aJ6slqMkBqq702yqzvPZ60Cgcv2j1D+1eFVR7aZhr/zew9c+HNuNs4cXYCfXSKisct
 87ocMIDDAAtCQKM4xGXvHmPO+k9nvZ9yJSTtfBVzVTjGggEduBr0l4yPCsrCgxO0EBuF
 I6qWvZgnvKydl9lDc5bZWUcJV+Hhkr+167oPdwQYGjx1V0x7DAgKN+5SIoVjNiAdx37A
 WN1hvf86RxBGCHWueUclR3j4s+tjZmntEs+3rgKPYEwhIMMAfFzPQzYKdAkZ4pEyZytm
 VAfNtn9SL0I5iVyBy3WCwGTpkEfehyXmFQ/uEptbHtze4R02VNKt4eQmA3h4Bpm7xek/
 LxLA==
X-Gm-Message-State: AFqh2kqj82NySeb06T61Gl0ddEwoP5MuCjY3gk0rw9UoJsHZkTQrT2JH
 pvv8t5TLqoprzvBdCr/1XBM2VRvzABBEiBOgLxaACDDJWQyFf8C7sY8HnMpo3OGh6JPDzNxl874
 1Q8qe3Aavh0DY+LqogncXbnOqBZ7S34p+n8ybmROM6g==
X-Received: by 2002:a05:6102:3f90:b0:3d0:ee83:95a8 with SMTP id
 o16-20020a0561023f9000b003d0ee8395a8mr9681698vsv.22.1673876504561; 
 Mon, 16 Jan 2023 05:41:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvYhRgRNllMe5psFSkuJuj41TDkdErcxfLGtCYOgT62YtFZx3O5juVXyyxqx+mq0RIA79mPcw==
X-Received: by 2002:a05:6102:3f90:b0:3d0:ee83:95a8 with SMTP id
 o16-20020a0561023f9000b003d0ee8395a8mr9681683vsv.22.1673876504271; 
 Mon, 16 Jan 2023 05:41:44 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 az31-20020a05620a171f00b006fbbdc6c68fsm18203746qkb.68.2023.01.16.05.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jan 2023 05:41:43 -0800 (PST)
Message-ID: <a5990064-df57-f991-832d-56d1156dc3f8@redhat.com>
Date: Mon, 16 Jan 2023 14:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/4] virtio_net: disable cb aggressively
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-5-mst@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20210526082423.47837-5-mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefano Brivio <sbrivio@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

On 5/26/21 10:24, Michael S. Tsirkin wrote:
> There are currently two cases where we poll TX vq not in response to a
> callback: start xmit and rx napi.  We currently do this with callbacks
> enabled which can cause extra interrupts from the card.  Used not to be
> a big issue as we run with interrupts disabled but that is no longer the
> case, and in some cases the rate of spurious interrupts is so high
> linux detects this and actually kills the interrupt.
> 
> Fix up by disabling the callbacks before polling the tx vq.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/net/virtio_net.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c29f42d1e04f..a83dc038d8af 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1433,7 +1433,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>   		return;
>   
>   	if (__netif_tx_trylock(txq)) {
> -		free_old_xmit_skbs(sq, true);
> +		do {
> +			virtqueue_disable_cb(sq->vq);
> +			free_old_xmit_skbs(sq, true);
> +		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>   
>   		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>   			netif_tx_wake_queue(txq);
> @@ -1605,12 +1608,17 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>   	bool kick = !netdev_xmit_more();
>   	bool use_napi = sq->napi.weight;
> +	unsigned int bytes = skb->len;
>   
>   	/* Free up any pending old buffers before queueing new ones. */
> -	free_old_xmit_skbs(sq, false);
> +	do {
> +		if (use_napi)
> +			virtqueue_disable_cb(sq->vq);
>   
> -	if (use_napi && kick)
> -		virtqueue_enable_cb_delayed(sq->vq);
> +		free_old_xmit_skbs(sq, false);
> +
> +	} while (use_napi && kick &&
> +	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>   
>   	/* timestamp packet in software */
>   	skb_tx_timestamp(skb);

This patch seems to introduce a problem with QEMU connected to passt using netdev stream 
backend.

When I run an iperf3 test I get after 1 or 2 seconds of test:

[  254.035559] NETDEV WATCHDOG: ens3 (virtio_net): transmit queue 0 timed out
...
[  254.060962] virtio_net virtio1 ens3: TX timeout on queue: 0, sq: output.0, vq: 0x1, 
name: output.0, 8856000 usecs ago
[  259.155150] virtio_net virtio1 ens3: TX timeout on queue: 0, sq: output.0, vq: 0x1, 
name: output.0, 13951000 usecs ago

In QEMU, I can see in virtio_net_tx_bh() the function virtio_net_flush_tx() has flushed 
all the queue entries and re-enabled the queue notification with 
virtio_queue_set_notification() and tries to flush again the queue and as it is empty it 
does nothing more and then rely on a kernel notification to re-enable the bottom half 
function. As this notification never comes the queue is stuck and kernel add entries but 
QEMU doesn't remove them:

2812 static void virtio_net_tx_bh(void *opaque)
2813 {
...
2833     ret = virtio_net_flush_tx(q);

-> flush the queue and ret is not an error and not n->tx_burst (that would re-schedule the 
function)

...
2850     virtio_queue_set_notification(q->tx_vq, 1);

-> re-enable the queue notification

2851     ret = virtio_net_flush_tx(q);
2852     if (ret == -EINVAL) {
2853         return;
2854     } else if (ret > 0) {
2855         virtio_queue_set_notification(q->tx_vq, 0);
2856         qemu_bh_schedule(q->tx_bh);
2857         q->tx_waiting = 1;
2858     }

-> ret is 0, exit the function without re-scheduling the function.
...
2859 }

If I revert this patch in the kernel (a7766ef18b33 ("virtio_net: disable cb 
aggressively")), it works fine.

How to reproduce it:

I start passt (https://passt.top/passt):

passt -f

and then QEMU

qemu-system-x86_64 ... --netdev 
stream,id=netdev0,server=off,addr.type=unix,addr.path=/tmp/passt_1.socket -device 
virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0

Host side:

sysctl -w net.core.rmem_max=134217728
sysctl -w net.core.wmem_max=134217728
iperf3 -s

Guest side:

sysctl -w net.core.rmem_max=536870912
sysctl -w net.core.wmem_max=536870912

ip link set dev $DEV mtu 256
iperf3 -c $HOST -t10 -i0 -Z -P 8 -l 1M --pacing-timer 1000000 -w 4M

Any idea of what is the problem?

Thanks,
Laurent


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
