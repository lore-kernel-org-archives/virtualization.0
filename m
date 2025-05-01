Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDA1AF4E9
	for <virtualization@lists.linux.dev>; Thu,  1 May 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107086; cv=none; b=gKQOvW2v8AZ8IOrdSMDBzbufW9mlgutXF29CC5R0TXoPNNjpH/Ixe8Ug9W+42MCWbCn7N8hJxyye+lroSJLpzArAvPBFzweV/7uZfmfqzzhonP20V2Ed02mlPhzMfYI8ZNqD0te9No77Ui43cYn7s6TS+YbppaD2O628bDi70Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107086; c=relaxed/simple;
	bh=TW6LWoRqtypIzn7B58qijKmL0w5gLK2466Q2vxKzNkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=toDTXLvmUJ/XRqfUXF0z7DAOmczRENTrdgmkwU1NZvN4S4BOmf0f0v7BkT4nvtYSpmf3e2SvXwotYP/cAuu1iIOKxvvlP83jF4DjmqVvfaeyYqZ2YwgL47rntLArQsmTh79bFWdE0MJiaOCAyBhXtjBD0xrdLVKBmVmLdpgxAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRzxo8GC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRzxo8GC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746107084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6UI0tYMue0gvJhLpVqoCbZ1TmzhnaUoOZcJGxHDR+D8=;
	b=jRzxo8GCUniyTfS9pciDsdBT8Wv8O8gMilVBIjcVd5P/kB+9OHmHrukDURo4BTJ4rEvhu+
	HsLLnon6dutsywzmdqxW+y6H9AfZ3nun0w0EljTvf9Px+l6pQZKOdT5kJrJ5eNCp3yYwDD
	2XGp1vvq2ZTWru4MAd1asE9ScXSFz4A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-ywEupwbfPIuKoTtEqd2O1g-1; Thu, 01 May 2025 09:44:42 -0400
X-MC-Unique: ywEupwbfPIuKoTtEqd2O1g-1
X-Mimecast-MFC-AGG-ID: ywEupwbfPIuKoTtEqd2O1g_1746107082
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912fe32a30so291993f8f.1
        for <virtualization@lists.linux.dev>; Thu, 01 May 2025 06:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746107081; x=1746711881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UI0tYMue0gvJhLpVqoCbZ1TmzhnaUoOZcJGxHDR+D8=;
        b=HEIWRhoVfRTaW865CFvhBrBG0gASnsKHXpbVb5s/8qs/iCm55OvRHfV7vH9bOI3pfb
         7r2YQDxT89Yg7tpohqPOoAzK7z0M+EGPB0+/kpqcviNwADECBiaJhTPIHZybTLkxkBjx
         GXNJ+4fybkZZ4PtuDIqHlqL2b2uAonjyuAwzycUmjsb3l2n7sa7/EfGqzKpouccMT7FC
         nolvKFuP1W/zDTOkUK6WWt7nEVY6lfPgEDpTUVxm0ILLY0ecGob4lYBheUU2chtbSIQW
         wVbVJ1b7mpuemr96uDnQb3vBKZj2rmXIiF7ZKHKvif9uokeWAhjIksHeZa+mH75bd5ZQ
         d8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+d1erScofkQPHVRh5vGsRA5hgusl4jPKIbX2ffeQMGOmiTMDwYKhfaaCjM0isxfsHzBvHD5hhZjXaDuaEkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7VNsqiYT8/EzKlhYepT96Tzm65wcgQ3zx5oZzLZwjSAXv8pvo
	BRvWICVnoSy8uzVbItS3XfH0FVoAY2S5N/Xiz2ptU2tnj/RvCgBGK1K5qIuwwjUQUszDbTfMuTZ
	YgnE3lp/MF27Pnl7fuUqJDeI1XrckHBtVAhAbojGAe9L81XgJW4S2YoFjoRsLNOru
X-Gm-Gg: ASbGncv9b57wop1Z3zRBClVtdm2rW0y2WbGdgKt/NysvfUoNxuJU0IJA44cST9T1BVa
	bLyBduTaULNbGI4XqUgZ+Qtbtl6eKeuriX+aoKrz2VbXKpzs1jh77xIeBasS5gC02aaiRhJpdIA
	Mgzpw5OHNECakuzj6Auv94QUC/9kqdMVLociuDSLqHTFNW7Hb0DqoqaANpQ6D92vcFAPfyCBGt9
	mjFTZUoTsMW0LKD0846xeFpjrgCZsQNatF2+NHbnGZwNf+JaqyHbWJKrQxbrM/XagGkOWDMn6l7
	bOLTBw==
X-Received: by 2002:a05:6000:1acd:b0:3a0:6ac1:93a1 with SMTP id ffacd0b85a97d-3a09404452amr1721873f8f.7.1746107081635;
        Thu, 01 May 2025 06:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD96yZkZMPIxtx9G7hGbxzu9GrBoqR4jN2AHFouxYn7cwL/a8mhV9pFuiwTxsci9UDPZbEJA==
X-Received: by 2002:a05:6000:1acd:b0:3a0:6ac1:93a1 with SMTP id ffacd0b85a97d-3a09404452amr1721860f8f.7.1746107081298;
        Thu, 01 May 2025 06:44:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a3e04asm917945f8f.18.2025.05.01.06.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 06:44:40 -0700 (PDT)
Date: Thu, 1 May 2025 09:44:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250501094427-mutt-send-email-mst@kernel.org>
References: <20250501020428.1889162-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250501020428.1889162-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OLRep0iPRnehZjmtDvTYXcai1B5pfkqvXGVm3hHO_RI_1746107082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 30, 2025 at 07:04:28PM -0700, Jon Kohler wrote:
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

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2->v3: Address MST's comments regarding busyloop_intr
> 	https://patchwork.kernel.org/project/netdevbpf/patch/20250420010518.2842335-1-jon@nutanix.com/
> v1->v2: Move from net to net-next (no changes)
> 	https://patchwork.kernel.org/project/netdevbpf/patch/20250401043230.790419-1-jon@nutanix.com/
> ---
>  drivers/vhost/net.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..7cbfc7d718b3 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -755,10 +755,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> +	bool busyloop_intr;
>  
>  	do {
> -		bool busyloop_intr = false;
> -
> +		busyloop_intr = false;
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -769,13 +769,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			if (unlikely(busyloop_intr)) {
> -				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
> -			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}
>  
> @@ -825,7 +822,22 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	if (unlikely(busyloop_intr))
> +		/* If interrupted while doing busy polling, requeue the
> +		 * handler to be fair handle_rx as well as other tasks
> +		 * waiting on cpu.
> +		 */
> +		vhost_poll_queue(&vq->poll);
> +	else
> +		/* All of our work has been completed; however, before
> +		 * leaving the TX handler, do one last check for work,
> +		 * and requeue handler if necessary. If there is no work,
> +		 * queue will be reenabled.
> +		 */
> +		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.43.0

