Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0C25B093
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035069; cv=none; b=OEk7Pr2P8V6M114ppuHv3cCFOb6po7R3PPPmnpqwkeCFu3gXYOylb9J4ILxSBM62NmbpgW+o+GupwOqpVNOcmui4z59z6uFPgwqVrmtO3Y74W34VAeDCr02hzVOkR/sDB+M4pCnKqdyjkiFSyAlTUcR392vK5EneDJ08nNVn5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035069; c=relaxed/simple;
	bh=nlvh7CSMqUiIujUhp9BH2IdZPZMU6ylLQI28sV+2+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kwJhcjP0hoDHmIA1HNGhLaPE34HwAWyrIoPYrVUSpdvXkT3LuBP70C49UHzFnW5Gmy6ozvXJGGYzww08N0bKc5CshhemN3s8nQVtZ/+kHeiabXnItsRvERm66fu8iyy+A1l46XnVYNzVP2a120GAxrN78RCsx4Kq7CiHmX36pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwKx25gA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwKx25gA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784035067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+SO+5kDYlyBkSJf2vk/RjtSZDkaoll53kor2Z2ySV6U=;
	b=NwKx25gAFszJlKU6Ikii6dm+ddAttXedju+ASm2vrSyiwlXFv+MmirtC4smQcwF4qj+JNh
	3WpgJcBNCg2PLnHYuulEerry6BB4xOxF0431w5IIm9Nijy9ek5iuJ4guvm4KM0u6ZrNO6R
	5R1nieNaJpxm1UBeQttUV6QmAjy+JJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-eD0sj2iqPHG-cAmDwzNvTA-1; Tue, 14 Jul 2026 09:17:46 -0400
X-MC-Unique: eD0sj2iqPHG-cAmDwzNvTA-1
X-Mimecast-MFC-AGG-ID: eD0sj2iqPHG-cAmDwzNvTA_1784035065
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4744b72f90bso2253631f8f.0
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 06:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035065; x=1784639865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SO+5kDYlyBkSJf2vk/RjtSZDkaoll53kor2Z2ySV6U=;
        b=GJnzA/pTaYAclpCaQ/t6tVCEkq+jWhazDHLNrHH4E7weXRX5kR3FeHcvk7hcDcj8n1
         i2p3TIVg/MuJpPgc0VUNfXPXJwzjgXYZ2T2ySu7E/SL4dPoPTL1qxLLySrSr0uT4ry0t
         CrrvvIqF0CzODwL+JGBZEon6oOOuSGSYJUjclbnxD/a13qrhDA+zjWePMpjKRkXIzsEc
         hG6YIER8Ku4x+qORH+CfLCdT70XovZR7ycQ6yo5fw2vAq7LlOAm7Gss1gapH70KEyC2d
         eXPO20CtMyra4i00uPJRI7EwtYbfV/QHl9Qr1yhi5msyBhot5mb+tPi4MigpgnseEucX
         Cz9w==
X-Forwarded-Encrypted: i=1; AHgh+RoxpDSXPMblstvGHuswIA0r9JvwzzNdxMcFBx6aG8jEm7NqMfAn17tTLuEiyjSWMzVAupd8PGl5lUCf2KAPlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyah6N02kbo+og1RRKjXJBA9ZG6DNAQlL1zD0bXZ9GO4RdO0meU
	9wcX7fF1KVZaqVotaZT5c3H0sKNaXCPvOGgady0U8dzxrvFp2Nnv8/AZoaZRydDQu+g0uj5Y7zq
	sl/KrjLpoHbp610xi5/R7nDyMZOvBeERnZKpQMXX2vNqwsSS+s1ueyptW/6s6Q+2bXBlb
X-Gm-Gg: AfdE7clqs8Gh2X5xkBvTDbmayaO/Hm/Ru4hFKb1R41w0oCZviXjrQihuCsRpQze+0Qm
	Qeri+rFr0VdlNZjTZQgBHU+qfUbxylz/h/vgxtrchfoHsLVQ3RxxcDwJFn2m2ji2fem+3xP4pFg
	oQIHdB09QCxTeyvTVWbGTvxNG13oYAOybkTX0+yfzKJ+mfPVe2YJFjyIfUZtpZB9JSVuqSjWJLH
	WMmxS096bd5ZbA5+GakvpoK1EkotnTLufrOd37Ec64DOvL/FVTQNKML+JQ6tcuppy6MEOQXMKUO
	4/aQJD48m8mrmBMZmCzVwm6sXyr1x+pDlqvN701029gZH4/9FeuCY+BfiEeioUM7xjp4zddjbdM
	Q41kelh5StNWO2be6KZtbiWSjoXjrlhuAX2U=
X-Received: by 2002:a5d:5e07:0:b0:47e:81b1:74aa with SMTP id ffacd0b85a97d-47f488bdae4mr2796415f8f.42.1784035064502;
        Tue, 14 Jul 2026 06:17:44 -0700 (PDT)
X-Received: by 2002:a5d:5e07:0:b0:47e:81b1:74aa with SMTP id ffacd0b85a97d-47f488bdae4mr2796364f8f.42.1784035063914;
        Tue, 14 Jul 2026 06:17:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm8851487f8f.3.2026.07.14.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:17:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:17:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, wangzhou1@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH] virtio_net: fix infinite loop in virtnet_poll_cleantx
 when device is broken
Message-ID: <20260714091622-mutt-send-email-mst@kernel.org>
References: <20260713132025.703147-1-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260713132025.703147-1-yangjinqian1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NT19voxJtdia-znE7jAClhrVXirImbor72HtGO1xxyo_1784035065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2026 at 09:20:25PM +0800, Jinqian Yang wrote:
> virtnet_poll_cleantx() contains a do-while loop that cleans up
> transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
> whether more buffers need processing. When the virtio backend stops
> responding during guest reboot, used->idx is never updated, so
> virtqueue_enable_cb_delayed() always returns false and the loop never
> terminates. Then it will block reboot process, and the guest will hang.
> 
> The problem occurs during guest reboot under network traffic:
> 
>   1. kernel_restart() -> device_shutdown() traverses the device list
>   2. virtio_dev_shutdown() calls virtio_break_device() which sets
>      vq->broken = true
>   3. virtio_dev_shutdown() then calls virtio_synchronize_cbs() to wait
>      for in-flight callbacks to complete
>   4. A virtio interrupt fires, softirq is deferred to ksoftirqd which
>      calls net_rx_action() -> virtnet_poll() -> virtnet_poll_cleantx()
>   5. virtnet_poll_cleantx() enters the do-while loop and never exits
>      because the QEMU backend has stopped updating used->idx, despite
>      vq->broken having been set to true in step 2.
> 
> Since the loop runs inside ksoftirqd (a SCHED_OTHER kthread), it is
> visible to the scheduler and does not trigger a hard lockup. However,
> the kthread never leaves the loop, so RCU detects it as a CPU stall
> and reports it periodically. Meanwhile, the reboot process remains
> blocked in device_shutdown() because virtio_dev_shutdown() cannot
> complete its synchronization step, and the guest hangs permanently.
> 
> This can be reproduced on a guest with a virtio-net device: run iperf3
> traffic in the guest, then trigger reboot. The reboot occasionally hangs
> permanently with RCU stall on ksoftirqd.
> 
> Observed on ARM64 KVM guest:
> 
>   CPU#1 RCU stall (ksoftirqd/1), repeated periodically:
>     virtqueue_enable_cb_delayed_split <- virtnet_poll <- __napi_poll <-
>     net_rx_action <- handle_softirqs <- run_ksoftirqd <-
>     smpboot_thread_fn <- kthread
> 
> Fix by adding a virtqueue_is_broken() check to the loop condition, so
> that the loop exits immediately when the device is broken, allowing
> the device shutdown to proceed.
> 
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>

I'd expect lots of drivers have this issue?  Wouldn't it make more sense
to check virtqueue_is_broken in
virtqueue_enable_cb_delayed/virtqueue_enable_cb? This way it works for
all drivers.



> ---
>  drivers/net/virtio_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7d2eeb9b1226..c8d2d420c31d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2970,7 +2970,8 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  		do {
>  			virtqueue_disable_cb(sq->vq);
>  			free_old_xmit(sq, txq, !!budget);
> -		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +		} while (!virtqueue_is_broken(sq->vq) &&
> +			 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
>  			virtnet_tx_wake_queue(vi, sq);
> -- 
> 2.33.0

