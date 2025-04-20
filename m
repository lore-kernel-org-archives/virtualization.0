Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C0197A8A
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745134355; cv=none; b=YBje+Pwp6HnolPEXwhios3aL8Mzpnpmhc6LQSAykxy85ko/dL5ZUAqqydZKy12gS/oKGLf4qKmAJy0tjDKPqX7aYtAIajVzpTE7V4bXDV4X3gcXNMJTFrvIC3GkQ+7zdzEHy/M7WXycn9DiLd7+HR1s6kBK1ZOHRxWt0hGwknXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745134355; c=relaxed/simple;
	bh=esKQyW/mP1LV/UEbhdKK0N8rrzF46fMuyMoO4EiNSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qhtDMaWUbNtbI39fcX//Yibstufj7BDl2A3ZHaHTWagI8mKhhfHqoM9WwLHnTuG0a1r5GdD9lDURIssLcKnG8l5PhPIAV0m/wg5DGaVatI6Ul7TQa5PFp2l28WbcpPCJPtRM9Cif8g2oKDMwS9NfDXTGL4sZR+5OT4q3m9jX9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLG5iPIF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLG5iPIF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745134352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rPnHwBvdjCpYN+ILr2KbqTtEgmvkuvdxNwRCB+YgauQ=;
	b=fLG5iPIFMB6O2SB6iLqS8OwCT9UqIVU6qSwGoSgWbMkPBogSS8QSrMOmDAoRmbS9GqOfFJ
	YH89A6eqqj1HaHdt/XdNQVJV/lEV8c01djTi+I1SEsYZkgtb7P0gWnPJnxMjJnvVAdXqfb
	z7rJuKt+t1NIyFGV9x7e/elnbUXrzjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-NJ3SWup_OUavIwWn3wrDHA-1; Sun, 20 Apr 2025 03:32:30 -0400
X-MC-Unique: NJ3SWup_OUavIwWn3wrDHA-1
X-Mimecast-MFC-AGG-ID: NJ3SWup_OUavIwWn3wrDHA_1745134349
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39143311936so1012407f8f.0
        for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 00:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745134349; x=1745739149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPnHwBvdjCpYN+ILr2KbqTtEgmvkuvdxNwRCB+YgauQ=;
        b=UEYOP1xhq4uTWta3wkW9PhiFlVrXq6w88TzPjmGhwHaGVYR0zJFt8vJyp06vQI/PnJ
         2avMarlz6D2s/6fGsu9m0qQWcEWCGTJeS/kMG9nTHvnrxws6NQKNFUTadE+NUdsP0b74
         Nj4zc30Y4V8TwCudXkOZdWDTVE0JDS5GTFoWKP5ZaYiJOLA4p9daEQOJVdMBv0AKO0NL
         iTDQZ1tNxZzBREB2gtT/n1aaYVL4nCwjdfiM9QbLSYs3T6xcIe2s8/k2uchk+avKFy27
         JFvQ6rH79fpL6gA/Y8w/+cQ7FzUgzdpR9i5/Cfu943kGvpnHkj15HQ8ZvmsAeh0FkQSZ
         3XrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGk9V4FH0IUrBAtMOmGs1qrVvTW9JtYIomZQNkgSlsbe/XaZExrOdeDu/ZScRg2FmH3f/FSbq4FxOfTlfy6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxi0p/LwwGBaWPknkBK23bmV1feL4OopiS09+Q61eBlB53KC1+4
	xrYmdFA+EWXZ0Gr4FIP2Wiknaymj0havEAFsEO7QK+wnxe0mJBljxLX2P5hz+W4Qwpy582UCFOg
	QtMxV+rA7kqnj6DuwgkNLlQmO9pctlxhJGbDLE5BT29c7McGcdbFSz+dP29WYtM48
X-Gm-Gg: ASbGncuqVMIFMqjrBrzKPEoBxLbCMWfBqM9KkM8MeDFa6gk8xSqgZ3XXZRiakZT7LgA
	kQ6jpbjsDGOr3fTot08ZSsKpaXHWw5R+EJzKu79FqZUyVI87qcac2uUsBLNGW+5jOFxbYvWAKtM
	0ndKsawwYKJkcaKDFJu3nsdoadCyCrAyRouOVprkU9oN/UBYn/3/nijK3jHsBuLDGXmBlRF4SCX
	2KNpWJA+hIiMrpOZvRUx5Lvmjq39q7bE9Lnt9Nn/p2iDjw/Lq+7IFxgNwy40HKGrWjjJ7f10erx
	XBOZ3A==
X-Received: by 2002:a05:6000:186b:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39efba60fa2mr5482627f8f.30.1745134349135;
        Sun, 20 Apr 2025 00:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrKjCeXR5ka2I9nS9y5bI3Cx9j6H+N6iEOY7I61+u5OZx0tRo6cSozrM/uepXIEFdsuc6J+Q==
X-Received: by 2002:a05:6000:186b:b0:391:13ef:1b1b with SMTP id ffacd0b85a97d-39efba60fa2mr5482610f8f.30.1745134348687;
        Sun, 20 Apr 2025 00:32:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4331a9sm8243556f8f.36.2025.04.20.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 00:32:27 -0700 (PDT)
Date: Sun, 20 Apr 2025 03:32:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
Message-ID: <20250420033135-mutt-send-email-mst@kernel.org>
References: <20250420010518.2842335-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tWBu3z3VWvWzImAwKMC36g_lDKp7RUDRInWnN3lKhto_1745134349
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

sounds like the right approach.

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---


in the future, pls put the changelog here as you progress v1->v2->v3.
Thanks!

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

