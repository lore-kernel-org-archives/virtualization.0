Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E73A5459
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259081; cv=none; b=PBGDgk2hCS73ohcjdpPVZqMCWNVodYH7LT1cotHvd3TfL9sU+hcE52xVG7GADVS1zjWiEqMy6lEV6dU+6XomISqeY/lN3Q4t68LWuKYgJEDh4+3yaOQaVYP3S4JC+yMpmWmlRX4sTXW8GwywwzR7Hv289amb61VsPJkKfXp52gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259081; c=relaxed/simple;
	bh=r9XIrRq0BRe9ek3EhJSgmSSJMb3TghTwa3VFKLtOMHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H06TXxe28GAm518y94cGRK0BW8TvmtiT7MTWdEb5px6rBCgjN48srDfiy5YrBgDTwwdIGqYUgU4zN0DxDznkUk3QVgJIjdRmPxIb3VHVwFjAgjKgZ8e3haJYEfct3MCAJtQ4/d7cRxHXAbttDvYtEnTlVOJhbUqPaaN5wR44Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n20O8Y+p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n20O8Y+p"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso93706b3a.1
        for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785259079; x=1785863879; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WR4BOhpZkqrSIT/iY8eTx3WwtTbSih09bCKXi8nvBxI=;
        b=n20O8Y+p50Y8cHvHCDFRgfaCJ8G31JVS/URDxWTaoNzLuO4SWsufYzSQqn1xPyW6zb
         +VxDw2dq4vCvRLvLAVZWufSSLrX8nS6zz97vpJZunCrj0jX5R9OOdhgcRDJMlmZC+Q+X
         U+DLW93gmWcg083oD5j8JvBgEgkqk7Rd5rbRqkYtZqPX3e7inHrSsfPiWdd6/3vyVJPN
         IeLfF2wOIzzmWZdTY64oVtqxACy6C7cZt7wWYXe1Ac/vo+aVW2V5YUH/F9AoB2LysuQD
         f8ByQfcNYooq2oN11LKNrBsmQAqRE1RhbkTI6lBoSK9CNngee3MzMlw4PFX6xdVA0rBG
         TN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785259079; x=1785863879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WR4BOhpZkqrSIT/iY8eTx3WwtTbSih09bCKXi8nvBxI=;
        b=lVglY+Z5xE9Ac1cSUYfEvFF1ImsltSjdeps8rWeJLQ7ryz0OUA0Nu8T+6+/gpDHEZV
         STh/s+7x1PNKBpJ6wmAZ6HEnjrRyWxmlZCEG8g/1vIVASfB6UDp2AzUmSe4qV1fOugGV
         QiQK+aPMfWkGQ9zHac2jeBXcEdlYCK2Iq1Jq3RfEox7Y3Vfm8IN2A9Uk28Nu57AM7B5s
         krCq1JcoksQZI4+OyPfOt3WSBeexUxJ0Kh5yeVGkcBOgCTnOJvedS+EWQjPptniPEjQ1
         hLshqwv0IXATwtcCXHja0V1Bb5YAfKnhgQ7MARWDQIvIe9UK97Kn+kcWRlJb2OoM/0/m
         mjQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqi7JnTDSPV10iRd2bbgpwn6sYKJwtJ4CiqyuZgiJsUUkVJnyTg//bIx9nIsUJ4a5gUVZF0YFXuJkyvoCsC+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHIcOUQLZIqm6B5bHl/EaRYEAsp/827AJvhpitjWY+UYikFUqk
	P4fXu6wIEdUcO/b+G735t6N7x7wYTdLHywik0aoQSRg40q/H8GYkdCWj
X-Gm-Gg: AR+sD11m/ASoSKdjvNzftDdWu1UvcU5PMEH7Q2E6S/gkjRMEuzJXqPORWBeMcBNunIC
	2+j4bhxQJ9ZfEnwrZIeHVrS+3AH9efFm3ToIrUGmIC9YJi/slkUZrfT7tMfn9NL1P49jiD9HQY6
	k1efTRvknWpZusFH3JbF5VzyLcAmKAkwKeOm2EHTIrnxVEjHug5Danmv8XfksXUo0O6VuMk11kg
	pTEFHe+cD6TKA67ztYPekWYba0FhOxtaj+JO6WHCInJeAxvSc/gtWZaS//183JtNGHc00LrDwyH
	WAqADQ5xxUKpfHRoe4l3v7iTfA+ds/esPHNfHiWkbyOKjwrw8JOiq+7KH0ws2JFkEaSLxvSHrM5
	pkw4WPGGNYvhdqsLFGV4kBPlEYzieIi/AHd24vA9BXRFwQw7I632ExpNypRYSesVG47oWEtgcaZ
	YABmBMA3xf0A7HGfX2jREUcjg=
X-Received: by 2002:a05:6a00:9289:b0:845:d286:1fa2 with SMTP id d2e1a72fcca58-84e932ee09cmr3569287b3a.49.1785259078809;
        Tue, 28 Jul 2026 10:17:58 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03767bbsm229289b3a.47.2026.07.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:17:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:17:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> The RX, TX and event workers read their virtqueue pointers before taking
> the mutex that protects the queue and its run flag. A work item delayed
> across freeze and restore can therefore retain a pointer deleted by
> virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
> and use the freed pointer.
> 
> RX has an additional path: when rx_run is clear, the common exit still
> refills the RX queue. A queued worker can consequently call
> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> 
> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> Read of size 4 by task kworker/2:1
> Workqueue: virtio_vsock virtio_transport_rx_work
> Call Trace:
>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>  process_one_work (kernel/workqueue.c:3314)
>  worker_thread (kernel/workqueue.c:3478)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> ...
> Freed by task 141:
>  kfree (mm/slub.c:6566)
>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>  device_suspend (drivers/base/power/main.c:1968)
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Read each worker's virtqueue under its mutex after confirming that the
> queue is running, and only refill RX while RX is running.
> 
> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 57f2d6ec3ffc..79cf19f58943 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  	struct virtqueue *vq;
>  	bool added = false;
>  
> -	vq = vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
>  
>  	if (!vsock->tx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;
> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, event_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
> -
>  	mutex_lock(&vsock->event_lock);
>  
>  	if (!vsock->event_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
> +
>  	do {
>  		struct virtio_vsock_event *event;
>  		unsigned int len;
> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {
> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	} while (!virtqueue_enable_cb(vq));
>  
>  out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +	if (vsock->rx_run &&
> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  	mutex_unlock(&vsock->rx_lock);
>  }
> -- 
> 2.55.0

Not a strong opinion from me, but since this last hunk is the one that
fixes the bug and the other hunks are moreso hardening, maybe break
these out into two patches?

Besides, that all looks good to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
