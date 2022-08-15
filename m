Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1E6C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 06:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69A2C409FF;
	Mon, 15 Aug 2022 06:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69A2C409FF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Slyn+8/Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h3OrWHT4L-GZ; Mon, 15 Aug 2022 06:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D418410A0;
	Mon, 15 Aug 2022 06:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D418410A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 119A5C0033;
	Mon, 15 Aug 2022 06:00:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38F9AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C436402EB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:00:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C436402EB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Slyn+8/Z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wT5SUFCNMi7w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:00:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1609D40146
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1609D40146
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660543236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAdBQK0QiV5b4wlrykjTQFv9XF+6GUWZgv1gebJc3GA=;
 b=Slyn+8/ZbpRzM3faDxHI/OLIrvHFQWL0yWxyMO3gNgp7qK4/lndOvFIC6wxhEPKTW/djDt
 OGelt+J99G2nw2mynUg9B55OtBzl+OkBOiW2/M4IW8wqEWVjeYXqh/lsgAuPVVH/cx8A72
 4Zr9cgXY9GJxtCoHj1CI9QMVnVETOUk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-VePlj5hrPqiz9AEwbfgLUg-1; Mon, 15 Aug 2022 02:00:27 -0400
X-MC-Unique: VePlj5hrPqiz9AEwbfgLUg-1
Received: by mail-ed1-f71.google.com with SMTP id
 q18-20020a056402519200b0043dd2ff50feso4134368edd.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Aug 2022 23:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=lAdBQK0QiV5b4wlrykjTQFv9XF+6GUWZgv1gebJc3GA=;
 b=VPSuP4W5k2pvXV9NoddC+O0Z2gw7JMLuDE/b2JkBvcsWMooRUkqDmlXajhd9Ew0I8V
 YgqxkTrZfl/znh0KbxWYHIn9tb7jPrndmsDn2DH2mxdkfAYHuDm7lH8+p0hl7NhWRr3n
 nFgQWheSRG3rkwh3NlyylZDBuH322bG/3IOaaWe+rck+3AAkWr2el1OqlaAnpJ+NwC8H
 R02x2OjeBggfi7Tn3QsRkBeOuI9TDPL3VD2VtWPgMVt0dQTGGUpmxGVVWKYWsiOAoav/
 ck3jGfSCXAaVu37aqEX4h5f6HP+OooBEUZuw1ZCNuB68xNGk2gK5hAVaE1ykbhIBDoD4
 LEKQ==
X-Gm-Message-State: ACgBeo3nuFs6YtbIYd0dFtcafqOrnBKBu7UX0lmQJYmRRoFeL3JCbd22
 RK5AvB9GcqfxYt1gXB7FS8tlA/+eEARC3YZn8iLqLfx362cu5PtHkwG9gHI748bI8cltG1h2url
 iykqBGabRVLF2N7lpwpyV2ZEkpgno8K4ejgSEE3t8Hg==
X-Received: by 2002:a17:907:1c89:b0:734:d05c:582e with SMTP id
 nb9-20020a1709071c8900b00734d05c582emr9323849ejc.282.1660543226513; 
 Sun, 14 Aug 2022 23:00:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7ajggNt5I/GyHHzN8RtwufAK7sHaSR68oGYohV/XNRYX67jjVhq0Tw36JfrmGRYRVhC7SPJg==
X-Received: by 2002:a17:907:1c89:b0:734:d05c:582e with SMTP id
 nb9-20020a1709071c8900b00734d05c582emr9323840ejc.282.1660543226308; 
 Sun, 14 Aug 2022 23:00:26 -0700 (PDT)
Received: from redhat.com ([2.54.169.49]) by smtp.gmail.com with ESMTPSA id
 dk19-20020a170906f0d300b0072fd1e563e2sm3743539ejb.177.2022.08.14.23.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Aug 2022 23:00:25 -0700 (PDT)
Date: Mon, 15 Aug 2022 02:00:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v14 37/42] virtio_net: set the default max ring size by
 find_vqs()
Message-ID: <20220815015405-mutt-send-email-mst@kernel.org>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
 <20220801063902.129329-38-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220801063902.129329-38-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 01, 2022 at 02:38:57PM +0800, Xuan Zhuo wrote:
> Use virtio_find_vqs_ctx_size() to specify the maximum ring size of tx,
> rx at the same time.
> 
>                          | rx/tx ring size
> -------------------------------------------
> speed == UNKNOWN or < 10G| 1024
> speed < 40G              | 4096
> speed >= 40G             | 8192
> 
> Call virtnet_update_settings() once before calling init_vqs() to update
> speed.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I've been looking at this patchset because of the resent
reported crashes, and I'm having second thoughts about this.

Do we really want to second-guess the device supplied
max ring size? If yes why?

Could you please share some performance data that motivated this
specific set of numbers?

Also why do we intepret UNKNOWN as "very low"?
I'm thinking that should definitely be "don't change anything".

Finally if all this makes sense then shouldn't we react when
speed changes?

Could you try reverting this and showing performance results
before and after please? Thanks!

> ---
>  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8a5810bcb839..40532ecbe7fc 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,6 +3208,29 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
>  		   (unsigned int)GOOD_PACKET_LEN);
>  }
>  
> +static void virtnet_config_sizes(struct virtnet_info *vi, u32 *sizes)
> +{
> +	u32 i, rx_size, tx_size;
> +
> +	if (vi->speed == SPEED_UNKNOWN || vi->speed < SPEED_10000) {
> +		rx_size = 1024;
> +		tx_size = 1024;
> +
> +	} else if (vi->speed < SPEED_40000) {
> +		rx_size = 1024 * 4;
> +		tx_size = 1024 * 4;
> +
> +	} else {
> +		rx_size = 1024 * 8;
> +		tx_size = 1024 * 8;
> +	}
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		sizes[rxq2vq(i)] = rx_size;
> +		sizes[txq2vq(i)] = tx_size;
> +	}
> +}
> +
>  static int virtnet_find_vqs(struct virtnet_info *vi)
>  {
>  	vq_callback_t **callbacks;
> @@ -3215,6 +3238,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  	int ret = -ENOMEM;
>  	int i, total_vqs;
>  	const char **names;
> +	u32 *sizes;
>  	bool *ctx;
>  
>  	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
> @@ -3242,10 +3266,15 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  		ctx = NULL;
>  	}
>  
> +	sizes = kmalloc_array(total_vqs, sizeof(*sizes), GFP_KERNEL);
> +	if (!sizes)
> +		goto err_sizes;
> +
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
>  		callbacks[total_vqs - 1] = NULL;
>  		names[total_vqs - 1] = "control";
> +		sizes[total_vqs - 1] = 64;
>  	}
>  
>  	/* Allocate/initialize parameters for send/receive virtqueues */
> @@ -3260,8 +3289,10 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  			ctx[rxq2vq(i)] = true;
>  	}
>  
> -	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
> -				  names, ctx, NULL);
> +	virtnet_config_sizes(vi, sizes);
> +
> +	ret = virtio_find_vqs_ctx_size(vi->vdev, total_vqs, vqs, callbacks,
> +				       names, sizes, ctx, NULL);
>  	if (ret)
>  		goto err_find;
>  
> @@ -3281,6 +3312,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  
>  err_find:
> +	kfree(sizes);
> +err_sizes:
>  	kfree(ctx);
>  err_ctx:
>  	kfree(names);
> @@ -3630,6 +3663,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->curr_queue_pairs = num_online_cpus();
>  	vi->max_queue_pairs = max_queue_pairs;
>  
> +	virtnet_init_settings(dev);
> +	virtnet_update_settings(vi);
> +
>  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>  	err = init_vqs(vi);
>  	if (err)
> @@ -3642,8 +3678,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	netif_set_real_num_tx_queues(dev, vi->curr_queue_pairs);
>  	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
>  
> -	virtnet_init_settings(dev);
> -
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
>  		vi->failover = net_failover_create(vi->dev);
>  		if (IS_ERR(vi->failover)) {
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
