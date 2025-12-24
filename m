Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6A1CDFCA
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540744; cv=none; b=Yhj9BQIak066gDXcdtCtkQT/Ietd9tTLtQXgNpWGSN2xr6dkuQuaZ1riXh5DmYQpoQKakfmdDiYKdz2n7OEtpVy7SRRbZ4Us3XnJwXAGIDYtzTiXf5IBrmNGM/eV747A0CE9IVwQ3QLZuDFB2gaNirsH6AxYl620wnX99b+Oku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540744; c=relaxed/simple;
	bh=qLZW3NS0wU1PkWXMkdS8e92GhST35BthsoRFkj6DtlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HiG1vJS3b4nvSCGyLL171CKoupkLAmRmrGsYk0EFR/5MbG4Kem5PXC/15rvdav8rb2Rh/eaW/ffejC6SA73mleYlAqWOGLBNYhxDmuigsWbvymfbNntELcNzqOuFjyA3FRCA+r5EXrQ9eyGY6Vx0risXdUqdM8S1BX3uGRoMmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDC7rEM6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDC7rEM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
	b=KDC7rEM64LCvp3prPeorvQNCoDtfulKTJ+csTX6SHNESrCjv3c8Mo9PYO3sonEc9+NAeIF
	O8Zq5xX8ydGUMwLylw6WyUlUwhvk16gVHJ8F1x2JtBEo/kmxyWsAwcgINhgnjomqRGV5tb
	uaZZ9I0n+2nWTO+IgNOMsdUu/Ovs1+E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-YZeSHTS5OG-MjOyPx7dQ7w-1; Tue, 23 Dec 2025 20:45:38 -0500
X-MC-Unique: YZeSHTS5OG-MjOyPx7dQ7w-1
X-Mimecast-MFC-AGG-ID: YZeSHTS5OG-MjOyPx7dQ7w_1766540737
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso53889415e9.1
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 17:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540737; x=1767145537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
        b=HhGSLtfcz+heM/VhaUWGUVEgFsnzjnh3ipd6BPaC4Sa09VxGZ9K2UKg8/hiKvqvjdn
         SuYHIlY3JMXemzx2bVAibFUjTZqhWOzoX65Ss2LO+EkrrmJNmJm90DP35wEt8Qf4sHEL
         Pfd2A42EbwF2xx0q34eK4UVEw3Mc+9/9g76LtFSu6VoggYFQewgfKT8aKrxoH549mh8U
         5QScGEsdyz+6+MW4YOrBaPOeGT8hkTM4jHpgnZ6/tXsf0yVZtEgTYNjdbV57X18ehmwA
         U2IHGHlt5KjX0uARfX2nZttmYwJeIbK5BUwYfxT+6en/XNm/1O04VP6WhKfJ0Ly1vM4A
         dRIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhpVyLAGB5gjzzW7Pu1zc1c/IO5DDPMj4C4e+VNJgL6wG9eTik8ffCcmaTNX1oNDd96I7IMXBVDIpqx7UlTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS/T9xJvjdgBOj4UV2qwQEMhxbZ8RCLTldSTTnKGwI+GyrqwpF
	cfnbWf0BHalF36ldSiTbdkXWvzo94Ob6JW/hv82Sai4uM0fU6Dg3hAh6MwF68jDLs/b7farF/Nr
	gLVRjjMT79RP1rFMkRhmGnJIu08PfoKH71tYyTu9JGAx8/uk8ahFicU8Pml/EdRmWPsFg
X-Gm-Gg: AY/fxX7P0Q2UJTw8YvO4W26dFg6nGfzZj+rmIqyd26JBn9dkJID9UPOOgqr6W5w9DBA
	NKxrD5JIte6G0aCgG+ZQNhp2aKCBhUMwXR0aE8VXBPWQWZ17NG8+djOyYNsFJGQ2G2tkCrtV47s
	mHvn8G0KSbaNObGz9nUisf+M6nSzG/wxrMJtAtAzYSn8UAqnWvK8oTrF/sa2cUnHv2DoDZj6PeJ
	zyaA6MA2OChb6DbTwPS2XCkDneP5BSwvj2pCVpx92lcYFr0g16h7kvdSURqFMWR5Je+PF8cYhwc
	t0/78e09brmsypriniujQatyBIKc0KbAq9cJwMOmEdGHGYL3mHYmU85THZDQnnBWtnKeCkLEkW0
	X
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18915027f8f.18.1766540734573;
        Tue, 23 Dec 2025 17:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrk944sB9ALtgrKmusKW3zRCVN5YKqSNp/nlu8sC1ya5zS0cqE0ZbPcPVKQitwZWGzuZSn8w==
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18914986f8f.18.1766540733985;
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm31426547f8f.34.2025.12.23.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Date: Tue, 23 Dec 2025 20:45:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
Message-ID: <20251223203908-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223152533.24364-3-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BlmL0n_aqXQoOhzN_LIA8_U8mu9oEE8ijuyQqO2aDgE_1766540737
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 63126e490bda..8016d2b378cf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>  	int i, err;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		bool schedule_refill = false;



> +
> +		/* - We must call try_fill_recv before enabling napi of the same
> +		 * receive queue so that it doesn't race with the call in
> +		 * virtnet_receive.
> +		 * - We must enable and schedule delayed refill work only when
> +		 * we have enabled all the receive queue's napi. Otherwise, in
> +		 * refill_work, we have a deadlock when calling napi_disable on
> +		 * an already disabled napi.
> +		 */


I would do:

	bool refill = i < vi->curr_queue_pairs;

in fact this is almost the same as resume with
one small difference. pass a flag so we do not duplicate code?

>  		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> +				schedule_refill = true;
>  		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
>  			goto err_enable_qp;
> +
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
> +			if (schedule_refill)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);


hmm. should not schedule be under the lock?

> +		}
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	bool running = netif_running(vi->dev);
>  	bool schedule_refill = false;
>  
> +	/* See the comment in virtnet_open for the ordering rule
> +	 * of try_fill_recv, receive queue napi_enable and delayed
> +	 * refill enable/schedule.
> +	 */

so maybe common code?

>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);

hmm. should not schedule be under the lock?

>  }
> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> +		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		} else {
> +		else
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> -		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }

so I would add bool to virtnet_rx_resume and call it everywhere,
removing __virtnet_rx_resume. can be a patch on top.

>  
> -- 
> 2.43.0

