Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C411DF965
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571460; cv=none; b=aG35ZFqubVOWEAiOHQAXfEi//FNnt69XdjyU9DnzC4eNMuLXYZ23DLBPsv146QcmOdhZ4nOYIYK9E3iRcMYUV+H9IluT4npCaHyS92NQhxlKLuWvijbJjHgun/PqJiBm4N/u5UCNQBYAsrlgvobpY8c4iZxeXWk9fZ0wjREdr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571460; c=relaxed/simple;
	bh=3QKEUFo5LXygi5n84KS64jmf6l8RWX20LRDFKQGndDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pEM57V2+cO4H1D/gzD/afjQLE8xoxj/YVOfCa+R6trCto2j/slQpdq1i14XFiB4eE3oZ0HuFxTNi9hToDDtYauSFtvygCUGIUhoU7GR8pf3iTEjfSdUEM4/2TlTjKlS1+dgtozOY4PdpCLkaWID+bos/PFzs0alRFjnj8ihRCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8sxJa/G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8sxJa/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766571457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzP3CpgRIzIHd4j7JJHeELNPFQj8HTZPnJadpGgQjTc=;
	b=M8sxJa/GQk2vLSz7jSunXPDhytPdnF/KgOozFy6hUeyOYe+r8DfUel0+cnODG4L+jg0tB6
	Y9G2EiEwXaAGhDi+qJO8JiKVXwq0DlNH+COwAgXiV9+dsWn4R443yH1tjOGTSpP6hb7yHp
	LHjCBeVx3R/b9G8r/DWjObRyuZ4g/08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-Xo6RaopLPxax09K-nkmBBQ-1; Wed, 24 Dec 2025 05:17:35 -0500
X-MC-Unique: Xo6RaopLPxax09K-nkmBBQ-1
X-Mimecast-MFC-AGG-ID: Xo6RaopLPxax09K-nkmBBQ_1766571454
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47910af0c8bso38182245e9.2
        for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 02:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571454; x=1767176254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzP3CpgRIzIHd4j7JJHeELNPFQj8HTZPnJadpGgQjTc=;
        b=Avg51rlG0wMeWvPo75AqI6s2t+l7TPS9lTq35ha347wEK6JqaHTYYVX3su9NtnuhAs
         kKenuvnXx55121agm/cIca4lqve7e/wgrpnmM7TkGGlP9LD2+RLE+be1ttTUHvumi6pO
         asNuXp3GcklGD5Sj5lzJbBTwEaA6P4AVl8LGFEE8EOpGnleVEhWjz7wHvigS9McV8krr
         Lcewwt0krL2TD7+8FCOCHeExHw6ADxnodgS1h5+rr1LappWbJLKjkAFKzvmqKgH7yAX6
         kFwx6vKNCETsPCcnsbtuzud/ntp+OtjOFTJYaWqtd8ccXrHkQRhfebRPbE2E/vS7d/JF
         rdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO3FM9cYR4qif91EKvOiBkW7q7jOJIqz40wt/PITkNCYtkMaIcfiqw8MIg5ZWgp/BPFUVcHlk8yN3RNjVIdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4IXIq5mNgeeX4rNU593LRVTcF0DwiqrbGn4HKYtpCxBo4N6i4
	CX8OSqCtCpJwAD6DT1cqRT9E9bXHV6v94jDiRv0W6Yzx83ZO6ANRyKyxeQHgOztnpcHhEjss3ym
	Y9SZ0+bAIDV1T4w4+Y5b/Ums2cUH/HnxiYy+cYQ0X7oLkSH17SkLnBGZuaUWH1xGvsXL9
X-Gm-Gg: AY/fxX4IA13jLXdr9mSXUkDZKC9rPOdumolCV7LAg4GnBLb55t3je+9UM9MPwm7e97m
	bvnBJ8Gmcx76qiyPaMJ/A5WfTY68o/GFvFONfHkooCzmmsHZ36b5jS+zBhl/MddEpLuzUQcdSno
	4XNgAe24PmRmL5eNJ9zB4aT1SbMPI3d+xDQCu/jPOjzlkVKOqbhv5qZkbWRjPDJvTnjGF6DNrv5
	1X1cUnY0syruy/9qSIu0tghgn2EBI5RKz5Ke43nrOpydMmq7U54DmwuNFFsXMhDzau7hLh+f1mF
	MOXfd3sZM5O2My9RQ9bSe0UHBM03ieR5byyOWJqDc7fQKTh9O+xSVJjviQzzWSY7V44UUTQKYrE
	9
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr150409885e9.5.1766571454143;
        Wed, 24 Dec 2025 02:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSLHXjoue22ycWh04PhviD8xBwMq2igG9VbtveaphLk/VbLO+tvT/RScqlygcnULbaItpauA==
X-Received: by 2002:a05:600c:444b:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-47d1953b77fmr150409605e9.5.1766571453707;
        Wed, 24 Dec 2025 02:17:33 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm343055335e9.13.2025.12.24.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:17:33 -0800 (PST)
Date: Wed, 24 Dec 2025 05:17:30 -0500
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
Subject: Re: [PATCH net 3/3] virtio-net: schedule the pending refill work
 after being enabled
Message-ID: <20251224051636-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-4-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251223152533.24364-4-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GAgSyUuS38dVjGLtElGUvWHpPGUaLO6Xqu-0tD3YVls_1766571454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 23, 2025 at 10:25:33PM +0700, Bui Quang Minh wrote:
> As we need to move the enable_delayed_refill after napi_enable, it's
> possible that a refill work needs to be scheduled in virtnet_receive but
> it cannot. This can make the receive side stuck because if we don't have
> any receive buffers, there will be nothing trigger the refill logic. So
> in case it happens, in virtnet_receive, set the rx queue's
> refill_pending, then when the refill work is enabled again, a refill
> work will be scheduled.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Sounds like this fixes a bug previous patch introduces?
The thing to do is to reorder these two patches then.

> ---
>  drivers/net/virtio_net.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8016d2b378cf..ddc62dab2f9a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -383,6 +383,9 @@ struct receive_queue {
>  	/* Is delayed refill enabled? */
>  	bool refill_enabled;
>  
> +	/* A refill work needs to be scheduled when delayed refill is enabled */
> +	bool refill_pending;
> +
>  	/* The lock to synchronize the access to refill_enabled */
>  	spinlock_t refill_lock;
>  
> @@ -720,10 +723,13 @@ static void virtnet_rq_free_buf(struct virtnet_info *vi,
>  		put_page(virt_to_head_page(buf));
>  }
>  
> -static void enable_delayed_refill(struct receive_queue *rq)
> +static void enable_delayed_refill(struct receive_queue *rq,
> +				  bool schedule_refill)
>  {
>  	spin_lock_bh(&rq->refill_lock);
>  	rq->refill_enabled = true;
> +	if (rq->refill_pending || schedule_refill)
> +		schedule_delayed_work(&rq->refill, 0);
>  	spin_unlock_bh(&rq->refill_lock);
>  }
>  
> @@ -3032,6 +3038,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  			spin_lock(&rq->refill_lock);
>  			if (rq->refill_enabled)
>  				schedule_delayed_work(&rq->refill, 0);
> +			else
> +				rq->refill_pending = true;
>  			spin_unlock(&rq->refill_lock);
>  		}
>  	}
> @@ -3228,11 +3236,8 @@ static int virtnet_open(struct net_device *dev)
>  		if (err < 0)
>  			goto err_enable_qp;
>  
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> -			if (schedule_refill)
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> -		}
> +		if (i < vi->curr_queue_pairs)
> +			enable_delayed_refill(&vi->rq[i], schedule_refill);
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3480,9 +3485,7 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> -	enable_delayed_refill(rq);
> -	if (schedule_refill)
> -		schedule_delayed_work(&rq->refill, 0);
> +	enable_delayed_refill(rq, schedule_refill);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> -- 
> 2.43.0

