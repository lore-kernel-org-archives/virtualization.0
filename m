Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C33524F
	for <virtualization@lists.linux.dev>; Sun, 18 May 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747604313; cv=none; b=drWwVJM6lgEWzwkvLPmb5c0/ZTMc5UHFdXkaPrg8jKCB45KgUUsLQvUhpErqs97g//PR22TtRIcJJE1dVtFixtQmUf94JY8bxXK6Z3saqNHb/bBK22GBDhK6z2F85bV7j6huWgj/G70SS7diziiZTsuljYYE3KK+o0CZmdBs45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747604313; c=relaxed/simple;
	bh=IY5YxUgfeivoNaGKuPIC9nYUq6Yn5iTNzaXtAmgFxWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pJOcmetvTwsJyx8V60UaoxqsZE/tBTgLZjx+BKMFoYbI/gZWuRsMEQWddKiQMg/klkpLvZMEE4Tqgm/dMVosycs77bRfiAX28DfuTFHNuHVAM0XIufXvOQpjKhFO/Gjk+L4fD/xJgXr+hDrIXIl+uJwEUox18kXeER9tX72QFIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZr1rOfb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZr1rOfb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747604310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DxfFVVppWL2QDoeVADckrWoeG/v7XssiZgeHgdT/vk=;
	b=UZr1rOfboB5AypuAyhh5MGYPeKBw3dKb1JLCbgJ1lA4sqMyrK72mKUngXF3K3to380hlfl
	jEkE54ecCs3MvSVBMdbk3m8BSdbNln/8nXISQ+zaVT4W9uF825e3BGy44ePaLyq0hyJZl5
	Qcgq8EQszsXSpHlzRcPN14cgGfp6PJ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-fluB8m90NoOtUtGH1iRNOw-1; Sun, 18 May 2025 17:38:28 -0400
X-MC-Unique: fluB8m90NoOtUtGH1iRNOw-1
X-Mimecast-MFC-AGG-ID: fluB8m90NoOtUtGH1iRNOw_1747604308
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so25096885e9.1
        for <virtualization@lists.linux.dev>; Sun, 18 May 2025 14:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747604307; x=1748209107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DxfFVVppWL2QDoeVADckrWoeG/v7XssiZgeHgdT/vk=;
        b=P9PtlbYXcsAfpX/fCfhtPq0zzih2G5XNHf6I7yd2nekToArKrY+FhkalZKFIfZbTH9
         H27Evdm3O5yO3N4lqrOTbHRUeRZ+n57QXFJtJQACT1FsCuNOckQnExqLDFVqch+W6TBU
         nMqIodB+Io+/utzH5hD4kClUpknOwfH165P9kbiofLonybZ+H723K4FZnIT8cpdVBz6e
         dNitHYFd0/oG1QMKoS6MfUkmRH2UoQiLOrJk5jJBk7H3J+wJcET1hqahMKXD7OQYfAU+
         Xb8RPQnYXC5Vaz0DDfl8uEriks8BVoppyrTcxfK0t43LgBQGTkcJi6LAVxHSPx68l7Nd
         C5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVdvX3mwdDxdhDGMa52ZSJ2ewmJRxHPnV+vfpG/72rTcUD5Lgu0WzvcfM55fXBH386Be7E46gyDLPs1jLgweA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy32nWlYAWZ5gYFnKayOueoSZAMWMRxXj7WvaeeISoQTCcvhV+x
	IsQMVry+YYTRzNszxCGAFeQu+nSBzHEgn2Aa5GjI+yiW5GTqpKh/zAcXtcaRNNOqxBjyO8qUbSl
	3uBdLYLbNMz1kv04ekxyX4HIfAG5Ni0u/hRrumY71biq2dksHN5mZTqk6d8VIMZlO5q0a
X-Gm-Gg: ASbGnctRvcMkmxjr2EDOT4hMtjBHMWQTgo4fnEG25kp4iJQZZWmy6FW5vtFM3/WOf+J
	JhX1EeVNewms/5fJqgDS5sOPArTjFNZHbXazkXEKRMyeATrhf3ZUX0sEdN9ZeavSio5CZExkhY9
	WIeh0MdWf3F1ltSlQ1Tq5rpWpMSEy0JUhE2aZTTONa6KrGPetSiAqiXFyncQNk745uomX4lZ8Ob
	QlwFCBVU3Fi9nCQKvgXVbG3txoRYKJFvw5xLReHFbNt39hSGfozkuTdjtWy1ou8nP7ieGIUJwPH
	VFakBA==
X-Received: by 2002:a05:6000:2a4:b0:3a0:b5ec:f05f with SMTP id ffacd0b85a97d-3a35c84bd9emr9695880f8f.39.1747604307628;
        Sun, 18 May 2025 14:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPvcQqiUdzhpUsTAuhZDZDZTf1fjEgpPyr6jPbRPZ5J04iBfqTi3ZNActvJ+NaYfNQu9hbkw==
X-Received: by 2002:a05:6000:2a4:b0:3a0:b5ec:f05f with SMTP id ffacd0b85a97d-3a35c84bd9emr9695869f8f.39.1747604307288;
        Sun, 18 May 2025 14:38:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85bb20sm131025615e9.0.2025.05.18.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 14:38:26 -0700 (PDT)
Date: Sun, 18 May 2025 17:38:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250518173756-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OHaUClxCpqk32-nftPGiPDmahwFBnw1G5k45Ce7qYA8_1747604308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 19, 2025 at 06:05:18PM -0700, Jon Kohler wrote:
> In handle_tx_copy, TX batching processes packets below ~PAGE_SIZE and
> batches up to 64 messages before calling sock->sendmsg.
> 
> Currently, when there are no more messages on the ring to dequeue,
> handle_tx_copy re-enables kicks on the ring *before* firing off the
> batch sendmsg. However, sock->sendmsg incurs a non-zero delay,
> especially if it needs to wake up a thread (e.g., another vhost worker).
> 
> If the guest submits additional messages immediately after the last ring
> check and disablement, it triggers an EPT_MISCONFIG vmexit to attempt to
> kick the vhost worker. This may happen while the worker is still
> processing the sendmsg, leading to wasteful exit(s).
> 
> This is particularly problematic for single-threaded guest submission
> threads, as they must exit, wait for the exit to be processed
> (potentially involving a TTWU), and then resume.
> 
> In scenarios like a constant stream of UDP messages, this results in a
> sawtooth pattern where the submitter frequently vmexits, and the
> vhost-net worker alternates between sleeping and waking.
> 
> A common solution is to configure vhost-net busy polling via userspace
> (e.g., qemu poll-us). However, treating the sendmsg as the "busy"
> period by keeping kicks disabled during the final sendmsg and
> performing one additional ring check afterward provides a significant
> performance improvement without any excess busy poll cycles.
> 
> If messages are found in the ring after the final sendmsg, requeue the
> TX handler. This ensures fairness for the RX handler and allows
> vhost_run_work_list to cond_resched() as needed.
> 
> Test Case
>     TX VM: taskset -c 2 iperf3  -c rx-ip-here -t 60 -p 5200 -b 0 -u -i 5
>     RX VM: taskset -c 2 iperf3 -s -p 5200 -D
>     6.12.0, each worker backed by tun interface with IFF_NAPI setup.
>     Note: TCP side is largely unchanged as that was copy bound
> 
> 6.12.0 unpatched
>     EPT_MISCONFIG/second: 5411
>     Datagrams/second: ~382k
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  15.5 GBytes  4.43 Gbits/sec  0/11481630 (0%)  sender
> 
> 6.12.0 patched
>     EPT_MISCONFIG/second: 58 (~93x reduction)
>     Datagrams/second: ~650k  (~1.7x increase)
>     Interval         Transfer     Bitrate         Lost/Total Datagrams
>     0.00-30.00  sec  26.4 GBytes  7.55 Gbits/sec  0/19554720 (0%)  sender
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>


Jon what are we doing with this patch? you still looking into
some feedback?

> ---
>  drivers/vhost/net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..9b04025eea66 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> +			/* If interrupted while doing busy polling, requeue
> +			 * the handler to be fair handle_rx as well as other
> +			 * tasks waiting on cpu
> +			 */
>  			if (unlikely(busyloop_intr)) {
>  				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
>  			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}
>  
> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	/* All of our work has been completed; however, before leaving the
> +	 * TX handler, do one last check for work, and requeue handler if
> +	 * necessary. If there is no work, queue will be reenabled.
> +	 */
> +	vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.43.0

