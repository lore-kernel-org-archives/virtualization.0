Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DC13B58D
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228622; cv=none; b=R/j1WfY+SAuaczYU6BD9FfA7jhDQJorx1YaRugj8gXOfjq5rbZ0Mv2VDBmHmm+bKOuYr2qr9tVbN4QBO4DjT5kJ4YxAXofuGmPjPZ0opPzoaT0RBa6F0kYeABJ9HXVZ4TGTGn5ZZ6xPwzew2ubv+78t3TrwxLeTdsX85hADUKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228622; c=relaxed/simple;
	bh=M4Wcb7VpXYtsowNR1lzdR6lNDnCTDjkIManIV1BdopA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j/b6FXdZ3Miez09o2z6v51CWOHBcpQ2hEnb66ft/fBJ1BRnyN9l8wEIuBWtwbcciQrKoJUlgCVho5A+6BCOr6YQ4XYY4R35xzCJE/CJsguEXQ3f/MObZW/4OnWeUfHJ2yst6EVvDpxThqYbH2xivO9j0cc1m0hr+ooUrQeAHTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+1lO5BR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+1lO5BR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRL+v6NCWhw/RequsUIDzeSCPLfQtqDa+UUOilSFfdM=;
	b=P+1lO5BRPU5I8mtUeLgpD+GASyLY9WfSWLMz6ehyYKkPG0RPDn5zhhzsL4ToP3elBzdnVC
	+eGSTsBxKZ1aef69u8ClsRgMfqoYrDSXjrmAubB8W5zW49WETZKkf7j/kikxGWzMTZPQ+V
	vjrucPiY0lMf8t7pyd06lCiw8QA4mIs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-HO3oa44YMl-S8DY-WjHFGQ-1; Mon, 24 Jun 2024 07:30:18 -0400
X-MC-Unique: HO3oa44YMl-S8DY-WjHFGQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36250205842so2634792f8f.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228617; x=1719833417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRL+v6NCWhw/RequsUIDzeSCPLfQtqDa+UUOilSFfdM=;
        b=KqeF/2wpQsxZODWE4LoVC+D9ryvF65eIZhzQwNwVaMTib1D5avQ7Jmq1tXqp1xSgm7
         lXppIJ5hwm0gyK8YqYEViEomlPGZ4AUPNBy7mgeeZXDfifV288FzbkVz9QsG/Hejv36I
         ldHo5JI7uztPvSiZQ2GoXiRIfDOEdqLI2/v26d9BYdy5/fv0zZ/RdWS7JQuDYIFVkwmV
         yyJX/fyraqf9s1+t9QNxGrc37MJbvRaueclKWi+YgBeADPWpdsc87dIltJv5hFoeUzi4
         n6JW0Z6Yqr9ZMH64Am3kkZewPoie14H5nB1a/yOxgfIALl0c9hDl9QcfnsgR3J0d05//
         aYhA==
X-Forwarded-Encrypted: i=1; AJvYcCVD0w06oeZFw4TMezCz8FZnZeyx2apzJaGjAUmBQFXrBzURontVhYnGtU9YEwP2Nk5wKZ6RmDHJ7raetXNO5KowapKEddR1JeNifoyBog8=
X-Gm-Message-State: AOJu0Yyy2H01p6yAco4HIJ+LBiWWv029RZdK5N4A36Os5OYYp8gV67Jv
	LVEeSBVzNx5nZraRmHXVw2MESiaCRIy2++UWvwSedg7lxtC2acPOQatgHtM6NczcejiRgRn4ieb
	PlS/8bof+tIXV9khOJHETtXzjCXeT00faO/vRBertXGNuV6hW2MHecL9AbqQitUF9
X-Received: by 2002:adf:9d89:0:b0:366:f976:598b with SMTP id ffacd0b85a97d-366f97659d1mr994694f8f.8.1719228617169;
        Mon, 24 Jun 2024 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhWMDHv2yrPbzqSTtV4Q2U5sqeXN1e4wLu15qFHYSwBt/LbXSBPkQLn+FYOqXtzR62lWULWg==
X-Received: by 2002:adf:9d89:0:b0:366:f976:598b with SMTP id ffacd0b85a97d-366f97659d1mr994658f8f.8.1719228616481;
        Mon, 24 Jun 2024 04:30:16 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6bd2sm9737523f8f.66.2024.06.24.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:15 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 2/5] virtio_net: enable irq for the control vq
Message-ID: <20240624072806-mutt-send-email-mst@kernel.org>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
 <20240619161908.82348-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240619161908.82348-3-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 12:19:05AM +0800, Heng Qi wrote:
> If the device does not respond to a request for a long time,
> then control vq polling elevates CPU utilization, a problem that
> exacerbates with more command requests.
> 
> Enabling control vq's irq is advantageous for the guest, and
> this still doesn't support concurrent requests.
> 
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b45f58a902e3..ed10084997d3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -372,6 +372,8 @@ struct virtio_net_ctrl_rss {
>  struct control_buf {
>  	struct virtio_net_ctrl_hdr hdr;
>  	virtio_net_ctrl_ack status;
> +	/* Wait for the device to complete the cvq request. */
> +	struct completion completion;
>  };
>  
>  struct virtnet_info {
> @@ -664,6 +666,13 @@ static bool virtqueue_napi_complete(struct napi_struct *napi,
>  	return false;
>  }
>  
> +static void virtnet_cvq_done(struct virtqueue *cvq)
> +{
> +	struct virtnet_info *vi = cvq->vdev->priv;
> +
> +	complete(&vi->ctrl->completion);
> +}
> +
>  static void skb_xmit_done(struct virtqueue *vq)
>  {
>  	struct virtnet_info *vi = vq->vdev->priv;

> @@ -2724,14 +2733,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
>  	if (unlikely(!virtqueue_kick(vi->cvq)))
>  		goto unlock;
>  
> -	/* Spin for a response, the kick causes an ioport write, trapping
> -	 * into the hypervisor, so the request should be handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> -	       !virtqueue_is_broken(vi->cvq)) {
> -		cond_resched();
> -		cpu_relax();
> -	}
> +	wait_for_completion(&ctrl->completion);
> +	virtqueue_get_buf(vi->cvq, &tmp);
>  
>  unlock:
>  	ok = ctrl->status == VIRTIO_NET_OK;

Hmm no this is not a good idea, code should be robust in case
of spurious interrupts.

Also suprise removal is now broken ...


> @@ -5312,7 +5315,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>  
>  	/* Parameters for control virtqueue, if any */
>  	if (vi->has_cvq) {
> -		callbacks[total_vqs - 1] = NULL;
> +		callbacks[total_vqs - 1] = virtnet_cvq_done;
>  		names[total_vqs - 1] = "control";
>  	}
>  
> @@ -5832,6 +5835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (vi->has_rss || vi->has_rss_hash_report)
>  		virtnet_init_default_rss(vi);
>  
> +	init_completion(&vi->ctrl->completion);
>  	enable_rx_mode_work(vi);
>  
>  	/* serialize netdev register + virtio_device_ready() with ndo_open() */
> -- 
> 2.32.0.3.g01195cf9f

